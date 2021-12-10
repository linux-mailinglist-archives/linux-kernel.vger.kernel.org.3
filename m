Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01ED746FB23
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbhLJHOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:14:25 -0500
Received: from mail-am6eur05on2080.outbound.protection.outlook.com ([40.107.22.80]:17185
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231245AbhLJHOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:14:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4G4WGwgwI5AGKrx9x+BdBRna5mLwu1cRDGQTReipLVYec5zXlVbCSz+GNVo/YzhsOMEgyUB3HrACfMWeOMVcqMcVQQU2fQ/uaUKKb8WzagTKp33azI4XRKjDarzr2uDecyNJlN4s+msACBwzi2e3rWpJl51MqEomhM2BUsv+8p8aQExjtz8+m897bDO5OoF1hz3j9Vxx0WCXv0+eeuHGS2eISuUqJIP4EGWt7fXCyX+cGaXdnpfPb1+gh8A0Po+Ni+pceZA5gzf8+61UMCOn/TImINSqZ7OGY55OHRq4irvNzrISEPD/R0oBGekPGWFkVbdxKWruHog+XkaNdM1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4n2+p/maTxhVmrtcDVTeSIvhPx0fgGyVNSQaIMRB2E=;
 b=jddct7jVUnRzP5ofIjRxadv142Y7Ak5DzUyIB1zenuxuqZGeygpAXqB8vYvRnjfdN2J5mKsI7qmqCD5E0rSDgfGUAU9YuIuwHF4Fsod5nXE9O73YHmcwA6HHZHdyHfZcgmvaDjEHKhj7rYgocJ1qkvbnt/gNgYutSpkz/8LXXwdJqX6EN2500cduhpQ7YeZBzXbLSL5AyW1jM6hpT9GUtxBlX6PLbEHiLq3gWXvYfoQJ1CDueSmnT0LZ9jZ9ibJP39GvL2WLEcNvrnbHe7MX4qIaGfh5BzPPadAGUYa1j8LJ69DOJ0l3zypM6lNvGBTA3hzx8WqCSCO8AkhEEuDT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4n2+p/maTxhVmrtcDVTeSIvhPx0fgGyVNSQaIMRB2E=;
 b=nUD/YUauc/ohfnwTbiRp2Y29FyWr91FLQPlcIt+vR5K9wwjfkgi/Nk0FJeqnxbU5eEasBU+M+8hApFH8hMZiPpiBVS7+KRdRA63ciQGGen9yBghxOmdBF0W036Lp+gihPqOho+Xohv/LE9wFSb6lCp1da2lS3BMDd+kgT9Tr3WIg6w/Y5iP38C9PRhA8go9ylOybBPovyMCrK4CKiMPfVaKx7Ooqcx6EW5uVCJcNYN8s5bJzxen/iyJxlWLiQzMHQUs7HqAPIDwqgjoVlzDIqHeTGfK9/vIOhcZVXAp9BlNEPik8F1R6U5zUqdk8wxPw1AWmVDTKhH5jRxDmZrB4HQ==
Received: from SV0P279CA0065.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::16)
 by PRAPR10MB5227.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Fri, 10 Dec
 2021 07:10:48 +0000
Received: from HE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::17) by SV0P279CA0065.outlook.office365.com
 (2603:10a6:f10:14::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Fri, 10 Dec 2021 07:10:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT043.mail.protection.outlook.com (10.152.0.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Fri, 10 Dec 2021 07:10:47 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Dec 2021 08:10:47 +0100
Received: from [139.22.134.185] (139.22.134.185) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Dec 2021 08:10:46 +0100
Subject: Re: [PATCH] arm64: dts: ti: iot2050: Disable mcasp nodes at dtsi
 level
To:     Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211117053806.10095-1-j-choudhary@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <24cbe5c0-3f23-d1a0-02ca-8a4e656811f2@siemens.com>
Date:   Fri, 10 Dec 2021 08:10:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211117053806.10095-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.134.185]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e3300be-75eb-4d71-0e8d-08d9bbac30d4
X-MS-TrafficTypeDiagnostic: PRAPR10MB5227:EE_
X-Microsoft-Antispam-PRVS: <PRAPR10MB522785C663AACCB98D18469595719@PRAPR10MB5227.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5eV7n9h6AZxs2vOUFcN+2zxToniAUd7gIJb0B5Mx/HXQg+0bzXRlQIaGjGXbpgY0VH83Gv5tX6pld/kuFZk1cLCEgBsmC4LDOYezIV3tbIr05L1DaG7ZpM5E5OtHYTR27hE+5Gp0v+0MX9jTwP3IEUWXiOKsBnMi5HDENqXM0ABeAzVqEVKaVTw6oh9qVeKYWw0UkY/UnTYsxZkJETxJ0dg+RYg9KMNoL25TEO9EAHB/EsKo3YT2JwztT+helYf6KQN9DZX/5Gptnp32n3KQXFvDHqT5jXlbdi3rqu7FPUOxmVvQXX/DZ4NnfC7uxxoezCCuou+HLB8rxA6hOJ2NOSt0y5RR2dfllKVs4SwftarHYrLFUhd1ROJPkYZwhCkwNB70X4/+uKmgTVJtIxpR1T+w0WaNMMIS4uGZi9dL6v3oxVpPMp6jq98OURwEv1nAv4IwsnRbG1JuuJSmNQUK0RvPBeoWHH6G2tNuEiVqH+6G86WgHaZVtw5AWt9ALPoOiWdYrndYG1I8hwzMizY6ksDl8h3iGsJcSePjcsWvJR8nJYGNNxcL0k3EhpPtD1YlmW5C167oq3Y9hy57BlT1xa+aAL/EZPQ4+P2I9Tr4rgSCyNSxYgaXsCTC8U7qdHNKSji+SW+G4jxgHHXehNa/8XI3lo1EKv+MA7+py9+GkbIKERVkwDlRIedCk9mHmH17cyz/0oZCL4xVj0ZEGh2mOf6l3Btlzk5P9DDGp4vum5vbpvWJPTiNA4g31DNkLgIvz8BFXgLYxjYuBa1ejIbu4wpZYYm5jX5KqH5V4Hm5bsQ=
X-Forefront-Antispam-Report: CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(31686004)(53546011)(110136005)(81166007)(86362001)(36860700001)(8936002)(508600001)(70206006)(54906003)(2616005)(83380400001)(316002)(70586007)(82960400001)(44832011)(31696002)(356005)(36756003)(5660300002)(16526019)(186003)(4326008)(47076005)(336012)(16576012)(956004)(26005)(8676002)(6706004)(82310400004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 07:10:47.6202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3300be-75eb-4d71-0e8d-08d9bbac30d4
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5227
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.21 06:38, Jayesh Choudhary wrote:
> Disable mcasp nodes 0-2 because several required properties
> are not present in the dtsi file as they are board specific.
> These nodes can be enabled via an overlay whenever required.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index 65da226847f4..c9407ed67866 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -731,3 +731,15 @@
>  &icssg2_mdio {
>  	status = "disabled";
>  };
> +
> +&mcasp0 {
> +	status = "disabled";
> +};
> +
> +&mcasp1 {
> +	status = "disabled";
> +};
> +
> +&mcasp2 {
> +	status = "disabled";
> +};
> 

Acked-by: Jan Kiszka <jan.kiszka@siemens.com>

Sorry for the delay.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
