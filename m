Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B362050EF58
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiDZDqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiDZDq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4AC33BBDB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650944598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFxmVKYXvSZPtacNcJTM6MnScqFh9HT3TZrp7pNItgg=;
        b=RcxGk7vDWpzy+UovVvYJ3g1K+e3Mle998OVaQf1Q7QX+AddU840CdoiHwqPwkFNThgoAoa
        3ejugUpuxhm7inrD0j6FmDUHbGRLs+6WY4aM5upqS7Umoven3zlGxKbGx5+sU/uGYKU8ha
        qA0ObyGLEmJfHWDXdh8iRvPbM29E3Fg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-kRGxQw4vP82HVtYwaJH88A-1; Mon, 25 Apr 2022 23:43:09 -0400
X-MC-Unique: kRGxQw4vP82HVtYwaJH88A-1
Received: by mail-pj1-f71.google.com with SMTP id a24-20020a17090a8c1800b001d98eff7882so946836pjo.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uFxmVKYXvSZPtacNcJTM6MnScqFh9HT3TZrp7pNItgg=;
        b=KeL68TS+uUMG9sfXJ5Ei6rhvV1cun/sa2Pnd/+SE0gkMHiElOo6riDefl2oyWJqkG2
         SD3yweVL//ZJmPIzg/11pSDKKBfnOsdl5ZECWucTs0xol+eSTJmqPcIV8lsfmrPP7Kk9
         8cy+mvezylJ7SHQkQXI3pEDk/DOsg5S4/UsnOs770xTnMTICdeogUBNzKDi/DRuwcVvq
         dt8mWCELrSFl1mAMcmaXSyXmvwi4q8dZe0PRm7YZDIXRa/8F1q1zFdaqlpdekmrl7Xv4
         7BZDSsn0jq8RgaThtWvRgWMfpltgtKgTloLW+/ENxCjqOf98EX56TwmNf5W0KML+SYpd
         l3Jg==
X-Gm-Message-State: AOAM533gaY4S54bowA/SQmsnNO5aA3tlAz3p+78kXdbRcgMDyv0LiXnN
        gdZI0m7/OO513T6ig3RYRSD2kCZJv8PE3U2Lp+YNYDaY6rqVg7qR2IYkKndjD9MWt9w08OsrAz/
        MomPsl53iI4Q9XviLPc97JaTN
X-Received: by 2002:a17:90b:1689:b0:1d8:28f9:3ba9 with SMTP id kv9-20020a17090b168900b001d828f93ba9mr22293954pjb.56.1650944588675;
        Mon, 25 Apr 2022 20:43:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxecPEtk+FpSPOmqCkDa4+7ZxcyXXxdF6EIM0b3g5xsoz9pZBoQkhEllm1rd+qlAOZyrrB5DQ==
X-Received: by 2002:a17:90b:1689:b0:1d8:28f9:3ba9 with SMTP id kv9-20020a17090b168900b001d828f93ba9mr22293939pjb.56.1650944588438;
        Mon, 25 Apr 2022 20:43:08 -0700 (PDT)
Received: from [10.72.13.91] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x4-20020a628604000000b0050d2ff56603sm7426174pfd.60.2022.04.25.20.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 20:43:07 -0700 (PDT)
Message-ID: <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
Date:   Tue, 26 Apr 2022 11:42:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org> <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220425233604-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/26 11:38, Michael S. Tsirkin 写道:
> On Mon, Apr 25, 2022 at 11:35:41PM -0400, Michael S. Tsirkin wrote:
>> On Tue, Apr 26, 2022 at 04:29:11AM +0200, Halil Pasic wrote:
>>> On Mon, 25 Apr 2022 09:59:55 -0400
>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>
>>>> On Mon, Apr 25, 2022 at 10:54:24AM +0200, Cornelia Huck wrote:
>>>>> On Mon, Apr 25 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>>>    
>>>>>> On Mon, Apr 25, 2022 at 10:44:15AM +0800, Jason Wang wrote:
>>>>>>> This patch tries to implement the synchronize_cbs() for ccw. For the
>>>>>>> vring_interrupt() that is called via virtio_airq_handler(), the
>>>>>>> synchronization is simply done via the airq_info's lock. For the
>>>>>>> vring_interrupt() that is called via virtio_ccw_int_handler(), a per
>>>>>>> device spinlock for irq is introduced ans used in the synchronization
>>>>>>> method.
>>>>>>>
>>>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>>>>>>> Cc: Marc Zyngier <maz@kernel.org>
>>>>>>> Cc: Halil Pasic <pasic@linux.ibm.com>
>>>>>>> Cc: Cornelia Huck <cohuck@redhat.com>
>>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>>>
>>>>>> This is the only one that is giving me pause. Halil, Cornelia,
>>>>>> should we be concerned about the performance impact here?
>>>>>> Any chance it can be tested?
>>>>> We can have a bunch of devices using the same airq structure, and the
>>>>> sync cb creates a choke point, same as registering/unregistering.
>>>> BTW can callbacks for multiple VQs run on multiple CPUs at the moment?
>>> I'm not sure I understand the question.
>>>
>>> I do think we can have multiple CPUs that are executing some portion of
>>> virtio_ccw_int_handler(). So I guess the answer is yes. Connie what do you think?
>>>
>>> On the other hand we could also end up serializing synchronize_cbs()
>>> calls for different devices if they happen to use the same airq_info. But
>>> this probably was not your question
>>
>> I am less concerned about  synchronize_cbs being slow and more about
>> the slowdown in interrupt processing itself.
>>
>>>> this patch serializes them on a spinlock.
>>>>
>>> Those could then pile up on the newly introduced spinlock.
>>>
>>> Regards,
>>> Halil
>> Hmm yea ... not good.
> Is there any other way to synchronize with all callbacks?


Maybe using rwlock as airq handler?

Thanks


>
>> -- 
>> MST

