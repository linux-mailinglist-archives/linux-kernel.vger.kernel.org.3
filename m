Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3CB5AD590
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbiIEO4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiIEOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:55:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A89A52FD2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:55:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso5847448wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=uvlODBfmBe3mEkuMeMvEY2qjFBAHvXEOHu/wxawQM3s=;
        b=kCFsmsOawszVXxHf+tUWi+Ktss3/GWzI1EdNw5ZFYp+qau/MzDY/CxUpMWq00zGaw7
         lAlveyUn20rE8nXuuLioMuY+NpqrYnNSKLVg6qTSslFPAYiQMNrFfibhsGIpQ3OdgOGB
         ciXu7L+Hr5p7kQDIoZGzW7AWsmSNYeN27aGywGhCRpK1y+eLvSE3+z0hYm4P8nCqtG1P
         zuXrIrU4PirpeMn+zkSendUy08FeyTYfGYUekOdaJ/Mwvqy98QdBujt9ev4rl3bmzQ5E
         +2u8wwmlnTLuDRCP3ww0fAxsP0pHQDcnglJpZ7JJ0Ea3QiK1GDkeF2Jo7ed69gE5/dh7
         7PCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uvlODBfmBe3mEkuMeMvEY2qjFBAHvXEOHu/wxawQM3s=;
        b=6ezx0K6aHZ3tH0RLda3gTm/5xBBgP0Z9Ie1Dnpk59jxnmtuLSD58AX0xHLFYsVK5WJ
         y8xhb7dJwUQu58GewEStBsDb9pi/GW9SgUHJybP8gx0/AruFBc+pdUD30DLk2qXzc0MX
         PmvzrPOe+AXDlEKAexK3mnOBVSGGpu9lgwstoKArewVdSZjwU1ErgxyS6CCNbsgYQ10l
         LHfhGB5g4vPmEeE0v9AkbPlDNCds5pUm2WD44NmaniDnSA6cdr7n/P7HqV2V1r5QcNao
         rY/JPgub9lkHLUaOVKtISMBw3VHcMdKmXxToCZgPYcnVSsFP9smH2qY/uwMLY3v5qvs2
         My1Q==
X-Gm-Message-State: ACgBeo0CxYYYp2IkA/4QznDDAPeLmxqBqAcGAjGbureP8M+pkV6VpIxt
        GxCpUqlpfqEPiKDZ3UIaOdDzfw==
X-Google-Smtp-Source: AA6agR6GPBlftqiLbVWnhki/MhS7+WB+UVXuXQIiKl/k+k/ztR4SmAMKa7QGhMyYDkANkRd6CTjV1g==
X-Received: by 2002:a05:600c:3b1f:b0:3a5:e672:a385 with SMTP id m31-20020a05600c3b1f00b003a5e672a385mr10871223wms.49.1662389754898;
        Mon, 05 Sep 2022 07:55:54 -0700 (PDT)
Received: from google.com (ec2-18-168-47-91.eu-west-2.compute.amazonaws.com. [18.168.47.91])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d6d41000000b0021db7b0162esm9168888wri.105.2022.09.05.07.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 07:55:54 -0700 (PDT)
Date:   Mon, 5 Sep 2022 15:55:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kavyasree.Kotagiri@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v8 0/3] Add support for lan966x flexcom chip-select
 configuration
Message-ID: <YxYN9CacFm47R/e2@google.com>
References: <20220708115619.254073-1-kavyasree.kotagiri@microchip.com>
 <SA2PR11MB4874435AC1CAEE6DAFC3F239927F9@SA2PR11MB4874.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA2PR11MB4874435AC1CAEE6DAFC3F239927F9@SA2PR11MB4874.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Sep 2022, Kavyasree.Kotagiri@microchip.com wrote:

> Hi Lee,
> 
> Are you planning to take this patch series for 6.1 or Can we include them through arm-soc pull-request?

I don't seem to have visibility.

Have I Acked it already?

BTW, this is my old email address.

Please use the one in my signature instead.

> > -----Original Message-----
> > From: Kavyasree Kotagiri [mailto:kavyasree.kotagiri@microchip.com]
> > Sent: Friday, July 8, 2022 5:26 PM
> > To: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; Nicolas Ferre -
> > M43238 <Nicolas.Ferre@microchip.com>; alexandre.belloni@bootlin.com;
> > Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>;
> > UNGLinuxDriver <UNGLinuxDriver@microchip.com>
> > Cc: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Kavyasree Kotagiri - I30978
> > <Kavyasree.Kotagiri@microchip.com>
> > Subject: [PATCH v8 0/3] Add support for lan966x flexcom chip-select
> > configuration
> > 
> > This patch series converts atmel-flexcom bindings into json-schema format.
> > Adds support for lan966x flexcom chip-select configurations and its
> > DT bindings.
> > 
> > v7 -> v8:
> >  - Added back patternProperties for child nodes.
> >  - Changed compatible string to microchip,lan9668-flexcom.
> > 
> > v6 -> v7:
> >  - Change filename to atmel,sama5d2-flexcom.yaml
> >  - Add #address-cells, #size-cells to flexcom node - Fixed warnings.
> > 
> > v5 -> v6:
> >  - Removed spi node from example as suggested by Rob and
> >    also pattern properties(spi dt-bindings conversion to yaml patch is under
> > review).
> >    https://patchwork.kernel.org/project/linux-arm-
> > kernel/patch/20220629125804.137099-1-sergiu.moga@microchip.com/
> >    Once this is accepted, I will add back spi example through new patch.
> > 
> > v4 -> v5:
> >  - Fix indentations of DT example.
> >  - Fix dt-schema errors - removed minItems, maxItems for allOf:if:then
> >    "reg" property as it is not required.
> > 
> > v3 -> v4:
> >  - Fix dtschema errors.
> >  - Add a condition to flexcom chip-selects configuration as chip-select
> >    lines are optional.
> > 
> > v2 -> v3:
> >  - changed IRQ flag in dt-bindings example.
> >  - added reg property specific to lan66x which is missed in v2.
> >  - used goto label for clk_disable in error cases.
> > 
> > v1 -> v2:
> >  - minor fix in title of dt-bindings.
> >  - Modified new dt properties usage in atmel,flexcom.yaml.
> >  - Used GENMASK and macros for maximum allowed values.
> >  - Use u32 values for flexcom chipselects instead of strings.
> >  - disable clock in case of errors.
> > 
> > Kavyasree Kotagiri (3):
> >   dt-bindings: mfd: Convert atmel-flexcom to json-schema
> >   dt-bindings: mfd: atmel,sama5d2-flexcom: Add new compatible string for
> >     lan966x
> >   mfd: atmel-flexcom: Add support for lan966x flexcom chip-select
> >     configuration
> > 
> >  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 155 ++++++++++++++++++
> >  .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 -------
> >  drivers/mfd/atmel-flexcom.c                   |  94 ++++++++++-
> >  3 files changed, 248 insertions(+), 64 deletions(-)
> >  create mode 100644
> > Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-
> > flexcom.txt
> > 
> 

-- 
DEPRECATED: Please use lee@kernel.org
