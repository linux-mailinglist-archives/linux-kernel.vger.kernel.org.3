Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2AF599AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348770AbiHSLMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348763AbiHSLML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9785FF219
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660907508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uyKEBhi8LTEdHgQsAAcWCSRvZCyy+0QioGOBKWMSHow=;
        b=X8xC0/OuPyx62BMUE7JHErlLRaMHlE/TN2UpAMW7XpkvUVLM+b6ykmCc6YqQkvIkzAzufS
        LAI922oJgXw4cmZyy9OdrCchDTtPRWMrq4rJyHBBOZXgt6PPR9znxz1u8ZqrF5s0usLvSA
        1ehQ9/DB+ne4c6Lczn1AOTCuKUH6erQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-290-6J8M7J88OpSAwtR3T8CH7A-1; Fri, 19 Aug 2022 07:11:46 -0400
X-MC-Unique: 6J8M7J88OpSAwtR3T8CH7A-1
Received: by mail-ed1-f70.google.com with SMTP id y16-20020a056402359000b0043db5186943so2651816edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=uyKEBhi8LTEdHgQsAAcWCSRvZCyy+0QioGOBKWMSHow=;
        b=xWX2fOQ5Mqc44t78E2xhQHU0jSQVMjzlf/9991SCLT6deHHQdt5hLqxnJp4Bc1ONCA
         FevHzpcG2z8EnDTWA+aCzFxmFaL7JkiGuMrdNWYN+PhGkcM2ETRJWY0QqvPRVGR2nYZ0
         wuLF3Cx5/YKrHYsqIIEo5rbmPTkXU7E2UcfpR2JCxUCSXO7X7AJSukxegxqRiz3t6XOU
         iFQf7TvRziG6NyptWgNzXD8ZXHIF6cgoq9OjxufpYa6k9Wq06apKo+loLOlcKw5J6FDj
         gcbozMvSqXHnjtGnqOI0vQKiKP5pLt/MTeCFgWB9fzoU0p/a8sIiO1YDIHWHGhXbuzx0
         PgIg==
X-Gm-Message-State: ACgBeo0caf4MstfnqXld5lkM9n7eqZoc7p0OgWNj65oMvAjqk7K0a61j
        3ugiRN0x9WPDxWlWsfTyj5k8tVemlmbFs8LuSaZdl0JnERB51fx5Bt7ZOJVUHcRU4r+SL709oEx
        pRhBJw5ePWQVFcTHqieraZMgX
X-Received: by 2002:a17:907:7678:b0:730:e1ad:b128 with SMTP id kk24-20020a170907767800b00730e1adb128mr4657552ejc.67.1660907505125;
        Fri, 19 Aug 2022 04:11:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5xkOeu4QqxyH3VwQMyC9h/lwMvmB9njj2Lcfg4Kwtf1gfWbGe05LGL/eKjTj7SpwlbIl6McQ==
X-Received: by 2002:a17:907:7678:b0:730:e1ad:b128 with SMTP id kk24-20020a170907767800b00730e1adb128mr4657547ejc.67.1660907504981;
        Fri, 19 Aug 2022 04:11:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b40:2ee8:642:1aff:fe31:a15c? ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id g9-20020a50d0c9000000b00445dba95be9sm2998781edf.30.2022.08.19.04.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 04:11:44 -0700 (PDT)
Message-ID: <01bc2efd-7a3f-3c46-a163-5b19adc72f6e@redhat.com>
Date:   Fri, 19 Aug 2022 13:11:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH drm-misc-next 2/3] drm/vc4: plane: protect device
 resources after removal
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220819002905.82095-1-dakr@redhat.com>
 <20220819002905.82095-3-dakr@redhat.com>
 <20220819072614.dthfuugbkk65o3ps@houat>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20220819072614.dthfuugbkk65o3ps@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Maxime,

On 8/19/22 09:26, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Aug 19, 2022 at 02:29:04AM +0200, Danilo Krummrich wrote:
>> (Hardware) resources which are bound to the driver and device lifecycle
>> must not be accessed after the device and driver are unbound.
>>
>> However, the DRM device isn't freed as long as the last user closed it,
>> hence userspace can still call into the driver.
>>
>> Therefore protect the critical sections which are accessing those
>> resources with drm_dev_enter() and drm_dev_exit().
> 
> Ah good catch, thanks
> 
>> Fixes: 9872c7a31921 ("drm/vc4: plane: Switch to drmm_universal_plane_alloc()")
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>>   drivers/gpu/drm/vc4/vc4_drv.h   |  1 +
>>   drivers/gpu/drm/vc4/vc4_plane.c | 25 +++++++++++++++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
>> index 418a8242691f..80da9a9337cc 100644
>> --- a/drivers/gpu/drm/vc4/vc4_drv.h
>> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
>> @@ -341,6 +341,7 @@ struct vc4_hvs {
>>   
>>   struct vc4_plane {
>>   	struct drm_plane base;
>> +	struct drm_device *dev;
> 
> That pointer already exists in struct drm_plane
Oops, I've sent a v2. Also addressing your comment from the other patch.

- Danilo
> 
> Looks good otherwise
> 
> Maxime

