Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE18D4EA30D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiC1Wdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiC1Wdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:33:36 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71D263CD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:31:53 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id v2so13762315qtc.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BYbE5ultDd7ocSRftvKgW60rNwB4DPzrNN76MatCGuk=;
        b=lgbawv4cevnQKnHX2UzD8S0LhBnLK6AZ3q0Wevpiy1r8pnVPchTYoXeSufoa4ctofk
         K6OLKy1QfoUsSKvQ1lkRnthBRdf/9WdH8YXuuMyhbP0vOX03JyzUrtyDiPNytmQIFVrn
         L2T3peOXBlK95e+njy19Zh0VlRliUBjOg6BXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BYbE5ultDd7ocSRftvKgW60rNwB4DPzrNN76MatCGuk=;
        b=l2lAQXUpplnD+HhphzlS+y+1mkV5RbW96VIdZeAbfzLU+QPDAs89OdK1Le5rzW+rHg
         f74PgeP25V3Xwcn56xnZWl3noRPWsZSdsB/OewZYauV3o4AtVmOW0w9fcF6aBIhncyvO
         5GmeOrIDlFGzyW9TSGjwi8u6Itvn1Jv1UU0K7/JQ4if3+jUC3MEkg/Tthdlr4iSdFIhA
         G4sPG6Sbg1OigEQv3tOLcBE7KaNqcPwrOxoxnil6WbFWYja4CkrgaWimhRaJvpp5HpQP
         si7AK9mHdL9/dzrts5iXyyq5OYNMzDX1xu3JGQoYFgdDuB0amu7+3QA17AQqpddN8DfS
         XvEw==
X-Gm-Message-State: AOAM530mndJ0Gpx9TQfH0uERFLDl00zJismJ3D1BfSd6BpcN3O4B2c6e
        k+htoABGJTSTjchvKVg4CULoCn59C57WRPWdLvYyZa4N
X-Google-Smtp-Source: ABdhPJxuqdwd1O+dPIY2XND9VHw20cQ0fzGLQhlk5XL/gb0f5mmplZ0b0indblsMbC81Cu/UgQ/jWw97Oo76wTaaB5A=
X-Received: by 2002:a05:622a:4cd:b0:2e1:ec2f:8c22 with SMTP id
 q13-20020a05622a04cd00b002e1ec2f8c22mr24918845qtx.494.1648506712819; Mon, 28
 Mar 2022 15:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <cd0f6bdfdf1ee096fb2c07e7b38940921b8e9118.1637764848.git.christophe.leroy@csgroup.eu>
 <efc0e15e-fc93-fb59-068d-602f96ec7431@csgroup.eu> <20211129124355.52474d90@gandalf.local.home>
 <0b901c6f-9d42-11f6-4e44-df3bb1587456@csgroup.eu>
In-Reply-To: <0b901c6f-9d42-11f6-4e44-df3bb1587456@csgroup.eu>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 28 Mar 2022 22:31:40 +0000
Message-ID: <CACPK8XcM9LAWrc-eiir5gUN0Vb2Ca_ZMR-xF1Z_FoyWK8eqYbA@mail.gmail.com>
Subject: Re: [PATCH] recordmcount: Support empty section from recent binutils
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 at 22:43, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 29/11/2021 =C3=A0 18:43, Steven Rostedt a =C3=A9crit :
> > On Fri, 26 Nov 2021 08:43:23 +0000
> > LEROY Christophe <christophe.leroy@csgroup.eu> wrote:
> >
> >> Le 24/11/2021 =C3=A0 15:43, Christophe Leroy a =C3=A9crit :
> >>> Looks like recent binutils (2.36 and over ?) may empty some section,
> >>> leading to failure like:
> >>>
> >>>     Cannot find symbol for section 11: .text.unlikely.
> >>>     kernel/kexec_file.o: failed
> >>>     make[1]: *** [scripts/Makefile.build:287: kernel/kexec_file.o] Er=
ror 1
> >>>
> >>> In order to avoid that, ensure that the section has a content before
> >>> returning it's name in has_rel_mcount().
> >>
> >> This patch doesn't work, on PPC32 I get the following message with thi=
s
> >> patch applied:
> >>
> >> [    0.000000] ftrace: No functions to be traced?
> >>
> >> Without the patch I get:
> >>
> >> [    0.000000] ftrace: allocating 22381 entries in 66 pages
> >> [    0.000000] ftrace: allocated 66 pages with 2 groups
> >
> > Because of this report, I have not applied this patch (even though I wa=
s
> > about to push it to Linus).
> >
> > I'm pulling it from my queue until this gets resolved.
> >
>
> I have no idea on how to fix that for the moment.
>
> With GCC 10 (binutils 2.36) an objdump -x on kernel/kexec_file.o gives:
>
> 0000000000000000 l    d  .text.unlikely 0000000000000000 .text.unlikely
> 0000000000000000  w    F .text.unlikely 0000000000000038
> .arch_kexec_apply_relocations_add
> 0000000000000038  w    F .text.unlikely 0000000000000038
> .arch_kexec_apply_relocations
>
>
> With GCC 11 (binutils 2.37) the same gives:
>
> 0000000000000000  w    F .text.unlikely 0000000000000038
> .arch_kexec_apply_relocations_add
> 0000000000000038  w    F .text.unlikely 0000000000000038
> .arch_kexec_apply_relocations
>
>
> The problem is that recordmcount drops weak symbols, and it doesn't find
> any non-weak symbol in .text.unlikely
>
> Explication given at
> https://elixir.bootlin.com/linux/v5.16-rc2/source/scripts/recordmcount.h#=
L506
>
> I have no idea on what to do.

Did you end up finding a solution for this issue?

Cheers,

Joel
