Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EDE4E6284
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348629AbiCXLdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349898AbiCXLdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A55F6A66E8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648121496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1NpkC2fEkSqd/CSAHTwNWACpSYPHkf2iIPZXWonefnU=;
        b=Tulh4C7w/HS5znCtP15/l74H6f93TXBkh5iFKn9dOkN/al4siR3bqBGZk2OibSKm5IvA0Z
        iuhkj/LshTqZ/bQcETGxkYKd2Udd7bzv58e3szxIqsTMBwLEcSNN+VrDzP5jvTdI9z0kAV
        T3FsrlA9LWfKXGrgFKoJgWbnOCfd6GQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-hzF1TpVAPlyY9_8Bcug4uQ-1; Thu, 24 Mar 2022 07:31:35 -0400
X-MC-Unique: hzF1TpVAPlyY9_8Bcug4uQ-1
Received: by mail-qv1-f72.google.com with SMTP id p65-20020a0c90c7000000b004412a2a1a6cso3392941qvp.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1NpkC2fEkSqd/CSAHTwNWACpSYPHkf2iIPZXWonefnU=;
        b=ts6ZSyN+dT1p6zoSkVq7JGuWvFKZvUR7SneV+DVpIdVGMbbY57fSTrzUDqxA2C5nku
         U3RKM1tkP47kiApiNSrvbBVP0Q8vRuJGYZLM4UOxwI/ZqYU2CJ5nlZlpgk57Q1Sz/siZ
         lfIuzbKTJaOdC2EDFkUlE2/PCEopxjEIT0+EjjRCijz6/SL9Br60N1q3bugBVVtEzrW0
         5OnQvQrufQ0AKgpgUMl3Dm258p9h78E4kvEMZVreozaeSdU91G1S8AT7ZQnlWfMOptQ7
         SUIF9CMHSd2Ji/k2hqZrsaBXY0I/MS4XsKykdK3XfN8rIOC4wiS6bD6YOzc3FZrJAEOf
         vzhQ==
X-Gm-Message-State: AOAM5318kYmLnAjr+JwiY3uJYJfFC3Yhk3VZ6lQZg9g7qThi3zIMA2Tv
        j9BgGc45jTctvIuwbteIMgvmcJMerCYg3Y8sHBsTmvRl+vg+/FEvVJQUdZuoTeWLBMp04qMtMWH
        RxiahfxV8JC2K2hjUn2RNSdUy
X-Received: by 2002:ac8:5a8f:0:b0:2e1:b34b:30f3 with SMTP id c15-20020ac85a8f000000b002e1b34b30f3mr3808691qtc.77.1648121494728;
        Thu, 24 Mar 2022 04:31:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjekPiDi3Ko7ojQ/j/aIK9Bc/hPbpL+E/dznL8qubjaItfkf0kyvau7TU4vOBNABxdpupVHg==
X-Received: by 2002:ac8:5a8f:0:b0:2e1:b34b:30f3 with SMTP id c15-20020ac85a8f000000b002e1b34b30f3mr3808671qtc.77.1648121494538;
        Thu, 24 Mar 2022 04:31:34 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-114.business.telecomitalia.it. [87.12.25.114])
        by smtp.gmail.com with ESMTPSA id b17-20020a05620a271100b00680a61f51c0sm298299qkp.16.2022.03.24.04.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 04:31:33 -0700 (PDT)
Date:   Thu, 24 Mar 2022 12:31:26 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, keirf@google.com
Subject: Re: [PATCH 1/3] virtio: use virtio_device_ready() in
 virtio_device_restore()
Message-ID: <20220324113126.f6f5hfabhqfyutix@sgarzare-redhat>
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-2-jasowang@redhat.com>
 <20220324064205-mutt-send-email-mst@kernel.org>
 <20220324110307.iizkdwuhc5c75noj@sgarzare-redhat>
 <20220324070612-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220324070612-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 07:07:09AM -0400, Michael S. Tsirkin wrote:
>On Thu, Mar 24, 2022 at 12:03:07PM +0100, Stefano Garzarella wrote:
>> On Thu, Mar 24, 2022 at 06:48:05AM -0400, Michael S. Tsirkin wrote:
>> > On Thu, Mar 24, 2022 at 04:40:02PM +0800, Jason Wang wrote:
>> > > From: Stefano Garzarella <sgarzare@redhat.com>
>> > >
>> > > This avoids setting DRIVER_OK twice for those drivers that call
>> > > virtio_device_ready() in the .restore
>> >
>> > Is this trying to say it's faster?
>>
>> Nope, I mean, when I wrote the original version, I meant to do the same
>> things that we do in virtio_dev_probe() where we called
>> virtio_device_ready() which not only set the state, but also called
>> .enable_cbs callback.
>>
>> Was this a side effect and maybe more compliant with the spec?
>
>
>Sorry I don't understand the question. it says "avoids setting DRIVER_OK twice" -
>why is that advantageous and worth calling out in the commit log?

I just wanted to say that it seems strange to set DRIVER_OK twice if we 
read the spec. I don't think it's wrong, but weird.

Yes, maybe we should rewrite the commit message saying that we want to 
use virtio_device_ready() everywhere to complete the setup before 
setting DRIVER_OK so we can do all the necessary operations inside (like 
in patch 3 or call enable_cbs).

Jason rewrote the commit log, so I don't know if he agrees.

Thanks,
Stefano

