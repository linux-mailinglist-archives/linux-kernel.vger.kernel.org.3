Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630D84BAFBC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 03:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiBRCbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 21:31:45 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiBRCbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 21:31:43 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE9613E1D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 18:31:27 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id om7so7341069pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 18:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Wu6EX2h/7tus2P3SDUK9sevuSiL3Agn1W6wGAXlsqI=;
        b=lb/juPy7WIz9nPqhuTaCj4bfy0OpDY2UNK5vYrm82kzUIK8FdpJt2quLU2sFv+tnkK
         j8zCL/0h169TRF0Z4vWrwPgbDC7F9nkU1MzglfvSrEo7hkQTAez/yI9NeFYfQHzRb+Xy
         ZyeFL0/xN8jnp6kQXifbJ+7dJy7kz8WGxrJB2diJ+qqa1ZY7qGGnysgfVC6TFaFssnYZ
         vkWyw8edFjDO/2u8ObVQ9ndVqsnc+lj4s0JDc5NFZHt+a54+Ouc9g+gW6+6H+kf9kKmS
         UsBFiMSwSTaf48onuTR4oOby3DGVY8qMcefEpj30po7ryyBLnvlGpPlcbLJS+3aI5XSz
         8GIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Wu6EX2h/7tus2P3SDUK9sevuSiL3Agn1W6wGAXlsqI=;
        b=0I5GT11PFI69t9Afr0Te+fi9rIL4OJRcjygajUCHCuEcsZyscEPOSuf9WFvxBaWwMc
         BP3aT+dDCFWigSpu8rNO7GwuC9GU3FqjbKTeyw3mGGmPgp24jeY8rRMMIGP6QpYi43Xv
         T3TokU5BBzpOEHme92A8xshKzAifWr90WwkEXemU+32GozQOgs18o+nMNudef9dfpZO7
         Zw0nH5OKqq6MmECDA99Y5aVccvIYw/ZQDsegoaDOJF2RSFmaVCj/nB43vnvE0Rln2yms
         aDcAoPMfYjIXd6CKjmm4//SokVIifeTbrY0RuS3bSSyZeL0d8A8Li2cHxgRkm3lnlfcG
         65fw==
X-Gm-Message-State: AOAM533hcZ2sdQACrnNXpq9F3w8eCJlOrsNEpCIP4kG+j7ljbFKmI/7k
        HNLZRwre/AiGGvAxeH7QvoYNJHBDbwdv0GfoxQ1Vow==
X-Google-Smtp-Source: ABdhPJx/hk6cRTyNEkHuIBj9NQxLPdLKvl2U5F36ETptzkjCC4LEAqWVT4JGu1F+Uxio04Qk4dgVzEkhKAyCuLUuLYs=
X-Received: by 2002:a17:90b:4aca:b0:1b9:ed62:b917 with SMTP id
 mh10-20020a17090b4aca00b001b9ed62b917mr10334314pjb.237.1645151486980; Thu, 17
 Feb 2022 18:31:26 -0800 (PST)
MIME-Version: 1.0
References: <CAPqJEFoUyHiyNj8Hx-wRaw86NLb5hGo-WT4ysqV4RGerYyDyJA@mail.gmail.com>
 <CAM9d7chL4_hY8BLHV=q2J_HJ14gUj07t5QvUvUBOj+4hmvY7hQ@mail.gmail.com>
 <CAPqJEFqJpnq1TF-ZA7Worsy2Yx6au-KHBPkCN0cSnQuyGbwsfw@mail.gmail.com> <YemED+3SzJQR+tZq@kernel.org>
In-Reply-To: <YemED+3SzJQR+tZq@kernel.org>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Fri, 18 Feb 2022 10:31:15 +0800
Message-ID: <CAPqJEFr0zgN2G8B3DVtA0EZwDye0hBjPaaYjV7+TeZ2GSSXmrA@mail.gmail.com>
Subject: Re: About perf tool set exclude_guest = 1 on guest environment
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Eduardo Habkost <ehabkost@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yao Jin <yao.jin@linux.intel.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Fri, Jan 21, 2022 at 5:57 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Jan 20, 2022 at 09:35:59PM +0800, Eric Lin escreveu:
> > On Wed, Jan 19, 2022 at 1:02 PM Namhyung Kim <namhyung@kernel.org> wrot=
e:
> > > On Mon, Jan 17, 2022 at 8:05 PM Eric Lin <eric.lin@sifive.com> wrote:
> > > > Currently, I run the perf command 'perf record -e branches:u ls'  a=
nd
> > > > 'perf record -e branches ls'. It will set exclude_guest =3D 1 as be=
low:
> > > >
> > > > # perf record -e branches:u ls
> > > > # perf evlist -v
> > > > branches:u: .., exclude_kernel: 1, exclude_hv: 1,, exclude_guest: 1=
, ..
> > > >
> > > > # perf record -e branches ls
> > > > # perf evlist -v
> > > > branches: ..., exclude_guest: 1, ...
> > > >
> > > > As I understand it, set exclude_guest =3D1 will not include guest c=
ounting.
> > > > May I ask if I run the above commands as a guest user, should the
> > > > architecture implementation ignore this exclude_guest flags and sti=
ll
> > > > make perf can count guest events in Linux kernel?
> > >
> > > So do you want to run the command in the host?
> > > Then you can use both 'H' and 'G' modifiers like
> > >
> > >   # perf record -e branches:HG ls
> > >
> > > or (for user-mode only)
> > >
> > >   # perf record -e branches:uHG ls
> > >
> >
> > Actually, I want to run the commands in the guest.
> > But when I run the commands "perf record -e branches:u ls" and "perf
> > record -e branches ls", it will set exclude_guet =3D 1.
> > According to the documentation[1] exclude_guest definition, it should
> > not count guest events.
> > So, if I run these commands as a guest user can I get the profile data?
> >
> > [1] https://man7.org/linux/man-pages/man2/perf_event_open.2.html
>
> The tool shouldn't know that it is running in a guest, right?
>
> And the kernel, running on a guest should exclude its guests if
> attr.exclude_guest is set, not itself and its non-guest userland.
>
> So, before delving into how the kernel running on guest _actually_
> handles attr.exclude_guest=3D1 behaves, what are the results you are
> getting from running perf on a guest?
>
> Lemme see...
>
> On a fedora:35 guest:
>
> [root@fedora ~]# perf record ls
> anaconda-ks.cfg  perf.data
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.014 MB perf.data (3 samples) ]
> [root@fedora ~]# perf evlist -v
> cpu-clock:pppH: type: 1, size: 128, { sample_period, sample_freq }: 4000,=
 sample_type: IP|TID|TIME|PERIOD, read_format: ID, disabled: 1, inherit: 1,=
 mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, samp=
le_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_eve=
nt: 1
> [root@fedora ~]#
>
> IIRC there is some extra magic to allow 'cycles' to be seen on the
> guest, but apart from that it seems to work.
>

I did the same experiment on an x86 kvm guest, and I got the same result.

Here is my understanding about the exclude_guest flag and how the
kernel handles it.

Consider there are two situations that the user executes perf
commands, one is on the guest and another is on the host environment:
When a user is in a guest environment, it launches a kvm guest on a
guest environment. Then the user executes a command `perf stat -e
cycle:u ls` or `perf stat -e cycle ls`, the exclude_guest flag is
raised and the kernel will exclude the kvm guest that the user
launched, not the user's environment itself.

When a user is in a host environment, it launches a kvm guest on a
host environment. Then the user executes a command `perf stat -e
cycle:u ls` or `perf stat -e cycle ls`, the exclude_guest flag is
raised and the kernel will exclude the kvm guest that the user
launched.

Is my understanding about the exclude_guest flag and how the kernel
should handle it correct? Thanks.

Best regards,
Eric Lin

> Eduardo, can you help us here?
>
> - Arnaldo
