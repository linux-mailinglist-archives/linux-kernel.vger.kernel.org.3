Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1BE5AFA8D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiIGDXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIGDX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:23:28 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDADB88DF6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 20:23:27 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-127f5411b9cso1654149fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 20:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Oa3I0B8/Gc5qSoYYjA2INQA/7y6UqoXGPhOex6onTbU=;
        b=j66zpCa9ljE56zxusk2346QDsgeMrrEvEVPwkFiNbcDnSS1jPCRQer9M21kPuh73RV
         qsQWM9mEXLzuwQ2d5sHhOSACopum8+NRHmgrCo2uh3EGZqtewsoZcfwWo6PnEuv0vLNp
         CS7wg2Wr7IKqRKhq1BkD/nkTYk/uvd5+wZJe4nkKAVxEtI+YOG66MKqYeC2zVGjJm1aD
         QMXcGlP+8RycAzbEkFyae2mRiuU0DTATYWlPYBENNi9VgBAsEqbepfWmsoWwam2qa3Ie
         ehIeHdDUcItWHopER3y3XYIa1SFNznLI5/AD1oXOP/XClAs4yqLxki7gEohio51yYxNf
         tZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Oa3I0B8/Gc5qSoYYjA2INQA/7y6UqoXGPhOex6onTbU=;
        b=sevFX82budKcJ18XX/u0GHKdCvXNV8MOBzFcvz+B1FLhIIN5ZBos8SrjsPsEzbO6zx
         timlxsaYj7S0svXqtr5VOXFBkWw49HWTZDETLhuUxQxCJX0KiQ0su2UsGAsXYXJTPKg6
         FXT/RJK3nGnqiU2qfScrTh/LE5bp4DBsG8Lh9BATDnl+F24E3wBNDj4i7AjwP+iZqzx1
         u9NkTSNJcdZaUrvMV4XvvPq0I/Ne6daW5FWwvRRk+86HqIiCkIv7yaV7hHvu+aXXzQFn
         z3dc2lpXfIDbWiJVE0Oz0ZvvPyAKfisr1T2N0XbpTmLsqTvfonCN2EDeLDmlA/PW65rI
         No0g==
X-Gm-Message-State: ACgBeo2yXzJMgkWNZvXONVMVKWqdOMRStt4DCi3xAx8yxtDTSnLGxKS9
        /mwvfJc3fikR1ZEMkUtz3oALzg5kLrBtYQgkbeXuBHt0DBg=
X-Google-Smtp-Source: AA6agR4fz8qKH69TMEEZzbOGTiuVYwELfo47L2XtqTs9vIlonfYPDR6hHso6oEZchx5JD3Hq7tNBnXkd81fI6APm2Uw=
X-Received: by 2002:a05:6808:4c8:b0:343:9abe:3ee6 with SMTP id
 a8-20020a05680804c800b003439abe3ee6mr659937oie.110.1662521007175; Tue, 06 Sep
 2022 20:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
 <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
 <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
 <d75edc49681473bf8b88e474ae61b524@mailhost.ics.forth.gr> <CA+zEjCsc60mxPynL7DDGxfaUz7uif3uXPx3atnHbvM3ei_TETA@mail.gmail.com>
 <2ec74f4bd0e7b7cb4b579e9e042fc035@mailhost.ics.forth.gr> <CALecT5gdqW9Na_s9PiFAZt0u=_uPCu0zYdUCb4UfuSV6fM_Q+w@mail.gmail.com>
 <75409de5-2351-3ab2-5162-33ebd8d30749@ics.forth.gr> <d30c98c9-b0bb-2b99-c4f0-94b3e46040d8@linux.dev>
In-Reply-To: <d30c98c9-b0bb-2b99-c4f0-94b3e46040d8@linux.dev>
From:   Yixun Lan <yixun.lan@gmail.com>
Date:   Wed, 7 Sep 2022 03:23:15 +0000
Message-ID: <CALecT5i9B_uXEHsMnNeLyChK3uML5PQNdZ0XMBJOT81NSL_VPw@mail.gmail.com>
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
To:     Vasily Averin <vasily.averin@linux.dev>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alexandre ghiti <alex@ghiti.fr>,
        Mike Rapoport <rppt@kernel.org>, geert+renesas@glider.be,
        Stephano Cetola <scetola@linuxfoundation.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>
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

Hi Vasily Averin:

On Tue, Sep 6, 2022 at 2:49 PM Vasily Averin <vasily.averin@linux.dev> wrote:
>
> On 7/5/22 15:23, Nick Kossifidis wrote:
> > On 7/2/22 14:35, Yixun Lan wrote:
> >> I'd also like to try kexec on unmatched board, and encounter the same error
> >> as Alexandre Ghiti reported, generally I'm using almost same cmdline
> >
> > The kernel-side patches have already been merged upstream, for
> > kexec-tools there are some people working on fixes, I'm expecting
> > pull requests on the github before I do a pull request upstream. You
> > should be able to use kexec without initrd.
>
> Dear Nick, Yuxun,
> first of all thank you very much for your great work.
> Could you please clarify about state of makedumpfile on RISC-V?
>
Speak for myself, I haven't played with the makedumpfile tool yet
and a quick check [1], seems there is no RISC-V support so far

[1] https://github.com/makedumpfile/makedumpfile/tree/master/arch

Yixun
