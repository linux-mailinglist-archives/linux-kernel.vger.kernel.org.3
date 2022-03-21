Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2184E2E43
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351349AbiCUQnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351368AbiCUQmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:42:53 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E3E103D97;
        Mon, 21 Mar 2022 09:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyMUlrWR7Fs/sdB0piDS7AOHqJWJT0wQjqUaIOXUYpX2P/cAaZgvq4r5/UdsHyGiyzcGPzvD3o+b70dSdFpTGuYc1xqit+6yxIx0n1j64vaHn5+D+t0vU1c0I4q8WzXhv16T4d6IcLyWRzV7WjtHZLNaJzqx8O+ivupqNwJTy0GYQEFKbvYrOL5BN46AiBuO+TyfeIfdI8F0qjts4j8Kjwpa5VHfiKJ8CJ6NrUNd1ZOxDXl7U4K+Cxd3hiJgve15r4/j5wiatOv30YOdysbl1qUpgjzj51aGoW09T3cvy5YKzrJR5upOWtw6k+OY+OwYcCY5HcpKbnb+mr4elydt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB07LRIDCKDOmNN6cGIr4xqHqwEpsD/QNdBa1C+rvXA=;
 b=PRLg6OfLO/zRjGwbZQWAYXzO3RNm9qXd6Az+DaYhzPkuVqgHi7N+i72OCD0th6xw2PHip23dm3hrKT6wg13lM9XzWHy3Yijlp0VW5XYuxR4yQCRDXJDd985FfkoTopNYJzYb7zTkxM251C78TkrrpJ38at2Mes5oDRRQMYpkxBzT/8F22doIOyRmE/OzwSZCXCJ9yPLLzQqyJYLWmzLoVjUqK8H5WdwKMolzL3gqdgLRZ23IpBvqgYtS9XAyOdyMZiRG96SygV4Hp8/Z4SBZSnGWDWJFO+vmFla55renCADKguhx8zswaBTjhaUaFRf4vU098nbxBLPKy68qYlK/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB07LRIDCKDOmNN6cGIr4xqHqwEpsD/QNdBa1C+rvXA=;
 b=dQdza3c2VVMaQIybBtVfcpgim3DrSwfKOS9oxW9HjiunCnsbx6HyRHevXhst/prH/f2Plj5QhZxsNa/91NoOVdjkdNxeg94HJKmIdnjkqQSE01HgIN1ZKiwuu83u/04wex3FCqdAaLlboV/Z08cuZLsMO+yGia84WXDewpyg0Cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2495.eurprd04.prod.outlook.com
 (2603:10a6:800:52::15) by VI1PR04MB5790.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Mon, 21 Mar
 2022 16:41:24 +0000
Received: from VI1PR0401MB2495.eurprd04.prod.outlook.com
 ([fe80::3c05:836b:b977:a027]) by VI1PR0401MB2495.eurprd04.prod.outlook.com
 ([fe80::3c05:836b:b977:a027%7]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 16:41:24 +0000
Message-ID: <659fb73c-525d-cc2b-0512-651f0f5cbef3@oss.nxp.com>
Date:   Mon, 21 Mar 2022 18:41:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/5] imx-jpeg: Support dynamic resolution change
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1647590462.git.ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <cover.1647590462.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0050.eurprd03.prod.outlook.com (2603:10a6:208::27)
 To VI1PR0401MB2495.eurprd04.prod.outlook.com (2603:10a6:800:52::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfa561a9-f3d4-4c93-5af4-08da0b59a275
X-MS-TrafficTypeDiagnostic: VI1PR04MB5790:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5790086FD4CAF5C95173F3B6CE169@VI1PR04MB5790.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRCGXCF4aE07T2qm6bDxZ7RLanp6bOZYY9jt8+r5p+ADgWInQkJ9iC9WhkJyqWDVxwx0AU4fa9ZV3RetbYN5xN1Oa/cHO1Tv+o1G2lKZt+3E1yGAi32bw6Wx28dmB4a8ZxFiFOYrBx9nJ1sx2fAthNyzc6TmdvpKEoqckd0gPV2hSES15b5ucg1OKOF07dH3F1TgbsLli9KRS5rOgQwknlhXB9mJOdFV2OnLAJ51WZ9z31SkWPo24VztDz2takKvpmGCbv9lvzw5FISLHiH1gKCzpgLbLCwHA8PZYSod0QZt67Mb/JI112RG3ZMUT0DrrZnGUkvOcYQpvapaahbcnCDQvOjW0veMzfgMCZOkJoUDImdSpRQvBo6msqBFL0N7slAOuKdk221eRD009fOCmTZe13zHPeygnXFivCxHlq1XF/T0bbcugUh52GnbJuWkeVgpmP14jmPFhmWGUwBgAp8AuT+wvKsRHkkHuvq2SRHhz7mvESvFwI0GOrvujpYzVc8+AtgaekVdXGi9HEcP9EPByRRqX7gUNuefeq4ubn1rGSQBU3wRABdafOPlbybvbFWni98ovtm0RfEfF/AjUhSNp9DhFpUNOEON4S2O6YUGMKPNnBdGRlVYeLhUmf02lxSp3ZTbztxmySoK/Oji5k1/yecR2BPIH4oIcolY1Lc1IiwIIdmw7fJd4QOv67+myabc4aqDFUX2uylb9SWp1KMgGwmD9QoB2HMG+3kIHvILx3ppZxS2MZI96y65wJBdKYDzGjReqchVb9VPBhiABQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2495.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(86362001)(31696002)(8936002)(7416002)(5660300002)(2906002)(4744005)(53546011)(52116002)(6512007)(6506007)(316002)(2616005)(186003)(26005)(6486002)(508600001)(6666004)(4326008)(31686004)(83380400001)(8676002)(66556008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUpycHJUUWEyZE16TDBZbW53czQvM1JOckpRU085cHlidERudmg0OWREcjZv?=
 =?utf-8?B?eDBaUGMvUG80K3VEN1paL0RTRHdUanlWUXBYcTRhY0tlT01Wb3NrbjVPVk93?=
 =?utf-8?B?UVNtaGM5SEJLRFhnY3Vpa2t2cFBsV09DMmRmM0hpM3RlZ1lqY3Z1NnJZRGsw?=
 =?utf-8?B?YkJnemNEMmVnaDluWVZiNmVHZTBrd2tsWFFSSEJjUVY2YlF5V1VNTWZQTmha?=
 =?utf-8?B?Yzdkc2ZCN0NLazVGbzU5TjdOcFMwd0REcTR6ODBPK0JYWG1TTXVneCtLd2d0?=
 =?utf-8?B?VFFxcWE3OVVxZUtHRXFjdEpZR1lsQnFJWVZhNHJHZGhJV3dBNlZLcGM1L09h?=
 =?utf-8?B?MHVGMUR4TlFwSzFpbXBVL2JzMWh3K1RMYmtZNG9oM0JiRFNqR2FKeGlaN0ZJ?=
 =?utf-8?B?cjVHakliWkJ6VGFXZyszeCszVURscnZnUFVEOTJFeTVyUGMxSVhjOEwycDRJ?=
 =?utf-8?B?c1ZNRGhhQkpxTDUxTFpxcWR6R3pzdlZKQkxsVEwxSHBBTjBSYVIvcGw2Y093?=
 =?utf-8?B?bzlPMkJlaGRhaUhrVUVWaVZiQ0NOVnllMjZ1OFd4aWJQa3l0YytHUVYrT21J?=
 =?utf-8?B?YmRLOU5sWTZMZmlFWktJKzlmTFlMTXNVamZ5TkNmOUNaQXFrSkxsU05VMGVv?=
 =?utf-8?B?K0drREVUMUl5L05KU00va1ZMMkhneVlteC9QM1gwRWJZTkUrUXlGUlJEZnpI?=
 =?utf-8?B?Yk5Peko5UHprYjZtd1h1R2l2ZDFZV25MakJzcDhSNll5eGRqRW9hVEs0alVv?=
 =?utf-8?B?eWN3NlNINVBmRVZKeHNiY0c2N0xRWEtzT1cvdEhTWUdValpubXo3dWovQWEz?=
 =?utf-8?B?NmN3TzBmdkpiWGxJcS80R0ZWdjBKWi9mRVJ1M3hKdHFCR2VhSXlqVVNtVGs5?=
 =?utf-8?B?UWFlSUxnQ2hWTkZjS0dSWE9LMWZFUW9EMlJDeW1jZWJEQ0pMTlVCWlRWc3ZQ?=
 =?utf-8?B?S1hCaHN5N1A5b3dlU0RKWGZmSWh6Vi95ODNDcktRMndaMTVmM2JFUURDZDli?=
 =?utf-8?B?VTVkSC9zZ3VZUSs5TTUraU5jc0taaVF0MThLWHlCQ25ZaFh4OWFIbnQvdVdZ?=
 =?utf-8?B?VHdCckJJZ2g4alR5ZXVNOFp5elZvb2lBaVlrbWRCbThGWDFJbFNFTjZFenpn?=
 =?utf-8?B?MTF0QXBaTXcwNXVvSlNORFZPakwwcVNSQVFIeEdUdmtOY0hXODNpKzIzOG5k?=
 =?utf-8?B?R3ozZ29aM09Yc0h4NTRnVjJOWVB2Wk4xTG5UYmNIY3JMRHp1VXU3bVBDdEYw?=
 =?utf-8?B?Y29SdmI0R213Rm9mY0xOTVY4OVg3UFpqK2JkT2VuY0dzaGFNSE5NandmVnF4?=
 =?utf-8?B?Z0M0QmhFeXFjdXBCMCtmWXZPb0NvaHdpQlRnVkx6U0QwYVIzQXVSRjM0V0J2?=
 =?utf-8?B?UzRzeTRzWE4zeVdINS96L210dFgvd09BRjZkeCs3NFlKUTZOVVZSWXdUMjZC?=
 =?utf-8?B?a3BDVlZJM2FORjBFek5VWnVXeFlidzRyRDY0c2s1WnQ2WGkweTFpZ2wrUURn?=
 =?utf-8?B?U05TTExaSy9KaTNuQTdGRkdzQWZJZWlnMG4zcFJRTlQwbDlYSEcrVStsRUtX?=
 =?utf-8?B?SDJJeEQrVEdXOGoxSDVlaU1xMjdtYmhYeE40V1lyamZhR2tORGIyZmp4MUJt?=
 =?utf-8?B?MFNTNm9USzcxRWlSRitFRjh1UktSZlczZkNHT3dxTjI0cFRvMzRIcjRyWkdG?=
 =?utf-8?B?cXB4T0VHYm5zVzIwY3BaTDg4UWJKVU9qU1VjUEphckFyNFNTU1hZY1N1Tk1k?=
 =?utf-8?B?SUJhcmV0bFdEWG1qY2NIbDdVYTBDY3NpT2x6eGFwaDB5Z01tN1JSOGxxdXhq?=
 =?utf-8?B?QmZBalp2aFZVOEZPRmovSWtPQWlPb1dYbUFtR1BVSXlzendnTHN1a2Izd2I3?=
 =?utf-8?B?aWl0cU4xTkZpUWFEdUJzck5WcG8yNm1ibHg2V2JiVzhaM2ZhQm5jaVAzWlBn?=
 =?utf-8?B?c1IvdzBMcnJnWlcyYTc0QktwTmR6a1B0VUVpOHVZOGNldDBZZ1RzVWswUGY0?=
 =?utf-8?B?dCt2RzN4SGl3PT0=?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa561a9-f3d4-4c93-5af4-08da0b59a275
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2495.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 16:41:23.8659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0nl7OSzMbvNqNmkRWhnwRb9jTq1je4kQGfFVBT5P7AsiRSiGopiHfAr63rFj+gftrw0iBZvA1+va26ttHboHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5790
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.03.2022 10:16, Ming Qian wrote:
> These patchset are to support dynamic resolution change.
> Avoid decoding error or even kernel panic.
> Otherwise, the Gstreamer v4l2videodec will fail to decode jpeg
> who is not decoded to yuyv.
> 

For the entire patchset:
Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>

> Ming Qian (5):
>    media: imx-jpeg: Refactor function mxc_jpeg_parse
>    media: imx-jpeg: Identify and handle precision correctly
>    media: imx-jpeg: Propagate the output frame size to the capture side
>    media: imx-jpeg: Handle source change in a function
>    media: imx-jpeg: Support dynamic resolution change
> 
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 244 ++++++++++++------
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   3 +
>   2 files changed, 169 insertions(+), 78 deletions(-)
> 
> 
> base-commit: 71e6d0608e4d1b79069990c7dacb3600ced28a3b
