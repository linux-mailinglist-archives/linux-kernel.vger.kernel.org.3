Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B9B50BF88
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiDVSIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbiDVSGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:06:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED4811838B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:03:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 731D6B831F6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 18:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F166FC385A0;
        Fri, 22 Apr 2022 18:03:01 +0000 (UTC)
Date:   Fri, 22 Apr 2022 19:02:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        vbabka@suse.cz, penberg@kernel.org, roman.gushchin@linux.dev,
        iamjoonsoo.kim@lge.com, rientjes@google.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] mm: make minimum slab alignment a runtime property
Message-ID: <YmLt0s/KdSJlSSPk@arm.com>
References: <20220421211549.3884453-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421211549.3884453-1-pcc@google.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 02:15:48PM -0700, Peter Collingbourne wrote:
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 373b3ef99f4e..80e517593372 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -201,21 +201,33 @@ void kmem_dump_obj(void *object);
>  #endif
>  
>  /*
> - * Setting ARCH_SLAB_MINALIGN in arch headers allows a different alignment.
> + * Setting ARCH_SLAB_MIN_MINALIGN in arch headers allows a different alignment.
>   * Intended for arches that get misalignment faults even for 64 bit integer
>   * aligned buffers.
>   */
> -#ifndef ARCH_SLAB_MINALIGN
> -#define ARCH_SLAB_MINALIGN __alignof__(unsigned long long)
> +#ifndef ARCH_SLAB_MIN_MINALIGN
> +#define ARCH_SLAB_MIN_MINALIGN __alignof__(unsigned long long)
> +#endif

Sorry, only a drive-by comment, I'll look at the arm64 parts next week.
I've seen it mentioned in the first version, what's the point of MIN_MIN
and not just MIN?

-- 
Catalin
