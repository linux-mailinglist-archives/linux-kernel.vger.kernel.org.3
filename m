Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9FD4DC301
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiCQJkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiCQJkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:40:12 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2121.outbound.protection.outlook.com [40.107.117.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EB817ADB1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hw3t+Fcb5qu5npUuQlZ9/D3BxFbulWHW+i3yE++audWBUtsSmluNjQmm90dchX4E2gCmnHsH1KhZiySSye3bExIRVv91uXDEjTJJxI7UDRgTEPbgiaJOku14QcYY4OaFvWiy1760iEyU7Plxrj9CU8GqnO5qJ7DF6n35ladgODttvfyaYFm65MV77jQnqbUT9YRSI9OBQypjZIlARueZx6Qnc2+jY5HyFZSA9d/q9oxUC0MorguW6pm0aWoOKg70ouqD9Q/rE+MFXxAbMo1ZMhIcI8n3QO9iNB+FfaqcHwRXhPWKN1lEJfmf8FyuNCmoFDWBVk/mfcJqweUAYbE9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKm0z0vzl2/UCx25vp1Jr3oEI36MrjD78di1mFmbz6c=;
 b=jcE7RAgnzCKjnhqFEK0BNyUjaPb/vwfSWIwdD0E3rpnAT3q/aTMJWVl3fhU0GsbIIKlEABa8Shh3poUQz2qMPO/hlvzNm0+bVBGnTJSfci9xqSPyZ/sX4gN3Pw39faPt05DaG6qN7ANl+c/95V6AzBwJRqvaUjWvb/t0W5ienTDbX98bCFvAKH5Ez9WFTSE0PdfQXfTymLFl9RlwMBx0oUb9wo3E1GT2+3thFi5OediHQm76/KjkFwdx45eg/u8e6B7S4F+wl5Hc2KSEwoSj9vtAeKErLyC4ugNO7YKQ5ZsJKRxqAMsmx/7CLi9LbQUmSYEBH0gdGWd0zwKhY4ctAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKm0z0vzl2/UCx25vp1Jr3oEI36MrjD78di1mFmbz6c=;
 b=oKuJRNK79jguop01Rm3v1HUkiyhzovmNjsXurY8eJ+DIEyxImbUNYBW/TZtugxAdEVdFWEF6VNQ/i6LuebmV/nsVnfd29ysK3FyoM9kq7GXqOtpYTTFzJ6JFzjq9Q8UcYbDdx+3HMblQ6EaiXUhWWuwDKPWvrCJ/iBt6z6s5jmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by KL1PR0601MB3939.apcprd06.prod.outlook.com (2603:1096:820:27::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 09:38:53 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::4005:4e49:1e4e:463c]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::4005:4e49:1e4e:463c%3]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 09:38:53 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] ASoC: SOF: topology: Use kmemdup() to replace kzalloc + memcpy
Date:   Thu, 17 Mar 2022 02:38:41 -0700
Message-Id: <20220317093841.3414-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0101.apcprd03.prod.outlook.com
 (2603:1096:203:b0::17) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c60bba2-a9b3-4f8b-dab9-08da07f9f2db
X-MS-TrafficTypeDiagnostic: KL1PR0601MB3939:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB39393AC712D1A33CE1987328A2129@KL1PR0601MB3939.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpK1i7K0CGydOL2mhfrxvb6T52343NoZbbta/rEIc+jK/Kt7aUiuEWKEjBXJoxQAxXfYMDZSlXBZnGGR4J86nLbgCqqv0x9B/OfbzACND7kgJ2/cGBTnm4LIui79bdzBlkfUttzM1Eh6t8RDmP8/XZqYjkfLmSNc+1cfNkrDzoYgFpte8+eUOeRTtS/QJqXFjtg3RGLIOcVEmAs2pbdwzMUrB0YaErR0HGaPyD0HrHuWqY9SVwbzpimiZNTAMeGJgH/YtNdYTrVmlyD3Rtl+pHYKN0mUwqTBZwMuNaPTRxH/Ig9hPXqXlNBi8aY9IEisBiR3HAUZ46pwt+x/acjSltzwQgJYlRM71+0OyjmYn+8e1Igt4m0DJz9/uheWZml5g2d8tFGopd2oXkyT5mZ/g7tCAOjDt0Ae5Pm56eJDv0Bqh2OltFeIu58KSo9aJ461XnWTBpYDYLSwnoEzVsa9XDyFODXaPdHoahMlOPNLJCD6zbplKDLTiynbqdtxNputMDfDCMQzZ/l/gobtL/J4hO83xjClco3yzuekqJwMuY3nKuWqFlXQN/MC2xI7HCrutlZJ/NtiHR8GI6CzRJVNZi9+Q526GFcnlPgmOjr/pPMaqruu6uJdsXFgDGAdtJemmUzqQvGKzHhCJG7uGSZbMpY34PDqxS034g08nlHKuuj+I5lAEILk03vwR7Cwr4pehFQAX/9UA6EuLOKjUJ0dsJ+Kqx86rNZOQPMlmwlaDz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(38350700002)(1076003)(38100700002)(83380400001)(6506007)(4326008)(66556008)(8676002)(186003)(6486002)(316002)(66946007)(66476007)(4744005)(86362001)(107886003)(110136005)(2616005)(36756003)(8936002)(2906002)(6512007)(921005)(52116002)(508600001)(7416002)(6666004)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vCtijWd/kI0mKThVIqIugnhRYiGPlKSeTqLouQGLETQkR4qxFFDMkf4+052B?=
 =?us-ascii?Q?EJgKsU/xxCmeOB2sjqdq33t9iOhHNLd3PszHCmz3b4fbrPJLvDwppXakV/wp?=
 =?us-ascii?Q?C+YF6x0FMJWsfbE4iDEFe2FxGcKI5QwyVeRavNA3MWAHuZ8UVSKGSXjXGSWi?=
 =?us-ascii?Q?J7VNEej4qTdT7FhT80Vbd2YtZ8hItY+5uXgk7Nw1VJsvmULuzlVZVC27GTiD?=
 =?us-ascii?Q?D9LiPiut88gRGJLGD2+5OPLZiQls2uNjIBCWMlX+EpaqbfAr1Oz9ZdRbWjIw?=
 =?us-ascii?Q?0dOQsjL+wNVJFREw2mOuGqsKONfVPikU4+OdZimcEHuewG3ux/Exb3L8JGMN?=
 =?us-ascii?Q?eIUuMc6zphyy4BZNpaBYqXQtMBzFeqXb0XwJ3Q22sk+gBSDvlj+fCELgnS49?=
 =?us-ascii?Q?RXOGHEEunA5zoeZI3Pw4R4k40rD4XZzk2fi5BnwOBl3J2h+kZjr+jN/M7PTM?=
 =?us-ascii?Q?GNE+hyy2u81t3bt8F2SkweGRwLw5GygbvdDJ1xbkdGkwVvtns7xif5MtYiS6?=
 =?us-ascii?Q?nQYSjqhFCGhZrA7FU7wA4xhrtlz8/KANd1tpI2Eo8RG/LEhr+tllvMNeybV2?=
 =?us-ascii?Q?yY+JlNmJzukIYS1gDR+2S5yhzis97LL0TvfDE1A+eiy+JNvMSPVopcuCXKYa?=
 =?us-ascii?Q?00aQ5pQD9ubHHqIig9QAV833Uh5osB+f0uwkiOXwhBMGvSCiKEW+k2cXoj1i?=
 =?us-ascii?Q?6DuIkODmLDv5CIwKkOxU8828AspxGrH/h803jjCtQMvJOaiQ0SUJagK/VRhQ?=
 =?us-ascii?Q?8pWUydsYStp1mkVbqLUnBqBIeQ22f3ldcE2X/1Qnr87SrZJzgxa1SIZVAs6L?=
 =?us-ascii?Q?KH7Rok7WF25RBgFxOc0rcRxvjXv7VYKysnotSDXQUWXyIgkDkcdQ+JbdaD8x?=
 =?us-ascii?Q?s8dKAi/A5Yk6nQ+w6fRyj6HB5f3+ZuXC58Z30d0/i6Mz4M1Qga800Hn8RnpM?=
 =?us-ascii?Q?O4X+KrqI/CpuG3kew9hJPIQw69AdLq0j+ukVMinki1f65WinMSApOG/bdn1V?=
 =?us-ascii?Q?P2AIl1kdyiMGvZCW8Egwo99aF8S3IjyA7qsmIlY8FnX6LGGw1Kh8AX1qMEwb?=
 =?us-ascii?Q?Fzv33geRtT/zGPo3S4hKwEedy15Hn6NrRSUOb0dL29LoQD/4mJfUqc83CzQ6?=
 =?us-ascii?Q?iM+qJImkrGz4e7SXkDawF65WRR5+I0nJfEVwVAGdn7u2Tqj2VFl6YPiiY+0Z?=
 =?us-ascii?Q?xK6xnJ70/d22ZMpwwDS8fMGs92RE+jl2ZouSKl4cmMMCldFETfEmqnwnGUOZ?=
 =?us-ascii?Q?9IqiD0Q5tNX0x/Nw8hFYB6oIO5o5LUcoQOfRlfXkvomPZ9LS45t9cVVhRmhx?=
 =?us-ascii?Q?Ujbzu4y7HMfOLNGaWmQnPO/htQK8LSpWQ9WwNsOb/KslwDTya/Fsw/61xZgz?=
 =?us-ascii?Q?9L1esUN8pL2Gv1fpWACpES38U8dHpsTQi5cDZ73niLPAdQM8f24INk4xOIOj?=
 =?us-ascii?Q?BPihwx0LgEEVxRQUQhtsoIJjYyO89TSl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c60bba2-a9b3-4f8b-dab9-08da07f9f2db
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 09:38:53.0654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TJsVeoXzPwXQF+8AHDSbNPbJLwRgSyZS7z0RlCQwUZ+w+5GpKa1VKAblyK6jXXrU+oJqfAmZGgMtKq/fbzKsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3939
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix memdup.cocci warning:
sound/soc/sof/topology.c:876:19-26: WARNING opportunity for kmemdup

Generated by: scripts/coccinelle/api/memdup.cocci

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 sound/soc/sof/topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 367fbe2d5b31..369693cc6d10 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -873,11 +873,10 @@ static int sof_control_load_bytes(struct snd_soc_component *scomp,
 
 	/* copy the private data */
 	if (priv_size > 0) {
-		scontrol->priv = kzalloc(priv_size, GFP_KERNEL);
+		scontrol->priv = kmemdup(control->priv.data, priv_size, GFP_KERNEL);
 		if (!scontrol->priv)
 			return -ENOMEM;
 
-		memcpy(scontrol->priv, control->priv.data, priv_size);
 		scontrol->priv_size = priv_size;
 	}
 
-- 
2.17.1

