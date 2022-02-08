Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009B84ADF6D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384218AbiBHRWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384210AbiBHRWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:22:48 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A6EC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:22:47 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y15-20020a17090a474f00b001b88562650aso1981607pjg.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 09:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vkwsMg8JIcYCvuRxCKyZKhniS3wznCIEfN9JuWpZlzs=;
        b=MkXyom8xyiPG/WxwzZZXl1x8vpzzXwe2JoYx8oz1Jl8dQTST0raqTCSmKisnBq5O30
         xCNDZaSb/+kMjKLx7lS0YJZWnbJ3/t0zgZXtSeBANnhLzPP9lMLNuoroIURJbszDGK7Y
         8TzyFbpmmqjLTquQPirjmezBA6bMoSHBtouYbA+FfTbSUEVLGFYe7lrbExAzSfEQiWJV
         iLCN5Ev61nBRm+oGiUKq4wnTkTCBlN0In/QIgQtko/aF9geOr/Vrd85K6/EBoR5oyqTg
         X7VsQLg9M+AJPvFhh2v8qRnJn4F6sVHJVvSoLGxWD2BMEC6bNl2SXwF8Xy9AJnY114e+
         dE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vkwsMg8JIcYCvuRxCKyZKhniS3wznCIEfN9JuWpZlzs=;
        b=DqmVIMDcfduKNRp/Kb0RF+RXrwGFZ359DKntHn4ryNOHh//iIHYSFQw71L3OMsScq0
         43F8uhc6qtbRA09MVFd92ZBXX6dPy0FpaLqT39C1jABvntjTJmK2aBqnGSvjY7xz3IlU
         39Ka2/wtsP1eKycR3Wh0K8gSdIbEJXPWo0k2yHMORrNxCFIIHha5zsvm/4Bc0es/b//u
         hjBVdxXMPIdX5NDR/AfcYDvmP4vfj0cUGHBvn0PSLEBSukfvf2YTl9bt5P2wUL7utWaH
         zMXBmFKIPXwpz1+ybHrBiCwSX0OHXi3d6S61/VmTh1mneLbaccoOg1HRZKfspPgfRhL2
         ksHA==
X-Gm-Message-State: AOAM530yIZc2AntQL6fnco/Wy2V8IUePqIoFcPeafKYCtiZ36xw07ul/
        V3AHxzREU4BKYF4rrVOVjKw=
X-Google-Smtp-Source: ABdhPJwqlB30dQX15Oaai5+7g929yw7jkaWgYZ12YXs+8s1KV43MFfoX3A8c22QQMTw8g1kSNyogLQ==
X-Received: by 2002:a17:903:41d0:: with SMTP id u16mr5490152ple.144.1644340967022;
        Tue, 08 Feb 2022 09:22:47 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id f3sm16813620pfe.43.2022.02.08.09.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 09:22:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 8 Feb 2022 07:22:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] kernfs: use hashed mutex and spinlock in place of
 global ones.
Message-ID: <YgKm5aSCcCYWkck2@slm.duckdns.org>
References: <20220206010925.1033990-1-imran.f.khan@oracle.com>
 <20220206010925.1033990-2-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206010925.1033990-2-imran.f.khan@oracle.com>
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

On Sun, Feb 06, 2022 at 12:09:24PM +1100, Imran Khan wrote:
> +/*
> + * NR_KERNFS_LOCK_BITS determines size (NR_KERNFS_LOCKS) of hash
> + * table of locks.
> + * Having a small hash table would impact scalability, since
> + * more and more kernfs_node objects will end up using same lock
> + * and having a very large hash table would waste memory.
> + *
> + * At the moment size of hash table of locks is being set based on
> + * the number of CPUs as follows:
> + *
> + * NR_CPU      NR_KERNFS_LOCK_BITS      NR_KERNFS_LOCKS
> + *   1                  1                       2
> + *  2-3                 2                       4
> + *  4-7                 4                       16
> + *  8-15                6                       64
> + *  16-31               8                       256
> + *  32 and more         10                      1024
> + */
> +#ifdef CONFIG_SMP
> +#define NR_KERNFS_LOCK_BITS (2 * (ilog2(NR_CPUS < 32 ? NR_CPUS : 32)))
> +#else
> +#define NR_KERNFS_LOCK_BITS     1
> +#endif
> +
> +#define NR_KERNFS_LOCKS     (1 << NR_KERNFS_LOCK_BITS)

I have a couple questions:

* How did you come up with the above numbers? Are they based on some
  experimentation? It'd be nice if the comment explains why the numbers are
  like that.

* IIRC, we split these locks to per kernfs instance recently as a way to
  mitigate lock contention occurring across kernfs instances. I don't think
  it's beneficial to keep these hashed locks separate. It'd be both simpler
  and less contended to double one shared hashtable than splitting the table
  into two separate half sized ones. So, maybe switch to global hashtables
  and increase the size?

Thanks.

-- 
tejun
