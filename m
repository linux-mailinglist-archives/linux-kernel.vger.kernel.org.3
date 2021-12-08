Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4438A46DD20
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbhLHUid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:38:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236697AbhLHUib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638995699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gjyPhtqWKvXzJTb8n9gdEmIwnhAiXQ7NBxC0TZtycX4=;
        b=ihYBQ5YjDDTFBFz7mRha296gsMhXJ11cnTo/lIMtSdxkjnaaEr4FHC6WDWmlKWAUPz+FIT
        wxbqVbcviawknvxdeTfYflSNXhEU7f3ejeHnCLcbfp5TjPP1xxP4285VCOoTSplCZhpmdD
        Ine16ODs7my5pj7P7X2XCL8bhDsxdA4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-CCWkg7j9MwO08u0OuACD-Q-1; Wed, 08 Dec 2021 15:34:58 -0500
X-MC-Unique: CCWkg7j9MwO08u0OuACD-Q-1
Received: by mail-wr1-f70.google.com with SMTP id v18-20020a5d5912000000b001815910d2c0so691683wrd.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 12:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gjyPhtqWKvXzJTb8n9gdEmIwnhAiXQ7NBxC0TZtycX4=;
        b=Y/ShwfchlR3imamDrqu1qD/iUiy8/vzefgh+vEHe8D7WnwCtLmG/P80IetepNuq9WW
         SIYJ0KM/+WrqJ2JCIuBL9BSKluwc/fFopGMYpnT7haHgxM4I514Z6l1NX+8d+apMYKCn
         KvGPTR9IwSd0zgbzorJaYMe4PcFJkSxfnCjRnl/lrWcO6HFszRPw4kEVKA7efMK+2Bd8
         bJCNehugZYFevL3jHVVkXbw5bNZKP6GuRopiB5vj+s04833qifqxo23FP+sZwRDqjj01
         Hgp2ZfLSpQ7cBRkWN/KmT6OS8DKfCTdP/O5kNn85aHTpaFqh+OQ5YpvhhcEgQSrB7s7K
         x7Hw==
X-Gm-Message-State: AOAM531zMmd7epSNeXIDZtqemNrA49ZDBZycAibjevX/WtI3Wq/Z5r/v
        l82DsHu22UeOXgai5iNklAWLAHb8B+5wFjBztAlalQW1H7lo843xhrHGpCAc0oy2W8MIBr13Sml
        Oez5aSfZ0jwom3WeeKKtquTq9
X-Received: by 2002:a05:600c:4c96:: with SMTP id g22mr1377789wmp.46.1638995696546;
        Wed, 08 Dec 2021 12:34:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhVE0pRRj446c43wOm/g7vW0Fq22NttrqLV7/KdxC1GrV37iQQjLydSqa0AKfBqzDP2eJIiw==
X-Received: by 2002:a05:600c:4c96:: with SMTP id g22mr1377758wmp.46.1638995696364;
        Wed, 08 Dec 2021 12:34:56 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
        by smtp.gmail.com with ESMTPSA id y7sm3590205wrw.55.2021.12.08.12.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:34:55 -0800 (PST)
Date:   Wed, 8 Dec 2021 15:34:51 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
Message-ID: <20211208153420-mutt-send-email-mst@kernel.org>
References: <20211129194707.5863-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129194707.5863-1-michael.christie@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 01:46:57PM -0600, Mike Christie wrote:
> The following patches made over Linus's tree, allow the vhost layer to do
> a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
> io_uring does a copy_process against its userspace app. This allows the
> vhost layer's worker threads to inherit cgroups, namespaces, address
> space, etc and this worker thread will also be accounted for against that
> owner/parent process's RLIMIT_NPROC limit.
> 
> If you are not familiar with qemu and vhost here is more detailed
> problem description:
> 
> Qemu will create vhost devices in the kernel which perform network, SCSI,
> etc IO and management operations from worker threads created by the
> kthread API. Because the kthread API does a copy_process on the kthreadd
> thread, the vhost layer has to use kthread_use_mm to access the Qemu
> thread's memory and cgroup_attach_task_all to add itself to the Qemu
> thread's cgroups.
> 
> The problem with this approach is that we then have to add new functions/
> args/functionality for every thing we want to inherit. I started doing
> that here:
> 
> https://lkml.org/lkml/2021/6/23/1233
> 
> for the RLIMIT_NPROC check, but it seems it might be easier to just
> inherit everything from the beginning, becuase I'd need to do something
> like that patch several times.


So who's merging this? Me? Did all patches get acked by appropriate
maintainers?

> V6:
> - Rename kernel_worker to user_worker and fix prefixes.
> - Add better patch descriptions.
> V5:
> - Handle kbuild errors by building patchset against current kernel that
>   has all deps merged. Also add patch to remove create_io_thread code as
>   it's not used anymore.
> - Rebase patchset against current kernel and handle a new vm PF_IO_WORKER
>   case added in 5.16-rc1.
> - Add PF_USER_WORKER flag so we can check it later after the initial
>   thread creation for the wake up, vm and singal cses.
> - Added patch to auto reap the worker thread.
> V4:
> - Drop NO_SIG patch and replaced with Christian's SIG_IGN patch.
> - Merged Christian's kernel_worker_flags_valid helpers into patch 5 that
>   added the new kernel worker functions.
> - Fixed extra "i" issue.
> - Added PF_USER_WORKER flag and added check that kernel_worker_start users
>   had that flag set. Also dropped patches that passed worker flags to
>   copy_thread and replaced with PF_USER_WORKER check.
> V3:
> - Add parentheses in p->flag and work_flags check in copy_thread.
> - Fix check in arm/arm64 which was doing the reverse of other archs
>   where it did likely(!flags) instead of unlikely(flags).
> V2:
> - Rename kernel_copy_process to kernel_worker.
> - Instead of exporting functions, make kernel_worker() a proper
>   function/API that does common work for the caller.
> - Instead of adding new fields to kernel_clone_args for each option
>   make it flag based similar to CLONE_*.
> - Drop unused completion struct in vhost.
> - Fix compile warnings by merging vhost cgroup cleanup patch and
>   vhost conversion patch.
> ~                              
> 

