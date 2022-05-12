Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF23D52579A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 00:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359066AbiELWLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 18:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359076AbiELWKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 18:10:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E920E28E3F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:10:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x18so6208525plg.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5pINHEZv62I1VVi/6cPBplzqwfW+cUrao+xeCNK719k=;
        b=LCRFLml7xEJRxFGUFkWpJE/kchV+HpiS1oOHDIpBNpG5BsbTuduUCS8YfO5TzpHlYQ
         3ptdU3A+twkT86qLqhKa4sj2dWAb2DwxO+ygJyGzul9PWb4o8o2QQEnlkn/eNhcZT1fi
         D8TFh38oRb8dLnSChfMarF325DLkkTM0oA6oD3ZBj4AqOS3XYntUhjg5ydhZ89fDcgOS
         RMTHM/olvT8e/DciINTCtF9OUhBxwilTni6qAOqfCVgq1wMW9xcGmryBpd5q68GaHUp1
         /BvgYZqfC+ExF2aNI0CBO0X26nEDS6wpORgNp1jK02QYVUyU+jHwF30vNsUnd57Euqvt
         HTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5pINHEZv62I1VVi/6cPBplzqwfW+cUrao+xeCNK719k=;
        b=FbNf4bDtx1EhpgL1k+ve1C5EHXnRGmz4YkDebTl/xvKTGrQ2rXlGIzRBEkFSsqD+rh
         oG6Rb88OeJf29zhFmfSDKNATUkHK3vxkomZ/IOPH6KgAMoY3wemcOAreCjWBq3OY9Kn/
         SyYnhhH7zrjDT0LcFQwfF/mnA3CeWoWqU0Ed/824TC/U4TMhgPCe/niiavhDuQAipG7c
         Vl4Pi5LhkStcp1bO01aaoc7cxwW4ZiG8V/4gA1hX1Tfl/HrhPpvAhVYee/apdbzrB9by
         nmd19IUb5VCntHvl0lV8qwBgyHx/Rqx9fX3yTYlVmiWbCnC/zLdlVoon3SPIZtBzUYcG
         l8AA==
X-Gm-Message-State: AOAM532iguKhY7THk6B/Bc5jEpewFwWr77ZpUS74n8SB5C5445evppxF
        pZ7ngkaKy7rnKa0Ba9csbFgtDDY+bqocDx/IZH4=
X-Google-Smtp-Source: ABdhPJyf6+hXy2q/+T6v2bshm8tdUo6EkuVGShdkL0vzhulsFZI82vRLQGS4bF3INIXlm0R9mB7rjkbvdcUvyPmT7Bw=
X-Received: by 2002:a17:903:1108:b0:156:73a7:7c1 with SMTP id
 n8-20020a170903110800b0015673a707c1mr1653537plh.101.1652393453361; Thu, 12
 May 2022 15:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx> <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
In-Reply-To: <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 12 May 2022 15:10:17 -0700
Message-ID: <CAMe9rOqb6ZnAZYe4uAWDt-vmhhP=z_+uZwi5fBURqyUWxCX9Cg@mail.gmail.com>
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, May 12, 2022 at 2:51 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/12/22 12:39, Thomas Gleixner wrote:
> >> It's OK for a debugging build that runs on one kind of hardware.  But,
> >> if we want LAM-using binaries to be portable, we have to do something
> >> different.
> >>
> >> One of the stated reasons for adding LAM hardware is that folks want to
> >> use sanitizers outside of debugging environments.  To me, that means
> >> that LAM is something that the same binary might run with or without.
> > On/off yes, but is there an actual use case where such a mechanism would
> > at start time dynamically chose the number of bits?
>
> I'd love to hear from folks doing the userspace side of this.  Will
> userspace be saying: "Give me all the bits you can!".  Or, will it
> really just be looking for 6 bits only, and it doesn't care whether it
> gets 6 or 15, it will use only 6?
>
> Do the sanitizers have more overhead with more bits?  Or *less* overhead
> because they can store more metadata in the pointers?
>
> Will anyone care about the difference about potentially missing 1/64
> issues with U57 versus 1/32768 with U48?

The only LAM usage I know so far is LAM_U57 in HWASAN.   An application
can ask for LAM_U48 or LAM_U57.  But the decision should be made by
application.  When an application asks for LAM_U57, I expect it will store
tags in upper 6 bits, even if the kernel enables LAM_U48.

-- 
H.J.
