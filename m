Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BAA52B625
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiERJZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiERJZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:25:15 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2110.outbound.protection.outlook.com [40.107.113.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA193E5C0;
        Wed, 18 May 2022 02:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI3tp2blQtKDatHs7/Qpl9lSlAKCaJ0D++/3hGS3cOPMVXJngZFY4vSncdKbOKkpNnTar0TmzLucKgnZ6c4i5tXrJr65hOIsln889009kn/lif1mxG8V7LaqH4nC8Mrmn1MwDgYx/qp/1J1uZyYzYqUvl5SPO7oYYEwKohpaTHAFSFFTJ68BN8d+Mf9YvCRY1wMpFL4pcblzQUk3OtYY5lROCyU1qw29sB8g0CNJZDi7tISoR6IfjdAQQRQJttO+7/XZx9Zrx2qvkookPjZqZUUNxBG0HzS/XHCKSbjrKp6glFAQi2X6BK9kAf2ZCNZgK1UMwHVkXYP9yyLnsCUs7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNfCgJR3Ja8v/vaWzIyIYaEoo716ETZ2a3s9k40pToE=;
 b=KNRvifhtIPBDb9AkhiTWSDDJYs3QB0K4sY47iOE/TNMv2ukE/oCqYfY1mwoqzEUJQeYP4kO0kfqvZDPQGBRtC/LuTHqoD6m4mdK0L100rQkoDZDfaQmWrjXFExA/sfALovJ4mvUz/HSoxWVlBKrupFJTJmG4fve+/0cvIq8TbsfoNQNUf8N+ORPLz3qRFiMh+6ZmvCtDVwfbG2evaH2vTWORWSiL1m+9TbTtw5QsRoOo8XNLvHpk/qyfTj4xyci5bFgbLN1BCxFukqNfqe7VFNUfB7ANGVAXc3PcstgrE99d1GsihgAWe6ciHJFcSCQ8Sg8zu7IUV0QKpt0jTJcAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNfCgJR3Ja8v/vaWzIyIYaEoo716ETZ2a3s9k40pToE=;
 b=CGnm6ehlNosvzLECymMLxnqaBw+R/5bcKpBdGK4qoREe3TbH3tVGAWLMGpiNN92Lh4uYiv2ivWeOKjZ3Fp5Al/hU4rJci2c/gM5fS5VIDsvOxLBuDZUhYHN3jI71eEzAqyCSwZSHEWZGHVWYmpHsOuUFvduBasSsn2iLOrykuls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OSZP286MB1324.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:13c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Wed, 18 May 2022 09:25:09 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7%7]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 09:25:09 +0000
Date:   Wed, 18 May 2022 17:25:01 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>
Subject: [PATCH -next v2 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from
 DT
Message-ID: <YoS7bT1B/+JrEn05@Sun>
References: <YoS6qRhxGuwHmK7q@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoS6qRhxGuwHmK7q@Sun>
X-Operating-System: Linux Sun 5.15.26 
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: SJ0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::18) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1367cf5-9f74-4a0b-016b-08da38b04d5f
X-MS-TrafficTypeDiagnostic: OSZP286MB1324:EE_
X-Microsoft-Antispam-PRVS: <OSZP286MB132448B7C94E3FF2CFF4E814BCD19@OSZP286MB1324.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLCVBNFW/ym6Egm2cma/unEDH3IqPoGIv5CBjeiHZQJ0ye+Y7dvk/6QuACIhNURte/J1NptRERXY+bHExK4vwF4ZC9XOlvt6JKlv50O8VsYLWOxtiBVm7/5qySFA6VLZSXQPFCLHFEWMIbau9qp944cf1794KI7Jg2IJJC2AR6gBDRCIcZo7ec70zl5G9tWHdH+GznyBC31/Kxv6On7f6/kFwlAbd5wahoMyWrEkOG4Nf+DHBC8CJNFHOsxOOf9+AVNWXv1FXtjivwhfAaDh+ZfwPbJ0TrGcEj3n7qNGxaphuKNFuAN/f2yPcJzikM4s5pHjMBb6YtkIVWFNpU2ZarDhudEAv67tZuPOx8PzVB2AhwcF1QwXby1sAPSBERonrUIJAkxqq/+rqFgKAw4gAYGfMGAc+Y2OsLoHDKN5/RfKO9u3k41oXNJ12r+hnGfUacWwc7xV83fbiwI1KXX85CbXnGN3qa9aRzb/zxKgKX6UtrpM6ObUHN4nW9Sv1dE9M0aa1saCDVUsi5RQk9PN5pXdjrjDTaKwugF8CSeA9Xuq32ca05sRmuTNS56H9CHER7O/zDVGE5ywcbvzRQ/z5CYSYA7cFGU09gfrblzVXSyfFafRPXED+m8DRIr5HbSY9gCcVylkllcYyB4u/E9JRgs5rECcCnaboEGTtlLjEXLc+uIM6qstlP8EugZmYnG8KTI7ot/S1McuK4Q2lxzoQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(346002)(136003)(396003)(376002)(39830400003)(366004)(52116002)(6512007)(6506007)(186003)(38100700002)(508600001)(54906003)(110136005)(6486002)(2906002)(9686003)(33716001)(66946007)(8676002)(4326008)(66556008)(66476007)(6666004)(5660300002)(7416002)(8936002)(41300700001)(41320700001)(83380400001)(316002)(786003)(86362001)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+sSh0HCXhW53nvPgK6opv1Il17XDdSbOhPwpHWvbhwkfqqVCIn3nPWwQqmHx?=
 =?us-ascii?Q?AgZY39NQmMXW2un/vcG/QM2t5Um/XbEVy0I1Otk8rxYhPZ8GUFHBw5ZN0D6P?=
 =?us-ascii?Q?8HHsFrk9Iblm5VD1tCEzexIsm3iY5se53JVO2pUgDOT1XXSjOnW30+lFck25?=
 =?us-ascii?Q?3CSbGZpiFAjIk2XrVXGWossrkQwIcqPQIBCA7i06aggM7PcwzHqoRShkWWyb?=
 =?us-ascii?Q?hMANolv0ANteAcppuqE2SJkNk9KfucezndivtlwMbVSbZnNXe4SFb5KFm6By?=
 =?us-ascii?Q?Cya+7CT91Dj83bsxzhxxIU5EICgH77EOEXT6CyoncQIbWk0A5cVZRtHpuIsx?=
 =?us-ascii?Q?oC9+aNIMgrgrC0CdvpFLtQ45HnDdznM1wG64DChOZR9zokRTrQJoB8IFcZMH?=
 =?us-ascii?Q?WCR3QZDHZu+abEC4KItmckZF8ZbeOSSUEU56js8cTneGj656H2T5ZrGbiIiK?=
 =?us-ascii?Q?PlYNdTK0VKbCrSdkRqOZQPiRpW744XTaVMpXePGWTwRJVXbNkhf+k20DyvGe?=
 =?us-ascii?Q?cHf89H2RVFPRhxnZ+ULCeWyp4vHQ1jVgxlSpDMeYaPaSY13hpGtIghQtLFQ/?=
 =?us-ascii?Q?azGZ8UATjTMPupMbjS8aEL9+fYiAJ+LryybuTPK8fyW31mlq29LEnSo3H15I?=
 =?us-ascii?Q?40j/tGZiuxypaYIXTVTpd6/nYxOCC+7soh6l6tgnUvsfvubw4YhvGhA8ojGV?=
 =?us-ascii?Q?BYNPkWvgh01TxUU3K3lb+iauxaTp4iaCGXrOd1ptCWYN+NlJgoB8gK0u6d3s?=
 =?us-ascii?Q?4iV4jvbZ/NgZ0+g+DvMuhOOW403zV1L55CukW1A6J31ie4fsYGEzOjNBcGZ+?=
 =?us-ascii?Q?poOl9iHQ56OpWL5HaHvr2zjRx2tRc71IRIJjLrgiE+zyjIq+YSBboczXmUMm?=
 =?us-ascii?Q?kjkVCFd+nA1cVmTeLdInDApX+sg6yDHLr/XRtdguf9ibVyRINOPVZ33etANB?=
 =?us-ascii?Q?G0PD2GLV4H0iCSwilygwObkkOrXz+FU1GoEDPnLOrMQ+0mopX2UERWliIoba?=
 =?us-ascii?Q?Jz2dKcjaxMS5egOGW5iGuWB5gib+zcg9/sv3MJtq8JORkV98TgCj0CiZYBLT?=
 =?us-ascii?Q?mRaPLcEY7ni99eAOUfX6rwPO2N8b9ENg/UIeeawlo3wkKL0o1fyUw9SFmHkG?=
 =?us-ascii?Q?HTcWr2qThUFScIjb0FODOiwxpP1aAuVAPdvLRGChXJ1Xk+W+hnteRJcEK1Nz?=
 =?us-ascii?Q?Pdxsza4QN4LqPrH4+ZoIf1cSRnjbzjDX2hYtrE+A8wbzN3RQNNqjYDRqcmec?=
 =?us-ascii?Q?aOhRwb7MdVDtKGE9Lx9/x9jGVcdqfT1Bw/lIqWP4v0maJWzkjafBF02GqTYW?=
 =?us-ascii?Q?zUvWgmOfPtFTmo1oeL+M5xOrPHtWmAvHi3Uqjc/v7LoBG8ambJDKjU2LVe23?=
 =?us-ascii?Q?SP/BfJNlSmFYZqLt0SUzMVwgxg2fjzLmEOzXf8I9qRZQMcnbbX9QEYK1ij2r?=
 =?us-ascii?Q?ScDvzrnCLUesAGTn7irJR9epghLSPEDen43ckMy4EA6KiR8zM6FdajSuh2Hf?=
 =?us-ascii?Q?g2jml3mwPP3GqhhnxLSARkAJZOupxflpPdDH3IZaF5a3LgTLNXqhTBodNo1L?=
 =?us-ascii?Q?1cUVDjWI+SCvCJXVzvn6CPJ70kYIyYWKXpy8L7ahgiDr8FmOcgKqu7x18pcq?=
 =?us-ascii?Q?vTFbSNdOaRJkBJx1ZZ54dBVSayP4aknm3Y3Qt+8xbvw4outzyWcTyWMSQ8H5?=
 =?us-ascii?Q?lUMPCDHA8Ow1EH8zwirHsIa7c3BlCyjLpOP2NdFAKMWtoz4yS+FkSTLirKLb?=
 =?us-ascii?Q?PaBlcto6Lg=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: b1367cf5-9f74-4a0b-016b-08da38b04d5f
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 09:25:09.1236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyxS+IJqzRrj1PiJmSXIWXKPZeYO/BkV2ouC8pg0ThH50lKjGTi4t+WhgoZ0u6D0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1324
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit parses Zb/Zk related string from DT and
output them in cpuinfo

One thing worth noting is that if DT provides zk,
all zbkb, zbkc, zbkx and zkn, zkr, zkt would be enabled.

Note that zk is a valid extension name and the current
DT binding spec allows this.

This commit also changes the logical id of
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
index 40c8776aec12..9d2bed2c1a37 100644
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
index dea3ea19deee..800a7aebced3 100644
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

