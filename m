Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B97053573B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 03:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiE0BB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 21:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiE0BB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 21:01:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E36BCFE24
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 18:01:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c93so2359457edf.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 18:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=46Dlx32NeqKGFqR8tbrXUNfX16XzYXTLkkklq3uKPP0=;
        b=Q11Qs/nvN2wel2x5/i/9VjArjDYQjfKrAZ+fhH/W0+KOWfFkEi/xS/zr9F6Tq6iBgs
         vhx5bOOVc7xCOcb5Y6zHvq4ZRFL42ey5ZrtXhP+EU+URraJZWaUSgEA5RJnwtVYsMysC
         yn3a5qeWCuEq/69pgfEjfFTs28A35NpOfm5aQ5ENPMSeYfS4ux7exnMnt+GWLAPgNrYO
         0hC7dFiPIKOB0JsnNy+AJPt4PNXns5ApBk2/EJmFsbAhveW5OwRgTnk/ikhvTrknIsP1
         F7wWduPV44+NCTh+FR0e+bd4vuVoLXPdwj1HRfSEejgFyZky9MqwfvagfFkM8aFwC3m7
         CszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=46Dlx32NeqKGFqR8tbrXUNfX16XzYXTLkkklq3uKPP0=;
        b=TonpKLIYgqqbhTuZisVtYgLXK7IJR7KGi15QMJptdefL+Z+n6pJX3+4r9fzui1K2S3
         kVzU5mts1d149cieCnzAuZ8s3Gw/SIGUZG/881QCOczHOpI2aQXaEYXZU/6VOm3AbpcY
         V43qZRQojux/NKGUfsKVLZs+/NPQa2dtjkS9vFFwkJvOZjfmq2S77wvD6IiauaMlKSmm
         IM1vTxO3oM1lVuhTI3phMbE6brG52Qm9GA8m2+13M5HFle7IeKOvwsa+GOqEMkV9YwDj
         d2h7r9qczoIFZMKen7CkkxrCS5R5ocdnGykDzRIMFKMgC7g1O8HOSvUns8JOMNhjDkib
         ET3w==
X-Gm-Message-State: AOAM531n8zF5KJfepfGuXovLivtMUP1oHhZ2IGgiffGqcTp1rKjG996f
        aA7vL1cSdUC6siGK9sIBWoi8SQpqbuSZnH6dkCceqg==
X-Google-Smtp-Source: ABdhPJzRjJTDQK+bBD15s7scpx9HyVQTqofCpMUjlIpasp2u1sdBEATucuvbfQWL88rbQkvEdRAKHxEstZEb/x+fbGY=
X-Received: by 2002:a50:ea8b:0:b0:428:7d05:eb7e with SMTP id
 d11-20020a50ea8b000000b004287d05eb7emr41396599edo.185.1653613310665; Thu, 26
 May 2022 18:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220526203805.3659597-1-tatashin@google.com> <CA+CK2bDkKzp6uvy+f09K=COd3xn+EDa5nEu2j2o7Vyhd=aG0AA@mail.gmail.com>
In-Reply-To: <CA+CK2bDkKzp6uvy+f09K=COd3xn+EDa5nEu2j2o7Vyhd=aG0AA@mail.gmail.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 26 May 2022 21:01:14 -0400
Message-ID: <CA+CK2bAKiJzMB_=TFKa=KC0pKaT2N3qgHnKSnZCU99hB=e+_LA@mail.gmail.com>
Subject: Re: [PATCH] kexec_file: Increase maximum file size to 4G
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, rburanyi@google.com,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 4:45 PM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Thu, May 26, 2022 at 4:38 PM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > In some case initrd can be large. For example, it could be a netboot
> > image loaded by u-root, that is kexec'ing into it.
> >
> > The maximum size of initrd is arbitrary set to 2G. Also, the limit is
> > not very obvious because it is hidden behind a generic INT_MAX macro.
> >
> > Theoretically, we could make it LONG_MAX, but it is safer to keep it
> > sane, and just increase it to 4G.
> >
> > Increase the size to 4G, and make it obvious by having a new macro
> > that specifies the maximum file size supported by kexec_file_load()
> > syscall: KEXEC_FILE_SIZE_MAX.

It appears that since:
f7a4f689bca6072492626938aad6dd2f32c5bf97
fs/kernel_read_file: Remove redundant size argument

Introduced a change to  kernel_read_file to limit the maximum file
internally from SIZE_MAX to INT_MAX.

Therefore, more changes will be needed. I will work on them and sent them in v2.


> >
> > Signed-off-by: Pasha Tatashin <tatashin@google.com>
>
> Should be instead:
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Thanks,
> Pasha
>
> > ---
> >  kernel/kexec_file.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 8347fc158d2b..1be2227b33e6 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -31,6 +31,9 @@
> >
> >  static int kexec_calculate_store_digests(struct kimage *image);
> >
> > +/* Maximum size in bytes for kernel/initrd files. */
> > +#define KEXEC_FILE_SIZE_MAX    (4UL << 30)

Also, I will address 32-bit, with picking minimum between SIZE_MAX and
kexec max file.

Thanks,
Pasha
