Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E6348DAD9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbiAMPoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:44:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:29323 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233305AbiAMPoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:44:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642088652; x=1673624652;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=m75ld79nt8TPm8DDWMvOut/woD0VIiTUU3VSnhxSZAQ=;
  b=kLcWrcJEZ81fUTy1gOnvx5G1SlahtYPU0Lm2EBvxWf6sBF1/vbABS59/
   gtqT7mlwE+RoKlZx8tt2PfRDVWJOB8imxb2YDiW/9qQ0vHRFw2kl31NhY
   WuI6C36HHHumMNWcSMi95O67kftjuEMaEePEbKCUPGp54yADil0V6+uJw
   Fmp5Rx4afh85qb3JJHEhQ5ARcueNY4aXbyx25QTkdGIpwjji4ZEHrwXw+
   rNsHKwRAdBmP9gERiV6nICEeZZ5FNwYwNI3BwNBR3agFXqMxM1nCiuu+W
   qc1IOH/jTdWruj43pwmivKcinDLQEep+lJ0VkeH+jd2oQ6pQ7YBya8fsx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="231380963"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="231380963"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 07:44:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="620639268"
Received: from ypchen-mobl.amr.corp.intel.com (HELO [10.212.66.70]) ([10.212.66.70])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 07:44:11 -0800
Subject: Re: [PATCH 3/6] ASoC: amd: acp: Add generic PCI driver module for ACP
 device
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Vijendar.Mukunda@amd.com, Alexander.Deucher@amd.com,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Bard Liao <bard.liao@intel.com>
References: <20220113092842.432101-1-AjitKumar.Pandey@amd.com>
 <20220113092842.432101-4-AjitKumar.Pandey@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9da4d004-5fc3-125a-4e60-f0a6a4007d2b@linux.intel.com>
Date:   Thu, 13 Jan 2022 09:27:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113092842.432101-4-AjitKumar.Pandey@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
> +{
> +	struct platform_device_info pdevinfo;
> +	struct device *dev = &pci->dev;
> +	const struct resource *res_acp;
> +	struct acp_chip_info *chip;
> +	struct resource *res;
> +	unsigned int flag, addr, num_res, i;
> +	int ret;
> +
> +	flag = snd_amd_acp_find_config(pci);
> +	if (flag != FLAG_AMD_LEGACY)
> +		return -ENODEV;
> +
> +	chip = devm_kzalloc(&pci->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	if (pci_enable_device(pci)) {
> +		dev_err(&pci->dev, "pci_enable_device failed\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = pci_request_regions(pci, "AMD ACP3x audio");
> +	if (ret < 0) {
> +		dev_err(&pci->dev, "pci_request_regions failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	pci_set_master(pci);
> +
> +	switch (pci->revision) {
> +	case 0x01:
> +		res_acp = acp3x_res;
> +		num_res = ARRAY_SIZE(acp3x_res);
> +		chip->name = "acp_asoc_renoir";
> +		chip->acp_rev = ACP3X_DEV;
> +		break;
> +	default:
> +		dev_err(dev, "Unsupported device revision:0x%x\n", pci->revision);
> +		return -EINVAL;
> +	}
> +
> +	dmic_dev = platform_device_register_data(dev, "dmic-codec", PLATFORM_DEVID_NONE, NULL, 0);
> +	if (IS_ERR(dmic_dev)) {
> +		dev_err(dev, "failed to create DMIC device\n");
> +		return PTR_ERR(dmic_dev);
> +	}

Past this point, any error handling needs to use
platform_device_unregister(dmic_dev);
...

> +	addr = pci_resource_start(pci, 0);
> +	chip->base = devm_ioremap(&pci->dev, addr, pci_resource_len(pci, 0));
> +
> +	res = devm_kzalloc(&pci->dev, sizeof(struct resource) * num_res, GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;

...which is missed here.

> +
> +	for (i = 0; i < num_res; i++, res_acp++) {
> +		res[i].name = res_acp->name;
> +		res[i].flags = res_acp->flags;
> +		res[i].start = addr + res_acp->start;
> +		res[i].end = addr + res_acp->end;
> +		if (res_acp->flags == IORESOURCE_IRQ) {
> +			res[i].start = pci->irq;
> +			res[i].end = res[i].start;
> +		}
> +	}
> +
> +	memset(&pdevinfo, 0, sizeof(pdevinfo));
> +
> +	pdevinfo.name = chip->name;
> +	pdevinfo.id = 0;
> +	pdevinfo.parent = &pci->dev;
> +	pdevinfo.num_res = num_res;
> +	pdevinfo.res = &res[0];
> +	pdevinfo.data = chip;
> +	pdevinfo.size_data = sizeof(*chip);
> +
> +	pdev = platform_device_register_full(&pdevinfo);
> +	if (IS_ERR(pdev)) {
> +		dev_err(&pci->dev, "cannot register %s device\n", pdevinfo.name);
> +		platform_device_unregister(dmic_dev);
> +		ret = PTR_ERR(pdev);
> +	}
> +
> +	return ret;
> +};

