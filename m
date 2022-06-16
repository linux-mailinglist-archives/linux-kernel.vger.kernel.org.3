Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A1C54DB8D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359298AbiFPHao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359278AbiFPHan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:30:43 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50042.outbound.protection.outlook.com [40.107.5.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5CD4FC47;
        Thu, 16 Jun 2022 00:30:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3IHn8DtcHzeU1PBhwLyfxyVE/80H8TvfHp51lh7Zlg3yK+D8jedHqRh0HfYdr6i2KEbkBIiPyh66TGkpY04Qp4cPdPdZO+jQSAgn5JqH9vFWzYux6aL/5Qt1dzPsPYeM9gudF+R7yG/+osO14nOWk6Ga9YUV45uFj4eO5EI6T4o/KzalVfvj+XG/ZEt+2lQLi5U3gDrvlbMzESeuVtLVdmFB2dfRqQBsiH7084xxBO9qu6pFtkvAco/Cj9Sdy53NZqoHPqGd6vjseoTYM5HuJr+tx18m1SADq5j8tUQ+SWWHGbiqwK86uU6XhQOlPvQHsDqjSLy2UVx5ndhSgr01Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YD8pYbmGmAC5FIH+meWEXIyihyhzOQBuKvIzyV+FYw=;
 b=dThoqRQK8Ke0mBISJJfYWwSRSs3zC6oLTOYz9zE7CcExhGz+KPKABJJrZISlC75kaT4JhX3X53H9KB7vUSfNO/X2HuYb8HqnrKJJjgtLRA32RUMyUEC5iFr7m4qJMtW0OaAcmRdxy1U/rO3ITwdQjGTmoPP0tMbrvmMPLUixkt3G4X8QSmjk+dg13A5VrhHVc+bm9yz6LeVtvNx7Ve7WSuL9wmLk+W3gKWMSLOjr4KP10FYti5G8SYCY8/EzPlDYo2TBEHn79sO9cnSFvTZF71iVqUUttGEZMVc7ktJouaUe687MhkhNIM0bs/CJ5U+BlIxBCgUUzOpit+76Z9AJRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YD8pYbmGmAC5FIH+meWEXIyihyhzOQBuKvIzyV+FYw=;
 b=NvDGqsIv2zJx166z5xoEwnxfMrfAt27U/dgKPxYZcpmUQ6+HrxmD2/a8iRQR6Ka85GKGOsg83Uk46IztdpU4sx1IKZbVVl8KZ/OutkupTQNbJa36xbDY1AzaTSLz5A4oGjKBrVAvFBdVZWoROleqHSQ29CNq1dx66gPwfHFi5wg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by DB7PR04MB5083.eurprd04.prod.outlook.com (2603:10a6:10:15::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 07:30:37 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::d5cb:2760:c9ca:4351]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::d5cb:2760:c9ca:4351%5]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:30:37 +0000
Message-ID: <c1e5fb3e-bd87-5a04-3fa5-95fab7c11026@oss.nxp.com>
Date:   Thu, 16 Jun 2022 10:30:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] media: imx-jpeg: Align upwards buffer size
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220530074919.14982-1-ming.qian@nxp.com>
 <0859ab90-4cb4-a2d0-c3af-84a372742634@oss.nxp.com>
 <AM6PR04MB634199B1F0F3C09B8F3FFA16E7AB9@AM6PR04MB6341.eurprd04.prod.outlook.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <AM6PR04MB634199B1F0F3C09B8F3FFA16E7AB9@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0101CA0070.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::38) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 768996bb-f5d7-493c-3ca0-08da4f6a1b71
X-MS-TrafficTypeDiagnostic: DB7PR04MB5083:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5083DA87EE59C20457B3E659CEAC9@DB7PR04MB5083.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIwSbJ6RvRj0fMUWET455ayqNMRIBMaBKcsfCTGffRrUzT164Jpc+dXs/MpVaUomOfEBRLEMCnPAkTmxXyKwS2we3QkqflPcJ2Otc7iB5vZ3qiYW3NvfSQU6qc7545up33KnBJKP7bWQQq2a1QKr6xdfiYVFyI1pia5TSdrFvmj/Fi3SlHGdtLi4LBn8AzSahJOR39OIda4wxRp0s+cWiMKdG+2jyrL+Ztrcfny0L5iQps7Mca3rgyTsUR/+JFFIxM4JLE3hgvvuGwWHPcBFk4orJi6vhevGh1SlbI/MNu7nLiD2PuoUWQBdtJCgsG6WCdDvD245HLD0Y+Ty6R+k3OZhvs/tXxnDnkdgeMWYsWCPZOF4l7vpIGQIljhUEvAQYGtPMSSRNurfx9xOstC21GR7owTJqPv5/fwxncWGJenvbf/MJFbYUuoqeLHtC5Ofs66jWTTFq6NO1NgGu7mxiGwo2KhpEK/ZIwE2Z9YT33DsqD+wtmRui7oU8SgDcx0oOuxfNfhyA2pk1naq0T78L2h++YGLV0fDfJQeSKkm11kvBt/nxByJUoL99/6dgeAtLgAcgCZ88uLSQJnu7sNmrWxPq2zvgNhBth+gYcTAph3cA5U7dnBM6mQu02f/v7RNafgkb5Qi2uXkn2alH8T5tBykmMientCc7hHh5rKMx/7/WAIWdZ87dIQoKlNC1GVJ+d1l2ZHQwRxJ5DafscszUQv3x/uDYCs5EKEOP6yHjEXE/b+0JBETM+sKAbw6aHUqaF/3L1tk7l+ByLdHFE+spz8nrI1sxwCezPvIAFet5gPjj9ev1WDADxDSwAwbjnUlbhLVK7pNdpL7ROGo8FopqHhcQjsQsea7uSYR4WzorFg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(4326008)(2906002)(31696002)(6486002)(966005)(6506007)(31686004)(110136005)(316002)(26005)(53546011)(508600001)(6512007)(52116002)(54906003)(66556008)(83380400001)(2616005)(38100700002)(186003)(38350700002)(30864003)(5660300002)(66476007)(7416002)(8676002)(8936002)(86362001)(66946007)(45980500001)(43740500002)(460985005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG01Um1xRDJlQldSWHpUdG9jMmx1Q1NOeWFzdEphdFZRdkhmbG1tYzNjbVNP?=
 =?utf-8?B?RTRKUEVPaEdCS1o3NENWU05nKy9qalg3ek9tTjE0eU04OVlwVG0xOVJRTkFS?=
 =?utf-8?B?U1Bob3VhdHJiOWpvRnlsblJLS2hWa0pOSlltdWQ4MmFFT25YVDFreVdsYVF5?=
 =?utf-8?B?MWVXa25kWHJSODFzVVh6TVVtRDE0QUpXYkVVQkl2Y2lJYXR3OTZET2h5SDdN?=
 =?utf-8?B?ZG1mMnRNazZTWlhCVm5Cbjd6dno2dlhFZGVaNlArczVvSDhTQ3J6OUpnOWdm?=
 =?utf-8?B?WTBBWm1jelJuQmxHOUp4cFVSaCtiUTZKL3RCVmhKUkEyUkFqSjZhZ1I0Z3Zj?=
 =?utf-8?B?dnh4MEp1S2xaRllGU1BTc1hLZC93ZEw0Y1ZBSDV2dGd1NE5iMjBlUzJxU1l6?=
 =?utf-8?B?Rk5BMjI3d1pLdDJwRm0zbExsMWpwYkhsQVVvbzNTQUUvNlp0NXlZWXpKUU9V?=
 =?utf-8?B?T2RpZnlTMzByM3hoOXRuci9Ld1RGb2Y3eFlna0xmU1dHSURqV2xyNHBzUHMr?=
 =?utf-8?B?Zmx2QzFiYUp3eEpLUHFuNFZSN3N0Z3A3c1A5dklTVDlJSlZzd2tYdVhlNm9v?=
 =?utf-8?B?cnlieEI4aTN5VmVZWUZ5Ykh4S3VqQnFoTWhXTmozYWh5NDN0TVgrWHBsVDdl?=
 =?utf-8?B?ZGxpcFlENFBzQ2NyMzhPMG1ydGEwemVFbk40MmtMNGtrRm1Hd3Q1cXZ5QnRX?=
 =?utf-8?B?VkZiNUFlTFRzTkpaeGtJc2QySnQwMkx2b292RjdWWTRMZ0tVaXgzL3JZMUNn?=
 =?utf-8?B?RXFYTVA1NDNqUGI5VDVtS1ZKTGxhSVZWcGY1bTZoMk9oM2c5TEM3U1ZZYWhj?=
 =?utf-8?B?VTZDdWRKdXpta3FrazgyZGZnWXJOcUJQcjlXS2p3eHpOZmFUeUFGV0ZQd01R?=
 =?utf-8?B?RDV0b2wraGdwK3QySzFsYlQyNE40RUVWc21qeVZqVFBTRnVuT0xLYktVVERz?=
 =?utf-8?B?bU0waC9KWHU0d3RKNGw3UGswTUtjOXhwUDhQME5SNjBDM2xFQWdlT2ljdlQ1?=
 =?utf-8?B?dEZwQTV2cVdaVUpwZEY5eEpEeTBnbUhEYkdmSlI0ejFPZmUrbW1mR21ESXVY?=
 =?utf-8?B?VkZvMlpIRHk1dkJXSUUxbVUzcXFqVWVrODUzOGJQME1PdXY5MkYybXNMVVBT?=
 =?utf-8?B?bzZ5VUxyK3NGRlFBUmV5M215SmR0dlcwT25hY0I1NGxZbnR6UWZSUzgrVGpJ?=
 =?utf-8?B?WGI1cEdTTk9EZnIyQ1V0TmNMOXdQSkZTOWwyNlJpNnBOUHNaSmRaelQxWnF1?=
 =?utf-8?B?czBDWDRUb21GUFI4cFJGUjlJVWpXYkdlRzI5bmdaM3AxS09HZ29HVWJzYnJj?=
 =?utf-8?B?UGtNRlRHYjN0aHJlL0VtcDhRYU13SjZSN1NnQTRLclBqMVdvcHdCQlE3SXFM?=
 =?utf-8?B?WGxnbVNPcFAweW5kbExJdGRpVElZSTMydXYyek1hWTE4QkZzMjIyYVRXb21X?=
 =?utf-8?B?RWd4QkdrWmJVTTVRb2tVWUsyc0N1Ky9zUCtoakNHVnpYdmlRTGZvaXY4VzVU?=
 =?utf-8?B?M1N5blVRdkltYWNvd3p1RmJtcmpUYmFQUGpjTkg1RXZyTm9PNUJlbXpuUlVk?=
 =?utf-8?B?RXVuNHo1bDAweG4rUE1yYWtqb0pTNW5vZUxIMmp4K3JtaGRyTXc1TXFydmNG?=
 =?utf-8?B?ZWxPK2VLWW9LZkxUYStIUndZOWlkb0ttcktFUDBlVnB0YS9QanZwYlVKcGVr?=
 =?utf-8?B?K0gyVmZ0ZFlMMUFNT0EwRmwxQndKQnRtT1BaZnBxRXVFWTVKUXB4c1JiRzFG?=
 =?utf-8?B?eDFQbGdZdE14NFVPTm16eGNMVS9CejdDT3dVODA2RXJ6VU80WXd0RzgvMWJN?=
 =?utf-8?B?MDNGZUcrVk0vOWVWdGIrT0lCeU1HT2JuQ2dOUldWTEdkTGdPY1RtY0RJZTVD?=
 =?utf-8?B?Sk9GaXFEZXZzQ3pWUGYyVDBGRU5PaGRaTVcxbmM0WFpNbkpTKzhrZC9OOEFm?=
 =?utf-8?B?cy84UkE5dy9FajhBRFRsNTMvSU9SMStQeFNPTGVIREwwVWVmZmxvdVdlaVlS?=
 =?utf-8?B?NDZ0cTVMS3R2L1lZWTROUXlZYmlUelo2YXpXVGt3VXpWL1o1YkwyU05XRS9R?=
 =?utf-8?B?ZkREMzhkeVFxajJpa04rNVc4ellPaTZYOFdOYzJ4TVFxV0FJT2Q0VEdCMm05?=
 =?utf-8?B?SmdnbTNVSU84aHRJNW1sV1JKcUVWS0lseE1kSEpseWh1RFVXNGNxalVXZmdY?=
 =?utf-8?B?Y1UxaURzamFWN3RMM1k5YUNGL3VJVG5xZ1RSNDNhQUxiazVqckJDVjRNanRt?=
 =?utf-8?B?Rlphbk93K1hqKzF5cVBIb3EyTTNpbGxPQWJWQTVOdFljb1JBN0RXNW9LNHpZ?=
 =?utf-8?B?aExGeUNGMFI0czVpYlpYTEFKcUNaaUxMUlVISkNkTC9CbXFYWXkvVGpsRThp?=
 =?utf-8?Q?eyri9TYD5qASbqtM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768996bb-f5d7-493c-3ca0-08da4f6a1b71
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:30:37.4692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ss0csJlR7UnSx5tXdLqcc9YcVgNaE3sQx9ysOt2RRZaXXJ917m5bOxqWLLGXKuKCMzdx0VSAg5HWCJLdboAAxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5083
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On 13.06.2022 08:25, Ming Qian wrote:
>> From: Mirela Rabulea (OSS) <mirela.rabulea@oss.nxp.com>
>> Sent: 2022年6月13日 6:56
>> To: Ming Qian <ming.qian@nxp.com>; mchehab@kernel.org;
>> hverkuil-cisco@xs4all.nl
>> Cc: shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
>> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
>> linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH v2] media: imx-jpeg: Align upwards buffer size
>>
>> Hi Ming,
>>
>> On 30.05.2022 10:49, Ming Qian wrote:
>>> The hardware can support any image size WxH, with arbitrary W (image
>>> width) and H (image height) dimensions.
>>>
>>> Align upwards buffer size for both encoder and decoder.
>>> and leave the picture resolution unchanged.
>>>
>>> For decoder, the risk of memory out of bounds can be avoided.
>>> For both encoder and decoder, the driver will lift the limitation of
>>> resolution alignment.
>>>
>>> For example, the decoder can support jpeg whose resolution is 227x149
>>
>> I doubt 227x149 is working. I have tried 127x127, with your patch applied,
>> both on encoder and decoder, the image does not look ok. The
>> 126x127 seems to work. Having an odd resolution seems strange, I see not
>> even gstreamer supports it (tried videotestsrc & filesink with BGR,
>> 127x128 produces a 128x128 size).
>>
>> We need to gain more clarity on this one.
>> And when we do, if we really can support any arbitrary resolution, from both
>> the jpeg core and wrapper point of view, we have stuff to clean up.
>> The assumption that I started with was, as stated in the comments:
>>    * The alignment requirements for the resolution depend on the format,
>>    * multiple of 16 resolutions should work for all formats.
>>    * Special workarounds are made in the driver to support NV12 1080p.
>> With h_align/v_align defined in mxc_formats[].
>>
>> Regards,
>> Mirela
> 
> Hi Mirela,
>      I think you are confusing picture size and buffer size.
>      In this patch, driver will enlarge the buffer size to align 16x16. But let the picture size unchanged.
>      And if you display the decoded 227x149 picture directly on imx8q, you may meet some drm error, and the display looks abnormal,
> The error message like below:
> [   36.381015] [drm] [CRTC:38:crtc-0] dpu_crtc_atomic_flush: wait for content shdld done timeout
> [   36.389630] [drm] [CRTC:38:crtc-0] dpu_crtc_atomic_flush: FrameGen requests to read empty FIFO
> [   49.469022] [drm] [CRTC:38:crtc-0] dpu_crtc_atomic_flush: wait for content shdld done timeout
> 
> But if you save the decoded picture data in to a file, then check the data, you will find it's correct.
> And if you treat the decoded buffer as a picture with resolution 240x160, and with some padding content, it's also correct.
> 
> So in my first patch, I let the driver report the aligned resolution in g_fmt,
> and implement a g_selection to report the actual resolution through the crop info.
> but this solution will fail your labgrid jpeg test.
> 
> So I choose the current solution that keep the actual picture size, and align upwards the buffer size.
> 
> The display of 227x149 is abnormal, I think it's not the jpeg codec's limitation, but the imx8q drm's limitation.

I did not try to display with gstreamer. I just tried to generate some 
test files. For example, this one:
gst-launch-1.0 videotestsrc pattern=smpte75 num-buffers=1 ! 
video/x-raw,width=227,height=149,format=BGR ! filesink 
location=bgr_227x149.raw
generates a 228x149 file, not 227x149, with the 228 column black 
(padding?). For visualizing, I used vooya, on host machine.

I then tried the pattern generator: https://github.com/NXPmicro/nxp-patgen
./patgen.exe -pix_fmt yuv444 -p colorbar -vsize 227x149

This generates a raw yuv444 227x149, without padding.
I used the unit test application to encode it.
The resulting jpeg is reported by JPEGSnoop to have Image Size = 
227x149, and it looks bad, every line is shifted, as if it would have 
228 width.
I did not check yet to see if any adjustments are needed in the unit test.

I'll send you my test files.

Regards,
Mirela

> 
> And in my opinion, I prefer the first solution that implementing a g_selection to report the actual picture size.
> If you can accept that changing your labgrid jpeg testcase, I can prepare a v3 patch to switch to this solution.
> 
> Ming
> 
>>
>>> the encoder can support nv12 1080P, won't change it to 1920x1072.
>>>
>>> Fixes: 2db16c6ed72ce ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG
>>> Encoder/Decoder")
>>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>>> ---
>>> v2
>>> - add Fixes tag
>>>    .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 88 ++++++++-----------
>>>    1 file changed, 37 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>>> b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>>> index c0fd030d0f19..9a1c8df522ed 100644
>>> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>>> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
>>> @@ -894,8 +894,8 @@ static void mxc_jpeg_config_enc_desc(struct
>> vb2_buffer *out_buf,
>>>    	jpeg->slot_data[slot].cfg_stream_size =
>>>    			mxc_jpeg_setup_cfg_stream(cfg_stream_vaddr,
>>>    						  q_data->fmt->fourcc,
>>> -						  q_data->w_adjusted,
>>> -						  q_data->h_adjusted);
>>> +						  q_data->w,
>>> +						  q_data->h);
>>>
>>>    	/* chain the config descriptor with the encoding descriptor */
>>>    	cfg_desc->next_descpt_ptr = desc_handle | MXC_NXT_DESCPT_EN; @@
>>> -977,7 +977,7 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx
>> *ctx,
>>>    				      &q_data_cap->h_adjusted,
>>>    				      q_data_cap->h_adjusted, /* adjust up */
>>>    				      MXC_JPEG_MAX_HEIGHT,
>>> -				      q_data_cap->fmt->v_align,
>>> +				      0,
>>>    				      0);
>>>
>>>    		/* setup bytesperline/sizeimage for capture queue */ @@ -1161,18
>>> +1161,30 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
>>>    {
>>>    	struct mxc_jpeg_ctx *ctx = vb2_get_drv_priv(q);
>>>    	struct mxc_jpeg_q_data *q_data = NULL;
>>> +	struct mxc_jpeg_q_data tmp_q;
>>>    	int i;
>>>
>>>    	q_data = mxc_jpeg_get_q_data(ctx, q->type);
>>>    	if (!q_data)
>>>    		return -EINVAL;
>>>
>>> +	tmp_q.fmt = q_data->fmt;
>>> +	tmp_q.w = q_data->w_adjusted;
>>> +	tmp_q.h = q_data->h_adjusted;
>>> +	for (i = 0; i < MXC_JPEG_MAX_PLANES; i++) {
>>> +		tmp_q.bytesperline[i] = q_data->bytesperline[i];
>>> +		tmp_q.sizeimage[i] = q_data->sizeimage[i];
>>> +	}
>>> +	mxc_jpeg_sizeimage(&tmp_q);
>>> +	for (i = 0; i < MXC_JPEG_MAX_PLANES; i++)
>>> +		tmp_q.sizeimage[i] = max(tmp_q.sizeimage[i], q_data->sizeimage[i]);
>>> +
>>>    	/* Handle CREATE_BUFS situation - *nplanes != 0 */
>>>    	if (*nplanes) {
>>>    		if (*nplanes != q_data->fmt->colplanes)
>>>    			return -EINVAL;
>>>    		for (i = 0; i < *nplanes; i++) {
>>> -			if (sizes[i] < q_data->sizeimage[i])
>>> +			if (sizes[i] < tmp_q.sizeimage[i])
>>>    				return -EINVAL;
>>>    		}
>>>    		return 0;
>>> @@ -1181,7 +1193,7 @@ static int mxc_jpeg_queue_setup(struct
>> vb2_queue *q,
>>>    	/* Handle REQBUFS situation */
>>>    	*nplanes = q_data->fmt->colplanes;
>>>    	for (i = 0; i < *nplanes; i++)
>>> -		sizes[i] = q_data->sizeimage[i];
>>> +		sizes[i] = tmp_q.sizeimage[i];
>>>
>>>    	return 0;
>>>    }
>>> @@ -1381,11 +1393,6 @@ static int mxc_jpeg_parse(struct mxc_jpeg_ctx
>> *ctx, struct vb2_buffer *vb)
>>>    	}
>>>    	q_data_out->w = header.frame.width;
>>>    	q_data_out->h = header.frame.height;
>>> -	if (header.frame.width % 8 != 0 || header.frame.height % 8 != 0) {
>>> -		dev_err(dev, "JPEG width or height not multiple of 8: %dx%d\n",
>>> -			header.frame.width, header.frame.height);
>>> -		return -EINVAL;
>>> -	}
>>>    	if (header.frame.width > MXC_JPEG_MAX_WIDTH ||
>>>    	    header.frame.height > MXC_JPEG_MAX_HEIGHT) {
>>>    		dev_err(dev, "JPEG width or height should be <= 8192: %dx%d\n",
>> @@
>>> -1748,22 +1755,17 @@ static int mxc_jpeg_try_fmt(struct v4l2_format *f,
>> const struct mxc_jpeg_fmt *fm
>>>    	pix_mp->num_planes = fmt->colplanes;
>>>    	pix_mp->pixelformat = fmt->fourcc;
>>>
>>> -	/*
>>> -	 * use MXC_JPEG_H_ALIGN instead of fmt->v_align, for vertical
>>> -	 * alignment, to loosen up the alignment to multiple of 8,
>>> -	 * otherwise NV12-1080p fails as 1080 is not a multiple of 16
>>> -	 */
>>> +	pix_mp->width = w;
>>> +	pix_mp->height = h;
>>>    	v4l_bound_align_image(&w,
>>> -			      MXC_JPEG_MIN_WIDTH,
>>> -			      w, /* adjust downwards*/
>>> +			      w, /* adjust upwards*/
>>> +			      MXC_JPEG_MAX_WIDTH,
>>>    			      fmt->h_align,
>>>    			      &h,
>>> -			      MXC_JPEG_MIN_HEIGHT,
>>> -			      h, /* adjust downwards*/
>>> -			      MXC_JPEG_H_ALIGN,
>>> +			      h, /* adjust upwards*/
>>> +			      MXC_JPEG_MAX_HEIGHT,
>>> +			      0,
>>>    			      0);
>>> -	pix_mp->width = w; /* negotiate the width */
>>> -	pix_mp->height = h; /* negotiate the height */
>>>
>>>    	/* get user input into the tmp_q */
>>>    	tmp_q.w = w;
>>> @@ -1889,35 +1891,19 @@ static int mxc_jpeg_s_fmt(struct mxc_jpeg_ctx
>>> *ctx,
>>>
>>>    	q_data->w_adjusted = q_data->w;
>>>    	q_data->h_adjusted = q_data->h;
>>> -	if (jpeg->mode == MXC_JPEG_DECODE) {
>>> -		/*
>>> -		 * align up the resolution for CAST IP,
>>> -		 * but leave the buffer resolution unchanged
>>> -		 */
>>> -		v4l_bound_align_image(&q_data->w_adjusted,
>>> -				      q_data->w_adjusted,  /* adjust upwards */
>>> -				      MXC_JPEG_MAX_WIDTH,
>>> -				      q_data->fmt->h_align,
>>> -				      &q_data->h_adjusted,
>>> -				      q_data->h_adjusted, /* adjust upwards */
>>> -				      MXC_JPEG_MAX_HEIGHT,
>>> -				      q_data->fmt->v_align,
>>> -				      0);
>>> -	} else {
>>> -		/*
>>> -		 * align down the resolution for CAST IP,
>>> -		 * but leave the buffer resolution unchanged
>>> -		 */
>>> -		v4l_bound_align_image(&q_data->w_adjusted,
>>> -				      MXC_JPEG_MIN_WIDTH,
>>> -				      q_data->w_adjusted, /* adjust downwards*/
>>> -				      q_data->fmt->h_align,
>>> -				      &q_data->h_adjusted,
>>> -				      MXC_JPEG_MIN_HEIGHT,
>>> -				      q_data->h_adjusted, /* adjust downwards*/
>>> -				      q_data->fmt->v_align,
>>> -				      0);
>>> -	}
>>> +	/*
>>> +	 * align up the resolution for CAST IP,
>>> +	 * but leave the buffer resolution unchanged
>>> +	 */
>>> +	v4l_bound_align_image(&q_data->w_adjusted,
>>> +			      q_data->w_adjusted,  /* adjust upwards */
>>> +			      MXC_JPEG_MAX_WIDTH,
>>> +			      q_data->fmt->h_align,
>>> +			      &q_data->h_adjusted,
>>> +			      q_data->h_adjusted, /* adjust upwards */
>>> +			      MXC_JPEG_MAX_HEIGHT,
>>> +			      q_data->fmt->v_align,
>>> +			      0);
>>>
>>>    	for (i = 0; i < pix_mp->num_planes; i++) {
>>>    		q_data->bytesperline[i] = pix_mp->plane_fmt[i].bytesperline;
