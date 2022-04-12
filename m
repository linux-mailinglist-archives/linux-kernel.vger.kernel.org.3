Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9554FDD01
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359597AbiDLKtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357330AbiDLKp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:45:57 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140059.outbound.protection.outlook.com [40.107.14.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF2F62BC6;
        Tue, 12 Apr 2022 02:46:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXmf+ilbVgop3qoWpZ3kvjxOAH4tvNMpx1VD7u6/fr/ldbPkqghk7qnDwd0+iqAcIRYC9xREldOXuY+/HboB+n72gv6B1r0zLActdYU/KG53WgnB+yuPGkHh5UdnfBh6NJDK1ygVKRmiL558Lmz6KBIWpxRgOgfy03+H1jqHmR7Ge2YjY7bAgkH9NhX4GP1ZgS2pGb2BF5QHelPZ9BW0wmPjFY8yqiYG5kMmDzdGvC1HfqWvYf4Gs/OuCZfN6iBCYus1dQbj7n7lxnwtfggiFqpZfsUzbvR+gCsVj3kDlUq/biQtZJhV1Liq1/fVa3SLLsf6QFDK8VDuetIxpBzxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpVyNSTqm8WudwGNPzyJqABLwCrkz9ilCf/0xINCDrM=;
 b=gaYvxchJIA8C9rR1Hm7p3LHhNmbKXVMLZxGoezkpsZ6R2JXuYh1xAb4x9Nw0/A509K2c8bJuJLrNJy7CvhosjlyNONsOFFSsml/Jg2b6tlBVTUvrvW1HrQTghdbJdshWu9Uuhcr+vGMpLomgIPwBkPasv+DkmAEBu1ChUf9/kxtarzXKxEaDAcsme6paS5To8v933rg4trK/leYpfLqRWvHrgqBUeNBNQWtwgcRGf6PlzO1k1CNpE+3nbY+HRYXntTSKi5H7MJaX28NNeI2+LBauJjg6NfhVy0Zup1j/5TNuB56e4jgzk1+NPlVb6BOLtXCd+d5G9IeOGHHeO9JFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpVyNSTqm8WudwGNPzyJqABLwCrkz9ilCf/0xINCDrM=;
 b=Ll0FGQmsDQNAOSUqUyRMpfRnXCTqOyXTb4/I+FrcIUCSSWeCkxhkqPaORDa1LnUcM4aK0gKfbOr1QvgVjoE/DWMaoNp//9jX/K84oSIDofgmalRv74BvKeoy3eQJPWhK9t+s/QcawGpBJzbL29vqCpJJFEZSzcHfk2d57F0ZKEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by AS8PR04MB7974.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 09:46:09 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::2188:f19d:32be:35af]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::2188:f19d:32be:35af%5]) with mapi id 15.20.5144.027; Tue, 12 Apr 2022
 09:46:09 +0000
Message-ID: <56d10082-2599-067c-ae60-9b0bda26a864@oss.nxp.com>
Date:   Tue, 12 Apr 2022 12:46:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/5] imx-jpeg: Support dynamic resolution change
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1648023273.git.ming.qian@nxp.com>
From:   "mirela.rabulea@oss.nxp.com" <mirela.rabulea@oss.nxp.com>
In-Reply-To: <cover.1648023273.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0120.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::25) To AS4PR04MB9244.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57ceaaad-10b0-4119-ebf5-08da1c6945cf
X-MS-TrafficTypeDiagnostic: AS8PR04MB7974:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB7974F6ED1F89432C822CB202CEED9@AS8PR04MB7974.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E11tcIEyFQgg150e7020xMWpiGKTIp42zVEy7whDGRDFaycooM/QFX9y0EUCxSRftiTTlncJhW1+9qnWg839Yu+rtxV9bdqWh4BzdPGoE39CH8OvPtSDXCltAPSGKcZb9oD69LThp/7n0/INIOW5tw5qEq1q6V1xAouCQ6YCmFJfnm/WzcZ73PWIIJ570ETh7aISHdNAN8nFD8bE8znbbOl5lrrKmMAMhqynFcuq5zmqCrsPDP6VAe9u+Lw0nMIGhtWVPIobMl0pb000B+fX4lYsZVDxULqH19k+Tl7B82fuE+Lpvm6r+dZWKtL8kt2JK5YczS2SDj73qTGGYu2cas4P6ESmr9vjb6GSZq0N7gk7EahAwC0a2nJf0dBtsRNjhKgelP6j6XRZjPTuwVUF9mQCUZFmBOecHY4m4C1qtcrLikjMY5RUTS1/QPiDwRLqISc5H1BkYRkVsGNU7OKaZV1PT6HJAJnCAAQUaYlsC/DTy75ej6jPGDR0+xC9vnjv8TdyQh47jL71iycEMGBPe5DLrCWLr/y/T1Z0dXfrCNOA82J/nHJFTWx2YrcPH1MXV7uefuXGeiOmIpZ2B0zhPL4vEImEMVOF3BhLotTo+oDtmDpRteE1ULcXugeAPkyH2rHKfEWY4wPw1C6qlZ9xh09JyvU23L1oJtnPrL3dj6NzJBAdWfm9x8hTQk2yvyOkBUMDdVK3UI90wzNs22xAgNqxCah9soHq5HJKJdL6tcsJ3fVXaBpTGtKauPEVo4Kb7GGpkNpuLFUgUK0UOrm/FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(5660300002)(31696002)(2616005)(7416002)(316002)(6486002)(4744005)(8936002)(31686004)(83380400001)(26005)(186003)(508600001)(86362001)(2906002)(66476007)(38350700002)(6506007)(6512007)(4326008)(52116002)(53546011)(66556008)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlFhL3BnWXFUMUczM2VROEhHcStZQlN5ODJxVm1NZVpxME1Mb2ZwY1RobERP?=
 =?utf-8?B?Tk16dE1FbFZlOVBXZFdNM3hzRGFML0RLWWh4cFZsWmpObHpScFo2OEgrQ3Q3?=
 =?utf-8?B?N2hDT3AwcnZLNEZsbkwveHRwdzdGTFpka3NZY0pIM21Uc3FKUTQrTzh3cjlm?=
 =?utf-8?B?TkFpQSthTGphZVBFektPcW94NEZDOWFOQ2hpSGw3aW5XTy91WVo1WW9DVGFN?=
 =?utf-8?B?YzIzSTBmNTF0K3U1UXVBOWVSTkErc3R3dWFnK2FodjlUQlhWNXlYenh1aVJC?=
 =?utf-8?B?SlAzSGhVOEl6a0V5L2xqa3pmRys3THM2UkdrZm5NQ045dHNwWGRvQUl2NzFx?=
 =?utf-8?B?aU9ha3RtK2pzTFBQeVU4aEk3Rll2dkV1ZG51eXRWSk14T2ZacVN3eERITTFI?=
 =?utf-8?B?cEdyWXRVdkVid1M0dEoxUTdtR2xLVWw2U21VMTFNd3dOQnBUT2k0Q29rdnAw?=
 =?utf-8?B?eGJsakdKK2dRbFc4cWU5WHduVHRSbG5rck5qdFg0ZG90ekR0bk9EUHdzMktk?=
 =?utf-8?B?TDYxMGpvSnRQNEVTL21BOFcxeHNRVTJ0TXJBNjgwZEpqMURlaDVMU0drSGwy?=
 =?utf-8?B?VUx6VUJHbmY0RUxhN1hSMDBGWStwNC9xSWN0NW40c1FFWHNjbE03UWsvWmJ4?=
 =?utf-8?B?SlU4c1AvWkRITVU4VHdzY3JDSTRPbkV0RmU3TlNja0ZONkpqM0lHZmwwQm1i?=
 =?utf-8?B?T1UzTVRVZ1BNb0V4UnFnN1lpZHdJMFJUNDVVRVRQc201ZVpObTVtM1Z3REtj?=
 =?utf-8?B?QmRKVGRXYkROL3U2T29PWWhVYVc5RUl0RzdGMlhkY3RYdGNtTE1VcXhJQ0dI?=
 =?utf-8?B?aUpJSkFvL2hydnh1WUZzWU04REhwWTdRWmhuNVQ0MUpZZW1DVWVtd01kVmV2?=
 =?utf-8?B?OVMzTDFNUm41U3hhTlF3bm8xTmZTdU1GZktMOEMwZk9qZTNyWWM5UC9oTGtW?=
 =?utf-8?B?R1BNNXNKY2p5bHZjbTRRZFdNMVp2OTdoeER1d0xCTWtybm5udXU4Mmh6cG1M?=
 =?utf-8?B?TE5ISE9CNTRjU2ErdGFBZ2pnUE5UK0NpaVI5WjN2Nm9ESEIxYmE3Y05ab1pM?=
 =?utf-8?B?WlVqeFpOMkpqN3g1MGtvQjVuWU0zQmRIR3lpc2lEa1JPUFhLd1E0VlN4d3Nm?=
 =?utf-8?B?UU1ublNEVWhERm96K0N2OGtUUFlQRHJsZEVwRzdXNEF6a1pKZEpqUU14Ujcz?=
 =?utf-8?B?MHlCSTZiZ0lwV1VDTmpUL25rKzFCSGhuakRRVGtjc08zbmFjeFF2bnZQWjA1?=
 =?utf-8?B?cU02b29iTUFwU0g4bm5ZOVpWUHZ0S3IxM1ZoRkhRaFJQYTI1T3hkMHFWY1JW?=
 =?utf-8?B?WnlVUkNWdERKbVB6UjlwdEo0Q3lEMU5hVEtOOHJCMWxJcVlqUGdGS09WVzJI?=
 =?utf-8?B?ZG9vaXpDQUp0NnBHZmJ5V1JRbmFqbXZ4TnU1YzVvRkdIa2s1bFk4MVNXazA4?=
 =?utf-8?B?d2ptd25ZenZPRlVpTU9FOEc4d0dRQVdHODJZZURPNVdMVFBqS09oaGJhK0Uv?=
 =?utf-8?B?KzEwQnkxWmFuZVpOS0p5TktHT0VlN1M4OTFKZVplOG0waHJKMWp1YXFybjZZ?=
 =?utf-8?B?TzdiODFibHFxZEcya2pwRzNVTlZUYW96YlJUYytmYTA3Ry9PWHViTThRM2dL?=
 =?utf-8?B?VUJMTmJCV1RyR2tLcHFZWm5YM2RDdktaSDlLNW5iUzdTMDd2dGgvaUE3WGRP?=
 =?utf-8?B?aDU5UnI4RVU3Z3NBQTQwdnMvNUdYaml2c0oyWnRQWkM0L2NsMk9DakxQb0JU?=
 =?utf-8?B?bC9DZm4wTWNCTTJwZ3ZOYlZudnNDSjQ2eFA0OHNTUGhQelNkcXJaeTRqbHZh?=
 =?utf-8?B?TmFaa1JqeUdQSUlGaG5qcnJTVzhaUHo3N0psMTRvMnNiYmNINWxob09OS3Zm?=
 =?utf-8?B?SmhtUFgyTjB1YjZIRGx2bXBYd1RidGxHekREQnFvSUZJQWpocVR1cTdWSS9n?=
 =?utf-8?B?RHhhUUdDY1RPclV6eUJDdVNJV1Bvalp6NENrWm03ZGloQk5tWUF2eU9QOCt3?=
 =?utf-8?B?eDliOUI1bXh3QlNxSnJqejFoOVVQTmIrUHdhendKbUNyMnloOWJMYmI3U1Ns?=
 =?utf-8?B?YXdabFJjN2wwQ1Y5ck5idnA4bCs2bE9LQUJsS0JFS3JUV1ozMXkwdDBwNnpl?=
 =?utf-8?B?MHpJdkxkbEY5dVI0MGJkTmhOYzQ3REhnbWFxcVhwbEFBbjFlcmpVZG1NTEpO?=
 =?utf-8?B?bEszL1N6V0dyM2ovL2prcG5KcGJLZll0RGZFTCtDbDE3RHZRVDBtRlhPQ0E3?=
 =?utf-8?B?UXBVWVVuSXY2UjlsYi82MUVpQnJIcVlqNXIzRGtpb24xaFNnc2hYSDV4elYw?=
 =?utf-8?B?Y3JYWE4zT1JYUXY0Z3piT0pqeGNEMVNOc0YvMEFoYzJJMWdlbWdsT0I1UFdr?=
 =?utf-8?Q?A46yjUUUIQmcW+Ls=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ceaaad-10b0-4119-ebf5-08da1c6945cf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 09:46:09.7400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWQl+edb55CNHbNtuwPhMElNjDcJAP/71LZEibwtsjT2vDpnveEToMQ6jrGDhPjadJJ+cq3byAoV5L6vHocaPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7974
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23.03.2022 11:05, Ming Qian wrote:
> These patchset are to support dynamic resolution change.
> Avoid decoding error or even kernel panic.
> Otherwise, the Gstreamer v4l2videodec will fail to decode jpeg
> who is not decoded to yuyv.
> 
> Ming Qian (5):
>    media: imx-jpeg: Refactor function mxc_jpeg_parse
>    media: imx-jpeg: Identify and handle precision correctly
>    media: imx-jpeg: Propagate the output frame size to the capture side
>    media: imx-jpeg: Handle source change in a function
>    media: imx-jpeg: Support dynamic resolution change

For the entire patch set, v3:
Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>

> 
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 249 ++++++++++++------
>   .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   3 +
>   2 files changed, 174 insertions(+), 78 deletions(-)
> 
> 
> base-commit: 71e6d0608e4d1b79069990c7dacb3600ced28a3b
