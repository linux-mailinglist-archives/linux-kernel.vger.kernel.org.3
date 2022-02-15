Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBCD4B6E40
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbiBOOCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:02:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiBOOCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:02:47 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2070.outbound.protection.outlook.com [40.107.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF8E288;
        Tue, 15 Feb 2022 06:02:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+Nv8zAvFd3xKe6LBb8FTB5CtmJSm1vWoNLyk8FjOaOyLd9jB4ZLN1XbKt7cHLMhODQL3JI8wIkcQTnQMu8rhivBSlSus385NQivHjAxoAIfO8XKKvni/HIhXyMu9Hfu2WCc6bEFVejeh4iRm/EgQSdCwXhKqP+ptfZnkNcmeYt1MJL2yOSKtiI+d8YQIkidUUcn8PdR3GFPpI2XBQkz6Trufecb2aNd9hfWR7nmtibE4BWzODOhRcsjMd74qeWHEPOFjZy8lKAosFQ2g8EfWY3eHQKOdllMFDV3MR5e/I3UE9BJBt3Izq5nGAZH99jQ8+nIGMEGjlVrebIZuDpPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1/l1U9ZJ9K0a+5lt4i6T0ZU2WStkln1fJ0FcHQ69kY=;
 b=BjsUc96XqBhiTK+em+xNiFGZASQudTS48MH24IoRE65Is7pQ7tmetG7JaNQ5Ab3z16rbYFpl+xCf44aWRssBtWgNni5z2gAwUc1wXzlyKOMWrAhGf1kSmEz6zaPz2SYi1dmJ3aJoaY0S9KNxw70TnNTd9Sajmjt3cUHjsPOzpa1iXAPklhYQaI7mmYOPBqLUGDnsn0YWfvWoDELiMmLwGdcNzpNg+cfFV+0ku+T2aLKpxqYSVEabFbajZpiNzyaS4EBQgD8ZIUt8HO15+rM/CUPVZ1Kw7USNcgub4oBvZz3ooP7nqNiDVHR53CAOnioaC/YnLIlHRrUO3bCbJYeEWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1/l1U9ZJ9K0a+5lt4i6T0ZU2WStkln1fJ0FcHQ69kY=;
 b=E8AJpyoKQkhNfpmIpom5P4sM/7pQFmz81jNWwEmIu/wLJzMwECmSdn+G2RS1Nh5bvAz9SDJ1c2P9jcJ9AMNRSxQL9urITMFduKofxyLVU6lmAL91o3vAKrjFHm49UXurW6PBTT3eTvn5vPR2ZZyaY8PDNzLoyh5OAXVP9LOnqME=
Received: from DM5PR22CA0007.namprd22.prod.outlook.com (2603:10b6:3:101::17)
 by SN6PR02MB4829.namprd02.prod.outlook.com (2603:10b6:805:98::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:02:34 +0000
Received: from DM3NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::c5) by DM5PR22CA0007.outlook.office365.com
 (2603:10b6:3:101::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Tue, 15 Feb 2022 14:02:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT026.mail.protection.outlook.com (10.13.5.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 14:02:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 15 Feb 2022 06:02:28 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 15 Feb 2022 06:02:28 -0800
Envelope-to: zajec5@gmail.com,
 robh+dt@kernel.org,
 trini@konsulko.com,
 sjg@chromium.org,
 srinivas.kandagatla@linaro.org,
 krzysztof.kozlowski@canonical.com,
 ricardo@foundries.io,
 jorge@foundries.io,
 devicetree@vger.kernel.org,
 u-boot@lists.denx.de,
 linux-kernel@vger.kernel.org,
 rafal@milecki.pl
Received: from [10.254.241.49] (port=38322)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nJyPU-000EhI-0V; Tue, 15 Feb 2022 06:02:28 -0800
Message-ID: <193f9354-5e1d-def8-c8ab-fbe88d8d9b8f@xilinx.com>
Date:   Tue, 15 Feb 2022 15:02:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] dt-bindings: nvmem: add U-Boot environment variables
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
        <devicetree@vger.kernel.org>, <u-boot@lists.denx.de>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220215134925.32691-1-zajec5@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220215134925.32691-1-zajec5@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab4fb619-9f83-4178-2461-08d9f08bd0f7
X-MS-TrafficTypeDiagnostic: SN6PR02MB4829:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB482987AC83EAF3FD03D2F17BC6349@SN6PR02MB4829.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yyWI3Eyu8lYHPeOJaArfzcsA39S13zJarnIotuPss/xvRyTkBzjGSviN/IgEM7b/AGe3ZL7v5YqwQsBjAjnZfKjQzANy+ZP6Wv0bc4AiW8aBhzB+o44xHY04DvH4tIDePx69+KhFT76ZteTIkJms9JhFVX1zy+a4Ugp6mC6Ggr92z0YmadmyoupZnmLhXZ7/7m32poTNl6e+Rad9sJt1YA1RuLXSPBgnP0EGHUbYd916OWmjf+cGscHPMiPJ6bsBSIPf5DtRaLtEWzRA62qE8aknin2KaZtLKYby8dy80PsQTL2XSsdisXp1SDzZcGR/giJnQ7hc4dX32xctrzp7eiFPGxD9EZAM3zn5PkCKgjWCuGbS9LC6hxUrv9zYMiJbQH2yq1hmW+0qiCXO1DNX7+b+jqE8isjVcHNWVJkP7N0Kafj5BQ3frYVive4Itx+Gt6RExB/9Ro7vfLmSbVWrMs3qOHQE0JcnmIeWgGFmMD0rYzaZiFGnyf5V6WUzCyZMmluVNHn32UxOPxLDs/0zwl4YirI7bkI4+KL9eFEzU9ap/mqPKKLoU/hLIiesUzzc3OTk4xSS07JwqE0vFyWZijJtwr01Psehvb60O9Sj1PVAziw5l4cZ5eDq0WSGlgRehry+upxDVR+0s6k0LWdlRCdvolHzMwbfNnkw7if80fIc1L70PJfs5M6LE/gzwPp2YB+fpqKvaiZPA1LX8VJsUrFzAH0pZLLsdzylLyo2Hw7+Y0QMgM7pVVpTd2Je7Mjl/5eVNVFpwpMYhVUsaMDb5ozFkfxGtBgTecI+DSwZdQ8jJ2atGPcGAYSrloiaCFUQZ96RbztJFfKzGeeGYMQOT0rB2JxA7XHTq5Aw+b3Y2+A=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(356005)(47076005)(7636003)(66574015)(82310400004)(9786002)(8936002)(44832011)(6666004)(53546011)(508600001)(31696002)(36756003)(8676002)(4326008)(316002)(966005)(7416002)(186003)(426003)(70586007)(54906003)(31686004)(83380400001)(40460700003)(26005)(2616005)(110136005)(336012)(70206006)(5660300002)(2906002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 14:02:34.5676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4fb619-9f83-4178-2461-08d9f08bd0f7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4829
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/22 14:49, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot uses environment variables for storing device setup data on
> flash. That data usually needs to be accessed by a bootloader, kernel
> and often user-space.
> 
> This binding allows describing environment data location and its format
> clearly. In some/many cases it should be cleaner than hardcoding &
> duplicating that info in multiple places. Bootloader & kernel can share
> DTS and user-space can try reading it too or just have correct data
> exposed by a kernel.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   .../devicetree/bindings/nvmem/u-boot,env.yaml | 58 +++++++++++++++++++
>   MAINTAINERS                                   |  5 ++
>   2 files changed, 63 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> new file mode 100644
> index 000000000000..a2b3a9b88eb8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> @@ -0,0 +1,58 @@
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
> +  Data is stored on flash in a U-Boot specific format (header and NUL separated
> +  key-value pairs).
> +
> +  This binding allows specifying data location and used format.
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +allOf:
> +  - $ref: nvmem.yaml#
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

I am not convinced that this is the best way how to do it. Because in u-boot 
implementation you would have to enable MTD partitions to get there.
And the whole parsing will take a lot of time.

I think the way how I think this can be handled is.

# I don't think that discussion with Simon was finished.
But for example (chosen or firmware node)
chosen {
	u-boot {
		u-boot,env = <&qspi &part0>;
		u-boot,env-redundant = <&qspi &part1>;
		#or
		u-boot,env = <&qspi 0 40000>;
		u-boot,env-redundant = <&qspi 40000 40000>;
		#or
		u-boot,env = <&mmc 0 0 10000>; #device/start/size - raw mode
		u-boot,env = <&mmc 0 1>; # device/partition - as file to FS
		#etc.
	};
};


&qspi {
	flash {
	    partitions {
	        compatible = "fixed-partitions";
	        #address-cells = <1>;
	        #size-cells = <1>;

	        part0: partition@0 {
         	    label = "u-boot-env";
	            reg = <0x0 0x40000>;
         	};

	        part1: partition@40000 {
         	    label = "u-boot-env-redundant";
	            reg = <0x40000 0x10000>;
         	};
	};
};

Thanks,
Michal

