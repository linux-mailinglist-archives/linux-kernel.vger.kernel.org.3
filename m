Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089874CE418
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 11:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiCEKIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 05:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiCEKIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 05:08:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6851A25C127
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 02:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646474838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a0Fgc88E/ZnztbMYK2n/3xkvK5J7VCgRYmi3UI+KKPI=;
        b=EQrcV1RngVR5eUbfS2dgxmuc8SYZRCtPitexg/fdWpbtPZjqYmzv0D3SwI/WQN/+CG24Fp
        qgYiO31q68r9j7sANSvKfQBz/w04ttcabOHIm52l6vs5K+WVkjtBhFs+KbTw8BdYzKXx5E
        +jtAwQJWyPQRZy39BhDguIJ/+j+yd3o=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-iT5aIG-SNf-F72d5224X5g-1; Sat, 05 Mar 2022 05:07:17 -0500
X-MC-Unique: iT5aIG-SNf-F72d5224X5g-1
Received: by mail-pg1-f198.google.com with SMTP id o30-20020a634e5e000000b00373598b71d4so5909072pgl.21
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 02:07:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0Fgc88E/ZnztbMYK2n/3xkvK5J7VCgRYmi3UI+KKPI=;
        b=ldoaqNmKezItI4qQHBSGBRwdCLHwWVvYrByk8RrW6oCgvczwpfeJgJQ7zeDa78XHzL
         dC7MSQuXlS9dMeQzWP/FA1F/GYQguYPDaNj+3wkAajTnx234n1s1StwmK0d1HIX+QOLx
         qj29L6W/cS2wHbB1SI/NJnC9xvlF23sNLSG6SHieX0NythOKaJN6RFIVM2h06ftnvIU0
         q9FKsOmXiSauCQrYA8Uqvy7O/i2DAYYmM18vl0ZAkDc9Y89huX7+Rul4nzlY/A3hl3K1
         Jrh13CEagVwb2P0CRJ7Xc/1Di0SJTjPmb0zBSkuoJYaWnJjlKStb45+5NxlBgNl+kCL9
         qdgA==
X-Gm-Message-State: AOAM531J9xsOhdpamtwVVb3YRqQmYSUKEvg9Zw7poativcz87zZtDI1m
        toAy81hx72cN3M76L1AN1ucsS00fnU6/egSF1UWBHI3wPSGXj8a/zBXkz1jtsril7IjuO96clm7
        V8ao2WtzZ51fjPdohgz4WV/uzymLpufuKi/G2H7mu
X-Received: by 2002:a17:90a:dac2:b0:1bd:fecf:6bd1 with SMTP id g2-20020a17090adac200b001bdfecf6bd1mr3049402pjx.113.1646474835962;
        Sat, 05 Mar 2022 02:07:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDEJR/yHEdFWnXc0pHQ+ViBWp74yyK9Eo9xHnLMRRGwOjXlrUAgunUqQ5UkVHlbRmy69Wo/GZFxyibXBCaP0k=
X-Received: by 2002:a17:90a:dac2:b0:1bd:fecf:6bd1 with SMTP id
 g2-20020a17090adac200b001bdfecf6bd1mr3049372pjx.113.1646474835671; Sat, 05
 Mar 2022 02:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20220304172852.274126-1-benjamin.tissoires@redhat.com>
 <20220304172852.274126-2-benjamin.tissoires@redhat.com> <CAPhsuW4otgwwDN6+xcjPXmZyUDiynEKFtXjaFb-=kjz7HzUmZw@mail.gmail.com>
In-Reply-To: <CAPhsuW4otgwwDN6+xcjPXmZyUDiynEKFtXjaFb-=kjz7HzUmZw@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Sat, 5 Mar 2022 11:07:04 +0100
Message-ID: <CAO-hwJJjDMaTXH9i1UkO7Qy+sbNprDyW67cRp8HryMMWMi5H9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/28] bpf: add new is_sys_admin_prog_type() helper
To:     Song Liu <song@kernel.org>
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
        Joe Stringer <joe@cilium.io>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Sean Young <sean@mess.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 5, 2022 at 12:12 AM Song Liu <song@kernel.org> wrote:
>
> On Fri, Mar 4, 2022 at 9:30 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > LIRC_MODE2 does not really need net_admin capability, but only sys_admin.
> >
> > Extract a new helper for it, it will be also used for the HID bpf
> > implementation.
> >
> > Cc: Sean Young <sean@mess.org>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > ---
> >
> > new in v2
> > ---
> >  kernel/bpf/syscall.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index db402ebc5570..cc570891322b 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2165,7 +2165,6 @@ static bool is_net_admin_prog_type(enum bpf_prog_type prog_type)
> >         case BPF_PROG_TYPE_LWT_SEG6LOCAL:
> >         case BPF_PROG_TYPE_SK_SKB:
> >         case BPF_PROG_TYPE_SK_MSG:
> > -       case BPF_PROG_TYPE_LIRC_MODE2:
> >         case BPF_PROG_TYPE_FLOW_DISSECTOR:
> >         case BPF_PROG_TYPE_CGROUP_DEVICE:
> >         case BPF_PROG_TYPE_CGROUP_SOCK:
> > @@ -2202,6 +2201,17 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
> >         }
> >  }
> >
> > +static bool is_sys_admin_prog_type(enum bpf_prog_type prog_type)
> > +{
> > +       switch (prog_type) {
> > +       case BPF_PROG_TYPE_LIRC_MODE2:
> > +       case BPF_PROG_TYPE_EXT: /* extends any prog */
> > +               return true;
> > +       default:
> > +               return false;
> > +       }
> > +}
>
> I am not sure whether we should do this. This is a behavior change, that may
> break some user space. Also, BPF_PROG_TYPE_EXT is checked in
> is_perfmon_prog_type(), and this change will make that case useless.

Sure, I can drop it from v3 and make this function appear for HID only.

Regarding BPF_PROG_TYPE_EXT, it was already in both
is_net_admin_prog_type() and is_perfmon_prog_type(), so I duplicated
it here, but I agree, given that it's already in the first function
there, CPA_SYS_ADMIN is already checked.

Cheers,
Benjamin

>
> Thanks,
> Song
>
> [...]
>

