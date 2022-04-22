Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D73150BC88
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354133AbiDVQGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiDVQFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:05:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2092.outbound.protection.outlook.com [40.92.21.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45255E149;
        Fri, 22 Apr 2022 09:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAopLuNi5ko5M29QRawPZImyb9K1aDn7CugSvUcvlDNDwysHZEuWV5JfqLs6xkKNkUHWZ32Qt6WXwC2yoF39MlbMARGbHvwZz18QsYYKhZdEIHNRVad6fPoArvSwDf29Ze2xFSSBIjfxrrWYhEk66cXOCETT51qs2OW4RELGmDY/WkMJLXIGqchKEOfrehkxANTBdeo8arm00SDiC86Aztj/Ej3tkWWGzlK/3gaNZfPvlqILj3TNKadT1xeNpHVWlqJbY82v/XbRQAIkpbz+VZ7704gstjxXbZP3QOMm+XU97PV20gLbVGT9uySsLxwAFq2Ea/hFd0o3wP5+IP14ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3bO13YmCabNvWf6OwNKP2sas0CpiP6jg/J18b8Pz0U=;
 b=IZAc3wOOIOgXwjr5oXuZ+RVOiEi51AcvQKJCBoL6dTDSEbHd27kbJ9o9mCy6X0Kx2lc/vNPegfUUoA98VqhTFJlDC5CcFJaciz2BX0JbQsizLrzoDrRDAwNRGwQowGhsIGInVsM1p4d1cOx+gKFMhghfLuiSJcmwcvG7bcZIpj9NMHmuRmL1uAuH5nDUA4kTbBhjk3XW31Rn9ZRkYfvMVUvi13nrrb9CzTnKdpTyZFXXKUJCcd8d+ctPhm39dZsMyEeb0lsHQqN30amwwFVtcGjHT3kO/nEkN+IKdDsup3YgZ7AxMftlBJ/SkOnDdq3kzJMlCVd2vM4jXAagc55hag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3bO13YmCabNvWf6OwNKP2sas0CpiP6jg/J18b8Pz0U=;
 b=mxm9Dk3Iy+mMp12lLYYfeKSYjAL/lhFRIllvOWMUrrFB5JUfLN3M4nDsAMshRxRkmR6FAF45U7nD1UmTiYhAfghiNP8X6b+iHoPpNFEHk7lFLtD+dDjBknuGB9raOVK9h5c7rV92nEfGtBWWYRHcktWiyn9AfGorliOQwc//ECiBHRt+V9m27eCC7HNBTY3f5fY61KInkqKxtgPouVDi5Cnbyd2MiEtI6q2AnT4LcqWBn3Q0FvrreKNH/3qC/IPdLT7FKRRbvvq7dHfMNfX2vMHYrCTvGvFBDu5YC75mH2ZGEVj7eAQDoIBIGrI/nLx8S9JI40n2n8eiqTdnSFKBbQ==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by CY4PR2001MB1685.namprd20.prod.outlook.com (2603:10b6:910:68::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 16:02:58 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 16:02:58 +0000
From:   icenowy@outlook.com
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Icenowy Zheng <icenowy@sipeed.com>
Subject: [PATCH 1/3] Bluetooth: btrtl: try config w/o postfix if postfixed one failed to load
Date:   Sat, 23 Apr 2022 00:02:29 +0800
Message-ID: <BYAPR20MB24723A54E913F0218DF87F83BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422160231.1072810-1-icenowy@outlook.com>
References: <20220422160231.1072810-1-icenowy@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [GLyOAnXyVB6IjTCN6k0tBy6bpZ0TJQdv]
X-ClientProxiedBy: HK2PR04CA0070.apcprd04.prod.outlook.com
 (2603:1096:202:15::14) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422160231.1072810-2-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 933fa029-322c-49fc-5382-08da24799129
X-MS-TrafficTypeDiagnostic: CY4PR2001MB1685:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPvqHwjKGA4AVqI353HHT/lq84Zlm4/36LVYg7cpEwE4I18G2RyDIhQt0+DBAfBtLa2nidbu6Qmi6JZEZpSuMRCQkKTe3whOwV9DQd0DAelCWcB5UFYEwJvs0zwJOfZGDf30LkZ8WkAGlj89HGQFgjGtEJTvclBLrTfUV6vU+lxJGjV/GhNrpI+7J9P/mJ55mYyEC7QntSgw4lmFZ42ISSEbXLdQfugVZ9iwbrKyHhssQJN0rlwf3jY1L83DZkWkjXUTs5uzVPAoOUpZqnUd3OriEExcL2AikW6wBPAOlu2KdT9k4l8KXx2ak+ylGHld0u5nxe5PK8OkcnOUicp+Ya/C0Qu9lsemV6pn53nwvEBpd8oD6O/WQnjqgEe6HedRrj5k+AVbageaGIq8MjCcHnKFH8KaZgexmlzuyld2YkV4rKMVyYrfH7T+InSr2KuX54OJMl2UMUtjU61ZSsXEEbGfS1rmLgJIF2J1MXnT1nO9P8gE+xn85WUQ6963lHF49v5H6NA8pK/YxNrjyIY5pYVoyXvy9TtZbRz115Ris+yOOuMtzlbufSJCcff8o6mxlmQxgbkoCjmBNSh9TVw69Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ItorM44UEDUGHTx4Uu74GSwxYyqsrDwNeChU/zm4sJ7cFF3U/RhUZEnZLpx9?=
 =?us-ascii?Q?d7Vj30eHjjDrGah3DZTrFj/gLXkRrODCAvzGt4AmtfUmIyqK6Q1evlCNf43L?=
 =?us-ascii?Q?pQFlTZAAlnCmSFc7k+Om6ZBCaSmKKMH/+cs4d19GN3QlfO/OjJ+MMz8xeqkz?=
 =?us-ascii?Q?uawqbM2azJJPQx2g25qB3cauglAh5YZt/lUH4mU7nt4sCuL1TeNKE2g+q82d?=
 =?us-ascii?Q?49mjhQ7BDkP0kAuMLnksnpBh1zjlWt4V1rrJYP8Wj1IhYX88NNsxMijw0nMi?=
 =?us-ascii?Q?27Ry92e8jfqJfKJKTtD6sfolPoyvS5r6lLQ57QQrgfcM3k456xWQufImvD4I?=
 =?us-ascii?Q?k3oqkI/2Lj50te9Vd8K3JQonI1zrFdLihNSwHdw6UNmfWEMA81pL/EtuAbqT?=
 =?us-ascii?Q?vnVRH6OSD4DwsxyMOtQIfSbfeOj3c2cf3PiVRaRm980t4vVSjaZN3h+Kasdv?=
 =?us-ascii?Q?/FcHl0Cd0C1TXsAoOWd0+V8XqEtW+pXojKoRhon0trkiRhWxuxdg96qNrVDn?=
 =?us-ascii?Q?jtZFOgr576+hwttoC9cvGsJUDJRToPzcgtFnNQqnjbttO2i0kL7tQeQDUK4n?=
 =?us-ascii?Q?O5X1v3v9uIBHc1QDcWz+wGZ9zq15ONJo6J/i1gJz8PQ2D9E8h1ApvhZzNX5m?=
 =?us-ascii?Q?gGqUIjEPlp+QmzlDLAqzwJrgCE4VWLHFaMOMMslizouGh8WaPbrd5eWPcRuC?=
 =?us-ascii?Q?1ZnEYxV6I1U/Nvq7iMgRNww30fmqACxGqdGuk3X5E3+fn2HixIEiUcFs3mmq?=
 =?us-ascii?Q?Go41dhD5dMyhU0I3dheDoNh03qXp25bgAZjFh3Xv3ulKhQ1ZpPmPr34Bnfbb?=
 =?us-ascii?Q?jKquxPzZE6MKhr4mSosUPV7zsiCQAvO36Su9uammSFYJGwAlOU6lDkUoIc9S?=
 =?us-ascii?Q?T538USo0IowSRLo73ct/fuMiE8KZTYyNL+1Uarzhs/q2nq2bvfAWQG6KsTvQ?=
 =?us-ascii?Q?UH6pon4BywLE+JCwQqA5yjeReEwaXFclarU2J7pNmaCkDZqgb3Bb/PMAMPEF?=
 =?us-ascii?Q?fSTTWHayChdmduBAoGCX/ql8RBs/vum12gz5BqbPTtpUi7fbQBKoQ33A1nTk?=
 =?us-ascii?Q?lHWU7R7jb52gHe21u9AtCc7iA9yeUAEvq0epHhrifUSemmIdd+zjONN2EH7F?=
 =?us-ascii?Q?oKMOdUyn3ICY6EvG8m+LMopQAA5AKmmJ514dspi8oEt/ySVtSjhndnZoDhsx?=
 =?us-ascii?Q?EQOQFd3Qq8VcvKZr0qZZuFc4maj7MUgsn4TMBbZ6L1aR9kneYlEUU8Fv67iD?=
 =?us-ascii?Q?KeH+rdnG/MAjURPspnEqfdx2lsBOFxHtYGmpMEg5PJ49Ryk/QMt5mU3GOFH7?=
 =?us-ascii?Q?DVpD18N6AkEpPWSYZqL52mFMU56s+MO773iujPnf5GhIMIdcqniu0+TK0UaB?=
 =?us-ascii?Q?7Cw6witVyRypFQg2T51u4UGIJuXUbrobq5ibJgai/CS7GDwofixeTJ4hskn8?=
 =?us-ascii?Q?E7dGJnmjy34=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933fa029-322c-49fc-5382-08da24799129
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:02:57.9830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2001MB1685
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@sipeed.com>

We should try the non-prefixed config file name if the prefixed one
failed to load (possibly because of it does not exist).

Add this behavior to firmware-loading routine.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 drivers/bluetooth/btrtl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 481d488bca0f..1f834513762b 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -699,6 +699,12 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		}
 		btrtl_dev->cfg_len = rtl_load_file(hdev, cfg_name,
 						   &btrtl_dev->cfg_data);
+		if (postfix && btrtl_dev->cfg_len <= 0) {
+			snprintf(cfg_name, sizeof(cfg_name), "%s.bin",
+				 btrtl_dev->ic_info->cfg_name);
+			btrtl_dev->cfg_len = rtl_load_file(hdev, cfg_name,
+							&btrtl_dev->cfg_data);
+		}
 		if (btrtl_dev->ic_info->config_needed &&
 		    btrtl_dev->cfg_len <= 0) {
 			rtl_dev_err(hdev, "mandatory config file %s not found",
-- 
2.35.1

