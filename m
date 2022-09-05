Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D495AD182
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbiIELXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbiIELXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149775B7A2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662377018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=As4yCcd3hHBHBXcao7m1xcH+s7kQozOVt+DY1fyS6j0=;
        b=BpCU7qYLiuEq5aVSd5jHMQXfSnbOQyR/FwcZtpkDrBWKYEZdJaXadTjAuCO2R/KSECGzD7
        6KM7Hqv5YTYcM8WJ9DFv/FADtLgxr4kdJVtkCU2B1DUQZCNHDSa510hBZOUzPnbIsHD6hZ
        mU5Djn4hghSLM9hQHiK7wgwj2D+4/pU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-332-7LLB7GFsN660MGcHHCTCnw-1; Mon, 05 Sep 2022 07:23:38 -0400
X-MC-Unique: 7LLB7GFsN660MGcHHCTCnw-1
Received: by mail-wm1-f70.google.com with SMTP id n7-20020a1c2707000000b003a638356355so5262363wmn.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 04:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=As4yCcd3hHBHBXcao7m1xcH+s7kQozOVt+DY1fyS6j0=;
        b=s6Ry2Fj5+y8EvNIIuYiimfDJVUz34sErR7ZvJ2kjItBFELAIL6qv+8kAyRpFfccUpu
         efPOli3CyZB2lkFYuto0bwn9jEHtZak1Msk0D25LfKSeaOtNo9+CO2583sylcTjAXlOD
         ZP7OyKYmYrpZQZq6HCgT6Kewvh3nVWWUTirjK6SR+4WPB39j+cmg/oauwN9g4i8nij/b
         dy11G/YfVsCWdd9dCUmJQOcfs+JY2+my6XPdRT6DqZZ1cxcRFrpgvQ4jMI6gmlmkm5dA
         pb42O1OpHZRYXlUoMwoDO5s3/UbDn912DupCb8M+GaAigZQiAml0x2JMazlsv4vRkkAP
         NfgQ==
X-Gm-Message-State: ACgBeo1xPjFlGwmrDKztwMxFqa4iucesOcK+/5h7ylmUZd0nnI8jUbqq
        4DRqMunDxJZqB+wXD/s8d5sDcAnxr20lKEHpZ79Tr4G3GuQ08yk/8O9uPja2C/AngQBoVZDoBoX
        KySlx4tjdkrC3UAge2J9tjweb
X-Received: by 2002:a5d:6a8b:0:b0:228:5cc0:84c8 with SMTP id s11-20020a5d6a8b000000b002285cc084c8mr5921686wru.414.1662377016611;
        Mon, 05 Sep 2022 04:23:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4JWqEiy6jK3SMnpP+DDYCCY8CODT55Wg8Erqm6CBrPglJqm17Vf3wOseTGHpTXNQTeFoDdmQ==
X-Received: by 2002:a5d:6a8b:0:b0:228:5cc0:84c8 with SMTP id s11-20020a5d6a8b000000b002285cc084c8mr5921678wru.414.1662377016432;
        Mon, 05 Sep 2022 04:23:36 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c024300b003a690f704absm16854154wmj.4.2022.09.05.04.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 04:23:36 -0700 (PDT)
Message-ID: <54a22137-61f6-4af8-dd80-301d180e553a@redhat.com>
Date:   Mon, 5 Sep 2022 13:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] drm/ssd130x: Replace simple display helpers with the
 atomic helpers
Content-Language: en-US
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
References: <20220828151114.1141510-1-javierm@redhat.com>
 <6f499b1e-daa4-7de1-6ffc-151663807910@suse.de>
 <03b207a8-e09c-2858-fd54-b95f2e8e8d11@redhat.com>
In-Reply-To: <03b207a8-e09c-2858-fd54-b95f2e8e8d11@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/22 13:00, Javier Martinez Canillas wrote:
>>> +static void ssd130x_encoder_helper_atomic_enable(struct drm_encoder *encoder,
>>> +						 struct drm_atomic_state *state)
>>> +{
>>> +	struct drm_device *drm = encoder->dev;
>>> +	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
>>> +	int ret;
>>> +
>>> +	ret = ssd130x_power_on(ssd130x);
>>> +	if (ret)
>>>   		return;
>>>   
>>> -	ssd130x_fb_blit_rect(plane_state->fb, &shadow_plane_state->data[0], &dst_clip);
>>> +	ret = ssd130x_init(ssd130x);
>>> +	if (ret)
>>> +		return ssd130x_power_off(ssd130x);
>>
>> It returns a value from a function returning 'void'?
>>
> 
> Right. I'll fix it in v2 as well.
>  

Actually, this return statement is correct since ssd130x_power_off()
return value is 'void' as well.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

