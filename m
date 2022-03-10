Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183E94D472B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbiCJMnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiCJMno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:43:44 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596CC29802;
        Thu, 10 Mar 2022 04:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646916162;
  x=1678452162;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tZ6AlfXiapP/crt3nnrn0CmCo73rq+3VFlax+DaKLXQ=;
  b=OHiB7d1BAXHPZi8elNwZ41UnQgzFtrXKTdLiBR2tJDUm+1REWgbt4bdA
   vX79uyhW4IMqfj1l72oBCvD5MQ/PhcLaHs+kj8KzI8RRUJaas7jOG+apM
   X1Q3rQIllXx4N2aZXgl9UtglWlgbXkK4mQQ6OlMsppVvjRte41ZL5Q9ys
   2R3vdFOFyUWIz6NKTzzoyUFHhMChfKYlggoP1Y1L9jEoAkjRliB7qB/m4
   PhQ1Y9enQvjtLSWb+kEAumQ7iS70vUGBrS8ywjLeJtSeV5QKEJa5MoSiw
   uJSbbNLA7hWHfqTyPW9UTraYvwnJgA6owx6/b/3zPDLmyc3Jld2aawBvr
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-um@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] docs: UML: Mention telnetd for port channel
Date:   Thu, 10 Mar 2022 13:42:30 +0100
Message-ID: <20220310124230.3069354-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not obvious from the documentation that using the "port" channel
for the console requires telnetd to be installed (see port_connection()
in arch/um/drivers/port_user.c).  Mention this, and the fact that UML
will not boot until a client connects.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 Documentation/virt/uml/user_mode_linux_howto_v2.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index 2cafd3c3c6cb..d5ad96c795f6 100644
--- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
+++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
@@ -664,7 +664,11 @@ one is input, the second one output.
 * The fd channel - use file descriptor numbers for input/output. Example:
   ``con1=fd:0,fd:1.``
 
-* The port channel - listen on TCP port number. Example: ``con1=port:4321``
+* The port channel - start a telnet server on TCP port number. Example:
+  ``con1=port:4321``.  The host must have /usr/sbin/in.telnetd (usually part of
+  a telnetd package) and the port-helper from the UML utilities (see the
+  information for the xterm channel below).  UML will not boot until a client
+  connects.
 
 * The pty and pts channels - use system pty/pts.
 
-- 
2.34.1

