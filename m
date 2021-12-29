Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1974813E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbhL2ONj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbhL2ONi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:13:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC5EC061574;
        Wed, 29 Dec 2021 06:13:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B9DB614AF;
        Wed, 29 Dec 2021 14:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDB6C36AE9;
        Wed, 29 Dec 2021 14:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640787217;
        bh=crdfs2TcubasYQDmy/rvRISSaBoRTG5lde8cjXxvosU=;
        h=From:To:Cc:Subject:Date:From;
        b=1+Es1wx9cEU/Sa1e2l8AyJP94Qnj61zi9vrA0XXBq8w1QNlKRw+msXT15DmAkEO+O
         /EBhDM6R3HC2Yfz+OCgTbpqz1ed7QAOTfyseJG4Tk9lxwit5kOqR8xwzYKPfjC3j2n
         9J7kqYk82GK+p0SuFNrnUXdRYEE9UZZfREjJF5s4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Justin Ernst <justin.ernst@hpe.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] x86/platform/uv: use default_groups in kobj_type
Date:   Wed, 29 Dec 2021 15:13:32 +0100
Message-Id: <20211229141332.2552428-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; h=from:subject; bh=crdfs2TcubasYQDmy/rvRISSaBoRTG5lde8cjXxvosU=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlncnle+WRwrjdvEGUwdVyWEjnnkkHmzd/ccqGuOw67fVqi +uh4RywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEzkmj3Dgvkd3gVnylfUB95Oe8ZjuM /72JltrQwLZqV4tqXeqbl/f3GRQ+qTX/lls/9MBQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the uv sysfs code to use default_groups field which has
been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: Justin Ernst <justin.ernst@hpe.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/uv_sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
index 956a354b57c1..625b0b79d185 100644
--- a/drivers/platform/x86/uv_sysfs.c
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -175,6 +175,7 @@ static struct attribute *uv_hub_attrs[] = {
 	&cnode_attribute.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(uv_hub);
 
 static void hub_release(struct kobject *kobj)
 {
@@ -205,7 +206,7 @@ static const struct sysfs_ops hub_sysfs_ops = {
 static struct kobj_type hub_attr_type = {
 	.release	= hub_release,
 	.sysfs_ops	= &hub_sysfs_ops,
-	.default_attrs	= uv_hub_attrs,
+	.default_groups	= uv_hub_groups,
 };
 
 static int uv_hubs_init(void)
@@ -327,6 +328,7 @@ static struct attribute *uv_port_attrs[] = {
 	&uv_port_conn_port_attribute.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(uv_port);
 
 static void uv_port_release(struct kobject *kobj)
 {
@@ -357,7 +359,7 @@ static const struct sysfs_ops uv_port_sysfs_ops = {
 static struct kobj_type uv_port_attr_type = {
 	.release	= uv_port_release,
 	.sysfs_ops	= &uv_port_sysfs_ops,
-	.default_attrs	= uv_port_attrs,
+	.default_groups	= uv_port_groups,
 };
 
 static int uv_ports_init(void)
-- 
2.34.1

