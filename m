Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D404E44BC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbiCVRKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiCVRK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:10:29 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092606E57C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:09:01 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id i184so2261806pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xlrOCYkNv2t8yWa7vnKFI31eu9eyynqVZEKfquTox9M=;
        b=NJ3EncoKDkBIdGPE9OBWzFvPN0gGKowcXQ9/vCxvJjWpNr1Epx4GPbwkKWFKiwG/UA
         M7NLq8KROHG+R5Mg+g0LKRy0TJBbznK642o3X/CBIPIZHvgi3FWODFZPramWjgtNspA5
         ugz6K/rfEE65UlCyhZrzZvldUeiQbcxawR3v7YSuhaaxlfLvB+c0hTCwG5CaESx4DROS
         IwFEYIetM/oss/CTOO9N7zo4bcYcZ/jur0B5W9YK9STzfK5lSdPeN/V0KjiBEtSXOiqb
         J0cbNZRHUwe+CDFQpRZKrXBcsxWOatlY+vrBdKYxiIThRXRZRI2BoQSfjuToe8FGOekS
         VSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xlrOCYkNv2t8yWa7vnKFI31eu9eyynqVZEKfquTox9M=;
        b=gsiz6/S90jd33fw08TVG69nZrYJhy53skBibb+6XL2z+vAz+FGcG3M8M2tkoVR/wlB
         gu/EqJVmGk2/yLZMmDQLvWrHw2bw+ClxWX06TRkTm0txvthl68OmjmI14PalKdafkmwo
         Qu3i/nkzoQFa/l+34Bvxwcl9kjVSnZJmyWzAAzJpA7ussaFb6eGQnGMFO5dh1iZn27u3
         l7nm8g4/OpJbH12z4V7x7MDAnr9A8NiBF+XeIjZMiiILe5AupRE4nQalOvWEBF06EJdg
         /Qw7t4MNPm/Q02JCcjo7oyo7t8+LbnkGG9FazDHcjrKfF87SBd9oevWy7mkichSSA4TK
         cSKA==
X-Gm-Message-State: AOAM531dRkJeMLaF6NbQTwRNJ2CALVi1JBzuGP7Cc9A8FYeue+COummt
        fO0ycZ+NwjHB8GWq7pgg8Sg=
X-Google-Smtp-Source: ABdhPJxp8RqnXpA25cXc1n+AXrq94CXiaylWeo2kgUec6KeMw4XAk74od/6M2Uprrhdvy59QTFnH3A==
X-Received: by 2002:aa7:81c1:0:b0:4f7:6ba1:553b with SMTP id c1-20020aa781c1000000b004f76ba1553bmr30587962pfn.45.1647968940322;
        Tue, 22 Mar 2022 10:09:00 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id y2-20020a056a00190200b004fa865d1fd3sm12060311pfi.86.2022.03.22.10.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 10:08:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Mar 2022 07:08:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Imran Khan <imran.f.khan@oracle.com>, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 7/8] kernfs: Replace per-fs rwsem with hashed
 rwsems.
Message-ID: <YjoCqqs+UDxZ55nM@slm.duckdns.org>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-8-imran.f.khan@oracle.com>
 <YjPNOQJf/Wxa4YeV@zeniv-ca.linux.org.uk>
 <536f2392-45d2-2f43-5e9d-01ef50e33126@oracle.com>
 <YjgpaeFfFandY999@zeniv-ca.linux.org.uk>
 <Yjir/d5S3J1PTiux@slm.duckdns.org>
 <Yji8KT2K7ZKOQ+6S@zeniv-ca.linux.org.uk>
 <YjjP5ldCCGYqD+UV@slm.duckdns.org>
 <Yjk3Nqft/U6vDvd1@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjk3Nqft/U6vDvd1@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Mar 22, 2022 at 02:40:54AM +0000, Al Viro wrote:
> Sorry, misread that thing - the reason it copies the damn thing at all is
> the use of strsep().  Yecch...  Rule of the thumb regarding strsep() use,
> be it in kernel or in the userland: don't.  It's almost never the right
> primitive to use.

Yeah, it's ugly. I was being lazy on top of the existing interface.

> Lookups should use qstr; it has both the length and place for hash.
> Switch kernfs_find_ns() to that (and lift the calculation of length
> into the callers that do not have it - note that kernfs_iop_lookup()
> does) and you don't need the strsep() shite (or copying) anymore.

and yeah this would be cleaner.

> That would allow for kernfs_walk_ns() to take kernfs_rename_lock shared.
> 
> HOWEVER, that's not the only lock needed there and this patchset is
> broken in that respect - it locks the starting node, then walks the
> path.  Complete with lookups in rbtrees of children in the descendents
> of that node and those are *not* locked.
> 
> > > Wait a sec; what happens if e.g. kernfs_path_from_node() races with
> > > __kernfs_remove()?  We do _not_ clear ->parent, but we do drop references
> > > that used to pin what it used to point to, unless I'm misreading that
> > > code...  Or is it somehow prevented by drain-related logics?  Seeing
> > > that it seems to be possible to have kernfs_path_from_node() called from
> > > an interrupt context, that could be delicate...
> > 
> > kernfs_remove() is akin to freeing of the node and all its descendants. The
> > caller shouldn't be racing that against any other operations in the subtree.
> 
> That's interesting...  My impression had been that some of these functions
> could be called from interrupt contexts (judging by the spin_lock_irqsave()
> in there).  What kind of async contexts those are, and what do you use to
> make sure they don't leak into overlap with kernfs_remove()?

The spin_lock_irqsave()'s are there because they're often used when printing
messages which can happen from any context. e.g. cpuset ends up calling into
them to print current's cgroup under rcu_read_lock(), iocost to print
warning message under an irq-safe lock. In both and similar cases, the
caller knows that the cgroup is accessible which in turn guarantees that the
kernfs node hasn't be deleted.

> In particular, if you ever use those from RCU callbacks, you need to make
> sure that you have a grace period somewhere; the wait_event() you have in
> kernfs_drain() won't do it.

I don't know of cases where they are called from rcu callbacks although
there are cases where they're used from rcu criticial sections. That said,
at least in cgroup's case, cgroup destruction path has a grace period and
that's how a rcu critical section is safe to deref a cgroup and the
kernfs_node inside it.

Thanks.

-- 
tejun
