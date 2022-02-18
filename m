Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED104BB5CE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiBRJlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:41:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiBRJlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:41:50 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2107.outbound.protection.outlook.com [40.107.21.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C44C4D;
        Fri, 18 Feb 2022 01:41:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5aE039+95K3vWAkidg5rucblTAkHLEZlia5ulvi+K+u31UVOWh7OT/XRUTzSSCdV7qx6TNXrRLY3fSUwLE6lh5Kw3CPI/LsMSNzSt5xa5LFf2ZtB9f5qNQp6op/t97vC4kDHAC6DbdIkab58RLLWdgVhffoNBAc+0/gPpNr7wzNf0VmxUEXeHd47NrL3CvhIp7zC2BDz5lln6KERSr9EbAkQDJaYCeZnsmadSuxo8uI6HorHaGD13EqzM0xSEXJC8Q2zfZrau+dI31s2MvJDd8r0/0/wVeUvPGqZUVJ/R4mbxDwII70h6PvRFvvDvxls2cCsOhtYwCjGIl9r2uXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiExnOWIywmDhDRGHSmlLJIuI38zGpCwcags1fjZhWs=;
 b=ZYDB5dpIE5AypZWyqINuAFPggDdVunIzaRbWugf3zW7DqnCCOSVBwkez0d15/bPpgris7Vigx5UVAlYaXPRC3mlmxX+Mkhu3JdLL6ZKnV9an8HitLdlJ/Hz7PW38wLOsWKPaDi97gwBa3CTA/IMx30ZXzMw6oAqsDcjb5Jml4eCLO3Kvfr2KhOCrWhxqVHbsrPqo/2HK0KZaIZsxrxa4sHwEMvp83bAR/EJJTJkx8Ro6ustwI0UMg2UpqMFkuc57FUHCNogi1AaIgjultmpv5tPP2pVshSlZ4e8ydjkGbwv80YP0nbITyJzOg+MqmyMKFm2HiVqgs8Crrp9p30kgHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiExnOWIywmDhDRGHSmlLJIuI38zGpCwcags1fjZhWs=;
 b=s+4hGXH14iZ2NEScZvksaGYhHIwoENpQxSQ0vo2JqoBXzjoHxFPo9QHmWxWh6YCNReYU98qAFhYUyqyAKncriK3Ge8Ukar3Cciva/gszaFq1yfaBTvqecFQk4IN/eRkwVFFUn4G/SJ0vWRkIiZEjraM2Qb47F9B1m6jLZtYJiso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM7PR07MB6916.eurprd07.prod.outlook.com (2603:10a6:20b:1b4::19)
 by VI1PR0701MB6960.eurprd07.prod.outlook.com (2603:10a6:800:190::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.7; Fri, 18 Feb
 2022 09:41:27 +0000
Received: from AM7PR07MB6916.eurprd07.prod.outlook.com
 ([fe80::594:fa1f:92c5:e546]) by AM7PR07MB6916.eurprd07.prod.outlook.com
 ([fe80::594:fa1f:92c5:e546%5]) with mapi id 15.20.5017.012; Fri, 18 Feb 2022
 09:41:27 +0000
Message-ID: <a828b1b2-9e32-57b2-6d60-b1b8de90222a@nokia.com>
Date:   Fri, 18 Feb 2022 10:41:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: add tmp464.yaml
Content-Language: fr
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>
References: <20220218065856.1899086-1-linux@roeck-us.net>
From:   Agathe Porte <agathe.porte@nokia.com>
In-Reply-To: <20220218065856.1899086-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR06CA0067.namprd06.prod.outlook.com
 (2603:10b6:3:37::29) To AM7PR07MB6916.eurprd07.prod.outlook.com
 (2603:10a6:20b:1b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 341524fb-ce51-42b2-56f1-08d9f2c2d5a3
X-MS-TrafficTypeDiagnostic: VI1PR0701MB6960:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0701MB6960337CC450DDDE0367351E9B379@VI1PR0701MB6960.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xaGhAiL49Wqf/FKqOFnHNDRJbEW49BY0qqPUNb6hTCfW4pD80+eu42PldZ7/8C4F24ANiKjXUuOgDbAoS6JaBlOZHzOwsUS4CARZdhb0pio0n/+1NSqAojzjakW+IR3yIV+9Ip4uSf4IUhHTfSm5Tf+mgq4ncz8J9KOmWhIwWleoYYyhkNtyxviclrzoycnIBvmlGLGeLVlnKaKvNiaAz15vMul4HoGmCAU9qdAGs8PI322OMlPO3slwF5iIHz+rwBFOz2mbDagrwXB1DQPwb/EheqR7DFSGiRQNH6NSXCGEBCGtKsyky82pCRZcfgZuQhlsGiJPxPAykb7MofL4m/A7di15FEGnVIgAidsjnvcgNVTHXk3IKqaeW+AwdryueSozHPdyiNbdcLjDwllMb77+gMMTi8AGZ6wPW4FORuWbhsMrh6dpZZ0aH8sLQJzB3wPd1a1pyArCrztR8PFHDvRdLSI07R6aLoKm3cd3gdjoXyu8jkUx9ziLdWU2+8NnzrQZp+ZGoc/8mwMXkwXIO1rPFHI7XFXsSkNLuTJ0++asb0xaxvJJisBldXJLZAswmzJCDEQpxmRDHGDymebtRv6U5KLFj6nfwq8fjBhfdUSCEoBYG6fmocatBSoPwrJ2PFJ/So6vUODQxF9vblfumW+Yw2axBFm49vkDFakdkRPpPaoBCnyoFZJ6UKhZzHMgTVI5sznSXq8LvggC5mGCgJXJhLmy2UYt+NDKZNBa8xs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6916.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(6486002)(6512007)(44832011)(38100700002)(83380400001)(2906002)(82960400001)(107886003)(26005)(86362001)(31696002)(2616005)(186003)(66946007)(5660300002)(508600001)(8676002)(4326008)(66574015)(316002)(6666004)(66476007)(36756003)(6506007)(8936002)(54906003)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2JXaXpZOFV6SUl2bTdHS1VrMXdEbW5VaDY4bHIvMThnUGZpMlowZzdpYnBu?=
 =?utf-8?B?ZytJSmlvaHNoR1VZQVkwWTFYSkZjRnh5aG96TXV5eDBiSGp2Q1pnT3MvK1li?=
 =?utf-8?B?ajBwVCtJRWEwbEtSd0RKd3dTYm8xMEx3Q2NWTzVDVDJxNFFiNEQ2cWJ1L2pN?=
 =?utf-8?B?c3B2SjF1ZklWdGRrcm50Z3dha0szRkxXWitIQVVjOU1IbVQ4Yk9XTit1Unln?=
 =?utf-8?B?VitvNmkvTVF2QXlOb1k0QlBPU2pFUnRIU012dFE3L3U4WkJLbEV3UWRUbXl5?=
 =?utf-8?B?Y3NrcTE1RndiL0o5Y0l0bTBTbHFENW5SYWZGMHd2RHA2UTcrYVBJL3ZyVWdH?=
 =?utf-8?B?cHhGdktyYkQzcFlhcVFER3Z0QnRzRE5UdklnZXY2MzlRUHVYZGNBTW14NERj?=
 =?utf-8?B?ZUFDN1pERDA4Qi93YkhQcWJqeG9WbHJyZHU0NmZqWUMwRWg4R1kvT3NpNmly?=
 =?utf-8?B?TkkwcFZwTUpNaWZhc3VkZ1JiZ2VuN01aRDExWTVyRmIyRnRVdTRsNzExWHQw?=
 =?utf-8?B?VmtDdDBCQ3pyU29GSVk0VXlkSW13dVFVUkNWWUxoNmluRjRXYk5Vd0pNYWw0?=
 =?utf-8?B?MVdtdWNFTkdrTmt2UHJEQTA1VWJ0SVJpUjRqWVRsWlZXeEVNWmhkaDRCVVVo?=
 =?utf-8?B?K0tqeDZVZTRFSTlUYWU5UlFCV1lHNTUzYUExZ1dwL3ZpVmw1SE5oc3JtbFBB?=
 =?utf-8?B?N1lMWit1QmNBSEMrNXF2SWQyRVBGNEVGNThQR0JLYWdBdnltRHBLWS92bXJQ?=
 =?utf-8?B?d0lOaE5CbElOWkJ6cVVkelFXWnF2b3RBS2RzYnI2VzF4V3owRUJoOG5DVzBJ?=
 =?utf-8?B?QzdFOGJvRlpFN1djaGFPT25SNVorS3UxUlh2aXpIU2ZxN3ZKVUZkWm9IejFS?=
 =?utf-8?B?dWs0S3pPYm8vejZwYkFVU0lSK0JXN0l5ZVdvQW5FYjkzemNnSFVSQVdYQytN?=
 =?utf-8?B?MUsyV2lzSWN0dFFsbGxvRnJsOHU0UXRqZVpEc1FLT0ZEellXdlAxWjNIVHl6?=
 =?utf-8?B?ZWhoLzNZWTdLQjEwRlVabitRaVZubkNaeVliaTdkb0FZWU9mRjJlYjhzbVRu?=
 =?utf-8?B?cmY5NVp6UFNtcFdBWTdoOGJNQUk4bXluU2dHNzA2SllOSzdwWTVzbVl3OElx?=
 =?utf-8?B?K01oeDY5RW9Yd0lMUmhsaWZGMkg3cGROdVpjNVpFdURscEVlWE9jSUNsdUh1?=
 =?utf-8?B?bDNDa1QvWm5GL2VTS0dINll6V2d3UXJBdFJwRVkybUxHUTU1U3B2WkFXeTVj?=
 =?utf-8?B?ZFZ5QzhaY1ByNVFkRGJZVEV1WGltc0paaGlIMnRvNE44Q05uSUExZzRxUWhR?=
 =?utf-8?B?VjZZb1ArOW4zcEdyblZmYkZoZnlYRHo5ODZCVUdwbEdVWll4eDBhcUozVzIr?=
 =?utf-8?B?aUxTSkRBK3MvVk1YSk9ZbkljU1lzUjg2SVdLVEdWbGJSREI3cEVrTzNQUDYw?=
 =?utf-8?B?ZXZuWWw1Z005dkhSMWxDTDk4V045a0ZjNUNTZkdVTlU2K1M5NDdWVDBaa1h0?=
 =?utf-8?B?ZWxoODNyeERjL0VXNlBBd3ZaOHF6Q0ErRVdaakpBMzJPS2RPTFJkcXIrMTc5?=
 =?utf-8?B?aDY5SnNpL2RnZkhLWVVMbm5mVjduY1krWU1XNUkvenM4TjRjRFZyQmt3bjJn?=
 =?utf-8?B?eXNucTFmajY1OGRCZjVZMWdMTkNhVVc0SWRubElqZjVSOUg0NzFyME9wZzZy?=
 =?utf-8?B?YXdaMUozTitOUElUVjdLQ3BzMGptOSsybEw1c25QS1pjMGV0bE9vZUZGeGhw?=
 =?utf-8?B?UUhDQU5kOVQwTzNjS1hPelZYRGhGVXFLVG9ZSHN1bXhFc1VSM2RKVEVOa2Z5?=
 =?utf-8?B?M0dCYXpGRzV2Z1Y2RHRUbDhDYUNlUEpMSVFUSTV1VkQ0N2VzN3Roc0RFWkZL?=
 =?utf-8?B?VnpQM1k2bDl1TmU5VHVaMzRmYmZYVm44UEo4dVNaYklYWFUvczNTaFhBa1hF?=
 =?utf-8?B?VFJOOE5rdFNOVktnaHI3QmxuOUFjcGpWNTBUQzY5Nk9OUFVCRU9RYzVqWFhQ?=
 =?utf-8?B?eHJXcjd6Y1dTWjlYWVNObkpSN0EvemFkUDdTbVZ2aVVRNjBiS3IvQU5PWklE?=
 =?utf-8?B?cGhoYm1YSC9GenNPcVp5RDgxWFFibk4yYVBCOE8zTjVYbXFPaDVkcllZTll6?=
 =?utf-8?B?U3U4UnV2ZEJkWHN1UjFERTBBWndNNkxSclM1MzFCV3BFUStJcC9FMDBrMVRu?=
 =?utf-8?Q?Ru7SwE5EDpf8SUNts8uUYvw=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341524fb-ce51-42b2-56f1-08d9f2c2d5a3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6916.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 09:41:27.4276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbm59Tp6yGrWl3c3XUqbEk+vGvytsbIqL8wFHeUd4yGgvCaX03eQcd36ALfcijtgPY2Qu+xzrfweh+haY57jrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6960
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Le 18/02/2022 à 07:58, Guenter Roeck a écrit :
> From: Agathe Porte <agathe.porte@nokia.com>
>
> Add basic description of the tmp464 driver DT bindings.
>
> Signed-off-by: Agathe Porte <agathe.porte@nokia.com>
> Cc: Krzysztof Adamski <krzysztof.adamski@nokia.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v4:
> - No changes
>
> +        channel@0 {
> +          reg = <0x0>;
> +          ti,n-factor = /bits/ 8 <(-10)>;
> +          label = "local";
> +        };

Setting the n-factor for the local channel is not supported, so we 
should remove this attribute for this example and move it to another 
channel.

Here is the output on a hardware test:

[165599.122883] tmp464 16-0049: n-factor can't be set for internal channel
[165599.123833] tmp464: probe of 16-0049 failed with error -22

> +
> +        channel@1 {
> +          reg = <0x1>;
> +          ti,n-factor = /bits/ 8 <0x0>;
> +          label = "somelabel";
> +        };
No particular issue when defining a property for channel that is not 
internal during driver probe.
> +
> +        channel@2 {
> +          reg = <0x2>;
> +          status = "disabled";
> +        };

Works as expected on target:

root@fct-0a:/sys/class/hwmon/hwmon2 >cat temp3_input
cat: temp3_input: No data available

Best regards,

Agathe.

