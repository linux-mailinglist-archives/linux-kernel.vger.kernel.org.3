Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C1B5829F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiG0Psh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiG0Psf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:48:35 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDE7491E8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:48:33 -0700 (PDT)
Received: from stanislav-HLY-WX9XX.. (unknown [46.172.13.9])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6D0FF40737A5;
        Wed, 27 Jul 2022 15:48:29 +0000 (UTC)
From:   Stanislav Goriainov <goriainov@ispras.ru>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Stanislav Goriainov <goriainov@ispras.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] objtool: Fix memory leak in create_static_call_section()
Date:   Wed, 27 Jul 2022 18:48:25 +0300
Message-Id: <20220727154825.3427-1-goriainov@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some paths of function create_static_call_section() the memory,
allocated for key_name via strdup(), is not freed. Even though this
is a utility function, and all memory will be freed automatically
after the process is finished, there is free(key_sym) in some cases,
so it would be sensible to always deallocate the memory.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1e7e47883830 ("x86/static_call: Add inline static call implementation for x86-64")
Signed-off-by: Stanislav Goriainov <goriainov@ispras.ru>
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b341f8a8c7c5..abbb3ab8b263 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -666,6 +666,7 @@ static int create_static_call_sections(struct objtool_file *file)
 		if (strncmp(key_name, STATIC_CALL_TRAMP_PREFIX_STR,
 			    STATIC_CALL_TRAMP_PREFIX_LEN)) {
 			WARN("static_call: trampoline name malformed: %s", key_name);
+			free(key_name);
 			return -1;
 		}
 		tmp = key_name + STATIC_CALL_TRAMP_PREFIX_LEN - STATIC_CALL_KEY_PREFIX_LEN;
@@ -675,6 +676,7 @@ static int create_static_call_sections(struct objtool_file *file)
 		if (!key_sym) {
 			if (!opts.module) {
 				WARN("static_call: can't find static_call_key symbol: %s", tmp);
+				free(key_name);
 				return -1;
 			}
 
-- 2.34.1

