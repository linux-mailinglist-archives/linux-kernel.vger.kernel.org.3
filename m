Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAB35394E1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346091AbiEaQS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbiEaQS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADE2A9858D
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654013932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YtoJsV/pAwLuD0XYy5XZQJJtondD7Ct4J80qDODwKmo=;
        b=ODLVHbLqE7hXDWStfta2c9uTfvFLu1BnpWrLHhBWKGdxYW6PigZ0b4YJTtlFHYmhR0mtFj
        lBQE7KCoutQjC3q2RCqB4CjPaL64qI+nkhGrSFO0aYcO/+PjTkONxRIi87MfVSAuGa+G9I
        Y5FmCnuWG83TUWtfgRj1+myA8Cbjhtc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-lC_hSxx2OZ67g4YOY_BLhQ-1; Tue, 31 May 2022 12:18:51 -0400
X-MC-Unique: lC_hSxx2OZ67g4YOY_BLhQ-1
Received: by mail-wm1-f72.google.com with SMTP id i127-20020a1c3b85000000b0039c1bf9739fso1014102wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YtoJsV/pAwLuD0XYy5XZQJJtondD7Ct4J80qDODwKmo=;
        b=qJxYj69UMPrkAqrQBOcyOh8HEtFdePlkCm+dh4aHWFVv/pcNEk7l7CJ7/IfsQUscpH
         U8Fd308CkJqwhdO7X5likNj/KGipfdCfk/cqwrD8yuIIisjftYdjeSSJIMJXTYXTNcR5
         lehiQxVXhoxcE8NrIZxnZ1G5L+MzCx7zQRwsVO3cwqKM82VJC/72HVdbuAt1T5D0jIlF
         jKsgVicRqJHrhDsH0HOE0BAZ+2i4rnmz5fKIPthlnAPxwgBHkNWhhdADkR1Nus3g4gOr
         ibvRYqflrwgXi1YUKxurnWu7bI3wPtEOOdQfS2NXFSdj3syk+kSnLHzAhe2eTUk3QTxd
         3AHA==
X-Gm-Message-State: AOAM5306SfqDyQvqkm1rQVNas+hEV+uhQrkgMSPBGt4U/KJ1J0423SEb
        Gwl7AhHdouMVyg3mG65lN5Kp7nN7pHao59qWgzs52tXTmpO/eAps8ZKYbBaEDnkMeC1kHwiG0R7
        iwSmTXstdeGsQNMBw249nD08w
X-Received: by 2002:a05:600c:3646:b0:397:326d:eac7 with SMTP id y6-20020a05600c364600b00397326deac7mr25225084wmq.43.1654013930044;
        Tue, 31 May 2022 09:18:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+BdBaQ0bOBc902fQ3zUVwJD7Nos9AeOAqNHRZ/i3ghUNUlKXPeQbyPlkHAXavv8IJGuTT/Q==
X-Received: by 2002:a05:600c:3646:b0:397:326d:eac7 with SMTP id y6-20020a05600c364600b00397326deac7mr25225067wmq.43.1654013929840;
        Tue, 31 May 2022 09:18:49 -0700 (PDT)
Received: from redhat.com ([2.52.157.68])
        by smtp.gmail.com with ESMTPSA id d22-20020a05600c34d600b0039736892653sm2451571wmq.27.2022.05.31.09.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 09:18:49 -0700 (PDT)
Date:   Tue, 31 May 2022 12:18:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 0/8] Use copy_process in vhost layer
Message-ID: <20220531121659-mutt-send-email-mst@kernel.org>
References: <20220512214704.104472-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512214704.104472-1-michael.christie@oracle.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 04:46:56PM -0500, Mike Christie wrote:
> The following patches were made over Eric's tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
> 
> and his kthread-cleanups-for-v5.19 branch. They allow the vhost layer to
> do a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
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

Series:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Who is going to merge this?

> V9:
> - Rebase against Eric's kthread-cleanups-for-v5.19 branch. Drop patches
> no longer needed due to kernel clone arg and pf io worker patches in that
> branch.
> V8:
> - Fix kzalloc GFP use.
> - Fix email subject version number.
> V7:
> - Drop generic user_worker_* helpers and replace with vhost_task specific
>   ones.
> - Drop autoreap patch. Use kernel_wait4 instead.
> - Fix issue where vhost.ko could be removed while the worker function is
>   still running.
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
> 
> 
> 

