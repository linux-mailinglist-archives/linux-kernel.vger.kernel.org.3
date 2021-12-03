Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFEB46778E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380773AbhLCMnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbhLCMnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:43:51 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7119C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 04:40:27 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso4751665wmr.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 04:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C5r84uA1kNqZTgloKYxBMzot2+jjFOzS+FJH7QjXhpU=;
        b=acLlXvt+/WKk8EtuCkCgWiem2JTbsa58a/U3oIoLmo0dksAWqa0RpWU7tXRupPTh1e
         nEDLUjfm4fc4eVy7TNIcQ/fyhGRFwb9G3YOQDDTJKM/UMOaBTl/SCaQ924O/1rH5j5C5
         UjCF37LZnn7eO8RwoX/cQF1/pYUFVHsyFiIGWDxuzv1Z+Ml1OzJAxmz0B9+al/rbsYP9
         Ltelq4rIRhC5BdpHug+T62dy+2PM4Nc1OuqJyo0OPH6Zu85N6PsgTpHl2DMEXL14PRwm
         QqOygfqvOq7iktFQaQYjtZGIiUMfYtit8okIbM7W14JranQLPwM801kc4KuJ8u5Yo82v
         0bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C5r84uA1kNqZTgloKYxBMzot2+jjFOzS+FJH7QjXhpU=;
        b=1t0PSZgayu7cBzleuzBjvNYU1T7fpH0GOa2kafciN3wVoly7LK9wFwaSABnKlsIVwl
         2OM2jsTIcSzUgi1FvgQMHErOjEtnvTJ1gKg3APxMpijPHArqk4oic5oOSeWUdL2EoOkT
         ICPqg20MwSGPm6+p55eqYhWfCtnsCJ5me6BdAtConJHb47uP9+2qVdZNQ4rRL7glJRRC
         AITffABaKH/rP2SrZrfQ26Aim9WSzVeZLbyhTj1glqDdF6GcOfPabJEkeGby7O67vsVA
         pHQnN23/msc1hC0C9Fj9OnAqEG0zFAFzMRSY+q3NAJ9KlkrNVrFG8Y8vK0aEZ193ISiB
         xZRQ==
X-Gm-Message-State: AOAM530VTphvUZ8dnj3ol2+uj95ejeFpmaL91XevKKob5x1ANIedsjzu
        eTQQuNO80c9jte3k4JC0x/Zm/A==
X-Google-Smtp-Source: ABdhPJxtrLN0N2ynsWRtZBh/dDm6M5oMausycldFEDmRx554dlPlbNQorANQEEmkR7CLN/lTYbBLjQ==
X-Received: by 2002:a05:600c:104b:: with SMTP id 11mr14952957wmx.54.1638535226195;
        Fri, 03 Dec 2021 04:40:26 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:cb5f:d3e:205e:c7c4])
        by smtp.gmail.com with ESMTPSA id r15sm4816930wmh.13.2021.12.03.04.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 04:40:25 -0800 (PST)
Date:   Fri, 3 Dec 2021 13:40:19 +0100
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 29/31] kasan, arm64: allow KASAN_VMALLOC with HW_TAGS
Message-ID: <YaoQM7xWVKISa5Yb@elver.google.com>
References: <cover.1638308023.git.andreyknvl@google.com>
 <8afdf7eb0bae77d2e94210d689d524580cf5ed9a.1638308023.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8afdf7eb0bae77d2e94210d689d524580cf5ed9a.1638308023.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:08PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> vmalloc tagging support for HW_TAGS KASAN is now complete.
> 
> Allow enabling CONFIG_KASAN_VMALLOC.
> 
> Also adjust CONFIG_KASAN_VMALLOC description:
> 
> - Mention HW_TAGS support.
> - Remove unneeded internal details: they have no place in Kconfig
>   description and are already explained in the documentation.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/Kconfig |  3 +--
>  lib/Kconfig.kasan  | 20 ++++++++++----------

Like in the SW_TAGS case, consider moving the lib/Kconfig.kasan change
to the final "kasan, vmalloc: add vmalloc support to HW_TAGS" and only
leave the arm64 in its own patch.
