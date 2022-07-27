Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1E25821C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiG0IIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiG0IIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:08:12 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F0443E5A;
        Wed, 27 Jul 2022 01:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMrhPjT1v39sCXRtuHr5YruJBG4UrOduPaONIN35Rm2uD80JQnmNNlkCUUBjbG4hjcWoU+XbTjbVf7mq/19rWkuxhfzyoPcDePEDgTqKMd9VidPRwUoCwOv0PnHGBL+qmg3yNK7XIYvWgtg+AbTYxloHv1Ds2MPc6RdCn4+qkcCT90rdReFZfULZQZjFEg+vxDNCWX2y2+pGyZdRCWJ7hAuGNhA1ck+hA8RhxnCCZUjuv3Be1tEBDY55PE9EujF49Ov2D3dSGZKrR2IoqdMolj4laN/ToUEzcvOXhe/z2CVY0BmS0TkWlX3fzqq9qNMKmiqON7uOMMDKiOXSAHBeTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1nSLaeOIyPeykErQ04yC2JN9Q4uic4HfLGb9KZ42G4=;
 b=daJfI9pkATYyKRcq5AYXMg1ADvPPUch8EXclO0w/5Ls1E5v0f7Ov/+eAhZyN2zJZ8v/wbs2txss6ZnPsttxBJUE46eb6qxJNN4RhCxgfyyrBLLr/cICm7cmesyyMKaSoGr1JZUCHN8ZhJ3DOJOfBgrwGAFC3KkdWHRIEBHRQSnjQQ1iajM4SyR917P8ldXA9EgkM4o+hRgeybD538jCM49/JkO3Ll9Z1oLj9En4bLbI8Xy2k+kvE6OTkYVBjyXxeucVdwvdAJkrkNGnLPQLIQQ56fHGqbN+GGiev61/keJJBWVpMMD4Dq21oU5Bi3Qdoc4sEWaerUb3H6zT9M1Vacw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1nSLaeOIyPeykErQ04yC2JN9Q4uic4HfLGb9KZ42G4=;
 b=n8HcP36LI3uN+XRwKrFdUe5vVp9CVrfclTpkQFQ4Bek7ihNV46c7Lt63ND3Iy7FgtT4HG8XCSITzbQNwJjWrpJ+P/zjX+3t1ukK/bN4hOsLRB6/anAoSuDadhqWXwM7vlM+gYtHdd5MQAsaNnHpJK034r6euEkBKM4oWMkog38w8wPj16K4UOHqU4qwyfUDuKxVA0QAihbD4bnEWXNDKCPjyUziiN7RNEcyo11qcQL9CAsJWT1Zc/59Z5+Gmlw3W4I4joy0yOUCgHm09dcgJ4Elfvvs6wsF+0o6ZyRuVJ3CLtYYyhuAsrVWyL5eXlwFhRI8eQdDNGRD+hjj/zUo+fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by DU0PR04MB9249.eurprd04.prod.outlook.com
 (2603:10a6:10:350::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Wed, 27 Jul
 2022 08:08:08 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d%12]) with mapi id 15.20.5458.025; Wed, 27 Jul
 2022 08:08:08 +0000
Message-ID: <5c37ee19-fe2c-fb22-63a2-638e3dab8f7a@suse.com>
Date:   Wed, 27 Jul 2022 10:08:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: PM runtime_error handling missing in many drivers?
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20220620144231.GA23345@axis.com>
 <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
 <20220708110325.GA5307@axis.com>
 <4ca77763-53d0-965a-889e-be2eafadfd2f@intel.com>
 <1937b65c-36c0-5475-c745-d7285d1a6e25@suse.com>
 <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CAJZ5v0j0mgOcfKXRzyx12EX8CYLzowXrM8DGCH9XvQGnRNv0iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0381.eurprd06.prod.outlook.com
 (2603:10a6:20b:460::28) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a2c572b-4b52-488b-e133-08da6fa72426
X-MS-TrafficTypeDiagnostic: DU0PR04MB9249:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIzB6IF9DznlXsfzFvL7v1seliyhL3VXZ5H8NCSrtcMaXMOjRLEuEv4CaGYIR67qzGTXciQ/0U0y7CxEwIZF50l5nSlSgQHHVkhoJt1XI7x66ZfIlfYLYVMN+l6cScB4NF7dn0Ntrjb3brI/9fzl0K1maKrk48a+HewEuiDH7Xq/Br5yZXfJAf5y3wHUXC/gFdeAtqQPb7oEBFJd3BjPFZF1Sh2Oyffxi4bBCE2cU8XeJAVhkso8EpjEZ+ephn5B1TtyRGP9ifw3Ll60HAz2wwgfhw3VgsYBAT6/7Vp8Wtb/x9UUt0C65n1Nd1pTh6uqF6P0K1IWLrhZEtgZPixmZXEl44GdSTx776vt4Fz4rtd90hbWPlGGscDtV+N0f+fyWl4UyW7opk+GMHDzW1f8b7elRYtkdzRPYFC+Shsrb0uxjm7Rj4e6U3anCvs46ayhC9mcktiNn8bZARp2/+WuQvWLCr7ErRbYIHO5Od4fxDiVsbkh2tPGlKwVgTDyG/REkrn2hTJetd9OMAFHHG4552Q2oKHahAFFXcjMLodj4GxoICV8yyyCKNxLD7+suoSBkzi6BDkWegjRML3h/mEu3TErItB/RAtZHwdUpbucRwcteoOvQBUV/jVDeG1Xc04ndQZD80U0CHB5SFWNkbvM4OScZ4Mv2Eh2FnsSDQCtUKnbuIJl31rbeu5JTHoGJUUQ7EXtdBd4AlFVuIDMAySb/JGWK9JmBIJ6jmDtPPXYw1RppF+l//DRmzF9J8ZEIETlZuwt6Q34noSrdoH406LRMIWrQkdAI8rIiMnBBPd1jivsW7XuCJmwxCgwDCwwftgU9NNmxyscqXeratFRDRUW5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39860400002)(136003)(346002)(366004)(2616005)(83380400001)(53546011)(2906002)(86362001)(6506007)(41300700001)(186003)(6512007)(38100700002)(31696002)(5660300002)(66556008)(66476007)(8936002)(4326008)(8676002)(31686004)(66946007)(54906003)(110136005)(6486002)(478600001)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2wvMlBiUXd0T091eng4SWxCRVVoZEpERHZwOWVUd08ybmhqRzVKcmovSHZV?=
 =?utf-8?B?dmFUbzltWE5Uc3RLcVpZMHU3Q2pkOHlmcDBvL0toQVlWVkRuQ3pzRFJzTmd6?=
 =?utf-8?B?Ym0wNGJZVzhHcjd4LzU4VUpXWEM4RG94OGxHWUh1MjdvWGpYRnBCL0s0L3Fk?=
 =?utf-8?B?R3AvNFB1YytoR01iYituYUVaUlU3VXg4ZW4vQUN3RjlMcEgreFZkVVZGY3Y1?=
 =?utf-8?B?clo3UThoM1NjY3VqbFl5UTR1aWxLcEhIUFJhSENzK0FmZnBuWTIxdVgvY1Vx?=
 =?utf-8?B?NlA4UXg2cWg2VFdyRzhYNGhYSHBvNTMvbzJVR3NnVnhuUzRkakJVMVlwS2JW?=
 =?utf-8?B?WEQ1OXdCdGsvb2hNMERaZlh0dXhkOUxOelViTU9pLzVZR2NmQ1dtKzJ1OXE4?=
 =?utf-8?B?UWVpVWloWDI5K3pya3V6OGtxQXhSVFBvNFduNGhPVUV3OEJGL2VrbVdXbjZi?=
 =?utf-8?B?eUtmSGx3VU1SSll3UE9UcDhxeWtGalErVm5oNmNtUU1VdFNscW9xSTNxa1Fo?=
 =?utf-8?B?WUFqcHBqUW1qMExxOWNhYkplakRaZUZ6Rm12a04xbXowTy9TR0lHY0QxMkxv?=
 =?utf-8?B?alYxeElVd1luN3AwK0s2T3JqS25xWTVuRmQreEF2UTRpRnQ3dFAwM0ZyMzU1?=
 =?utf-8?B?NmdjbEZrUHMxUDdSbFJKTWdjeW1aV0xNOFQ2ejBSNjRLa0FDWFZtMzAxOEMx?=
 =?utf-8?B?c1pLbCt5Tkw1NFVKc2h1Y2hhV3pmUGpIU2tUMitOOGg4alVNaHZTbW9xT1Z3?=
 =?utf-8?B?R3BCL3N1T0ROM3lsR3A1NFJlQzJaK295L0NGNDVoazBqU3R2L0xqVjI5Z2dV?=
 =?utf-8?B?Z1NBZjIxOHF6UTI2TlF1SVJmREhTZ2NRZzg3d0pzWXc1UTUzbnJyL0pmNFM1?=
 =?utf-8?B?UWlpOGdMVFF3VlNqYS9FUmNyemI4RnAweU1uNENNUjRENkxRd1NUaHhmNkRS?=
 =?utf-8?B?S1puVndzUTB4aG9ydVFGemNLeW1JZVVJYTVYL0pCRlZHVVU4RTAydFhjL1F4?=
 =?utf-8?B?SmIrUlFLbEtsaHFqblBqSUM0UHFIQ01aWHZSRkRjdS85Y2lSMCtwblgxVyt3?=
 =?utf-8?B?SGt6eXIrYllVSFhjRGdDK0E4Y0lpL2ZUc3pQc1gvQlo5RVQ4NDlkOEZGRmZs?=
 =?utf-8?B?cDJtNFhiaUpadlVIWGwwK1FWdEtPVFBXU0lienBIUTBORHI1T0NBY3JKNkJl?=
 =?utf-8?B?OGxBQzE0TFdnallTWi80MXV6eWRJalBFVXhmYW5UT21GenYwTUtwTXJBZlJP?=
 =?utf-8?B?ZTJ4b2ZQalpXbzE3TExiWEdjV0dyVldCTVZvUjZrT1lNVkR2RTVMVjFiSjFW?=
 =?utf-8?B?K1lsY3UzK0dZc0hYcC9BaDUvaDB4Y1RKTytnQVpYaUJhZEg0a3gyeE9icFhE?=
 =?utf-8?B?d1BZM2dJc0JKbFZ4UEo1d1lZenN1MjZHMXV2VnV3VXhBczNka1lPWXJlTTB6?=
 =?utf-8?B?Tk0xZWNIUWE5eGgvTDhBN0R5RFNjTG5kNUwxTU1wUTJEVUN5UmNxWU5TQWlR?=
 =?utf-8?B?WlRValhoMXhpbkllNmZaNjZvYVV2NG5oZE9xZDhXY2tPcE1kNnF5K2x6UE16?=
 =?utf-8?B?Ti84eFBaN25TSWgyay8yb1kzTjUvbHFVVUs2WVVlTmNhSTltRXJIbkJTQ092?=
 =?utf-8?B?S25DcVFGWHdXTkF5aS9qVENnK1NGNlN2WEZVdUxSUE55OWdsL0JYbDd5Uy9x?=
 =?utf-8?B?VDRHQzJMWUJKbWJ3Ti9KMFZSWU90THVBaEV5SDJwdkdUMS9mWS8wUXBXalFv?=
 =?utf-8?B?OFZTZWxXbm1kM2tQZkhyRE9uMFNRM2hueER2djJDZHRKOEswdFVmaElSeEY2?=
 =?utf-8?B?OFE1UnFXOWxwczJUL0FjNXVMMm1sUElSYkxucWdhbUFFZ2ZXS0creE5UWTNL?=
 =?utf-8?B?ZzlldDhDZ0RNMWNmbVprYmdjU0RwT20wUHJpSjlCUklrZHVGcGFiWUI3MCsv?=
 =?utf-8?B?czFOMWpiYnF2c084dEU4S1UweFlsSGRSc3F1aEFUWFhqMG9zeE1ZVXdEVEFP?=
 =?utf-8?B?Y2tCc2xLMDVnY21iWkdXcHk4b1dqdjVrNmlzZDlyNGlYS3FJRWJ1d01GVURt?=
 =?utf-8?B?cVF5dzJsWGwvalZNMjZMc3BOcUVPZFU0RHAvUzBIWHl1Mk9QYUpGTE5QVEZi?=
 =?utf-8?B?YlAyZW85QUt4Mm1ZQmhFMTRZQ0lhdXlXMDFScWdUS092dDRjdWlHejdEZGFG?=
 =?utf-8?Q?n5BebVtqjIpuT58oVXDV5OBvT2WlC3TiawzgdKnpxL+c?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2c572b-4b52-488b-e133-08da6fa72426
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 08:08:08.4658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RXPHvmZkIjNnB6cgQ/3JqnUOVu2+d0dwriRfCbkFSdk++SrtBmyU6a9EXJMSPfOEEasjGks726/w5ONh9UXQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9249
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.07.22 17:41, Rafael J. Wysocki wrote:
> On Tue, Jul 26, 2022 at 11:05 AM Oliver Neukum <oneukum@suse.com> wrote:

> I guess that depends on what is regarded as "the framework".  I mean
> the PM-runtime code, excluding the bus type or equivalent.

Yes, we have multiple candidates in the generic case. Easy to overengineer.

>>> The idea was that drivers would clear these errors.
>>
>> I am afraid that is a deeply hidden layering violation. Yes, a driver's
>> resume() method may have failed. In that case, if that is the same
>> driver, it will obviously already know about the failure.
> 
> So presumably it will do something to recover and avoid returning the
> error in the first place.

Yes, but that does not help us if they do return an error.

> From the PM-runtime core code perspective, if an error is returned by
> a suspend callback and it is not -EBUSY or -EAGAIN, the subsequent
> suspend is also likely to fail.

True.

> If a resume callback returns an error, any subsequent suspend or
> resume operations are likely to fail.

Also true, but the consequences are different.

> Storing the error effectively prevents subsequent operations from
> being carried out in both cases and that's why it is done.

I am afraid seeing these two operations as equivalent for this
purpose is a problem for two reasons:

1. suspend can be initiated by the generic framework
2. a failure to suspend leads to worse power consumption,
   while a failure to resume is -EIO, at best

>> PM operations, however, are operating on a tree. A driver requesting
>> a resume may get an error code. But it has no idea where this error
>> comes from. The generic code knows at least that.
> 
> Well, what do you mean by "the generic code"?

In this case the device model, which has the tree and all dependencies.
Error handling here is potentially very complicated because

1. a driver can experience an error from a node higher in the tree
2. a driver can trigger a failure in a sibling
3. a driver for a node can be less specific than the drivers higher up

Reducing this to a single error condition is difficult.
Suppose you have a USB device with two interfaces. The driver for A
initiates a resume. Interface A is resumed; B reports an error.
Should this block further attempts to suspend the whole device?

>> Let's look at at a USB storage device. The request to resume comes
>> from sd.c. sd.c is certainly not equipped to handle a PCI error
>> condition that has prevented a USB host controller from resuming.
> 
> Sure, but this doesn't mean that suspending or resuming the device is
> a good idea until the error condition gets resolved.

Suspending clearly yes. Resuming is another matter. It has to work
if you want to operate without errors.

>> I am afraid this part of the API has issues. And they keep growing
>> the more we divorce the device driver from the bus driver, which
>> actually does the PM operation.
> 
> Well, in general suspending or resuming a device is a collaborative
> effort and if one of the pieces falls over, making it work again
> involves fixing up the failing piece and notifying the others that it
> is ready again.  However, that part isn't covered and I'm not sure if
> it can be covered in a sufficiently generic way.

True. But that still cannot solve the question what is to be done
if error handling fails. Hence my proposal:
- record all failures
- heed the record only when suspending

	Regards
		Oliver

