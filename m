Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36154A6D17
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245095AbiBBIpC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Feb 2022 03:45:02 -0500
Received: from mail-eopbgr90048.outbound.protection.outlook.com ([40.107.9.48]:8736
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245070AbiBBIpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:45:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZWMOumrTSJJGQVmUz6mtthZO+BX2keaEIdhstOQUgcxc/x3oX3TozTUuC4Ft8dWLdI+l1RaYGHAYCKHxzI5imXrCm0sOU9fvNJGRmuykD+tLycAhKWfgUvctrSNCU+4kp+jnoyDzK5wnPMfp3awpVtjkgqNax96uWMqsN6UsrDgKnUlUglP/K8P2+Z+5INO0XN306claqKyoXGFn+M9lhMsWT8KCqdDpLUDqssTuSnUSeuknu7uHUav/GaXx8jqTHwC5U/LAbELC9yYc12120+k6CIG6GP6Y/+61c67OO2WB2diIaYl+I4Wfb2ac1P6DW2v/WuoeruWQ77HcoDu9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wBo4nIdN2RFAwFq84yvv3HNVVFCq353gnyFKfCn4EQ=;
 b=OOWd6OZTkR5Yd7vzcx/VT/U7Xw9rFVIgnGiSdpSGaIPZ/gE19hfS9douJYv4JoNmYuIUoi0xEPT3UVibPbGL5MLud8TgAY6HMjkhFi91bFXY2vFWku/jy6pivuMeGqnhHpPUFJuN5fLWWk3tjE3DsgJt+kge2XLnaPIwIBBLn+S1Q3Ve8xtjQ/x0vXhveovKEq03HLlBoo4pchl3LZZaUoG8nSFQA85rUMlD286udJ4zNldVqpaG8+PDbH7hF5tdhLZxI6LrOXzwMpOxn+D2pEuyzzwWuLrFVQ/TcqCt5WzjsPi4RweDbq3nZuiBFFQg9fEk3swWDqAsT9eZXmnDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB4276.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 08:44:58 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%9]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 08:44:58 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: [PATCH 2/4] mm/kasan: Move kasan_pXX_table() and
 kasan_early_shadow_page_entry()
Thread-Topic: [PATCH 2/4] mm/kasan: Move kasan_pXX_table() and
 kasan_early_shadow_page_entry()
Thread-Index: AQHYGBEobYxXe/WLd0imaMeHUpNeig==
Date:   Wed, 2 Feb 2022 08:44:58 +0000
Message-ID: <3fe9bf0867b2ffc7cd43fe7040ee18d245641ec1.1643791473.git.christophe.leroy@csgroup.eu>
References: <a480ac6f31eece520564afd0230c277c78169aa5.1643791473.git.christophe.leroy@csgroup.eu>
In-Reply-To: <a480ac6f31eece520564afd0230c277c78169aa5.1643791473.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22de4de2-d2b5-478a-b76a-08d9e6284b28
x-ms-traffictypediagnostic: MR1P264MB4276:EE_
x-microsoft-antispam-prvs: <MR1P264MB42768964836CAC57BF6336B5ED279@MR1P264MB4276.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uI8b/v92ssuNqCBoj7rr9TnkNw653L/5dLA4aiJUCxM3ZwIEoU/t0TVeiUMseVVNRp8Xt8xfHW2Zs8/3cmHQ9iKlM7gTAF6NC5+LQkXUQjgfSg2uY4bubQVpUYTXmE2FFHRjpfSfHlNVfe+oIRqtubwpF1EdKc4xAjrX8I//MMPGPuXUEhNN1ZCgIA75Mo+lrWK8JsYrdTqG/LoS31+er+FowE0fm6ITuoZJB8aC2CMEzoLxfSi8jBb6I3V+wB41Q8ADlEHwC0LKUAeZ+RH4n5cph6S5IUt/aI/7EfIcV1l/AyhktmtCB3ZGbi4ClzqaTZRSuwZW7zYk63IYqRsrofPcbtydnLfPj60s9RG175w0ECH8YlBBVbM74z7JPRBJUNVikZrzP3tx9E1rPQa7PKAgmBuCzVq2lzF/L09uD30VgFZ7IuqxdW949Fijrh1yjlzvpkMZbOt7g3JhHPz4vW5AfAS9aaJmO0pwGfBVIl4Y4aIUdNfjbsiKFZa/48+Z3PfNe7KI3/LZkPFftFbrhPX3bxGMclSZQKUGx5tIyG28cLyV3wcbmfD2YZmuZG59qVCGZCZKQyKIj/x++a9fntIyaeF9mVGf1aF64qFSg9TqTVbq2wVDh/AMLNs85L56nluHUHvYYT4abCCiEECnSfOi2jtjmrzYbrbGyIt4AFSUIAtQS3MvMSHmJ6GLxFoKDQwDt382+MqucoGO7D1/vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(2616005)(26005)(186003)(508600001)(76116006)(66946007)(66446008)(71200400001)(91956017)(5660300002)(36756003)(66556008)(66476007)(8936002)(64756008)(8676002)(2906002)(4326008)(122000001)(38100700002)(86362001)(316002)(110136005)(44832011)(54906003)(6512007)(6506007)(83380400001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dqgUGT6Qod7qf1SE6nAmUjd4G8yGctp6SqIXypebggRqPmQPFQFIr2yb6G?=
 =?iso-8859-1?Q?JZE6A0N1Kp1HmEZAu7qMQuGzz2ObbGuK5UbYnECJzk1LXS6QEGy8o5/UJh?=
 =?iso-8859-1?Q?DX7Y1/QkpE4O8hHRFlutdE6wVDtxJNZJzMIdxiPuB9gkSW8N0nP7AaoZwH?=
 =?iso-8859-1?Q?xwO/EAUigFd/l9DNTknOwB6PsbXVRUZ/39d7cu6AwF5jmENSEQf5WQ0kee?=
 =?iso-8859-1?Q?HJzDYz5dneKXdYGEnJWZIeggfSehOIwa9p7Zrs1r2uVM8hh1FQQDrI3QdR?=
 =?iso-8859-1?Q?nh3h7SDYvdL52r8z9SyflnKJeqBrzmzj8yJtLyY02VXSyn41xSZ5lNH6RM?=
 =?iso-8859-1?Q?u1cb0oBPhvWcgO5gF8d+cIxkT6rU4t3ag15UaWShOn1OAxIw8wklQnAGyv?=
 =?iso-8859-1?Q?kXYD7vnOZnNoBikMaQMebH/AOWrHUzPG2t8Cbf9DkUtrPp7Eb3ak7pw/9G?=
 =?iso-8859-1?Q?RtaW4hna8g1d5kaIKla2vtIugSJHZ8bE+vbqmoKMn7K3q7H2e7GVv2Jswh?=
 =?iso-8859-1?Q?dguVbELHpjE1to2PgtGe+fW2mzS6CQ8I6QhDDwMeYbIMrCIqdKuAcTq1u8?=
 =?iso-8859-1?Q?Wc67lF5HspfBy3yS086TF3wR7+zUlVup8zMWrPyzv8MPj1D0rOCjbvopQz?=
 =?iso-8859-1?Q?e4B1X3OotwWkCAmkfByiu/lG2wYRM2WxcQNbldHmtBv7qoiA/hPiCUE/hT?=
 =?iso-8859-1?Q?WmWtESx0cY8K/P1mZ8+2ZpkFet7tG5duxd4eJ1wpA7K7IM4bhzaLdmzChr?=
 =?iso-8859-1?Q?5Hi0FPCV7v7wTE/Q9fKVFXjfhphid1gZh4MpyLt8BKPcvjqO/pwfl1ftI8?=
 =?iso-8859-1?Q?YMQfqhHQO3zq3jIZNW6TAbV6Blcbm5vg6iRY3iP9oYyu//sLqqvRFL70yQ?=
 =?iso-8859-1?Q?ag103NaLiz7d4w2LiRAZ9kaKnWTIUckj8Sf4O+Ey7FDw1oAwbKP9VvYk3q?=
 =?iso-8859-1?Q?QHZakzbSeanjUejMmFOGw+6+7fiNYRWwpC2Msr7TkLsdYiTd78lZEhkY/H?=
 =?iso-8859-1?Q?tbtR/OoGTGZyFzHmj3BC4RdTdj3Tu4wdwwzXNoHPIxanQa9qNbvIcu/XC6?=
 =?iso-8859-1?Q?ykIAkFGI+dGdVfl6DFfAtimKlst8l3kafWnxL69ex8gwRTlB0DD244umHZ?=
 =?iso-8859-1?Q?uvhKclBX91s2KmbcaMd1AtpmepqwnwlM3TnyubABnbQQkLTHAaTBVZlQZR?=
 =?iso-8859-1?Q?kxoDUSHVp3rbGbHewsajtwZQ5oCBE4KU3focGu/GizlSz7DpOVOwpz7xfh?=
 =?iso-8859-1?Q?dGj5fT0e8e4n+FfmOCS1r3nbLIh/bmuREDVQlHYvnQgs/mUIj1wbZFnenW?=
 =?iso-8859-1?Q?UAEJUw+Aus8zxDj4PydF9l4l32tOP3oSIs14zpQX24McUevnclWZrB8+9z?=
 =?iso-8859-1?Q?d6h12fuHWlnf1JMSe24Y3ge4EgP8PhM4A1FLYiDQrVgEiQSn8ARCC0/S15?=
 =?iso-8859-1?Q?FKi50LsxcFW2QY0ZgvLP1zAVRxPN2M8A+aIq4LXJO0HFwZGZt6aRT0+gcl?=
 =?iso-8859-1?Q?T6s02YbElJxXotGUhT1a/QRh1D/us2qCBnSzwG/HikkWM6Jg+yzUFRKeML?=
 =?iso-8859-1?Q?f/XjZki4frrcXwJmw1C5JLdfODGBrVxtJVXi+e61zFXlr76rgFYgJBpNFi?=
 =?iso-8859-1?Q?NKipnXOY+ONiEmyE5FkbT5SkQwRQy13MVyGM79b4LhXYg4QtrAZmqMzaku?=
 =?iso-8859-1?Q?dkmWSgIcNK8MoSf45ds0+nPlXeExpjj6pLz3l1hjwX0UPYhkNHfLrEwml9?=
 =?iso-8859-1?Q?z0ClHd9H9gM/+LrT1Iboo9VlM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 22de4de2-d2b5-478a-b76a-08d9e6284b28
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 08:44:58.3050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5jqpnrEHw8N6wfhiQbsud8slVsQPpsED+BePjXS5fcdSsIR+gXpVlLM4i1zDSsurSuZ7Yj/4X4GFRSj/AMAvPhU5tOnX+Hq/1bUbVNcN72I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB4276
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reuse them outside of mm/kasan/init.c, move the
following helpers outside of init.c:

	kasan_p4d_table()
	kasan_pud_table()
	kasan_pmd_table()
	kasan_pte_table()
	kasan_early_shadow_page_entry()

And make them available when KASAN is not selected.

Inclusion of kasan.h in mm.h needs to be moved down a bit
in order to get lm_alias() definition.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/kasan.h | 57 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mm.h    |  3 ++-
 mm/kasan/init.c       | 37 ----------------------------
 3 files changed, 59 insertions(+), 38 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index c29778b25d8a..1629797198ec 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -28,6 +28,7 @@ struct kunit_kasan_expectation {
 #ifdef CONFIG_KASAN_SOFTWARE
 
 #include <linux/pgtable.h>
+#include <linux/mm.h>
 
 /* Software KASAN implementations use shadow memory. */
 
@@ -81,6 +82,62 @@ static inline void kasan_disable_current(void) {}
 
 #endif /* CONFIG_KASAN_SOFTWARE */
 
+#if defined(CONFIG_KASAN_SOFTWARE) && CONFIG_PGTABLE_LEVELS > 4
+static inline bool kasan_p4d_table(pgd_t pgd)
+{
+	return pgd_page(pgd) == virt_to_page(lm_alias(kasan_early_shadow_p4d));
+}
+#else
+static inline bool kasan_p4d_table(pgd_t pgd)
+{
+	return false;
+}
+#endif
+#if defined(CONFIG_KASAN_SOFTWARE) && CONFIG_PGTABLE_LEVELS > 3
+static inline bool kasan_pud_table(p4d_t p4d)
+{
+	return p4d_page(p4d) == virt_to_page(lm_alias(kasan_early_shadow_pud));
+}
+#else
+static inline bool kasan_pud_table(p4d_t p4d)
+{
+	return false;
+}
+#endif
+#if defined(CONFIG_KASAN_SOFTWARE) && CONFIG_PGTABLE_LEVELS > 2
+static inline bool kasan_pmd_table(pud_t pud)
+{
+	return pud_page(pud) == virt_to_page(lm_alias(kasan_early_shadow_pmd));
+}
+#else
+static inline bool kasan_pmd_table(pud_t pud)
+{
+	return false;
+}
+#endif
+
+#ifdef CONFIG_KASAN_SOFTWARE
+static inline bool kasan_pte_table(pmd_t pmd)
+{
+	return pmd_page(pmd) == virt_to_page(lm_alias(kasan_early_shadow_pte));
+}
+
+static inline bool kasan_early_shadow_page_entry(pte_t pte)
+{
+	return pte_page(pte) == virt_to_page(lm_alias(kasan_early_shadow_page));
+}
+#else
+static inline bool kasan_pte_table(pmd_t pmd)
+{
+	return false;
+}
+
+static inline bool kasan_early_shadow_page_entry(pte_t pte)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_KASAN_HW_TAGS
 
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e1a84b1e6787..b06ee84b3717 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -31,7 +31,6 @@
 #include <linux/sizes.h>
 #include <linux/sched.h>
 #include <linux/pgtable.h>
-#include <linux/kasan.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -121,6 +120,8 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #define lm_alias(x)	__va(__pa_symbol(x))
 #endif
 
+#include <linux/kasan.h>
+
 /*
  * To prevent common memory management code establishing
  * a zero page mapping on a read fault.
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index cc64ed6858c6..e863071a49ef 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -30,53 +30,16 @@ unsigned char kasan_early_shadow_page[PAGE_SIZE] __page_aligned_bss;
 
 #if CONFIG_PGTABLE_LEVELS > 4
 p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D] __page_aligned_bss;
-static inline bool kasan_p4d_table(pgd_t pgd)
-{
-	return pgd_page(pgd) == virt_to_page(lm_alias(kasan_early_shadow_p4d));
-}
-#else
-static inline bool kasan_p4d_table(pgd_t pgd)
-{
-	return false;
-}
 #endif
 #if CONFIG_PGTABLE_LEVELS > 3
 pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD] __page_aligned_bss;
-static inline bool kasan_pud_table(p4d_t p4d)
-{
-	return p4d_page(p4d) == virt_to_page(lm_alias(kasan_early_shadow_pud));
-}
-#else
-static inline bool kasan_pud_table(p4d_t p4d)
-{
-	return false;
-}
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
 pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD] __page_aligned_bss;
-static inline bool kasan_pmd_table(pud_t pud)
-{
-	return pud_page(pud) == virt_to_page(lm_alias(kasan_early_shadow_pmd));
-}
-#else
-static inline bool kasan_pmd_table(pud_t pud)
-{
-	return false;
-}
 #endif
 pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE + PTE_HWTABLE_PTRS]
 	__page_aligned_bss;
 
-static inline bool kasan_pte_table(pmd_t pmd)
-{
-	return pmd_page(pmd) == virt_to_page(lm_alias(kasan_early_shadow_pte));
-}
-
-static inline bool kasan_early_shadow_page_entry(pte_t pte)
-{
-	return pte_page(pte) == virt_to_page(lm_alias(kasan_early_shadow_page));
-}
-
 static __init void *early_alloc(size_t size, int node)
 {
 	void *ptr = memblock_alloc_try_nid(size, size, __pa(MAX_DMA_ADDRESS),
-- 
2.33.1
