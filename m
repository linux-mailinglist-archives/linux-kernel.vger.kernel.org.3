Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAF5493FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356717AbiASSYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:24:11 -0500
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:18001
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1356730AbiASSXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:23:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRBPQ/x1SrHqlEdnR92Gtp3n69ba27H5XMJ7QclnAFom+BB+I7dvrgQSBkXmlDOW2GoaDRF8L7CHmXFigjMh87rSEOsjDMBSgMqfsXpWIx05R2GQBOcKZZmKy6mKpwtFk5cwyXSBAhOEUlxEs7qXWZ/dyLahcq+UPrDSN72OcJGJRswxLO+9HhSxgbvrsFME3hj0wAKy4MwAiOzwpzuWGGFRl/33Vuiem6EVW4N/jlXJGy5Otzm+zyWajY1CYnYBmjFiy93hgGRLzvwBcf7DyjFbDPQb2m4nnj6SUYRVpO+TKWRERBBXhRaBceAyPyI2xzKIK8bjo2MDYoDR6+aODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/hun9LVdJzICSFp3276k5Rhh9JSw2yfKJ9j+h2KzFg=;
 b=HCLihSsaRKzixDJktDWoICQUG9OlIWdDojXHEZbbP0WVLnad12nETuOT6bv2UcNQupjM1dWFAQLeQCD0IKDyMHlDLCNWFlCWqUF/IC+y2+Gg4DDSeRGtcoKApNEjyGGzJcHUfmX94xF8iT80+PgkGL5X7WsbKkewwCxmCKXavCWiUCOg+EWQuGh4g8d41oo9H4VNbXzmruV23X/XwODEaHjsWf3vT0cIL+YWrMcGUYiRPadhpYti06Vf4LTldaeLK/oZC1FHAWAcWiyDfKbGTKp/CoJ/ZebScfXGEr08mwe1taQcNoa4KRaeWz5EO5busk/t0WiSDONL2ZSirmtvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/hun9LVdJzICSFp3276k5Rhh9JSw2yfKJ9j+h2KzFg=;
 b=sTDn+O3raFEvB/e243v5ZaYSOKZZRoe2ts/kEdcZoMYXKt8SbSVgdknmmb0TDOWGRUw/JxhjJS8bpdr8yPqdplvbJyebeUh6693obs3oCPs6tX+glsv3/S6AnYx+XMKx7PYy8T1FSyEbcbt6W2aHmssLRhQAvRvKqJuf6UMrjOMziogjxCyGSlJTJDHs8MOFggZ6lv7+Na5kbPH+AqlI4ZZd8wN3vBZw31mLKAzsdrfG61MH1RAjmr1Y8Qg55+Jlb+WpRs7prgKgXN0c2QVvP1hFkpXq6uHgFoWFIZMVT7CeGbRuPkz7iIl4zc6kNA/XQrkVykwXL2z5O/YEeKs0LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from AM0PR03MB4514.eurprd03.prod.outlook.com (2603:10a6:208:d0::10)
 by AS8PR03MB7537.eurprd03.prod.outlook.com (2603:10a6:20b:344::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 18:23:50 +0000
Received: from AM0PR03MB4514.eurprd03.prod.outlook.com
 ([fe80::58c1:9483:524d:6b]) by AM0PR03MB4514.eurprd03.prod.outlook.com
 ([fe80::58c1:9483:524d:6b%4]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 18:23:50 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 0/7] usb: dwc3: Calculate REFCLKPER et. al. from
 reference clock
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20220119002438.106079-1-sean.anderson@seco.com>
 <87ee53fv01.fsf@tarshish>
Message-ID: <a1932eba-564c-fe32-f220-53aa75250105@seco.com>
Date:   Wed, 19 Jan 2022 13:23:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <87ee53fv01.fsf@tarshish>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:207:3d::21) To AM0PR03MB4514.eurprd03.prod.outlook.com
 (2603:10a6:208:d0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 725e89cc-1017-4277-f266-08d9db78d711
X-MS-TrafficTypeDiagnostic: AS8PR03MB7537:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB7537E2DD512977CE40D864C896599@AS8PR03MB7537.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fitnWJd9PZCLjmWT032SygeoQ/z9xTxCh1gOYafG/nAJgAB4CHxJBWPuWrY3EkJXrQF1oxUqgMEsrtX/rfrMSmj+3dZe4iInOnII/p6XJNfVG+mgdoDEZ726qARBMhuCIzymX8iEdyDULSITrgV9kIHrCD5Hf7UHBrAcoOu/bGQerpERKaTSfyH75T31ZR9CvJnxChTFYprPQmxG5lBq1p7eO7n13aG0W/LRWVWY8EQ43JjhRcmK0FoTVmh7VtOGYXDjbQv5GdTKdEneAWfFqmPX3rD7U6CfI0G75ET9OIaaotrdDph/Cr1hAXnDurAI87Diwr7cLNYujCOkg89PSczAAUfwaVvGlwhB3kNbVZpE6Cy2e8FMVVPpgupUBBfvtU08QEWggc4zSJSkt6nu3KD7hEz5Y9jcDy5p8Hl38gKdf1jB+tPL8FlkYaVQyvziJTGLj+PVrbM4r5etpJtIdoaRPXABuC4DnwITesROWwZ6z1deLO1tMKBfDt5LL6ymY60SPZwl3G7UX6lCyqG6SdjZRcLZNCmtHrRS3XDGpFcuV6O7YRI8Ka0I/b5wd7LqV+wRpmQyarbpzigOlP4+KH3cl4eFhm3k/8WgRiYdKeJhGZXcKig9u/GHVz+gzGYszwKTiwlyFPDYO7PYmcsI4VhWYdS16xPRAIBTd5MZL6AGY1lrQHsQQYFaeYeC7UQrR8CGBy2Ki3bCReozMZf7JKE0kStdZ8rF1kN5MSEnYM2CRMzexAWq/lZArQ14arDlWEwSpkD+ubUOhluU2wX2kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR03MB4514.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(44832011)(38100700002)(38350700002)(8676002)(2906002)(7416002)(8936002)(2616005)(53546011)(6916009)(6506007)(86362001)(6486002)(54906003)(4744005)(31696002)(5660300002)(4326008)(316002)(31686004)(36756003)(26005)(83380400001)(66946007)(66476007)(66556008)(508600001)(6666004)(186003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1BQSzF0NENWY3ZPQ2VobjBGbWlhYlU4SEJ6ek9sWVNLcU1oUFMzRnBRU0tr?=
 =?utf-8?B?N01xNU9tbSt6ZlhXdjkzUE9IQ2lYaS94Vjg5NGNjcGx5c2ovNFBuM2hOdVlD?=
 =?utf-8?B?VHBueDFqSVlLSjMwVklrSUFqc2I2NERJWUdyQkJ3MVNDUnVyMG1wb1ZaZlRy?=
 =?utf-8?B?blRaVmlnVCtPQ1REbnV0Vk4xMEUrdXVCQStzZnNVamMySnNrUUdNWGtSaFVh?=
 =?utf-8?B?Y05FWXk5UHdSbnNXN2Rxc21zWHlmblp3dmRndGNDUXhaSU5Lb2lweUVMbDhq?=
 =?utf-8?B?ZUI3Z0ZtekdjNVJmZjYwWll1cDI0eGZ4S2RIbmFiNXZTNSttZ29vd2NsQ3FQ?=
 =?utf-8?B?Q1hCRVNxZDZZcFJnODlDVGZFT0ZtZnpUSWgwYlRsN3RlUG45NzZpSkxETHVi?=
 =?utf-8?B?SWh3VStlUXJYQ1pWL3VMY0t1eWtqVnlrNHA1S3AvVWczdFlUeXhUMXhYTnNl?=
 =?utf-8?B?ZHNGeGorY2JXaW1ValdhanBvRGpsQllhenpid3MzeVNYN2RJMU15bTlaeWp3?=
 =?utf-8?B?RGxSQXJOREFXVWlhZkxoVGg5amdsazNjcHlNakI3TUFmNzJjcWxwQnRZT092?=
 =?utf-8?B?Z0NVTGU1WjlLZHcxSHhybzNDUkt4S0xMZjlUQldZdjVEb3pLTlBhYk1lVFVx?=
 =?utf-8?B?UGpVR0xxaHN1UlFoOEtaRm9GT3ZjRndTa1pQaUVXRHdWKzAxYXFjNWMrODNq?=
 =?utf-8?B?MzFhN2habmFkNlQyZmhGOGtwdThSa2RlTDFBb1JKaWtPV1M1QkhRU0tROHZJ?=
 =?utf-8?B?ZEFQZUlTVUxmeHlLNjZZaTc5UWdTTlRQaEkvWllwMUdjcTRCdjN1UEtVZFA3?=
 =?utf-8?B?T28raWRYWTgwa1FRT29rMzJCN1BjcFp4cVBBbVVLQnpRdENLQTBwV3gzVnUv?=
 =?utf-8?B?b3ViQkhaMnVRWkZFZkk4VFBKUzFCeG5wRUt4L1pzMkg4QnRCMXBKZEUrSE1F?=
 =?utf-8?B?Nk56WEhjdS9TVzdtV0czYVlvRnZRaHoxYTUyQWlvemdXYWpGUVlFWUFoWFpX?=
 =?utf-8?B?dEtEdHQ5eUZxSTVQMUI5cFZNSm5lejBORS9TdkxreUR2NkI3OVl3a05lQTBG?=
 =?utf-8?B?TzZrSnhPdVNVY3lvc1RnYy9nbm1XRHJuOVpGNTh4V2lLVTZVaTcxaEgwcndJ?=
 =?utf-8?B?Y2hLbmxlUnFPWTJDYlVUYnRvWTR6dkVOS3lueDhkMkxncVNmTTd3UWpjQTdU?=
 =?utf-8?B?UzM2NlQwRzVUOE1VM2pZUFZ2Zm15aUl4c2FEL00rY2pjTTBTaVRWc1VEb213?=
 =?utf-8?B?UTYvdzNWcGcyQ2R3czhRT00vVW1IeTlHQjh5NkFxQTJPZEF3V0dSM25Xbm1t?=
 =?utf-8?B?SzFCRlJRVEV2YzNOdzYxdWJDNFZoejI2amNSN2MwcVdEQnMwZ3RnTWh2VUZv?=
 =?utf-8?B?d01YZnRyT3YzelRMUFJZOG1PVFdZTU4wVVhMMS9tUnQ0a2VWZW1XQ2Zza2FO?=
 =?utf-8?B?bXlrTGs4YnRCM1ltNjMwS3dSQmVLdXAvR3NrbXVIMVdqcnN6a28zMTBOWHFz?=
 =?utf-8?B?eFVudHdvcDJGYzhhaEU0d2pYQlJwcWVBb0U0TlAyVjQyMHBMS1d0NE9WVkYr?=
 =?utf-8?B?a0RtOG81N3VzQ3p1ekREbnUwanJJTzVQNy90bnd5a014eUw2M2NsdUk2VVl6?=
 =?utf-8?B?TzBIWllVT1lsVXdzZDh2K3B2RW13U0ZPU2FEeXZteXp6SGwwVXpFVEtqT0d0?=
 =?utf-8?B?c0I2eVVkUzJDciszUXNpSUw0MEU2cm45bUpnTFdJcmxwcTQxMkpINXBIaUNr?=
 =?utf-8?B?RmlZaldRT3V6L1lPUlIrZXdIdmF2eUczSHFQUVZNMlc3bHk4NjBVNUl0MGpK?=
 =?utf-8?B?TGRUWGovaFhFNUlnaUJXUUozaEFmRUhhRnd3T0FzZXNyTVVQUFprbndmb3NW?=
 =?utf-8?B?NXhqSWpQWk45ZDNlV2RUcThCYzBUUWFuZUQvZkdVSHUwbjhhSmJEenl5K21I?=
 =?utf-8?B?bDN0RU5qcTJDZzVQd2RlcUduYTZoQTdrQnlUeUExV1o4R2Fxb0l6cTAyeWU2?=
 =?utf-8?B?ZjNHVGFXemdwbWxTSm93U3hUSTcrTHJxemFQeHJJR01NNitzM3hxcjJpbmZF?=
 =?utf-8?B?UGY3aCtOeXdpeTlUaUNlSWhxN09KVTlZTGJ4VjZ6U1pSaHd2djNESXlrWHFB?=
 =?utf-8?B?SmNXMCtVSzZvWkl1U1MzbHhySFZWM3VqWVloMmppUnhLR3hSNnp3MXp4YUx5?=
 =?utf-8?Q?/N35JytYoRYBUFMx+H4fPOA=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725e89cc-1017-4277-f266-08d9db78d711
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB4514.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 18:23:50.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+2yiDW4KXfNK4pIFCR26PZ0XmSIxU77E6NJzEMMqfQAMehlGrnVm/Nxfq5l9Num3/nPcnBWm2UUEeefoqSrcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7537
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baruch,

On 1/19/22 1:14 PM, Baruch Siach wrote:
> Hi Sean,
>
> On Tue, Jan 18 2022, Sean Anderson wrote:
>> This is a rework of patches 3-5 of [1]. It attempts to correctly program
>> REFCLKPER and REFCLK_FLADJ based on the reference clock frequency. Since
>> we no longer need a special property duplicating this configuration,
>> snps,ref-clock-period-ns is deprecated.
>>
>> Please test this! Patches 3/4 in this series have the effect of
>> programming REFCLKPER and REFCLK_FLADJ on boards which already configure
>> the "ref" clock. I have build tested, but not much else.
>
> Tested here on IPQ6010 based system. USB still works. But the with "ref"
> clock at 24MHz, period is calculated as 0x29. Previous
> snps,ref-clock-period-ns value used to be 0x32.
>
> Is that expected?

Yes. From the documentation for GFLADJ_REFCLK_240MHZ_DECR:

> Examples:
> If the ref_clk is 24 MHz then
> - GUCTL.REF_CLK_PERIOD = 41
> - GFLADJ.GFLADJ_REFCLK_240MHZ_DECR = 240/24 = 10

And 41 == 0x29.

--Sean
