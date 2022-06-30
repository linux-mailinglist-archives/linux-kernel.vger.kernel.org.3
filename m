Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB40A5611B5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 07:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiF3FXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 01:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiF3FWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 01:22:42 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80108.outbound.protection.outlook.com [40.107.8.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325CC4163F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 22:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irL+KvnqaVeeUeB75qu7/M+om9fqTjA85nwEeuAWnGDlGrDYkbehYuwCtd4JMlfT9v2t7134KY1zEz4uBKs7k1cySqBx3bZf1QqI/w3fQA2zOTZc1E1wC/w4EusuAw5W8gP4jFkHpR7FGz06Bhj17oYstDGFh1Ukh5Epge7xVvTazlxai3nptlTRnJbYccMV/iw99wvhGtruwATNwD6u2m1qhDzJNd97PBHv0dm7+U0fF9YexBnMXOwK7FWGWvKVr3oiKk47AtZfNM3x53aa0KHNVkw+3NWNcNuF696G3EUqtERxmiRVZoA/kG1Qdcvm9LlmvnVNfV026XstdRAVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQlRFFfDflZsQ/LpExGZavaN6RWsWzM08tS9+ewWFZs=;
 b=aPFY3Xb0nT0kxrx0WQ0eNOLlvITy9npaC7w/x6340bDj/B87yrkOUTr4XdCdXBqGdwdgv79KYhqEB3TaZLDnkD35UQpqqPkAOL2pWwcbPFvmc7dRtzfAj73fdQ27IupgNhtGAquceOu1EU1mW7I9wJDZCxc7TvFWJTYwITlgRIBJV7R9951KnxcW6c+CcHbu9MQb7MLuT9arj3KfdgbvES8xiSS5I+KJDPNVguI4Siyrp3cvzGWmSsdgXvP7uFlw3+6W4nnv+6bMmnwArZvvzFVAzLbydYKb8xK00+rQLEOVygrH40p+EtkjDw+TtTOnJOlNUEKyR3s05co07+zubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQlRFFfDflZsQ/LpExGZavaN6RWsWzM08tS9+ewWFZs=;
 b=kAURGOhbsByp/Oz7DLnkmvPMEk6BcB1BUakbtAbdWO+O0jbdM9rRR1W9Rwh0klRHw6m93Pw1RhSIEbg2mNJ3iM8pdGlQchgKY/OYU+7tThPguGG8nqYaAQ31Dp/1phTevmgISUgy/lHUpSGyjjBDTN9D6zIQ1orrdIayCSZuf+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AS4PR02MB8648.eurprd02.prod.outlook.com (2603:10a6:20b:58f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 05:21:01 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::11f2:df70:b231:2b45]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::11f2:df70:b231:2b45%4]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 05:21:00 +0000
Message-ID: <d12d7f38-f3cb-6461-da7a-a82c3f340b80@axentia.se>
Date:   Thu, 30 Jun 2022 07:20:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: en-US
To:     Tudor.Ambarus@microchip.com, regressions@leemhuis.info,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com
Cc:     du@axentia.se, Patrice.Vilchez@microchip.com,
        Cristian.Birsan@microchip.com, Ludovic.Desroches@microchip.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, saravanak@google.com
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <6d9561a4-39e4-3dbe-5fe2-c6f88ee2a4c6@axentia.se>
 <ed24a281-1790-8e24-5f5a-25b66527044b@microchip.com>
 <d563c7ba-6431-2639-9f2a-2e2c6788e625@axentia.se>
 <e5a715c5-ad9f-6fd4-071e-084ab950603e@microchip.com>
 <220ddbef-5592-47b7-5150-4291f9532c6d@axentia.se>
 <6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se>
 <0879d887-6558-bb9f-a1b9-9220be984380@leemhuis.info>
 <4a1e8827-1ff0-4034-d96e-f561508df432@microchip.com>
 <1a398441-c901-2dae-679e-f0b5b1c43b18@axentia.se>
 <14e5ccbe-8275-c316-e3e1-f77461309249@microchip.com>
 <c5928610-4902-27f3-7312-e8c85eefad39@axentia.se>
 <bfb4cb27-e2e1-e709-1c27-d938e4d30eab@leemhuis.info>
 <6b1bae01-d8fb-1676-3dee-9d5d376e37f1@microchip.com>
 <0d8b2d9c-af85-7148-ff13-aa968a7f51ad@microchip.com>
 <AM0PR02MB4436C535FDD72EFE422D8B10BCB39@AM0PR02MB4436.eurprd02.prod.outlook.com>
 <272fb9f0-ad33-d956-4d0f-3524c553689c@microchip.com>
 <dc500595-7328-999e-6fa7-7e818378bb0d@microchip.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <dc500595-7328-999e-6fa7-7e818378bb0d@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::29) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd2c7d7b-34d5-48d5-f00f-08da5a5851ec
X-MS-TrafficTypeDiagnostic: AS4PR02MB8648:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmtNozCgZbKjLgJMVt+xZuN2qX2uGq9wnnDkE8ayIt2JjmpN7DpVpMSDMjJCS0nsYI3TRk53yMqjVFBFItA3YXPGAKuVfeyJOPRV0esW1EnWANkKLomV5SMtbJXMhagF7hL+lM7kU1nayG1UJI8vblxbsnWYbzb3sEYzH7f8DbnkaZC5vEjp2Fnr+CXIFIryHv/kaqixF92hBu9XfIfpFHVanS4qqPrCx+SdjdT0eHsP0o8XwsCbIz1xnvQpCg3IuihPpkxmKwRzKRJTXSdObdq/VYY+JDaOT5lwaq6sknCVXyGo7Y6wQz6BOZjX28rUHSgRVXVvp0/C1AGxRniYYglQ1iqQLF0V8d+jc/xthSDNBiNcCCqDXQVNMcsakCzjHVe6J/sQEJzZ5jtxtpIgauDSwIKi+vPSZQJtvsg1EiSCUwBIfiE3SNKsPZ29DKoFnY3IQoXMp19Fi10wtOsmH79JqJVmN36PFelVU2GnPohJLQQkHlHj8I7vGDOM7bIP9ChOaJeUVRVo18PEhJ8oOhBFzL6FtrCTVQetdRKgt2r/gUzHWLABjcq/UqSroDBsRhdrd23NMRPKzOLVFKSLtOeXBydnH6uUiAL9A4bre+rIHwiO5rQkJgwOx4wifGmGlbcSAwjm3x07juHglF/J3p5yql1jdqmoKqe4odvOMMcF6D3bt457+sr9J7U50/vZTl2YMtRl50JIHPoZflYcrVvJ2viJDcpnUEjKKSquAnILTouuU3NW9DXoBuU7huljBcy7LuEz07/IPTdKxiaU4r38BKfALHcx6B0zJWYhFUJ1NU656zd/5MEb4Xb+WjfxrhwLRXpcE04C1ikqdmMPVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(39840400004)(396003)(136003)(83380400001)(66556008)(8936002)(66946007)(4326008)(8676002)(478600001)(66476007)(86362001)(2616005)(41300700001)(31696002)(26005)(53546011)(2906002)(38100700002)(6506007)(186003)(6512007)(6486002)(36756003)(316002)(31686004)(7416002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzQ4a2VBaXorZDlRVVc1dUhrWHhSeTZiU1hJb1lYYXhoU3dpSEtLY3RZV0ls?=
 =?utf-8?B?ZmxFdVJKSlA3bGpzcDJYbEpRVTE2UVUvdnU1T3FyeGxvSG0vTGdybWdPQzNt?=
 =?utf-8?B?SnpsSEN0ci9DQ0ovVjRJd0tGYkxhd1hTV3g3dDY0SkQxMWhlcE9yWFFBQ1Iw?=
 =?utf-8?B?ZHdYWkJCMzB5SUpieVdmVm5OTWNmSVJZYVFkMnQ5M1Vma01kK2JYeXVWR0Ez?=
 =?utf-8?B?TlFEVTg0TzNTcXBiYkdhd2c5MlZVa2IzcmdPL2ZMRmUwdGZDTHdoejF6Mmti?=
 =?utf-8?B?MnNvcC9tZFZyMkJMNWtqVjl2RzdHeUE0bjBkdlh2U3F4Y2dWVXloNUJCeFky?=
 =?utf-8?B?TW9uSThyL3lQU1NJSTZEblh2anJGbDFSRW1sZGlNdjdBbzZZQzlYcGJzOEZz?=
 =?utf-8?B?cnFRbzIzQW5DQktPKzI4dzlxOEZYS0FPdExlMmw0cmtKL0JaY1paTUJ2S2lU?=
 =?utf-8?B?MkVlNWJPbTV1MXpEbEIyZmt6aloybVJqVCtGTngwYWdxdXBpVlhqZ3l5TndN?=
 =?utf-8?B?aHV4OHdzNVBKbGMzcHB3NjhPVmsxbWRPTzZHUG9lTXlaWDVoemIvc2RTempS?=
 =?utf-8?B?VzR1TEFsVmlLVnBkRWhoQkZUQjZZc2VJRUt1czl3Q09YMGpiS2lGdzV5cldj?=
 =?utf-8?B?YzIyQUlBZVNRc0JzWlRVYTk4cmd5V3hEZWU4Z1lRRUtObDlWWS83VWVRb3Zr?=
 =?utf-8?B?K3h2SHRmZm8vczhpQ1VjeENtUElyQUVGazFRK3V1eFJrWDN5WGhYSmhFUi9k?=
 =?utf-8?B?dS9lUkxMZWlWSlY0bUg1cVQyTm5uMTRUYjl4Q3FJV1EvMFgvZDhnV0t3RHp4?=
 =?utf-8?B?dmc2cW15VG5zelQxSVdKMkhNc2x1d2JNUm1heEIyakRRNWNRQ25pM3BIVTIr?=
 =?utf-8?B?TEZwL1JQcW1mNzF6MlNqbDREeTBidEYySTkzd1BxTG5ERUNJU1BVZjJQL1FB?=
 =?utf-8?B?VDNJM1BYdWxLMytlb0pjY0N6OUJOa1Zxa1d5bXl6REUvblU5a3NZKzB0QVU3?=
 =?utf-8?B?b3U3MkcvTWlwOEUvRk9VMlJ6dkVvOVI0a3NlejNNYk05YmliN05jWnRaMElB?=
 =?utf-8?B?MTg2UzJzTWU2cWhFalZTRC81TVAxQW5YQWZIUk1wSHpDZTA1ZjF4VFFNMlkv?=
 =?utf-8?B?RXYrWUpnTkNrMU5Eb2todzl5NkExdjRhNlI1RTZnamhBRkVwblN3dU96bDBP?=
 =?utf-8?B?cnRIc29jb0lIdUhRVGxEeXhiall5MmdjNlVFWWxaWU13Vk5VMDNOckFsL08v?=
 =?utf-8?B?R1lOUjI0UlYwTlBQcncxWTA3aklVbGhZV29uaXF3ZWVhMy9pSVFreU5ReGQ2?=
 =?utf-8?B?N1JUT0crc3JiZk5JUm5SZzhSUUd6R2RDZ2s1WHpkb21tdnlqZXVmZVVJVTlh?=
 =?utf-8?B?S0tnalcwNlZRN3RiMXc0RGxhbGluUnhKQlc4a25hWXVCeWJRMXloM1ZxZ2tq?=
 =?utf-8?B?V1FzLzJTY091MlYrOFpnclBSWHdEZm1RVGxablhUNExDbFhoWFlrRUpscWc1?=
 =?utf-8?B?ZGtma3RKKzl6STN6TXU3V1J5RlFkb3V6K0dJY3FMVGtNZllRdjVPVFFvNlRt?=
 =?utf-8?B?NzZRR1RhaW5ramowb3JDYXBGU0Rmdm9KVExwZ3J2T3VER0g0NWduYkxRUGJi?=
 =?utf-8?B?QTVTNzYvZHF0RnJialk0cTlreVhDcFFxVWxMV2VsSENnSTQ0TDJNY1IwK25u?=
 =?utf-8?B?Q0xWbHphekFRbVlpMkFpSGZoWkJHL0pUWUhvSXNoaDlUYWs4Qm1PZHlZZ245?=
 =?utf-8?B?SzlFWGxvYXdJajRYMHkyOXBIaW8yQmUvaHZUdU5VWHdqRmc0SXJPQ2pKNGVa?=
 =?utf-8?B?YVI0NEZaVTJOQjBXNFlyb3drbm04R2NWQlNGdTZYSDIxV2ZhR3BSR2U5QVN3?=
 =?utf-8?B?bytpam1CYjF4YTlmYnNPak9TeldiZGRmU2dSci9ZN2dKSmZMQVhRZW4rdUdG?=
 =?utf-8?B?S0poQ1pYMkJuTDd3RkNvOHNYYU01Y3lsaXRzY2Q3dys5dmNzNm4ya3luYURt?=
 =?utf-8?B?em5sRmh0akZSN1k5ZFluMVlWMHlqcVNGSVJnY2hpbW9zVFNZTE1EYTdtMDdo?=
 =?utf-8?B?K2dmR3A0cU9tY3hmaWU1bVdJVjN0TzViOUpRZWl1MUZXL253OGJUOGJ6ZTdU?=
 =?utf-8?Q?0A7pkyvjbna23HDZlyYB8q39h?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2c7d7b-34d5-48d5-f00f-08da5a5851ec
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 05:21:00.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yY77FBiT2EQu8bdxFt9fOM+t3GHVQJoZ0Q0DgUc4w835gmjHcBWVAjqpyQqQMYy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8648
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2022-06-27 at 18:53, Tudor.Ambarus@microchip.com wrote:
> On 6/27/22 15:26, Tudor.Ambarus@microchip.com wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 6/21/22 13:46, Peter Rosin wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> 2022-06-20 at 16:22, Tudor.Ambarus@microchip.com wrote:
>>>>
>>>>>
>>>>> git@github.com:ambarus/linux-0day.git, branch dma-regression-hdmac-v5.18-rc7-4th-attempt
>>>>>
>>>>
>>>> Hi, Peter,
>>>>
>>>> I've just forced pushed on this branch, I had a typo somewhere and with that fixed I could
>>>> no longer reproduce the bug. Tested for ~20 minutes. Would you please test last 3 patches
>>>> and tell me if you can still reproduce the bug?
>>>
>>> Hi!
>>>
>>> I rebased your patches onto my current branch which is v5.18.2 plus a few unrelated
>>> changes (at least they are unrelated after removing the previous workaround to disable
>>> nand-dma entirely).
>>>
>>> The unrelated patches are two backports so that drivers recognize new compatibles [1][2],
>>> which should be completely harmless, plus a couple of proposed fixes that happens to fix
>>> eeprom issues with the at91 I2C driver from Codrin Ciubotariu [3].
>>>
>>> On that kernel, I can still reproduce. It seems a bit harder to reproduce the problem now
>>> though. If the system is otherwise idle, the sha256sum test did not reproduce in a run of
>>> 150+ attempts, but if I let the "real" application run while I do the test, I get a failure rate
>>> of about 10%, see below. The real application burns some CPU (but not all of it) and
>>> communicates with HW using I2C, native UARTs and two of the four USB-serial ports
>>> (FTDI, with the latency set to 1ms as mentioned earlier), so I guess there is more DMA
>>> pressure or something? There is a 100mbps network connection, but it was left "idle"
>>> during this test.
>>>
>>
>> Thanks, Peter.
>> I got back to the office, I'm rechecking what could go wrong.
>>
> 
> Hi, Peter,
> 
> Would you please help me with another round of testing? I have difficulties
> in reproducing the bug and maybe you can speed up the process while I copy
> your testing setup. I made two more patches on top of the same branch [1]. 
> My assumption is that the last problem that you saw is that a transfer
> could be started multiple times. I think these are the last less invasive
> changes that I try, I'll have to rewrite the logic anyway.
> 
> Thanks!
> 
> [1] To github.com:ambarus/linux-0day.git
>    cbb2ddca4618..79c7784dbcf2  dma-regression-hdmac-v5.18-rc7-4th-attempt -> dma-regression-hdmac-v5.18-rc7-4th-attempt

I was out of office, but I managed to get a test running over night and can
report that It still fails. This is a longer run of about 500 with a failure
rate of 5% compared to the last time when the failure rate was 10%. I tend
to think that the observed difference in failure rate may well be statistical
noise, but who knows? Would it be useful with a longer run without the last
two patches to see if they make a difference?

Cheers,
Peter
