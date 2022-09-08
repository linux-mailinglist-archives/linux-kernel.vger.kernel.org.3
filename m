Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141635B265D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIHS76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIHS74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:59:56 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA57303EE;
        Thu,  8 Sep 2022 11:59:54 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bh13so17632852pgb.4;
        Thu, 08 Sep 2022 11:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=QPWYV7SgKdoLBiozZZHmaqbwNoXqKRlSRLPxFGfyYfk=;
        b=j5rNX4T33UID7ItncZ3QoK9LvkbSzkOAxd9ibsBSpQcMBe4jAZaKLB0/5tv5c3p0i9
         SxtBaj3m+Jsyv/iwxmqJCFtfuPr+8pZTsj0NkzQljsqoQgBLfD7RmzoDJCzGFoBih7dI
         9vDzTBfJdWVceC+c6DEOABkYSiNSycMPrhH7NI0cKyPnB129+3e7mSJ9ckOB6Z9DfS5f
         GTD52aaLqxbxw6UD9jGe6ELTE7SlwflQH1cJxyrCGgVOBuLRl7eqL4cAQT49TLhcRcOz
         xJxweH6oDMcNbiWsagxOeRpQspW+/OuA3gnhmLvSXFRRoInpva4SQWPhA6dovzEX5UwS
         Hp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QPWYV7SgKdoLBiozZZHmaqbwNoXqKRlSRLPxFGfyYfk=;
        b=zmks+E0ytD0Xhmm0Y3NSoZ8MpQKDFbeS76HD54NGdytYSK2D1+j3S5BNwZvtD1xhLp
         i+wBlUU5TGkWok4W7q7uIn3l2IHZ/80nxFfMDoYBr8oNehw/VlAttkC3SIpkEM8EJgN5
         MtAwO+DXrzaFrHlP2McN8y1ZmyrGtkdrGWIteaajf756rgeIoH2WfTqW5+1bCNlSaQI7
         tY5JW+XblXipeTsSE8Kf/xPTdzRa5+2AqW5HunAfRFKWWWfPo6l/ByELt/HzTskSIlYL
         pbo3+UmM7IkZzex5rQD+pF1pm66Evl7Ul9+PcPgOl53zdISh6HYL6rVNJ0HWAEFYDted
         x7GQ==
X-Gm-Message-State: ACgBeo3JLA7gXmrzKqF0C0tEeDbTWk5gaem77ffIpB3NGOKW0AzCYOnR
        8wKSEN1fk7qVFvC6XiIQfxc=
X-Google-Smtp-Source: AA6agR419aI0sYHUJo0vwr+hxoYBPCgNE/bzx/5o5dSli8P+DAPpDjqmI16wJ0jsAe5sNPJGjMKTAA==
X-Received: by 2002:a05:6a00:230d:b0:53d:c198:6ad7 with SMTP id h13-20020a056a00230d00b0053dc1986ad7mr10566201pfh.67.1662663594057;
        Thu, 08 Sep 2022 11:59:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x63-20020a626342000000b0052c849d0886sm15207373pfb.86.2022.09.08.11.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 11:59:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 8 Sep 2022 11:59:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 01/21] dt-bindings: hwmon: (mr75203) fix
 "intel,vm-map" property to be optional
Message-ID: <20220908185952.GA3343467@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-2-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-2-farbere@amazon.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 03:24:29PM +0000, Eliav Farber wrote:
> Change "intel,vm-map" property to be optional instead of required.
> 
> The driver implementation indicates it is not mandatory to have
> "intel,vm-map" in the device tree:
>  - probe doesn't fail in case it is absent.
>  - explicit comment in code - "Incase intel,vm-map property is not
>    defined, we assume incremental channel numbers".
> 
> Fixes: 748022ef093f ("hwmon: Add DT bindings schema for PVT controller")
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied, together with patches 2..6 of the series (all fixes).

Thanks,
Guenter

> ---
> V3 -> V2:
> - Change this patch to be first in the series.
> - Add explanation why "intel,vm-map" is not required.
> 
>  Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> index b79f069a04c2..8ea97e774364 100644
> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> @@ -48,7 +48,6 @@ required:
>    - compatible
>    - reg
>    - reg-names
> -  - intel,vm-map
>    - clocks
>    - resets
>    - "#thermal-sensor-cells"
