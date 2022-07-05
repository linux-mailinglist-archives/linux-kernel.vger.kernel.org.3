Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ED65670C7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiGEORx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiGEORW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:17:22 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751A51005
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:13:11 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w83so16323545oiw.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QI3B1vIlvYkplD/OGFLDNG9KjTXHUoGMSflSfPKXG5I=;
        b=DfVQLNy96aUWYf+Jt0CfmE7H2lYMo7TQ0F5goqxT/ODcU4vuDqq+EKv0pC/J4mrPhK
         ckjbHfhDcM5wrntYgLzgf4zdR7zfyhv8EjVmBawbawurUni6XstEXFQUYxjf1NYyODD6
         JPzGBSjXAh7267svFQP1/88rAhJ9b46HIRC+vRsLsjkfBpF4DE0b+rjSZsyAN1p5kBe7
         r30gzYYQP8a2ucHu2cTDVoEVEYJ3nmw3FmEew6OWMWC8nTEOWbFg2aiYec8ekbJVaFTy
         +0Gqw+CHRpYHpNyO8unp5PRDhpgUZuluMmI8VlZbN3j3LhiyufpNrFpy5akiSIhVBsNi
         PTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QI3B1vIlvYkplD/OGFLDNG9KjTXHUoGMSflSfPKXG5I=;
        b=PdQ/DEED2WBj7YYk2hMj6SsL6zLG5osxx1wqkysiThHOUNejcCKe+J27jtFddWJGDa
         zwPE+1jWfb3dU6GQhCh2dxkIV0QvjqzBvWmfKLymVRKJ084+b2Wo2hqonpeVSt1Ud7XV
         UFUaM9fu6e5r11l5XZwlALxXb+OA7bhmLP6Us+B5rrE+LcORU5iSmo55Nk0LBbU+dmd9
         un8+Pv1I47ec3Sdij3ro1i5tBoYs0ch22f5joQIM/tJ7bkrMDHeUFB18zK6FJNouA/mn
         LLyWEDHKhksONRlsgjYWpM+wOIF12N2E9Af+aonTPFtS0UXpEI+nMJiLPyC9MtnmOo5+
         tGaA==
X-Gm-Message-State: AJIora+eEVxPlBIqsI3fHaOUIt9jfP0Z6sG4j9fYAYKCNtKHBKrAUE+5
        4ocUVmi+ZmFxGxb2xtKdq0zUPh1rQNBHvjyBmJQ=
X-Google-Smtp-Source: AGRyM1uKWnxIsrOjuSrESBMFHOOIgp08dNiqIPuvwPDUKe/GYZCd8M/st/cAl0YrkegNHZK4GxiYvRIkoO4isGqxnes=
X-Received: by 2002:a05:6808:2099:b0:335:1606:2504 with SMTP id
 s25-20020a056808209900b0033516062504mr19434401oiw.110.1657030389377; Tue, 05
 Jul 2022 07:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
 <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
 <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
 <d75edc49681473bf8b88e474ae61b524@mailhost.ics.forth.gr> <CA+zEjCsc60mxPynL7DDGxfaUz7uif3uXPx3atnHbvM3ei_TETA@mail.gmail.com>
 <2ec74f4bd0e7b7cb4b579e9e042fc035@mailhost.ics.forth.gr> <CALecT5gdqW9Na_s9PiFAZt0u=_uPCu0zYdUCb4UfuSV6fM_Q+w@mail.gmail.com>
 <75409de5-2351-3ab2-5162-33ebd8d30749@ics.forth.gr>
In-Reply-To: <75409de5-2351-3ab2-5162-33ebd8d30749@ics.forth.gr>
From:   Yixun Lan <yixun.lan@gmail.com>
Date:   Tue, 5 Jul 2022 14:12:58 +0000
Message-ID: <CALecT5gA-h7p__BZT=okWJCANz9oHE8R4kwHC6hJOPKGMe+Fkg@mail.gmail.com>
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
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

HI Nick

On Tue, Jul 5, 2022 at 12:24 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> Hello Yixun,
>
> On 7/2/22 14:35, Yixun Lan wrote:
> > hi Nick
> >
> > ping, any update for this? any new patch for kexec-tools?
> >
> > I'd also like to try kexec on unmatched board, and encounter the same error
> > as Alexandre Ghiti reported, generally I'm using almost same cmdline
> >
> > Yixun Lan
>
> The kernel-side patches have already been merged upstream, for
> kexec-tools there are some people working on fixes, I'm expecting pull
> requests on the github before I do a pull request upstream. You should
> be able to use kexec without initrd.
>
> Regards,
> Nick

Thanks for the reply and updated information
I was looking forward to use "--initrd" in order to boot a complicated OS,

Anyway, I will try kexec without initrd, and please keep me posted
when there is PR

Regards

Yixun Lan
