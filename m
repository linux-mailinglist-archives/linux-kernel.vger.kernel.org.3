Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF794CC470
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiCCR5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiCCR5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:57:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 001441405C6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646330192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pt2NEyN77WvQVDGkaIF/Nqcc+6j6rTEVnHq5++rUv8c=;
        b=LhSZwx9iahYcAre7GSsJuHJgirNF2cDLo31kjmjVYEnEwr2aVx6O1CXlOOkKqwY/Ylq/Nn
        9dRsaOySgRo715xurguPPp+3TvW0ZG4tzgzNB86Ot3vMhPRQZ7cN3Ufs4dWl/0+Vz55nn/
        en6YknoKsjTvuVVJFmzaGz9ymuN6g7c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-MsJQHMtHPVumj4VNRIi2gQ-1; Thu, 03 Mar 2022 12:56:29 -0500
X-MC-Unique: MsJQHMtHPVumj4VNRIi2gQ-1
Received: by mail-ej1-f70.google.com with SMTP id sa7-20020a170906eda700b006d1b130d65bso3116886ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 09:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Pt2NEyN77WvQVDGkaIF/Nqcc+6j6rTEVnHq5++rUv8c=;
        b=AmSXFHy3sYnBw7SErg/+IvewCJTjLL9PeUbRd1myiMMi79wPThCom/87BmlUKMfRKP
         ViSq8kqRm/r+8HOu0b/TNf0h4KDdbtQ3p1IW/3TcTV82SEF5ir+SVSWH8raBEyL1/xzr
         Ycgz7Mmf04wp1l4k+p67fonck5FfRZAvKCS27XrfrwFXwITfC9aa8XHM3BfpnBZh48pT
         uBfFaoEq7RBvQasWkUY1zh/r51arbdbFG0kA/PKn2keycKsJfFuRnGs7wl/4p4Q/Q68t
         gRmNikk5aRJ0I4dDhBy3TciHTrXGyvZMRVBiHEejLB2hCXS8/O/XaPSuwX6GilE15fkM
         FKkw==
X-Gm-Message-State: AOAM5321gWnMDJH80c8cIH5zyzFA8YI4Ppnapcrg+Ob0BjCof/9KPYk4
        Vsa6r2Vju2eNMv+ZdBIIWCOH10dekPwFufNIsPyc1d+JCAUd2TTfeT9szzamH5/LSnv3qZtI6Vx
        aMwpsvmkMAWvdJFgc7s4/cciY
X-Received: by 2002:a05:6402:4414:b0:408:4dc0:3ee9 with SMTP id y20-20020a056402441400b004084dc03ee9mr35543559eda.203.1646330187927;
        Thu, 03 Mar 2022 09:56:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPRtKLOiKu9tA7Gy98mghBFK0zV7El+3s6ksl1od7pWlMdP3fg7CriUUTbr2yPPhb7rsU+gg==
X-Received: by 2002:a05:6402:4414:b0:408:4dc0:3ee9 with SMTP id y20-20020a056402441400b004084dc03ee9mr35543539eda.203.1646330187754;
        Thu, 03 Mar 2022 09:56:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id lk10-20020a170906cb0a00b006da92317793sm825104ejb.131.2022.03.03.09.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 09:56:27 -0800 (PST)
Message-ID: <535336dc-8c54-7c3a-ecf6-b2920ea99297@redhat.com>
Date:   Thu, 3 Mar 2022 18:56:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] ACPI / x86: Work around broken XSDT on Advantech
 DAC-BJ01 board
Content-Language: en-US
To:     Mark Cilissen <mark@yotsuba.nl>
Cc:     linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kernel test robot <lkp@intel.com>
References: <20220302040800.10355-1-mark@yotsuba.nl>
 <832a5b2e-d70c-f1a6-e377-7697b1eb7049@redhat.com>
 <7BD8A71A-95C7-4A10-82FD-BEAAE0B0DDE9@yotsuba.nl>
 <43b0c275-e728-492b-c6a7-d054fae72117@redhat.com>
 <4BBB58DC-653C-4373-A5F5-9239C86C8AE8@yotsuba.nl>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <4BBB58DC-653C-4373-A5F5-9239C86C8AE8@yotsuba.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/3/22 14:42, Mark Cilissen wrote:
> 
>> On 3 Mar 4 Reiwa, at 14:38, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Mark,
> 
> Hi Hans,
> 
>> On 3/2/22 21:20, Mark Cilissen wrote:
>>>>
>>
>> I think that there are a lot more boards that will have
>> DMI_BIOS_VENDOR == "Phoenix Technologies LTD"
>> then that there are boards that will have
>> DMI_PRODUCT_NAME == "Bearlake CRB Board"
>>
>> So if you want to make the DMI match as specific as possible then
>> IMHO dropping the bios-vendor match is best.
> 
> Of course, but just to clarify -- my proposal above is to drop
> 
>> DMI_MATCH(DMI_SYS_VENDOR, "NEC”),
> 
> not
> 
>> DMI_MATCH(DMI_PRODUCT_NAME, "Bearlake CRB Board”),
> 
> . :-)

Ah I see, I did indeed misunderstand that. Still NEC is not that
often seen as sys-vendor, so I still believe dropping the bios-vendor
match is best.

Regards,

Hans

