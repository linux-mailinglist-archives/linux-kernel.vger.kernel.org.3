Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CC7474D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 22:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhLNVcl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Dec 2021 16:32:41 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:50666 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231331AbhLNVck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 16:32:40 -0500
Received: from [77.244.183.192] (port=62494 helo=[192.168.178.41])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mxFPa-0003ft-3B; Tue, 14 Dec 2021 22:32:38 +0100
Subject: Re: drivers/pci/controller/dwc/pci-dra7xx.c:864 dra7xx_pcie_probe()
 warn: 'dra7xx->clk' not released on lines: 759.
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>
References: <202111301803.NOwoj4Jd-lkp@intel.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <1521f09a-605a-746c-aabd-9cb036578a6f@lucaceresoli.net>
Date:   Tue, 14 Dec 2021 22:32:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <202111301803.NOwoj4Jd-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: it-IT
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan, All,

On 30/11/21 12:04, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d58071a8a76d779eedab38033ae4c821c30295a5
> commit: 5af9405397bfb90d6adab61d58f4d94c78166698 PCI: dra7xx: Get an optional clock
> config: powerpc64-randconfig-m031-20211128 (https://download.01.org/0day-ci/archive/20211130/202111301803.NOwoj4Jd-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/pci/controller/dwc/pci-dra7xx.c:864 dra7xx_pcie_probe() warn: 'dra7xx->clk' not released on lines: 759.
> 
> vim +864 drivers/pci/controller/dwc/pci-dra7xx.c
> 
> e259c2926c016d drivers/pci/controller/dwc/pci-dra7xx.c Tony Lindgren          2021-03-10  684  static int dra7xx_pcie_probe(struct platform_device *pdev)
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  685  {
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  686  	u32 reg;
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  687  	int ret;
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  688  	int irq;
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  689  	int i;
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  690  	int phy_count;
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  691  	struct phy **phy;
> 7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  692  	struct device_link **link;
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  693  	void __iomem *base;
> 442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  694  	struct dw_pcie *pci;
> 442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  695  	struct dra7xx_pcie *dra7xx;
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  696  	struct device *dev = &pdev->dev;
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  697  	struct device_node *np = dev->of_node;
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  698  	char name[10];
> 602d38bc65aa29 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-01-11  699  	struct gpio_desc *reset;
> 608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  700  	const struct of_device_id *match;
> 608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  701  	const struct dra7xx_pcie_of_data *data;
> 608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  702  	enum dw_pcie_device_mode mode;
> c232c0df9610bf drivers/pci/controller/dwc/pci-dra7xx.c Kishon Vijay Abraham I 2019-01-24  703  	u32 b1co_mode_sel_mask;
> 608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  704  
> 608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  705  	match = of_match_device(of_match_ptr(of_dra7xx_pcie_match), dev);
> 608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  706  	if (!match)
> 608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  707  		return -EINVAL;
> 608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  708  
> 608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  709  	data = (struct dra7xx_pcie_of_data *)match->data;
> 608793e27b3313 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-03-27  710  	mode = (enum dw_pcie_device_mode)data->mode;
> c232c0df9610bf drivers/pci/controller/dwc/pci-dra7xx.c Kishon Vijay Abraham I 2019-01-24  711  	b1co_mode_sel_mask = data->b1co_mode_sel_mask;
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  712  
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  713  	dra7xx = devm_kzalloc(dev, sizeof(*dra7xx), GFP_KERNEL);
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  714  	if (!dra7xx)
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  715  		return -ENOMEM;
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  716  
> 442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  717  	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> 442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  718  	if (!pci)
> 442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  719  		return -ENOMEM;
> 442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  720  
> 442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  721  	pci->dev = dev;
> 442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  722  	pci->ops = &dw_pcie_ops;
> 442ec4c04d1235 drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-02-15  723  
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  724  	irq = platform_get_irq(pdev, 0);
> caecb05c800081 drivers/pci/controller/dwc/pci-dra7xx.c Krzysztof Wilczyński   2020-08-02  725  	if (irq < 0)
> a0d21ba120d2c7 drivers/pci/dwc/pci-dra7xx.c            Gustavo A. R. Silva    2017-08-09  726  		return irq;
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  727  
> c8a119779f5609 drivers/pci/controller/dwc/pci-dra7xx.c Wei Yongjun            2020-04-29  728  	base = devm_platform_ioremap_resource_byname(pdev, "ti_conf");
> c8a119779f5609 drivers/pci/controller/dwc/pci-dra7xx.c Wei Yongjun            2020-04-29  729  	if (IS_ERR(base))
> c8a119779f5609 drivers/pci/controller/dwc/pci-dra7xx.c Wei Yongjun            2020-04-29  730  		return PTR_ERR(base);
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  731  
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  732  	phy_count = of_property_count_strings(np, "phy-names");
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  733  	if (phy_count < 0) {
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  734  		dev_err(dev, "unable to find the strings\n");
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  735  		return phy_count;
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  736  	}
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  737  
> a86854d0c599b3 drivers/pci/dwc/pci-dra7xx.c            Kees Cook              2018-06-12  738  	phy = devm_kcalloc(dev, phy_count, sizeof(*phy), GFP_KERNEL);
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  739  	if (!phy)
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  740  		return -ENOMEM;
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  741  
> a86854d0c599b3 drivers/pci/dwc/pci-dra7xx.c            Kees Cook              2018-06-12  742  	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
> 7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  743  	if (!link)
> 7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  744  		return -ENOMEM;
> 7a4db656a6350f drivers/pci/dwc/pci-dra7xx.c            Kishon Vijay Abraham I 2017-10-09  745  
> 5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  746  	dra7xx->clk = devm_clk_get_optional(dev, NULL);
> 5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  747  	if (IS_ERR(dra7xx->clk))
> 5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  748  		return dev_err_probe(dev, PTR_ERR(dra7xx->clk),
> 5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  749  				     "clock request failed");
> 5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  750  
> 5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  751  	ret = clk_prepare_enable(dra7xx->clk);
> 5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  752  	if (ret)
> 5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  753  		return ret;
> 5af9405397bfb9 drivers/pci/controller/dwc/pci-dra7xx.c Luca Ceresoli          2021-05-31  754  
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  755  	for (i = 0; i < phy_count; i++) {
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  756  		snprintf(name, sizeof(name), "pcie-phy%d", i);
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  757  		phy[i] = devm_phy_get(dev, name);
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  758  		if (IS_ERR(phy[i]))
> 47ff3de911a728 drivers/pci/host/pci-dra7xx.c           Kishon Vijay Abraham I 2014-07-22  759  			return PTR_ERR(phy[i]);
> 
> Smatch wants an clk_unprepare_disable(dra7xx->clk) on failure paths.

+linux-clk

Looks like I assumed a devm-managed clock is disabled and unprepared on
error. But apparently I was wrong and only deallocation happens
automatically, at least it's what I could get from reading the code.

I'm sending a patch to fix this.

-- 
Luca

