Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B404D24AF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 00:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiCHXNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 18:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiCHXND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 18:13:03 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9347A7EA29
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 15:12:00 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id k9-20020a056830242900b005ad25f8ebfdso471571ots.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 15:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NIeUfBbQiyEOaJvhbRmO4T1V+ggs7NcHxKpXGx3CcUg=;
        b=shaABnC1fz4XX6bf9zc6pc0ehX1xXu/6tiLr/y9kv8L9Ndwwm8LxlZzVLnVF+fKGpq
         Defj3bTg9qLEELpTMsADdsBEQnwBiakDiJQRbA9/435RDeKPcOhi3J0SZhiLWTu5tUs/
         7vn/KF2qEWk0wdUKHZ2UvfVO7hIzIafHHe2894rfEpjYMy7c4U5UdfDWa/7TazRAwhUl
         +ZKAZLhKXFH4EyNieGiCwaF8UBOmdLGpuiSk8MBsVdTqMgITUX38B1EJphDpuwnPsMTm
         /zd3ism7JgxVlb7b/SUHwdXqnxGbkT0vxywdlQr/wklTi9gjKOCs5HQW4/DYplgLpJoF
         HKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NIeUfBbQiyEOaJvhbRmO4T1V+ggs7NcHxKpXGx3CcUg=;
        b=QomzYB2ln1Q7E/wYnguJgKGyLhTc08szYqdl8J8Oqrf7qQhkqpNvqWr/J4Fl61b2/1
         2FkeGMFQKmdY3CIHgnlIsY2Cw2UsoxT5ArItg1oYKlQqjKm9377PUp629OdH9FOWx1se
         geLhGq1E1+EjRZB/i0gObOkQOh8Hdnl+AotPuDHuGu6EMzqxsjRh2jpR16rHp0fRvpUz
         uI6UWtwnWAfwxQSlVTlWLPR7XmpO8rbrGJTF55JMElPLGeJc6yJUZsuAgn1BzEBXu9c1
         v3xnSlRDOKpMOl2nfukaTcULjNXK6IYwMYcN4IAlIOox03gP4iLX/JtBDdyWTFAH0bQl
         bH5w==
X-Gm-Message-State: AOAM533s5OTp15f5ruq4sbXFQWEsxNB6v4R3Q0KTtt2jUiWlkQBvb0L7
        OjNA3a/6wctl+B8EuZUNngcXig==
X-Google-Smtp-Source: ABdhPJzRzJ+EfLNwSBtBRH4SshLivGux05CGMMfQj4fC2U66pqUfm6cTK4b6aH+2w5g9A1/Bh17tvg==
X-Received: by 2002:a9d:4604:0:b0:5b2:6100:7f11 with SMTP id y4-20020a9d4604000000b005b261007f11mr225949ote.300.1646781119901;
        Tue, 08 Mar 2022 15:11:59 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3-20020a056808114300b002d51f9b3263sm164287oiu.28.2022.03.08.15.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 15:11:59 -0800 (PST)
Date:   Tue, 8 Mar 2022 17:11:57 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, tdas@codeaurora.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        robh+dt@kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: net: qcom,ethqos: Document SM8150
 SoC compatible
Message-ID: <YifivcMNJ7KIOn37@builder.lan>
References: <20220303084824.284946-1-bhupesh.sharma@linaro.org>
 <20220303084824.284946-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303084824.284946-2-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Mar 02:48 CST 2022, Bhupesh Sharma wrote:

> From: Vinod Koul <vkoul@kernel.org>
> 
> SM8150 has a ethernet controller and needs a different configuration so
> add a new compatible for this
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

As you pass on Vinod's patch, you need to add your signed-off-by to
certify the origin of the patch.

Also please resubmit it (alone) to the networking list.

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/net/qcom,ethqos.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.txt b/Documentation/devicetree/bindings/net/qcom,ethqos.txt
> index fcf5035810b5..1f5746849a71 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ethqos.txt
> +++ b/Documentation/devicetree/bindings/net/qcom,ethqos.txt
> @@ -7,7 +7,9 @@ This device has following properties:
>  
>  Required properties:
>  
> -- compatible: Should be qcom,qcs404-ethqos"
> +- compatible: Should be one of:
> +		"qcom,qcs404-ethqos"
> +		"qcom,sm8150-ethqos"
>  
>  - reg: Address and length of the register set for the device
>  
> -- 
> 2.35.1
> 
