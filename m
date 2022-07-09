Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA49756CA38
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiGIO4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGIO4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A3341ADA9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 07:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657378579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lhe0MLtyoBkpahosVrejSAhtzTQ5suZXiUqbUoZC8Os=;
        b=Lz3hQ/S9xIlmgsaebXA+WEdABHXJyII6Eu5ZbmUxU+/N+6vZxr+WvZo90Z8/wspBmhkSVQ
        1xoqkEK+N2mYOQ/VPqYlqDl7at/gnQLNytF11bszp9/GKZKL969RYrISQW27ltVwUCul/x
        NpRLhAKHXFQQgXuUIGRbHhd49/ost/A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-BXX2KEWYMyy2zupELh5JbQ-1; Sat, 09 Jul 2022 10:56:17 -0400
X-MC-Unique: BXX2KEWYMyy2zupELh5JbQ-1
Received: by mail-ed1-f72.google.com with SMTP id m13-20020a056402430d00b0043ac2f27d83so746229edc.20
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 07:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lhe0MLtyoBkpahosVrejSAhtzTQ5suZXiUqbUoZC8Os=;
        b=2UaOfB1b4UmIKO46iJjieZyBA+AC8e1OEUWonbGD0lp7l55r7ujFw2XoiVW6U/kkaR
         jMfpahVBjAdT74bquCjt6pkIP7RvPvtntuHAihSKoPC+3JOkq3Jl7F6gtvM1zRDS14FI
         dTAOyZw/apXq7YEZ8jKeXV10B4JcfYU9EuCOa/pyddiJ+OL49R/k1LtxeZjTIhlgswoQ
         CDof/vyv0WZsg1JMqWp6SYUJO9D9dzbbeRS82ScZJcWP2mSSOomx8Vt3U3ipBbSnQX9B
         JgIeHFqoT6i6bB9nt7Jt2dPSYhg9ZuTC6QiQrxF/Z7y3GEorLw52ttY4x/PBQxdd7kj5
         Y9Dg==
X-Gm-Message-State: AJIora98M/J1eQJ3Bc8iilxy6K7wfCjS06mjdqzcwCLXSAeJ/+Fd/7Fq
        hjb3GsM9A0T4EkpcVjLOWGCHMkfIW3XIRF/qQeLvC3gnSLTwQEZFxIfessmXjx5itmKgrXEAeF9
        Bf38euJ7UN0gzHBqqfYmzCedd
X-Received: by 2002:a17:907:7ba8:b0:72b:1491:c73c with SMTP id ne40-20020a1709077ba800b0072b1491c73cmr8995981ejc.415.1657378576733;
        Sat, 09 Jul 2022 07:56:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tk8xtQIGFQOcmJKQJrfW5RgVDZYVRGPl9aPcP2hAw6MPO4bXHTwfaYbxpxXXpa5cElXNVuzQ==
X-Received: by 2002:a17:907:7ba8:b0:72b:1491:c73c with SMTP id ne40-20020a1709077ba800b0072b1491c73cmr8995961ejc.415.1657378576545;
        Sat, 09 Jul 2022 07:56:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ch15-20020a0564021bcf00b0043a71c376a2sm1087446edb.33.2022.07.09.07.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jul 2022 07:56:16 -0700 (PDT)
Message-ID: <8b893c42-e514-bcef-0513-070b3723cdcc@redhat.com>
Date:   Sat, 9 Jul 2022 16:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: input/i8042: Malfunctioning brightness keys on HP Elite Dragonfly
 G2
Content-Language: en-US
To:     Alex Dewar <alex.dewar@gmx.co.uk>, dmitry.torokhov@gmail.com,
        tiwai@suse.de, markgross@kernel.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220629094314.b7xmfb3xccj7vs6v@ic-alex-elitebook>
 <3fedf676645bfa638c9a6c656121083abc2c98ea.camel@gmx.co.uk>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3fedf676645bfa638c9a6c656121083abc2c98ea.camel@gmx.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/5/22 19:25, Alex Dewar wrote:
> Friendly ping? 🙂
> 
> I'm also CC'ing the x86 platform people into this, as I'm not sure
> whether this problem is something more within their remit.

Please test the atbkd device with "sudo evemu-record" or "sudo evtest"
and if the brightness keys generate events there, write down the
raw event codes (MSC events).

Assuming the brightness keys indeed send events here, then:

After that you need to create an update to:
/lib/udev/hwdb.d/60-keyboard.hwdb to fix the mapping for your laptop.
See the "To update this file, create a new file ..." section.

You can find the DMI match pattern used in this file by doing:

cat /sys/class/dmi/id/modalias

Once you have things working, please submit a pull-req to upstream
systemd to get these quirk included in the offical hwdb. Or send
me a copy of the local 70-keyboard.hwdb override you have created
and I can submit it upstream for you.

Regards,

Hans



> 
> Best,
> Alex
> 
> On Wed, 2022-06-29 at 10:43 +0100, Alex Dewar wrote:
>> Hi,
>>
>> I'm running Linux 5.18.7 on an HP Elite Dragonfly G2 laptop, which
>> seems
>> to use the i8042 driver. Mostly things seem to work (including
>> hotkeys)
>> except that the increase/decrease brightness keys instead send the
>> "mic
>> mute" keycode. (The *actual* mic mute key works fine.)
>>
>> Any ideas? Do we need to add a quirk?
>>
>> Best,
>> Alex
> 

