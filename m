Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1B2587514
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiHBBeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiHBBeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:34:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6F7EE0B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:34:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A72161029
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB54EC433D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659404055;
        bh=3OXdvzQ7/toN4Xf9TNpY/YzZq0NdKmXU5WNB9SSX6jA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CLn9rgcnAlz3WhPJbq1bcKz2GjedBXvp8Ybm6P+boBNhjPjKCuyfv53pXKBVKzRt/
         3oRUEdqG3b4jIHc7W4CSAuJoUtuiGtx/B49EIKjAufwFSUu++gvHvceseZe6TcIxyf
         K1wBFCwKHcKHDcdvGZyHwDQv/D+4q7BQomcmNDW5wKS4pjQTE0SfMisTxbE33hmK1J
         C5xvCtktd1BPtSfhBMTv/jiXogsrTQ8nsSp7kymKUxguQbFjsFA3jOXGQObri9gsoQ
         JeOWHRV3/4sKsDkI/14WQezyzYws64YBvRuCHx+oS9y1ehaaEwhUf1tT/C3vT6r8an
         bkSiSY8G7jIpQ==
Received: by mail-ua1-f50.google.com with SMTP id l7so5254653ual.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 18:34:15 -0700 (PDT)
X-Gm-Message-State: ACgBeo39omgtHD146oIAHhmgusCCRsP6/lxPN0vocj9YZ/6PaT135Scm
        VF77oKJuvQau/0m9d4e42l9Ugag01DG/Jsx4Awc=
X-Google-Smtp-Source: AA6agR7sg1KN0wkD7d0GKnKxIEdICSgZ+psEs/t/m6wxi5Xmf2xVR/6g7SOlIA4pzjhzHRBvx9x0/mGvQnPnyv6FCJs=
X-Received: by 2002:ab0:2150:0:b0:384:ba63:69f9 with SMTP id
 t16-20020ab02150000000b00384ba6369f9mr7303484ual.100.1659404054794; Mon, 01
 Aug 2022 18:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220801121726.9681-1-zhangqing@loongson.cn> <20220801121726.9681-3-zhangqing@loongson.cn>
 <CAAhV-H4hR-Xdk5EpakR9ft0J+V5qgPj5q2T=zjh1SHMnnHK1vw@mail.gmail.com> <6e6a7219-8666-bd9e-770a-e60e4b329832@loongson.cn>
In-Reply-To: <6e6a7219-8666-bd9e-770a-e60e4b329832@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 2 Aug 2022 09:34:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7yfxX-ZsXjvWvSTwsyc8jf34jEOeLJ+dJ6jktJzuiryA@mail.gmail.com>
Message-ID: <CAAhV-H7yfxX-ZsXjvWvSTwsyc8jf34jEOeLJ+dJ6jktJzuiryA@mail.gmail.com>
Subject: Re: [PATCH 2/4] LoongArch: Add prologue unwinder support
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Qing Zhang <zhangqing@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Youling,

On Tue, Aug 2, 2022 at 9:30 AM Youling Tang <tangyouling@loongson.cn> wrote:
>
>
>
> On 08/01/2022 11:26 PM, Huacai Chen wrote:
> >> diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
> >> index 243330b39d0d..f9f73a26504e 100644
> >> --- a/arch/loongarch/include/asm/unwind.h
> >> +++ b/arch/loongarch/include/asm/unwind.h
> >> @@ -14,6 +14,14 @@
> >>  struct unwind_state {
> >>         struct stack_info stack_info;
> >>         struct task_struct *task;
> >> +#if defined(CONFIG_UNWINDER_PROLOGUE)
> >> +       unsigned long ra;
> >> +       bool enable;
> >> +       /*
> >> +        * Enable is the prologue analysis method
> >> +        * otherwise is the way to guess.
> >> +        */
> >> +#endif
> >>         unsigned long sp, pc;
> >>         bool first;
> >>         bool error;
> > This data struct makes me very uncomfortable, especially "enable" and
> > the #ifdef, maybe we can rework it like this?
> >
> > #define UNWINDER_GUESS     0
> > #define UNWINDER_PROLOGURE 1
>
> Maybe it's better to define with enum type?
> enum unwind_type {
>         UNWINDER_GUESS,
>         UNWINDER_PROLOGURE,
> };
Both macro and enum are acceptable, but enum is essentially "int",
while the "type" member is "char" here.

Huacai
>
> Youling
>
> > struct unwind_state {
> >         char type; /* UNWINDER_xxx */
> >         bool first, error;
> >         unsigned long sp, pc, ra;
> >         struct task_struct *task;
> >         struct stack_info stack_info;
> > };
> >
> > Huacai
>
>
