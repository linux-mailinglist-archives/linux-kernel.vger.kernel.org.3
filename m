Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9642547D7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345268AbhLVTg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:36:27 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:43917 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhLVTg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:36:26 -0500
Received: by mail-qk1-f179.google.com with SMTP id f138so3332665qke.10;
        Wed, 22 Dec 2021 11:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DQXkbqnZiEcUh+/jcIs4LSNWY6G1vGofSkBZyjGU8cQ=;
        b=R7zWbvk82wDCaUtKlcZGIARJVV6KhxDWi5AglA5393WLRbmHwpiWKMnbpM+OM3YfR9
         BaNZURHf2TyYhjRPB3BvZpcoBoQUJn3xl5dFe78g+4ggCLDLR6BH1wWPDeT13R+qlpAI
         q5ya7fzKDRQD+8YaDlrh8eDbhbgvwUzyFh+HfXe+L9Yj0lv+13oNiYGVuvUyaihRtu10
         q8n3U7MBuE/tS1KXlzuwvNd6JF7kZbC8+tGGg/7Xzg55C0UtZYzzvKQyqvrtgB2fqtZg
         JT38gcGdU47ZyCB5KrVdHFtUq66JuOdfvKmS/ppv+/PXdHlEUYmtI4yqKM5vVRA8r/IJ
         RArw==
X-Gm-Message-State: AOAM533IfhnLgKbzF60qQuj2fgRErd/P5P34NR5oP0sy//tzt8XkvMtf
        rAjI44QZI7cRG6QUPXw18iGQZWtFh7Kj
X-Google-Smtp-Source: ABdhPJweKvH4XP+FIgEnwNQb2TWPZgo9az0S6H2t7eFK6avipIRvJ+Y3o6DS8ZLkH1cDVPiRc2/IbQ==
X-Received: by 2002:a37:a305:: with SMTP id m5mr2075895qke.86.1640201785488;
        Wed, 22 Dec 2021 11:36:25 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id r187sm2375814qke.11.2021.12.22.11.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 11:36:25 -0800 (PST)
Received: (nullmailer pid 2574361 invoked by uid 1000);
        Wed, 22 Dec 2021 19:36:23 -0000
Date:   Wed, 22 Dec 2021 15:36:23 -0400
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Introduce common properties
Message-ID: <YcN+NwFu2m6WZCdE@robh.at.kernel.org>
References: <20211221175029.144906-1-paul@crapouillou.net>
 <20211221175029.144906-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221175029.144906-2-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 05:50:28PM +0000, Paul Cercueil wrote:
> Introduce a file for common properties of hwmon sensors.
> 
> As of now it contains only the "label" property, which can contain a
> descriptive label that allows to uniquely identify a device within the
> system.

I don't think we need this. What we need is a global (in dtschema) 
type definition and then any users just add 'label: true'.

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/hwmon/common.yaml     | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/common.yaml b/Documentation/devicetree/bindings/hwmon/common.yaml
> new file mode 100644
> index 000000000000..997f74127d8c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/common.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common properties for hwmon sensors
> +
> +maintainers:
> +  - Jean Delvare <jdelvare@suse.com>
> +  - Guenter Roeck <linux@roeck-us.net>
> +
> +description: |
> +  This document defines device tree properties common to several hwmon
> +  sensors. It doesn't constitue a device tree binding specification by itself but
> +  is meant to be referenced by device tree bindings.
> +
> +  When referenced from sensor tree bindings the properties defined in this
> +  document are defined as follows. The sensor tree bindings are responsible for
> +  defining whether each property is required or optional.
> +
> +properties:
> +  label:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: >
> +      Descriptive label that allows to uniquely identify a device within
> +      the system.
> +
> +additionalProperties: true
> +
> +...
> -- 
> 2.34.1
> 
> 
