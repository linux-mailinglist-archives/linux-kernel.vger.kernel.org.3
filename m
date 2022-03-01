Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38534C86C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiCAImp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiCAImn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:42:43 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF6D88B16
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:42:01 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 39B8F3FCA5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646124120;
        bh=dZm4dVdpcvNRhKnzE3iapZ6aqr4LkpURHZ0F0cP2Ffk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=lbftfQbaBU844nsZQB31PSLptIySJ/JrJsUhYj9C/gK/ETMAIBRyjckV3rzW7rX2n
         5XX9HWyAxrW9+FpO8SUN4Putjgwt64v62kPOwDuWMUgGdWGQQ8nGhhOcCREbV2acwW
         LpKVZEtkmXEGBsN+I3xBM8X8vRAOuOUV30ZE/h5Kz28oo0WP+/eAgWzhVrBhHzIyhv
         Ooq3sO742mRLCT8mg2/FsXYQvtVAkix6RNFvhU8eIWKIx3EjqDb2gQjrr0r/tayLaD
         3AhGFjSF7GG+B+Pln9+oLk0El5Xxnsh9O4dDG/FFwtudKz3/M/zRiWiA2yNJCL+NpA
         ztoPouzOVcEUQ==
Received: by mail-ej1-f72.google.com with SMTP id nb1-20020a1709071c8100b006d03c250b6fso6485039ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 00:42:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dZm4dVdpcvNRhKnzE3iapZ6aqr4LkpURHZ0F0cP2Ffk=;
        b=xNNryGFVWpb6LxCc5Xvgt+HPWlGgX1IW0HqbVqARI0OGqLeMNyKHv9Gj2wAR4jyqfG
         5LzMJmu4CfcDsthMZEN/ePaP1zzNQczk9oBpsggO7sCYdPqB7ii14PSOk+9Arh9zfjXN
         Aq+CU6LfdWcNUSSDUMb8mn4FgJw2tLI4DLkPvDc1p1YnDKcWSL7e7vfh/o3zKlrrn6YJ
         eB2rTx4HktCytMN1Pz09PUkZiauENwsZ/F0jcVJdGhWHUE/H/KS5ftOMLTcffUOKX/56
         QiAe2vElQpFDdraE/+diogIsH3mwWo6Pdiftl7HhPvMPjHQuuk28cnKcYkJGnWeaL31r
         W1Lg==
X-Gm-Message-State: AOAM531XIKThpV3+fHRa+U5X3LIrAHPeXQv5bl3d7a1RClVHZQ7o3x89
        0/ixLvhDI4nuVpxwsSibNQz8l/kxHwTTQofh0yBBmMdn7DOin5B9UjyH091Hs1TBtYu25oRUKQ8
        h0+sTI6TRT9gzKFBAT2LwTYMB3Et/dZQpSyOZFIXRLg==
X-Received: by 2002:a17:907:248a:b0:69b:ba2d:62cd with SMTP id zg10-20020a170907248a00b0069bba2d62cdmr18284926ejb.212.1646124119342;
        Tue, 01 Mar 2022 00:41:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkLsXZPJFLzXPV5FGYgxl+qkbahIyWcZp4Gh4Ixdg/+bf55XzGLZMALWtwePubTl5fD9ILsg==
X-Received: by 2002:a17:907:248a:b0:69b:ba2d:62cd with SMTP id zg10-20020a170907248a00b0069bba2d62cdmr18284886ejb.212.1646124119100;
        Tue, 01 Mar 2022 00:41:59 -0800 (PST)
Received: from [192.168.0.135] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id bo14-20020a170906d04e00b006ce98d9c3e3sm5116757ejb.194.2022.03.01.00.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:41:58 -0800 (PST)
Message-ID: <59ba1fd5-4be5-278f-47df-d26c341da73a@canonical.com>
Date:   Tue, 1 Mar 2022 09:41:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 05/11] PCI: Use driver_set_override() instead of
 open-coding
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20220228200606.GA516338@bhelgaas>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220228200606.GA516338@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2022 21:06, Bjorn Helgaas wrote:
> On Sun, Feb 27, 2022 at 02:52:08PM +0100, Krzysztof Kozlowski wrote:
>> Use a helper for seting driver_override to reduce amount of duplicated
>> code. Make the driver_override field const char, because it is not
>> modified by the core and it matches other subsystems.
> 
> s/seting/setting/
> or even better, s/for seting/to set/
> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
>> -	char		*driver_override; /* Driver name to force a match */
>> +	/*
>> +	 * Driver name to force a match.
>> +	 * Do not set directly, because core frees it.
>> +	 * Use driver_set_override() to set or clear it.
> 
> Wrap this comment to fill 78 columns or so.

Thanks, I'll fix both.


Best regards,
Krzysztof
