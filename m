Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321E04C24AF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 08:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiBXHuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 02:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiBXHt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 02:49:58 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AD617CC61
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 23:49:28 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 794923F1BC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645688967;
        bh=tIIHXtnNxTvsUSqBUvFfmiqo64/DEPmMQ0dgIpM1aoU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=YpEXb4n41C0VFLtYmr1fnR1n54QsPYCran0ax0dJevvKreA5A0KGjmGuIA3F1afG+
         ekHHgz2A+VvYN251k13Qxe6TSqhG01sZGymFg8CrzPeRCCTe7KV11MX/i3np+WyExb
         5iODgpN+sYno+8AI2YYG9whPqJNJp4eNB3hKXg0W3pTQSrAa9rAyaF0JIFW/NWNT7d
         FJKZPUMp/Ts2DxQ+u1+12uk6cQBhScqrsp+ZaDPw2cyxJWiT0RH4HZka30ua0wygPq
         +xbrcBHL7lYkjlXPQz6xlfKd/2BwtVn8cp/1huOy1flRUYI5ULPF6e8zdZL0DC0yCI
         cOMbJalBVL4NA==
Received: by mail-ed1-f69.google.com with SMTP id n7-20020a05640205c700b0040b7be76147so358394edx.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 23:49:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tIIHXtnNxTvsUSqBUvFfmiqo64/DEPmMQ0dgIpM1aoU=;
        b=idWwlrr9HE1OlEYEFUa2VkRsT0zi50+cWUUkITYS2vb8yzVZki4AedYyu49/Ah1uTS
         KTbipOybZrg1u+VYTJqvvr/YGNoL5gsMol1mhJhj0DuzWVTB956BZBChT2eNHdKUNYps
         7CETKGNTyRK4o0400cmUveC+q7eu4rfMQGEZFxyldBZ8k01Rcw3/cjNHuE7OBhCSAR7Y
         Y35wipgA8V5zNH3KKk6L7iZpQ51v2WX7hcuPgvTZUJZm1x2Jtv0+BTHtqIPCXDbZC3tf
         rQxRWw3oiXYUtZdoqRX98O/K7ifBoomJHd44ZmCu6wXCjZjbjkIc5aPT3nJKH3OrDPgS
         yW0Q==
X-Gm-Message-State: AOAM5333ZOpqaMjOzawqJ+P5B/yzN2A76t4P03KKLlozsFWTPqwzlMdm
        IrRWjvJu9PJUJaDS15TqRvjUXFnoCp8TmZYvxf/KAQYzmyQvaBinrpBl/YHNjqpdDZYizGOzmoR
        WxCfmkjZclLt0R0C4zRxQgt2qp+4nnOZ8GObgnSAxhw==
X-Received: by 2002:a05:6402:177b:b0:413:2822:1705 with SMTP id da27-20020a056402177b00b0041328221705mr1116386edb.270.1645688957130;
        Wed, 23 Feb 2022 23:49:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZ4T6vTJDSRNBttoRjN0CBDIUiJLcd/AByD7b5Uhgs6BBbS824OeS6Yj6e4iHov1EozcksnA==
X-Received: by 2002:a05:6402:177b:b0:413:2822:1705 with SMTP id da27-20020a056402177b00b0041328221705mr1116367edb.270.1645688956871;
        Wed, 23 Feb 2022 23:49:16 -0800 (PST)
Received: from [192.168.0.127] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id s15sm954628ejm.70.2022.02.23.23.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 23:49:16 -0800 (PST)
Message-ID: <f7347531-8aa4-c011-d405-dea93e29779f@canonical.com>
Date:   Thu, 24 Feb 2022 08:49:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 05/11] pci: use helper for safer setting of
 driver_override
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20220223215115.GA155125@bhelgaas>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220223215115.GA155125@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2022 22:51, Bjorn Helgaas wrote:
> In subject, to match drivers/pci/ convention, do something like:
> 
>   PCI: Use driver_set_override() instead of open-coding
> 
> On Wed, Feb 23, 2022 at 08:13:04PM +0100, Krzysztof Kozlowski wrote:
>> Use a helper for seting driver_override to reduce amount of duplicated
>> code.
> 
> s/seting/setting/
> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  drivers/pci/pci-sysfs.c | 24 ++++--------------------
>>  1 file changed, 4 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index 602f0fb0b007..16a163d4623e 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -567,31 +567,15 @@ static ssize_t driver_override_store(struct device *dev,
>>  				     const char *buf, size_t count)
>>  {
>>  	struct pci_dev *pdev = to_pci_dev(dev);
>> -	char *driver_override, *old, *cp;
>> +	int ret;
>>  
>>  	/* We need to keep extra room for a newline */
>>  	if (count >= (PAGE_SIZE - 1))
>>  		return -EINVAL;
> 
> This check makes no sense in the new function.  Michael alluded to
> this as well.

I am not sure if I got your comment properly. You mean here:
1. Move this check to driver_set_override()?
2. Remove the check entirely?

> 
>> -	driver_override = kstrndup(buf, count, GFP_KERNEL);
>> -	if (!driver_override)
>> -		return -ENOMEM;
>> -
>> -	cp = strchr(driver_override, '\n');
>> -	if (cp)
>> -		*cp = '\0';
>> -
>> -	device_lock(dev);
>> -	old = pdev->driver_override;
>> -	if (strlen(driver_override)) {
>> -		pdev->driver_override = driver_override;
>> -	} else {
>> -		kfree(driver_override);
>> -		pdev->driver_override = NULL;
>> -	}
>> -	device_unlock(dev);
>> -
>> -	kfree(old);
>> +	ret = driver_set_override(dev, &pdev->driver_override, buf);
>> +	if (ret)
>> +		return ret;
>>  
>>  	return count;
>>  }
>> -- 
>> 2.32.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


Best regards,
Krzysztof
