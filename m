Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9444EDFAC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiCaRdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiCaRdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:33:04 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0325E14E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:31:16 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b43so683540ljr.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37DeCDWlzdqkrXbAxfAuhXVMiTsGHz0hz+oO3LlsSAk=;
        b=OpXbfuoWXGtoVCxlYREjKa12nC/ZS5c6WIcrnkI8eccbmu5/uLBWGYimttqpYS8VW3
         +7YGiaqEFrS3FpnuX2EDtUfr5SLVwwJS16vOz9O1xs7VQoRsqwXQVyTm2DHS+HBbUKJW
         JcnKmGiKnrrFpcQsKy0swpAqSluMvhVusfDjp7x4US+WiiiWR7htYGSSYN9BMjK+PNzB
         3bDKkdDzBq8iD1v2ploXFNsOGBgurGnmJmFODojEuOx7h5IJv9a3ZyGps5XW+zm3ZwP3
         IyNp8IubOAJdKp98Y8byqVMwum46U2PVLc0kWpI3Dx2X+rTq5WlWvdzZTZ10/09brYbh
         5/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37DeCDWlzdqkrXbAxfAuhXVMiTsGHz0hz+oO3LlsSAk=;
        b=arJf+iIc6g6pzu/LR24x0Dk3HYn+N3yRqttxPWVO0AOQzaO4RRmpLZJEPWRubvvqIW
         Vj5Hfqm6Z11G/Ih2fWhikjsBlxgZIpa1s7I3W2OLAehNr8+Y7lS1Hpigj16q5okGuk8J
         sD/ak0JehM96SlYAnLJK03APwvKNHjIFdm7EI0UcA+uY9MWlIoBjamKreKAcfX+Nknmt
         6c4Utxpgr6X82ShVSHRZntZi3Jf5dM/CsFNlig/v46WGOjjBnO4c2YyxVj8cIQQTT4jP
         PaYmXS8BVKhPZ/jpVtVRxXC+AT7cUoEPj7G18ertqn5/Z8eG1tl8wfbXGs/CZqmr9o8C
         wLgQ==
X-Gm-Message-State: AOAM532GLWcMuaQpDXUyIct1yiUzYqCzyKlshQ+/sZxps2zxwvx4bI1g
        LO87SAe9qAIEg29+fbpMYgGJFAhrGA6LM9xm1c9SaRwF97GJwQ==
X-Google-Smtp-Source: ABdhPJyIrADojlxnjoJbjHABCl+RY1oRMepIxM5nb9mo2vXqxPk9ksIqJg+9gS8ogRsiwQgdyPv54GWhmXZP85nX5oI=
X-Received: by 2002:a05:651c:1508:b0:249:b843:208f with SMTP id
 e8-20020a05651c150800b00249b843208fmr11115015ljf.239.1648747874376; Thu, 31
 Mar 2022 10:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <164847778869.3060675.8115416881394543419.stgit@devnote2>
 <CAKwvOdmAYQZtzGudBjmiRZNjT+VixTdNbJmYmxc7-gQNCsHfrA@mail.gmail.com> <20220331104531.81d0edf9a85a4f69020a9f13@kernel.org>
In-Reply-To: <20220331104531.81d0edf9a85a4f69020a9f13@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 31 Mar 2022 10:31:02 -0700
Message-ID: <CAKwvOdmbMPBOGvcZNURK6qMx8gm7dGFiWmtX_yXheEqQ8CNLsA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] bootconfig: Support embedding a bootconfig in
 kernel for non initrd boot
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 6:45 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Nick,
>
> On Wed, 30 Mar 2022 11:04:50 -0700
> Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> >
> > Any chance we can use
> >
> > CFLAGS_REMOVE_<file>.o := $(CC_FLAGS_LTO)
> >
> > a la
> > commit d2dcd3e37475 ("x86, cpu: disable LTO for cpu.c")
>
> Hm, this looks good to me. Let me confirm that works.
> (Does this mean the bootconfig.o will be compiled to elf binary?)

I know we went with Masahiro's suggestion, which is clever and better,
but to answer this question; yes, under LTO, the linker can link
together inputs that are a mix of ELF object files (basically, no LTO
optimizations) with LLVM IR (w/ LTO optimizations between such files).
-- 
Thanks,
~Nick Desaulniers
