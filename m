Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E937575973
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 04:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbiGOCG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 22:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiGOCGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 22:06:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4677774DD7;
        Thu, 14 Jul 2022 19:06:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ne+fhdezxOUbiggDNATYYSypyHmemsEyBz1TQlIE8PhLWwWN+hN+6SqzhG/3l6M9dVmQcQUokjvQscHXoT3IEOYHmBeefIZVKvIBp9dfOjaG/ND5kVHqpusAko0qJKAvMMAHaLXpZ2s7oj75ysvb7x+e9+l9pW4da11c5398rUfjyE1UFuUMJPbYSn2XZ2f/Y9TcU7J8Ta0QMmS40BmAIN3fxMAa7uiumQIum1z5zAWy0xdhaBgWcj1Nhl2rne4dTmiEv0mR+nlqgl5K/dM26qkdwTw65Ai4TBQ2lD9t2ha1AGy/yqRH8+IrzeVdLUBS9kW1UMc+LJKmU52PpCDEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V3tViWSrXFNt9pOtNudz9fnSYSu5dA9WwBlUeLN7j0=;
 b=KUqBvRhDPsXsL5SN3YmJ7X+iMSoWZdnpoFen4YJMHlt0P0aJJfM2htqyt9dmHsPulAWdp/m4kcpQbI4r4F60THYrfNGkF84yaVqicTe7iv6hOcQ7+mSE1k5F+HlMikvTqOV5g3OTMAbJwTmXmHpN4Fbgs0fibo9uvqWHoHT+rGrd+cjvHetrlTLI+6I2CuhBqi+p2CepBzvnJWXPoGzUoiiRWvwxouzOOrccgHiiS+oLI0hFYcMTomgPoB25j5Wx6D8dCezuAL5qaVL7LhPETx0NdfBcgczJUQf6cW/+1yqzoOZmnja3snq+vcFc7KBnp85ux9bg4N/57NoQj+F3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6V3tViWSrXFNt9pOtNudz9fnSYSu5dA9WwBlUeLN7j0=;
 b=OmHZR79hpmjHzuw/t/bs6k6xDfFTbF/t9gqMjyhuwu8l6V44FjwxYvIiLynf1TNvvtUxxKKgomfI9Z3AM6vsK6DbUU5w8H4ZRDjFgomI2fcrADpkunkDxqmX7TL64vmOQ1mv6Yzssb2CkPT+a+im0j6ItBq6CIu2IXo2KjMfOI2jgHlOd+13JffSLJ+XUetF7sNAIDNkQ2RktTV3XBOZkVDSXcNNPHnHGp1AUxLgK26Q8ZzK5ehTHOuMk7LuwTLyYnr4bmqg/9WN5uvbLBcwhwp5J6Bt3ls+UdnhR5KAGcU2iEtKLfpRzhLJR3VQZ+8rqHyxslfUNGF5zB5tnA3qUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 02:06:23 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::dda2:7b0a:3280:5365%7]) with mapi id 15.20.5438.015; Fri, 15 Jul 2022
 02:06:22 +0000
Message-ID: <7277ef56-f425-493a-f148-8e4aaac37614@nvidia.com>
Date:   Thu, 14 Jul 2022 19:06:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/6] gpiolib: cdev: code cleanup following hte integration
Content-Language: en-US
To:     Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org
References: <20220713013721.68879-1-warthog618@gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20220713013721.68879-1-warthog618@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0070.namprd08.prod.outlook.com
 (2603:10b6:a03:117::47) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df53d380-405e-477c-7517-08da66069dba
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7036:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTwIuDh1HLBvz5XxxugpkapXJ042n6Xzq0YslUWKFJMkgBBxw6CmOckzN6xggDq7mT2AtvuLmYI0KpJ8m7yOkys38NkYbffnrb9g8bB5sZKxfthar5r86y8rY7+rzHoLDYiIzQFiw98FS5EBZ09y35EREWBrqZ6Oq2vgE1A2bowXhwhq2LQEOIswaoKCZ8Z5TKwzxGVFZIDivVVfdo1tCpkkEtIF5d/UipmfxxeyziyIxl5bjw2H2sDnz+IH2P2ue0+JYua8z3ikQ0kp2Hy0GA/i+ICJ2YuhVctRbXhU4neL0nR5g/mpeh+IoohFvKY3kTfp/xRctX/S45y9lqnwrs4hALnfoIJRl27SXwdYH8HoQFL3/IY4XwE+fJDqeVevjRuRatUoXZbIPk1upM/KySELMOkVoQZpuwm/4E6PGqMH8OUV59zpjehXlDwGdO3P4XlwrSDjyvFY60H20p+GOeokRodfIOxCbysdgmxsdVI93vkf6z8eqlar6GYkVfE0622KQ+w3nKEf7xpfddwzWq9wobP/aCYpXP6foaZ9NSDUCr6CXjtm+N1kSIa3RzKfsd2btEWlsoTMULUHDtwUIUN/27YsgdGlp6AmbMpxwurp7KPYGW2XV9cdSRzqmjuW2VrlvCmI1d0+NwwyPxBuvfrETeoGgieCKKnWmi8q9C/T66shKYgDJ08mZ6GFHG29YDrefbPVX+AfZyWGwW565OBO6xj/jyoqAH9JtzZ4XkcC/gZTF9VoKuf+Fq+I6YyswtTLhwnmZhIi0TSAAoFUyd/c20qfwexyukkb7dJ+B0gFMfMMKEs+RgSFWCIZ1cKx3A875YKz1/Ea3vUSPNu9sXWBmRLuqCo1lIx7aIYzAsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(66946007)(66476007)(66556008)(8676002)(316002)(31696002)(5660300002)(86362001)(8936002)(36756003)(2906002)(478600001)(38100700002)(83380400001)(6506007)(6666004)(6486002)(53546011)(31686004)(186003)(41300700001)(26005)(6512007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjVTOFh4cmR3TW1VVTZGdU43S0FCd0VwNy9NVU5CRzk4akt6S05KWGNRaTY5?=
 =?utf-8?B?MDZKd29LRVdPQXVzKzN0TG5FenZrTW5TeXVtZU1vRzMydjBSZyswTGNOVnhz?=
 =?utf-8?B?N0ROYkVub3ozKzVjSTB4alk1N25aaStJVzNVa3NRQ0pLYWNaVisrQUk0b3RR?=
 =?utf-8?B?Q2t4cWMrbUptcm1OUUorUXgzSVN4MDhiV3Q2UmU3VzVvMWpodTQwVkVnL3V2?=
 =?utf-8?B?TzlUeHBRb0EzWFp0WXkrTHdsdWRDdGt0MTVMZ0w2dWtWeHU2MGxMa0o3SjNT?=
 =?utf-8?B?WDJQak9GUUFpcFF3NlA3RmlzR2hBOWdLQkd2TU1TWnc0SFN1S3VOMzlmWU1l?=
 =?utf-8?B?Z1Zyc2NoSFd4R0xpSkYxWThuUFVDWVVkOEpQRW9ibnlFOXlST0k4OUJpRWtm?=
 =?utf-8?B?cFFvUjlnY0wvaG9nTnBBNlBvMGdKN3pIeHV3cytCVHpRZmpPaXBwc0hZT3ZP?=
 =?utf-8?B?MExraE5mTGkxSE5zaXZ1SjZvSGRrTlpDRGROSW11emg0OGx6bVFvSGpTcVpu?=
 =?utf-8?B?aDZOenFHUHhTMlhER1U3THhpY2JOaHhOM01KQUVxV0s3MUJWbFpOemF5aW1L?=
 =?utf-8?B?cHVqR2FjVXRlSi9LSkorUldHTkd3Z1p0Tld4YmM1Qk1XcWNuOW95djRHdXl5?=
 =?utf-8?B?N2tjTTI3NkdBMmU1ZWFVRkRFbFd5WFZRbkNSWDh3OE1wM3pWL09Lc1VNamJG?=
 =?utf-8?B?RkVTcVM0T1NHa2MrbXpsQ3hsTHRsQVg4ekkyWWFSK3k4bGRNa2JLQ2U5WjJY?=
 =?utf-8?B?SVFGK2sydC9vWTA1Y0hqdjlEY3FOWnBwUElRUjFqTnJvaTNPN3lyVVQ5VlNK?=
 =?utf-8?B?cTR1UXhoMS9LUTdKaVB1TWYyWlNOajVNdlhXYkFESjFmYk1LcnE4cHRFTmdR?=
 =?utf-8?B?UlBmdGp3cDk2U2cvOFBMcGdqc0piNnBNTDhmMEtoQndtVjlkQVJsRVJRSXUw?=
 =?utf-8?B?QmlGSkd0UGh0NTB4WjNTRlR0SkhyS1hhNTQrVGFYYmwxb3BoakZCWTJXYU9N?=
 =?utf-8?B?emZUTlptOFhhNnlzWFpscnl3cW1UN1RtczluM2U0dXZNOHpkRUJMQWxaRmFN?=
 =?utf-8?B?d0w4RkY4Qml2bFlYODBLcjh0MDRkUEZxdGUyVURFRUdCeW1MdkgyVEwzVmF4?=
 =?utf-8?B?NWMvdDFxVkVGTnByT0pGVlhHeFlxTnJmSFduR29UTmpqNDdoczV0MTFGN0VS?=
 =?utf-8?B?d1BDZU05WnlUYkk1eTJMQTdGeHpKQUY3TkpWLzF1NDBaMFZuS3JxcVBWTmlz?=
 =?utf-8?B?UzB4QSs2dkJMNHMxVTM4c1p4NmZQTHZEV055ZUJzTkl6Mnh6cG9rV2Y1SGtL?=
 =?utf-8?B?NmJaZGYwUS9wc1BRNkx4aUtDbEsxWmFpQTAyWXdUKzlZbDAwTnYxU1VScnRo?=
 =?utf-8?B?c3NHU3IyVU1KZ2V4eHhvV29WTVlESFhrU2ZNMXF3Y1FxdTVjTGdCd2hodDVk?=
 =?utf-8?B?WExuaVdaR2JYYVZIU0RLcktaVndNVStsN1I1Y2hkY09ncGlFekpoL2gwTTl1?=
 =?utf-8?B?MHFlTm16Q1N1K1prRWdYWXB4a0Y4QlVXeDNwaUxvRXVjZ2UzNmZGSkpSMUtZ?=
 =?utf-8?B?ZHhNQ2lMeUpVbmhWZ3dlTXJubWhuSnN3NUJETytPSmRrcHBLeHZZZEVWekND?=
 =?utf-8?B?dlRhS0gzbFA5dXI0elpFVk1oTG5YMDFIMjhnOUxOVmRhU1lmQnFBQjN2WlVE?=
 =?utf-8?B?WkhHYmdteG03OWdUTEZtb2txSzk2MWRma2xxckZkRzdOeWdPc0xRU3U4Y3k3?=
 =?utf-8?B?bHpic2RhNXFzZGJBeVZodmM1Qk9pb3hvd3p0cGJodmdHdGlYZnVQbXN3RGhr?=
 =?utf-8?B?RFoyK3N5bDhzM3JKQ0x2NmhvYnRHRFdxWWpOWjlSUnNDdEZyUXlEeWszZ3Ry?=
 =?utf-8?B?MG42elR3RjBZd2d5QlFrK0ZDcGhONHB0Y1pzRklEUXJ0Mmw4MUthUzdxTFpO?=
 =?utf-8?B?UUhjVE9FVWx6SGpqMitqVWt4OE1uL01mTVA4RHJNdlAzWDQ5d1NvQlBvajNC?=
 =?utf-8?B?RjI4cmNUaUdvTXFRbmRwbnorS2dzd2NXckF2V0JVTmdDRExuRG1oYk9RSGt2?=
 =?utf-8?B?cS81VTIzU2VHQzd4NlBrU3FFTVIzaHQ5TEpBTkIyS1JNTVJuNk5jUmY2OW9p?=
 =?utf-8?Q?F4HlwqtyjjRAifXaTwDT5/u/D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df53d380-405e-477c-7517-08da66069dba
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 02:06:22.9519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQRfE2ryJeDmBNfAw8gqC3+XlKeN7M9RfHBhvoChP2zkbELM2VppC3/qzyDXu6c4njwyIbl868LUKgTUPklU9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 6:37 PM, Kent Gibson wrote:
> This patch series is a collection of improvements to simplify the
> code, improve readability, and compile out unused code.
> There are no functional changes.
>
> The first patch is a cleanup for my recent linereq_free() fix. I
> noted then that the edge_detector_stop() could probably be safely
> moved inside the line desc check block, but wanted to keep that
> change minimal just in case.  It can be safely moved, and so here
> it is.
>
> Patch 2 makes use of an existing macro to simplify a call.
>
> Patch 3 replaces some more if-else chains with switches, which is
> more readable (YMMV).
>
> Patch 4 reorganizes the line identification code to share code
> common to alternate paths.
>
> Patch 5 consolidates a number of separate flags into one.  This
> reduces code complexity, simplifies any future edge source additions,
> and makes patch 6 significantly simpler.
>
> Patch 6 totally compiles out the hte specific code when CONFIG_HTE
> is not selected.
>
> I've based this series on gpio/for-current, as it requires the fix
> patch -
> commit c8e27a4a5136 ("gpiolib: cdev: fix null pointer dereference in linereq_free()")
> Happy to rebase if that doesn't suit.
>
> Dipen, I don't have any HTE compatible hardware to test with, so
> could you check that this still works for you?
Sure, will do it by Tuesday next week.
>
>
> Kent Gibson (6):
>   gpiolib: cdev: simplify linereq_free
>   gpiolib: cdev: simplify parameter in call to hte_edge_setup
>   gpiolib: cdev: replace if-else chains with switches
>   gpiolib: cdev: simplify line event identification
>   gpiolib: cdev: consolidate edge detector configuration flags
>   gpiolib: cdev: compile out HTE unless CONFIG_HTE selected
>
>  drivers/gpio/gpiolib-cdev.c | 286 +++++++++++++++++++-----------------
>  1 file changed, 149 insertions(+), 137 deletions(-)
>
>
> base-commit: 7329b071729645e243b6207e76bca2f4951c991b


