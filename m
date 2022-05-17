Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B76529BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242150AbiEQIE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiEQIEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:04:53 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2074.outbound.protection.outlook.com [40.107.255.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BE03A713
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bpcl03MWKLudPhCtO7KGHUOZegNf0AFA+Lo/9w6JlbRZVEfvNZl8dVXDIRSq2kgBUXUPkUp4c0Jy2bwQt9Ug3K/Wl1o6YZmsiD3A2thZS4aJnEFcrgfnbBU31kNHEvSfpi2ujOA4rUwK357z9sup3Dct3efPDVT9B0GyK69ouQrDIXWQJxC46MtWpSd3xK5dSEH8/O4evjTA3rRSUMaE1LvobX/qMoyFg8z7V21wmyPb56FjzjT0Ehg8HMFW6lApXIyu+tYoz8OUFt87zeyQVPtFY8psyqcvCSqpXQ8sWfX1EaR/3k4/N6bWgDVkgp563xgRLImdSmeR8mKyUskpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AeKlEMvgulmXcuHQBx3hEEDfAkwq4CWehxCV6zjOjg=;
 b=BdUnI7SVMfh57z++/KtCXI4+3qA++iFW4R18toXk6XLhF3GohB9afYnwxG6tCErbZWdMm5IdtQF+S5gVx+pCYzLdkLuMz0nu9RWE6eW2S19EdFa+HDbbBVqfgOxppV61namIY5cDNJLY1BTcv3H3FiFiXnekU5K3CnqkVPkf/YWI8kYRvz62oDd5YXb+6Wgbnwxng+iYJAf0oNZqZfr400EhZitr+b1HjwzdWDI/elTO+Dhdckua7s4TbLbV+EB8JvUnYdxG6H+TxgKNh87kwVbmGzmWzLrERsO9hSs+6gZJc/cwHDiRrWKZgI40T7SikvAth3lHSwCv2gEsW6+01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AeKlEMvgulmXcuHQBx3hEEDfAkwq4CWehxCV6zjOjg=;
 b=pFhAZR2251+FqiE/rdyrm8bUZzRJuqHQNwZ5kJxwhY9C7Fnvnv8qR0uPMs12VYBIB/6VIRavzRielS+fls5Lxb13kQdf73wl1q/YvgoOKwTeEzF5MC04LG1ZwKX2FZC4vdO68w7DJGWo/78EFO6g+F0p0UtDfUfHi5edU7O5k+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13) by SG2PR02MB3337.apcprd02.prod.outlook.com
 (2603:1096:4:44::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 08:04:48 +0000
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::28e3:2379:30a7:c4d4]) by TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::28e3:2379:30a7:c4d4%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 08:04:48 +0000
Date:   Tue, 17 May 2022 16:04:46 +0800
From:   "lipeifeng@oppo.com" <lipeifeng@oppo.com>
To:     michel <michel@lespinasse.org>
Cc:     michel <michel@lespinasse.org>, akpm <akpm@linux-foundation.org>,
        hughd <hughd@google.com>, linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Barry Song" <21cnbao@gmail.com>,
        zhangshiming <zhangshiming@oppo.com>
Subject: Re: Re: [PATCH] mm: fix align-error when get_addr in unmapped_area_topdown
References: <20220412081014.399-1-lipeifeng@oppo.com>, 
        <20220412142238.93e36cc4095e4e0b362db348@linux-foundation.org>, 
        <2022041310411426044561@oppo.com>, 
        <2022050110235766139218@oppo.com>, 
        <20220501181041.6d53cb9ed54bf697840e36cc@linux-foundation.org>, 
        <2022050211305415626916@oppo.com>, 
        <20220509114521.GA9512@lespinasse.org>, 
        <2022051610294089439420@oppo.com>, 
        <20220516074524.GA27455@lespinasse.org>
X-GUID: 628F0ACD-C0E1-4E5E-B54C-9ECCCBE18592
X-Has-Attach: no
X-Mailer: Foxmail 7.2.16.188[cn]
Message-ID: <2022051715205971070538@oppo.com>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8121c854-8081-404e-af79-08da37dbe949
X-MS-TrafficTypeDiagnostic: SG2PR02MB3337:EE_
X-Microsoft-Antispam-PRVS: <SG2PR02MB33372C25D276B0FE37B3F8E3C6CE9@SG2PR02MB3337.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBHZThiO2gLGrhcfr7O4F8b4hKHAy8Pn0Dx0fEQGpCaS7KULFPdS1DAbYjq8ApJaY0nvMocJniDvGlT8i74fxA67oWVKgaVspqxEjatEEb83BAF6q0ETA27XbjZYEchyB2DWya2S5GN6QqDpBKyb4Ujng/SpDMVMNgCSn6YUekY/WqSCDqh1Q7EFk7yA87cc4IGkzZByhQzy0ADUU+0LXdFr+QTOrPDhfE1KBjPu8pWtnUhEam8BlzN6RnNGlsUCsbG8ktnQCO+EtFGATAZwH/hFLw8KL5LMzU07ScZ15SpyS76hlJn3eC1gMLTLBWw2a+jBoLnxiexSbJvFN9BZHtcyTKYYW+hMKpYQMXamKq473wAWwI3YKyZpuAED+UV48MxjhrTRseXzHBbWvcjLz1JsOutRTrHJl3uwVRph5PYRWACx8gT6f6rKFonRZBwunSsgreZefl0yF8rYGEnWuqc1Th4oS+9Dmvq+iS/cxjwD0OsYELHKRz1/u+d7rN0exs6XP8Qg8XHIIf6OhVJDS6kINhfsyqIvrKfaroVSsY5q2sZC9iwSxQQ81FxrJ4vocymVT0FGGFNnlJFZQMpvovfMqCSYBgwuGfbZ1ryJYXIrYQsYmieGlM/lj2gWk/z3PpbkBlzAfcyq4frMPJZ3b3vD7I+hetr9fU6iO9g04S5df9/y/f0rv+Ab7E0KGiWUBneSV2VM+yS8s6BHwdDtVgMgPhFdDlFjwSG9/yljVWcosr81PrQIPFI1erLFl/4dj1iPSc/zO972qps8e1XNi8LBzOrsh/H4Vw3DxsJqVVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4431.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(6916009)(58226001)(36756003)(4326008)(508600001)(66556008)(54906003)(66946007)(66476007)(6506007)(6512007)(98106002)(8676002)(2616005)(2906002)(86362001)(186003)(52116002)(6486002)(966005)(26005)(8936002)(316002)(83380400001)(5660300002)(37786003)(38100700002)(107886003)(38350700002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czNmVDNuZ0QyeHNYV3MxYnJrM0dwcEl0bHVRRDZHWUdvYVJRVG84MW90bVBj?=
 =?utf-8?B?VWorQXNDOXh6ckJCOUVMMmlVS0hwVWdqRy9semw4R2FsSFBISzE4ckN3dTJ3?=
 =?utf-8?B?WUJpN2htWlI0LzJjOHpyeU5rZ1NFdTRhTVpnNTlNQWVPOE8yVzhaRUtIaW9x?=
 =?utf-8?B?UnBtaEFDYUZMakVXSDI4OE4yUlNUSk41QUplTVZnSHJoYU1mRGxWTGxaUzdw?=
 =?utf-8?B?Nzhkamorb3hhY04rVjhTOEJuNUo0THZOcS8rN1V6Ui8yVlRuczduSTNSZGY3?=
 =?utf-8?B?WWwyWUF6TXZ5cVJFcXdpYzdyY0d0S3BpZGNlVHpTY3E5WVF4dGZYVzhqVzlv?=
 =?utf-8?B?RWE4SGYwbnBPQ1VoZmJHNTEyalI4ODdpR3FEZThFVEdjd0hOMElWdFdOZUcz?=
 =?utf-8?B?OFlvdjB4WVk5N3B2NnFiVEdmMElWdFNJQTBhaExuVmp3cDk2RXcvdlhrR3JR?=
 =?utf-8?B?OVZVaHl3TVptTm01YTYrYStVbmhxZS94REVGUjAzSk1Bbk9iQjQ1dlNjQ0tl?=
 =?utf-8?B?bHlQQ3lRRVdnQlFCUWUxQzUzRUJzb3V0MzlkMnpDbDZBcGsxRmNmMW1ia0Jn?=
 =?utf-8?B?cnlXWklMTSs2clZicnFvbkxobFk1Z2RLZnpZcXBPaTdkQnkzVHNPRXF0Rkpi?=
 =?utf-8?B?aGJtajUySW5JSGlZRzRsditDcllxOFBwUzU1WERRMlRYYktjeEp3ZHRCZytK?=
 =?utf-8?B?MmJIUS90Q1drcmpzNUJ3Uk56T3dSanpiU3B5ak9Nd0tzU3dsMFNuQ0RCaWgy?=
 =?utf-8?B?bk10TGMrQUp2bW94VkQrTU8vMnkvckdpV3AvakVJWXV0em4xQnkzMmNCampT?=
 =?utf-8?B?dXdhQTRDNkpvWWVrZHhsQXIwaEYvM1hoaEQxSUFidlh4S1VXNGNKRlRDaHBG?=
 =?utf-8?B?WU1rcGNKL1FYbW4xTUFOdTR5cXo0dnlIUEdPVzBTQ2VzUVBRNUVkbTh6aTBM?=
 =?utf-8?B?bS85SHBYdFJUV0N4bDNzTjFWVTU1aWozQmpQVDFLYUtvYTE0TVlJZGRBQjY4?=
 =?utf-8?B?d2g0cFNMZkRTMlkzSm13Umo2MWp2REpuazdvUk1BSHptNVdnRzFZRmg5cC9I?=
 =?utf-8?B?MVNiQzN5ekxYdnJjVGtST1RTODhYWXRRWWVKTlAyTEltMmFHZzhRWGVUZ29j?=
 =?utf-8?B?VVMxZWRhdzNKWlhkbkhXTDd2NVNNSWFCQmRvUkFGcWFaT1JWaXo5TjNleVox?=
 =?utf-8?B?cW0xcUVXcmdUYTU5bWUyZ1NqTjJKWi9pNW1MeXE2WFdZeGswcm1LWm9tcGdZ?=
 =?utf-8?B?Y3BybC9CT0haa1NEelZnRzhJV1d2YWl3OTZjR3Q5R1hqQ2QwRHpKYUhIT0Nm?=
 =?utf-8?B?aVYvblZ1YmxObXJMZFlGMGdLSWhsM20yYkVLMTFRNWdTMXI0WURWdllHQzNR?=
 =?utf-8?B?dGFrUDFUMW0yTTltVjgxVFJnSEZPQTV3Yk9UczRqbzRxMXdmWEJLc0RwQ2VH?=
 =?utf-8?B?MTdaRmU3ZWgwODlGNnRlRUorR3M2cW9zUlFiNkJIaVc4YmZIcGltWEpoemUv?=
 =?utf-8?B?a2xrZTQ1Q2JsR0ovbjd6OHg3S2xtZTZJK1cvNXErWlAwbU0rSHpnWnlWTWl3?=
 =?utf-8?B?NlBUVnI2NHEvb08rUFhVWlFrbFRlQUdxZ3M1aVdJdGRuem5ZajJTT3A0OHFR?=
 =?utf-8?B?U0xsejN3dStYRGFWSWFWcVczM285Nzh5MlBqLzlvUHhvdGxKUWxhdTBDL29i?=
 =?utf-8?B?RERsUlVBMFQ1OUI3SnpIdTZLNjFaclhZbkhQUjMyK1RiZm50VWJPdlFhMmM5?=
 =?utf-8?B?ZFZQYzFsc1lKbWtCZWg2bS9ja2FxeUluMTVlSURyRDZoL0EwSG5sUTBoWFpp?=
 =?utf-8?B?M2FiMm5lRTZLUFVOeGJ1RXVjM1haQnJWanBBZzQzbDZXZi83bjdRZ3VSZ0Ny?=
 =?utf-8?B?Y2ZQM01tOUYrbk8xMzdVdTRocVhYcUZ1U1hoOVhXWksrc3dVT0R0UlRIVXFG?=
 =?utf-8?B?aUV5ZUh4K2xDSFp2ZVM5ZEFFMnFsMkxjZDRNQ08rNHAzQ2h1WlluQTBwaUl0?=
 =?utf-8?B?UVJjV2htcFJ6aWdkVVhXdkpGZHpFQXJXM1NBVXZsb25NNWcwOGxuRERCa3pR?=
 =?utf-8?B?QXZxK2hPZ0VHMmE3YmpoMjgzbjIrbmJaZDI0ZXBOclpXZEloZjZlbzkwZkhX?=
 =?utf-8?B?UTkzRUdGRnNiajZSSkhwRXh3aXRLMERuS3ZYWXBNVGxqb3p2d2tnUkpVcC9R?=
 =?utf-8?B?UTJyV2NlNEtvODhKN2RHc25lR2Z3U0EwL28wQkEycGlBQXFva1FBMWRqLzFU?=
 =?utf-8?B?SHo0eGhUNzZJSmwyOTlyYUY1NGhWOWhQNzdpWGJnWUNETSsvTlRtekRSUVJ3?=
 =?utf-8?B?Y2x2emRDNEh5dHNGNlNmMU44MjNNSHZZRDI4RnJidDQvV1B1ZnVaakRyOHpQ?=
 =?utf-8?Q?F7OjwwDqwPoWZ5ZE=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8121c854-8081-404e-af79-08da37dbe949
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4431.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 08:04:48.0773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qlYxvNCONBtdO4f6oPcGatXYqAtBMFNTySX8C0AXH1g1K05gpUKtFwSLb/OxBdfP6XudRCnV95xTxvyjPhMjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3337
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gSWYgSSB1bmRlcnN0YW5kIHlvdXIgbWVzc2FnZSBhdGFiZMKgCj4gPiA+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjA0MjQxODMzNDU0ODQ4OTU4QG9wcG8uY29tLyAsCj4g
PiA+IGl0IHNlZW1zIGxpa2Ugc29tZSBhbmRvaWQgYXBwcyBzdWNoIGFzIHdlY2hhdCBhcmUgZmls
bGluZyB1cAo+ID4gPiBhIDMyLWJpdCBhZGRyZXNzIHNwYWNlIHN1Y2ggYXMgdGhlcmUgaXMgbm8g
MTNNQiBnYXAgYXZhaWxhYmxlIGFueW1vcmUKPiA+ID4gKGFzIHdvdWxkIGJlIHJlcXVpcmVkIGJ5
IHRoZSBjdXJyZW50IHNlYXJjaCksIGJ1dCB0aGVyZSBhcmUgc3RpbGwgc29tZQo+ID4gPiAxMk1C
IGdhcHMgYWxpZ25lZCBvbiBhIDFNQiBib3VuZGFyeSwgd2hpY2ggdGhleSBhcmUgdGhlbiB0cnlp
bmcgdG8KPiA+ID4gYWxsb2NhdGUgZnJvbS4gSXQgc2VlbXMgdmVyeSBvZGQgdG8gbWUgdGhhdCBv
bmUgd291bGQgZmluZCB0aGVtc2VsdmVzCj4gPiA+IGluIHRoYXQgc2l0dWF0aW9uLCBjb3VsZCB5
b3UgZ2l2ZSB1cyBzb21lIGRldGFpbHMgYXMgdG8gaG93IHRoYXQgaGFwcGVuZWQgPwo+ID4gPiBE
byB5b3Uga25vdyB3aGF0IHRoZSBhcHAgaXMgdHJ5aW5nIHRvIGRvIHRvIGZpbGwgdGhlIGFkZHJl
c3Mgc3BhY2UgdGhhdCB3YXkgPwo+ID4gPiBBbHNvLCB3aHkgaXMgdGhpcyBvZGQgYmVoYXZpb3Ig
Y29uc2lkZXJlZCB0byBiZSBhIGtlcm5lbCBpc3N1ZSAtIHdhcyB0aGUKPiA+ID4gYXBwIHByZXZp
b3VzbHkgcnVubmluZyBvbiBhIChxdWl0ZSBvbGQgISkga2VybmVsIHRoYXQgZGlkbid0IGhhdmUg
dGhlIGZhc3QKPiA+ID4gdm1hIGdhcCBzZWFyY2gsIGFuZCBpcyBub3cgZmFpbGluZyB3aGVuIHBv
cnRlZCB0byBhIG1vcmUgcmVjZW50IGtlcm5lbCA/Cj4gPgo+ID4gMS4gV2VjaGF0IGp1c3Qgb25l
IG9mIHRoZSBjYXNlIHdlIGZvdW5kIHRvIHNwYWNlIHVuc3VjY2Vzc2Z1bGx5IGJ5IHRoZSBvbGQg
d2F5LAo+ID4gb3RoZXJzIGFwcCwgbGlrZSBzZ2FtZeOAgXRhb2JhbyBhbmQgc28gb27vvIwgd2hp
Y2ggaGF2ZSBiZWVuIGZvdW5kIHRoZSBzYW1lCj4gPiBpc3N1ZShUaGUgYWxsb2NhdGVkIHNpemUg
aXMgMU1+MTJNKS4gVW5mb3J0dW5hdGVseSwgd2UgY2FuIG5vdCBzZWUgaG93IHRoZQo+ID4gYWJv
dmUgYXBwcyBvcGVyYXRlLgrCoAo+IEFyZSBzdWNoIGFwcHMgcnVubmluZyBvbiBjdXJyZW50IGFu
ZHJvaWQgZGV2aWNlcyA/IElmIHNvLCBob3cgPwpZZXMsIHdlIGZvdW5kIG1hbnkgYXBwcyhvbmx5
IDMyLVRJRikgZmFjZXMgdGhlIHByb2JsZW1zLgoKPiBEbyB0aGVzZSBkZXZpY2VzIHNoaXAgd2l0
aCBrZXJuZWwgcGF0Y2hlcyBzaW1pbGFyIHRvIHdoYXQgeW91IGFyZSBwcm9wb3NpbmcgPwpXZSBo
YWQgbWFrZSBhIHNlcmllcyBvZiBwYXRjaCB0byBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZSBvZiBp
c3N1ZSBhbmQgd2Ugd291bGQKc3VibWl0IHRoZSBwYXRjaHMgaW4gdGhlIGZlYXR1cmUuIFdlIHBs
YW4gdG8gc3VibWl0IHRoZW0gb25lIGJ5IG9uZS4KClRoZSBwYXRjaCB3ZSBkaXNjdXNzZWQgY2Fu
IGltcHJvdmUgc29tZSBwcm9ibGVtcyBvZiB0aGUgaXNzdWUgYnV0IG5vdCBhbGwuCgo+IE9yLCBh
cmUgdGhleSBiYXNlZCBvbiBhIGtlcm5lbCB0aGF0IGlzIHNvIG9sZCAod2UgYXJlIHRhbGtpbmcg
OCsgeWVhcnMgbm93KQo+IHRoYXQgaXQgZG9lc24ndCBoYXZlIHRoZSBjdXJyZW50IGZhc3QgZ2Fw
IHNlYXJjaCBhbGdvcml0aG0gPwp3ZSBmb3VuZCB0aGUgaXNzdWUgaW4ga2VybmVsLTQuMTQva2Vy
bmwtNC4xOS9rZXJuZWwtNS40ICsgYW5kcm9pZFEvUi4KCgpJIGFncmVlIHRoYXQgeW91ciBhZHZp
Y2VzOgp3ZSBjb3VsZCBnZXRfYWRkciBpbiBmYXN0IGdhcCBzZWFyY2ggYWxnb3JpdGhtLgpBbmQg
dHJ5IHNsb3cgZ2FwIHNlYXJjaCBnbGdvcml0aG0gaWYgd2UgZmFpbCB0byBnZXQgYWRkciBhYm92
ZS4KClJlYXNvbnMgYXJlIGFzIGZvbGxvd3M6CjEuIG9ubHkgcHJvY2Vzcy0zMi1USUYgd291bGQg
Y2FyZSBhYm91dCB0aGUgdGhpbmcgd2UgZGlzY3Vzc2VkLgoyLiBGYWlsaW5nIHRvIGdldCBhZGRy
IGluIGZpcnN0IGFsZ29yaXRobSBpcyB0aGUgZXZlbnQgb2YgTG93IHByb2JhYmlsaXR5IHNvIHRo
YXQKwqAgwqB3ZSBjb3VsZCBzb2x2ZSB0aGUgcHJvYmxlbXMgd2UgZGlzY3Vzc2VkwqB3aXRoIHRo
ZSBmZXdlc3QgYWR2ZXJzZSBlZmZlY3RzLgoKRG8geW91IGFncmVlIHRvIHRha2UgdGhlIGFib3Zl
IGZhbGxiYWNrLW1ldGhvZWQsIGlmIHNvLCBpIHdpbGwgc3VibWl0IHRoZSBuZXcKcGF0Y2guCgpU
aGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIGd1aWxkYW5jZS4KbGlwZWlmZW5nQG9wcG8uY29t
CsKgCkZyb206wqBNaWNoZWwgTGVzcGluYXNzZQpEYXRlOsKgMjAyMi0wNS0xNsKgMTU6NDUKVG86
wqBsaXBlaWZlbmdAb3Bwby5jb20KQ0M6wqBtaWNoZWw7IGFrcG07IGh1Z2hkOyBsaW51eC1tbTsg
bGludXgta2VybmVsOyBCYXJyeSBTb25nOyB6aGFuZ3NoaW1pbmc7IHBlaWZlbmdsNTUKU3ViamVj
dDrCoFJlOiBSZTogW1BBVENIXSBtbTogZml4IGFsaWduLWVycm9yIHdoZW4gZ2V0X2FkZHIgaW4g
dW5tYXBwZWRfYXJlYV90b3Bkb3duCk9uIE1vbiwgTWF5IDE2LCAyMDIyIGF0IDEwOjQzOjM5QU0g
KzA4MDAsIGxpcGVpZmVuZ0BvcHBvLmNvbSB3cm90ZToKPiBUaGFuayB5b3UgZm9yIHlvdXIgcmVw
bHkuCj4gSSBhbSBzb3JyeSBmb3IgbXkgbGF0ZSByZXBseS4KwqAKSSB1bmRlcnN0YW5kLCBJIHdh
cyBwcmV0dHkgc2xvdyB0byBhbnN3ZXIgbXlzZWxmLgpMZXQncyBzdG9wIGl0IHRoZXJlIHdpdGgg
dGhlIGFwb2xvZ2llcyA6KQrCoAo+ID4gVGhpcyBwcmV2aW91cyB0aHJlYWQgaXMgdmVyeSByZWxl
dmFudCBoZXJlOgo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9DQU5ONjg5RzZtR0xT
T2t5ajMxeW1wR2ducXhuSm9zUFZjNEVha1c1Z1lHdEFfNDVMN2dAbWFpbC5nbWFpbC5jb20vCj4K
PiA+IEkgYW0gc29ycnkgdGhhdCBJIGhhZCBjb25mdXNlZCB5b3Ugd2l0aCB0aGUgb3JpZ2luYWwg
cG9zdGVyIG9uIHRoYXQKPiA+IHRocmVhZCAtIHlvdXIgcHJvcG9zZWQgY2hhbmdlcyBhcmUgdmVy
eSBzaW1pbGFyLiBUaGF0IHNhaWQsIEkgc3RpbGwKPiA+IGhhdmUgdGhlIGV4YWN0IHNhbWUgY29u
Y2VybnMgdGhhdCBJIGhhZCBhdCB0aGUgdGltZS4gVGhlIGN1cnJlbnQKPiA+IHNlYXJjaCBhbGdv
cml0aG0gaXMgZ3VhcmFudGVlZCB0byBmaW5kIGEgZ2FwIGluIE8obG9nIE4pIHRpbWUsIGlmIHRo
ZXJlCj4gPiBpcyBhbiBhdmFpbGFibGUgZ2FwIG9mIHNpemUgKHJlcXVlc3RlZF9zaXplICsgYWxp
Z25tZW50IC0gcGFnZV9zaXplKS4KPiA+IFRoZSBtb2RpZmllZCBzZWFyY2ggb25seSByZXF1aXJl
cyBhbiBhdmFpbGFibGUgZ2FwIG9mIHRoZSByZXF1ZXN0ZWQKPiA+IHNpemUgYW5kIGFsaWdubWVu
dCwgYnV0IGl0IGNhbiB0YWtlIE8oTikgdGltZSB3aGljaCBtaWdodCBiZSB0b28gc2xvdy4KPiA+
IE1heWJlIHdlIGNvdWxkIGFmZm9yZCB0aGUgc2xvdyBzZWFyY2ggaWYgaXQncyBvbmx5IHVzZWQg
YXMgYSBmYWxsYmFjawo+ID4gd2hlbiB0aGUgZmFzdCBzZWFyY2ggZmFpbHMsIGJ1dCB2ZXJ5IGZl
dyBwZW9wbGUgd291bGQgZXZlciBleGVjdXRlCj4gPiB0aGF0IGZhbGxiYWNrIGFuZCB0aGF0IG1h
a2VzIGl0IGhhcmQgdG8gdGVzdCAvIGVhc3kgZm9yIGJ1Z3MgdG8gaGlkZSBpbi4KPgo+IEluIG15
IG9waW9ucywgbXkgbmV3IG1ldGhvZHMgdG8gc2VhcmNoIGFkZHIgdGFrZSBPKGxvZyBOKSB0aW1l
IHRvbywKPiBpcyBpdCByaWdodD8gaSB3aWxsIG9ubHkgYWRkIG1vcmUgYWN0aW9uIHRvIGp1ZGdl
IGlmIHRoZSBzcGFjZSBpcyBhdmFpbGFibGUKPiBhdCB0aGUgc2FtZSB0aW1lLgrCoApDYW5kaWRh
dGUgZ2FwcywgbGFyZ2UgZW5vdWdoIGZvciBhbiB1bmFsaWduZWQgYWxsb2NhdGlvbiBvZiB0aGUK
ZGVzaXJlZCBzaXplLCBjYW4gc3RpbGwgYmUgZm91bmQgaW4gTyhsb2cgTikgdGltZS4gVGhlIHBy
b2JsZW0gd2l0aAp5b3VyIHByb3Bvc2FsLCBpcyB0aGF0IGl0IG1pZ2h0IGluc3BlY3QgYW5kIHJl
amVjdCBtYW55IGNhbmRpZGF0ZXMgZHVlCnRvIGJlaW5nIHRvbyBzbWFsbCBmb3IgYW4gYWxpZ25l
ZCBhbGxvY2F0aW9uLiBJbiB0aGUgd29yc3QgY2FzZSwgdGhlcmUKbWlnaHQgYmUgY2FuZGlkYXRl
IGdhcHMgKGFnYWluLCBsYXJnZSBlbm91Z2ggZm9yIGFuIHVuYWxpZ25lZAphbGxvY2F0aW9uKSBi
ZXR3ZWVuIGV2ZXJ5IFZNQSwgYW5kIGV2ZXJ5IG9uZSBvZiB0aGVtIG1pZ2h0IGJlIHRvbwpzbWFs
bCBmb3IgYW4gYWxpZ25lZCBhbGxvY2F0aW9uLiBUaGF0IHdvcnN0IGNhc2UgdGhlbiBiZWNvbWVz
IE8oTikgYXMKaXQgaGFzIHRvIGluc3BlY3QgYW5kIHJlamVjdCBldmVyeSB2bWEgZ2FwLgrCoApU
aGUgY3VycmVudCBhbGxvY2F0aW9uIGNvZGUgYXZvaWRzIHRoYXQgaXNzdWUgYnkgb25seSBsb29r
aW5nIGZvciBnYXBzCm9mIHNpemUgKHJlcXVlc3RlZCArIGFsaWdubWVudCAtIHBhZ2Vfc2l6ZSks
IHdoaWNoIGFyZSBndWFyYW50ZWVkIHRvCmJlIGxhcmdlIGVub3VnaCB0byBzYXRpc2Z5IGFuIGFs
aWduZWQgYWxsb2NhdGlvbi4gQnkgYmVpbmcgbW9yZSByZXN0cmljdGl2ZQppbiB0aGUgZ2FwcyBp
dCBpcyBsb29raW5nIGZvciwgaXQgZ3VhcmFudGVlcyB0aGF0IHRoZSBmaXJzdCBnYXAgcmV0dXJu
ZWQgYnkKdGhlIE8obG9nIE4pIHNlYXJjaCB3aWxsIGFsd2F5cyB3b3JrLCB0aHVzIGtlZXBpbmcg
dGhlIG92ZXJhbGwgY29tcGxleGl0eQphdCBPKGxvZyBOKS4gT2YgY291cnNlLCB0aGUgaXNzdWUg
aXMgaWYgaXQgaXMgc28gcmVzdHJpY3RpdmUgdGhhdCBpdCB3b24ndApmaW5kIGFueSBnYXBzIC0g
dGhlIGRlc2lnbiBhc3N1bXB0aW9uIHdhcyB0aGF0IHZpcnR1YWwgYWRkcmVzcyBzcGFjZQpzaG91
bGRuJ3QgYmUgc28gc2F0dXJhdGVkIHRvIG1ha2UgdGhpcyBhbiBpc3N1ZSwgYnV0IHRoYXQgZG9l
c24ndCBzZWVtIHRvCmhvbGQgaW4gdGhlIHVzZSBjYXNlIHlvdSBhcmUgdHJ5aW5nIHRvIGFkZHJl
c3MuLi4uCsKgCj4gPiBJZiBJIHVuZGVyc3RhbmQgeW91ciBtZXNzYWdlIGF0YWJkwqAKPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjA0MjQxODMzNDU0ODQ4OTU4QG9wcG8uY29t
LyAsCj4gPiBpdCBzZWVtcyBsaWtlIHNvbWUgYW5kb2lkIGFwcHMgc3VjaCBhcyB3ZWNoYXQgYXJl
IGZpbGxpbmcgdXAKPiA+IGEgMzItYml0IGFkZHJlc3Mgc3BhY2Ugc3VjaCBhcyB0aGVyZSBpcyBu
byAxM01CIGdhcCBhdmFpbGFibGUgYW55bW9yZQo+ID4gKGFzIHdvdWxkIGJlIHJlcXVpcmVkIGJ5
IHRoZSBjdXJyZW50IHNlYXJjaCksIGJ1dCB0aGVyZSBhcmUgc3RpbGwgc29tZQo+ID4gMTJNQiBn
YXBzIGFsaWduZWQgb24gYSAxTUIgYm91bmRhcnksIHdoaWNoIHRoZXkgYXJlIHRoZW4gdHJ5aW5n
IHRvCj4gPiBhbGxvY2F0ZSBmcm9tLiBJdCBzZWVtcyB2ZXJ5IG9kZCB0byBtZSB0aGF0IG9uZSB3
b3VsZCBmaW5kIHRoZW1zZWx2ZXMKPiA+IGluIHRoYXQgc2l0dWF0aW9uLCBjb3VsZCB5b3UgZ2l2
ZSB1cyBzb21lIGRldGFpbHMgYXMgdG8gaG93IHRoYXQgaGFwcGVuZWQgPwo+ID4gRG8geW91IGtu
b3cgd2hhdCB0aGUgYXBwIGlzIHRyeWluZyB0byBkbyB0byBmaWxsIHRoZSBhZGRyZXNzIHNwYWNl
IHRoYXQgd2F5ID8KPiA+IEFsc28sIHdoeSBpcyB0aGlzIG9kZCBiZWhhdmlvciBjb25zaWRlcmVk
IHRvIGJlIGEga2VybmVsIGlzc3VlIC0gd2FzIHRoZQo+ID4gYXBwIHByZXZpb3VzbHkgcnVubmlu
ZyBvbiBhIChxdWl0ZSBvbGQgISkga2VybmVsIHRoYXQgZGlkbid0IGhhdmUgdGhlIGZhc3QKPiA+
IHZtYSBnYXAgc2VhcmNoLCBhbmQgaXMgbm93IGZhaWxpbmcgd2hlbiBwb3J0ZWQgdG8gYSBtb3Jl
IHJlY2VudCBrZXJuZWwgPwo+Cj4gMS4gV2VjaGF0IGp1c3Qgb25lIG9mIHRoZSBjYXNlIHdlIGZv
dW5kIHRvIHNwYWNlIHVuc3VjY2Vzc2Z1bGx5IGJ5IHRoZSBvbGQgd2F5LAo+IG90aGVycyBhcHAs
IGxpa2Ugc2dhbWXjgIF0YW9iYW8gYW5kIHNvIG9u77yMIHdoaWNoIGhhdmUgYmVlbiBmb3VuZCB0
aGUgc2FtZQo+IGlzc3VlKFRoZSBhbGxvY2F0ZWQgc2l6ZSBpcyAxTX4xMk0pLiBVbmZvcnR1bmF0
ZWx5LCB3ZSBjYW4gbm90IHNlZSBob3cgdGhlCj4gYWJvdmUgYXBwcyBvcGVyYXRlLgrCoApBcmUg
c3VjaCBhcHBzIHJ1bm5pbmcgb24gY3VycmVudCBhbmRyb2lkIGRldmljZXMgPyBJZiBzbywgaG93
ID8gRG8gdGhlc2UKZGV2aWNlcyBzaGlwIHdpdGgga2VybmVsIHBhdGNoZXMgc2ltaWxhciB0byB3
aGF0IHlvdSBhcmUgcHJvcG9zaW5nID8KT3IsIGFyZSB0aGV5IGJhc2VkIG9uIGEga2VybmVsIHRo
YXQgaXMgc28gb2xkICh3ZSBhcmUgdGFsa2luZyA4KyB5ZWFycyBub3cpCnRoYXQgaXQgZG9lc24n
dCBoYXZlIHRoZSBjdXJyZW50IGZhc3QgZ2FwIHNlYXJjaCBhbGdvcml0aG0gPwrCoAotLQpNaWNo
ZWwgIndhbGtlbiIgTGVzcGluYXNzZQ==
