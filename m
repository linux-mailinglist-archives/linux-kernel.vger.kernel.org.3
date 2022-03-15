Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569194D9E39
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349497AbiCOO6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349550AbiCOO6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 946AE4B858
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647356215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a6LNIA40Y4JrPJL3Qz2tmM4ovvIqWyioo/2km0sAYnY=;
        b=EwtYraExTUr0UvhG8rrBAaM7lw+ANirUbNKis0kWH422xkhkyizUX7grjHQOLrdS2QswKA
        m/iJ+tReK0MEGYqSHoj40KjJIqA7X0lVMKirBV3c2nAqv6gnsX/b1YPoUnf6F1xUH/1wNL
        bziYHM5pe9v0ogEPhhAZTGLmGMxVhBM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-WzJFYN0wOiOLsFNaEMNCxw-1; Tue, 15 Mar 2022 10:56:52 -0400
X-MC-Unique: WzJFYN0wOiOLsFNaEMNCxw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA2943801ECB;
        Tue, 15 Mar 2022 14:56:51 +0000 (UTC)
Received: from [10.22.34.226] (unknown [10.22.34.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6F48555C92;
        Tue, 15 Mar 2022 14:56:51 +0000 (UTC)
Message-ID: <5a8ffc81-b7dc-7bbe-e925-7d1c39fd2d69@redhat.com>
Date:   Tue, 15 Mar 2022 10:56:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] locking/lockdep: Remove lockdep_init_map_crosslock.
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220311164457.46461-1-bigeasy@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220311164457.46461-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 11:44, Sebastian Andrzej Siewior wrote:
> The cross-release bits have been removed, lockdep_init_map_crosslock() is
> a leftover.
>
> Remove lockdep_init_map_crosslock.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   include/linux/lockdep.h | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 467b94257105e..3d948f001f182 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -431,7 +431,6 @@ enum xhlock_context_t {
>   	XHLOCK_CTX_NR,
>   };
>   
> -#define lockdep_init_map_crosslock(m, n, k, s) do {} while (0)
>   /*
>    * To initialize a lockdep_map statically use this macro.
>    * Note that _name must not be NULL.

LGTM

Reviewed-by: Waiman Long <longman@redhat.com>

