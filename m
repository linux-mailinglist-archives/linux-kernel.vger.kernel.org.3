Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125FF4EA90E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiC2IRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiC2IRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:17:01 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6DBA88A3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648541718; x=1680077718;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=etJNUyFKccNjFEH+loh7MV5WicY1MjAS8jDboHE8eiU=;
  b=dscpidZMoSzdIFOEwvrPem8ofHOPqvLRe4/f4RhsI6Y2mOUkiBBHZhYD
   uYNUCcf7F3ik5T8DUvpC2R+wiNDOz/fRsrOJTdjnURaqNxA7NOH/t3Z2I
   yuJpQfoY/CIM7WH7RMItqCjepv43eeUEhYrC8cqeu4bS4W/36IIYLVBA3
   BPaoE+KjJJBdVe/moW5TG55rAVZZGiUbSgnpfxiXvcEMGeOeW7eZSc/9l
   74xPxuQIJ4QgdAFDbPYjuLVuu1XFzYNdzK9xdWE2l8Zu+zqnLiQUuV5Pk
   sYXfdZA6qYSCu3fQDMV2AY+yg6+m0wZvmPIIjCwN9IlYmvPIQEOGw+OGM
   A==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643644800"; 
   d="scan'208";a="201365598"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 16:15:15 +0800
IronPort-SDR: eFK9cZtR3pPy9M/F3+2NUUM5Mtqm/llIxdJBZxPFgjON3U8vYA5J9TGAkSmZa5bdcPk3Tg6s0U
 Y4C+tJb+UDlyQFAt5wAfnTeX91gZV5IwZLY16seJwDYwTtXrl+qPYh2UWAT7+2XFJ/8bEW/xCS
 Xebtd0TKwf2cLm18/8NaQJxyDae7duCUzduDTsrZSXkygEr0MzzIpZumFqqVKWxnrj1CManedg
 ig+6PHmnrSCSyBOmTlrjTUhq6FWobdHjgZt1IzgXlaZsuR5XT6T8d/9g5ER8QLnJ6us5Dv9+fy
 7K+8dNeCLx9DXYSVnRRh3KgU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 00:46:08 -0700
IronPort-SDR: UIo/eWtIbDqc4GvikVa9h6reiOw34SzicOL4qWVcLF3bG+xwUZtr5u+74OE+k/dbQN3YixE0q4
 COhuc7JZSFiTcvk8kUPC3CeU5wHkI8rkE4WcPltorn9U3c4x80gjhoYTa5Qy307hRAjWh8HCFP
 io6G4klfqUSf3C+DtcTZwciBESky02nA1nPVtQUwvxz6gyaOlkptQwgV44jFyHNpHqSWC+3e83
 EEGPVOjO6e1UWC2wLbHTq0CpaLghc2MFuX9yFBD1+iFSDHl68ck4cac8uIPi/0qM3P7KxPKnev
 so8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 01:15:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KSMnJ0gVtz1SVp5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:15:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648541715; x=1651133716; bh=etJNUyFKccNjFEH+loh7MV5WicY1MjAS8jD
        boHE8eiU=; b=rbTF4xovKjZmjm0Q9kD377CcxZE6a5+bc4Ph0ByS4mv5rAhDmN5
        IHEmLItD2CD+1CijzpQQVhNlazvLope4j9BC2MAuYntsKzMinyTtjk7jCeYIlO0z
        TPtwNCWNrTY0YrJ2vI5abkSiUPYUz+JfTS69G3ZAEwDBv29Xmxpbfg41TrAVjy+q
        ANfyxbz2dAIpnC2DjpqsYLal/ogpkUvrrx4mx6XfiGWFe80w6uHOqFYUumVWPFiD
        qod4EIjsMk4V456o9VdM3nQWyVYnZSrEsXG+6qNJlcxVq9XgIOWIKt6tTwtPt/YK
        9WKA7oxaGB426i3X7edoJ0iw/s2WNqnKyUA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id q8afSvvOU0H4 for <linux-kernel@vger.kernel.org>;
        Tue, 29 Mar 2022 01:15:15 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KSMnF2ytmz1Rvlx;
        Tue, 29 Mar 2022 01:15:13 -0700 (PDT)
Message-ID: <92699f07-0efc-e471-d886-c7d6c83f352e@opensource.wdc.com>
Date:   Tue, 29 Mar 2022 17:15:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/21] dt-bindings: ata: sata: Extend number of SATA ports
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-2-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324001628.13028-2-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 09:16, Serge Semin wrote:
> The denoted in the description upper limit only concerns the Port
> Multipliers, but not the actual SATA ports. It's an external device
> attached to a SATA port in order to access more than one SATA-drive. So
> when it's attached to a SATA port it just extends the port capability
> while the number of actual SATA ports stays the same. For instance on AHCI
> controllers the number of actual ports is determined by the CAP.NP field
> and the PI (Ports Implemented) register. AFAICS in general the maximum
> number of SATA ports depends on the particular controller implementation.
> Generic AHCI controller can't have more than 32 ports (since CAP.NP is of
> 5 bits wide and PI register is 32-bits size), while DWC AHCI SATA
> controller can't be configured with more than 8 ports activated. So let's
> discard the SATA ports reg-property restrictions and just make sure that
> it consists of a single reg-item.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  Documentation/devicetree/bindings/ata/sata-common.yaml | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/sata-common.yaml b/Documentation/devicetree/bindings/ata/sata-common.yaml
> index 7ac77b1c5850..c619f0ae72fb 100644
> --- a/Documentation/devicetree/bindings/ata/sata-common.yaml
> +++ b/Documentation/devicetree/bindings/ata/sata-common.yaml
> @@ -41,11 +41,10 @@ patternProperties:
>      properties:
>        reg:
>          minimum: 0
> -        maximum: 14

Why remove this ? Since AHCI can have up to 32 ports, then change the
value to 31. As the comment at the top of the file says, this is not
intended to be a device tree binding spec, but defines properties common
to most adapters.

>          description:
> -          The ID number of the drive port SATA can potentially use a port
> -          multiplier making it possible to connect up to 15 disks to a single
> -          SATA port.
> +          The ID number of the SATA port. Aside with being directly used
> +          each port can have a Port Multiplier attached thus allowing to
> +          access more than one drive by means of a single channel.

Please add a comma after "Aside with being directly used", otherwise the
sentence is hard to understand. And replace "channel" with "SATA port" to
stick with the terms defined here.

>  
>  additionalProperties: true
>  


-- 
Damien Le Moal
Western Digital Research
