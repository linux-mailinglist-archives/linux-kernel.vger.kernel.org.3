Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A89B4748D9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbhLNRGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhLNRGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:06:21 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083F3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 09:06:21 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso17741488pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 09:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IvqOA246pz6MpJ2Qx8Vk8PM4dTJlnXdWQbQp45Jo7eU=;
        b=AGLcpSoCRP3mDHqZy9q6CHC/f/cQL4x6F2nPdN5iAtowhi/xHCfoPYeaYA5s2BUZFr
         XM03O7Z8KGaszQlBTNjAm+2lZkdPb6RAsdCxlWStWODnyBHc97RCmXTuXjrG5nVSFFdz
         pbwjXtm5k/DnTwAob5ndMTz3YmBpTezQn8hxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IvqOA246pz6MpJ2Qx8Vk8PM4dTJlnXdWQbQp45Jo7eU=;
        b=brSIhupCBfh0+5nFxsvt7Pus4365Alhf1Ln6DSHywWafIGMPGtQcWbXIus/sQvaAUd
         KjoLNdlZOMxjScyFzm24WiYG8pm5M261avq5EAJtCuXeH/OMOg5lYykaRyiSjIKg1iAL
         d2CKrzfsDLWsruw8EURBHKqrZ3MoT2xV5Al2CcuJogmssC81FJVWZSSDggebk3l2jo0a
         z4Zw98xTC1WF0t0BAtp2cSlNXEwSwUDck5MXNZE2r8N+nQqW3PuuPppH3NwoNWsm71QM
         usiUk2W8Qk1X8EGDasQCUtY+wC17aQ4Q7P7CgkTKDUiKyylXfKCwsukrTwjpzdgmOSks
         gF8g==
X-Gm-Message-State: AOAM531IgDIlFKMsGxTrsn3toKlrtv1QKlRuKAzq+aso2v10dzmWo+cK
        oG4/k+x/iADO8GoNLDdBGAlRM8f9A2FHEg==
X-Google-Smtp-Source: ABdhPJxVwqDR4+vDuC91Bf9YfHuFRkh+AN9IOxfGAait4qoh9fmClkfVrhdtcTc/ZF4Ld0JJiXNP3A==
X-Received: by 2002:a17:902:ecc4:b0:148:a2e8:2784 with SMTP id a4-20020a170902ecc400b00148a2e82784mr248013plh.139.1639501580488;
        Tue, 14 Dec 2021 09:06:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 204sm280350pgb.63.2021.12.14.09.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:06:20 -0800 (PST)
Date:   Tue, 14 Dec 2021 09:06:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thibaut Sautereau <thibaut.sautereau@clip-os.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>,
        Levente Polyak <levente@leventepolyak.net>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Subject: Re: [PATCH] mm/page_alloc: Fix __alloc_size attribute for
 alloc_pages_exact_nid
Message-ID: <202112140906.80FA30E@keescook>
References: <YbjEgwhn4bGblp//@coeus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbjEgwhn4bGblp//@coeus>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 05:21:23PM +0100, Thibaut Sautereau wrote:
> From: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
> 
> The second parameter of alloc_pages_exact_nid is the one indicating the
> size of memory pointed by the returned pointer.
> 
> Fixes: abd58f38dfb4 ("mm/page_alloc: add __alloc_size attributes for better bounds checking")
> Cc: Daniel Micay <danielmicay@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Levente Polyak <levente@leventepolyak.net>
> Signed-off-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>

Thanks! Andrew, can you take this?

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/gfp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index b976c4177299..8fcc38467af6 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -624,7 +624,7 @@ extern unsigned long get_zeroed_page(gfp_t gfp_mask);
>  
>  void *alloc_pages_exact(size_t size, gfp_t gfp_mask) __alloc_size(1);
>  void free_pages_exact(void *virt, size_t size);
> -__meminit void *alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask) __alloc_size(1);
> +__meminit void *alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask) __alloc_size(2);
>  
>  #define __get_free_page(gfp_mask) \
>  		__get_free_pages((gfp_mask), 0)
> -- 
> 2.34.1
> 

-- 
Kees Cook
