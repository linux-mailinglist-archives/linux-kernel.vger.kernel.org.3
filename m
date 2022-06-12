Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416DC547B8D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiFLSqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiFLSqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:46:11 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2128.outbound.protection.outlook.com [40.107.113.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5665C852;
        Sun, 12 Jun 2022 11:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+De3cEIfsDR03NDNbO+gweDvQKrjzBiwXo+OdXK2qGLo44Av0HoJ27Uq6nTjY38n7ZvWlFEUa/4vmSSbQ3ZhwxVXsuraKlJp4NuDk2h2b8Bn4x3uQnZ7TG9sIC2Uu5zljtTj03wN1lCOSXnGGY+nxFqnnrv2Dm0RwD0v5w7UCXKqdSGEZTo9TNoSq+fi6U30VA5zFAs9zFk0yVGFnMjjyk7fAUM87PAhzPKY54v7yR00/Z7tSfE8LJQ7cEtgjaVEtGhR7cbTruP5xr/V3qNTUp/3uBYtc1AnDO0l2yZ9gtUaZbdml4yF/yeLQwyZuQT89RWjh2qxsu8SSEYKqBv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brpvWS+N7MgNh3jBCMf3aKScDepuut7lnRI1cHbwcGE=;
 b=dH6p+7iDBfJkynyMZd+6m2Ec0iwImKYRSau0R/aNBr6M520vVa2w11llWS67m/EAsxY4POxK8PR50Ti3CBgK+sa5dltrtodt9h9bFGeQY0QQE+TIAtTq5ILoze1W9EPum/tUcbRRJk3ukms3ob47I65n0EXPTn0COJ8ro/Z27wxPcB0jYxmJeP3/9NrPOBPkpwPoLyF6LktAkNggod4yqMB6HLTA7dPKPMYHKrf63XqUqeUX+Izc1rb2nfUbr86dlP+KX9CdPBWnfG0QZFYYg/SqeVnBfeD6Ww0fGyztG4nGofcIAeV8ilD48rM0mDnGWBoJ/GL/wNI5Dm4zG2tj3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brpvWS+N7MgNh3jBCMf3aKScDepuut7lnRI1cHbwcGE=;
 b=JK1/KI3nYQ4Sbwm36jZRmBU1pDBbqgHZZbGFiooKho/JJ5h5N8JJEGWff9czs+c09MQbu2S+ZfBN7chzskLI5tmcN0wSKReVCIuTVYMH3LFBImx9bDPhKRlfMTpvm0dDtNBNTfSFntFlBmjIcv/i/PSrVJ6LojNJO6hTCiEnKak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OSZP286MB1063.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:111::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Sun, 12 Jun 2022 18:46:08 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a162:2f17:bb41:c95]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a162:2f17:bb41:c95%9]) with mapi id 15.20.5332.020; Sun, 12 Jun 2022
 18:46:08 +0000
Date:   Mon, 13 Jun 2022 02:46:01 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>,
        Heiko Stuebner <heiko@sntech.de>, Conor.Dooley@microchip.com
Subject: [PATCH v3 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <YqY0aSngjI0Hc5d4@Sun>
References: <YqYz+xDsXr/tNaNu@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqYz+xDsXr/tNaNu@Sun>
X-Operating-System: Linux Sun 5.15.26
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: SJ0PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:a03:338::13) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91bf3cb4-e7c4-49ff-5047-08da4ca3cfe9
X-MS-TrafficTypeDiagnostic: OSZP286MB1063:EE_
X-Microsoft-Antispam-PRVS: <OSZP286MB10630638B077C8FA911288B6BCA89@OSZP286MB1063.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYDujBw8XQWEobSojBOybYV8ihRIA7FDV+bCx+WCXPxzVMkEKnuD1sCjeJiZWfmw97tqkor8xAUP818K4P0eY/5XIDvgzHhNuEgvdi9leVUqPqf0r1gu1H62MFdQZRBBmzt7SeoyeMs7N/Z0oAw0kme6VAr8GRht/MNn41s0LbAkYvq7wQX3aF7NEXSmjz74GUUhDWNkNMU+bS55+RYcyh8tpwIJJXFxWmsUhXlPKfxrFEKJtSkPEoqWAAKmjLE8B0bLZQ2RIlHmQ5VodGJMnKerOf1Vb/lqd2C7OKp8C4VzBpMdCP13n+501zjsEGqDOTXAd5xhPz00/99+gIFRjofbTwakh0f1C8RZgD7ogKQgkMUDrWycgTRMAOX7M90Su6cRNjD/3gjmYJAkbvoTZK+Eq9ArWiaD36KT8K2PdnfzkLuUE/B2YjX0Sx2HFMR3sqp1H3dJbSxuDr1Y9IBkcRdNiRYdAofGo0HTBrlRxsGgvCi6OOxEEXekL9gfp/g7B6qiyKWlfF5xBYtwxQPfpTGfcm/HPr2AWG6reTNlTIiS9yUCzhkY/OkMCMdGPwyZY2Gnzx5mMgXVxD6iOcXeL3rP7I2EKy83y1iJ4F2PQHTYzZWkOt6seDMngGeNANnSp13r/oCRtSlh2PgyxbwSv5AeIzAxtBanwkEqmaTFICgpAmwuJN8RArJFCxq7v33GpS33s/xIGvKTx8I1/ldTfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39830400003)(366004)(346002)(396003)(41300700001)(41320700001)(6506007)(52116002)(9686003)(6512007)(6666004)(786003)(316002)(110136005)(54906003)(66946007)(66556008)(66476007)(33716001)(6486002)(86362001)(508600001)(38100700002)(186003)(83380400001)(8676002)(4326008)(2906002)(7416002)(5660300002)(8936002)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f0dpepDlFfOr7Dx2WxPi+nK57SlypF53yNyUyQM3K6KXn8opXvLPQxIHrgRQ?=
 =?us-ascii?Q?ho1MKbA1UiVDyzQJQcMxtqqc9a09ovc4Mhtjaf7UxbYGXnx5rFoKXZYPkXnB?=
 =?us-ascii?Q?mZ5aHTMMo9ASVtBVAwEzG33yW9j+zWrmOnlxCqWlku+TO2nkEM087nm/0I6v?=
 =?us-ascii?Q?ytSM1Prqki+JqyT2uG4vzAaWbmtcSInt1z4BaYBwcydnd4kebsm9uR6lefaV?=
 =?us-ascii?Q?8RIAVbmCOwDnhF/Km+GiCni1SAb/MtAQhxfH29El/x5qpJacSsz/DEn1Q2zt?=
 =?us-ascii?Q?Ph1XdhYVYOtStJw3Z004MMVa6IAe4DL5vqlSMTaWhNGUpnxTBrJpVJfgOuNF?=
 =?us-ascii?Q?IgMrwbP4y54oknmQ2lBCIrRxxsQSURAzSNuKpyIpgsjgonbT1mYf/B7+VlmC?=
 =?us-ascii?Q?KwMO5tj2B0I+rPzjpRTF0sDUOAqGrRosBdPkHp/4pLQJK3eUmmHm4THzmukj?=
 =?us-ascii?Q?X9ZRyFIj+YFORoU146bgoD3a5PhcxqQg43UnJq+/EIR0jTor34O7uRdHvao2?=
 =?us-ascii?Q?1NA0+pt2GVawcFwunAZkNfkGOC8/isgjsxcDv2lHd3WNxUHqeII/2O4qVEkU?=
 =?us-ascii?Q?9u9kfpiYjxzFd1GJvgQ0yOYQ0NeS98449EleYYV920ykBqPE5kUtCWQw6l4r?=
 =?us-ascii?Q?n2CyA/tF32I6+qlA/5EiuGf5GvyRrvoIl0MevV9gy7cC/H2UIGG4xIo0lNzy?=
 =?us-ascii?Q?TmGAxx7zgvJlgsZN1Xy1eLqkapL93xCgk+quci6ERlH56okH3OTDbiSF8oIb?=
 =?us-ascii?Q?Q+GHeDb+DymzYh6tKHWqPkdkpZwoLZfITaUlLAIiC0S7t+wN9RX7UMQukAmz?=
 =?us-ascii?Q?FPyNFSLJ0uM6+GTwfzh5+JI2nHZdDEHA5ja/qFHZRe8Y3hDRI8l8xlFiJjet?=
 =?us-ascii?Q?EksqxKg79BiPUdtU5f2SYpZ/w+NGbY2/3fzcoEKeYWRhcd6yoempJy7/qAg2?=
 =?us-ascii?Q?whR1807FreGpxKnR3aP/g2MuSDGamC0VIfAzSn0vi9qktSkMIdpGvwzmyHwN?=
 =?us-ascii?Q?g/Bk6loUbF6JYHvn3J/1iKRUPvOwQxqghFspjri4ekkH2gq9zspiSBPOYOV/?=
 =?us-ascii?Q?O2HntB0jvpWdJvsVy/NRsIWGeKOAUIQ8c0VT9xUMpTTkdIo2NN6S2dyZLN9s?=
 =?us-ascii?Q?SVSprZbz7mTTgIOel22Pjb9VcNSeqJNTFKvpSMGMOfyd8EpluubgOFDfP1Z8?=
 =?us-ascii?Q?tK9D7B+81UJHr2zlwA/YLAb8FEEbqH7b8y/evRnHbHB1xBmhndEDDw66I6DT?=
 =?us-ascii?Q?e3Tle//HYROpfJ636WjyKDnhJc+p1zWGOVNsa5/NUZbuPPWNhdkNbUtLlBak?=
 =?us-ascii?Q?p8h0+jeyG2kyOiTzBfA+bCZ2h8vy6PcrBQ5blDwTOTncfye1Jjp4sYGqdRT9?=
 =?us-ascii?Q?y06cYIDvpIVvChuCY7v83435a99TQ2KOTvtXpg87E8RjcP6GaOOmBgBSSrh9?=
 =?us-ascii?Q?f+GDqo29hDNJVVe9mqwKFVFWrh97eqPPvMAJzVZIXji93egBGCxCfOxPFmPj?=
 =?us-ascii?Q?vFDm4q1GJDeNEUbpbm0GvXJOcCvVR8coyQQJ+PD+AdtNXfH+ImT1dXcp2+8O?=
 =?us-ascii?Q?9/s1f4YOWSwlZiGQAirHI2QUJ/OLpMzUEiuSooTauWQswuWucKcKNDbCwD2v?=
 =?us-ascii?Q?0unQkyCR5fbvyuqDD6tv7Ih9zcs/UZK3XGwlrzfNLW6BDZF65W9O2xDkaQVX?=
 =?us-ascii?Q?G5W4Vll4UlcvyruW+xmUJbdMX+l84Go2znOhYdInms5F7H3d1kzj7DJaExs8?=
 =?us-ascii?Q?GQk+Gvb8Cw=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bf3cb4-e7c4-49ff-5047-08da4ca3cfe9
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2022 18:46:07.8681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtWgEDIh4FsCz/dVw/DW7mID4ik0XysF3WhqgeGYW4KXUcMd6rzsjA2RAgCVvZwy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch parses Zb/Zk related string from DT and
output them in cpuinfo

One thing worth noting is that if DT provides zk,
all zbkb, zbkc, zbkx and zkn, zkr, zkt would be enabled.

Note that zk is a valid extension name and the current
DT binding spec allows this.

This patch also changes the logical id of
existing multi-letter extensions and adds a statement
that instead of logical id compatibility, the order
is needed.

There currently lacks a mechanism to merge them when
producing cpuinfo. Namely if you provide a riscv,isa
"rv64imafdc_zk_zks", the cpuinfo output would be
"rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed
_zksh_zkt"

Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
---
 arch/riscv/include/asm/hwcap.h | 20 +++++++++++++++++++-
 arch/riscv/kernel/cpu.c        | 14 ++++++++++++++
 arch/riscv/kernel/cpufeature.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 4e2486881840..02c454a12683 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -49,9 +49,27 @@ extern unsigned long elf_hwcap;
  * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
  * extensions while all the multi-letter extensions should define the next
  * available logical extension id.
+ *
+ * The order of them should be maintained according to the riscv-isa-manual.
+ * As this is an internal API, changing the id of one extension does
+ * not affect compatibility.
  */
 enum riscv_isa_ext_id {
-	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
+	RISCV_ISA_EXT_ZBA = RISCV_ISA_EXT_BASE,
+	RISCV_ISA_EXT_ZBB,
+	RISCV_ISA_EXT_ZBC,
+	RISCV_ISA_EXT_ZBKB,
+	RISCV_ISA_EXT_ZBKC,
+	RISCV_ISA_EXT_ZBKX,
+	RISCV_ISA_EXT_ZBS,
+	RISCV_ISA_EXT_ZKND,
+	RISCV_ISA_EXT_ZKNE,
+	RISCV_ISA_EXT_ZKNH,
+	RISCV_ISA_EXT_ZKR,
+	RISCV_ISA_EXT_ZKSED,
+	RISCV_ISA_EXT_ZKSH,
+	RISCV_ISA_EXT_ZKT,
+	RISCV_ISA_EXT_SSCOFPMF,
 	RISCV_ISA_EXT_SVPBMT,
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index fba9e9f46a8c..d9ff9bff3d45 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -87,6 +87,20 @@ int riscv_of_parent_hartid(struct device_node *node)
  *    extensions by an underscore.
  */
 static struct riscv_isa_ext_data isa_ext_arr[] = {
+	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
+	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
+	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
+	__RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
+	__RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
+	__RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
+	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
+	__RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
+	__RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
+	__RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
+	__RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
+	__RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
+	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
+	__RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index a6f62a6d1edd..0c2638365ec2 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -199,6 +199,39 @@ void __init riscv_fill_hwcap(void)
 			} else {
 				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
 				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
+				SET_ISA_EXT_MAP("zba", RISCV_ISA_EXT_ZBA);
+				SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB);
+				SET_ISA_EXT_MAP("zbc", RISCV_ISA_EXT_ZBC);
+				SET_ISA_EXT_MAP("zbs", RISCV_ISA_EXT_ZBS);
+				SET_ISA_EXT_MAP("zbkb", RISCV_ISA_EXT_ZBKB);
+				SET_ISA_EXT_MAP("zbkc", RISCV_ISA_EXT_ZBKC);
+				SET_ISA_EXT_MAP("zbks", RISCV_ISA_EXT_ZBKX);
+				SET_ISA_EXT_MAP("zknd", RISCV_ISA_EXT_ZKND);
+				SET_ISA_EXT_MAP("zkne", RISCV_ISA_EXT_ZKNE);
+				SET_ISA_EXT_MAP("zknh", RISCV_ISA_EXT_ZKNH);
+				SET_ISA_EXT_MAP("zksed", RISCV_ISA_EXT_ZKSED);
+				SET_ISA_EXT_MAP("zksh", RISCV_ISA_EXT_ZKSH);
+				SET_ISA_EXT_MAP("zkr", RISCV_ISA_EXT_ZKR);
+				SET_ISA_EXT_MAP("zkt", RISCV_ISA_EXT_ZKT);
+				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKB);
+				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKC);
+				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKX);
+				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKND);
+				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKNE);
+				SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKNH);
+				SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKB);
+				SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKC);
+				SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKX);
+				SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZKSED);
+				SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZKSH);
+				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKB);
+				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKC);
+				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKX);
+				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKND);
+				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKNE);
+				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKNH);
+				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKR);
+				SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKT);
 			}
 #undef SET_ISA_EXT_MAP
 		}
-- 
2.35.1

