Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A219A51B9D5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346728AbiEEITq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244865AbiEEITk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:19:40 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79E842559B
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651738560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=do1UvCnuc5di86ZbdYll8zHp7a0uqEH80l8XkiVHqz0=;
        b=AHgI+ZP7XktqAtLyz+NL5xShNWvm2mpLeqyLJjMzwwp2Ql9jl4I4reHh3w3VNcAETCLTPG
        Vi1csCT4/xFra/jz6UdGLe6sqa87N6VUQtxX6uEiWihnsM690eOlnlRDlo6tNQ/Nve+FBj
        S2VzpcQYMfQ6Uxzc9mHUCbz2qNB9cn8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-V9jPOEygNDiGgv6z4pMLag-1; Thu, 05 May 2022 04:15:56 -0400
X-MC-Unique: V9jPOEygNDiGgv6z4pMLag-1
Received: by mail-pl1-f197.google.com with SMTP id l5-20020a170902ec0500b0015cf1cfa4eeso1940471pld.17
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=do1UvCnuc5di86ZbdYll8zHp7a0uqEH80l8XkiVHqz0=;
        b=vJaaViEXqVNL2R83gCuOstN/An4tdA+KJnrA5GaGu0emAUWE+nmXxLB+Rimpk/l9Ub
         cJCklvsSw4dcb+YqeSqlId37EGg0YNV+Rehlwq3xmq9Q2mRJDNEQYw8zzpv8QCuBA5gn
         LvVn+9UjiDkB/W9nTN9VBPqA9N9saEelelpFjhOznefz/MHaHmXDy0f1oUJVUKpwAYqt
         U/s7QdZocTM2wc7v3rVxVDaSNRI0R7zKw1vwCWvAS9As5bTKYe9Swxcg8r4vk8rBHwZZ
         fUUnLFFsGS6/rXZfmUJHXwg8hI/43WkQCq9OAbXxADt45I20xdxhux+GskZdR1cgejzp
         lTOQ==
X-Gm-Message-State: AOAM532nwPI94yvaCWV+ws7skpovo2OgleOpO0BUybz47qM5j8uAXYuc
        u9xljx84YKdXLwMz6gHKCjIqWpZ12B5mlh09jcH39PrUIkDLoQ9bFGbe5RKPBHno9FpBmrGYqRY
        0bIVAgLpTymZMhrZrEJa/xnSq
X-Received: by 2002:a17:90b:4acb:b0:1dc:32dd:d51e with SMTP id mh11-20020a17090b4acb00b001dc32ddd51emr4536839pjb.5.1651738555899;
        Thu, 05 May 2022 01:15:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpduv1Ktx/cekWb28nZP/0aCNFGUL1g8LskDyDIqV4bXgu7v49iSg3ZoEhWf+Kaxx0D13mxg==
X-Received: by 2002:a17:90b:4acb:b0:1dc:32dd:d51e with SMTP id mh11-20020a17090b4acb00b001dc32ddd51emr4536817pjb.5.1651738555672;
        Thu, 05 May 2022 01:15:55 -0700 (PDT)
Received: from [10.72.13.116] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902bb8300b0015e8d4eb2c2sm829079pls.268.2022.05.05.01.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 01:15:55 -0700 (PDT)
Message-ID: <fe3c54a2-f6eb-96a8-425e-07df6b7b7f95@redhat.com>
Date:   Thu, 5 May 2022 16:15:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH V3 3/9] virtio: introduce config op to synchronize vring
 callbacks
Content-Language: en-US
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     mst <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-4-jasowang@redhat.com> <87r15hlgel.fsf@redhat.com>
 <CACGkMEsrSHtD9iO1qHjMGgwG5YwYVpX+7OKZaN9Oq29tPpGZYg@mail.gmail.com>
 <87ilqsl5ba.fsf@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <87ilqsl5ba.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/29 15:25, Cornelia Huck 写道:
> On Fri, Apr 29 2022, Jason Wang <jasowang@redhat.com> wrote:
>
>> On Thu, Apr 28, 2022 at 5:13 PM Cornelia Huck <cohuck@redhat.com> wrote:
>>> On Mon, Apr 25 2022, Jason Wang <jasowang@redhat.com> wrote:
>>>
>>>> This patch introduces new virtio config op to vring
>>>> callbacks. Transport specific method is required to make sure the
>>>> write before this function is visible to the vring_interrupt() that is
>>> Which kind of writes? I.e., what is the scope?
>> Any writes before synchronize_cbs(). Is something like the following better?
>>
>> The function guarantees that all memory operations before it are
>> visible to the vring_interrupt() that is called after it.
> Maybe "all memory operations on the queue"?


That's fine. Will do.

Thanks


>

