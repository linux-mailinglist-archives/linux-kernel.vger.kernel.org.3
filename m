Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE4E4E716A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358927AbiCYKln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358919AbiCYKlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19829BD2F6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648204805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TrfAZ0qzao0ZEtbHRPfVRmwmNq2i/Jw+hPAR+QAaxzk=;
        b=TgNjEyZ3HJmCbLXSeg6CyVAsQW7ilrbzAcd1Fjw5YbtLY8Cz+OR35Bgj/xIMj3keGUbUVf
        tbMt/ziNu79j36ZunOKRnnMNqBrOfokBJwqsbbGg6xUpsRS5CMD2PEZviqGBIcu5gaCYoO
        3riE4xAJ9tm1xVGDvPDaMen3aF6QtNk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-JVCwtg9CNsOB5RYzjApq5w-1; Fri, 25 Mar 2022 06:40:04 -0400
X-MC-Unique: JVCwtg9CNsOB5RYzjApq5w-1
Received: by mail-ed1-f69.google.com with SMTP id b24-20020a50e798000000b0041631767675so4686554edn.23
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TrfAZ0qzao0ZEtbHRPfVRmwmNq2i/Jw+hPAR+QAaxzk=;
        b=ns/dEFgUaL1mkLzaXBCRhn5xeiDe5dQlJ74NcK7Y1/nY3Fr3zmgrxBOZONjaGdtowZ
         8Uk93U80fVcchWqjF0I736TT6bpEK65M3bmBmdG/6Qa9cU4IAq7GlEvG15sEXAkj1Fi5
         1c/CDGlkOcZCft295Dl3cPwelXSI8Hs0a3EFg13X3OJ5H4k38YCTFpTzQH6fHu4GJw+y
         1RO/AZ765Joq4nDIfoLRVBG8vxhInHqfp8ON7RMelJAl+/+yh3D6v0WfUI6wgamLNCXa
         ponH+/yHmW+U0UuC4sTN5bkDhnUWZZ2b881KbLaQrgaik6KegMq1IeStke5WAyA3L3tK
         0aog==
X-Gm-Message-State: AOAM533QiuP0yWVvWtuGKNgNdebYjXAqqhdJt2Mp94twTZrZZhx9ri1N
        nnqEEprzmRth2tZlT22UZDRhztsPfReKo76gNg1gkFlJgYVpPtwie3qSaOwoVdAPpV8ghLbNIJ+
        UNKJqQtTtLu29gBRMA5CPmEJK
X-Received: by 2002:a17:907:d2a:b0:6e0:963c:97d9 with SMTP id gn42-20020a1709070d2a00b006e0963c97d9mr4574201ejc.736.1648204802911;
        Fri, 25 Mar 2022 03:40:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMnCBBkEIFXU/Xo8yMmB+B0JwunTv09fo/5qHHm1J86glb+mcfRbtW0qcUumoVXxb2Wbrxzg==
X-Received: by 2002:a17:907:d2a:b0:6e0:963c:97d9 with SMTP id gn42-20020a1709070d2a00b006e0963c97d9mr4574177ejc.736.1648204802679;
        Fri, 25 Mar 2022 03:40:02 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id d7-20020a50cd47000000b004187eacb4d6sm2717357edj.37.2022.03.25.03.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 03:40:02 -0700 (PDT)
Message-ID: <5bbb34bc-0dbe-05b0-ea56-c37fca0db814@redhat.com>
Date:   Fri, 25 Mar 2022 11:40:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/4] Documentation/ABI: sysfs-class-power: Fix Sphinx
 error
Content-Language: en-US
To:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220324164737.21765-1-hdegoede@redhat.com>
 <20220324164737.21765-5-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220324164737.21765-5-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/24/22 17:47, Hans de Goede wrote:
> Fix the following error from "make htmldocs":
> 
> Documentation/ABI/testing/sysfs-class-power:459: ERROR:
> No bottom table border found.
> 
> ================ ====================================
> auto:            Charge normally, respect thresholds
> inhibit-charge:  Do not charge while AC is attached
> force-discharge: Force discharge while AC is attached
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index fde21d900420..859501366777 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -468,6 +468,7 @@ Description:
>  			auto:            Charge normally, respect thresholds
>  			inhibit-charge:  Do not charge while AC is attached
>  			force-discharge: Force discharge while AC is attached
> +			================ ====================================
>  
>  What:		/sys/class/power_supply/<supply_name>/technology
>  Date:		May 2007


I see a similar change has already landed in linux-power-supply/for-next, so
I'll drop this patch from the set.

Regards,

Hans

