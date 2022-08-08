Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D476758CEC5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbiHHTzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiHHTz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:55:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2124.outbound.protection.outlook.com [40.107.92.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690701119
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ka5Io++nI2OP278RfnWhoLoFE1Plzei4tZ5KV4ta38/HQsDM4kEDIK0mpi3Yrx/atxVUK5LklUnFAJbBdRGZnPTPw75R1oS7W7S5oLlQkQrulgUDOaRBfvp3MoLLQvmemn/nDZQkL8bQIbtGdO7JLkz5fyIxjFeFKcvqbTlGTR5DUbbtLSzPBOPWNxxhTfd0vd2Ioe500bKkULWf7qAqtPzMtl9F0E/he9g6cPOxW5ichOEwBUCqqTaw+zTR0K/UIHuyM7Dqr1ZnkzSjSMAykJhV6rUMsv5aJRU3rsmonI8bSqqewyDYGV1zEY3zsxdtsz7O0jsET3y5AR0GKp5ruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1IR2mHXp06ntq3cFrwwsjSHyTePdFe1K2KZL9zaMgM=;
 b=KDS92cLtbhI+obyVKvAsVSfkhco/93HKC4ozJQ0MRp52CIzfLgxy8S6IWzSi5IMjhphGnDuWVcV5KUBn4FjMGLK4cYrS9L5VwCue3yJASSAVCG2vzyzINGJVBry8eh1HNxxGycXLBaWYdp2Db9EZP350FcmqLmWUzPBm3/QO7VuFXwopA41fw/HF+KUDrsaP20RiahKZYTTJ8kNBN4BLwTpANCnX3Y5cqAxJ4/DfaGklQ4SYszafY/U9EYweNvdZxzKo+M0eCb0RaEODyL01RsaoHZO9JRL7zNbie3BaZBqHzSDYEhOdg5/8C8UtUnY7p1XHLxSATmmUFkg+8/FIcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1IR2mHXp06ntq3cFrwwsjSHyTePdFe1K2KZL9zaMgM=;
 b=nUpUTPBiQXkcPyQ/84YPQFnyNWas6Ua+FjugnuWecTP9tfsSHlqyNyIO8i5oXUXg690WUUqyJBYwdZtXfAeo1g3q5g1Dq1v8i7x/mwOmAGwO4XIzQsmgzGEcDZ0uo6z9JSm3IKyL+uv2jlDKphOdLKwLqfhWk2lQnZ+dfvwSJX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BYAPR01MB5096.prod.exchangelabs.com (2603:10b6:a03:1d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.17; Mon, 8 Aug 2022 19:55:19 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a0d7:4912:3c82:b0aa]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a0d7:4912:3c82:b0aa%7]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 19:55:19 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        patches@amperecomputing.com
Subject: [PATCH 1/1] perf/arm-cmn: Add more bits to child node address offset field
Date:   Mon,  8 Aug 2022 12:54:55 -0700
Message-Id: <20220808195455.79277-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:610:54::16) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6afbe557-4c77-4c76-f19c-08da7977eb94
X-MS-TrafficTypeDiagnostic: BYAPR01MB5096:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6oXlRgdCURVPRMgmk9ZHHPwEXoqhBXpReBJLnFyX+JDzoN3vxBlHHltn3MY8NNa+9IXa/MxsBOwDWpqF4cMLICrpXIkH+G0IX3eOCqNRXPelTG4zRQK9M5bbLHjVgkgK4DaNo7li+IheRmjMuMkis+Rya7ZOa4dLMIn8Ir0bqnp1pXjjlyQrFTrZLqZbZPYVC5hwyUWQwMHMU/pQjZvuVpQrB7ne9etS7hnwz3iP4inVGcVToPTw7Ftr5ZIG2v7+pTkHmJe35aAC9ziAtxy/LwjwHFNV3QrMv5EOJWj6UFmVZkZXTUIKq4AYCnAWZNQHHLCvhCf+1+OUP/s6BQHvdF2psY76aqchq/X5DhJ7QFeHNTHj7vO6mdSHBNfMmQ+4jWqvEKVI45QVR0Rd57K/Fhb0Xv1EOPgoOCS6ULzV0yjEhph/vEVjq6SUoueKuKopiKGug1F2Oj2upRFlaMWaDxS/RKai2JVPCvexTdq7O1gFkjhwJkHwleFlpENBSTzDPy1JJrBPPZXnrfS3SkgYvTn7L396xYe9wloYnsLVW+YG1g/Z1q3U96if2WtMMZNIUK9ljFb0AczrT/qStU7f5qIEelbHOAeVOOuv9qJiezYJoofb6ItI+DKvn4ZMF4xF+G9+zDPQ5SeEEYZu9PSdhzWLVKgF6jBJTvbTKvEOCLrKsRWZc2DwsvfW9WfJrqIadb5fOIeQ1AqcQa/oXNtRA8CZ2mhwALXkT/VlH16ZiSFCztnlgZW+pLV7YRT4nJ10kcykmIxadDRZF6/x0lSnSrtPBcfjfwsfWp2efKbmVEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39850400004)(136003)(396003)(38100700002)(38350700002)(1076003)(186003)(6486002)(2616005)(107886003)(26005)(6512007)(41300700001)(52116002)(6506007)(6666004)(110136005)(478600001)(86362001)(66946007)(8676002)(4326008)(4744005)(66476007)(66556008)(5660300002)(316002)(2906002)(83380400001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zQsHamR7bz/zmujCvSHe2TNLrPbt7y84wpAGr1nLaNPstxoEaYENa04zRw7/?=
 =?us-ascii?Q?ok66vUAO7piticRqctnp2OLXvLUU9vHczQQ0cUosxUl/6+mJrfi3nZyEibLz?=
 =?us-ascii?Q?iOTGsND3ZE6J83PpN9fmTz7uZQNeuhjvQLp5qXirV4SyIZSyj3xdUCs5r5JS?=
 =?us-ascii?Q?EsSdphvQF329dpbYcgkgXjGgbwh83vIeiYDqxqZ5IHgYST2Bh1D7su7ejJZ9?=
 =?us-ascii?Q?/BsvgJKp78+9HAKtbtZv1ctktoe+KkpNWGuA6vQbjew7gOtsEyBko9k59bKq?=
 =?us-ascii?Q?/Az4nSJdHZwUEbRvY3M+dp+tzlBrj5VTC46J/xnjJESVIDqasu6vGUfJdzIW?=
 =?us-ascii?Q?Ka639izWSvjGqJmF7gz6P+tAppdunuMu9cretEyIuHpQUS2HMIjsm9UTz4MD?=
 =?us-ascii?Q?tQ8autdTTxGHDrpGAnmFZtC8F3f2puTSqDp9ucwoIAuq6TqAxu5hp3OJJeEM?=
 =?us-ascii?Q?ok5M/RNw/ET0stoVzook9f+GO150nO/uX0wbwXH6flUYjAjjbXol1AOtEr/i?=
 =?us-ascii?Q?b+7iL2vaODGBZkQ5MmYYe8ApQAcGBGdd0bSw6LQRDi+QLA9ecbz2wp2PN8k6?=
 =?us-ascii?Q?K+kLIPJ3yauLX3/mgQKLQTpaoKIEWyOsEcLER2QlQv2WOcvwcmNp60eClFrL?=
 =?us-ascii?Q?8P76mLS05enJIlDIgKe9CpyMP7kMIkQaWCshwCOZ57xd82tutFQB5kbLrVxg?=
 =?us-ascii?Q?s+M+gODcCMN/moKLO/u9Ouo0QPXu/IVMgQyHNUxdN+LYv7C/JOVrHDbtIDR3?=
 =?us-ascii?Q?wBVO5nug4uxcWi2vBuJzP5m133OoMGH8iTq38rKBuziU0pgrsgCUYiRJxlE6?=
 =?us-ascii?Q?fSXhPEhepvP7RGXgv+bJoGU7pQmmc//PVT6a1RjhYK94JqF8ccaISzKQXadD?=
 =?us-ascii?Q?utFlV8m/JoVoPtHMx/XFjs6lE0NCdTUwW3yCrmc7+nXFeilhvjGTl/AhKVTT?=
 =?us-ascii?Q?0KqwT0ZHmx3afb77/0JBMIDFvgmKFBnMktFOC+beQw+nXu/tPWRVV9kcGdEb?=
 =?us-ascii?Q?As4aFi/q6BIrOsf9jkIcgtLny5eQaFVHzlMD31nGZr5Uy1Mk0SfAvGOMiqM2?=
 =?us-ascii?Q?x+FwKc56jhsyyAOS7eK5daWpatQCKm3qXgf0ZbrXfFMpGbDca51IMb1tsWtB?=
 =?us-ascii?Q?btF17GmMxpWcoA66r8DOApF3tpO25hBKXFVj4tZkmhg+UR/HZ/EIJxLzUUeF?=
 =?us-ascii?Q?MHD4wigwLAl6LTBhzQIFMJK0BgaAh+k1Icj1KFl8pbpDvESMY9itr8ALcGIR?=
 =?us-ascii?Q?NQzIQq89lwoBuWXkljnMo9L936KPn+2XDygmy20i67jC5g6IC2ynFCkD+DL1?=
 =?us-ascii?Q?8x30UMAW4k/DeGtiTyPy4QCiQJ0MLcjvoJlFNFBdWwGBXetxonGeU8iDFKzA?=
 =?us-ascii?Q?a4w+4h1youekCmS5aVrF4WBWbe665uhE/9tYQNMUEOlg8IagAO8clcJcbPBb?=
 =?us-ascii?Q?ftRaSU3SN9Shqb/OjgaDigXDswBJzpM3htAH57N6jCfiZ48A0eXBwu0JqOru?=
 =?us-ascii?Q?kcSLgy0wxvOFhnKtu9nEVEcVm1LutzLmHt0qMtAvA4x5RkPxLCbq9gDvSXqt?=
 =?us-ascii?Q?HpJbAkALWYSWp9zhtHXbIIGbMIVy9A5nTUAWEwTMzKehbbFkFyUlR2Unlpkl?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afbe557-4c77-4c76-f19c-08da7977eb94
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 19:55:18.9634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbzOWNmGz1WPorYNLZPqbN/gXoteTfO1oRCjJAm2SBMPt+e9Y/LNXmD9qkuPf/tNVj7gQ8Y4tSY7NgKlzNm16hK8q9EEj33EBJ4iXHZZ70lcMYrYRv8GHDN01A072TmD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMN-600 uses bits [27:0] for child node address offset while bits [30:28]
are required to be zero.

For CMN-650, the child node address offset field has been increased
to include bits [29:0] while leaving only bit 30 set to zero.

Let's include the missing two bits and assume older implementations
comply with the spec and set bits [29:28] to 0.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---

I have tested this patch on CMN-600 and CMN-650.

drivers/perf/arm-cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 80d8309652a4..b80a9b74662b 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -36,7 +36,7 @@
 #define CMN_CI_CHILD_COUNT		GENMASK_ULL(15, 0)
 #define CMN_CI_CHILD_PTR_OFFSET		GENMASK_ULL(31, 16)
 
-#define CMN_CHILD_NODE_ADDR		GENMASK(27, 0)
+#define CMN_CHILD_NODE_ADDR		GENMASK(29, 0)
 #define CMN_CHILD_NODE_EXTERNAL		BIT(31)
 
 #define CMN_MAX_DIMENSION		12
-- 
2.17.1

