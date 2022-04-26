Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF75450EF63
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243449AbiDZDtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243430AbiDZDt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:49:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1791A3DA52
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650944781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V+5kKdPw3WI+dqWqeF0INPrgyOUCKqxJJn7dgIpXh9w=;
        b=AGAIJ5Ae4Gi7b/l+tVyWv86mBuLdci8kL1d8QPjMad2bMqy/BqrxhmKrutv2yzfMPnokRf
        122Gw+M4Zzf76pHRZ0fIwvAsvXns7+z8mw93ugCXYw4MJR+R1uPbLnHKDRxOq5Y1Pi2XNy
        7y8APmvZ3ThH2LHEsGVsKqFt9q0+IL0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-14Y7R_QCO5CtT4HaIVlW_Q-1; Mon, 25 Apr 2022 23:46:15 -0400
X-MC-Unique: 14Y7R_QCO5CtT4HaIVlW_Q-1
Received: by mail-pg1-f200.google.com with SMTP id o5-20020a639205000000b003ab492e038dso2689777pgd.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V+5kKdPw3WI+dqWqeF0INPrgyOUCKqxJJn7dgIpXh9w=;
        b=u9Xsiu1sukG2jKUNydnIX74mjLzbIEMK5ipLED8+jIPZXH/OBbW0lQ3C+E4M2d8o0i
         guqQ973U+Lb9g3M94Vb1RwKboCHiBNSqIt3GLEHQh1XgFq8dMKtE6uOWgku6VMZ/a38l
         sU+ruUYAvQiJ/tdTYq0ZKKbXZdc6ccXThuUHcjMEA9vlKUHFdZDDNTdS6A4zLgw2Ahew
         baaAibyX63uD1nDfT9FxV31euXTeDyoXOP5TgaKxd+zQ8+2lCTxMniFnFQD744xFBZwE
         BDrD+qRNLlpjw+zcxTfZWN+nDWgDIW7m6jVvOx83KqriPBhlQr/P0OzeTMUIs2Wde+cW
         FLRw==
X-Gm-Message-State: AOAM533k54OsAB8Uc7+CjOQ5nM178gwW7e4TIRo++vIylcZ3Nd0m3Y85
        mOr+YsVwFR17aJv2j6Wlz5FHVr9B8+ntdEwZO/K0wis4PI47kHwjVJGr+fp7qrZ5pnyqXe8Wnt9
        1ZBJFqNVAs3JKQRylzP39Z+kb
X-Received: by 2002:a63:e116:0:b0:3ab:812a:d5b8 with SMTP id z22-20020a63e116000000b003ab812ad5b8mr2439106pgh.457.1650944774042;
        Mon, 25 Apr 2022 20:46:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzG6Ams0Mtboz1vlInLrgOti6uyQkKvjIJxFLHKyvNtz76RtrzgASTFxQVGo+4X8PgoYjWslg==
X-Received: by 2002:a63:e116:0:b0:3ab:812a:d5b8 with SMTP id z22-20020a63e116000000b003ab812ad5b8mr2439093pgh.457.1650944773852;
        Mon, 25 Apr 2022 20:46:13 -0700 (PDT)
Received: from [10.72.13.91] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d14-20020a62f80e000000b0050d2671b11bsm8826357pfh.53.2022.04.25.20.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 20:46:13 -0700 (PDT)
Message-ID: <7f459ca6-0564-7206-adb2-6abc01c95a6d@redhat.com>
Date:   Tue, 26 Apr 2022 11:46:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Content-Language: en-US
To:     Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org> <87a6c98rwf.fsf@redhat.com>
 <20220426045050.4697c833.pasic@linux.ibm.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220426045050.4697c833.pasic@linux.ibm.com>
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


在 2022/4/26 10:50, Halil Pasic 写道:
>>>> +static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
>>>> +{
>>>> +	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
>>>> +	struct airq_info *info = vcdev->airq_info;
>>>> +
>>>> +	/*
>>>> +	 * Synchronize with the vring_interrupt() called by
>>>> +	 * virtio_ccw_int_handler().
>>>> +	 */
>>>> +	spin_lock(&vcdev->irq_lock);
>>>> +	spin_unlock(&vcdev->irq_lock);
>>>> +
>>>> +	if (info) {
>>>> +		/*
>>>> +		 * Synchronize with the vring_interrupt() with airq indicator
>>>> +		 */
>>>> +		write_lock(&info->lock);
>>>> +		write_unlock(&info->lock);
>>>> +	}
>> I think we can make this an either/or operation (devices will either use
>> classic interrupts or adapter interrupts)?
> Right, for virtqueue notifications. I second Connie's motion!


Will do this.

Thanks


>

