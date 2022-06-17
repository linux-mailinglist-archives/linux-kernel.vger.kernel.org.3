Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DFF54FCCF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383457AbiFQSO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiFQSOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:14:55 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B194013FA4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 11:14:54 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id x21so718850uat.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 11:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sIEAK66uF4B5e7pJ+nU+n3T6LF4OnfLjyiO3Rsbq+aY=;
        b=qrEixrWbRWmJWXA1nsDRXFZdAjJ84cC1B/zdoUw6B93LbjqUSEHl/jWUe5uiYSO5jt
         vgJvW4XM1vvDWFqXRv/hQ5RS4+3uFVlM3iOUlBDkwWCRa3/qiAOn+q3wHQMH0V2VkhOx
         VYVH2wl+i6RnlS7bw3bQAr25YerYEyT5VQMEqPCAtSwlaxwDg/zyfrgrcUVKKipKejad
         vc9+jcTqy3uDXBvZK69oUCum7Vhtr8pCT04B55Fod9RrrMBHhH0WYkZqz90xgGcqGPdK
         1bKmH3IoUqwRSTSZLHMmZKqoBvkk7x6sySjpnIAVJWumEslZLoGz/L2rgyghatfxzfU2
         U4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sIEAK66uF4B5e7pJ+nU+n3T6LF4OnfLjyiO3Rsbq+aY=;
        b=aDvF78cDZIgcOz17iCI0ca681j1JNO1CVA4f2rDUXI4Ok/EC17gg7CbPdOnjZoSQQ5
         a4d5GU6rCkze9joGEKEp3bN3+HdJCg66O+RwDjQD10zUurKewTEfBja7h6adPkz4K89k
         bdHq/+3oUgxYhbC41wpDrS9k1Tq4Nsv3YlrN2KKomrYSQhMiqSJI4DQ7hlBdMXUIuYdS
         +HMhRVMaL5TKkTarOF1I+e3uJ23HLFQ5tOjfUgP6h7xZmN37tkEFk5/iI3H8Iaoyu7nT
         ZSc7Cue3otSgYYBLD/+BnJla3c8HXdBR1yzQ0DjVAnqjawWAAHCfjSJ75XD0qEMnPcHi
         EsZw==
X-Gm-Message-State: AJIora+9M7ywLqfh9n18fNUq8pmpqUu7/jOkI2fqkK6gPmO10X3JTszV
        AJgX0A8IwVPSa5pka/pTmp/Yydsxv7fAvvDRoWpsHA==
X-Google-Smtp-Source: AGRyM1tELyDu0ySYNUSlQ6O9dDzcNcsCCKWPYTlYCS5LfPjTM7ZqQ/s5TR8hBE8f3dM1Ccbkzzc2nVKEj2f4XNuyGQA=
X-Received: by 2002:ab0:2311:0:b0:37f:6d6:8822 with SMTP id
 a17-20020ab02311000000b0037f06d68822mr630437uao.20.1655489693605; Fri, 17 Jun
 2022 11:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220616195759.3214538-1-samitolvanen@google.com> <CAKwvOd=KWfNsUFcW4Enq5i94t0zyi7+C9p1-+QUP8+SvoHs=NA@mail.gmail.com>
In-Reply-To: <CAKwvOd=KWfNsUFcW4Enq5i94t0zyi7+C9p1-+QUP8+SvoHs=NA@mail.gmail.com>
From:   Ramji Jiyani <ramjiyani@google.com>
Date:   Fri, 17 Jun 2022 11:14:42 -0700
Message-ID: <CAKUd0B_2PcLW5Lj+4rG=AeVKBQx86x5bM2zL2YGORfKsk1EFyQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Ignore __this_module in gen_autoksyms.sh
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <alobakin@pm.me>,
        Steve Muckle <smuckle@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
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

On Fri, Jun 17, 2022 at 10:28 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> + Sedat
> Re: https://lore.kernel.org/linux-kbuild/CAKwvOdmb5xdF70TzNp=4STCpzkGh16FnuKE1KbdzDhHt=OuRFA@mail.gmail.com/
> In case this helps.
>
> + Ramji
> Ramji, it sounds like you helped test this downstream? If that's the
> case, mind supplying your tested-by tag for the record? Thanks for
> help verifying this change. Thanks too, Steve!
>
> On Thu, Jun 16, 2022 at 12:58 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > Module object files can contain an undefined reference to __this_module,
> > which isn't resolved until we link the final .ko. The kernel doesn't
> > export this symbol, so ignore it in gen_autoksyms.sh. This avoids an
> > unnecessary vmlinux rebuild with UNUSED_KSYMS_WHITELIST when we have a
> > symbol list that already contains all the module dependencies.
>
> Worth mentioning that this also fixes a significant build time
> regression made more painful by CONFIG_LTO_CLANG_FULL when using
> CONFIG_UNUSED_KSYMS_WHITELIST.
>

Yes, I tested it and it resolves the build time regression with modules.

Tested-by: Ramji Jiyani <ramjiyani@google.com>

Thanks,
Ramji

> Thanks for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  scripts/gen_autoksyms.sh | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/scripts/gen_autoksyms.sh b/scripts/gen_autoksyms.sh
> > index faacf7062122..653fadbad302 100755
> > --- a/scripts/gen_autoksyms.sh
> > +++ b/scripts/gen_autoksyms.sh
> > @@ -56,4 +56,7 @@ EOT
> >  # point addresses.
> >  sed -e 's/^\.//' |
> >  sort -u |
> > +# Ignore __this_module. It's not an exported symbol, and will be resolved
> > +# when the final .ko's are linked.
> > +grep -v '^__this_module$' |
> >  sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$output_file"
> > --
> > 2.36.1.476.g0c4daa206d-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
