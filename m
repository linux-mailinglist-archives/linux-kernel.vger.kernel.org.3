Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA11474C55
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhLNT4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhLNT4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:56:07 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C321C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:56:07 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v11so34282770wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wS77TqqTPnBTpmksYhdz3eSRMai6KqIllrvJewhLyWE=;
        b=FK8LQs2jZHxN78dHSNnrvFkYm0T4xDtpiUBawSlgn169PaOnn1oebfe5XyxSi7S5B+
         lC3qo7f10AVt794TSxtbhb5OLUExwX4AU+nvfA7Y9X94rElmxbAbVmBwFRB+9r2o+B45
         1US5ap8R6GFmAEzPUbnFhap5TXHxhnVc2HxVgQuU9lx43GCEzPcuOXuLrx+s+vTDJejn
         gSUGN+x/lZ5E88ho2XOdDyzNLg1p9SECnEcaQcuckkHyrEaYKjVIaJGRjXCKcmxm3Gnw
         B6ZixaxPO9JnYFEQpJ3f35l6SUnVjBzRifD010ufEj066nu67da3ZzAgMd6fHwydEyHa
         ytOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wS77TqqTPnBTpmksYhdz3eSRMai6KqIllrvJewhLyWE=;
        b=bsYoaRY8OQuSuXMO2F4QpTJn4+iX84hbSQ2wkLJIUVLn88l2w68ziYk7MLuMqt+Vcw
         m8eGF8JiCj4beUqQiXDcCHJr1iZ9wnF1/Zjwq6Zc2oF+t6r69SARv7LK3WJcrHgLRqKX
         NymfcUUC3XhbR37SHbLCax7DWr4saxtIWYozd3svX3cj+ttOK/N9CqzWC8G8Pc4nFIFh
         eBTTzs4RdWWWdWovWYjgVSC52Y/4VLvxcz6Q+DhOZWOMYmsPp+6WnOTF1BUnmfyMoPON
         yUpSc8kVJNbmlae2i7FVttBdVayRG2O0PwtFswdfLwLE/W6EqxyoOgTYFPFsHX4yu1Kg
         QGmg==
X-Gm-Message-State: AOAM531z1u4GsOdgVDpGxVufkR2wKWon1KTWNDcOiGpUa58PoWs1iz+3
        YzfWlxIhN1BNIKnu1xEaz/atvA==
X-Google-Smtp-Source: ABdhPJzjOMfuJ4ickmlh1ep17YBYjPJwE4BK843Qs8UJvreheviMvgUN/HF6dUwCslE1l0bhNDQGRA==
X-Received: by 2002:adf:c10e:: with SMTP id r14mr1212852wre.558.1639511765820;
        Tue, 14 Dec 2021 11:56:05 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f9c2:fca2:6c2e:7e9f])
        by smtp.gmail.com with ESMTPSA id bg34sm3343256wmb.47.2021.12.14.11.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 11:56:05 -0800 (PST)
Date:   Tue, 14 Dec 2021 20:55:58 +0100
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH mm v3 29/38] kasan, vmalloc: add vmalloc tagging for
 HW_TAGS
Message-ID: <Ybj2zms+c6J3J/pf@elver.google.com>
References: <cover.1639432170.git.andreyknvl@google.com>
 <af3819749624603ed5cb0cbd869d5e4b3ed116b3.1639432170.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af3819749624603ed5cb0cbd869d5e4b3ed116b3.1639432170.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:54PM +0100, andrey.konovalov@linux.dev wrote:
[...]
>  
> +	/*
> +	 * Skip page_alloc poisoning and zeroing for pages backing VM_ALLOC
> +	 * mappings. Only effective in HW_TAGS mode.
> +	 */
> +	gfp &= __GFP_SKIP_KASAN_UNPOISON & __GFP_SKIP_ZERO;

This will turn gfp == 0 always. Should it have been

	gfp |= __GFP_SKIP_KASAN_UNPOISON | __GFP_SKIP_ZERO

Also, not sure it matters, but on non-KASAN builds, this will now always
generate an extra instruction. You could conditionally define GFP_SKIP*
only in the KASAN modes that need them, otherwise they become 0, so the
compiler optimizes this out. (Although I think it does does complicate
GFP_SHIFT a little?)
