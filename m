Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A5A4DC8C2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiCQO3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiCQO3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:29:04 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA0820035E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:27:48 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 395DD3F602
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647527259;
        bh=XT6vpCcggmBHdZMgmBcnWI+odMRKjzM5F/MBrP0ojdw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=DZ3JGJM8c2ypyL/DLlySTsd3aWFkw9Fyo3R+leqDe3d+UQoRlFi5+6q7vtFPcjrhw
         iVj1N7FD+ICpWMG9flq71mfLLArO+goGHczxCMKaJ1EecljdZJqwRTw2XY8JrQt/q+
         pUfTzUTax+tY7X4UuW87MTTEmd7RW4ECu7R+yE1OEK6ejbfK05yb3mxcritBNu13xX
         xv8L6gnUQilZMPyE1PhNDwWdWG3fyBW26g1Wxw3LK7TAomelZq+1iu6bs0hL1c5edu
         Kr4dlvVuDOglF6ITDcSpntZFyVYAN1qM2tghAWm+7iTRCEIaaQEqBn335GjYIoAwLB
         pm7KyKtoZWZrA==
Received: by mail-wr1-f72.google.com with SMTP id f9-20020a5d58e9000000b001f0247e5e96so1593714wrd.15
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XT6vpCcggmBHdZMgmBcnWI+odMRKjzM5F/MBrP0ojdw=;
        b=O+YzsB8AtvIMG5PxOEX2j6Sy4COTq6GZljWLqmOhVXlqiyrO8iTYbT2Txz54p4XZyK
         kdNsAbZ9FxJuMpjTJdC5Va+VLZekjuaeRo0YZ7RFhBWky4frMdZQqn7hsJquR7bBzc/c
         G74HODCCajuxFvjaCNRyMnuNbx0dsAUjMipzTnrfme+YAs+TmFPOCgKZYM1CtA/djI8d
         soWioqGjTfdWZR4r7SV9T8KU1SDPL8vg5PXXn6AmkT5Kc982mLPHCOAk9X1piT2BnKkR
         Xw5XvZcPNBhe00TFCfiQvWbIm+fZnRi0lCXQWJyquEwnvKlB1dhDPpqg+tHdThZTXAe/
         vHvQ==
X-Gm-Message-State: AOAM531WgJbugFnjP1jJky/EIE8113DHcSedy5Jvb3+bHCIah1A6Qz/0
        ixyVAGBLqE9tqGi98R+xlfIkNtdoDvOTltifftPNyvOD2nfymPPE06kKaGIQymGaDgW58EeOt7H
        udWw4hFMeRqVJwpIs9adCNpuVn0WN0UzoZ3LZwSF30Q==
X-Received: by 2002:a5d:6da5:0:b0:1f1:f968:1a62 with SMTP id u5-20020a5d6da5000000b001f1f9681a62mr4417221wrs.227.1647527258413;
        Thu, 17 Mar 2022 07:27:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlM6gjdeCd3PkCLJvzS4KHMc2/6IvEHZls0h7G3l5Er9P2s7TAMJ5CKYryRFQwToudopNmIA==
X-Received: by 2002:a5d:6da5:0:b0:1f1:f968:1a62 with SMTP id u5-20020a5d6da5000000b001f1f9681a62mr4417208wrs.227.1647527258241;
        Thu, 17 Mar 2022 07:27:38 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id i15-20020adffdcf000000b00203efad1d89sm1259833wrs.9.2022.03.17.07.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 07:27:37 -0700 (PDT)
Message-ID: <f130deed-1c12-7cd2-fb5f-b58a7991b4c9@canonical.com>
Date:   Thu, 17 Mar 2022 15:27:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: irqchip: mrvl,intc: refresh maintainers
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220317120252.451669-1-krzysztof.kozlowski@canonical.com>
 <YjNEvKTrLXv3/9nL@lunn.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YjNEvKTrLXv3/9nL@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2022 15:25, Andrew Lunn wrote:
> On Thu, Mar 17, 2022 at 01:02:52PM +0100, Krzysztof Kozlowski wrote:
>> Jason's email bounces and his address was dropped from maintainers in
>> commit 509920aee72a ("MAINTAINERS: Move Jason Cooper to CREDITS"), so
>> drop him here too.  Switch other maintainers from IRQCHIP subsystem
>> maintainers to Marvell Orion platform maintainers because its a bigger
>> chance they know the hardware.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> Sebastian has not contributed for a long time. So i suggest you only
> add Gregory and myself.

Sure.


Best regards,
Krzysztof
