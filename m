Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC6A490943
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbiAQNNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:13:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231894AbiAQNNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642425193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KoHD0T4Qgoe1KhATHZfpvSKKRzDTRge8Amqh33PB6yY=;
        b=ccMMvZgGXq0YvqreQQN26bOnhz3ohL72ahmnXbXnZPc3Nb5ooTYMJ8hi+Q9z4U4bC5K/ts
        qHrAGsVNCrpARBHcx4XUENoaL+e3Zj9EuzbiHrjq7wg919H4/lkOJX94CusijPPG76Cj13
        5q6HhNX/UYkAjoZrCwYt5r2ZxLDz1jI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-yRlD69j6OZ6hs6GB3-znaw-1; Mon, 17 Jan 2022 08:13:12 -0500
X-MC-Unique: yRlD69j6OZ6hs6GB3-znaw-1
Received: by mail-qt1-f197.google.com with SMTP id 4-20020ac85744000000b002b2f329efc2so12541658qtx.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 05:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KoHD0T4Qgoe1KhATHZfpvSKKRzDTRge8Amqh33PB6yY=;
        b=0+Wdd4bteFaePIKiRpswfWyvjjZ61OV/xyyRG85AtL8s7tH1+1vIKStOnRuSDokuRX
         mwoPktdhl/pRv9TzBG+UKleWHd2o+Hu2NCsReTri3/tBaurZuazKv4PQo3CJ5H6L70pn
         a53xxld++SVbX06I0sRb2S/cxSXwJyMWiUnGq+vo2ZNcxYiNbmeD6QnIX11IPnSE2LYb
         txlZdIVmliWK8olphrY5FxYSYufa6RcKhyurSa18EeIMfboN9D8AWPGdGpfPZ6TqjtGX
         rL4ozlGi6QuK9pBCX/em78zyEsNzCy+94rgN0DfDFbR2WRnN/9FgTW2OAUq2/y77l51x
         DZiA==
X-Gm-Message-State: AOAM533lackEQJ7DuUe7IQNU1ho3rShPxV8sDTOGXzzTlv9tpfQlsEb5
        B7HZXcTbmiyU+7SBEJY8W8TChqu+xKxcj4+8jnfN7RwGLg4cmBjqFyE1loJm49SzAu349dDW/Z/
        vhBJqYiRm1yFnHeFJYJyVTk2S
X-Received: by 2002:ad4:5ded:: with SMTP id jn13mr18031197qvb.112.1642425192216;
        Mon, 17 Jan 2022 05:13:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8zahbWUfzIjviyspBo6mAwtq6lEfIulh9X/Oe4Votnq4+jt74G1gTWnuu1R8OJmZa285zkA==
X-Received: by 2002:ad4:5ded:: with SMTP id jn13mr18031165qvb.112.1642425191861;
        Mon, 17 Jan 2022 05:13:11 -0800 (PST)
Received: from localhost.localdomain ([151.57.254.96])
        by smtp.gmail.com with ESMTPSA id x14sm8810332qko.110.2022.01.17.05.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 05:13:11 -0800 (PST)
Date:   Mon, 17 Jan 2022 14:13:04 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Xin Long <lucien.xin@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Antoine Tenart <atenart@kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] mm: slub: fix a deadlock warning in kmem_cache_destroy
Message-ID: <20220117131304.pdc3mfdowkzovw6q@localhost.localdomain>
References: <388098b2c03fbf0a732834fc01b2d875c335bc49.1642170196.git.lucien.xin@gmail.com>
 <YeO8pcs866Iu2iJX@ip-172-31-30-232.ap-northeast-1.compute.internal>
 <CADvbK_eY=3Gf79MkvK72Nh86ysN4eoFei0k1jg0frg22GgToGA@mail.gmail.com>
 <YeU4B46F+oFUBRLE@linutronix.de>
 <39a3470f-06ab-cf41-32e4-80edb249c7d3@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39a3470f-06ab-cf41-32e4-80edb249c7d3@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/01/22 13:40, Vlastimil Babka wrote:
> +CC Clark
> 
> On 1/17/22 10:33, Sebastian Andrzej Siewior wrote:
> > On 2022-01-17 16:32:46 [+0800], Xin Long wrote:
> >> another issue. From the code analysis, this issue does exist on the
> >> upstream kernel, though I couldn't build an upstream RT kernel for the
> >> testing.
> > 
> > This should also reproduce in v5.16 since the commit in question is
> > there.
> 
> Yeah. I remember we had some issues with the commit during development, but
> I'd hope those were resolved and the commit that's ultimately merged got the
> fixes, see this subthread:
> 
> https://lore.kernel.org/all/0b36128c-3e12-77df-85fe-a153a714569b@quicinc.com/
> 
> >> > >         CPU0                        CPU1
> >> > >         ----                        ----
> >> > >   cpus_read_lock()
> >> > >                                    kn->active++
> >> > >                                    cpus_read_lock() [a]
> >> > >   wait until kn->active == 0
> >> > >
> >> > > Although cpu_hotplug_lock is a RWSEM, [a] will not block in there. But as
> >> > > lockdep annotations are added for cpu_hotplug_lock, a deadlock warning
> >> > > would be detected:
> > 
> > The cpu_hotplug_lock is a per-CPU RWSEM. The lock in [a] will block if
> > there is a writer pending.
> > 
> >> > >   ======================================================
> >> > >   WARNING: possible circular locking dependency detected
> >> > >   ------------------------------------------------------
> >> > >   dmsetup/1832 is trying to acquire lock:
> >> > >   ffff986f5a0f9f20 (kn->count#144){++++}-{0:0}, at: kernfs_remove+0x1d/0x30
> >> > >
> >> > >   but task is already holding lock:
> >> > >   ffffffffa43817c0 (slab_mutex){+.+.}-{3:3}, at: kmem_cache_destroy+0x2a/0x120
> >> > >
> > 
> > I tried to create & destroy a cryptarget which creates/destroy a cache
> > via bio_put_slab(). Either the callchain is different or something else
> > is but I didn't see a lockdep warning.
> 
> RHEL-8 kernel seems to be 4.18, unless RT uses a newer one. Could be some
> silently relevant backport is missing? How about e.g. 59450bbc12be ("mm,
> slab, slub: stop taking cpu hotplug lock") ?

Hummm, looks like we have backported commit 59450bbc12be in RHEL-8.

Xin Long, would you be able to check if you still see the lockdep splat
with latest upstream RT?

git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.16.y-rt

Thanks!
Juri

