Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECAA4FC803
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 01:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiDKXNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 19:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiDKXNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 19:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 394891D309
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649718667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zufRQemY0tMoebS+JfwFg0YIcxjRVmfAUD4mEizZNlQ=;
        b=HpxB/47uPNBhYAJSMQ50n+0rE6T9IA15C9biVB/BuhzZbkFAfUvX1rlVVYBFbOkYB+XziX
        1EIVsxtTFX2DGM+lf0M2M4JY5x9UxKDE79aRhcnkjaYgdhTzUZ9WEYeCPc5dDGlKcdhPBH
        qAhalL1Som9zJIQ6kPFOVGFSY8WmaVQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-uKoFZ2jCN8qEWiLK1GVCEg-1; Mon, 11 Apr 2022 19:11:06 -0400
X-MC-Unique: uKoFZ2jCN8qEWiLK1GVCEg-1
Received: by mail-qt1-f199.google.com with SMTP id a24-20020ac81098000000b002e1e06a72aeso13690850qtj.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zufRQemY0tMoebS+JfwFg0YIcxjRVmfAUD4mEizZNlQ=;
        b=UbA/9yBoXoZfPoxRiCZSTyaHawaCxShnJLvOdPB4PxD86wVssMbKVVahspM6Q9gZHd
         2NOyuPZJ4hRJ2sb5mG23g1mSg3ZQ7T/l0cUMpZVUsqfW/BpepMUMxiOft391mKTyVqYn
         qKre6D+qJ8xOC/ZSe3FfP/OxR8MiLAKcNzmsfpcth/0hRHSpZMZJAg0MF4H3AKYb/3Q+
         Sp57QuyWZimFcM+X871QdKC0U/za+FBBb+RTAEPs+1y0dwsIqZMmPTb5Vb9taTeygAD3
         NyvpJxgTJk/buzJ8BJl3krgtteS1UADnL99fSqqWTOwKXbnAsNXQu3jriT277MPwKIwR
         r4Rw==
X-Gm-Message-State: AOAM5300oAGKmFXjE8KltE7ckEf8h5g5K2L6Xf2RJ/1arkGTEoAARFGt
        +X74omMm2Z9SLbGX9bTHKiUG+KgA0dNCq9IJsJVZKsyji3OF9aUbsGXKjpxoHzR7qm5s9CBO3T6
        e5S0HMuGvcrQupa3q/+l7VBtV
X-Received: by 2002:a05:622a:1990:b0:2e1:a7bf:9222 with SMTP id u16-20020a05622a199000b002e1a7bf9222mr1349199qtc.230.1649718665431;
        Mon, 11 Apr 2022 16:11:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOChGI1LFSjIQBIXC7Y4dhktK0iomYjZxyQ1lT6EauFoXAynzxuFpju/Kdc7JhFpP3U56Naw==
X-Received: by 2002:a05:622a:1990:b0:2e1:a7bf:9222 with SMTP id u16-20020a05622a199000b002e1a7bf9222mr1349187qtc.230.1649718665180;
        Mon, 11 Apr 2022 16:11:05 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id c3-20020ac87d83000000b002e1d1b3df15sm27243500qtd.44.2022.04.11.16.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 16:11:04 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] objtool: Fix function fallthrough detection for vmlinux
Date:   Mon, 11 Apr 2022 16:10:32 -0700
Message-Id: <b434cff98eca3a60dcc64c620d7d5d405a0f441c.1649718562.git.jpoimboe@redhat.com>
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

Objtool's function fallthrough detection only works on C objects.
The distinction between C and assembly objects no longer makes sense
with objtool running on vmlinux.o.

Now that copy_user_64.S has been fixed up, and an objtool sibling call
detection bug has been fixed, the asm code is in "compliance" and this
hack is no longer needed.  Remove it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c                   | 2 +-
 tools/objtool/include/objtool/objtool.h | 2 +-
 tools/objtool/objtool.c                 | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0f5d3de30e0d..5f10653eb5c2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3310,7 +3310,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 	while (1) {
 		next_insn = next_insn_to_validate(file, insn);
 
-		if (file->c_file && func && insn->func && func != insn->func->pfunc) {
+		if (func && insn->func && func != insn->func->pfunc) {
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn->func->name);
 			return 1;
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
index 7a5c13a78f87..a6e72d916807 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -27,7 +27,7 @@ struct objtool_file {
 	struct list_head static_call_list;
 	struct list_head mcount_loc_list;
 	struct list_head endbr_list;
-	bool ignore_unreachables, c_file, hints, rodata;
+	bool ignore_unreachables, hints, rodata;
 
 	unsigned int nr_endbr;
 	unsigned int nr_endbr_int;
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index b09946f4e1d6..843ff3c2f28e 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -129,7 +129,6 @@ struct objtool_file *objtool_open_read(const char *_objname)
 	INIT_LIST_HEAD(&file.static_call_list);
 	INIT_LIST_HEAD(&file.mcount_loc_list);
 	INIT_LIST_HEAD(&file.endbr_list);
-	file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
 
-- 
2.34.1

