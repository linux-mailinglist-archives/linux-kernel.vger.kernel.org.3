Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50C85150BB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379062AbiD2Q31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379061AbiD2Q3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:29:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EE4D5578
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:25:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 125-20020a1c1983000000b003941f354c62so1251431wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U7GwZfxNxCr20dXvniV2zLTxrd1PMEcbQZAO6v8SYLo=;
        b=D7hRSRGysLF6b/+lZGfGwGJW36LZtjnuaVsdT5g70KMJgcqMMC+FEhfKVUsaq/1da7
         IIbDQ1woP6gkqB9YFFVt2Z1ekn7gRvOn9m2dz899A2gF6FBaNoF1biSy4iaquXh+4IUI
         xntEIqq+rBOCXSEXbyXmRDWy5DyPF+oOtEp/tojXXdC7ZGUPgtjmAO4F67MHFK+pFHeC
         HyHxG3Xm7Kn0NTU2juRmrQhnIzj4auuTvurfUW7+ntOkSEzMWmLm6nRn/linRhkY58ae
         ouvIrvB+0vzZ6/h+haYPYB9L3MeD9Z6QO4u+RuQmqgtb/2egseSjMnCQAh+JCe3q1Iez
         W0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U7GwZfxNxCr20dXvniV2zLTxrd1PMEcbQZAO6v8SYLo=;
        b=hdZe0GjD6BL7w/Jk3SGXYakjFjePVcKZjSWOzv+z1m/IqXuWe/LDnp+orIFo0i4RdL
         BZ3EH3nliAdDZyC9qB/L3Jg0rMwEx56l7pQSH+S5aRyy9062zH1u3Pqc4pNeaYvkZhzs
         gPrzqClXRVYqF137FgyjFNUne8wPkq2a7gTL0+IiMYYB7F1cTNU2o5WU9dquOYof9NUO
         kvHgMa4HlVu0XEQ3HPReuBNJkABMSWjIDHT78LGtjFbg1GVB4RvJd+ZOd3kNb0H8cYqi
         Cm5IIZYLcihRDsfxMSUylxU2bvYGE2oT1ZObgKKD/Q+f+qjp0vwD1SVcWyklop1ANRwk
         IfIA==
X-Gm-Message-State: AOAM532kB2sa9DvYpl8Glm93IxiDytSou9IDB4KBJHFpEf6Q1s4SI4+7
        2B3wtaV+6SH8fSCSos+5Ld/7tSv3aomczm3ziw9L4Q==
X-Google-Smtp-Source: ABdhPJxhLzTgLf/Ks/AB0pes6BWh4ozeKIdS874CsMwC+xluHukgX/fubue2dWWqxRl4fMNT+Iw0yiN5ImWbON3APeU=
X-Received: by 2002:a05:600c:4f93:b0:393:f08d:a048 with SMTP id
 n19-20020a05600c4f9300b00393f08da048mr4023212wmq.158.1651249557596; Fri, 29
 Apr 2022 09:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220427184716.1949239-1-kaleshsingh@google.com>
 <20220427184716.1949239-2-kaleshsingh@google.com> <YmveXly9117jbWKr@sirena.org.uk>
In-Reply-To: <YmveXly9117jbWKr@sirena.org.uk>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Fri, 29 Apr 2022 09:25:46 -0700
Message-ID: <CAC_TJvfm0ndtQSPt-gqYmzA-Q51MY6Eu1Gk3MxvCm+VqgtvCOQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: arm64: Compile stacktrace.nvhe.o
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
        Zenghui Yu <yuzenghui@huawei.com>,
        Keir Fraser <keirf@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, Apr 29, 2022 at 5:47 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Apr 27, 2022 at 11:46:56AM -0700, Kalesh Singh wrote:
>
> > Recompile stack unwinding code for use with the nVHE hypervisor. This is
> > a preparatory patch that will allow reusing most of the kernel unwinding
> > logic in the nVHE hypervisor.
>
> This is substantially more than just the build change that the changelog
> would seem to indicate...  it would I think be clearer to split this up
> further with the code changes separated out and explained a bit more.
> It's not just recompling the code for nVHE, there's also refactoring to
> split out changes that don't apply in nVHE hypervisor like all the task
> related code which is needed but not mentioned in the changlog at all.
> Possibly a patch or two for the code motion then a separate patch for
> the ifdefs and build changes?

Hi Mark,

Thank you for reviewing. I agree - will split this into more
incremental patches in the next version.

Thanks,
Kalesh

>
> I *think* the code is all fine but I'd need to go through it a few more
> times to be sure I didn't miss anything.
