Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FE84EAF2E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiC2O1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiC2O1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:27:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444A86C911
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:25:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF192615A3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E5FC340ED;
        Tue, 29 Mar 2022 14:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648563958;
        bh=yYTB0lyh3mmHTVhYy9K2H4htwEZT34AzRrO9oY4njbo=;
        h=From:To:Cc:Subject:Date:From;
        b=zU0ECT3KiVA61Iyvuls8H3Jr2mbxSQODcBvT+XB91Xu92mXppiAfWtY1SlmAWe655
         Q+ZuQEBqj/8yKmbszq50hf147Y799oSCLMr9UMmi95GoSHKO+BQ4hhGI6yESU+E5Dk
         oXlwyob+TcILIJJ0ALYYhPLgqRS1rN1weINzHt4U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Haren Myneni <haren@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/pseries/vas: use default_groups in kobj_type
Date:   Tue, 29 Mar 2022 16:25:52 +0200
Message-Id: <20220329142552.558339-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2424; h=from:subject; bh=yYTB0lyh3mmHTVhYy9K2H4htwEZT34AzRrO9oY4njbo=; b=owGbwMvMwCRo6H6F97bub03G02pJDEnOYu8maiVI7HIM+FofITKLu+rgM//52Zoz/j4WPPz5K9Pn zsAdHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCR1KkMczgaZ2tsj41zmHZs3anjCa plWyP2hjEsWL0ke0uavXuHzcJtxhp3v2z7unB9IAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
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

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the pseries vas sysfs code to use default_groups field
which has been the preferred way since aa30f47cf666 ("kobject: Add
support for default attribute groups to kobj_type") so that we can soon
get rid of the obsolete default_attrs field.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Haren Myneni <haren@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Note, I would like to take this through my driver-core tree for 5.18-rc2
as this is the last hold-out of the default_attrs field.  It "snuck" in
as new code for 5.18-rc1, any objection to me taking it?

thanks,

greg k-h

 arch/powerpc/platforms/pseries/vas-sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/vas-sysfs.c b/arch/powerpc/platforms/pseries/vas-sysfs.c
index 4a7fcde5afc0..909535ca513a 100644
--- a/arch/powerpc/platforms/pseries/vas-sysfs.c
+++ b/arch/powerpc/platforms/pseries/vas-sysfs.c
@@ -99,6 +99,7 @@ static struct attribute *vas_def_capab_attrs[] = {
 	&nr_used_credits_attribute.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(vas_def_capab);
 
 static struct attribute *vas_qos_capab_attrs[] = {
 	&nr_total_credits_attribute.attr,
@@ -106,6 +107,7 @@ static struct attribute *vas_qos_capab_attrs[] = {
 	&update_total_credits_attribute.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(vas_qos_capab);
 
 static ssize_t vas_type_show(struct kobject *kobj, struct attribute *attr,
 			     char *buf)
@@ -154,13 +156,13 @@ static const struct sysfs_ops vas_sysfs_ops = {
 static struct kobj_type vas_def_attr_type = {
 		.release	=	vas_type_release,
 		.sysfs_ops      =       &vas_sysfs_ops,
-		.default_attrs  =       vas_def_capab_attrs,
+		.default_groups	=	vas_def_capab_groups,
 };
 
 static struct kobj_type vas_qos_attr_type = {
 		.release	=	vas_type_release,
 		.sysfs_ops	=	&vas_sysfs_ops,
-		.default_attrs	=	vas_qos_capab_attrs,
+		.default_groups	=	vas_qos_capab_groups,
 };
 
 static char *vas_caps_kobj_name(struct vas_caps_entry *centry,
-- 
2.35.1

