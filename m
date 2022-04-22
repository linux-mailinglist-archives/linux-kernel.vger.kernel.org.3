Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AC050BA2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448702AbiDVOgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiDVOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:36:21 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20051.outbound.protection.outlook.com [40.107.2.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8035B3DA;
        Fri, 22 Apr 2022 07:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5adLJoVNZMXEyfFMt1xVLrXb+w7gpajDvzna9SVXMKcXeVXksgA6RWy6D4cuXl6w8tfy41ECf3srFtCcB5QwJHj+nTJzEhmK0cJ55GLpVBecPR3EZXqLeaq+1tZXODIgMHgfWev/lLx2MeBL/tMvp3GcdHHEDhxOMVVI+l8Utdk/z97fmIKGft/rFk32dcC5NHqrMy36DI3n4qI7OmMkpdQ815EOB/5Y/UODiPfVYKcIGnlhF0f/1MeMRiCpjzxXsS7Sv4ZGJw3s75O+F7uZZMfC8tR9PG+N3OFSD+tTHmROIih0OYCm45O9Vb1JqPw9FBT03JSpsvKrymQaTu/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQsauyW3gAEXQtwWBQeJ4/L08VLywotpbkW+9DNS9bI=;
 b=fiwbZR7nY+RBWnJjrGrzqjiaA769YhSv+nko1TTDiDAHpE99NP1GDe1O8Zq2s7yw4x4+eLM5c2lmagjaxlfXn6tgNrcQcWwT7Dhu5+7ESdSENm2JyRouWWKb2LAI5E/ZNWZ2pFaUo1bN069PLuMPViK3iRciahH0qsqsBXKogPciqeO+pXrbG60pQfIHDveHo3qFQHMF72ST1GpyZrG7kOLop66kWorT1MBvuTEfIBnaMeIEQVyLaq1GOsYOMTbo72SnFFvcFjXaZcBbNp5RdBNQKFkUvFCHXZ49Qy5kMlBVSlZj8JPjgD6mrWjhS+S4v6iBPILS/uvalO3jEsHh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQsauyW3gAEXQtwWBQeJ4/L08VLywotpbkW+9DNS9bI=;
 b=N1uBrDKBPLY7JdWg/3FznoMh/xgW5wJEElXwoQ1HlGXyrbR2fXftPHN6WVeoBmb23AnHYqxNmQBthby6rSwv5OKlmrsdIgWzK5vrHg7mE+MY7d3k4JVBi4z8/vX18/PfgLJmJz36L+TBeizIoL71TVNcSzwKE1LB8/9wBUzDo4iNRupRZKI52YCM3qqzJIHrkmpZ8ozIaOB3wrC0s2TXZLMbSI7wAi889piSYWFM970FNtDJvtRu56pUIZVqFyZfumkU4luG91dlAvjxoHTCCpTG5h/z3v/i1ZT9EcesZtvgFt3IISjyfK1CrDRZzS0S+W10lMUyUnstdVuKosojMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by VE1PR03MB5439.eurprd03.prod.outlook.com (2603:10a6:802:b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:33:23 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 14:33:23 +0000
Subject: Re: [PATCH 2/8] dt-bindings: nvmem: sfp: Add clock properties
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
References: <20220421175657.1259024-1-sean.anderson@seco.com>
 <20220421175657.1259024-3-sean.anderson@seco.com>
 <1650634580.180348.1895585.nullmailer@robh.at.kernel.org>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <841ce88d-bb45-9868-a205-f6c96fb2cf89@seco.com>
Date:   Fri, 22 Apr 2022 10:33:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1650634580.180348.1895585.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0089.namprd02.prod.outlook.com
 (2603:10b6:208:51::30) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4463ba09-e964-48f9-fb5d-08da246d0e2c
X-MS-TrafficTypeDiagnostic: VE1PR03MB5439:EE_
X-Microsoft-Antispam-PRVS: <VE1PR03MB54392C8BF40835BF34AADB9896F79@VE1PR03MB5439.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4eIHDCthCApBRDXgBV0AA+fV8tY9Q2OW7eTSYOImdfItbOc5Wmnf0WHL8+5GLNP+EDaJjXL8DTRzP1oKgztTs/LTIhLi2+GJdxbJzZhtRMQdBfVDfGiI0qXl/8VGIgQR6oWpHoUPZFelW+sCZTl/xyXyaDhBkWHdhqI3aw7sji1A29+xaZN6H7VwsjnBVTLsnpShZLH2v3phIkoyc4buy12S/xp7T0I7FfyIW9Y3LJjhRTxwXW5s/0lfamlpKRmDwGvwFV7LN1rQSJZntC+tWqCrUUJcrL7un8wVN/rvOc1jChGGT4m/6JgTHjlZzva6Z3fb3PlLhjAAVp8VpIRWaZoXAcE4wkU+t4dd/+wOjrGc7HMHFFmLJcMZHavjSAOurjVf7BL7Z3RCZwgTMF9PHZcxk5uEiRLA2A+MfebqY19LUUWdZsDfZXkyuDG3pPczEgBweB1uqW08TCFxq1m8UmrX1YQV9hrvLvvK9vVVBeDPeb+v8JsDF4faMwmyzH9RwQdrzqg9NlExrdi5NBe5/i9PxP3l5dLFxYPI/p9aQgGmXRgEiZxFebIN6WuBlU83YtoH0UtHc9Fo6NXb1BZaGhJljv1IeZlGRRW5H9/PX6owxXPGTH3AOWo1paLtybjFcjKYGN0u+XfmdoUwMl/sSREklpmsIhp9f33hKcEcamXsVo2pdF2BLVyly79T7xrdbHEVSpOu3ctmZiVpZ+BKIRGC/OVOoo3qWcFP6fkYDkzD2QRnuYlzvyJ8GzH+1KbQ5E0F/G5OS+YmJjXcv+KdMRXPaSKTOz0/n5sb7YhjKFzp2/28SLvbTkQYwvZP/7M1isPkkQL5VDqqMRojN2CG7XeMFou2DyJkVNQOIsdez54=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(7416002)(966005)(8936002)(6512007)(53546011)(38350700002)(26005)(38100700002)(52116002)(5660300002)(6666004)(2906002)(83380400001)(44832011)(508600001)(86362001)(6506007)(2616005)(186003)(31696002)(31686004)(316002)(66476007)(6916009)(66946007)(36756003)(54906003)(8676002)(66556008)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1VGWkJtV3NseHQzYU0vc0ZseXRjNVBueklQcmx6dGhUV2dldGpENS9vckkw?=
 =?utf-8?B?cEwyaWRlZUE0aXloWDJRMlg1Zmx2QTBESVE1Tm1XTUdaUzU4SHVmTU1nVVI0?=
 =?utf-8?B?Mmw3UWV4eWh0Z0RNQlZ0emc0VnEwUmRJMHg1eWsrMk1yMUFCOHpLUlBpRDBE?=
 =?utf-8?B?c3UzQ3d6VXExUDF6ajB4eEIxQ2wrcVU0Uis2VXY5WVYwM29mSUF6WTIvMEM5?=
 =?utf-8?B?VFNDN2wvVEtpSEU3L1BpcDdEV1k0TzZXNldrcHEzV3FKMmtKTGtRalI0cTBL?=
 =?utf-8?B?cVU4RXlZUWdtWmVibElpTHF4ZWkvTlhOdXNUcWErTHRIWFdpSHRLOUFrUUNF?=
 =?utf-8?B?NDJqSkpyK1lTWmMxVHhNMzByV1pTV3NBYkwwUUxLTG1OZWRrcEM2VmdTempE?=
 =?utf-8?B?OFFTTTRmY2dnUEFWMzd5ZGZ2RDYyTFc4VTM2Y3A2QnFlWUhycmpHYWJHMWIy?=
 =?utf-8?B?TUUyMlpaYmJqVUZmbVRpSmVwdkZlY29yT05lbi9oRUhxaVRGdi9rQkx4dDBj?=
 =?utf-8?B?MlFDSWRITmcybk4vODNSQnQ1K0w1MlZ2aGUrOGxqcFo2YzQzYUNUbEwvUWNK?=
 =?utf-8?B?WUxFYTAyc29ZdDh6ditUSVlmM2dsK3dpVjVZSHVkWS9ScCs2ZzZxczFhT2Ew?=
 =?utf-8?B?V2RqMTlxQlRqNFZaTHJSWWhMeU1aS1JOTllBWXA2OERhNi80L05BZkl6dWZt?=
 =?utf-8?B?Myt3Z1duc2llWUpLN1lKeTVFQkNYWGw2aG14V25mZlBhZi81VzdPUkZab0JB?=
 =?utf-8?B?UkI1Z3FRTG1GS1UvSk5IRTJyS1lyWFdLcGJWYkFTVVY5eFNpSFN0bHEwWU1S?=
 =?utf-8?B?TGZvaFdmdFEyTExZUHI4Qktrb04vWDhtT2VoaVd4V0c1M29BY2JVVUU1ZjBR?=
 =?utf-8?B?TFNweUhwMU9QS0liNDU0dzlCWnR5b2dVc1o5UmJtMzVyNmEzeVo2YXBmZmtv?=
 =?utf-8?B?aWhKOUJ5ZmhEeis2SDRKQzhaQklXdXVueDhUUlZnMzAwNmFiZFFEaG8xMUVE?=
 =?utf-8?B?N3JCbUlDY21QNVJVcEVGUGhvYzFmSTBoSkpQbS90ZHZqY3phM1J3OHBJMlp3?=
 =?utf-8?B?NmRDMkcvS2MrcTFQckdvak9rN1NDNytYS0p1MkEyN1dabnFBWDNqU1RucU9O?=
 =?utf-8?B?ejg1SU1RaEl3MGlkTkZlZ29nVWh3ZnhMVGgvMmNxdnhIWGh1bmlpSldab2ZO?=
 =?utf-8?B?RTJvRFNpMXBQYU81VDZEcGpLckhKVFJ2d3FGaENSNkxCUGRjQUpxQ2RvcFNq?=
 =?utf-8?B?STNoTW9FRG1KMm9ZandldUZ3S21IMTZDcksyQkM0ZHJWWkVmMlZwSWpLMmhR?=
 =?utf-8?B?UkRhTkQ3NGxqYTBPbHkzYUZSRlpuNk03NjZiYlNFMW9TQTdCQkZkM3dRRFMx?=
 =?utf-8?B?dnBKdlA1US81ZE1odTZVYk9JZU80WTdCa2tEbGR4YlJQV2NEM3ZNaENEa05l?=
 =?utf-8?B?SGk5ZWxMSksvQXY0cVZRdG5xK2l0cUFXWVU3eE16WDNqNEtiR3J0SXFxQWtr?=
 =?utf-8?B?U3dhTUlXU0FWQ2Y4SDdXNHJ4UnVaV1pDcHVPM0IxaFc0R29DY05zWGhYQWR2?=
 =?utf-8?B?WDZBOU9yeW1xL2Y3cWdYSHRUUllBcXNWL29JZ0JEMm5ZTHE4SERCeHFsc0Uv?=
 =?utf-8?B?VkVtNElxTUtBamQwSkFlWlFhcEF5bmp3QVAvTHlVZ1podDRlQTZ3RzlwcG5l?=
 =?utf-8?B?aGJqYzJLUE1wVGp3djR1UnZHaFpDQVhaNnhWWG1RVkFrV0RxdFpCamdiQzh2?=
 =?utf-8?B?TFhwQm5BZGp6VzB0UUYrQWp2L1pNQWE5eWNzcGEwYVA0eGpXL1FEcXcvdG1M?=
 =?utf-8?B?bnVvV1FwUS9xcE5tMTJzcmx1ZVhQSkgxREJaM2NZeFZnNGpvUnZwU3VqUGhy?=
 =?utf-8?B?QUNsTENhLzZVWURIcGhsNTFVbzh6VU9aaWl5RFhheFpPRjV1amF1VGkxY0RJ?=
 =?utf-8?B?cnlZWmgwQmFwNHp4dnhFSERlUklQU2paVS9kK0RPSm80cGtSNzhHb25YZWdC?=
 =?utf-8?B?VVIyWHgrcGExckwzU0cxOG5yYzU1Qk1wWlRMODJPTXo1MlZURzZRVTNYSzkx?=
 =?utf-8?B?MVdkSXF2MFY2OGY4NGcyOFBZeVdxZVFLb2dhbWViT3NCUXRkQjV2Vk5DN0Ji?=
 =?utf-8?B?MGJFWlExcGpFRlBpQUJoYlA1YmJybVNjbGdPOXRML0R0TlcwN2dhWUZOZ0ZC?=
 =?utf-8?B?eUtpYmV0VVdXeDhla2VQWThxR0tKRHBGK2piMGZWUU9HR2Fac2haUEtUY2pN?=
 =?utf-8?B?TTZjQ1FhTTNPNnhJUDR5WTBGaElkak85WndxSjYySzFtZVlKbFNRRUN5OXgw?=
 =?utf-8?B?eWFKb3YxZitOL1AzVWpQTG5rNlpGRkZYYkltNVBmRDZkVk4zd01ZOUY4QXcy?=
 =?utf-8?Q?FYPxeoXPm8S4Txy0=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4463ba09-e964-48f9-fb5d-08da246d0e2c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:33:23.5616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEmyaRb4LlQgz0wRoil8gtS2yyHBn8oMNqFFdngwFbFLara4Y7a7Z6X39KAmsC1i5puWTILsidV9BMvUNGW0IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5439
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/22 9:36 AM, Rob Herring wrote:
> On Thu, 21 Apr 2022 13:56:51 -0400, Sean Anderson wrote:
>> To program fuses, it is necessary to set the fuse programming time. This
>> is determined based on the value of the platform clock. Add a clock
>> property.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>> 
>>  .../bindings/nvmem/fsl,layerscape-sfp.yaml         | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>> 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> efuse@1e80000: 'clock-names' is a required property
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb
> 
> efuse@1e80000: 'clocks' is a required property
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dtb
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dtb
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dtb
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb
> 

This is fixed in 4/8, but I have ordered dt bindings changes first as
required by Documentation/devicetree/bindings/submitting-patches.html

--Sean
