Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301AD4FB7E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiDKJlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbiDKJkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:40:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C49403F4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:38:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so17902179pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Mgp6pVkSMNLUNo4DPsjqmPs+yoIZMbh8PrScCQtPiM=;
        b=judohM/9aPQkaHYw1OyW/B0E5FdtFLosJNkmK0hYldEG0y04UchNLjdYEgRfG8e5UG
         Qu4kWs2fUS7aIquBJXpVeBD2YhVI7XQIDJy6KRTxek2URMvb9JFUl4KcVNnoEhmPlXSJ
         WLWEFZwiqGvhaHcw50HsI7tasDEQkPVutFSBMMWOcii47maRd1wcP03X2QjPXg3r3aw2
         AZ+paeJtnDxsLr18B8fyZ97WAnVNGS8y4NWz0ag/wPLnvz+gRsR2eriRojGu35Ch/C3f
         M5SsjGISWBgJbhfYU0rmx59ut3Y+o8W2cbsa7aZFpTBOtrryl4xe1b764hPxSIMAl8v5
         MTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Mgp6pVkSMNLUNo4DPsjqmPs+yoIZMbh8PrScCQtPiM=;
        b=Y4RFVp5fV9hftQFgIGDnx573bgn8t1pI+0zeRtrgoZ3mQsfP/meh92KLsEnVio3YGm
         9OEg6WZ8VLXiabWintcmev53TNl/uZlowovP/7Dk6GVC1LclFwvDbizKX6t74YiBcEEF
         NBFmV8bJs3mp3SRiphWmwdWE7hqFHixnSndOfD0IiqVIvUqQxzn/E0CmJbV2ZHleA7OH
         NdaXZvDTLNrSlv64oF03n1nuFSU2JYvSfYjMA7oxEq8hPGcIUf8YO0excqUMmqTUiekN
         VpMnekUythNdOvVLhcoqwcIgNTZ/0oUPDh4C4rK9k52uZVKD2TCbRFHHpUPaFh/oKRdJ
         a2Iw==
X-Gm-Message-State: AOAM533wV+weneAPt1+YL45SufWmj6q193Jr4eU6Af9b6mSCeIvEZOHc
        pQ894KcIewCJs6ePBgqM7uIDgw==
X-Google-Smtp-Source: ABdhPJzX5UalnwICGKeRp6I4kHxHVKJILwYU0i00E7ab8iFGqOBWigZ0yzBU/yPnkSl80u5CckyZhQ==
X-Received: by 2002:a17:90b:1bc2:b0:1c9:9cd1:a4fe with SMTP id oa2-20020a17090b1bc200b001c99cd1a4femr35412815pjb.136.1649669917110;
        Mon, 11 Apr 2022 02:38:37 -0700 (PDT)
Received: from localhost.localdomain ([223.177.215.72])
        by smtp.gmail.com with ESMTPSA id d6-20020a056a00244600b004f701135460sm36461596pfj.146.2022.04.11.02.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 02:38:36 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
        will@kernel.org, liwei391@huawei.com
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, mhiramat@kernel.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 0/2] arm64: kgdb/kdb: Fix pending single-step debugging issues
Date:   Mon, 11 Apr 2022 15:08:17 +0530
Message-Id: <20220411093819.1012583-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set reworks pending fixes from Wei's series [1] to make
single-step debugging via kgdb/kdb on arm64 work as expected. There was
a prior discussion on ML [2] regarding if we should keep the interrupts
enabled during single-stepping but it turns out that in case of kgdb, it
is risky to enable interrupts as sometimes a resume after single
stepping an interrupt handler leads to following unbalanced locking
issue:

[  300.328300] WARNING: bad unlock balance detected!
[  300.328608] 5.18.0-rc1-00016-g3e732ebf7316-dirty #6 Not tainted
[  300.329058] -------------------------------------
[  300.329298] sh/173 is trying to release lock (dbg_slave_lock) at:
[  300.329718] [<ffffd57c951c016c>] kgdb_cpu_enter+0x7ac/0x820
[  300.330029] but there are no more locks to release!
[  300.330265] 
[  300.330265] other info that might help us debug this:
[  300.330668] 4 locks held by sh/173:
[  300.330891]  #0: ffff4f5e454d8438 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x98/0x204
[  300.331735]  #1: ffffd57c973bc2f0 (dbg_slave_lock){+.+.}-{2:2}, at: kgdb_cpu_enter+0x5b4/0x820
[  300.332259]  #2: ffffd57c973a9460 (rcu_read_lock){....}-{1:2}, at: kgdb_cpu_enter+0xe0/0x820
[  300.332717]  #3: ffffd57c973bc2a8 (dbg_master_lock){....}-{2:2}, at: kgdb_cpu_enter+0x1ec/0x820

So, I choose to keep interrupts disabled specifically for kgdb. This
series has been rebased to Linux 5.18-rc1 and I have dropped Doug's
review and test tags as there is significant rework involved.

[1] https://lore.kernel.org/all/20200509214159.19680-1-liwei391@huawei.com/
[2] https://lore.kernel.org/all/CAD=FV=Voyfq3Qz0T3RY+aYWYJ0utdH=P_AweB=13rcV8GDBeyQ@mail.gmail.com/

Sumit Garg (2):
  arm64: kgdb: Fix incorrect single stepping into the irq handler
  arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step

 arch/arm64/include/asm/debug-monitors.h |  1 +
 arch/arm64/kernel/debug-monitors.c      |  5 ++++
 arch/arm64/kernel/kgdb.c                | 35 +++++++++++++++++++++++--
 3 files changed, 39 insertions(+), 2 deletions(-)

-- 
2.25.1

