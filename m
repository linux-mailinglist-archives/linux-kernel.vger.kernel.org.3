Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E8B4E74C5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359285AbiCYOG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359263AbiCYOGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ED5D8F4A;
        Fri, 25 Mar 2022 07:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E556561B27;
        Fri, 25 Mar 2022 14:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A458C340F4;
        Fri, 25 Mar 2022 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648217118;
        bh=m65/Et1iHVv6XP+JP+iGhMq2qae+wAHPwH92tV4AmNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LL8PaMmMGJAI8oNbT6uPdYJ0tVOHWey22HqjkB57P4tUnAKX7JWx6Fs916lWUJh7I
         fgthCih3V7WkfAK0K562/PMBeW0Uz7qcOxLc9gurSVIM1ADqcsGy2Gh8q7eQp8UhDJ
         AW9B0Dp2am/vW6ngPhIgMBw6w4o3oFd/HemhDI+n2mmQmIhaDgTC/QTr84NFipVayh
         yrqbwl2sua/Jrv91hVJaxZIwtNiBnqM8DMvD1AAJCraIWEZOTJE70IFhlT04XEFhoj
         717HTfSB2PszU0Dm2FZUKkQdp+Zjp69Xy0posk/73lYaiQ4GOciIFeLkCOOIGOTQeD
         tZGjOjdn/9Azg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nXkZ1-00Axz5-Tc; Fri, 25 Mar 2022 15:05:15 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] docs: kernel_include.py: add sphinx build dependencies
Date:   Fri, 25 Mar 2022 15:05:14 +0100
Message-Id: <f2b9b241b04bc3040d8fcad71d2b41649ab31372.1648216561.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648216561.git.mchehab@kernel.org>
References: <cover.1648216561.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The files included by kernel-include should be added as build
dependencies, in order for sphinx-build to rebuild the corresponding
docs if any changes at the included file happens.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 0/4] at: https://lore.kernel.org/all/cover.1648216561.git.mchehab@kernel.org/

 Documentation/sphinx/kernel_include.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index f523aa68a36b..abe768088377 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -59,6 +59,7 @@ class KernelInclude(Include):
     u"""KernelInclude (``kernel-include``) directive"""
 
     def run(self):
+        env = self.state.document.settings.env
         path = os.path.realpath(
             os.path.expandvars(self.arguments[0]))
 
@@ -70,6 +71,8 @@ class KernelInclude(Include):
 
         self.arguments[0] = path
 
+        env.note_dependency(os.path.abspath(path))
+
         #return super(KernelInclude, self).run() # won't work, see HINTs in _run()
         return self._run()
 
-- 
2.35.1

