Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282884A62CD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbiBARne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241623AbiBARna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:43:30 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BA9C06173B;
        Tue,  1 Feb 2022 09:43:29 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z5so15941865plg.8;
        Tue, 01 Feb 2022 09:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xtJMwxjU4Rj4Pcv//zGr7gCkoDaffyiUBign7P1X5Wo=;
        b=pOROpeWkRE2TFTfv2Ds99CFvLljZ57Mkrg+wFSGZ/w6xbyGSH5RdtC1RFaYyNmYzRC
         xbhHVB0oWSCimL0EbLvhI3KH0PVe73dlzKS1yTUCH3MwxM/7W1Sxi+rOM7HaT07cLhhr
         byT0DsTzkdP21b8DepU80eb3GuOe98doT6jNn8wMYSkMSdWzy92Uz7ZC3Yl66+9OFO/B
         sBM7RN//wKkJo0oRyvW8frTfS8U5gPP2ZnutgYjSOOaSNTTs6/23Y0wqv4VLGiveSbeS
         Yphl7jcF1JYDH3ks9KFRIJe97AoCtI9PomQNvJLM8VDG4CHT9Xjf1kegnmUK/33kvRtj
         HWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xtJMwxjU4Rj4Pcv//zGr7gCkoDaffyiUBign7P1X5Wo=;
        b=a/3Fq2ijjh76JJ/Hx/rYsn7SbeNr69TL77H6+x8olst+tpwKSYjwQ0pN3HtH8Z/AnF
         bZQ9TGCETNxAKhBw8NqWsOYYcqTopUy2zJRY4lOnfe8xlsT1Tu9PKDC1QkWjg/7Ks6Zn
         6vFhE1STKePEFmsT5SFHEZdoi7JUJdVnoocdA1NUu74f9HiHEYWnmspEDytvGYDbGKpj
         MBU49bnitKgFW7spbav5oE9iJbHgz95TDlVhNi0JT1dmOB6sLGKG0tlo5TGOlS6WmGhp
         BVeAKUZ2p8EconzeSPaO9JoVTCFlrrfbNI2CH9jrui98yCIG6SNaHKKqDOROR29+vC6Y
         C4WQ==
X-Gm-Message-State: AOAM530BThzFWCQG9gXa9ouuNe3X4fF4WvJw3H5eXfevk7CUCQ1nQwD/
        pj/g/4DoaVAQe2C7YVm2CjPOKeijDH8=
X-Google-Smtp-Source: ABdhPJzPbTdI8h9vw7KAgGCw7+Gqs82eElXbtc+5ntsE2gYo3SCGnVCJ+x+9NsQ5IgWG5SP2QNTWpA==
X-Received: by 2002:a17:90a:f0ce:: with SMTP id fa14mr3539033pjb.212.1643737409172;
        Tue, 01 Feb 2022 09:43:29 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id c11sm23330188pfv.76.2022.02.01.09.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:43:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 1 Feb 2022 07:43:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Igor Pylypiv <ipylypiv@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changyuan Lyu <changyuanl@google.com>
Subject: Re: [PATCH] Revert "module, async: async_synchronize_full() on
 module init iff async is used"
Message-ID: <YflxP28HlVrrNBU2@slm.duckdns.org>
References: <20220127233953.2185045-1-ipylypiv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127233953.2185045-1-ipylypiv@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 03:39:53PM -0800, Igor Pylypiv wrote:
> This reverts commit 774a1221e862b343388347bac9b318767336b20b.
> 
> We need to finish all async code before the module init sequence is done.
> In the reverted commit the PF_USED_ASYNC flag was added to mark a thread
> that called async_schedule(). Then the PF_USED_ASYNC flag was used to
> determine whether or not async_synchronize_full() needs to be invoked.
> This works when modprobe thread is calling async_schedule(), but it
> does not work if module dispatches init code to a worker thread which
> then calls async_schedule().
> 
> For example, PCI driver probing is invoked from a worker thread based on
> a node where device is attached:
> 
> 	if (cpu < nr_cpu_ids)
> 		error = work_on_cpu(cpu, local_pci_probe, &ddi);
> 	else
> 		error = local_pci_probe(&ddi);
> 
> We end up in a situation where a worker thread gets the PF_USED_ASYNC flag
> set instead of the modprobe thread. As a result, async_synchronize_full()
> is not invoked and modprobe completes without waiting for the async code
> to finish.
> 
> The issue was discovered while loading the pm80xx driver:
> (scsi_mod.scan=async)
> 
> modprobe pm80xx                      worker
> ...
>   do_init_module()
>   ...
>     pci_call_probe()
>       work_on_cpu(local_pci_probe)
>                                      local_pci_probe()
>                                        pm8001_pci_probe()
>                                          scsi_scan_host()
>                                            async_schedule()
>                                            worker->flags |= PF_USED_ASYNC;
>                                      ...
>       < return from worker >
>   ...
>   if (current->flags & PF_USED_ASYNC) <--- false
>   	async_synchronize_full();
> 
> Commit 21c3c5d28007 ("block: don't request module during elevator init")
> fixed the deadlock issue which the reverted commit 774a1221e862 ("module,
> async: async_synchronize_full() on module init iff async is used") tried
> to fix.
> 
> Since commit 0fdff3ec6d87 ("async, kmod: warn on synchronous
> request_module() from async workers") synchronous module loading
> from async is not allowed.
> 
> Given that the original deadlock issue is fixed and it is no longer allowed
> to call synchronous request_module() from async we can remove PF_USED_ASYNC
> flag to make module init consistently invoke async_synchronize_full()
> unless async module probe is requested.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> Reviewed-by: Changyuan Lyu <changyuanl@google.com>

That's quite a walk down the memory lane and I agree with your analysis. The
PF_USED_ASYNC is redundant for correctness with the removal of synchrnous
loading from iosched path and the WARN_ON guarantees that nothing in kernel
is creating a similar situation.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
