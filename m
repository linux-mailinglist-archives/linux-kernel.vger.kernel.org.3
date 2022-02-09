Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26534AF3E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiBIORM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiBIORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:17:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94DEAC0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 06:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644416231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRUhAeA84UjsLS4HbxlBt5EQCd/sdN8Mn9sTcjqUddo=;
        b=NIAaEpmof7H5RhU0lmHdzWZdwSXrpjrDkO98lcuA5Ev473FUYO1fj2jMkQG1c2n4UpZdoQ
        4QLsF86yM0PusKT/BbusN0wz6ODCWCJyrYLiEFgXVGXCVLhwKjulRtszRi8PuCiS0LO8J9
        YqYauhabXcmOcjhQX+LcURVCL5IUKwY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-tdE84yNwNu2WQQBHyumhZA-1; Wed, 09 Feb 2022 09:17:09 -0500
X-MC-Unique: tdE84yNwNu2WQQBHyumhZA-1
Received: by mail-wr1-f72.google.com with SMTP id h24-20020adfaa98000000b001e33eb81e71so1163423wrc.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 06:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KRUhAeA84UjsLS4HbxlBt5EQCd/sdN8Mn9sTcjqUddo=;
        b=IYvkbn4S8V3bCbKITjSZEk4vvi7xi54D6AulxTMo+bNhqx7dyOVg+mvoVydI4y1tx7
         +XlNluD1/EiaziOaDzZNlugpgeWdouErZA5r+HkvDTciS4nnqLqvVmE9SXYSq/KiiVSf
         8VqkEBc7arqcDdKO1qr5M1oERZzUDiY+JrclM9hZi/+Vwl+NhsrLpcC8alpVRdRfB69k
         s4iUcYt/u3Vu7p1k5+famx6LzHSzS+/rUlVol8DflYFUpWSnuEhgA08HbBV8GU0GcLVj
         olAEZpEaHr6Cv7shJQ5d+zbZ3mRkHqTIlXqdVpAxk0qQSQKe4CXaIYLD5Gg07wmfoKre
         X1oA==
X-Gm-Message-State: AOAM532Y1xEd6mg19gHTwsLcd6ucVkYbcuByGEnozdEPmoYF/flcdcAP
        nPROBw+OOKL0Rcs5SnagkkfQAwm8LZIV8tcuCGLe/E7wjfEp1dmzpfH6f8GmyDvsN55Vu1VRi8I
        0cTIQZYiaeOVFYTGiiyn4FXzD
X-Received: by 2002:a05:600c:4e16:: with SMTP id b22mr2290151wmq.8.1644416228503;
        Wed, 09 Feb 2022 06:17:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwIzQ5Y+IJIHsSpt0Pgn2iyoVM/suryQvdT8KlECfzPpYA1vTVAA9aQ4WkCb9TTM9E2pUG9Q==
X-Received: by 2002:a05:600c:4e16:: with SMTP id b22mr2290117wmq.8.1644416228230;
        Wed, 09 Feb 2022 06:17:08 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f13sm5562779wmq.29.2022.02.09.06.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 06:17:07 -0800 (PST)
Message-ID: <d1025530-90e1-fbc5-c06b-f62ed83f2f19@redhat.com>
Date:   Wed, 9 Feb 2022 15:17:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/7] drm: Add driver for Solomon SSD130X OLED displays
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-4-javierm@redhat.com>
 <YgPE8Z7HxU2wv7J/@sirena.org.uk>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgPE8Z7HxU2wv7J/@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

Thanks for your feedback.

On 2/9/22 14:43, Mark Brown wrote:
> On Wed, Feb 09, 2022 at 10:03:10AM +0100, Javier Martinez Canillas wrote:
> 
>> +	if (ssd130x->vbat_reg) {
>> +		ret = regulator_enable(ssd130x->vbat_reg);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to enable VBAT: %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
> 
> Unless the device supports power being physically omitted regulator
> usage should not be optional, it's just more code and a recipie for poor
> error handling.

The device has a VCC pin but in most cases this is just connected to a
power provided by the board in its pinout header. For example, I've it
connected to a rpi4 3.3v pin.

I guess in that case what we should do then is to just have a regulator
fixed as the vbat-supply in the Device Tree, that's regulator-always-on.

The old ssd1307fb fbdev driver also had this as optional and I wanted to
keep the new driver as backward compatible. But I understand now that is
not describing the hardware properly by making this regulator optional.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

