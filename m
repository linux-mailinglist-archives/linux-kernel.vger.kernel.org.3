Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DC85A9855
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiIANUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbiIANTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D364093
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662038252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dbU0ErSCeBzcqs0VQ9yr78KT5w2WG2r+58K65PvKptQ=;
        b=SmZ0mNBCdhdJ5C4A4eefTfWvROV2ESKzaw9sRo71lrdkiS7CFT5swtpSXbSvRXGKtzv45f
        f7Jd52dJHE6TFuXfXACO9KSEPtE7Ejc/HqZFiZnjdYbc3IRWW97PPEwnk8IR7h5Fy6xYsh
        bsklvI8mKNDgJo1CFiUiPowRNVdsBrQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-14-etL34ZKRMMGLBmJEl_h11g-1; Thu, 01 Sep 2022 09:17:31 -0400
X-MC-Unique: etL34ZKRMMGLBmJEl_h11g-1
Received: by mail-wm1-f71.google.com with SMTP id v3-20020a1cac03000000b003a7012c430dso1261400wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dbU0ErSCeBzcqs0VQ9yr78KT5w2WG2r+58K65PvKptQ=;
        b=sOIbcGJLc9BCgXHa9TpZKvnjUzoim9GBiLxkFC1UlR9b0KW6CwnxFOx6jzN70AHlVx
         zySSqOF1FYoYAh+MWgC5gXycR/l/uDRlhwgvj8Frg6Tp8RQxmRvwzlh8q86bftpEz25W
         jXu1JvwloGZ61iGtPlv9Ry5p7H2eagyYFmGqaS0GBdx9e+rH9k8TJyfxJ6b5CL3tgpnJ
         0yIsfU3PIzx1sQdCRiUJ5FO6OwITSsYLUwKa6iwQ99faM5rg+aJTPnNjb14v9wOUpEqt
         wjmnXy9+2QuaLaaeY8cXVEfBcJMbfoDXtNmC5Nn1IOtATk2xKnCbuqqjnbG40aPhEs5j
         jP0Q==
X-Gm-Message-State: ACgBeo0+27tp6ENwd+/NHSg03GGs2lEMC6n8abYES+dt3OoXaT5Q+YjL
        IrmQISN9j3h0OGcqGW4E873qnKmd3z4Ek01EirkIG3gmyWzFT8U+tt9EdOqjbmLehWfkEaf6Z6m
        QjiyWE/IHcnemEpI8iPhbkbb2
X-Received: by 2002:adf:eb10:0:b0:225:70d5:e994 with SMTP id s16-20020adfeb10000000b0022570d5e994mr14332336wrn.425.1662038248615;
        Thu, 01 Sep 2022 06:17:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7MFLzLBOV4HiscaGRSbKZajVvC/dHCpC9549jZEyDkd1lo6YzUYUmct/A+r7uLnmWiTNjnrA==
X-Received: by 2002:adf:eb10:0:b0:225:70d5:e994 with SMTP id s16-20020adfeb10000000b0022570d5e994mr14332322wrn.425.1662038248419;
        Thu, 01 Sep 2022 06:17:28 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z14-20020adfd0ce000000b002253fd19a6asm17374003wrh.18.2022.09.01.06.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 06:17:27 -0700 (PDT)
Message-ID: <087acab2-c230-fe5d-9ab3-2b8a18e42175@redhat.com>
Date:   Thu, 1 Sep 2022 15:17:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] drm/tests: Change "igt_" prefix to "test_drm_"
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
Cc:     michal.winiarski@intel.com, David Gow <davidgow@google.com>,
        siqueirajordao@riseup.net, magalilemes00@gmail.com,
        David Airlie <airlied@linux.ie>, tales.aparecida@gmail.com,
        Arthur Grillo <arthur.grillo@usp.br>,
        brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        mwen@igalia.com, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net
References: <20220901124210.591994-1-mairacanal@riseup.net>
 <20220901124210.591994-2-mairacanal@riseup.net>
 <20220901125530.b56s4zisnkfuigvc@houat>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220901125530.b56s4zisnkfuigvc@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 14:55, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Sep 01, 2022 at 09:42:10AM -0300, Maíra Canal wrote:
>> With the introduction of KUnit, IGT is no longer the only option to run
>> the DRM unit tests, as the tests can be run through kunit-tool or on
>> real hardware with CONFIG_KUNIT.
>>
>> Therefore, remove the "igt_" prefix from the tests and replace it with
>> the "test_drm_" prefix, making the tests' names independent from the tool
>> used.
>>
>> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
>>
>> ---
>> v1 -> v2: https://lore.kernel.org/dri-devel/20220830211603.191734-1-mairacanal@riseup.net/
>> - Change "drm_" prefix to "test_drm_", as "drm_" can be a bit confusing (Jani Nikula).
> 
> I appreciate it's a bit of a bikeshed but I disagree with this. The
> majority of the kunit tests already out there start with the framework
> name, including *all* the examples in the kunit doc. Plus, it's fairly
> obvious that it's a test, kunit is only about running tests in the first
> place.
>

Agree with Maxime on this.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

