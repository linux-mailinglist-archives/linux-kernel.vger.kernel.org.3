Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464D455A111
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiFXSbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiFXSbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:31:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624057E013
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:31:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d5so2772261plo.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7UZMPMhDZHwhruUP/gy07hdb/n6RU3gIUBFH2x6pR/E=;
        b=OzJxyJkgM0vPngbknpX9j+vS0DyzJx/Y7jlWmi4L4mtZaouBN8j5a82S7tkUPOViXk
         Sj/2UTqLMdbbwxsMDcmiY6BrW3Ta01AdBZzSb7cMNKaWBxQZCxu6R9IuCquOQnQUhpPA
         0BHrTGS57awX289R4o9EwS6PC7nTF2GJewB9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7UZMPMhDZHwhruUP/gy07hdb/n6RU3gIUBFH2x6pR/E=;
        b=ykK7YIjcVr+Cn3dBtdL/pj33zula1Hfx8LwuXhH53SH4mP0UKQ5BBqaC4c24YyhaCF
         e3pqBMSQp2VbKFaxhWXLoIerR9Ica//6g+t+l6TcCW4Bqb+m9HhkZTzLnd2Wb6ZUCXLY
         AhNttN6vAwlXQsI3Ynvbco7GlA4opYx4FgqNHRaVfsmIdsBaN2obeHB9BLHVfSo+YM7c
         Dc+bbsOMNYK5a5HrJ21GODJppTIgq3984I1Rwzt2ABEcska4pOguoU7ZDfKoQJ3MqrOu
         gdQ1X42HOJN6m6BOPkxn7xs95b6Uut/0WN4t6ggKEpGTCeq8GcMNMeMHmLFC8ThD6hjb
         KB6w==
X-Gm-Message-State: AJIora8zV26wr1/C1oPYfbyMnTgNPYQ3OH1GOtcWKo/oKm1M332EUNxq
        PFKYOkMbkv9UbreaoTa/Xv8ZiA==
X-Google-Smtp-Source: AGRyM1uMM2ZoIYSFehnqHolpsYBxnGcZUaFDORWDi05jODl4um7df6RKhhwxrb8uxB0JMS5Xs2o3vg==
X-Received: by 2002:a17:903:2494:b0:168:fee7:6daa with SMTP id p20-20020a170903249400b00168fee76daamr476085plw.39.1656095492888;
        Fri, 24 Jun 2022 11:31:32 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:2d5:7aa9:cf0a:7d28])
        by smtp.gmail.com with UTF8SMTPSA id c10-20020a17090a020a00b001cd4989febcsm4389374pjc.8.2022.06.24.11.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 11:31:32 -0700 (PDT)
Date:   Fri, 24 Jun 2022 11:31:30 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/2] PCI: qcom: Add system PM support
Message-ID: <YrYDAtzI5g2gdmqu@google.com>
References: <1656055682-18817-1-git-send-email-quic_krichai@quicinc.com>
 <1656055682-18817-2-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1656055682-18817-2-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 12:58:01PM +0530, Krishna chaitanya chundru wrote:
> Add suspend and resume pm callbacks.
> 
> When system suspends, and if the link is in L1ss, disable the clocks
> so that system enters into low power state to save the maximum power.
> And when the system resumes, enable the clocks back if they are
> disabled in the suspend path.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

On which tree is this series based on?

With v5.19-rc3 I get:

  CC      drivers/pci/controller/dwc/pcie-qcom.o
/mnt/host/source/src/third_party/kernel/v5.15/drivers/pci/controller/dwc/pcie-qcom.c:1658:26: error: cannot assign to non-static data member 'cfg' with const-qualified type 'const struct qcom_pcie_cfg *'
        pcie->cfg->is_suspended = false;
        ~~~~~~~~~~~~~~~~~~~~~~~ ^
/mnt/host/source/src/third_party/kernel/v5.15/drivers/pci/controller/dwc/pcie-qcom.c:218:30: note: non-static data member 'cfg' declared const here
        const struct qcom_pcie_cfg *cfg;
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
/mnt/host/source/src/third_party/kernel/v5.15/drivers/pci/controller/dwc/pcie-qcom.c:1721:2: error: use of undeclared identifier 'val'
        val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
        ^
/mnt/host/source/src/third_party/kernel/v5.15/drivers/pci/controller/dwc/pcie-qcom.c:1722:8: error: use of undeclared identifier 'val'
        if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
              ^
/mnt/host/source/src/third_party/kernel/v5.15/drivers/pci/controller/dwc/pcie-qcom.c:1733:26: error: cannot assign to non-static data member 'cfg' with const-qualified type 'const struct qcom_pcie_cfg *'
        pcie->cfg->is_suspended = true;
        ~~~~~~~~~~~~~~~~~~~~~~~ ^
/mnt/host/source/src/third_party/kernel/v5.15/drivers/pci/controller/dwc/pcie-qcom.c:218:30: note: non-static data member 'cfg' declared const here
        const struct qcom_pcie_cfg *cfg;
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
/mnt/host/source/src/third_party/kernel/v5.15/drivers/pci/controller/dwc/pcie-qcom.c:1749:9: error: no member named 'ops' in 'struct qcom_pcie'
                pcie->ops->enable_clks(pcie);
                ~~~~  ^
/mnt/host/source/src/third_party/kernel/v5.15/drivers/pci/controller/dwc/pcie-qcom.c:1752:9: error: no member named 'ops' in 'struct qcom_pcie'
                pcie->ops->post_init(pcie);
                ~~~~  ^
/mnt/host/source/src/third_party/kernel/v5.15/drivers/pci/controller/dwc/pcie-qcom.c:1754:26: error: cannot assign to non-static data member 'cfg' with const-qualified type 'const struct qcom_pcie_cfg *'
        pcie->cfg->is_suspended = false;
        ~~~~~~~~~~~~~~~~~~~~~~~ ^
/mnt/host/source/src/third_party/kernel/v5.15/drivers/pci/controller/dwc/pcie-qcom.c:218:30: note: non-static data member 'cfg' declared const here
        const struct qcom_pcie_cfg *cfg;
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
7 errors generated.
