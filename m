Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4908E4B36DE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 18:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiBLRue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 12:50:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiBLRud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 12:50:33 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A602FFCC
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 09:50:29 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso14918731pjt.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 09:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Svf95FOeL5J7/saoJgddlt8a+RbWE9cYMRDS2l9fhxQ=;
        b=JljpsMSgafZOIqYfyKNYJptOXWZrX3r1UV77+BIJqkOW8szOYPMGG7CCQBHk2gsTGC
         iCtw9Gr6s/rHaZgdOYFXL60wt+rS0E9oW1r5/7jdXPoqKzvbTO5sxLH90p/vUIHiBO6L
         xEDGd1k3vT9dWpuzsxWlvx4o+Xz68lqFjeTno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Svf95FOeL5J7/saoJgddlt8a+RbWE9cYMRDS2l9fhxQ=;
        b=dK+Pd/Hgwru9jz4eIVSk/Eg3kag6vE2iCe4z1P7+eseh19XRrKDCBIOVZMKB3Gd7Kw
         TMGjsCl40uHyMaB7una+GL+71ENM61RWg25MVXfVttd+QxVmi5FK+vVuEjoa6IcpzocL
         g4kYqAQ4i6iBBNdKuj8/3eI4K1SrnIoWHnw/Z2AVuYtT8KXzRoEAZgV6LNZtLHfPysrR
         jaZWxeTQGSzBR1+9LsUuFATZVRaGGO2Nu8s1s6SjyT7qEfppwUBGECrCg/o+6v0XBY3k
         t1IEyyT5OlOrmgm3joY1y/62SvPa6NeNQmpwJzsj1UY5wWrRxWpH4tqGs7ohGWCZxsVK
         us0w==
X-Gm-Message-State: AOAM531ZszEInLct3B7QrsR1P7edEg+MRNbpTvtPcTYDQ8DxUeMTTGyN
        NjwSfo+idYO3aoVmeWMnYmZ9XASCHEoAiA==
X-Google-Smtp-Source: ABdhPJzxRSTNoySb5tCsxOJ3Lrh+mKwfxRwF0mclqLCiQvDl89uY1shiClJLdMC1/uEBERr5n5eKIA==
X-Received: by 2002:a17:90b:3508:: with SMTP id ls8mr3647810pjb.224.1644688229050;
        Sat, 12 Feb 2022 09:50:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mu18sm9356244pjb.18.2022.02.12.09.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 09:50:28 -0800 (PST)
Date:   Sat, 12 Feb 2022 09:50:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Justin Forbes <jmforbes@linuxtx.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-next 20220125 - build failure in objtool with gcc 12
Message-ID: <202202120949.A85C37491@keescook>
References: <20494.1643237814@turing-police>
 <CAFxkdAoe8XO4ivDpvfP8PTPpuew7k5Ngar3Ua9KhwTq32zdEQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFxkdAoe8XO4ivDpvfP8PTPpuew7k5Ngar3Ua9KhwTq32zdEQg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:34:34AM -0600, Justin Forbes wrote:
> On Wed, Jan 26, 2022 at 4:57 PM Valdis Klētnieks
> <valdis.kletnieks@vt.edu> wrote:
> >
> > Fedora Rawhide shipped gcc12, which apparently includes a new warning that
> > causes a build failure.  Apparently, it's unable to figure out that 'ptr' remains
> > valid on failed realloc(), and we only call realloc() again on failures...
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104069 explains (toward
> the end) why gcc is leaving it to be fixed in the kernel.

Yeah, I agree -- it can trigger a free(). I think the solution should
be:

diff --git a/tools/lib/subcmd/subcmd-util.h b/tools/lib/subcmd/subcmd-util.h
index 794a375dad36..de392fc5fd3a 100644
--- a/tools/lib/subcmd/subcmd-util.h
+++ b/tools/lib/subcmd/subcmd-util.h
@@ -49,15 +49,24 @@ static NORETURN inline void die(const char *err, ...)
 
 static inline void *xrealloc(void *ptr, size_t size)
 {
-	void *ret = realloc(ptr, size);
-	if (!ret && !size)
-		ret = realloc(ptr, 1);
+	void *ret;
+
+	/*
+	 * Convert a zero-sized allocation into 1 byte, since
+	 * realloc(ptr, 0) means free(ptr), but we don't want
+	 * to release the memory. For a new allocation (when
+	 * ptr == NULL), avoid triggering NULL-checking error
+	 * conditions for zero-sized allocations.
+	 */
+	if (!size)
+		size = 1;
+	ret = realloc(ptr, size);
 	if (!ret) {
-		ret = realloc(ptr, size);
-		if (!ret && !size)
-			ret = realloc(ptr, 1);
-		if (!ret)
-			die("Out of memory, realloc failed");
+		/*
+		 * If realloc() fails, the original block is left untouched;
+		 * it is not freed or moved.
+		 */
+		die("Out of memory, realloc failed");
 	}
 	return ret;
 }

> 
> 
> >   CC      /usr/src/linux-next/tools/objtool/exec-cmd.o
> >   CC      /usr/src/linux-next/tools/objtool/help.o
> > In file included from help.c:12:
> > In function 'xrealloc',
> >     inlined from 'add_cmdname' at help.c:24:2:
> > subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
> >    56 |                 ret = realloc(ptr, size);
> >       |                       ^~~~~~~~~~~~~~~~~~
> > subcmd-util.h:52:21: note: call to 'realloc' here
> >    52 |         void *ret = realloc(ptr, size);
> >       |                     ^~~~~~~~~~~~~~~~~~
> > subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
> >    58 |                         ret = realloc(ptr, 1);
> >       |                               ^~~~~~~~~~~~~~~
> > subcmd-util.h:52:21: note: call to 'realloc' here
> >    52 |         void *ret = realloc(ptr, size);
> >       |                     ^~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make[4]: *** [/usr/src/linux-next/tools/build/Makefile.build:97: /usr/src/linux-next/tools/objtool/help.o] Error 1
> > make[3]: *** [Makefile:59: /usr/src/linux-next/tools/objtool/libsubcmd-in.o] Error 2
> > make[2]: *** [Makefile:63: /usr/src/linux-next/tools/objtool/libsubcmd.a] Error 2
> > make[1]: *** [Makefile:69: objtool] Error 2
> > make: *** [Makefile:1405: tools/objtool] Error 2

-- 
Kees Cook
