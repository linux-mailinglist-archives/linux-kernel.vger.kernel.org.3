Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B10D4AC02D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389147AbiBGNvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243146AbiBGNbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:31:18 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8B2C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1644240675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3E0gGfgAVd3/EyxWVzxOLBQNYi18NFRDlPcr8SDaQHM=;
        b=MRGaiCCGUVw2nwwOM9Q6WWH6Q81ID8dr+u281lfYurBlJqbJ7w4fzNkhopTEvkQezPRHhB
        Nt0tzBnGwutSvI4JVN2ou9IoIdKhXB2ylJUDZ12G9sOaqqXgCJaq7EcKnr7w7bdDcW++UU
        2cuRjesI8YRbTPrgoBRspwry2X3KJpI=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2051.outbound.protection.outlook.com [104.47.10.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-xd6vp7mMNIizN5W5QlcQ3w-1; Mon, 07 Feb 2022 14:25:07 +0100
X-MC-Unique: xd6vp7mMNIizN5W5QlcQ3w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcGfSrKaibBKPW4hWr6/xwZgLGICFNWcY8h1urf7yAMWIClB3gA1p0nlavw46ZIasJlTm1oIQ9VnHjJBPbrgrm1vCfj50u5QDlJshnJzhXyb1DBnknfEDgcFJArM7etjAjpB9Kbtlzz3c8oVRTlAL5WMyRrocB6k9RVsczy70kfPVOkblBs3FrtlJxPWb1faHl2jUmHWw/lHzBWufyI3fumAevJPGAjEcaa8bT2tWTr+LwiEQVEdZeLI7yq8lu41GKtyPirIUB0PJMW4zkdENxoiFv6ymRaOLrOie0E3M8NGMYMGb0sqFVZFgXOTKJPv3SlGMjqDQdRHeBrf2Fk6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tseiYH9roVSbkr3z6CQcWuouvSpB+D8wkwva2LG6giY=;
 b=Dff2OkJPcG8li4MDWUb8jZ/rGBsFFsqw68uDfKPPBLqACCa5uiCewdtN51Ozkj31CJUm3dlLbVmZVPqsD9GPGFnIONbiGJYK6VQ6C3ZltlwSP8CqU0oEPDAAMcuRckG2u+wEB6UWG0E48iW9dvvs8M4fwT6SEdHcaKO2oddV8zI3b8sWADxgXlPPPo4c3iWBKZGz/MeeKJpaKx9WYTx5TIKicJ8ax0hWaR4BvGeEuJhlRo9IPVs18LWiPCdujiTFMgPtp4nyKKTqI2q31U1V9jTh51fXulx0MPXgWiUVJd5C6qQDW+xTIb6PLjTIRt6P7R+TNmq0QfesL45ewWaydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 13:25:06 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::e14a:7928:ecd6:f233]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::e14a:7928:ecd6:f233%4]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 13:25:06 +0000
From:   Chester Lin <clin@suse.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Ciprian Marian Costea <ciprianmarian.costea@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>, s32@nxp.com
CC:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [RFC PATCH 2/3] arm64: dts: s32g2: add SCMI support
Date:   Mon,  7 Feb 2022 21:24:43 +0800
Message-ID: <20220207132444.3653-3-clin@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220207132444.3653-1-clin@suse.com>
References: <20220207132444.3653-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM6PR01CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::14) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f32adf9a-2617-4a98-0867-08d9ea3d4143
X-MS-TrafficTypeDiagnostic: PA4PR04MB9248:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB92485C63D244C2027B5E152BAD2C9@PA4PR04MB9248.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYj3sKtar8o9eHnhet0YYrPmP46uZaHSdLjx9uqvRtySM1kVxhJkIjZ7NsVMLxn6/B6K3wEYHzuOWBgCVyPGLprBwJFJ1BJz83HpZXZzJB0hRqyiWJr65VfolwcWxf0rSFbZ1IQrCPG9SmwOVvWTw/OqFB/xs7vstLbx9uBPzGEYq5mM5v1uPo3VWGHBNEXc4rlNV6QUa2YUEHTK5sHCMQzKT9etroD65Ugwih/6DIjWlXJTPJEXv1oYvXDt7/hik5ZeSz0UBp7EmRP3hhd7yDwK2NIhPu4IT5Xn6yB+DKlwekyHyRyaQ4EZRySD/aQdDsD72syHxpBb25thw/Q+aiRz6r3gAxwIs9daeMrkFCH+muMvgLkFRLTfS4gXN4RE+3rdC7vtozSSU1olL9aopW0B6dk9dnQbycwHL3/FEas7HVm9VUzGXAKTnqslYrelhzSmO+/NAHCw9HvUFmh9uvYUtxk5M/BnE6dvqGDW+HY5uid1dG9KEHdERBhvr2JMh+i2wf/4JNO29HYYBtkP+oaA4aheI8tgL7p9FNWP8xVjbxRhNVSYn87bi39JYDiu+5KePxIS0GeHoL677PGieHLd717HsXcklvXaMonXUdJU2x5BgWYqQNxOUxKLFYMiigHYKitrVoL1v06QHvYSRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(66556008)(8936002)(66946007)(5660300002)(6512007)(66476007)(4326008)(6506007)(8676002)(7416002)(83380400001)(6486002)(36756003)(2616005)(1076003)(26005)(86362001)(110136005)(2906002)(54906003)(508600001)(38100700002)(107886003)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5CMtm15ueT4aKn8tTpgZe6pPpU1uGMo5/kRtUODzDFEhuDFzTXWY5Y+4cjOb?=
 =?us-ascii?Q?k47sDhX3vQsSmGeqDo2qgJuju1r2Gbwzv1DIZy9KO9dtl8Rf+Yqk1qXRVKck?=
 =?us-ascii?Q?zd9vsXh6uUGTy+YbI56l0qLDLBg0ZNH9Z4B7mgumg65T3jQmRLACLNuloBBz?=
 =?us-ascii?Q?6vbC+9fBPSW7G+WZSt5xqb3Jg5s2N2w1rbd+4c8fpg4g6g2xET1TKDal175N?=
 =?us-ascii?Q?e0ccn/gmFFhugn/+Z7r/TS6Gzb3FTUsVQ1ZFgLy43GiE2uxbwEUUGKP0sP37?=
 =?us-ascii?Q?wr+QWGAh67f8gqNJI5/KDlspZ6PPMZyuAp8yAUjmYsKp17mjltZGUaEFixIi?=
 =?us-ascii?Q?E+sz6SWXEOOv/ISB+4mbVpFW/NUrLVG1B06tOzrkUoE/NcTAl4SiD68aNofK?=
 =?us-ascii?Q?zGw68PaQcYviGZaii2VE/pTL6q+r9+Nt1PwhzSsv+T7Lq7pH/5hVuR7dLKSW?=
 =?us-ascii?Q?5DjaVCANqqQ959xZ49Iy+QKMMnCJpWfn0MnU9+WE0dtUUdw7J+9Zkf1bjxy8?=
 =?us-ascii?Q?2VgeexTFrtkNRoUMR83i67A02iaf8wEtdZJ7U44b8wnJxGfGL90kxNTsulXU?=
 =?us-ascii?Q?oVDI5H8GPe6G82bUyUsrm6q+IyU1Jed9+A2UiOiodnEHLbXftheOSEwiaq3b?=
 =?us-ascii?Q?o+ta8pPRv9kFN9nyL5ukSk53Hfz4DwCVQS6OOgQkuc2dyXkcyThZB5FRFwgJ?=
 =?us-ascii?Q?UGcQp8uxFeVBM7L9b+RfLNZBwNU0jtBiNXiNH3L77wnZOYDtq8y3sfb980Sg?=
 =?us-ascii?Q?GtghTWuWFJaG1a4xUDqrxUzIeHnZScwsy2YxxkJc9NvGqaV6qHf8j8W5XWOQ?=
 =?us-ascii?Q?WfB1axdd+Np3eb7+0wQaUZHndw+irsYkKhfSMw7XcfjSTwjbUg7NiWHy1FZj?=
 =?us-ascii?Q?7SJq5uPa4+6K5f8ctg1hsy3DJGSEg6dyPYelrwv4ILuOjaXGoN8s3afY7nuf?=
 =?us-ascii?Q?BvJwroHqkWDODMSe2Z/aDBdQAnI/QUHG3/uWFDWJPORF9Ov8OqOnLy5mZ3Ov?=
 =?us-ascii?Q?/q15nDhL4ydin+FC2Imzf1PDk75sDyMJaFL95/EMM7DF2AbGKjC5UyumeMip?=
 =?us-ascii?Q?YsfVFt9zLsyMs1eScxzxFCxTRRdiS5NW2IQ6Z18+jK15nYwnnMvNQbuVc2eu?=
 =?us-ascii?Q?elsiDGJfUYyi24YMs8hMjaufA7Q5H7Kk64U5JIJ3e5W3s9I+lFJ/AiYzSkfX?=
 =?us-ascii?Q?qWGPkhqudeYHt81av+DHbpUTEUafKDRSjbaCNiuGnGlhMnr3oSWw74AjWJNN?=
 =?us-ascii?Q?L8W6Sy7ZLjx+vp+gHWf0YPuNl5o1vHDWnVSjGxP+YTRDpetCKV2Lrmx90IoF?=
 =?us-ascii?Q?Q1Mz6n0jeLeDORHbLGZ9uUoNwfnxqBpnj/IY2Ooiyty2Uuf6bkqYFn4Y98/B?=
 =?us-ascii?Q?ODQeskexiy4+q4UWxOHtwdBLY0eGsZvRscMSLU7wALR2P8HYhiF9XOXCsd5K?=
 =?us-ascii?Q?Q5snPf01rb76lbezXboREJxL3XvQSYuGvkFo5gnXCXU9QVsJQ4IUa8CN1Vgh?=
 =?us-ascii?Q?zjH9d7n2orCEHvpTBQSznap9AZxgu3zbhxDiPhBlhkSJpSIJxxTTJtD8T89e?=
 =?us-ascii?Q?IllUGQQOg8KgeNxSfrY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32adf9a-2617-4a98-0867-08d9ea3d4143
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 13:25:05.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/erUT7S07F0Zii2bJs8zOToTU233dHq1D+NRUCr3RvquzD9deXatbNlwO2iZ/P/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a scmi node to support SCMI protocol 0x14 on NXP S32G2 platforms.

Signed-off-by: Chester Lin <clin@suse.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts=
/freescale/s32g2.dtsi
index 59ea8a25aa4c..34652d36a9f1 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -72,11 +72,37 @@ timer {
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
=20
+	reserved-memory {
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		ranges;
+
+		scmi_shmem: memory@d0000000 {
+			compatible =3D "arm,scmi-shmem";
+			reg =3D <0 0xd0000000 0 0x400000>; /* 4 MiB */
+			no-map;
+		};
+	};
+
 	firmware {
 		psci {
 			compatible =3D "arm,psci-1.0";
 			method =3D "smc";
 		};
+
+		scmi {
+			compatible =3D "arm,scmi-smc";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			shmem =3D <&scmi_shmem>;
+			arm,smc-id =3D <0xc20000fe>;
+
+			scmi_clks: protocol@14 {
+				reg =3D <0x14>;
+				#clock-cells =3D <1>;
+			};
+		};
+
 	};
=20
 	soc {
--=20
2.33.1

