Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D89493144
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 00:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350237AbiARXP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 18:15:27 -0500
Received: from mail-am6eur05on2060.outbound.protection.outlook.com ([40.107.22.60]:23137
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350210AbiARXPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 18:15:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmWReaJJcT+/C61uSZjf8Q58aR0R7AMioNCDcNjkJjI1mQ2eqX4KGf0fmtLeJtCwUx0LhY8AofOWI6QW6MfL6iyfKA44ATBl1tO9r23nm576FziUg3yw2iYeoW7TGYSvM1Kv7Qg9MBpilsZRXk54djkP8G+TRtIMb7BWZ0AMrRIEw4m609tKQvJRNeyqri8SwBPSAaFKlyiuqg1gdx4FSVQKjFgcDheBCRpRW8qDDX4rWfagni5P3CE8Dk5dOFF8nk+cKn6cDIxRH3oK0YlBy5e2cOwtvUpYgQtPHCFVzqgz/lMxVQtkgBptHFmz4Qv5IUf9PAGySKRhOS9GuKLWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQQpQtM2B2mCmPpZjvJhpcjnEwSZFUErOslKcdU4l1w=;
 b=c1Rd11EoTb1j3xDdmsKKuD1QWcp+Zwx/rrxhmMY9oSZsF+4F/s7rfEkIyjn/nvX+0FXtdGZnm7tWpFF1nsUYUQsFISbbm09HhqYAQwmJn+fHQ/pMnpyYBNSqh4GCdU+71m21m5kmCrxRLMdW3wrkmz6MoD65C6JS1bp1MkPXnslRlPcFxdQswctI/9r2BtpCd/DU0DOov9ygJG3bjmb4UiEKmkJe2EmlxruunJt85NGZAG0F6NCTEtpmnJoPxs/1kFt1K5wvs5Bs8sj7B2QdjBycDT5vQ5JkIl0bqN9AJTMWyRqqVxOgMa2u6hkNebxbgkG2gwh2wa1Irhp/RpIKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQQpQtM2B2mCmPpZjvJhpcjnEwSZFUErOslKcdU4l1w=;
 b=K4BRHLLpvNuhtUVi047BXn0g8YrkMAV3je8Z1+uC0F1DQDahf6nfmxX9xci39dhEcMwW8Rfy57G6CQE3GSyuAbH6bnOuQWhq5Tcx7x44CmyRbJa//CrkPN6RoHM2CHNvxQ3heeMal+GOt+J3NSuNFZamCy4ckD3fkRgBDOMBao5KcgGIueqQGVB69Xu/Q/pP1s2vWyHI1eLe365TicvhOXoUFGnJ+j656hBmfzaXf+Ud2/Q8dm5NJJqOjTAD/G4IODQF7glorIv3zVj4JgXohsw8WXotcsIkgBbTZ+gUjQxG7ckq8VhyHU8vfIwnw/SXm1Flx3KNY0PKFmzgIJ1/NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM0PR03MB3682.eurprd03.prod.outlook.com (2603:10a6:208:4d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 23:15:21 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 23:15:21 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from reference
 clock
To:     Robert Hancock <robert.hancock@calian.com>,
        "lijun.kernel@gmail.com" <lijun.kernel@gmail.com>,
        "jun.li@nxp.com" <jun.li@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "bjagadee@codeaurora.org" <bjagadee@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "agross@kernel.org" <agross@kernel.org>
References: <20220114233904.907918-1-sean.anderson@seco.com>
 <CAKgpwJUMXk--4EaYOxAAtLJT85mDHRHMihr6n7y1HECN+gmBBw@mail.gmail.com>
 <79d6057a70dae09bcc30a35f608f51c5a768d097.camel@calian.com>
Message-ID: <4dd8aced-174c-03b9-87f3-70026c963f6e@seco.com>
Date:   Tue, 18 Jan 2022 18:15:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <79d6057a70dae09bcc30a35f608f51c5a768d097.camel@calian.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:32b::21) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8657d560-659b-4c02-fefe-08d9dad86618
X-MS-TrafficTypeDiagnostic: AM0PR03MB3682:EE_
X-Microsoft-Antispam-PRVS: <AM0PR03MB36827DE7EFCC56FA196C58C796589@AM0PR03MB3682.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kpdj2Qs6ZJW16MqSCU6uZGzz0cpYMYjMNWjjpZZie2/6TtSO+zQxM5uz5lWIrUufwSQMiVTqzVQO2nTEw8QDaOwyV2pKv8FlMSHZxSKk+FP1TRzw+Qyk+E9W/a0CETcCoTwiAwni6wYR3uRN9o2Bc6FE2PdijttKzrprKm2d1bbA1OyjRXGnVenDw1DVcSVte04y5CJ1wwIhV8+Uv2T00v/lRzb2y2NnjAgphC1v5BxDWefnVAI9Vt0d0ucLzSYKrq+DsmZxuUerAdlNiNj8j7ftnoDDyXjLvR3PzQlSGpdjPpg8N5sYzyYFHO6QmN5BSHJ7WKDrsmsOAUv88A0rMR3nC+YI1/t25SYASzUjKwwpIZqREmflLWHQDFOldvgv9o/4lEnffzrPDXkqeAzWBXxsPgJ7oi2cgSLBVPrGyLuMKk1qNGIEq55JpdHeLBJvnHFguva4M/dUgCxlucM+Cp9YK61SrmwEr/DPHPI1Nknv4hWHWwQB+za1q7JtcouUyFNW6B0cisynojjBg8aJyYEhAd2aG2LvyYQn2N2mcU3uO1ddftKDrmFF/PJt2BI0s4nKX1csxu6+ETlQYjOE5nyHoCZ9jhuRs0fVnJtnNWiO4NLBDbck35JKmirFcb9r4liFKa6SgTtOqBDsrzjNlXAr/yaVyDXFbV7+sy9oauy1B+qbSiXhw40ANb7gVRx49YqhpCn9LBL4SFKlZujuta5KqAFG8vXzB0LiJf0E0BtLsh3+BMwjUyuoaHcjMl8bsoXIRx+2TtcWAwe8FS4+5DkZoXn3aV52mysgDc770BEb3n7WGtaWLlGBSBzQEjbtGXDknTCVR1MWWyOm3MFtHBK/O0ivJ5pANdjI7NNet/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(966005)(5660300002)(66946007)(8676002)(66556008)(36756003)(31696002)(508600001)(86362001)(6486002)(8936002)(186003)(52116002)(53546011)(2616005)(7416002)(6666004)(316002)(44832011)(2906002)(6512007)(4326008)(31686004)(83380400001)(110136005)(38350700002)(38100700002)(6506007)(26005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjN2L3ZRaXlNODZZbUFOREZHb0JFVGtyTUJnNnhaVWx6Qlc4WEVOT2QzTW51?=
 =?utf-8?B?NnR3SUg3elFLZU4veXd2N0pxQS9lY1JoME54R2Y4eDA0RkVNWDZWemxTZmZ5?=
 =?utf-8?B?dTcxNkJNd0ZsRm90eFBWZ0FqdHJwUTdwcHlZd1dXZ1dtSkFlQUZxMHQ1V2hI?=
 =?utf-8?B?YUhKQ3hZSzVMc3FCODF6a0wrWEdwWjhxT2VCVitaRkw0WHQ2ZUFuWDhxU0VH?=
 =?utf-8?B?OFZmalFXMk1TeUNlYm1nOVpzVEM1M2lEVnk0b2ROS3NONjgzRHlFc1FocDZD?=
 =?utf-8?B?cWlIakNCTE96cUpkQzFhY3MvbWpaMEtKUWJLa085NGZVNHBrWmZsTnNteVRB?=
 =?utf-8?B?aUFRSUsvNUVjQUQ3YVFZYnVhMURsK1VKMkZyeVdoQzR4TlI1TEl4MGhTWE1M?=
 =?utf-8?B?OGJROVVRQ1k3Sk0ydk1hbVNjMk5Ra04yeGhxcjhwMllGZ01VSnV6YlVBYVNU?=
 =?utf-8?B?cXZuUFZ0MXBieU0yYVo1MWpTUVhZZDFxY1IwZlV2YTEyc1lMNHk5UVhtS2tP?=
 =?utf-8?B?U2VhV1RkZFdaUDlUSm5yL1MzYThZYUl2ZkUzRGV1Skg1UzJUMXhTVzMxMHo1?=
 =?utf-8?B?Rk5acGR2QnZnOUNreGRXTWM5TGFRQ1F6b0dPQWQ4TzMxT1hKeXFJdEVEeWY4?=
 =?utf-8?B?R0Q5WWNjM3JTdGdsWHRTTkF1NUZiZGVGZWFyRjM4bjkvOXRZWjBLdGVqU2ky?=
 =?utf-8?B?WHZ5Yll6ZVFscGwxOW9XUlFHWjBGaGxOOHRuZmE0bkpoNndKOVpjRGhXQTZY?=
 =?utf-8?B?MWxKTW05UUExZ3RRYTI5VUVEQndoNG9WelJHVXE4VTdzMEVDVTFwSmIwbG5T?=
 =?utf-8?B?bHdmRXdWL29jakVteFAya0srMmJ1Y3JvMUQ4YklPTVNlamZhZXllemdST1hX?=
 =?utf-8?B?aUhPejBLZGphSWlzUUc5SW1WSnJ6eS8zN2hSOXgyaHpEQVpuYW1vNENTNFc4?=
 =?utf-8?B?MnFhejJTVmtmbTNOK1JDUGtLazJYdkVIaG5tZUU5MCtGM2ZKQlljOC9XZGt2?=
 =?utf-8?B?ZGFHMmNxRGFrRzRQL3ZSSGhWL3VuTTQvbUlsT0Ztc1pFSkZFQ0JtWnlRb1Y5?=
 =?utf-8?B?cjEvOUlFMW41OCthUzBYbC9PYngwMHB0NFBkeUl0NXcyQ0NDazFheTFKUG5x?=
 =?utf-8?B?TkJncCsyc3d1bE9QcHlIZ2trOVdRbUVvYWYrOEROdXFEUGJWcHJKd1FKQzBL?=
 =?utf-8?B?UEtGMmpaZGlUNXh4NFZTOG1sWG0zZjVYY2RMbDNTNS9meVFPYjliSUZjNjMv?=
 =?utf-8?B?cStwbkdiRGVBdEYvWmkyQUZ1dlJtZU9lTGlEclhvblAySDB2WlNQMEhld09B?=
 =?utf-8?B?Q0xUOW0zeEhEZEZFcEVKOVV6Qmt2ZnJLYjN1WU1rWUtibnUvRGg2d3NKSHdq?=
 =?utf-8?B?Ri9Td2NYeS9ESUlKdmZkbDdLcVFXelorT2JmVzNBMHBRYkM3aWJYMEJyREFP?=
 =?utf-8?B?RE1Lekt5ZW5kb2g5WUVlemRaV0UrcHh5WGVMQkNoajU4MHR2eUhmaEhkMngw?=
 =?utf-8?B?RjRPUGpnTHRVcDN2YUo0UWVSaHB4OEJOeUU0YzRxYjBPdFdIdmpXYUo1Qy9H?=
 =?utf-8?B?dTJhWUNCSjV6bU9QaDB4MnE5NHRSaVg3dWJnemlqNHAzQzhmYmVJYTRRVHVC?=
 =?utf-8?B?S3dUdTg1MVBGQXVJUy9IK2JwUzZXRnB4WTNXNjhTRkwvUHN2blRNMldjMFMx?=
 =?utf-8?B?SStBenFUNHNPVVQrTk1Wb1pIZys3c3NFVHdRUWFRaUlSdktlZk9xQ3ExNmox?=
 =?utf-8?B?UjJYMGJlWk5BNVhKcEFYQzRqR041cTk1UkRHT3RFU2JuaUo3eGZkWHJLUXhq?=
 =?utf-8?B?VGwvOGxaVW9rR05mbHdVTkc4MVN4NHJrRUtKRmU1VEEydzIvVVduYnhoNmlF?=
 =?utf-8?B?YVM0Mld0SXpGdTYyL0FXbUY3ajdHWW5xcmZ1aVJRcS9ndHpQQVZWWVpYQk9i?=
 =?utf-8?B?SmluNWR2K0R4bjVnUmNZZDY2VWJYUU5XSHhSYkFKeHdHUnhVSnRZZ3VQQ2hT?=
 =?utf-8?B?ZFYzdTNiRjA4cEt3VzVmcDRtZjBsZkRxVnViZ3JDdWl2RGUrcmVzc0IzbjF2?=
 =?utf-8?B?QXlDdDhxVW9UZ2RtWjlKNlVpeUV4cGg2bXdETDNxcmRHQWlPMWNPaTI3dWQx?=
 =?utf-8?B?cWlCNjZwaHFhMFVoS2VGak83Vm5rVHpaQ1V4dmpzS2xTdlJjbVQ3bldaa3ZJ?=
 =?utf-8?Q?+Bkq34iEudodjGHdoQL/DJk=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8657d560-659b-4c02-fefe-08d9dad86618
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 23:15:21.2528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOPqW3xxdk8D8W+z4IoRBjl0l5YrP/yAiFAUgFrLc/ojBDpWp7jlgirmiFSKW9Y7UNHm2bi6mep/fK6hr0WKTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3682
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/22 6:49 PM, Robert Hancock wrote:
> On Mon, 2022-01-17 at 20:30 +0800, Jun Li wrote:
>> Sean Anderson <sean.anderson@seco.com> 于2022年1月15日周六 10:11写道：
>> > This is a rework of patches 3-5 of [1]. It attempts to correctly program
>> > REFCLKPER and REFCLK_FLADJ based on the reference clock frequency. Since
>> > we no longer need a special property duplicating this configuration,
>> > snps,ref-clock-period-ns is deprecated.
>> >
>> > Please test this! Patches 3/4 in this series have the effect of
>> > programming REFCLKPER and REFCLK_FLADJ on boards which already configure
>> > the "ref" clock. I have build tested, but not much else.
>>
>> DWC3 databook states a *condition* for program those settings:
>>
>> This field must be programmed to a non-zero value only if
>> GFLADJ_REFCLK_LPM_SEL is set to '1' or GCTL.SOFITPSYNC is set to '1'.
>> The value is derived as follows:
>> FLADJ_REF_CLK_FLADJ=((125000/ref_clk_period_integer)-(125000/ref_clk_period))
>> * ref_clk_period where
>> ■ the ref_clk_period_integer is the integer value of the ref_clk
>> period got by truncating the decimal (fractional) value that is
>> programmed in the GUCTL.REF_CLK_PERIOD field.
>> ■ the ref_clk_period is the ref_clk period including the fractional value.
>>
>> So you may need a condition check, with that, only required users
>> are effected even with "ref" clock specified.
>>
>
> The Xilinx register documentation for this register in the DWC3 core (
> https://www.xilinx.com/html_docs/registers/ug1087/usb3_xhci___gfladj.html ) has
> the same description, but it is rather confusingly worded. I suspect what they
> really mean is that "this field only needs to be programmed if
> GFLADJ_REFCLK_LPM_SEL is set to '1' or GCTL.SOFITPSYNC is set to '1'", not
> "this field should only be programmed if GFLADJ_REFCLK_LPM_SEL is set to '1' or
> GCTL.SOFITPSYNC is set to '1'". I'm not sure if someone can confirm that
> interpretation is correct?

This is the interpretation I was using as well, since GUCTL.REFCLKPER
has similar documentation and it was always programmed before this
series.

> However, looking at that description a bit further, it looks like there are
> some other fields in that register which are dependent on the reference clock:
> GFLADJ_REFCLK_240MHZ_DECR (bits 30:24) and GFLADJ_REFCLK_240MHZDECR_PLS1 (bit
> 31). It looks like the Xilinx board I am using has those set properly, i.e. to
> 12 and 0 respectively (I'm guessing by hardware default, since I don't see
> anything in the FSBL psu_init code setting those), but it wouldn't hurt to
> ensure those fields are also set correctly.

I'll add those in v2.

--Sean
