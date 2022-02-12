Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED07D4B3636
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 17:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiBLQEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 11:04:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbiBLQEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 11:04:22 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8083820E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:04:18 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 23096402B4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 16:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644681857;
        bh=QcIQqgroCqdej9OjV6C9iN3KDLQKItyx3mQCLCn7fTA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=oEkMjMwcttqEdonOK+Fwky1Q4vTR6ApjXdOpKQEXJjks2dAt82irOH79Dt9xihu5p
         3CbUDG3YxrpcdKwcWlXl7dygFdpJMdvsEkATNoHs3vN271wfEkVXNbYHqXwDmP08NT
         HsW2HOJn7rOrUYMlNNxne5RHK/5P4s4g+OJCk7ibhtVmZ1ofyjCRv4sw/4EgBr0NGV
         +N2OxJ35fmcqtYPy6QRnrGoHoP07Fg9ZbVv33d+u3ApGGtL1kRKTXAmcWDd9QU8OfO
         dgl0Fhpa4EMxnk8Z8jxQMrsxOJGvy1JRRV2atZikblMbHNBspwNxg/fmZhtPn31n5k
         SGovyP/husumA==
Received: by mail-ed1-f69.google.com with SMTP id cr7-20020a056402222700b0040f59dae606so7291471edb.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 08:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QcIQqgroCqdej9OjV6C9iN3KDLQKItyx3mQCLCn7fTA=;
        b=zr1rtC5baUY939s2988nOdAiUg5n4heuASDTht9BvbMVehnOgnTKveaJR8GBAIRjhW
         5KTG+Va1EI9pllXyTMtT88kBI8W4OnQ4kKEA4ZJBuLNxVqa7DOTvN/FOCHE4t5bDkpUH
         VbNVJx6R1/p2Wxgov9UzPZ/cJ7GprpakxvNi7DpjaaE38w/UeMYKZPIR5zhwVaKSZWMC
         CVMEFTG54lV8kH1Mmqd43gQIpTXsGmJ2Kgt2GTTIdWcdvksi2ZDsNgQROqTD1NSRorUD
         Ppnh+FkbEGIGTv2BOIv9LAC+ziLoguBCI7zkgO2Gbz/JadYD4Skzsd/Dr18yzxffq1C9
         TWnw==
X-Gm-Message-State: AOAM533SK2szm/rcifTKu2xLmN+/zAH+U8VcZc+g1yMAF3TAsvxJtgwq
        bIif3mWduLbJ+yl3WCbdi2+/gvZsVWV1P9h96ei5ukWmv8ssNtlTX/LYb1yfjlcbW+yMsBrAMOm
        757aj36peeTuuxBOmbbHZPWOBogvOke/KvPhG1lMO5w==
X-Received: by 2002:a17:906:77db:: with SMTP id m27mr5235240ejn.763.1644681856548;
        Sat, 12 Feb 2022 08:04:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeuTVyT10Sr1VrEAjKE3ypRITjHr1PAzaH07C90ZIL4VM1XZvo6xyhFbHUKor4xH5tzshNlA==
X-Received: by 2002:a17:906:77db:: with SMTP id m27mr5235230ejn.763.1644681856395;
        Sat, 12 Feb 2022 08:04:16 -0800 (PST)
Received: from [192.168.0.101] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id f19sm8534417edr.96.2022.02.12.08.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Feb 2022 08:04:15 -0800 (PST)
Message-ID: <fb5e8add-b77b-2553-031f-3201225e3a09@canonical.com>
Date:   Sat, 12 Feb 2022 17:04:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/3] regulator/mfd: dt-bindings: maxim,max77802:
 convert to dtschema
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <20220111175430.224421-1-krzysztof.kozlowski@canonical.com>
 <f0a9e656-cf18-f212-b701-a1c9d10c4a59@canonical.com>
 <YgDoG8Xlhq5L3Bii@google.com> <20220212112536.GB20866@duo.ucw.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220212112536.GB20866@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2022 12:25, Pavel Machek wrote:
> Hi!
> 
>>> Dear Lee,
>>>
>>> This patchset was reviewed and there are no outstanding issues. Could
>>> you pick up entire set via MFD tree?
>>
>> Nothing from LED or Regulator?
> 
> I took 3/3 separately, as suggested.
> 

Thanks!


Best regards,
Krzysztof
