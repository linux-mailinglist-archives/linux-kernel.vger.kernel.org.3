Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F104D3026
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiCINnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbiCINnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:43:49 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2074.outbound.protection.outlook.com [40.107.96.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03095C12DD;
        Wed,  9 Mar 2022 05:42:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIJEApFRPfW+wwpYWUbDDjC3XGs6IYA0RO5bpyEhsfRy2SHsLVSeM7MY+35Q57WwUqCGyLhiIwGQGZa6zXMgQKaapc66hSb4VhQdiccr8nCr+OJ2lNRmMiv1qXafAWPJWEMUbIB06Y05SmrkvhqhdhcKIbzBWWNzntbRYcT5iRPsmcGnq6Q1KVXTmvq/KVg0TAJ1iwnjyRTjkygooOCvXTK2vHVrtLmcWbr1X1k3wNalCHYmuNlCsu/ltttLdmTKSa0s91ohCu2N+hYr/XCuDnxh/J0XPwJ+WRgeI4EL+qOOMG5b6RO3iPlEbMTbJADJs2Ush3qVs6TQQQKD3z13Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfXKSTDsfaM8fZRwULHj2z/dqYmvN4Q2/+WSbqYWSQA=;
 b=hHrhmvRXFMq/bwopPRuDMtw6m9oQaK7ycL7KaCg3Z9lM2XLVmD5a/JsGyJpF5md8Gyw6Z+sI/AREfFpGQNUO1cgKZ4oBpcr5xaLQI/npW8dqAuuOcwIZv7icSoLBOnQ59us6j92rcQi8MfOajk4nBjorrobxoUum2zL1cjuGOMwYoL+MU37nUsB0UpWrD6NSeI4kuD9dkI2fyFXQLIbHVG5T1MUw6vLhrTDC8KKk4QDYhFzokig3psBmAcIV1RxcPGkUf41agdtvLNhnOY1J4ChlkIrPo9nRk8m7I+dwcKmTbVhJKHi7FgEh3Sp4Mo/D6XFfTRXNXqo9ruQu+wAdbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfXKSTDsfaM8fZRwULHj2z/dqYmvN4Q2/+WSbqYWSQA=;
 b=FfPuPM4R/2mMDveXma8r0hwmz07LYZ/YpPQ3nN+epXR9fz2Bd6+7f8mcjoZjpjHMlM68y0I7LjFF+ZkQM6vuA18Eq+D5BNEgGIQrlJAw3K2V72YYY0aqz2Lhd0NJzzyMlZ8DzMuephAwoeMgo8JvfgaJIQlg92R9vMyLQO9NreY=
Received: from DM6PR07CA0063.namprd07.prod.outlook.com (2603:10b6:5:74::40) by
 DM5PR02MB2331.namprd02.prod.outlook.com (2603:10b6:3:57::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Wed, 9 Mar 2022 13:42:48 +0000
Received: from DM3NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::9d) by DM6PR07CA0063.outlook.office365.com
 (2603:10b6:5:74::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Wed, 9 Mar 2022 13:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT041.mail.protection.outlook.com (10.13.5.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 13:42:48 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 9 Mar 2022 05:42:47 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 9 Mar 2022 05:42:47 -0800
Envelope-to: zajec5@gmail.com,
 robh+dt@kernel.org,
 trini@konsulko.com,
 sjg@chromium.org,
 srinivas.kandagatla@linaro.org,
 krzysztof.kozlowski@canonical.com,
 ricardo@foundries.io,
 jorge@foundries.io,
 seanga2@gmail.com,
 devicetree@vger.kernel.org,
 u-boot@lists.denx.de,
 linux-kernel@vger.kernel.org,
 rafal@milecki.pl
Received: from [10.254.241.50] (port=55666)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nRwaV-0005MV-7L; Wed, 09 Mar 2022 05:42:47 -0800
Message-ID: <578e243d-2273-add3-898c-959888c2a155@xilinx.com>
Date:   Wed, 9 Mar 2022 14:42:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH V3] dt-bindings: nvmem: add U-Boot environment variables
 binding
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Michal Simek <michal.simek@xilinx.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>,
        <devicetree@vger.kernel.org>, <u-boot@lists.denx.de>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220228131250.16943-1-zajec5@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220228131250.16943-1-zajec5@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3983d298-4301-4d72-33ca-08da01d2b2d0
X-MS-TrafficTypeDiagnostic: DM5PR02MB2331:EE_
X-Microsoft-Antispam-PRVS: <DM5PR02MB2331A49341274A644121C0A1C60A9@DM5PR02MB2331.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8K0slqyuMU4ecqFOgSdvN1PN6LCKa8Jy/a1K0X0UWV84mGg4OV116V56xa3ySDearqQAMryavxx5UoRnD4eNrNHICrXpe1iFIec/cFL+JUq+G/Ic5HY56pifJyfhJpRaBnZwFsoDzOzJvNBtDyimv99i22PYx1mwZjJkfAA4jVke30UuZUXUb7YNjZTXEfqeAAPQNxC+fuArm//WpqzD0Xg8DW7x/xjhy+geF2NREAesAylnIntMC642S2PZ+NH3LQo0TEXFDeYRqMpZN8RaNdh4++ozQ+iPCdDRCCHwOriu0/01DNeuV9yvvrHhtxtMwFykQErgZ/rbgujy7/4Gawk5KmxQ+d2WQ7fzy2CqvMR8GtAnUUnVIIren541WSmlEzRdCe8L4uOWj/7mFR8HtgmMLbjq129zfH6468/5DpSY8dFXl7fI1A+E/S6afG0kDoPYn9HsnWgrBkt5jnnmivzXkWOxaW0vLdxzs15k5xmLmdMVtUDbNV/iXaBgAr0krharaU2zZle2qyANeJH3m/d6h9NBNGwcfJ/JdQFVU0WbY6GHLYiPTcAZZW5claMEDXWasSk7ThMMi+Mtl8pmSRVAXcrNxDu4sAWhdYgEEVGDY0hMfWM+QG3NNolucO3iFFRFBAkQLr5gBM6fwmRC1babDY8KZMSY1NxR953TgxzaYyUSeejmqgQnF0wJko2exWJzwwEAEopx5XIFXWTb+scY5OVd3gTVHZa+ftss4OvspIuPgAIKQBlsZTu7tq1fPv7cvO+NiUXgZQAHZcaTyVTAKRlULGJ59DbGNcukVsGt9vyhGbbPZBvs6HqVcERxUAbz4drzO9AtlOCzRjHayrN8mcfox7qZxEG5wOCe+Q=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(47076005)(8676002)(36860700001)(316002)(82310400004)(31686004)(70586007)(70206006)(110136005)(54906003)(4326008)(36756003)(186003)(31696002)(66574015)(40460700003)(2616005)(5660300002)(356005)(336012)(53546011)(6666004)(966005)(7416002)(7636003)(83380400001)(26005)(508600001)(8936002)(9786002)(2906002)(44832011)(426003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 13:42:48.0314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3983d298-4301-4d72-33ca-08da01d2b2d0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2331
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/22 14:12, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot uses environment variables for storing device setup data. It
> usually needs to be accessed by a bootloader, kernel and often
> user-space.
> 
> This binding allows describing environment data located in a raw flash
> partition. It's treated as NVMEM device and can be reused later for
> other storage devices.
> 
> Using DT should be cleaner than hardcoding & duplicating such info in
> multiple places. Bootloader & kernel can share DTS and user-space can
> try reading it too or just have correct data exposed by a kernel.
> 
> A custom "compatible" string allows system to automatically load
> relevant NVMEM driver but phandle can be also used for reading raw
> location.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Update descriptions to don't make this binding MTD (flash partition)
>      specific. Mention multiple possible storage ways.
> V3: Drop
>      allOf:
>        - $ref: nvmem.yaml#
>      as we don't use anything rom the nvmem.yaml. Thanks Rob.
> ---
>   .../devicetree/bindings/nvmem/u-boot,env.yaml | 62 +++++++++++++++++++
>   MAINTAINERS                                   |  5 ++
>   2 files changed, 67 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> new file mode 100644
> index 000000000000..e70b2a60cb9a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: U-Boot environment variables
> +
> +description: |
> +  U-Boot uses environment variables to store device parameters and
> +  configuration. They may be used for booting process, setup or keeping end user
> +  info.
> +
> +  Data is stored using U-Boot specific formats (variant specific header and NUL
> +  separated key-value pairs).
> +
> +  Environment data can be stored on various storage entities, e.g.:
> +  1. Raw flash partition
> +  2. UBI volume
> +
> +  This binding allows marking storage device (as containing env data) and
> +  specifying used format.
> +
> +  Right now only flash partition case is covered but it may be extended to e.g.
> +  UBI volumes in the future.
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: A standalone env data block
> +        const: u-boot,env
> +      - description: Two redundant blocks with active one flagged
> +        const: u-boot,env-redundant-bool
> +      - description: Two redundant blocks with active having higher counter
> +        const: u-boot,env-redundant-count
> +
> +  reg:
> +    maxItems: 1
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible = "fixed-partitions";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        partition@0 {
> +            reg = <0x0 0x40000>;
> +            label = "u-boot";
> +            read-only;
> +        };
> +
> +        env: partition@40000 {
> +            compatible = "u-boot,env";
> +            reg = <0x40000 0x10000>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index db8052bc1d26..24fc181a7e6c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19958,6 +19958,11 @@ W:	http://linuxtv.org
>   T:	git git://linuxtv.org/media_tree.git
>   F:	drivers/media/pci/tw686x/
>   
> +U-BOOT ENVIRONMENT VARIABLES
> +M:	Rafał Miłecki <rafal@milecki.pl>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> +
>   UACCE ACCELERATOR FRAMEWORK
>   M:	Zhangfei Gao <zhangfei.gao@linaro.org>
>   M:	Zhou Wang <wangzhou1@hisilicon.com>

I think that parsing these partitions is quite sw intensive process and I can't 
still see the value to have compatible string here.
I would prefer to have just any link from u-boot node to partition instead.

But up to Simon or Tom to decide.

Thanks,
Michal
