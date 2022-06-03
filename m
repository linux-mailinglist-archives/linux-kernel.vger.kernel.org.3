Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CED953C963
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 13:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244038AbiFCLcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244031AbiFCLck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:32:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D2D6582
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 04:32:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B127A614B9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 11:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71328C385B8;
        Fri,  3 Jun 2022 11:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654255959;
        bh=RUIWjdi+c0hEDA8KmPq5DigplDr40Ya3Xv3H0upaLZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=endJPiCxHK9arBpNI/XcCyq7SNAcyH4oGZm+pKOWOgtKHYx7bbDNcWwPrHh4IQ6hx
         5kn4YwUfin24FhSpC/KhNli7LsznpxtuUTsDFocNK6MhwuKqNetv7ZApGMmsm5TijH
         CHJh0IEl6Fpvj+OkPWD2heoOnVs/ZKGa1p1Xy9ro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] driver core: Set default deferred_probe_timeout back to 0.
Date:   Fri,  3 Jun 2022 13:31:38 +0200
Message-Id: <20220603113138.2689444-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603113138.2689444-1-gregkh@linuxfoundation.org>
References: <YpnwZ/Q5yTKRDBOD@kroah.com>
 <20220603113138.2689444-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1556; i=gregkh@linuxfoundation.org; h=from:subject; bh=qt7Uo5/n3MdW34pPRVweL6Pb/Qf79epqflj4y7Z+mzk=; b=owGbwMvMwCRo6H6F97bub03G02pJDEkzP0olzLtVMLMrLqfzeiPvCcdfcz//W/XnqMAEm1WfZJbb u3q7d8SyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBESpIZ5imEClzevnR7dTcz+8yQlT O3zm21P8cwP6/6zNSkCcw7Ffbv21q1Izwx/fX6VAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

Since we had to effectively reverted
commit 35a672363ab3 ("driver core: Ensure wait_for_device_probe() waits
until the deferred_probe_timeout fires") in an earlier patch, a non-zero
deferred_probe_timeout will break NFS rootfs mounting [1] again. So, set
the default back to zero until we can fix that.

[1] - https://lore.kernel.org/lkml/TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com/

Fixes: 2b28a1a84a0e ("driver core: Extend deferred probe timeout on driver registration")
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Link: https://lore.kernel.org/r/20220526034609.480766-3-saravanak@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/dd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 91f63cd33b12..251b5ba1b84a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -256,12 +256,7 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 
-#ifdef CONFIG_MODULES
-int driver_deferred_probe_timeout = 10;
-#else
 int driver_deferred_probe_timeout;
-#endif
-
 EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
 
 static int __init deferred_probe_timeout_setup(char *str)
-- 
2.36.1

