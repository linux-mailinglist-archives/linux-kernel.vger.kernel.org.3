Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EFB5905A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbiHKRS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiHKRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:18:35 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054FB98CB0;
        Thu, 11 Aug 2022 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=LtG2lQ8g4UFMf1coUU5mYDsEFUIxxdCEAwjofNBnS6E=; b=COivCoJdVPvxuCsM3im5fV1ASK
        4oXPj5JLozg6OMvSWP+UnzS4S5WPNzPBVVsTCtBd61dIJJoy6DeJQh+P3Gp1XSrM9KlVGeUFq+lwi
        o+FrcMVlJ9aeOBQuqbzfKKeuQMbMoDA4veJN5pMO6LgazRocaxoaYOZFo8YKWs+2Z/8Lyz52WImnf
        KraCvCojyNHbWODv3mBzYrsc2uDbTredmcoj5GXepEE0UhXnwb39s/nKmHNm8ToQXAUYuXBbCX0DP
        L9SpcRtartqLx7cLb/SLherpd+t5snbpknNaAXCOaWHv1AwVwDIcuG46E4LuoW8FfKtt8HsJPN7OW
        Z631nn/A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oMBlJ-00EAyg-Rl; Thu, 11 Aug 2022 11:14:27 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oMBlH-000cR7-Qc; Thu, 11 Aug 2022 11:14:23 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        David Sloan <david.sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 11 Aug 2022 11:14:13 -0600
Message-Id: <20220811171417.147697-2-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220811171417.147697-1-logang@deltatee.com>
References: <20220811171417.147697-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, david.sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 1/5] md: Flush workqueue md_rdev_misc_wq in md_alloc()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Sloan <david.sloan@eideticom.com>

A race condition still exists when removing and re-creating md devices
in test cases. However, it is only seen on some setups.

The race condition was tracked down to a reference still being held
to the kobject by the rdev in the md_rdev_misc_wq which will be released
in rdev_delayed_delete().

md_alloc() waits for previous deletions by waiting on the md_misc_wq,
but the md_rdev_misc_wq may still be holding a reference to a recently
removed device.

To fix this, also flush the md_rdev_misc_wq in md_alloc().

Signed-off-by: David Sloan <david.sloan@eideticom.com>
[logang@deltatee.com: rewrote commit message]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/md.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index afaf36b2f6ab..71d221601bf8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5620,6 +5620,7 @@ struct mddev *md_alloc(dev_t dev, char *name)
 	 * removed (mddev_delayed_delete).
 	 */
 	flush_workqueue(md_misc_wq);
+	flush_workqueue(md_rdev_misc_wq);
 
 	mutex_lock(&disks_mutex);
 	mddev = mddev_alloc(dev);
-- 
2.30.2

