Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B408D4C592E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 04:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiB0DuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 22:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiB0DuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 22:50:24 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E3A186409;
        Sat, 26 Feb 2022 19:49:49 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id c1so8452790pgk.11;
        Sat, 26 Feb 2022 19:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ek02eCmAnj7Z2ZCUVWU1x+42laMB9rYJ1kTYghRSfoY=;
        b=l5LWHNq/cqCHFY23g+qTLqYtg2Mgv7d2GowvDp/LrdHdjfCCJaLU9EkWMTemApxWso
         L7mRV+GY4NUJAOnJh+SyFoQ2AZbCvtq05jfttc8/XZcF00Ud36eKQzeSuZjVoEZHvZ++
         8YfT3V4zEtI1guC9HOJfif2AxnmnL4ojUtunB/s9X0npaZci0zEQ2mpCn/QlbK+Z+rHf
         sDmNpLcXXv4B+GTZTvLpRvWn4EeuaZVBpIp78cUOh+oHp0hB/7XFRhHeYX8DlFERAUXO
         q1bgLt/dJHQCtgwP2G4oZvEMeHErFuP8cwaFoAvsmutlmF8RAK37gPgqxdt3ungrgXFy
         nfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ek02eCmAnj7Z2ZCUVWU1x+42laMB9rYJ1kTYghRSfoY=;
        b=2PGo6NH8nGiJbbJdsDXPLMBNvgMuGXCzLf4KEA98x/DJE3kocnIrf6q/XRE8cN2vXc
         PWTTF+mKpT+VUPWs67y9s8KHk69BDnEQLFuOHsjkDitOyWi9l3V3X9b4JF6ZouAajGdZ
         q/mStv1Ena6VXmAW+Jk2EXvWOH8jk4jcPFJMOeAzAQVI7Ay8fG7n4SFRBWQKcvA/6Pt4
         Wprc1l3/ffWuwdLt7C+UCet9UpTZ8qZOVRZHlJq6gWRwVOwqeLm6ONPDA2GgHtQp85h5
         E2TgaOeSDbzpwjkjtNH5gItJZuaqu/ao3YQeLjPm6WwLUk1y60ignD0lCa3Ht8TKDSTj
         L1Xw==
X-Gm-Message-State: AOAM530h+5ToU2ToTcAGzx3JwgzIkD5radq9IRla7OHK9Hue1NklTqfB
        2ZNv9iOsYcMFWpb9TFvyNyU=
X-Google-Smtp-Source: ABdhPJzzuUAQA+T6PXrJ+bSAiek9oD6PjwdZxcLhDQsJbsFHLYu0HQ9stXDcYMMzLIgqbH/QjRw64A==
X-Received: by 2002:aa7:8a4d:0:b0:4f2:6d3f:5fe3 with SMTP id n13-20020aa78a4d000000b004f26d3f5fe3mr15220064pfa.48.1645933788551;
        Sat, 26 Feb 2022 19:49:48 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id lt8-20020a17090b354800b001bc509e0085sm12606983pjb.21.2022.02.26.19.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 19:49:48 -0800 (PST)
Date:   Sun, 27 Feb 2022 03:49:42 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/5] slab, documentation: add description of debugfs
 files for SLUB caches
Message-ID: <Yhr01naZNIa2SxEd@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220225180318.20594-1-vbabka@suse.cz>
 <20220225180318.20594-6-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225180318.20594-6-vbabka@suse.cz>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_FMBLA_NEWDOM,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 07:03:18PM +0100, Vlastimil Babka wrote:
> From: Oliver Glitta <glittao@gmail.com>
> 
> Add description of debugfs files alloc_traces and free_traces
> to SLUB cache documentation.
> 
> [ vbabka@suse.cz: some rewording ]
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/vm/slub.rst | 61 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
> index d3028554b1e9..2b2b931e59fc 100644
> --- a/Documentation/vm/slub.rst
> +++ b/Documentation/vm/slub.rst
> @@ -384,5 +384,66 @@ c) Execute ``slabinfo-gnuplot.sh`` in '-t' mode, passing all of the
>        40,60`` range will plot only samples collected between 40th and
>        60th seconds).
>  
> +
> +DebugFS files for SLUB
> +======================
> +
> +For more information about current state of SLUB caches with the user tracking
> +debug option enabled, debugfs files are available, typically under
> +/sys/kernel/debug/slab/<cache>/ (created only for caches with enabled user
> +tracking). There are 2 types of these files with the following debug
> +information:
> +
> +1. alloc_traces::
> +
> +    Prints information about unique allocation traces of the currently
> +    allocated objects. The output is sorted by frequency of each trace.
> +
> +    Information in the output:
> +    Number of objects, allocating function, minimal/average/maximal jiffies since alloc,
> +    pid range of the allocating processes, cpu mask of allocating cpus, and stack trace.
> +
> +    Example:::
> +
> +    1085 populate_error_injection_list+0x97/0x110 age=166678/166680/166682 pid=1 cpus=1::
> +	__slab_alloc+0x6d/0x90
> +	kmem_cache_alloc_trace+0x2eb/0x300
> +	populate_error_injection_list+0x97/0x110
> +	init_error_injection+0x1b/0x71
> +	do_one_initcall+0x5f/0x2d0
> +	kernel_init_freeable+0x26f/0x2d7
> +	kernel_init+0xe/0x118
> +	ret_from_fork+0x22/0x30
> +
> +
> +2. free_traces::
> +
> +    Prints information about unique free traces of the currently free objects,
> +    sorted by their frequency.
> +

I'm not sure that it's traces of the "currently free objects".

static int slab_debug_trace_open(struct inode *inode, struct file *filep)
{
	[...]
        
	obj_map = bitmap_alloc(oo_objects(s->oo), GFP_KERNEL);
	
	[...]

        for_each_kmem_cache_node(s, node, n) {
                unsigned long flags;
                struct slab *slab;

                if (!atomic_long_read(&n->nr_slabs))
                        continue;

                spin_lock_irqsave(&n->list_lock, flags);
                list_for_each_entry(slab, &n->partial, slab_list)
                        process_slab(t, s, slab, alloc, obj_map);
                list_for_each_entry(slab, &n->full, slab_list)
                        process_slab(t, s, slab, alloc, obj_map);
                spin_unlock_irqrestore(&n->list_lock, flags);
        }

	[...]

}

static void __fill_map(unsigned long *obj_map, struct kmem_cache *s,
                       struct slab *slab)
{
        void *addr = slab_address(slab);
        void *p;

        bitmap_zero(obj_map, slab->objects);

        for (p = slab->freelist; p; p = get_freepointer(s, p))
                set_bit(__obj_to_index(s, addr, p), obj_map);
}

static void process_slab(struct loc_track *t, struct kmem_cache *s,
                struct slab *slab, enum track_item alloc,
                unsigned long *obj_map)
{
        void *addr = slab_address(slab);
        void *p;

        __fill_map(obj_map, s, slab);

        for_each_object(p, s, addr, slab->objects)
                if (!test_bit(__obj_to_index(s, addr, p), obj_map))
                        add_location(t, s, get_track(s, p, alloc));
}

I think it's not traces of "currently free objects"
because index bit of free objects are set in obj_map bitmap?

It's weird but it's traces of allocated objects that have been freed at
least once (or <not available>)

I think we can fix the code or doc?

Please tell me if I'm missing something :)

> +    Information in the output:
> +    Number of objects, freeing function, minimal/average/maximal jiffies since free,
> +    pid range of the freeing processes, cpu mask of freeing cpus, and stack trace.
> +
> +    Example:::
> +
> +    51 acpi_ut_update_ref_count+0x6a6/0x782 age=236886/237027/237772 pid=1 cpus=1
> +	kfree+0x2db/0x420
> +	acpi_ut_update_ref_count+0x6a6/0x782
> +	acpi_ut_update_object_reference+0x1ad/0x234
> +	acpi_ut_remove_reference+0x7d/0x84
> +	acpi_rs_get_prt_method_data+0x97/0xd6
> +	acpi_get_irq_routing_table+0x82/0xc4
> +	acpi_pci_irq_find_prt_entry+0x8e/0x2e0
> +	acpi_pci_irq_lookup+0x3a/0x1e0
> +	acpi_pci_irq_enable+0x77/0x240
> +	pcibios_enable_device+0x39/0x40
> +	do_pci_enable_device.part.0+0x5d/0xe0
> +	pci_enable_device_flags+0xfc/0x120
> +	pci_enable_device+0x13/0x20
> +	virtio_pci_probe+0x9e/0x170
> +	local_pci_probe+0x48/0x80
> +	pci_device_probe+0x105/0x1c0
> +

Everything else looks nice!

>  Christoph Lameter, May 30, 2007
>  Sergey Senozhatsky, October 23, 2015
> -- 
> 2.35.1
> 
> 

-- 
Thank you, You are awesome!
Hyeonggon :-)
