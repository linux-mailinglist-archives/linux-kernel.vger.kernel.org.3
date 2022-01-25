Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8895A49B2D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381356AbiAYLSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:18:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381340AbiAYLPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643109278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rvvfbm9DdsitiqMaGToeqN6bn83eZm9ryJcgfNBtuTE=;
        b=Cy3Wxa5Fbrk3X2GG3L8ktyfUo8bzz003Ectl+B3MOdHid4lOFRfpRbEUd0nLuAPqhJ2Mf+
        IIETpd99GbptNj2k3fiB+lYmiU9bhWSL37fkxdSqSuWEVZYgRbK00QbuP8FyxhlZ71/n9b
        N7cSgV5m/PSUpBBWej73a9ZLrNqZTAo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-VFIsPKDMN4Kj088c3hacDQ-1; Tue, 25 Jan 2022 06:14:33 -0500
X-MC-Unique: VFIsPKDMN4Kj088c3hacDQ-1
Received: by mail-wr1-f70.google.com with SMTP id x4-20020adfbb44000000b001d83e815683so2891027wrg.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 03:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rvvfbm9DdsitiqMaGToeqN6bn83eZm9ryJcgfNBtuTE=;
        b=Xt72Q0uJww0qfQ0sGYbEaR5cCq7dcgPNhhXE5ulKVLtd0wmdoMLp3R9wDjViTnteu9
         4o04QPZbKr/XVsffbsFzguCrdHLHtVZa2oXVv/hjeGg/FqqZbk8TAMh7FO6wRK9Jizew
         T5Vnk/NZ3IXZvjzvP5cbiYANaX9wmy9VE9i4BSBR2nNQNYO5e346OfigsV0j37ER0yXR
         XkvdM4YHrYZTNIfg5k/EPOV3ljaYhMEq7cX9mbOYKu30PGdjHIKzDz7M/eg6IQ0La8j8
         8cun5iFyDPM4UNy0wo3m1MROImoybpXWnQ8Kv4DYSuUN6z2w83wdIRH+BkpeHHF31Jus
         NlXA==
X-Gm-Message-State: AOAM5338W0zUQcRRFdU1DpHcoMVytESjsU9cRPvAtTeKDCrWBPw4DY17
        CF9tuiM7600dfYFkyY0POJtzl0ztY9a+5JxzGwfnu1SOk0ZPFfBq5LsWTYkWjIdY2f0YZzhLIAu
        5kmZgc1KvoguDgsYp/vEHhEdJ
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr18147955wrn.502.1643109266375;
        Tue, 25 Jan 2022 03:14:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwe9f8UE+t1HaCGIVAqAvlkesdvDMkIgGHznqy4t0x7dqgJcd7Nmt776tM9Ir7lrl12OgiLkA==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr18147939wrn.502.1643109266078;
        Tue, 25 Jan 2022 03:14:26 -0800 (PST)
Received: from steredhat ([62.19.185.119])
        by smtp.gmail.com with ESMTPSA id t14sm60428wmq.21.2022.01.25.03.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 03:14:25 -0800 (PST)
Date:   Tue, 25 Jan 2022 12:14:22 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v1] vhost: cache avail index in vhost_enable_notify()
Message-ID: <20220125111422.tmsnk575jo7ckt46@steredhat>
References: <20220114090508.36416-1-sgarzare@redhat.com>
 <Ye6OJdi2M1EBx7b3@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Ye6OJdi2M1EBx7b3@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:31:49AM +0000, Stefan Hajnoczi wrote:
>On Fri, Jan 14, 2022 at 10:05:08AM +0100, Stefano Garzarella wrote:
>> In vhost_enable_notify() we enable the notifications and we read
>> the avail index to check if new buffers have become available in
>> the meantime.
>>
>> We are not caching the avail index, so when the device will call
>> vhost_get_vq_desc(), it will find the old value in the cache and
>> it will read the avail index again.
>
>I think this wording is clearer because we do keep a cached the avail
>index value, but the issue is we don't update it:
>s/We are not caching the avail index/We do not update the cached avail
>index value/

I'll fix in v3.
It seems I forgot to CC you on v2: 
https://lore.kernel.org/virtualization/20220121153108.187291-1-sgarzare@redhat.com/

>
>>
>> It would be better to refresh the cache every time we read avail
>> index, so let's change vhost_enable_notify() caching the value in
>> `avail_idx` and compare it with `last_avail_idx` to check if there
>> are new buffers available.
>>
>> Anyway, we don't expect a significant performance boost because
>> the above path is not very common, indeed vhost_enable_notify()
>> is often called with unlikely(), expecting that avail index has
>> not been updated.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> v1:
>> - improved the commit description [MST, Jason]
>> ---
>>  drivers/vhost/vhost.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 59edb5a1ffe2..07363dff559e 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -2543,8 +2543,9 @@ bool vhost_enable_notify(struct vhost_dev *dev, 
>> struct vhost_virtqueue *vq)
>>  		       &vq->avail->idx, r);
>>  		return false;
>>  	}
>> +	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>>
>> -	return vhost16_to_cpu(vq, avail_idx) != vq->avail_idx;
>> +	return vq->avail_idx != vq->last_avail_idx;
>
>vhost_vq_avail_empty() has a fast path that's missing in
>vhost_enable_notify():
>
>  if (vq->avail_idx != vq->last_avail_idx)
>      return false;

Yep, I thought about that, but devices usually call 
vhost_enable_notify() right when vq->avail_idx == vq->last_avail_idx, so 
I don't know if it's an extra check for a branch that will never be 
taken.

Do you think it is better to add that check? (maybe with unlikely())

Thanks,
Stefano

