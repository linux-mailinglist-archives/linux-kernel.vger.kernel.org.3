Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43EC54D196
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345683AbiFOT2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347903AbiFOT2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB70153709
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655321319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4iNpZV57zc5+8qKldvmii2a0KVMkOhtMnZxn7FI/aI=;
        b=iI4LJW3hP+ViJxVdniQ2mev0BlNG8HP8b2aQfKp8AQI45aZ/hy0cshrKVUFmHuUNl5iyWl
        9BLsu7Ges8X90Nq0tZ3fJqeTuW1kahs3oqeDOs5X0ubYgimH9rs7DJ+84eA6nVWU/GnYmm
        OVuCTQafGaw5JlLPOkI7T0vpJDi8sx0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-teA61MmJPJmfXfWcOin0nA-1; Wed, 15 Jun 2022 15:28:38 -0400
X-MC-Unique: teA61MmJPJmfXfWcOin0nA-1
Received: by mail-ej1-f72.google.com with SMTP id hg21-20020a1709072cd500b00718cd4dcf6eso3446256ejc.19
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E4iNpZV57zc5+8qKldvmii2a0KVMkOhtMnZxn7FI/aI=;
        b=4y+5PTilKhxfHrKHkIA+O02cuwRjboKqz6kQlSF7v90ekZ4qghGVZAYyjN8pLG/ga5
         /hatF62yt29yv7bDA6210dz3+WK+Pofbb/YLw8ZQ689V13UvX4C7quVey3v7c9sZrY7o
         n15Vf70UTENbbOGm0a7l3IHnxE3d8SsxCTwdaWBMVi3YOxZ2Qjzlm5xjPU10884CFUW4
         5abFAsdk7QbHiRCfkJ9dk45k+Me6TwRIIL717m3qHDmOfSUE4MhA2JM3M1dACcXHuMK2
         mwjnwsN/iInC+KM7IoUuPBf0eiFR1VvemTbjW56LyFNvEhoiY6O4/hCSMYkpxHNMTN5C
         YyRQ==
X-Gm-Message-State: AJIora/1+r+99GTiDGS0ZOKfUg3tVwCrVx6EtVDAcB8MgExL3wn61jye
        vVjqv1DaJCHosyzFh8MZkJG7pjRtIs92E7XuM8VlRUIgSfyxu0F2BLWzH+Kx4zxTWHBeHcxtWGG
        GJe6F0x3oyPtYbU+8erbvok4d
X-Received: by 2002:a17:906:d8af:b0:715:744d:7e29 with SMTP id qc15-20020a170906d8af00b00715744d7e29mr1171671ejb.715.1655321317311;
        Wed, 15 Jun 2022 12:28:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u9eNwzg6ZDeFaOyUVQjIposxG0Zu9DD4wsVOVoKjZ9FcbTFHKA3qU9UWTNdpcbfsfZOJNNcQ==
X-Received: by 2002:a17:906:d8af:b0:715:744d:7e29 with SMTP id qc15-20020a170906d8af00b00715744d7e29mr1171652ejb.715.1655321317065;
        Wed, 15 Jun 2022 12:28:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id f7-20020a056402354700b0042bc5a536edsm28159edd.28.2022.06.15.12.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 12:28:36 -0700 (PDT)
Message-ID: <6969ca0e-4a4c-c995-02a2-6645f875338c@redhat.com>
Date:   Wed, 15 Jun 2022 21:28:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all
 hotkeys
Content-Language: en-US
To:     Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kenneth Chan <kenneth.t.chan@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Seyfried <seife+kernel@b1-systems.com>
References: <20200821181433.17653-8-kenneth.t.chan@gmail.com>
 <20220612090507.20648-1-stefan.seyfried@googlemail.com>
 <20220612090507.20648-3-stefan.seyfried@googlemail.com>
 <CAHp75Ve+vrfSu6pD+AKe-eCVA2pC5o520y4gVwLNg9Dtk0U5bw@mail.gmail.com>
 <CAHp75VdFPUHTeDBY5ukFgVqJJn7BbTHxrxKUGOLB6P1UX-utAg@mail.gmail.com>
 <d80789bc-a8fc-de5f-164a-75adf7097311@message-id.googlemail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <d80789bc-a8fc-de5f-164a-75adf7097311@message-id.googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 6/15/22 19:10, Stefan Seyfried wrote:
> Hi Andy,
> 
> On 15.06.22 13:24, Andy Shevchenko wrote:
>> On Wed, Jun 15, 2022 at 1:21 PM Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Sun, Jun 12, 2022 at 3:54 PM <stefan.seyfried@googlemail.com> wrote:
>>
>>> We usually add module options in very bad cases where it's very useful
>>> for debugging or when some devices require the opposite settings while
>>> can't be distinguished automatically. Here I do not see either of such
>>> cases. Hence, I would prefer to see a DMI based quirk as it's done a
>>> lot in the PDx86 drivers. Can you do that?
> 
> I can do that, but... below ;-)
> 
>> Looking into the code of the culprit patch, have you tried to add a
>> debug pr_info() and see what value is in the result? Perhaps you may
>> just sort out by correcting that.
> 
> The driver is working fine, it's just that Kenneth's machine is getting most of the hotkey events (I'd guess all but sleep, hibernate, battery) twice. That's why he disabled the key generation from the panasonic_acpi driver for them. (My guess is that on his CF-W5, they are also coming in via normal keyboard input path). My CF-51 does only generate them via acpi, so if they are not generated, I get nothing.
> Hence the module parameter so that the two known users of this module (Kenneth and me) can adjust this to their needs.
> 
> Now about the DMI match: I can do that.
> But let's face it: the panasonic laptops are pretty rare in the wild, so even if I'm "whitelisting" the CF-51, then probably other models will need the same treatment and we have no real way of finding out which ones, unless people complain. (For example my CF-51 is about 17 years old now and I just pulled it out and updated it to the latest and greatest "because I can". That's also why it has taken me so long to even notice the driver was broken for me. So people not complaining will not mean "nothing is broken" but rather "this code has not many users").
> So even if I add the DMI match (which is a good idea anyhow because then "my" model will work out of the box, while right now I need to add a module parameter or switch it on later), I'd still vote for having a possibility for overriding the DMI results.
> Would that be OK?

Actually I agree with your original assessment that Kenneth's patch
(ed83c9171829) which broke things on your laptop is wrong.

Back then I did not properly realize that it is effectively
disabling event generation for most of the reported event codes.

If anything there should be a DMI match for Kenneth's model and
reporting the events normally should be the default.

Kenneth, can you check with e.g. evemu-record or evtest
where the double events are coming from ?  Obviously one of
the events is coming from the panasonic-laptop driver, but
where is the other event coming from. Is it coming from the
atkbd driver; or ... ?   Maybe from the acpi-video driver
for the brightness keys ?

Regards,

Hans


