Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0435AFA08
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIGCmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiIGCmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:42:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82979ED5;
        Tue,  6 Sep 2022 19:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+LCWwljOTebg7LpHSn13i/YE9c/EVDBtLqulX0W9Vj/mdbin0s1Z4p3cz4d7R1JrgAysaCBMpq0s1VzhHutWWKXyL4O34ID+wXCqJKTfTL9imzlATjsWOFaYT6H7PshRAU2NsdVh+oWLecMQNfPvBuRBwCpT43uVI2sDBB9Ov2ZQzbx+mJNaw23HMXoyBSz9DshoZuqH0pYOYFdCGcQKDKtWUX3k0A9saaeExEav8jANVe0umtYHnHIBBmhmg4kASmS9QDdp1+PdUHXAovV2bAwnzKI03MJ1RocZSRhAGbT/wbXLY7kkvu9GBBP3ZUSZoFLhjB0KTfiRxoq3kD8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPc3CWue0/6lSHlTnYytgrhGTiKjlM+xz0nv7PJ1IVw=;
 b=WzsoEm2YvSW7Bv8w/EuwkH9J05IAFua7TmSTaH7r1albCo3hzZUmAmrDtYVFd+p5+GV8GQUySiFeEPXZYy1qWk/wXC6OW0TDjzi1oV0S+N2bCgLo6qHCEwLPih+1puVM/Rk8jdmmyc/SbzEwtfKMGFMDHsyakADKVkqmRLZ3tbbYJXJi3EcJiU4RUaxhuy+xVJWQklKptsbsZr2O60oK91XSOK4qeAvRJ8Vj1KICVttuuyoS6t4E7uNl6mgSOi/ziBbBff+oudiFQh3y3RJkBdSvrS4gHOjIWCVGA4cSEHkyqihr9IHOhC1aLyxlygdiLFnxI5eHQBLZq53G8bb6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPc3CWue0/6lSHlTnYytgrhGTiKjlM+xz0nv7PJ1IVw=;
 b=ffbCThGqZMzaha85VRIliGBA62u0f2eSemQhBIZZZb0w1e7rmNegXfDft1LkbkXrUP2ddh2XQXLBMVUgaBcSwXMdBTQAHYnRUR+3j/OpWcNPuk6PuONMzI+4YvwMeSup7jHlq6YYqDhoUTeVOfjJofi0lJE0MgDspmYhwrK3Cj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7410.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 02:42:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 02:42:00 +0000
Message-ID: <80ff145c-7f83-6d5f-7c9f-9bae1b6ffb89@oss.nxp.com>
Date:   Wed, 7 Sep 2022 10:41:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V5 5/8] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV_MWR
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220822064536.3947512-1-peng.fan@oss.nxp.com>
 <20220822064536.3947512-6-peng.fan@oss.nxp.com> <2849448.e9J7NaK4W3@steina-w>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <2849448.e9J7NaK4W3@steina-w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da22e3a5-92a3-4c8d-d31a-08da907a8a1b
X-MS-TrafficTypeDiagnostic: AM8PR04MB7410:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9m+Oh2x44UolXNhqBbvOcADypvFBEjSpY9RdcQYR3YiSbWUBjr8boZpzy3vAEuhpAH38K5rVEmlrUXv6qyIW+/BUuczqc5/MrKrxebClJRnbndd86nbJPUuVYZqvJBroNwk+dnz7oFprxYBohr/+Hl+pj7kyuyNUPniPEHnCQkByIBCHtmARBcCi7rZ4etP070zowMPUlbpKte7XyZzR5KB7S8tloB8ts8NE7b/qyw3pflD15y6A6ERod0JM+R9rBiWGUqIeTMAYEo28DLe42e+GkREL6vKeMwFf1sJqX8JL5KY+lADO8xPNFRbkDbTM8mrSAJM6ZwZ6INetxu/NT1Su+ffAYvG81ADG+fgXnY6UcJ4x5r7+TNZRYgd5MdMb5wdKC40rSURDQEtNl7FsFnbMmO97qOBVd9woDc8vh8DcCML2kBQudQ1ndsDaqpB61sydD1cNEDnMCnaIGq84dRzAfZkYXf0FFDITmFUGJDLuyXcxsKzXJ5tedS7wEKq+o7MkF8at7RDGIMUNFuL4+ehnPJk1U3Kb1ci8OOUWzWVr2GHcqPVybbWuihRhzUElKO6nda30hOtH9BWsfBQRy+I6uUKN6VAjORv3QJg1NUucV8BKbfymGR7oU5ZxiSzrxYLdOOX0IuT8brdt+iqkNDYFYiG9CcGPBXx6HBUMtONZzPY+QV15I4D4n1MVMrea/ZfwwgKbJSCb9LpCgN834Aj9SKcj3ucrNk6yEFa2bUnx73dhT7RhNYl+sJkSQIlBlUOIHrWJ//Y25DnfkDFcakkSWJH5tSSWUO4FFnHYgDcT6mzzvyd0AeTQkmyPnEzYTbCC5/uT+gELz2Q/cJ/gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(6916009)(53546011)(86362001)(31696002)(31686004)(38100700002)(52116002)(316002)(38350700002)(45080400002)(478600001)(4326008)(66946007)(66476007)(8676002)(66556008)(44832011)(26005)(2906002)(6666004)(6506007)(5660300002)(41300700001)(6486002)(186003)(7416002)(6512007)(8936002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUM3YzNEbnJ3NHVROTRUbnRySDllWUszZ3RQMDZYeHpTZ0dkejZpSDRDUVFp?=
 =?utf-8?B?akY0clVCV0lkUWxuYTU0RWtRREtXNEw2NEcwMHBIZzE4RFJkbjVNMVBpTzhB?=
 =?utf-8?B?WDdhSDBsRTVTVFgxQmQrVi9pOGpNblEyc2dVZ1RiZnZFR056VTRCY3d6cG1u?=
 =?utf-8?B?UEx2bEFOdmsxRzk3dDZHcWJVc0VuTjV0WkFPYVV5OTIySHY3VUROTFlCT2c2?=
 =?utf-8?B?eVE5WTU4VGpBY3U0Ulc0RjJab2F1VEtxU1pOUzMwSFZlT0xUbEhRU0JPOGFJ?=
 =?utf-8?B?L0ZLVWdwZmFweWZyY1k0NHg0NHlucGRQYUVqa2RmakIyZFJwakVzRWVqMWVB?=
 =?utf-8?B?QnhMYUhKQzMrM3pLdFd0L1IwUHJKaWJydUlEd0pMSVdkaXhIQXRxaVhSZ1dG?=
 =?utf-8?B?RzBhaHBQVmxCLzJKa250UHcxZDd2U0JpL1VZeTFmbG0zMHBjQXJYQ2loY0dh?=
 =?utf-8?B?WEViejFjUkpqZjRVbU5RVXFRZmhwOFlFTGk5M2lBN29mNzlndXQ5WnJRVnNW?=
 =?utf-8?B?Z1Nzd0FzVCs3VVpaM3RwRWxjODdINEFsdys2bUQraDArOG1UT1VRVlVzWlF4?=
 =?utf-8?B?dDd6UFRldEJmLzd3cGp3T1o3ZU9xZEpUbGs3MGxKb0M2bGh1Y1E5TmI1QlVW?=
 =?utf-8?B?RWFveDM4ZktFMUs3TlZXVWlIcGJmdFRQWmczZVpwQVhZZnp3aHorbjJMYzJr?=
 =?utf-8?B?MmdnYXhSYmZwNHVXcGZtV3l0S1Axdlg1V3JFQ1JIc2IwSGcrWkdxajJ6SDBy?=
 =?utf-8?B?OHdhbXEwR2FuUlNLL0prOTNvSDlmdktVS3gxVUtkY2lUL3BDU21ZOVNYYVc1?=
 =?utf-8?B?WnpzVE0zckdEVEdwRzVIZnJneFRNYWhnd1ZhYnRUY1F5NlQvNGd4bTI4ZjR2?=
 =?utf-8?B?YjRReGpNVTliWVYvWXpURGt6TUY4WGVzYytNRENjRlhSTUIzUnF3TEhST2hx?=
 =?utf-8?B?RzNrWi9sQ21RdERGSmliYkZjbXB6R2gxb3k1bS9kUHV1MmNYV3lBN0ZUUXNn?=
 =?utf-8?B?ZzdBekFUelliUFdEU3c2VEpaNG45Y2tMdlJ6WVFaSXZZYjVwU2RoSEg1RDEw?=
 =?utf-8?B?aXZMWjh3Rmx1K2Y2a3pua2VMNGYyazliZ05BdUEwbUd3WWhzSHEwZjlnbVU0?=
 =?utf-8?B?cEp3Tld0LzdLQkNzK1JHcGlEREdRK2srWTA2MFhWdVhyd044Zzc5MitDcHdx?=
 =?utf-8?B?bnFUczB0NlJGbXcxMDFJNVVRb0U3cjlaTkZ1ZGRYOW5UMjQ5RTQ1UlloR3V0?=
 =?utf-8?B?bmRFM3RBSG1RT285WDBiazl5eXR0NW0zMmRPTW5vblZaUWZKL2pSNlNucHhz?=
 =?utf-8?B?TzhLNjlENnpOR3lJb2NWUmZrSmU2RXp1ZE5pM3VUYTFpSUVpOGI3dEpuRG1K?=
 =?utf-8?B?QlQ0SkhnaWdzS1JOV21vSlRNb3hUUTQrbXRFSGJ3YTQ3bHREOXVtZXVKVk85?=
 =?utf-8?B?b05icEVvbkkvUmhCeCtiamJ4V29BWmdIRzBnMGtKUHB6NkgxSlhrbjViNlZr?=
 =?utf-8?B?Z28wUkU3Uk9FMk9hUXVkWlRsNktsOUR0d3NqTThiamV2QVRkYlV4U3hNdXlX?=
 =?utf-8?B?NVl4TWNPeW4zUmJFd0xVM2xQcEt5c1JseVFhaDVGZ3IwS1FNamZ1OUxQQnJa?=
 =?utf-8?B?QWJObjg4cnRBaStqdSttazVQS3FwMW9OeG1ZYjZ6bGI4blFlbUt6Tk55Vmhp?=
 =?utf-8?B?R3dPNjUvcnU4VnVIckVLcE41NkJyYnhMOE1WVEkvREhPcnlaZVhTSGhsc3F6?=
 =?utf-8?B?SGJtT2VVRlREOXV1TjllcytrUE5vNEpCQzkwR2hHd2dxUG4rdzJkdHRKOGs4?=
 =?utf-8?B?RFZ1RnpTRlh5R05Db1VwVjVvTXZ4a1N2LzgraEcvTFFvc0NwVndoczFmaklW?=
 =?utf-8?B?QXU0WTF2eFlQNGZJZHFqNUl2Z2Vxa0pwN3JxMjFNS1dtbk44U2kyc1FRcFZY?=
 =?utf-8?B?UkJac2ZQK0V4b0c1aGJPOWFBdDVrMCsxQVNZeHFSUThGMVVIZitlVGk2TWpB?=
 =?utf-8?B?QnlMN1Y5SWxlcGtHVTZSS2tWbU8weHMxYk0waDNEajU4U2N2OElJSkt3b1Bv?=
 =?utf-8?B?bmwzQ0ZoWFhjWnlSTC9ZT2lOSWNBUklhQXJ2dks3RElGTGJWNEkyRzdkYWp6?=
 =?utf-8?Q?I4gjqb1C93CNeIlJd1g9IgzEg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da22e3a5-92a3-4c8d-d31a-08da907a8a1b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 02:42:00.8691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bt4e8py2G3M3Dc8XWxN2LyyaccN/xXltLfuQ4rdXF6AOPvKO43CTFT/+2Z5+/0Cd6+0kuBPIairBeRBOIJVaEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7410
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/2022 10:37 PM, Alexander Stein wrote:
> Hello,
> 
> Am Montag, 22. August 2022, 08:45:33 CEST schrieb Peng Fan (OSS):
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> i.MX8MP HDMI supports HDCP and HRV_MWR(HDMI RX Video Memory Write Master
>> for RXRX validation), so add them.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   drivers/soc/imx/imx8mp-blk-ctrl.c | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c
>> b/drivers/soc/imx/imx8mp-blk-ctrl.c index 6f983adcb47c..527d45d12a54 100644
>> --- a/drivers/soc/imx/imx8mp-blk-ctrl.c
>> +++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
>> @@ -235,6 +235,13 @@ static void imx8mp_hdmi_blk_ctrl_power_on(struct
>> imx8mp_blk_ctrl *bc, regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
>> BIT(12));
>>   		regmap_clear_bits(bc->regmap, HDMI_TX_CONTROL0, BIT(3));
>>   		break;
>> +	case IMX8MP_HDMIBLK_PD_HDCP:
>> +		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL0, BIT(11));
>> +		break;
>> +	case IMX8MP_HDMIBLK_PD_HRV:
>> +		regmap_set_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3) |
> BIT(4) | BIT(5));
>> +		regmap_set_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
> BIT(15));
>> +		break;
>>   	default:
>>   		break;
>>   	}
>> @@ -283,6 +290,13 @@ static void imx8mp_hdmi_blk_ctrl_power_off(struct
>> imx8mp_blk_ctrl *bc, regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
>> BIT(12));
>>   		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(22)
> | BIT(24));
>>   		break;
>> +	case IMX8MP_HDMIBLK_PD_HDCP:
>> +		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL0,
> BIT(11));
>> +		break;
>> +	case IMX8MP_HDMIBLK_PD_HRV:
>> +		regmap_clear_bits(bc->regmap, HDMI_RTX_RESET_CTL0,
> BIT(15));
>> +		regmap_clear_bits(bc->regmap, HDMI_RTX_CLK_CTL1, BIT(3)
> | BIT(4) |
>> BIT(5)); +		break;
>>   	default:
>>   		break;
>>   	}
>> @@ -365,6 +379,22 @@ static const struct imx8mp_blk_ctrl_domain_data
>> imx8mp_hdmi_domain_data[] = { .num_clks = 2,
>>   		.gpc_name = "hdmi-tx-phy",
>>   	},
>> +	[IMX8MP_HDMIBLK_PD_HRV] = {
>> +		.name = "hdmiblk-hrv",
>> +		.clk_names = (const char *[]){ "axi", "apb" },
>> +		.num_clks = 2,
>> +		.gpc_name = "hrv",
>> +		.path_names = (const char *[]){"hrv"},
>> +		.num_paths = 1,
>> +	},
>> +	[IMX8MP_HDMIBLK_PD_HDCP] = {
>> +		.name = "hdmiblk-hdcp",
>> +		.clk_names = (const char *[]){ "axi", "apb" },
>> +		.num_clks = 2,
>> +		.gpc_name = "hdcp",
>> +		.path_names = (const char *[]){"hdcp"},
>> +		.num_paths = 1,
>> +	},
>>   };
>>
>>   static const struct imx8mp_blk_ctrl_data imx8mp_hdmi_blk_ctl_dev_data = {
> 
> Something is missing here. Iget the following error during boot:
> [    0.886211] Unable to handle kernel NULL pointer dereference at virtual
> address 0000000000000000
> [    0.895043] Mem abort info:
> [    0.897841]   ESR = 0x0000000096000004
> [    0.901606]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    0.906942]   SET = 0, FnV = 0
> [    0.910003]   EA = 0, S1PTW = 0
> [    0.913159]   FSC = 0x04: level 0 translation fault
> [    0.918054] Data abort info:
> [    0.920943]   ISV = 0, ISS = 0x00000004
> [    0.924791]   CM = 0, WnR = 0
> [    0.927761] [0000000000000000] user address but active_mm is swapper
> [    0.934157] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [    0.939749] Modules linked in:
> [    0.942813] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc4-
> next-20220906+ #674 2c55fa642ba20b0dbb66c0e78dacc9ca96d5e733
> [    0.954099] Hardware name: TQ-Systems i.MX8MPlus TQMa8MPxL on MBa8MPxL (DT)
> [    0.961100] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.968099] pc : kobject_set_name_vargs+0x10/0xd0
> [    0.972823] lr : dev_set_name+0x58/0x80
> [    0.976674] sp : ffff800009c7b860
> [    0.979997] x29: ffff800009c7b860 x28: ffff000002d728f8 x27:
> 0000000000000150
> [    0.987172] x26: 0000000000000009 x25: 0000000000000007 x24:
> ffff800009ab8958
> [    0.994347] x23: ffff0000000a0000 x22: ffff800008eb77d8 x21:
> ffff000000225410
> [    1.001524] x20: ffff800008eb7808 x19: 0000000000000000 x18:
> 0000000000000000
> [    1.008697] x17: 702d78742d696d64 x16: 682d6b6c62696d64 x15:
> 68203a656d616e3e
> [    1.015872] x14: 0000000000000000 x13: 70636468203a656d x12:
> 616e5f6370673e2d
> [    1.023047] x11: 61746164203a6c72 x10: 74632d6b6c622e30 x9 :
> 7274632d6b6c622e
> [    1.030222] x8 : 3030303063663233 x7 : 205d353039393738 x6 :
> ffff800009a240e0
> [    1.037397] x5 : 00000000ffffffd0 x4 : ffff800009c7b920 x3 :
> 00000000ffffffd0
> [    1.044572] x2 : ffff800009c7b8d0 x1 : ffff80000936ca78 x0 :
> 0000000000000000
> [    1.051749] Call trace:
> [    1.054199]  kobject_set_name_vargs+0x10/0xd0
> [    1.058574]  dev_set_name+0x58/0x80
> [    1.062072]  imx8mp_blk_ctrl_probe+0x5c0/0x660
> [    1.066534]  platform_probe+0x64/0x100
> [    1.070297]  call_driver_probe+0x28/0x140
> [    1.074322]  really_probe+0xc0/0x334
> [    1.077909]  __driver_probe_device+0x84/0x144
> [    1.082284]  driver_probe_device+0x38/0x130
> [    1.086486]  __driver_attach+0xac/0x244
> [    1.090334]  bus_for_each_dev+0x6c/0xc0
> [    1.094184]  driver_attach+0x20/0x30
> [    1.097772]  bus_add_driver+0x174/0x244
> [    1.101622]  driver_register+0x74/0x120
> [    1.105474]  __platform_driver_register+0x24/0x30
> [    1.110197]  imx8mp_blk_ctrl_driver_init+0x18/0x20
> [    1.115009]  do_one_initcall+0x58/0x200
> [    1.118861]  do_initcalls+0x164/0x19c
> [    1.122534]  kernel_init_freeable+0x134/0x17c
> [    1.126909]  kernel_init+0x2c/0x150
> [    1.130411]  ret_from_fork+0x10/0x20
> [    1.134003] Code: a9bb7bfd 910003fd a90153f3 aa0003f3 (f9400000)
> [    1.140127] ---[ end trace 0000000000000000 ]---
> 
> Adding some debug out shows:
> [    0.866795] imx8mp-blk-ctrl 32fc0000.blk-ctrl: domain->power_dev: 0x0
> [    0.873257] imx8mp-blk-ctrl 32fc0000.blk-ctrl: data->name: hdmiblk-hdcp
> [    0.879905] imx8mp-blk-ctrl 32fc0000.blk-ctrl: data->gpc_name: hdcp
> 
> AFAICS the power domains 'hrv' and 'hdcp' are missing in the 'hdmi_blk_ctrl:
> blk-ctrl@32fc0000' node thus resulting in a NULL pointer from calling
> dev_pm_domain_attach_by_name().

The HDMI blk ctrl dts not landed in Shawn's branch, could you share me 
your dts change?

And dev_set_name, as I recall, Lucas has a patch to remove that.

Regards,
Peng.

> 
> Is there a patch I am missing.
> 
> Best regards,
> Alexander
> 
> 
