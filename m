Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62EE581681
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiGZPdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiGZPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:33:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA9B24BED
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:33:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m17so20398856wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IdrmtKsVwJ8Ilm8fXdlZo1ojDSarLxj4cwD1+3jZZEk=;
        b=OqCNg3Evlo5tkojw6+O9gMzqKRS/81Ng74vt1BFuMXIRVoj+ueOPnewIymEDcvNbsA
         GrTelS4phLivi2uHD1PHTtXKp55HSg8TUI748XhWMdrJm28oIfHDx/WkiAjZW46k57+x
         6YmtHrQsq3VmBUk04cYdjOmWJ8j7Sn6Ug1slr8XmG3pngkPHXku6peewmEPuAuktdRnZ
         b5R+MxAoh0AnJ92YiuB+1nQKotCBa3cjPKqGeivWHwO8U9tBjdLyahbAc+YDhK91MBD2
         pcMCrC+ezfRpRQBGbbQejnVCyDmZ601SYHCW9NZAVK7zw5uy7vtWyqttX0N4761Z8Bkx
         bkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IdrmtKsVwJ8Ilm8fXdlZo1ojDSarLxj4cwD1+3jZZEk=;
        b=0Mp4EQdDWA48OStvldGFg7mMd9CALFrCobebOp4aQWHpsMT4zdzQ4azfWHzDcE4ho8
         aIS+82TDMttyizwkIhggbylR0jE3eNjfXxCz4zCUsEblonW75rPfIivNSu8kzOFRwy0q
         Lkd97tg0Xt9/I1Yali9YezBBcY3+LKSVbGQTeN1FdZ2fIcpmhLbXKz7O1zKuu5adlQBA
         Ep7sOCFdFExJqo9h7RL6egs7asG+dM25TYOP/YOLPQs/xxkE+tBmjQdD6FLAs8qJsgRB
         1Aa2GWobVxe2IAzSw26a/YofTALTgtUcfwS+i0AwN9ZGZzCoRFf0XzAXYrAIgSqrCdHp
         slBA==
X-Gm-Message-State: AJIora8iv/WxDQTBkvckpbKah/YBE8K5L/3ra193/cDXJhEwcPEUXb19
        RYhPDj1ezspL9JlAbbNd/+35mVSkq8cxn1X71hxOpQ==
X-Google-Smtp-Source: AGRyM1sEa6iMPu3EBWOW+qgWlSZBYXUn6OljA5SeoAQuOFG/BP2IVZ12GTJ9KaYjd799UK0R/24QNFygZopnAgNFRrY=
X-Received: by 2002:a5d:4583:0:b0:21e:3b0e:2bc9 with SMTP id
 p3-20020a5d4583000000b0021e3b0e2bc9mr11226482wrq.649.1658849612164; Tue, 26
 Jul 2022 08:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
 <20220726073750.3219117-13-kaleshsingh@google.com> <87a68wxkga.wl-maz@kernel.org>
In-Reply-To: <87a68wxkga.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 26 Jul 2022 08:33:20 -0700
Message-ID: <CAC_TJve+33nTGNVZrsnrEJGPGMvCNARougeSmXWDdjiq_Daeig@mail.gmail.com>
Subject: Re: [PATCH v6 12/17] KVM: arm64: Add PROTECTED_NVHE_STACKTRACE Kconfig
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jul 26, 2022 at 3:00 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 26 Jul 2022 08:37:45 +0100,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > This can be used to disable stacktrace for the protected KVM
> > nVHE hypervisor, in order to save on the associated memory usage.
> >
> > This option is disabled by default, since protected KVM is not widely
> > used on platforms other than Android currently.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > Reviewed-by: Fuad Tabba <tabba@google.com>
> > Tested-by: Fuad Tabba <tabba@google.com>
> > ---
> >
> > Changes in v6:
> >   - Add Fuad=E2=80=99s Reviewed-by and Tested-by tags
> >

> > Changes in v5:
> >   - Make PROTECTED_NVHE_STACKTRACE depend on NVHE_EL2_DEBUG, per Marc
> >
> >  arch/arm64/kvm/Kconfig | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> > index 8a5fbbf084df..09c995869916 100644
> > --- a/arch/arm64/kvm/Kconfig
> > +++ b/arch/arm64/kvm/Kconfig
> > @@ -46,6 +46,21 @@ menuconfig KVM
> >
> >         If unsure, say N.
> >
> > +config PROTECTED_NVHE_STACKTRACE
> > +     bool "Protected KVM hypervisor stacktraces"
> > +     depends on NVHE_EL2_DEBUG
> > +     default n
> > +     help
> > +       Say Y here to enable pKVM hypervisor stacktraces on hyp_panic()
> > +
> > +       If you are not using protected nVHE (pKVM), say N.
> > +
> > +       If using protected nVHE mode, but cannot afford the associated
> > +       memory cost (less than 0.75 page per CPU) of pKVM stacktraces,
> > +       say N.
> > +
> > +       If unsure, say N.
> > +
> >  config NVHE_EL2_DEBUG
> >       bool "Debug mode for non-VHE EL2 object"
> >       depends on KVM
>
> Having NVHE_EL2_DEBUG after PROTECTED_NVHE_STACKTRACE is pretty odd
> when you use 'make menuconfig', as the new option appears out of
> sequence.

Ahh good catch. Should have moved it when the dependency got changed.

>
> I'll move it around, no need to respin for this.
>

Thanks Marc.


> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
