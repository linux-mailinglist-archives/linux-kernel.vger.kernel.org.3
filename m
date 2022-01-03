Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16D54836AD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbiACSRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:17:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232153AbiACSRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641233829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hesRhwlpHtOvx3n9CMFDmBD0XIz2FWM8W0cKo57+sm8=;
        b=FEZFKoSEy9j88h3jA63W3D0yrhssxJpY4+hMy+HVRH+F0T/662ckFi1ZKeYfLweibdTfNY
        sxZaM6Rqz/V4KYbqWO0H7bF7TsBKC3Dr+cehHaPe4Al3GWY6LM175dFeHb+eKAq6OBkgOk
        lMKEdficXzPsSGm60av0N11zMsGaihI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-QVLeNb7VNE-TgW0rhGu2IQ-1; Mon, 03 Jan 2022 13:17:06 -0500
X-MC-Unique: QVLeNb7VNE-TgW0rhGu2IQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8045C801B35;
        Mon,  3 Jan 2022 18:17:05 +0000 (UTC)
Received: from [10.22.9.34] (unknown [10.22.9.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51C0B80331;
        Mon,  3 Jan 2022 18:17:02 +0000 (UTC)
Message-ID: <4d3b818e-2aca-a596-644f-28e9e52c27bd@redhat.com>
Date:   Mon, 3 Jan 2022 13:17:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] locking/lockdep: Avoid potential access of invalid memory
 in lock_class
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20220103023558.1377055-1-longman@redhat.com>
 <954086c4-d679-57d7-cc46-9ce6af2872a4@acm.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <954086c4-d679-57d7-cc46-9ce6af2872a4@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/22 12:47, Bart Van Assche wrote:
> On 1/2/22 18:35, Waiman Long wrote:
>> -    WARN_ON_ONCE(!found);
>> -    __lockdep_free_key_range(pf, key, 1);
>> -    call_rcu_zapped(pf);
>> -    graph_unlock();
>> -out_irq:
>> +    WARN_ON_ONCE(!found && debug_locks);
>
> lockdep_unregister_key() should only be called for a registered key so 
> I'd
> like to keep the WARN_ON_ONCE(!found) here instead of changing it into
> WARN_ON_ONCE(!found && debug_locks). Otherwise this patch looks good 
> to me.

The reason for this change is to handle the case that a 
lockdep_register_key()/lockdep_unregister_key() pair may be called after 
debug_locks is turned off. Without that change, we are going to get the 
warning in lockdep_unregister_key(). That is the motivation of your 
original commit 8b39adbee805 ("locking/lockdep: Make 
lockdep_unregister_key() honor 'debug_locks' again").

Cheers,
Longman


