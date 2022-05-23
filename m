Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81155314A6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbiEWQKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbiEWQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEFB264738
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653322215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRKL91EqCGrYR3jhbmoJxjNS6DqoFl91Xh8EB9KpYsw=;
        b=FeraEF1g+YYYTzXzWdV2CdrvuTx6W9IrB1PPEObu+PDoKrSrQBxB/mOgBz0of859YC/RZA
        FvDdxeP1m6J+7hWqXaHdtsEq/Cma18zD6CmMrQWT2G8AyqHT/Bdp2Ff+MZbYvoNUn22/uu
        K81PwAQblR7uwwyB3tk7k6THUnRlj6Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-CbY9HITmP8S5Dc7eNXS4OA-1; Mon, 23 May 2022 12:10:12 -0400
X-MC-Unique: CbY9HITmP8S5Dc7eNXS4OA-1
Received: by mail-qt1-f200.google.com with SMTP id a6-20020ac81086000000b002f65fd83048so11873883qtj.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uRKL91EqCGrYR3jhbmoJxjNS6DqoFl91Xh8EB9KpYsw=;
        b=muZZgDuT7A5Hmwl1m3a1WnX5t9OItqC5BfqlBBV8gQRGnS9oYZZKv4f0rYF8xymuph
         fhN8F5MIzbvumzKDNrPzqlMW/EouNxioWKMx3qPbdRKq6bjoSFP8+mF9nXtKXzWoc9+C
         H202FqhU9DbCHFqWn1EO+SvHez3QGWjneem6B0QfS95dSOHheIN7pftI7Xff9cSyox8q
         SVJu2dStf3wkOuPoRBJvz/+fPbQXrYxIaXtSTNAaMPPmRyG/K2LyyMXFHw1YM6jv7Ibz
         ZW53+TPUJkONMMezewPU37CJ2gj3YeW66y5m8hdJtnWWe0jGn+fkHOO1J4IidRuN8aki
         wa8w==
X-Gm-Message-State: AOAM532WMLDkotG0t+BYkLXAGWO6SvujS8kv3Do7VI4AllwX8GuYDiEa
        uMBgVXxN0MQMULKmR/yZVIVfMyeKsyliT84v9DhNPW4par6obp+L/RUb8V78kB67Jw+LYWpgHX2
        QozNCwV22QXVnJCmeaynheHqm
X-Received: by 2002:a05:620a:178d:b0:6a4:61f1:742a with SMTP id ay13-20020a05620a178d00b006a461f1742amr691916qkb.523.1653322212137;
        Mon, 23 May 2022 09:10:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJww1EFdhXdnjSHa1uTotEqVgJ5iYRqKpJaihahEbjr36wXhmpyPJZYwVC3c1eGAq35iKZ0Q1A==
X-Received: by 2002:a05:620a:178d:b0:6a4:61f1:742a with SMTP id ay13-20020a05620a178d00b006a461f1742amr691896qkb.523.1653322211904;
        Mon, 23 May 2022 09:10:11 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id u3-20020a05622a198300b002f92a5a396esm4907505qtc.3.2022.05.23.09.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 09:10:11 -0700 (PDT)
Date:   Mon, 23 May 2022 12:10:10 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Harsh Agarwal <quic_harshq@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com
Subject: Re: [RFC 2/2] usb: dwc3: Refactor PHY logic to support Multiport
 Controller
Message-ID: <Youx4uztX0RNRVkd@xps13>
References: <1652963695-10109-1-git-send-email-quic_harshq@quicinc.com>
 <1652963695-10109-3-git-send-email-quic_harshq@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652963695-10109-3-git-send-email-quic_harshq@quicinc.com>
User-Agent: Mutt/2.2.1 (2022-02-19)
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 06:04:55PM +0530, Harsh Agarwal wrote:
> -	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
> -	if (IS_ERR(dwc->usb3_generic_phy)) {
> -		ret = PTR_ERR(dwc->usb3_generic_phy);
> -		if (ret == -ENOSYS || ret == -ENODEV)
> -			dwc->usb3_generic_phy = NULL;
> -		else
> -			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
> +		if (IS_ERR(dwc->usb2_phy[0])) {
> +			ret = PTR_ERR(dwc->usb2_phy[0]);
> +			if (ret == -ENXIO || ret == -ENODEV)
> +				dwc->usb2_phy[0] = NULL;
> +			else
> +				return dev_err_probe(dev, ret, "no usb2 phy configured\n");
> +		}
> +
> +		if (IS_ERR(dwc->usb3_phy[0])) {
> +			ret = PTR_ERR(dwc->usb3_phy[0]);
> +			if (ret == -ENXIO || ret == -ENODEV)
> +				dwc->usb3_phy[0] = NULL;
> +			else
> +				return dev_err_probe(dev, ret, "no usb3 phy configured\n");
> +		}
> +
> +		dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
> +		if (IS_ERR(dwc->usb2_generic_phy)) {
> +			ret = PTR_ERR(dwc->usb2_generic_phy);
> +			if (ret == -ENOSYS || ret == -ENODEV)
> +				dwc->usb2_generic_phy = NULL;
> +			else
> +				return dev_err_probe(dev, ret, "no usb2 phy configured\n");
> +		}

I know that this block is a copy and paste move from above, but is the
ENOSYS check really needed? It looks like the phy_get() only returns
-ENODEV.

> @@ -1147,8 +1149,10 @@ struct dwc3 {
>  
>  	struct reset_control	*reset;
>  
> -	struct usb_phy		*usb2_phy;
> -	struct usb_phy		*usb3_phy;
> +	struct usb_phy		**usb2_phy;
> +	struct usb_phy		**usb3_phy;
> +	u32			num_hsphy;
> +	u32			num_ssphy;

Rename num_hsphy / num_ssphy to num_usb2_phy and num_usb3_phy so this is
easier to audit.

Brian

