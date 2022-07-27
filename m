Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38720583162
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242926AbiG0SA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242831AbiG0R7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:59:37 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com (mailrelay1-1.pub.mailoutpod1-cph3.one.com [46.30.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB5D5925F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=G1yxjX0ml7bWjfSawJ8KXkM7VbWITujIankz7OQDQDU=;
        b=jVM4agKAWmOwyeSa7KfEytokRMEy91zpRYZ1NLJSLohJKav/IH4ouKcVky9D2m31qboTIRepA65IP
         aebcArchP+KYFud7n8Ar/0HyY2vkibNKiEJpIVFUX593g8guc09F45+BJfD5xuesQl/ahpWRkbk2Cp
         mVuWtKIdbOCamxgL9ES6KRDHzyT63GI38lnbMhVAsFFEC1/1nsDFjaXY5a9IwFzo033DrNWN7+fsf7
         Jn8KtD2dNw+qizO9gksC35QEiE+M3ldYWOoKyKVkHKAjkY0FVMvXpJxdmxrAMW0QuyRudI3Q7d4hnp
         SWjbcEdB74BUyXJj/KELhPa99Vk9iDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=G1yxjX0ml7bWjfSawJ8KXkM7VbWITujIankz7OQDQDU=;
        b=lDk1ZjUPf5ZpN4MXa95KlvR0P9gIsDqDNA2gITqap0cMWkMJAGeAc7mQQND/XPpzx3GziAs6twqUL
         JCjKCq6Aw==
X-HalOne-Cookie: 8a64bf85c0aa5d803b906c36b6265a74ceb1f174
X-HalOne-ID: 2a675d83-0dce-11ed-a6c8-d0431ea8a283
Received: from mailproxy2.cst.dirpod3-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 2a675d83-0dce-11ed-a6c8-d0431ea8a283;
        Wed, 27 Jul 2022 17:04:24 +0000 (UTC)
Date:   Wed, 27 Jul 2022 19:04:23 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Lechner <david@lechnology.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Heiko Schocher <hs@denx.de>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: use spi-peripheral-props.yaml
Message-ID: <YuFwF/sOk4svIlkK@ravnborg.org>
References: <20220727164312.385836-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727164312.385836-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Jul 27, 2022 at 06:43:12PM +0200, Krzysztof Kozlowski wrote:
> Instead of listing directly properties typical for SPI peripherals,
> reference the spi-peripheral-props.yaml schema.  This allows using all
> properties typical for SPI-connected devices, even these which device
> bindings author did not tried yet.
> 
> Remove the spi-* properties which now come via spi-peripheral-props.yaml
> schema, except for the cases when device schema adds some constraints
> like maximum frequency.
> 
> While changing additionalProperties->unevaluatedProperties, put it in
> typical place, just before example DTS.
> 
> The sitronix,st7735r references also panel-common.yaml and lists
> explicitly allowed properties, thus here reference only
> spi-peripheral-props.yaml for purpose of documenting the SPI slave
> device and bringing spi-max-frequency type validation.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

I assume this will be added to the same tree as the SPI CPHA and CPOL
patch.

	Sam
