Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD2A53F140
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiFFU6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbiFFU54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:57:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347E7149A93
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:46:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w20so3522396lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cfOlBmdhOyczhq1q2DRlk1Hjg1wlO53vwRDEPJxbnVw=;
        b=myTkGQ7V5AWMiimvQu2/Os6R/NXjN+F722C15P5Rt9hbdAQ42xHoOWM7WSAJzJAvqB
         3A2N2xVkN4gtpgM1urV/SdSztoebbHVa0fTE174RYofnYwKECoVQMz9kj44tnpiOHI0p
         lVZu0PwvGtH5Jrl3hkiUbSzwK+UtDHY7EgowAC9DEZ9KqhiyogHhoLwzuMzibcbm250+
         n/FnYCWfiRX4FW7+7p8ig45AQHlx11Nng8yvuzi7l/zXD6pOsMMyu4FPua4kr15nTP6r
         QRa4WdlsQTjPZiXdSZ/cyQp2/UlKgfGNQubcDkVHQ2PwKX9Et84iKWidtPJKUeUe1pW1
         Kzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cfOlBmdhOyczhq1q2DRlk1Hjg1wlO53vwRDEPJxbnVw=;
        b=TvbOrQZ6xvqLbyRs4rfsSmjBeASd8YVD2rVydryNvYTgZrvaj0iL0BnY9nvo+Uhf/F
         d8bpJmr14TmaPF0DzkllIkh4MeHT1J1HRP/RF0NThfIZ0POAx/wwkCtnAU/Lf8AVbnP9
         gmiOkA7yGIHbkutQb90MDX3ht00TVwfyu7eW7IMz+AttXla8okrOvUEn9zPNCIF8qpZW
         BMwTBMguA09q0s1UE6ZVE+GltzQvrFCKU4UQWYfhjNLgbe7etlXnwRUcuZ8HIMGcPKiV
         qkICQf3/KH3EwLt3nILp+A/x8la9bTqEtpgdL6xZD71fW4ZLdGqq3LWN/yY7XtPpy6Gq
         ywqQ==
X-Gm-Message-State: AOAM533b1menKo0e+oom5m+5IF5wGGF9SmI9bMyOeNRc/O4gHSiRdca0
        FcNI7z1ZgTninLh0fzoEQpg=
X-Google-Smtp-Source: ABdhPJyJYp1IIb/bd/u9a8IMc8pJPVr3WboDn3Rsi5K1hDer40oHWlNgReGFK6dkpmAmXZY9ZxdEkw==
X-Received: by 2002:a05:6512:752:b0:479:1b68:722c with SMTP id c18-20020a056512075200b004791b68722cmr11680076lfs.59.1654548398488;
        Mon, 06 Jun 2022 13:46:38 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id a16-20020a2e88d0000000b0025538905298sm2587600ljk.123.2022.06.06.13.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:46:38 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 6 Jun 2022 22:46:36 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, urezki@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] mm/vmalloc: remove the redundant boundary check
Message-ID: <Yp5nrJ2RnxYgGmL1@pc638.lan>
References: <20220606083909.363350-1-bhe@redhat.com>
 <20220606083909.363350-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606083909.363350-3-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 04:39:06PM +0800, Baoquan He wrote:
> In function find_va_links(), when traversing the vmap_area tree, the
> comparing to check if the passed in 'va' is above or below 'tmp_va'
> is redundant, assuming both 'va' and 'tmp_va' has ->va_start <= ->va_end.
> 
> Here, to simplify the checking as code change.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/vmalloc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index b7a138ab7b79..c7e1634ff2b9 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -874,11 +874,9 @@ find_va_links(struct vmap_area *va,
>  		 * Trigger the BUG() if there are sides(left/right)
>  		 * or full overlaps.
>  		 */
> -		if (va->va_start < tmp_va->va_end &&
> -				va->va_end <= tmp_va->va_start)
> +		if (va->va_end <= tmp_va->va_start)
>  			link = &(*link)->rb_left;
> -		else if (va->va_end > tmp_va->va_start &&
> -				va->va_start >= tmp_va->va_end)
> +		else if (va->va_start >= tmp_va->va_end)
>  			link = &(*link)->rb_right;
>  		else {
>  			WARN(1, "vmalloc bug: 0x%lx-0x%lx overlaps with 0x%lx-0x%lx\n",
> -- 
> 2.34.1
> 
Make sense to me: Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
