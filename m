Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3B04D085C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbiCGUdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiCGUdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:33:35 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70111.outbound.protection.outlook.com [40.107.7.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BBF131
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:32:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDnwfqTTg8LeudfQezEQi1qA6LBETP4n9y6hylYgHv1Rm+SYPEDSYrigc4cwfA7rA7oPAPhfOgkgSGcSd29+vFiX0rAvhK5IVeqSdYx3MgHuULZM8ihyxGRN/Ji6/Kk52wwsHTTk2RCTXDZlRTGqajtVbRaQXcfRSjJKB5qhuaSVGgPQ/kqwTyqmGBvF25Fb491z3N35+2XtfOORAilJP9XEmL2wV0PsEzHjqYB4U35XvtFLVCg4ohQ3tFv/cQ2ZyB9n6ofgNQPfZGj1d70ikXR7pOGEIwv2MeR/AGUS19wBxpO+1pSoh6+/sSRnCgCFpmqg39jf6+9xu/mpiQZZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ER52+L7d0/lbZ+lh9Lic5ynuv4o6JSNwBRFOVpIrOxE=;
 b=XlmCFP6rq2hMRh6TthVxLN6Ii02ruOC9l8FqqUYfuu5d6uw0+3waExeRpdkpqvhgPQt8PjiN3gzdQrlI1j7HvFMPiAyIDk32uBpseO6qG0f5TdorpvZsIVfOGyBon6IsF4bs4FMgyDuWcRtTeL/DH2fMDDpG0IR0aYuBNqKg5ITc7xcxfsRjeT6p53uTb8N4UGgta1+3Ldwx2rO/ypcuQMLkJhJ3YF7IdxuInc1qF55LeG0960hXIz/WxMirbcdCa2ZPOv5XIvNGmWsBEC6PNaSTfxtWV8QZDjUIenEWa9bIAN/VnXvfph7TbvFD7RX8g8abobyDe0afh+GSH+pU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER52+L7d0/lbZ+lh9Lic5ynuv4o6JSNwBRFOVpIrOxE=;
 b=cmeWvxoxwQ0A+8MwGUu9lpJaGUzfm3y9x7/6Il8g1ruzjbnJ9OBldNNzZ/RpxaImgI6wLrueYW/xq2NZSw5vdyJ8qlEHDXChjYYHcO6uTuSmLMoohXR+LUR7a+xAKf98h1DMzj6JvXC8NIEV1lADCjkova1rnTxGRLGh2sS4d9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DB7PR02MB5370.eurprd02.prod.outlook.com (2603:10a6:10:34::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 20:32:29 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7d29:dd84:d2bf:a1a0]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7d29:dd84:d2bf:a1a0%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 20:32:29 +0000
Message-ID: <7214ea3d-1445-c0fb-2620-cdc3d6167bcc@axentia.se>
Date:   Mon, 7 Mar 2022 21:32:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: en-US
From:   Peter Rosin <peda@axentia.se>
To:     Tudor.Ambarus@microchip.com, saravanak@google.com
Cc:     alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, du@axentia.se,
        Ludovic.Desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org
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
Organization: Axentia Technologies AB
In-Reply-To: <9e24034e-f586-a721-9031-179601a69abb@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR09CA0076.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::20) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1d2e406-5004-4805-2da5-08da00799935
X-MS-TrafficTypeDiagnostic: DB7PR02MB5370:EE_
X-Microsoft-Antispam-PRVS: <DB7PR02MB5370570FE8A3FA5E4161B8DABC089@DB7PR02MB5370.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +PfO1Qr9n5hTbjnMo9z9p9lgGX4xUrRIxFHdkAs6psF2Qx1q+Lr8qBme4ZEGICIi6M9BxM1Gt9flTcOpUJpjKP3vljoKPQxRqc7YrSI/Vz3jmKQgFbEQml8e+c1rWEvPNabPIq3AATe+ZKsJAsVKuAbJRq15hE+8aITVAC7bF9pwVL/7vJ3z/fbHU9TglB9IGFg34nWcLcqbzQ4LYqfOmmouX1FaqkObWal0IoHm3t72q0dzzFGk3gVp8wFwRDd5pTCl6HTnjygaPE6lbmj+By2IdIEdeshDWbMWLFwnjqPODjl2hha6j8+apdDGl+zwqP/T7AjL0D+0sZS8cjgI45LMmi9iUoCprEirP+MT6t8Ink1DwZ6Bx36OD63GGBkCGT38RtgizmkfgMatAbxZRGxxd/68HGk/pp7/F/qM28BGe4cGlqpe4QXCSQguvkzPFQZohFUk+FV+z7BWZngVt2an8bw/0gT7CJSqtS/aZzdavThO6eSv6JTHB9vHr+OO4dgI1kGT5NncmCYyQJZKfWP0GZsv7LxrArjmn+lOP5RU8nNRHi4pv4W2nBsY58bWqHAo77oL8UkaZ0uF2RTvHe08weVJ5ZMRfLq5vkr3oJMV+be65SRrYdJKSo0Ot4XH8hF5qA5johC4XtsoNUd8fTzVAQE0TUelDLCUCuyD2itT7BXE2uMLMAPjF57Q66/67sIVFvuNkGJG3N+238Q48c7etFRbuNPAZUJPxcTVBCYTFKJXxDXe5NM3V/y5ALRsGAIScKAyYSKkBezv03rRmeFvhphimN4nmCnzl4ymr85q03Qbr9wTBO32WC8lw1Av
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(136003)(366004)(396003)(39840400004)(346002)(36916002)(6512007)(6506007)(53546011)(2906002)(86362001)(316002)(6666004)(36756003)(966005)(508600001)(6486002)(38100700002)(66946007)(4326008)(8676002)(66476007)(66556008)(8936002)(5660300002)(31696002)(2616005)(31686004)(83380400001)(26005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXAxOUxVVjMzN2JHWSsxYWduNHZIclpSVnF1dUhTYzh2VVI5MURHeG8yZERX?=
 =?utf-8?B?MmJmb0VGM2hnM1VCT1hTVCtOMERNanZzVzRjZlA0VmhUWW1HM0p3aGZJcUcw?=
 =?utf-8?B?S3pFUzBwRzFvVzdRUDJtVElFUjJsWkhDN29oaDIzTE9pR0NrR0JjUkd1YWVr?=
 =?utf-8?B?NEdmc3crZlZGTFM5d1Z2eW1oRy81NEdOMTk1Zk1mQ0M3bm01S2xhRVRlQSs4?=
 =?utf-8?B?VHNvbjZ0WGJFN29QWXhIWHBOQzBQTjlBd3N0L1F6VlRzdDk1QmF2eGJlZDlC?=
 =?utf-8?B?ckJaRHYxVVFpY2w2TVlaa0NlZ2k2TnAyWGNhbGpsL1BORWRoN3N6T1d3Mkhp?=
 =?utf-8?B?d05jMnB6NjNIdXNrbWhPTVVtZUdteFBJRnR4V0dLUm5IdmRBeXdwcGg4Rys2?=
 =?utf-8?B?ZW1XLzlGWHM5YU9naGVpd2dqMnhxT01QK2w3cldhbjJiN0Q5VVRiZUJQcDNC?=
 =?utf-8?B?OSsrdThCaldPMm9wdldHNUhDemhDZitNSjA1WGltQnR3Z3gwTHVBRkcvMmow?=
 =?utf-8?B?NXF4d255c1FpQTNDc3Vva2EwV1RZU3BYZjdCYkJYTjV5dmNLMTdlWXRGSkRL?=
 =?utf-8?B?STJXYVRFbUlud21tMGdNMHVoZE1tQWhYTXBPbDdCWUdXNG11MTBzdGNxcDZN?=
 =?utf-8?B?ZHhlOVJTQlVyWUNqb0VrWSszYWNQazlkMC9lbW8ramhTWjkzOEZWZWRtamhs?=
 =?utf-8?B?TVE2NTVXemltMXRnK1RxNWhxRm5WcWljajNGT1BnVTVOT003QUpLSVArU09P?=
 =?utf-8?B?aFluYnFYNXJVUm1tVEdwVDBOOFFUVGoyTEJHL2FCemFqd2xjaXRPSFRjVTRZ?=
 =?utf-8?B?N0pBQWNOVXF1VUE4cHN3YkkwWDI1ZHN5K1o4UlIyVlQ5NUhqVEtZVnBqdita?=
 =?utf-8?B?ZWdRQmNsYlZ1TFZJQVJ2WEFQVzVzYlg4Zy9UOVF5a3VKelBoc1B4TXU4N1Q4?=
 =?utf-8?B?dVJldTFXMmFheDB3VTJTbEZuU0s4WnN2Z0xlL2lYTlhOdmllTjU3czRmZTNy?=
 =?utf-8?B?SWFTTlUvd3F1cDRaSS8wcXRqaWFxTXl5K2JTK045TEh6bnVFenJKSWtDT0Q4?=
 =?utf-8?B?Unl3Y1NHZU92QzF0cFFaVmdhMmJQSzU1TElDYUh0UCtBWTcveS95REFwV2Nw?=
 =?utf-8?B?VDl3b0RlRXRDMCt1dm5DL1IzVEVZZnN6KzZiVXhxa0ZtWms0WVJrajhsbC9Z?=
 =?utf-8?B?K0x4MVhYK0RFM2dTbkE3QlNuQnFGd2dUK01MTzNETk52bkhWV294NDM5S1h4?=
 =?utf-8?B?dFlmaklOVXlEWDFtNlY5UGVaYnlYS1VxY2pOOUxCOFNiSWg2Y1JXWjhVYWxz?=
 =?utf-8?B?VUhKN1RLQnBpR3hoVDFsalJCV1NkMVVBNzlmN25lU0JIa0d4VHlxajRZcUth?=
 =?utf-8?B?T1NSbFB1bXIwOUl5NUwrTXBZV0xPdndsTUFFU3NraUwvbmdCZzFaZDhQTE4v?=
 =?utf-8?B?M1phcTFLVGk5Zm9tS2pPQkpWcXBqZXNRcFc4V3dTT1dYbkZkbDVKMVpZYUVD?=
 =?utf-8?B?cW9ScUVyQW8rMUtobE9GZTZaay9xY2pWaEZzZkNGK3pXdFE1TUJTOVZyVC9J?=
 =?utf-8?B?VWZKRnNwOHM4UlM1b1JwSXN3RklIbFNPTFBQN1ZQc0pmd0VOYUprbmoxMUFN?=
 =?utf-8?B?WmJ0RmRqZ1VaTEp0YzRTWk82SGlqM2d3TTR5bEpMR3k0MGlzdjhWOWZVTG5U?=
 =?utf-8?B?d0R2RjBJbi9ER1VWR0dtaU9OTXV2TUx6TmVHWTR6aVdTRW1HaHNCWVVETk5w?=
 =?utf-8?B?ZTczYTUrMEZlWUZnbGh6aWNnYjA5SEpwbllSdGljRGYybFplL2N0a0lvR3Uz?=
 =?utf-8?B?bGxqOUVIOWhpRm11RDg2ditUbHhmZVpJT3gwU241K1hSOVlDMnZudTM3WEts?=
 =?utf-8?B?UUJHTUVMVXgxeE9GTnVDbHRpSnpGbHNTWGpoc1dnaXNWVWNxN0ZDVE0weFhI?=
 =?utf-8?B?eStqd0xDUW83WU1TZE5KWTgxaUIvelRURk9Zc2RDcVdreFpyWHhHK1N1TGg3?=
 =?utf-8?B?SUVhMlZHR0x3ZTA4Um1kcjhGblBRc3J6VVp1WFN3aUJ4YWx0dlVOT21MTWpU?=
 =?utf-8?B?SU5reFdNWVhTNG1WQU03Z3pIMzc1bGNTYW8xdFh6bWFsMEtEeGcxWHV2Wkkv?=
 =?utf-8?Q?0KLM=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d2e406-5004-4805-2da5-08da00799935
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 20:32:29.0132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImARtDVGk/FWHov2OmPCvPYi+Qwkg04qxDziXDlsv/zro1hb6QweKgRf1KcdqjFS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5370
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-07 12:32, Peter Rosin wrote:
> On 2022-03-07 10:45, Tudor.Ambarus@microchip.com wrote:
>> Peter, would it worth to do on your board a similar test to what I did?
>> I'm thinking whether the source of interrupts matters or not. So can you
>> disable your USB and use a mtd NAND stress test as a source of interrupts?
>> mtd_stresstest together with scp or hexdump.
> 
> That's not a quick test for me, since I don't have modules enabled.
> I have located my SAMA5D31 evaluation kit, and I think I will try
> to get that running instead.

Hi again!

I got my SAMA5D31EK board running, using a freshly built at91bootstrap
and u-boot according to linux4sam.org and using the cross compiler I
have used from buildroot 2021.08, i.e. gcc 10.3.0, then using the
dtb for the ME20 from the original post and the same kernel and userspace
as I have used previously. Now, that dtb describes things that may not
actually be there etc etc, and I will try with a proper dtb as well
tomorrow, so this was just a quick-n-dirty test. I also added mem=64MB
to the kernel command line, to mimic our "Linea" CPU module and get a
bit quicker turnaround in the page cache.

Anyway, with that setup I can reproduce the problem on the EK board.

$ while :; do cat testfile | sha256sum; done
5a939c69dd60a1f991e43d278d2e824a0e7376600a6b20c8e8b347871c546f9b  -
7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
250556db0a6ac3c3e101ae2845da48ebb39a0c12d4c9b9eec5ea229c426bcce9  -
874c694ed002b04b67bf354a95ee521effd07e198f363e02cd63069a94fd4df8  -
7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
c3a918a923ff2d504a45ffa51289e69fb6d8aa1140cca3fd9f30703b18d9e509  -
1577ed72d2f296f9adc50707e0e56547ecb311fa21ad875a3d55ca908c440307  -
7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -


But apparently only if I have an FTDI usb-serial adapter attached
while I boot. I also start to get good hashes if I remove and
reinsert the FTDI adapter, which is interesting.

$ while :; do cat testfile | sha256sum; done
7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -
...
*snip many dozens of lines*
...
7bf74cf37c8bf81ad4f8e86da8eb129a8ae0ee0f5a22ac584ad39233b97acb4d  -

It's of course hard to prove the absence of trouble, but it feels
like it is working from both of those latter cases...

(for the "real" case the FTDI usb-serial adapter is soldered in,
 with no easy way to make it go away, so it is not as easy to do the
 same test there.)

I'll try to reduce the number of local parts of the setup further
tomorrow, such as the dtb mentioned above and the rootfs. I was
hoping for a binary download of prebuilt parts, but some links on

https://www.linux4sam.org/bin/view/Linux4SAM/Sama5d3xekMainPage

are bogus. E.g.

ftp://twiki.lnx4mchp_backend/pub/demo/linux4sam_4.7/linux4sam-poky-sama5d3xek-4.7.zip

What's up with that twiki.lnx4mchp_backend "host"?

Cheers,
Peter
