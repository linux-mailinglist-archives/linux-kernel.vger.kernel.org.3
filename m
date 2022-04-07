Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47454F857A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345933AbiDGREm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243010AbiDGREl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:04:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151481C9B44
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:02:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so9473367pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0ivtkeOg+kP/2Vx3yPWIEgDzLpCVU+G/AfaFqRH+wuI=;
        b=CRO266mD+o2s7koF4nsc9f25nTY4YXwNwNNuMVvyI0LMrzFKYWahos6STTpZ5neC4h
         4o9S52XkmugTW8mbObYEZe8W0PKvFs3qGrWlvbkFYE72ND3OJkRKXVjzMMbuHKDnn2gm
         J2RElLWCnPUy3hV5mZap4aMK87Ef7ffQu534E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ivtkeOg+kP/2Vx3yPWIEgDzLpCVU+G/AfaFqRH+wuI=;
        b=Kkb2Bxvov5kcaOgHCkWYGDAr4o+OFYuCqKkHhKcv/xjufDT47qSg5TmO/8P/HQkdcI
         WRai/PxEqCki+8eXCAXHh2LGPj0WUiXBet2+dHwGiB7UiLa7CZGxBQ+nyS1n+A/3+FEn
         Ix/SeNQAozUHt/18T/C1tdBat5bRPr4PlUksYwR601Hs2S+aWBz/73urINeFHx7AInJH
         hix5QlA8I6zs8EKaG/Vdj093kls/DqqPW5+pgpR3ADujK56lzpFdjdl1YVuhxPt29PJE
         lD892l17JMCgpmR7767iLmYoQxTMeJz2unzqJ1NNJ3W443VjfgqmhYy9s8/Kbxf5OxfX
         mVfQ==
X-Gm-Message-State: AOAM531Ba8XkVebF0C6fx/x2wNvpKHb3vGoQQ5QI4RJQi4CD7QAFHQi6
        qZkM1W0ckxKar/eK/3lWjOEWAw==
X-Google-Smtp-Source: ABdhPJxWXYdAsNC79MZ/ySTgeDtOWSsS2DzAYYQ0PUgvYMWlm10cm4+SYczDKvZ/0Ha8dc2pp0H8uw==
X-Received: by 2002:a17:902:cf05:b0:156:8445:ce0f with SMTP id i5-20020a170902cf0500b001568445ce0fmr14739893plg.99.1649350959495;
        Thu, 07 Apr 2022 10:02:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:693e:9ca0:42a0:6bf7])
        by smtp.gmail.com with UTF8SMTPSA id j9-20020aa78009000000b004fde2dd78b0sm18367272pfi.109.2022.04.07.10.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 10:02:38 -0700 (PDT)
Date:   Thu, 7 Apr 2022 10:02:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_kriskura@quicinc.com, quic_vpulyala@quicinc.com
Subject: Re: [PATCH v12 5/6] dt-bindings: usb: dwc3: Add wakeup-source
 property support
Message-ID: <Yk8ZLIvVXjQ88LSA@google.com>
References: <1649321104-31322-1-git-send-email-quic_c_sanm@quicinc.com>
 <1649321104-31322-6-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649321104-31322-6-git-send-email-quic_c_sanm@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 02:15:03PM +0530, Sandeep Maheswaram wrote:
> Added support for wakeup-source property. This property can be
> used to check and power down the phy during system suspend if
> wake up is not supported.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index f4471f8..4d4de2f 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -341,6 +341,11 @@ properties:
>        This port is used with the 'usb-role-switch' property  to connect the
>        dwc3 to type C connector.
>  
> +  wakeup-source:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Enable USB remote wakeup.
> +
>  unevaluatedProperties: false
>  
>  required:

nit: within the series this patch should be before "dt-bindings: usb: dwc3:
Add wakeup-source property support", which makes use of the new property.
If you have to re-spin for another reason please change the order.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
