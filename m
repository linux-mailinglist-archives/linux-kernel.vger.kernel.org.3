Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCFD55E2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbiF0VES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239552AbiF0VEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:04:12 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A1895A4;
        Mon, 27 Jun 2022 14:04:11 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id i194so10878171ioa.12;
        Mon, 27 Jun 2022 14:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VA6ORkBSx7XmeTMDyx85R9tA3TNtUa5l/wq0WUtTI6U=;
        b=Txlh4qoMdq0z2yjG2CKysB+/BV22Q5HhXbH6NC+j3Dq+DsKFwgPcojTQ7mJPA4dffs
         fH6sH+cDlDEJuUm+WzO45JjZTo3xgpuJ58VqLXZaoHfh3bArNIMoMC59kX/tuZhzE5aV
         xovmT6RbXJt3P/3SIbPUMVeCVLOdzqiZDOnlZZQ38cyubf454gtKLJlA7azm93CxWjHE
         lJgloT/QNnZGpwe4VmorXE6O+O7O1leoGll5G9yj3qldhCojPDfB0oSB6CfCEqTQpw+g
         WgXbjDo94N3uiyaMJOcu59BqTnrEp/5ESN3aZ0KuFb91fsz1aRDcbufTC363iXWaRBIA
         KJVw==
X-Gm-Message-State: AJIora8R6UuEkl5BfsiJgkOEt9eYCDYXh4F0hUVjCXjPv1dux9/WnI++
        Q3JKQapZNHmtxe+tbF0Ikw==
X-Google-Smtp-Source: AGRyM1t4abnkeVbOz7m4JFXhTp+ZgOE+dhLfycD1T0nq7VKCENH5U1t29c/Aixyg12ceJlgkwe/REg==
X-Received: by 2002:a05:6602:2a4b:b0:66a:44ad:89f3 with SMTP id k11-20020a0566022a4b00b0066a44ad89f3mr7492274iov.10.1656363850219;
        Mon, 27 Jun 2022 14:04:10 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id e4-20020a0566380cc400b00339dbd4c8d7sm5215727jak.45.2022.06.27.14.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 14:04:09 -0700 (PDT)
Received: (nullmailer pid 2954489 invoked by uid 1000);
        Mon, 27 Jun 2022 21:04:07 -0000
Date:   Mon, 27 Jun 2022 15:04:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: usb: Add Type-C switch binding
Message-ID: <20220627210407.GA2905757-robh@kernel.org>
References: <20220622173605.1168416-1-pmalani@chromium.org>
 <20220622173605.1168416-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220622173605.1168416-2-pmalani@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 05:34:30PM +0000, Prashant Malani wrote:
> Introduce a binding which represents a component that can control the
> routing of USB Type-C data lines as well as address data line
> orientation (based on CC lines' orientation).
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes since v4:
> - Added Reviewed-by tags.
> - Patch moved to 1/9 position (since Patch v4 1/7 and 2/7 were
>   applied to usb-next)
> 
> Changes since v3:
> - No changes.
> 
> Changes since v2:
> - Added Reviewed-by and Tested-by tags.
> 
> Changes since v1:
> - Removed "items" from compatible.
> - Fixed indentation in example.
> 
>  .../devicetree/bindings/usb/typec-switch.yaml | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/typec-switch.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/typec-switch.yaml b/Documentation/devicetree/bindings/usb/typec-switch.yaml
> new file mode 100644
> index 000000000000..78b0190c8543
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/typec-switch.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/typec-switch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: USB Type-C Switch
> +
> +maintainers:
> +  - Prashant Malani <pmalani@chromium.org>
> +
> +description:
> +  A USB Type-C switch represents a component which routes USB Type-C data
> +  lines to various protocol host controllers (e.g USB, VESA DisplayPort,
> +  Thunderbolt etc.) depending on which mode the Type-C port, port partner
> +  and cable are operating in. It can also modify lane routing based on
> +  the orientation of a connected Type-C peripheral.
> +
> +properties:
> +  compatible:
> +    const: typec-switch
> +
> +  mode-switch:
> +    type: boolean
> +    description: Specify that this switch can handle alternate mode switching.
> +
> +  orientation-switch:
> +    type: boolean
> +    description: Specify that this switch can handle orientation switching.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: OF graph binding modelling data lines to the Type-C switch.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Link between the switch and a Type-C connector.
> +
> +    required:
> +      - port@0
> +
> +required:
> +  - compatible
> +  - ports
> +
> +anyOf:
> +  - required:
> +      - mode-switch
> +  - required:
> +      - orientation-switch
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    drm-bridge {
> +        usb-switch {
> +            compatible = "typec-switch";

Unless this child is supposed to represent what the parent output is 
connected to, this is just wrong as, at least for the it6505 chip, it 
doesn't know anything about Type-C functionality. The bridge is 
just a protocol converter AFAICT. 

If the child node represents what the output is connected to (like a 
bus), then yes that is a pattern we have used. For example, a panel 
represented as child node of a display controller. However, that only 
works for simple cases, and is a pattern we have gotten away from in 
favor of using the graph binding.

I think Stephen and I are pretty much saying the same thing.

Rob
