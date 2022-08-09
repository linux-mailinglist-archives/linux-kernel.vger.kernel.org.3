Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A658D1C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 03:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiHIBeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 21:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiHIBeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 21:34:15 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACAB12D20;
        Mon,  8 Aug 2022 18:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+5nMWCIP/sMvWh0gK66UdXiqbKTHFzRvieduehw2r0wmmS3yjZeig9pzZkik0BnK/BCFTdf7jvV4wDM2TME38vt7JWbfZnFNnSvXu2etQmbYPoVgtzhUCj34b1hCA6RRSc0IMmBmZ2lEKIteYVYqphXnebSwcThKvEOQWoBRmgtSlUD4DIIVh1ZyVH3WviAjJk5EKcwr5rVq4UlkubMZVQBLKY6Z5frwsz99ezQVnKkt6ylQOk08ae+1GS5AR1uzLZypslOIVmCBePRjC5FTcChlYjToQ5XKOP9Cb+SDS9Zmoel5XPXSfwlBGlQEv/RXj7SqEzA5xlM7wzeaPbTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4+7kKtwrLmNhiqn5Sb5uHjxa6fPdDrhm3oP6CNkJXQ=;
 b=Se2SufbC0LMs+AupKYKZaGZ5sOpgZayvI8rHfeTPU6JAYyxNWYtNPh/6eOxW/Q+tX0xTLldDInBbF7V7dpEm/56EamNbS2x66Mxv0iPqqghcATgZVl0lEkVxH1y29JwOUaTxB1Q05r8n//RhPX1TP7qQ55YE5BYL6ds69vl6iAS840NVTJxXgjCHt5cT01rpVFquByAVodIRxR/Ly4jwKZcizf/VZPBVh16EcmOiYttxy5vRlmi9/m/qgIL6OoWwrOItDrFFbQOAV2BSrVF4oBD3noxoJNG3UQUbVbHZO2zbQM3KirdFc93OlokpYt5qkguSbckkZigQRkzd4oESqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4+7kKtwrLmNhiqn5Sb5uHjxa6fPdDrhm3oP6CNkJXQ=;
 b=QuQIPAvur/z57snL77xigzG8zOkbQGSAfg2KuLakQpuTZctk2Mhdyq8vZ6F5h/nAHwQYPEEOKAMbMTz4q96s2eehrjZVqFj8fe/ruXBKaWMrOLJkpyr3OxzVJGOgNIj48C2gZYYIwAZ5axqY3xhaygxyR9RZmfwHqw++8MyfKfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6273.eurprd04.prod.outlook.com (2603:10a6:208:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 01:34:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 01:34:10 +0000
Message-ID: <5c8a815e-1f8c-3580-52c0-6a48edc7bc11@oss.nxp.com>
Date:   Tue, 9 Aug 2022 09:33:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V4 0/7] imx: blk-ctrl: Add interconnect for i.MX8MP
From:   Peng Fan <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abelvesa@kernel.org,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
Content-Language: en-US
In-Reply-To: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4b35141-87be-49b0-82c8-08da79a74236
X-MS-TrafficTypeDiagnostic: AM0PR04MB6273:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 07rP2HDJxGD8ZWxoIPnfAxp16d5HFZD3559ETes3Gsfuu3Y2koFjsoGolXRa60SKnW5hm1URg+x7nadsqHab8GCwbH42w50JAh2dgB5SfSIft291g0NWypXMoA4GjPkGGDZzXKKcr5TgYMTOutMoIumnYyjFSvcebbjpXmmtoH5WZeldga4xom8YSAVOyLef4zPSRU63N099Ze1L1yLKnYCHr+wUOPw0lvHpYRh4uYaMdNYp+0y3BukwQb5pXhrQ9s9/uwqBxSf5C3W5hs9b+E5cZXXlUPmnuIHCAMjygLCNb0QtAr5HGc+TgVls+X/UuzOcjnPI5o4tSMEzS87sIgPvTNW5xMhKjfomw4xxHrNdLULDsznpXmKISt5TX9A1n+TcBHxXqCjtbZwJZfFLcIl7Z6s0H4/+QFSNj+N33JgnLwoYAeS2VIS1e83nlqC3RbapJS6IGmXSPPEHEn3IMB2sM0s40pINTi3ty2O7wH517JKppW8XZhSEInkdxnxRis3EppJRBwOTiliDUorqllTMdiRbMaZdBncibYNQfOn3NBdJFP/ElJER/haVgWoRlDg50gd3uQgoaa4EwNDyQEBXPKwP42rqO4tefxdUYZgt4ybfSzoug2iWwTfVzFsJ1vxE+x/k0KHZ/MHkiAzYpfZtCCzXUnFQsZbfoLrwMLZtIf7/vIxMcW8J2ihsI6HhTJyuKMEK50QC+Qr8M3tXHH+zaBoIiV1J8DsBM46S4O7ugxeSq1Rp8M+hQ0IzFnRVSHuUUJPlzcInQOdiccU9ght2vtyMMaYuCwSS+NHFdo6oVC+dYlznNyP8axNg0FeZ1aiNOQDBqwa1fvoggfxZ92//ASlhsWaGDiJFgZtmoDO1xI+fyV9BoSexf1GhqrzH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(52116002)(53546011)(2906002)(26005)(316002)(186003)(6512007)(41300700001)(6506007)(6666004)(86362001)(31686004)(2616005)(31696002)(6486002)(7416002)(44832011)(8936002)(66946007)(66476007)(66556008)(478600001)(5660300002)(921005)(4326008)(8676002)(38350700002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDRIYTQxZkIvbng3L2lOeVl5L2tIeXQzUG16bFdTUGp6MFgvRWFuTXFiNUZO?=
 =?utf-8?B?cmdiZHZuNS9FRTFIdGdocFZlSHN0QnJkSUloeWtCdFVpYWIyMmFNTEJmQ0tY?=
 =?utf-8?B?ZCtiTjZuNnVRRGlWbDQveFh2RjI2WlJJTkcyNHJGSmlDNWNGaEpYRmdjbGpo?=
 =?utf-8?B?VDJqS21IWnB0TElwWjJGRUdYaHp2eU1RTkVGeDJka3ZaaXNyZ2JSakx3VHk2?=
 =?utf-8?B?aUFiZ28zWkRGTy8rN0FaS1NxQnIxRHY1RHltK3FOcnYvOFBlRm9Ed1VVZm9l?=
 =?utf-8?B?TEhuem5kcVFGYWREVDZlaUJFeGV1SkFKU2M3dkVaclhBS2tyYzczc05veTlD?=
 =?utf-8?B?ZGxQTkF6WVA4d0J5a2ZkVmdSSTR6bDFZc1J4cHJId2NRSytBM2NlNzR1YmU0?=
 =?utf-8?B?TWJlMGk1M1E5U3p6V1ZiWXJFMFVpbyszZDRTMGU1SnNKWC9MRXNrM1JuOTZI?=
 =?utf-8?B?cW1xQ3FGUHJ3YU1iM2dSVE5FOWo0OTZjRjl1VDVRd3B6S3Y2QnFFNjJyZ2tO?=
 =?utf-8?B?MlQwZmN0K2hqRjdqQTJUOGdHbitSNFRtSlI5WVREMTJwVGlyUFZNM2lLWVV2?=
 =?utf-8?B?SHUrSHBycG1hdEpQRkpMN1d4dE5DazFnL2xHNWs4QWFHUklmUklTakEzNk94?=
 =?utf-8?B?dTJQSHVFZnhmKzhTVlBDaXdqdUd1SUFnNXlZYWdtRFN2b2pCbE1BMENjODM2?=
 =?utf-8?B?SVlUdll5ODU2Qm5DOGZjOFMwNGthaW02S252SWl4VW9aUmZwTitnZEdPQ290?=
 =?utf-8?B?WGpEQlpJWUYyVlBSU0ljejROMUdNSGRUNVhLKzZGOG16YVhpdTdQYVgvak1C?=
 =?utf-8?B?NnhwcTJEcmZtNk9EMndXL2ZwVWNzT05BNUNnK0RCYU1ITEhHa2JwaExtWXZw?=
 =?utf-8?B?MEFxSjdSWDc1TTVqdVdZeWk5TEUwMzd4TWZVZ1NtSHZNdERxck1xbW9LYys5?=
 =?utf-8?B?dFJ1NjhIOGlZa3dRVzF4Nnc3YWh5a1Q3dEc2OXd3d05TRmNPUFFic1duWHli?=
 =?utf-8?B?SElSNXR0eTkxN2JaR2ZiVThWTlduVnNGYkdsTVFXV0piKzRzZ0JqVW8yTjNx?=
 =?utf-8?B?cFhGaER1b3pwVjNvLzB6OGlKNmJBaWUvdUkycnFLT2ZOU21UWE5tTXNRSjBY?=
 =?utf-8?B?QjBwaWJ1MHplQnNSRFdLejVDWFZDaWxLaVlsRURqbXV6NmdtcmtKdHI1bThn?=
 =?utf-8?B?U2JSZk5aajNLNDNZMG5rL2lldGJtcVl5TXQ5U3UzTjhYc3dYcUY0Z0dpN2RS?=
 =?utf-8?B?ZjI1MDVaRkZNOHFsenlMeG9FTlpoNTArRUZ2WjlyZCtDOC9KK0JJNHZMSnoz?=
 =?utf-8?B?eENlaVo1Smxib3BmQjlUZ1VzRVFxR0YrZjlNdWc2a2xvTEUybU0zUGhMTDNH?=
 =?utf-8?B?YmJyTDB4RlUxOTlyQVMxTHk5YXY2WWQwcUR1S1pzRWQ5NmloR2hXdkRJc2dw?=
 =?utf-8?B?TlBjMlI5WkxhMnhnVG15dE5MSEg0R1FEMTRlcjVKVHdDNkdpSE5IMkcwTHV6?=
 =?utf-8?B?dVFTZU9sdlRsbDAwMG02eDI2TWsxd3Y2OEpNWXJzZFlHcGFNejlFVlV6bE16?=
 =?utf-8?B?YjVjbEdPcFYySFNXSVZtTGRzQzFMYVgvaFNFM0orRmgybk40Nk9FSDRLZytI?=
 =?utf-8?B?Ty80V3VFN3dSejdNQytwOCt6TktDNzQySWVDeFpZWFNuUkg2QXFlcWNGTWRO?=
 =?utf-8?B?QmpiMS8wK1Q0bTMwMENKWitVczJIVDU2WXgyRGtnbU4yY25PYmpjRFJSWmF4?=
 =?utf-8?B?ejlmRGhXMjFmMXI0WGFhV3JkNG1vMU50YndTVCsvTm0yU2JrYWdxcmF0WXVT?=
 =?utf-8?B?SzFIZlp1NFJzVy94WkpBTmNUV1FPdzUza0wvdGlDL2hoTktlaVN6K09YZUow?=
 =?utf-8?B?VC9FRlVETVVHSXozUWxveXRaT2lBUHkxTElyTWEvbkNPcVBRZHJYOUVGWWFC?=
 =?utf-8?B?YU9mSFZrYWlMYmZST3htMUdlbHRzcjAwN3ZVa1Z0VzA5cTZEN0RxY1VmbTBE?=
 =?utf-8?B?M0Q2SEczM2ZwUWN4blZNcWNnamFDY1ZqdWtJNWwrWDdoNE1HQjVQQUorWm5M?=
 =?utf-8?B?czB5QUkrM0VpbmNkT2tkVHVHZUFyQmhkUzcyOWhGS0x4V1BRNVIwTnVCNUdY?=
 =?utf-8?Q?1RMwD8CK62O4kKueLJHa4PQaS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b35141-87be-49b0-82c8-08da79a74236
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 01:34:10.7307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D94314QrCEMWXZIn/2yNWTohM+oZ3b2nzANmCZ6gcXYzn9ai0bjBT6Gm98ZpXPQmZa/H5WZc37rHSI9Es2LhzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6273
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Ping..

Thanks,
Peng.

On 7/8/2022 4:56 PM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V4:
>   Because the header is not included when adding NoC node, the fsl,imx8mp.h
>   needs be included in this patchset. So include it in patch 6
> 
> V3:
>   Move adding NoC node patch to i.MX8MP ICC driver patchset
>   Per Lucas's comments, warn once when icc bulk get not return probe defer and continue.
> 
> V2:
>   Use a low bandwidth value instead INT_MAX
>   Minor fix to move fsl,imx8mp.h out to dts patch, not driver patch
>   Add A-b tag from DT maintainer
> 
> i.MX8MP NoC settings is invalid after related power domain up. So
> need to set valid values after power domain up.
> 
> This patchset is to bind interconnect for each entry in blk ctrl.
> 
> This patchset is not include DVFS DDRC feature.
> 
> Peng Fan (7):
>    dt-bindings: soc: imx: add interconnect property for i.MX8MP media blk
>      ctrl
>    dt-bindings: soc: imx: add interconnect property for i.MX8MP hdmi blk
>      ctrl
>    dt-bindings: soc: imx: add interconnect property for i.MX8MP hsio blk
>      ctrl
>    soc: imx: add icc paths for i.MX8MP media blk ctrl
>    soc: imx: add icc paths for i.MX8MP hsio/hdmi blk ctrl
>    arm64: dts: imx8mp: add interconnects for media blk ctrl
>    arm64: dts: imx8mp: add interconnect for hsio blk ctrl
> 
>   .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |  9 +++++
>   .../soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml     | 10 +++++
>   .../soc/imx/fsl,imx8mp-media-blk-ctrl.yaml    | 14 +++++++
>   arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 18 +++++++++
>   drivers/soc/imx/imx8m-blk-ctrl.c              | 39 +++++++++++++++++++
>   drivers/soc/imx/imx8mp-blk-ctrl.c             | 35 +++++++++++++++++
>   6 files changed, 125 insertions(+)
> 
