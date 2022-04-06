Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4464F6ED8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 01:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbiDFXt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 19:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiDFXtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:49:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F09B179406
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 16:47:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r10so4511583eda.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 16:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=02d0w8PmklTy+xy8dNE5jEsKmZD5PVzo6uj8ETuD9Nw=;
        b=q5IxDBxPTJcEcQP9qhwWClBC1OhCH0NQTxB5GqC5eH+IfAnpIXJzIBePtweUQ8ewXI
         J2M18uI4A8XKNzkwdKK/1TLJS+fHhklEGiACO+gWZPmeQcWGqsySBZ8ktt7ABE9FTRgc
         4hkcs0+4ipQEhip4GJvfyPpRPYBkPSRq/ezs6wpNAhL0jlc3tVE/kp4iW4hnQRlWf6YF
         6o0MRfRv8jfqcgaIm296k4SjrXRnYTpG3D/x1/AawuX9riD31U66i/fEO0mYRrDu3apa
         sYygC7Y9VAJgSuu36KlMrJoidWnSr6KJcN9ulNyHAk3EhPgpK9WxeX/ehdPn6yHLzE9E
         uD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=02d0w8PmklTy+xy8dNE5jEsKmZD5PVzo6uj8ETuD9Nw=;
        b=3UpsuAF4EmqFcl2FeGEYBMARyicSI9dp+7tzvsZlD+BueRPMnKsGgMWljXPVPYEH4V
         k5tWhT5sihPysFixXsnCO1dH5aE32EddaHzyOm8vvwC02qLOfag/9ElfWs6Ht/ax58wA
         eL50YNsPv5KQCFLFKsf2CHsZmxqOzZWyaaZ35VS0fOnFEVQ+XWDzE6PXEtsXJ0Ba6gny
         Rr0RwaXsXo50ZJE2cF7DpVAUdNVe5ga2LvOji/ux1f7MEIv3cizZT6pZ8fy5XEBif5E4
         lrIfc6kQ8uVrC0DgcXCuGBL0LrGleA8XRYravRo2xe1PqP1LlCY1Cu+h3Hwi3+qjzQs/
         1/fg==
X-Gm-Message-State: AOAM532UNnhfBP51Y8Z9ZDl6K2Qj+zH1g8O5HsGDd0zzuJ1ftqYm+ASL
        vF1FBiSNzmy5QwOFBT4xwwBBV2ARBTM=
X-Google-Smtp-Source: ABdhPJw2gOjynHQhfdqwHhOMPRayY6XDf5k93guIbpcmixLfmjXG92xiyf+CiYQHMxBtckrb3vJikw==
X-Received: by 2002:a05:6402:34c9:b0:419:53d2:83d0 with SMTP id w9-20020a05640234c900b0041953d283d0mr11090803edc.308.1649288875713;
        Wed, 06 Apr 2022 16:47:55 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id b20-20020a1709063f9400b006e12836e07fsm7062902ejj.154.2022.04.06.16.47.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Apr 2022 16:47:55 -0700 (PDT)
Date:   Wed, 6 Apr 2022 23:47:54 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_alloc: add same penalty is enough to get
 round-robin order
Message-ID: <20220406234754.4vpi5sjztcsusqiq@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220123013537.20491-1-richard.weiyang@gmail.com>
 <c56564cd-87f0-25c8-bb78-2bb8d8ad2655@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c56564cd-87f0-25c8-bb78-2bb8d8ad2655@suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 07:11:12PM +0200, Vlastimil Babka wrote:
>On 1/23/22 02:35, Wei Yang wrote:
>> To make node order in round-robin in the same distance group, we add a
>> penalty to the first node we got in each round.
>> 
>> To get a round-robin order in the same distance group, we don't need to
>> decrease the penalty since:
>> 
>>   * find_next_best_node() always iterates node in the same order
>>   * distance matters more then penalty in find_next_best_node()
>>   * in nodes with the same distance, the first one would be picked up
>> 
>> So it is fine to increase same penalty when we get the first node in the
>> same distance group.
>
>With that logic I'm not even sure if we need nr_online_nodes as penalty or
>it could be just 1. Would you know?

Yes, it has the same effect.

[    0.031849] Fallback order for Node 0: 0 1 2 3 4 5 6 7
[    0.031854] Fallback order for Node 1: 1 2 3 0 5 6 7 4
[    0.031857] Fallback order for Node 2: 2 3 0 1 6 7 4 5
[    0.031860] Fallback order for Node 3: 3 0 1 2 7 4 5 6
[    0.031864] Fallback order for Node 4: 4 5 6 7 0 1 2 3
[    0.031867] Fallback order for Node 5: 5 6 7 4 1 2 3 0
[    0.031870] Fallback order for Node 6: 6 7 4 5 2 3 0 1
[    0.031873] Fallback order for Node 7: 7 4 5 6 3 0 1 2

Do you prefer to set it to 1?

-- 
Wei Yang
Help you, Help me
