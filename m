Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F13A4D4418
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbiCJKAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiCJKAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:00:04 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2124.outbound.protection.outlook.com [40.107.20.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A539210874A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:59:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IF6f4MkcpQufPXx/vr6GtT8XipuIxElx9X+UWuYtkzHQFmhNpfpWt6dLp+gNiq1jQ1FU1C2b0+rbix0vz+91AKU/6BtrVrhWkaLakUCYdfjLtjvmnFY7VvISl8u8DqM/VfQS3ieTeDlVxVxM4x7T6GdqRAKpJdkKMfaqVhGmBvbYCPpVXmK7mXD+QVJJohJTp8a6q414jMSbCklPVZxEiZZtVE13cT2SHC2sO+kxG+FIH29polJwRejsq/QEQdwefGia2L1j7NMDV8F+YogTsRhgrQd1IQK3tBWxJfgSdGW98EM7zAr8BcVryVcgkpLMTIOAJGSZU0QSxVL/gRNCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvAkx6adJwjc83B76Xs11rZYey2Gl6pRvNp8OS4Sh6w=;
 b=SDHfKb96yaTXZp4Uc2oTBc9g7MaeeCjNmTLssS11Jfp0qtkltQe5bSlt0+xJruSda6QNaeN04+xmj0uTrLyamNNJ054/6W/EjGVfljZWUDpnoKeMg+22/158xiZ1mNtZ/Wx88prCJshTeJxS6bEGGy8l3pQd/EuQ+ACYK/tk5pSRyOJt55g1suFrd9bSKCkeKmrO1WzxtmgbKfQyjwx6o5CscChVl5iRKa8t+6AGYEzJKW2tF4u1PeIam2eNPg9W3RELTAddqubBwgg6cP1vMdVWfrZqgvliedGCdaCHTbFcQM6cxaPnyiTRzziXVBsXjQ7qjpgXKou5Mz+L+dPlRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvAkx6adJwjc83B76Xs11rZYey2Gl6pRvNp8OS4Sh6w=;
 b=GV3sSV8iYf7Ra2K2dc1LHrq+nO1PlBxVu3W7bs8aGBa3Z5PeZbqTxzWd6TpX05XZlfR8lEiKV8duKyga2It9FbLwooof4VtEEXcPJw/zdEv+z2M1uGLyODNx06jkBenjKVmVmpjz599KVPTsTxb0zJwqxVFzJWj0e63/orf/arM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM4PR0202MB2852.eurprd02.prod.outlook.com (2603:10a6:200:8e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 09:59:00 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7d29:dd84:d2bf:a1a0]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7d29:dd84:d2bf:a1a0%4]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 09:59:00 +0000
Message-ID: <220ddbef-5592-47b7-5150-4291f9532c6d@axentia.se>
Date:   Thu, 10 Mar 2022 10:58:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: en-US
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Tudor.Ambarus@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Daniels Umanovskis <du@axentia.se>,
        Patrice Vilchez <patrice.vilchez@microchip.com>,
        Cristian Birsan <Cristian.Birsan@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <CAGETcx_yDtX0m4gVKahABvKamUtGg2adL1+6=gwb4U=KEhwm7w@mail.gmail.com>
 <69bb004f-0bb4-ec56-479c-5deab0ece00f@axentia.se>
 <CAGETcx8Bppn1y3Hffp2N_DPcJA6YyMEv1EFDTa1e1zOrkxbxzw@mail.gmail.com>
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
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <e5a715c5-ad9f-6fd4-071e-084ab950603e@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::25)
 To AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a48ab20b-f117-47af-89ea-08da027c995a
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2852:EE_
X-Microsoft-Antispam-PRVS: <AM4PR0202MB285275CB384CC1FBCECFD4E2BC0B9@AM4PR0202MB2852.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yzxVwB7G4FY0lDVt8QZMBkWj/Hk14PKEsJL4g9LHgBU7dCcBEhWEEzhIY3iLSg1q5ep2SOi2Y4SF+jzx44lBjsltUbKPgmMaW/FJvNof8NR1yj0YWBIAs87g8/ENmTwwIO0HZf0rD4uQkEh/y/tF9PY7XDbk2nreYFLuduOTHEAZafrY2Fga61bk9sXBr2Mu0ES7MxacJkBwHHZEdKNTH1/W1oaDdbx1ri+j9YOv6pqODeAW7IJgDM8GrrbXfd14To+MTYO/HfBEyZ6YOQ5hVBb2+STYd+EMBV0AO87b7ccJ/llz13WCZiBFhCTstGHvxN0b+d6M8I9CyjlTQM/b4LepPUxES+lgIPsp8bukonG/56smU4GilpIqB2GhRNxSXGlmgv7FFs7rJ38N+lt6PuEjIi0Nn6DjnfMbSK3D5mg/6F9OASdA85eDrM5MoL/AqCwgcZfM6TA3YdqNXAdA31Opbr3KeQ/L4uSsMR2JSBFdnhDgj8WYjVkntSrpKc4sF2xHmS2FtQpVL10eD/weD+Z9r3v1kRkAFNcVgaVHXywM4d8RAlNDmlL1ueoHB/T5gAOLmgp4HUV4GS6fV3UC3jUjPTcmNJviOljDPsiLcuAOUOjJDHwYa9147Go79J+5amzTj9C0kPpdzoG0jRocsQx2/YEBefh7URPF0KAhTs7qiT6QXxI9/AROwwDGUPV4LqCg2ijc6FFPSM2iQgCeJgUXBGZequI/YcPinkZhvBN2Hl/x87otKfU+iwGWa0LQMUyXek+rorFpHtSFInhZRCQf7V6UrFO/RfPqVNMQOu5CXryN6o0zqMyvDC83yEGx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(136003)(376002)(39830400003)(366004)(53546011)(6512007)(6666004)(186003)(2616005)(6486002)(66556008)(2906002)(31686004)(36916002)(6506007)(83380400001)(36756003)(5660300002)(26005)(8936002)(7416002)(31696002)(86362001)(110136005)(508600001)(66476007)(54906003)(316002)(66946007)(4326008)(966005)(38100700002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0tEbDNEMFdDcUlpMUpaSE9mNXdOaHdnZ0NrUGp1UHU3SWYraU5Xb2NCcG83?=
 =?utf-8?B?Y1R3VGxETjF5WDR6QWZNY1RzQ0NjWktPSDVYSGQ0MGUzUkVaYzczb0h2ZStH?=
 =?utf-8?B?dkQ3SnpaWkRzamUvWW1OV0c3cXI4bWttaGNka3dlVVZLSFIyN1JZYndEWGZB?=
 =?utf-8?B?Nks1YWRlMFlBeXhiZkxjcUQrZmgyeFBHUXNYYnNOTUpqMDdHVlFKcFJJb1c3?=
 =?utf-8?B?MFR4RDYzajBNb3AvV2dmNTdEdVRVSllhK3grWHZxcVRLZjAyblUrUnRMczl5?=
 =?utf-8?B?dUNkbjAvS1pXRHZ2ZTBtOHZXMGQ1UG9kb3VvOGdDckhQMWN5Y2VzMXFhUmpX?=
 =?utf-8?B?eXllTkdaaC9XUVVUdjBTQlhsREhoOUpBak5ldDNITVd0SFR6MWVrcnNLOW9X?=
 =?utf-8?B?TEY2R21Fbjg5ZGd5dWpaWkU2RDhLRGQ1c3htK3JmRjFrc1FOY215N2FQUHlW?=
 =?utf-8?B?STdBem9yUWppTWZpWmdoZ0dsQnd2OXZhU0JNQkt3MXk4MDZFUGxLclhMR2FO?=
 =?utf-8?B?eWpVaXltdnFzazhRbWVaZDRTUUw0U3E2bExhQlF6bWl4UkNpZUtVTFJKOXlk?=
 =?utf-8?B?VndGaThFRFBKbnZobm5BUWdUMXBIcXlaMnNySTFXdVgwaXZqV0ZGa0FacWdu?=
 =?utf-8?B?RWZuQjQ2akhKZ0E1Z3Bad1kzSUhVbVJ1Q0VzcGRuV3kvM3FoNEhDcC8rM2hM?=
 =?utf-8?B?Mkh4Mm5sM2Rvb1M0TSswcHdST3JSNlhwKzJWK0habG5JMDEvRFNRYStBZ0o2?=
 =?utf-8?B?YTJqTG9MYlVXQWUxbnNUanU1UERZa3dwQjBrbWNPa0hnVEtTSUxrclNGS1RD?=
 =?utf-8?B?UEJFQUxqYkJQMlEwY0QxSzF1MFhTTUgyclNXNURvY3NEOFNNd1R6d0VkaU1X?=
 =?utf-8?B?ekpQUldKYUxRMGppazdwb2NKVVhrNXUwbFlkTitNeDMzVVhJb25SajlLcE42?=
 =?utf-8?B?dVZ2aWdhMWhPS2cvOEFnZEJPSGJTM3VCa2M1VGdDcFcxaGxIZUhUdzNQVHVp?=
 =?utf-8?B?dGZKZi9MZjNKZlpiMUxoUGVFbVBEd2pEWFY1YmlvUzd4QTNSWXVqUFhFSkho?=
 =?utf-8?B?TERRdDRLNlAxTkJqMGlsbEpZbjlOV1Z6YkhrRDZoQ3dseklBeVZESEdqNUtV?=
 =?utf-8?B?T1BGcXQ3d3hCOXVvNTc0Zy9rNTNJZ3VrY3VmTFFscGRXNUpIMkNDNkhkeXBU?=
 =?utf-8?B?K1ptbFRDNVhaUmhvKzFPQVkvclE3blhVcWs5TzRFcDJDUU9yRnQ0WHg4RjhR?=
 =?utf-8?B?aVNpQ0YzK0tVRkE4SFVoYTdOR1ZEWmFuaTdlcWNTZS9OMitsYTJKVXV0RzEv?=
 =?utf-8?B?UEhKMmhORjVuYXZjbnRROUdEQi8rbTgra0VnK2xHNjJQaU5mZ1hhYkwxV3JO?=
 =?utf-8?B?MHhCQ29jNTg3VjZFb0FTM0FYcW4wOGE1NitUTnR4cUQyU2oyK2NUQmNFWWNp?=
 =?utf-8?B?Kzk4NmlUMTB1Ym04R3YyMWtlR2RWaUsrY3Z0UkREQXhjVnNZY2RiZTJaeWsx?=
 =?utf-8?B?QlgzZEtiZlJFZGx6MjRUREpGZzFRbWpJWXFnWi8wUGZ3QVZlOXpnRjhnY1Ns?=
 =?utf-8?B?RXFRNkFqUVRBcEtBdWJDU0dZQXJhRXBxNW1nRjByQTNheTJHdWk0V1ZEeWxk?=
 =?utf-8?B?bmxhNk9saUNJbDdEL0wwczlEak9XcmFmMWg4bjdHWjZHdG5vd1VCQThOcXl4?=
 =?utf-8?B?UmVZcjRIbTlUM1Z0Zk50R01FeEhWa0FOaEppVVJ6QVlGY05RMzlOMHJ4ejlI?=
 =?utf-8?B?RVI0NGdaMEtTK21Oenc0M2NWUWdsaFROUDdkcEkvY2grUEpHSEZxN0svdHFs?=
 =?utf-8?B?VFZZdE9FeFVwb0I4a1pPNTEzd0FxUUMvSWdESmhhNEZ0TmZyNmp0MEVRa3Fp?=
 =?utf-8?B?LzJpeHVqdURFcS94WGc5RnZGbDBBb3lXWHdxRG9MV2hkWGQxZk0ySlhNckRk?=
 =?utf-8?Q?4IIezCgrJsfgN9J5yvojQgThMmtoHAgx?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a48ab20b-f117-47af-89ea-08da027c995a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 09:59:00.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Es6NOMr1+cDYALDtnh1TROB+lpsBUEVigbxhRdedJ8ahaIYZVfD3YoD9EIoCErpl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2852
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[bringing this threadlet back to the lists, hope that's ok]

On 2022-03-10 09:27, Nicolas Ferre wrote:
> On 09/03/2022 at 12:42, Peter Rosin wrote:
>> On 2022-03-09 11:38, Nicolas Ferre wrote:
>>> Hi Peter,
>>>

*snip*

>>> One of my colleagues had an idea about this issue and in particular with
>>> the fact that removing some of the entries in the structure triggered
>>> the problem: "isn't it some kind of misalignment between structures that
>>> are supposed to be treated in 64 bits machines and our 32 bits core that
>>> we use?"
>>> This misalignment or "wrong assumption" of using 64 bits machine might
>>> be present in the USB stack as it seems to be related to this sub-system
>>> somehow.
>>
>> Yes, something like that has been creeping around in the back of my
>> head too. And it could be something much later in struct device that
>> is no longer sufficiently aligned when struct dev_links_info changes.
>> But what?

I verified the alignment of various things. With the old working
struct dev_links_info, i.e.

struct dev_links_info {
	struct list_head suppliers;
	struct list_head consumers;
	struct list_head needs_suppliers;
	struct list_head defer_sync;
	bool need_for_probe;
	enum dl_dev_state status;
};

I get

sizeof(struct device)           440
sizeof(struct dev_links_info)    40
offsetof(struct device, links)   80
offsetof(struct device, power)  120

"power" is the next member after "struct dev_links_info links" in
struct device, and I find no other uses of struct dev_links_info.
With the new problematic layout, i.e.

struct dev_links_info {
	struct list_head suppliers;
	struct list_head consumers;
	struct list_head defer_sync;
	enum dl_dev_state status;
};

I get:

sizeof(struct device)           432
sizeof(struct dev_links_info)    28
offsetof(struct device, links)   80
offsetof(struct device, power)  112

Which means that everything around and within dev_links_info is 8-byte
aligned in the same way in either case. The exception being that
"status" no longer shares 8-byte space with "need_for_probe" (which is
gone). But that should only make things better, no?

That combined with the test with this permuted version (swapped two
list_heads in the middle):

struct dev_links_info {
	struct list_head suppliers;
	struct list_head consumers;
	struct list_head defer_sync;
	struct list_head needs_suppliers;
	bool need_for_probe;
	enum dl_dev_state status;
};

which displayed a new failure mode (BUG instead of corruption, see
upthread) indicates that this is not an alignment issue. Famous last
words...

>  From that article:
> https://lwn.net/Articles/885941/
> 
> I read:

> "Koschel included a patch fixing a bug in the USB subsystem where the 
> iterator passed to this macro was used after the exit from the macro, 
> which is a dangerous thing to do. Depending on what happens within the 
> list, the contents of that iterator could be something surprising, even 
> in the absence of speculative execution. Koschel fixed the problem by 
> reworking the code in question to stop using the iterator after the loop. "
> 
> USB subsystem, "struct list_head *next, *prev;"... Some keywords present 
> there... worth a try?
> 
> Regards,
>    Nicolas

gr_udc.c is not built with the config that is in use, which is sad because
it looked like a good candidate.

Cheers,
Peter
