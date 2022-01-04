Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E951B484529
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiADPsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiADPsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:48:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C41BC061761;
        Tue,  4 Jan 2022 07:48:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A2D961492;
        Tue,  4 Jan 2022 15:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBC9C36AE9;
        Tue,  4 Jan 2022 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641311284;
        bh=dDzMHlLnNUUHegsHLetyjpYo/44r9VvVT/d4vsDqNrE=;
        h=From:To:Cc:Subject:Date:From;
        b=LazF/egiOSl1C/q0ggX1XNs4/tt4hOpWZP4yFEStOtV5s/sVa9ajv9k0+3jW7TDsf
         J5GWYOpyjhTddU0f2BMo1ShKjdzAwTrfi3UOl2Tuyxg6gl4KxUFLoBB4IARfg3rKkW
         nbzySwRv9hSKfmH5I8/RllP8aMQKwwL4z+dehn9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        linux-ia64@vger.kernel.org
Subject: [PATCH] ia64: topology: use default_groups in kobj_type
Date:   Tue,  4 Jan 2022 16:48:00 +0100
Message-Id: <20220104154800.1287947-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477; h=from:subject; bh=dDzMHlLnNUUHegsHLetyjpYo/44r9VvVT/d4vsDqNrE=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlXcvQZAjkFFd1EXiybGy5j63FrXcHlx56ZTR5Wa65pL827 bPS7I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDaEi1MAJnJBjGHBsdnpOwz/36qSOaha62DDnd TapqXEMFfu7cGzpYeuL4rd/a/Xu7lyWcny3ssA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the ia64 topology sysfs code to use default_groups field
which has been the preferred way since aa30f47cf666 ("kobject: Add
support for default attribute groups to kobj_type") so that we can soon
get rid of the obsolete default_attrs field.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-ia64@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/ia64/kernel/topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/topology.c b/arch/ia64/kernel/topology.c
index 3639e0a7cb3b..e4992917a24b 100644
--- a/arch/ia64/kernel/topology.c
+++ b/arch/ia64/kernel/topology.c
@@ -264,6 +264,7 @@ static struct attribute * cache_default_attrs[] = {
 	&shared_cpu_map.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(cache_default);
 
 #define to_object(k) container_of(k, struct cache_info, kobj)
 #define to_attr(a) container_of(a, struct cache_attr, attr)
@@ -284,7 +285,7 @@ static const struct sysfs_ops cache_sysfs_ops = {
 
 static struct kobj_type cache_ktype = {
 	.sysfs_ops	= &cache_sysfs_ops,
-	.default_attrs	= cache_default_attrs,
+	.default_groups	= cache_default_groups,
 };
 
 static struct kobj_type cache_ktype_percpu_entry = {
-- 
2.34.1

