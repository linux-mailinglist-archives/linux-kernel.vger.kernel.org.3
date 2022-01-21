Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50360495A1B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378784AbiAUGov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:44:51 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:33381 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378772AbiAUGot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642747489; x=1674283489;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6WtxJ6G8QH17m9vpF9tZ9iNboVlbxxw9g9H61lLIeeY=;
  b=fQdnDBuHdl7C0mf0dVcFDeQUDDWY1usMcZ6ZZB+thOrtY1W/3xXRPoa/
   dqjeEDkUnEACs/c85adMNuP1x4/DhrrzQVtrvBKH+G78HWgqSDjCrwbvw
   FgVQSMoajsjaVq6zlHOECf8drKKFJ0fG9rvmEjAoGNDcqyAypyctq1xW3
   Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 20 Jan 2022 22:44:48 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Jan 2022 22:44:47 -0800
X-QCInternal: smtphost
Received: from unknown (HELO youghand-linux.qualcomm.com) ([10.206.66.115])
  by ironmsg01-blr.qualcomm.com with ESMTP; 21 Jan 2022 12:14:30 +0530
Received: by youghand-linux.qualcomm.com (Postfix, from userid 2370257)
        id 6A162225AE; Fri, 21 Jan 2022 12:14:29 +0530 (IST)
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pillair@quicinc.com, dianders@chromium.org,
        kuabhs@chromium.org, briannorris@chromium.org,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [RFC 0/2] ath10k:set tx credit to one and delay the unmaping 
Date:   Fri, 21 Jan 2022 12:14:25 +0530
Message-Id: <20220121064427.32059-1-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset=n
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently for WCN3990, the host driver can send two wmi commands at once, 
now it is limiting to one because if HOST wants to initiate 2 DMA transfers,
it is possible when copy complete interrupt for first DMA reaches HOST,  
CE has already updated SRRI for both DMA transfers and is in the middle 
of 2nd DMA. HOST uses SRRI to interpret how many DMA’s have been completed 
and tries to unmap/free both the DMA entries, but CE is still in the middle
of 2nd DMA which can cause SMMU issues or corruption.

We are seeing a corner case smmu fault issue where copy engine is still accessing
the memory though host unmaps it hence as work around we are delaying the 
unmapping the memory and tx credit to one.

Youghandhar Chintala (2):
  ath10k: Set tx credit to one for wcn3990 snoc based devices
  ath10k: Delay the unmapping of the buffer

 drivers/net/wireless/ath/ath10k/core.c | 30 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/htc.c  | 18 +++++++++++++---
 drivers/net/wireless/ath/ath10k/htc.h  |  1 +
 drivers/net/wireless/ath/ath10k/hw.h   |  6 ++++++
 4 files changed, 52 insertions(+), 3 deletions(-)

-- 
2.29.0

