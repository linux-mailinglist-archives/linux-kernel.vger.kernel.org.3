Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10C752E704
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245383AbiETINx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiETINu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:13:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432BD56F98
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:13:50 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y199so7149947pfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EIB7I1izCiKqOcFIxWO4e4Y55iF6iq8HKn+j8l4m85k=;
        b=l5FqNy4IOsPn30GAhv5YZgTa/ATc/RMrO8LLQb2+ZeGbCy/l7dFWQJzCRHrWF+pNdZ
         5Kzg4CwqmGA/2z7Z87N+l095g4gd07Tdc22QNAQ03064+BgpzlI6DRkobXASad9OVMKX
         5nIHWqC3OYjkTEdbECoGeQPB0GVj5Flxq92K/mNoS3ZiTvk/ST6xby0yq8UNf0HwQSdP
         gL3vuF7LkXQs9reCJbardFAdJRiuP84INJGU/CzblAtYRXTU/iWPD8/oZwgCPsFisWeH
         fWEl03rbbW19aCf3Un8h4QX5N+jcwyvkGoUYBbECQ/Z6KjR2fwwZIGsDtxMxQx6ThRTO
         V32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EIB7I1izCiKqOcFIxWO4e4Y55iF6iq8HKn+j8l4m85k=;
        b=Sd+pZMA7GdqLMz4BEsstz/LzcCrQyO+sgewtveWA5shBXGKzdjOnpTy1kORQ63ntAe
         GfYtQ/rBFcKCkAUJmQuILyg6/uBHeLSc4K7V8EvJ206+KWKkHiceK2+thJGrOtdowRs5
         yjRdPHsuzjnML3gPVjCFyOimEDhoRIWfwD00I59dVmlbyBqiEU795do4utKlEoi8ucda
         sMaPn7v0ABVdgv6w1PJq+ycDFPZa2mOVU5t546w6bwu6CxxGdrHekwgPvYE6TxEFkCvz
         F8hFQ++PCUCZDHXXj0JGfh5Aa2oAAdFClH2XEfclZLZah0D0n17FeMqrGFOSweHtnOQV
         XMKg==
X-Gm-Message-State: AOAM533I0+VfO8NWMtI13AQty8vTQAaP4+Gh2d4Ca4blmxjNIjhQ+pOb
        aF2aZfKEFd5b/iYzJnGQv3E=
X-Google-Smtp-Source: ABdhPJyU6MeKG/U3vVDarJSOP+UaAJpwGqEaW7e7mjKiG0rQcQRP/t86aQEPrI2FMr2k0aUeeO1QgA==
X-Received: by 2002:a63:5c22:0:b0:3db:141c:6db2 with SMTP id q34-20020a635c22000000b003db141c6db2mr7398703pgb.198.1653034429671;
        Fri, 20 May 2022 01:13:49 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:1761])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b0015e8d4eb2c0sm4995113plh.266.2022.05.20.01.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 01:13:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 19 May 2022 22:13:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Hillf Danton <hdanton@sina.com>, Michal Koutny <mkoutny@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzbot+e42ae441c3b10acf9e9d@syzkaller.appspotmail.com
Subject: Re: [PATCH] cgroup: don't queue css_release_work if one already
 pending
Message-ID: <YodNu2C5iHKW3UeZ@slm.duckdns.org>
References: <20220412192459.227740-1-tadeusz.struk@linaro.org>
 <20220414164409.GA5404@blackbody.suse.cz>
 <YmHwOAdGY2Lwl+M3@slm.duckdns.org>
 <20220422100400.GA29552@blackbody.suse.cz>
 <20220519112319.2455-1-hdanton@sina.com>
 <25fb057a-077f-b601-dcb7-130071c733db@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25fb057a-077f-b601-dcb7-130071c733db@linaro.org>
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

On Thu, May 19, 2022 at 04:26:51PM -0700, Tadeusz Struk wrote:
> On 5/19/22 04:23, Hillf Danton wrote:
> > On Wed, 18 May 2022 09:48:21 -0700 Tadeusz Struk  wrote:
> > > On 4/22/22 04:05, Michal Koutny wrote:
> > > > On Thu, Apr 21, 2022 at 02:00:56PM -1000, Tejun Heo<tj@kernel.org>  wrote:
> > > > > If this is the case, we need to hold an extra reference to be put by the
> > > > > css_killed_work_fn(), right?
> > That put could trigger INIT_WORK in css_release() and warning [1]
> > on init active (active state 0) object OTOH as the same
> > css->destroy_work is used in both kill and release pathes.

Hmm... wouldn't the extra reference keep release from happening?

> Will this help if there would be two WQs, one for the css_release path
> and one for the rcu_work?
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index adb820e98f24..a4873b33e488 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -124,6 +124,7 @@ DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem);
>   * which may lead to deadlock.
>   */
>  static struct workqueue_struct *cgroup_destroy_wq;
> +static struct workqueue_struct *cgroup_destroy_rcu_wq;

I don't understand why this would help. Care to elaborate?

Thanks.

-- 
tejun
