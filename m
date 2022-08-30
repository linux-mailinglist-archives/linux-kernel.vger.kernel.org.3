Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADB35A5901
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiH3Bun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiH3Buk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:50:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A93C58DD6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:50:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFj3d5DooAQhmm6STTDZSYQkZKTQdqiXVLcKKKYo/UxMFldfWwfu3z9ocMk3jDTqyNTxepLzcu2iD93GTuxLa2e7EJK7GWkKSeT3CCYOSAoMjh2MSOPYghkqymvSGiQ9rfQcECod+lC2knnn43otQwIPa8gsPqertus7ESp0/mgjknh/7UKEHk4Mes9OOFoZNNYzj97TyrwB16M6gXMoAxwTM9U2NTlDPHSKsqKagBmKImaUkF6IFfqOH+2+yjEJMYAcZLvlNJcFUtJbRqvL8zVOQ9GXhMTZ81VdSbgm48bmiSVhyr/U3C1wZdyOF3g+p4ojNK3+ZZ63lc/QYpS3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zQS7iFq9C9Oy1/wY/JaE+cHi9LvDNTnc5jJStWuUs0=;
 b=nqq42fHQfPKW8Heohr+LdQSIRln4T2mjDNW3OK8wE/sIj/xUiJGoVrwsi+PlY3QpHTh0bcOJxVl4dJyvSvZDDXA8Ome2DItJ6RGhA5d28NAwklydz/xTryMq1I6lW4Hb+F1CZysT3MAfahyBbA4Q6/Q/lEyEanEIM9QovErywNMsbaFOZJhk3JDbcZCQe04LVEx71qiqVt9tMK0n1gHEuvC4epM91qnskE3cvdpStg8G70eYbSza3KOmWPwHZJ23d+H004ax0hrLgbi3CdvWoW7g/2y3kBVHaMYtHxietvzhsBEzFIKNxRhi3Olsd0aefo4iR63GSKExKA7aFLkaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zQS7iFq9C9Oy1/wY/JaE+cHi9LvDNTnc5jJStWuUs0=;
 b=BOm0O0OzyXkygZazfYvkbiqVs4jk/pMsQC8ZafkPp2FZAGAhMbKSfLlrKCTFm1gO7pGPFFGZvOeDqGtXy9h5ii0AzsmAe3HQWGFNSaxK9ydR0MxfPKcxFCNFlhkNjRVvx3bVq/cPUuBMQR4T1K68acjAYLMZcbU/UbwkXgAUqAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM6PR04MB6437.eurprd04.prod.outlook.com (2603:10a6:20b:f3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 01:50:37 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%6]) with mapi id 15.20.5504.027; Tue, 30 Aug 2022
 01:50:37 +0000
Message-ID: <0e8c36ccc57d8c8e303933983a98671409125a90.camel@nxp.com>
Subject: Re: [PATCH] mailbox: imx: fix RST channel support
From:   Liu Ying <victor.liu@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, jassisinghbrar@gmail.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Date:   Tue, 30 Aug 2022 09:50:12 +0800
In-Reply-To: <20220829033743.2698606-1-peng.fan@oss.nxp.com>
References: <20220829033743.2698606-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8943c26e-f504-4ad5-6b10-08da8a2a08a0
X-MS-TrafficTypeDiagnostic: AM6PR04MB6437:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znnPPkiVu5QlwmC4bK5LsyOWrkjecsU1I7Zjx7OctIZEaJ66qP505WFOGGspNuf31g8BB3upvs00ZlKfX4aulgB0jxqKHkf+mveU+xtEhUvBSFYMrmraCaMwX72jWMAB+7Xlfo5s/R+BLHGqPT62rsP/m0pg2yByWbQbL+uA6tP1jgO0QtrZKnR/WtA8pNwWfRx6FLETdeZXENIlX5pqDoaVFs53kszGPA5dXzwYOqqvZX/AGxQxCss1hp/TMJfZZwTuGeMKAnuiBHNhpm9u/oliarmBxvDS/uhoDKkEieLuzemv1TIja4sg6mo3WWzanxwRtSe+Y0eG/garBhQfaS5oXc0VtTviSj7zOJXyxfM/urK+CipTgCbB1iDKykInLQFsSlAazKo0IImW2/KZEv7K8tvyeypfK+OmzFw6QOBxrBTxUojbY0u0TskHmndVVyty+MhIuXqL7pBG1utTIhdgoldEsp1MeYIuV3IhCzCbZNPELu/98wupbjltop2Gd/KiZwJ41mUISCEmC2+FvArT3ZY1P1Yb1UZIErX5EdvEwugMaOwn0u4a+UEkqAw3NjoRRCx4rFoJX0+Fy9IcukH4uinSs0qUPGgRrWAjpkjbHLTU62G2GosdcsTI+OVcAEA501fd/o5A2SPArmJyZRS/96pQc1qvG4+L4MsdULAvUeoNL1Ax2+wPWsaVlmqlfWeZvMtrpZ0dwh12J1an4an1pO/qeKsJmbwWmC68hKVnys3GLVNLuj/rQzVuP3xWsYdIDtV653ll86hgE1uu9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(6486002)(8676002)(41300700001)(15650500001)(6506007)(66476007)(4744005)(66556008)(2906002)(5660300002)(52116002)(8936002)(66946007)(4326008)(478600001)(2616005)(86362001)(6666004)(83380400001)(186003)(26005)(6512007)(38350700002)(38100700002)(36756003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUpFTitZVmEwMjRRaUl1WWRPZ2RERTRFQ1F3SGhYaG1KT2FpSGpDeTdqZWJr?=
 =?utf-8?B?QVZoSGt1aHNDM3pSb3FtTFZHbmhVNHJlTHdwS05hbWphRmZRWVdlMDVoTGlu?=
 =?utf-8?B?Mm5QaU0vem9kV1JnalcyTCttRnlQSTIxSHQrK09obldwcVBmQm9RSnAxK1JI?=
 =?utf-8?B?Y3VoTWVWYTY4VzhJSnJKNzZzUExxTDVuajF3eHFaY3JWSjNVVmFadjJFYm1K?=
 =?utf-8?B?cFhGaHNVRm45SnVnVU95cjhSNzEvVkFwcFArY0srNWVjT3pmTmMxa0o3SytL?=
 =?utf-8?B?bEZFeFFiKzZpWnlQL3VLTnY0RUdpNDJEb3J2ZDRwVFVMSktIbHFLMktvSVIw?=
 =?utf-8?B?eFNGMjl3L0JpeDJMcHRweDFxK0VjSmVIemRrK2tadExrVmgzWVF3QWQ5NjYx?=
 =?utf-8?B?Umd2RUVaK25mYi9NZFI5LzBzSitHWUtSRW1lbkZTNStDUGhzOXorWU5XZDNI?=
 =?utf-8?B?d0JFM0VYZ3hnMEw2eUZEMi9ETnl5SmlpaEkvS3hsWnRqU3NRUklMUGw0U0hl?=
 =?utf-8?B?Z0ZvU2lZVFFQdG5IY3QyUGRsWjRmVXp0NHBvN3VtbUN2enRUdVg1clBscldY?=
 =?utf-8?B?ekNOL2FYY3ZGMWJ0dktrVGdTNEhKT0xUSEJHOXhhU1pwZndXbHJ2VUcwaENZ?=
 =?utf-8?B?ZXVFQ0FrOWRqbWwzeHFNdWFJci82c2ZIM255dUNSU01ud2I1R0E0SUNtVFJ2?=
 =?utf-8?B?dG1mYS9UVmdKc3ZuQVg5dHZJQWNkVUZRSnF2KytiZUV0MFhOYXpRMlo0Ulcy?=
 =?utf-8?B?MUx6TzRRa2JFUzdDM21JWEZOM0FNWEgrMDNjUThlYnFHWkNwQkNyUlg1K3NQ?=
 =?utf-8?B?TENuMFN4TjluZE5JQ0FHR1ZEeC9GcVJaU2RXbVIvUmZLVW4xSnh3WlNhZ0th?=
 =?utf-8?B?ZktRV2NnQktTMExMMW15c0JuOEF0L1pld1J5VUt1RHZmNWVXVUpoTDJySHlj?=
 =?utf-8?B?c0V5VERxM2FrWXZORWVySnV2a2hhdmFxTXNkak1DVVRaQmFaU2lIWWFvUjVi?=
 =?utf-8?B?VWFZYVlUa3h6QmkyM2M0OWp2QU5ES0dUT3FwbGdkVDZsSW1GdFZ6L01wd2Vo?=
 =?utf-8?B?TmZFU3JIWEJjNlkrU2Y4Tnh0bUsrZnpnWjdMQm5od2Z0dnNSOUhwY1lBdUpK?=
 =?utf-8?B?MzJZWEs0QUR5K1p2UWhTUEF1bHo0cCtySitmZjR3L2I3SXRvaVJDRWFrSUEr?=
 =?utf-8?B?NGplWjRvOFFydGVvMjNCSzlYUVB2SXpPVmE2WlFjSnU3RWU5d1hlSk53MThs?=
 =?utf-8?B?V1VURHVmZXhPdVJhNXJiRjhocWtzcTBJbXdobUZEa1A3MkJua3gyZHJpU2t5?=
 =?utf-8?B?d3ByUnVxSFZRMW1uSHpkTjZETkd2QlFXTHJCaDduc1lBZ0JqZ2F4SUlHcU9w?=
 =?utf-8?B?UzRXeDNMT2YrbW9xbENQMThYWnRRMURZSGx0Y0NtSzNRUElOM2NVSW9YVXBz?=
 =?utf-8?B?djNMNjhlNXNkWWpIVk82UktOQ0QxVEU3ajA2UkhwQ1F5M2phZjVUTUdqMTZ2?=
 =?utf-8?B?eXBTZGE0OFk0dldpalBxY1Z1RityK25wMUtqS3I1QjZQcm5xUXhSSkloWVBh?=
 =?utf-8?B?WmtkZnJkVWhFdmZxZnNaM1h2MkJ4Z2R1RkI3a2hQbDdubVlIUVlTYU5qRGV3?=
 =?utf-8?B?UXBtMUdhUGV2Z0tZKy84UU83RzdROHJ2T3lZM2xvL1FDSDdKaHU4WXBvelRp?=
 =?utf-8?B?MUpKalUzUk51VTk0QmpLSGRRTXFOUjVtYktlYWVKUk4vWUVvZVRmV29NTG5Z?=
 =?utf-8?B?WlcrTzZHZ2R3YUh3VVFVUnN2b3dsTFA5QkRyaGsrU0RrdWNUZ3hxL05iZnZT?=
 =?utf-8?B?UXU0bUZ1M05CUDRjNDBVZEhQWEFwd3E1cVlUSkZjSnJJeHFHZ0ZIaWZHcVZB?=
 =?utf-8?B?cUNidzd4anVBdFM4a1lmZTcxNHkzSk41U1h6T09HdGtnZmVpVFd4RUdjS0lq?=
 =?utf-8?B?YVcvNXM5alFsckZEOGNMeU1la21IOWYrS3Z4am10WWk0bjRzL3BENkhkZHI3?=
 =?utf-8?B?ai9NbElXNnY3aVl3VVZ1L1BFTUk4WFBiTGdWaXdMTm5lMmtHRXduTGdMcVNs?=
 =?utf-8?B?ZW82WTZwTUJNSEVjMGZ1Q1RIdEtDb2VQb2FHMzhYZ1NCZk9NVjRCaTNRM3lz?=
 =?utf-8?Q?yh/1czxXLbFM9HuD30insz/PH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8943c26e-f504-4ad5-6b10-08da8a2a08a0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 01:50:36.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kvgjrDpQubUP1G1rL+mNkk3qF4W+Hc5agrkTcHbA6k2VP6y6UHqdhABL6L/HuZhu4lavYGnVvCrHII3gstj1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6437
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-08-29 at 11:37 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Because IMX_MU_xCR_MAX was increased to 5, some mu cfgs were not updated
> to include the CR register. Add the missed CR register to xcr array.
> 
> Fixes: 3d38ac9c40bd ("mailbox: imx: fix RST channel support")
> Reported-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V1:
>  Tested on i.MX93/8ULP/8QXP/7ULP
> 
>  drivers/mailbox/imx-mailbox.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Tested-by: Liu Ying <victor.liu@nxp.com> # i.MX8qm/qxp MEK boards boot

