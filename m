Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BD94FE222
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355633AbiDLNQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356731AbiDLNOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:14:07 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5FC5599
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:00:24 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i20so11767239ybj.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gF2cl5RInkAztfUncbBifVXypH97fQxX/qYG05vFGDQ=;
        b=Lsevu59fPR/V8RV00Pfzmbc2h9Jb1UrgFOdLFtvzhVRR4kBNRYCxzqCVF8AHfAM2zN
         pcKiQM6I/GuChhwnJuhCCwcumqZYtCOFSD7Zqgv8Yfo7CZtXDcQaWhUhCxCXLJWH+wdf
         2qRHOSArHtaHUxMl2SFfzcZXQPQhbZxZkNtBYlTSjvXtFY0niqlINMhb7LKAZ/JDwD3P
         swl4IDu6rw+/moJXoyXwlxLbYuHtlT5jM5PbFEzjvlRjyxGaxFBmyQ3IOs63s13E+owm
         4gqS++HmHStAftBZZTsu5sFZP+l72BH2lYKgI3OvuldEWFY13n9hsfE7Yc6cRez359es
         QS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gF2cl5RInkAztfUncbBifVXypH97fQxX/qYG05vFGDQ=;
        b=PHuyJHFa7XFI/Jd8Hy1pguWTJNYQRORHqoCLKHbC5IDyij8NhSY2LrtoEZQd9BjD5j
         1X3qVw+9307x+rDnqwU0aDd5UFWy/jIcDWvKNUvklQPyR+py+cSpBY8ZTa4339+5rJia
         Nrd7E0MEvWl6CEPt/qVBN9mBQVGX9F8e4RNuetrIURSfe40UtLYWkSDYS1l2FYCrdV06
         JSesp1q8FDoZQeHXTc/uypeSZGTK/g2/jwNKiP+qX69kt3WWGXak1jP7LOYwgmV3wLU+
         6IVYDw0bjBu6UjwVHtZ3Xa3Jr8sJW/HuDDhmvXNqGYdYvc7JGtIbE5jsT5TuLTIIpAfp
         hQ9g==
X-Gm-Message-State: AOAM5320L+woTj4jDWO9FYNh+Ja9fgUeN9nD2SIp63CQWueg8IIyZpNP
        hf/O/zRBAMy9N9APsrJgifRA1dxl2+KpvMjdf24=
X-Google-Smtp-Source: ABdhPJyXkslkUxKLzZHWEk9t//+nZPCUDaPUtfvR5wpAp2mfBLNHVct36eTkBMWeHckvn5jU5LzwPobGd1tmzsDfcsk=
X-Received: by 2002:a25:d207:0:b0:641:5458:207e with SMTP id
 j7-20020a25d207000000b006415458207emr7565977ybg.552.1649768423731; Tue, 12
 Apr 2022 06:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211213042215.3096-1-jiangshanlai@gmail.com> <20211213042215.3096-4-jiangshanlai@gmail.com>
 <YbkR36Vpb1h5SlMZ@zn.tnic>
In-Reply-To: <YbkR36Vpb1h5SlMZ@zn.tnic>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 12 Apr 2022 21:00:12 +0800
Message-ID: <CAJhGHyAFQLgGM-Lxn_DWeQWYuy+42hC7wtxSG3tFHE0brJJqPw@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/sev: The code for returning to user space is also
 in syscall gap
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
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

On Wed, Dec 15, 2021 at 5:51 AM Borislav Petkov <bp@alien8.de> wrote:
>
> + Tom and leaving the whole mail un-trimmed for him.
>
> On Mon, Dec 13, 2021 at 12:22:15PM +0800, Lai Jiangshan wrote:
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > When returning to user space, the %rsp is user controlled value.
>
> And?
>
> I'd expect to see here some text analyzing the couple of instructions
> between those new labels you've added and whether a #VC can happen
> there.


Hello, Borislav

I resent the patch with an updated changelog mainly copied from
Joerg's reply.

https://lore.kernel.org/lkml/20220412124909.10467-1-jiangshanlai@gmail.com/


The other two patches in this patchset are omitted since they
make less sense which only harms only when the system owner
is deliberately doing stupid things.

thanks
Lai
