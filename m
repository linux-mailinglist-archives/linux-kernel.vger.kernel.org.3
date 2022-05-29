Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6667C536F06
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 03:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiE2BZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 21:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiE2BZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 21:25:54 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0A35C677
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 18:25:53 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g13-20020a9d6b0d000000b0060b13026e0dso5491016otp.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 18:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iU/L4z31FrxEVnAnKalgBEe0gTrhifa4cOV0FrNiBlI=;
        b=irsPE4oMIQkSi0DtJcyKut3rR0IbGB2pS/+1W255QtWO4Kch7bDiKDATTIHCka9b5B
         eeuwLook/lkph3s9DIpSok/q3finlIRL1YLw9AJ5z8/A2a3kOWaka1vFdF1Pa4+EdtHU
         Vf7hCuayXStK/C60zVOH37vCMnPbXxgXOQowE01PXKgec6vh+juGnsVjlEflDC2MRLGV
         t3IK4Oysolg30GJOHAgyKRX7lI5VJHInWAv/XQHYdtsO2mfv1DmNjK19hB6JE2H76cam
         BQYW1QElQL0AAXOwWf9H5PBMTdn4QnfSyrDegyxheo6/L5qI3tSvMEZAncE7aMm0Kvr9
         U6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iU/L4z31FrxEVnAnKalgBEe0gTrhifa4cOV0FrNiBlI=;
        b=2nykYzZjiwcAro93p2ULN7h4D0Oo9QX3bpIjIIzvw28hHiaEMSMzNrre29tzmXpYVN
         8Lvmhyh32/xTswOzo052NgPl1828oJwGpk/F1QvA6pvCWqmQEk2fvoE+E57iEIy41Gdl
         HrYz+mcameMi6N6dg4j4ivQCAIz28Z9esuKttU2BuhLtU1uC1QoJdx8ypaoSQ4HqaNPs
         M7b4/gaiT5vzYhvI4vjDYfd7SSkIN/zHy6cb5rOJBapTaXaTTRAqYmVv7iwkTdKc2lkS
         mEuh7TVxA6wg9I9IYED+ZLHOZ0TLOtQYfxmiQBP7k7gs/AXobd5kka6kVFV9cgP0rY5Q
         gsLQ==
X-Gm-Message-State: AOAM532ELNSADPCsrSG74rxV6IY8cSfAtQmjL6mC/MaOgkOYQaXHEI+b
        610mcapdHqQljeL0QXU05Ps=
X-Google-Smtp-Source: ABdhPJwZ04/EXddCI+aJrUeq44lX2lBd9lsBJUAQy/dzyJzuad9YmFslGSV/VBPUtD/x9u+roYgOlw==
X-Received: by 2002:a9d:69da:0:b0:60b:1218:19ba with SMTP id v26-20020a9d69da000000b0060b121819bamr11983660oto.92.1653787553198;
        Sat, 28 May 2022 18:25:53 -0700 (PDT)
Received: from geday ([2804:7f2:8006:5ec0:8108:8ab5:1f16:73fe])
        by smtp.gmail.com with ESMTPSA id u1-20020a056808000100b00325cda1ff9esm3297766oic.29.2022.05.28.18.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 18:25:52 -0700 (PDT)
Date:   Sat, 28 May 2022 22:25:51 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: missing NOT while checking if Workqueue is
 offline
Message-ID: <YpLLnx8/xpZIPMbi@geday>
References: <YpKA5Bdk1Cm6KgKU@geday>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpKA5Bdk1Cm6KgKU@geday>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 05:07:08PM -0300, Geraldo Nascimento wrote:
> Greetings,
> 

Hi, again,

> This is a one-character patch but very important as the kernel workqueue
> __cancel_work_timer will cancel active work without the NOT operator
> added.
> 
> During early boot wq_online is false so with the NOT added it will evaluate
> to true. Conversely, after boot is done, workqueue

I meant wq_online. After boot, wq_online will evaluate to true, current
code might as well have an if (true) there. I hurried up the patch
because if I'm right this is a major show stopper to drivers that make
use of cancel_work_timer(). I hit it through amdgpu in conjuction with amdkfd.

> is now true and we want
> it to evaluate to false because otherwise it will cancel important work.
> 
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> 
> --- workqueue.c	2022-05-28 16:54:12.024176123 -0300
> +++ workqueue.c	2022-05-28 16:54:37.698176135 -0300
> @@ -3158,7 +3158,7 @@ static bool __cancel_work_timer(struct w
>  	 * This allows canceling during early boot.  We know that @work
>  	 * isn't executing.
>  	 */
> -	if (wq_online)
> +	if (!wq_online)
>  		__flush_work(work, true);
>  
>  	clear_work_data(work);
