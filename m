Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC7859C559
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiHVRt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbiHVRty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:49:54 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70080.outbound.protection.outlook.com [40.107.7.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F74B15801
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyCkwO968OZGVIOZsvPzLvBFpbtmHbfRZ+86Mxskvn2vJJfzJeIsue5h4nxCsUqLljNCkMZY4yUIjFZd/YL46vL5KnFQY0d8BQeNx0mPja48VafAA0o1W/nxrH7TBa5L40zDeW9lJqmH+mpCcoiavSm8Bw8DWvt0soMIeqT7r3M3kEB0+xCgZSUs9a7zdnkXMyZ4qdgkOaT3ToFgEunwWKWrpEtBEggMQKrsSHCRlkviWEA5QFhlgc1wQ0Kdz09A5MFZcA/cMK5cU4rnS1QTAcstVUE8iA4k/R13FSOx63R7eceblmCcuZYzEgO+9IGjMGVorjqYKJe+pxa2XZ7OOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDZwVtNg4dtUMrat6sPZHWUINSdLLFQCxDvh7eJsXSA=;
 b=Rc35tptuMWfKW0q9MBBRChTfqLEfmx4yGGlP/VjVqZuD8LAHMMn3rSsOPuXHEX9gTHKymMLV3h9m85/RRWEe6aqbXTEPCJxMoF1cps6B+K7m1jzZoGGsE8ElD/s5sNLwA7gXreB+rGPNwb3e7krWtjhjXga8y563pzXHrUG3KsGyGVqfMz+ouVdjIf4SK7RVirdQVTrwtdfeSsM+qJJWhPFOIk3wmiJDD2lG7nI7yFXzoz5hlInBiS2YdRX9BBQsj6WBMML3HOISqV0GRmWThQ/XkJyyU6ganqr7ctH0Yp2RS7XQshaNCAkvFh5Jdk7/hXd14EMM5EJfwzNCJ7nSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDZwVtNg4dtUMrat6sPZHWUINSdLLFQCxDvh7eJsXSA=;
 b=a+WHAWSP93UMpgppJZY1cauCceQHNi0l9Q/T0K0ZPnofsmLlSAdgOXLgWbubwvAPsUGlxU/vL4QwCL95ire94M86KS56wM69ZHI6lGK2EY03/Gf+xpdxV4VGf25DyFjAEpZFc7Gt3bwT9pwhi4o3qSvXdOG1wjcq8lmATEK0+dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by AS8PR04MB8449.eurprd04.prod.outlook.com (2603:10a6:20b:344::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 17:49:50 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::68e3:e10a:8232:10e5]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::68e3:e10a:8232:10e5%5]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 17:49:50 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: SOF: compress: Remove dai_posn variable
Date:   Mon, 22 Aug 2022 20:49:37 +0300
Message-Id: <20220822174937.254873-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0063.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::16) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f75ff19-b2ce-4a54-917e-08da8466b5c6
X-MS-TrafficTypeDiagnostic: AS8PR04MB8449:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCPGRjdQJRLtJlPaC9h4jPzcW6QqGIZRqqWjFhy+MPDkXtBapGr9N5gS44DSX/gj8QyVcRkfCWmIbJiz+Atb02z2Xvwb/yZVPKElAMNX3th02EHwCn14TzGo7Ms4nyEH2R+ShpjFbk3H9jbg2m6cERbCpg32dM5h3i5lz4vspLIJw+yUnWR7d8v8gCwWIYcwEPGuj4ze5dqneawES0olgcbguRBa7gch37GXxWPf/slxRhjaErSt2dNc7n/ugXWmBSyeBkIwvGzIG/Okzo+ZH0uPy6Yux5Jt2XJoOtF/w0jZx7BPabB+YVOo9AJrX7muAoGsRUIwS7jb3KW+acwzttLvT+N60PGoVthXD2gVCQe2pMd4e1V6jK/WxDZenMWm2o9YASZrFiAkjJpkVuyP3cL+3pDXq3y8HRoNecw+YYvjNZbyFKKpdw1mGPpjXazkLr0m+1nuV0LbwgnevLkPPNZF77CSbB3QmZyr1TVWbpIwf/4FVg6wgTrTvQJJTmyCNgDpYZkSPohPV4MJO9N1swbj76dN+nNFEW/X2EDEVKT1DnfUMrsVH4UUgBh4RoodznJ7h3vRGdDzMC1+O9v4Cb8a9q/4pS4ZL8UQZss0kCuvlKNL9d1vlFCBBBtQA7mk2JCLLmox5X3DnMQkZLdcWEHSBuOKEUXqt7Bf8PtjgiHxMynxN6zOsq2v/xacWfhR6UodH1vNLsybWlS+5vJViA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(478600001)(6666004)(52116002)(6506007)(86362001)(83380400001)(6512007)(2616005)(41300700001)(6486002)(1076003)(186003)(66946007)(8676002)(2906002)(66476007)(4326008)(54906003)(316002)(66556008)(5660300002)(44832011)(8936002)(7416002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4gVnYwaZgNwsixv30N+rBWBaBigA3rKo0M3NCdoXTTGHyNhAT22Pt2RGaYxE?=
 =?us-ascii?Q?VwyqstHJKi4NRagBR7QMHC6T/t6FnhIvrOzwCpCyNrj6J/8ndVJ0KUcVDjcq?=
 =?us-ascii?Q?jwS8JISbSqvDecB7e2IZAspCnUqtGwEot8fixsS+Oy1BjfGNzABe/SQh3A8R?=
 =?us-ascii?Q?3f5+mK5yHbJrYhZ8lix09f++E5LvUDzbbMJe5rgY80wdukbH9G0hGfLiK7b9?=
 =?us-ascii?Q?TseW0hW79Jawlf56dIrP/5kjaDSw1WorPcMtEvwHCvqFbdRY8g+ZLH10W9dM?=
 =?us-ascii?Q?WEzBnKPqnFmszhEschVYn0EL6EKLZsx6X2sRxMEdFi6+bjxC4HKdgO513GAc?=
 =?us-ascii?Q?fpY3YgvpnyXdY4Knl+m1JfGcUexT84Fdr+XXEaaTRKuUYrkYYuMmZoIw6zQo?=
 =?us-ascii?Q?peTXDJB6/KJ0rkNC17K8bY6o1LhSutvVcb39wicw21JrbSsaG1pQp6uWnVei?=
 =?us-ascii?Q?p5zLewWLYNSeegfmwJJF48pgJ5mZK2WlEXe3WRO7czDhoLv/BAaQrVSKmByl?=
 =?us-ascii?Q?bu7KLEwa0k7mJlZzf+smHcFadDu3+AFa3GnZ3Tje1MaAfs2Pd+IopAL2LAv+?=
 =?us-ascii?Q?+IhQz29+jqksBT6BSTsFhgD75cj4l6bRTAWCwwMACJvgxcbg1XeogIHrpJe+?=
 =?us-ascii?Q?YDCoiCEmjEeWAY7PHW8AcfMTtp+kvoPdh0VMRY5YgM3Q9nhzeskBplQSUxog?=
 =?us-ascii?Q?hltb7gcdIjY4wsgQiNhPh8trWFVygVbeb7f3oWRjH1YEt68Z92+GdS0m6wkI?=
 =?us-ascii?Q?feBw8Fsc7OA0bDtKWqcJhvWRFQ/6qbpTR99PvJiejE4wVSiP/fLHZmdZHAsu?=
 =?us-ascii?Q?s+SZarYrmP+nwgyEsMPhWnbd5wIwbtUarsNFRwvFaoV7CFIdeNSlOrN0pIrZ?=
 =?us-ascii?Q?yw1qUIXdxT4PJU2qGOz0aJqMakPMi/blMBom4YW5eRWxH6UtB4zqdAoPLM2l?=
 =?us-ascii?Q?KSsULooGxNkK2Ts9d6loG8UOUKqOCAxd5oLo9H7R58RU2eMktuHliUaH+xZa?=
 =?us-ascii?Q?joT9rL19T6SqSOfBHIVcd00L9n5Rv7FxJrGGrx7XMRQlI6OC7tjANE4rHmg7?=
 =?us-ascii?Q?mLZ/8H9+TDxt9Wrq37ml3+BDDLVucDXccWw9lW7wNgyF3RLwkrFCBEJAuQUo?=
 =?us-ascii?Q?WMdvAG4LuTbkxXuQI5TsC8rLWFUWql7/V7QteUfuzTnXM5SwRTFvbCR4fYQw?=
 =?us-ascii?Q?69QPaE8nhLCe6l8sqZdY+nbD8h+E9yGSev6FryWsS9IhmxH3XKzOcrNTU1Qd?=
 =?us-ascii?Q?wv0HONqG1ERNY0xrMl+6Ie2x19pzGAuoWH6ynwez3/Km6oOjyZZo/fJkGdSz?=
 =?us-ascii?Q?1WLdF7lyeoO7rqI20uyGTCwiODnM2PGLLoPJvYe5Dv5G2JMbkk8d1/vkj+9t?=
 =?us-ascii?Q?okEQtWwrSeEIL9OH0piKT8RaRU46FOODmQFJ1jCgd+TZc9w2IdngfSBxM9Hw?=
 =?us-ascii?Q?N2TYELeW3xSZTzfSl+zUt8CFSxTHtiYFkKF4SNY8WxQEyEhCLW+2B0hxX4HS?=
 =?us-ascii?Q?925A5PWl4DjVpxtIjca5S2WtyLppHuIhelFu0+JzI8CwIXPx8//zKVqBpchg?=
 =?us-ascii?Q?iULojFEKt5/GxPo8SBXdikAdETJwje7J5IembUygiKsD127wTBdCj4wjnUvm?=
 =?us-ascii?Q?IJfcWf7TYUzEaj25ii+TrU7w+o4jUdWX9DvelfMNJMpyS8QuCSPEfkPLxzIl?=
 =?us-ascii?Q?bXphpw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f75ff19-b2ce-4a54-917e-08da8466b5c6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 17:49:50.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2UOLn7VC1eePMbaQj01sKvwcKjR3bKKeus09aNgRA8Yyw6kZUrWYaAyfXvTDVfrPlXZKqdFUbVGFX1QXehtxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8449
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

dai_posn is set but never used. Initial intention was
to use dai_posn to shorthen one code line but it looks fine
without it too.

Fixes: c1a731c71359 ("ASoC: SOF: compress: Add support for computing timestamps")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/compress.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 174b3d8e67dd..c8ae778a50d1 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -327,7 +327,6 @@ static int sof_compr_pointer(struct snd_soc_component *component,
 			     struct snd_compr_stream *cstream,
 			     struct snd_compr_tstamp *tstamp)
 {
-	u64 dai_posn;
 	struct snd_sof_pcm *spcm;
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct sof_compr_stream *sstream = cstream->runtime->private_data;
@@ -336,8 +335,6 @@ static int sof_compr_pointer(struct snd_soc_component *component,
 	if (!spcm)
 		return -EINVAL;
 
-	dai_posn = spcm->stream[cstream->direction].posn.dai_posn;
-
 	tstamp->sampling_rate = sstream->sampling_rate;
 	tstamp->copied_total = sstream->copied_total;
 	tstamp->pcm_io_frames = div_u64(spcm->stream[cstream->direction].posn.dai_posn,
-- 
2.27.0

