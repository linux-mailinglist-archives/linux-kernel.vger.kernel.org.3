Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6336647D845
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 21:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhLVUZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 15:25:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhLVUZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 15:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640204753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKNI12rRctab/R9pu9OcGdD4dkmFiilNbvjoRWpVtkQ=;
        b=O/KZgYH+ZO5svjnAgF1Yxw4gYj2fw+6YoAKY+6zlN4fNVTTHJQMKKJp38EZJ5VJ/nnyoxL
        L/uVQ60F8HWUOYQm8qyP4yVruFUcBhbuJc26ewg99hPABpcpF40n4gUC96Fen5o7MEKdmH
        zUn59mnSHdX+/7hx9tbCMGpDzRWYOM0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-ooOD33tZO3uBchQmxsEtpQ-1; Wed, 22 Dec 2021 15:25:51 -0500
X-MC-Unique: ooOD33tZO3uBchQmxsEtpQ-1
Received: by mail-wm1-f70.google.com with SMTP id n31-20020a05600c3b9f00b0034440f99123so1100157wms.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 12:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UKNI12rRctab/R9pu9OcGdD4dkmFiilNbvjoRWpVtkQ=;
        b=HDznEKU5hfAtONqXd9/7nbK8DOS5SC87a7V8wOYWv7E0po3plUhmuzSFhXgqujnQ0w
         PPkfkwGDPCJBQTbkur6OdFAvaJCJgD7thyW4QyOHqyum3p7H9v9VbZrTprhiY+0JjN3H
         14r7ayT3JMNN8ZdzQQhWUXhsScnXoFS/lucGIzDG1z4RBpXSIaP+3nACi8y70U2xaFzr
         22NoZEjHtJlyOdG5Ia/LETVbK5oQjcjwiYZPpu9cCcyFwAHQbhrDEymFxZuw/Wf19pSN
         jr6QN/9m2sFt1GaTnWMJhboxuXOmpLymP/itIFUjSjxqZAZQ9E4/TqvfzFYRJHGVfOQR
         dARA==
X-Gm-Message-State: AOAM532t+mRKlIKDwDocAGC5Q9heu/oxrGdLN8OOHjr3thrWcZSLkYCh
        fy8fYCBZhIMxVSdWXrARLVrO/daKMHey6pBskla4LABt+gQ3uL0tywynGLdP7b5sP8a4lfu9rIZ
        N+j2QaXqLUFZsVCkJ/r2slbwo
X-Received: by 2002:a5d:6d8c:: with SMTP id l12mr3067960wrs.55.1640204750225;
        Wed, 22 Dec 2021 12:25:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyoKfXmbMLMoiUvuezS04MoLEB8t1h5V/Aua1AGwYJVnIrMFEGdP5c1VzAIhCxJ6qIy/IHVA==
X-Received: by 2002:a5d:6d8c:: with SMTP id l12mr3067947wrs.55.1640204749958;
        Wed, 22 Dec 2021 12:25:49 -0800 (PST)
Received: from redhat.com ([2.55.1.37])
        by smtp.gmail.com with ESMTPSA id p21sm2791332wmq.20.2021.12.22.12.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 12:25:49 -0800 (PST)
Date:   Wed, 22 Dec 2021 15:25:44 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Mike Christie <michael.christie@oracle.com>, geert@linux-m68k.org,
        vverma@digitalocean.com, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
Message-ID: <20211222152311-mutt-send-email-mst@kernel.org>
References: <20211129194707.5863-1-michael.christie@oracle.com>
 <87tuf79gni.fsf@email.froward.int.ebiederm.org>
 <a171238e-d731-1c22-af72-0f7faf7f4bea@oracle.com>
 <87tuf11oe6.fsf@email.froward.int.ebiederm.org>
 <a3bd6fe7-1775-6fdd-3a02-e779c4d4e498@oracle.com>
 <87pmpoxzuf.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmpoxzuf.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 12:24:08PM -0600, Eric W. Biederman wrote:
> Mike Christie <michael.christie@oracle.com> writes:
> 
> > On 12/21/21 6:20 PM, Eric W. Biederman wrote:
> >> michael.christie@oracle.com writes:
> >> 
> >>> On 12/17/21 1:26 PM, Eric W. Biederman wrote:
> >>>> Mike Christie <michael.christie@oracle.com> writes:
> >>>>
> >>>>> The following patches made over Linus's tree, allow the vhost layer to do
> >>>>> a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
> >>>>> io_uring does a copy_process against its userspace app. This allows the
> >>>>> vhost layer's worker threads to inherit cgroups, namespaces, address
> >>>>> space, etc and this worker thread will also be accounted for against that
> >>>>> owner/parent process's RLIMIT_NPROC limit.
> >>>>>
> >>>>> If you are not familiar with qemu and vhost here is more detailed
> >>>>> problem description:
> >>>>>
> >>>>> Qemu will create vhost devices in the kernel which perform network, SCSI,
> >>>>> etc IO and management operations from worker threads created by the
> >>>>> kthread API. Because the kthread API does a copy_process on the kthreadd
> >>>>> thread, the vhost layer has to use kthread_use_mm to access the Qemu
> >>>>> thread's memory and cgroup_attach_task_all to add itself to the Qemu
> >>>>> thread's cgroups.
> >>>>>
> >>>>> The problem with this approach is that we then have to add new functions/
> >>>>> args/functionality for every thing we want to inherit. I started doing
> >>>>> that here:
> >>>>>
> >>>>> https://urldefense.com/v3/__https://lkml.org/lkml/2021/6/23/1233__;!!ACWV5N9M2RV99hQ!eIaEe9V8mCgGU6vyvaWTKGi3Zlnz0rgk5Y-0nsBXRbsuVZsM8lYfHr8I8GRuoLYPYrOB$ 
> >>>>>
> >>>>> for the RLIMIT_NPROC check, but it seems it might be easier to just
> >>>>> inherit everything from the beginning, becuase I'd need to do something
> >>>>> like that patch several times.
> >>>>
> >>>> I read through the code and I don't see why you want to make these
> >>>> almost threads of a process not actually threads of that process
> >>>> (like the io_uring threads are).
> >>>>
> >>>> As a separate process there are many things that will continue to be
> >>>> disjoint.  If the thread changes cgroups for example your new process
> >>>> won't follow.
> >>>>
> >>>> If you want them to be actually processes with an lifetime independent
> >>>> of the creating process I expect you want to reparent them to the local
> >>>> init process.  Just so they don't confuse the process tree.  Plus init
> >>>> processes know how to handle unexpected children.
> >>>>
> >>>> What are the semantics you are aiming for?
> >>>>
> >>>
> >>> Hi Eric,
> >>>
> >>> Right now, for vhost we need the thread being created:
> >>>
> >>> 1. added to the caller's cgroup.
> >>> 2. to share the mm struct with the caller.
> >>> 3. to be accounted for under the caller's nproc rlimit value.
> >>>
> >>> For 1 and 2, we have cgroup_attach_task_all and get_task_mm
> >>> already.
> >>>
> >>> This patchset started with me just trying to handle #3 by modifying kthreads
> >>> like here:
> >>>
> >>> https://urldefense.com/v3/__https://lkml.org/lkml/2021/6/23/1234__;!!ACWV5N9M2RV99hQ!bvqZOWy7TxQyq18L4I_a5MxP2OX0V2imOYEJrWsc-LkyVTI_zpFzxyV2pM_dgYywwH2y$ 
> >>>
> >>> So we can use kthreads and the existing helpers and add:
> >>>
> >>> A. a ucounts version of the above patches in the link
> >>>
> >>> or
> >>>
> >>> B. a helper that does something like copy_process's use of
> >>> is_ucounts_overlimit and vhost can call that.
> >>>
> >>> instead of this patchset.
> >> 
> >> I don't fundamentally hate the patchset.  I do have concerns about
> >> the completely broken patch.
> >> 
> >> With respect this patchset my gut says decide.  Are you a thread of the
> >> process (just use create_io_worker) are you a separate process forked
> >> from the caller (use a cousin of create_io_worker but don't touch
> >> create_io_worker).  I think being a process vs being a thread is such a
> >> fundamental difference we don't want to mix the helpers.
> >> 
> >>> Before we even get to the next section below, do you consider items 1 - 3
> >>> something we need an API based on copy_process for?
> >> 
> >> I think 3 staying in the callers nproc strongly suggests you want to
> >> reuse copy_process.  Which gets back to my question do you want
> >> a thread or do you want a process.
> >> 
> >> 
> >> For me a key detail is what is the lifetime of the vhost device?
> >> 
> >> Does the vhost go away when the caller goes away?
> >
> > Yes. When the caller, normally qemu in our case, that created the worker
> > thread exits, then we free the vhost devices and stop and free the worker
> > threads we are creating in this patchset.
> >
> > However, I'm not sure if it makes a difference to you, but we also have second
> > way to free a vhost device and its worker thread. The user can run a command
> > that instructs the the qemu process to free the vhost device and its worker
> > thread.
> 
> I dug a little deeper to understand how this works, and it appears to be
> a standard file descriptor based API.  The last close of the file
> descriptor is what causes the vhost_dev_cleanup to be called which shuts
> down the thread.
> 
> This means that in rare cases the file descriptor can be passed to
> another process and be held open there, even after the main process
> exits.

It's true enough, however it will keep a reference to the mm
of the original process and keep accessing that.
Which in turn makes this kind of trick useless enough that
I'm pretty sure no one does it in practice, if we want to
change this aspect I think we can without worrying about
breaking some usespace.



> This says to me that much as it might be handy your thread does not
> strictly share the same lifetime as your qemu process.
> 
> 
> >>   If so you can create a thread in the caller's process that only performs
> >>   work in kernel space.  At which point you are essentially
> >>   create_io_thread.
> >> 
> >> If the vhost device can live after the caller goes away how is that managed?
> >
> > When the caller goes away we free the devices and their worker threads.
> >
> > Either before the caller exists it does an explicit close to release the device
> > which frees the device and its worker thread, or when the process exits and the
> > kernel does a put on its open devices that will trigger the vhost device's release
> > function and we free device and its thread at that time.
> 
> All of which says to me that the vhost devices semantically work well as
> separate processes (that never run userspace code) not as threads of the
> creating userspace process.
> 
> So I would recommend creating a minimal version of the kthread api,
> using create_process targeted only at the vhost case.  Essentially what
> you have done with this patchset, but without any configuration knobs
> from the callers perspective.
> 
> Which means that you can hard code calling ignore_signals, and the
> like, instead of needing to have a separate configuration knob for each
> place io_workers are different from vhost_workers.
> 
> In the future I can see io_workers evolving into a general user space
> thread that only runs code in the kernel abstraction, and I can see
> vhost_workers evolving into a general user space process that only runs
> code in the kernel abstraction.
> 
> For now we don't need that generality so please just create a
> create_vhost_process helper akin to create_io_thread that does just what
> you need.
> 
> I don't know if it is better to base it on kernel_clone or on
> copy_process.  All I am certain of is that you need to set
> "args->exit_signal = -1;".  This prevents having to play games with
> do_notify_parent.
> 
> Eric

