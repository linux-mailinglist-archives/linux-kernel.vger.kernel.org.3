Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63DB4F85DA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346190AbiDGRY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346083AbiDGRX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:23:58 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8106864F4;
        Thu,  7 Apr 2022 10:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=lUq08cdcUVP7geqUMO4Ev+0ju/xC3/Dyu2GujITehKs=; b=PYyrJt7ewqHOGWsi3qiAGmkBH3
        kfZnUZVWFOZkih3iCNvFDuyt8k4UgmY4gnUljez5mnh1LJrjJVrMUbkKnTsRKcskR3pJCsjf1YN7v
        FUX3AFBU3i/6jUyACSHWwTuJjsCH45O/NuetVOcgAfIhPFMFlGVRpi2G07A6KcKiE+B9UDenB1Rgj
        /qODeNf94xzKtPQkQ/Rh8JSYTNkGyJDcQKJZDsZ5lWoNdeSA/W/H4qxNDP0BKOWfKkwXIyhX6iEEz
        TSwJSmQ+Zjd8WOV/Lk0rytSx3AVDQRSVTtmy+TAzmk0FHUAC8Fg94+BCBVjANwmMFVPQIdmgtxC8t
        Do7rkeBQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVRf-002CRe-HG; Thu, 07 Apr 2022 10:57:20 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVRe-0002Pz-O1; Thu, 07 Apr 2022 10:57:18 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  7 Apr 2022 10:57:06 -0600
Message-Id: <20220407165713.9243-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, guoqing.jiang@linux.dev, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v1 0/7] Minor Raid5 Fixes and Cleanup
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series contains a few cleanup and minor fixes to the raid5 code
to make it a bit easier to hack on.

Patch 1 cleans up the error returns in setup_conf() (I had an
abandonded patch that added another error out and needed this clean
more sensible).

Patch 2 fixes a sparse warning with the raid5_percpu structure.

Patch 3 through 6 fixes sparse warnings related to missing __rcu
annotations when using the RCU calls.

Patch 7 just adds some basic __must_hold annotations for the device_lock
to any function that is called while holding the lock. Sparse doesn't
really check this, but the annotation makes the locks a little easier
to analyze.

Thanks,

Logan

--

Logan Gunthorpe (7):
  md/raid5: Cleanup setup_conf() error returns
  md/raid5: Un-nest struct raid5_percpu definition
  md/raid5: Add __rcu annotation to struct disk_info
  md/raid5: Annotate rdev/replacement accesses when nr_pending is
    elevated
  md/raid5: Annotate rdev/replacement access when mddev_lock is held
  md/raid5-ppl: Annotate with rcu_dereference_protected()
  md/raid5: Annotate functions that hold device_lock with __must_hold

 drivers/md/raid5-ppl.c |  13 ++-
 drivers/md/raid5.c     | 179 ++++++++++++++++++++++++++---------------
 drivers/md/raid5.h     |  23 +++---
 3 files changed, 139 insertions(+), 76 deletions(-)


base-commit: 3123109284176b1532874591f7c81f3837bbdc17
--
2.30.2
