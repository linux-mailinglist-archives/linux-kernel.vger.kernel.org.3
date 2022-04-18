Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CB0505CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346681AbiDRQzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346566AbiDRQyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B01D3388F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RiohTaoM29xhpBRMIpNDadunlIt2skg8irQpa7owkKw=;
        b=aVCKFaE8mj9GFl79pZvtIjY8NghgcTciwuY2+AbSYHChx51LZrOwgGjlrXfs5jEgoWRH8l
        r4F0HXnA8nxYwFhDchgckzwgHXpRFj9siv0ODj4/AlbNJH+6R36K1rVEiu5KUo8EpMZlEB
        lgB9OGZo8+l1WgsHjMRmRBEdkdTM0N4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-8KqqKwCSO1WZbMhyhHs26g-1; Mon, 18 Apr 2022 12:51:18 -0400
X-MC-Unique: 8KqqKwCSO1WZbMhyhHs26g-1
Received: by mail-qv1-f69.google.com with SMTP id m16-20020ad45050000000b00446393a7a9fso6789927qvq.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RiohTaoM29xhpBRMIpNDadunlIt2skg8irQpa7owkKw=;
        b=2QaaV7DQgVGCBTH1cpah/O/FXAp49Ym0qZNhNcUyiDhmINZByq6AVV7zDhMWpw8Zxg
         ziDehng+wHWPYEQJlgOuhhqObHLR1jOPKBh/szNMwy+EIw+Zb5MySDZNgCRoWiNmQkjX
         xKj7U9mcHq8iyz55ZnxYQIQ6q8dGxKJTUZ8zW67dCcyYyP13A1/3yajSvY/FGKFdW7wR
         IbMK3cb5uBMwnL6YY5GF3OJ4crrRlFarhFRCMwpgNTT+Il2EAWK4RsWDcvto92ULbuJc
         kLDc1eNX/y2JsV3Y0mFQqouooLKVZdy8B/cRLYCzZn4KtJsth4Q8inFYEtc6NVqeXmGb
         RnUg==
X-Gm-Message-State: AOAM531dmQPiJMIbabfzdsJv7UMGwUemsxmayA+Loy1P1JG1EHMiQOJ1
        ll+zTNn/CANgL20WLJw5BzataBxG4/L7utRErtaDjduBzDrC3Kd8f2WxjxBaQy735acsRssiDWU
        jIkkBzjwK5l3aEYfLfOlqGyY2
X-Received: by 2002:a05:620a:1a17:b0:69c:669c:1032 with SMTP id bk23-20020a05620a1a1700b0069c669c1032mr7128707qkb.377.1650300677045;
        Mon, 18 Apr 2022 09:51:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSYd5H7IJuluxq9Dum2Jr2Io19JEUswNf7XqXsEBL6n4fxPX1U+iUHwQkwFw/X6SextmnT3A==
X-Received: by 2002:a05:620a:1a17:b0:69c:669c:1032 with SMTP id bk23-20020a05620a1a1700b0069c669c1032mr7128698qkb.377.1650300676821;
        Mon, 18 Apr 2022 09:51:16 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:16 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 16/25] objtool: Extricate sls from stack validation
Date:   Mon, 18 Apr 2022 09:50:35 -0700
Message-Id: <2545c86ffa5f27497f0d0c542540ad4a4be3c5a5.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extricate sls functionality from validate_branch() so they can be
executed (or ported) independently from each other.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 56 +++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0059b592195e..88b527b3eb37 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3272,11 +3272,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		switch (insn->type) {
 
 		case INSN_RETURN:
-			if (opts.sls && !insn->retpoline_safe &&
-			    next_insn && next_insn->type != INSN_TRAP) {
-				WARN_FUNC("missing int3 after ret",
-					  insn->sec, insn->offset);
-			}
 			return validate_return(func, insn, &state);
 
 		case INSN_CALL:
@@ -3320,13 +3315,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_JUMP_DYNAMIC:
-			if (opts.sls && !insn->retpoline_safe &&
-			    next_insn && next_insn->type != INSN_TRAP) {
-				WARN_FUNC("missing int3 after indirect jump",
-					  insn->sec, insn->offset);
-			}
-
-			/* fallthrough */
 		case INSN_JUMP_DYNAMIC_CONDITIONAL:
 			if (is_sibling_call(insn)) {
 				ret = validate_sibling_call(file, insn, &state);
@@ -3846,6 +3834,41 @@ static int validate_ibt(struct objtool_file *file)
 	return warnings;
 }
 
+static int validate_sls(struct objtool_file *file)
+{
+	struct instruction *insn, *next_insn;
+	int warnings = 0;
+
+	for_each_insn(file, insn) {
+		next_insn = next_insn_same_sec(file, insn);
+
+		if (insn->retpoline_safe)
+			continue;
+
+		switch (insn->type) {
+		case INSN_RETURN:
+			if (!next_insn || next_insn->type != INSN_TRAP) {
+				WARN_FUNC("missing int3 after ret",
+					  insn->sec, insn->offset);
+				warnings++;
+			}
+
+			break;
+		case INSN_JUMP_DYNAMIC:
+			if (!next_insn || next_insn->type != INSN_TRAP) {
+				WARN_FUNC("missing int3 after indirect jump",
+					  insn->sec, insn->offset);
+				warnings++;
+			}
+			break;
+		default:
+			break;
+		}
+	}
+
+	return warnings;
+}
+
 static int validate_reachable_instructions(struct objtool_file *file)
 {
 	struct instruction *insn;
@@ -3914,7 +3937,7 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
-	if (opts.stackval || opts.orc || opts.uaccess || opts.sls) {
+	if (opts.stackval || opts.orc || opts.uaccess) {
 		ret = validate_functions(file);
 		if (ret < 0)
 			goto out;
@@ -3940,6 +3963,13 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
+	if (opts.sls) {
+		ret = validate_sls(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
+	}
+
 	ret = create_static_call_sections(file);
 	if (ret < 0)
 		goto out;
-- 
2.34.1

