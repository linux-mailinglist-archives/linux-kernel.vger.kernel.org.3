Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06F2536FDC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiE2FyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 01:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiE2Fx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 01:53:59 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84B95622C
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 22:53:58 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w130so10505415oig.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 22:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VIS+wex15RjJjnP3IC3f+DeaURA34+e1K2Y/VUb1vUE=;
        b=URJX4oD2EgfSpoNO+0r5dLKdtue5Ifu5Wkh2KLAOMO1BMlgqrAeSv9HwBc1Zbq0apc
         K4AZxDONmeGcY+ck/I6bBI74Kg5+faK0bHiZ8b7sYAOTkC/pNZcp05aqjdvqcD5SBPGb
         4I3JjllsLScaFUqEOEgQmUh/XsgaJe9xRqdOHwMWpSNrmRPALedRr3RfbPt4gQIuaZ04
         6yb61j+Gatf/Ck0EvA+xErsPW8FiiF3NUHBWfUXG1c8T4S61/kS6DcPMYdfrkmpsv03c
         ICbY4Dpw/vHcKHUiWl+Tg3Hz2BZU3Nud+DbcfbzAyi5/kCU4pLyazjyl+nvpVaRXiA4y
         IlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VIS+wex15RjJjnP3IC3f+DeaURA34+e1K2Y/VUb1vUE=;
        b=iVRdbC7GDQ77OnhOkTxX6yv9OCKROY6DC/sy5j8JYUWi2FFQGYsNuEBA8Evm9hMa2o
         YPWTpCvOOANMKFarJLvxhuyj5FX6Zt1I1S5OhETXdzatggfL4+8lVRevuO/ENSM8xWu7
         nnvzK1WDtfT7M2hVRFT4qfjiq6S6Gfl+B3MYZB45M7JD2T2HMvyyaoP3LfFjXEvVDJE4
         nUJCsCVq4OhAytMx3L/P1YHdCJmhrd3+AjNheZYByVvPiGJE/a1dunnGDiFMlP3gYnKp
         efGjF7YeNFBYK9T/eMUWc5MiwrX5ad+0fgiXEHkW2a+682qcrrT4YW9KwojyWu8SREW8
         43aw==
X-Gm-Message-State: AOAM533EBImSuJhSrW0yR775v/4EFff0HGTtNCrVhK0yOMoEA5tDTos9
        a9poH0TDbY1qwFgHCLTv16oc8jJR9AY=
X-Google-Smtp-Source: ABdhPJz6j+yVOjZYOkEZkKL3loNsQUZQooanHDPiFOm687axOyYH5ekkZb9u55X9EDpaYUvJBn7ZEw==
X-Received: by 2002:aca:110c:0:b0:32b:bb17:80d with SMTP id 12-20020aca110c000000b0032bbb17080dmr6961430oir.186.1653803637394;
        Sat, 28 May 2022 22:53:57 -0700 (PDT)
Received: from geday ([2804:7f2:8006:5ec0:8108:8ab5:1f16:73fe])
        by smtp.gmail.com with ESMTPSA id n8-20020a056820054800b0035e9f149b90sm3817596ooj.3.2022.05.28.22.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 22:53:57 -0700 (PDT)
Date:   Sun, 29 May 2022 02:53:39 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: missing NOT while checking if Workqueue is
 offline
Message-ID: <YpMKY88/2tTK319E@geday>
References: <YpKA5Bdk1Cm6KgKU@geday>
 <YpLLnx8/xpZIPMbi@geday>
 <YpL2rHUXd0vf8IML@geday>
 <YpMDmZZ7IpEhjywp@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpMDmZZ7IpEhjywp@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 07:24:41PM -1000, Tejun Heo wrote:
> On Sun, May 29, 2022 at 01:29:32AM -0300, Geraldo Nascimento wrote:
> > I would like very much to hear the opinion of the maintainers!
> 
> I have a hard time understanding what you're trying to do. Can you please
> slow down and start from describing the problem itself?

Hi Tejun,

Sorry for the hurry.

The problem is best described in https://gitlab.freedesktop.org/drm/amd/-/issues/1898

From my understanding from the context of __cancel_work_timer() we should not
ever call __flush_work() but I may be wrong. In the present case as
described in AMD's GitLab __cancel_work_timer() is being called by
cancel_delayed_work_sync() inside kfd_process_notifier_release()
from drivers/gpu/drm/amd/amdkfd/kfd_process.c:1157 (Linux 5.18).

We should only call __flush_work() from __cancel_work_timer() if
workqueue_init() is not yet initialized, that's possible during
early boot though not very likely. Anyway that's before kthreads are
spwaned, so we are sure that particular work isn't executing, hence
why it's safe to call __flush_work() in this particular case.
The comment on kernel/workqueue.c:3157 (for Linux 5.18) says it best:	

	/*
	 * This allows canceling during early boot.  We know that @work
	 * isn't executing.
	 */
	 	if (wq_online)
		__flush_work(work, true);

If __flush_work() is ever called during early boot it will result in a
WARN_ON because workqueue is not online. I have no idea if that's OK
though it hasn't harmed my machine. Of course I don't want to introduce
bugs, I wanna solve them, and I appreciate your cautious approach. Thank
you for the work.

What is not OK apparently is trying to use amdkfd without HSA_AMD_SVM configured! :)

Thank you,
Geraldo Nascimento

> 
> Thanks.
> 
> -- 
> tejun
