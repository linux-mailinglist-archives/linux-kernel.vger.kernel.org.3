Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E7D5312D8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiEWPfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237929AbiEWPfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03BDB54BDF
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653320148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2KAC1uUtSEkUItQB1W9uMOP2zx1Fex80FCDALCr5LA=;
        b=SUTjCLW+LtbWul7VqxuCAD4yZ+H6MyS+85rUF30hFmwMLwquWxF/V3AZn4CocPk4GAX5XG
        uKNJvsi+UpjFT/W+ne9ecLe+XGAx/vA6tsE0yAJ9xfVghuYS7GAvjmfdT0qiTMgn+xWS9H
        NZVBNLcYPOHnDyk799ZgRXwufF6NsNw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-BL78one-OtGIYkhLZ8gTJA-1; Mon, 23 May 2022 11:35:46 -0400
X-MC-Unique: BL78one-OtGIYkhLZ8gTJA-1
Received: by mail-wr1-f70.google.com with SMTP id x4-20020a5d4444000000b0020d130e8a36so4125074wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q2KAC1uUtSEkUItQB1W9uMOP2zx1Fex80FCDALCr5LA=;
        b=Z6KMGMyF/AFPic2OW8Tnb1vygcgAd/zph31MGlMM6BmH4kL0g/NiXSEIouy3TfIN1E
         /nH/xmnlCnDXm1DHB2hpAO+x9ZuQvGBktsQ7xXAaS27WGPGk//9Mi+QDp/ENAEEL3xhD
         EGeHcqoaZ8ZLK+vKaCKOKvTTcu1WGzvMqkh1xfWJwd27JHgAIvvb7SA5yO5pbK3wCFXK
         xKvKp7C41Zsnin/O0+NtmcK7lGOtK3zyUPRAaJ6MHsAsUhqipTmIeM7dKMB7rWWakpew
         g0apX/fxAEt5O8+JRp3vs/AK3GNV7w1Q/cZzJ0WwKL1PQtxZTyHyMYUe6z0TpzncxkgC
         lpMw==
X-Gm-Message-State: AOAM530xaZ7e1sdVdPxOoftz7EfnAKPDThhKiuduc8uZ6RtgbJwoyxkC
        dphSVZwRG6f+toOFtzt5yr1K2SsF5YmCz/GZC2lVod2a3fTLN5XMzxMv8RP18w5XzzNEkAe2VZm
        vMlWBTJYNg3Y0I+sAClfIjb3l
X-Received: by 2002:a05:6000:18a4:b0:20e:79a2:4613 with SMTP id b4-20020a05600018a400b0020e79a24613mr14059553wri.459.1653320143180;
        Mon, 23 May 2022 08:35:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEH2kKe3iyfnbSpXy9l3pJJY1B63fBh+NuSk9c5mmpbmsyqkCPFw7eCWq/4zquFwPkHqx5Cg==
X-Received: by 2002:a05:6000:18a4:b0:20e:79a2:4613 with SMTP id b4-20020a05600018a400b0020e79a24613mr14059537wri.459.1653320142852;
        Mon, 23 May 2022 08:35:42 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c4d03000000b003942a244f30sm10357845wmh.9.2022.05.23.08.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 08:35:42 -0700 (PDT)
Message-ID: <6b5e584a-6d08-afc5-d503-7ef830ee1165@redhat.com>
Date:   Mon, 23 May 2022 17:35:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 2/3] fat: add renameat2 RENAME_EXCHANGE flag support
Content-Language: en-US
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Chung-Chiang Cheng <cccheng@synology.com>
References: <20220519092343.2776414-1-javierm@redhat.com>
 <20220519092343.2776414-3-javierm@redhat.com>
 <87fsl1cvl7.fsf@mail.parknet.co.jp>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87fsl1cvl7.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello OGAWA,

Thanks a lot for your feedback.

On 5/22/22 19:42, OGAWA Hirofumi wrote:
> Javier Martinez Canillas <javierm@redhat.com> writes:
> 
>> The renameat2 RENAME_EXCHANGE flag allows to atomically exchange two paths
>> but is currently not supported by the Linux vfat filesystem driver.
>>
>> Add a vfat_rename_exchange() helper function that implements this support.
>>
>> The super block lock is acquired during the operation to ensure atomicity,
>> and in the error path actions made are reversed also with the mutex held,
>> making the whole operation transactional.
> 
> I'm not fully reviewed yet though (write order and race), basically
> looks like good.
> 

Thanks for looking at the patch. I agree with all your remarks and will
address them in v2. Please let me know once you have reviewed if is OK
from a write order and race point of view.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

