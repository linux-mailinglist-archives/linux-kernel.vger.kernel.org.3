Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C1F5A2946
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbiHZOVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiHZOVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:21:40 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0272D1CE;
        Fri, 26 Aug 2022 07:21:39 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QDTkW5020320;
        Fri, 26 Aug 2022 14:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=9vvUEr6vYBXweMNa6hyTPiaf8qkBAa17EOXvWLMhCKw=;
 b=N0hs+VXUBBjU3p0MMPr1RF2FDjEzv6V+iilqqt+WkGkWUIYi6wGKChMOQKSuPDi6DLFx
 hHQao2IRn+rdMBsUSgklnTguiqvLWYVPlCV0Da7dNkbDX45K8u8Az244reDEKstzmcTz
 rDt6FUV5O54T8s28ksV8qqPIgTkQPeFU9TF+1uGzhb6BjI5p41xI5a0I/fw5//lx6dOE
 e+0aWUWQkXYmWsttg/g2LglBSqFXXJjconsYa/OuW+BC7vaspFGb1phEXR00pfUoufi8
 ca52Fzw+VE9N2hlXmJ+iv29rhy8RIZbDfOgi/oWI68ko7Nx0zE2R95f2U2yhR+ArjrQ+ Zg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3j53ryjrvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 14:21:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSVnSx8c9apIWKbdhljOieje1gQ3IouIrJuMitZsZ8Gk00w3L059DwWw48wOttYEHLlKrUEXgDtC6n8sv4jfS/lNGck1kp70KRu6pD4+VqoKz3zzqpVUB0yYCfZT0sNOeC1GmeWkqA/XDgvehoG9oALvyj5HgAyI9qtXzE2oenMyb+IhECQTJ6yyXNmyH9e22u5l39BmmN5W8nfFnKtdNUs/NdsoVz48dP2L+OYFIvLltLHrRNIV+iDZh667/Jyp72Pts9PB0YQ3XbdHsXFHe3lSl1YFaV5/QWMLRkKyCUp+Ogh92gHijinDdyykU+odfuHqmGPatOL+tobRXKbN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vvUEr6vYBXweMNa6hyTPiaf8qkBAa17EOXvWLMhCKw=;
 b=aLqCQ9/dA8u5KiIb8rpWT2gUTr41zCgG7QuU9tekTAAiDyrFiyiNzvDOryq3081gkn/h5Fw3Brmtw85nRWKbbPhrKw6A+Lxlc15ZT3rr6QkLd2lwYWLzU4/01xuiKmDa384pARoTw0bnT+HgJFZ5Ueriyd3mga0qgNkJBoBQnNPPMl49c2RzlBLqqgml6ff+3Sqze+zDXAjx/0fKYE/rhtYjwdwBvtQpgZM5mNuQPQnu5bsP1c74dl9YiLfMoCijbC3gvqrZ8vwslpVzJESPmVMF7S+NrxYFFwM+CwzVTWdsfggNsB9jF4ZoO/ykxArnGSO/sdhIew25G0dw381vdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by MWHPR11MB1904.namprd11.prod.outlook.com (2603:10b6:300:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 14:21:14 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::4057:7eb4:511b:e131]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::4057:7eb4:511b:e131%8]) with mapi id 15.20.5566.018; Fri, 26 Aug 2022
 14:21:13 +0000
From:   quanyang.wang@windriver.com
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Michael Tretter <m.tretter@pengutronix.de>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: zynqmp: pll: rectify rate rounding in zynqmp_pll_round_rate
Date:   Fri, 26 Aug 2022 22:20:30 +0800
Message-Id: <20220826142030.213805-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0108.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::23) To SJ0PR11MB5630.namprd11.prod.outlook.com
 (2603:10b6:a03:3bb::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75f50ce5-5b6c-4f0c-4c6c-08da876e3b29
X-MS-TrafficTypeDiagnostic: MWHPR11MB1904:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBJ05ko+8tFJlafhK19hTcZfjLkiwKmP+VfhpHwMGzvhZQimM+nXTRXiN3oo5XhFbkXz4W7BUFt8qLTuMEAo9QNj1AXlMtmjGe5+kQVRRDSjdXKaq5+zEgV9HZh7Zzi/V+EOc4HF//iKA6bIo3rGaGEphjpfzeYsyYFYIcO+uYDS59B+bvk2nChfPyir7kgUVFDFhs0X7bTsiMVmJpv9i8wHW7n5BhDyfvdYmd6lE5u1s5YLDLBjAXwQIjWtcvGNP19GGiu+dnQh7hDXnsD7DBtzbBk0nNegtLsh5a32xKOogaEUMhTNEPslS3Udq6Pyz2rXT5vQ+cDp9+GPbTKl9RXW98Mx6hEypB//inmrtpOoBYq04nymzEOzz1mpmh+rz2VuwY8mztRHVYDAEj3AzGEwTwuLYyCzOCYhZ8+Gwfd89GonMyfl6/Wcmp/mxJLGOAX8HKBaSIKCAuosmXc1g25DT/tRYwHRYHdeMBi+k+o0wVm9EhUICNX4lc/EVnSROIprFmM8399Ip97YkZ31y+5EOeHaV0z2QwePgMfDMp1uM33/NIurGXILBqRgzV2qXRi5IBdP1T5XISBoMcNbav+pVFCYSEVrhvlwpArP2SlfJVsyDOKF36vy8MQIP6/g5LJVcFXwNbNG4WAWnPsoS32kA3dk4ATHNSzGF6fUTFJe8Frg5NPbYFSjujL482feICeSIDbvbLH8NiBp04NeTJf2eLDwsJP+69mtGCEMYzg1DFxLh6ZypLEjcDsEFl1C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5630.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(366004)(376002)(136003)(346002)(396003)(2616005)(5660300002)(2906002)(186003)(4326008)(8676002)(66476007)(66556008)(66946007)(6666004)(41300700001)(36756003)(8936002)(1076003)(83380400001)(478600001)(26005)(6506007)(6512007)(9686003)(6486002)(52116002)(86362001)(110136005)(316002)(38100700002)(54906003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?627lhwWsKVSO3MqIbR9N6yUmsr/JAwKG8tRevvW9z+QLrbwEb28o5WUhwNd1?=
 =?us-ascii?Q?BNaUAgzj4PkW96TKrQ2UIZBQ0QMQ6AouUI/gW/dLvIgCaoI3Eu/HOMPTEaMX?=
 =?us-ascii?Q?Jfmy2N4uA7Z9nzXKgbeLgHtPS0nViCEwIahzZ8rrxsr+OcAWqVpP7Lc9VekD?=
 =?us-ascii?Q?7PrnXQVnHR5etE+P3U4YgOwxvSmuTe1ShtilOJsg8b8nLIihRbBMP+aw1xt2?=
 =?us-ascii?Q?VfA1HgDzwey8mVMEzpjtliCQNzQC93YawXplVx1l2iMetKhRkxSSxx9DIoza?=
 =?us-ascii?Q?ZbvcDd1wQMDrZf5BQKkQN92gLNJtjtZm7wZW1uCzd6uEkPxyMLysQwqopX3I?=
 =?us-ascii?Q?oPPRzgpQaQVDlJAgASoPwDeWw3Oyzl+7yPpU88QFTq5i0InrzGAvOeA9LCUP?=
 =?us-ascii?Q?L1w8v5U5PAT1n1EPHTa+Qnj19r+0FJvrZSZ4pmeTwUFE2RI6dgl6QHNtwQBA?=
 =?us-ascii?Q?5ttrTVohkGBCCX7tt3xafim8hMGCd3TetAAks/eBf/djaaXKWYBkH2R+YzLU?=
 =?us-ascii?Q?22MugVKVTaBCgjl5WvR4A+QlivE8qSKDDBDiYTkcjzxkVVuUy6qmOU7SGP1U?=
 =?us-ascii?Q?UVzSuA1PkZ2D38ejX1rqfIHS5UHiIG2ISm5v6L5BAhrzj1MAYUc27pOHIqJq?=
 =?us-ascii?Q?O5HJ1rTM/JHlcrhzCa1+Wy5A1wh9Od3R79pYjXbsvr0gEUT1L1kjj4889kFC?=
 =?us-ascii?Q?D7Q4GFI2j/+Cl9J2k9Mfq9BaF95ZSyip5aijOwa+vpu+HXPeLEPQYn8gOErN?=
 =?us-ascii?Q?D04vZ/ZYnZcDYwssBOnjsFFR36OIvM2E4FugD5vQG3vT7Z9S9XP/zp43AQz0?=
 =?us-ascii?Q?fljc0LqKP+o8NowjIRvOXl4IkTo5t4di/5v3yKG8XW6R7+0NCdyYnLED8Pbz?=
 =?us-ascii?Q?dKmmohnO8tiduPxbgmaoqxq9hNbJE8TEoe+PQPwu9UzkYA/XVUZUbj6IrsfO?=
 =?us-ascii?Q?RVo5PE+Gk6bHfVrobqgHKwKxuqWGcdXY9l0t1mxzDO0nXFsPRxh5O7iB7Imm?=
 =?us-ascii?Q?SxR2bAhxg6SNsKw6tqsU6P4SDAQTkwU03iKlVO1gKRupyITygkRSgi08J5GV?=
 =?us-ascii?Q?FUIq5mfHfNlHwc4mkiIeGSJ6LN6sTVN48/wyVKISyZYmX/YPZep1b4qxfigF?=
 =?us-ascii?Q?iFafXZHDRWkHbTUkImPjgrySDesaR3MGWokuLAcnTDP/D88hZUXeURXoSiFE?=
 =?us-ascii?Q?GV2WfIgWuhgf1FEh3gsi1+n+pu0a0dJ0GGzOgl73uxa99Zo1tlcZ1KSaUBHE?=
 =?us-ascii?Q?wbMgPefWMM8J4YeJFRbLCBYVKnuK3+woyUBpE7qp2rb5QzrJ4mFC0qP034Ik?=
 =?us-ascii?Q?ARMPFUZIShgIARCrReH9ndWFrr4MO/0ROWsNoj0UCSZbAKFmrz4FWKRe2ZF4?=
 =?us-ascii?Q?9NV72bxrliFqMZmpC5LVb8S2JYQ179vZjiAweWCKFQxpGxuNXcgtuDvfdp3t?=
 =?us-ascii?Q?omESXGroSf/W8+bUVbnpeIEDo9O6aPW9pPAjeaq/1DM4PaCJEuAygRkC9BXZ?=
 =?us-ascii?Q?txF1v+v5HFkVEGWfkTzgqewtz27ZgxcOMWIQLZx8E901XlQUrliG+Qt1LATH?=
 =?us-ascii?Q?Y2Bao7fs6Zk9F5WIzheFFpcvcLV/rjo9yk3bNNb7lzbJHG2e8sK2wpyoGTxL?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f50ce5-5b6c-4f0c-4c6c-08da876e3b29
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 14:21:13.7705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PM5zSm0VCA84mPM68bYSN8NqAd9Ldt2f4z8ivuFqbbIybY6kV6sGmudG/p77eeaNWfiWxgR7WBCC8813Sn3I8Q0v4TLv41WCVT0dNrsFkJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1904
X-Proofpoint-GUID: u4Je5xs2nxYaDVLhPsF6jDzG2HY55C_F
X-Proofpoint-ORIG-GUID: u4Je5xs2nxYaDVLhPsF6jDzG2HY55C_F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_07,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208260060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The function zynqmp_pll_round_rate is used to find a most appropriate
PLL frequency which the hardware can generate according to the desired
frequency. For example, if the desired frequency is 297MHz, considering
the limited range from PS_PLL_VCO_MIN (1.5GHz) to PS_PLL_VCO_MAX (3.0GHz)
of PLL, zynqmp_pll_round_rate should return 1.872GHz (297MHz * 5).

There are two problems with the current code of zynqmp_pll_round_rate:

1) When the rate is below PS_PLL_VCO_MIN, it can't find a correct rate
when the parameter "rate" is an integer multiple of *prate, in other words,
if "f" is zero, zynqmp_pll_round_rate won't return a valid frequency which
is from PS_PLL_VCO_MIN to PS_PLL_VCO_MAX. For example, *prate is 33MHz
and the rate is 660MHz, zynqmp_pll_round_rate will not boost up rate and
just return 660MHz, and this will cause clk_calc_new_rates failure since
zynqmp_pll_round_rate returns an invalid rate out of its boundaries.

2) Even if the rate is higher than PS_PLL_VCO_MIN, there is still a risk
that zynqmp_pll_round_rate returns an invalid rate because the function
DIV_ROUND_CLOSEST makes some loss in the fractional part. If the parent
clock *prate is 33333333Hz and we want to set the PLL rate to 1.5GHz,
this function will return 1499999985Hz by using the formula below:
    value = *prate * DIV_ROUND_CLOSEST(rate, *prate)).
This value is also invalid since it's slightly smaller than PS_PLL_VCO_MIN.
because DIV_ROUND_CLOSEST makes some loss in the fractional part.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/clk/zynqmp/pll.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index 91a6b4cc910e..0d3e1377b092 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -102,26 +102,25 @@ static long zynqmp_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long *prate)
 {
 	u32 fbdiv;
-	long rate_div, f;
+	u32 mult, div;
 
-	/* Enable the fractional mode if needed */
-	rate_div = (rate * FRAC_DIV) / *prate;
-	f = rate_div % FRAC_DIV;
-	if (f) {
-		if (rate > PS_PLL_VCO_MAX) {
-			fbdiv = rate / PS_PLL_VCO_MAX;
-			rate = rate / (fbdiv + 1);
-		}
-		if (rate < PS_PLL_VCO_MIN) {
-			fbdiv = DIV_ROUND_UP(PS_PLL_VCO_MIN, rate);
-			rate = rate * fbdiv;
-		}
-		return rate;
+	/* Let rate fall inside the range PS_PLL_VCO_MIN ~ PS_PLL_VCO_MAX */
+	if (rate > PS_PLL_VCO_MAX) {
+		div = DIV_ROUND_UP(rate, PS_PLL_VCO_MAX);
+		rate = rate / div;
+	}
+	if (rate < PS_PLL_VCO_MIN) {
+		mult = DIV_ROUND_UP(PS_PLL_VCO_MIN, rate);
+		rate = rate * mult;
 	}
 
 	fbdiv = DIV_ROUND_CLOSEST(rate, *prate);
-	fbdiv = clamp_t(u32, fbdiv, PLL_FBDIV_MIN, PLL_FBDIV_MAX);
-	return *prate * fbdiv;
+	if (fbdiv < PLL_FBDIV_MIN || fbdiv > PLL_FBDIV_MAX) {
+		fbdiv = clamp_t(u32, fbdiv, PLL_FBDIV_MIN, PLL_FBDIV_MAX);
+		rate = *prate * fbdiv;
+	}
+
+	return rate;
 }
 
 /**
-- 
2.36.1

