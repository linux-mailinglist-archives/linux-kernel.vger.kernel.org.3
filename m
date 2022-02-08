Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E3C4AE562
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbiBHXWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiBHXWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:22:35 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D516C061577
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:22:34 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id e28so1119121pfj.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 15:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65Yx3cIdfLzt0T+id6uVoCd7FXnXUVvDxA3gTNR3Dng=;
        b=D9YNuUVdJTulkSju/MM9sviTG6bckQkX/SIXUVO1UtmvIaPP8VkZNbvOeNoaFqcPI9
         UH23LE55wzOe4mCH81x1UYN4ER5e88H7pJ2UKltNDPfu6A/YPCCQugqamLLz/P5ETbC1
         apovZ0lNaHQ9V9HmAmlc/upFgiorgor0lyS6hTfOn/BJluWaNeBQo0rHngXxeWEbIDCU
         iKyCgb19m7k4h3e/ZIphkjrM7oxWS1JXyGNPnyWCvR06TmhKvtP7eygFOSmBg7ogChR2
         fvANAU4h1Er/ddhFqeYIlxNxdVzfjYmC6uJFaSmbw0ML4SUrLQ0pYrQ6qADLc1Wyo6hx
         MMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65Yx3cIdfLzt0T+id6uVoCd7FXnXUVvDxA3gTNR3Dng=;
        b=xyUCpSjN4o+n7LuRBg1IAW9UencYi9pr3ZQ2Jl/BkH8w9MbgECXIU/NBqxxp4dbjql
         9IEj8QhSoViHlpHFaUSKb00VlszuPvqOZj71xtHxVJJxv1FvHgAGs6hN35TTBJOeKgUd
         OlZkieAwVOEoikfiOmrvqFOtndUlHlugUjHB3UTo3joLsHrvlCPsoTmqvG54tAW3kRNp
         UhTc24wHOkzJca3bDpRwQ05yUMMrC2sVOGP4C54Eujs3WRbV5U8cxDlC0fAQOwYLTzPI
         vsBuLAzk7Ih57nnIb2/4qqLkGi/PleWHYHG8+g1QuYpHdeI8fV7nOZ56KN233yZAWr+t
         HQSw==
X-Gm-Message-State: AOAM530+qwCgqwIp9BrsS0YtJAwp4gdyZcFLnpC3fD/sQVGPLMX9s4G4
        8ZqAvDPs1BkNDi/hTUe/1fnOHMIi8PWwdazNINfu3zSFAWc=
X-Google-Smtp-Source: ABdhPJwFl69iK7ADPSSNO1REnB1wEk4TOLoSjHxhRyrj8iZ2laimMn3fDvfhzf8CkUPDdJGSGJZTS9pAfLYJWo9OU/Q=
X-Received: by 2002:a65:484b:: with SMTP id i11mr5240409pgs.40.1644362553514;
 Tue, 08 Feb 2022 15:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-37-ira.weiny@intel.com>
 <2193142f0cf3785a4225e0393eace397cbbe86e6.camel@intel.com>
 <CAPcyv4i_Jc865zEzNxbQB_XHqCwSS6zm_evquLv2BBu9ipa39Q@mail.gmail.com>
 <20220205054039.GE785175@iweiny-DESK2.sc.intel.com> <CAPcyv4hcKsy1Z78OyhPK+gPCqqEsbr9fuNRzOBNah03guDzktA@mail.gmail.com>
 <20220208224803.GI785175@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20220208224803.GI785175@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Feb 2022 15:22:22 -0800
Message-ID: <CAPcyv4iPT8r9ButHRJ2DsPQQMBN1rHCe1zSiV-rrag9vdqoW7w@mail.gmail.com>
Subject: Re: [PATCH V8 36/44] memremap_pages: Reserve a PKS PKey for eventual
 use by PMEM
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 2:48 PM Ira Weiny <ira.weiny@intel.com> wrote:
[..]
>  *      // 5) Add initial value to PKS_INIT_VALUE
>  *      #define PKS_INIT_VALUE ((PKS_ALL_AD & (GENMASK(31, PKS_KEY_MAX * PKR_BITS_PER_PKEY))) | \
>  *                              PKS_KEY_DEFAULT_INIT | \
>  *                              PKS_KEY_MY_FEATURE_INIT | \

Does this compile? I.e. can you have a '|' operator with nothing on
the right hand side?

>  *                              )
>  */
>
>
> Let me know if this is clear enough?

Looks good to me.
