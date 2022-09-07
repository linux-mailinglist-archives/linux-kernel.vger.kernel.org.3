Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250155B0FB0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiIGWNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIGWNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:13:13 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D02AEDB7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662588790; x=1694124790;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V+0k4SbulDK21C0d7Ev+pAWQlueHvqwL6BErGZBgVdU=;
  b=W8ZnKwQazJlVWs3yVjMrVoAxXfDTNLNexywtnAOkXfJxrboFbWlGQ2Sb
   umxWcPYsDr2EiIXREVmUbPFyyPlTlgZB3GqUwbmjvAJuS0REVmAcpN4Zt
   lPBtbD4aHdvZ3kRdRxPaT9vJsWZQX6GnQ1NwoQRYiLFjQ38vrmpEM/mSX
   Xyqmu0HJ6DvY9kref7conX3EYSGIP0ePyAvKHCgUq+w1uFAlTUn0BcyI2
   meMaRpyonUDTvx2BSdBHcZwSj48nKTIRFraeHAq9Ad9hm0Wjj747Kr70a
   kGLDQ7w2JviuohpSMJKfuw1/dndk2uCERa/L3CEBalUeAc/k0hOjLiu6c
   g==;
X-IronPort-AV: E=Sophos;i="5.93,298,1654531200"; 
   d="scan'208";a="215942164"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2022 06:13:08 +0800
IronPort-SDR: Hg9jc1Np4q/2TsXfgvNVEkR22kzx49c9GQHhJYdLKxvmW8usQmoJL8Cub9adpZ9Qn9PHtdjNin
 4swTaoFKWdxoOh2ZQpYCBsh/qha4D48Z3sZjr7p1cpCG9Wzb9DQGk6R8ct8cUx7gS1phnqcVU7
 kbyQNLl9/C/x+zv30xJGJHhJz6YpM1ebGBxIwoINwp+Vm3LFocqVVYXno5LZpgRkp/8iMVt+6Y
 QfGfIFQa7d9h4Pq/Ac4flXElofHHcOE10Y3EJLQPB/6fivdnf206HxBXlhUsJdLovnL1TVoJ5Q
 1tcJ3yYkHE174V6BZHuEyt3U
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Sep 2022 14:33:30 -0700
IronPort-SDR: uM2HV1KxgXh7o2B+5QTPSPmhQeT+nZzolCDuhHCZ7ixt4lTE30Po7lHI1dYqDa8aKuBb8/Kr/Q
 dNG0US9/QndtULRgsX4W6N9p38OqwWjD5Yx+nQj4uiS++bsM9Ge5zCgSm1MfhuHfz4f6kwd9St
 oJS0M/LAjuDlueYfhhKW36qe2j8KdbJfRtsG6m3wkfSEWFOKRx3yPuWgBjNHTZUDU4/33+0j6k
 ui6MBUkjwHwRUP44f1N/BDC2X9K8r3an7hp/kSbYr4Yllygj7bZDbS+EucRwL2pPO9rD8I72vR
 aYQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Sep 2022 15:13:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MNGjK6bLxz1RwvT
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:13:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662588788; x=1665180789; bh=V+0k4SbulDK21C0d7Ev+pAWQlueHvqwL6BE
        rGZBgVdU=; b=rebSP0s+zADCSOOsrax25tnyTOjohwsTRNeFBUc3SAOcVEi+h1e
        M4h5z16Y6JJQSfuWVtu3hHBSP8YXXSSY8GmqV10QM9Zu+4OxR+GMJw64wOM10bp5
        lUoxp9b11JoLqpM+6dMKL5gbuaU0oiD5JQRoBUFEbtMU8YPBPwD8KlFA6YPSSAnf
        6sPfaxHI0XA5QUdScRqm2xtV+sFtrhloG7CogXUQJ7dCUyLNUU1NZV4Z4mYa30tN
        03s3qFIe5/YKmKU0u8oGH4O8bFsauOSoPQIik6RHO7huVlp133EQYOI/pCfQSPhn
        C24cyjWFPCc32qvmVEjWF3lGnt2O1io5LlQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QzGLNJi1XrHe for <linux-kernel@vger.kernel.org>;
        Wed,  7 Sep 2022 15:13:08 -0700 (PDT)
Received: from [10.225.163.64] (unknown [10.225.163.64])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MNGjG656Sz1RvLy;
        Wed,  7 Sep 2022 15:13:06 -0700 (PDT)
Message-ID: <04372579-4c43-efa1-6042-270f6ae919c2@opensource.wdc.com>
Date:   Thu, 8 Sep 2022 07:13:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] libata/ahci: quirk for JMB585/JMB582
Content-Language: en-US
To:     MD Lin <mdlin@jmicron.com>, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kevinliu@jmicron.com, charonchen@jmicron.com,
        corahuang@jmicron.com, mhchen@jmicron.com, georgechao@jmicron.com,
        banks@jmicron.com, tzuwei@jmicron.com
References: <20220907105130.13797-1-mdlin@jmicron.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220907105130.13797-1-mdlin@jmicron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 19:51, MD Lin wrote:
> This patch adds a quirk, which enable error bit handling functions
> and SATA configuration for JMicron JMB585/JMB582.
> 
> Signed-off-by: MD Lin <mdlin@jmicron.com>

Please use scripts/get_maintainer.pl to check to whom ata patches should
be addressed. If you do not send patches to me, there is a high chance
that I will miss them.

The patch title should be:

ata: ahci: Add initialization quirk for Jmicro 585/582 controllers

Or equivalent, that is, a little more descriptive.

The commit message also does not explain WHY this quirk is necessary (the
problem is not described) and there is also no description of HOW your
patch address the issue. Please be a little more verbose with the commit
message to better describe the patch.

> ---
>  drivers/ata/ahci.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 505920d45..b0768fae3 100755
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1657,6 +1657,68 @@ static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hp
>  	}
>  }
>  
> +static void ahci_jmb585_write_sata_phy(void __iomem *mmio, u32 addr, u32 data)

The patch title said jmb585 and jmb582. So should this be called
ahci_jmb58x_write_sata_phy() ?

> +{
> +	writel((addr & 0x01FFFUL) + (1UL << 18UL), mmio + 0xC0);
> +	writel(data, mmio + 0xC8);
> +}
> +
> +static void ahci_jmicron_585_quirk(void __iomem *mmio)

Same here. Also, please be consistent with the names: spell out jmicron or
use jmb, either is fine with me, but once you choose one, stick with it.
So:

ahci_jmb58x_write_sata_phy()
ahci_jmb58x_quirk()

or

ahci_jmicron_58x_write_sata_phy()
ahci_jmicron_58x_quirk()

> +{
> +	u32 pi = readl(mmio + HOST_PORTS_IMPL);
> +	u32 b8_data;
> +
> +	/*
> +	 * enable error bit handling functions, these might overwrite
> +	 * the setting which loads from external SPI flash
> +	 */
> +	b8_data = (pi > 3) ? 0x13 : 0x92;
> +	writel(0x03060004+b8_data, mmio + 0xB8);

Spaces missing around the "+" in the first argument.

> +	writel(0x00FF0B01,         mmio + 0x30);
> +	writel(0x0000003F,         mmio + 0x34);
> +	writel(0x0000001F,         mmio + 0x38);
> +	writel(0x03060000+b8_data, mmio + 0xB8);

Same here.

> +	writel(0xF9E4EFBF,         mmio + 0xB0);

And what are all these magic values ? Where do they come from ?
It would be nice to have these defined as macros with descriptive names in
drivers/ata/ahci.h.

> +
> +	/*
> +	 * set SATA configuration, these might overwrite
> +	 * the setting which loads from external SPI flash
> +	 */
> +	ahci_jmb585_write_sata_phy(mmio, 0x06, 0x70005BE3); /* port0 */
> +	ahci_jmb585_write_sata_phy(mmio, 0x13, 0x70005BE3); /* port1 */
> +	ahci_jmb585_write_sata_phy(mmio, 0x73, 0x000001E5); /* port0 */
> +	ahci_jmb585_write_sata_phy(mmio, 0x75, 0x000001E5); /* port1 */
> +	ahci_jmb585_write_sata_phy(mmio, 0x74, 0x00000024); /* port0 */
> +	ahci_jmb585_write_sata_phy(mmio, 0x80, 0x250B0003); /* port1 */
> +	if (pi > 3) {
> +		ahci_jmb585_write_sata_phy(mmio, 0x20, 0x70005BE3); /* port2 */
> +		ahci_jmb585_write_sata_phy(mmio, 0x2D, 0x70005BE3); /* port3 */
> +		ahci_jmb585_write_sata_phy(mmio, 0x3A, 0x70005BE3); /* port4 */
> +		ahci_jmb585_write_sata_phy(mmio, 0x79, 0x000001E5); /* port3 */
> +		ahci_jmb585_write_sata_phy(mmio, 0x83, 0x250B0003); /* port3 */
> +		ahci_jmb585_write_sata_phy(mmio, 0x7A, 0x00000024); /* port3 */
> +		ahci_jmb585_write_sata_phy(mmio, 0x84, 0x250B0003); /* port3 */
> +	}

Same here, lots of "magic" values that cannot be checked. Please use
macros and add comments describing where these come from (adapter specs ?).

> +}
> +
> +static void ahci_jmicron_quirk(struct pci_dev *pdev,
> +			struct ahci_host_priv *hpriv)
> +{
> +	void __iomem *mmio = hpriv->mmio;
> +	u8 tmp8;
> +
> +	if (pdev->vendor != PCI_VENDOR_ID_JMICRON)
> +		return;
> +
> +	switch (pdev->device) {
> +	case 0x585: /* check if the chip is JMB585 */

The comment can be removed. This is obvious.

Also, there is no case for jmb582 model which the patch title mentions. Is
it the same number for both models ? If that is the case, then please add
a comment above the switch() describing that.

> +		tmp8 = readb(mmio + 0x44);
> +		if (tmp8)
> +			ahci_jmicron_585_quirk(mmio);

The tmp8 variable is not necessary.

> +		break;
> +	}
> +}
> +
>  static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	unsigned int board_id = ent->driver_data;
> @@ -1775,6 +1837,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	 */
>  	ahci_intel_pcs_quirk(pdev, hpriv);
>  
> +	/* set JMicron configuration */

This is obvious from the function name. So you can drop this comment.

> +	ahci_jmicron_quirk(pdev, hpriv);
> +
>  	/* prepare host */
>  	if (hpriv->cap & HOST_CAP_NCQ) {
>  		pi.flags |= ATA_FLAG_NCQ;

-- 
Damien Le Moal
Western Digital Research

