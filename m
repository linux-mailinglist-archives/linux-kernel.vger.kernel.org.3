Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6634E4838
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 22:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiCVVVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 17:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiCVVVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:21:34 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B358D4C408
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 14:20:06 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id o13so13519897pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 14:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RchwFeHnAgjVWoa34ourakFD10mLtoxIuJ+lDmxFKKg=;
        b=ZqV8cykf9WeQtP+YSmYl6cpCPrbad2cfJeryFJXKq8NaQuH88oFy5Ywt3scHYMzsWS
         XZhPBvKSVHloYGZR5Px1AtbtO+nOqAWMaPRr1bQtHtA/ozHk9i0GzgYyK283QCIS69z9
         q5MQvlx70XnP8/H2Ky8MJrQRnvQtT8uQxl3w+2I8ZIGQhUVpHozrjDel+AyjEiBxkIj4
         EkAvL0airjZRPoXvXqMudZt/Ilax7DQuIvVSZqqWdZbnw/shR1k6B8jewK+RmNkdgwH/
         e/r7XEDQA2Qm4SdwXzeUVFD4DPUAXqT5hpycPEvtWZ6B34/PFIM1VLT3FLfq+QULoixq
         LNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RchwFeHnAgjVWoa34ourakFD10mLtoxIuJ+lDmxFKKg=;
        b=JFn8Fubg6eUC6ke890HPwcZCNamZdZkjkpyiKuBcFuye9rom23Hxrv17ftaxJfOSWj
         GusaQU9WfWsmP3x5oTjuPrJManx6g+Gmz50zY649fyLdd/rQ9XRCm9oC9YNeZw1APt6C
         SoI/+c7eF57bE0/Y17l9lDbg3zjkh9ucbtZX4ewmkPSlaZKiuT3F1rI0Sk1byZFBJL9I
         bvKiCjzpsgoeTjEONxuxvXT4GeBVfgYx9je1RXAfZumtcW0eAHnCz6rkyzoMDC3c88ZF
         qWDRyqfHLBMu5U4yN7lF7oUEjF7B5O0DeWaWbMNEC/wfWKQiRW5aeTb2NKN3Od9iKaFy
         UQyg==
X-Gm-Message-State: AOAM530HG3ZO0ei2qMNicpq5Seqj7cKwmSjzSZu/pEAfCzRIXLzMaLIB
        DtEzGOZ5dvNj4BV6JINxAXVtAPqR3kdJeA==
X-Google-Smtp-Source: ABdhPJwOYIGapJ3FHXd7tkbK1F+Nd46r3WV+r96ZYtxcIYZaGcriVzpOtGkfHd902PVJ/2RcT00ppQ==
X-Received: by 2002:a05:6a00:d6a:b0:4fa:6940:f2dc with SMTP id n42-20020a056a000d6a00b004fa6940f2dcmr25906612pfv.61.1647984005775;
        Tue, 22 Mar 2022 14:20:05 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id g3-20020a056a001a0300b004fa65cbbf4esm17704415pfv.63.2022.03.22.14.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 14:20:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Mar 2022 11:20:03 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Imran Khan <imran.f.khan@oracle.com>, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 7/8] kernfs: Replace per-fs rwsem with hashed
 rwsems.
Message-ID: <Yjo9g6+PkxeRgNif@slm.duckdns.org>
References: <20220317072612.163143-8-imran.f.khan@oracle.com>
 <YjPNOQJf/Wxa4YeV@zeniv-ca.linux.org.uk>
 <536f2392-45d2-2f43-5e9d-01ef50e33126@oracle.com>
 <YjgpaeFfFandY999@zeniv-ca.linux.org.uk>
 <Yjir/d5S3J1PTiux@slm.duckdns.org>
 <Yji8KT2K7ZKOQ+6S@zeniv-ca.linux.org.uk>
 <YjjP5ldCCGYqD+UV@slm.duckdns.org>
 <Yjk3Nqft/U6vDvd1@zeniv-ca.linux.org.uk>
 <YjoCqqs+UDxZ55nM@slm.duckdns.org>
 <YjoxDicNK1pTkrKJ@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjoxDicNK1pTkrKJ@zeniv-ca.linux.org.uk>
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

On Tue, Mar 22, 2022 at 08:26:54PM +0000, Al Viro wrote:
> The only thing that matter wrt rcu_read_lock() is that we can't block there;
> there are tons of plain spin_lock() calls done in those conditions.  And
> rcu_read_lock() doesn't disable interrupts, so spin_lock_irq() is usable
> under it.  Now, holding another spinlock with spin_lock_irq{,save}() *does*
> prohibit the use of spin_lock_irq() - there you can use only spin_lock()
> or spin_lock_irqsave().

Yeah, I was just listing different cases to make the point that these
functions don't know what context they might get called in.

> The callchains that prohibit spin_lock() do exist - for example, there's
> pr_cont_kernfs_path <- pr_cont_cgroup_path <- transfer_surpluses <- ioc_timer_fn.

Yeap.

> 	Out of curiosity, what guarantees that kernfs_remove() won't do
> fun things to ancestors of iocg_to_blkg(iocg)->blkcg->css.cgroup for some
> iocg in ioc->active_iocgs, until after ioc_rqos_exit(ioc) has finished
> del_timer_sync()?

Ah, okay, I was wrong before when I said that kernfs_remove() is like free.
It puts the base reference but as long as anybody has a ref on a
kernfs_node, the node itself and all its parents are pinned. For iocost,
ioc_pd_free() which is called from __blkg_release() ensures that the iocg is
off the active list. __blkg_release() puts its css reference before calling
ioc_pd_free(). If this were the last css of the cgroup, this can trigger the
destruction of cgroup, so the order doesn't seem right - we should call
blkg_free() first and then put the references. However, given that both css
and cgroup release paths involve a RCU grace period and __blkg_release() is
called from rcu callback, I don't think the race window actually exists.
I'll still send a patch to reorder the puts.

Thanks.

-- 
tejun
