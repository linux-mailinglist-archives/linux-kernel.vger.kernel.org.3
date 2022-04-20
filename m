Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C2A507DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbiDTAq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358628AbiDTAqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:46:19 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3C82C117;
        Tue, 19 Apr 2022 17:43:34 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E24A91BF205;
        Wed, 20 Apr 2022 00:43:27 +0000 (UTC)
From:   joao@overdrivepizza.com
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     joao@overdrivepizza.com, peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: [RFC PATCH 07/11] x86/lib: Prevent UACCESS call warning from objtool
Date:   Tue, 19 Apr 2022 17:42:37 -0700
Message-Id: <20220420004241.2093-8-joao@overdrivepizza.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420004241.2093-1-joao@overdrivepizza.com>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Moreira <joao@overdrivepizza.com>

Objtool emits a warning whenever it finds a call that may happen with
UACCESS enabled. Prevent this b not emitting calls to the
__fineibt_handler in such circumstances, making the function
coarse-grained.

Signed-off-by: Joao Moreira <joao@overdrivepizza.com>
---
 arch/x86/lib/copy_mc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index 80efd45a7761..554e6c6ecea2 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -22,7 +22,7 @@ void enable_copy_mc_fragile(void)
  * Similar to copy_user_handle_tail, probe for the write fault point, or
  * source exception point.
  */
-__visible notrace unsigned long
+__visible notrace unsigned long __coarseendbr
 copy_mc_fragile_handle_tail(char *to, char *from, unsigned len)
 {
 	for (; len; --len, to++, from++)
-- 
2.35.1

