Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B39F54EBC0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378588AbiFPU7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378647AbiFPU7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:59:19 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09929606CB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:59:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h192so2300054pgc.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uyK50s9EkHN1pgwlRq5Dwy3BidE/OhrXFABhT7oGlPA=;
        b=nwzzgF7cOsgTaJ11NmMHaMAty8wE0fW9Ze5Qz5sg5yLR8bagED5e2RO4HyRQ76v+zP
         5job7iEdh5i0tHz/5eKylBTGvK9UwNt5nFbeHeNrJ+CQgt6V8xs/IiNbALUomcF6doUF
         YAF2gEmJsSH4vu9Q9bRedsEFCitXLaayOACM0qlx2jg4sS7+rmj9Po/k3WA/pYlI4wCt
         dP3qXtz2HwH6vBwGdiSQ23/6oblEVRj2+52C9VzurqvBmzyPxQLY9Et5BL9aQsfx0eW8
         VNv07xi8qpDNFcGwOTsuORNJEHNWYN1kvTuGGR+buPA0/2qe/0Avz9ecd5qQC3X+UuCP
         s4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uyK50s9EkHN1pgwlRq5Dwy3BidE/OhrXFABhT7oGlPA=;
        b=5FY8uqB+Pz51ETqS4qlIoSzir7hv5hT4LSzFWeYPfSvJBT11tQK1HmGRAgRa5dHCWX
         8zkhLWS1jjHPOZmR6ZbPFcegr7fOAmkHg6v8tM8ul86SsFvTqBOBLR6lC5gap9iox+7c
         dsqbVU0v/XlTzXN9ZwdoYaYvdLWJOWMyAyu+6pT+ESI9GVoycveEJLpf43YA2lxKga/S
         rvosRgdtrYJP2+IySle4ITSgDrib9LtJm5mZ9Y0gO7LlWCeTUicA/yksjWbPdkea4Sb4
         1y3gNoF82A9dckATDM3OzNrxYTpXZxPMTM4m9t+CLWRM2B+JT4MhVBj6Qk0Qo9s6zVkA
         uH4Q==
X-Gm-Message-State: AJIora/x0kr0E/VS7u66A5cVpeZhaDEEizyUWN89fJFnsOcudFGi0erB
        YVs2Khkyjlht3UnHD/wOUbv3rg==
X-Google-Smtp-Source: AGRyM1sRzfpE5VchXXUcungBiuvR3gNJzYsKFsQTMoIJXs8+VkN8CFy2nMp0xdY10PcLJVaFj4k/Lg==
X-Received: by 2002:a05:6a00:9a1:b0:51b:c452:34a9 with SMTP id u33-20020a056a0009a100b0051bc45234a9mr6662317pfg.34.1655413154549;
        Thu, 16 Jun 2022 13:59:14 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id 135-20020a62178d000000b0050dc762817esm2206074pfx.88.2022.06.16.13.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:59:14 -0700 (PDT)
Date:   Thu, 16 Jun 2022 21:59:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Subject: Re: [PATCH V15 2/9] dt-bindings: mfd: pm8008: Change the address
 cells
Message-ID: <YquZnHF5u/eMpO/y@google.com>
References: <1655200111-18357-1-git-send-email-quic_c_skakit@quicinc.com>
 <1655200111-18357-3-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1655200111-18357-3-git-send-email-quic_c_skakit@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022, Satya Priya wrote:

> Change the address cells as '2' so that the first cell
> describes the i2c address offset of the clients.
> This helps us to define the child nodes of all
> clients under the same parent mfd node, instead of
> adding separate mfd DT nodes.
> 
> Change the gpios reg value accordingly.
> 
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in V15:
>  - None.
> 
> Changes in V14:
>  - None.
> 
> Changes in V13:
>  - Fixed nit.
> 
>  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
