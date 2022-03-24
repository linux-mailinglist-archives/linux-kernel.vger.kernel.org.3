Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592944E5CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 02:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345857AbiCXBmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 21:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbiCXBmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:42:15 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076DC92D3F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648086045; x=1679622045;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4QEMOUcjYeQg6k3oG5z4tHQPgW+dlh1g2Hbu+B/waMM=;
  b=XO+H4H6DYt2BbpZnn2Ya2Bcqk6Nr5f8PXToxt0TfeHBAlPFC4PctmbGz
   n3lSM/9CuCwNV6254PE1EWfuuFWISKnUsaoxul4/zgDiGvlTPbESGSz7e
   fRTWNlB6bA+4cc1Mn0bgV0ODPwk7S8e//pRj90rOvMnpX7/dSgjOhwzLV
   gAptQOJTcQ4GaFxJF5qC7V2MxvIqMFo7tEGb4IG5xrzuRr5tJ2fh2587o
   DXjkqNcmYu69+zhfY+x0r/s/OOsvmDgCdM1t8BHrfRM1mKc5PdyBdwWXn
   8Q58OtWwV5fZE8GNPqwufEgWTyL/pgAZ5QQ9YkQz9DHc4if83CyL04Z7k
   w==;
X-IronPort-AV: E=Sophos;i="5.90,206,1643644800"; 
   d="scan'208";a="195019839"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 09:40:44 +0800
IronPort-SDR: wXQrZ6CzJxL0rNPI8sq5+y5uwE9S6lnz45XEaRC2mOVuFaMl7jak7yqDo+LT0EBBLEGa4xgNwe
 qlVD6vZcbuf32iiwiuh5SbX9qWqSlYQNBUYyEFO63CB9Oxq9dU1Mwa/dqo574PMpowW064hg+J
 gDQpwZgVjSj7C/xUogTevVVCHMgyFJ9Cqt992N3raaql7UaBDEp+gTANzNGRGWCXo9Ij8RCo8T
 9Gosi2NC7baXgrLjlhpRUdyZyEjsm3jUCWUi7VdSbUQZBlxe8vNJ3Wi0Vm2gAhxc9vWzq1iMCD
 o6C2DNnGWjgEZkk/stL3nUeU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:12:37 -0700
IronPort-SDR: pDkF/k6bOqkJder5kFa0WVkcBwmyQ1MjfYsADE7ZydGJX3tD2zDu1ZaJFfPpZMjhT+Xu1jwZhl
 qMhjnvgLPQu0J2wTkpqb0x0SeChIlNEBtUh//rjHljPyP6l3RzLZ+pAvna3j1nq0Wrjyr4iQxy
 i6fUHkO48ucwIvrJocWy/MxkwW7/s1DbxIeDfT+Dmp4mOKLsvZOpnkd1LM13rWb+rwPg5nOofo
 XG+yQRqarrkUeXSil671FmLaHYJ/Am9BIySqJnToFEsM8vtzmzn7Hxx4u7CnmYsDF7MwXarI6f
 XNw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 18:40:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP7GM3vVlz1SVp2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:40:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648086042; x=1650678043; bh=4QEMOUcjYeQg6k3oG5z4tHQPgW+dlh1g2Hb
        u+B/waMM=; b=pbihkB93tzJAeclaFNW5UkmpnyuQLhw10d2p+tvDoXWCvmRO1C2
        PjZ2bYMDHWtG7STDyf69s12NCUEqA00h14Fe0k94ITUa4nzk2daWAKas1P68w85S
        Dm0pAArRoYTcIbWNMo9bQttyBPg/Z1AZrlP+0c0K/g52ZQvsfvCaz1WptKASSjRV
        dJPFJ2q40Y7w5bo6rN7PRlVMpXslfD4u4RtQmshnAGn6JGdQjLXqSJAhhnGZ5Dza
        tmoxl9PAWx4oPIA0XUcf948Ht8vqGTGH1kWJZyE2dI79VHCuwhMM7YS4hQb1F4rx
        t0NPAIT2hgXL8Rho6HY0eo62GsEIKYty9gA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uma-Z5t59WhL for <linux-kernel@vger.kernel.org>;
        Wed, 23 Mar 2022 18:40:42 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP7GK1GLMz1Rvlx;
        Wed, 23 Mar 2022 18:40:41 -0700 (PDT)
Message-ID: <ab7f2a2e-0ca9-ed97-e4ed-bf8ef0ed69a5@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 10:40:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 07/21] ata: libahci_platform: Sanity check the DT child
 nodes number
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-8-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324001628.13028-8-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 09:16, Serge Semin wrote:
> Having greater than (AHCI_MAX_PORTS = 32) ports detected isn't that
> critical from the further AHCI-platform initialization point of view since
> exceeding the ports upper limit will cause allocating more resources than
> will be used afterwards. But detecting too many child DT-nodes doesn't
> seem right since it's very unlikely to have it on an ordinary platform. In
> accordance with the AHCI specification there can't be more than 32 ports
> implemented at least due to having the CAP.NP field of 4 bits wide and the
> PI register of dword size. Thus if such situation is found the DTB must
> have been corrupted and the data read from it shouldn't be reliable. Let's
> consider that as an erroneous situation and halt further resources
> allocation.
> 
> Note it's logically more correct to have the nports set only after the
> initialization value is checked for being sane. So while at it let's make
> sure nports is assigned with a correct value.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/ata/libahci_platform.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 4fb9629c03ab..845042295b97 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -470,15 +470,21 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  		}
>  	}
>  
> -	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
> -
>  	/*
> -	 * If no sub-node was found, we still need to set nports to
> -	 * one in order to be able to use the
> +	 * Too many sub-nodes most likely means having something wrong with
> +	 * firmware. If no sub-node was found, we still need to set nports
> +	 * to one in order to be able to use the
>  	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
>  	 */
> -	if (!child_nodes)
> +	child_nodes = of_get_child_count(dev->of_node);
> +	if (child_nodes > AHCI_MAX_PORTS) {
> +		rc = -EINVAL;
> +		goto err_out;
> +	} else if (!child_nodes) {

No need for "else" after a return.

>  		hpriv->nports = 1;
> +	} else {
> +		hpriv->nports = child_nodes;
> +	}
>  
>  	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
>  	if (!hpriv->phys) {


-- 
Damien Le Moal
Western Digital Research
