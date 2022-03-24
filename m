Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FE34E63D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346509AbiCXNDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350354AbiCXNCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 423C7A76D0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648126877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKpt0iAlHwpVNyFxsS8ClqeuI+QSAUafQjmj70sQjk0=;
        b=YsgQ5SWKZdamtcnlp4AwkoZ0Q08hIu1fIDAYRQaht1VQPtYtakzGxtEJcKjBs+Xx8M6a9y
        2mYu4AlbktUDUdxT0/WUEBCsleNckhAX5pBXTJ6b0/UpHhfvSYvfODoWTFyT64s49cyUTt
        9RAWpQOrQwI04MJwpeBLhitnBtpBw0k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-GcqFfLdvO5W2LS0zBv30KQ-1; Thu, 24 Mar 2022 09:01:16 -0400
X-MC-Unique: GcqFfLdvO5W2LS0zBv30KQ-1
Received: by mail-ed1-f69.google.com with SMTP id w15-20020a50c44f000000b00418f00014f8so2980267edf.18
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QKpt0iAlHwpVNyFxsS8ClqeuI+QSAUafQjmj70sQjk0=;
        b=Ik/5rIxipaERNaCNFIfMtMu1lUg6QRpsv9k7A2o815q9TbFfaEt5wi9W4I0nuT4GII
         824F0b2ObdymzmX73JxbamTvaE0od/856SlJvc2lNUnIlAQFNQ+OE9KV7H8zmiJ8v1Z3
         yhCWuiDJiRc4zXQj77aoL1nmC7WJ2xw9DoweGDRYxINx0bc1hLCdBRbMBloMgKL3mF25
         JcwX6Nq78OGCAWkTV5NeJ/zj+uJwFbrf/4Ye6uGCGwwMp6LBTzuZKkIXVrROoAx7TLiy
         W/o9blM8taH9r+XLQLPceOOyZBsWCDmrAVnX3u2AH3Banm0mevpFcCkJxTXQyR660Jcv
         uGuQ==
X-Gm-Message-State: AOAM532lIbTQPwXZOWP13OyIbz86VhaR8bFronJBuoFnVsYgJMNU2sWi
        1i7/WEp0TDfF871OdZ2Nvm47PdI7BAJaGFg1Qbx5ag7royD3iaWFh9+1aZFoynCgzDsrbsG1m3v
        Y0nsB+38LmZh+67EyxdoRWBpW
X-Received: by 2002:a17:906:478e:b0:6db:7c67:c7e0 with SMTP id cw14-20020a170906478e00b006db7c67c7e0mr5536431ejc.335.1648126874667;
        Thu, 24 Mar 2022 06:01:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5wlUIgcIRRrqV8EYMQN7jV34L0dzbP6Fs6iZjFKL3f63okml3Ykm+F1K6VOIx+V1qTiRDxg==
X-Received: by 2002:a17:906:478e:b0:6db:7c67:c7e0 with SMTP id cw14-20020a170906478e00b006db7c67c7e0mr5536401ejc.335.1648126874444;
        Thu, 24 Mar 2022 06:01:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id sd7-20020a1709076e0700b006e015549bdfsm1079786ejc.53.2022.03.24.06.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 06:01:14 -0700 (PDT)
Message-ID: <41973e94-c825-fa04-0dc8-cc1fe6b86d5c@redhat.com>
Date:   Thu, 24 Mar 2022 14:01:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: linux-next: build warnings after merge of the drivers-x86 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Gross <markgross@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20220301201659.45ac94cd@canb.auug.org.au>
 <20220324183329.22c97ea1@canb.auug.org.au>
 <2f33bdce-a002-708a-dd65-7bfb6ebc4cd9@redhat.com>
 <20220324222241.42896e9e@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220324222241.42896e9e@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 3/24/22 12:22, Stephen Rothwell wrote:
> Hi Hans,
> 
> On Thu, 24 Mar 2022 08:39:19 +0100 Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> I replied to your original report on March 1st, but I never got a reply
>> to my reply:
>>
>> """
>> Thank you for the report.
>>
>> So I just did:
>>
>> touch Documentation/ABI/testing/sysfs-driver-intel_sdsi
>> make htmldocs &> log
>>
>> In a repo with drivers-x86/for-next checked out and checked the generated log files.
>> But I'm not seeing these WARNINGs.
>>
>> Also 'find Documentation/output/ -name "*sdsi*"' does not output anything,
>> is there anything special (maybe some extra utilities?) which I need to also enable
>> building of htmldocs for the files in Documentation/ABI ?
>> """
>>
>> If someone can let me know how to reproduce these warnings I would be happy
>> to fix them.
> 
> Sorry about that.  I am just doing what you are doing but with the
> whole of linux-next (which I don't think would make a difference).  One
> possibility is that we are using different versions of the doco
> software.
> 
> I am using Sphinx version 4.3.2 (using Python 3).

[hans@shalem ~]$ rpm -qf /usr/bin/sphinx-apidoc
python3-sphinx-4.4.0-1.fc36.noarch

So I did some digging and the trick for reproducing any ABI
related warnings is to touch the .rst file which has the
"kernel-abi" reST directive (1) for the ABI subdir you want
to regenerate the ABI docs for




 this is
t
I doubt this makes a difference though. AFAIK the build process
for the files under Documentation/ABI is a bit different,
I think there is an extra pre-process step involved and maybe
I'm missing something needed for that step ?

Looking at Documentation/Makefile I did 

Regards,

Hans


