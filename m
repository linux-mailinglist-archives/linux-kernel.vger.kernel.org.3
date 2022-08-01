Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95CC586818
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiHALZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiHALZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:25:47 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2058.outbound.protection.outlook.com [40.92.47.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174732F395;
        Mon,  1 Aug 2022 04:25:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfLcb//upCAIebxy8hI65TTFIiEMTfRkZ91Tra86ZQQVf/LMOaUPwixE61BMqDsfmqUMMdRDbOb3ROOjn4ca8T7A2hqBA0DntKkBWyJY3/xF2leIEoHOrz9+SntVlzg0Ff4n1plrbaiDohR8xWMd0Uu5ihN5rPdzNppnp2klE3yQBrFzh9E0gwlyJBu/7vFID8fRocKSlvWxDbqWzIEONAUyKFHFz8FNPcTajrlQN0NmAjGS7RoEdByD2edI+PwVO34TqozdP0aUHMg2LzegkQ5z4KNjE+PSU8nZgxkYWId+8vnAG+UD1KMqddnn0RrEYZrXAugR5WtEzDvj1yJPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HatgaQ3m+WxFt/4aARX0T2yoRMtbI4h8QXbAWWB3AI=;
 b=NVeTQaOB84IuG7XfL9HDEkS/XU2JV1CxxANwPK9S7rWdC3k9Ogk7dplIxIMVSHozfI1uJNcDbzhYqzo0iONqmw8m2v55oD/6s6ONkns3TuYC1nqeP2YCqpaEWe8IDejnnjXHl0ml5/MP94fn5bd00anwgjAv+xO9ZuqCpHUQR5GeL7JLLnSVymEfH9bgoN781G5C6NYA/ztrLf4mpGkc28AyfM+CHEttxOuFPaXOcjEAQwpG2LsaH9o14I3Lavi1q45Az4LJ+jzExta4je4vN6gSgo0hMIq/mKfFtNvI4zzv1hhzCCnmFFeVmr7NCkr7z9sCqKCMGI6MHA5+lv2LCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HatgaQ3m+WxFt/4aARX0T2yoRMtbI4h8QXbAWWB3AI=;
 b=tMJwTSZ2/agmfdVPD/NccBw5/Yqr6aXX8oPOlhDNSUytDAM+gIsxPh0oh3MnZMFD2lJWrLV7Rcy4icRLYCdE/93ZqmoXc3GbSUq8GLQFvAkvEGmYiTE7pWqGCJQ545ikL4Azz+A9ij8WdWq1pZAIx6leCo8ZSFRhLRLuZuJP+FW/42xg+I32dxZ74cFLMuVtCJQ9rBDjRSzRKdWh1VwhSGMAMKXzrWBMZDUtOq1MJ3O/x33BIyUC2q7pI6LgR0MQJjr6amKpQA8lWpHD7VFD4TZ7DGb8naQCdd6+dg1pCpNgqZQ3FyERDTxkSC9b72GRJBotny3ZEKuy6SY9EcfqmA==
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by CO6PR02MB7666.namprd02.prod.outlook.com (2603:10b6:303:a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 11:25:40 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180%8]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 11:25:40 +0000
From:   Joel Selvaraj <joel.selvaraj@outlook.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joel.selvaraj@outlook.com>
Subject: [PATCH v3 3/3] arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce Xiaomi Poco F1 EBBG variant
Date:   Mon,  1 Aug 2022 16:55:12 +0530
Message-ID: <BY5PR02MB70091B1231831E56B40D3C89EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220801112512.209047-1-joel.selvaraj@outlook.com>
References: <20220801112512.209047-1-joel.selvaraj@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Vt55p9XIn5OIO+gxuLyAo3TlxQuBz//kNIJ0lr1sljRuFz7bfRN0pKu11c4+xWOX]
X-ClientProxiedBy: PN2PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::22) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <20220801112512.209047-4-joel.selvaraj@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a33831f0-623e-48cf-4d12-08da73b090d1
X-MS-Exchange-SLBlob-MailProps: tBYDyRQCPckhYfnxUdDn+O6zSuD/K+SSYADPTPgxcy2o9hu/U4OyO230tApN0+e6ylrn4fDskN/5K2HDIuhgxwh/SRbHm/6vUf70u7p4VajsN9KdXbhRGNGDdVojYYLX9SqQVOd3gCFGsCuVbFBFt0n63s80ap6Xmi39JUJyVnZI/+VQhyPzWdE2MRxXOpaovb4byejaRA1/7NIzMQY77V6jPQ0grCvKlHZ1m46qgESgQ1RkcdyewcsjQzpoLdnOgO7rRX6ZgU81Ax5NObIrv6eQ5GlkCOcufhnwDYnzk/xS+dVGzuX152wypXP4H/qeMoQR20aXeWa7n8aVpg7WSJyLH0fYnTUgwnVfO5BzSW2LddO1MpAdToIQoF8A7bwJDSzJZUHcjWsAuiZV65PTPpFB/Bk2GG4KNvGUtztCw8KyElJQ7SGET0mC3hFhUcQJg7XXhIQ3H2kayTQFV5149Xe8msCJDrsYMQMuhrttozaBWe7JuCMiL2jy7I5yNRrxJLVWy8qSoyo5uzX0UHCybfiiGum5dFPWv04eNujJSNiCxNbnccaITDo0/94zMTcojSZKwdCkd+1T3vLOd5x8DM7EcOfXdTvway0I6xuuVhKApyOaEul4OTvU088FlslNowvMHozrmfvVYG/LGoW3sDRKUBTtHGxeikWndYt3rwMDNAEsv5kFQGew4xK4REOhFGv+38JXxD8ag5AeBerzyEa3r/pvPMg4Dr/DBa2LoWX607ZoafnDnQ8i9V1s45iFjbEfGq3yLCI=
X-MS-TrafficTypeDiagnostic: CO6PR02MB7666:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etU8csTljBwXMle5kXJ7G2MBzsszNJUSQQuZBkf+WQ/cLLQPWniLLtBmxjJp0y7eqCZWq+tBn26opnbO+CSig/g66E0muVahLEiPg0ehuwhZWvZSDRH8jlkLZCV4IEeuUs2BLjNMIJnOm70rjVQeFilwhHwiER2X2+wGFNTDhx7wEHCCUQe5+0MSfvIvwKG4/n/AlokrZDbMolN1ZbR6We1E9z80UBjqzzkvxBHoFQ+JLKv++GDvD+ABWc+UMFtop0HJmHz3YhxqLm1dqSQzLIBopDIwI68xkEBsCJ6xG2uCMq87f0P1kImKBLASLGMHiQYAgI+K/9bDZpPbO2epjUfqI3Sp97H5NRq9riYj7AFgofaY9Bvb5jwmxAoAGYAMeylja6khpWJYOeQoPp0/eGNoh5zgLoAAjCNUtBCLkadL04Xm/0otlfuRS3d0BLbok+kXVXiZejK/7XNqjuQ0wWpf0kJ81/yFR+FL13/GbEg7ToyTmdbpOQnRLJq+AIv/aedR0Zi6aXtTxv3NoEI4Z3ehz0qoC9fRHTnH+25h0E3RYuVuFep2ypHzkPgth8/VFykaqoUs4OcPpuHFW/0lTKF2Lr57zlZhjqrdIHucSapYvVBv4JcOyNepvSQ51jgz/0xbPBXU85Dxardg0v9Teg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PXVmMPpcns9TnVU3lntfDzHoZ87DCrvNu3uEUk5qTEDOU382YsoawBsgbNT4?=
 =?us-ascii?Q?GVg32E0hGF4YRfiXSOCla8EHt6yyJME8XwiVjo31xGBn8N2uY8Vc3fF3NFUB?=
 =?us-ascii?Q?zdRiR0mm1pclqeL1XxGPVDuIBfkwrMdMbdNdLzIm6t0LUPOM1aXfhmjIFjxf?=
 =?us-ascii?Q?xRQJ6xGfZqBrSRCtMfN6iAzIu01rrBt5TUbNSqn6nN43MBf4AKGkyFvhKr/9?=
 =?us-ascii?Q?0vj4wE1MGD4Nj4AFZcceqecD1t33ALgCAKCnVhQQ0QZtC1X0BEB/irWwoTax?=
 =?us-ascii?Q?XQ42GpgbzSZziHqieJ+FhNB5chrKS78F6SLZqMsb4wZFxXyhD6XgyGm+jk0b?=
 =?us-ascii?Q?DkQ9Ty2SgEZptUsydc4ssGtdYVWIRVEUDlGdh3xjDPU3HjYGQ2R/13jO+IES?=
 =?us-ascii?Q?58rscAc7KgD9HGC/NTgqctKQUvXm7bS1zceJSS1Qu8JTdQ6679IQKtdkoVsB?=
 =?us-ascii?Q?xdzFon8CcQ59MQPE5ipdbWYmfPfVcF7qO7us6hzEpf/dNmsmqI6moiflr46S?=
 =?us-ascii?Q?abXIh48LnWN5cXe/eMZ3C+zx5PAoGy8NtVwfVrQNm1qKF1/PS+QyXNGst5+A?=
 =?us-ascii?Q?FB1Eij2jsO85bliioQ0Xca6Kqk0rCqI84Tr7rr+bcHY3PdQsFuWs+UqL/ztO?=
 =?us-ascii?Q?8QYga6y85Mjw7koVJ6MOSTBfpPFjpR6pEhU2ixOzWpzW+9Mr7d31l3S4DFwO?=
 =?us-ascii?Q?kWiogbUOxuX0cucnghwOKPaaD3eCkeYAcI1CGHWkHhna28EqftrirwZeLalf?=
 =?us-ascii?Q?a7Jr9VKkCJD9tYRQmotwhGWGKh2zMAYLI9Qqs0j5j39CwwtzFNK/iA6JwBH/?=
 =?us-ascii?Q?0NfVKCAoKbyhNbYCROwnDsvtuuibsRED7PvRhWJ/pfTnrMtWzN/IhkAAI/0f?=
 =?us-ascii?Q?VZ2frh4Pu8rTvir4A4s91e8CRXISxILcqr2XRPQfzq5TAs9ty8z4DDOeflXt?=
 =?us-ascii?Q?5d57E/F2FjyOw75d6PTwLqt/FTM2aPjRL/65p0MKLlR/kQVk0uSnoV1By8pA?=
 =?us-ascii?Q?+M1ypavtTQZStJpOuS2kFxgINkzgslkS9O2dsYxgE4KuUmzt99YqhEPrvixX?=
 =?us-ascii?Q?q+vKYTaIo2eqz1gSUfO+eEyPZtE/Ys85wG8bYCcmTIFMj0Uxthvcceyt41rU?=
 =?us-ascii?Q?xdWj75TOzH1x4IGbfi9dX8tsVxxy3WqN+gaW0K1GXVkXU39w/kCw0QUZwxHJ?=
 =?us-ascii?Q?4tjxTjTsDo/TPsjPKNJB9e54VtlgNOQROH0z2kTiL1qAMbHNmlv3+RO4Ci6c?=
 =?us-ascii?Q?AAr2rZBv341+zsTElmuxiVsNH4wkRQOB9As8bVBfx9k37A8DtZMm0lgw1Yvi?=
 =?us-ascii?Q?YoitPmcYfv4Rcfeb7Dk5/VwitqfJbl9zaHmaMIt2Fxf0Pw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33831f0-623e-48cf-4d12-08da73b090d1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 11:25:40.8982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7666
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support for the Xiaomi Poco F1 EBBG variant. The EBBG variant
uses EBBG FT8719 panel manufactured by EBBG.

Signed-off-by: Joel Selvaraj <joel.selvaraj@outlook.com>
---
 arch/arm64/boot/dts/qcom/Makefile                      |  1 +
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts     | 10 ++++++++++
 2 files changed, 11 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 02db413b228c..29f15031a199 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -106,6 +106,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-oneplus-fajita.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akari.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-akatsuki.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-sony-xperia-tama-apollo.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-ebbg.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium-tianma.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
new file mode 100644
index 000000000000..1e0be481b9da
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "sdm845-xiaomi-beryllium-common.dtsi"
+
+&display_panel {
+	compatible = "ebbg,ft8719";
+	status = "okay";
+};
-- 
2.37.1

