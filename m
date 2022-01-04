Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC6C4845D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiADQN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:13:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54360 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiADQNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:13:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11120614BF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 16:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22AAC36AED;
        Tue,  4 Jan 2022 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641312803;
        bh=SYOuq4QCCHRXMqkBPeDi3N8aojaaAmUTN11Y3EnSLFw=;
        h=From:To:Cc:Subject:Date:From;
        b=pYHLsyIm8sARB68IALsDq2lM3CKxWn0HOloWJV3XcM4qEMMoYkv2dcGfky+i0LQbc
         V1M1BIUHVg8Lqhn6T9xTLvtxY4KfqG7lf+VDq2jpgMfyOcX4eaSEwyYQMnBekJIS2g
         8SRn8ewVsVk2FZH1j7J5hW5/HDl0+Jk2ot0Ls1hs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/opal: use default_groups in kobj_type
Date:   Tue,  4 Jan 2022 17:13:18 +0100
Message-Id: <20220104161318.1306023-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2218; h=from:subject; bh=SYOuq4QCCHRXMqkBPeDi3N8aojaaAmUTN11Y3EnSLFw=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlXimSKZzZG+yy2btCZqf84QsThxyN37qzlcya9+bVsoo3Z a1f9jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIiQ0M82zfLUqMnKpaOVWOXT/89Y LI3d+v7GOYZ2MqfORJ7oMAySLG9TpRi1fKT1n/BgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the powerpc opal dump and elog sysfs code to use
default_groups field which has been the preferred way since aa30f47cf666
("kobject: Add support for default attribute groups to kobj_type") so
that we can soon get rid of the obsolete default_attrs field.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/powernv/opal-dump.c | 3 ++-
 arch/powerpc/platforms/powernv/opal-elog.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 717d1d30ade5..410ed5b9de29 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -208,11 +208,12 @@ static struct attribute *dump_default_attrs[] = {
 	&ack_attribute.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(dump_default);
 
 static struct kobj_type dump_ktype = {
 	.sysfs_ops = &dump_sysfs_ops,
 	.release = &dump_release,
-	.default_attrs = dump_default_attrs,
+	.default_groups = dump_default_groups,
 };
 
 static int64_t dump_read_info(uint32_t *dump_id, uint32_t *dump_size, uint32_t *dump_type)
diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index 5821b0fa8614..554fdd7f88b8 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -144,11 +144,12 @@ static struct attribute *elog_default_attrs[] = {
 	&ack_attribute.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(elog_default);
 
 static struct kobj_type elog_ktype = {
 	.sysfs_ops = &elog_sysfs_ops,
 	.release = &elog_release,
-	.default_attrs = elog_default_attrs,
+	.default_groups = elog_default_groups,
 };
 
 /* Maximum size of a single log on FSP is 16KB */
-- 
2.34.1

