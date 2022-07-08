Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F3F56B44D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbiGHIR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiGHIR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:17:26 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B698049E;
        Fri,  8 Jul 2022 01:17:25 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id fd6so25975658edb.5;
        Fri, 08 Jul 2022 01:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qT5deAffqTtZVxgvmEojgmp/7PC24g9Y8IJXNXkYP7A=;
        b=ZtYZ4uaxxrkdNypbBx4J9maRKQcdhKkeHfZJBpaBMaGEC5sTp9G2DTYL4wv+jnJAUe
         SLuqhXjOQ4dsryS2YBSFsxFYP9v+EZumTBTdoRdB9YFTk/YweeZvaFCPyfji2+fdheAC
         peq/t/nbElA8B1AMy8k47w8A3KBH4GaSA8YaNtpotno2fkakeD4jThqSQ0x7PEMq1utl
         W260KX4edalLtv/xT7dac16TVmYzdDWKw7Fe4SEXnZ0R4dlF+LieKvtZI0qkV5uYiM9o
         0rVxKTIeYrI0Nm2I4JWNhnOOsVesa0PgJ1kxpN/A5kOSgZ73DPsrV0+QiAbJCU9yIpkK
         8q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qT5deAffqTtZVxgvmEojgmp/7PC24g9Y8IJXNXkYP7A=;
        b=a+BNqQyb59xj5ygebsdifokVNKQ05/ViI1JbyAm+xyY0kDd5XQFiioxcSlLfAVGiyR
         aE++uwWpll5SWuMwcOClMbFwZplX2b3dQzy3BSW0gxWQh4tWLPgNlta+o3bDwWHJy5t5
         KlgmmhQr/E2AJlK4iYd1jhSvKKoy1NH8N/HzHY4uLI//KAI2qdV2UpecXsPffDsoEeRQ
         diSAr+QE0RsPWZ3E1fK0OCbbqSYonPISFuvjv/gU5OmLBHGqxsNsiyOHfDEpnyHeJ1Wv
         yK8vX/4W2EybAi4IyS9xwTR+SAOE1hEX8vd+wGQsOdDWg4zan32wjbeJmTtkI6HiQjNa
         g6bQ==
X-Gm-Message-State: AJIora+o3QLEO0ko81qmgtw6Fvcj5J7P12MopBMhtMwNSQSTi8+mRt2r
        9Tq5ZaIRD0nXbUHAWk5PK9U+SAiq214TmsUZZqo=
X-Google-Smtp-Source: AGRyM1vkB8bZoNSx6FI2z+hieyN/8K1faoFYu+2IGNBNHn+eOjLS1BKR/WS6kB64rbf9X/xQaPlguTIEyWulWTirYPI=
X-Received: by 2002:a05:6402:42cb:b0:43a:5df2:bb5d with SMTP id
 i11-20020a05640242cb00b0043a5df2bb5dmr3192234edc.36.1657268243904; Fri, 08
 Jul 2022 01:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <67943544-6DAA-4C8A-A04D-029D2D36C318@vmware.com>
 <20220708065957.3859-1-21cnbao@gmail.com> <EE0C38ED-A213-4F5C-9F87-FD90E5035C21@vmware.com>
In-Reply-To: <EE0C38ED-A213-4F5C-9F87-FD90E5035C21@vmware.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 8 Jul 2022 20:17:12 +1200
Message-ID: <CAGsJ_4wp03dV0JqRk5NiSSEwPxvMH7z3SE0FhX8Dc8DjDPuVyw@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: rmap: Allow platforms without mm_cpumask to defer
 TLB flush
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
        "guojian@oppo.com" <guojian@oppo.com>,
        "huzhanyuan@oppo.com" <huzhanyuan@oppo.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "lipeifeng@oppo.com" <lipeifeng@oppo.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "realmz6@gmail.com" <realmz6@gmail.com>,
        "v-songbaohua@oppo.com" <v-songbaohua@oppo.com>,
        "will@kernel.org" <will@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
        "zhangshiming@oppo.com" <zhangshiming@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 8:08 PM Nadav Amit <namit@vmware.com> wrote:
>
> On Jul 7, 2022, at 11:59 PM, Barry Song <21cnbao@gmail.com> wrote:
>
> >> The cpumask_empty() is indeed just another memory access, which is mos=
t
> >> likely ok. But wouldn=E2=80=99t adding something like CONFIG_ARCH_HAS_=
MM_CPUMASK
> >> make the code simpler and (slightly, certainly slightly) more performa=
nt?
> >
> > Yep. good suggestion, Nadav. So the code will be as below, right?
>
> Hmmm=E2=80=A6 Although it is likely to work (because only x86 and arm wou=
ld use this
> batch flushing), I think that for consistency ARCH_HAS_MM_CPUMASK should =
be
> correct for all architectures.
>
> Is it really only x86 that has mm_cpumask()?

i am quite sure there are some other platforms having mm_cpumask().
for example, arm(not arm64).
but i am not exactly sure of the situation of each individual arch. thus,
i don't risk changing their source code.
but arm64 is the second platform looking for tlbbatch, and
ARCH_HAS_MM_CPUMASK only affects tlbbatch. so i would
expect those platforms to fill their ARCH_HAS_MM_CPUMASK
while they start to bringup their tlbbatch? for this moment,
we only need to make certain we don't break x86?
does it make sense?

Thanks
Barry


>
