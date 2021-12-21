Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C88D47BF71
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbhLUMMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhLUMME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:12:04 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9B0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:12:03 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r17so26167389wrc.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jfaFJc8Cz1U41Grmp9dApUf6heZ4GsGx9TaK2/L8KJ8=;
        b=rXXpkxvAqlZJxXII9t13lJWwFpQKDr53BPSUm8rox7gb1xTX6knSAWASZTBOc7e6K9
         hcsTRynp1v+qKkg/KNNPj5x05hMhq5KLcmCIq8GNT9QG0a8vXuIJ9dfTHiXNgMBp7JqC
         pB4N0PdccOgqjel8LDV75Ul9+1SNn4bo4nWBKcfr087O43y9Ppn4PZn67Q9JZPa/B9dj
         oeSbp1XC/YbNqd97d1kXspb6j2Pr4brrLgLCo0RoBQms5enF25lG+otJ4BtdKlzgn/sW
         1HPyaNkru7kq13q/7lfguzH4RSLIo+JiQ/muUHIcfHyZFcvk3QOt80LvR1Z/Rd87ElYM
         Ct7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jfaFJc8Cz1U41Grmp9dApUf6heZ4GsGx9TaK2/L8KJ8=;
        b=offi422Ahdvsy5dljo6472QvF9XHdc1mnMUNHATdiUTMU/pt9KH9r/o9ISivadCXpN
         6ZSHavlGXmEZ0r+b9CyP1hSCAKYB1TVgBzFFMkqAYm07f2/EDl5PBjX+1xFuvjAdMr9t
         M0f6kKAPXvIRqema8NGplgdPRBy3c2P6aoHXiWW7tUuYT4a7qxYSFSfmccr7mLh0vrU0
         tH/xb4IthVGa82WJKcxZKK9A3ZH9miyXhm8wF96DxHordEaHnczBJR/VQ515Q1CF0/nJ
         5j5nEcaJE9TI0UMTzLdEbVl9aVYX59GKYLxBZc5uI1Z9QKXoJcEQukQGsrY1qqkl/qYt
         Yliw==
X-Gm-Message-State: AOAM531lvXa9N5p4mEJ60gmBvw7NPMchellkKVsqUbmhTC7HpjrnkOlm
        UzeLd8cU7IvLCXd0tUnzvYdBpA==
X-Google-Smtp-Source: ABdhPJz82HUVXY+qdDadDZ4std231gMaciHwyCd375yzBVc79K02MakZ5rf/njE7fI+bDkHQwWCg8Q==
X-Received: by 2002:adf:f54e:: with SMTP id j14mr2402039wrp.442.1640088722221;
        Tue, 21 Dec 2021 04:12:02 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:87ff:799:2072:8808])
        by smtp.gmail.com with ESMTPSA id o12sm17642260wrv.76.2021.12.21.04.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:12:01 -0800 (PST)
Date:   Tue, 21 Dec 2021 13:11:56 +0100
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
Subject: Re: [PATCH mm v4 29/39] kasan, page_alloc: allow skipping memory
 init for HW_TAGS
Message-ID: <YcHEjERoiqJTKmsZ@elver.google.com>
References: <cover.1640036051.git.andreyknvl@google.com>
 <dea9eb126793544650ff433612016016070ceb52.1640036051.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dea9eb126793544650ff433612016016070ceb52.1640036051.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 11:02PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
[...]
> +static inline bool should_skip_init(gfp_t flags)
> +{
> +	/* Don't skip if a software KASAN mode is enabled. */
> +	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> +	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> +		return false;
> +
> +	/* Don't skip, if hardware tag-based KASAN is not enabled. */
> +	if (!kasan_hw_tags_enabled())
> +		return false;

Why is the IS_ENABLED(CONFIG_KASAN_{GENERIC,SW_TAGS}) check above
required? Isn't kasan_hw_tags_enabled() always false if one of those is
configured?
