Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20184EA45A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiC2Auj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 20:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiC2Auh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 20:50:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD5EDF6D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 17:48:55 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o10so32012904ejd.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 17:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2KkRgW8qJAAnPMyCiJ8EOME7H/pHXL44sx8xKCxSZzg=;
        b=HFfcTsqmkj3HWmiGc/GrOX/rtjkgqqs5u0see8c078pjGfdUP+zhJZ2Yq0hFvakGCB
         kgUcuuVAjTWp3aTF0rxXxYRq4iJ3wnWlh2KMUyI7lo3ctLjG99DbG9KfeRNklKY3AMKH
         P1Q6dlRf1CiUaCbKwgiLaunWKNL29LeKmb8FIRB0WMu+Wl2xzGSIyIhWgl5ssqsYLIWw
         mZTuqRMfxI9BX0RTpPqpefp+nyFR0ddmDFXS/d4Eq6p0Kn0Oeaop6e6a7D6RzkOug4MF
         kKKFBTH+Czj8FmVsWlOPGk1GJlJ6cyzKS3TW1/A+QvYd5UzwtpJXGN8scLCQQNVGW7Gv
         9KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2KkRgW8qJAAnPMyCiJ8EOME7H/pHXL44sx8xKCxSZzg=;
        b=a4owAREiFOGnyaoTVTCJ0m5h6KkwE0sLbyrJRhzMAhvoixzvZlHy3rkEb23iBmFT5V
         /yw+iuG3Rmh76Op4xwIYsU+xTHPCHKdTrs4rdiYYiHtvVxl9UpDwNpTvvnM5sU+kOAnx
         kGlHMrug09W8EA2ChbINZmMTfuRh6sBbFIiLeJs5ro7IePx6Ms8w7ueBOn0jQUWAZ2XQ
         ZR44u2RuYB/IiHrapP3VHpeV4cBXvhiot25RNgRo9mTqOXdPzbG4B1MviR6Hfg+H+3zy
         p4DHPfLRqwZ/thnQSTgClHhCkrTRPT7z7ZtAUqXtlY5UpMhEfDeKiKZOLk1ZcxZL16RV
         mrpA==
X-Gm-Message-State: AOAM531NwUBW4RMFzKqcdRruqZ7KKR1fkE9Wagr3avq4Fjn9zz5vgXi9
        UK54zaDfe78Fw81ZdAfm7qA=
X-Google-Smtp-Source: ABdhPJzhV3vijKYLVVmrkTn1ZQyQKdbkOWIE1WsmL7ZQ9kIXD14Jul8fRKpuakZs2pFfoBiqAGyzbg==
X-Received: by 2002:a17:906:7746:b0:6ce:a12e:489f with SMTP id o6-20020a170906774600b006cea12e489fmr30670831ejn.551.1648514934446;
        Mon, 28 Mar 2022 17:48:54 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id qk30-20020a1709077f9e00b006dfae33d969sm6468308ejc.216.2022.03.28.17.48.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Mar 2022 17:48:54 -0700 (PDT)
Date:   Tue, 29 Mar 2022 00:48:53 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net
Subject: Re: [PATCH 1/2] mm/vmscan: reclaim only affects managed_zones
Message-ID: <20220329004853.svpeohdxyav4joi2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220327024101.10378-1-richard.weiyang@gmail.com>
 <YkFuUsWe2LAuQa3n@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkFuUsWe2LAuQa3n@localhost.localdomain>
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

On Mon, Mar 28, 2022 at 10:14:10AM +0200, Oscar Salvador wrote:
>On Sun, Mar 27, 2022 at 02:41:00AM +0000, Wei Yang wrote:
>> As mentioned in commit 6aa303defb74 ("mm, vmscan: only allocate and
>> reclaim from zones with pages managed by the buddy allocator") , reclaim
>> only affects managed_zones.
>> 
>> Let's adjust the code and comment accordingly.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>
>LGTM,
>
>Reviewed-by: Oscar Salvador <osalvador@suse.de>
>
>We still have some other places scattered all over where we use
>populated_zone().
>I think it should be great to check whether all those usages are
>right.
>

Thanks.

This time I have checked vmscan related places, it looks all related part are
fixed. For others, I didn't get a chance to catch them. 

>
>-- 
>Oscar Salvador
>SUSE Labs

-- 
Wei Yang
Help you, Help me
