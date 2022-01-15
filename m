Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B75948F8DA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 19:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiAOSqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 13:46:44 -0500
Received: from sdaoden.eu ([217.144.132.164]:50346 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233406AbiAOSqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 13:46:43 -0500
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Jan 2022 13:46:43 EST
Received: from kent.sdaoden.eu (kent.sdaoden.eu [10.5.0.2])
        by sdaoden.eu (Postfix) with ESMTPS id 1E39F16059;
        Sat, 15 Jan 2022 19:40:29 +0100 (CET)
Received: by kent.sdaoden.eu (Postfix, from userid 1000)
        id C69BF2E51; Sat, 15 Jan 2022 19:40:26 +0100 (CET)
Date:   Sat, 15 Jan 2022 19:40:26 +0100
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Makefile: uses rsync(1), could this be optional?
Message-ID: <20220115184026.U6ZIV%steffen@sdaoden.eu>
Mail-Followup-To: linux-kernel@vger.kernel.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
User-Agent: s-nail v14.9.23-217-g95280174f9
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

As a not-yet-tested low-quality Makefile suggestion, with modern
GNU tools and find(1)'s -printf, wouldn't the following code work
out gracefully in practice?  (Not subscribed.)

Thanks for Linux!

--- Makefile.orig	2022-01-15 19:33:59.337393371 +0100
+++ Makefile	2022-01-15 19:34:07.447393217 +0100
@@ -1260,8 +1288,17 @@ export INSTALL_HDR_PATH = $(objtree)/usr
 quiet_cmd_headers_install = INSTALL $(INSTALL_HDR_PATH)/include
       cmd_headers_install = \
 	mkdir -p $(INSTALL_HDR_PATH); \
-	rsync -mrl --include='*/' --include='*\.h' --exclude='*' \
-	usr/include $(INSTALL_HDR_PATH)
+	if command -v rsync; then \
+		rsync -mrl --include='*/' --include='*\.h' --exclude='*' \
+		usr/include $(INSTALL_HDR_PATH);\
+	else \
+		cd usr;\
+		find include/ -type f -name '*.h' -printf '%f %h\n' |\
+		while read f d; do \
+			mkdir -p $(INSTALL_HDR_PATH)/$$d;\
+			cp -P $$d/$$f $(INSTALL_HDR_PATH)/$$d/$$f;\
+		done;\
+	fi
 
 PHONY += headers_install
 headers_install: headers

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
