Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D7D5AD9A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 21:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiIETcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 15:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiIETcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 15:32:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FA619287
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 12:32:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b14-20020a056902030e00b006a827d81fd8so4538271ybs.17
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 12:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=nzYPTXzWW9nmntWCV8Vh/LKoFqcXyIKvmgnu1hGqu7k=;
        b=WjbKtL1D/4BXosFYcBo3Si+QUfuKWnKSWJbeLnRZnaybjfLdGcEJjjFW57YuBXnd7j
         VG3d7Mmo3qrYy0ZyW1mYkiDPH1xODzNXv7eE2AL+LxXcuucTAmmD8nt80QxlxPYdTItP
         GF5/MRKziOzianOw+Uxq4CNNYNO2p3srplb3WOIVzrEHuBdy5569DMrcyeNyaIaz6ryv
         YofbNi4e2vtlS0wPOj8QD36kSGIZirDb7K45pWi1bHqv+cALIJ5RizNMyfHcuVKAbONz
         zgdCwUZq5aIx3WjrC0EddIwXSy9UHyfMOQgIbSLAJRqN5g2RspVR/JJVASoMFonflc2L
         EtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=nzYPTXzWW9nmntWCV8Vh/LKoFqcXyIKvmgnu1hGqu7k=;
        b=xZmW21fCkSvKiNFweFt+L93os3yKErN2EAdsOCvd5eIml78wlHbRge7O8e4VuGjooW
         naw5crsEdh4iLa4/YO8GX1mBwYRMPzz/5PuGHXXuEdGC1T94kej7xi18UYkyrLHPXRPL
         EaNPhS2/k1wWmeAo0Q9e3JQ8DuKk8W6/8HT6treB4MtmsDPV7q56DcK1iOjUtr4sopUT
         MRUFCxq/WvgkOMX0pO1iszmQL8b+6YcaREkdN3/BQS7FUE69SLLd3pK5D8hJYlLtfSmM
         WNRgnXxExuUwlnH+oPEUn/QvIG76O34K3g0ymKCTIKwdJWQl+e+p/27zvieI0ihRF+C9
         VG9g==
X-Gm-Message-State: ACgBeo2bLgQcU0PI+flxjwhvN14N/Lr5Nwb5sTj/EdZWH51v3d44Dn2T
        uEVEd1KnjIddl0pDPhSHP4iyNcjV+R6iXg==
X-Google-Smtp-Source: AA6agR45LtLtFdonuDVQF86B/UUUAlIaw1OBFliTILqCjdA5n/Kgr/GmjivDnXK1JxcUbWbLC/ps6jCHTlNz9A==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a0d:d2c1:0:b0:33e:e1f4:4bb0 with SMTP id
 u184-20020a0dd2c1000000b0033ee1f44bb0mr38132884ywd.234.1662406322246; Mon, 05
 Sep 2022 12:32:02 -0700 (PDT)
Date:   Mon, 5 Sep 2022 19:31:59 +0000
In-Reply-To: <20220905193516.846647-3-jiebin.sun@intel.com>
Mime-Version: 1.0
References: <20220902152243.479592-1-jiebin.sun@intel.com> <20220905193516.846647-1-jiebin.sun@intel.com>
 <20220905193516.846647-3-jiebin.sun@intel.com>
Message-ID: <20220905193159.eeu2xmqj6743kzxv@google.com>
Subject: Re: [PATCH v2 1/2] percpu: Add percpu_counter_add_local
From:   Shakeel Butt <shakeelb@google.com>
To:     Jiebin Sun <jiebin.sun@intel.com>
Cc:     akpm@linux-foundation.org, vasily.averin@linux.dev,
        dennis@kernel.org, tj@kernel.org, cl@linux.com,
        ebiederm@xmission.com, legion@kernel.org, manfred@colorfullife.com,
        alexander.mikhalitsyn@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tim.c.chen@intel.com,
        feng.tang@intel.com, ying.huang@intel.com, tianyou.li@intel.com,
        wangyang.guo@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:35:16AM +0800, Jiebin Sun wrote:
> Add percpu_counter_add_local for only updating local counter
> without aggregating to global counter.

Please add why do we need this. Who should use this and who shouldn't.

> 
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>

[...]

> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> index ed610b75dc32..d33cb750962a 100644
> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -72,6 +72,12 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
>  }
>  EXPORT_SYMBOL(percpu_counter_set);
>

Add a doc comment here on why someone want to use this?

> +void percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
> +{
> +	this_cpu_add(*fbc->counters, amount);
> +}
> +EXPORT_SYMBOL(percpu_counter_add_local);
> +
>  /*
>   * This function is both preempt and irq safe. The former is due to explicit
>   * preemption disable. The latter is guaranteed by the fact that the slow path
> -- 
> 2.31.1
> 
