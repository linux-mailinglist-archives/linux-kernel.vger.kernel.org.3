Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB88A51105B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357765AbiD0FET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240085AbiD0FEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:04:15 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272633F307;
        Tue, 26 Apr 2022 22:01:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h1so611967pfv.12;
        Tue, 26 Apr 2022 22:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SFTg9MPpAQTp6TISgZC7JwgCd+VZygIltX3qHXtuEIY=;
        b=M9T5s2utd20CnMnOeMpcBa4bYx7nj5rJZtAwndg5kj3H5PopvrFBSzHq02FziZkf0D
         4sQ4y/7n/Xwj/nwxCJEoey3LR/SmgJl9zeHG37Di0cWLYg5F17aF3MA+a5D33z6BRvrA
         WXTL/ZWvYyAztswWc+j345du08QD3O0c8Cq9ijTCDVCNkCFlfrSJ01m7+MMVbvyT3e4j
         yZfoV07Cx0jUbPlbB8MRpJM3dL8ALM9hBG4K8q0UAt5AaRvZDGfGTvP4xw2cLuLbFbb9
         HF/BWAz/0tVtyLITz/1CaeHiHhF6EF+ZTwITITJWF3ZegZMDDOGJPOAaLrvOP742Wtgh
         Smyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=SFTg9MPpAQTp6TISgZC7JwgCd+VZygIltX3qHXtuEIY=;
        b=JBhhvTgCdlXuBx5yQiZP9ps0UFIQZ5suT3W/T0Zg7KhoiA57Px8AB2GDvcO3LtphZP
         ep1H1CCZmuqA+5zak549QWJaUExVAyZuEgIIuCm3AF01JOY9RuNZRSrc4rwvjRSzf/vi
         7TcJ/yOyNfNZrTWAV8BMs45pq2HdOzY0akeTlbjcEnPmcuJCQ1pEjana0dw81C4Iqavm
         rdai+JNd4Uq0rYGC1ioq+gthNNSX7hW7UJt5SBZrD/ASmmnNcLhsmwcXJa/WEHVJ1Ggo
         4Wyou2DOP+t9SQpYjKj76K5B5JHzyaOtfLtGpP2CpNBkUISZvmU/0Vbf5GB5lD1tsrk2
         CkrQ==
X-Gm-Message-State: AOAM53241FGuDV0D16MVeLQd2dAtKSJd0L1FBtnVjQETZtdLUgpC1whY
        HUmybtqefOMbmEZG0cVNsO4=
X-Google-Smtp-Source: ABdhPJyMcdiaF/JnIL8yZrYft4WsH/fwDZRML7R1hbRK74iYsx6XgOIzGNwB0a/19H8GoJYefSCdHg==
X-Received: by 2002:a05:6a02:182:b0:374:5a57:cbf9 with SMTP id bj2-20020a056a02018200b003745a57cbf9mr21979675pgb.616.1651035664985;
        Tue, 26 Apr 2022 22:01:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7a3e])
        by smtp.gmail.com with ESMTPSA id t15-20020a62d14f000000b0050d3846c538sm10587628pfl.57.2022.04.26.22.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 22:01:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 26 Apr 2022 19:01:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Rik van Riel <riel@surriel.com>
Subject: [PATCH block-5.18] iocost: don't reset the inuse weight of
 under-weighted debtors
Message-ID: <YmjODd4aif9BzFuO@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an iocg is in debt, its inuse weight is owned by debt handling and
should stay at 1. This invariant was broken when determining the amount of
surpluses at the beginning of donation calculation - when an iocg's
hierarchical weight is too low, the iocg is excluded from donation
calculation and its inuse is reset to its active regardless of its
indebtedness, triggering warnings like the following:

 WARNING: CPU: 5 PID: 0 at block/blk-iocost.c:1416 iocg_kick_waitq+0x392/0x3a0
 ...
 RIP: 0010:iocg_kick_waitq+0x392/0x3a0
 Code: 00 00 be ff ff ff ff 48 89 4d a8 e8 98 b2 70 00 48 8b 4d a8 85 c0 0f 85 4a fe ff ff 0f 0b e9 43 fe ff ff 0f 0b e9 4d fe ff ff <0f> 0b e9 50 fe ff ff e8 a2 ae 70 00 66 90 0f 1f 44 00 00 55 48 89
 RSP: 0018:ffffc90000200d08 EFLAGS: 00010016
 ...
  <IRQ>
  ioc_timer_fn+0x2e0/0x1470
  call_timer_fn+0xa1/0x2c0
 ...

As this happens only when an iocg's hierarchical weight is negligible, its
impact likely is limited to triggering the warnings. Fix it by skipping
resetting inuse of under-weighted debtors.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Rik van Riel <riel@surriel.com>
Fixes: c421a3eb2e27 ("blk-iocost: revamp debt handling")
Cc: stable@vger.kernel.org # v5.10+
---
 block/blk-iocost.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 70a0a3d680a35..9bd670999d0af 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2322,7 +2322,17 @@ static void ioc_timer_fn(struct timer_list *timer)
 				iocg->hweight_donating = hwa;
 				iocg->hweight_after_donation = new_hwi;
 				list_add(&iocg->surplus_list, &surpluses);
-			} else {
+			} else if (!iocg->abs_vdebt) {
+				/*
+				 * @iocg doesn't have enough to donate. Reset
+				 * its inuse to active.
+				 *
+				 * Don't reset debtors as their inuse's are
+				 * owned by debt handling. This shouldn't affect
+				 * donation calculuation in any meaningful way
+				 * as @iocg doesn't have a meaningful amount of
+				 * share anyway.
+				 */
 				TRACE_IOCG_PATH(inuse_shortage, iocg, &now,
 						iocg->inuse, iocg->active,
 						iocg->hweight_inuse, new_hwi);
