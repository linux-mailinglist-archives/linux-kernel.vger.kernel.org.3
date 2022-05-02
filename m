Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08D0517773
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387140AbiEBTcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387135AbiEBTcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88C211108
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651519730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybrD/7h5J3fSITXfW6xwvBBTYoCzdyhOVw3+IuZ9Mdo=;
        b=iQxTKB0OQasHTRRbuLgl2BEVWPvl8cs0yxcZ5mWCzJ+2pqc3MyGZw9teNrvSBRD0rfTcfs
        zj0N7Orsym+2mwFw5JrSoVmydeResL7QFyNqlt/+fWndvJQ9uVnFipDCSFHEqSCeEK5A5V
        pqbQ5/LNm7I86IfXAHIedn9Iw2z5YXM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-n9_7gPzvMoOURMpAzxRSCw-1; Mon, 02 May 2022 15:28:49 -0400
X-MC-Unique: n9_7gPzvMoOURMpAzxRSCw-1
Received: by mail-wm1-f70.google.com with SMTP id d13-20020a05600c3acd00b0038ff865c043so126726wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 12:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ybrD/7h5J3fSITXfW6xwvBBTYoCzdyhOVw3+IuZ9Mdo=;
        b=ShMPSGNQb9OfzttQC+4lkqsZGcaSxdrKvPAchFJEFSgAx1cHgXs3QM8T7g+yAshGW0
         5r6HJw7G8y0bHcvP/SmeQmPW7wFMwmWPOjiDWVcKgEKxB7WHcFvcKi3zfUo1SdfuU56q
         dhZXqNu4+MPmSUuAOVuJWzDekumDer5tA56uTGSRJVm23ZK2dZJGr6fhaM15zG7nfMPZ
         zg71vhKUtp2/KtpyvGVXdDnekvAClN7dXrilO6+UOBVViAaxwBtfgurcsBg+xBnofmZb
         qhnRdcmztHcuZUE38+jejj1NusrBYHzAPqxxp4Nn6ujxqx3SG/ic52TSlkCnrfrXpzri
         6V2A==
X-Gm-Message-State: AOAM532c1MncRrW9KCVxPz77/oQbE1H3+oz7fJg+jVVeWRX6rwSMl6Fx
        sq0U0AP3AnzzoasBX9i4bWbcd5dLOn/jv2IEfya4X+COtxK1/Wt39uJPURufACV30kxlwbZb+10
        UCWGIq+OCBZ1JwOgYrlh4tETF
X-Received: by 2002:a1c:2185:0:b0:38f:f4ed:f964 with SMTP id h127-20020a1c2185000000b0038ff4edf964mr455158wmh.115.1651519728172;
        Mon, 02 May 2022 12:28:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6PH/40SaNl+msWDc9MMOxGWhQ4paAp4y0QHAm2sPRM41zGPMEJK26hBMq+1sXlgAvBf3d/A==
X-Received: by 2002:a1c:2185:0:b0:38f:f4ed:f964 with SMTP id h127-20020a1c2185000000b0038ff4edf964mr455146wmh.115.1651519727953;
        Mon, 02 May 2022 12:28:47 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l1-20020a1ced01000000b003942a244f4fsm54753wmh.40.2022.05.02.12.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 12:28:47 -0700 (PDT)
Message-ID: <21db3772-b85a-59ff-df17-9056b3099977@redhat.com>
Date:   Mon, 2 May 2022 21:28:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/3] drm: Remove superfluous arg when calling to
 drm_fbdev_generic_setup()
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20220502153900.408522-1-javierm@redhat.com>
 <20220502153900.408522-2-javierm@redhat.com>
 <YnABjdpGC166yIY7@pendragon.ideasonboard.com>
 <5dd80287-1b09-d02c-9f67-5a0bb0a4566c@redhat.com>
 <bc6b6598-0e09-1a43-4086-e4164ab42a20@redhat.com>
 <YnAkwRL7b++a0omG@pendragon.ideasonboard.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YnAkwRL7b++a0omG@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 20:36, Laurent Pinchart wrote:
> On Mon, May 02, 2022 at 07:15:16PM +0200, Javier Martinez Canillas wrote:
>> On 5/2/22 18:55, Javier Martinez Canillas wrote:
>>
>> [snip]
>>
>>>> drop the depth option to drm_fbdev_generic_setup() ? There's a FIXME
>>>> comment in drm_fbdev_generic_setup() that could be related.
>>>
>>> A FIXME makes sense, I'll add that to when posting a v3.
>>
>> There's actually a FIXME already in drm_fbdev_generic_setup(), so it's
>> a documented issue [0]:
> 
> That's what I meant by "there's a FIXME" :-) It doesn't have to be
> addressed by this series, but it would be good to fix it.
>

doh, I misread your original email. Yes, it's the same issue as you
said and something that I plan to look at some point as a follow-up.
 
I hope that we could just replace fbcon with a kms/systemd-consoled/foo
user-space implementation before fixing all the stuff in the DRM fbdev
emulation layer :)

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

