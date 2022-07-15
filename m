Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBE957672A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiGOTKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiGOTKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:10:20 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E474A42AC3;
        Fri, 15 Jul 2022 12:10:18 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31c8a1e9e33so55870927b3.5;
        Fri, 15 Jul 2022 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0eFPkxDRT819KSGBw+2IxjOO0RG/iHGVi8eAb/xqty0=;
        b=f/4f6JFFnBU9uTKjuUmeSdJ/6vp/353/HUJvdgH72g+VRfZy6xjLgyy50GWODcB9qC
         QSUphY6kFh7qSjOSb+3dQw0IEc3DMISeYErWmjW+kD/LonaJmtvnnKAZU5BywZUC2kn8
         dWHsNEMx/Y/Mb89k5SrUBchJNiCuoxJF2x/2AUu3y7vqnIrsFcSwAx1tMjwxw5QNsdCX
         UFvWf7lUphXKSi4mvpQKWB809WW/B1CCz5LBxnRQ3coPwdhBRXjxLjw2JAka7aHtlBwk
         kjyQd0SUHlXdepEs6O1E813chUKsXzYhHrwTLL4wMzyMkIES2JdNHgFdzEi8/cWCrRGy
         Q3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0eFPkxDRT819KSGBw+2IxjOO0RG/iHGVi8eAb/xqty0=;
        b=kZLgdYHIhvfTRAfArFCyHUkiLhLOQvSfyvyaYcBOiGwaJkmvxgUPoQq8d0NJbA5lNz
         zqUvaG4CYwLkpdnUIXDwcM6DkARrrwSWMb7L1xFF22dlZxx/K+CiSkVuSPQh2fpZgW+s
         vTJPNRQ1bAZ9LgA6YCTd5MBoocQdtVIxdbpnuPVQT/5Gg6Q94b2wvuXRnB9ici7LB6MZ
         1JUml11PrlY5pi8Vc/82OB7r6jP8YMdDCRs317Ri+Z4H8mpvapGNcvgM5/sNJ42rGso9
         ReQc8l4VMz9kyYGEdz1HdZn5lLqfJygOilFMkFLbLaVon9r+Qa85e4OAaRZGeIw2/IS6
         Mltw==
X-Gm-Message-State: AJIora+6jQlVKbyMEpuUVI1sblBtbkXZ1EJdZafBhjdQIXNU8tMykHH7
        wQGIE6BP8I90C79vseKq5Kc38s1P/finEJajFh/fmxiaSoE=
X-Google-Smtp-Source: AGRyM1u0LfZ/5A73nKyjWxon9iGrwvZUGBIxQ1+PoIrjIXnaMtBrTrN8qxeJAwr/pBi1AmwazSDMtzOwsUqXDHdyBmU=
X-Received: by 2002:a81:108f:0:b0:31c:d7ae:9ff1 with SMTP id
 137-20020a81108f000000b0031cd7ae9ff1mr17042253ywq.18.1657912218072; Fri, 15
 Jul 2022 12:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220715224443.46ce75ca@canb.auug.org.au> <87fsj2v3oq.wl-tiwai@suse.de>
In-Reply-To: <87fsj2v3oq.wl-tiwai@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Jul 2022 21:09:41 +0200
Message-ID: <CAHp75Vf1O0AEkdNvAoGQ-nM9Pbx-nFtA5-GH=z=TZF_xTgfY3A@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the sound tree
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 5:39 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 15 Jul 2022 14:44:43 +0200,
> Stephen Rothwell wrote:
> >
> > Hi all,
> >
> > After merging the sound tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> >
> > sound/pci/hda/cs35l41_hda.c: In function 'cs35l41_get_acpi_sub_string':
> > sound/pci/hda/cs35l41_hda.c:693:43: error: invalid use of undefined type 'struct acpi_device'
> >   693 |         status = acpi_evaluate_object(adev->handle, "_SUB", NULL, &buffer);
> >       |                                           ^~
> >
> > Caused by commit
> >
> >   d60b05b4c780 ("ALSA: hda: cs35l41: Allow compilation test on non-ACPI configurations")
> >
> > along with commit
> >
> >   eef375960210 ("ALSA: hda: cs35l41: Support reading subsystem id from ACPI")
> >
> > I have reverted commit d60b05b4c780 for today.
>
> Thanks.  Now I reverted the commit on for-next branch as a workaround,
> too.

Thanks! OTOH it means it's working well :-)

Nevertheless, I have prepared a series to deduplicate this _SUB code
and I think the ACPI would stay as a compile dependency because of
that change anyway.


-- 
With Best Regards,
Andy Shevchenko
