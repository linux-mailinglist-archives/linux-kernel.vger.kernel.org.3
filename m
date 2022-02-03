Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A674A8D28
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354005AbiBCUXa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Feb 2022 15:23:30 -0500
Received: from mail-eopbgr90050.outbound.protection.outlook.com ([40.107.9.50]:13888
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230100AbiBCUX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:23:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMGKnPIctA/c1Qbtpg5XetzYv8MglB2nQXdAW378mfj9ZmuWzc7w+Ahb7MbquOSq0a+j3FGa0NzhkXdZRTZZkmOBh9c5an4W/uA/U6AmbeiF31x3G6w6n41T33LyIoLfQVVFsVXQrTx1fSa/SEFi0kcPwlD1GG/oU/B4O+uomGeJk2Kpvma7XQjsowzfPjmjlL4fTztH9eLQ8OhQGyw0kW34bPIlNA5uS7ceiAE+oB+zjA8nNASPEiLOkHBgQWsQilGjh+24wzErIkF6+34OMETdklFW/E9asyZhNOATEcRn30etFIvCmiHM6C163CnlrI7fS0fR7LsIi6WDKrKYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/EV6uEC1M5zqIUD+hp6YncWMRxPKXLAKPwg76aqnIU=;
 b=RxDNcdB+W5JrFbP10DQfi5xQpHb51Z+1NyVo6X4brJDM7BiwBPmDTG2iEc784IaBVhgqLmC86wQnbM85kvX4lzsQENBqNEuRhY3JFec6iJeN8G3AQVAUqGsT/yV9v/0fXhycC5EbuvEyKdZFq5XHG3Bycw5fo2Ef5WPMutUxfM6sJrwIlVDGWHpR2XcM4VQ1q6vPaBx65X9uXDMwypHiGtx5MWHiac67CegfzYzmyFv9jJ+E1Upzixddx2ptxV2vWlPvH+Qwo7a7k2HF6kkavunyWeANRO/ICZXvQ0Si+HhcsAT+xJMU3U3OwHuxheIs6Wh/OijdnmNu3sxkzU2sOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2814.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Thu, 3 Feb
 2022 20:23:25 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%9]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 20:23:25 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "atomlin@redhat.com" <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/2] modules: Make module_enable_x() independant of
 CONFIG_ARCH_HAS_STRICT_MODULE_RWX
Thread-Topic: [RFC PATCH 1/2] modules: Make module_enable_x() independant of
 CONFIG_ARCH_HAS_STRICT_MODULE_RWX
Thread-Index: AQHYGTvleFd3jp/x5EiW0RJAl2kmwQ==
Date:   Thu, 3 Feb 2022 20:23:25 +0000
Message-ID: <203348805c9ac9851d8939d15cb9802ef047b5e2.1643919758.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 736b9568-e706-4348-a219-08d9e7530829
x-ms-traffictypediagnostic: PAZP264MB2814:EE_
x-microsoft-antispam-prvs: <PAZP264MB2814BC744BC5D8F77983F045ED289@PAZP264MB2814.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k+71Z8cp8Pbp0l8q6tk1fZRSMH3jPBFEKl0Y7BktlnxJKZNA4uFX6Oh7OmzLBHrvaevILzmX9jYN23+PudODH73XHzQZWY/Dx89zDQorWL6BuXDAwcRm/RU1wIvUp1HYhsvphtSWgEZKFFwspNNcsNwneSp7Qb2IeQN2Q3D8BV/MJk3thLcX+AzdjLrxfo5utpT51ULtwZ/j5pFWV1DHzkw5E79SmV0O8khHyas9Cq+Fg08nJjfiANUBu2ZBRn3W2cWwrMBvZJZdSMdOOzzlDbNKR6d0i2pcJVfixQC+aVEuyDw7KtgP3y+y54WBrDay3qgO1PTCU+XJRYlFGl7CjVpqWE5IbAMzHSBSilwT7AseVgj8cP2riu4NhIiQModOOPWqzXQ0n3wTgML9WdH+Vpg12GK2U62gO6IVJabbJ6MpvViA012oFzU2NPKGM+Mtlm0tcpzlZX9vl9xFkgMyAgj4alFXPR1w17JORwunch7EcIVh6s2bP3fbxqC/PduAsA+xidXVSY6QH4uB99bV6jcYmdUTUA1s5Bc7LcwkDsJw4tkitQAasljmmrwHmnJEDWzMCIWhbG1a6EfYMCFNEUyz+EyvFNxu3iXu7OdYaf7u7Plwy/96+3VJLL0S7ihGrt8YB97qjSA8bzRZkz7Pf6vX27wL6JcLvWeLZ3fS+SReG/tMmRYeO5VF0q0iRuQ/Y9YagOKkoadnkk278UJM9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(71200400001)(2906002)(186003)(83380400001)(26005)(44832011)(6486002)(2616005)(36756003)(508600001)(64756008)(122000001)(8936002)(66946007)(66446008)(6506007)(76116006)(5660300002)(66556008)(66476007)(54906003)(110136005)(86362001)(38070700005)(38100700002)(8676002)(316002)(4326008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VM+c9Oogj0uMJeRKUBWt38cK4POZMEZdCESpOIsNTP2JI5C9Lpv0l6Qzat?=
 =?iso-8859-1?Q?aOzFAju0H+zp2gZJJP5a6MRBlzPLizSwipQ3qmBjjOJe1D8mqM0LH3Vof+?=
 =?iso-8859-1?Q?177QqzPg6fr8b8bOOqfNY5ZToc/Auq+9TxLrguwyOFk7uHlz39psYXaVrB?=
 =?iso-8859-1?Q?BuW5+mHMogmEgPivlSaSx6xtMyG5WqUDrcq3FaqCDWuPckEcYZlyPgZ+bq?=
 =?iso-8859-1?Q?Ln/LUoTjL+4V6qE3ans3e2m4Xez+3F2eZTqBwmWPPCQ6BaJW5BDCyNjt3O?=
 =?iso-8859-1?Q?IbHvUSk0ovPONu0rx2oq1geNiMTZGVY1cBZ2My3ZZdG8K98AB/wD84AMmF?=
 =?iso-8859-1?Q?4Dt2BPav4UOQzL44Fm7zPBIDefMPoikyse2vKFueU6iJSxkmn/hbx3SAoc?=
 =?iso-8859-1?Q?7XYwYWjdP5/GfiasVzRxOe/JV9HBvDYoZUR1eTTkqqHxRW6GoU7wfLl/b0?=
 =?iso-8859-1?Q?RITcBVAgs9ZPH+oqWnUehJWWFPlQVeHjkxLVxoZm6X4sj/DasDsbzGF3V2?=
 =?iso-8859-1?Q?+OvWj62Eb4V3QR5CeZMa45W+rim8R8nCV0/dMUWwcwDwut6DSXIoGXaolV?=
 =?iso-8859-1?Q?AfU6I6LIHAngwn6uGVltVEVVsEw4ZPjIUajqb8I6XgPOdPOkq5wFFUViUD?=
 =?iso-8859-1?Q?w7Odir9ViC3T2dlkDmY2MJX0SkiOcURZkjX/UxkVb7I5bbT7ez9hizQDxM?=
 =?iso-8859-1?Q?pZRR0MpmCxqy8wzEROHxJYB4GaC+uCi/n2WhZab6MqfBLgIhuEefq0oS2h?=
 =?iso-8859-1?Q?A0x7n0/q/wjPigJWdgrML9wfQiGJqh8TlS6fnhwyPllWE+yxbzH/RTl3bw?=
 =?iso-8859-1?Q?UiMwZW0ItX9VXHz5dLKzdnEXIltyqZx7SqItODV5yGmy3v81cqcnlhwN5G?=
 =?iso-8859-1?Q?b9um3Vm/+FQEGZHuNfrz9I/f0yJdeSys7vHOrygLAaGWfd0cKggn3vKsHD?=
 =?iso-8859-1?Q?gyJ5Jt/iJ85WS98c+XJ467SKCsbWR3AK7GG+knq0pct5EGDAWs27VbkDj2?=
 =?iso-8859-1?Q?kBQVZpZFxH3ClGzj1jVLA2DcsVSzEbxalCsfciU0odKEt40vtbHaLQV1OH?=
 =?iso-8859-1?Q?R4jj5zkzWrPCpx4Vbube9uco2lEoe6iIILZ50tqNJIR+69KEil+uukgccQ?=
 =?iso-8859-1?Q?l7t+u5sMA9QlZd/qHy7ovAtOkP0zvl5y3TLxtlx+/h0Lbz0CX1afeFfuXz?=
 =?iso-8859-1?Q?SsNNjT5wiCiNxe3OmvlP0bf5ThTnxIIIkulyl6X4bkpDf5dNrXW+Y+5tf8?=
 =?iso-8859-1?Q?QCryNlpeh913hM6dO8iGEB+HEYzzSsdWdH9YEVzTkHiiCzaY/xzzA2P0d0?=
 =?iso-8859-1?Q?dmyBPnGkSIqbZm/aGzz/DvYK/SAzP86unURTNpgSSEqA0U/ZmQHY2q5SDC?=
 =?iso-8859-1?Q?pfqB4xwWSDvjVsWmiiAe8tzdCztygRXv9CVg6uOYjlppyYatPGvbyHY52G?=
 =?iso-8859-1?Q?JG21yHhdekRoD8OPjSIGUe/4FxfWQyemJDO0tBweyS+cle7wmejxx1nQCW?=
 =?iso-8859-1?Q?e3GNHldW57xmOoMWl3hxn5sp4nar4EVtV5Wy8lx19c6T6es7BAaC8RIZU4?=
 =?iso-8859-1?Q?9qtfVKzlckQkJTqMVl1Jlg+yL0osbunPYltGj1VjtNzPuj1nM2G3xgN4QL?=
 =?iso-8859-1?Q?QpB8Zfi+kl4hUIZeJyoGd+8hSMKYWuBc3zqNZADV7KaxnbSXlFv0MqauzR?=
 =?iso-8859-1?Q?zekoExQE/Ezcq+y45mMegHcz4lifvPUSD1xzcTCkgYA+onplECUAGUAsBe?=
 =?iso-8859-1?Q?P6bMQoHT1JVtQrYITl7+wXWho=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 736b9568-e706-4348-a219-08d9e7530829
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 20:23:25.4102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K+l6xbH+BxZWUWDCIlxx4mTYsWO4Kx2MWwG6UvFWftOyhOQJu1/4EyzmqA6PyAIu8fPNI744fPHZ7MuwSWvTxx0/sXYzn9TquZrGeM0IAN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2814
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module_enable_x() has nothing to do with CONFIG_ARCH_HAS_STRICT_MODULE_RWX
allthough by coincidence architectures who need module_enable_x() are
selection CONFIG_ARCH_HAS_STRICT_MODULE_RWX.

Enable module_enable_x() for everyone everytime. If an architecture
already has module text set executable, it's a no-op.

Only check end boundary if CONFIG_STRICT_MODULE_RWX is set, and
make sure we entirely get the last page when the boundary is not
aligned. When CONFIG_STRICT_MODULE_RWX is not selected, it is not
a big deal to have the start of data as executable.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 24dab046e16c..44ed39cbbd17 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -70,9 +70,9 @@
 /*
  * Modules' sections will be aligned on page boundaries
  * to ensure complete separation of code and data, but
- * only when CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
+ * only when CONFIG_STRICT_MODULE_RWX=y
  */
-#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
+#ifdef CONFIG_STRICT_MODULE_RWX
 # define debug_align(X) ALIGN(X, PAGE_SIZE)
 #else
 # define debug_align(X) (X)
@@ -1955,14 +1955,15 @@ static void mod_sysfs_teardown(struct module *mod)
  * CONFIG_STRICT_MODULE_RWX block below because they are needed regardless of
  * whether we are strict.
  */
-#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
 static void frob_text(const struct module_layout *layout,
 		      int (*set_memory)(unsigned long start, int num_pages))
 {
 	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
+#ifdef CONFIG_STRICT_MODULE_RWX
 	BUG_ON((unsigned long)layout->text_size & (PAGE_SIZE-1));
+#endif
 	set_memory((unsigned long)layout->base,
-		   layout->text_size >> PAGE_SHIFT);
+		   ((layout->text_size - 1) >> PAGE_SHIFT) + 1);
 }
 
 static void module_enable_x(const struct module *mod)
@@ -1970,9 +1971,6 @@ static void module_enable_x(const struct module *mod)
 	frob_text(&mod->core_layout, set_memory_x);
 	frob_text(&mod->init_layout, set_memory_x);
 }
-#else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
-static void module_enable_x(const struct module *mod) { }
-#endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
 
 #ifdef CONFIG_STRICT_MODULE_RWX
 static void frob_rodata(const struct module_layout *layout,
-- 
2.33.1
