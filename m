Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE0F472CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbhLMNEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbhLMNEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:04:05 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AC7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:04:04 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a18so26920722wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SClrgPZjHFxolenNh14g8Orrmsd/9jHZAaeoodMKXHs=;
        b=m97/kcbgPGInVPLjKpivD+gigXnhyJ+GpFXQnImCQAMX7coASKx4Rnt6nnVsWENJji
         CIXw7i98KUbC69EA3rkaVczYdoOIz1LKSFPws/wjrnqBxlWlz8OaPtOLwCF62Le2bnPh
         bOF7ob9nWqWEY+nYmkJkRVPSNa+z6WSSfRX15nWNo9/7cvcTKiYqJV3OqHkE/J6YhMvJ
         4gBcnziRaU7BdU9pjbbfW76mCbX0GAClIxtQ/RWqY29WReczvWTAGP5408cCI440oWcR
         jNEjNl8l46GY1OmMabFzmOYe9NYBQNq/9evDYxNltAmnCPwOy9iTvwwgnIjwWR3xCc8a
         Fryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SClrgPZjHFxolenNh14g8Orrmsd/9jHZAaeoodMKXHs=;
        b=eGvOy997vZ3DzFQaIn18ADSmOInsNKY7V6nyKCUFaSrvxQ23aICtS4pyE9SUY4OA5F
         zC84EmcW+2TFG3isB+3dVuCLeXBWavzVZep22xSHywxPR/zjb7hWlJ8mhwl2KiJON5t3
         41SIEw6K6R6v3rE2cGtxLqa/PXZwZTAp0NCxp87GgiWks/UkM7GJVnoYTkgcDmoCXbUS
         6P7P18rJ3EipvYaLVI5ljCSaSimSZITtgVe7zwL14w9g3xM63NBeQ7LCs3KhD0+zAgcN
         jSh4dfXD8R6YfiaiQ6eUwk5zafT4bAkX0K6FH53xzmccnD4sL94IIJ+Iu4uj3MjcrwGY
         l2eQ==
X-Gm-Message-State: AOAM533r2z3pIaEWlRehentkL5tPvDzOlS3nVnCtxAWP2OAssmdz14xJ
        4Or4/Ow58Mf5RR50iQV/gKJQaQ==
X-Google-Smtp-Source: ABdhPJwVJPP7CgqmeswIa0G78yYeD82j1qj+vtsa83Iek4tIcPAHL65q9odji0Am8nTBlBMLzQ+7iw==
X-Received: by 2002:a5d:6510:: with SMTP id x16mr32629958wru.2.1639400643130;
        Mon, 13 Dec 2021 05:04:03 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id g5sm15146522wri.45.2021.12.13.05.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 05:04:02 -0800 (PST)
Date:   Mon, 13 Dec 2021 13:04:00 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        "Wang, Xiaolei" <xiaolei.wang@windriver.com>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
Message-ID: <20211213130400.npccyt36r5sysca3@maple.lan>
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
 <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>
 <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org>
 <CAFA6WYM1oCs9gE4b5DaRez+jhCXPb_c25ausj0yWdS5tawX0MA@mail.gmail.com>
 <20211210154915.hjbgrnvtitmwluhz@maple.lan>
 <CAFA6WYPd+SLT+XZgLPVjLph27P1D5RpYuLwNu4KC+2nOQH07_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPd+SLT+XZgLPVjLph27P1D5RpYuLwNu4KC+2nOQH07_Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:28:01PM +0530, Sumit Garg wrote:
> On Fri, 10 Dec 2021 at 21:19, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > On Fri, Dec 10, 2021 at 03:08:21PM +0530, Sumit Garg wrote:
> > > On Fri, 10 Dec 2021 at 13:40, Jerome Forissier <jerome@forissier.org> wrote:
> > > > On 12/10/21 06:00, Sumit Garg wrote:
> > > > > On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wrote:
> > > > > Yes. AFAICT, optee-os should allocate shared memory to communicate
> > > > > with tee-supplicant. So once the communication is done, the underlying
> > > > > shared memory should be freed. I can't think of any scenario where
> > > > > optee-os should keep hold-off shared memory indefinitely.
> > > >
> > > > I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
> > > > the config file [1] and the commit which introduced this config [2].
> > >
> > > Okay, I see the reasoning. So during the OP-TEE driver's lifetime, the
> > > RPC shared memory remains allocated. I guess that is done primarily
> > > for performance reasons.
> > >
> > > But still it doesn't feel appropriate that we term all RPC shm
> > > allocations as not leaking memory as we might miss obvious ones.
> >
> > IIUC this patch adds kmemleak_not_leak() at (pretty much) the last
> > possible point before *ownership* of the SHM block is passed from kernel
> > to OP-TEE.
> 
> I wouldn't say it's a transfer of ownership from kernel to OP-TEE but
> rather a way for OP-TEE to access kernel's memory in order to pass
> info or execute further RPC commands.

The RPC handler allocates a pointer (e.g. now the RPC handler owns the
allocated memory). The RPC handler then passes that pointer to OP-TEE and
forgets what it's value was.

That is a transfer of ownership: the RPC handler does not hold any pointer
to the memory and is incapable of freeing it. Moreover this situation is
what kmemleak_no_leak() is for! Its job it to inform kmemleak that the
pointer is owned/stored somewhere that is does not scan.


> > Sure, after we change ownership it could still be leaked... but it can
> > no longer be leaked by the kernel because the kernel no longer owns it!
> > More importantly, it makes no sense to run the kernel memory detector on the
> > buffer because it simply can't work.
> >
> > After the RPC completes, doesn't it become impossible for kmemleak to
> > scan to see if the pointer is lost[1]?
> 
> Apart from the special OP-TEE prealloc SHM cache stuff, I can't think
> of any scenario where an OP-TEE thread should hold off kernel's memory
> pointers for more than 5 seconds before being passed onto kernel for
> further RPC commands or RPC free action. So the kmemleak should be
> able to detect if a pointer is lost.

Or putting this a different way: there is known to be firmware in the
field that allocates pointers for more then five seconds!


> /*
>  * Kmemleak configuration and common defines.
>  */
> <snip>
> #define MSECS_MIN_AGE           5000    /* minimum object age for reporting */
> <snip>
> 
> > kmemleak is essentially a tracing
> > garbage collector and needs to be able to scan all memory that could
> > hold a pointer to leakable memory. After the RPC completes the
> > only copy of the pointer will be stored in a memory region that the
> > kernel is prohibited from reading. How could kmemleak possibly give you
> > a useful answer in this circumstance?
> >
> 
> There is another aspect of kmemleak being the minimum age of an object
> to be reported as a memory leak as described above. Also, this case
> resembles where a pointer is stored on the CPU stack (see struct
> optee_rpc_param param = { };).

I can't see how this resembles pointers stored on the stack.

Firstly, stack memory is scanned by kmemleak meaning a thread is
permitted to own memory for more than five seconds without provoking a
warning. OP-TEE memory cannot be scanned like this.

Secondly, stacks don't have any concept of sessions. It is *really*
buggy behaviour for a TA to allocate SHM memory during a session open so
it can avoid critical path RPC round trips when operational?

 
> In most of the scenarios apart from special prealloc shm cache case,
> the flow should be as follows:
> 
> 1) Alloc kernel memory via RPC
> 2) OP-TEE passes references to kernel memory for RPC action commands
> 3) Free kernel memory via RPC
> 
> kmemleak should be useful in case the 3rd step is skipped due to
> incorrect behaviour of a particular OP-TEE thread. And I can't think
> of any appropriate way in OP-TEE OS to detect this type of kernel
> memory leak caused by one of its threads.

If OP-TEE is the only place the pointer is held and you can't think of
any way for OP-TEE OS to detect if it has leaked the pointer then how
can you expect the kernel to give a correct verdict when it has even
less visibility than OP-TEE OS.

Note that, if you think OP-TEE routinely leaks memory, then there are
ways that the corresponding kernel driver could track what memory it has
handed to OP-TEE. However this should be described as a list of
*allocations* rather than a list of *leaks* because the driver cannot
distinguish the two.


Daniel.
