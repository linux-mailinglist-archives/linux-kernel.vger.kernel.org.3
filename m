Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324765AF1EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiIFRHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiIFRGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:06:47 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2E36398;
        Tue,  6 Sep 2022 09:54:02 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c24so11140990pgg.11;
        Tue, 06 Sep 2022 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=zQI+DdLFCUikiV3t8V8tFwBfwRVF+ZZxI2qA2tELRBo=;
        b=eGQRctC9tfBhIZgDcOX7N5Qu5AXcjH955F6q8rujOsAHkxvCmrsrOue7d3Kh/PjRoo
         fICVhL3TN6qp6HiRPs0WiwU8ibFFaKNuQX/qq+9XBjQODg8Apda7ytY4UH7iprmlfCCI
         8fXnjwfghk92pZ4o/lZQW8sVapH+NdoLhMyAkhhd5nPI+vbIpq5FKi7RYIW5nxImmHSn
         ad8wmJAPfLmsJJFlfilbXLYUJqdnORtv9tZw4UjrM0IE+QbUWbvOvwgXYcll0PL9OonI
         8aYph2R0nAPla00jxGLwGIkRRCkZroB49/sO6/0asFPSWdH2v+57JtTMuAs+1pJdmTvF
         myJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zQI+DdLFCUikiV3t8V8tFwBfwRVF+ZZxI2qA2tELRBo=;
        b=Zeg71Fy5L1FGaN0A5CH3QoCW4rSa/ShxZbE8efPdoW+z+cguYVJbOcoiu++6G3icJR
         tE6KBD34mhIfkf2SM7/iYnN9bWWrANmhZ2INVGmNmWt4a177qnS1g4AuV/MkoBQwuyXy
         Xdjphmg+6FalCY2wOsT7qUdHnYf0CWZlGa6Xd5r1gbFxufrV9IRAhO6JHINYmjwlpUI4
         N5GvWFkYZkktaeHIcNrQiOq+tE/YvJNY7z1uXY+/SZ5EDqdZtBQJNGkQYyrUuuLh6ojU
         LB0yRE1W08Z9eTzsTRaZyQGKxdm7C7NsujPvuhUOvC8ycvYS/O2g2CHNY47ajVLSyvWk
         9OxQ==
X-Gm-Message-State: ACgBeo0JgK8aO2NdW4u8u8TnR2FukmdylLqnOXaeRkoV+2USFk1/fNIw
        MNyOyuDF5l9BFsdYwZ7WKDE=
X-Google-Smtp-Source: AA6agR40KVFSonXPgm7B1M39fQ5MInhXgP1GfPy9N18rTZ8vE5vC3bNIPirphDfpRKdk2qanPExaCg==
X-Received: by 2002:a65:5b0d:0:b0:434:a7d2:9771 with SMTP id y13-20020a655b0d000000b00434a7d29771mr3705934pgq.356.1662483241177;
        Tue, 06 Sep 2022 09:54:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d16-20020a170902ced000b001753654d9c5sm10274183plg.95.2022.09.06.09.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:54:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Sep 2022 09:53:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hhhawa@amazon.com, jonnyc@amazon.com, andriy.shevchenko@intel.com
Subject: Re: [PATCH v4 02/21] dt-bindings: hwmon: (mr75203) fix
 "intel,vm-map" property to be optional
Message-ID: <20220906165359.GA817639@roeck-us.net>
References: <20220906083356.21067-1-farbere@amazon.com>
 <20220906083356.21067-3-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906083356.21067-3-farbere@amazon.com>
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

On Tue, Sep 06, 2022 at 08:33:37AM +0000, Eliav Farber wrote:
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
> ---
> V3 -> V2:
> - Change this patch to be first in the series.
> - Add explanation why "intel,vm-map" is not required.
> 

I don't see how this change warrants dropping Rob's Acked-by tag.
Am I missing something ?

Guenter

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
