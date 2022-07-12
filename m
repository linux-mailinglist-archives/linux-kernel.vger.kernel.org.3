Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358A1570EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiGLAeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiGLAed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:34:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C97128E28
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:34:32 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 5so5845190plk.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YEGCW3L9w6vpD4jzjiiKJZWjsQc0N/LncnKW15mwrD0=;
        b=aCgI0u564Jh00d8jVz1QrOfS995n8O1pprP0kz/EU2rdaXzIKwoLh/5VucQQzNlXf7
         0bYpIsU4//SgTm3R0BFfIzlZvCVeWA7MQzpxBpntb9KkKtzSnuX4oM9bpd6a32OqgjNY
         nih+bQgeacWqEBXTEsboMmi29jHeuDbvI8+Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YEGCW3L9w6vpD4jzjiiKJZWjsQc0N/LncnKW15mwrD0=;
        b=TI2RqDOtwB2JfP5kGzXY2w5052/F65U2RwNLe5/eZsvpHQ0vcqD5sdRK8AddmKhndH
         vOuYvYD++F6TC6b6pdihjhdI9h8ZahC3VM4o+PEag3qtuPgHcUjy9ovaG7gvBW37xwbA
         oZIuofsUHJAN5UmjZtbc2S9316OLgM3x3T3QpTJ+GGRt/pdScyTOKQH34eOcr+cnbp8w
         995eOtXJiyCHQohIiPE+Fayw2PCioecj0oG3OoqhXx5kei44MDJid+jY9A/NbXCmU44t
         7S5lPg342697NwH6z+K/OnwaWnbUC4vtqM7HRHRJ2CZuhycuxdTeNf67NpBgtw9mcorZ
         bX1Q==
X-Gm-Message-State: AJIora+0eq82nw/HGG61jrVdicyQULpCE2tbk24li7YHAaEMNFt0MxZX
        Sy+eQR/Tw7egtvfEkJmP42R9Zw==
X-Google-Smtp-Source: AGRyM1u59Vu859pze58RyVUtWiruDXKRMBn08hKepU6kCfuz9ViyELgLctATU4O7kdQ8cGpeZjzQEA==
X-Received: by 2002:a17:90a:408f:b0:1d1:d1ba:2abb with SMTP id l15-20020a17090a408f00b001d1d1ba2abbmr1157511pjg.152.1657586071764;
        Mon, 11 Jul 2022 17:34:31 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:7b75:79f4:3be2:2c65])
        by smtp.gmail.com with UTF8SMTPSA id p2-20020a170902e74200b0016c57657977sm706817plf.41.2022.07.11.17.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 17:34:31 -0700 (PDT)
Date:   Mon, 11 Jul 2022 17:34:29 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v4 2/2] PCI: qcom: Restrict pci transactions after pci
 suspend
Message-ID: <YszBlUbQ6KSwOkWV@google.com>
References: <1656684800-31278-1-git-send-email-quic_krichai@quicinc.com>
 <1657118425-10304-1-git-send-email-quic_krichai@quicinc.com>
 <1657118425-10304-3-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1657118425-10304-3-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 08:10:25PM +0530, Krishna chaitanya chundru wrote:
> If the endpoint device state is D0 and irq's are not freed, then
> kernel try to mask interrupts in system suspend path by writing
> in to the vector table (for MSIX interrupts) and config space (for MSI's).
> 
> These transactions are initiated in the pm suspend after pcie clocks got
> disabled as part of platform driver pm  suspend call. Due to it, these
> transactions are resulting in un-clocked access and eventually to crashes.
> 
> So added a logic in qcom driver to restrict these unclocked access.
> And updated the logic to check the link state before masking
> or unmasking the interrupts.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 14 +++++++--
>  drivers/pci/controller/dwc/pcie-qcom.c            | 36 +++++++++++++++++++++--
>  2 files changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 2fa86f3..2a46b40 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -29,13 +29,23 @@ static void dw_msi_ack_irq(struct irq_data *d)
>  
>  static void dw_msi_mask_irq(struct irq_data *d)
>  {
> -	pci_msi_mask_irq(d);
> +	struct pcie_port *pp = irq_data_get_irq_chip_data(d->parent_data);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	if (dw_pcie_link_up(pci))
> +		pci_msi_mask_irq(d);
> +
>  	irq_chip_mask_parent(d);
>  }
>  
>  static void dw_msi_unmask_irq(struct irq_data *d)
>  {
> -	pci_msi_unmask_irq(d);
> +	struct pcie_port *pp = irq_data_get_irq_chip_data(d->parent_data);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	if (dw_pcie_link_up(pci))
> +		pci_msi_unmask_irq(d);
> +
>  	irq_chip_unmask_parent(d);
>  }
>  
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0a9d1ee..78bc463 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1342,11 +1342,41 @@ static int qcom_pcie_suspend_2_7_0(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> +static u32 qcom_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> +				u32 reg, size_t size)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	u32 val;
> +
> +	if (pcie->is_suspended)
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	dw_pcie_read(base + reg, size, &val);
> +	return val;
> +}
> +
> +static void qcom_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
> +				u32 reg, size_t size, u32 val)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +
> +	if (pcie->is_suspended)
> +		return;
> +
> +	dw_pcie_write(base + reg, size, val);
> +}
> +
>  static int qcom_pcie_link_up(struct dw_pcie *pci)
>  {
> -	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	u16 val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	u16 offset;
> +	u16 val;
> +
> +	if (pcie->is_suspended)
> +		return false;
>  
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
>  	return !!(val & PCI_EXP_LNKSTA_DLLLA);
>  }
>  
> @@ -1590,6 +1620,8 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  	.start_link = qcom_pcie_start_link,
> +	.read_dbi = qcom_pcie_read_dbi,
> +	.write_dbi = qcom_pcie_write_dbi,
>  };
>  
>  static int qcom_pcie_probe(struct platform_device *pdev)

This patch fixes an issue that is introduced by the previous patch of the
series, i.e. the first patch can not be applied by itself without breaking
things. This is generally avoided as it complicates bisecting.

This patch should be before 'PCI: qcom: Add system PM support' in the series
(which obviously requires shuffling where the 'is_suspended' flag is added).
With that the series can be applied partially without introducing unclocked
reads or writes.
