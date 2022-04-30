Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E057515AEC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 09:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349670AbiD3HPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 03:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbiD3HPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 03:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 560232654C
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651302743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GLSGd7eLffGH5E++bjQhKsXkDpYyiATw6DYp1xz5Rbc=;
        b=aM9eOVRhdOAptj2joiufuDNitrgDgDEIsxlYsxcCvrzW2KI7b3KzWbaAslXCJZjYBBi+f+
        /Cgedcukh7AhEYJLHH0/H4dbEjj7xdeQ28aYmySlGl5YRhc5xYhaLdzIf9o5irCPktqDmT
        p88d0YdZ1PrINXjdA5ji9NiqClyjc8E=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-KHKn4zxAN72p07RmS8kTpA-1; Sat, 30 Apr 2022 03:12:21 -0400
X-MC-Unique: KHKn4zxAN72p07RmS8kTpA-1
Received: by mail-pf1-f200.google.com with SMTP id c202-20020a621cd3000000b0050dd228152aso267432pfc.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 00:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLSGd7eLffGH5E++bjQhKsXkDpYyiATw6DYp1xz5Rbc=;
        b=hZybbQxh23WNdTJFJz26smaYCclU6VBINz6jzt+2UAHyochXfBEdohKefglqsJJJis
         7FnT1v8oZNK1rDvwyUr61dIA+mx87l4xV2wv6EjTkPU2qEO+U1cfknec8DPTOO8gEwry
         OJDcNXSzSlHVd13FXyuODPXBLbOKqYwGgZCIcghkhx1QpVNtLCnnJ1Q0FsFVyX/NT688
         gWLONJJbtCyBR/Nnj95eTYsV4ZWmdJLahyUyQY/l5WONOKaHjlyQh5Lbi2qVXEvZmBnn
         PCs2Sj/IQqSv8ozzpEqUylciTF7cFfFLGexjqFvSkXI5gaJf6/TU4h67XjiSmc0mQj6H
         3zlg==
X-Gm-Message-State: AOAM533q5Y6DnWwRrashkZpbsMTPzlCyvklc/k/K0WETC0d8FkdxmKt5
        oLsP0H2oJ/3LrnavwctUgjtcvHdXkkgFyMk9z2DuFf8K4Nd/B7Pue7wYN9oGbNj+j45ej3wFX8+
        W41sa928ycOVPXxa80B9lAMHgWcXkLZ6+/WYEDY9t
X-Received: by 2002:a17:90a:170c:b0:1dc:20c4:6354 with SMTP id z12-20020a17090a170c00b001dc20c46354mr2997362pjd.113.1651302740721;
        Sat, 30 Apr 2022 00:12:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoT1vQqCssn4aXcNHDNuFRvBetM3BXXg0UzN7CkO1M+kV++j0uE1TMl2cfAWLjb6D+SAyBoJIBsl6r0IAVRYU=
X-Received: by 2002:a17:90a:170c:b0:1dc:20c4:6354 with SMTP id
 z12-20020a17090a170c00b001dc20c46354mr2997335pjd.113.1651302740405; Sat, 30
 Apr 2022 00:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220426040314.ez3cdpv2w45vbgkk@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CAO-hwJLziatB9n5Rut_EYRgfN94t2XX8Zx8B_Zmu2nucTw3k8g@mail.gmail.com> <CAADnVQKN==eb3ASQhrJBg4yC8BuRdMQyY-OdRbXhdyv2P8L0-A@mail.gmail.com>
In-Reply-To: <CAADnVQKN==eb3ASQhrJBg4yC8BuRdMQyY-OdRbXhdyv2P8L0-A@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Sat, 30 Apr 2022 09:12:09 +0200
Message-ID: <CAO-hwJ+HV=jZUgH1LXcPuBFirMzx3OAdSy4zvyyYh7PQhnaduQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 5:01 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 26, 2022 at 12:20 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > On Tue, Apr 26, 2022 at 6:03 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Apr 21, 2022 at 04:07:33PM +0200, Benjamin Tissoires wrote:
> > > > Hi,
> > > >
> > > > so after the reviews from v3, and some discussion with Alexei, I am
> > > > back with a new version of HID-BPF.
> > > >
> > > > This version is not complete (thus the RFC), but I'd like to share
> > > > it now to get initial feedback, in case I am too far from the actual
> > > > goal.
> > > >
> > > > FTR, the goal is to provide some changes in the core verifier/btf so
> > > > that we can plug in HID-BPF independently from BPF core. This way we can
> > > > extend it without having to care about bpf-next.
> > >
> > > Overall looks great. imo much cleaner, simpler and more extensible
> > > than the earlier versions.
> > > The bpf core extensions are nicely contained and HID side can be
> > > worked on in parallel.
> >
> > \o/
> >
> > >
> > > > The things I am not entirely sure are:
> > > > - do we need only fentry/fexit/fmod_ret BPF program types or should
> > > >   programs that modify the data stream use a different kind?
> > >
> > > Probably not. I'll reply in patch 2.
> > >
> > > > - patch 3/7 is probably not the correct approach (see comments in the
> > > >   patch itself)
> > > >
> > > > We are missing quite a few bits here:
> > > > - selftests for patches 1 to 4
> > > > - add the ability to attach a program to a struct device, and run that
> > > >   program only for that struct device
> > >
> > > yes. That is still to be figured out.
> >
> > I spent some time on that, and I don't think it makes a lot of sense
> > to use the current trampoline approach if we want to keep on using
> > fentry/fexit...
> > - the trampoline is pretty nice, but it adds instructions before
> > calling the actual function, meaning that adding a check on struct
> > device will be quite hard to do ()we have no idea where the struct
> > device is in the arguments) and will take more space on the trampoline
> > itself
> > - there is a limit on how many functions can be attached to a
> > trampoline (38 IIRC), and we probably will explode that number quickly
> > enough when we get more BPF programs to support HID devices.
>
> Ohh. This is an obsolete limitation.
> 38 was the number since we used half page optimization
> for bpf trampoline.
> It's gone now. We can easily lift this max.

Oh, interesting.
I have been working this week with that limitation in place, and I
just managed to get something working yesterday night. See below.

>
> > So my chain of thoughts from yesterday was the following (completely
> > untested of course):
> > - instead of writing a new BPF API that might move in the future while
> > things are settling, I can actually simply load a tracer BPF program
> > from HID that monitors the BPF programs that are attached to a given
> > function
> > - I can also add a new API (a kfunc likely) that "registers" a given
> > BPF program (through its fd) to a given HID device
> > - when a device sends data, it hits hid_bpf_device_event() which will
> > have a default BPF program (loaded by the kernel) that dispatches the
> > registered BPF programs based on the HID device.
> >
> > This would solve the 2 issues above IMO, except that the kfunc to
> > register a HID BPF program will suddenly be not standard.
>
> Could you add more details to these ideas?

That's basically your last suggestion below.

> I thought you wanted bpf prog writers to be independent of each other.
> They would tell some framework HID device id/pcie id that they need
> and the rest would be automatic.
> Maybe we can achieve that by adding another layer before libbpf
> that would accept (bpf_prog, hid_id) tuple and insert
> if (hid->id != hid_id) return -E..;
> as the first insn into bpf_prog before loading into the kernel.
> All such progs will be kfunc-s attached to the same hook.
> The kernel will execute them sequentially.
> The framework will provide demux by auto-inserting this 'if'.

That's an interesting approach. Much less convoluted than the one I
have right now. The only downside I see is that every program will be
called for every event, which might not be ideal (though the event
stream from HID is way smaller than network).

> This 'if (hid)' could be a part of sample code too.
> We can simply ask prog writers to follow this style.

Not a big fan of that...

>
> Another idea would be to do something like libxdp.
> Attach a "dispatcher" bpf prog to the kfunc hook and use
> some library to attach hid-specific progs as "freplace" kind of
> programs. It's a more involved solution.

freplace might not work for me because I want to attach more than one
program to a given HID device. Not so sure BPF_PROG_TYPE_REPLACE will
do something enough there.

>
> Another option is to use tail_calls.
> If hid_id is a relatively small number. The "dispatcher" bpf prog
> can do bpf_tail_call(prog_array, hid_id)
> while hid specific progs insert itself into prog_array
> instead of attaching to kfunc.

This is roughly what I have now:

- hid-core is not aware of BPF except for a few __weak
ALLOW_ERROR_INJECTION hooks (dispatch_hid_bpf_device_event for
example)
- I have a separate hid-bpf module that attaches BPF traces to these
hooks and calls a "dispatch" kfunc within hid-bpf
- the dispatch function then do a succession of BPF calls to programs
attached to it by using bpf_tail_call(prog_array, hid_id)

- for the clients, they define one or more
SEC("fmod_ret/hid_bpf_device_event"). That __weak hook is declared in
the kernel by hid-bpf but is never called, it's just an API
declaration
- then clients call in a SEC("syscall")
hid_bpf_attach_prog(ctx->prog_fd, ctx->hid_id, ctx->flags);
- hid_bpf_attach_prog is a kfunc that takes a ref on the struct
bpf_prog*, and stores that program in the correct struct bpf_map *for
the given attached_btf_id (hid_bpf_device_event in our case)

And that's about it.
I still need to handle automatic release of the bpf prog when there is
no userspace open fd on it unless it's pinned but I think this should
be working fine.

I also probably need to pin some SEC("syscall") (hid_bpf_attach_prog
and hid_bpf_dettach_prog) so users don't have to write them down and
can just use the ones provided by the kernel.

The nice thing is that I can define my own API for the attach call
without dealing with bpf core. I can thus add a priority flag that is
relevant here because the data coming through the bpf program can be
modified.

The other thing is that now, I don't care which function we are in to
decide if a RET_PTR_MEM is read only or not. I can deal with that by
either playing with the flags or even replacing entirely the dispatch
trace prog from userspace if I want to access the raw events.

However, the downsides are:
- I need to also define kfuncs for BPF_PROG_TYPE_SYSCALL (I don't
think It'll be a big issue)
- The only way I could store the bpf_prog into the map was to hack
around the map ops, because the fd of the map in the skel is not
available while doing a SEC("syscall") from a different process.

Also, I wonder if we should not have some way to namespace kfuncs.
Ideally, I would like to prevent the usage of those kfuncs outside of
some helpers that I define in HID so I don't have to worry too much
about other trace programs fuzzing and segfaulting the kernel.

>
> > >
> > > > - when running through bpf_prog_test_run_opts, how can we ensure we are
> > > >   talking to the correct device? (I have a feeling this is linked to the
> > > >   previous point)
> > > > - how can we reconnect the device when a report descriptor fixup BPF
> > > >   program is loaded (would it make sense to allow some notifications on
> > > >   when a BPF program is attached/detached to a device, and which
> > > >   function have been traced?)
> > >
> > > Not sure I follow. What kind of notification do you have in mind?
> > > To user space?
> > >
> >
> > No, this is in-kernel notifications.
> > What I want to do, is when I load a BPF program that changes the HID
> > report descriptor, hid-core detects that and reconnects the attached
> > device.
> >
> > But after a couple of days of thinking, and with the above approach
> > where HID would preload a BPF program, I should be able to achieve
> > that with the "register BPF through a HID kfunc call". When I see that
> > we are attaching a HID report descriptor fixup to a given HID device,
> > I can then reconnect the matching device.
> >
> > It would certainly be cleaner to have a general "notify me when a
> > tracer is attached to this particular function", but we can hide that
> > right now with a preloaded BPF program :)
>
> There are few lsm hooks in bpf core. It probably wwill be eird
> for hid core to hook into them. We can add a few tracepoints
> at attach functions if that helps.
>

With the above, I actually don't need those notifications. Users are
calling my own "syscall" when attaching their BPF prog, and they are
also not required to attach the program to the actual BPF trace
(through BPF_PROG_ATTACH), so this request is now gone :)

Cheers,
Benjamin

