Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8876F55A36D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiFXVSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiFXVSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1A704F46C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656105524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3ciFIS1tCZAKBLlEA3LLrsEdfv6a6xB/Mxc/YJONLM=;
        b=IXI349GI6u0DfARveOaCA+sYHIH3mkJ2n04UOBAoIyu7+hPqpRYgMCucMCQ72O6CeuCQcI
        9c3X67pNBNo5w5o8fMffqk3NBLUGT38yNlR16ubf5uHLI0HgOv4Bh4sHxaW6cCsFUWdCKl
        eXktH6QFqorD0nRAvFyUGE11CKylIj4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-VaNEPkeVPtmbHZ_UohYppg-1; Fri, 24 Jun 2022 17:18:43 -0400
X-MC-Unique: VaNEPkeVPtmbHZ_UohYppg-1
Received: by mail-wm1-f69.google.com with SMTP id bg6-20020a05600c3c8600b003a03d5d19e4so900875wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c3ciFIS1tCZAKBLlEA3LLrsEdfv6a6xB/Mxc/YJONLM=;
        b=Nk6Gd1wIxmj59kw/xxaVPKkpuSy2Sk9CKEGi2EIKtwvskYoJ1UBaI6EuVhIwkt1R4g
         LSUWevF4/gHQ4cx0LdwRDS2gC0osZfKkcJgl4XRe7bpzsoTTS7gocLfiaAKdlf+p3+rA
         DRiMvUbbLt848z0wPUBFur++Y4wdHZ20UtU+P7AXLiD0zaV9LeH2V3qbd9NLvj6nEeHN
         6R6DXlcYftCWHgKHHs1MX3krNWTBxp61Bb/45fOtT3Nur3k1vDrD4ggGAmzTermMpLNN
         sPvP3PEkqjAjBgjJtCDtXtvZRhgwYeQVGJWv25/2uzKgyMPGWt4cnmA7vkoDGt1hxbXT
         kzZg==
X-Gm-Message-State: AJIora+8IX9i6e+esMuRCU5N8tac4/FYR4tEZ5+dh5wAPHnyDNwz4bqy
        Vmogopze+FhuOLJjQODpkqnE6wCrl4a04ImwIYBaLgVnPjl3+iQtX6iC6PFLb67hC8Q6vKUzT8v
        xFdQ3Lz7nPNzfqbV/ySKxK3Ik
X-Received: by 2002:a05:600c:198f:b0:39c:8417:5daf with SMTP id t15-20020a05600c198f00b0039c84175dafmr6207778wmq.110.1656105522365;
        Fri, 24 Jun 2022 14:18:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vMlC5khdVqL0HumKEX5jn7jG3b+wyoISHiyI1POCQHuV+/axV4wKi0xGt4Y2ytkR+CNqyTFg==
X-Received: by 2002:a05:600c:198f:b0:39c:8417:5daf with SMTP id t15-20020a05600c198f00b0039c84175dafmr6207762wmq.110.1656105522117;
        Fri, 24 Jun 2022 14:18:42 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q11-20020adfea0b000000b0020fff0ea0a3sm3142713wrm.116.2022.06.24.14.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 14:18:41 -0700 (PDT)
Message-ID: <b16eba9c-30cc-c71f-ad95-eb5398f84af8@redhat.com>
Date:   Fri, 24 Jun 2022 23:18:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/3] drm/doc: Add KUnit documentation
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
References: <20220613171738.111013-1-jose.exposito89@gmail.com>
 <20220613171738.111013-4-jose.exposito89@gmail.com>
 <c50e5c87-3198-08b7-1e32-d0959af1f296@redhat.com>
 <YrYmR+aCdO3ldORB@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YrYmR+aCdO3ldORB@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

On 6/24/22 23:01, Daniel Vetter wrote:
> On Tue, Jun 14, 2022 at 02:58:29PM +0200, Javier Martinez Canillas wrote:
>> Hello José,
>>
>> On 6/13/22 19:17, José Expósito wrote:
>>
>> [snip]
>>
>>> +KUnit (Kernel unit testing framework) provides a common framework for unit tests
>>> +within the Linux kernel.
>>> +
>>
>> I think that it will be useful to have a reference to the KUnit kernel doc here,
>> something like the following:
>>
>> `KUnit <https://docs.kernel.org/dev-tools/kunit/index.html>`_ (Kernel Unit...
>>
>>> +This section covers the specifics for the DRM subsystem. For general information
>>> +about KUnit, please refer to Documentation/dev-tools/kunit/start.rst.
>>> +
>>> +How to run the tests?
>>> +~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +In order to facilitate running the test suite, a configuration file is present
>>> +in ``drivers/gpu/drm/kunit/.kunitconfig``. It can be used by ``kunit.py`` as
>>> +follows:
>>> +
>>> +.. code-block:: bash
>>> +
>>> +	$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/kunit \
>>> +		--kconfig_add CONFIG_VIRTIO_UML=y \
>>> +		--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
>>> +
>>> +.. note::
>>> +	The configuration included in ``.kunitconfig`` should be as generic as
>>> +	possible.
>>> +	``CONFIG_VIRTIO_UML`` and ``CONFIG_UML_PCI_OVER_VIRTIO`` are not
>>> +	included in it because they are only required for User Mode Linux.
>>> +
>>> +
>>
>> Maybe also add something like this ?
>>
>> For example, the following command can be used to run the test for x86_64:
>>
>> 	$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/kunit \
>> 		--arch=x86_64
>>
>> Regardless, the patch looks good to me:
>>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Hey so since you have a bunch of patches merged into drm already but seem
> to lack drm-misc commit rights to push these yourself I think it's time to
> get those:
> 
> https://drm.pages.freedesktop.org/maintainer-tools/commit-access.html#drm-misc
>
> And I guess Javier can help you with any questions you might have and make
> sure the request gets through by poking folks on #dri-devel irc?
>

Yes, he already requested commit access and got the acks, so I think is
just a matter of time until he has this sorted out.

José, please don't hesitate to ask if you need any help or clarification
once you have a setup to push your patches. The dim documentation [0] is
superb but I know that it can be somewhat stressful the first time :)

[0]: https://drm.pages.freedesktop.org/maintainer-tools/dim.html
 -- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

