Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1533053F003
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiFFUjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbiFFUjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:39:22 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD3D104C9A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:36:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u26so24397354lfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0RLGEEsboSLHGJxAqv9pnzJzu69ELTjI+jQtVVqn7U0=;
        b=gt8SezvDbZycK1axO6XFjf25V2bD5/SJOfvuJWnNiZvKnsE7YZLt7D8gbHwBUHp6AP
         KDO3PQzULFrf4XdekutMxswJNqdG6kGxDGdkGVsLwbDPH8/APGpsWx3jN8fFB9jhC+s8
         9sK8hNtPV63/KqDI/oQhcxH7ZE8IOPo/e0BPAB+BBJECxDok/Kcs/djvC5ovNF8wVKt/
         DuxFydk3tawgK0AkMdfB0d6VJ6s8L3ooiI0kpaAkL8khlaoCLnW8cAnrBXJhSLs6FZPb
         oaabwQqaEm4BugV2aSey8PhCTYaes93stZqL7vWbeHlQlsocrxrSXucBYXrFUH9oycDB
         6HQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0RLGEEsboSLHGJxAqv9pnzJzu69ELTjI+jQtVVqn7U0=;
        b=ULfwvXqjbqYecdear00yIbOTBHuy73aNIr7PX3LlD3Q1DjYXNPHdHycoVXAP2UJSwd
         qcnDGk3H4ByXqgW8zYdImSAa9fQy2No+G2QwrAYfcum4gWgQPb0UEcbWQkHDGXgMuriJ
         UcniAgH5BDxVUCf2989+m4bJd6P78v0M2KMyA738wmX9OJAIaeT/CbY6oDaFrnNdk4GO
         f/0cDG7EbA8M9Iwpbf+jRYDGAxlusvd+CfdQuc17CAd/Dcy5XqRliXwj0COryRMollxz
         5ogaEhgwdmol36wtAoTANChkmNoiQ2VQHBc9g39+Iq6qhllb0AKftYmN5tlOJtivz+z5
         Awzg==
X-Gm-Message-State: AOAM5301cEK9bgb71l8lOcmrIH1hteEz9bX/dtmsnNZkfAn5FzvLGWvl
        dTgej2Eg7AbUo5x0FRqNopY=
X-Google-Smtp-Source: ABdhPJwwWpuKBF7Dn3+cvtdNRSjRg9kr2U1RMytMewXQnBAV4us4nr8yDCn9hH/mBKiE/Zx4j3zQCQ==
X-Received: by 2002:ac2:5f92:0:b0:479:112e:76d7 with SMTP id r18-20020ac25f92000000b00479112e76d7mr15102887lfe.189.1654547766087;
        Mon, 06 Jun 2022 13:36:06 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id e2-20020ac24e02000000b0047900e9a9d2sm2982352lfr.266.2022.06.06.13.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:36:05 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 6 Jun 2022 22:36:03 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, urezki@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm/vmalloc: remove the unnecessary type check
Message-ID: <Yp5lM0j1JdceUEjw@pc638.lan>
References: <20220606083909.363350-1-bhe@redhat.com>
 <20220606083909.363350-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606083909.363350-2-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In function adjust_va_to_fit_type(), it checks all values of passed
> in fit type, including NOTHING_FIT in the else branch. In fact, it's
> unnecessary to check NOTHING_FIT since the check has been done before
> adjust_va_to_fit_type() is called in all call sites. So clean it up.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/vmalloc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 07db42455dd4..b7a138ab7b79 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1418,8 +1418,6 @@ adjust_va_to_fit_type(struct vmap_area *va,
>  		 * Shrink this VA to remaining size.
>  		 */
>  		va->va_start = nva_start_addr + size;
> -	} else {
> -		return -1;
>  	}
>  
>  	if (type != FL_FIT_TYPE) {
> -- 
> 2.34.1
> 
Why not just invoke the classify_va_fit_type() inside the adjust_va_to_fit_type()?
In this case we do not need to rely on upper-stack checks and the split logic 
becomes fully implemented in one solid function.

--
Uladzislau Rezki
