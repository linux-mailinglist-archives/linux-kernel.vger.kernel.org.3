Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33B54BBE8B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbiBRRjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:39:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbiBRRjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:39:44 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195DD2BB19
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:39:27 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id t22so10794723vsa.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0NhB1xsVCUvvgT8xA5VIM+U/pg8RDe8EADZNUdbmpw=;
        b=LQlGKbvYmoghEDOz5mAfbSZPQkv9R6f2PjO4g3ZFPDnIXwP1lLVPJ5YIbRGtI7uAtx
         iqeVrwXL3aFY+U3ilfBt9nIAXyEAkLvuaj0j2O6q+oL1nMYnzyM3cfxm5WdnEM6Rr+Yw
         AyVUuarJkT+7aDv1gxDQMrtFRE6TueKIeUiiCTmeLHNx+iEWOgdDvCwV2+C2ExC8MjT9
         Qf3RSPskYUcr1y2ZqortgdG723i6PYuX+f6Abej0MKG9zikCic40qsCz45QuCAtv6v5A
         4jJh4U3Wi1Dk6QHBouD0TVocOYoHNB6/XeGapQbTLlh25DgLOsTCIbG5svtly19Wvsb0
         VfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0NhB1xsVCUvvgT8xA5VIM+U/pg8RDe8EADZNUdbmpw=;
        b=cns8pv9+CM+9+xRgId87h+G0wR8Y4viTRBV6KuFW+C8utT1hBjXvuYgThhYEDsfoX1
         fOEJ9J3KzWg947I9dPVrtMMvG2DxBXFHiVIydqx4VuUhZS7Nx1JmEdyduoDIAuaFnzkN
         Y2lmeB3ztPJZoDpLBr81Mlu8wdq22l+3mwX3vIvHmAyYG1UROhmEj4DitegL9zwuadXZ
         RIPNPg4tmlwNqYR8pYqTwzgyWbypXk1x7nsxokrc/37WSjOkwC1yJxsIhURcOCZtNC9Z
         7biAEUtRTBDAZODqqZRgtSNWvpqsgnvyuwmXuAyKaic11QXqOjszPX713KbpKS1U9d09
         KALQ==
X-Gm-Message-State: AOAM530g3pVoKdxuzunPWVE4c0+KBXU4Q3ObbgmtZ/KDqUavbFIUpeOg
        so+Kqc/UczcD3+ulYmL1psI2PkksATOW2gmFkFbAIw==
X-Google-Smtp-Source: ABdhPJzPtL5T94v2FfTMvYe30S9B0+OgBIA4Vcx+QVmdo52/ZERaYyOJ9hOhkCyysOd3cQ7mW/ZjrMqjQKZ6iI+XVHE=
X-Received: by 2002:a67:c081:0:b0:31b:8d09:7e25 with SMTP id
 x1-20020a67c081000000b0031b8d097e25mr3768382vsi.42.1645205966074; Fri, 18 Feb
 2022 09:39:26 -0800 (PST)
MIME-Version: 1.0
References: <Yg54nse5qNQO3sbW@zn.tnic> <20220218013209.2436006-1-juew@google.com>
 <Yg+2Hc78nfSRmh/j@zn.tnic> <CAPcxDJ4c3eGXTB9UPJmZ8dzyCNPW4Lv9s1QSeoCWq_LdNWTrJw@mail.gmail.com>
 <Yg/FyrvLWhZHB/UC@zn.tnic> <CAPcxDJ72dMOpbKXxyb__OeMaEyjYSPtsL_ubVsKOuRXefAQ3_w@mail.gmail.com>
 <Yg/UUHuVvd9AOJ94@zn.tnic>
In-Reply-To: <Yg/UUHuVvd9AOJ94@zn.tnic>
From:   Jue Wang <juew@google.com>
Date:   Fri, 18 Feb 2022 09:39:14 -0800
Message-ID: <CAPcxDJ5aB131SqXM3S7Etpj_B6AqVcpLJviMsfvFPbUSGjBb_g@mail.gmail.com>
Subject: Re: [PATCH v2] x86/mce: work around an erratum on fast string copy instructions.
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
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

On Fri, Feb 18, 2022 at 9:16 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Feb 18, 2022 at 08:21:36AM -0800, Jue Wang wrote:
> > My concern was that here returns 0 instead the value read from the msr.
>
> You'd walk into that code only if you're doing MCE injections. In that
> case, it won't read or write MSR_IA32_MISC_ENABLE because the injection
> code writes into the injection mce struct only.
>
> So it won't disable fast strings when you manage to inject the exact
> error type which triggers this erratum.
>
> I think that's actually a good thing - you don't want to disable fast
> strings just because you injected a particular MCE type.

Ok, makes good sense.

Thanks Boris!

-Jue
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
