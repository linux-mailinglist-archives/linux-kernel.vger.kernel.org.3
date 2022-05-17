Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B89E52A539
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349282AbiEQOuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237661AbiEQOuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:50:10 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70120.outbound.protection.outlook.com [40.107.7.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB31C4F9F2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klzXZicoCyglrcttm4q0cm5zV3k1o+ZxBdtWDry2FHZh6aXEHIYrNvZoAxAP7vOJaAi/HYfFsNvGfv/8W1EcdvviPm/wkZpt8vBrWC1bYsCwHRFYrJ8w9Ry0p+cb5YZY3FbKbCZNRiSj8GurWo1Qz1xfy1Nds8tkWmHEqsBWuqp/8avZXam0QGDuxsnPaUWfA70FkAqfaPxzs4KRnLXM3AIkriTOIN89nBiaq8BdyknRkImSBHXPVlgdatmsolv3vWuou/Inpg7c4/NrZ9ZWTEto4lg1dkqmsbD2joTCCQsuunO4/R96qGawzD9UqZHAnbSV4ISLO7yVycG8ADtVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt1qJdvCVaNkaEpRHRVFaF2Tdo7mGCASjMxAnu24e/0=;
 b=eDQ2ook/ID2bOk3J5nRGE4XSvTkeRkPQptf1t/xV4ZONAYw+/+mJk5ygn74z7TOfsjIvvGkT3TY+ojt67S9kvPzypb/IY1f4GDr9VsLPmZCmuefg6BFdHmv7eWKOjvXpZvsuCQ8zloOIqjgBI+cKpmqGuZPSCWhqC62OaqPJS0roqw6wRFmDUjpWvW7BSieVvuqPo0PxbOpXhOAqLkVXf5loR/Ao+4hrUf5RooLgbVhDadv7JHuWUUyYK/r9SzHbI9A6e9End+5RsrwQjY6ooXXUL5U80stdNJpRXvdRa+tpRSbN0pO1kMlJylRdfD2AxFUFF3wZSDAjSKvxhP6I+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt1qJdvCVaNkaEpRHRVFaF2Tdo7mGCASjMxAnu24e/0=;
 b=SYlKg7BfhCwCqbbIcCHgGN4Y9wm1Y+IhQVlpOsm9efw4K7Jf+wJgv90LbP5fOXcOm04UHRQwoDgMEcfq4cOchL2VX6zytc1gC8i86M6yGUYpgmQBsH7J/1G53dshGrVgHs4VPzgAKYd7Jpnr6gLdIrKBSIOzCvCBhlTG0BfEu0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM0PR02MB4387.eurprd02.prod.outlook.com (2603:10a6:208:f5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 14:50:03 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::dcef:9022:d307:3e8a]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::dcef:9022:d307:3e8a%4]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 14:50:03 +0000
Message-ID: <1a398441-c901-2dae-679e-f0b5b1c43b18@axentia.se>
Date:   Tue, 17 May 2022 16:50:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: sv
To:     Tudor.Ambarus@microchip.com, regressions@leemhuis.info,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com
Cc:     du@axentia.se, Patrice.Vilchez@microchip.com,
        Cristian.Birsan@microchip.com, Ludovic.Desroches@microchip.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, saravanak@google.com
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <f91c6f22-67a4-076d-d86d-6be1d14bc18a@axentia.se>
 <7edb467a-c8b4-fe29-9947-f71c655caa9f@axentia.se>
 <8484ce66-639c-03f5-c5db-3574ea26690c@microchip.com>
 <075a196f-79c2-0d58-15f9-ad5e33e2306b@axentia.se>
 <3beb80ad-d6f8-8c6a-e17d-e40a644bba07@microchip.com>
 <e47c155a-f25d-11b3-3339-b2bf71b886ce@microchip.com>
 <9e24034e-f586-a721-9031-179601a69abb@axentia.se>
 <7214ea3d-1445-c0fb-2620-cdc3d6167bcc@axentia.se>
 <b5c57978-212f-55c4-2f0b-b38a8f157ca3@microchip.com>
 <a024180a-493c-af20-0910-da30dd5fe364@axentia.se>
 <6d9561a4-39e4-3dbe-5fe2-c6f88ee2a4c6@axentia.se>
 <ed24a281-1790-8e24-5f5a-25b66527044b@microchip.com>
 <d563c7ba-6431-2639-9f2a-2e2c6788e625@axentia.se>
 <e5a715c5-ad9f-6fd4-071e-084ab950603e@microchip.com>
 <220ddbef-5592-47b7-5150-4291f9532c6d@axentia.se>
 <6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se>
 <0879d887-6558-bb9f-a1b9-9220be984380@leemhuis.info>
 <4a1e8827-1ff0-4034-d96e-f561508df432@microchip.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <4a1e8827-1ff0-4034-d96e-f561508df432@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::32) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cccdba1-1871-4722-eb33-08da38148668
X-MS-TrafficTypeDiagnostic: AM0PR02MB4387:EE_
X-Microsoft-Antispam-PRVS: <AM0PR02MB43879F58B2764A4B8BC70B59BCCE9@AM0PR02MB4387.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCTRn9OpWWaWWfsNNCsqfcUW2WbCWyoq35zE+X6LlqqrUBGfA2Q8EZWF5PH8hMgWjcz16J7CfoGBFO6yhw95vDySuK4Fta+OMcbeV6+atPV6zWGvmMfRGs+Q+vo1OuwvbhDSGihEVEP62j9yKV/bDL6+er6fUS/53Awe0FyitQWZu5AhzMRi69isJo0okFvtaW1Xcb6DnwX/HCYd5UistKKX9Ok+g1tPZKVOOFUNsy6ssqBCzOzvLSlL6DfUi48oRFm6nL85T6PlBN50uLJaPl84LLb8GSFzVqfZjSETVKyfxOwwggh27q2EgI/h2o98O3yFUtSFk+n1pnlykzvm/8rgT/NCN2HtdN3l6X0u8QcRVQSVoXLfUsoekVTLXgWfDdnlX9uwFsMLf2hOkVcr+kmgUqq3JNsfRoaJTva44O7tkhWX6z3LhQ/SIRmZHgBIAMCotgQZmt4B4LC8WR2+76xoKop8Rhxxi6It4laQptXTS/VIjtZAUxSSz/yvQ/FZ+cdqt5sN7R9QohLqndT3vavqNt2wp3YL37yNj/B4ZTc2JTcdLr4cbQiaItJFnBShfWPZBc/xtlq9E2Cs8+4nP+T8dTOnZSZom1N935/P8dzj+OdjOqhwOHET6PHgK4uNkfbBJ7KY4Hv7nm8hz1D4+xy6sNUGllupxFpmFAHTzdnatH1SPFTUJfMHueSVzpbRonFgrXgoyW09AZqIcJlTX7ACBsdrKiusW6MlkEBYpKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(366004)(346002)(39830400003)(136003)(396003)(36756003)(41300700001)(2616005)(31686004)(2906002)(66476007)(66556008)(66946007)(508600001)(6512007)(4326008)(558084003)(8676002)(26005)(8936002)(186003)(86362001)(31696002)(6486002)(316002)(6506007)(7416002)(5660300002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmxSWnQxU3BCV0QrZ25nT01nU2k5TkV0VXM5RjRETWJxcDF6NFlhaU5FaUxQ?=
 =?utf-8?B?VHprS2NwUFVlZWJhVHZkbU5UQ2lBQXk3WnFiU3BkRytDd0xtS3ZBK1Rrb1ly?=
 =?utf-8?B?a2pkQWFDWkZCb2ZPaU4vY2RyaHNzWk4wZzBlQ1owQUdLRlZsNUZwTnEveW1n?=
 =?utf-8?B?QStaeGlnOTN3dDBHZ3JNUU53K09FRnBzcy9GY0w1OHJ2SHNmMVdNcWhzaVpL?=
 =?utf-8?B?NG9oYmVpM1h4N3FFcTVxazh2STFZNm42eStRZWY2RzB0Tm1RRzV2TUxRUDdT?=
 =?utf-8?B?ZXErYUt0VjlVeUp6SWM2dURuaWFEQitWOGRCZ1Z6bUMyT2FaSjJVWjFycmhN?=
 =?utf-8?B?WlRpVlh2STliRlpvVm5YNmJrUVY3NWN6dmpRTnp3S21IT2RSK20wdnMySkpQ?=
 =?utf-8?B?WUV5SExUOUF4V3pCMVEycjMrT3Z5b2Zqd0FVdDNPNTF0cHFuSWgyVWU0dEtF?=
 =?utf-8?B?Q1JNVUg4VFBvZTNiVVdsLzZsM1hyYnptNlYvWWtSbnFGb1M5V2Z0dHBNVG9I?=
 =?utf-8?B?Y0JmVXEzeGNqZkw3WlgxNklibkVDYW1ENDk0TTFVNGxrVnJLcFE1Kzk4eEpX?=
 =?utf-8?B?aDJ6YjF2TERKd0xpT1A4dWZGZEtUd1R5L0dBT0xHckNJMmdkVmsvNjJKOWRU?=
 =?utf-8?B?U2tmUWJWZWNFSmxYSlE5V1lhZnEzQWNzaGlXVGJTZjljc3haS01jZ1RtMzJi?=
 =?utf-8?B?UE5yWGh6UHRwUGpFSU5DcGVwdmpvd0RPaHdqTUw3c2VNVXhHQVZDbmdYY1Fy?=
 =?utf-8?B?L0R6SG5NWWtudmNCZXpvcU5GOHB5L2JsSmpTQkN0TlpPQTIraXg3MGlIdUJB?=
 =?utf-8?B?NmplL05lWVdoNFZnM2kvSzdiQ3d4R1IvVmIzeTlYWFRZTlllc1lQbHIrLzhI?=
 =?utf-8?B?T1VFdFdPVGsyR0psRkp0eGZrN25vamZxa1pmK1dCNjVpdVJRblRxNkd3eUhi?=
 =?utf-8?B?djlDMjl6eTFWd29oTmJXY1Q0dnJNOFdzTEowWjlvTzJkQVhyNWM4dXJHTmln?=
 =?utf-8?B?Wmppd01Vb2lPazlxeXBibFVDWkZmSUcvaTNuTDRMdHNyS21sUG5sVysvbnFr?=
 =?utf-8?B?TFllNWNIREhWU1ZGN3NsTDJyREpabFNHR0pEU0tGNDUvZ0F1VFFTVmdVTWNr?=
 =?utf-8?B?dXFWdlJWYmFNakNUMTRxRW5EK3hFZGRSdVB2V2RjMSthZUt1WHp4enArczBy?=
 =?utf-8?B?WDlrU2dMeGhZcXowUDIzWCtPeitpNldoQVFwdmhUMFJJYWszdVZtcFJvUjdF?=
 =?utf-8?B?OTBUOGQzQitId21MenhpVnd6K2xxRk1WemRpU05jK3AzSTMvb2VaUlEvRTFR?=
 =?utf-8?B?a0ZtRG1aSHA2MmxYWWdpQ1pKSExYSUFvTUtLNk5UZzdDcjJaQ0VDcm5najBX?=
 =?utf-8?B?dlVsUGppcENaNWpPNGZjOTZFOCtPMm96SStyRERndmVFN1dITUZZL3JaUGxT?=
 =?utf-8?B?U1hEdDVmempTVHR0RXZnUXB3b2FRY2xtVEZNQjVZZmgvY1crY3lsR25CMEVy?=
 =?utf-8?B?am8wcDR3OEw5MlZHbjVGcTlKZkFHTlR5UXN2elczbTUzcHp1UXd6OHQzbThV?=
 =?utf-8?B?YXpWcW1iY2IwaC81UUFUU1pkQ3YyVCtxUS9pV1F1bVJRcTY2SE10UUs1aHpy?=
 =?utf-8?B?cXNFNmhDbTFsdlhsOGMwQXpCNDZkTHZUMm4wTlZ4KzMxbDdUUnU4bzFHQVpQ?=
 =?utf-8?B?Yk9BY1NFSXdHWG9rdzBhVGR4b051bzZGeGFmM2k3TXdwbE9YMklycVBuN1N0?=
 =?utf-8?B?ZGFqbG1SQmEyaGNsUnVlUTVTVncxVlhFbCtSd1RXaXAvK2srUzFhdy9meFB4?=
 =?utf-8?B?TTBTanlNUzNIYU51VUVTS2dQTldnMXFweHJPL2FHVlhBR0NBTU1hSFdZVENz?=
 =?utf-8?B?dEQyVksySmxiMEQ3YlRHMUZHNHF5LzZsSXpEYmh3c21ocklFV3VFbkx6SnZE?=
 =?utf-8?B?cVBLMGdQcVlndVhJV3pTRUE4V3VHV05XNVl1bXFzWWdIdU1XejFFUXU3K2p2?=
 =?utf-8?B?UWFPSk93TDR6bHVUNHd1YmdySmxISFVHaSszbUJENG1KWG81YVRwYUdrVUky?=
 =?utf-8?B?Sy9lL2I3UlVXSGpGYU43MnZZQW9HYkY5eURleldGdGRyQit0VEZ6YmVsZncz?=
 =?utf-8?B?NEwraVBVN3BzSU9rQnMrVE04WWdlNkQ2QlNmaUk0RGQrS0daM2I5VGd1aXI1?=
 =?utf-8?B?K2RTUWZhdERsRFFRb2Rjc09lZG81R3ZVZE1TYWpDSVZNS08yTEp6U3ZUbGxD?=
 =?utf-8?B?ZVR6K21Rd2hoQWgwdWJDTmpzMXhjMlgvQ21rVTk5T0trMU5ud29SbzNqSVgr?=
 =?utf-8?B?T1Z0TnFXV3JnRG9EUndGM1ZlVWZvTVlHLzdLZE5WN001Q0dhajBGZz09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cccdba1-1871-4722-eb33-08da38148668
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 14:50:03.5151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkElv6VEfVgq0VHedQiZljaWhm0kMCS68Rm2DemTtvDGqZsXw4Vn1RruKSoGcT0Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4387
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-04-11 at 08:21, Tudor.Ambarus@microchip.com wrote:
> There are some concurrency bugs in the at-hdmac (DMA) driver, I'm handling them
> and will come with a resolution. Disabling the DMA showed the bug is no more
> reproducible.

Any news?

Cheers,
Peter
