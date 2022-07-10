Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74D56CFBC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiGJPWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiGJPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D76EDED4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657466537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKni0WvfsJ6ByPDOsZhb/D5KxBUEDM9u0fms8nPwywA=;
        b=Aafb4r+EP542b+7dwFZZ58QqtX9muKdHNnb6sP1bCYXQycC6nKAXKO4r5TDRLyEgYPkmnk
        kBP97K0elh6oQNdbLalG3G/3z0dr/zM76qXuYYJqjutDbeWR24Z5kAVAPBTTztyxJNMsfc
        K/wOop4EbpXLOyolvX3Qp/OUHTu9mSY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-ZbrXBg96NYu9_EgFVph2_w-1; Sun, 10 Jul 2022 11:22:15 -0400
X-MC-Unique: ZbrXBg96NYu9_EgFVph2_w-1
Received: by mail-ed1-f69.google.com with SMTP id w15-20020a056402268f00b0043ac600a6bcso1728895edd.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 08:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wKni0WvfsJ6ByPDOsZhb/D5KxBUEDM9u0fms8nPwywA=;
        b=2mFICurnDyLKIXwJoKjF1sPbuGG06uTlDayNrWyc4tLrucmUbAKM0PUx6B+AGskl7f
         nLPRRfeOUbj3zU7MIkDY7TYxN+brly+mkxrpoJIhkQFNMYg5alvml6zOLqvwc4i5/Ugp
         XkRRX53vpuliJaubaxh4gDnm97vMUnmhHRzUHRLK1QQFKpuUM8HO9bgAcxQBJ0vRFAbK
         Z9AsdnXefOo9XtiF856HiOLdI+S5afM4fAX3FHWhALBVMJtCqrm/2yaI1fglNxjb2Iv5
         dG0jVpIne833+Ni34neJ/HVrGfbN9baE8zTf0OTz6/8V4hPNGbUx3Mdxmjh24RXDgqRC
         A10Q==
X-Gm-Message-State: AJIora8fIt4w1ZwLPj0EBlla3bDykFBXPjELxP2X/vWiSz3SuiEqIViR
        i6ra7eoPF3hyHECgj4l/1IKrNMtaiP5naqAu5m+S5AZmZy0okwrToOxPT4dyyaLwFT2rGbYRykx
        pXgrjIB1AwygV8EbVLQdKm08Z
X-Received: by 2002:a17:906:a245:b0:708:ce69:e38b with SMTP id bi5-20020a170906a24500b00708ce69e38bmr14074520ejb.100.1657466534685;
        Sun, 10 Jul 2022 08:22:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uMytWdrOM/eLsvnjyWEOQAi9pXJoWWKcK3aXocpxb+JcgsvNF+XSrYFqXT3vNnt9U5V9lyeQ==
X-Received: by 2002:a17:906:a245:b0:708:ce69:e38b with SMTP id bi5-20020a170906a24500b00708ce69e38bmr14074510ejb.100.1657466534523;
        Sun, 10 Jul 2022 08:22:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id be5-20020a0564021a2500b0043a2338ca10sm2841632edb.92.2022.07.10.08.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 08:22:13 -0700 (PDT)
Message-ID: <df701ecb-de54-8249-b276-d7877723ae6e@redhat.com>
Date:   Sun, 10 Jul 2022 17:22:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] platform/x86: gigabyte-wmi: add support for B660I AORUS
 PRO DDR4
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a4r_Eriksson?= <parherman@gmail.com>
Cc:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@weissschuh.net>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705184407.14181-1-parherman@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220705184407.14181-1-parherman@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/5/22 20:44, Pär Eriksson wrote:
> Signed-off-by: Pär Eriksson <parherman@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/gigabyte-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
> index 497ad2f64a51..5e7e6659a849 100644
> --- a/drivers/platform/x86/gigabyte-wmi.c
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -150,6 +150,7 @@ static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M AORUS PRO-P"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M DS3H"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B660 GAMING X DDR4"),
> +	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B660I AORUS PRO DDR4"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z390 I AORUS PRO WIFI-CF"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z490 AORUS ELITE AC"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("X570 AORUS ELITE"),

