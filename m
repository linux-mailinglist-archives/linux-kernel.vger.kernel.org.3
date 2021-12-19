Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F0347A230
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 22:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhLSVJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 16:09:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229810AbhLSVJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 16:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639948166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w8NVHh5KaHOjxDyMfVIdFJPd854oBlCBTaA4pOiH41I=;
        b=SyOijWkrsV8hJorb3qvB4pao/dq7VZSGp2JfWp1mtHO7OUav7Gl3oDWWTdxEEIzRZhqy22
        x6/3MDGLldP/F/sEhwhEtYZpV7Rx25Axg4t9eumh6zqRH4Svs1aD9xq34HqHC1WIT4Gcjh
        jaslVwmbp9irjKIFPiM+KXG9Fp+wnYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-2h4jEnqqOlWk9-DZfEywhg-1; Sun, 19 Dec 2021 16:09:25 -0500
X-MC-Unique: 2h4jEnqqOlWk9-DZfEywhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0BC918460E8;
        Sun, 19 Dec 2021 21:09:23 +0000 (UTC)
Received: from [10.22.8.127] (unknown [10.22.8.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEABF5E26B;
        Sun, 19 Dec 2021 21:09:20 +0000 (UTC)
Message-ID: <71c5ca50-1bf9-4ef7-eea0-634f66838d4a@redhat.com>
Date:   Sun, 19 Dec 2021 16:09:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] locking/rtmutex: Fix incorrect spinning condition
Content-Language: en-US
To:     Zqiang <qiang1.zhang@intel.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20211217074207.77425-1-qiang1.zhang@intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211217074207.77425-1-qiang1.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/21 02:42, Zqiang wrote:
> When the lock owner is on CPU and not need resched, the current waiter
> need to be checked, if it not longer top the waiter, stop spinning.

Incorrect grammar, should be "if it is no longer the top waiter". There 
is a similar typo in the existing code comment too.

You can modify the subject line to [PATCH-tip ...] to indicate that it 
is supposed to be apply on top of the tip tree. Other than that, the 
patch looks good.

Cheers,
Longman

>
> Fixes: c3123c431447 ("locking/rtmutex: Dont dereference waiter lockless")
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>   v1->v2:
>   Modify description information.
>
>   kernel/locking/rtmutex.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 0c1f2e3f019a..8555c4efe97c 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1383,7 +1383,7 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
>   		 *  - the VCPU on which owner runs is preempted
>   		 */
>   		if (!owner_on_cpu(owner) || need_resched() ||
> -		    rt_mutex_waiter_is_top_waiter(lock, waiter)) {
> +		    !rt_mutex_waiter_is_top_waiter(lock, waiter)) {
>   			res = false;
>   			break;
>   		}

