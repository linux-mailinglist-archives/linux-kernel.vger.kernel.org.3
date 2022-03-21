Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634434E30BE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352651AbiCUTVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350210AbiCUTVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:21:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3607265816
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:20:09 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n7-20020a17090aab8700b001c6aa871860so177232pjq.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=95YhjwXki3u5hxuRlqlEClEXa9Pk9skNf0mQT0wjwEg=;
        b=Zf45MCHIGlLKE4vbREeKCEGQx/HGWqtDoDnYvedfgmmhV585xZ1TRL+B08Os/YW2Nm
         4XURP+1dEqaYrlREXrNdJTRRvXMZYYKPfV/SMHpbGH81eiV3wS7YlwBbjbFGJvkr24KK
         VxV1Zhw3T+g4p3FO+3pxU2qtV4N/VgJE5auxCwvbTtV7hTjW/aOL58m7HEvtPInPycdO
         +HuX7zlKWL9ThLeJLKwb5fWFHcDv2+7W/adSWnkfsygogW1ryOIMoiFsZCjS96dCo7dp
         kdLqLeFpppxBkxekOznkiDgexKCSfa4cDK5WSRgoACedT3gllwA1QBoJNxIcFi7Ei6Gv
         xQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=95YhjwXki3u5hxuRlqlEClEXa9Pk9skNf0mQT0wjwEg=;
        b=raoT45B3d4v/p+JLu5Dxuf5pFpVYmOXwgqjxXzwbvi9aPO12u8KoVoy3392If7NZDT
         tFtP+rEyMEWKnHo4Ey9N0jJMmhPMlzAI0MdLTtG0eZtvqvfkvyBn9HAoW2h3fLX+lpDM
         2N7RtuRXDhCV0d+0dVQxs/pm4o7/NIafGHWgT+JQvEFWNxdWoGJ3ddqMJsdo396hmJNk
         7meIbIW8TUzOlRffiEF8IKtnuLS0NvLIaE0VvqQvHW7hhU0CB1vG6c7BfYoUi4oU/euT
         UpmT4O5FvJKhkAj/RuKxbKJaOaXB7QDeboAdGcNWKrfZdyGPzxowTQN36JSnZXfh04KL
         AOBw==
X-Gm-Message-State: AOAM531ZGvxRUUgLC94tGErJ4friP4WxCSddmrkxkILXeVyQavp3oRZ6
        NvZV9zij5rWgCWN3JLXQSdo=
X-Google-Smtp-Source: ABdhPJz9/JpdcfpdSHzu0Zzj+4AGIPE+bQI+wmgajXPYRUNY8w06+51pLW60sQzV82E1CJ7MNQWjPQ==
X-Received: by 2002:a17:902:70cc:b0:154:1cc8:9df8 with SMTP id l12-20020a17090270cc00b001541cc89df8mr14593851plt.32.1647890408413;
        Mon, 21 Mar 2022 12:20:08 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id k3-20020a056a00168300b004f7e60da26csm20779672pfc.182.2022.03.21.12.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 12:20:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 21 Mar 2022 09:20:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Imran Khan <imran.f.khan@oracle.com>, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 7/8] kernfs: Replace per-fs rwsem with hashed
 rwsems.
Message-ID: <YjjP5ldCCGYqD+UV@slm.duckdns.org>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-8-imran.f.khan@oracle.com>
 <YjPNOQJf/Wxa4YeV@zeniv-ca.linux.org.uk>
 <536f2392-45d2-2f43-5e9d-01ef50e33126@oracle.com>
 <YjgpaeFfFandY999@zeniv-ca.linux.org.uk>
 <Yjir/d5S3J1PTiux@slm.duckdns.org>
 <Yji8KT2K7ZKOQ+6S@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yji8KT2K7ZKOQ+6S@zeniv-ca.linux.org.uk>
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

On Mon, Mar 21, 2022 at 05:55:53PM +0000, Al Viro wrote:
> Why bother with rwsem, when we don't need anything blocking under it?
> DEFINE_RWLOCK instead of DEFINE_SPINLOCK and don't make it static.

Oh I mean, in case the common readers get way too hot, percpu_rwsem is a
relatively easy way to shift the burder from the readers to the writers. I
doubt we'll need that.

> kernfs_walk_ns() - this is fucking insane; on the surface, it needs to
> be exclusive due to the use of the same static buffer.  It uses that
> buffer to generate a pathname, *THEN* walks over it with strsep().
> That's an... interesting approach, for the lack of other printable
> terms - we walk the chain of ancestors, concatenating their names
> into a buffer and separating those names with slashes, then we walk
> that buffer, searching for slashes...  WTF?

It takes the @parent to walk string @path from. Where does it generate the
pathname?

> kernfs_rename_ns() - exclusive; that's where the tree topology gets
> changed.

This is the only true writer and it shouldn't be difficult to convert the
others to read lock w/ e.g. dynamic allocations or percpu buffers.

> So we can just turn that spinlock into rwlock, replace the existing
> uses with read_lock()/read_unlock() in kernfs_{name,path_from_node,get_parent}
> and with write_lock()/write_unlock() in the rest of fs/kernfs/dir.c,
> make it non-static, put extern into kernfs-internal.h and there you
> go...
> 
> Wait a sec; what happens if e.g. kernfs_path_from_node() races with
> __kernfs_remove()?  We do _not_ clear ->parent, but we do drop references
> that used to pin what it used to point to, unless I'm misreading that
> code...  Or is it somehow prevented by drain-related logics?  Seeing
> that it seems to be possible to have kernfs_path_from_node() called from
> an interrupt context, that could be delicate...

kernfs_remove() is akin to freeing of the node and all its descendants. The
caller shouldn't be racing that against any other operations in the subtree.

Thanks.

-- 
tejun
