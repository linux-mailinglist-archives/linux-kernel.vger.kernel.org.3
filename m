Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F80505CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346633AbiDRQyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346522AbiDRQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D6DF33366
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Z+DKCRf8I0VDKhczbT7dFWZdHYvbA+t2UZbUuCO6Ts=;
        b=UyhO7NiyibcT3cmH82cTUJf9Mf8EPjMYuDN3X9KEF4rv134gSVoow15I6nmwllzkXdoYv5
        iYAfTTkiPXqu/lDy1OtOaCRUYkjlP5ys5jyF2jO3UkbehOdJ/l2Iv2MKkrXB2VecLXV6NN
        nGdfq2LKkGFeXbm3x8J7+t1l4ZJYPgs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-ihUzUyyoO-uMBgaYwYy8MA-1; Mon, 18 Apr 2022 12:51:09 -0400
X-MC-Unique: ihUzUyyoO-uMBgaYwYy8MA-1
Received: by mail-qk1-f199.google.com with SMTP id m23-20020a05620a221700b006809e1fa4fdso10733423qkh.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Z+DKCRf8I0VDKhczbT7dFWZdHYvbA+t2UZbUuCO6Ts=;
        b=qfreXPYYBUCoInA6BVkTsQ901UJ+65Jg995uDeE67XEaIiVG057EYL5WFj6hqepdwZ
         2alS7Ges3Vu9vI5QtUDXpGf/gYQPyfFyiSIOa8D50dIfWXiVEsXp/BZZmgGkStpCiBXc
         7x7nm3Ht8Qp7/vE0Z3jCt+4IFCecOSQ7lI3XIQ2x7yV6maDVjcT9IxY46224KdjJRiqj
         DnlgDExcey0thYajgVhVU4chv0Qa/Ka3ZxKF4hnZkPWFCTEYp9WY8WqXHUj9WId6+x3c
         nMY/jiqiTQwfZnN/PVqcOOeLiIuUjxbX5Ffr1FN+7RCZ/UqzKeEnawLWiQlY3LGZ/kEJ
         caPA==
X-Gm-Message-State: AOAM531xrjDR/2UF3bmnxOmPl9Y8qfVglW5l4SySZR45hO8uyxdf11j1
        AsKUI5WsesyEWq8AWqmRvS+7OquReVBU3QnVrSyU25yCuxv+R+AYw3BcspsOIoc+NXK73csUsk4
        kIxxrpIRjTu5bL2GqbC/GNwyq
X-Received: by 2002:a05:6214:5189:b0:446:5077:7f75 with SMTP id kl9-20020a056214518900b0044650777f75mr6152349qvb.37.1650300669303;
        Mon, 18 Apr 2022 09:51:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAY8Sj56hJ4OUrUe7do9WO80TQYnEhocgTEB6pUtL57k2idWMkKrSsRT1InFO4PNiKSRCiLQ==
X-Received: by 2002:a05:6214:5189:b0:446:5077:7f75 with SMTP id kl9-20020a056214518900b0044650777f75mr6152339qvb.37.1650300669049;
        Mon, 18 Apr 2022 09:51:09 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:08 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 11/25] objtool: Use offstr() to print address of missing ENDBR
Date:   Mon, 18 Apr 2022 09:50:30 -0700
Message-Id: <95d12e800c736a3f7d08d61dabb760b2d5251a8e.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 97026c1b4bd6..49d5f0986a52 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3219,9 +3219,8 @@ validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
 static void warn_noendbr(const char *msg, struct section *sec, unsigned long offset,
 			 struct instruction *dest)
 {
-	WARN_FUNC("%srelocation to !ENDBR: %s+0x%lx", sec, offset, msg,
-		  dest->func ? dest->func->name : dest->sec->name,
-		  dest->func ? dest->offset - dest->func->offset : dest->offset);
+	WARN_FUNC("%srelocation to !ENDBR: %s", sec, offset, msg,
+		  offstr(dest->sec, dest->offset));
 }
 
 static void validate_ibt_dest(struct objtool_file *file, struct instruction *insn,
-- 
2.34.1

