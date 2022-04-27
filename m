Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62A0511377
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359390AbiD0IbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359384AbiD0IbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:31:02 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1CC37A95
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:27:52 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id e12so1990055ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=waqMF3/+jBkXSAMHa/4juRRN3TjD0wPV8HITfW07pmM=;
        b=TVxN/Mw2C6wNn1nlB9R2nUDCaA8o5XlpjdPJHdCjvoWdU92d59JP7Atc+ZLOjFQbne
         x9pKtH7s0o/Nt31G0K5f+roqep0gyI5w49psWljWaum+BF8EurMkrx2tjoebWDHaMNSx
         6yYT+Kog9oGk2OI4DRvfBPWQTPNA5fC8XaJSlPzc1I7tEczpHuRqk/arQD0QKaaMaNrW
         IDPZqrlYHc4Wgk5l3kd6C5RkdGpLO9kaK8veoKOclPNSbqAXa/5XaoeKpX3DX8J/BM0h
         j6GoIbCS4DrYookYPSlfi2WOYxVIDeClO0iVN7rKh03KgiTkPjvXt1dsZmPJ0Z11f9gt
         3xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=waqMF3/+jBkXSAMHa/4juRRN3TjD0wPV8HITfW07pmM=;
        b=ZLJr0YYq+QW0dgaLs2BPUX4REEgxhZOMGgSiMws+efyuF2NOGdFuWTLkGjceXf0olo
         X6gJRbs7hK33HUfcybl4a0PrGi+1j+b80rClmfIQFQ/mQsbnV3JbGrIbxrNhwJFlzdVX
         qjz27XwI7k7Pc9exMyAJlheCCSnqucGKwTjp9ALPW6J2BvyiYCZtRl9jbpVk4VZAZLW/
         B9w6OSipYLDo2ySo99pjn//nxwP29IeFmT3RzAz4EEUYrLC8DtrKeuLYuyNt2vshJAdH
         E8j9f0kwO4gl/G9FLqIaoHTCKoV4vdCuQ1tLhomvxWgpfMe76yCPOzQWX+vtqlOvjV4A
         4yrw==
X-Gm-Message-State: AOAM530czhvcf8NqwZZPqjW1Ptd/bebY/1bNSCCNOQD1hkVmrANOYX6N
        duUhqbATl5f5aUY2q2jto7kOURmBn/Ee3YuwwTqP+Pf9EPY=
X-Google-Smtp-Source: ABdhPJyBrXvKCOcYiAA6x0cCl09ltI73httWyAVtbC4Y5iYG9xqkb2QJCmHbk5GJo7Q34cVVprKsvLnNXLEnA/jqse0=
X-Received: by 2002:a25:8b03:0:b0:628:8cff:ed6c with SMTP id
 i3-20020a258b03000000b006288cffed6cmr25109981ybl.513.1651048071760; Wed, 27
 Apr 2022 01:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220412124909.10467-1-jiangshanlai@gmail.com>
In-Reply-To: <20220412124909.10467-1-jiangshanlai@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 27 Apr 2022 16:27:38 +0800
Message-ID: <CAJhGHyAbSSUnfvDJ1dO2Z56=eRWTj2Ren_mZhGJMHFSPZSjqtg@mail.gmail.com>
Subject: Re: [PATCH V2] x86/sev: Mark the code returning to user space as
 syscall gap
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 8:48 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> When returning to user space, the %rsp is user controlled value.
>
> If it is SNP-guest and the hypervisor decides to mess with the code-page
> for this path while a CPU is executing it.  This will cause a #VC on
> that CPU and that could hit in the syscall return path and mislead
> the #VC handler.
>
> So make ip_within_syscall_gap() return true in this case.
>
> Cc: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>



Hello

Ping.

Thanks
Lai
