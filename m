Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5626590F70
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbiHLK26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiHLK24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:28:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B75EA6C01
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:28:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 119EF3EDB7;
        Fri, 12 Aug 2022 10:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660300134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3nvTqnT7K3LiWJYUMML5+6yBkFhanW5C2y33qNN7G5I=;
        b=qQC2SZ2K+zGPknb6DeUDqSJz17ArNIRGdVcEv+WZwU5xf5hxmd70rNOx/MUPDzN2MmnLxV
        trmTK9pXjgyujQQ9y4wK285M8HSFHDAMoB1DUy61UC4zBaePAbKinFDhjsQONUfvHLDuR6
        LqiQDYEsXgndazKsJDXPOZKYMwo90s0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660300134;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3nvTqnT7K3LiWJYUMML5+6yBkFhanW5C2y33qNN7G5I=;
        b=9KLKbLUpXuZRnPN19AEZRNln6YGKTmYaqE8PYLcpSQiTd8x2UvfmyXNVqT5f5G6j2dGUSQ
        5An8cGVmD11tWzCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFE9B13305;
        Fri, 12 Aug 2022 10:28:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iK31MWUr9mK2WwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 12 Aug 2022 10:28:53 +0000
Message-ID: <c60897e7-fa5d-a1a9-09a6-c80cfe4b5fd5@suse.cz>
Date:   Fri, 12 Aug 2022 12:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v2] Introduce sysfs interface to disable kfence for
 selected slabs.
Content-Language: en-US
To:     Imran Khan <imran.f.khan@oracle.com>, glider@google.com,
        elver@google.com, dvyukov@google.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
References: <20220811085938.2506536-1-imran.f.khan@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220811085938.2506536-1-imran.f.khan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 10:59, Imran Khan wrote:
> By default kfence allocation can happen for any slab object, whose size
> is up to PAGE_SIZE, as long as that allocation is the first allocation
> after expiration of kfence sample interval. But in certain debugging
> scenarios we may be interested in debugging corruptions involving
> some specific slub objects like dentry or ext4_* etc. In such cases
> limiting kfence for allocations involving only specific slub objects
> will increase the probablity of catching the issue since kfence pool
> will not be consumed by other slab objects.
> 
> This patch introduces a sysfs interface '/sys/kernel/slab/<name>/skip_kfence'
> to disable kfence for specific slabs. Having the interface work in this
> way does not impact current/default behavior of kfence and allows us to
> use kfence for specific slabs (when needed) as well. The decision to
> skip/use kfence is taken depending on whether kmem_cache.flags has
> (newly introduced) SLAB_SKIP_KFENCE flag set or not.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> ---
> 
> Changes since v1:
>  - Remove RFC tag
> 
>  include/linux/slab.h |  6 ++++++
>  mm/kfence/core.c     |  7 +++++++
>  mm/slub.c            | 27 +++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 0fefdf528e0d..947d912fd08c 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -119,6 +119,12 @@
>   */
>  #define SLAB_NO_USER_FLAGS	((slab_flags_t __force)0x10000000U)
>  
> +#ifdef CONFIG_KFENCE
> +#define SLAB_SKIP_KFENCE            ((slab_flags_t __force)0x20000000U)
> +#else
> +#define SLAB_SKIP_KFENCE            0
> +#endif

The whitespace here (spaces) differs from other flags above (tabs).


