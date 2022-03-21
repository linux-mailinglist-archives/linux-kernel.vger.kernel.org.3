Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F214E2E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351365AbiCUQqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344532AbiCUQqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:46:53 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBA43914C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:45:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mm17-20020a17090b359100b001c6da62a559so5118085pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AicliVQo9oPBK8n7poeLN51566am0Rt/VUvE8XrowPQ=;
        b=ZTiDb1aQ0Y7pdZtN6OoKWYvjwdAZqk/SO3bPioXF0K5AbLBvmws1X34rzqX80ZQIRw
         80bRadDMgRvlW8wQVA3cYBaJsameVfGTQ0veT1zsj7ylD4Y2c45f2VEqxWjaM/gmsbj9
         k1eRfDYXYsGK93GqgZiY9Q9LywnK+OzvnPQ9I5yS9+Y8Ipr2aMSF+mgsWMajY0I9DYll
         8OSaT/ML4OFsqOTghSpjGbfymkHK4wgVM7vMVXxhDcDIEJKg14UeluSfz1LouMScnQa1
         6Yqeb+e3qHRJTDqOM8Su5779tYTxX36JUx9XnMr4IVMF9C/uLwRO8+rne8XlHANsW1Sp
         0IFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AicliVQo9oPBK8n7poeLN51566am0Rt/VUvE8XrowPQ=;
        b=Ikinxr0oK45WL7t5vJNpG5wZzltWS9IvX05EpLHSrPu96cxIsfSu++3Vus7zmrpbvi
         EA4Q+ccIrfmNrFpSX9cYpWvMvpIVmUtx7ReP924R4NlsND9hRh5XnyH3FJV47ULZrDO9
         1CFcG+nVKuv85YWbjyq16uJnR0id7+qPBwxCyn4ZpxC+lVrUWLRmbOC24BPOvdX6ZEdQ
         4DzAkA5vOZLgQhMl+j3LCi0VXNfIo82KWpq1oK+0QjR00OaCiL77+SQ979sFNRw/z+YC
         CDf9dApTM08Chs2v/7vGlW3POpSbQEiDS6RU1SDHXAe3PpLSvCJZfQQlTA2u03vfY68c
         joSg==
X-Gm-Message-State: AOAM531Wd/aPifA24zui+HMexzpp3aBd5PQ3qtuBihsuu39PCwzcOVE6
        cKYgjEsLw873KDXcs5v4RoW1cddGPl7EGw==
X-Google-Smtp-Source: ABdhPJyHS1zM0QTpvbnngDrXsPaSf+9njyggsayW5v60DPCfyvZ73SqetYY/v51IhrBqSso7skltnA==
X-Received: by 2002:a17:902:e742:b0:154:3e6a:21c0 with SMTP id p2-20020a170902e74200b001543e6a21c0mr10091153plf.117.1647881126281;
        Mon, 21 Mar 2022 09:45:26 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id x2-20020a63aa42000000b0038265eb2495sm5477022pgo.88.2022.03.21.09.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:45:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 21 Mar 2022 06:45:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: An announcement for kernel-global workqueue users.
Message-ID: <Yjirozrn/iRHhN63@slm.duckdns.org>
References: <49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp>
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

Hello, Tetsuo.

On Mon, Mar 21, 2022 at 10:24:23AM +0900, Tetsuo Handa wrote:
> Hello.
> 
> The Linux kernel provides kernel-global WQs (namely, system_wq, system_highpri_wq,
> system_long_wq, system_unbound_wq, system_freezable_wq, system_power_efficient_wq
> and system_freezable_power_efficient_wq). But since attempt to flush kernel-global
> WQs has possibility of deadlock, Tejun Heo thinks that we should stop calling
> flush_scheduled_work() and flush_workqueue(system_*). Such callers as of Linux 5.17
> are listed below.

Hey, so, I'm not too sure this approach would work. Someone would have to do
most of the legwork and ping the respective maintainers with proposed
patches explaining what's happening why and how the proposed patches are
safe.

> I tried to send a patch that emits a warning when flushing kernel-global WQs is attempted
> ( https://lkml.kernel.org/r/2efd5461-fccd-f1d9-7138-0a6767cbf5fe@I-love.SAKURA.ne.jp ).
> But Linus does not want such patch
> ( https://lkml.kernel.org/r/CAHk-=whWreGjEQ6yasspzBrNnS7EQiL+SknToWt=SzUh4XomyQ@mail.gmail.com ).

You can *float* these warning patches in -next to help with conversion if
necessary but you really have to convert most of the obvious existing users
beforehand.

> Step 2: Create a WQ for your module from __init function. The same flags
>         used by corresponding kernel-global WQ can be used when creating
>         the WQ for your module.
> 
>     my_wq = alloc_workqueue("my_wq_name", 0, 0);

And, the first preference would be converting to use flush_work() unless
defining a separate flush domain to flush multiple work items is absolutely
necessary.

Thanks.

-- 
tejun
