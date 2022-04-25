Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D335C50DD2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbiDYJxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbiDYJwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6AA23F330
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650880158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKNwuusliPtIsiMP1NCPfSy6f0NI8bGmv/mZPssyDJg=;
        b=g6B/a6BRVF57tmm2hir8zrvHsWbyLwu1KKchwYdwykD0UAMuv7vTsQ66ZTho3OH4p73CNh
        ZDKyzjc35XcTHl92cVoSDTOR/bQN6U8clqze2DLLFKv6onuOCiTjUMfvQ1dz1JlFDv7GC1
        GPacwf6y/fdTolmrgdpanY08qIQ0tZ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-YB74clg7OzykA0DDQx86zA-1; Mon, 25 Apr 2022 05:49:17 -0400
X-MC-Unique: YB74clg7OzykA0DDQx86zA-1
Received: by mail-wm1-f70.google.com with SMTP id bh11-20020a05600c3d0b00b003928fe7ba07so6951155wmb.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kKNwuusliPtIsiMP1NCPfSy6f0NI8bGmv/mZPssyDJg=;
        b=DYVbP+oOlIGCOoWmahntAjYgE4MMY3S/uT9po+Z3pzMqic0r7JktNB2BVXuMcjO2RX
         pIfs5ThEUXA/Y4sIbO9Bwg5607bzy3b9jXrD9UVvS+0vgnv2Y+ptmY0A+MEQX8W9vfj9
         EExXkjZTon+Wq8dgyJFCMRegLA/IGsn8abOUDs+a59VUK1hD8JyynESi1U9xNoe4hM0D
         oTu/8ZwgBL8sdUh1lDkODHuaQ8GPp+HARbtM7TkJcvxCDGJqVLfjkSlie2l9YDOhFpaI
         yXnGqc13/CdFWclRFp9dNkJnzBjce7wQ0gpELoHOnEwf5t4da0pdsfD9zq0NeHHtAgGk
         HGUw==
X-Gm-Message-State: AOAM533JABYt4+o6tGnsOcD6k5oDp1PlqsC7F0Gj1IlYk+qWiNSkro1q
        I8BIUHcXkVkNlLE1TmoH2XJ1R3MA2+i2hQfMRhhwgrxZAmhjKYhRyMSBPqLcj39O4t77kzO6D5s
        vBMMTGwELNasX5KPy90NK3fTt
X-Received: by 2002:adf:e40f:0:b0:20a:d221:b00c with SMTP id g15-20020adfe40f000000b0020ad221b00cmr8504136wrm.11.1650880155731;
        Mon, 25 Apr 2022 02:49:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkqXyEZhA+tMfcWcXkFaRjZ8uyIBBykE5B3d3nfqlK8Sdk4xdSLTeSK5orNTzGtexB97eLjA==
X-Received: by 2002:adf:e40f:0:b0:20a:d221:b00c with SMTP id g15-20020adfe40f000000b0020ad221b00cmr8504119wrm.11.1650880155484;
        Mon, 25 Apr 2022 02:49:15 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b00205aa05fa03sm8286883wrr.58.2022.04.25.02.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 02:49:15 -0700 (PDT)
Message-ID: <220929be-91c4-d19c-b04f-312c5f7e9e40@redhat.com>
Date:   Mon, 25 Apr 2022 11:49:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 0/5] Fix some race conditions that exists between fbmem
 and sysfb
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miaoqian Lin <linmq006@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yizhuo Zhai <yzhai003@ucr.edu>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20220420085303.100654-1-javierm@redhat.com>
 <535ebbe4-605c-daf5-1afb-f5225e4bb3a8@suse.de>
 <093d742f-4c87-2ff3-e9fe-153cd734f8e4@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <093d742f-4c87-2ff3-e9fe-153cd734f8e4@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

Thanks for the feedback. It was very useful.

On 4/25/22 11:15, Thomas Zimmermann wrote:
> Hi
> 
> Am 25.04.22 um 10:54 schrieb Thomas Zimmermann:
>> Hi
>>
>> Am 20.04.22 um 10:52 schrieb Javier Martinez Canillas:
>>> Hello,
>>>
>>> The patches in this series are mostly changes suggested by Daniel Vetter
>>> to fix some race conditions that exists between the fbdev core (fbmem)
>>> and sysfb with regard to device registration and removal.
>>>
>>> For example, it is currently possible for sysfb to register a platform
>>> device after a real DRM driver was registered and requested to remove the
>>> conflicting framebuffers.
>>>
>>> A symptom of this issue, was worked around with by commit fb561bf9abde
>>> ("fbdev: Prevent probing generic drivers if a FB is already registered")
>>> but that's really a hack and should be reverted.
>>
>> As I mentioned on IRC, I think this series should be merged for the 
>> reasons I give in the other comments.
>>

You meant that should *not* get merged, as we discussed over IRC.

>>>
>>> This series attempt to fix it more properly and revert the mentioned 
>>> hack.
>>> That will also unblock a pending patch to not make the num_registered_fb
>>> variable visible to drivers anymore, since that's internal to fbdev core.
>>
>> Here's as far as I understand the problem:
>>
>>   1) build DRM/fbdev and sysfb code into the kernel
>>   2) during boot, load the DRM/fbdev modules and have them acquire I/O 
>> ranges
>>   3) afterwards load sysfb and have it register platform devices for the 
>> generic framebuffers
>>   4) these devices now conflict with the already-registered DRM/fbdev 
>> devices
>>

That's correct, yes.

>> If that is the problem here, let's simply set a sysfb_disable flag in 
>> sysfb code when the first DRM/fbdev driver first loads. With the flag 
>> set, sysfb won't create any platform devices. We assume that there are 
>> now DRM/fbdev drivers for the framebuffers and sysfb won't be needed.
>>
>> We can set the flag internally from drm_aperture_detach_drivers() [1] 
>> and do_remove_conflicting_framebuffers() [2].
> 
> And further thinking about it, it would be better to set such a flag 
> after successfully registering a DRM/fbdev device.  So we know that 
> there's at least one working display in the system. We don't have to 
> rely on generic framebuffers after that.
>

Exactly, should be done when the device is registered rather than when
the driver is registered or a call is made to remove the conflicting FB.

I'll rework this series with only the bits for sysfb_disable() and drop
the rest. We can go back to the discussion of the remaining parts later
if that makes sense (I still think that patch 3/5 is a better approach,
but let's defer that for a different series).

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

