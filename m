Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5B654B1CA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244529AbiFNM7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350563AbiFNM6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA6572E6A2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655211514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezBmONPgWBH1++OckHRx+3aB1t/HFHrFb9bdukl8H7M=;
        b=cTs3/o/bSLZekLLNo08T+mKxTZIKMqeks9xzaLthppUmpvtlMlgmRkILMbM86Ovq5FjVLC
        bnfJQkDWDtFlMtN3N6GctWSruSuyFbyNIHLKSF2vskF+ZLyZHHjH1qMobOSi8ri0k2dJOd
        vtvqIVISNFKWGYy5MFwkPELIockpbIo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-fv66oLgEMnGqPCTAFV7dAA-1; Tue, 14 Jun 2022 08:58:32 -0400
X-MC-Unique: fv66oLgEMnGqPCTAFV7dAA-1
Received: by mail-wm1-f70.google.com with SMTP id p42-20020a05600c1daa00b0039c62488f7eso7539982wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ezBmONPgWBH1++OckHRx+3aB1t/HFHrFb9bdukl8H7M=;
        b=uuG5X+oz36ccFl+QU14iyCRwnjkP/YrvgWFMeyNMQJfwg2FQn7zuRMBCnoRDE3f6Xe
         U1BiSuxjXF2QuihiNzrXakxVaiP6qyzOUuDYH40hAVbwKHa0W5ORekwqXa1qlOl+1sKM
         xvDY/4MPs51ql45FnaK20Jaav8MGfCDSJ3VgCv7RFCSUayU7NNlD+KqjpjyXH3IT2HRV
         4n1qTEOLDyy+sOf6+ZE9XXa7hZ0sq9PpHkGcY72k4zjt+ZflntcB0eBiR3Jq9ZmyZuRK
         mrm59BH9AqptkUH+3mgiMLVBpNX4jEVlF8qhRPrUsf0WeMV02IT8A7QoMttdZyiC1ctQ
         RRRg==
X-Gm-Message-State: AJIora9J44Zuvv+0vuieWeghWYhBzj0O0guQJ8Sxxv27fixgIM37kPi9
        03pWKy6RMNNDzInBhnJwGUfJlu7rs3g5nw7lE80ml6YkMDhCz0yQFqBvgwv6yXqboD+4XUVzoRD
        0kLpzQWuKlFd2f3dUkUqfA9mz
X-Received: by 2002:a5d:61c9:0:b0:213:b518:444c with SMTP id q9-20020a5d61c9000000b00213b518444cmr4684514wrv.509.1655211511556;
        Tue, 14 Jun 2022 05:58:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vAVyVUrWMmUPbTsdBaKIL+Sh7mNJHVQooy5Tzk0KSO/pkczKP/EKYcPXfuVbr1y1EZJoM7TA==
X-Received: by 2002:a5d:61c9:0:b0:213:b518:444c with SMTP id q9-20020a5d61c9000000b00213b518444cmr4684494wrv.509.1655211511350;
        Tue, 14 Jun 2022 05:58:31 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i18-20020a05600c2d9200b0039c235fb6a5sm12555666wmg.8.2022.06.14.05.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 05:58:31 -0700 (PDT)
Message-ID: <c50e5c87-3198-08b7-1e32-d0959af1f296@redhat.com>
Date:   Tue, 14 Jun 2022 14:58:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/3] drm/doc: Add KUnit documentation
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
References: <20220613171738.111013-1-jose.exposito89@gmail.com>
 <20220613171738.111013-4-jose.exposito89@gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220613171738.111013-4-jose.exposito89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello José,

On 6/13/22 19:17, José Expósito wrote:

[snip]

> +KUnit (Kernel unit testing framework) provides a common framework for unit tests
> +within the Linux kernel.
> +

I think that it will be useful to have a reference to the KUnit kernel doc here,
something like the following:

`KUnit <https://docs.kernel.org/dev-tools/kunit/index.html>`_ (Kernel Unit...

> +This section covers the specifics for the DRM subsystem. For general information
> +about KUnit, please refer to Documentation/dev-tools/kunit/start.rst.
> +
> +How to run the tests?
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +In order to facilitate running the test suite, a configuration file is present
> +in ``drivers/gpu/drm/kunit/.kunitconfig``. It can be used by ``kunit.py`` as
> +follows:
> +
> +.. code-block:: bash
> +
> +	$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/kunit \
> +		--kconfig_add CONFIG_VIRTIO_UML=y \
> +		--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
> +
> +.. note::
> +	The configuration included in ``.kunitconfig`` should be as generic as
> +	possible.
> +	``CONFIG_VIRTIO_UML`` and ``CONFIG_UML_PCI_OVER_VIRTIO`` are not
> +	included in it because they are only required for User Mode Linux.
> +
> +

Maybe also add something like this ?

For example, the following command can be used to run the test for x86_64:

	$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/kunit \
		--arch=x86_64

Regardless, the patch looks good to me:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

