Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EF954FC86
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382906AbiFQRvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiFQRvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:51:36 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E0E4AE19;
        Fri, 17 Jun 2022 10:51:35 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id h8so5245941iof.11;
        Fri, 17 Jun 2022 10:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=grjrAGI4VNuEsZ3QNXKvxidIo/MX1HBbCbb5NRnse+k=;
        b=SMzhwmMFoTT6L9qoBI9jQ7LbYRxV1Q/MJDuIgZaqzIQtm5Z9mHNC92pKhWfzWLV0L+
         zJYYvFHCrajTHFLC6tGPTj+3QkxkZ4TuxjxBc+VaXDeLvV1ou3j6PJolzwgH/ohJlqAu
         Q9er51KtPCUlE1mcV0CGJ3WQvE1qFl1cTmU1rLW+Po39o4ZxwEuwYo4uxH68aVtZM200
         JQ7lEdwFCj70Je4tkJK93P6iuZq1xcmgkMkS7+B7kfELwD0rv+BaSw8CGGnlaHQ4/A5j
         yJXMbmxkZTV4KtqoVRDDnDeWDgSSsuOdFX862Zeoau5vYNpbYJQZJ5BwcYvpqjQtglAw
         6kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=grjrAGI4VNuEsZ3QNXKvxidIo/MX1HBbCbb5NRnse+k=;
        b=4aqlbskYkbx5ebirnxz01NWizVmnG6ZGwPtUWTEpmZ0mTRYzAEMlw41qDtS/K+S+nn
         N5CFyHDJtY3r8sFMf+xwWX7VX8ONq7ZkSiAlqs93zgxrn/4KRjQkFUJwOfoRqJ108HdI
         zBYlXUZKmx9U/Lk1jyvn/wIwoB9ktOJw7UAuzhk+5TQarVSKWYmlZgoCikCPRNRvzPWh
         ECX3xb206aDPPFP631JaopmIcGDSakHprvJv5DUKlEKthxp3hTMYEN9O8HrE5AnlDAxD
         jvaKHS80dVmPA8DPKvr6SI5moTqXqSVobXti00VLaWkG19SBkFgo3Jf/utfQLFIk0DPY
         FpAA==
X-Gm-Message-State: AJIora+qAgoyGcfmFgd7/oK8gg65eoTC8XluOpmTKS/koN7iKKrA8SKu
        8tys++A+i54SJHPh+42LfM+hEsV2rDXzwzWaLeTH0HjDamI=
X-Google-Smtp-Source: AGRyM1stNa4oiKHeh/+bvfYGv7PV+gk7a4nSJEBQ6BNXihalHF+mrDme9X1gUVtaoWweJP+wfGjJtKOh3haTKHT9S8k=
X-Received: by 2002:a05:6638:1415:b0:331:d318:83ab with SMTP id
 k21-20020a056638141500b00331d31883abmr6251119jad.126.1655488294457; Fri, 17
 Jun 2022 10:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220616104541.16289-1-jslaby@suse.cz> <CA+icZUW8O-HUSpw-656o6YZOiR2ZiCXjxsJwm2kctT6DHrs=4g@mail.gmail.com>
 <CA+icZUV6bM2_jxyROK5B4XRid6fv8oX6YYNEdHUX8e_1OAdQYA@mail.gmail.com>
 <CA+icZUUSTcrJqZB-gwNYt5objVg1J5+Ous6_hof0_A6eVCM-Kg@mail.gmail.com> <CAKwvOdmb5xdF70TzNp=4STCpzkGh16FnuKE1KbdzDhHt=OuRFA@mail.gmail.com>
In-Reply-To: <CAKwvOdmb5xdF70TzNp=4STCpzkGh16FnuKE1KbdzDhHt=OuRFA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 17 Jun 2022 19:50:58 +0200
Message-ID: <CA+icZUWZKGEQ_VbnRL03SRAicEMi4r4J0dLRgXJgHvRg7DBM7A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: pass jobserver to cmd_ld_vmlinux.o
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 6:32 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Jun 17, 2022 at 3:35 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Jun 17, 2022 at 12:53 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Thu, Jun 16, 2022 at 4:09 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > >
> > > > On Thu, Jun 16, 2022 at 12:45 PM Jiri Slaby <jslaby@suse.cz> wrote:
> > > > >
> > > > > Until the link-vmlinux.sh split (cf. the commit below), the linker was
> > > > > run with jobserver set in MAKEFLAGS. After the split, the command in
> > > > > Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
> > > > > is lost.
> > > > >
> > > > > Restore it as linkers working in parallel (esp. the LTO ones) make a use
> > > > > of it.
>
> TBH, I agree with Masahiro. I didn't understand this comment "esp. the
> LTO ones."  Jiri, can you clarify what you mean here?
>
> > [ CC Nathan and Sami ]
> >
> > I re-checked as my build-time takes approx. 15mins more than usual
> > with Linux v5.17.
> >
> > [ Perf - seconds time elapsed ]
> > v5.17: approx. 12500
> > v5.19: approx. 13500
> >
> > +1.000 secs = +16,67mins
>
> Does this patch make a difference?
> https://lore.kernel.org/linux-kbuild/20220616195759.3214538-1-samitolvanen@google.com/
>

Running a new build...

-sed@-
