Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAED584618
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiG1SsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiG1SsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2938971BDE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659034084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2DJM3dywGojOdJzQwenMVghSwcw7CDj/ldG3SLSuEbw=;
        b=QowrBzP+76OolKdgV34ijZF7MBj5iZ3I5Cm3pokq1XYPBSQVYAetFDh0NbgS07YrfoArfW
        VnzMjW2vBEVzhMqF03ZzJ6NpVzIBadyE3JHeg09ftPNdq31A22gDzRfPW/Nak1G9RKA7gI
        8Ld9By7VEl5XATdszLAH5aFdUsjbR3o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-xd7l4yjGO-S_CXlB1vTHpg-1; Thu, 28 Jul 2022 14:48:02 -0400
X-MC-Unique: xd7l4yjGO-S_CXlB1vTHpg-1
Received: by mail-ej1-f70.google.com with SMTP id ne36-20020a1709077ba400b0072b64ce28aaso918988ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2DJM3dywGojOdJzQwenMVghSwcw7CDj/ldG3SLSuEbw=;
        b=p4knDs0/Vr24pIkxebpB6Dg1I3Lx7UgQXewn+GB1eyFFaBP/KaMNTHVeJGK1tscKc3
         y2wOHFzRaCo35tS5T77/IK1E6fWTP0+YwVIarF1sOB8z6Lr5gUuNSn+4xGpwvbeVKjoQ
         7DLWgGkcVMpTZvHxqYss5k61nMB+f9WSyFf9emRQJ5Puwx8RUQMK9fDz/mGseOTpraGE
         KJpJSde9Klhgz+eaqNgX4XGNIuEXN/MLwAdEo6GY9oWChXCfRPLb+8rBPf2z5wQdkv3L
         dHzFeSrHNdjbdvHdG87BABuw/gVxHZbboXjN6HMfOaTYjST6U5xB4nOZPAEBrm4CmLP+
         kFSA==
X-Gm-Message-State: AJIora+NnYt8e7BYwckEBBwUErQVElPUeChmpI08Oi12ED8bX1w7+ue5
        i75Zdr87DkkPr21gpFveRqBG0+dPGX43QKOl720Yi+ZppWgMoi4zNV4UeDj8mZtwLxMo6oCzfkR
        xu5WkRIOKT6CxW1ucE2nvvZ6y
X-Received: by 2002:a17:907:3e21:b0:72f:87c:efeb with SMTP id hp33-20020a1709073e2100b0072f087cefebmr214902ejc.528.1659034081600;
        Thu, 28 Jul 2022 11:48:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vAcJF0/ZzVFPQboJ+JLU58QC/RmPOy2zxuKOSX70XcNJXPfG51IrsnAW5B5zXNdTrQbF6e3g==
X-Received: by 2002:a17:907:3e21:b0:72f:87c:efeb with SMTP id hp33-20020a1709073e2100b0072f087cefebmr214882ejc.528.1659034081223;
        Thu, 28 Jul 2022 11:48:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id s21-20020aa7cb15000000b0043cfda1368fsm944844edt.82.2022.07.28.11.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 11:48:00 -0700 (PDT)
Message-ID: <26102aca-a730-ddf8-d024-2e7367696757@redhat.com>
Date:   Thu, 28 Jul 2022 20:48:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] platform/x86/intel/ifs: Allow non-default names for
 IFS image
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20220710160011.995800-1-jithu.joseph@intel.com>
 <YssFjbveghDLNn4N@kroah.com>
 <55368a65-c536-93c7-c501-9f6086e308d2@redhat.com>
 <YuJ8Ah37WAHGTJlV@kroah.com>
 <39b47ca8-1d25-0e60-d326-ad627541fe36@redhat.com>
 <YuKIL4QkC25h6RF8@kroah.com>
 <1ea8a38f-538c-43ed-c4dc-bc3722c03489@redhat.com>
 <SJ1PR11MB6083263E8EEBF106B6B61B24FC969@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <SJ1PR11MB6083263E8EEBF106B6B61B24FC969@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/28/22 17:12, Luck, Tony wrote:
>>>> Speculating myself as far as I understand IFS is not for factory
>>>> tests but for testing in the fields since big cloud vendors have
>>>> found that sometimes there are hard to catch CPU defects which
>>>> they only find out by running statistics which show that certain
>>>> tasks only crash when run on machine a, socket b, core c.
>>>
>>> Who knows, Intel doesn't say so we can't really guess :(
>>
>> Right, for version 3 the commit message and ABI documentation changes
>> really need to clarify why multiple test-pattern files may be needed
>> mucy better. If possible please also include 1 or 2 _clear_ examples
>> of cases where more then 1 test-pattern file may be used.
> 
> Sorry for the radio silence. We took Greg's suggestion to go back and
> thinks this out completely to heart. As he said, there is no rush to get
> this in. We need to do it right.

That (taking your time to get this right) is good to hear, thanks.

> Your summary above on how this works is completely correct.
> 
> The reason for adding more files is to cover more transistors in the
> core. The base file that we started with gets mumble-mumble percent
> of the transistors checked. Adding a few more files will increase that
> quite significantly.
> 
> So testing a system may look like:
> 
> 	for each scan file
> 	do
> 		load the scan file
> 		for each core
> 		do
> 			test the core with this set of tests
> 		done
> 	done
> 
> Our internal discussions on naming are following the same direction that
> you suggested, but likely even more restrictive. The "suffix" may just be
> a two-digit hex number (allowing for up to 256 files ... though for Sapphire
> Rapids we are looking at just 6).
> 
> So our current direction is to name six "parts" something like this:
> 
> 	06-8f-06-00.scan
> 	06-8f-06-01.scan
> 	06-8f-06-02.scan
> 	06-8f-06-03.scan
> 	06-8f-06-04.scan
> 	06-8f-06-05.scan
> 
> but we are still checking to make sure this will work for future CPUs. Once
> we have something solid we will come back to the mailing list.

Thanks, this sounds good to me.

> As also suggested in earlier thread we will change the name of the "reload"
> file (since skipping to a new file isn't a "reload"). The "load a scan file" will
> write the "part" number to this new file.

Regards,

Hans

