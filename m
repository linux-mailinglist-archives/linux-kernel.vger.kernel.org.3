Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C5759ADE0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 14:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346246AbiHTMRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 08:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345238AbiHTMRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 08:17:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21DB61D79
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 05:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660997839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iy3aCCM0ofzhiGWBxDwAa5x5+aFSHrvtSCmy4RrpDTE=;
        b=PpouliPgEtqN4U/9mRC90N3eXmpl28EmB/krwXcCQCx4FtD8KwA9FoFvmTU05wD1RK7J8y
        iVzjplYCBS0kaEKI8qe4okCThC0d+Pepr7ADOCy4rDvSWT+VLp7ksMEkI6IHQfWhBnex/Y
        KtEx195Owr1wiEGbclQyO5cLRIIizkU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-492-OE4CQrrgM9GFzMZ8r8TciA-1; Sat, 20 Aug 2022 08:17:17 -0400
X-MC-Unique: OE4CQrrgM9GFzMZ8r8TciA-1
Received: by mail-ed1-f71.google.com with SMTP id c14-20020a05640227ce00b0043e5df12e2cso4219456ede.15
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 05:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=iy3aCCM0ofzhiGWBxDwAa5x5+aFSHrvtSCmy4RrpDTE=;
        b=3yNzgJyxq7y3K3EEe1ualDHd5p3ba9pF8OWXA8PqCQHaJhglyPEwIU+rIkvA4Jv1VM
         1T9JWNjlSWZOpZgXqf5tn1T3puzR/wq3aSOuIJOygXJ3Ya45AVaM655yUNdnJQtrybpu
         1wJpClWj2io/4ey9n8C+4wqcXICdflG5TifvxOE7cQLs1qF1ntqzBJbKLbjhiOG2tH6L
         c5HNQpZdaFZnrid2QpA0oXh/+hFTzfMRbPQbTFfFrvdSpaiMso8HKlqRsmtxZZTbGPw1
         SydRMroXXnNR6tbMJMPHtoU0Iy/mBuNVqgHM7dGa4ZryS4F9w3eMfidKLXxgrPg9Bq41
         PRew==
X-Gm-Message-State: ACgBeo1v4ncDyv6K7MjeJbq0+UuMsIase1ph9XrOSU1d7XjtA1DdoazC
        ZeqnAJqPKU9fJK2Yx+12eu+DEoYMuEWEfusHxwyY7Oz5JMdvrU2U7ZUCEk7y9qa7ZK8ww5OHyl3
        JH+l3uUPhLCaY3DMj+YDwIxBZ
X-Received: by 2002:a17:907:970b:b0:73d:5a29:959 with SMTP id jg11-20020a170907970b00b0073d5a290959mr3372642ejc.183.1660997836697;
        Sat, 20 Aug 2022 05:17:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5nXo87Pd7eW6X9eQzTrY8FDGaHJn7EYV6wHukMmMfX/kPNkwcmlXtH1ZjmliARRqJ1I9GyPA==
X-Received: by 2002:a17:907:970b:b0:73d:5a29:959 with SMTP id jg11-20020a170907970b00b0073d5a290959mr3372632ejc.183.1660997836515;
        Sat, 20 Aug 2022 05:17:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709067cc700b0072f112a6ad2sm3575376ejp.97.2022.08.20.05.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 05:17:14 -0700 (PDT)
Message-ID: <63626444-a7ee-a0c4-ec0a-f44a810e25ea@redhat.com>
Date:   Sat, 20 Aug 2022 14:17:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 0/4] remove useless files
Content-Language: en-US
To:     Nam Cao <namcaov@gmail.com>, lkp@intel.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <202208200447.kdEhBy9a-lkp@intel.com>
 <cover.1660977535.git.namcaov@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <cover.1660977535.git.namcaov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch 1/4 seems to be missing?

Also please squash patches 3 and 4:

   staging: rtl8723bs: remove odm_NoiseMonitor.o from Makefile
   staging: rtl8723bs: remove odm_NoiseMonitor.h and odm_NoiseMonitor.c

together. Ion other words remove both the files and the Makefile
target in a single patch please.

Regards,

Hans


On 8/20/22 08:42, Nam Cao wrote:
> Delete odm_NoiseMonitor.c and odm_NoiseMonitor.h because they are
> useless. The first 2 commits are preparation, and the final commit is
> actual removal.
> 
> v2: Add new patch to remove the file from Makefile, otherwise there is
> build error as reported by kernel test bot.
> 
> Nam Cao (4):
>   staging: rtl8723bs: remove unused function ODM_InbandNoise_Monitor
>   staging: rtl8723bs: remove member noise_level from struct dm_odm_t
>   staging: rtl8723bs: remove odm_NoiseMonitor.o from Makefile
>   staging: rtl8723bs: remove odm_NoiseMonitor.h and odm_NoiseMonitor.c
> 
>  drivers/staging/rtl8723bs/Makefile            |   1 -
>  drivers/staging/rtl8723bs/hal/odm.h           |   2 -
>  .../staging/rtl8723bs/hal/odm_NoiseMonitor.c  | 130 ------------------
>  .../staging/rtl8723bs/hal/odm_NoiseMonitor.h  |  39 ------
>  drivers/staging/rtl8723bs/hal/odm_precomp.h   |   1 -
>  5 files changed, 173 deletions(-)
>  delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
>  delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h
> 

