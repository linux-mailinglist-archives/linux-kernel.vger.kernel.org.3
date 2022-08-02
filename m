Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D93A587A0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiHBJpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiHBJp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:45:28 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2131.outbound.protection.outlook.com [40.107.22.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AEA63C1;
        Tue,  2 Aug 2022 02:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnJKwRGP6vJDpJcIHsG84wPmK0rDk+rsOZuub6c5rGHEOjX9PLgnqZzpaG0e9iCdVXF1P8/Lh3O/kvbzuw34MUTiVuQ9kr+754F6tPaBuBqB1GDAccJUNn7ad5zYmym3kxYNQ0FQKTy9PtVv7lj0OSH32Nkavvh5xiiHeiBdwDXbCYfkw+cF7Gyw3EqKU5D7ozrDZAdModoj1KrJBrxTOma8zfS19EJvCMTOYOnzLjf7se2cXRln8p4TL2ANmGWEyq8Gg8x2MaW1a4pwSM7PGhX+KHUKIDrnhg1vwqD1XFgAmMZwAz3H0rR+6htT8SvlYX6ck4Q107D/XyxLi0iQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyc63SagnjLZJstPgOVD0yVlf4u8bV5/bC/YL7C8AI4=;
 b=oZooPzhD9b61F3qN/yGnA9AfjIZMk6gmTrgPHgbj92vRwJGFFsItleR4l2xQIcH1yEWEwfTpHgwucfVpV8iodIiOCmBFGUVzd05ayHgZ614LgDirBdY3Nf00Qr2z00RqVYmbJBcUC3EdxN4QpxaCx7k5rIb5wR5dOFiLeoIPDo3h2jGOWoj9vvSyMefrGZ22BKroll4pnFfsCqlTnWvI5WkrSUltX1UpzpmOFzGhmmSwU9aKXSSI/iIL+D01MTDwUpm0vHBkIy0BxWGyd2OC75hX2dKeMqUd3pVYCPP/H/19TmorTomQmDqjqmXTO1MXRtL8nlL6CbkbGDxQAfLSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyc63SagnjLZJstPgOVD0yVlf4u8bV5/bC/YL7C8AI4=;
 b=O1JY0AQBSVHsVcv/k1fmZTONSrk9a6mqbA9Ir7u3MQpu5ADMHFUY1DhzeE7iydWIntaAdfLDKqXfV1HDQ6qob5qDEyjh/zBYRq6fnNgEsSuxrNcyvD9KjYplnJ4HxuVhlOzLhu4gKGXI8xbEeQtstL2kYbgzpd1Os4Dhwkilr6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from PAXPR10MB5280.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:277::21)
 by AM8PR10MB4242.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10; Tue, 2 Aug
 2022 09:45:22 +0000
Received: from PAXPR10MB5280.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a415:5795:98e7:1e53]) by PAXPR10MB5280.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a415:5795:98e7:1e53%7]) with mapi id 15.20.5482.011; Tue, 2 Aug 2022
 09:45:22 +0000
Message-ID: <6bb054d2-66c9-361c-bae6-c457b20d6870@prevas.dk>
Date:   Tue, 2 Aug 2022 11:45:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 02/31] kallsyms: avoid hardcoding buffer size
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Miguel Ojeda' <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
References: <20220802015052.10452-1-ojeda@kernel.org>
 <20220802015052.10452-3-ojeda@kernel.org>
 <c2bdc599a30e4cb887aa97e7c9d0355a@AcuMS.aculab.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <c2bdc599a30e4cb887aa97e7c9d0355a@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0023.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::9)
 To PAXPR10MB5280.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:277::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6c65fb8-09f5-4c6a-0219-08da746bb7e4
X-MS-TrafficTypeDiagnostic: AM8PR10MB4242:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39o2Cc6pzRf74V5x+y77aVBDri83U/qucXImo6pst/Vu9VTFgjBG/ZQDHTk7n32agc0CW1FM6xETWpAqoKd2ZsLKsttP/hbhuBxS/Vq9JebWzN21kJBV/p4iDGgMjWUKlJlien78Kja/JB0BkotrlWOh9VIQ0o3BmbJCsA88BLWPwNSkeLLunpVFuQQQ4FhL9u7SA4MgTcH/c/1qmWHyHeL3/fsEBiTFMgZaqXvofIQWKKVyPj2PWxfsW9veFSyHMv8ivHF/CPld1x3xHK1cGGzt7rT8a4ptULUrD3QiMacK8CRbc7yruXsjB+znOy8Ve1paMyzUstWytTVATaIfq59/lzceq9pWpGsakZ3Zkql/nqtaXZRjydum+OREA0gWu0sFZNdcgIPaMUbaWiELSRhomeshsY3ibRKWIX6H87CcNOUAEToEu2dDr2smnr9aaLXOclNtRmnRU2JMAkBnZBZPgSxrsE/fRe53qlJxlxHv1Wkj4DfZM0i/vBRIB2Y1XCamLtpfv/6W2szKYp7n2OkjDJSowJuqIPNnKlhEnNdLarIloeJACrFp0jS2oyAuSh51MERZkrbeuaw5GrgXmqe3zu3e9DrzTlYa6pxKTenQmK2Rv3sMcbiA+Fh3eJwW3psW2LW4h1cxPaKYHe5QArM8U/0Q3EBXr2e+Rn6F6oTSc2f0FJMsygmOKHDokjtWf+JYc7ti/cVpR1rHeNtLMyIMLmKeFNXe5akSbl6wqTMlEuRCo1UY0HsXz2oq7bwJEIs32PhlragtqYVDA74ZiYHhqInHMv1sgJ3Iw/aSPPYM4Vi3BPBeZh9oQVtVxf5ZIiNF3H/WnuQHdyOf5M9VmfYemGIp12gG7WTQq21cqhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5280.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(39850400004)(376002)(346002)(44832011)(4744005)(2616005)(186003)(8976002)(8936002)(36756003)(2906002)(8676002)(5660300002)(4326008)(66476007)(31686004)(66946007)(66556008)(54906003)(478600001)(110136005)(41300700001)(6506007)(31696002)(52116002)(6512007)(26005)(316002)(38350700002)(38100700002)(86362001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkFDMGdCakd0QVJzVllUZVp6bXUrbG1SNWFvUjJtd0JRVHVyVGd2NmlnZGZM?=
 =?utf-8?B?bTR4Y2JSTUIzWkJVZVVTSEphQ0p3QVVrT2NwREdaeGE2eXcvWTVuVmE3K0JY?=
 =?utf-8?B?TmJ1YVI2ZkM1N09lMzZQbGpUa0tna21xMS84N1NQZ3dzdUFpSEh0WDY5ZEh6?=
 =?utf-8?B?cVhEbnp6WHl2dkE1cmdUbk5uL0tjOTFoL01tbWxjbm9pYlpuQTdpYjhxUHZU?=
 =?utf-8?B?NVNXakpIcVp4K2NtVUljZXVIek9FU0lteVdOQnFiV3p6bnBMdzBhUFdxNjZO?=
 =?utf-8?B?QURKbUdkV1VvTXduVFFvZUlKWWk4dFoyNlIvVEpJdTh4aVpSQUNxT20zVnlB?=
 =?utf-8?B?eU8rdHQ0cXdST2xyUGpsZE10cFpLNFdiSXNmY0ZvT1FBeHI1WXAyUU9aS0Y0?=
 =?utf-8?B?MDhCSDY4dkcyQi9yYUF1OEtSa0Z2SWxMUjYxb1R6QkJPcU5SYVdYWlZyd2hr?=
 =?utf-8?B?bElZSXBITzVZWXh6bkNaTUYybU9hSDJBd3pteGJsVjdIVWF6Z3FTcDkvMXhV?=
 =?utf-8?B?RU1xTG03bHFwM1VHU3VoZ20yWHh0bTdFMU9wZ2VBYzBFcG1SVG1sb2FyeEVX?=
 =?utf-8?B?V3hVY0t1TlN0T25HMFhqdGl2Vk5GMllMVUlVcFRaMkFnRGVMUFJSUEZDWE1w?=
 =?utf-8?B?dm45RVJBcGlTY1VQSHhBOEtrM3haTEx2UHpGNXhJdjFDYmt6emRseUZFN1Bz?=
 =?utf-8?B?Nld3MFJvODZpNEo3eEUzWmtzMGpHVCtsdEsyTzltMnNTWjk0MTU5K1l0VUNq?=
 =?utf-8?B?d1J3NkJxamxUbDlxOTBERTYva0tOVi9QQVZ0a3E3VW54Zk9OeU1aODRZdXZ4?=
 =?utf-8?B?czhlbzBWYm5vZVd4SFhPeTJsNTZzSFNlckM1YnIyTEFCS2FEblpIOXNEc2lB?=
 =?utf-8?B?TXlCV2p5dmUvLzdBOWJNd2xxVjJuYkE0MUtyRHUySDZZekF3YjFoMnZWMW84?=
 =?utf-8?B?bmNTNlBwd05hazQrMlUyV3p4Tzd5SjlYM1o4ZVNyNjI2a2lEY1pZdnkzWVpa?=
 =?utf-8?B?eHByc0kxNld1VnN5RHFTZ2R4RTBPQVBleFRSWHNGaWdjb0JsSERwRXluMlRi?=
 =?utf-8?B?M04xTUFRUzlDQWxKNmxpdFpxdXNSTzAzUXBTZDEzcjgzYUhRcGxNSmt3eVl5?=
 =?utf-8?B?V205eVBRVk91TVNKbmFHcEpOUXpuNzVTSisyWmN6bGozRFFUMy9nYnhxZVpG?=
 =?utf-8?B?aDNvcDZJa3M4dUQ0ejVZZkFzc0ZhUDdNYjZpeGU1dHM0ZkhSV29rQU9xSzRq?=
 =?utf-8?B?U1d2RDFrS1FhNXlGbWl4bndkMkVlQjV1bk5IaUdDR0tubUV6K1pDNHU4V0FN?=
 =?utf-8?B?VVpKQUFqUC9ueERiWGdmUUxYR0hyaWJydVprSEZJMGczOFk2aHVmZmtRL2lJ?=
 =?utf-8?B?a3NidGZmd1d2VDdqVEd4cHowVzJrbldKUE5YVjFETjdPYlg0NWNjRkNWSFhp?=
 =?utf-8?B?ajMyN3UxMzZteGM5V01qSTlwaHZCMTZPR3hEc2MraXJmelpFYVVjeTI3Q1Z0?=
 =?utf-8?B?eThaODRzTnVqUzJyaGxsdS9kOHh0Wmp3akVpUEJsdTMrN3ZQcmhHSTJtWDJP?=
 =?utf-8?B?cFRZLzJ6NysxZWYvYjg3Z0FFVkh5eWF4WlcyaVFGMWJNNzNib3VKdmxMUnV6?=
 =?utf-8?B?cENMUlIwTTBhYzRIbnJQSGx5OW15WVlHcWl4Nmt6UGh5ZVlpQjlXWXhVNng5?=
 =?utf-8?B?MTJHbHdjYXNTR08rQ2RJVmYvU0VZcjE2NEgrWHNaNFhYTXlnRENsWmp0bjZJ?=
 =?utf-8?B?bVVyT2ovSWU3dTBleWNTdWw1WHE4WFBMclk5dFNFQnRnREpGUzBscDZNaE16?=
 =?utf-8?B?NzNod2pwWnpLV0pHOXpOV3NSdzFVZEJhMXlXTXdyZ3dkUkNWYkxjR1gxb1dW?=
 =?utf-8?B?QkFTZk1wN25JMm1DTzFHUGFFVmVic1g4Z2M1enBaNFNmemovOUZvM0Z3cG5T?=
 =?utf-8?B?Qm9VejJXcjIxaDBYamVqTFJBcHBpQTlIM3NoNzZFdDJMcUNZc3VkNE5tUkQw?=
 =?utf-8?B?RVZOVnlkQ3RvUy9QbGVuU3JlRjN4SFF3K1JzSXhqM2w2c1IzZlhKZVpLR3Fn?=
 =?utf-8?B?NVJ4ZzRXN3lxTFFYZmJLdHJQTU90Q1BEc3FjZU91NHBwT0dQMGdFQ0ozUFE0?=
 =?utf-8?B?clZ4TlFPcTRwRlpJRzJ4aElkNGtwdTZ4eGVua2VUZTVmcm1kTXNuQVJPbWZw?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c65fb8-09f5-4c6a-0219-08da746bb7e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5280.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 09:45:22.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKUGTbFpoMf2WhSjioKVtCKjkyYTv2iXM81/qSOfCAsGs1wC7gwJgN37+LUIXbj4iZc4p9r9KJpYCTA2oGdLkatfFFuy1NTOlIvc0g6Y4Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4242
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2022 10.29, David Laight wrote:
> From: Miguel Ojeda
>> Sent: 02 August 2022 02:50

>> -	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
>> +	rc = fscanf(in, "%llx %c %" _stringify(KSYM_NAME_LEN_BUFFER) "s\n", &addr, &type, name);
> 
> Think I'd use "%*s" - simpler.
> Although I normally completely avoid scanf() - too easy to get wrong.

Indeed, and your suggestion is a perfect example: for scanf, * doesn't
mean "there's an int argument specifying the 'precision'", quite the
contrary. man fscanf:

   •      An  optional  '*'  assignment-suppression  character:  scanf()
          reads  input  as directed by the conversion specification, but
          discards the input.  No corresponding pointer argument is  re‐
          quired, and this specification is not included in the count of
          successful assignments returned by scanf().

Rasmus
