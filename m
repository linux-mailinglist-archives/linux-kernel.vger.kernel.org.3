Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282004AB765
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349318AbiBGJMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240758AbiBGJGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:06:40 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C73FC043181;
        Mon,  7 Feb 2022 01:06:39 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id on2so3767383pjb.4;
        Mon, 07 Feb 2022 01:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z4u5w4bPw3yV/b+kwX1aHYBXd+5cdgt0I+HhlG81Y0w=;
        b=I3SC8O7pbbNxbedv2qwjaMe3RpBRr2dLh4gTQ4+8YLG66sdQWzfhcz+A7XLsoifHPp
         O/KBe+DuQl1gJ4RtlJHPJvHYZtdeThla2pgyR0eQvCbcW/winam4GAAAQXIJaqzKLrt4
         ir6Pko95eMhn/toNdLOg9FSWIEoULuDqVRy8sDWVi2SpaGip5tn+fzVwLa/QIdETuW7S
         VV0Ys4OL4BFHJV2TCch65duVYYr7bOxIhI0E8fAHQH87B3Hfic3XTmmPzqgAPPMctlYX
         eAFOGNdpAsuvm9qNFGR6y+j997pRPszL2VnlqyV8uzMKJAH1NnBdZeypw5QTwsYBeAbq
         GJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z4u5w4bPw3yV/b+kwX1aHYBXd+5cdgt0I+HhlG81Y0w=;
        b=dA3dejW1qANkxKfpfov00Rx70XgOqKi6sZ1Th03JDX0hAC1nl99VrSZxGOHqleO2/j
         n7RRhf/DTdFFoSU/G/EyyL51/xcEnDc/LAiePT4SXI07mRTE2VrNBeso+sysNS8aDrFk
         dYB2fiONBH5z+b0pU34C9sgubPN5Mwwj9+jXBUNjT9igMZYiXJmrGxW+2Bvbo/QvPlJP
         JlGkYX6NZnaZ+kslbMurs4y+6LCl9wf9VFdOxL+DsvawvDpwC84dsooxKoF2Ox4sfOvw
         08QOsgGHDUxWI7/PIRr+pZ0ehoaY4Ivnse8W5XVnoL2LEcopRDTBhsUL1zg2s3QR4PUJ
         xlXw==
X-Gm-Message-State: AOAM5304gy2SKWnXTi2DFMovICTmTjGxxo7YnJ/M3fkPOgjPXYoH+lO0
        tygmvRIb8blRZIijWRsTTdFrkC/SdB0=
X-Google-Smtp-Source: ABdhPJx4GR2wsbDJLP7wI3RIxadSj0ipCMY9VI0P/l4mi9o0gHOe/FMyPrBofsFJ5cLht8dSGeBJGw==
X-Received: by 2002:a17:90b:4c06:: with SMTP id na6mr13168872pjb.37.1644224798980;
        Mon, 07 Feb 2022 01:06:38 -0800 (PST)
Received: from baohua-VirtualBox.localdomain (47-72-151-34.dsl.dyn.ihug.co.nz. [47.72.151.34])
        by smtp.gmail.com with ESMTPSA id s17sm10660126pfk.156.2022.02.07.01.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 01:06:38 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <song.bao.hua@hisilicon.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        Barry Song <song.bao.hua@hisilicon.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] dm io: Drop the obsolete and incorrect doc for dm_io()
Date:   Mon,  7 Feb 2022 17:06:20 +0800
Message-Id: <20220207090620.21207-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7eaceaccab5f ("block: remove per-queue plugging") dropped
unplug_delay() and blk_unplug(). And the current code has no
fundamental difference between sync_io() and async_io() except
sync_io() uses sync_io_complete() as the notify.fn and explicitly
calls wait_for_completion_io() to sync. The comment isn't valid
any more.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/md/dm-io.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index 2d3cda0acacb..7dba193de28b 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -528,11 +528,6 @@ static int dp_init(struct dm_io_request *io_req, struct dpages *dp,
 
 /*
  * New collapsed (a)synchronous interface.
- *
- * If the IO is asynchronous (i.e. it has notify.fn), you must either unplug
- * the queue with blk_unplug() some time later or set REQ_SYNC in
- * io_req->bi_opf. If you fail to do one of these, the IO will be submitted to
- * the disk after q->unplug_delay, which defaults to 3ms in blk-settings.c.
  */
 int dm_io(struct dm_io_request *io_req, unsigned num_regions,
 	  struct dm_io_region *where, unsigned long *sync_error_bits)
-- 
2.25.1

