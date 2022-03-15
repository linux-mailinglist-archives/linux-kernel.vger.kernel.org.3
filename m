Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180A44D9631
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345898AbiCOIbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343504AbiCOIbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:31:22 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28BA4C417;
        Tue, 15 Mar 2022 01:30:08 -0700 (PDT)
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 15 Mar 2022 01:30:09 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Mar 2022 01:30:07 -0700
X-QCInternal: smtphost
Received: from unknown (HELO youghand-linux.qualcomm.com) ([10.206.66.115])
  by ironmsg01-blr.qualcomm.com with ESMTP; 15 Mar 2022 13:59:54 +0530
Received: by youghand-linux.qualcomm.com (Postfix, from userid 2370257)
        id D9466227E3; Tue, 15 Mar 2022 13:59:52 +0530 (IST)
From:   Youghandhar Chintala <youghand@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        pillair@codeaurora.org, dianders@chromium.org, kuabhs@chromium.org,
        briannorris@chromium.org, mpubbise@codeaurora.org,
        Youghandhar Chintala <youghand@codeaurora.org>
Subject: [PATCH v6 0/2] mac80211: Trigger disconnect for STA during target hardware restart
Date:   Tue, 15 Mar 2022 13:59:42 +0530
Message-Id: <20220315082944.12406-1-youghand@codeaurora.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in case of target hardware restart ,we just reconfig and
re-enable the security keys and enable the network queues to start
data traffic back from where it was interrupted.

Many ath10k wifi chipsets have sequence numbers for the data
packets assigned by firmware and the mac sequence number will
restart from zero after target hardware restart leading to mismatch
in the sequence number expected by the remote peer vs the sequence
number of the frame sent by the target firmware.

This mismatch in sequence number will cause out-of-order packets
on the remote peer and all the frames sent by the device are dropped
until we reach the sequence number which was sent before we restarted
the target hardware

In order to fix this, we trigger a disconnect in case of hardware
restart. After this there will be a fresh connection and thereby
avoiding the dropping of frames by remote peer.

The right fix would be to pull the entire data path into the host
which is not feasible or would need lots of complex/inefficient
datapath changes.

---
Changes from v5:
- Fixed kernel test robot error

Youghandhar Chintala (2):
  mac80211: Add support to trigger sta disconnect on  hardware restart
  ath10k: Trigger sta disconnect on hardware restart

 drivers/net/wireless/ath/ath10k/core.c | 25 +++++++++++++++++++
 drivers/net/wireless/ath/ath10k/hw.h   |  2 ++
 include/net/mac80211.h                 | 10 ++++++++
 net/mac80211/ieee80211_i.h             |  3 +++
 net/mac80211/mlme.c                    | 14 ++++++++++-
 net/mac80211/util.c                    | 33 +++++++++++++++++++++++---
 6 files changed, 83 insertions(+), 4 deletions(-)

-- 
2.29.0

