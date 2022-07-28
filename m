Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D0158444D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiG1QkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiG1QkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:40:20 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED72465CC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:40:18 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 6so1928191pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=Jx3fjLO5Rw80zgj8Pe6hN2gdWGaZqNpaZHeq5jpljnY=;
        b=TRYbBxtVyplJA8c381OUhjCudBIy3CkwpJnag+ockqvRwYZTrqXv65PA6Xav+hVY8o
         4ru8WTL0ywTxTmmsgepswvra1JSVZPiRs1pMfiV3CKh80RS2HsD2x5smATwqseBmxrkn
         pjBb0wr6c6d6Ajkv/38kncH0y23tixmfImWFz+4GNC9Zm9/IONkq9UAMZpDH2ntf+88g
         4fQYfFLFPBHq0OJaW+dfxC1TZ+7e/ulYLCLNFzioX/TcMJQ2uv99ZXJu/7jSijlbY/RS
         /+7Zzj395UXWLaKIkibX6HwBZa2c0g9OuV2m16DQNOTLrOlo+Y3/jJEZdovJk1y9WIKA
         MPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=Jx3fjLO5Rw80zgj8Pe6hN2gdWGaZqNpaZHeq5jpljnY=;
        b=E0nwyGhv956Cxv2CUmobzaLnGFaNqviwtJQCFRlaY4iVuTeHJL9PCO1z6ho8y45SuE
         soe+0/VIL0ZCaxO6P99xTuS88Rl/cHEhU2hHSOpjlpJdhUsoALGAysKCmlH+I0vILtbX
         j6cznPC7qBBkS3qPPWMAP/hQSz93SnTKHMnbe9PqaRRvZGUPTsxgD+zpWuiwE/ZyvP2C
         nFm6m230JvcOgQyiwEZsiJmk+oQoH96NdhKaQKiQE7/FKx4daSKo9ntYK1iDMQSEpQX3
         gURCYHWlmQlBwJ7ANOjZqAUiUDlz0uFFGXyd46N94voqHdtZZyfRXptBJqa7peeA1uBi
         L/fA==
X-Gm-Message-State: AJIora+u+9EOEuRmzKGUprIv22Pn5FyCgHEFukATlNC9EyOI6eNxS5jY
        KVv7V0y+yBotYSX3bvMuEFKkFQO3c2I=
X-Google-Smtp-Source: AGRyM1tZ1pnd3F9tbC8QoL0a4vTAHzymeZgopSUWAUT4pebjLdSRFhjRLDGyKW4vEunps4Zs/YAB6w==
X-Received: by 2002:a63:4c61:0:b0:416:1e62:953c with SMTP id m33-20020a634c61000000b004161e62953cmr23130767pgl.24.1659026418308;
        Thu, 28 Jul 2022 09:40:18 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902e14c00b0016be368fb30sm1460501pla.212.2022.07.28.09.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:40:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 28 Jul 2022 06:40:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: don't skip lockdep wq dependency in
 cancel_work_sync()
Message-ID: <YuK78Jiy12BJG/Tp@slm.duckdns.org>
References: <21b9c1ac-64b7-7f4b-1e62-bf2f021fffcd@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21b9c1ac-64b7-7f4b-1e62-bf2f021fffcd@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 09:23:25PM +0900, Tetsuo Handa wrote:
> Like Hillf Danton mentioned
> 
>   syzbot should have been able to catch cancel_work_sync() in work context
>   by checking lockdep_map in __flush_work() for both flush and cancel.
> 
> in [1], being unable to report an obvious deadlock scenario shown below is
> broken. From locking dependency perspective, sync version of cancel request
> should behave as if flush request, for it waits for completion of work if
> that work has already started execution.
> 
>   ----------
>   #include <linux/module.h>
>   #include <linux/sched.h>
>   static DEFINE_MUTEX(mutex);
>   static void work_fn(struct work_struct *work)
>   {
>     schedule_timeout_uninterruptible(HZ / 5);
>     mutex_lock(&mutex);
>     mutex_unlock(&mutex);
>   }
>   static DECLARE_WORK(work, work_fn);
>   static int __init test_init(void)
>   {
>     schedule_work(&work);
>     schedule_timeout_uninterruptible(HZ / 10);
>     mutex_lock(&mutex);
>     cancel_work_sync(&work);
>     mutex_unlock(&mutex);
>     return -EINVAL;
>   }
>   module_init(test_init);
>   MODULE_LICENSE("GPL");
>   ----------
> 
> Link: https://lkml.kernel.org/r/20220504044800.4966-1-hdanton@sina.com [1]
> Reported-by: Hillf Danton <hdanton@sina.com>
> Fixes: d6e89786bed977f3 ("workqueue: skip lockdep wq dependency in cancel_work_sync()")

Tetsuo, you gotta explain why this is okay w.r.t. the spurious warnings that
the above commit addressed. You can't just state that there are cases which
are missed and then revert it.

Thanks.

-- 
tejun
