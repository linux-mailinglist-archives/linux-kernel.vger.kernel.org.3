Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27917543F0E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiFHWSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiFHWR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:17:58 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F65C35868
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 15:17:55 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-f2a4c51c45so28988925fac.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 15:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=sjggaWHpjbyPFtlZQEJUzFJDBjr7IqTMh+s2+xOurSk=;
        b=Dtey83E7P4XRafF2kgiWH0Nqj5Cu/jeuMmiOiioNWcp94xnELMeJ1RLV2iLC42j0Aw
         vCmjggpU3Yl6QpeWoegxYrh6J7IDD8XSIdZ2dxl8ayz6AqICySZnX6Thyqq1YqdkfE0I
         Q2WHDA+Oabqn8z0zRq7k93+lKjUbaR/QzPGB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=sjggaWHpjbyPFtlZQEJUzFJDBjr7IqTMh+s2+xOurSk=;
        b=Ac+hulIh8cJAoesh9Ey2626s3dw3lX8wJOzVgTZAfing6692cKPgmZcZI6ND2tIK6e
         zlVWdqZP22Z47K+9AmwD3PjOaWWTWp2u24Fr0tk5s0i4c/INmRf20BqRdhYkUzBCfjr3
         eey/CZastGIhKAMmjrnhGYUOs5tUyi8NfDXOVln3prR15m3bkTn+Uvmpe6GfKI+WG5Y0
         CFLbgRcrpU4X5PEHQWeitka2uIjoJ24ee69rrMRpTwY1hZsYdSLYN9yk4H5/31gjLfjR
         qCy6MORNznFAP3QDSUZQf17yBvquiuwnxMw2XUO5xBovVcSD1wUXrryW4PPKDoMRk7hI
         lkcA==
X-Gm-Message-State: AOAM5302WW+GfQZxfEeEqNLqeXRRDUWFCDQIpSMBP+CJiezsuLCdCyOc
        IT/R+i8BlJn+vbV1jCPXMiPlX+aWXfdViTd7zLBmCw==
X-Google-Smtp-Source: ABdhPJxjhinNFopJWfMD6r4u711h/8HphOSbID6Nj3U0jXyaNq7zLF2fz4Du5aIyA170mLwnTOdfDEPL4IFLBfactqI=
X-Received: by 2002:a05:6870:b381:b0:fe:2004:b3b5 with SMTP id
 w1-20020a056870b38100b000fe2004b3b5mr93795oap.63.1654726674487; Wed, 08 Jun
 2022 15:17:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jun 2022 15:17:54 -0700
MIME-Version: 1.0
In-Reply-To: <1654240730-31322-1-git-send-email-quic_krichai@quicinc.com>
References: <1654240730-31322-1-git-send-email-quic_krichai@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 8 Jun 2022 15:17:54 -0700
Message-ID: <CAE-0n52hpKxMG=gq1rPGx0cM2VKNRo+WHVW+ExCScJ8UwZKgGA@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: qcom: Allow L1 and its sub states on qcom dwc wrapper
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krishna chaitanya chundru (2022-06-03 00:18:50)
> Allow L1 and its sub-states in the qcom dwc pcie wrapper.
> By default its disabled. So enable it explicitly.
>

Would be good to add some more details about why it's disabled by
default. I guess it's disabled by default in the hardware and enabling
it is OK to do unconditionally for all qcom dwc pcie devices?
