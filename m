Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E21E58166C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbiGZPa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiGZPa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:30:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D1DAE45
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:30:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bn9so9794675wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0wgweyi5NGRv+HE2MTaBWrplm2EHlyiIAxkkqIQSs0=;
        b=X47KxyizSGoS2M4kT8l3dojbBsx8AlSGEk/cpikgOxJynDa/Y5++hdo0KEAxdqBZMw
         SyXwpOijT0+YR5+VNyj5Er+GLUFDxf3oOutcVSwsJudhHX+45ov34VH+/yEvyjbvE8OE
         J/EFnpOl9nJGfEPyWu+AOV5EfDpSl/ROMPUnOAE39kCW9HcAIfrNVEJPbYmzGJv6u3fo
         shx9bLD+thS2W6D2iiGNBW/5/NgufOiCpSr/QOMU5h3KjQtCEiPeMliB/NdB3fhWZCYA
         Kw2/wCpm0xIephjsdP0ShBZ2PdbKM3zzjT1FtA6vcdwADBxizYVd8YY3CBuSJYnZk34O
         MEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0wgweyi5NGRv+HE2MTaBWrplm2EHlyiIAxkkqIQSs0=;
        b=S17urj5iN0zAlY5Si3lvNV0spQhE1IYiaXQbHq80l/SmlDssKOmDRnvSlG6q5NjGoZ
         Hhlb9IGKTjkhsdZJnQMKaeRsbFl6OnqbH7S1uw2979cHtXVC26AECl+0/MEDcqNewNy3
         4keWImmoNjkIBMApJ72KnUlEGd31tC5x5jRpBhQ/YZSYDqTNmc3cP31Hl0rWNub7W8es
         PN14kxzrQbfss0QZYq4bATdGvA1WR/A869aFLYRA5AWpNUCA4HgRagfENZGRqkDlMDJg
         5GEFuDdryGS9SMvDxrW2tO/snQIW+j0AjzW1UjKQznVFEZScV7CP7x0zHDhRVvnQz+DI
         vnnQ==
X-Gm-Message-State: AJIora8i+4EdO8M2mvAMRQN4qBE/71+Oivak6Pmyt/tQwNpaJOdF3jNl
        wcRwVsDnvZyM1kIbJzflR2sOixXUgu/pah1XKHmeAQ==
X-Google-Smtp-Source: AGRyM1uqZdO2rcSVp/+TPJN7QEyIEDvp460BhjWSnS8sTm4VBrNNvBNfn82pg1xgJHAV0aUyNeV626vcuz4oZvZTUiI=
X-Received: by 2002:a05:6000:508:b0:21d:4105:caf9 with SMTP id
 a8-20020a056000050800b0021d4105caf9mr11603813wrf.699.1658849423820; Tue, 26
 Jul 2022 08:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
 <20220726073750.3219117-5-kaleshsingh@google.com> <Yt/7WzuBzc1m/6JU@sirena.org.uk>
In-Reply-To: <Yt/7WzuBzc1m/6JU@sirena.org.uk>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 26 Jul 2022 08:30:12 -0700
Message-ID: <CAC_TJveY_pk6AaMuRASy8UmhHvk2Du6A9VbuwrJ50Sw1RAPBMg@mail.gmail.com>
Subject: Re: [PATCH v6 04/17] arm64: stacktrace: Handle frame pointer from
 different address spaces
To:     Mark Brown <broonie@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Fuad Tabba <tabba@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>, Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Oliver Upton <oupton@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>, android-mm@google.com,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 7:34 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jul 26, 2022 at 12:37:37AM -0700, Kalesh Singh wrote:
> > The unwinder code is made reusable so that it can be used to
> > unwind various types of stacks. One usecase is unwinding the
> > nVHE hyp stack from the host (EL1) in non-protected mode. This
> > means that the unwinder must be able to translate HYP stack
> > addresses to kernel addresses.
> >
> > Add a callback (stack_trace_translate_fp_fn) to allow specifying
> > the translation function.
>
> Reviewed-by: Mark Brown <broonie@kernel.org>
>
> with or without one very minor thing:
>
> >  static inline int unwind_next_common(struct unwind_state *state,
> > -                                  struct stack_info *info)
> > +                                  struct stack_info *info,
> > +                                  stack_trace_translate_fp_fn translate_fp)
> >  {
> > +     unsigned long fp = state->fp, kern_fp = fp;
>
> As a coding style nit I don't love having multiple assignments on a
> single line especially as part of declarations.

Hi Mark,

Thanks for the reviews. I'll update this if a respin is needed.

--Kalesh
