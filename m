Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F5F580F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiGZJFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiGZJFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:05:38 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140074.outbound.protection.outlook.com [40.107.14.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12322737;
        Tue, 26 Jul 2022 02:05:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1N5VxXokGbNy3mEGFkcnMUnVWqUSX+eycjd8Vpb5DRVpjMt9rm49f45EYQ5mYScrF//rHKFtxAa+vyudR6jcYAUstdyDSCwSYa+AI7GWmn3yL2L/hVWd0nfb5OTwz4afQZTMsMgbjBXVT4SGWqkWPQU7zEGQNcJWrP4UMhb8LA24NR1dCOYOHqirUjF4tmJ9mh8OlAzqEsS/2301Q1ACGaRjDeLTrrScPddiXQ7/KEdK04SQ+MTdi6JZhNYEBDFm/DLnW9g0Ogz56tOR0WzZJD2FaO5yUbb1GaOeC2hOjKU7Ix/P57UlI9g000NcS7HKnD8vIY5yaAVCoQ3aHOg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7v7JNW/KJZJl4jJg0/SGPmKxKwdVWlDRjZy1cjXJro=;
 b=jfW223fS7RIXCBQ9+NF82ktWWo5t2UCmBZjHjVejY1awCRr+QyExxV+UbKK9FXbksdAdPtn2kQwYM3f3t60K+btYHFS1A3X2vXvsl/K15y24VKTP1zpAlme/3jLfrioat7TQcAITuAE/JeNHazwBKwnxixqH3mRPjQXDxP+lHleKYHMAiRhVP0l1I3BMnnhhQPnPPf7Tj580KxGbmLXwRM3RkLgIt7Ahq90tJbuB3o6aLrV4jGkGV9VNTT17qftxg+Rk72mfCrvje3N/DoBNa2nxgcl/2OCi8Dlp/1yeeoF0G/CZetS55g0rNH5yAugqLBxm+5wiSYtWk6be8+CO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7v7JNW/KJZJl4jJg0/SGPmKxKwdVWlDRjZy1cjXJro=;
 b=rKKQgdCIfFdkUBRKcNpOELXuimXyoXMLXLgDaur9gEakVauo2dFFmgVRXHT/pyLtKjEhHlFrbw5MuXPdIRmt1rX/RfCfj33L+bbFY3o5Nai4FAZxT749W5WQXE2FoEbSt8koHyMV2UsAh/UFvSNc336AMOLUZyUqyNJDs1+xjqmXkD+Th1KqvFTlTbbrShulEjgyEjir7dLnZEpxFGENPO0z65BPrxJHzGzROvnC5yN49m5TFRA3/Rt81EWi2we2vJrk9P/C4m64l1hlqcSXipwnVQOZ78wfleYN6a+vn60+OyXKyUi0fd4Oo23BwnT6JbzdAOgnmlpLEmt3lJ6tiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by AS8PR04MB8022.eurprd04.prod.outlook.com
 (2603:10a6:20b:28a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Tue, 26 Jul
 2022 09:05:34 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d%12]) with mapi id 15.20.5458.025; Tue, 26 Jul
 2022 09:05:34 +0000
Message-ID: <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com>
Date:   Tue, 26 Jul 2022 11:05:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: PM runtime_error handling missing in many drivers?
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Oliver Neukum <oneukum@suse.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20220620144231.GA23345@axis.com>
 <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
 <20220708110325.GA5307@axis.com>
 <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::22) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbfa895a-97df-4a35-b573-08da6ee5ffb4
X-MS-TrafficTypeDiagnostic: AS8PR04MB8022:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHM48Gjm9LEY1zahEFxnC3J84qHaiZOqeZzGlOqHYYjXFvfkdAlPM7weH9pK9YmXmQ4afuYaajm/dNmVrxHR/wqV3KMByUKwix+y303ykI0UoLxscT8nc68pqglDaL981D+0diX94hGhqeYLe1fW79y/qJpZDCPY+5d/iblQxV0crKOVv0j76GM6Ywsv8rXSWMGS3rWvMnRfAKPR15Rm9A7Xy5H+oL1gTLMTpINbUWdMj+8tZxy08fuxzaPgQ6AhHqefhu/yg0IkiLl22YALis5mPIyRZwKgMZDq/0praZUrYBkHimnVLN43KygbQRHYGSYiC0gAJYVxVs3qMZ65HxTpGpymIWRooxB4G/pVcGNWl7TAeRuu+oykQOx9YuhEanzsEWY5MK3x4GhkVDs0ClHLu6pNkrj4ZhDeHRahMidYwYoZr6/9xAGoN30iO4Al1UGgveI+IqQlKz2OcdFeEQpEG2IVJ3/zcHPyTX3Ld7MRo4pgeYZYwLBtKycwjey2pMKHJW4PHhIET0XRkDHW5p49P2L3zOU/5odKyPYNepWFBUUzT/SqcXoHCRcd8MMUElhdlHOC/TJV2wyonbJpR0123Zi6f0b5wp6dFNahlDeJwIkFTzxkRfecT6+ESY7jWRCbRsb3llOc+JeX1ce/1iWWai2TZ0J2HQurI1s7oy0Wl95TxisuALivI60wUiBpDjbbeBwpoysC8wII8pKwaXgQ+kNgx17rUx7VTh7ju8791ADkRvx669/PLKot2lwAcij6+Yq4M2RtEj6IUJ4r1nHveFz0K8pwh2YJbg+BDCfCgvfZCJ33nPcEDRAPFGvl5LM9BV7GJQzb29LeubRxpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(39860400002)(136003)(376002)(478600001)(6486002)(8936002)(31686004)(86362001)(5660300002)(6506007)(53546011)(6512007)(31696002)(2906002)(41300700001)(8676002)(66946007)(66476007)(4326008)(38100700002)(66556008)(54906003)(110136005)(316002)(36756003)(2616005)(83380400001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajJBSnJ6RHQxTGdmejB2MDlCZjJKd29CUHhtNEx2dFlWN2ZwbVZPdnN1Z1lr?=
 =?utf-8?B?M2JMeUNJVCt6aVhIbXl4KzFLcC9MQ1cxeGRwalRMWHhBREFIZ1ZxTDhHR2Y3?=
 =?utf-8?B?MmY3RmpVTWo1aHFlZ2hxVUliYzJoR1BMRDVWUXhKU1loZzFBa0xPdXVNRDVZ?=
 =?utf-8?B?aEVPV21qSHJXUHVBdHdBRzAvWVFPb25hdTRwbmR2UjY1OHl5TEJzdG9kSUc0?=
 =?utf-8?B?MG5tMW1PaldTaUt0aERaMjhDcnIwcHI0c1NiYmhzdDYwTHRrZjhnbnoxOGgy?=
 =?utf-8?B?S3VvOTVsWFNiK21wUWpNa0drRnhGRmdkNlMwV2Z4S1d2V2FQYnE2N2VvNFdl?=
 =?utf-8?B?NGgzb0VaU09NTGp5RFFBb0I5L1RKeENONWJkWnBMa2k3NE51cHliYVJKd0lh?=
 =?utf-8?B?R25kcmUvNWQ0a21Td1l5Z2RFS2p4U2p5SmZnTE9SVGJCWFhTeEhIZXRrejJI?=
 =?utf-8?B?cTdscUUva25DWFpGYlhKTHAraFJTRWcvSnBZMzdPMld0T0pneWtuZ1E3WW00?=
 =?utf-8?B?QXV6bW5IZGFTc3poakY1Tlk4UHVla0JCb2ZmZk82TWY5bjdsYkFFd1drbG8x?=
 =?utf-8?B?OUpYS3gxaDFtNmNmazVDMDRLdFFpN1M2eDRlQWY1MlNqd3ZySWduM3NWOXcx?=
 =?utf-8?B?ZFk2MGd5UHVsZ1NtV1NQQ1ZjUnMrN1phK0xRL0VObVV5VG1HNUdVY3FOQWFa?=
 =?utf-8?B?Q2VraHhraGQrTFRaMUVlSlZEK2JETXhPbVRKVENLY1cvZXJCYkdNbCtnTlR5?=
 =?utf-8?B?UkNMaXFKd1VkWm5wVVFQbDV4UnN2aTNtZXh0UUxvNDVieEhJNU5ESmhEQlVv?=
 =?utf-8?B?T1FJQjV2Z1hscjdocnVpU0kycExZbWI1ZWRZVlRMc1V4UVBKeWtmUUhVRHBS?=
 =?utf-8?B?RWFBeEgvMks3dFlVNEFxUTMvbGljeklrcS9VL0FkREFudmljSkVpaWRjNTh2?=
 =?utf-8?B?MXgrUDBHUzNQVm9aT2VVZlJsVG5DMy8vOEFoRGhuS29CV3hlS2Q3aFMzV0tw?=
 =?utf-8?B?aEtYay9jMWxKWXFxNEl4aTJpOHRFaWVXcjliWDlKYm1MN0g4N1pFTWtwcTZC?=
 =?utf-8?B?a3FrWTM1QkU3YjkzcklrSDVaUklaa2syV2l2OUdSc09ZanhEQWVZTHFobnJ6?=
 =?utf-8?B?M055RWRLd1J4VS81Qk1qUlJZdWxTYnZxbzJQdU9PM0xWbTNtK056RS9nS0lV?=
 =?utf-8?B?Y2hRc0phTm41SHJQckJSZUVOVjNDS20zRldpNElsdndrT2tmSDFsK3U5M3Fp?=
 =?utf-8?B?SG5yWkRmK3NkN2IrU2F4eWRaa0tIbEJZRVoydVJJS2ZpazVPWmpkUTI4RW5J?=
 =?utf-8?B?cnovSldBUXNHTGJrV0xjdVVSZk1MVXgxMmJXWjdnc2lnZVE1eHFMc3BnTjlB?=
 =?utf-8?B?RWdyNXNTYXZvU1FjWE9id1F0a0JTT05xUGZTWVllRnloNVhrUDFhSkNtUjdD?=
 =?utf-8?B?UUEzZ0NGQStlUE56K2lzL3FxblNqR3Jsd0FldDRnT0hoeENvdFB4SXBVZDRl?=
 =?utf-8?B?d0g5QWVGKzJHaE03ZURNMGl6RWorZVZ2MWRYL1pnT1l6MHArenFPbnBDbTJM?=
 =?utf-8?B?cndNaTVTYmRGcGhxRnJNbDlCWmMvZW1OYmVabjJYdXNBRTZBUHZ5aHAyOEZG?=
 =?utf-8?B?MDhQb0ZOM05TbHZBU1ErWlAvZUs1RVZQdXB1V1psc3JYbXRGanFEaFNEaFBZ?=
 =?utf-8?B?ZXVjN05QMjhqVGlLUU1rdlRveFlvRTFqZjZDWVRQYm4xaEpLZm1MWWJBTllS?=
 =?utf-8?B?dnVndU5Fckk4ZlZkL0VzSGNHMU9semZZbDJVZDlYMEFpcnJuOFpPQnVvWjJw?=
 =?utf-8?B?Y2dGTi9vQlU0NFB4S0JiczlFUllmQTlrTTVpZTRMZmk2UFptMW41VWJlR2Y4?=
 =?utf-8?B?ZlpHU1ArUmhjZi9JcmlvMUZXNlpyL1dYaWpQZVJWeU5tU0J3bzBKT0VWRitz?=
 =?utf-8?B?ZVhVQnlHR0NsZ1d0OHVlOFdoREZlMjdNTzhyZ1FFczdTTUNCTHlQUjFrSUM1?=
 =?utf-8?B?U1FzUndPVHltNjY3dlRyN24zd1VrNFVUNUt0ZjB0NkIzUXNWZ2hiQmVvTW1l?=
 =?utf-8?B?Y0dEYjZ1bzB5SFNGcEVrcFBZdlY1U1U4ZGNnRzBvVzV6eUk3eG1NbmVDSVF6?=
 =?utf-8?B?TzJ3cjdHVThhYWlRUjZiTkt3TXJVdWw0T1l5c2FvdFhwSzlTb1ZzRGFSNGI4?=
 =?utf-8?Q?HHookpAkRvBdxnwU4khEbRaZpIrRcWifV8PhTR1DKjld?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfa895a-97df-4a35-b573-08da6ee5ffb4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 09:05:34.4195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKnCGchuXBOyNmaPBg1nsQ9vJQTEaeZ/3zJeQjHJziOf54gU79eXoVwwDLp5k7WpZg/Wcp8dCTu3Vhkafh9toQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8022
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08.07.22 22:10, Rafael J. Wysocki wrote:
> On 7/8/2022 1:03 PM, Vincent Whitchurch wrote:

>> Perhaps Rafael can shed some light on this.
> 
> The driver always knows more than the framework about the device's
> actual state.  The framework only knows that something failed, but it
> doesn't know what it was and what way it failed.

Hi,

thinking long and deeply about this I do not think that this seemingly
obvious assertion is actually correct.

> The idea was that drivers would clear these errors.

I am afraid that is a deeply hidden layering violation. Yes, a driver's
resume() method may have failed. In that case, if that is the same
driver, it will obviously already know about the failure.

PM operations, however, are operating on a tree. A driver requesting
a resume may get an error code. But it has no idea where this error
comes from. The generic code knows at least that.

Let's look at at a USB storage device. The request to resume comes
from sd.c. sd.c is certainly not equipped to handle a PCI error
condition that has prevented a USB host controller from resuming.

I am afraid this part of the API has issues. And they keep growing
the more we divorce the device driver from the bus driver, which
actually does the PM operation.

	Regards
		Oliver

