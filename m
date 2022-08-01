Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECDD586C73
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiHAN7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiHAN7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 837D525C5D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659362343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eXxFDNHmW1eO0dHBvosAP+F5NsGPg4Gs2jo3HyEeOm4=;
        b=elBnH3m4Mc/5raaQ++OPBqwdsc40LXyyekriiAY3EdthBd7jxOhQrdUkFaNnS8A5EEP9DI
        iWvW+4YxuXSmhy0zV9+xz/IJ4NZK2r8uE5gxLVQB5yOQnRGgugtY7kLXaTfUSfU88RYTz+
        O26RUDniix2HHgO74CWDY+MR8tFxSSc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-e1a-lm2QPSCtKUxIhQQvrQ-1; Mon, 01 Aug 2022 09:59:02 -0400
X-MC-Unique: e1a-lm2QPSCtKUxIhQQvrQ-1
Received: by mail-ej1-f71.google.com with SMTP id g18-20020a1709065d1200b0073082300e1fso710464ejt.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 06:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eXxFDNHmW1eO0dHBvosAP+F5NsGPg4Gs2jo3HyEeOm4=;
        b=fNzP9zLfDMqvGAsnqGi1BxuXpE0OIsHh5CsTPDHPUksuepZtKPBLoJmUpEuV1+hCGk
         wJaD8i3K2dkr4G1GEIlPUwvvpGWd/1M19g8ltWm23wy0KMqPVeniInOygdkJL0mlb5uN
         ouGubcX1CAdoiFbhsQ24SWi12XPUhGJM8DDx+bozTE9+BaG45TF77ml5e8XJQY6dscpy
         UZo24qHx+BbKaOlcrP3Jg+9zlx3/bejSTJA00ZoqfqLU6NKKh/pzlD8y+LqU3tgRYJGW
         sayem8NKS2kUWnfnfeuwYWMCW3gfQRMDFl6dhpj57NWyv0GAyuadpVGDTSvoaztaq4t/
         G1vg==
X-Gm-Message-State: AJIora9LS0rjEBxwjZIlmpRfjFawyygzH1Zu+SPj3Gi9PMYXR61KIT3E
        O8i2gOEj+OxVHEl1OFlxKCfJusc/6ih1vTcFO8BYP6Vk4G0ZbsHxeh447PNHVdCRXFoFpoxW9Li
        WGlRiJ9G5N0a5vx1XADiASuuSAh/leZ7F6RXcjCky
X-Received: by 2002:a05:6402:428a:b0:42e:8f7e:1638 with SMTP id g10-20020a056402428a00b0042e8f7e1638mr15797062edc.228.1659362341203;
        Mon, 01 Aug 2022 06:59:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sOKK1XArDJ/+T2IJ3/pCZ85i2lWKtqCnCIBQNq5wFJM3QRwfxBQ0mImsdCShuk7kTJM73OnyoYE+c/C8XVIdY=
X-Received: by 2002:a05:6402:428a:b0:42e:8f7e:1638 with SMTP id
 g10-20020a056402428a00b0042e8f7e1638mr15797050edc.228.1659362341081; Mon, 01
 Aug 2022 06:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220711083220.2175036-1-asavkov@redhat.com> <YswAqrJrMKIZPpcz@krava>
In-Reply-To: <YswAqrJrMKIZPpcz@krava>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Mon, 1 Aug 2022 15:58:24 +0200
Message-ID: <CACjP9X-HWHhFD6D1TsuhWOgj2v=dMkwVCjQCQzQqa054yKiqeg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/4] bpf_panic() helper
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Artem Savkov <asavkov@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 12:51 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Jul 11, 2022 at 10:32:16AM +0200, Artem Savkov wrote:
> > eBPF is often used for kernel debugging, and one of the widely used and
> > powerful debugging techniques is post-mortem debugging with a full memory dump.
> > Triggering a panic at exactly the right moment allows the user to get such a
> > dump and thus a better view at the system's state. This patchset adds
> > bpf_panic() helper to do exactly that.
>
> FWIW I was asked for such helper some time ago from Daniel Vacek, cc-ed

Nice :-)
This is totally welcome. Though, IIRC, I was asking if I could do a
NULL pointer dereference within perf probe (or ftrace) back then.
Still, the outcome is similar. So kudos to Artem.

--nX

> jirka
>
> >
> > I realize that even though there are multiple guards present, a helper like
> > this is contrary to BPF being "safe", so this is sent as RFC to have a
> > discussion on whether adding destructive capabilities is deemed acceptable.
> >
> > Artem Savkov (4):
> >   bpf: add a sysctl to enable destructive bpf helpers
> >   bpf: add BPF_F_DESTRUCTIVE flag for BPF_PROG_LOAD
> >   bpf: add bpf_panic() helper
> >   selftests/bpf: bpf_panic selftest
> >
> >  include/linux/bpf.h                           |   8 +
> >  include/uapi/linux/bpf.h                      |  13 ++
> >  kernel/bpf/core.c                             |   1 +
> >  kernel/bpf/helpers.c                          |  13 ++
> >  kernel/bpf/syscall.c                          |  33 +++-
> >  kernel/bpf/verifier.c                         |   7 +
> >  kernel/trace/bpf_trace.c                      |   2 +
> >  tools/include/uapi/linux/bpf.h                |  13 ++
> >  .../selftests/bpf/prog_tests/bpf_panic.c      | 144 ++++++++++++++++++
> >  9 files changed, 233 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_panic.c
> >
> > --
> > 2.35.3
> >
>

