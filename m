Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E03580287
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbiGYQT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiGYQT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:19:57 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F84D1571E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:19:56 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10d6ddda695so15446270fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hQLvXyUca7YvppsQ/RG7x1mMXVBl9JH0uYVjO129EoI=;
        b=OAhRwqf49aOSneQbfVf4I4qLvceeO8M/evD/LZwSLYqvW7B8dQbWJuIW0uN1KnpNSv
         YI65tmA6muuzZBc1yyFTBAEBnQEmgV8HPXaBQLJENARqrkKEB2MwVDXOpSb1TLlK0dxt
         Sd5wV95AtNOPyeaWSD/x/gI+KkdHGSwUJo6fJ1b5D758/4ImHz0V/2q2ABuMnVxvLbSB
         3jIJcflF6sHkNRLCJ4RkITNR2Nmlq7edFEgMTDx0ho6wFQiEYNXdKOtdkmFw8R6wjF6N
         Q1ZrEO+0WXjfYTfs0iy8D607f994GEMYE6iPUrKJV8Nr6ije8cWuNBAFDk/ZF8Gq2fiH
         GTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQLvXyUca7YvppsQ/RG7x1mMXVBl9JH0uYVjO129EoI=;
        b=Egs+LxYslazqmJtnAI264ECnG7eiTeJvjJY2Lc0xtSmTECEUsq+9juvvtivzJVEtSy
         JSaCvT3oGiKhXXWDS82osw/zpILe6tREC8MFXJxosPPYjTmCrHWfon82taaejTt0fgue
         iQeI5WWR592Q7s/lo8l/J1d++TaM9Ye+CG5+eUespDCZSG4mnAkeLF1PFmxhXBubWYJK
         GYS8xIdnxUuGp2l161cbYo1RE6Npd7tzIeRmldJH9qZImKj1jMDq9WkzdffHxa4ZZqAy
         //Lo8oi51ajb0ViyYKIqrlrRZj0QfM4QOQyv3r65WQHg/h4AV8dzy8LdnRfjXJtmolfS
         za/Q==
X-Gm-Message-State: AJIora+Mos54I0BNiogD4QY2Sv1eRfScgEZbo2f731L4WXqYRwyaPVBQ
        sGTQB/Whdxj431VqazvQMQ74ifqig+4=
X-Google-Smtp-Source: AGRyM1tGqTo6breYBO+En54ubKvhgYAREFdPuBVzxVyJ2WucLxqD42sP2P5+1LvQ0LVDquW+hG+ccQ==
X-Received: by 2002:a05:6870:5aa:b0:10d:7d87:25b5 with SMTP id m42-20020a05687005aa00b0010d7d8725b5mr6679486oap.268.1658765994625;
        Mon, 25 Jul 2022 09:19:54 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id b20-20020a056870471400b001048f70e03dsm6264385oaq.15.2022.07.25.09.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 09:19:54 -0700 (PDT)
Date:   Mon, 25 Jul 2022 09:17:42 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/2] powerpc: drop dependency on <asm/machdep.h> in
 archrandom.h
Message-ID: <Yt7CJj8r3eo05pKd@yury-laptop>
References: <20220723214537.2054208-1-yury.norov@gmail.com>
 <20220723214537.2054208-2-yury.norov@gmail.com>
 <CAHp75VfOmN=cTEs7gbwxZ7W3hXjBo67N4AmHHiDfcVfFzHkMLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfOmN=cTEs7gbwxZ7W3hXjBo67N4AmHHiDfcVfFzHkMLA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 09:28:12AM +0200, Andy Shevchenko wrote:
> On Sun, Jul 24, 2022 at 12:19 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > archrandom.h includes <asm/machdep.h> to refer ppc_md. This causes
> > circular header dependency, if generic nodemask.h  includes random.h:
> >
> > In file included from include/linux/cred.h:16,
> >                  from include/linux/seq_file.h:13,
> >                  from arch/powerpc/include/asm/machdep.h:6,
> >                  from arch/powerpc/include/asm/archrandom.h:5,
> >                  from include/linux/random.h:109,
> >                  from include/linux/nodemask.h:97,
> >                  from include/linux/list_lru.h:12,
> >                  from include/linux/fs.h:13,
> >                  from include/linux/compat.h:17,
> >                  from arch/powerpc/kernel/asm-offsets.c:12:
> > include/linux/sched.h:1203:9: error: unknown type name 'nodemask_t'
> >  1203 |         nodemask_t                      mems_allowed;
> >       |         ^~~~~~~~~~
> >
> > Fix it by removing <asm/machdep.h> dependency from archrandom.h
> 
> ...
> 
> >  EXPORT_SYMBOL_GPL(pm_power_off);
> 
> ^^^ (Note this and read below)
> 
> ...
> 
> > +EXPORT_SYMBOL(arch_get_random_seed_long);
> 
> It can't be like this. Brief browsing of the callees shows that.

Is my understanding correct that you're suggesting to make it GPL?

ppc_md is exported with EXPORT_SYMBOL(), and the function is in header,
so it's available for non-GPL code now. I don't want to change it.
