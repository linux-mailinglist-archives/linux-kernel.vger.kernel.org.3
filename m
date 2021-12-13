Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6654731DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbhLMQb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:31:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239936AbhLMQbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639413111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MT4/b2QPfJ4jW4cPiNaQ4X6156JfED28RbUoF2jZNtA=;
        b=bzv0FPjkfJf6R975MNyU7JRxih5NzngDexme8K/ZE0E5Je/fud2InfwWAiydQKr+XTj3ob
        k4TFQA1ekkaY0ZoxNh7hI++ZXNxkBKzG9hTLRLx4ejv/KjpfRoczy0oTlJRuiWYzxVB+4L
        QRqT57IPe/8j+vccFK0P38k62E6srYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-GBD0qURQN5eGKu3jfMKAFg-1; Mon, 13 Dec 2021 11:31:47 -0500
X-MC-Unique: GBD0qURQN5eGKu3jfMKAFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39715100F942;
        Mon, 13 Dec 2021 16:31:46 +0000 (UTC)
Received: from [10.22.18.158] (unknown [10.22.18.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18798100164A;
        Mon, 13 Dec 2021 16:31:45 +0000 (UTC)
Message-ID: <383e4f24-8165-7aab-40af-52340c09de46@redhat.com>
Date:   Mon, 13 Dec 2021 11:31:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH -next] lockdep: Use memset_startat() helper in
 reinit_class()
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     wangweiyang2@huawei.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org
References: <20211213132618.105737-1-xiujianfeng@huawei.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211213132618.105737-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 08:26, Xiu Jianfeng wrote:
> use memset_startat() helper to simplify the code, there is no functional
> change in this patch.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   kernel/locking/lockdep.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 4a882f83aeb9..89b3df51fd98 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -6011,13 +6011,10 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
>   
>   static void reinit_class(struct lock_class *class)
>   {
> -	void *const p = class;
> -	const unsigned int offset = offsetof(struct lock_class, key);
> -
>   	WARN_ON_ONCE(!class->lock_entry.next);
>   	WARN_ON_ONCE(!list_empty(&class->locks_after));
>   	WARN_ON_ONCE(!list_empty(&class->locks_before));
> -	memset(p + offset, 0, sizeof(*class) - offset);
> +	memset_startat(class, 0, key);
>   	WARN_ON_ONCE(!class->lock_entry.next);
>   	WARN_ON_ONCE(!list_empty(&class->locks_after));
>   	WARN_ON_ONCE(!list_empty(&class->locks_before));

LGTM

Acked-by: Waiman Long <longman@redhat.com>

