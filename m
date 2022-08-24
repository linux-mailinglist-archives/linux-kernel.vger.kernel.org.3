Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9553E59FE41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbiHXP0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbiHXP0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:26:02 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E1E7FFB2;
        Wed, 24 Aug 2022 08:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGz+YxcKGreYheeCzxVoCbRBHwgVlYIliRahYOrCyP0kJcb0t81aKWBLEUGqakcJuC1jt/pa0BCQpCOdUuPj3jdP8xtV1gt/BPoyrimbGh4rg/CUNzxC9WfWAPI/BIGx2/TRTYz2i8Hqcupbu3riMKuzKaSvHWdx+PQQRqaPhXIQAou3LMYB/8+Q1BSdq9J6bgO2g5Ba1qy3DGf02cNKcGs62l2EuRQEiQCPvzT49JedARRNa8/H0OxxEKdsIzje6m/lkntf6WUaxTag4i55dK54m/PuTPxYBhN+dSL4INNUy7WZNDYVJkpQPPHN8fRU0wObJ4nSAutYf55Brnae/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtMntCKAD+tObCLo8GINfRNE7kx/IfsLKPY3RiWlOZA=;
 b=ZA0wdcVfcfZFWjvDPn1PQg9EGQG11579+oFEo4CEpkFvirkjIi6PiM0UoAbY7uusWFCNsL44FR7P4V+TyGfOS7zrHw7kwtiEtuByPjDEIGkpmKGehEAiBgmGssGjqQRP0aj8aptG48WxqeoZcGXIoehc7DKCCgM6oWjtZn9alL/AvWr0jiMB3OFCNTplKB+y1nlGdS3K05m2YhNZqTagtPyePi7PtI7aa0hAeQI5QtZVPFaSM0h6sObLvSy29mT7TCBQIzhg9nVCu0Flz1JMWwyGShLuLun8kHHmBU9+t1MvywqABMqmZnDS/Zpfv6EimhrsFFTvUgfb9QAsKhsOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtMntCKAD+tObCLo8GINfRNE7kx/IfsLKPY3RiWlOZA=;
 b=FO0R4P2I3H5TzMn+abqz7nStDJEHlQeaoV8WpK3Lbm5000XKmRGO+aS9Rqw+TeTYYsAcuaZXFqFZaws97Ew2m4DXkLHZt/PGRuTIv04dOSDhBBBUMWQ9rm2rwBSQD24AafTMJV3JW1Y+LSx7vltBLGu+U9iKZaznj9zBGurOqyfZhGwiLvi8sNIuNqxE6alBwLFd8nKR/7tPrVjSwriyGAluENqQdAPoIpb3crFwZ/oKMUyNP0dTSoWhII3za+0zpR7rLYsI9TMVUTZ3LiTJMeIK/QUgqOICl5KMQy6FqKRso+vADGMdglj5j2b9yAfqE2ge8TcI+W2RbMq3oLKJ8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PA4PR10MB5634.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 15:25:58 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 15:25:58 +0000
Date:   Wed, 24 Aug 2022 17:25:56 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] watchdog: w83627hf_wdt: add bootstatus support
Message-ID: <20220824172556.245f2579@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220824152448.7736-1-henning.schild@siemens.com>
References: <20220824152448.7736-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::13) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bfd065b-54ff-40b7-40d1-08da85e4f207
X-MS-TrafficTypeDiagnostic: PA4PR10MB5634:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xr1xz3jmWH3/1hLNeFlkVFCP/Xe+iqxnKOKyw7y8DHCu2SfDgvf8zsM7FInLAFAkkL0ZwipNkgC09NM4SBSTNgX8tjQRUgbmxyepkhXbaIFHtslJGVBwm1VBVtg2KhgXw8UnPk7aZnfwMXrRR/uWB5R3J9fMKHgC1UX0b+E9f2yiPWPo/kYr4bvIXUvUwvqfCh4JpaArHq/enp7fe9HJin9FQEicHKhdVTOJM7CR92wWhXPk8VFAGOUMJ/kTbdUS+SK8PzfkCyJnkb/QgXCcJH0OcKoq5Pu1RW6Nel2LycBMNOexRJUhCLOLRsfMcC/fnUyw0LJ5nmEXMvyVOI8KorozNMQaA7eO/YEINGwcxj9SoCR5F0xhgowfkVT3+vjWafmi53NF0XKLmOYZNC/AAuh6VNWOkyNMmlvrHteFKahTHWx17Qjn8pj9KV7kO9btF2qDnVgnwgMkb0wVjxN/trzqtMXeRSMQ53QuJkoPLDlPGLxDNjYIv0Bzg6F7kDNzbCZau3UcFzwDIMlMEBCnh5GGUKvYOqukiZcBPD1uzcWc4Vc0E2+4gKVnJcx1WvZTF0ixR0EJtwFKFOiumnVnH2HkgBaKKOahg3HAb4PCER9pYq9wVOlyV3NX+G6ylTH2iIacN3eHl1+6yvSmQPxBJib+bTW1n3UC4FMnUIqiwXCDead5/ZF723x/9MA8dqQf1biF57CagSmPvwIQzD+UyK68m+vE++smHfAjfa7384n00OF+ahxImcckYF5ia+5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(1076003)(186003)(44832011)(110136005)(316002)(9686003)(6512007)(26005)(2906002)(83380400001)(6506007)(86362001)(82960400001)(8936002)(41300700001)(5660300002)(8676002)(6486002)(38100700002)(66556008)(66476007)(66946007)(478600001)(2101003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PPGkxbo6D/OFWVbnplEgrzB7HLGmwoSWc/OTDUkSouuHRHp1eRxTqwokRIeV?=
 =?us-ascii?Q?7b3TR8ExdpQaN3ZYYbRYUBg3AMCv2S70tfOP3i/59cviNeiEDRb6qIjxw+tX?=
 =?us-ascii?Q?0d6nw6y1JaEsF2ql6NL5zfy5vGwRVz2hBaoxjVQ1by95xzbiR03seXy1EDGq?=
 =?us-ascii?Q?srYmq+eYyIrwjCJ90oqPEixpAB66j40uLS7Z0Ym4JwtM41YNYoYsgBPh4WiB?=
 =?us-ascii?Q?MDJ565TaGrjS3eu7iJ3/VCMOixgobS6gT3MveZ3ThOCW7tqIWQ2JswVNahFg?=
 =?us-ascii?Q?PjqKzdDUq0FerhX3LiQpDqD8EprHIhWFgLTNc0/iyE+ohheKB7aaUPPlQeX3?=
 =?us-ascii?Q?0YvrU45dodnhMXCYkIjq2I3/pfSAFnv2hX5kJWl0usivg2TVfMo+bQLtKpDv?=
 =?us-ascii?Q?124oPgrWXG+mr51TOvRCOYqjDpSuFIiQcUPsnOGX0kYB1JjlR/F/qG3WF8va?=
 =?us-ascii?Q?jdbHG5PG5tFN2VUuidrNAKu/rvH8KjvMRXRKV4+qBQbLImhAUMhIXp1S8Lmn?=
 =?us-ascii?Q?H5wVpdto+rnnyI6NoEe7tj6gqK0GWOTClm9nnHrS4CoHw0qjpoXA6oM1k+pg?=
 =?us-ascii?Q?CGKHHoMS5EF2b5l9YZYH0oyqz7AVS1yeCArN0uP9+II7G5nmXjoFOj5/Xu8Q?=
 =?us-ascii?Q?oEcNBvwHkKAvZW6r0obhjeUtpQcng2Z1gbH7g2hUjWOcilkLsRzDqnDUK0S5?=
 =?us-ascii?Q?nAjO30YbfYL43FIzNTKjHQByEM/R+OD63TeO5TEy+ZahBqBNGjEY/NrSkORY?=
 =?us-ascii?Q?Nt11sbmkB9TsJjbClpo1/PMMd2wuNZEUbSShSmBCq+9aTDBj8CwuqRuRoapq?=
 =?us-ascii?Q?0J4aakm4Q8aeIVb/qoK7aMr/lL6RF9An6GRBERWz9MtFxN6evtvhoqhoHR1/?=
 =?us-ascii?Q?p9yIAN9Eo6YEVNeCcw2FUSrLoAzav9UCpXen/GRIS1a9jaTCbIR4OrChhMwq?=
 =?us-ascii?Q?vQxVkTEC1vSI94PT0HxgE21y2F7rQeRHG9xe+FoEqSR79ZpQk6GSDxDuzqE6?=
 =?us-ascii?Q?Ew3/xx8WRL12xdRq4M9pGUihIaKvhrJxhKg2cWMTeTEu7l+Rnr29kFHtiCJy?=
 =?us-ascii?Q?Cb4cz+CqFQF0PvegRqXeMWQb4PW/xcxJnuHa64yi1Be2st8i1/w5E+Znokig?=
 =?us-ascii?Q?GthB5pZubupAoajltGrLE6cwaguLD1BtuJoPmit0iFQi0eeif+D7QupFFoNB?=
 =?us-ascii?Q?Z3eOfaSdvvC5NfVhVDMKVDnpQVx4s+abexnZ+YhOd7A7ijccqW6tRbZXhoyH?=
 =?us-ascii?Q?hSGJ3X59NHlrSI2TJCVsPj0PgFXV4M9Fupi2NYr7FekCxkBHwDG7/2U0927u?=
 =?us-ascii?Q?t6dlJa863xA/rxMq1coNh9euWOELYZbBa44HtS4qidwkinoDCEMntkQLT3nC?=
 =?us-ascii?Q?17S7xx0KFHsLiRY+D/sZQPT17MKqSUa4iTDym5Qte1ZHcDqGNXuaPxUMR/4Y?=
 =?us-ascii?Q?rxBuVI9Qp7HUzvbee0+W2RO1FyHFpnSov4miP6emy4FGlQc+qlM+K13SJyk1?=
 =?us-ascii?Q?S0zYybO2FiGUy61yQHik+Akph+ZJABAlgwEIfczXBfQY6fGlQoNOstbi/XXH?=
 =?us-ascii?Q?osj9j3CNTXtICLvzJV3Tr9mUKbT2D9fggzy92lW0ONfupKoQBRa5OllSHyRq?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfd065b-54ff-40b7-40d1-08da85e4f207
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 15:25:58.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pUGK3+/iIfwsDum0jO6STt/Hy/nGaaiOTTFj1qEFMCVIF4/3bvnk1wPT+P7GvbpASFJ9JoiDQRXW9XcZpBgcgY+MoeF7leoi9xoiEqNXm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5634
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Diff to v1:
 - fixed typo in commit message
 - add Reviewed-by tag
 - make sure it still applies

Henning

Am Wed, 24 Aug 2022 17:24:48 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> The status bit in the status and control register can tell us whether
> the last reboot was caused by the watchdog. Make sure to take that
> into the bootstatus before clearing it.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/watchdog/w83627hf_wdt.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/w83627hf_wdt.c
> b/drivers/watchdog/w83627hf_wdt.c index 56a4a4030ca9..bc33b63c5a5d
> 100644 --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -113,6 +113,10 @@ MODULE_PARM_DESC(early_disable, "Disable
> watchdog at boot time (default=0)"); #define W836X7HF_WDT_CSR
> 0xf7 #define NCT6102D_WDT_CSR	0xf2
>  
> +#define WDT_CSR_STATUS		0x10
> +#define WDT_CSR_KBD		0x40
> +#define WDT_CSR_MOUSE		0x80
> +
>  static void superio_outb(int reg, int val)
>  {
>  	outb(reg, WDT_EFER);
> @@ -244,8 +248,12 @@ static int w83627hf_init(struct watchdog_device
> *wdog, enum chips chip) t = superio_inb(cr_wdt_control) & ~0x0C;
>  	superio_outb(cr_wdt_control, t);
>  
> -	/* reset trigger, disable keyboard & mouse turning off
> watchdog */
> -	t = superio_inb(cr_wdt_csr) & ~0xD0;
> +	t = superio_inb(cr_wdt_csr);
> +	if (t & WDT_CSR_STATUS)
> +		wdog->bootstatus |= WDIOF_CARDRESET;
> +
> +	/* reset status, disable keyboard & mouse turning off
> watchdog */
> +	t &= ~(WDT_CSR_STATUS | WDT_CSR_KBD | WDT_CSR_MOUSE);
>  	superio_outb(cr_wdt_csr, t);
>  
>  	superio_exit();

