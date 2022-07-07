Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362D956A1CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiGGMPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiGGMPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B01DE10FC3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 05:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657196105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mbs481tHsGM89XED3giouE72pimnkluKaWbGcj8hSD4=;
        b=NPxS2enosB84LfTUAeQLmBOIM17fLpG3+c7amoLMp3u6VLbtDMth/dHRsUqtuTczt7f35A
        7lKlyrXVjTyb75abvaFra+xfr4v9py0ea4GC1gfyXZkokXhwHuCmVs5hk1PAx8gNXZHOkl
        0vfvTOJuJSGTBF7At13S7uRw6a3AEoQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-7AnKyOdWPxK8b9TxOuL1CA-1; Thu, 07 Jul 2022 08:15:04 -0400
X-MC-Unique: 7AnKyOdWPxK8b9TxOuL1CA-1
Received: by mail-lf1-f71.google.com with SMTP id 10-20020ac2484a000000b0047f9f9c81daso6338741lfy.16
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 05:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mbs481tHsGM89XED3giouE72pimnkluKaWbGcj8hSD4=;
        b=Abo8OkjUinyF63S2c2zXtSxMbxPwX/rnZKTQUs2MSysgpKHishkxBzinF8YLUGD28C
         q0wLL9oeEcFsd5qoiheg61dsnlHbpOEWgDnBg3AGaAybfjOC8wNs8Q4keg0C742mso5n
         mvCbw0dTbJlBkAr3CVAimKXEb5ubFIKUE1H1O+WkqIG+8La75WzwIjt//q+qfntljuxp
         wLrd2qe7vK8wmxLZ7+lfXTbngcllMNy2/ukSrax24xkunfMw4H85WhYRpeRWOjQ48mIN
         QpEx6Pcgw6jJNYm5BBk6v6xqQPXHFWaVF5H50LA19ydIP/loFz+cZqbgqjZA6sVIAxb4
         Bb5Q==
X-Gm-Message-State: AJIora+xDrMr8oRNy8dTo3GuQdUF5D75UxwKLPhZt7JLFGIVXv7hOJQu
        hMyI6ceHoWxE9uWtiH/5iL5d5RueG6R5Fq7IaQxZszrqZ/yVxSUmQfWCZmwg/0RyaSjMlOYQ/x7
        V3GY4pbjPtBpz3Tov6pYP6BzT9UkonHa0Pek1Vufz
X-Received: by 2002:a2e:bf21:0:b0:25d:4b4b:f2aa with SMTP id c33-20020a2ebf21000000b0025d4b4bf2aamr3103341ljr.503.1657196103242;
        Thu, 07 Jul 2022 05:15:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vMcH0UiUDOPP/H8I4asZFfJr+vM8ihLQnz0V+NqvLvZrKYzOgKLoxJDbByYdvsOJ1Z+jbM8lUG9WQnWttAA2M=
X-Received: by 2002:a2e:bf21:0:b0:25d:4b4b:f2aa with SMTP id
 c33-20020a2ebf21000000b0025d4b4bf2aamr3103326ljr.503.1657196103018; Thu, 07
 Jul 2022 05:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <920acea9aa18e4f2956581a8e158bdaa376fdf63.1629203945.git.jstancek@redhat.com>
 <95f35287-3d66-1788-e54c-7275fdba16ac@csgroup.eu>
In-Reply-To: <95f35287-3d66-1788-e54c-7275fdba16ac@csgroup.eu>
From:   Jan Stancek <jstancek@redhat.com>
Date:   Thu, 7 Jul 2022 14:14:47 +0200
Message-ID: <CAASaF6xZXjEYEUnkMQh0Ke24d=iJo-SZFdwuGQgrqZbbmMtGfg@mail.gmail.com>
Subject: Re: [PATCH/RFC] powerpc/module_64: allow .init_array constructors to run
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 1:20 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 17/08/2021 =C3=A0 15:02, Jan Stancek a =C3=A9crit :
> > gcov and kasan rely on compiler generated constructor code.
> > For modules, gcc-8 with gcov enabled generates .init_array section,
> > but on ppc64le it doesn't get executed. find_module_sections() never
> > finds .init_array section, because module_frob_arch_sections() renames
> > it to _init_array.
> >
> > Avoid renaming .init_array section, so do_mod_ctors() can use it.
> >
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
>
> Does commit d4be60fe66b7 ("powerpc/module_64: use module_init_section
> instead of patching names") fixes your issue ?

Yes, it does gcov for me. Thanks

>
> If not, please rebase and resubmit.
>
> Thanks
> Christophe
>
>
> > ---
> > I wasn't able to trace the comment:
> >    "We don't handle .init for the moment: rename to _init"
> > to original patch (it pre-dates .git). I'm not sure if it
> > still applies today, so I limited patch to .init_array. This
> > fixes gcov for modules for me on ppc64le 5.14.0-rc6.
> >
> > Renaming issue is also mentioned in kasan patches here:
> >    https://patchwork.ozlabs.org/project/linuxppc-dev/cover/202103191440=
58.772525-1-dja@axtens
> >
> >   arch/powerpc/kernel/module_64.c | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/modu=
le_64.c
> > index 6baa676e7cb6..c604b13ea6bf 100644
> > --- a/arch/powerpc/kernel/module_64.c
> > +++ b/arch/powerpc/kernel/module_64.c
> > @@ -299,8 +299,16 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
> >                                         sechdrs[i].sh_size);
> >
> >               /* We don't handle .init for the moment: rename to _init =
*/
> > -             while ((p =3D strstr(secstrings + sechdrs[i].sh_name, ".i=
nit")))
> > +             while ((p =3D strstr(secstrings + sechdrs[i].sh_name, ".i=
nit"))) {
> > +#ifdef CONFIG_CONSTRUCTORS
> > +                     /* find_module_sections() needs .init_array intac=
t */
> > +                     if (strstr(secstrings + sechdrs[i].sh_name,
> > +                             ".init_array")) {
> > +                             break;
> > +                     }
> > +#endif
> >                       p[0] =3D '_';
> > +             }
> >
> >               if (sechdrs[i].sh_type =3D=3D SHT_SYMTAB)
> >                       dedotify((void *)hdr + sechdrs[i].sh_offset,
>

