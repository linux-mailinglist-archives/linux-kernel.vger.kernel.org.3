Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC915AEBC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbiIFO0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241220AbiIFOUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44C98D3C1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662472214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fF/McEgJ2IGT8zNYV5Anr2pyXDPQdaP/ZefdLv4zi5k=;
        b=Vf2Ozewp5nWr04BPuvlrFV6mI1KEOFK/XWOo39cAWev7V8hbKxSE+j8J1lSg8T/W9Pxz/A
        +QvkAhq1BFYLWSGTUEG12l0rvCVvqc7RcTx8lJ7WbaCXhnCv0YO1sy/82zV+jLUiXmCgKz
        GK1ojGbaKtQtJPgi1iuxkdGr9xhVg/U=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-436-7qcS8SLGOPm4Kcto4uoTmg-1; Tue, 06 Sep 2022 09:50:13 -0400
X-MC-Unique: 7qcS8SLGOPm4Kcto4uoTmg-1
Received: by mail-pg1-f200.google.com with SMTP id k62-20020a638441000000b0042b66a99b6aso5799866pgd.18
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 06:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fF/McEgJ2IGT8zNYV5Anr2pyXDPQdaP/ZefdLv4zi5k=;
        b=wt1x02qn8imL4Z+IJ5GdKAQmjP5JqVV9nxtvYDCKsc55UO7VFeMBBCgnMIKbMGwi/h
         IXFsuwBpKljkYQPqKtOWukIt3AtxFr4xGzEIVgTd+gaUbtwAa30jjT0a3uX/Zu2Z7n1p
         /E70FtptuoPdtOeyLBOrvT07l+JD93oZIfSZxdnbKauY6K6shioZilK17E901d/ZOfMh
         dkTEZ3164tVNUYyBuEFtwNfO2jBByDOlDBlM0DdpYJSyQFn+duVGjxjqbbNBSU/LYBvT
         Ws7kRN4GkPQwHKVEdFRL2pJGQ/7tiUxnWRl+87JDXeYC/0hKeTn5vvT/CXZYjRdk0zEk
         Bckg==
X-Gm-Message-State: ACgBeo2P8pU65KN/YIFff4KebWPicQE16yD+hSnQfUsaKDAwilPydd93
        RJIHFP3bTvV9TuPYte1l0CNLO8i81Z1daunsgVi2tZqP/WLP2H/MgTJqSxWvttqqJi/Y/4dYxdZ
        CP0CEY67ZYcCKmgXRmnWM3JkzTzNEU1b0Fp2RTJzu
X-Received: by 2002:a63:125b:0:b0:434:6fb1:660e with SMTP id 27-20020a63125b000000b004346fb1660emr6591740pgs.489.1662472212074;
        Tue, 06 Sep 2022 06:50:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6fpX4ksRwNdiWB8H8btCxoSm5yD30eQEDR5VMy+1tR5Dy84nsIw3fRbEfb3k43eyQqvvFdzBBzDMPFKfIuvA8=
X-Received: by 2002:a63:125b:0:b0:434:6fb1:660e with SMTP id
 27-20020a63125b000000b004346fb1660emr6591709pgs.489.1662472211764; Tue, 06
 Sep 2022 06:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220902132938.2409206-1-benjamin.tissoires@redhat.com>
 <20220902132938.2409206-2-benjamin.tissoires@redhat.com> <CAP01T75KTjawtsvQmhZhj0=tEJVwc7UewRqdT1ui+uKONg07Zw@mail.gmail.com>
 <CAP01T74zEuSfTYhkKieU1B5YwzdXhKWxPX55AabV84j-=virwA@mail.gmail.com>
In-Reply-To: <CAP01T74zEuSfTYhkKieU1B5YwzdXhKWxPX55AabV84j-=virwA@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 6 Sep 2022 15:50:00 +0200
Message-ID: <CAO-hwJLBtjfU7NWVTRK8HKmATuSb3ZSY__+OOMZhqY85DeQbWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 01/23] selftests/bpf: regroup and declare
 similar kfuncs selftests in an array
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 5:27 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Tue, 6 Sept 2022 at 05:25, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > On Fri, 2 Sept 2022 at 15:29, Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> > >
> > > Similar to tools/testing/selftests/bpf/prog_tests/dynptr.c:
> > > we declare an array of tests that we run one by one in a for loop.
> > >
> > > Followup patches will add more similar-ish tests, so avoid a lot of copy
> > > paste by grouping the declaration in an array.
> > >
> > > To be able to call bpf_object__find_program_by_name(), we need to use
> > > plain libbpf calls, and not light skeletons. So also change the Makefile
> > > to not generate light skeletons.
> > >
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > >
> > > ---
> >
> > I see your point, but this is also a test so that we keep verifying
> > kfunc call in light skeleton.
> > Code for relocating both is different in libbpf (we generate BPF ASM
> > for light skeleton so it is done inside a loader BPF program instead
> > of userspace).
>
> Err, hit send too early.
> We can probably use a macro to hide how program is called, then do
> X(prog1)
> X(prog2)
> in a series, won't look too bad and avoids duplication at the same time.
>
> > You might then be able to make it work for both light and normal skeleton.
> >
> WDYT?
>

On this patch alone, I concede the benefit is minimum. But if you look
at 6/23, I must confess I definitely prefer having just an array of
tests at the beginning instead of crippling the tests functions with
calls or macros.

The actual reason for me to ditch light skeletons was because I was
using bpf_object__find_program_by_name().

But I can work around that by relying on the offsetof() macro, and
make the whole thing working for *both* light skeleton and libbpf:
+struct kfunc_test_params {
+       const char *prog_name;
+       unsigned long int lskel_prog_desc_offset;
+       int retval;
+};
+
+#define TC_TEST(name,__retval) \
+       { \
+         .prog_name = #name, \
+         .lskel_prog_desc_offset = offsetof(struct
kfunc_call_test_lskel, progs.name), \
+         .retval = __retval, \
+       }
+
+static struct kfunc_test_params kfunc_tests[] = {
+       TC_TEST(kfunc_call_test1, 12),
+       TC_TEST(kfunc_call_test2, 3),
+       TC_TEST(kfunc_call_test_ref_btf_id, 0),
+};
+
+static void verify_success(struct kfunc_test_params *param)
 {
[...]
+       struct bpf_prog_desc *lskel_prog = (struct bpf_prog_desc
*)((char *)lskel + param->lskel_prog_desc_offset);

However, for failing tests, I can not really rely on light skeletons
because we can not dynamically set the autoload property.
So either I split every failed test in its own file, or I only test
the ones that are supposed to load, which don't add a lot IMO.

I'll repost the bpf-core changes only so you can have a better idea of
what I am saying.

Cheers,
Benjamin

