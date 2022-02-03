Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B424A8D26
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354017AbiBCUXe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Feb 2022 15:23:34 -0500
Received: from mail-eopbgr90050.outbound.protection.outlook.com ([40.107.9.50]:13888
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352352AbiBCUX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:23:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKV3UYHrfjzUM8h35qxEBOzzErrr8Gs+53rZMF/lrFknTfYI1FtyrH6LeSsC8qK9oqisg2TAhsilODKq5utfULDIEGO9LX39F0epXxURczWIQnNOENyMwwoJpYT4cWYImfYMikqv2p1v4/VF7xQkjbfyHPBkhazsl394JVW4ETzIf3HnBKxbQLRrU7E73/lIshbjJThGeN3pMpR2acnPoIZ4Pw49wcU5urQTEBDj3JwAX8g81WkKPEbM4ImmYxnVuDRZZv4OwhtEmylOCBv9wR1ywWgLvDay5pToSV83Vt7+E5IG1e2c1CYiCQ83WSgxZOizkO0tkO0HBFa96XMAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx4PzRS2cU5fserQ1TnSoVqnVAePApvp7QO0Q94TKaE=;
 b=dw+hOVZyNygUTWfGiPz2H784hNKy4aXdo+Odo6uLqsXku2eNP5SPaM8Hhpu5PcnCCV8NfT7Xrk9DhAapCE0HMP4HaP0Actp9y77ZZzgvE4qIkacUHqPR/xf2cKXqYlmVP0VGcJuuexPaL6Q5c8O/DLsH+jQOkhcfDCVkioXDNWTgJ7RwexLGkrdyLTWKQTljRfVzn2DgMeyZPWexbcYSrdNAywhj16niwIumIo1orxMCXFj7es920WZaEn4ifkJv3yDx5A0NOahLg4Dy68VIekPiqu+KiWMXJtXCagOQtxT4OLcuN9CVdYlhk7IE3Qd/cPX5hHeFgqxis+HTSlLEKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2814.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Thu, 3 Feb
 2022 20:23:28 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%9]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 20:23:27 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "atomlin@redhat.com" <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 2/2] modules: Rename debug_align() as section_align()
Thread-Topic: [RFC PATCH 2/2] modules: Rename debug_align() as section_align()
Thread-Index: AQHYGTvn9hZotPPO10W1OgSPmhGbBQ==
Date:   Thu, 3 Feb 2022 20:23:27 +0000
Message-ID: <57afeae7c0df4a9e76d44d69681e815e37d03d6e.1643919758.git.christophe.leroy@csgroup.eu>
References: <203348805c9ac9851d8939d15cb9802ef047b5e2.1643919758.git.christophe.leroy@csgroup.eu>
In-Reply-To: <203348805c9ac9851d8939d15cb9802ef047b5e2.1643919758.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 770fc739-31c8-4b1c-df79-08d9e753099d
x-ms-traffictypediagnostic: PAZP264MB2814:EE_
x-microsoft-antispam-prvs: <PAZP264MB2814AC62184D2BDD42186BCAED289@PAZP264MB2814.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dxg31Hyu97GCLJuORI2qbJ5iL6XUV2R3Rvxk62DunZDcn/Ajf0+F3783ImDUArz+RY+Lo9OOQxySf2v+5geUROAWyJgOcA40PBMO4MwA4e7L5dLCVPuL+zC9jCtQrlvixV5k9OwVfu+Ph9DoHIOEvPJzBEcBV6kp7Wqb+CCIzVFfny5Sc8rRQcLEBErLV7k0kHm3bZrvnlooFOpI3xwQBwQGckVsRqK0oQrHBpwykGokNxufShSCTcOPGly9I0huX2zVVGP+tLSa8YAZMVld1fu1PVho4IjJ04iuOEFSHfh72OmqsJ4j2ClZpSfxkrH738OyV6Yq36UFQV8/VMjV+lRN81fI0c2Jr/pYTOKPxQyTJ4emiCBAI23TYW7FHYe8OYyKQqXyY4xONmIvoerdU0ZJdyQ45OrXVK92MY9c+lr7J1UBQ79Bc2Gtj8pfTD7ceJT11j82ODc5zmTtOz0WWPFyUan5s45cy2XOii4DBNckR2Taz0TEE+hlT9GZXD5//UM5oKcLP6x0Tg4f/wfcLYhQme45+iW+BLZFomvhH8jgGdM+YFct8IBF+WwWYj8d17Rx0LaLrTFk9Zh+6QZGztGgeIdMy9+x0OEx5Ev/WT5ksPsZMW3er0qk8U6CXcxhAdLoCJHkcv5Mm4TLjm1EO4PCixAuLmjsWDAROaynDvrs6quLY4EtNHdQwO61Gc7FaOgurZGLBgeuG3JqgaM1gA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(71200400001)(2906002)(186003)(83380400001)(26005)(44832011)(6486002)(2616005)(36756003)(508600001)(64756008)(122000001)(8936002)(66946007)(66446008)(6506007)(76116006)(5660300002)(66556008)(66476007)(54906003)(110136005)(86362001)(38070700005)(38100700002)(8676002)(316002)(4326008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/4LWGB0GXalvfCoRat7WZNOYdVLySD5L3KkN14nYTScgIVFibeMxBPOt1h?=
 =?iso-8859-1?Q?ixeB7loZA8haKDvgbvugAec0OTbtJLZiH1jt26oQeD/oy7jXnK7qmKuw4J?=
 =?iso-8859-1?Q?hZINWQRcBwXglhyuvdCBOLJK680IU0WBcfhQiWqIPQZymeTHXEpl7FIX++?=
 =?iso-8859-1?Q?bkAF8PZrKqnQSLkpYxiIMb30GkdgQGuxEQ4KwW8sN7pJr5S5bJyvcFtdH4?=
 =?iso-8859-1?Q?ZLte6S2X5irTAEfMWPD/JFB5HRSX1suwkDcRnd0jXDvlJumuvpiUN8Mubo?=
 =?iso-8859-1?Q?HbJWF0fpYMeXo/p0fX37EDSoGfgcXzaTFKVn7H9t9cbRQ+gGB5TYZHPoPZ?=
 =?iso-8859-1?Q?uU/DXsmYZ0cCCFIjcA+MaU7mmLSSw48xZuVqmgTzzYSwzrDe+eweImjd1R?=
 =?iso-8859-1?Q?m8NsBXw/aznknaFJj5sPutJf0MmYvbQV1Wb5GDTNbz93v/Lp351fIIP6zg?=
 =?iso-8859-1?Q?LicoZMo2twTeQxgf2/2gpJrIRFDP4biBmxsuhpOo6WhnusS0z91vU0uU2J?=
 =?iso-8859-1?Q?reSHDV79hIGRx1wJF7ro8Y/dtqUFdtjG3LgkIDrLqQmLesgta81yu5e93K?=
 =?iso-8859-1?Q?elRtunVh2RQ7dUf71SdjGtx7BGO4ov75Rqow4X0QBJoyMeaZwpgqM8H5r0?=
 =?iso-8859-1?Q?9HkUBEnS/FuK6aaoIEN3yJG3tQbPjqKSm1L5aj1gCi6+Ksyr3N6WTAEDCU?=
 =?iso-8859-1?Q?PrmgjtScS7p+d9Ix/0u7jupK1fwwVJhEBpUK0p0o8gvqKUrEePVo/CN9KG?=
 =?iso-8859-1?Q?ZnjpdcH+D+nCjAdV9HvZtrBjaoQUKmt5V/QSFRKu2M28QJPyy/HT9Zyw03?=
 =?iso-8859-1?Q?8bPLSlJWHu116o3aP2/my5QHDzXAjr1ptpQrJHByFJGmxrc+WUT15Rwigy?=
 =?iso-8859-1?Q?wFxySiydEoyXlE2JUgU3RtVZ+FL8loXgKLZeouXf9jr5WOmmxtuR/Xb2QK?=
 =?iso-8859-1?Q?Y4hrJG37XhN5q1Wu/Z7hd6OYS3lh9HoGrD9mf87MfLWBTy36sBJ/ACpNZQ?=
 =?iso-8859-1?Q?GHZJN9HML0tMK7Xh9oAqePx+/b9GKyUlZgwuXXYmj0t/SKdgdcG25ppZW3?=
 =?iso-8859-1?Q?pGQPHMnpfSjq3eKih1Xeamlt4CuaP2VwOeNcrOuzqSuTRPxqfOBtPAVDwa?=
 =?iso-8859-1?Q?4uQ1DV/xXRJmhOh0FDxPPWPZmIlNnv0CEtOBcS6gUqrpyZwWc4T9zYYSR1?=
 =?iso-8859-1?Q?g0LU5/Cn5S6tP6exyl3bHIjNfY82g+/qBAPFha6lSnzBwLlXceDfnMEqm8?=
 =?iso-8859-1?Q?+sTi9g8TmSksVX8yN7xgql/2mgKiLmSQHmIRn/m6EF0y6leIJselZfy0/q?=
 =?iso-8859-1?Q?kzCVBJmcuoSNq+n1+dIfQvKf3bU6mPMT+Ovu5n74gU9jH5Sk+cHSzAhtVJ?=
 =?iso-8859-1?Q?zCr8facQ6LF7uQQtnD/93ixr2CbW/tBPjRV80umwMJQycBT1OoCJODM1Tr?=
 =?iso-8859-1?Q?/wma0KxRlk5AAxLqEvy3fs09uvTZp+izLzm1p+2zlwZsDY23M9RoMG0Wt1?=
 =?iso-8859-1?Q?E7J1DzQekaYnAxocFSpx26cjk3GlpCszpDEwAccqRIvbXJD15mYRj88sM9?=
 =?iso-8859-1?Q?sJ8i84/UN6K2lACHU5KLP6A6U8titi58wnXD4DtgmiYqPwuZEtfRfRUwGX?=
 =?iso-8859-1?Q?Erpofexv598NRj1ULaGGs2qMJreT3tUljRCbM1yIbzU2zCdZVRSyIJLeV0?=
 =?iso-8859-1?Q?QjiVw+hUlUxze21fBtHzSxthnLe5Gwe1AaeLOtPc9CXhObqXSh4k+GUIvY?=
 =?iso-8859-1?Q?Y/FPd8Ybks4NnthDJ7/T2QCDI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 770fc739-31c8-4b1c-df79-08d9e753099d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 20:23:27.8654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gCRSVXIqkzXDIbv5qRK4verkfEG0cnEsXSS1/wG3moF1Fb+pL0on5HkE+V6p1IOlCZsBtoV28DH/CPte9DBfU6yK3ZVWEE6Ybiji4HHxQQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2814
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debug_align() was added by commit 84e1c6bb38eb ("x86: Add RO/NX
protection for loadable kernel modules")

At that time the config item was CONFIG_DEBUG_SET_MODULE_RONX.

But nowadays it has changed to CONFIG_STRICT_MODULE_RWX and
debug_align() is confusing because it has nothing to do with
DEBUG.

Rename it section_align()

While at it, use PAGE_ALIGN(x) instead of ALIGN(x, PAGE_SIZE).

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 44ed39cbbd17..fb30249a05bb 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -73,9 +73,9 @@
  * only when CONFIG_STRICT_MODULE_RWX=y
  */
 #ifdef CONFIG_STRICT_MODULE_RWX
-# define debug_align(X) ALIGN(X, PAGE_SIZE)
+# define section_align(X) PAGE_ALIGN(X)
 #else
-# define debug_align(X) (X)
+# define section_align(X) (X)
 #endif
 
 /* If this is set, the section belongs in the init part of the module */
@@ -2454,19 +2454,19 @@ static void layout_sections(struct module *mod, struct load_info *info)
 		}
 		switch (m) {
 		case 0: /* executable */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
+			mod->core_layout.size = section_align(mod->core_layout.size);
 			mod->core_layout.text_size = mod->core_layout.size;
 			break;
 		case 1: /* RO: text and ro-data */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
+			mod->core_layout.size = section_align(mod->core_layout.size);
 			mod->core_layout.ro_size = mod->core_layout.size;
 			break;
 		case 2: /* RO after init */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
+			mod->core_layout.size = section_align(mod->core_layout.size);
 			mod->core_layout.ro_after_init_size = mod->core_layout.size;
 			break;
 		case 4: /* whole core */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
+			mod->core_layout.size = section_align(mod->core_layout.size);
 			break;
 		}
 	}
@@ -2488,11 +2488,11 @@ static void layout_sections(struct module *mod, struct load_info *info)
 		}
 		switch (m) {
 		case 0: /* executable */
-			mod->init_layout.size = debug_align(mod->init_layout.size);
+			mod->init_layout.size = section_align(mod->init_layout.size);
 			mod->init_layout.text_size = mod->init_layout.size;
 			break;
 		case 1: /* RO: text and ro-data */
-			mod->init_layout.size = debug_align(mod->init_layout.size);
+			mod->init_layout.size = section_align(mod->init_layout.size);
 			mod->init_layout.ro_size = mod->init_layout.size;
 			break;
 		case 2:
@@ -2503,7 +2503,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			mod->init_layout.ro_after_init_size = mod->init_layout.ro_size;
 			break;
 		case 4: /* whole init */
-			mod->init_layout.size = debug_align(mod->init_layout.size);
+			mod->init_layout.size = section_align(mod->init_layout.size);
 			break;
 		}
 	}
@@ -2724,7 +2724,7 @@ static void layout_symtab(struct module *mod, struct load_info *info)
 	mod->core_layout.size += strtab_size;
 	info->core_typeoffs = mod->core_layout.size;
 	mod->core_layout.size += ndst * sizeof(char);
-	mod->core_layout.size = debug_align(mod->core_layout.size);
+	mod->core_layout.size = section_align(mod->core_layout.size);
 
 	/* Put string table section at end of init part of module. */
 	strsect->sh_flags |= SHF_ALLOC;
@@ -2739,7 +2739,7 @@ static void layout_symtab(struct module *mod, struct load_info *info)
 	mod->init_layout.size += sizeof(struct mod_kallsyms);
 	info->init_typeoffs = mod->init_layout.size;
 	mod->init_layout.size += nsrc * sizeof(char);
-	mod->init_layout.size = debug_align(mod->init_layout.size);
+	mod->init_layout.size = section_align(mod->init_layout.size);
 }
 
 /*
-- 
2.33.1
