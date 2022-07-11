Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8EA570114
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiGKLsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiGKLrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8175725E0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657540029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5y2xr3Vx8OQwRCbGVz5PkIj/TcERMyOp8kvktoro/qE=;
        b=ORsUPNg6yC6wHVM2eSE0yYaF6I3i7oAKao4Yzeht6CVXcJcfqRzfChx5u19whG/kZUFYd3
        mIgizuuYcg5I8UGyFFNjgLu4EBjpNCAwdvBgdOBp293z8EkN2P0W16v8RdCvhx8UjFfb7O
        WGq64Ks52rbWeJ+KV2hcOhJ7KfbbLZo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-UCL3icIFNJud8zlFgv-zZw-1; Mon, 11 Jul 2022 07:47:08 -0400
X-MC-Unique: UCL3icIFNJud8zlFgv-zZw-1
Received: by mail-ed1-f70.google.com with SMTP id o13-20020a056402438d00b0043aa846b2d2so3966135edc.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5y2xr3Vx8OQwRCbGVz5PkIj/TcERMyOp8kvktoro/qE=;
        b=7mWfTYsHvRkvRDNKF59gyzuLZxzcYtUivZbQoQ/G1MDvY2DGUHqgYfzIDsyjskE8jh
         gZ6C6hpvIPwDaB8n5yHadKWSb4XIJokhLLlg+kktqLe+E8RjtKbYnkA1TwhMb1g45HPB
         4dESMfYBYRGHt1pIUS+LDpHwvbfKAKgj7Hrm8b4WK9ud0E++ID5EbPWh7ir/aaxAOlD8
         QPp2lxuFEig/+3WEK+BetHsnK/O7+8rg8eX84YASiqU5K9GXNlWcLrTUK7OaTUzIPoB0
         7/GHi7WJCFjv0KsigZOEN/gFg2i6YfWKr+l+MBy8BihQQRuvF7T54HGK09+zrXESJm1G
         S+pQ==
X-Gm-Message-State: AJIora/FhzTF7sbK/jDAM/KFfyps1DGySqR+GtgWU5SGyc9pw6493bXb
        EuU//mwEliTmrjU1EGNgsuWoo0ngO4weSmFbp6dxfgNXfm1qIlwbBvwSEH0vhfo4vz+AVZVtvmU
        uwkLwfMH3h4eN7P7gHMrOOTCm
X-Received: by 2002:a17:907:168c:b0:726:c521:25aa with SMTP id hc12-20020a170907168c00b00726c52125aamr18125278ejc.46.1657540027217;
        Mon, 11 Jul 2022 04:47:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uigjXoyFbpZ7GXNNBz8Nrc+N2ZvmSbHZ4faDHCA9Dj8i7rNqjuANtp8LwCYs6GrD2hWSVG+w==
X-Received: by 2002:a17:907:168c:b0:726:c521:25aa with SMTP id hc12-20020a170907168c00b00726c52125aamr18125258ejc.46.1657540026969;
        Mon, 11 Jul 2022 04:47:06 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id fy6-20020a170906b7c600b0072aed3b2158sm2609073ejb.45.2022.07.11.04.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:47:06 -0700 (PDT)
Message-ID: <d7e2a109-c1b7-9f8c-c2b2-b765f016a9a3@redhat.com>
Date:   Mon, 11 Jul 2022 13:47:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: Add mic-mute LED classdev
 support
Content-Language: en-US
To:     PaddyKP Yao <ispaddy@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     PaddyKP_Yao@asus.com,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Corentin Chary <corentin.chary@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luke Jones <luke@ljones.dev>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <HK0PR04MB33636680A6DC47211560BB43FA879@HK0PR04MB3363.apcprd04.prod.outlook.com>
 <20220711024718.1700067-1-PaddyKP_Yao@asus.com>
 <CAHp75Vfnt0DX9wnx0pKhit4JWCjBST+4caTjY6x6VYNdGjqn9Q@mail.gmail.com>
 <YswMZ5Il+5yde3+f@paddy-ASUS-EXPERTBOOK-B1400CBA>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YswMZ5Il+5yde3+f@paddy-ASUS-EXPERTBOOK-B1400CBA>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/11/22 13:41, PaddyKP Yao wrote:
> <accidentally hit send to soon, trying again>
> 
> Hi,
> 
> Sorry for mistake about send two patch mail again...
> After some try, I cannot remove legal message from asus mail.
> I will use my gmail and send patch again.
> And may I use author PaddyKP_Yao@asus.com instead of my gmail account?

Yes I can fix that up for you.

Regards,

Hans



> 
> Many thanks for your kind feedback.
> 
> On Mon, Jul 11, 2022 at 10:50:29AM +0200, Andy Shevchenko wrote:
>> On Mon, Jul 11, 2022 at 4:47 AM <PaddyKP_Yao@asus.com> wrote:
>>>
>>> From: PaddyKP_Yao <PaddyKP_Yao@asus.com>
>>
>> Besides we got two emails again of the same version...
>>
>>> ===================================================================================================================================
>>> This email and any attachments to it contain confidential information and are intended solely for the use of the individual to whom it is addressed.If you are not the intended recipient or receive it accidentally, please immediately notify the sender by e-mail and delete the message and any attachments from your computer system, and destroy all hard copies. If any, please be advised that any unauthorized disclosure, copying, distribution or any action taken or omitted in reliance on this, is illegal and prohibited. Furthermore, any views or opinions expressed are solely those of the author and do not represent those of ASUSTeK. Thank you for your cooperation.
>>> ===================================================================================================================================
>>
>> ...this is problematic and can't be used in open source projects. Ask
>> your legal team how to deal with it.
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko
> 

