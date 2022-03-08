Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B94D0F2C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 06:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244055AbiCHF2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 00:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237923AbiCHF2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 00:28:01 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD6A3B57A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 21:27:05 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id z4so15460653pgh.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 21:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oPr7jbEQjZcFbPcnfK3KFYS7eLKVUp4KxioDBpQLsHE=;
        b=KFudWe1Vy5F9opv/soKhgh7FbpSJlX8UMUatuMgFRoPStXK8BeJYII3IzceeF4CUsE
         tbZtmjAemFX5zvbE6wUAsuHZbZjxHyMXZWeEZcotbpQPuVRvG0M7k6VpuXKY6pkei48H
         zXfV9NCW2jKEE17DZ9Ra4LgaKKzI3Af1gO2wcA7ElXQGZWb4NCyLsLzkpbYM8UT9vsEO
         pUu9p56Gp1SA3gnsGePgMqiQbP60EhVUK9DOvNBmk8vIgN7nMuOBxQ+IB8iUaUiYu2Qb
         2Pna2NPt9syIKgvHRHKvIJRPlI6Fu620/j9bCtoglu3IB7vYM/lS7I1CEm9Rb4f9/4gY
         lvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oPr7jbEQjZcFbPcnfK3KFYS7eLKVUp4KxioDBpQLsHE=;
        b=G8/ZQFPsHTNpKOtvdyOeUXFn9369UpcRjgDpg7QHJ8ilD3HJ02tW42+pqdom2if0p2
         fP5BbJ9A6JAEfQEu2BDJKO5J10iTEagO4aGIe8tuajB0sHndzWNQL9rz44iUoTrLsLho
         BrT74mRBLuUMJd9KApuWLxqn4hsSPJ+r+DkqmhGtvYDoVs3ey0ZoDlGAOuw50+p9x4C8
         X1K8GGl78itl61ffchrDsLY5vYi8lNqAJ1iFAq0bWcb4wiscb6hsp1SZRzh17C1dgYXj
         C1XDHSrb4YXCCK55+8XanJga+1EEN871gTm9AFu1MLGMPMW3pGSAgIf9bWu5cepBrsg6
         6IUw==
X-Gm-Message-State: AOAM532UCVPH/L3onbMVXBbyf82IzesimKHhXevtUOBfe+O/DFXcfA59
        M8hfpeFLSWh+AdwHE/ushNcmqQ==
X-Google-Smtp-Source: ABdhPJyH9JQVBjUGI9YE7QPYpbcBryWFyGEZ7zSUSAdXkhoivPgJwH+prK8BW8Uov0OvBfEDSxptFQ==
X-Received: by 2002:a63:d018:0:b0:374:a3c1:dfed with SMTP id z24-20020a63d018000000b00374a3c1dfedmr12888737pgf.155.1646717224619;
        Mon, 07 Mar 2022 21:27:04 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004e1414f0bb1sm18580376pfl.135.2022.03.07.21.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 21:27:04 -0800 (PST)
Date:   Tue, 8 Mar 2022 05:26:59 +0000
From:   Chun-Tse Shao <ctshao@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        keyrings@vger.kernel.org, DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4] config: Allow kernel installation packaging to
 override pkg-config
Message-ID: <YibpI1MkqVUvEl9h@google.com>
References: <20220306223016.2239094-1-ctshao@google.com>
 <CAKwvOdnmtRYnSx3VvG=PEnzpzWa8f=0bn1xDymjER5EShS2tmw@mail.gmail.com>
 <YiaMJCHOOuujHwiK@google.com>
 <CAK7LNAS-=Fne6fyiqzQ6DwNLOdF-HAY9Libn10uyV9GmQQMUKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAS-=Fne6fyiqzQ6DwNLOdF-HAY9Libn10uyV9GmQQMUKQ@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 01:01:45PM +0900, Masahiro Yamada wrote:
> On Tue, Mar 8, 2022 at 7:50 AM Chun-Tse Shao <ctshao@google.com> wrote:
> >
> > On Mon, Mar 07, 2022 at 10:17:17AM -0800, Nick Desaulniers wrote:
> > > On Sun, Mar 6, 2022 at 2:39 PM Chun-Tse Shao <ctshao@google.com> wrote:
> > > >
> > > > Add HOSTPKG_CONFIG to allow tooling that builds the kernel to override
> > > > what pkg-config and parameters are used.
> > >
> > > Sorry, kind a late thought here for v4, but we don't seem to prefix
> > > many other host side tools with HOST_, i.e. LEX, YACC, AWK, PERL,
> > > PYTHON3, etc.  Maybe just having the variable identifier be simply
> > > PKGCONFIG rather than HOSTPKG_CONFIG then put it at the end of the
> > > list in the top level Makefile after ZSTD (i.e. the list of host
> > > tools)?  There's HOST_ prefixes when there's more than one tool
> > > involved (i.e. host compiler vs target compiler), but I suspect
> > > there's no such distinction for the existing uses of pkg-config?
> > >
> > Thanks for your suggestion, Nick! Yes I think it makes sense with PKGCONFIG
> > instead of HOSTPKG_CONFIG since there is only one tool involved. I will
> > work on it and submit a new patch.
> >
>
> Please hold on.
>
> I was also wondering what to do with the "HOST" prefix.
>
> Libraries are usually arch-dependent.
> (in other words, pkg-config should return different library paths
> for $(CC) and $(HOSTCC) )
>
> You already understood this, so you added "HOST" prefix.
>
>
> Please let me take time for further discussion.
> I will come back to this when I get some time.
>
>
> In the meantime,
>   a8a5cd8b472ca20e5b8fa649c43b3756867322f8
> as reference info if you have not seen it.
>
>
> How many distros support something like
> "aarch64-linux-gnu-pkg-config"  ?
>
> Ubuntu 18.04 and 20.04 seem to support it.
> I do not know for others.
>
>
>
>
>
> --
> Best Regards
>
> Masahiro Yamada

Thanks Masahiro! Will wait for your suggestion.

-CT
