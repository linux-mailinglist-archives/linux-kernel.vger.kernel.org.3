Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52666480F47
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 04:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhL2DZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 22:25:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229989AbhL2DZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 22:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640748306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TcGDDbJqJhKmcEVDqtazS3R0O5m21NZRmhbjT5xcZDU=;
        b=eAxm8+l1m48MRyGCKD23fHO6Pz1j+lrrSzNRiHyUDZ5eP0bVVcYyOnSMSKpPjbRIH75l/d
        VwT7Jb3ZnPUeT+9APXpBVIHTx2X0vHP6IMWwyVHB2f3oxhTBoaVAE07W3QkqiMTsV5795C
        WooYagqvQeJ52+CQap5E3TaoZHu4bMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-1E9pDY5LP5OrGHRYSKyXIA-1; Tue, 28 Dec 2021 22:25:05 -0500
X-MC-Unique: 1E9pDY5LP5OrGHRYSKyXIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96A9718397A7;
        Wed, 29 Dec 2021 03:25:03 +0000 (UTC)
Received: from [10.22.16.58] (unknown [10.22.16.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAE031037F3F;
        Wed, 29 Dec 2021 03:25:02 +0000 (UTC)
Message-ID: <015af849-3571-e9ac-692f-d803aa19f566@redhat.com>
Date:   Tue, 28 Dec 2021 22:25:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [lockdep] UAF read in print_name().
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <77f05c15-81b6-bddd-9650-80d5f23fe330@i-love.sakura.ne.jp>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <77f05c15-81b6-bddd-9650-80d5f23fe330@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/21 05:49, Tetsuo Handa wrote:
> Hello.
>
> I found using linux-next-20211210 that reading /proc/lockdep after lockdep splat
> triggers UAF read access. I think this is a side effect of zapping dependency
> information when loop driver's WQ is destroyed. You might want to xchg() the pointer
> with a dummy struct containing a static string.
>
> difference before lockdep splat and after lockdep splat
> ----------------------------------------
> 8635c8636
> < ffff88811561cd28 OPS:      26 FD:  122 BD:    1 +.+.: (wq_completion)loop0
> ---
>> ffff88811561cd28 OPS:      31 FD:  439 BD:    1 +.+.:  M>^MM-^AM-^HM-^?M-^?

Thanks for reporting.

Yes, listing locking classes by /proc/lockdep is racy as 
all_lock_classes is accessed without lock protection. OTOH, we probably 
can't fix this race as lock hold time will be too long for this case. 
Atomically xchg the class name is a possible workaround, but we also 
need to add additional checks as the iteration may also be redirected to 
free_lock_classes leading to an endless iteration loop.

Cheers,
Longman

