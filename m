Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D3C537543
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiE3GVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiE3GVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:21:46 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8601E0D
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1653891700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=GEoWWwPnZHC5PlTEHbYP//hOGoOZXnRTPhL+zdo6i/I=;
        b=i8FQJoTwfvOKMoaoAOVh/bF5atAZ+GwN2WdcgxP8vvUGVmq87D7a8B71JGKmEc5q/r8lbw
        WW1oWfcdU/AxBIgb9/M+d4Y/XuezSxxa/ectJcaNWtsMxTUDPoSYwVIcdX+DMRyjW0vudc
        hnVOTvJO+H4lJg3PLH6IfAjYXVnnv0k=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2053.outbound.protection.outlook.com [104.47.6.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-_A8PAXPgPWOfVYJx7iJkQA-1; Mon, 30 May 2022 08:21:39 +0200
X-MC-Unique: _A8PAXPgPWOfVYJx7iJkQA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNgzJhOqTwahV32Aznrs+F80eFZIpUwvJO0g5qUq9gxiWGE/6piS5BJ18LEDA2wreihe3j8DJtqLIs1JGY9d/BTm6sm8tXlHTB7l9AtjopRAxxrHVYJ02SMMb8GOV82U64vkB0kCxVqY4LHaZebC9kLHFs6EGP4m3qTWib/kiPqwF2scoXfAFJBbElyAXhNKAfQzshLtp1uOSRjZcdYDBYPtqpPUcmHQbZPSIdE3vqdq6kht8BstrlXfeA/FKcuEE4JHjppaZLivfS9lkidQxuozA4LP3eORxYAKh1GqW3s6xrzP8UKYKqo+SkxtOCYhO4xMCIRuz+ze1VBzOogRfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEoWWwPnZHC5PlTEHbYP//hOGoOZXnRTPhL+zdo6i/I=;
 b=FBx9BEu4329I3KPSohiGSSgf0+cMzpiTCyXf6TrquMSyyrzQf986wYamZuzTWHKI3m9pBKux9ikWxuPiXKLxsLxngSO32LZR7yk4D3pT51HHSzruagzp0kF7VSVvc4TWhNYSOYsKKP9jb00N+kr2L8MptUOswvuf7Hpwi5gZhZb4/8t1U2ZlkALyMvyf1af738xYCcjb+KQJQGSbFvdyvuefuEMs/vp4tORM1tC2sJVNT1GMziTT7/EtC44gPCB3VcpnIv/twLF5GMfawLgndZUtt+UvXgeRoUacwdEvegO265al/YG0520713HjFQvZ1rTL+d6eA0lskxeCToKpUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM8PR04MB8019.eurprd04.prod.outlook.com (2603:10a6:20b:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 06:21:37 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::b51c:9a69:6f99:65c]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::b51c:9a69:6f99:65c%4]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 06:21:37 +0000
Date:   Mon, 30 May 2022 14:21:26 +0800
From:   Chester Lin <clin@suse.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>, s32@nxp.com,
        Fabio Estevam <festevam@gmail.com>
Subject: [GIT PULL] arm64: s32g changes for v5.19
Message-ID: <YpRiZpZU3kH2xprC@linux-8mug>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: AM5PR0701CA0012.eurprd07.prod.outlook.com
 (2603:10a6:203:51::22) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ca948cb-7b7e-4144-58af-08da4204a6f5
X-MS-TrafficTypeDiagnostic: AM8PR04MB8019:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB801929317DCED4C0EE8FEC76ADDD9@AM8PR04MB8019.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4lR3tERPv+s8GSuAt6Cmur7s8X/E1g0YbGUC1/hmEDvcWtV7BshCFTT9R3KO0etXEkNqIs73CastCLw9i1JKYv8PlyIoqNVB9BINwl415t2//sQItBdDA5j7u0Gt/S2KHSabLdeXL0ECoUHyXAL8HPqaospZvIAKyfeto+XYzRcHC58tlqtXQyTYdsva9X2DYtynq+ww/lcdSC+vjFN5pVSsCO0pYgrxwE13Xb3QUbFjg2tagU2uUMmWfYRL80wMYw/o3Mv+dBPypVUh4FXtNv2W0Gt1M+SoMsekcqMGL+A3epje9tOy8Zf9UxEfdDqmDoRT7ku32K9+5G1hsGs+EYn5ne9A+Y7uKhvVEk9rHNUm9DCMTvzfEwEYregGZmDSuMHgGe7W+wpD8+8d7b2z3K2kOgB6Hdf9pvbatxyuO+IXSsWjtaX1hn5PXYBPvMLQA3yXJTatDxkLElyZ4MkXlzokOnplKv61eM+79O30UQtrygCTwm4WN0zwxcqPybNBYYGocR6eJ3ylCV8LBXFxn+X1AXWXzwG/hEUYquyZrinNyy/kJDg4v3MnLOeXpgqfgWhXuk96BcYJMCOd1cM7gxco7iZZ+burap3bFGtGXY03M0elxFz0zSXWh8qSeW0wi6ePD+NyYm2wsPRfIxKenrQQxc//HFq5nRlAPaY/ipWeGHoKQlJeWs2lrK6I1k0ArE7T7EZn5IM0OLmRkpcJz1dwkadS5HXC29Tm8IE11I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66556008)(508600001)(110136005)(66476007)(66946007)(186003)(966005)(83380400001)(4326008)(86362001)(2906002)(38100700002)(33716001)(26005)(9686003)(6506007)(6512007)(5660300002)(8936002)(6486002)(4744005)(316002)(54906003)(8676002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HFgQSFe5elNTZ8itsrkeXIf5ar4fEPDcFi2hy2kYRFDwSkiej6zX32wRzABR?=
 =?us-ascii?Q?oXIT33+8H8FL/2ef8avUSSUY3SoVDKB64QnE+DMh05r7T+cBKuKIRdeRj3Nw?=
 =?us-ascii?Q?8xG1NHrhRot1jiEmB9IxTFyomeDySuDoQgtDsYvrnrR8vSz0kqf27lveE6U8?=
 =?us-ascii?Q?H7hHW8wApaivBZuEoNTOYHBa6pdEAOhVqhM96iRqeEjJqcD1OfddZZD/SUBw?=
 =?us-ascii?Q?zJs3jpThRMHY62dtzjWPnUXbPjEEpYHQnAXRZW17U8Su3vooF5Nb8Ty+ZCV1?=
 =?us-ascii?Q?0kqtIntTnd6Qxxxihfn2mDEmV16WE2DBMjD8mWr+aLCtWkiuFtic40Cr4WJb?=
 =?us-ascii?Q?QQjj4FJf5QOlmaC9CmdBtrqUehPysv/k9hx4AzfTW/zjsBmQbx1AAbq+V5/V?=
 =?us-ascii?Q?gyI1nMFMvlWab+owbw9PaA3h6gZd3ZxpiKuIXFIN/In6DqUSuMIbBofBpZjo?=
 =?us-ascii?Q?ljbSQ1p4lQFIccEwYErwyqb1CSFH6EF04rfsHMYHiVs8d3vHnMM3fOnjK3dG?=
 =?us-ascii?Q?yT8nOBgMf0RNqRxYrW/YzNOGb8bG0SVYMx9YnAGO2h/YVU6NWHRfFoaotkEP?=
 =?us-ascii?Q?tXfOH6FnezHO2tS/wq/0CJMDpdsKjbRxrDAX83F8rv68NDLwXvyFjGeQvZui?=
 =?us-ascii?Q?TfECWBaVIrq24HdBcvCWlfk9cONebQQ/7MOjOk9K6sgUuMJyjrSo/sWeuaVS?=
 =?us-ascii?Q?FBBiClE9HaXs+ZYQAKt1u8MA99coWjFi1YT2237bB+KwCRJEiHje0fH8nuM1?=
 =?us-ascii?Q?fEAugJvwsh16TSeLdOxuTWPCfUkxNDoY2MkwMkFd812vS9MDCyrt3ik6TifS?=
 =?us-ascii?Q?G61iSf8ann5rzQfcLa96sli8FafGA4nde2lIsIKRMa9InKAw+33xoxnqEvt8?=
 =?us-ascii?Q?zTQBA/WL6pK/rmeir2AAOrl/rYyByy1UFCzouH4dRgR/ziK/x2LqcYV1lCuv?=
 =?us-ascii?Q?Vq6O9sBIg9ERzfDiD0ymI9CiNKYKC5QwWyzdu/Ld3oWtb0x1PBZIEdNIr/9+?=
 =?us-ascii?Q?5hMCBHePWSg2iORZ5vMq047L1yX0v6wCuRwMt2B2Zh5wmIqcgjr1Xcq49Vp8?=
 =?us-ascii?Q?jC1X01hCRFLIYSfNp6xVAuIdJbITQnQc2a95r04Eoxhe2H8rW50Xa5adjWfe?=
 =?us-ascii?Q?ajG5jyEHQoDShWwydmk26jAhAqzfMdkzFg+DCcab4Cckcaurqv5HYo5q2h3n?=
 =?us-ascii?Q?DmPwfbehDTDq0sVpZiwX5sqUk5839dmXT0YzqRAsIW4uM6dHzKjqqQTCBn4J?=
 =?us-ascii?Q?q52RMiOpkxJIKhII8APt72jyNSwsuHdM7a2w4G5L8eig05UZ996L12ppc9/L?=
 =?us-ascii?Q?2aweFRyr9TuBkCZT8RuEclfAOuEUm77TK94rc+sLAZsX5M6dvPcsRatIEbfh?=
 =?us-ascii?Q?DpVcylWswQKG5uRVLXurGvcJQcVq21x3XEDMe4ZVT35nWl+5pCLr7EeCKgO5?=
 =?us-ascii?Q?Cg0mCqQCLNeFEgrxTDgmARF6S/7v+7QVL2DFygUETd80KV1eAIbPj7Jm5+zW?=
 =?us-ascii?Q?JFE1Jc62o/W4XIy9FOvlwuxtTCfMIr1nLqf4BcAoz4rUkpWne3aH5KHPAAQ0?=
 =?us-ascii?Q?axePavxqGNcmwcZHPPutuGXPrcTycYjGexfuTMpjWc+I0OZNsm9gZn5Rl8ju?=
 =?us-ascii?Q?gK6gWseo+XPAfQ1pnNIw/GHaXX4yhzlT2cfYurwEIOMjMkwvP/ZHSYqD04GW?=
 =?us-ascii?Q?cXHBQS+cpazIRFJMBKV4GsJnpm7XPT0lKgldNqvF5WTiHqB1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca948cb-7b7e-4144-58af-08da4204a6f5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 06:21:37.6308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDtCrFi+3mn/Mm5u1H1NAKVvpUgq5hIXkucgg86YpObp/7Qx23TadVQVcCbCdbK9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8019
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof, and ARM SoC maintainers,

Please pull the following two changes for s32g. Thanks.

The following changes since commit b00ed48bb0a7c295facf9036135a573a5cdbe7de:

  Merge tag 'dmaengine-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine (2022-05-29 11:38:27 -0700)

are available in the Git repository at:

  https://github.com/chesterlintw/linux-s32g.git tags/s32g2-5.19

for you to fetch changes up to fdb31e581566f7a2790b602f62701fce96b16443:

  MAINTAINERS: add a new reviewer for S32G (2022-05-30 11:21:49 +0800)

----------------------------------------------------------------
s32g changes for v5.19

----------------------------------------------------------------
Chester Lin (1):
      MAINTAINERS: add a new reviewer for S32G

Fabio Estevam (1):
      Pass unit name to soc node to fix the following W=1 build warning:

 MAINTAINERS                              | 1 +
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

