Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5891588A21
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbiHCKGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiHCKGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:06:49 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4D664C6;
        Wed,  3 Aug 2022 03:06:47 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 273A6Sxb016646;
        Wed, 3 Aug 2022 19:06:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 273A6Sxb016646
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659521189;
        bh=wmOcErEdU+TDtdRRUU4DWlVjpGfT3KCiEB6lg4A7q+8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nzVEfTvVC4k0SeABNbuU4Xy0ENX70LuhMNqIoWlX2awwFzgEdhNzGsI33Ulmtp31w
         orl2KKEzeKkuZusLBa0lBlkxqpGnO32u5af5Dpdf6Q8FSntELV1EWNlIUfSGt7AAam
         2eRE+7DicEYeq2IpYDPCrtK+Pin5fXmfplLOleU8HarlDEuzOg3lB6gaw+oa/xRlKt
         /+MbQabuR9+CZceZF7IEHEP+wCwDmDUB0Fe7FMnrtN298BRTpXM9v1YU5csD06zhKp
         wvNUvKhmwcX7JPXD1K/Zn2SPtFfJu4Pxpx7eqPi8p7PkeJRIzhT/h6xGRkRSd3/yx7
         71X9NspaeuVLw==
X-Nifty-SrcIP: [209.85.128.49]
Received: by mail-wm1-f49.google.com with SMTP id c22so8449362wmr.2;
        Wed, 03 Aug 2022 03:06:29 -0700 (PDT)
X-Gm-Message-State: ACgBeo0xnwJpauz3INEd8slSbUJfVRIkrlDe+wA4BqpSfwg1nEeueTjr
        PfZZuOCKfo4XqRY6KUHbemeioWxOyFBn1vGpTt4=
X-Google-Smtp-Source: AA6agR5YxxFZ2fNQSoyxT6/q86ZBjZAZ6ZGShjeXN79KJ+JSWZkpKY0XMUBWZfHoRVj7/xkf66qN7E4gJg3Ypb6yGQc=
X-Received: by 2002:a05:600c:a18e:b0:3a3:10ef:672a with SMTP id
 id14-20020a05600ca18e00b003a310ef672amr2234630wmb.14.1659521188077; Wed, 03
 Aug 2022 03:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220730173636.1303357-1-masahiroy@kernel.org> <CAKwvOd=gZc6TKaV1yh4pfbtj26xoQasVw=i+Vq+jOu2dgzFsFA@mail.gmail.com>
In-Reply-To: <CAKwvOd=gZc6TKaV1yh4pfbtj26xoQasVw=i+Vq+jOu2dgzFsFA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 3 Aug 2022 19:05:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT7ni-nOmhyjPByn=a40a-_D2sgkhvNFpqgHQsPDMm7Tg@mail.gmail.com>
Message-ID: <CAK7LNAT7ni-nOmhyjPByn=a40a-_D2sgkhvNFpqgHQsPDMm7Tg@mail.gmail.com>
Subject: Re: [PATCH 1/3] modpost: add array range check to sec_name()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 2:55 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Sat, Jul 30, 2022 at 10:37 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > The section index is always positive, so the argunent, secindex, should
> > be unsigned.
> >
> > Also, inserted the array range check.
> >
> > If sym->st_shndx is a special section index (between SHN_LORESERVE and
> > SHN_HIRESERVE), there is no corresponding section header.
> >
> > For example, if a symbol specifies an absolute value, sym->st_shndx is
> > SHN_ABS (=0xfff1).
> >
> > The current users do not cause the out-of-range access of
> > info->sechddrs[], but it is better to avoid such a pitfall.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> I don't mind adding this check; though if it's anomalous I think we
> could also just print to stderr and abort.


If  sec_name() has a failure path,
I need to add another check before calling sec_name().


I want to get a return value that can be safely passed
to strcmp(), etc.


For example,

   strcmp(!sec_name(elf, secindex),  "some_pattern");


Returning "" for special sections
will work nicely without additional check code.



I am changing the code with a bigger picture in my mind,
although that may not be so clear if you look at this patch only.



> I would prefer Elf_Sym over unsigned int though.  WDYT?
>

In /usr/include/elf.h, Elf{32,64}_Sym are structures.
How to use it instead of unsigned int?


typedef struct
{
  Elf32_Word    st_name;                /* Symbol name (string tbl index) */
  Elf32_Addr    st_value;               /* Symbol value */
  Elf32_Word    st_size;                /* Symbol size */
  unsigned char st_info;                /* Symbol type and binding */
  unsigned char st_other;               /* Symbol visibility */
  Elf32_Section st_shndx;               /* Section index */
} Elf32_Sym;

typedef struct
{
  Elf64_Word    st_name;                /* Symbol name (string tbl index) */
  unsigned char st_info;                /* Symbol type and binding */
  unsigned char st_other;               /* Symbol visibility */
  Elf64_Section st_shndx;               /* Section index */
  Elf64_Addr    st_value;               /* Symbol value */
  Elf64_Xword   st_size;                /* Symbol size */
} Elf64_Sym;




Best Regards
Masahiro Yamada
