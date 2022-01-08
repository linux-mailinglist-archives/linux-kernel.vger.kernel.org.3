Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E145A4883E9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 15:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiAHOHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 09:07:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43436 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiAHOHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 09:07:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2177860A21
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 14:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0232DC36AE9;
        Sat,  8 Jan 2022 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641650822;
        bh=gci4djc4GSMAbsYN1DiQSIK1IPxgklaPR2gyH4o82ao=;
        h=From:To:Cc:Subject:Date:From;
        b=K/fowwAVjqUCiHVa27XwHnrTP2N+Sdr77Lk5qDzGuyaI+AcZ2ydgzcVrq3r255Q46
         cvqIvPbc86UudRo8duk2SfgCeC6kvLFZq8eNyj0BxVteZ8BT1I+RHparCfcrf631Nc
         LuzX/LVdaVJmx23fBeTI3g1yj5T/tiGR9GYE578o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Matthias Maennich <maennich@google.com>
Subject: [PATCH] module.h: allow #define strings to work with MODULE_IMPORT_NS
Date:   Sat,  8 Jan 2022 15:06:57 +0100
Message-Id: <20220108140657.3361237-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; h=from:subject; bh=gci4djc4GSMAbsYN1DiQSIK1IPxgklaPR2gyH4o82ao=; b=owGbwMvMwCRo6H6F97bub03G02pJDIk3ZzUqGNdEHNYU14qI9SvTd5FeuXfZl7p3rS9+qZ0rnxpe qLuqI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACaywo1hwfJP8mITJt61XfNwYdzbO/ 05UyrrShjmaU81n278JYpj8f33t6OP3v+oc1XyAQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_IMPORT_NS() macro does not allow defined strings to work
properly with it, so add a layer of indirection to allow this to happen.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Matthias Maennich <maennich@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, there is no in-kernel user of this, I wrote this to help deal with
some module namespace issues that Android kernels were having where we
wanted to put the namespace name in a build #define to make things
easier over time when combined with the change at:
	https://lore.kernel.org/all/20220108140415.3360088-1-gregkh@linuxfoundation.org/

I can also see this be used in ways to make namespace names up "on the
fly at build time" when combined with the above-referenced change to
create a different namespace for every time the kernel is built to do a
poor-man's symbol mangling to make life harder for out-of-tree modules.
Not that I would ever suggest such a thing :)

 include/linux/module.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index c9f1200b2312..f4338235ed2c 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -290,7 +290,8 @@ extern typeof(name) __mod_##type##__##name##_device_table		\
  * files require multiple MODULE_FIRMWARE() specifiers */
 #define MODULE_FIRMWARE(_firmware) MODULE_INFO(firmware, _firmware)
 
-#define MODULE_IMPORT_NS(ns) MODULE_INFO(import_ns, #ns)
+#define _MODULE_IMPORT_NS(ns)	MODULE_INFO(import_ns, #ns)
+#define MODULE_IMPORT_NS(ns)	_MODULE_IMPORT_NS(ns)
 
 struct notifier_block;
 
-- 
2.34.1

