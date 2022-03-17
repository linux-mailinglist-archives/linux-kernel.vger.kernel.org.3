Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790834DC035
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiCQHev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiCQHeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:34:44 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE61099EF5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:33:27 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id r10so6111311wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DFyEXhOGqkmdaWhQZfBMS5bkvh64Ek9rN53yKBN0Usw=;
        b=AEMPaNy1IGkWwx72+UvkuuDzL1ojlLQMpKaNoz0fWciJJvqntM8wkSTzusvdM/jayF
         njOZS1Uvf93vU4LJ/jxeDFZ1gzsDK5+GK8TVoaA+tn1H0QcFk+ef0qAwf56E8fWBXAeX
         jTgRgSsBwDiCLNAUmZnn2tmPxwCHq6SOrPMVMoMuiZHpAJknreljSI0LLR8A3I0sxY6k
         WKClTwJO+ODS1lNoMXLWXMiGPCdqLgt7I1UHWAcflUVaQ7pCb4R6gzm+JkXQdkU0+Mil
         J3NctLafcjOe7Wt2bPMo5xZccoWPqZyOmyPaDyTLm++x9CjpxKLN5Kz6QaKu5pOPT8Ll
         do7Q==
X-Gm-Message-State: AOAM530AjMY8R06FHB3ZzdphHY1+0pM8reDqemjtzXSxZiD0Fcrx0a/J
        +XJy4+nksyy4yZeTXJybJaA=
X-Google-Smtp-Source: ABdhPJyNyd4Sh+B7LgZAIAECEmLIbfu9/iIu3CNMHw99MKpFBpTsrw9qrWudNaWsQHr26CJQOPBvWQ==
X-Received: by 2002:a5d:58d6:0:b0:203:de3f:e648 with SMTP id o22-20020a5d58d6000000b00203de3fe648mr2782383wrf.292.1647502406170;
        Thu, 17 Mar 2022 00:33:26 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id bg42-20020a05600c3caa00b00380deeaae72sm5618440wmb.1.2022.03.17.00.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 00:33:25 -0700 (PDT)
Message-ID: <df1f96ac-a55d-5905-f0a2-bffd1e3eba2c@kernel.org>
Date:   Thu, 17 Mar 2022 08:33:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] memory: fsl_ifc: populate child nodes of buses and mfd
 devices
Content-Language: en-US
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220307204118.19093-1-leoyang.li@nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220307204118.19093-1-leoyang.li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 21:41, Li Yang wrote:
> Commit 98f1323959b8 was trying to replace the "simple-bus" compatible
> with explicit bus populate in the driver.  But of_platform_populate()
> only populates child nodes of ifc without populating child buses and
> child mfd devices residing under ifc.  Change it to
> of_platform_default_populate() to fix the problem.
> 
> Fixes: 98f1323959b8 ("memory: fsl_ifc: populate child devices without relying on simple-bus")
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/memory/fsl_ifc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

It's too late for upcoming cycle (patches after rc6 usually do not make
it), so I will pick it up after merge window.


Best regards,
Krzysztof
