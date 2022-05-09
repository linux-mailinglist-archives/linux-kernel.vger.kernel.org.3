Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D69552043C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbiEISQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240034AbiEISP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 597134D617
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652119924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PDz7CXT91tsteQlydOBrXVm/Nk7FX3udXe6Lvda4gk0=;
        b=AyhvVZdSsLr4NuaYtkqT8YrfxkGUiP32KjGzyzHonlofTXElXIkr89uTKZ/Jpdbo82kVWQ
        +beoip5uypF0f2zRdycQ+V+kKI3+qbxwVMnqCq12iimAz0oLADl6X8J9KB9X6Z5qDi5PPs
        fyw79ULiTP4TpdBdm01bsAEOvlD6Jdo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-40oJqjlQNqOh-C7ADGasHQ-1; Mon, 09 May 2022 14:12:03 -0400
X-MC-Unique: 40oJqjlQNqOh-C7ADGasHQ-1
Received: by mail-ej1-f70.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso7168073ejc.18
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 11:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PDz7CXT91tsteQlydOBrXVm/Nk7FX3udXe6Lvda4gk0=;
        b=Z3OdE09jS3VfvStC7TN3ndfNFvGXlX7jcO/qXxKS9Zcnp+3TjX/RvYKnIrJ6bE9xGp
         qiD+gWuOO/yvDTAg+/h/x3MdHCcblh/GjogFqImo/XErfymsj7He45i199hAdwJQMJRQ
         G/GiXoVXQCmL0qYr3x0BGsE68M5kkRUb/WQOTGcwH2THwtV2L0Fip7h/VAfj0B2iHiHs
         v2ff9JlbuZal9w3h9Q4U6PpMjED7O1VwI5eleSP+FfOqGQ5h60FquVuR0EdpVjKJiqYm
         CziG4X+QdIauOBMRSsHOoKXhIWthqS92MFiIi5uujit+UY9RD7q+OkfKPKl/dW14Pevk
         PC6A==
X-Gm-Message-State: AOAM530lmfOqsGjWH6XYtgDbsouy4r648sGLzC+vgAL1c/bAkidMqRYd
        XyLFLyPKxd5nP1z0MPXUDmHCuq8yyv9Iw2JunkgtTUvaLyXzYxyMhTCl4f9QZHAPzUKtCRSNFNn
        Qi27eJcO8q319Hxspc5rZ1Mtc
X-Received: by 2002:a05:6402:4310:b0:427:f6e9:76b3 with SMTP id m16-20020a056402431000b00427f6e976b3mr18716531edc.324.1652119922160;
        Mon, 09 May 2022 11:12:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIhCnxEwAwh0UWoKYWIuKMyOPRZ6yYLPhg/iJNa7BitKx5xVaUTemiyrsOpCwXdv0OiUndPg==
X-Received: by 2002:a05:6402:4310:b0:427:f6e9:76b3 with SMTP id m16-20020a056402431000b00427f6e976b3mr18716516edc.324.1652119922018;
        Mon, 09 May 2022 11:12:02 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id p26-20020a056402045a00b0042617ba6388sm6586819edw.18.2022.05.09.11.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 11:12:01 -0700 (PDT)
Message-ID: <e8cfdd18-6c18-16c8-c4cc-89d50ba3ac92@redhat.com>
Date:   Mon, 9 May 2022 20:12:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 00/10] Introduce In Field Scan driver
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <13054c5c-ed48-b7a2-a800-25b9b1b1ab0d@redhat.com> <YnFK+gXFx0jQB1dz@zn.tnic>
 <b18234d7-a1f4-d5a4-e59b-f5439c38c2d0@redhat.com>
 <15cca88b82cd46a3a2a98b7cf336a6ed@intel.com>
 <4fda831b-c132-53cd-cd75-4f46b45219ac@redhat.com>
 <05b3c44c62a944f793b66b2e8e8c0cfe@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <05b3c44c62a944f793b66b2e8e8c0cfe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/9/22 19:05, Luck, Tony wrote:
>>> Do you still take patches after -rc6?
>>
>> If the patches are send soon (1-2 days) after rc6 I can still take them.
> 
> Hans,
> 
> V7 was posted Friday. It survived my weekend testing, and another round of tglx scrutiny (ending with
> his "Reviewed-by" on the latter parts of the series.
> 
> Let me know if there is anything else you need to get them applied.

From my side everything looks good. I plan to merge this
into my review-hans (*) branch coming Wednesday.

Regards,

Hans



*) And then from there move it to for-next once the build bots
have had a chance to play with it


