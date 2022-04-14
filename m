Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CE35019AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiDNRKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347133AbiDNRKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D91B369CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649955666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4B1/0zprUHgX3VT2zhq8T9uZ6S7ysF6md7j6hbXhF8M=;
        b=Dw8CGa7CTv/3Ef6SYfSLyXxUsgoMcd71MDuwZ25MRN64AwYw68kn7Gt+IO29YEAmKdePQZ
        xbUpREuh0aIdKBbYc0FNz2fOb5H1/z8DgE/rK0RfLu7DQghNKHputl1gS+iseLv2DUNHmA
        1nHEtOCNHDc3I9YDYnJzSE9rtlKojFU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-7TlB9aR2OnCUYblOC-sKWQ-1; Thu, 14 Apr 2022 13:01:05 -0400
X-MC-Unique: 7TlB9aR2OnCUYblOC-sKWQ-1
Received: by mail-qk1-f199.google.com with SMTP id u7-20020ae9d807000000b00680a8111ef6so3649504qkf.17
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4B1/0zprUHgX3VT2zhq8T9uZ6S7ysF6md7j6hbXhF8M=;
        b=KC525HSATLW7T5OKD/oAR9TSyXBS+lqv8TH/7nW6lMaVkrcJmOQXVOVs/Oe5f3Wyq/
         FxtFCk6WQoWaxe1MAgd7vtbevcQVO4t1WdVAHuIiakd2Ipdnjf9xJ0Ka6Qeomgf7rh20
         bIH0P5apCzN6aSXVOVJpOTDRGuce1vfkTYb2DTqGTxdlotpXvEHiZEOo2c70Bxy/rNxg
         sptAhn8cSK/TstXx4ZeoORQik+VM3+KVqSNi+FlRfLMYdfTk3vUZei2L6MFbSPlwCX1K
         Nyj4uY2cT2LU0mSEPdLB4+1MtZs736fgyKMEUMuMZu8qcslt1RNpBra1bip8Wogrj6WD
         6rZA==
X-Gm-Message-State: AOAM531dprcAdQLtqS/TNWQzrIyDvvtVIsep+OdG73hPRzzMIiuvhf7o
        ZHzhfpdL49d4LieZRiks95s5T+M6nr4tgILHwp9NQfzXsLf8atuDPtgA43oFQaPelgbunR66pfH
        6eXR3ljgaqTTEEhq4yBqwtK1L
X-Received: by 2002:a05:620a:1903:b0:67d:243b:a8ae with SMTP id bj3-20020a05620a190300b0067d243ba8aemr2608417qkb.142.1649955664664;
        Thu, 14 Apr 2022 10:01:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPWnG9sKZnoc4ROrcDaT5+CKtcHx0u44tTJaHAF47tvPdCZfGyVldRbmpYGKCc/3kyEjM3kQ==
X-Received: by 2002:a05:620a:1903:b0:67d:243b:a8ae with SMTP id bj3-20020a05620a190300b0067d243ba8aemr2608377qkb.142.1649955664121;
        Thu, 14 Apr 2022 10:01:04 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id c3-20020ac87d83000000b002e1d1b3df15sm1459694qtd.44.2022.04.14.10.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 10:01:03 -0700 (PDT)
Date:   Thu, 14 Apr 2022 10:01:00 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 02/18] objtool: Support data symbol printing
Message-ID: <20220414170100.c66rfyvk7dp33bxx@treble>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <097057f88605aa67b0e3ec573fcf394ae7ac4d6f.1649891421.git.jpoimboe@redhat.com>
 <YlfHy011VP2oPFjV@hirez.programming.kicks-ass.net>
 <20220414152148.cwdefx744kymqcut@treble>
 <Ylg+bewBpaqqYgeB@hirez.programming.kicks-ass.net>
 <20220414153854.rqkt465xn4vzndr7@treble>
 <YlhNo026PgjJuCIU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlhNo026PgjJuCIU@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 06:36:51PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 14, 2022 at 08:38:54AM -0700, Josh Poimboeuf wrote:
> 
> > > Yes, I'd not seen that yet, what's that for? The Changelog alludes to
> > > something, but I don't think it actually does get used later.
> > 
> > Nick had asked for something like that, it's just a way to avoid doing
> > math every time we look at a warning, i.e. to convert func+offset to
> > sec+offset.
> > 
> > But it's kind of ugly and I'm not 100% happy with it.
> > 
> > Maybe it should be behind an option (--sec-offsets)?
> 
> Can do I suppose... Myself, I have this script:
> 
> $ cat objdump-func.sh
> #!/bin/bash
> 
> OBJ=$1; shift
> FUNC=$1; shift
> 
> objdump -wdr $@ $OBJ | awk "/^\$/ { P=0; } /$FUNC[^>]*>:\$/ { P=1; O=strtonum(\"0x\" \$1); } { if (P) { o=strtonum(\"0x\" \$1); printf(\"%04x \", o-O); print \$0; } }"

That is nice, just added to my ~/bin.

And how am I just learning about objdump "-w" ?!?!

I wrote up a new version of that patch which adds a '--sec-address'
option (see below), but maybe I'll just drop it for now.  It's not
really relevant to this set anyway.


From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] objtool: Add option to print section addresses

To help prevent objtool users from having to do math, add an option to
print the section address in addition to the function address.

Normal:

  vmlinux.o: warning: objtool: fixup_exception()+0x2d1: unreachable instruction

With '--sec-address':

  vmlinux.o: warning: objtool: fixup_exception()+0x2d1 (.text+0x76c51): unreachable instruction

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/builtin-check.c           |  1 +
 tools/objtool/include/objtool/builtin.h |  1 +
 tools/objtool/include/objtool/warn.h    | 31 ++++++++++++++-----------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 3df46e9b4b03..2c562e3dec55 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -55,6 +55,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN(0, "module", &opts.module, "object is part of a kernel module"),
 	OPT_BOOLEAN(0, "no-fp", &opts.no_fp, "skip frame pointer validation"),
 	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
+	OPT_BOOLEAN(0, "sec-address", &opts.sec_address, "print section addresses in warnings"),
 	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
 	OPT_BOOLEAN(0, "vmlinux", &opts.vmlinux, "vmlinux.o validation"),
 
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 0cac9bd6a97f..e6910a66317a 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -33,6 +33,7 @@ struct opts {
 	bool module;
 	bool no_fp;
 	bool no_unreachable;
+	bool sec_address;
 	bool stats;
 	bool vmlinux;
 };
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index c4bde3e2a79c..a3e79ae75f2e 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -11,30 +11,33 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <objtool/builtin.h>
 #include <objtool/elf.h>
 
 extern const char *objname;
 
 static inline char *offstr(struct section *sec, unsigned long offset)
 {
-	struct symbol *func;
-	char *name, *str;
-	unsigned long name_off;
+	bool is_text = (sec->sh.sh_flags & SHF_EXECINSTR);
+	struct symbol *sym = NULL;
+	char *str;
+	int len;
 
-	func = find_func_containing(sec, offset);
-	if (!func)
-		func = find_symbol_containing(sec, offset);
-	if (func) {
-		name = func->name;
-		name_off = offset - func->offset;
+	if (is_text)
+		sym = find_func_containing(sec, offset);
+	if (!sym)
+		sym = find_symbol_containing(sec, offset);
+
+	if (sym) {
+		str = malloc(strlen(sym->name) + strlen(sec->name) + 40);
+		len = sprintf(str, "%s+0x%lx", sym->name, offset - sym->offset);
+		if (opts.sec_address)
+			sprintf(str+len, " (%s+0x%lx)", sec->name, offset);
 	} else {
-		name = sec->name;
-		name_off = offset;
+		str = malloc(strlen(sec->name) + 20);
+		sprintf(str, "%s+0x%lx", sec->name, offset);
 	}
 
-	str = malloc(strlen(name) + 20);
-	sprintf(str, "%s+0x%lx", name, name_off);
-
 	return str;
 }
 
-- 
2.34.1

