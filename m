Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2027251795F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387771AbiEBVrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387762AbiEBVrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:47:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1D6CE0C4
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 14:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651527844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c7qpZ5gaWPIGhuR6581IOmtx3CCGtKfAeFRs42Wu+jM=;
        b=V4drL9u7sHC0uHQUMBkSoZcUOF1eFstFj6q7F/RtMxpMzwK+gFRmowC7mg6AJmEwy0BMwm
        V7aJE0IyZe5Ce3jn5gN4IRQcC01DnXfNdDqvawsjYGLr6V3UiAFLBHissTDWatjNCjnIEa
        k863BLz6TMlbnULE9oRxF41BHV2WgME=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-Dx4GWecMPzyNlmemWmnVAQ-1; Mon, 02 May 2022 17:44:03 -0400
X-MC-Unique: Dx4GWecMPzyNlmemWmnVAQ-1
Received: by mail-pf1-f200.google.com with SMTP id a16-20020a62d410000000b00505734b752aso8610054pfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 14:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7qpZ5gaWPIGhuR6581IOmtx3CCGtKfAeFRs42Wu+jM=;
        b=AE0tvueKgPtPM0tY7M01xOyFioFHpARjmrNT2ByTrogc5jL/Q59Sdan+F6CjnP3Ps9
         r05mfd5lkacC58UZENGdNsb+1VCFd7BQLRWfmxgOGpnKDGH4F+SPyIix3zJDDvRzrWo4
         b5SzInH60kjC4HHWsnWMe5fsFLANzUb+ZyppBadcLEEqUEevhzZ9WWKM4JAqJPjC9RdJ
         bdtg/0hmxPfHnWa5F82SGvEqhY5aJmcPcKPTJ74Pbc3pG1c2Og+rC0md5hQaulY879dF
         RMg0hccERDjX8ZAtGncYRyW9MFQnD1pFUUoHybdU3GH2m05QKOTILlIljA+D1tvCLA11
         B+OA==
X-Gm-Message-State: AOAM533C3TB1/FZwIb5N5G9eJG5zt6qfRmKvzLYOQkiaw8hHfMtevA3T
        T5GU9izBoTQPr4kCiiPylxDYDc1IOGJ2/cDPdi+vZ+1YQtsgoW4DqacryGBWrpezLmmNGIi+ij6
        JvarWiLuJw5sp4CE8wgwuH1e8LYqcqHqm3WF/vulU
X-Received: by 2002:a63:444f:0:b0:39d:3aa5:c9f0 with SMTP id t15-20020a63444f000000b0039d3aa5c9f0mr11422897pgk.363.1651527842573;
        Mon, 02 May 2022 14:44:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVBPlNkFLYOr47rFMtKIeTN9KJAaYIPfVcIELE5KmrrWdSio/kRJK7auPfCAOHNli1rBX7YCGK+kct7Km3Uzo=
X-Received: by 2002:a63:444f:0:b0:39d:3aa5:c9f0 with SMTP id
 t15-20020a63444f000000b0039d3aa5c9f0mr11422879pgk.363.1651527842322; Mon, 02
 May 2022 14:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220426040314.ez3cdpv2w45vbgkk@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CAO-hwJLziatB9n5Rut_EYRgfN94t2XX8Zx8B_Zmu2nucTw3k8g@mail.gmail.com>
 <CAADnVQKN==eb3ASQhrJBg4yC8BuRdMQyY-OdRbXhdyv2P8L0-A@mail.gmail.com> <CAO-hwJ+HV=jZUgH1LXcPuBFirMzx3OAdSy4zvyyYh7PQhnaduQ@mail.gmail.com>
In-Reply-To: <CAO-hwJ+HV=jZUgH1LXcPuBFirMzx3OAdSy4zvyyYh7PQhnaduQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 2 May 2022 23:43:51 +0200
Message-ID: <CAO-hwJ+bAJb_1jSu30hnjfF1u8HZVMCqKU4qTJg=XUhupok13g@mail.gmail.com>
Subject: Re: [RFC bpf-next v4 0/7] Introduce eBPF support for HID devices (new attempt)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 9:12 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
[...]
> This is roughly what I have now:
>
> - hid-core is not aware of BPF except for a few __weak
> ALLOW_ERROR_INJECTION hooks (dispatch_hid_bpf_device_event for
> example)
> - I have a separate hid-bpf module that attaches BPF traces to these
> hooks and calls a "dispatch" kfunc within hid-bpf
> - the dispatch function then do a succession of BPF calls to programs
> attached to it by using bpf_tail_call(prog_array, hid_id)
>
> - for the clients, they define one or more
> SEC("fmod_ret/hid_bpf_device_event"). That __weak hook is declared in
> the kernel by hid-bpf but is never called, it's just an API
> declaration
> - then clients call in a SEC("syscall")
> hid_bpf_attach_prog(ctx->prog_fd, ctx->hid_id, ctx->flags);
> - hid_bpf_attach_prog is a kfunc that takes a ref on the struct
> bpf_prog*, and stores that program in the correct struct bpf_map *for
> the given attached_btf_id (hid_bpf_device_event in our case)
>
> And that's about it.
> I still need to handle automatic release of the bpf prog when there is
> no userspace open fd on it unless it's pinned but I think this should
> be working fine.
>
> I also probably need to pin some SEC("syscall") (hid_bpf_attach_prog
> and hid_bpf_dettach_prog) so users don't have to write them down and
> can just use the ones provided by the kernel.
>
> The nice thing is that I can define my own API for the attach call
> without dealing with bpf core. I can thus add a priority flag that is
> relevant here because the data coming through the bpf program can be
> modified.
>
> The other thing is that now, I don't care which function we are in to
> decide if a RET_PTR_MEM is read only or not. I can deal with that by
> either playing with the flags or even replacing entirely the dispatch
> trace prog from userspace if I want to access the raw events.
>
> However, the downsides are:
> - I need to also define kfuncs for BPF_PROG_TYPE_SYSCALL (I don't
> think It'll be a big issue)
> - The only way I could store the bpf_prog into the map was to hack
> around the map ops, because the fd of the map in the skel is not
> available while doing a SEC("syscall") from a different process.

Update on this side: I realized that I could use the syscall
BPF_MAP_GET_FD_BY_ID instead to get an fd for the current task.
However, I've been bitten quite hard today because I was using
bpf_map_get() instead of bpf_map_get_with_uref(), and so every time I
closed the fd in the syscall the map was cleared...

But now I would like to have more than one program of a type per hid
device, meaning that I can not have only one bpf_map of type
BPF_MAP_TYPE_PROG_ARRAY.
I have explored BPF_MAP_TYPE_HASH_OF_MAPS, but we can not have
BPF_MAP_TYPE_PROG_ARRAY as inner maps with the current code. And I'd
need 2 levels of nesting (which is not authorized today):
- hid_jmp_table (key: HID id)
  - array of different program type per HID device (key: HID_BPF_PROG_TYPE)
    - BPF_MAP_TYPE_PROG_ARRAY with the actual progs (key: int)

The other solution would be to be able to create a map when needed,
store it in struct hid_device, and then call bpf_tail_call on this
map. The problem is that I need a way to teach the verifier that the
struct bpf_map pointer I have in the context is a true bpf_map...

Any input would be appreciated :)

Cheers,
Benjamin

>
> Also, I wonder if we should not have some way to namespace kfuncs.
> Ideally, I would like to prevent the usage of those kfuncs outside of
> some helpers that I define in HID so I don't have to worry too much
> about other trace programs fuzzing and segfaulting the kernel.
>
[...]

