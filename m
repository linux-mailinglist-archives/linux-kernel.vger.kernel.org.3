Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B9246E861
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbhLIMZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:25:37 -0500
Received: from mail-sgaapc01on2095.outbound.protection.outlook.com ([40.107.215.95]:62305
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237352AbhLIMZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:25:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA66+Y4W/8ZUtljKFzrBJcJPSFeT7grelvgxpaNiJKslzzMQ5oDMsOb9v4tieHClq3eydEhxc4a88blfr5Pe5AtUk49YFRGbFwLlIIxqRuyFyIpbEN/9KpKSfgXbdaO4bB1FYk1DQpGjAGBBQQVop5O+Avjm0sp1YnunP3CD2HWf2mdNgvNpDMOji9OOO6v+gUW2hGkFf19fvnAXwrnePJnX43KWMgZWgZj2STLb/BIG15Fi+BC1WsWo69JY6O6IwZENwt3fzbZnvIwBhSn1b+1ZVWKmX57lWA/albi6inyeuPqZDCdT6pekGjMVK5X3tqkqbRxmj1EoLeKky/e0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AcQEQCZpLaouYtjZ1O4r0ZK8x2y6EsFjAl1fE9GNG4=;
 b=gGxCvkrfTk9MD5dT3XJHaIPKUTRnLZVZ5ZdVAQQAc+VHWmU0WnpPvzyacgNkmszjX+UE2euynrmM66jgrix506z6wWdab8qTin/bIxybBC4zZS22BZqIDRKLDfsWyMwFt1seibohpiOzX33drIicQ17KfyqRaLheBcrqI4jvl71/AEba3zJ4n7PuQ19moj0/mAK3UnqjjF7ALv0pKfZMHG9u6IcIQ8LJacc33eKPd0Mmh0ElZ+yrycQFld6oGAmAm1k+/4ihn5TozwODeLf/FNZxp/Ot76OzMy9MyiLwFJuWmiKXt5Nxbhqac6ioq8d33AM7Qy/UHcoT76zsW9qQ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AcQEQCZpLaouYtjZ1O4r0ZK8x2y6EsFjAl1fE9GNG4=;
 b=TiowNrXDHk427079KAyeiJ5k6e5OxIpfVTeymlm9R2ev/4uAhNK+VrPzJMR/cCRKEVFGQyBCLWeyz2zwMO/5d763e4K/Hn25W/XU9o5YCJgVvW59nQcLjDjgEcY7zIbg5cpef628uQdrjOeaMXYUnDv1vNot+vVG/JsBsoAOHBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3180.apcprd06.prod.outlook.com (2603:1096:100:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 12:21:58 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4755.023; Thu, 9 Dec 2021
 12:21:58 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] irqchip: irq-bcm7120-l2: add missing put_device() call in bcm7120_l2_intc_probe()
Date:   Thu,  9 Dec 2021 04:21:46 -0800
Message-Id: <1639052506-23462-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:202:16::14) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0130.apcprd02.prod.outlook.com (2603:1096:202:16::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4755.17 via Frontend Transport; Thu, 9 Dec 2021 12:21:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b676e9c3-ebd4-4bbb-1036-08d9bb0e7ee8
X-MS-TrafficTypeDiagnostic: SL2PR06MB3180:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3180EC14DECE82FB66F7B2BDBD709@SL2PR06MB3180.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiIMmiJViazpPEC2/ema1bsUTr06J35gtPatKURZMbe84/nLvKSOEkJDmQjt5P7Pu9M7W6sg9OpyfV5lDWlWgUVmL6HKS+GmKOAwtYBoLRSIBjnJl/NHbdl8kmrRIAg7dAPKplY10hRvuXYtR0osXuQSO4qWzwUrqt0yPvbSMZv6kotgcHnLDazjDpdcpp6krMEqM/RHnk4iXqf3jUEpDrhBNWMghsbeg4Xsj2b6oUMYtMR3g3GOY9vluokVwnwqHLbU3RrR8dAocgndKCdQlqGZkRGfs6l1RGr9Rqb0owUyDl3c41OY6dZsHwVK4WGRIu15bdoBCTVe9Wz6WS2jcMVShNsqeZWPWc7S/2yBFKgvakV+UHgQcZmwfdZiNI6WEAzVvVh8WzsQrMDOt7+PDgBX29/ziqjwowRRwphsyH+bCZ30EqW/IyZ4FIQlbQ8wx+QKHxjAFqVLeF3MQ7d+9Yf2/m+1FKgi1LTWMPs/IyK5ByzeW/S8dRstZCuhMT2WScGSd+DSbQVUuA8jyZ6WIemFeDKuajtBYaVnWaq8sJd1dkHRRmUQvVoHcfqMkO5qAb3HQ/ApxoHlIinucOVoKpVO8ijDWYOr8S5Nj9zTutMY0dsGyCkXkQV1Kt74l641/ftxDuIPOhWQqXVTl6ES9RDX2VsWH1rCWfiIg4HsE5ipkgmBfDE+ttMZ2xM8orPtJAD9ZWJxmDXbXN1iTid9Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(107886003)(6666004)(4744005)(110136005)(36756003)(66946007)(6486002)(316002)(2616005)(4326008)(52116002)(6506007)(8936002)(26005)(186003)(508600001)(6512007)(38100700002)(5660300002)(38350700002)(86362001)(2906002)(66476007)(66556008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HLRpm9DcuGVZPDxdVaY8C37/kGZCbrTbaiocpBwy/t7KX8BmGKjZJ3YCuk3T?=
 =?us-ascii?Q?ri1EYN3R34zLV4z4uOotL3v9S3qRo0WLEM7IaIjJA/z1fKtiVuGRiZoq35ka?=
 =?us-ascii?Q?Sah1qsIaqu19dRKJkUPqZUt+gqwMKKXOdXuNq1Yn3SXYzs7Q9Udf3S8d6CSZ?=
 =?us-ascii?Q?gmpb0IYwgRXyWaTZnwdFWVvzfgTJwc9iAammA/zcPmkXGOVw58MVNP/njs+a?=
 =?us-ascii?Q?mheez9VtWwAm86wlfQDHOI4rYMEIyA0ggCVlaNYRsMkkdyTuiP2rJT5K1vqu?=
 =?us-ascii?Q?sj5g1OHFEa0pfYPefNgqiyW8vqfcbb3CmWCTtT2gazBpEBILWXUF39DpZVys?=
 =?us-ascii?Q?dGklMbfaVypWvKTKyLaoLdKz+A0hT7OGRjAAoPO8q9JCaQBYA/KHc8QdpCC3?=
 =?us-ascii?Q?ccYOHIl+oktDxFFCCq5ekVViVXYLsgsmsawFqNeIZejjeb3FXPsO5UYwHCAQ?=
 =?us-ascii?Q?WYuGHiax/t5/wXaLo7wXFuTBk7RcIuD/BcAiKhrea+MkcSnEzJndCEYwpGN7?=
 =?us-ascii?Q?OahYbMyd66oDtE1y0h6lF530OJ40NBVV4y8oLz6tY0CHtftF4vipALoAtJbs?=
 =?us-ascii?Q?gT5/HS2hCSK/gK+zITi8bjns0zdTWdp/AiFiKq3AI7aE/ewspjj0t8vnbxLf?=
 =?us-ascii?Q?dlR4Chg/jajsO5MCAR1jm91bp9vuKNVZjdWDmljIdoskQpgJnwU3SDI4Hk1B?=
 =?us-ascii?Q?eqpzAx95kT/yy5ujEfiKPMRHz3p0zEmL/ewZQgYdvv5A9ocx+h+VbiMhvNXP?=
 =?us-ascii?Q?GVRFQMUQ/TlqhQK0Run3Qdm1iZIyvjagy9nW5rsudINjQl8GUrsRNvDlx7Ei?=
 =?us-ascii?Q?YdQfSmQBJPlRrRMQ4XH4cwrabFOeNpDQfyCm5P7ReS3fRfE1oOJ7BEtUJ51M?=
 =?us-ascii?Q?80vSRAxdZUTPiAWR+lgHImdVS4pZUn/78iXt+USefPglSHDaZOeglCRl7VbI?=
 =?us-ascii?Q?GTYcuX6G3jMq74vMk9GgItlqIvnLtIiZpzqnIslgjoDL2rp5WsHYiiEMCtWp?=
 =?us-ascii?Q?QHfk5kO08pkPB6G+zootxZtkNcQgc/bFnAgCYbziqEPOBm0gki9pzzBNqxBr?=
 =?us-ascii?Q?qowyNFfY1PMQN8igRh52nLK4sQRKQd3QWJDH6csSLp3b9+ynWSAI0LsV5Dxc?=
 =?us-ascii?Q?ktUInNKB8F2eGG18JSDdqDSC7zsrXbYT7N6aEItryUUG9TQCepzK8FiY4mje?=
 =?us-ascii?Q?Bjasz6emSk7c/5h/z5rxpMRTtHIpZyQOqTULPzqRPSugvD0SNNZPEFtLY+l7?=
 =?us-ascii?Q?Su26Q9QEMeCZ1nPqUd94BA9R9YlVjDVpS0J+5AwYCSf/B2zDYTY8Vu9X6L8f?=
 =?us-ascii?Q?HK3YeN/t4vCzvlr8BeygP38y0RTkU6bGnLkzdKqdll+Bt4al+Rhfxi9U/Brh?=
 =?us-ascii?Q?FJ+l4NfS21yTYJcaL7MfSRaZMhfl+kDiykL2maTa9JNCF1a249zlYnvCXD/L?=
 =?us-ascii?Q?3IBdKDXAxaO8/dANpIl2lFIYLTUO25pHSTYPwtLrJWCKsb8D678nKBxYWw7S?=
 =?us-ascii?Q?PSM5sNEIa21N2Zu86wgaeNJ4/KnWCCvhlwthNGiE7kxfoB5hWF4FcOqQvJWw?=
 =?us-ascii?Q?r084qQuE8PdAm75bZVcDn6VA6/MYmgE1Qi6H4r1Jc17ke8HJloiU4M/zhyXY?=
 =?us-ascii?Q?Lo/h+uMbr48GOpyspBpuC+U=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b676e9c3-ebd4-4bbb-1036-08d9bb0e7ee8
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 12:21:58.4316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Urcq7zeMXV3v7nCdSMxSRaeEGoJm2wjDpmAGgc89oGCRic2ZQLbifYp0IEHSL72cQDaBXD81G+yf89h16UEmzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

of_find_device_by_node() takes a reference to the embedded struct device 
which needs to be dropped when error return.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index d80e67a..24573ca
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -336,6 +336,7 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 		if (data->map_base[idx])
 			iounmap(data->map_base[idx]);
 	}
+	put_device(&pdev->dev);
 out_free_data:
 	kfree(data);
 	return ret;
-- 
2.7.4

