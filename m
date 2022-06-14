Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BBB54B51C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343806AbiFNPth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344407AbiFNPt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B918C42ECC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655221766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H0LqbJsXhqPV5D+p7TkqXnodF2x40k1XJHNKS73Qf8s=;
        b=Hca6aUUqLrf+V3nXra6rBlxwPgyBgYta9SsleRH4rQZDEgw4LPDkMASPputH9eriFw+hvD
        vl4NAZwPZWMFrMgm8Z2mtTRUPVCdFTtW0P5d8tc5vhbbi4LsXeOjZu7YIh3GOiD2k0wZ8x
        K35oBAozEaRwrf3DuzVatsSIUyuZC6w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-tasogiT2NiK2Ub0xgkuXNQ-1; Tue, 14 Jun 2022 11:49:25 -0400
X-MC-Unique: tasogiT2NiK2Ub0xgkuXNQ-1
Received: by mail-ej1-f72.google.com with SMTP id t15-20020a1709066bcf00b0070dedeacb2cso3038483ejs.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H0LqbJsXhqPV5D+p7TkqXnodF2x40k1XJHNKS73Qf8s=;
        b=IhyXY4+zP7IboVeDIV4LU9huGVRbtaQLgegUtudzgG+pffYMjStDTze44kKYYs6YEU
         3/dNwTn00Ev9+EIpVeSW2nzOgyhsJDThbqaeUfravdI5Mhm/2JN6ekgiNcOYlkFU3GmX
         mJdvHKkI450ZqKaGuvK/qY1Ewh1vCG3YytodvwiygcWagRaw2GHOQF8pbZtxlxWFKew8
         g4+5fjTuZDTaP0sId/QSFGtHERLFGgX+ysBWjaphqs2W5AJ64I9xlSR2t1l2nkp4LlOW
         493b8sesFLgysMUkIYBD5NtAPDP3ZBjg7UC3/tWUBF5DyWP4DH0Kbp9o0vIXvMQYKzDP
         wZPQ==
X-Gm-Message-State: AOAM531+itfMDo6m7E5D9n5t/0NXoqnBJi4KVdwpgtjiS8STS6scik/q
        1EIDle1usHLCp9br1ynma3fiQ1BA6BTVlgDI/BZWqtZEpPV+VyB5Eg8JaeGqXorLSUp+FmGt4kc
        Gwu0xWCT1ZeuL7PMbiG9zCK9O
X-Received: by 2002:a17:907:7245:b0:711:d1ff:2ca4 with SMTP id ds5-20020a170907724500b00711d1ff2ca4mr4977410ejc.753.1655221763968;
        Tue, 14 Jun 2022 08:49:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vPyve1+0RUr74qY0pNAm4r3dLI3EHLVJQ2aR4cVSenNQC/56jmGFGGus4kQCdlAK0D9v8mXw==
X-Received: by 2002:a17:907:7245:b0:711:d1ff:2ca4 with SMTP id ds5-20020a170907724500b00711d1ff2ca4mr4977383ejc.753.1655221763715;
        Tue, 14 Jun 2022 08:49:23 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id d9-20020a1709063ec900b006feb6dee4absm5211929ejj.137.2022.06.14.08.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 08:49:23 -0700 (PDT)
Message-ID: <390cf16c-f07c-ebfc-08ad-25b242548953@redhat.com>
Date:   Tue, 14 Jun 2022 17:49:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/1] phy: ti: tusb1210: Don't check for write errors
 when powering on
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ferry Toth <ftoth@exalondelft.nl>
References: <20220613160848.82746-1-andriy.shevchenko@linux.intel.com>
 <bd21d5c6-ed5f-dd8c-f0bf-73f54ca8ee58@redhat.com>
 <YqiGocQ+vr9KjUHK@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YqiGocQ+vr9KjUHK@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/14/22 15:01, Andy Shevchenko wrote:
> On Tue, Jun 14, 2022 at 01:23:21PM +0200, Hans de Goede wrote:
>> On 6/13/22 18:08, Andy Shevchenko wrote:
>>> On some platforms, like Intel Merrifield, the writing values during power on
>>> may timeout:
>>>
>>>    tusb1210 dwc3.0.auto.ulpi: error -110 writing val 0x41 to reg 0x80
>>>    phy phy-dwc3.0.auto.ulpi.0: phy poweron failed --> -110
>>>    dwc3 dwc3.0.auto: error -ETIMEDOUT: failed to initialize core
>>>    dwc3: probe of dwc3.0.auto failed with error -110
>>>
>>> which effectively fails the probe of the USB controller.
>>> Drop the check as it was before the culprit commit (see Fixes tag).
>>>
>>> Fixes: 09a3512681b3 ("phy: ti: tusb1210: Improve ulpi_read()/_write() error checking")
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Copy and pasting my reply about this in another thread to keep everyone up2date:
> 
> Thanks! My replies below.
> 
>> """
>> In my experience with using the phy for charger-type detection on some
>> x86 android tablets which don't have any other way to do charger detection,
>> these errors indicate a real communication issue for reading/writing
>> phy registers. At the same time this usually does not seem to be a big
>> problem since the phy seems to work fine with its power-on defaults.
>>
>> In case of Bay Trail these errors were related to 2 things:
>>
>> 1. Autosuspend of the phy-interface block in the dwc3, fixed by:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7c93a903f33ff35aa0e6b5a8032eb9755b00826
>>
>> But dwc3_pci_mrfld_properties[] already sets "snps,dis_u2_susphy_quirk",
>> so I guess it is not this.
>>
>> 2. There being no delay in tusb1210_power_on() between toggling the
>> reset IO and then trying to communicate with the phy, fixed in:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df37c99815d9e0775e67276d70c93cbc25f31c70
>>
>> Maybe the:
>>
>> #define TUSB1210_RESET_TIME_MS				30
> 
> Actually it's 50.
> 
>> Added by that commit needs to be a bit bigger for the possibly
>> older phy revision used on the merifield boards?
>>
>> (note it is fine to just increase it a bit everywhere).
>> """
>>
>> IMHO it would be good to try and increase TUSB1210_RESET_TIME_MS (start with say 100
>> and then see if e.g. 50 also works). If increasing that does not work
> 
> No help
> 
> [   35.126397] tusb1210 dwc3.0.auto.ulpi: GPIO lookup for consumer reset
> [   35.126418] tusb1210 dwc3.0.auto.ulpi: using ACPI for GPIO lookup
> [   35.126455] tusb1210 dwc3.0.auto.ulpi: using lookup tables for GPIO lookup
> [   35.126465] tusb1210 dwc3.0.auto.ulpi: No GPIO consumer reset found
> [   35.126476] tusb1210 dwc3.0.auto.ulpi: GPIO lookup for consumer cs
> [   35.126485] tusb1210 dwc3.0.auto.ulpi: using ACPI for GPIO lookup
> [   35.126538] tusb1210 dwc3.0.auto.ulpi: using lookup tables for GPIO lookup
> [   35.126548] tusb1210 dwc3.0.auto.ulpi: No GPIO consumer cs found
> [   40.534107] tusb1210 dwc3.0.auto.ulpi: error -110 writing val 0x41 to reg 0x80
> 
> (I put 5000 ms there to be sure)
> 
>> I'm fine with going with this workaround patch to fix things.

Ok, so I guess we should just apply this workaround patch to make
the error non fatal. Still would be good to dig a little deeper one
of these days and see what is going on here...

Regards,

Hans

