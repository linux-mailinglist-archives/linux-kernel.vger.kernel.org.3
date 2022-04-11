Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56A44FC801
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 01:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiDKXN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 19:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiDKXNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 19:13:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5959D12ACD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649718664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qxd8LkJbqRmTlrpNwb0bYhE4UOJkR+dpIlYlWKMwvE=;
        b=Se0FeB65wqRD572r5aAdQMnP+R/q9sivkgbiGxzYc1zcI5R98uG95B5XZse+ZR7miD2/pt
        Uu+lGCVMi0IM0uGJ/Oq2V5V7zNr1Xi/FbOknsZt3JB13IxQmTktSDQxBLOoW9l88K9lLsB
        yqogFxa2jhSdmfDc1fu1zOG17pPNyGY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-E-tkDJwnNwyOklcKMgeH_A-1; Mon, 11 Apr 2022 19:11:03 -0400
X-MC-Unique: E-tkDJwnNwyOklcKMgeH_A-1
Received: by mail-qt1-f197.google.com with SMTP id bt12-20020ac8690c000000b002ee65af14d0so2814013qtb.22
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4qxd8LkJbqRmTlrpNwb0bYhE4UOJkR+dpIlYlWKMwvE=;
        b=33Y16/RbI0UFJZnG8Oe1dPTucuBL3ix4fJ1xiZfVkjZR9IO7Y9/oXhCsQMqoUwIgpj
         ms+jgDcIQC3uVqw+akugEtXDyDXf9Z3XM3qR6hW5ZtDio6yop8ORlH/zfShfXXYgh6mR
         5KLGDZ7VknesQ2dtXsDUsr2nDHy/3lM0YzWM/GCfqlrwQfVQGeRc98EVwhCtFY9Q5h7s
         t8AddfoFzV54z4VJacLMs9JskRdeJAhrsOcGnBK0CcrzlQl/uo2bq+C62wLFdte3tLbC
         1l5icVopP58mfmL/GmVxAbGgKoojGOJNyfY03RNd+ImuCFMeBJR9RFMTJhCneucxodU3
         3OzA==
X-Gm-Message-State: AOAM532G2ZjjLAfGX3ntC+N4hyv73H3VSZ8XiAVt9+5DrW+W3LsTsoFx
        65+UGdztMyPObUdrvovtlgoEyc1Ihq2nCi/Ga6IC++7jRzIRbFPFVAm+eDTj87IBEp2CIn8KJZh
        ByIo45+FECJTxUvyttWTkwoq/
X-Received: by 2002:a05:6214:c85:b0:441:2bb9:92fa with SMTP id r5-20020a0562140c8500b004412bb992famr28637612qvr.21.1649718662588;
        Mon, 11 Apr 2022 16:11:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy63Vwyu9MBCFvXLU0Sen/ZfLPul69mtbVqD6AuObTlGEj1Z+4I0OXSSDVjydPBmpXqzoz82w==
X-Received: by 2002:a05:6214:c85:b0:441:2bb9:92fa with SMTP id r5-20020a0562140c8500b004412bb992famr28637593qvr.21.1649718662285;
        Mon, 11 Apr 2022 16:11:02 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id c3-20020ac87d83000000b002e1d1b3df15sm27243500qtd.44.2022.04.11.16.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 16:11:01 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] objtool: Don't set 'jump_dest' for sibling calls
Date:   Mon, 11 Apr 2022 16:10:30 -0700
Message-Id: <8737d6b9d1691831aed73375f444f0f42da3e2c9.1649718562.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649718562.git.jpoimboe@redhat.com>
References: <cover.1649718562.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For most sibling calls, 'jump_dest' is NULL because objtool treats the
jump like a call and sets 'call_dest'.  But there are a few edge cases
where that's not true.  Make it consistent to avoid unexpected behavior.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bd0c2c828940..6f492789c8c0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1271,7 +1271,7 @@ static bool is_first_func_insn(struct objtool_file *file, struct instruction *in
  */
 static int add_jump_destinations(struct objtool_file *file)
 {
-	struct instruction *insn;
+	struct instruction *insn, *jump_dest;
 	struct reloc *reloc;
 	struct section *dest_sec;
 	unsigned long dest_off;
@@ -1291,7 +1291,10 @@ static int add_jump_destinations(struct objtool_file *file)
 			add_retpoline_call(file, insn);
 			continue;
 		} else if (insn->func) {
-			/* internal or external sibling call (with reloc) */
+			/*
+			 * External sibling call or internal sibling call with
+			 * STT_FUNC reloc.
+			 */
 			add_call_dest(file, insn, reloc->sym, true);
 			continue;
 		} else if (reloc->sym->sec->idx) {
@@ -1303,8 +1306,8 @@ static int add_jump_destinations(struct objtool_file *file)
 			continue;
 		}
 
-		insn->jump_dest = find_insn(file, dest_sec, dest_off);
-		if (!insn->jump_dest) {
+		jump_dest = find_insn(file, dest_sec, dest_off);
+		if (!jump_dest) {
 
 			/*
 			 * This is a special case where an alt instruction
@@ -1323,8 +1326,8 @@ static int add_jump_destinations(struct objtool_file *file)
 		/*
 		 * Cross-function jump.
 		 */
-		if (insn->func && insn->jump_dest->func &&
-		    insn->func != insn->jump_dest->func) {
+		if (insn->func && jump_dest->func &&
+		    insn->func != jump_dest->func) {
 
 			/*
 			 * For GCC 8+, create parent/child links for any cold
@@ -1342,16 +1345,22 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * subfunction is through a jump table.
 			 */
 			if (!strstr(insn->func->name, ".cold") &&
-			    strstr(insn->jump_dest->func->name, ".cold")) {
-				insn->func->cfunc = insn->jump_dest->func;
-				insn->jump_dest->func->pfunc = insn->func;
+			    strstr(jump_dest->func->name, ".cold")) {
+				insn->func->cfunc = jump_dest->func;
+				jump_dest->func->pfunc = insn->func;
 
-			} else if (!same_function(insn, insn->jump_dest) &&
-				   is_first_func_insn(file, insn->jump_dest)) {
-				/* internal sibling call (without reloc) */
-				add_call_dest(file, insn, insn->jump_dest->func, true);
+			} else if (!same_function(insn, jump_dest) &&
+				   is_first_func_insn(file, jump_dest)) {
+				/*
+				 * Internal sibling call without reloc or with
+				 * STT_SECTION reloc.
+				 */
+				add_call_dest(file, insn, jump_dest->func, true);
+				continue;
 			}
 		}
+
+		insn->jump_dest = jump_dest;
 	}
 
 	return 0;
-- 
2.34.1

