Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FBF4A76C6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346240AbiBBRYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:24:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242514AbiBBRYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643822656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a3OAAhJ1yQ586G1GSfs1iva0fA7dOQbeoU53qGnYVps=;
        b=U6TIpxq+4usR7Gh+UpQnA9N/aodMJ82vXCKt7rXEub26n0j0mv/BVpwb+vHNSgq/F9LOU+
        jojTLXOMhl0e+VbAkrCUcnRmaykPfYGc0XSdemhroI6Lo3DdfudPiRYVCDG8bQfg1wHg07
        XIPrh0R/uwpXn6aLWgY30QPtoymY9CM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-2jJZ7fGbPbOp9LgrWv-QXg-1; Wed, 02 Feb 2022 12:24:15 -0500
X-MC-Unique: 2jJZ7fGbPbOp9LgrWv-QXg-1
Received: by mail-wm1-f69.google.com with SMTP id s1-20020a1ca901000000b0034ece94dd8cso4293695wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 09:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a3OAAhJ1yQ586G1GSfs1iva0fA7dOQbeoU53qGnYVps=;
        b=okT3BaN827Ylogk5PW/YRTgt7oImwdOoCo2xC8jTxywgrFYu1cvljTscROSABEI+TN
         +V7vAo5XhSNjzf5ecfN47+OTyyG4h3QVvzNK/lqLowaPvPkCaDD9D2YvHzI4DKCUr2hV
         W4KIDW3n5N87qnj8zqgob3/J9LUE8M4Tg1rxtrh71b1hJVFhscBLenqqDKInJ1/C9OcH
         1cBDjtrq4Mj36iuw5XH9z8n4/IEgWCBohbUBowgtsPC2FlTVUj866c68cPDVfD5fSUU7
         J7LaOMRkFzIJ7sUSRrU8H5/uTZL9KcbtaL4L+EBmgffFtemWLhT2I4mjQBwmkDosJV+e
         koUg==
X-Gm-Message-State: AOAM533zpQOo2rbKfAFLuziSKEC7dQconJZbCEYpEE35Yaz7jRcpVd7f
        yVCWdtDIkCJ1Y5EvzTW1VYh+Hw2TaOQiCwrticR5CPO4VcGBBJLUOByzjmAueeo4VHNZD36nSiE
        BeCGZKSnbhNk0D4DYnL0DHQay
X-Received: by 2002:a05:600c:4801:: with SMTP id i1mr7027713wmo.180.1643822654619;
        Wed, 02 Feb 2022 09:24:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSSayZ7Fi8nDt3X2L7PRK4VumZHeWPrHmdIcrsIB/sUgpK7JI78M0RwK69qEVM5hPwZUtFxg==
X-Received: by 2002:a05:600c:4801:: with SMTP id i1mr7027702wmo.180.1643822654476;
        Wed, 02 Feb 2022 09:24:14 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id r2sm25729143wrz.99.2022.02.02.09.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 09:24:13 -0800 (PST)
Date:   Wed, 2 Feb 2022 18:24:12 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH 0/8] bpf: Add fprobe link
Message-ID: <Yfq+PJljylbwJ3Bf@krava>
References: <20220202135333.190761-1-jolsa@kernel.org>
 <CAADnVQ+hTWbvNgnvJpAeM_-Ui2-G0YSM3QHB9G2+2kWEd4-Ymw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+hTWbvNgnvJpAeM_-Ui2-G0YSM3QHB9G2+2kWEd4-Ymw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 09:09:53AM -0800, Alexei Starovoitov wrote:
> On Wed, Feb 2, 2022 at 5:53 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > hi,
> > this patchset adds new link type BPF_LINK_TYPE_FPROBE that attaches kprobe
> > program through fprobe API [1] instroduced by Masami.
> 
> No new prog type please.
> I thought I made my reasons clear earlier.
> It's a multi kprobe. Not a fprobe or any other name.
> The kernel internal names should not leak into uapi.
> 

well it's not new prog type, it's new link type that allows
to attach kprobe program to multiple functions

the original change used BPF_LINK_TYPE_RAW_KPROBE, which did not
seem to fit anymore, so I moved to FPROBE, because that's what
it is ;-)

but if you don't want new name in uapi we could make this more
obvious with link name:
  BPF_LINK_TYPE_MULTI_KPROBE

and bpf_attach_type:
  BPF_TRACE_MULTI_KPROBE

jirka

