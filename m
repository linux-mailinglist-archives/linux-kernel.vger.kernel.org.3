Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F804EEEC1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 16:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346651AbiDAOGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345764AbiDAOGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:06:10 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B60C6579D;
        Fri,  1 Apr 2022 07:04:21 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-dee0378ce7so2792975fac.4;
        Fri, 01 Apr 2022 07:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=466muH8TK2/yIkrsl/4601LgxLVtXpA/vsSB0xSWFPM=;
        b=rGqRBRgNfBRlr85/uY1NJ7xEeAUZNegM9wNH2XMUOgJZX//zgoSN/Ck7f7hQ379fUo
         ABhNyLb/JbTS8WqOsEFi2gHUtT8Rng8N4/TsJXEva03ynq1P1wpjkSo2v3SJ8fHlZ1YL
         v6mpUCbTGBpao0kZvaSCFRblUsZUgaED/x0GpnD2IFpuhvexsi/AIxemAh8PSbzfy77g
         ZuiNQYhQQXk9Pgd5E9HBrnbTJLImYa2nnvPsa64kk+yqHkQOIeSgpB4W/55dmloLCGOW
         zw8sbJFwS0jiM5kzzh7gFfOjcxIoeSFNt+PgNDbW1kxwI4hPLwgodtZdh6FJn/syxgFN
         i8Ng==
X-Gm-Message-State: AOAM531xSl1m0P/5fVw/wBDhe30QnLmQG0b7Ljo0nXFIPtdMw/NYnxQB
        gYaen3RezgB2K1d3QcBw5g==
X-Google-Smtp-Source: ABdhPJwDMMktaz/l2V8/Ke7d7S2/0T3HHlMyAQTdziceWQhTIjAzKSHejbo1nlHUsHjY+VnD9FuQHQ==
X-Received: by 2002:a05:6870:c881:b0:de:ab7f:2401 with SMTP id er1-20020a056870c88100b000deab7f2401mr5031521oab.75.1648821860362;
        Fri, 01 Apr 2022 07:04:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y67-20020a4a4546000000b0032476e1cb40sm1053435ooa.25.2022.04.01.07.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 07:04:18 -0700 (PDT)
Received: (nullmailer pid 2984690 invoked by uid 1000);
        Fri, 01 Apr 2022 14:04:17 -0000
Date:   Fri, 1 Apr 2022 09:04:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     niravkumar.l.rabara@intel.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Altera hardware mutex driver
Message-ID: <YkcGYcGVkai3eu1E@robh.at.kernel.org>
References: <20220331214911.27194-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331214911.27194-1-niravkumar.l.rabara@intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 05:49:11AM +0800, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Altera hardware mutex soft IP provides hardware assistance for
> synchronization and mutual exclusion between processors in
> asymmetric/symmetric multiprocessing (AMP/SMP) system or
> multi processes/threads in uniprocessor system.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>  .../bindings/misc/altera-hwmutex.yaml         |  47 +++

Bindings should be separate patch. We have a subsystem/class for this 
type of h/w. The binding (and driver) belongs there.

>  drivers/misc/Kconfig                          |   6 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/altera_hwmutex.c                 | 321 ++++++++++++++++++
>  include/linux/altera_hwmutex.h                |  42 +++
>  5 files changed, 417 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/altera-hwmutex.yaml
>  create mode 100644 drivers/misc/altera_hwmutex.c
>  create mode 100644 include/linux/altera_hwmutex.h
> 
> diff --git a/Documentation/devicetree/bindings/misc/altera-hwmutex.yaml b/Documentation/devicetree/bindings/misc/altera-hwmutex.yaml
> new file mode 100644
> index 000000000000..57a9ea19c563
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/altera-hwmutex.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/altera-hwmutex.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera hardware mutex
> +
> +maintainers:
> +  - Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> +
> +description:
> +  Altera hardware mutex can provide hardware assistance for synchronization
> +  and mutual exclusion between processors in asymmetric/symmetric multiprocessing
> +  (AMP/SMP) system or multi processes/threads in uniprocessor system.

Link to IP documentation?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - altr,hwmutex-1.0

1.0? I feel like you made up this version.

> +      - client-1.0

No.

> +
> +  reg:
> +    items:
> +      - description: physical address of hw mutex and length of memory mapped
> +         region
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    mutex0: mutex0@100 {
> +        compatible = "altr,hwmutex-1.0";
> +        reg = <0x100 0x8>;
> +    };
> +
> +
> +   #Example of mutex's client node that includes mutex phandle    
> +   #mclient0: mclient0@200 {
> +   #     compatible = "client-1.0";
> +   # 	reg = <0x200 0x10>;
> +   #	mutex = <&mutex0>;

We have a standard binding for this.

> +   # };
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 0f5a49fc7c9e..707acf740c6f 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -435,6 +435,12 @@ config DW_XDATA_PCIE
>  
>  	  If unsure, say N.
>  
> +config ALTERA_HWMUTEX
> +       tristate "Altera Hardware Mutex"
> +       help
> +         This option enables device driver support for Altera Hardware Mutex.
> +         Say Y here if you want to use the Altera hardware mutex support.
> +
>  config PCI_ENDPOINT_TEST
>  	depends on PCI
>  	select CRC32
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index a086197af544..6fcbbd36b3cf 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_PCH_PHUB)		+= pch_phub.o
>  obj-y				+= ti-st/
>  obj-y				+= lis3lv02d/
>  obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
> +obj-$(CONFIG_ALTERA_HWMUTEX)   += altera_hwmutex.o
>  obj-$(CONFIG_INTEL_MEI)		+= mei/
>  obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
>  obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
> diff --git a/drivers/misc/altera_hwmutex.c b/drivers/misc/altera_hwmutex.c
> new file mode 100644
> index 000000000000..45f98e4b13d0
> --- /dev/null
> +++ b/drivers/misc/altera_hwmutex.c
> @@ -0,0 +1,321 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright Intel Corporation (C) 2022. All rights reserved
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.

Drop the license text. You only need SPDX-License-Identifier
