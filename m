Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F204CCE27
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbiCDG6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237197AbiCDG6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:58:00 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2092.outbound.protection.outlook.com [40.107.22.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DABB18E3CA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:57:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUjPQU7BNrU+L+YDXD2C0V9jIkUwc71BzeEjoBY0OgrCb0RYMjYpzaO4LfP/mzSgocn8Nvqv9X4vk0mDBEQXZX0CjsYuLs7iAA2d7/uwKUVtIzXPu+vdv8vtOwHLsBdVOzg4Mso9rUUypigwPFDcvjpzfWnrjHkDukU4uJUkfsn3g6lkqopNwM5Tg/hmW/rSFqYZ790WOJMPL+zTh8OLyw4NU7hzFoenFIsNybKo0lhrR/M4dH9et2NcwPCVD/g1cuYzyPMl0syirA3HYWRZAIMkrdV+aNQQ1Dt/ACbJRPYxHE4cBBruJHHUfYnm4kqBdT8kdW+Q9y0bQ3GOw0kC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT1MSiLVILarxBETB7VSue4wlcwtXZDjnbso6v2lPzM=;
 b=iDmWI8trAp7f+OlGTqZ3XbeNYxORAqIGTibaSmtbrmdo0t+rG/Kf0c9MCCz073tWtGLVRdQV1aKMKoTj9dRVI429h++pDheaXR2G7daYA3Y3+RhSS0vgSqxRSeMUR3i0CaXKAVr1dV6ap43AgUjbIQypvbLQwgQdt7PyKsxBJYpoQPxJzy4smsUUzDZidTYutsAJ9GwxCicPui8sQL3uNUL+NiIESd4KT7wJCreRPDKfdbdl52bGEL3lqpztOdqWSC39yoQbnUSC+CGPtAaZ/VWfWhWJV87uVQ5UgUU614kpel98bq6NZTh31Ub7j7BWsWwkDsz1MFhON4wdS87UKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT1MSiLVILarxBETB7VSue4wlcwtXZDjnbso6v2lPzM=;
 b=LH2kZO1uRBvmZmmJtoijgOsNdtNmdFbdofOYOuScdQGOE7QIl53nIzpFvEz+lzeL8DUDr4ddBqkj9Ym/H1INCbiMKsfK/hN5xCQh+ytROBv+N9cm2CYzkkbjDXTuWCtJ+2rWuouLqJvuY6RBja36nqkwzHC2RQi0uwW09N4LHxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com (2603:10a6:803:ab::28)
 by HE1PR0201MB2282.eurprd02.prod.outlook.com (2603:10a6:3:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 06:57:06 +0000
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::2c21:5ed9:a7e6:6cdf]) by VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::2c21:5ed9:a7e6:6cdf%6]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 06:57:06 +0000
Message-ID: <f91c6f22-67a4-076d-d86d-6be1d14bc18a@axentia.se>
Date:   Fri, 4 Mar 2022 07:57:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Daniels Umanovskis <du@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <CAGETcx_yDtX0m4gVKahABvKamUtGg2adL1+6=gwb4U=KEhwm7w@mail.gmail.com>
 <69bb004f-0bb4-ec56-479c-5deab0ece00f@axentia.se>
 <CAGETcx8Bppn1y3Hffp2N_DPcJA6YyMEv1EFDTa1e1zOrkxbxzw@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <CAGETcx8Bppn1y3Hffp2N_DPcJA6YyMEv1EFDTa1e1zOrkxbxzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0274.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::26) To VI1PR02MB4445.eurprd02.prod.outlook.com
 (2603:10a6:803:ab::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0cca71c-8999-49d6-e7ad-08d9fdac31ce
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2282:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2282B47C89879A21659F421DBC059@HE1PR0201MB2282.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfGHc8967z6e+0kzMa1mbg2WEMrLA618I78/1r0qIfh6DxYzgNtYNWhWBF9yoer1I17CksA5qLJ1NYTZi4bqYo8g1TULBR+w2DdEN9e5uVazVOwUelSO2v1pBncNUsZioMnVZ596uLiucJUwJKkW/OL5sSFMivw5mykQcJ/2e7fv524fHXBdXQJrovrAuHrIhfCfkoQG+lykuf1SiWarGICh+1DBrTtG5akOEJL4/VCr/+qhTX/VeqGzmxoAxSScb2+TfDb1SYJwN3WdCVr4bXtiU4aViJUEFQ3BFLvJu7NxORAVG54LagtL/5VbLNlXviZEgenk5E+CLbuoV9gTOBnPqmsyjczsJZ/XLZCi91UZUrPhtzGVBrWyFusdYCPWosbktqyJfCm5xXdLe4YQEvkOf4K0mAPAHIRwZbzbFE/dY4QKc3iYLg3lmqRhzmQmpeeAiKUTl3Lx+2WS+NRDhHqDKe+2ThY3vic92okzh1gBuxCWwtZVi1nL+SS95boLnpJV6zE3cQCYVxufnAl8eUlT+Yz2cZZpOXSOhVTXmJk5Y7ILWqGlVYtc4fADRXRpX+oTWveApyJXUr90ig+Uag1vFTAxdxr75CS8qPvz4LqkCZz1JCtRj2pjCxhUFji8fmbEpZRwAiqDUL4I1uFJM+4V6jzzLcA1StnmEq1r4dT3i2DVqU+aisu2oM0wusWC5nI6qwPJOsfbUyq6vT7Igrwo31lthrqgsz2QWxnVmTH6cga4XlengDJOCY5y3hEWElPhTMSbSmjEcBWodDUgLEaQCumtpb4r0ARo8lkgT2DtUWZc/MCUbNvrctmrdtXk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB4445.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(346002)(39830400003)(376002)(136003)(396003)(316002)(66556008)(66476007)(8676002)(6486002)(966005)(66946007)(6916009)(4326008)(38100700002)(86362001)(31696002)(508600001)(53546011)(6666004)(186003)(5660300002)(83380400001)(31686004)(2906002)(26005)(54906003)(36756003)(2616005)(8936002)(30864003)(6512007)(6506007)(36916002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0VQdGQzT2xpUFlreWxyMVA2TnJidHlzV3QrL2MxdmZjMW5HSUY3OUVsOWxM?=
 =?utf-8?B?RFV5MUw1OTBkVUdoR0RMWWV3cE9VR3VNWDRQa3ZBODBtQ2N1dGpGcStHQk1t?=
 =?utf-8?B?dmM3SXh6R1NWZ09rZ1lUSEVNL0lJOXEyS1Ixa1FTdUJlV3ByMlMrSzN6d05a?=
 =?utf-8?B?SmppV3o4bVhyZjVmZGQvTDVjUzNoK3ZQQkFPVFhCTEllL2NHMWJPRWt2Nk1O?=
 =?utf-8?B?NWpQc1pVRDZjWnUwY3Jmd3lkcG45MU14T0pYeExYNXZnMmtOTTFuc1VjMEEv?=
 =?utf-8?B?dGViRVlRSHVIWjNUSUkrcVVkc010Vi9KWU1TVy9qcWl1dlJnUmhuRGJyYndp?=
 =?utf-8?B?SXNENXhOT3JzVHkrdVptZWF3ZGE4K3krKy9VZTNydHNYazdwa2Vsa2x2TjVX?=
 =?utf-8?B?RDc3L2FuRTV6RTZzZlRsUGZlUzJFOEp1KzlGNkl4MnRQcnltVllGUG4vNW9t?=
 =?utf-8?B?NWt0cldEQVM0d0Z0VlBIMGhKWXdtMWx3U2tZOVk0c2RiY1RuaFBHZzR4aFVI?=
 =?utf-8?B?NmZHNUJIbHZkZ3FUR0hMdXNjdURWM0NvSGRvQVdrbEVkcFNuQjdva1lHVGQ0?=
 =?utf-8?B?RjZTSnFRdndzT1B2amdYK2RvOXZ3UW1pQmZyZitnMlNmd0xUbk9pamVpSS9w?=
 =?utf-8?B?aTFRcXN4QTVFNHE5aGIxSkZaakxwT2crekxaVzBjMFBBQUhYWHlmMDlwYmFp?=
 =?utf-8?B?bHI4VThBaTcyaUFkdUl0LzR6QVhiQ0kyNlhvaWxrSE9FSUZHWlRKdk5BM2N2?=
 =?utf-8?B?bGFraHRJQWhYM3Z6a2pGMFY3SHNZQjlmRzVUaXFkZURRTUdnaTdLVzRsM1pn?=
 =?utf-8?B?cmc1YTFSdWl5R04weURtakNmYjRTRXhLeGFReW9xQ1Z0dVFiV2pxZzVjWFpW?=
 =?utf-8?B?eE1jOW93blJIL3NwTDgrTHkrZzJlS1BYU3kzTjYwRXZ3aWhPTUVabXNNTmta?=
 =?utf-8?B?WmFyWFA1OXM0SU9XNVZzRnNPRE93anVQMHg1SkFtZlZLRWVEcU5saVdXN3JU?=
 =?utf-8?B?YzJjNldLRnNCZi9lUU5wM2VMTG4vVUZ1VUgwK1NtZUh6YmdiMWUvYnFlUVNm?=
 =?utf-8?B?MkFSUGdqZytSWmRoZjhWTjVJYmVFNC9LbG5EcWtGSGRoUEFOMitsWkFPR3RL?=
 =?utf-8?B?Mm1qZ0pLRlkrUFAyZXk0R0xmNU1qbU1nQW9ZSVVqY3VCSmFyOUJXSFhFYXll?=
 =?utf-8?B?U0poVG14dzVrNUJEQWNwNFNMdm15N0h6WVVqN2NBazZFMmp4azh6bGxpWDVu?=
 =?utf-8?B?MDllZS93Q0t6OE1ReXdjKzZVQWIrQW9Cei9FN1kwZWRHUWdNTGZKYTY3V2tO?=
 =?utf-8?B?cnkvQkZHcEt2RHhTNlFzUG85dWo2YTFwMm5rQWVNN293aXIrYkplNUpPdzVV?=
 =?utf-8?B?N0ZuVUhDLzQ2clMxN1E5ZU9GK09OMUlLRmFNSWlkNTlwajRJQWZrZHBhNlpR?=
 =?utf-8?B?YTlMMHdhREt4elp5RUtYMUdQcEo4N0ZmNnplejFjSGhnakZLUkhmajREejN2?=
 =?utf-8?B?bGZjWVRyTmI5bE83a3pjS2JhUW1JSHFXenBlN0JBYWZONHh5ek5DV3B1dkEz?=
 =?utf-8?B?RW5SdE5hOTVuWVFtMHdxVlhWWlpVWWN3THhFalJGZmZUYVZMU3RRdFQ3S3Rz?=
 =?utf-8?B?cjFMSmVEVXcramtyRWxwaUJkU3daZ04wVmZiK24vRDBCYzJQUkNBVFNtYit6?=
 =?utf-8?B?ZXgvMnpJNGVlVXRxN3JNVmJ2b0tmcExNeFN6ZFh4UFBEZVFVaHhVY3NaMThU?=
 =?utf-8?B?NERLMjRSQm5KSW9QWGJSOVlubTdJdXN3S1BGUmszVkplSEQ5Q0pVcTE5cElp?=
 =?utf-8?B?QjNpbkhQWVdXNit5TlNmK3l1eXFtdExORmh4ek5uSzlTYW52cGx5dUZqd3Qv?=
 =?utf-8?B?OU5nWWN6bnA4cWhaTW5lQzNTSk9sZU9QbTBmcFhlSTlESGkxNjJsNTl0bTFm?=
 =?utf-8?B?RVljQkpucUdWRk5PeUs0TC9YRDRYYzN0dHlmb3NIa3FscGxyb1ppd04zaStC?=
 =?utf-8?B?VXh1UUl1cTN1OS9vN3FGNTg5OE1zNG54ZmRZQXprN0k0b2FEekNFVHkrNjZW?=
 =?utf-8?B?K0V4ZjFnV3lLcDBiRVJKL1hhR2dzUXhXaTJEdHhpZmtka2lmYk9QVit6QUxQ?=
 =?utf-8?Q?CMWI=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cca71c-8999-49d6-e7ad-08d9fdac31ce
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4445.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 06:57:06.4293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dk/ZC3dEnq51d4/zwNzRAkqAhwp3Euc15FGmC/W4Ry8sIk1xVEm1oomePxUKWHj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2282
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-04 04:55, Saravana Kannan wrote:
> On Thu, Mar 3, 2022 at 1:17 AM Peter Rosin <peda@axentia.se> wrote:
>>
>> On 2022-03-03 04:02, Saravana Kannan wrote:
>>> On Wed, Mar 2, 2022 at 4:29 PM Peter Rosin <peda@axentia.se> wrote:
>>>>
>>>> Hi!
>>>>
>>>> I'm seeing a weird problem, and I'd like some help with further
>>>> things to try in order to track down what's going on. I have
>>>> bisected the issue to
>>>>
>>>> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
>>>
>>> I skimmed through your email and I'll read it more closely tomorrow,
>>> but it wasn't clear if you see this on Linus's tip of the tree too.
>>> Asking because of:
>>> https://lore.kernel.org/lkml/20210930085714.2057460-1-yangyingliang@huawei.com/
>>>
>>> Also, a couple of other data points that _might_ help. Try kernel
>>> command line option fw_devlink=permissive vs fw_devlink=on (I forget
>>> if this was the default by 5.10) vs fw_devlink=off.
>>>
>>> I'm expecting "off" to fix the issue for you. But if permissive vs on
>>> shows a difference driver issues would start becoming a real
>>> possibility.
>>>
>>> -Saravana
>>
>> Thanks for the quick reply! I don't think I tested the very tip of
>> Linus tree before, only latest rc or something like that, but now I
>> have. I.e.
>>
>> 5859a2b19911 ("Merge branch 'ucount-rlimit-fixes-for-v5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace")
>>
>> It would have been typical if an issue that existed for a couple of
>> years had been fixed the last few weeks, but alas, no.
>>
>> On that kernel, and with whatever the default fw_devlink value is, the
> 
> It's fw_devlink=on by default from at least 5.12-rc4 or so.
> 
>> issue is there. It's a bit hard to tell if the incident probability
>> is the same when trying fw_devlink arguments, but roughly so, and I
>> do not have to wait for long to get a bad hash with the first
>> reproducer
>>
>>    while :; do cat testfile | sha256sum; done
>>
>> The output is typical:
>> 78464c59faa203413aceb5f75de85bbf4cde64f21b2d0449a2d72cd2aadac2a3  -
>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>> e03c5524ac6d16622b6c43f917aae730bc0793643f461253c4646b860c1a7215  -
>> 1b8db6218f481cb8e4316c26118918359e764cc2c29393fd9ef4f2730274bb00  -
>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>> 7d60bf848911d3b919d26941be33c928c666e9e5666f392d905af2d62d400570  -
>> 212e1fe02c24134857ffb098f1834a2d87c655e0e5b9e08d4929f49a070be97c  -
>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>> 7e33e751eb99a0f63b4f7d64b0a24f3306ffaf7c4bc4b27b82e5886c8ea31bc3  -
>> d7a1f08aa9d0374d46d828fc3582f5927e076ff229b38c28089007cd0599c645  -
>> 4fc963b7c7b14df9d669500f7c062bf378ff2751f705bb91eecd20d2f896f6fe  -
>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>> 9360d886046c12d983b8bc73dd22302c57b0aafe58215700604fa977b4715fbe  -
>> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
>>
>> Setting fw_devlink=off makes no difference, AFAICT.
> 
> By this, I'm assuming you set fw_devlink=off in the kernel command
> line and you still saw the corruption.

Yes. On a bad kernel it's the same with all of the following kernel
command lines.

console=ttyS0,115200 rw oops=panic panic=30 fw_devlink=on ip=none root=ubi0:rootfs ubi.mtd=6 rootfstype=ubifs noinitrd mtdparts=atmel_nand:256k(at91bootstrap),384k(barebox),256k@768k(bareboxenv),256k(bareboxenv2),128k@1536k(oftree),5M@2M(kernel),248M@8M(rootfs),-@256M(ovlfs)

console=ttyS0,115200 rw oops=panic panic=30 fw_devlink=off ip=none root=ubi0:rootfs ubi.mtd=6 rootfstype=ubifs noinitrd mtdparts=atmel_nand:256k(at91bootstrap),384k(barebox),256k@768k(bareboxenv),256k(bareboxenv2),128k@1536k(oftree),5M@2M(kernel),248M@8M(rootfs),-@256M(ovlfs)

console=ttyS0,115200 rw oops=panic panic=30 fw_devlink=permissive ip=none root=ubi0:rootfs ubi.mtd=6 rootfstype=ubifs noinitrd mtdparts=atmel_nand:256k(at91bootstrap),384k(barebox),256k@768k(bareboxenv),256k(bareboxenv2),128k@1536k(oftree),5M@2M(kernel),248M@8M(rootfs),-@256M(ovlfs)

> If that's the case, I can't see how this could possibly have anything
> to do with:
> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> 
> If you look at fw_devlink_link_device(), you'll see that the function
> is NOP if fw_devlink=off (the !fw_devlink_flags check). And from
> there, the rest of the code in the series doesn't run because more
> fields wouldn't get set, etc. That pretty much disables ALL the code
> in the entire series. The only remaining diff would be header file
> changes where I add/remove fields. But that's unlikely to cause any
> issues here because I'm either deleting fields that aren't used or
> adding fields that won't be used (with fw_devlink=off). I think the
> patch was just causing enough timing changes that it's masking the
> real issue.

When I compare fw_devlink_link_device() from before and after
f9aa460672c9 ("driver core: Refactor fw_devlink feature")
I notice that you also removed an unconditional call to
device_link_add_missing_supplier_links() that was live before,
regardless of any fw_devlink parameter.

I don't know if that's relevant. Is it?

Not knowing this code at all, and without any serious attempt
at reading it, from here the comment of that removed function
sure looks like it might cause a different ordering before and
after the patch that is not restored with any fw_devlink
argument.

> IIRC (it's been more than a year), the series [1] that brings in this
> patch has a few reverts. Those reverts undo subtle device probe
> ordering changes brought in by a bunch of earlier patches. You could
> go back to before those patches were added and see if you still see
> this corruption and then start bisecting from there. Basically try
> going to a point before:
> 42926ac3cd50 ("driver core: Move code to the right part of the file")

That patch was added after 5.7-rc5, so just to make sure, I have now
also tested 5.6. As expected, it looks like a good kernel from here.
It's been running while I have written this mail and has consistently
produced good hashes.

I arrived at the bad patch by first noticing that 5.15.6 was bad and
that 4.14 was good. I then did a manual preliminary bisect-like
thing and concluded that 5.1 was good, 5.8 was good, 5.11 was bad,
and that 5.10 was good (I think that was the order anyway, not that
it matters all that much). I then did a "proper" bisect between 5.10
and 5.11.

$ git bisect log
git bisect start
# good: [2c85ebc57b3e1817b6ce1a6b703928e113a90442] Linux 5.10
git bisect good 2c85ebc57b3e1817b6ce1a6b703928e113a90442
# bad: [f40ddce88593482919761f74910f42f4b84c004b] Linux 5.11
git bisect bad f40ddce88593482919761f74910f42f4b84c004b
# bad: [538fcf57aaee6ad78a05f52b69a99baa22b33418] Merge branches 'acpi-scan', 'acpi-pnp' and 'acpi-sleep'
git bisect bad 538fcf57aaee6ad78a05f52b69a99baa22b33418
# good: [15b447361794271f4d03c04d82276a841fe06328] mm/lru: revise the comments of lru_lock
git bisect good 15b447361794271f4d03c04d82276a841fe06328
# good: [d635a69dd4981cc51f90293f5f64268620ed1565] Merge tag 'net-next-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect good d635a69dd4981cc51f90293f5f64268620ed1565
# bad: [2911ed9f47b47cb5ab87d03314b3b9fe008e607f] Merge tag 'char-misc-5.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect bad 2911ed9f47b47cb5ab87d03314b3b9fe008e607f
# good: [c367caf1a38b6f0a1aababafd88b00fefa625f9e] Merge tag 'sound-5.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good c367caf1a38b6f0a1aababafd88b00fefa625f9e
# good: [93f998879cd95b3e4f2836e7b17d6d5ae035cf90] Merge tag 'extcon-next-for-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next
git bisect good 93f998879cd95b3e4f2836e7b17d6d5ae035cf90
# good: [b5206275b46c30a8236feb34a1dc247fa3683d83] usb: typec: tcpm: convert comma to semicolon
git bisect good b5206275b46c30a8236feb34a1dc247fa3683d83
# good: [9e1792727ead477f49958578d0dbd466a7deea48] tty: use const parameters in port-flag accessors
git bisect good 9e1792727ead477f49958578d0dbd466a7deea48
# good: [157f809894f3cf8e62b4011915a00398603215c9] Merge tag 'tty-5.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect good 157f809894f3cf8e62b4011915a00398603215c9
# good: [25ac86c6dbe62fba9b97e997fa648cdbe2d40173] driver core: Use device's fwnode to check if it is waiting for suppliers
git bisect good 25ac86c6dbe62fba9b97e997fa648cdbe2d40173
# bad: [9c30921fe7994907e0b3e0637b2c8c0fc4b5171f] driver core: platform: use bus_type functions
git bisect bad 9c30921fe7994907e0b3e0637b2c8c0fc4b5171f
# bad: [5b6164d3465fcc13b5679c860c452963443172a7] driver core: Reorder devices on successful probe
git bisect bad 5b6164d3465fcc13b5679c860c452963443172a7
# good: [e82a840cb1c1c83d01a9b81bb63b6cf1c09239d7] efi: Update implementation of add_links() to create fwnode links
git bisect good e82a840cb1c1c83d01a9b81bb63b6cf1c09239d7
# bad: [2d09e6eb4a6f20273959f4905ccf009da8c64c7a] driver core: Delete pointless parameter in fwnode_operations.add_links
git bisect bad 2d09e6eb4a6f20273959f4905ccf009da8c64c7a
# bad: [f9aa460672c9c56896cdc12a521159e3e67000ba] driver core: Refactor fw_devlink feature
git bisect bad f9aa460672c9c56896cdc12a521159e3e67000ba
# first bad commit: [f9aa460672c9c56896cdc12a521159e3e67000ba] driver core: Refactor fw_devlink feature

Since I need drivers that was added for 5.11, and it was easy
to revert there, I landed at 5.11.22. And while that seems
workable at the moment, it's of course not at all where I want
to be.

Since then, I have tried a fair few kernels after 5.11, and
they have all been bad. I'm sad so say that I have not kept a
log of exactly which ones though.

> TL;DR: is that since you are reproducing this with fw_devlink=off, I'm
> pretty sure the problem is not actually because of my changes or any
> changes related to fw_devlink.

I too don't get it, but it's a little bit too consistent with
everything pointing at this one patch across so many changes.
Nothing is good after this patch, and it all behaves a little
bit to similar across the bad kernels for it to be some subtle
timing issue. Methinks. But maybe I just need to stumble on
to some later good kernel. Not holding my breath though...

But it does seem related to interrupts, as I mentioned in the
original mail, I can take a bad kernel and reduce the interrupt
pressure from USB from slightly more than 1kHz down to a
trickle and things behave much better when it comes to sha256sum.
Copying with scp might cause network interrupts, so the two
reproducers I have are perhaps quite similar? If that's the
case, then trigger would be page cache churn, interrupts and a
fair bit of CPU usage (calculating hashes or encrypting).

Cheers,
Peter
