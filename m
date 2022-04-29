Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2C3514312
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355032AbiD2HSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351856AbiD2HSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16AA536177
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651216496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bmhVhWxwujManEWb7Tvvt40ys1VYDFgv5QSh1ts7YSs=;
        b=fFIzZnNe8+/lmrsFqQbJJHduIekfgj3NeoTNwWqKIwat0xBQnRK0cvXqgRxsOFXi0snOqw
        2sMHTyjn5Vf6oZ21Y8YS0vHPkMvo0BysB9QX8zEsYZ6/8u0egSoNv5ZIeprBQrZWcHlJcx
        /tETHmQAyUoWvXgGcrOs+T2e2XSd17g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-TcYEM2wENJKFO7GqZDXUBw-1; Fri, 29 Apr 2022 03:14:54 -0400
X-MC-Unique: TcYEM2wENJKFO7GqZDXUBw-1
Received: by mail-ej1-f71.google.com with SMTP id o8-20020a170906974800b006f3a8be7502so4106368ejy.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bmhVhWxwujManEWb7Tvvt40ys1VYDFgv5QSh1ts7YSs=;
        b=3UL8Bads6g4yBE1pTEQ65+XEM1/bXBtMDT2dsoHUrPUa5RrrEw9Et/6KBWihmi/KTY
         Nc2h0x1ykacIFTc8GLlfVxbPzi8OKVYMymh8Vuk0LCRDYqzlWcI44A90YVpLNjZhHBU9
         E0rGxsj5SWtUh5FJkAWifMMoybWu9lKrGbsjmU7Asm2hGIwzfg8GHO0fzols2u8R0q7D
         tyG2LmF1dMKr+9ZMWrcetSaPuG7ROOqSdJxEurVu83AKF4KGWTMKEw7xNh1y2L5kmwcp
         KkSd7pg7VrrAIOf6YDtpMqbedrKaZsH8atUjcihmfEuWFcXL8wLhl8Clsar1ISp9RU7x
         8PbA==
X-Gm-Message-State: AOAM532FUTd1eoAXOqStk/RV9ADUJrMIZUqaAqLSn4kZvxS6RU8x9ED4
        hRmxWbmJ+AmLm7+oyBZuYRTB5bq/xusJFj1fdMONzUtBZuldl2YUqBM7H+7kC0KSKB3ahH9qv5C
        q+yDoQwlvvIR5vHr1DJUixSjd
X-Received: by 2002:a05:6402:518f:b0:426:25ed:4a2 with SMTP id q15-20020a056402518f00b0042625ed04a2mr8255001edd.9.1651216493621;
        Fri, 29 Apr 2022 00:14:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnz8bMf2XUMgzQMQyMU1WLAZsmiRkEckvQzc3dWSmAMEIfI6u9vul2juptEqaiz0ZzC8QlpQ==
X-Received: by 2002:a05:6402:518f:b0:426:25ed:4a2 with SMTP id q15-20020a056402518f00b0042625ed04a2mr8254987edd.9.1651216493364;
        Fri, 29 Apr 2022 00:14:53 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-234.retail.telecomitalia.it. [87.11.6.234])
        by smtp.gmail.com with ESMTPSA id og31-20020a1709071ddf00b006f3ef214da2sm364183ejc.8.2022.04.29.00.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 00:14:52 -0700 (PDT)
Date:   Fri, 29 Apr 2022 09:14:49 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
Message-ID: <20220429071449.pycbkk2dvvxmtvay@sgarzare-redhat>
References: <20220428151242.213824-1-sgarzare@redhat.com>
 <CACGkMEv=0VWh_NxhvM+6_TRHEx0f2RGRWbR1n5RhKfq0a7xJUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACGkMEv=0VWh_NxhvM+6_TRHEx0f2RGRWbR1n5RhKfq0a7xJUw@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 10:46:40AM +0800, Jason Wang wrote:
>On Thu, Apr 28, 2022 at 11:13 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> The simulator behaves like a ramdisk, so we don't have to do
>> anything when a VIRTIO_BLK_T_FLUSH request is received, but it
>> could be useful to test driver behavior.
>>
>> Let's expose the VIRTIO_BLK_F_FLUSH feature to inform the driver
>> that we support the flush command.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> index 42d401d43911..a6dd1233797c 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> @@ -25,6 +25,7 @@
>>  #define DRV_LICENSE  "GPL v2"
>>
>>  #define VDPASIM_BLK_FEATURES   (VDPASIM_FEATURES | \
>> +                                (1ULL << VIRTIO_BLK_F_FLUSH)    | \
>>                                  (1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
>>                                  (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
>>                                  (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
>> @@ -166,6 +167,17 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>>                 pushed += bytes;
>>                 break;
>>
>> +       case VIRTIO_BLK_T_FLUSH:
>> +               if (sector != 0) {
>> +                       dev_err(&vdpasim->vdpa.dev,
>> +                               "A driver MUST set sector to 0 for a VIRTIO_BLK_T_FLUSH request - sector: 0x%llx\n",
>> +                               sector);
>
>If this is something that could be triggered by userspace/guest, then
>we should avoid this.

It can only be triggered by an erratic driver.

I was using the simulator to test a virtio-blk driver that I'm writing 
in userspace and I forgot to set `sector` to zero, so I thought it would 
be useful.

Do you mean to remove the error message?

Thanks,
Stefano

