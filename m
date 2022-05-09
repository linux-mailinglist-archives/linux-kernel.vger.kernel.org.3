Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B963051FB9B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiEILtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiEILsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:48:38 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEFA13FA2A
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652096684; x=1683632684;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1x+FMxo1b1TQU/wdpcA4rbUnkh/IM34rDwgwBlnHG3M=;
  b=Asd97UJV8qjBrJjbwJddw17KWGX+d+Ogq/G84Le/D6jECamwTNfv1Tkl
   YAKUaMtjfDMXg30qgWJt8c8VI4Ezk+gGZwvlOrbHlOJBPkGeHiU1dlovM
   Rpk+V+5z5Iz68TgL5EkRghejm8I0Nk0pxPpYzvvEP4dyvwESRda3bmgM3
   Ce5kXTaiEU8oaINrQtaVfp840cMMzTsgsCkgWL11id7ogSZCfN/F5IhxW
   QXBZ+AJO/9uZZx3vNEcd3wTrJlP5tG+T3bNfY0DfOMkr2KXpnfbxNtiH8
   9+I95qby0UnD7QGDVIyeVgtVKmMZtFiDYQ7O8TIIvEGEtP4H+bKKG1nil
   A==;
X-IronPort-AV: E=Sophos;i="5.91,211,1647273600"; 
   d="scan'208";a="198691009"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2022 19:44:42 +0800
IronPort-SDR: nbHpXsgTK0eP84qEwBL8K53/dfxXFcqHcxX0FOLQPT+gUHQvWE20kJs/sI424ii9NVAXkgS2s4
 3bMz2ESHYIMXPHXmhGH+Zqtx2r9PfqQcGa9X/pWEXHoTc6DCRWSffTglNA4QZlVT4OJJk1P0dP
 I8Wm6f37rO0A76TusoVcl6vac9XSqxHgTf2qZV1tLGENHBy9fhxo+6o0knr0AeQA850R9TF3Pv
 WB2opBZAe71abxAnZAqzmO9/WUyH6RUOqhxbAkfWtIBos/aEw1GnEnMY5m8iZoRVQFFOVW0+xO
 PObUF5THDFal9mAlS16PIMUY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 May 2022 04:14:48 -0700
IronPort-SDR: M2i9pZbF5fRmfcBBE/qMjnOqRJ3G+4huc5PqEMg0JwOMeVp77xv6NjbFhBnG54yDEdSai3eao/
 8ndLGwQi34/1lJHlphOv9cx83s37zMo1TpCEx5rUesJnZShgeRR43jVvKyrTgP/4iKhocMMAf6
 Zq1YGmTgLuJO+JmrnjnORP77UtECORoLW9ZrmoC5z0O4IYAfrh0cY9C3BWT8YZDbCtnkfrlck4
 owi1rNdt6mRrD49TDGBwDEQn8yE84NPHLlalV5kApgCCe+/DjXoBAfYfO1MPpRSy3x6a2dWfLC
 d98=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 May 2022 04:44:42 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KxfV15f3vz1SVp0
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:44:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652096681; x=1654688682; bh=1x+FMxo1b1TQU/wdpcA4rbUnkh/IM34rDwg
        wBlnHG3M=; b=T8q8DD3Okj9Vto6TIzr5k7zi1PPmv02jIQOpzmoR4FKPkzCIys8
        Vd3QE3FK6Mf9rhT6WY49FG2c8Yi5foX96AGnQtdfrACKGyEZrLBdeb+BfmQZCFtB
        7l9CSkG3jfq+/K4ia6GvGzd2F4InQuyAbx5aa6PT4xrkkWlJYOHHVtqoUFELsxtM
        uSdmrepugLZkDFpLrQynIzYBvcG8F0ngJdq+yFjoj/3Oq2bITAYjVm/+xGjz2D1d
        /Yxx+Q7scsPhGGhLD0KHZmli7BijM+2q6+PftqxyHyd1oXPp3hxga6jHskgd+KY4
        TNNkiverp7SmIxKi0FRMbCUv+amaUCwlTSg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JB_Rb05oE_5A for <linux-kernel@vger.kernel.org>;
        Mon,  9 May 2022 04:44:41 -0700 (PDT)
Received: from [192.168.10.49] (unknown [10.225.164.111])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KxfV01VqRz1Rvlc;
        Mon,  9 May 2022 04:44:39 -0700 (PDT)
Message-ID: <a54d0558-be00-b87b-9238-187978ca06c1@opensource.wdc.com>
Date:   Mon, 9 May 2022 20:44:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] ata: simplify the return expression of brcm_ahci_remove
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220505022133.55852-1-chi.minghao@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220505022133.55852-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/05 11:21, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Simplify the return expression.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/ata/ahci_brcm.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index ab8552b1ff2a..f61795c546cf 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -549,15 +549,10 @@ static int brcm_ahci_remove(struct platform_device *pdev)
>  	struct ata_host *host = dev_get_drvdata(&pdev->dev);
>  	struct ahci_host_priv *hpriv = host->private_data;
>  	struct brcm_ahci_priv *priv = hpriv->plat_data;
> -	int ret;
>  
>  	brcm_sata_phys_disable(priv);
>  
> -	ret = ata_platform_remove_one(pdev);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return ata_platform_remove_one(pdev);
>  }
>  
>  static void brcm_ahci_shutdown(struct platform_device *pdev)

Applied to for-5.19. Thanks !

-- 
Damien Le Moal
Western Digital Research
