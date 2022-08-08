Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E91C58CB76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243233AbiHHPpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbiHHPpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:45:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4981E8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AE7C61012
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 15:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98397C43145
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 15:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659973503;
        bh=0+M//WFj4QufhDanyiSvlllCgJP3lcJFBIdND72VH8c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FhbrpMMaW2VUB25O64jvPFojr9qmr2z94jzXHOwlQcZjFoOeD+MqjEAnArO/n1t4v
         3e69NiO/Rw3splQ8Vi6UGj4ihHsI/STjI4gQ4tiNRgENmj/aDlU2hw0Py6Xb4HsRPM
         AMFoPYG9njomAJGUXzxlgvy5s+HP6+xorvEPjhWNLoLO1EAHl2b2nrEk5XweEf5XmQ
         MOh42c1f9tfg5dUf/0H9aiKilYkN+zRoHI2F3RU2x1QgBwERXyhA7AWr2kW89Mp2KV
         EQ0pQwlqVJwr4zQ9HjC2JHvhw5uKq7O0/UbNgchFQQvnU4FZ/OiMxaPQZoTeAAQ5jy
         lB8X0UGSzZTcA==
Received: by mail-ua1-f42.google.com with SMTP id b4so3646065uaw.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 08:45:03 -0700 (PDT)
X-Gm-Message-State: ACgBeo3ZBMeKovryMfQIi+raIPrNY6psBB9xhrmZMQIvIvp7aUhBbP9j
        UMLE095btxtHL1s/oxagZPH8gqeoHK4m0YxLAw==
X-Google-Smtp-Source: AA6agR6mVFjC5VBa80Aifh09hljy1mvccPoQFLhpS0jUnBD7z5E4KFhe92+/ImOsfK5s/YfuXt9X9tMfwqH2jC4zR10=
X-Received: by 2002:ab0:2505:0:b0:384:cc62:9a75 with SMTP id
 j5-20020ab02505000000b00384cc629a75mr7586379uan.36.1659973502267; Mon, 08 Aug
 2022 08:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-2-eric.devolder@oracle.com> <YvCCOY+mRshu1tHi@MiWiFi-R3L-srv>
 <52d40562-ee6f-bb89-6d21-2d6baf67053d@oracle.com>
In-Reply-To: <52d40562-ee6f-bb89-6d21-2d6baf67053d@oracle.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Aug 2022 09:44:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLXGSPzCDUD6sD-CsziPw0PWxSTocNfxnwOGR_-ALos9w@mail.gmail.com>
Message-ID: <CAL_JsqLXGSPzCDUD6sD-CsziPw0PWxSTocNfxnwOGR_-ALos9w@mail.gmail.com>
Subject: Re: [PATCH v10 1/8] crash: introduce arch/*/asm/crash.h
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     Baoquan He <bhe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, kexec@lists.infradead.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Thomas Lendacky <thomas.lendacky@amd.com>, efault@gmx.de,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        sourabhjain@linux.ibm.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 9:19 AM Eric DeVolder <eric.devolder@oracle.com> wrote:
>
>
>
> On 8/7/22 22:25, Baoquan He wrote:
> > Hi Eric,
> >
> > On 07/21/22 at 02:17pm, Eric DeVolder wrote:
> >> The use of __weak is being eliminated within kexec sources.
> >> The technique uses macros mapped onto inline functions in
> >> order to replace __weak.
> >>
> >> This patchset was using __weak and so in order to replace
> >> __weak, this patch introduces arch/*/asm/crash.h, patterned
> >> after how kexec is moving away from __weak and to the macro
> >> definitions.
> >
> > Are you going to replace __weak in kexec of arll ARCHes? I don't see
> > your point why all these empty header files are introduced. Wondering
> > what's impacted if not adding these empty files?
>
> Hi Baoquan,
> In this patchset, to file include/linux/crash_core.h I added the line #include <asm/crash.h>.
> I patterned this after how include/linux/kexec.h does #include <asm/kexec.h>.
>
> For kexec, the items that were __weak are refactored into corresponding asm/kexec.h.
>
> I followed suit for crash __weak items. File crash_core.h now #include's asm/crash.h and
> so that file needs to be present for every arch, else build failures ensue. It turns out
> x86_64 already had this file.
>
> At this time, I was not planning on converting the other arch's __weak to asm/crash.h, but at least
> with these empty files, the infrastructure is in place for when that does occur.

asm-generic is the right location for default asm headers. I'm not
really sure you even need them as you mainly seem to be using the
header to enable a feature. That's normally done by the arch selecting
a kconfig option. But as Borislav previously pointed out, you don't
need a new option here if the arch must provide support when kexec and
hotplug are enabled/supported.

Rob
