Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FC24DD325
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 03:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiCRCfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 22:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiCRCfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 22:35:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20FE92B2044
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647570865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=duOp2ocdsQtYVeejVnR7JaDMgSdM5pTrtAwC2d6f5i4=;
        b=Rpt6DhFHAhb1c7uviGvuep8o12OXJGaRI5OjMtJ4b3tZLYC4PGMDOeLRWK+bI9PvOB+r9J
        2PyI6a/TF6sLpczTVz6e6ExN121hubvHvAUHoidYL8pn7ATiEvveTI1kbBukN0RC28482/
        zuhU0UeMMJOPSk7xdwo5j3Q8rOvWO84=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-yQnZBMsIP-CKZhfWFtjaVg-1; Thu, 17 Mar 2022 22:34:24 -0400
X-MC-Unique: yQnZBMsIP-CKZhfWFtjaVg-1
Received: by mail-lf1-f71.google.com with SMTP id w25-20020a05651234d900b0044023ac3f64so2253349lfr.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=duOp2ocdsQtYVeejVnR7JaDMgSdM5pTrtAwC2d6f5i4=;
        b=7NpN1vM04jQ0b+3e6Nyv8smeINYswraBSeSgIlC0RPq+1t949c6xKrBUvLMOMsgSbl
         6GX8dfwF4wqNmNFRPhM6a5p1kZ/KsxP5vG4RPKh9fU/btgizzkc0ZEHAe1VxB6Cjp/w1
         3mAqC2yaNG9rv+twS6g1Xs3XQeT+IUV7P2JWl3dllgcO6eLQTPQzuOooUnrTRF6Piohp
         5ShXCl2l2W2ximD5Pmd1oXpB7uUEtXvjpKcCeyAd3e0NdIXffNrytxhRyyQpDTziBJCT
         1j4QX56P5P/Vt0LxnQ5cFhyobA3zg42IgfHqSgTH/CcTURaNs3LdDH/51SW4Gkd5ssu4
         cQgg==
X-Gm-Message-State: AOAM533ij9Hs1L5qo6ryC/DgWSXG2uY9UNrgpu3W5sRL+qGef4Lx1car
        vVLY4iZG4u4ymJ/MCFWHQdKhQDXFPOFLkLp0DP2gQHJegmQeg/FxZMyWg30AeI7mS1f5tlXfIkS
        s+GbNWPtjXIBnBVPOjV7RcMw=
X-Received: by 2002:a2e:b60e:0:b0:248:1b9:a88a with SMTP id r14-20020a2eb60e000000b0024801b9a88amr4606689ljn.270.1647570862425;
        Thu, 17 Mar 2022 19:34:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDhDFnC46j4OMGmVk18Qmp7Znlt5OUc2MqgnzsvJkomjHYZRasHOYL4E2Kr+SaaM5gyqARmw==
X-Received: by 2002:a2e:b60e:0:b0:248:1b9:a88a with SMTP id r14-20020a2eb60e000000b0024801b9a88amr4606675ljn.270.1647570862199;
        Thu, 17 Mar 2022 19:34:22 -0700 (PDT)
Received: from [192.168.1.121] (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id d33-20020a0565123d2100b0044a0c8e0625sm71857lfv.290.2022.03.17.19.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 19:34:21 -0700 (PDT)
Message-ID: <10fb1261-f22f-8e21-4056-166c283e26f2@redhat.com>
Date:   Fri, 18 Mar 2022 04:34:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] mm/hmm/test: simplify hmm test code: use miscdevice
 instead of char dev
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        vbabka@suse.cz
References: <20220311033050.22724-1-mpenttil@redhat.com>
 <20220314182439.GB64706@ziepe.ca>
 <d9b9c82e-4012-cf0a-d966-d9669a684a27@redhat.com>
 <20220315183922.GC64706@ziepe.ca>
 <8e836d75-97b0-d301-4d6a-92025e91cad5@redhat.com>
 <0f53c5ff-1711-861d-9a12-0634d4ab9fca@redhat.com>
 <20220317141539.GD64706@ziepe.ca>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <20220317141539.GD64706@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.3.2022 16.15, Jason Gunthorpe wrote:
> On Thu, Mar 17, 2022 at 08:58:52AM +0200, Mika Penttilä wrote:
>> @@ -1225,7 +1232,11 @@ static int dmirror_device_init(struct dmirror_device
>> *mdevice, int id)
>>
>>          cdev_init(&mdevice->cdevice, &dmirror_fops);
>>          mdevice->cdevice.owner = THIS_MODULE;
>> -       ret = cdev_add(&mdevice->cdevice, dev, 1);
>> +       device_initialize(&mdevice->device);
>> +       dev_set_name(&mdevice->device, "%s", dmirror_device_names[id]);
>> +       mdevice->device.devt = dev;
>> +
>> +       ret = cdev_device_add(&mdevice->cdevice, &mdevice->device);
>>          if (ret)
>>                  return ret;
> 
> Right, miscdev isn't that helpful in the end..
> 
> Jason
> 

To wrap up, I could send a v3 formal patch with either this cdev way or 
the miscdev way.. Both eliminate the user space /proc/devices parsing 
and mknod'ing. Jason brought up concerns using miscdevice like this, 
although for this case it works correctly. miscdevice also provides a 
little more cleanup and simpler code, but the difference is not huge. So 
what do people prefer?

Thanks,
Mika

