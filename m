Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3488959C3B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbiHVQG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiHVQG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:06:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058CA2D1EE
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:06:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so11785984pjf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=49YUdvvcH4sXkXjjBRb7TPrNyN9ePD7bMnp4Wg/4Iuw=;
        b=WgdfrzymkqsLxn28d9609+2UnLaQqq1u7agL5Saw8zFhDUT3vW8lejynk/41Pj0NP1
         d9CDXKGyqbEW6dCbQeqsT0X+gZ3yJMEhYcms1FZyVkXebVqSupbmlkbzwyPrwOxGqka2
         aZfnVwtEndYLPpG8w1o75AqSVjjG2WvdH9asM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=49YUdvvcH4sXkXjjBRb7TPrNyN9ePD7bMnp4Wg/4Iuw=;
        b=7u321ZiWvDVn3SWgsdgIzg0tdrGkCIPvOcnLYKzdPKJVqgepjuBY1Lr1CJoLsp7LVq
         i9txcuWrfUbc1knd3Wgx5fIVXGsaZ/NWRznLX93dJWvS1EHUFGvCzQiFBHzxB8WQWHYr
         oSxAjeyyrVTcmch22Uu7Pv3UD3YxFhR0J9+CXafiJURbE9ses62kCcm6hOvz+QV9UjU6
         YgcZAs1iYpFOT7ajSX9boXJodgpjWuONmqDk1B7OQFQQqCZV4XLF03xq3izpCyS+Abas
         zNtQDtVr7TGWnuJKy4l7HVObJVjZyUu/XN/h+P46+r0MMLR5APB5GjkQW0pqpYTU7Qtb
         pYZA==
X-Gm-Message-State: ACgBeo06fTo4HbbFI8itGMEmwxU3sHil54u8lZxh0Vo/HqiAWI0MJ1/p
        yzQz5xocIFqWtwBf2f8ItNDqDQ==
X-Google-Smtp-Source: AA6agR5M4n+nXMrD2/te4CpsrB4wdwKrC3DPCrc4JKLmB8Q3c7ZyU0dK1Bt+jo+mZejIfeDA7lBjzQ==
X-Received: by 2002:a17:902:f70a:b0:170:c5e7:874c with SMTP id h10-20020a170902f70a00b00170c5e7874cmr20703386plo.109.1661184415098;
        Mon, 22 Aug 2022 09:06:55 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:1969:d650:d765:53ef])
        by smtp.gmail.com with UTF8SMTPSA id q12-20020a170902dacc00b0017269cc60d7sm8602620plx.214.2022.08.22.09.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 09:06:54 -0700 (PDT)
Date:   Mon, 22 Aug 2022 09:06:52 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: move USB wakeup-source property
Message-ID: <YwOpnApjcZI8BXU5@google.com>
References: <20220802152642.2516-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220802152642.2516-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 05:26:42PM +0200, Johan Hovold wrote:
> Move the USB-controller wakeup-source property to the dwc3 glue node to
> match the updated binding.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
