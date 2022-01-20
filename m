Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D273D494C30
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiATKw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:52:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56110 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiATKwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:52:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F26181F3A9;
        Thu, 20 Jan 2022 10:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642675969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fGHgbMxwXjsCrtDbrRZYWVOFmooUHx3UZa613EEbclc=;
        b=pT6ar/mKTm1xikvzwGTan35RELfXWoOE3Jjew8G6GjW+qsX3s/54U8K06vtyXZITJIeMo8
        QzVbvbbiLd6uqIey9iKggxM03W/uxvyC0hKB412HzQ6SwiUai/wKa9+wxDeBavQIUr/mja
        lccpSgmD+i70g8kggdLpE2u1KOyItNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642675969;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fGHgbMxwXjsCrtDbrRZYWVOFmooUHx3UZa613EEbclc=;
        b=OK7qhQLB0P8UFK/4/+n5IasPzg0k5h++pMPckp/Q67VMH3vIRbjWvxS2DkAA57+ELto00D
        Ah6OyT2k/Uk3afCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 13D27A3B81;
        Thu, 20 Jan 2022 10:52:44 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id DBEAB5192BF4; Thu, 20 Jan 2022 11:52:49 +0100 (CET)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 0/2] fix crash by reading /proc/diskstats
Date:   Thu, 20 Jan 2022 11:52:46 +0100
Message-Id: <20220120105248.117025-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During failover nvme-tcp tests in a HA setup a crash orccured. iostat
was running in the background while the test was executed.

I am not sure if the fix is correct. I am unsure if using
blk_queue_enter() is the right thing. But when starring at the code
snipped I saw in older version blk_queue_enter() was used but got
evenutally replaced by the rcu_read_lock() as far I understand at the
moment... So any tip here would be highly appreciated.

Daniel

Daniel Wagner (2):
  block: remove commented out code from diskstats_show
  block: hold queue lock while iterating in diskstats_show

 block/genhd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

-- 
2.29.2

