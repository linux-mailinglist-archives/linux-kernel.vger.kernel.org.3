Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC945402A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344278AbiFGPlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344235AbiFGPlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:41:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFCFFF7499
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654616473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MW20m0fXB97Kzh8xHfouXeuYHpNJecVj214SM0USpwc=;
        b=BFpBDLwDbqRzOxLMfaIjmK9xrgdpO2Hq5PELg6d5XNP6cTySHAEFJx0A1CPapPil4iWDI4
        UCgyg1yiKYNMqwz77VSasMApgmHJn6NTSoFfgi7B4wFO5E63au+46JGT3XJ04IAcOo5Pb8
        RYqfZarmM9oUry11olIdQnxpSfrwwps=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-wJ0zxIr_Nsq9GgbQm7QBxw-1; Tue, 07 Jun 2022 11:41:12 -0400
X-MC-Unique: wJ0zxIr_Nsq9GgbQm7QBxw-1
Received: by mail-wm1-f69.google.com with SMTP id l34-20020a05600c1d2200b003973a50c1e4so8910583wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 08:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MW20m0fXB97Kzh8xHfouXeuYHpNJecVj214SM0USpwc=;
        b=U89w7mWZpVdh98+w6dcwse2HokjQBTYD/0WkIKScfoR5nOLo9f+K+5Zl+D/19cu3Wm
         GSVufvvPpWDDs7bZhU1f2A4XaYo6iUMzu9KqCqS+v3ZsQ0ozhqATkNFiSl4oxaIAy2Ly
         wgzt0tLgBhB5D/TENmwThHbGDH9P+YgN6V0uuvRe+ZP4PGLnOYGJr05RaQ1o3AS5G5ff
         TVozNt7utkrkKDZWrjm+Cmi1tJxDybJklxpYCzZ4m3+6TASMB2YYXjcj+4sqtmfHPwQW
         SKFi+lna4Ag0JT/kSMRcgJLu145XPujBmFDRGjozol5aaqCdInETQVlTAmfweJSidOOJ
         gdcg==
X-Gm-Message-State: AOAM533rW1AAvANest9yewy84kZ3TGIb+i18WB1RS7X8Z7X+Saw3j6wP
        QQOFQ48sitx70K6u203vOwCx3PnrRfMuGWDmCNvCS7tFJvtiRTMLNEFKkcNwWl5+EtS9N+kRIxv
        zRoIR7XIDpxdgdAtxXb4B+FJcj/Aib+f5WvxwfdxUjadz+RInbOWE2/YrVkkYjBreXcwCMOCDgl
        w=
X-Received: by 2002:adf:cf04:0:b0:215:e763:518a with SMTP id o4-20020adfcf04000000b00215e763518amr19598104wrj.290.1654616470565;
        Tue, 07 Jun 2022 08:41:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygbbgbOiyD2ek2GV5QdQZM8m7ti0m92eFR0rbReFw2iOXdMVBWmQ6imP5ap57dHC1mi4EPfg==
X-Received: by 2002:adf:cf04:0:b0:215:e763:518a with SMTP id o4-20020adfcf04000000b00215e763518amr19598068wrj.290.1654616470203;
        Tue, 07 Jun 2022 08:41:10 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c425500b0039c41686421sm13105215wmm.17.2022.06.07.08.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 08:41:09 -0700 (PDT)
Message-ID: <da991c8e-bd19-d243-5433-82b9621df4aa@redhat.com>
Date:   Tue, 7 Jun 2022 17:41:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 5/7] fbdev: Disable sysfb device registration when
 removing conflicting FBs
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220511112438.1251024-1-javierm@redhat.com>
 <20220511113144.1252729-1-javierm@redhat.com>
 <Yp9oLJ/HD2rHxO3z@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Yp9oLJ/HD2rHxO3z@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On 6/7/22 17:01, Daniel Vetter wrote:

[snip]

>>
>>  drivers/video/fbdev/core/fbmem.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
>> index 9b035ef4d552..265efa189bcc 100644
>> --- a/drivers/video/fbdev/core/fbmem.c
>> +++ b/drivers/video/fbdev/core/fbmem.c
>> @@ -1789,6 +1789,17 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
>>  	if (do_free)
>>  		kfree(a);
>>  
>> +	/*
>> +	 * If a driver asked to unregister a platform device registered by
>> +	 * sysfb, then can be assumed that this is a driver for a display
>> +	 * that is set up by the system firmware and has a generic driver.
>> +	 *
>> +	 * Drivers for devices that don't have a generic driver will never
>> +	 * ask for this, so let's assume that a real driver for the display
>> +	 * was already probed and prevent sysfb to register devices later.
>> +	 */
>> +	sysfb_disable();
> 
> So the og version had (or should have had at least) the sysfb_disable()
> call before we go through the loop and try to unregister stuff. I think
> this needs to be done before we call do_remove_conflicting_framebuffer()
> instead. With that:
>

Yes, the original version did that but also the original version didn't
attempt to remove the devices registered by sysfb on sysfb_disable().

I was going to answer that this has to be done after the loop because
that way fbmem could first ask sysfb to remove the devices, but then I
realized that you are correct That this wouldn't be needed if sysfb does
the disable (and unregistration) before the loop.

So by doing it before the loop, we should be able to drop [PATCH v5 4/7]
fbdev: Make sysfb to unregister its own registered devices:

https://lists.freedesktop.org/archives/dri-devel/2022-May/355201.html

Since by the time the loop is executed, no registered_fb associated with
a device that was registered by sysfb should be present in that array.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

