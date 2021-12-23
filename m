Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA13F47E656
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349175AbhLWQYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 11:24:34 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59686 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244591AbhLWQYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 11:24:32 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BNGO2Zu123677;
        Thu, 23 Dec 2021 10:24:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640276642;
        bh=Iq/I994HXFx9f25hIiTM8IwYE6TUMFqEWlEnFgbfxdU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DxA0BkpTSHY3HLo7IXx8OJwameSE98Z30CckN5jgHRY9dvwceap5XBRxpkvyr+5Le
         oPXf8cagYc21rEIuBLn0d2NH/nmxtPYweQvJx27EFpouRHYL7geyzkgjbyExDNxaWJ
         sbQq9YjLgDMmza7Xg931TqZV7d1wWo3pemAXIjJc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BNGO145102237
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Dec 2021 10:24:01 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Dec 2021 10:24:01 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Dec 2021 10:24:01 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BNGO0FW028418;
        Thu, 23 Dec 2021 10:24:01 -0600
Date:   Thu, 23 Dec 2021 21:54:00 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/3] dt-bindings: nvmem: add U-Boot environment variables
 binding
Message-ID: <20211223162358.wbfnibsma5lskxkw@ti.com>
References: <20211222192320.21974-1-zajec5@gmail.com>
 <20211222192320.21974-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211222192320.21974-2-zajec5@gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/21 08:23PM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This binding allows describing a (part of) MTD device (partition) that
> contains a block with environment variables. Operating system usually
> needs to parse that block to read variables values that may affect
> booting process & device configuration.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/nvmem/u-boot,env.yaml | 56 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> new file mode 100644
> index 000000000000..0f808868fff3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> +
> +properties:
> +  compatible:
> +    enum:
> +      - u,boot,env

Typo? In patch 3 you match u-boot,env.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
