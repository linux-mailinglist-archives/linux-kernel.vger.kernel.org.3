Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FB659275D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiHOBLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiHOBLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:11:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E431181D
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:11:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 17so5209839plj.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 18:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc;
        bh=Ne4JOdW2yUxs9Z+rnlNsmRDLyCc2jQEMfG4sisZnaNQ=;
        b=OYn6Uq00PGcbZzL2BLjWxgpzr49ilkuJIPrtRyJvcMmjRTaCSZtPLZ0iT16uaqC4Jn
         17Myd0n7pd+KCYqIE9Kemlyw0TCiYu1MPcByUqf9hSYE0q+6k0Owjp9xxiMoPJPv4DtP
         BbQZ8Une1VdI8FfqlhgZcpO9X6cgczMbs0gZX0KiRY83SPiILAfnn9aAUN18KG+5wMX+
         btmPe1oF5Jjpzu/ibq0zp+CRKh2DDnc2e2dp6pAFj99kVRRyIgyvGmg0yQ2jr2RiICak
         mvGQuDuQ44AFLPSzQ/A1zzbeuza/E0VholRSFj1EqTgEfSXEMp5MTUFNeSErjUgTWn+v
         douw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=Ne4JOdW2yUxs9Z+rnlNsmRDLyCc2jQEMfG4sisZnaNQ=;
        b=bWpJQTC/kP3sMaZCB7oFqlylq4RrcXsKKs2wXZ4i50DnCjC/RTQVqTxp1craEQ7wD6
         fOhO90UhjRige9wkafEtZ39Ccvl7yxWvr+hk3v3ASR2wdi27dCszAW2HzTH/SknKlXO0
         KxFb6bfLIE1VO3GAncApqsJbwYq/pPUZEqFPgdKx/jw33WTAjZRT1njrTwqoxpDcP3+z
         f5eYUXfOqj+DBNCZKsDqnm1cl8D/RB9Lr5ieLUkEHuQxKoMIQV4lPuQShIonuCS6WltZ
         02HttdGjdnqNK/ThpjxHhtSgL+tm1vDUJZL7esOvHjaqErjJqFBWnYfCtyVUpbPPvkLB
         An0g==
X-Gm-Message-State: ACgBeo2u6xmuMyFBCJSVO8owjwziEPdyrB/SC2NMZmbyCzDPLCH8VScn
        +aaERWUIvnPAon0OyYrR7Gd9FQ==
X-Google-Smtp-Source: AA6agR598KYUGtHAymaRBAaUH+cE+i+pREnfqZiMpn2k0Ue9zcjVTV7FoX9AFMohvw8sSSN9hg7AQA==
X-Received: by 2002:a17:90a:7407:b0:1f4:fe7e:bd51 with SMTP id a7-20020a17090a740700b001f4fe7ebd51mr25530832pjg.218.1660525906174;
        Sun, 14 Aug 2022 18:11:46 -0700 (PDT)
Received: from [2620:15c:29:203:2fe6:b086:54db:d870] ([2620:15c:29:203:2fe6:b086:54db:d870])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7973a000000b0052ad49292f0sm5620003pfg.48.2022.08.14.18.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 18:11:45 -0700 (PDT)
Date:   Sun, 14 Aug 2022 18:11:44 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Waiman Long <longman@redhat.com>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/slab_common: Deleting kobject in kmem_cache_destroy()
 without holding slab_mutex/cpu_hotplug_lock
In-Reply-To: <20220812183033.346425-1-longman@redhat.com>
Message-ID: <f7ed4f8e-5ed3-4fe1-9591-0467ef960ecb@google.com>
References: <20220812183033.346425-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2022, Waiman Long wrote:

> A circular locking problem is reported by lockdep due to the following
> circular locking dependency.
> 
>   +--> cpu_hotplug_lock --> slab_mutex --> kn->active --+
>   |                                                     |
>   +-----------------------------------------------------+
> 
> The forward cpu_hotplug_lock ==> slab_mutex ==> kn->active dependency
> happens in
> 
>   kmem_cache_destroy():	cpus_read_lock(); mutex_lock(&slab_mutex);
>   ==> sysfs_slab_unlink()
>       ==> kobject_del()
>           ==> kernfs_remove()
> 	      ==> __kernfs_remove()
> 	          ==> kernfs_drain(): rwsem_acquire(&kn->dep_map, ...);
> 
> The backward kn->active ==> cpu_hotplug_lock dependency happens in
> 
>   kernfs_fop_write_iter(): kernfs_get_active();
>   ==> slab_attr_store()
>       ==> cpu_partial_store()
>           ==> flush_all(): cpus_read_lock()
> 
> One way to break this circular locking chain is to avoid holding
> cpu_hotplug_lock and slab_mutex while deleting the kobject in
> sysfs_slab_unlink() which should be equivalent to doing a write_lock
> and write_unlock pair of the kn->active virtual lock.
> 
> Since the kobject structures are not protected by slab_mutex or the
> cpu_hotplug_lock, we can certainly release those locks before doing
> the delete operation.
> 
> Move sysfs_slab_unlink() and sysfs_slab_release() to the newly
> created kmem_cache_release() and call it outside the slab_mutex &
> cpu_hotplug_lock critical sections. There will be a slight delay
> in the deletion of sysfs files if kmem_cache_release() is called
> indirectly from a work function.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: David Rientjes <rientjes@google.com>
