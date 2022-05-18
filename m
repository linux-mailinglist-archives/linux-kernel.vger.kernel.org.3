Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07C352B440
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiERHvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiERHvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:51:16 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2105.outbound.protection.outlook.com [40.107.20.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C6611A0A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNZZwK5rno1/c2/hWPdcH58zvwZAoJO5m6xwEDakSlTUtmN+YRGzyOmejivPOoxnpdCVXDGeeFeUzpadTeB2XaM+cisMw+vt10HuBoJp56Qc0qFw6Yz2MwrNgHB2DqOAQSadOCi+Qj7je26lUG6JugAD3X/xCNg/aPRqAOkZKpskdpFyTrRfhF0X+xl1MnNiL8oYnpJ7P4N6MiqXJBmjpF7/bBz6pzuAQVEJvmOe+4dd5ndlAhZaLeDzHsISMehle07HcYmiqHW6Gw5UpV/tuj7LBCCu75CTkvh2XHxEnndGOPA2Dl2G4G99g4ltzaZ/WFZKnHPr1czdmReNOP6Mdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORFmSWQqMdomerb4x8TyztuSdOflITwD7qnTa/Fl524=;
 b=J2GrzBow/42CqXNHZv4q9EOqp6eOPVx/6dQZIt31q5fKNJipZHQovC/DBvtqct3pNo9lrKqYkgsGz3NcD0LUNrKff8sQ5wX0kKKYTwV2TJKW2AlDgiWXfOquQ7aNU3toHos0WqqD6/aE6yWrVLXlI8uvw0sCVlJv4mDYnR7KFz1kkUWaOa19wPrgVDAy+NFwwF0G1YQNB86SaA3KmOY0yrx7msRCL8S9N+I7b5qTi7GO0xnvgju0gaALjjhKq8mT6E7bP5CmNDqBlBYHEscWQLCLYgHnpHUw533cK7XecRBaCDUhpgqP1l9/2YrHX/Uuvmf93SS/z89gk4d/BuLegg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORFmSWQqMdomerb4x8TyztuSdOflITwD7qnTa/Fl524=;
 b=OlsZxCH2++6v41qioRxJz7HBIUeS369RMOl9ii4AMTTuT2KnA2YyGAdBbNU4StuJY/1FSE/P+Shgi8HYd/zbvMNbTZ9Czb/AgtPPIaabLBSdJgIjgt2KOHpz4CG+3sxd+EzPrEZ9chiJhqmIarmhlUdHIzS9AJzF/fzW/wC8VoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PR3PR02MB6202.eurprd02.prod.outlook.com (2603:10a6:102:63::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 07:51:07 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::dcef:9022:d307:3e8a]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::dcef:9022:d307:3e8a%4]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 07:51:07 +0000
Message-ID: <c5928610-4902-27f3-7312-e8c85eefad39@axentia.se>
Date:   Wed, 18 May 2022 09:51:04 +0200
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
 <1a398441-c901-2dae-679e-f0b5b1c43b18@axentia.se>
 <14e5ccbe-8275-c316-e3e1-f77461309249@microchip.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <14e5ccbe-8275-c316-e3e1-f77461309249@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OL1P279CA0040.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:14::9) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6990edc4-de6a-4627-afc0-08da38a32a41
X-MS-TrafficTypeDiagnostic: PR3PR02MB6202:EE_
X-Microsoft-Antispam-PRVS: <PR3PR02MB620251A1AA0E14B5F7D32FB9BCD19@PR3PR02MB6202.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pqQrS7M0HTpTGe20kaQaLhFiXiiI+Am+XLzOhxnUe7U8/cymGzBza/joBWY91oTG6Xq4QIrQX8yFt+QutS1F451Dog9b6hgOuQsPmiOgRj8+hb7oXc9szbGTBIcb+JZWABJxq4gKuIcCLA2F5qnonCQ4zNiXLVIzxwElH4rQ4DpLfoqmq9fKRHecr3/hYr8hghGTlX2yDEsOcVd83MY29llN7ugU5i0W+3sgNuBRZ+GLdvHQPP641AK8lws1DVznLzVQbhmIJJITZJk6fKOEtYATSwMSMM0iiQNpDpHE51D4Nxx6RIbRz9Rpxj7R2z0y3ZGQGUOVbwAtFTb+ZuNjB0V4UqUGK3QxPAJr6/qAKz4rNDIbrBSDNYdrHFkBXA660LXjFxjKmU07UKObWWlV+z18hYmENvFayKieFS9LQl0ziJsKQBaTjI4JRvNp7+l6u+cxnD5WQJA4upRDnW/5q+2rqinj3fpDA5rw58AjnT2cipSQV6xqS6aoQS/kcd3Xrv/VM3WjY6OPL0vhIobUjGJsibqjH9vZtsIpPldP7gIkBvVq4SfQ9wSLOxMhVl5Xpw6M+CF/ogPzSgN7wJTe9hrd//tDImqXfYqnIvidR7FMh7olpUPEIz8ndpPH/B7LA59rkZk4iCX3Ey96oTjgeo/jK/40PzSDsH14HvJ11O1cpM2rWPA2cguAAv7mwoaVU+6G/99n+PGsVyr9cplGxpYH//kblAPUoL22S16+Rwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(39840400004)(376002)(136003)(396003)(346002)(316002)(2906002)(7416002)(5660300002)(36756003)(83380400001)(31686004)(53546011)(86362001)(31696002)(186003)(66946007)(2616005)(38100700002)(8936002)(4744005)(4326008)(8676002)(41300700001)(6512007)(6666004)(66556008)(66476007)(6506007)(6486002)(26005)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0h3WTRNZ09DSjZFak12VTh5MEpQdDZEc01LcG03Q1ZScEc5K0h2d2FwbDJL?=
 =?utf-8?B?VUt2eGJENVFLdXZTeEtmOVRESm1RbDNnVStIZ1RORDFMd0tvQTVORDlhYzRs?=
 =?utf-8?B?NnV4Ky8zbnNXZENuekhJN1NyTzhQVStBY2ZCWFVjQkN5a0tIQkxRY244dXVz?=
 =?utf-8?B?NEVaclNhMklHUm9ieHZhdC9WVXZMV09wUXlnU1RPaURybHphRlV2Wm9pTmda?=
 =?utf-8?B?REhmMml4UGw1UGZZY2hqWndSR1Y4bGE1K09tbW9tNytoNDYrajdyOTlsWmFp?=
 =?utf-8?B?bUh0QTVweERhNXBMNG9uU0oxN01VRmpqbzd0cFU1MGxILy9LdFM4d3VQTlhW?=
 =?utf-8?B?bkdESmwvSnJNVU1YVUtmb1hMbmNkdVYzcFdyL2tNbWhhUWdoTHYwbWVWcjBs?=
 =?utf-8?B?bDY0YTJITkRGclFoSzhQMlFVQ0lnNE53eXhOME1ocXFSZWd5VUdZaExGS29v?=
 =?utf-8?B?OUVOQWd1MWZvUVNLNjVLNm1LbEt2QTUzSXBCQW5vYitMUStrY2RtazZNeWxV?=
 =?utf-8?B?ck5CcnJPeEgrQkdqSG9ETjdMY0lFc3RwcUd2YkxUazNtZnB1czVaenJqMG44?=
 =?utf-8?B?MkRJczlRS0hxNE1pRW95NTNKSHdVZDNUODVGODdlOUlaaE1vTmN1SjdyLzJa?=
 =?utf-8?B?UXdjR3hDZlZhUmJUb1lZNDI1YlhtZG5QK0xadFNVdkR4SytnSkVZMFNOZzRo?=
 =?utf-8?B?RzQxWUVJVEJ1VjM5Z3NuQURXcENWZWprV2thSUc5QmZqdENWLzZlWXRFcGVJ?=
 =?utf-8?B?dVdYbVE0aUtMQ0lFRXJacEN6Mlc4SWNCUzhBQjNwcnBqeENVM0tOS3QwTnFZ?=
 =?utf-8?B?ZGhYM0gxR0x6cVRKQ1l1L1J1TTBvd0w4cG9oeE11dWwyQ3JuUkpjT2VPOXRB?=
 =?utf-8?B?ZW8rbG91Q2R6Vm1WdFg0QkEwRWVJMzlVQ3dxVEtWRVE1aEN5SzJDN0tiSlVG?=
 =?utf-8?B?Q0dQYVZLaENCTldydEIwNWxnZTlUMXJrZm5jWTI2dnA3djhkT20ydm0ySEly?=
 =?utf-8?B?TTlLMHdvWDJlSUpQY3RMYUNOMWlOcnJ1VU1jcnFHNTRXRjBGdUdaZmdFemJ6?=
 =?utf-8?B?cjNndUhFWFlvS1l6RjFBWGthL2RIb0NaTUdWN2x3b1F6WmczUFdBSHJrR3ZM?=
 =?utf-8?B?SnRhMzlJQ3BoNkZLWm9MNHUyY0tZUzNkTk5HLzVGSHNadTVlVElJR1NXK3hD?=
 =?utf-8?B?QXhaZnVyaDRtK3FQYU1JS2M0eDB2bUdwdHVnWGFib2dOUGIzNTFSalM1TE1C?=
 =?utf-8?B?dGVMNCtPbTcrdldGY1hqNUZvSVZQU3RQQXZ2MW9FcUV3NERtUHFuWXhjRVlz?=
 =?utf-8?B?di9GV0d5NzlFZ2hnTVYyNXZaSXExaHU3QThoOHFaSnVjZ0gzdGtUZjBxOEJX?=
 =?utf-8?B?ZXMwaHluZUJlZmdVKzNzWkNxVU9xeFlkMms4QWVWSjVjdlk3WTU2VDRiUDNN?=
 =?utf-8?B?UmNOTVVzTGF4cTIydm1rejhRcHBHOG9XSkZuajFJdW4xVW5hVkdhUFU0d2Jw?=
 =?utf-8?B?UFNvU3VtdjY1N3poUmxvR2Y1NlFWNmpkU2NWbTQ3Z3AwWm4vZWFWdm1ZMVVT?=
 =?utf-8?B?QmVETjZDZEMvdzk4d1lwMXhxQzBmRmU5MmZLVEcyU3ErckRpdnZCbGVIdFpS?=
 =?utf-8?B?NVFvdzJOUExKSWFFNWpOcXp1WnVyNEJQc3hjYThPNGpjTzJMbXVOcEMyZkZj?=
 =?utf-8?B?OVowT3ZQN1g4KzBJMUFNZ1psZmZ2ZTBZcTZ4TVFBeUdmbUxWRVQ4ays1Nmt2?=
 =?utf-8?B?aVM5ZU9HZ3VjQmh3SWNlMFA2UkdROGdKajQ0UGowSUpyK0p0SHpya2k5dmJh?=
 =?utf-8?B?MUNrSXhRRFBRcEFiNWlCbzFNNy9GZDk3QUZpTEpHdDdwT3dza1RyeGZrV2pH?=
 =?utf-8?B?U3UxeFUxT1dXQTFCWTZFQXcvK3pNa3JOYXh6MDhtOFFhc1VYcW9qdjBySVpn?=
 =?utf-8?B?NGZqKzNUQXVyZU9YdkFHRGtwbnZKRmkramJoVzZ4WXhIL3lnejBDbUs0V1Vm?=
 =?utf-8?B?ZjRnOGR5Vk5qREo5UnFiaFRLUGJjQXZaNUp0YjFSRCtWKzR3cnVOVFJ3MDJ5?=
 =?utf-8?B?UG4rc0twVCtKL1Q2c0FFVGtWMHF0TkJWZU1TMnAzR001cGFjM0c4cndleG5F?=
 =?utf-8?B?TTh6T0JmZGt6Z2NSK3hZOFp4SWZuYjBjMGJUVitwNXNaMXJDUzRKOTRMcFcy?=
 =?utf-8?B?OFZ5VzB1aWJ1ekU4MkhiU3ZiVS9sbEpWeWhzUTI4ZERiTWtmWHk3VEpqYVNC?=
 =?utf-8?B?WUFRT1BKMGlubkVEUFZFcnlrMVBFaEgvVmYwMmg2NlA3VWZlOVpSVS9BVUVP?=
 =?utf-8?B?QmFqbGdJTmVTYXk1RjYyMS9adEl5dmpFTWJvcUMxWCtBUnMrbFRRdz09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6990edc4-de6a-4627-afc0-08da38a32a41
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 07:51:06.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ItR/MwW9mjkBWtOpZuil+IKLqXSScDNB+L/ZpBqoobJG4KMhKYpdSHwgDUhJsga
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6202
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-05-18 at 08:21, Tudor.Ambarus@microchip.com wrote:
> On 5/17/22 17:50, Peter Rosin wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> 2022-04-11 at 08:21, Tudor.Ambarus@microchip.com wrote:
>>> There are some concurrency bugs in the at-hdmac (DMA) driver, I'm handling them
>>> and will come with a resolution. Disabling the DMA showed the bug is no more
>>> reproducible.
>>
>> Any news?
>>
> 
> I'm now allocated on this, so I started looking around what has to be done.
> I'm thinking of using virt-dma to manage the channels and the request queues.
> Will get back to you after I'll have something working.

Sounds good, thanks!

Cheers,
Peter
