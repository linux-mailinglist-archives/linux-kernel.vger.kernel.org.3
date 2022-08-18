Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ED959845C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244679AbiHRNkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245144AbiHRNjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:39:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802985AC7F;
        Thu, 18 Aug 2022 06:39:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4C77616C6;
        Thu, 18 Aug 2022 13:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA50DC4315D;
        Thu, 18 Aug 2022 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660829947;
        bh=88BIzikTkD6g/4hks5fn4fU/mpPMY8uzoxDnFybpsys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PTaFOkjHzurVV3Tb/YV8czaY695Zf+l3dMmGduldqbhO75P0wI7P1i09Zz2CVFZyI
         6kG4CqYv4eX2vytjODKqCA/QZw2G+CVhAImouywlYvf4CNx2jCZt1m9xylUxsL2Ny0
         1GQBD8kqb9Q7IN3whc81R4sPwl/6z/HUYxWK90Pio2gfT1dw7k4Wj2gPa08SJLqrv9
         ebeCeBX2sQN7yVTcCq0lCPAsVxiZOj8RLP9Yh3UltQBlSmQKE/o6J1E+bvBAcWQFth
         qOFUy2HKz376fkmLzn8Tx93uWxb8zD0kzc1/SC+d5vjXwy+HTn3udjzKoAYMav5YUY
         MD1NoAtpgdVxA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oOfjl-00AY81-MM;
        Thu, 18 Aug 2022 15:39:05 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>, corbet@lwn.net
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Xiubo Li <xiubli@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] fs/dcache: fix a kernel-doc markup
Date:   Thu, 18 Aug 2022 15:38:59 +0200
Message-Id: <9d2676a83ebee327b97b82f3c2ab76a2e53756d1.1660829433.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660829433.git.mchehab@kernel.org>
References: <cover.1660829433.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no such thing of using the same kernel-doc markup for multiple
functions. Trying to be creative using a single one with a comma meant
for it to serve two functions will do the wrong thing and produce a
warning:

	./include/linux/dcache.h:310: warning: expecting prototype for dget, dget_dlock(). Prototype was for dget_dlock() instead

Address it by duplicating the comment.

Yet, it probably makes sense to explain when/why someone has to use
each variant of it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/

 include/linux/dcache.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 92c78ed02b54..5f254284bb83 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -299,7 +299,7 @@ extern char *dentry_path(const struct dentry *, char *, int);
 /* Allocation counts.. */
 
 /**
- *	dget, dget_dlock -	get a reference to a dentry
+ *	dget_dlock -	get a reference to a dentry
  *	@dentry: dentry to get a reference to
  *
  *	Given a dentry or %NULL pointer increment the reference count
@@ -313,6 +313,14 @@ static inline struct dentry *dget_dlock(struct dentry *dentry)
 	return dentry;
 }
 
+/**
+ *	dget -	get a reference to a dentry
+ *	@dentry: dentry to get a reference to
+ *
+ *	Given a dentry or %NULL pointer increment the reference count
+ *	if appropriate and return the dentry. A dentry will not be
+ *	destroyed when it has references.
+ */
 static inline struct dentry *dget(struct dentry *dentry)
 {
 	if (dentry)
-- 
2.37.1

