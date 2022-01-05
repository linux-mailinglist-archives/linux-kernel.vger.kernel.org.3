Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E894857CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242663AbiAER5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiAER45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:56:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67171C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 09:56:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 787E5B81CDA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 17:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7CDC36AE0;
        Wed,  5 Jan 2022 17:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641405414;
        bh=A4o09EHP0/Q+rMDTFiXzm2iUIp/xW4ydVYShp5v3dbs=;
        h=From:To:Cc:Subject:Date:From;
        b=y1a/xplvjN+TsHIkTk9GMCEf7kteZdZzRsDJzP+ITlT45Z5tifvn4h4sqfcy8wJHu
         5BaMZYMJzxT6AMzz49gJIjVA7zunuBmVOQEYzB2GsLX5sIJCH+e34joMni73L/0lr9
         VF01aJSStuUKkE2QHgSzI58DPR4E98u141RJ13cQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] firmware: memmap: use default_groups in kobj_type
Date:   Wed,  5 Jan 2022 18:56:50 +0100
Message-Id: <20220105175650.2640758-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; h=from:subject; bh=A4o09EHP0/Q+rMDTFiXzm2iUIp/xW4ydVYShp5v3dbs=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlXbz9s6n3a2Lf03MMzadu+LNYQmsvq+vWT0jPODNMOe4Mr fTvcO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiee8Y5le7Gs17sGnS3wxvjebzz9 rsO7oNdjAsWKY+Md6l/3HAXMl9T0viC3f+XWE8GQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the firmware memmap sysfs code to use default_groups field
which has been the preferred way since aa30f47cf666 ("kobject: Add
support for default attribute groups to kobj_type") so that we can soon
get rid of the obsolete default_attrs field.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/memmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
index 24945e2da77b..8e59be3782cb 100644
--- a/drivers/firmware/memmap.c
+++ b/drivers/firmware/memmap.c
@@ -69,6 +69,7 @@ static struct attribute *def_attrs[] = {
 	&memmap_type_attr.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(def);
 
 static const struct sysfs_ops memmap_attr_ops = {
 	.show = memmap_attr_show,
@@ -118,7 +119,7 @@ static void __meminit release_firmware_map_entry(struct kobject *kobj)
 static struct kobj_type __refdata memmap_ktype = {
 	.release	= release_firmware_map_entry,
 	.sysfs_ops	= &memmap_attr_ops,
-	.default_attrs	= def_attrs,
+	.default_groups	= def_groups,
 };
 
 /*
-- 
2.34.1

