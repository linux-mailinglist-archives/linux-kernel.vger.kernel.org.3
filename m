Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BD2531B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiEWTZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiEWTZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:25:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42313174911
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:04:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 202so7495969pfu.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ry0605dl+YcGvkJKzAEQ3WcZNm1x8lAWLbnXr+W+zTI=;
        b=kKZDJvitoPDX7n0OSbQVwarphKOVShdw4sHCRu1Az9GlaT12ZJlQAGoG4txmt1fjI3
         OaOMwlkfS4qtGPOkaZnqOlRk7x8goZ+RVanUTJkEvDw5lS2dmzZe3CPN7MBSj3s1BHRo
         qHeAn08E7v9t6nzCvD5ZYajIKXpiQ9efwrU2eraaZmQySDCSV49WZyb/lXlg0kfoGe8s
         kXJmdAnn3a3cuF01MPxJLKZx8daZu7kTLsPkjPYMvdUsihJeiOS+MKYywUw33pVHyDN1
         U671hNMKSeiz8vGRiRt4TRJT9mJcGQ4+J4p22kc8enymXkJ625hy7Fa9lYFArm+RuURH
         LxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Ry0605dl+YcGvkJKzAEQ3WcZNm1x8lAWLbnXr+W+zTI=;
        b=7gt2GK4XYS5fq78EjBYXdINEs1xaAOKUI60ylkkq/yXv903lRG2yKlLhV3740i/bem
         AMSbD/0oa8IPC7aaLG4rGtHXb0xRUhjQZbY7dG0IQo5FFiaXKfKbNyncSrbA1V/4Nyeo
         mqv6HpXRcDfRo5WoLqMhPrKzOnsTudM5j9Q6NgNy5okmrvFIPfq+czlLCeXtbkyJoxPl
         pW2eAYCnEgkeumleMSPZMBiQpyOF7rAv3Oa+ua1bMQ0J+NKmo/vpEInW8sSyYqUlr5ot
         0zv18jJMZyB7XhKd1Ev5+qZQl3TsccXymITZDzj0r4ptJ5e8oS/lQko2c5axeE+dN//Y
         PTvA==
X-Gm-Message-State: AOAM533sLbc9yaVsGiaiX4wfGDdm5R9CIULMdVw6dp/Sq86zj6CcMPst
        Sab1TuAxhegjeeWdZ22byBnzLWQ8V54=
X-Google-Smtp-Source: ABdhPJxndU8LKAzlicd0O4iMleYxPzC4VW6YIK4yZJChhqi60vvIqWO2ra0TlmBZg1vxwxy0CET/nA==
X-Received: by 2002:a65:42cc:0:b0:3a9:f71f:33f9 with SMTP id l12-20020a6542cc000000b003a9f71f33f9mr21303921pgp.391.1653332658580;
        Mon, 23 May 2022 12:04:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:aafd])
        by smtp.gmail.com with ESMTPSA id g25-20020a639f19000000b003f5eb31fc4bsm4969105pge.11.2022.05.23.12.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 12:04:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 23 May 2022 09:04:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] workqueue: Wrap flush_workqueue() using a macro
Message-ID: <YovasFyOcKB6ZanQ@slm.duckdns.org>
References: <7b2fecdb-59ae-2c54-5a5b-774ef7054d1b@I-love.SAKURA.ne.jp>
 <1c1b272b-239c-e1d1-84de-47d02feb911e@I-love.SAKURA.ne.jp>
 <YodK1czmhZtGmJ8E@slm.duckdns.org>
 <5f417d30-34a7-8da1-0ad5-33bd750582c7@I-love.SAKURA.ne.jp>
 <Yod3S8jmle+LYlES@slm.duckdns.org>
 <1a1634ac-db0e-a44c-b286-a3aba55ad695@I-love.SAKURA.ne.jp>
 <YofLmMTAjNVM+9nQ@slm.duckdns.org>
 <d05f4745-ba08-61eb-4780-ddfe50d0f1b9@I-love.SAKURA.ne.jp>
 <YohxUC45xk523g9I@slm.duckdns.org>
 <e9df5f75-2958-db1b-462d-dba4a0455f44@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9df5f75-2958-db1b-462d-dba4a0455f44@I-love.SAKURA.ne.jp>
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

On Sat, May 21, 2022 at 08:37:19PM +0900, Tetsuo Handa wrote:
> +/*
> + * Detect attempt to flush system-wide workqueues at compile time when possible.
> + *
> + * Always warn, for there is no in-tree flush_workqueue(system_*_wq) user.
> + */
> +#define flush_workqueue(wq)						\
> +do {									\
> +	if ((__builtin_constant_p(&(wq) == &system_wq) &&		\
> +	     &(wq) == &system_wq) ||					\
> +	    (__builtin_constant_p(&(wq) == &system_highpri_wq) &&	\
> +	     &(wq) == &system_highpri_wq) ||				\
> +	    (__builtin_constant_p(&(wq) == &system_long_wq) &&		\
> +	     &(wq) == &system_long_wq) ||				\
> +	    (__builtin_constant_p(&(wq) == &system_unbound_wq) &&	\
> +	     &(wq) == &system_unbound_wq) ||				\
> +	    (__builtin_constant_p(&(wq) == &system_freezable_wq) &&	\
> +	     &(wq) == &system_freezable_wq) ||				\
> +	    (__builtin_constant_p(&(wq) == &system_power_efficient_wq) && \
> +	     &(wq) == &system_power_efficient_wq) ||			\
> +	    (__builtin_constant_p(&(wq) == &system_freezable_power_efficient_wq) && \
> +	     &(wq) == &system_freezable_power_efficient_wq))		\
> +		__warn_flushing_systemwide_wq();			\
> +	flush_workqueue(wq);						\
> +} while (0)

Please just rename the backend function.

Thanks.

-- 
tejun
