Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C01F53412E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiEYQOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbiEYQOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:14:34 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EDBB82D2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1653495271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QZjltoaBA9zfWV8F2GjAxQeCag/sO3MguIV8wShMGqU=;
        b=g9rWjE33g1T18l6VP9o3Y9N+qVyhVvt1SsCbIMxxRn7hyX6DwgIpk5ra/V763dqyA0I4ul
        q05kNcxsmIcnJPibLx9l5D43cM2PyAo8verSfgL4KU5fefT/PVjTkf7SijxBRvbpcSTLv1
        FMRQahMJxnfwaUcNvUK5PPBEsw50158=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2175.outbound.protection.outlook.com [104.47.17.175]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-aKhtyIxpMm-RNIUXxgsPIA-1; Wed, 25 May 2022 18:14:30 +0200
X-MC-Unique: aKhtyIxpMm-RNIUXxgsPIA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGwnKtqaDiLk+It6YXxJe5xR2Lzu7H4v9TBN55lC5en4VhPmfVM7lBdRdOxwSMlgAKXy0P2HbhZnQcputWiif5U8M5dvp2rHhnQ+TP+0AnFMIouOA42eaBBanL3mEPqYpK9j/s1Jhqg7e7xOo+O5Ugl07iIY6MycrzVqj7QkoNC/FHPyE8zvq9aTkNjOK7A9T4Z+//9jnEUERkSukwI9+2GuYmGapwx7trwgz7G+FEZBBYgrMuY5k0JV2aziialHi/UxnF/WV6DMDm9Of8TqITEoZcKY0m0ZCJkFCQfuKeomTHpuKZ+8ujZqKBdJ4QdlGgyQBu1SVh9YbLsTZYW9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atSCzkiLUTLZWR/HGp+szuPyF+iJHX/EhlY2X0mkJ5U=;
 b=aDgmHx9n4WgbA/KgJCbf+0K1oCSRTei4ftGDyamKHatc4UhLobnMurMo2ugWnxyUwGejlTdMGmtFOJbvc2fK9GD9ELXq12G9ZLNjYd1IDwc6hnNofREm4DYdjRSupe/+ZBuoiQzn1ifgT4uQUYyekid6jppk4eFKmgScZKmZxGJNUCKhBiqYl/H19gj+WUAwwp7BYVjndqz2DkGzyHUiBCTM6SKI+6gt6lfmufyTnOK6bKGyZzKSnlKkMKiTa0ts7zD19faH0Lu3sC6JR4SjUNo92UYs2t93BKZL992hcCw4wTA9DAdatcN4944hmXWUMcJ7yhRAqAmJYh5vl7lHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR0402MB3950.eurprd04.prod.outlook.com (2603:10a6:803:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 16:14:29 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::b51c:9a69:6f99:65c]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::b51c:9a69:6f99:65c%4]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 16:14:29 +0000
From:   Chester Lin <clin@suse.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>, s32@nxp.com
CC:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chester Lin <clin@suse.com>
Subject: [PATCH] MAINTAINERS: add a new reviewer for S32G
Date:   Thu, 26 May 2022 00:14:22 +0800
Message-ID: <20220525161422.14156-1-clin@suse.com>
X-Mailer: git-send-email 2.33.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK2PR0401CA0007.apcprd04.prod.outlook.com
 (2603:1096:202:2::17) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a829b3c2-ee94-49c0-3e87-08da3e69a539
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3950:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3950419878968FFACF0A7E69ADD69@VI1PR0402MB3950.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHdjGrRUgHpLyT7VgYjQvXhpWeIYXPDxdPI9KWd3pxTPplK54mC+BR0hd9cO7SSwPlc9b+fwZJnXi2/YG6ITdWVMIj+0VigBqC1BM1hUdKJSq/f7xhMCeC/xJHZZuc0tv5To8824Lw8wqQZ8y5UR2l8UG1+Et2MB4zUFokCllCimfF/ZoVi2bC1yLhFpvQwtJ3wKOqWB8JfV1b+L5kqGSQuVWOHbR8vnjx8VrZpq9nkNj5PO0S6R9UuyVT9N8EcV2DTWFnJt6zy15u2L8MjHIPw5We+1TyaffkidjdphMy9s0xvsnD/zZw5BUyigU18bAS6H32uWUwz00nHoh5oza/jScwqPbtSM7qLkhihFPPRfL9LIKsHsEnV1w17UOQbZpa/P8J0QxmR0XYSMuxOlhFzzn+QBkSLTZeOlO0ApyHq8hzvNM+xve+3eHWVHOkXeaASzF3c+Iz5WrUSsYMzSZyKqPrxDRT3OrVs4uhcU46l+FhswLFPuppGBH+ki9e3OkyCYuyoj+dZMyH6WFIbCAKNpcsyDY+1IjGmfKbBcQm79SgFC5djqK5WW6ZHIrePUJB4FkcfcsDVVAcIlDopPWT/RU1/rC2nI3vOs4HrMHh7p8Jmc2MIzRLFrydxcZhBn1j0/fjHza0AXGqyLZkHyYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6486002)(26005)(6506007)(36756003)(6512007)(6666004)(1076003)(186003)(107886003)(110136005)(2616005)(86362001)(8936002)(2906002)(4744005)(38100700002)(508600001)(5660300002)(66946007)(66476007)(66556008)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VcRVx3T6NfnYSO5b4DHsd57n8swtRgGsPbagHmHh0fti1hlezmjX4BqIgpZr?=
 =?us-ascii?Q?XiqKaewoXf8iZFkmxtttHOYk7ibKdLZd0c2UiBlWZ5e9ltVkjZJE/7ClQnDJ?=
 =?us-ascii?Q?132nbnMDz1jVgbcsgIF8PvUBqpHc887MB8Bx3wYJnXmNHinATRfrxON9UVbj?=
 =?us-ascii?Q?16k3btUlvn0KStAf6ODj110CBD+sFp5uvwx3ZiG12xosgE1qK2oyJan8rhcL?=
 =?us-ascii?Q?G1jQ6kpUEJCTRJB6+MTicBEdtuXxstrqtBmMvVwX8pWLk0KgIqEaofmSk+0l?=
 =?us-ascii?Q?R/wB1aEn5tsljp+on2H0BuyAFb6CMzpB4u1qmCP07hSaypULbSrKs0Kw4puP?=
 =?us-ascii?Q?HDiFWz+htqoqEHV1bkYftk0nh/0zKQ9FlYn5Re/h1rZ0uYMJKzHaQuY/ePtW?=
 =?us-ascii?Q?UAY7oof9tvtBet4Jxy2dGI/FztYZeNgObNBT1ag0BveTICrmsQIgWp8/Bc2P?=
 =?us-ascii?Q?zcolfK//wxBuzL6ENfFDoV/3sIWTbV6qMDAX9Ksq/0nelSvD0oPfBLOzhJhP?=
 =?us-ascii?Q?ElxMmHQRDjtBaqeGdcCKPo266GtGm3p9uj43kb1RBPHz+cM9s5h7aOq2oTF7?=
 =?us-ascii?Q?nw0SvVwlC8aPhkP+RzvJ6fpZUk2QXGRsQXWMUdOlVmvbDOR4I72aKf/WxQpl?=
 =?us-ascii?Q?t7uPgSNilCg58YDpzkMCRZAApZV0nW9YBJXj9waLRzFRbGqJG18kF9vxEnEg?=
 =?us-ascii?Q?muf4ZTZua/k3+WYAasSTXZzpKeSdMfy4N7WMscCtugSUsr1dduxfeflVc212?=
 =?us-ascii?Q?rV5hFkJjSEIv1i6wpuNoBpQA7O8vq3RzJQxsLz7R0ophGfGea6FrRsVLOfSb?=
 =?us-ascii?Q?NhMH2FMvJR1j88b1in5qWCygYh4rXUqXgMNE0Yj3iQetaIp3/LwtGW2INUBX?=
 =?us-ascii?Q?CA1FwkeOtCKBpeGYd2twvuHqLLqqfSlGSBtK1BF82Pf2LaAiuBgpKS4BXndm?=
 =?us-ascii?Q?9NSdr4zVFw1QCuelUZmDXrYtiLdxKD7qiAL4ToqxtKLUdljYjeYLrLkNecEl?=
 =?us-ascii?Q?mljBx+Uuhehru5yd+Ejj3oea910JxFvdD1oNVjfYrZiqpQYg3c/VFtRyhGyR?=
 =?us-ascii?Q?JSkdQUnKYU+gcFvpjagO/KvIKtDELfdJ5F2dcPKXpZD1fIYTNlbExLskwJZT?=
 =?us-ascii?Q?5OH0uqHNy9uNSimUYOBfnOHa/NIj1v5sQwH9xuc/gnTp22FSv4ZhRe3rY0Z2?=
 =?us-ascii?Q?QgqlvA/Tsm9N6ZD8cxbQbbWzVRmXwU3ubHA7NdPnoYePbjuC0dEAlafT36LF?=
 =?us-ascii?Q?1pOKZLEIrygYjbJ7B9ZvMEg6TZTM6THcrJW8w5QRepJDfnOgKfQr7ggI5Rsj?=
 =?us-ascii?Q?3Llrkei9m90GYhxnD5IrS0KWHeNVznaHmC0lupR8ygW8lGFjFVquWqSS5so5?=
 =?us-ascii?Q?mpDlfsFDDALLLtMG69bhLqjS3Yn99RPNnmY5kYgGehgqH2CAPI6/gBLIUMcT?=
 =?us-ascii?Q?yIvaeHjojC7/mjD6heLZk72/3LFj6gbV4cXnezdodlT9OmafmtJYCjy4x6ms?=
 =?us-ascii?Q?pW6AP7GqoolV+YfryrHx0yzcNNHlZavTF7o1GWS8eLpN+6FE9dLaUlAalBgu?=
 =?us-ascii?Q?jTlzkBrANhnxm0XLSJV83EsX36JnXXWK24v4X2KVhKrZjAbvJRc1oW57tA9U?=
 =?us-ascii?Q?Ejmpqn39cqvIv3yHTz9qLOXcRS+z91j3IMjpWrZ4ycHhv5QANkmBg6mHonu4?=
 =?us-ascii?Q?FechK1fCodkuazt4kfvslhNenvl/9HZCEOoGh8Kr+a5DYuZ4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a829b3c2-ee94-49c0-3e87-08da3e69a539
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:14:29.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtMc1b9Qk03G9EaKGj1h2eGbWP+B1I1b17jHAzA46wRo/uGjUT64Gv49DRLhHrKO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3950
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the NXP S32 Linux team as a designated review group of s32g.

Signed-off-by: Chester Lin <clin@suse.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6618e9b91b6c..084be85957c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2450,6 +2450,7 @@ ARM/NXP S32G ARCHITECTURE
 M:	Chester Lin <clin@suse.com>
 R:	Andreas F=C3=A4rber <afaerber@suse.de>
 R:	Matthias Brugger <mbrugger@suse.com>
+R:	NXP S32 Linux Team <s32@nxp.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm64/boot/dts/freescale/s32g*.dts*
--=20
2.33.1

