Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52B447BF77
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbhLUMOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLUMOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:14:42 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D45C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:14:42 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y196so8909020wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NYtFuw8skf4IqEe2E5F4oiyYNk3w/W3sUef4AJQUX7E=;
        b=kf5FSZi9QZrnv6ySxi9p72oDKv52pmBclrrZhly+vLZhDoHU+uDqpeyaMuJofTjTHu
         vLzU2JlRKCMKTBSSBXGKad6TZ3AIfa2RWaIn/ZpYO0Y790TQVLxYAXA2LotAe3CnA+rX
         Fz72DBZ63ZCaBLXPfiCB2pl9eZojAjwadyJ5vQgXtjQsofvawOQyUUs69RHruSyEagzM
         m8XvxsBF+gN/OxJHMKTywPk1Ie4DVzhpILtScMt3j4galI26LWK9XRWkfRSpF7SLdPD+
         v8Vuz95W29oEs/ZHr7YZzuV30BoXbp/sp8HV+NzsJsORykE7IreL+wAO6QCbvCBVPSqX
         JBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NYtFuw8skf4IqEe2E5F4oiyYNk3w/W3sUef4AJQUX7E=;
        b=1cxdVMPtKVAAG1TH5YaGPSYAo/WPUcZSbmH221aCtUZyK9aoH0eVU9LNZ1Sh06uaR6
         HRtqOjVu+4TYw+Bs+kMRXMwKM7uZyLDUryoAZPuhkbbaL4YXLVBYkdx87/MUn19tpfCp
         r2+eohTr01+saAflb5QOMeWtBGVo09bexg9w3ueS/hgtIIDBhzyv/yGX9+jJcyje1vS+
         Dg/BAbWoAWdEGuNBIJh31Eql6krKX1X/Y3QaiB+dFWLQ9qKrWwKjk7k/+yqKEiLc19vu
         i0zMw2Wv3f3jdChaiN29Jd/90xWTsJ0SJiLMpkP+1JhcQ9AiF2/jnNfNHSaMEn81SsZv
         k+AA==
X-Gm-Message-State: AOAM5336hJJnoKCMA5WgA6CWtwMm/kVzWXKYg0JxZmv3KxQDuJpoGFpT
        qN9F6ExzXq/Hpq8fF1bTF/vGmg==
X-Google-Smtp-Source: ABdhPJyYt6GOM4lsAt7lCM8s88YHu36R9L+5yPwihNvz2lZ9aTQ8C+e5luDGa2eKWrBz2uBXUKHR5g==
X-Received: by 2002:a05:600c:2150:: with SMTP id v16mr174804wml.10.1640088880731;
        Tue, 21 Dec 2021 04:14:40 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:87ff:799:2072:8808])
        by smtp.gmail.com with ESMTPSA id p18sm4326864wmq.0.2021.12.21.04.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:14:40 -0800 (PST)
Date:   Tue, 21 Dec 2021 13:14:33 +0100
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
Subject: Re: [PATCH mm v4 28/39] kasan, page_alloc: allow skipping
 unpoisoning for HW_TAGS
Message-ID: <YcHFKSNDI8KJKR7y@elver.google.com>
References: <cover.1640036051.git.andreyknvl@google.com>
 <73a0b47ec72a9c29e0efc18a9941237b3b3ad736.1640036051.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73a0b47ec72a9c29e0efc18a9941237b3b3ad736.1640036051.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 11:02PM +0100, andrey.konovalov@linux.dev wrote:
[...]
> +static inline bool should_skip_kasan_unpoison(gfp_t flags, bool init_tags)
> +{
> +	/* Don't skip if a software KASAN mode is enabled. */
> +	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> +	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> +		return false;
> +
> +	/* Skip, if hardware tag-based KASAN is not enabled. */
> +	if (!kasan_hw_tags_enabled())
> +		return true;

Same question here: why is IS_ENABLED(CONFIG_KASAN_{GENERIC,SW_TAGS})
check required if kasan_hw_tags_enabled() is always false if one of
those is configured?
