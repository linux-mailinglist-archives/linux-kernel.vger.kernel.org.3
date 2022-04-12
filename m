Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509A14FD65E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391343AbiDLJ3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384016AbiDLIi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26923FFD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649750644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbhl05HtZCAM0QbsYgzFCTx28ZJJnBHmU8lbBNZDClo=;
        b=VUu1DAQFREtABIaWbgyYa+PfFsyzyANY+oXmNFG6pX9R2zocLQBFF43G6N6VpNWS3u1+39
        Evwmvuyyw/0KFBneNQQRjPcWl4BgU5XrF29Em97goUGL0fU59URrhawcSx6tnaaQ9RmdAt
        nWV003jYiucSIS4uuYoLwQx9p5jVHEk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-vqo2SVPgP4m65M2uxmentg-1; Tue, 12 Apr 2022 04:04:02 -0400
X-MC-Unique: vqo2SVPgP4m65M2uxmentg-1
Received: by mail-wm1-f70.google.com with SMTP id h65-20020a1c2144000000b0038e9ce3b29cso948794wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rbhl05HtZCAM0QbsYgzFCTx28ZJJnBHmU8lbBNZDClo=;
        b=zcmrT3+g5zKmy1UyDHXNdihh2T9ebYDgQ506lSvRxfPxcju0rph+ENxS1G56ELpPb7
         q3OxOp76cUFyipnA0dQZv4C0v5Ud+fkvLrtzbmf95L05S52KA6IdqxLcq8g70XxgPawB
         KliJ4KVYEPQq/s794hQWyttoEwm0awTDulaEGPeYlDeSw9WOnP4GW+V7g6i4wpJe7Njr
         /RKkvY2anVo3m6gccLm2s4WtrH3fU33aB07xsCqPQQSgatnrCMtpdUnPZ68MKJ6Qre9+
         sz1vrPO6T79absFa5BDzxpH3ALxH4QBcRx4oIObPRscbHpu3CYoXT2APvrkomU6l3xN3
         hylw==
X-Gm-Message-State: AOAM531LWq6RaSpoJSSmHHydwdHpdFC1uZp3NeScBYDRdIYCWGURzoVn
        Rhirn/+3qB1ZFRD/MHitSRFuYcR5gInh0HWZm3FJP7jEYaEB+dnpJPhLM8bucu9CbAd7ARjhVEK
        pGXqbWpUX02Zwg408iPSHzMwX
X-Received: by 2002:a1c:7517:0:b0:38c:8722:9bc6 with SMTP id o23-20020a1c7517000000b0038c87229bc6mr2903820wmc.2.1649750641728;
        Tue, 12 Apr 2022 01:04:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNulvYOKyNljk5aO/TEUcOBw7IP2//9iJfeiOVa008fbcM5pJ/mjc3Z/KG9RH+aMGBaU2irg==
X-Received: by 2002:a1c:7517:0:b0:38c:8722:9bc6 with SMTP id o23-20020a1c7517000000b0038c87229bc6mr2903798wmc.2.1649750641518;
        Tue, 12 Apr 2022 01:04:01 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d5608000000b00207ab405d15sm2767291wrv.42.2022.04.12.01.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 01:04:01 -0700 (PDT)
Message-ID: <bf65cc48-d7af-150e-b6c5-84721b9175e8@redhat.com>
Date:   Tue, 12 Apr 2022 10:03:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/5] drm/solomon: Add ssd130x new compatible strings
 and deprecate old ones.
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
References: <20220411211243.11121-1-javierm@redhat.com>
 <20220411211243.11121-4-javierm@redhat.com>
 <CAMuHMdWVZ2+YYkLUjCYLjCQx27AvMUPkwrUkTX52w0dyjVjOEg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdWVZ2+YYkLUjCYLjCQx27AvMUPkwrUkTX52w0dyjVjOEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 09:19, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Mon, Apr 11, 2022 at 11:12 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> The current compatible strings for SSD130x I2C controllers contain an "fb"
>> and "-i2c" suffixes. These have been deprecated and more correct ones were
>> added, that don't encode a subsystem or bus used to interface the devices.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> Acked-by: Mark Brown <broonie@kernel.org>
>> ---
>>
>> (no changes since v1)
> 
> That's not really true ;-)
>

Ups, I did indeed update the compatible strings to drop the "-i2c" as you
asked. I'll add that in the patch history for v2 when posting v3.
 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 

Thanks!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

