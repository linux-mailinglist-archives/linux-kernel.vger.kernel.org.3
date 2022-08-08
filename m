Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02AC58C55E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242272AbiHHJQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbiHHJQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0FE412761
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659950184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uvs1zjGn2V6SDoroOchmiGtU4O2139IfzZNve5l/N8=;
        b=L/ZEN2a628NlyhcvuoXX2QtspX2qU7+WyIO9TPXfZTOTADX3Ydln/kPHfhm1puDEStUa0i
        qkm/H3cSVscpQAtFXMx6XZ1vCxPE4lyjUWlYFiTcVC0uGxSTvibc9lwdXhFkrSxfm2FiDt
        bGBzb8p7NW2CPJWXtWrMaX1eX+zu+Dw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-AGXpx_AJNQqI1n-DQtT2eA-1; Mon, 08 Aug 2022 05:16:23 -0400
X-MC-Unique: AGXpx_AJNQqI1n-DQtT2eA-1
Received: by mail-ed1-f70.google.com with SMTP id r12-20020a05640251cc00b00440647ec649so2913431edd.21
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 02:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3uvs1zjGn2V6SDoroOchmiGtU4O2139IfzZNve5l/N8=;
        b=MediLvtTNywYxJBjvZxAKOSVeB57d8yPJz3baOZ+CF+2RakSfVcaSo1/NzgGh4I2E5
         yYTo5aG61+eYV25qFvja5ZgqEu0yvX2beDa1kUaL//tcuOpJZFb2iHqHsULmt+lU2VAs
         PfJ4oxL+mQvSzZML/mcI2a/HwVAppQpuG8GmyalORlK49+aODa2H/XEn/Uh8y5/HZA+k
         H1XLpOhIkpmzAVSrbOASNSsAOHM1Q8jr/tSy7lgMGjVHMekST4Ws+Os9QwRXmetSRzVr
         AddFOQS0FSPDa85SDw8yo3wx5ewre4CWJkA8RpUULiA0/K5mB1c/Iv29DvolyJSU2hI2
         P0Ow==
X-Gm-Message-State: ACgBeo2zBYETynoens50ts/vAfJ/tHiVz6POsV4l19RC0xetSTVMN4fk
        KngjxqIVN/siP1v+VD2eYQjqlNFR7FZZfOQmYLFpdJOXMEWB8G8UKpE9OZt5kcIMTt8hdjI611h
        9ISF9glNUpHVOe3KqojhizF4w
X-Received: by 2002:a05:6402:177b:b0:43d:64c5:7799 with SMTP id da27-20020a056402177b00b0043d64c57799mr17720432edb.180.1659950182243;
        Mon, 08 Aug 2022 02:16:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5fIZpmxV+eYK+x6+8G2X0o5mUIXjSHCVj1gxNvIDV+Uu1vn9esy7bZd2WwFZjZALaWhL0d9Q==
X-Received: by 2002:a05:6402:177b:b0:43d:64c5:7799 with SMTP id da27-20020a056402177b00b0043d64c57799mr17720421edb.180.1659950182078;
        Mon, 08 Aug 2022 02:16:22 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id gk23-20020a17090790d700b00730560156b0sm4752531ejb.50.2022.08.08.02.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 02:16:21 -0700 (PDT)
Message-ID: <7507e07a-5094-f129-b75a-69cc32147543@redhat.com>
Date:   Mon, 8 Aug 2022 11:16:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] HID: HID-rmi - ignore to rmi_hid_read_block after system
 resumes.
Content-Language: en-US
To:     margeyang <marge.yang@synaptics.corp-partner.google.com>,
        dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
Cc:     marge.yang@tw.synaptics.com, derek.cheng@tw.synaptcs.com,
        vincent.huang@tw.synaptics.com
References: <1659949639-3127-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1659949639-3127-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/8/22 11:07, margeyang wrote:
> From: Marge Yang <marge.yang@synaptics.corp-partner.google.com>
> 
> The interrupt GPIO will be pulled down once
> after RMI driver reads this command(Report ID:0x0A).
> It will cause "Dark resume test fail" for chromebook device.
> Hence, TP driver will ignore rmi_hid_read_block function once
> after system resumes.

This sounds like it is an issue in one specific touchpad model,
yet you are changing the code to ignore the first readblock call
on resume on *all* models ?

Regards,

Hans


> 
> Signed-off-by: Marge Yang<marge.yang@synaptics.corp-partner.google.com>
> ---
>  drivers/hid/hid-rmi.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 311eee599ce9..236a38bfcf9a 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -101,7 +101,7 @@ struct rmi_data {
>  };
>  
>  #define RMI_PAGE(addr) (((addr) >> 8) & 0xff)
> -
> +int ignoreonce;
>  static int rmi_write_report(struct hid_device *hdev, u8 *report, int len);
>  
>  /**
> @@ -203,7 +203,13 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
>  		if (ret < 0)
>  			goto exit;
>  	}
> -
> +	if (ignoreonce == 1) {
> +		dev_err(&hdev->dev,
> +			"ignoreonce (%d)\n",
> +			ignoreonce);
> +		ignoreonce = 0;
> +		goto exit;
> +	}
>  	for (retries = 5; retries > 0; retries--) {
>  		data->writeReport[0] = RMI_READ_ADDR_REPORT_ID;
>  		data->writeReport[1] = 0; /* old 1 byte read count */
> @@ -468,8 +474,12 @@ static int rmi_post_resume(struct hid_device *hdev)
>  	ret = hid_hw_open(hdev);
>  	if (ret)
>  		return ret;
> -
> +	// Avoid to read rmi_hid_read_block once after system resumes.
> +	// The interrupt will be pulled down
> +	// after RMI Read command(Report ID:0x0A).
> +	ignoreonce = 1;
>  	ret = rmi_reset_attn_mode(hdev);
> +	ignoreonce = 0;
>  	if (ret)
>  		goto out;
>  

