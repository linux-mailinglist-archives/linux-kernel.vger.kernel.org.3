Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5423525D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378164AbiEMIXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378091AbiEMIWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:22:52 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC5B262672;
        Fri, 13 May 2022 01:22:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c24so3730149lfv.11;
        Fri, 13 May 2022 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bHr/LN3gH4J18SZqSPlyS5LBwKeIhV3WXsMlgOi6f+4=;
        b=XMgBiIJSaZ7yHO4F9FFyh4HHsDzgwZIc4ROUHt/XnJTZwDoCGLlUf0jmBOhMlJUneq
         PdynIO8s2ISkn1/WAhVMYiuz1CIU/JH64vo0cGEkqvx2d8tJM7M3aY+P2guwTeVDqq2e
         aDs9vLoKwGFgLXH7VFbdoRofSmEdjAg9pXXuBy2rJ0JQDJzRw28lrMb0HWdW69GBG7Ro
         PbB42o+ip83alHR8cSOYN5OlMKVp3LwEM2klfmNpRUABn+3nLswfeRyvIJLRM3kQnMWe
         FAm89zG5JnMnPy8tRcReAxncvZ4huoqs7gjMBERp2M9AWUJj5ANU37+rxoItLT6jq0Yz
         pIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bHr/LN3gH4J18SZqSPlyS5LBwKeIhV3WXsMlgOi6f+4=;
        b=uN6KQaUXbtPmKI9zmAaV5tBMxYqf9SJ4jI73Db0qGXU16Q74YuYyA5BWJrIHktcXRH
         Xuxa9YBFtLcTHDLLY5Qvqb9Zr5RxT8KSqbGaA0NvWPfS/4sF/1mv6RfSok8r+/LiNl/I
         HnQibfPEHHuRCHOaNwReTzD/r5YxRvN1TFT0+/T/B0d/lrVQ4qLkY7blhopKxA6ZJicg
         rqtMS5RPDSx5QNOdNHzU0AnStkb/bZ2QEvTwcA9k9aXkb7zM65mnIWpZtibdT3NBOa8V
         Eb1s7HO4sl2ti0heKO1ju+Ck+76dTGB5+DVKAo8PPEssT/Rt3Sy2r5Z1oQsXqBH5qME7
         +fyg==
X-Gm-Message-State: AOAM5332KAGSY/BbTddvNPc7Y+HyXODZV0K+f+w3E2spRBpxgcaVaHuq
        5bWeLDk5vYYROA+rjbSGxKi4ftWsjoM=
X-Google-Smtp-Source: ABdhPJx1GDgivsFZ/N+yg7hu65wIxi09RSSRjKzQnH/8QUBVM9jo2ssm4vEaZeluX4loQWBMs2fudg==
X-Received: by 2002:ac2:5f84:0:b0:471:fd0f:a6e7 with SMTP id r4-20020ac25f84000000b00471fd0fa6e7mr2589134lfe.41.1652430167053;
        Fri, 13 May 2022 01:22:47 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.80.171])
        by smtp.gmail.com with ESMTPSA id n2-20020a195502000000b0047255d21164sm286121lfe.147.2022.05.13.01.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:22:46 -0700 (PDT)
Subject: Re: [PATCH v3 13/23] ata: libahci: Extend port-cmd flags set with
 port capabilities
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-14-Sergey.Semin@baikalelectronics.ru>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <887a7537-5400-f3e2-235c-033871d413bc@gmail.com>
Date:   Fri, 13 May 2022 11:22:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220511231810.4928-14-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 2:18 AM, Serge Semin wrote:

> Currently not all of the Port-specific capabilities listed in the
> PORT_CMD-enumeration. Let's extend that set with the Cold Presence
> Detection and Mechanical Presence Switch attached to the Port flags [1] so
> to closeup the set of the platform-specific port-capabilities flags.  Note
> these flags are supposed to be set by the platform firmware if there is
> one. Alternatively as we are about to do they can be set by means of the
> OF properties.
> 
> While at it replace PORT_IRQ_DEV_ILCK with PORT_IRQ_DEV_MPS and fix the

   Your code has PORT_IRQ_DMPS instead...

> comment there. In accordance with [2] that IRQ flag is supposed to
> indicate the state of the signal coming from the Mechanical Presence
> Switch.
> 
> [1] Serial ATA AHCI 1.3.1 Specification, p.27
> [2] Serial ATA AHCI 1.3.1 Specification, p.7
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/ata/ahci.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 7d834deefeb9..f501531bd1b3 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -138,7 +138,7 @@ enum {
>  	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
>  
>  	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
> -	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
> +	PORT_IRQ_DMPS		= (1 << 7), /* mechanical presence status */
>  	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
>  	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
>  	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
[...]

MBR, Sergey
