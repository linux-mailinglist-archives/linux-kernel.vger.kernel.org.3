Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C214EF6E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 17:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358313AbiDAPq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243425AbiDAPRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C56558395
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 08:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648825235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4C2FtsuZxf0/Q/b0iTYDkQBo4MdhWNl+MwxPx5dtPM=;
        b=VpAe2EIUSKbKVmhAHUO1Pk9jpYYqOBX6Gng1bdtta5u8CaZ5YqEKxst5J+FD7Xm4TKE4i/
        4UEEaUBqlOS64CunHafcQgd82wgvtsPdZqBmr+hbHmi7so1ulAOCmBIXkuhHU4loncxm72
        BSm7tBnI+CMEV2wguY+Z3I0zKoOAlig=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-LZo7cM_3MmekcMdomRJtuA-1; Fri, 01 Apr 2022 11:00:34 -0400
X-MC-Unique: LZo7cM_3MmekcMdomRJtuA-1
Received: by mail-ed1-f70.google.com with SMTP id o20-20020aa7dd54000000b00413bc19ad08so1696040edw.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 08:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U4C2FtsuZxf0/Q/b0iTYDkQBo4MdhWNl+MwxPx5dtPM=;
        b=DXhIbz3tREUjNe5H3Lecpes+p33Id860f9xqvmuJ0Fu7gbB1GAgl+lpJkMZ9Z4auu0
         /xSklKsMAeAXMJ0ENWhOIquL2hawdSPZebCfFiJK3399kG9aEWAcF4sqBL/teN945cVM
         VyGU017GoD1zPIY2C34DysDqeCMH1mEKT6XLNrBpxL4vHufCm7nCVHO8KyeE5ueNHzSp
         y49TIDAJQvayUHsNVdtAaz/wx/mjKZbPTn8+W7xqjvAY5IlfABJpc1r52WZsvH7+QArQ
         L+MgqYhFRg0vq51tlgdxZMI+OwW5P72nvstzPucyJiueHWid+9AsFtVfC0a+Py73ns0V
         Mvag==
X-Gm-Message-State: AOAM532ulZFm8Cus/gMOq+O9utChGRK5lV3ofxQtTJKSGlmKqIDoYU6G
        DI2bV1uMXN4RUh1NQ4/vaLpEEYIzyWlZKjHCtO4OPTij7Rx8ezc5bQVPOnS4HjY4B8Nnrlf9pMp
        DZnL1wu5tFWCm71hLX1VR0R4O
X-Received: by 2002:a05:6402:27d2:b0:419:1a3d:442b with SMTP id c18-20020a05640227d200b004191a3d442bmr20841613ede.409.1648825232183;
        Fri, 01 Apr 2022 08:00:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVAReUv2SvSmu/TQtO7iDA9+C4zYyJ+bufOOhAWSyh+evkJ1N0aCK5WKLJdbVvtRrCxIoc7A==
X-Received: by 2002:a05:6402:27d2:b0:419:1a3d:442b with SMTP id c18-20020a05640227d200b004191a3d442bmr20841583ede.409.1648825231922;
        Fri, 01 Apr 2022 08:00:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id gb29-20020a170907961d00b006e00c7b0f5asm1096476ejc.0.2022.04.01.08.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 08:00:31 -0700 (PDT)
Message-ID: <cf286eb6-aafc-49fb-f900-d3ef6fbcd48c@redhat.com>
Date:   Fri, 1 Apr 2022 17:00:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: mmotm 2022-03-30-13-01 uploaded (drivers/platform/x86/amd-pmc.o)
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mhocko@suse.cz" <mhocko@suse.cz>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <20220330200158.2F031C340EC@smtp.kernel.org>
 <5a0b94c3-406e-463e-d93e-d1dc2a260b47@infradead.org>
 <BL1PR12MB5157D16702C349C2620AEE97E2E19@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <BL1PR12MB5157D16702C349C2620AEE97E2E19@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On 3/31/22 20:41, Limonciello, Mario wrote:
> [AMD Official Use Only]
> 
>> -----Original Message-----
>> From: Randy Dunlap <rdunlap@infradead.org>
>> Sent: Thursday, March 31, 2022 10:51
>> To: Andrew Morton <akpm@linux-foundation.org>; broonie@kernel.org;
>> mhocko@suse.cz; sfr@canb.auug.org.au; linux-next@vger.kernel.org; linux-
>> fsdevel@vger.kernel.org; linux-mm@kvack.org; linux-
>> kernel@vger.kernel.org; mm-commits@vger.kernel.org; platform-driver-
>> x86@vger.kernel.org; Limonciello, Mario <Mario.Limonciello@amd.com>
>> Subject: Re: mmotm 2022-03-30-13-01 uploaded (drivers/platform/x86/amd-
>> pmc.o)
>>
>>
>>
>> On 3/30/22 13:01, Andrew Morton wrote:
>>> The mm-of-the-moment snapshot 2022-03-30-13-01 has been uploaded to
>>>
>>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fww
>> w.ozlabs.org%2F~akpm%2Fmmotm%2F&amp;data=04%7C01%7Cmario.limo
>> nciello%40amd.com%7Caa3aae02b7b6437c46ea08da132e4222%7C3dd8961fe
>> 4884e608e11a82d994e183d%7C0%7C0%7C637843386674652995%7CUnknown
>> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
>> WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=WpfXOyTRBgvqCj3iZ%2BJjXVTb
>> V%2FUWDP4ds5XtDfa5bPc%3D&amp;reserved=0
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fww
>> w.ozlabs.org%2F~akpm%2Fmmotm%2F&amp;data=04%7C01%7Cmario.limo
>> nciello%40amd.com%7Caa3aae02b7b6437c46ea08da132e4222%7C3dd8961fe
>> 4884e608e11a82d994e183d%7C0%7C0%7C637843386674652995%7CUnknown
>> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
>> WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=WpfXOyTRBgvqCj3iZ%2BJjXVTb
>> V%2FUWDP4ds5XtDfa5bPc%3D&amp;reserved=0
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>>
>>> You will need quilt to apply these patches to the latest Linus release (5.x
>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fozla
>> bs.org%2F~akpm%2Fmmotm%2Fseries&amp;data=04%7C01%7Cmario.limon
>> ciello%40amd.com%7Caa3aae02b7b6437c46ea08da132e4222%7C3dd8961fe4
>> 884e608e11a82d994e183d%7C0%7C0%7C637843386674652995%7CUnknown
>> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
>> WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=adnYHchdMvieQ0lCqQ1er1jhHA
>> UMomgFpaWBo%2BMnINk%3D&amp;reserved=0
>>>
>>
>> on x86_64:
>> when CONFIG_SUSPEND is not set:
>>
>> drivers/platform/x86/amd-pmc.o: in function `amd_pmc_remove':
>> amd-pmc.c:(.text+0x11d): undefined reference to
>> `acpi_unregister_lps0_dev'
>> ld: drivers/platform/x86/amd-pmc.o: in function `amd_pmc_probe':
>> amd-pmc.c:(.text+0x20be): undefined reference to `acpi_register_lps0_dev'
>>
>>
>>
>> --
>> ~Randy
> 
> AFAICT you're missing 20e1d6402a71dba7ad2b81f332a3c14c7d3b939b.

That is unlikely since the whole series got merged through
the pdx86/for-next branch, so either some other tree
has the whole series or none of it.

Also note that Randy wrote:

"when CONFIG_SUSPEND is not set"

The problem is that all of drivers/acpi/x86/s2idle.c is
wrapped by #ifdef CONFIG_SUSPEND ... #endif

Since AFAIK the whole amd-pmc driver's whole purpose
is to allow s2idle to work properly. I think this can
be fixed by simply doing:

--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -198,7 +198,7 @@ config ACER_WMI
 
 config AMD_PMC
 	tristate "AMD SoC PMC driver"
-	depends on ACPI && PCI && RTC_CLASS
+	depends on ACPI && SUSPEND && PCI && RTC_CLASS
 	help
 	  The driver provides support for AMD Power Management Controller
 	  primarily responsible for S2Idle transactions that are driven from


If you agree, please submit a patch with this change and I'll queue it
up in my fixes branch.

Regards,

Hans

