Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A11F54C9E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348894AbiFONdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348796AbiFONdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4FA21A069
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655300009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ElUN8T1cq4s61Ms7BHHS//RviJNChfZk2AevhepNuYw=;
        b=h92EeXjqIOQc5YHSXVrRtbhSaOZ0W2s7t5zAFcUSCBvWXpXarAIV1lbjhMagZ88fpkVfCV
        +3KHEKqImIKNRMg5+qO8KYtebzY+H6nSknsJcIxuPxa/bgDuu+LAanwv19+oRCS9wvOy1l
        NWEA9tQ+1Ze1ubWP5BfCl9E7KkhX1uk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-bi9YTVieMGCZUWSN6FtBtg-1; Wed, 15 Jun 2022 09:33:28 -0400
X-MC-Unique: bi9YTVieMGCZUWSN6FtBtg-1
Received: by mail-pj1-f69.google.com with SMTP id lk16-20020a17090b33d000b001e68a9ac3a1so1382496pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ElUN8T1cq4s61Ms7BHHS//RviJNChfZk2AevhepNuYw=;
        b=ukHGv6XqL0MIMFelaZeDWAWbM7LT2PHMx3TL7dyFHpQHVj4GuZl+uMtVCjpvCb3RUH
         DHfEVYsgYEFuNp28T4M6T28EitrpuDv1wxg+9vikyHjbEElpTG9AUN+ZqDG9fnxO1zh4
         FI0D0ga4ugA+aRJZjuCcuH4X9clUHfbFJ9m7Uj2hGV6tocoxQtJnHZo7ot159nApTLeZ
         YApiTcLTVijddojcRQ3tTXHoDw5GNcgS5Vt0YgygRc/+2mcboJkZf8uzsu1XFGcGDHRU
         vJFHQrMrsQIwvsscEjELF3Bwil+QVhDHvSyqAyD3fShNix873cU3pZBMdRhRJciLAtVe
         2wBQ==
X-Gm-Message-State: AJIora8RcDzBikkqC9y5jDzzUz6XGZyA3q/w6whz9cxd8sh1aBvlS0f3
        4qz7I1IJomTwtA+v8jmdhI9Mgiq3EPaD6EpjFeP9/WjeOS19+Hmx0BABi3FKEy8KYI8AkP3XRQb
        tyPRX+KHt5Xa6dU7s9OgXffBz
X-Received: by 2002:a17:90b:3805:b0:1e6:85aa:51b with SMTP id mq5-20020a17090b380500b001e685aa051bmr10306064pjb.182.1655300007350;
        Wed, 15 Jun 2022 06:33:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tb4/p2f7hRkF6jlREKWV12KxvmfuJQQVpA3aDNFZ/uwNnmlZ5qNGCW6kdfHFSMs79ONcrXXg==
X-Received: by 2002:a17:90b:3805:b0:1e6:85aa:51b with SMTP id mq5-20020a17090b380500b001e685aa051bmr10306047pjb.182.1655300007115;
        Wed, 15 Jun 2022 06:33:27 -0700 (PDT)
Received: from [192.168.1.219] (180-150-90-198.b4965a.per.nbn.aussiebb.net. [180.150.90.198])
        by smtp.gmail.com with ESMTPSA id l21-20020a17090a409500b001e85f38bc79sm1742359pjg.41.2022.06.15.06.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 06:33:26 -0700 (PDT)
Message-ID: <f032daae-3820-9ded-9865-69b35e6b2cad@redhat.com>
Date:   Wed, 15 Jun 2022 21:33:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/3] radix-tree: propagate all tags in idr tree
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        onestero@redhat.com
References: <20220614180949.102914-1-bfoster@redhat.com>
 <20220614180949.102914-2-bfoster@redhat.com> <Yqm+jmkDA+um2+hd@infradead.org>
From:   Ian Kent <ikent@redhat.com>
In-Reply-To: <Yqm+jmkDA+um2+hd@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/6/22 19:12, Christoph Hellwig wrote:
> On Tue, Jun 14, 2022 at 02:09:47PM -0400, Brian Foster wrote:
>> The IDR tree has hardcoded tag propagation logic to handle the
>> internal IDR_FREE tag and ignore all others. Fix up the hardcoded
>> logic to support additional tags.
>>
>> This is specifically to support a new internal IDR_TGID radix tree
>> tag used to improve search efficiency of pids with associated
>> PIDTYPE_TGID tasks within a pid namespace.
> Wouldn't it make sense to switch over to an xarray here rather
> then adding new features to the radix tree?
>
Might be a dumb question but ...


How would the, essentially sparse, pid type PIDTYPE_TGID pids

traversal get benefits from an xarray?


 From what I have seen the searching isn't the real problem, it's the

traversal (that, at the moment, does a search 'and' a traversal over

a lot of pids to get a relatively small number of them).

Ian

