Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9EF5A1BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244244AbiHYV4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244204AbiHYV4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:56:09 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A2D5FF4D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:56:07 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p185so6618605pfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=CzgioAjiB1AjDh0ZU+UlgCffn2LI7NLs0P33UVPvdV4=;
        b=b0psqClyf0TBQ+z7lbRc6Pa1ppFmttTmsH4BLTHltHC9FvKD84IxzTcm+ahQj68OhN
         xFIcHxe25iDdR10LFeo/DdLYlTT1NrLZb8dmKeysW/CqaD9KIKHEb+jfDAK/FLrZFOj9
         ajPSUE1keTMpgZn9z+TTexsk/jBWQ+ZWuVU3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=CzgioAjiB1AjDh0ZU+UlgCffn2LI7NLs0P33UVPvdV4=;
        b=gSDRAxSdCu85DuxjNEQh1VCmZooxSHC1Oxjh0MQwi3p3HXz1P7GK1NcW0AN3nLIs5/
         deSL0QvXNU8hJNUka2dfMTJ0UM0yQQ6o6iz07GwJP7JXQWv7ByhWGMgRSgfhNk/DcmWP
         iHPsvfNN4vRMs0wGrWtr+vMI1CW7atB5Jmr/1b5e+YTdB1GyAFhgcPJc7uWXd5f8fdc+
         O51ssF/wGC3LIN5inbr+P1yLtreh4FtvzGkNJIzkz/fIC8DX4Im83zySxYAMWr1ehc94
         30vycYo9mBJoknN66UMTohGQva11BbgVgwuEDr1w8X19cufZypOYqP5zY02dm8XhfeAe
         6LtQ==
X-Gm-Message-State: ACgBeo2Qhrr7QedlXiKDSKqocBRcrddk/Qd98Wo1un+et3iU3CxFcsaB
        S8wwUofwJsFJeXz5E5WrdTBH7A==
X-Google-Smtp-Source: AA6agR5Y473dTPZIIe3oymeiQYkz/4PMyQwDsu36n/0Y+wDzAP5RMvZ0EPyT70ZhvCD1StazgD6bNg==
X-Received: by 2002:a63:cc42:0:b0:41d:c915:ffd with SMTP id q2-20020a63cc42000000b0041dc9150ffdmr834523pgi.161.1661464566910;
        Thu, 25 Aug 2022 14:56:06 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:d529:f79d:2a1a:4e61])
        by smtp.gmail.com with UTF8SMTPSA id b123-20020a621b81000000b0053641e66825sm115586pfb.173.2022.08.25.14.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:56:06 -0700 (PDT)
Date:   Thu, 25 Aug 2022 14:56:05 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: disable USB core PHY management
Message-ID: <Ywfv9bNVx2l1n//z@google.com>
References: <20220825131836.19769-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220825131836.19769-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 03:18:36PM +0200, Johan Hovold wrote:
> The dwc3 driver manages its PHYs itself so the USB core PHY management
> needs to be disabled.
> 
> Use the struct xhci_plat_priv hack added by commits 46034a999c07 ("usb:
> host: xhci-plat: add platform data support") and f768e718911e ("usb:
> host: xhci-plat: add priv quirk for skip PHY initialization") to
> propagate the setting for now.
> 
> Fixes: 4e88d4c08301 ("usb: add a flag to skip PHY initialization to struct usb_hcd")
> Fixes: 178a0bce05cb ("usb: core: hcd: integrate the PHY wrapper into the HCD core")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>

(tested on sc7x80 with '[gcc_]usb30_prim_gdsc' set to ALWAYS_ON)
