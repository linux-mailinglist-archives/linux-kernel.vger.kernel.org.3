Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3263357F82D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 04:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiGYCJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 22:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiGYCIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 22:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7E57FD24
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 19:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658714923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3H+nJazZwUTI7bMfI3XTbXbN/qZRH3y006Os5Yq8ong=;
        b=WQcW5Gj/5nxI/PoLJzkA4MjQYKf9ZAw2E8VkTINNibpucjpSQst0Sncr3KLiaHD+9CcVKo
        m5dSzHb07dH8K2JGKqv2usz0xfdAJ4RzQbPwP1BbWtDfI3HuN4svo2g6h94LGcZ5/hMwwy
        X8pvUL6mdSDVrHSNq7vBfCoHfzVexUs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-LE49NObQNpihPsAljGi0ow-1; Sun, 24 Jul 2022 22:08:37 -0400
X-MC-Unique: LE49NObQNpihPsAljGi0ow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BAD01C068CB;
        Mon, 25 Jul 2022 02:08:36 +0000 (UTC)
Received: from [10.22.32.58] (unknown [10.22.32.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57C3718EAA;
        Mon, 25 Jul 2022 02:08:35 +0000 (UTC)
Message-ID: <0ea27d18-6d45-9673-38b7-78d59325f9d5@redhat.com>
Date:   Sun, 24 Jul 2022 22:08:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V8 10/10] csky: Add qspinlock support
Content-Language: en-US
To:     guoren@kernel.org, palmer@rivosinc.com, heiko@sntech.de,
        hch@infradead.org, arnd@arndb.de, peterz@infradead.org,
        will@kernel.org, boqun.feng@gmail.com, mingo@redhat.com,
        philipp.tomsich@vrull.eu, cmuellner@linux.com,
        linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM
Cc:     linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
References: <20220724122517.1019187-1-guoren@kernel.org>
 <20220724122517.1019187-11-guoren@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220724122517.1019187-11-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/22 08:25, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Enable qspinlock by the requirements mentioned in a8ad07e5240c9
> ("asm-generic: qspinlock: Indicate the use of mixed-size atomics").
>
> C-SKY only has "ldex/stex" for all atomic operations. So csky give a
> strong forward guarantee for "ldex/stex." That means when ldex grabbed
> the cache line into $L1, it would block other cores from snooping the
> address with several cycles.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>   arch/csky/Kconfig               | 16 ++++++++++++++++
>   arch/csky/include/asm/Kbuild    |  2 ++
>   arch/csky/include/asm/cmpxchg.h | 20 ++++++++++++++++++++
>   3 files changed, 38 insertions(+)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index dfdb436b6078..09f7d1f06bca 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -354,6 +354,22 @@ config HAVE_EFFICIENT_UNALIGNED_STRING_OPS
>   	  Say Y here to enable EFFICIENT_UNALIGNED_STRING_OPS. Some CPU models could
>   	  deal with unaligned access by hardware.
>   
> +choice
> +	prompt "C-SKY spinlock type"
> +	default CSKY_TICKET_SPINLOCKS
> +
> +config CSKY_TICKET_SPINLOCKS
> +	bool "Using ticket spinlock"
> +
> +config CSKY_QUEUED_SPINLOCKS
> +	bool "Using queued spinlock"
> +	depends on SMP
> +	select ARCH_USE_QUEUED_SPINLOCKS
> +	help
> +	  Make sure your micro arch LL/SC has a strong forward progress guarantee.
> +	  Otherwise, stay at ticket-lock/combo-lock.

"combo-lock"? It is a cut-and-paste error. Right?

Cheers,
Longman

