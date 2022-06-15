Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338E854C83F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347835AbiFOMP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345996AbiFOMPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:15:21 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D978E12764
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:15:19 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220615121518epoutp01025200e8c2cfd600c01f211b0f71e1a4~4ylJoqN1e0727607276epoutp01z
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:15:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220615121518epoutp01025200e8c2cfd600c01f211b0f71e1a4~4ylJoqN1e0727607276epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655295318;
        bh=5Ilj0JrS2l1vwaLwafYqmPNBBHc2ZRo4XhqkSS78FAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=osa61Gktx/kc+raXmb7jVwDL4avr6wK/UvfwpRN6tQuX4uOydM53giC+TEG1dM2iI
         8PhcrNTxU7HJjV9TaOWZp3fAtlYChjeeq7KmO+9Vl5Az7UaI1TnUSGn2B02nScTaFL
         jNp0eWSXUN28uVaI5qkzNiv4PUBMDLLkhtk+Aedc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220615121517epcas5p280fdc7a2e89eddd66da2605099d5120a~4ylJGHZGP0983109831epcas5p25;
        Wed, 15 Jun 2022 12:15:17 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LNPQC6s4nz4x9Pr; Wed, 15 Jun
        2022 12:15:15 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.E9.10063.35DC9A26; Wed, 15 Jun 2022 21:15:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220615121515epcas5p29fd5c0b2e215047926cb92507a9919c9~4ylGi3Lia0984109841epcas5p27;
        Wed, 15 Jun 2022 12:15:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220615121515epsmtrp18047fc871b18343fa2930f72177b2099~4ylGiEylU3132631326epsmtrp1e;
        Wed, 15 Jun 2022 12:15:15 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-53-62a9cd53a9f4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.17.11276.25DC9A26; Wed, 15 Jun 2022 21:15:14 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220615121512epsmtip24e1d46f7348c490c44fc68e88acf5099~4ylEWFLKO0846808468epsmtip20;
        Wed, 15 Jun 2022 12:15:12 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     beanhuo@micron.com, krzysztof.kozlowski+dt@linaro.org,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, chanho61.park@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH 3/3] include: ufs: re-arrange addresses in increasing order
Date:   Wed, 15 Jun 2022 17:42:04 +0530
Message-Id: <20220615121204.16642-3-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220615121204.16642-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmlm7w2ZVJBpNemVg8mLeNzeLlz6ts
        FgcfdrJYTPvwk9ni8n5ti74XD5ktNj2+xmpxedccNosJq76xWMw4v4/Jovv6DjaL5cf/MTnw
        eFy+4u1x59oeNo/NS+o9vq/vYPP4+PQWi0ffllWMHp83yXm0H+hmCuCIyrbJSE1MSS1SSM1L
        zk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpVSaEsMacUKBSQWFyspG9n
        U5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdsf+vS8Et04rWi31M
        DYzndLsYOTkkBEwkLi3+y9zFyMUhJLCbUeLj3UvsEM4nRol9iyaxQjjfgJxNu5i6GDnAWnYe
        qYGI72WUmPr8HSOE08Ik8WzXV1aQuWwC2hJ3p29hAkmICDQzShzs2AXmMAu8ZJRof3KBEaRK
        WMBbYsPOBywgNouAqsS9xqdMIDavgI3Er41XGCEulJdYveEAM8hqTgFbiTMPLSDCjRwS7U0C
        EBe5SHTtUYIIC0u8Or6FHcKWknjZ38YOUeIhseiPFEQ4Q+Lt8vVQw+0lDlyZwwJSwiygKbF+
        lz5ImFmAT6L39xOod3klOtqEIKpVJZrfXWWBsKUlJnZ3s0LYHhL3P1+DBtUERolJlyezTGCU
        nYUwdQEj4ypGydSC4tz01GLTAsO81HJ4LCXn525iBKc/Lc8djHcffNA7xMjEwXiIUYKDWUmE
        1yx4ZZIQb0piZVVqUX58UWlOavEhRlNgeE1klhJNzgcm4LySeEMTSwMTMzMzE0tjM0MlcV6B
        /41JQgLpiSWp2ampBalFMH1MHJxSDUxRXccffzAS6LisonbHY87uArP4ytJNs2Rf52z7Okcv
        LFHDzfkdm5m02DxRprwXqlvnVnV4+qmGnv96/n5rS6aTdSRzRpRC8yJL3p9u+ya9XCXC9kBt
        7+4vGx94F6ocSPy9s31Zye7VHi6zdRt+73zw79jXNilZRf/vDlu/fuaJzlg623vTWQlzFaUT
        Pl+Wvgn3fi8t2GIZNH3Z9qqD9Rpv92RlP3wYM+O00o1XHwpmiqz+1Xbd0PffZrnkeO7s/Lsq
        R6yOtedZrNE7WlxluYL3stcGrdtvrKzu6K/eELflsba9m+j6jalW+yNn/k1L12j9ekpGXldp
        p/7JljMX06qW/fzFL/jj2/8rDx2KWBcosRRnJBpqMRcVJwIAUgfpLggEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSvG7Q2ZVJBvd2m1k8mLeNzeLlz6ts
        FgcfdrJYTPvwk9ni8n5ti74XD5ktNj2+xmpxedccNosJq76xWMw4v4/Jovv6DjaL5cf/MTnw
        eFy+4u1x59oeNo/NS+o9vq/vYPP4+PQWi0ffllWMHp83yXm0H+hmCuCI4rJJSc3JLEst0rdL
        4MrY/9el4JZpRevFPqYGxnO6XYwcHBICJhI7j9R0MXJxCAnsZpTYvvAiUxcjJ1BcWuL6xgns
        ELawxMp/z9khipqYJNauXMkCkmAT0Ja4O30LWIOIQDujxP3tbCBFzAIfGSVedi9hBEkIC3hL
        bNj5AKyBRUBV4l7jU7AGXgEbiV8brzBCbJCXWL3hADPIRZwCthJnHlqAhIWASu4+ecA2gZFv
        ASPDKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4ODV0tzBuH3VB71DjEwcjIcYJTiY
        lUR4zYJXJgnxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXA
        tP5Xct2eoD+nNn5Yy+7lHye98+omo8vXVpgExTzli3+xrkwm/OifD5btrxYdZnmwWfPchNz2
        OjM+h6gC0T+rDyS27bHPVgj9dKpz1U1XMa+qxsjJclnvY+skZqqrdul5/4hZfsj4R9blvmq7
        5LsfxH5d7Y2MrZ09ZdHCF8fdvwnbfdJxOnT8Trxgn/eSxXZtoVYp38MXq2u8c+xbIb6jXfBf
        l1ldq6hJdrfKm2Jex826kV5ph0Lm1LTGFns5K8+/Fip7Rv6iL3NoTT17isCE9cKO3z9PjQ+Z
        dEY8KShzUc1zcS4NLc/nfy1de2bai+yc2Vu0y8HBIZatc2370+ezc+tUn10L9i5Y5jm7zkSJ
        pTgj0VCLuag4EQDFo/wozQIAAA==
X-CMS-MailID: 20220615121515epcas5p29fd5c0b2e215047926cb92507a9919c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220615121515epcas5p29fd5c0b2e215047926cb92507a9919c9
References: <20220615121204.16642-1-alim.akhtar@samsung.com>
        <CGME20220615121515epcas5p29fd5c0b2e215047926cb92507a9919c9@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange all the unipro and mphy addresses in their increasing order.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 include/ufs/unipro.h | 102 +++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/include/ufs/unipro.h b/include/ufs/unipro.h
index ade92e8d3676..4cbfe9272787 100644
--- a/include/ufs/unipro.h
+++ b/include/ufs/unipro.h
@@ -38,6 +38,18 @@
 /*
  * M-RX Configuration Attributes
  */
+#define RX_HS_G1_SYNC_LENGTH_CAP		0x008B
+#define RX_HS_G1_PREP_LENGTH_CAP		0x008C
+#define RX_MIN_ACTIVATETIME_CAPABILITY		0x008F
+#define RX_HIBERN8TIME_CAPABILITY		0x0092
+#define RX_HS_G2_SYNC_LENGTH_CAP		0x0094
+#define RX_HS_G3_SYNC_LENGTH_CAP		0x0095
+#define RX_HS_G2_PREP_LENGTH_CAP		0x0096
+#define RX_HS_G3_PREP_LENGTH_CAP		0x0097
+#define RX_ADV_GRANULARITY_CAP			0x0098
+#define RX_HIBERN8TIME_CAP			0x0092
+#define RX_ADV_HIBERN8TIME_CAP			0x0099
+#define RX_ADV_MIN_ACTIVATETIME_CAP		0x009A
 #define RX_MODE					0x00A1
 #define RX_HSRATE_SERIES			0x00A2
 #define RX_HSGEAR				0x00A3
@@ -47,31 +59,19 @@
 #define RX_ENTER_HIBERN8			0x00A7
 #define RX_BYPASS_8B10B_ENABLE			0x00A8
 #define RX_TERMINATION_FORCE_ENABLE		0x00A9
-#define RX_MIN_ACTIVATETIME_CAPABILITY		0x008F
-#define RX_HIBERN8TIME_CAPABILITY		0x0092
+#define RXCALCTRL				0x00B4
+#define RXSQCTRL				0x00B5
+#define CFGRXCDR8				0x00BA
+#define CFGRXOVR8				0x00BD
+#define CFGRXOVR6				0x00BF
+#define RXDIRECTCTRL2				0x00C7
+#define CFGRXOVR4				0x00E9
 #define RX_REFCLKFREQ				0x00EB
 #define	RX_CFGCLKFREQVAL			0x00EC
 #define CFGWIDEINLN				0x00F0
-#define CFGRXCDR8				0x00BA
 #define ENARXDIRECTCFG4				0x00F2
-#define CFGRXOVR8				0x00BD
-#define RXDIRECTCTRL2				0x00C7
 #define ENARXDIRECTCFG3				0x00F3
-#define RXCALCTRL				0x00B4
 #define ENARXDIRECTCFG2				0x00F4
-#define CFGRXOVR4				0x00E9
-#define RXSQCTRL				0x00B5
-#define CFGRXOVR6				0x00BF
-#define RX_HS_G1_SYNC_LENGTH_CAP		0x008B
-#define RX_HS_G1_PREP_LENGTH_CAP		0x008C
-#define RX_HS_G2_SYNC_LENGTH_CAP		0x0094
-#define RX_HS_G3_SYNC_LENGTH_CAP		0x0095
-#define RX_HS_G2_PREP_LENGTH_CAP		0x0096
-#define RX_HS_G3_PREP_LENGTH_CAP		0x0097
-#define RX_ADV_GRANULARITY_CAP			0x0098
-#define RX_HIBERN8TIME_CAP			0x0092
-#define RX_ADV_HIBERN8TIME_CAP			0x0099
-#define RX_ADV_MIN_ACTIVATETIME_CAP		0x009A
 
 
 #define is_mphy_tx_attr(attr)			(attr < RX_MODE)
@@ -102,47 +102,50 @@
 /*
  * PHY Adapter attributes
  */
-#define PA_ACTIVETXDATALANES	0x1560
-#define PA_ACTIVERXDATALANES	0x1580
-#define PA_TXTRAILINGCLOCKS	0x1564
 #define PA_PHY_TYPE		0x1500
 #define PA_AVAILTXDATALANES	0x1520
-#define PA_AVAILRXDATALANES	0x1540
-#define PA_MINRXTRAILINGCLOCKS	0x1543
-#define PA_TXPWRSTATUS		0x1567
-#define PA_RXPWRSTATUS		0x1582
-#define PA_TXFORCECLOCK		0x1562
-#define PA_TXPWRMODE		0x1563
-#define PA_LEGACYDPHYESCDL	0x1570
 #define PA_MAXTXSPEEDFAST	0x1521
 #define PA_MAXTXSPEEDSLOW	0x1522
 #define PA_MAXRXSPEEDFAST	0x1541
 #define PA_MAXRXSPEEDSLOW	0x1542
 #define PA_TXLINKSTARTUPHS	0x1544
+#define PA_AVAILRXDATALANES	0x1540
+#define PA_MINRXTRAILINGCLOCKS	0x1543
 #define PA_LOCAL_TX_LCC_ENABLE	0x155E
+#define PA_ACTIVETXDATALANES	0x1560
+#define PA_CONNECTEDTXDATALANES	0x1561
+#define PA_TXFORCECLOCK		0x1562
+#define PA_TXPWRMODE		0x1563
+#define PA_TXTRAILINGCLOCKS	0x1564
 #define PA_TXSPEEDFAST		0x1565
 #define PA_TXSPEEDSLOW		0x1566
-#define PA_REMOTEVERINFO	0x15A0
+#define PA_TXPWRSTATUS		0x1567
 #define PA_TXGEAR		0x1568
 #define PA_TXTERMINATION	0x1569
 #define PA_HSSERIES		0x156A
+#define PA_LEGACYDPHYESCDL	0x1570
 #define PA_PWRMODE		0x1571
+#define PA_ACTIVERXDATALANES	0x1580
+#define PA_CONNECTEDRXDATALANES	0x1581
+#define PA_RXPWRSTATUS		0x1582
 #define PA_RXGEAR		0x1583
 #define PA_RXTERMINATION	0x1584
 #define PA_MAXRXPWMGEAR		0x1586
 #define PA_MAXRXHSGEAR		0x1587
+#define PA_PACPREQTIMEOUT	0x1590
+#define PA_PACPREQEOBTIMEOUT	0x1591
+#define PA_REMOTEVERINFO	0x15A0
+#define PA_LOGICALLANEMAP	0x15A1
+#define PA_SLEEPNOCONFIGTIME	0x15A2
+#define PA_STALLNOCONFIGTIME	0x15A3
+#define PA_SAVECONFIGTIME	0x15A4
 #define PA_RXHSUNTERMCAP	0x15A5
 #define PA_RXLSTERMCAP		0x15A6
 #define PA_GRANULARITY		0x15AA
-#define PA_PACPREQTIMEOUT	0x1590
-#define PA_PACPREQEOBTIMEOUT	0x1591
 #define PA_HIBERN8TIME		0x15A7
 #define PA_LOCALVERINFO		0x15A9
 #define PA_GRANULARITY		0x15AA
 #define PA_TACTIVATE		0x15A8
-#define PA_PACPFRAMECOUNT	0x15C0
-#define PA_PACPERRORCOUNT	0x15C1
-#define PA_PHYTESTCONTROL	0x15C2
 #define PA_PWRMODEUSERDATA0	0x15B0
 #define PA_PWRMODEUSERDATA1	0x15B1
 #define PA_PWRMODEUSERDATA2	0x15B2
@@ -155,12 +158,9 @@
 #define PA_PWRMODEUSERDATA9	0x15B9
 #define PA_PWRMODEUSERDATA10	0x15BA
 #define PA_PWRMODEUSERDATA11	0x15BB
-#define PA_CONNECTEDTXDATALANES	0x1561
-#define PA_CONNECTEDRXDATALANES	0x1581
-#define PA_LOGICALLANEMAP	0x15A1
-#define PA_SLEEPNOCONFIGTIME	0x15A2
-#define PA_STALLNOCONFIGTIME	0x15A3
-#define PA_SAVECONFIGTIME	0x15A4
+#define PA_PACPFRAMECOUNT	0x15C0
+#define PA_PACPERRORCOUNT	0x15C1
+#define PA_PHYTESTCONTROL	0x15C2
 #define PA_TXHSADAPTTYPE       0x15D4
 
 /* Adpat type for PA_TXHSADAPTTYPE attribute */
@@ -172,9 +172,9 @@
 #define PA_HIBERN8_TIME_UNIT_US		100
 
 /*Other attributes*/
+#define VS_POWERSTATE		0xD083
 #define VS_MPHYCFGUPDT		0xD085
 #define VS_DEBUGOMC		0xD09E
-#define VS_POWERSTATE		0xD083
 
 #define PA_GRANULARITY_MIN_VAL	1
 #define PA_GRANULARITY_MAX_VAL	6
@@ -245,27 +245,27 @@ enum ufs_unipro_ver {
 /*
  * Data Link Layer Attributes
  */
+#define DL_TXPREEMPTIONCAP	0x2000
+#define DL_TC0TXMAXSDUSIZE	0x2001
+#define DL_TC0RXINITCREDITVAL	0x2002
+#define DL_TC1TXMAXSDUSIZE	0x2003
+#define DL_TC1RXINITCREDITVAL	0x2004
+#define DL_TC0TXBUFFERSIZE	0x2005
+#define DL_TC1TXBUFFERSIZE	0x2006
 #define DL_TC0TXFCTHRESHOLD	0x2040
 #define DL_FC0PROTTIMEOUTVAL	0x2041
 #define DL_TC0REPLAYTIMEOUTVAL	0x2042
 #define DL_AFC0REQTIMEOUTVAL	0x2043
 #define DL_AFC0CREDITTHRESHOLD	0x2044
 #define DL_TC0OUTACKTHRESHOLD	0x2045
+#define DL_PEERTC0PRESENT	0x2046
+#define DL_PEERTC0RXINITCREVAL	0x2047
 #define DL_TC1TXFCTHRESHOLD	0x2060
 #define DL_FC1PROTTIMEOUTVAL	0x2061
 #define DL_TC1REPLAYTIMEOUTVAL	0x2062
 #define DL_AFC1REQTIMEOUTVAL	0x2063
 #define DL_AFC1CREDITTHRESHOLD	0x2064
 #define DL_TC1OUTACKTHRESHOLD	0x2065
-#define DL_TXPREEMPTIONCAP	0x2000
-#define DL_TC0TXMAXSDUSIZE	0x2001
-#define DL_TC0RXINITCREDITVAL	0x2002
-#define DL_TC0TXBUFFERSIZE	0x2005
-#define DL_PEERTC0PRESENT	0x2046
-#define DL_PEERTC0RXINITCREVAL	0x2047
-#define DL_TC1TXMAXSDUSIZE	0x2003
-#define DL_TC1RXINITCREDITVAL	0x2004
-#define DL_TC1TXBUFFERSIZE	0x2006
 #define DL_PEERTC1PRESENT	0x2066
 #define DL_PEERTC1RXINITCREVAL	0x2067
 
-- 
2.25.1

