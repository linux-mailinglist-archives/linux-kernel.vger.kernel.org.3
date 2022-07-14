Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291235751CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbiGNP2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240242AbiGNP2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:28:48 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E9F11C2F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:28:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id e16so2147738pfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=1WXbs9Fy2MWdbGl25z8Oh8hLkXQ1fFvb9A9F5gVezUs=;
        b=SpCvPVu6C2PQfOt5+oRsi+icyQphag5PHEyWURhyDMjx2nGjQyavgX82qKJ6wR+z9N
         lJmcCb1xqCw17MwHGLiO/8SP6t3esyVR5KN0vGDVGAm/XYOukuPQXF1fn+5FmmejPDKy
         LAVDeZAcV/wWvkGCAzsaHmi0G5/duan7jR5eJXAt5I/V+kztGE/dd1GyLsMnABnVI7ei
         HWciE0epXZrqWzI2LB9Frd8TYCE2hwns7igroFHj/tnZwKFyzPXVM/Hwi7MQH1SkV/4P
         hBVctZ92B3WcfVTLsvKl0MHzsdneS3nlknF7pD70YQKnYnwHP/1FPx3GfXywCAKjeAil
         KzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=1WXbs9Fy2MWdbGl25z8Oh8hLkXQ1fFvb9A9F5gVezUs=;
        b=vZpMBKmxN5IrtQFVGWo7vd10v9pSYmR4/dCzbnxVf9nCF4mNJ9O1aXB4qpLCOixia+
         RJK6NiqqcuVkH/MZQ498xoRw+/9VE00KdNtKBuuCBxVp6gBKtPSHzRN0yPG17zExscR5
         8nEAkjrpN9iNp/lRnCuoh7wLWvIfaZm5RGzvrdHPFoVf+5EEwr9clvlelUXrmX3IFuT/
         8k6x99Vi7Ya4FYVxxKMyUyOwKuWI52A8Njh8a+giZnyt6aaOkPpEFkxOCbymkgEnKGpj
         FK7QkUX+/q2YDpAboUpCnCjuGicx0jsbpnx/zKpCD81M/S2LGhRP6/ltoExiUlWQOS61
         eyUw==
X-Gm-Message-State: AJIora+p4QmXnrKOzvqBpRZxrKAbUwEQXzT5adw9x5+zDxx+sGQ/FhLD
        h+ZxONPE725IVoviEW3d5v/ihrwL+aunXw==
X-Google-Smtp-Source: AGRyM1sT/B6Ji2BMAdZI5CJbIYsJ1bZpMHfyva4mzP6hjrXz0RiSEK03YMSpytRXkYKiZpU7sx2f4g==
X-Received: by 2002:a65:49c8:0:b0:415:e89d:ea1a with SMTP id t8-20020a6549c8000000b00415e89dea1amr8174459pgs.266.1657812523278;
        Thu, 14 Jul 2022 08:28:43 -0700 (PDT)
Received: from ArchLinux (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902860100b0016bfa097927sm1584352plo.249.2022.07.14.08.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:28:42 -0700 (PDT)
References: <20220707090501.55483-1-schspa@gmail.com>
 <0320c5f9-cbda-1652-1f97-24d1a22fb298@gmail.com>
 <YtAqsyjlvmfDokH/@worktop.programming.kicks-ass.net>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>, tj@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Use active mask for new worker when pool is
 DISASSOCIATED
Date:   Thu, 14 Jul 2022 23:17:59 +0800
In-reply-to: <YtAqsyjlvmfDokH/@worktop.programming.kicks-ass.net>
Message-ID: <m2y1wvd87z.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Jul 13, 2022 at 05:52:58PM +0800, Lai Jiangshan wrote:
>> 
>> 
>> CC Peter.
>> Peter has changed the CPU binding code in workqueue.c.
>
> [ 1622.829091] WARNING: CPU: 3 PID: 31 at kernel/sched/core.c:7756 sched_cpu_dying+0x74/0x204
> [ 1622.829374] CPU: 3 PID: 31 Comm: migration/3 Tainted: P           O      5.10.59-rt52 #2
> 									^^^^^^^^^^^^^^^^^^^^^
>
> I think we can ignore this as being some ancient kernel. Please try
> something recent.

I have merged all the workqueue changes from
Link: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/log/kernel/workqueue.c?h=v5.10-rt

And this problem can still reproduce.

I checked the patch from master tree too, it seems there is no existed
patch can fix this problem.

Or are there any scheduler, process management related patches that
might fix this problem?

-- 
BRs
Schspa Shi
