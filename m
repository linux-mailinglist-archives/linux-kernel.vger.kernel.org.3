Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117244E63DB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350354AbiCXNGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbiCXNGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:06:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A16B1D309
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648127074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HxPrUhuzt19uTx9FtmZNdKy0YYbrN6xElRt7MFKc2u4=;
        b=Nqw3xoA3psjJiO2P18tnC+utADuQlBd+IYxD88Q4vValvgmZwoIpLgeZ4scqQTpcWyOG/w
        i7YGKZxhm0TFHRhxG42VgKsiNtUS677t7tUNdrG8QRVzIQ9K+X6zM0edfuKbHiIWI1wV5s
        y52yWf5gHwMreCHJPRWQhkurXS0+hk8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-TYDmLKfdO1embMwKYyN9uQ-1; Thu, 24 Mar 2022 09:04:31 -0400
X-MC-Unique: TYDmLKfdO1embMwKYyN9uQ-1
Received: by mail-ed1-f72.google.com with SMTP id v15-20020a50f08f000000b0041902200ab4so2968563edl.22
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=HxPrUhuzt19uTx9FtmZNdKy0YYbrN6xElRt7MFKc2u4=;
        b=g71En2oqttMiF3Ra3fsaslZ3S6wdAqN/y8XZfem5uvC1sxozwN7GUP1EIzhK6lY9jf
         1zmrV22f/0LeRauqoWupcuCnFPIzTEvYENJlDbbFX4SDyJ2Qh+5Yo3A3aWGJfGWCb5FO
         wvvGRlmDuKqVv6G4hKLMou2llS+DZs2NuP3OPI4ACyKRDiewQlUOFPot+Cv73pHqxHJo
         5Z24F/0fersJpvQEgPgFTpHSsapfKxhU8jO5meyHr6PgXmWyxPkgM4bB9HIUll0bBRjU
         BybK5lQo6yIlqsHTEtNCJ8/EyA6oWLsxMqwB3ERjHJG6m4iDRB42EzW8HywCnp+MbCIX
         kK6A==
X-Gm-Message-State: AOAM531qxs7mI81ps3y56YsyLCCbaIPtQCCNlivx+g8FVv4f7YBB92DU
        Zc/BG3dkfSCUcyNtLQDD8QWwCjD37bDtrtz3Ym28z0AyK4Je2LzauJecgLEclIkXw4m7K3zMgKs
        9PErRA73XAfXA0UVtiBID1bNE
X-Received: by 2002:a17:907:70cc:b0:6e0:1646:9123 with SMTP id yk12-20020a17090770cc00b006e016469123mr5537116ejb.329.1648127069877;
        Thu, 24 Mar 2022 06:04:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9mG1YV/Nxxur9iUPNhDYJQF2OMH9BNi3DfisIXyy0UXTE7U0Ir9X/t/kvNHmwS8S9IG4keg==
X-Received: by 2002:a17:907:70cc:b0:6e0:1646:9123 with SMTP id yk12-20020a17090770cc00b006e016469123mr5537098ejb.329.1648127069696;
        Thu, 24 Mar 2022 06:04:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b006cee1bceddasm1107911ejn.130.2022.03.24.06.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 06:04:29 -0700 (PDT)
Message-ID: <d1399c72-d729-58f8-ac63-1966f18c028d@redhat.com>
Date:   Thu, 24 Mar 2022 14:04:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: linux-next: build warnings after merge of the drivers-x86 tree
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
Content-Language: en-US
In-Reply-To: <20220324222241.42896e9e@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<fat fingered send, sending an incomplete email, this is attempt 2>

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

I doubt this makes a difference though.

So I did some digging and the trick for reproducing any ABI
related warnings is to touch the .rst file which has the
"kernel-abi" reST directive (1) for the ABI subdir you want
to regenerate the ABI docs for.

So in this case I did:

touch Documentation/admin-guide/abi-testing.rst
make htmldocs &> log

And now I can see the warnings. I'll prepare a fix for this.

Looking at Documentation/Makefile I also learned that you
can also do this:

scripts/get_abi.pl validate --dir Documentation/ABI

Which results in a different set of warnings...

Regards,

Hans


1) Implemented in Documentation/sphinx/kernel_abi.py

