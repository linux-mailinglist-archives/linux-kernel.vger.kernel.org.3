Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB4451A4E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353063AbiEDQGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiEDQGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:06:18 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E8D15728
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:02:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so1112388wmn.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 09:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kO7qnx1Xqmu4DTD9ZcMD0gBbZfcRWt3UHYqgmw5RRmo=;
        b=Uoq+oA6kCO+OfEGFjCjYfU6owqHFW/6uuJJ0H7lJFwoo877iwo4q1BKeCwlxbMlnFD
         HrPqOqakLwgWUHpect+AHNXyT9CjssbCwV0BkKOsOz06UViZ80rZdayeXGvjhzIr2Vlt
         AP6bsFESQPVV82h6Mb4v4iYaWkr3weVKmV62+yLiGi1I2EzaK95tF7W6jbD/XaxgkYlK
         0/Gr3VnwDTjNeFheBC5hKvnDmiLK9SIOu6bH2fISS7YUP0asoWXXkRUN3pAXV6ySq3Vv
         5n6HxKCryKATu1TtPgq6gw62JUxp5dYF5M4Qeqt2gXCibnb4oqDmi72w6bOll+4EXAcr
         7ikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kO7qnx1Xqmu4DTD9ZcMD0gBbZfcRWt3UHYqgmw5RRmo=;
        b=eO7PQbvz3J1WXwcOzmRPN04oxdBROxHPhupxuLgzNF4Qs/eVW22/vDiBsehGKsjZec
         9F7U4Yka7u6IpaRr1AVrDP1rIOo/qOcnF/1VPtaRJIBVOEtOAiGOOFPVk0KY2s1gFOwy
         GZTUF+LpRrmu1wKmWDHfjng726k1+FDdDOa3aOMMTF3A9bA8iODjW+LSKcgDn1x2dM/G
         oB74pBg9Z453AnTdY/E91DG1Eyj8fm/i2Jd8o4DdEoH3TkMTMbFvHXOg0VJE/P44NlU4
         jX8jGLji5yilk+b7DHSQEUhwwvOD09cry72LuCUbj8npttmbb7+CEayWBYDrd8ha/vYo
         HzXA==
X-Gm-Message-State: AOAM532b+4KnzyVmSMBbHSwmeLvrSowKJjiAcw1sslFXivO31Nl0RMJy
        8GgVbiGK7kbQifZxedkJ3z9ZFVYOW1ZxK9zROVCntQ==
X-Google-Smtp-Source: ABdhPJxRKbW0nGe4qEM+/yFmAHEZ2p2lUWe6rRExJqJLSFhXadzsjcNe1S07pRkToh4blRMr1KAvy65FxTxywp/v26M=
X-Received: by 2002:a1c:e916:0:b0:38e:ac96:f477 with SMTP id
 q22-20020a1ce916000000b0038eac96f477mr115168wmc.160.1651680160228; Wed, 04
 May 2022 09:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220502191222.4192768-1-kaleshsingh@google.com>
 <20220502191222.4192768-3-kaleshsingh@google.com> <YnKK2IxdbVvcsOC2@sirena.org.uk>
In-Reply-To: <YnKK2IxdbVvcsOC2@sirena.org.uk>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 4 May 2022 09:02:27 -0700
Message-ID: <CAC_TJvcqRd+t8y75Z6+CAoDtADAH0yEFWo1CHhGz7wYxubM7-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] KVM: arm64: Compile stacktrace.nvhe.o
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Jones <drjones@redhat.com>,
        Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, May 4, 2022 at 7:17 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, May 02, 2022 at 12:12:02PM -0700, Kalesh Singh wrote:
>
> > Recompile stack unwinding code for use with the nVHE hypervisor. This is
> > a preparatory patch that will allow reusing most of the kernel unwinding
> > logic in the nVHE hypervisor.
>
> >  enum stack_type {
> > -     STACK_TYPE_UNKNOWN,
> > +#ifndef __KVM_NVHE_HYPERVISOR__
> >       STACK_TYPE_TASK,
> >       STACK_TYPE_IRQ,
> >       STACK_TYPE_OVERFLOW,
> >       STACK_TYPE_SDEI_NORMAL,
> >       STACK_TYPE_SDEI_CRITICAL,
> > +#endif /* !__KVM_NVHE_HYPERVISOR__ */
> > +     STACK_TYPE_UNKNOWN,
> >       __NR_STACK_TYPES
> >  };
>
> I don't immediately see a problem with it but I'm curious as to why
> STACK_TYPE_UNKNOWN got moved to the end of the list here?  It does mean
> that zeroed memory will default to STACK_TYPE_TASK but we're not
> actually relying on that.  Otherwise

Hi Mark. Thanks for the reviews.

STACK_TYPE_UNKNOWN was moved to the end purely to group the common
enum values. Not a functionality change as we don't reply on an
uninitialized stack_type

Thanks,
Kalesh

>
> Reviwed-by: Mark Brown <broonie@kernel.org>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
