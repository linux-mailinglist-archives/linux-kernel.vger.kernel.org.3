Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D69C4A6D18
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245084AbiBBIpA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Feb 2022 03:45:00 -0500
Received: from mail-eopbgr90075.outbound.protection.outlook.com ([40.107.9.75]:30800
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245069AbiBBIo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:44:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtWBDizEa3lVP3uv9WAv8CS5f31WEYVjTGyxcv5za7wmyLb06sE/Tv9Y7jZ8W6uqet6JWYPSRxRfaWd9EP6YspLGp00W5bj3STAvntgt6DTWXcoFAIVu3ofAolZpUDAxLBjloIWOFtA1K+L4gMB1j/m/B5a+t370FmN3m5U+ljLN4nj+sd4TrBeFdgYtZu5SkJFC47uACb69Z8ZOlClNMaQuaGt7P49sEss0d3rjuhZqu2e7W2y1BbQ0Lmp71UDM76ZL3Z9WTqcHTZ0ndz4Xetsnpe8vdPdDuMZ9tOz2aVbL4Mckz1ffsBy9aYiUWAQIsbMr6KgbLN/5dESt+ps1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ind7o++C36YYMkSVPYnPhsPIiTzLjg06hyjBauGJi4=;
 b=C3xyyVHfWq/80P3EjUofILeccSpcRbwVjg/kingmrQta/v7qn+bVPqYxEMn5Mhz+NbfLK8apwbdp0RF6Uv0HmWSFElQBrbInFuvSPYsbbYQAWeG2ZNX94JaLI/OnItLPmPoxOv8jC0OQgcTb/EPWriOHeju/HwjB5JVDuhYEOpMnMomum/jpcdKYzHkjdxDlSbM9K1vkrKfBcZx/NKnx23lwFgVVw089iQBL2MqqIcOB/6TEJlIaEEnR/m9mBdj1bMA7xVwlt/+ESS2bzfgoDdIrt+CxCM/k/gX0ofLeSaXRKIRByDowyjjXZwmkzMgfwNoKqRWqZ4JKl5iNAVOazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2894.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 08:44:56 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%9]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 08:44:56 +0000
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
Subject: [PATCH 1/4] mm/kasan: Add CONFIG_KASAN_SOFTWARE
Thread-Topic: [PATCH 1/4] mm/kasan: Add CONFIG_KASAN_SOFTWARE
Thread-Index: AQHYGBEnAwJzYYWGn0e5XkqoRz5SsA==
Date:   Wed, 2 Feb 2022 08:44:56 +0000
Message-ID: <a480ac6f31eece520564afd0230c277c78169aa5.1643791473.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1105e9be-ae1c-483d-a81b-08d9e6284a0a
x-ms-traffictypediagnostic: PAZP264MB2894:EE_
x-microsoft-antispam-prvs: <PAZP264MB2894357FD3BCCB8E3BD705ACED279@PAZP264MB2894.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HfRPigFKtSv9p0/jCRTAQywNrKV8x6hixhRgNqmiFNZAZMjXAe9NVc/KCEm0tRn6QA5fl7xq/0sjiDLcPyz+MzJ/+KoCfgFo/yDPmlvWhR5aO+EOHsReEqKiD0CwOlUQfNCPkNoUSxD/fV0p8io3hHEwG4M9yC1Fr7XY4gYXym84nQJEhWf1mhgSRXvkl8mXUr1I1OynT/OuvkEKGtOadPVcD/Vv1Vr/rptBh4Vmj4wMB8acWfCZ85SzcRAyew0KlacQoPdWX9dX44ANiSOnDk2NMksYuF0jDIAVngY+0hY1PFHeK7706Wfq12ZdbLw0h6Vg3qoM1tsoRCvkHs3qmXMAcW81zQ9iW8Go/BcI/+O977m285Oox6EXVk6V9EXaDNw7iciGcdaRWQNiK2P2MgTSverOflsuK9yKRlqKc2ptVml2OQajTmMZJ2SZuzBVaWKiPrwIhiOOyILkZ/TwWX3sgU8nHmJHlCoAYXrxMraHAkgPUJTjp71VVV1LNi8Mws6zFIB0avoUeJo2kuT/KgvfRbWhx7nwoXKBXzBZGYLnpSMx2RBr7OgJbJXKbFKl7YhPIsYfc7VwbdnkYzWHbudDdP/R8kpEOj/MSwa0SQX5eu/I+D8dnaDDvyLoCgBxcoZRDwRwTrgvijLsQHzePpMmxfFQNIPgDY3S4S7ygNTyZtl4mCafMg1PaLpS1+qtZImWzSdHnIM0AMkzkoAx8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(2906002)(122000001)(6512007)(44832011)(36756003)(83380400001)(5660300002)(30864003)(2616005)(8936002)(38100700002)(66946007)(66556008)(66476007)(4326008)(8676002)(316002)(64756008)(86362001)(186003)(91956017)(76116006)(54906003)(26005)(38070700005)(71200400001)(6506007)(110136005)(6486002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IrHmp00xJV4L+F3wMdEHMCZpLNWhQp3kIIk5f65IIi5za9Xc9C0n/yFYgX?=
 =?iso-8859-1?Q?xJtlgi0i3IazZ9yb9lgib9dQYPiSBHFazu6RlKn7e/SoCeSh0fcegI6uPs?=
 =?iso-8859-1?Q?xXQDw6Eu5/TWH2Tm+MS2eRu72MioxEoX6AkfD22hRO+i9zhARFLLwWAZnk?=
 =?iso-8859-1?Q?FXRZ2SPbM8RPoBo0vKA046t1zMOJqI80kmsVkZNLYQ0WdiYoQa6E5PaorR?=
 =?iso-8859-1?Q?41xyvle7ctD63uTsKADocnDhl5je7rLHZ48ntumeKvMp0X/KqDz9tzz+Nf?=
 =?iso-8859-1?Q?TgByRvPVtqdQeaSpxuRqhzbSC07rSuEo6sUk6aPxcNyX9SJoHDplAwLEcZ?=
 =?iso-8859-1?Q?E3I6C/DP+MZ+jI/JsnAW6eUuBnHoXRJEGcJkciy3B3+E49GjfyUQpF8qHz?=
 =?iso-8859-1?Q?/7OlTy/C+lh2pgfEOrOVLWJqWbtb0ERmUSiweEi6O2GcW8eyDAITUnZr8/?=
 =?iso-8859-1?Q?fCr1LUF6p28TMDJ3ZABJqA2GFaUMTK7JCfOHX5/nOmhKgbAC1qs436KZTh?=
 =?iso-8859-1?Q?AlxgqzqsFI4PWxW4GJhViaPtDDQlfqlegOMEqFSjQPKQmNIyCBeDjORg2E?=
 =?iso-8859-1?Q?VCoX7QpUS1ChUwFTdztHpPQ4LkZ2ZlBJYhWPudQ2vILiGO4EZdfDEhe2Fi?=
 =?iso-8859-1?Q?jqU/TzMRiS0eJMS0l9ZFHK3HJT7pCPzCbw+ujEH1rKZDckh0A4jgPb2zcO?=
 =?iso-8859-1?Q?LESrAgRJVFNCkFbUjfVOY8lkLc3ww4gHh9otJHcs01Lz4ILeyQ54jTLmkt?=
 =?iso-8859-1?Q?0EeVpbsEfQtU22ssZ0issjaFPCr5IHzl7C+6RGRfOitkXCaJvLL0UUPeOt?=
 =?iso-8859-1?Q?tNjx7dtzhgNfos659BxFgvFERXyXjb42PXbI/eelqRNQSymZIj5irD/ZjE?=
 =?iso-8859-1?Q?8vcCAUkFHSWLhiJ7bie1uLa8sjkhYkH5BAwlJ/LhdZJuVbwECFinNnm7GB?=
 =?iso-8859-1?Q?0vpyFznRpgNfB8iZBl/ZbAdNXh05Ft5sTo2vw4ViV0o6mtT0K3GYXkbQbI?=
 =?iso-8859-1?Q?Iqg5PIbAzRgCg/TBElmj6EUs3JGZCMqlqW53YUilPQFwu85jr4q9Uq1/YD?=
 =?iso-8859-1?Q?ji10O1dAz67RqSBaerTeeLD37NCtrM94z8m0q3qfLF6fIxxF3+/jgvgMbT?=
 =?iso-8859-1?Q?uF5xaG/nD27/fk5oRCV3ZFKVayxuCTmlcnF9iLy8SXc7jw3GqrQf6G2nTa?=
 =?iso-8859-1?Q?PjpeXp+uFEzgVdg3icCV1o1WcYeRtVWSVE4K2ncywrqoblGzyubaX1Xvy9?=
 =?iso-8859-1?Q?vTOU33ewK0QJOxtKhknTHgJ2idCERtufK6AWACRSjw7GDu/ytDAQnFgLCQ?=
 =?iso-8859-1?Q?HW4NduZa0eNF7wFXtRb1e7OW3LyRfNvuhqjVQ/d7eHdgICiGH3+1ZEg8F3?=
 =?iso-8859-1?Q?XOVIHroFhsUG9runH4MC9xrK552EVQf11C7lptSspcovcsrXicQkC3paVl?=
 =?iso-8859-1?Q?9jHB8+pAdYY3l7x3PBcEK01oWGqubAlceibZbqF1XGf3PA9I6l4Gy7V8NH?=
 =?iso-8859-1?Q?Sw5vDN8SANMfNqsDXDaGsKxrK9ODMJXC9kEQyBDC0O6VLoKVQbQBs+ibGB?=
 =?iso-8859-1?Q?HdGeTNG4rl590tWAFMlJJiS4Ad9e9T+2YdD4mkUfguwIEvGYb5KZKYE6Fy?=
 =?iso-8859-1?Q?yIYm19YJinphn8kozRkNif7WcheyKkccMTA9XVpQnpCtSaETUBnLiAh1D0?=
 =?iso-8859-1?Q?TLjGfn/lv22IGL5LYUn3wpxXE/MZt+TVa0RidK+XS/wVJ6sz7Do6Qucr4J?=
 =?iso-8859-1?Q?6bfM/UNqfV5YhfUc9tfWYqQ3M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1105e9be-ae1c-483d-a81b-08d9e6284a0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 08:44:56.3991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ObWeQ6nmhXlOHeuhBN0SZX2HXVERFslKaLACTDbeKqC+E/M53izbmaCMc06sTNGTabWQinJoYcc3JPodnwWkSWHoaWJratjplIr4EU/tv+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2894
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many many places check whether there is one of
CONFIG_KASAN_GENERIC or CONFIG_KASAN_SW_TAGS

In order to avoid adding more places with such a awful
check, add CONFIG_KASAN_SOFTWARE which is selected by
both CONFIG_KASAN_GENERIC and CONFIG_KASAN_SW_TAGS.

This patch only modifies core part. Arch specific parts
can be upgraded one by one in a second step.

Don't change mm/ptdump.c as those #ifdefs go away in
the patch after the next.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/fortify-string.h |  2 +-
 include/linux/kasan-checks.h   |  2 +-
 include/linux/kasan.h          | 13 ++++++-------
 include/linux/moduleloader.h   |  3 +--
 include/linux/sched.h          |  2 +-
 include/linux/vmalloc.h        |  3 +--
 init/init_task.c               |  2 +-
 lib/Kconfig.kasan              |  9 +++++++--
 mm/kasan/Makefile              |  5 +++--
 mm/kasan/common.c              |  4 ++--
 mm/kasan/kasan.h               |  8 ++++----
 mm/kasan/report.c              |  2 +-
 12 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index a6cd6815f249..65c06e30fc6b 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -24,7 +24,7 @@ void __write_overflow(void) __compiletime_error("detected write beyond size of o
 	__ret;							\
 })
 
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+#ifdef CONFIG_KASAN_SOFTWARE
 extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
 extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
 extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
index 3d6d22a25bdc..7ad385c4b2fc 100644
--- a/include/linux/kasan-checks.h
+++ b/include/linux/kasan-checks.h
@@ -15,7 +15,7 @@
  * even in compilation units that selectively disable KASAN, but must use KASAN
  * to validate access to an address.   Never use these in header files!
  */
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+#ifdef CONFIG_KASAN_SOFTWARE
 bool __kasan_check_read(const volatile void *p, unsigned int size);
 bool __kasan_check_write(const volatile void *p, unsigned int size);
 #else
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 4a45562d8893..c29778b25d8a 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -25,7 +25,7 @@ struct kunit_kasan_expectation {
 
 #endif
 
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+#ifdef CONFIG_KASAN_SOFTWARE
 
 #include <linux/pgtable.h>
 
@@ -66,7 +66,7 @@ extern void kasan_enable_current(void);
 /* Disable reporting bugs for current task */
 extern void kasan_disable_current(void);
 
-#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+#else /* CONFIG_KASAN_SOFTWARE */
 
 static inline int kasan_add_zero_shadow(void *start, unsigned long size)
 {
@@ -79,7 +79,7 @@ static inline void kasan_remove_zero_shadow(void *start,
 static inline void kasan_enable_current(void) {}
 static inline void kasan_disable_current(void) {}
 
-#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+#endif /* CONFIG_KASAN_SOFTWARE */
 
 #ifdef CONFIG_KASAN_HW_TAGS
 
@@ -467,8 +467,7 @@ static inline void kasan_populate_early_vm_area_shadow(void *start,
 
 #endif /* CONFIG_KASAN_VMALLOC */
 
-#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
-		!defined(CONFIG_KASAN_VMALLOC)
+#if defined(CONFIG_KASAN_SOFTWARE) && !defined(CONFIG_KASAN_VMALLOC)
 
 /*
  * These functions provide a special case to support backing module
@@ -478,12 +477,12 @@ static inline void kasan_populate_early_vm_area_shadow(void *start,
 int kasan_module_alloc(void *addr, size_t size, gfp_t gfp_mask);
 void kasan_free_shadow(const struct vm_struct *vm);
 
-#else /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
+#else /* CONFIG_KASAN_SOFTWARE && !CONFIG_KASAN_VMALLOC */
 
 static inline int kasan_module_alloc(void *addr, size_t size, gfp_t gfp_mask) { return 0; }
 static inline void kasan_free_shadow(const struct vm_struct *vm) {}
 
-#endif /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
+#endif /* CONFIG_KASAN_SOFTWARE && !CONFIG_KASAN_VMALLOC */
 
 #ifdef CONFIG_KASAN_INLINE
 void kasan_non_canonical_hook(unsigned long addr);
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 9e09d11ffe5b..232687e315b3 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -96,8 +96,7 @@ void module_arch_cleanup(struct module *mod);
 /* Any cleanup before freeing mod->module_init */
 void module_arch_freeing_init(struct module *mod);
 
-#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
-		!defined(CONFIG_KASAN_VMALLOC)
+#if defined(CONFIG_KASAN_SOFTWARE) && !defined(CONFIG_KASAN_VMALLOC)
 #include <linux/kasan.h>
 #define MODULE_ALIGN (PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT)
 #else
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f5b2be39a78c..8d815aea1009 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1335,7 +1335,7 @@ struct task_struct {
 	u64				timer_slack_ns;
 	u64				default_timer_slack_ns;
 
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+#ifdef CONFIG_KASAN_SOFTWARE
 	unsigned int			kasan_depth;
 #endif
 
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 880227b9f044..83d870b16a31 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -28,8 +28,7 @@ struct notifier_block;		/* in notifier.h */
 #define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
 #define VM_NO_HUGE_VMAP		0x00000400	/* force PAGE_SIZE pte mapping */
 
-#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
-	!defined(CONFIG_KASAN_VMALLOC)
+#if defined(CONFIG_KASAN_SOFTWARE) && !defined(CONFIG_KASAN_VMALLOC)
 #define VM_DEFER_KMEMLEAK	0x00000800	/* defer kmemleak object creation */
 #else
 #define VM_DEFER_KMEMLEAK	0
diff --git a/init/init_task.c b/init/init_task.c
index 73cc8f03511a..fa924e5ae173 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -177,7 +177,7 @@ struct task_struct init_task
 	.numa_group	= NULL,
 	.numa_faults	= NULL,
 #endif
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+#ifdef CONFIG_KASAN_SOFTWARE
 	.kasan_depth	= 1,
 #endif
 #ifdef CONFIG_KCSAN
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 879757b6dd14..4b2de3bd188a 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -46,6 +46,9 @@ menuconfig KASAN
 
 if KASAN
 
+config KASAN_SOFTWARE
+	bool
+
 choice
 	prompt "KASAN mode"
 	default KASAN_GENERIC
@@ -69,6 +72,7 @@ config KASAN_GENERIC
 	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
 	select SLUB_DEBUG if SLUB
 	select CONSTRUCTORS
+	select KASAN_SOFTWARE
 	help
 	  Enables generic KASAN mode.
 
@@ -90,6 +94,7 @@ config KASAN_SW_TAGS
 	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
 	select SLUB_DEBUG if SLUB
 	select CONSTRUCTORS
+	select KASAN_SOFTWARE
 	help
 	  Enables software tag-based KASAN mode.
 
@@ -125,7 +130,7 @@ endchoice
 
 choice
 	prompt "Instrumentation type"
-	depends on KASAN_GENERIC || KASAN_SW_TAGS
+	depends on KASAN_SOFTWARE
 	default KASAN_OUTLINE
 
 config KASAN_OUTLINE
@@ -150,7 +155,7 @@ endchoice
 
 config KASAN_STACK
 	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
-	depends on KASAN_GENERIC || KASAN_SW_TAGS
+	depends on KASAN_SOFTWARE
 	depends on !ARCH_DISABLE_KASAN_INLINE
 	default y if CC_IS_GCC
 	help
diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index adcd9acaef61..5f22899b3b2b 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -36,6 +36,7 @@ CFLAGS_hw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 
 obj-$(CONFIG_KASAN) := common.o report.o
-obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
+obj-$(CONFIG_KASAN_SOFTWARE) += init.o shadow.o
+obj-$(CONFIG_KASAN_GENERIC) += generic.o report_generic.o quarantine.o
 obj-$(CONFIG_KASAN_HW_TAGS) += hw_tags.o report_hw_tags.o tags.o report_tags.o
-obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_sw_tags.o shadow.o sw_tags.o tags.o report_tags.o
+obj-$(CONFIG_KASAN_SW_TAGS) += sw_tags.o report_sw_tags.o tags.o report_tags.o
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 92196562687b..5693fe2c176f 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -45,7 +45,7 @@ void kasan_set_track(struct kasan_track *track, gfp_t flags)
 	track->stack = kasan_save_stack(flags, true);
 }
 
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+#ifdef CONFIG_KASAN_SOFTWARE
 void kasan_enable_current(void)
 {
 	current->kasan_depth++;
@@ -58,7 +58,7 @@ void kasan_disable_current(void)
 }
 EXPORT_SYMBOL(kasan_disable_current);
 
-#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+#endif /* CONFIG_KASAN_SOFTWARE */
 
 void __kasan_unpoison_range(const void *address, size_t size)
 {
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index c17fa8d26ffe..57d96714bc1b 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -55,7 +55,7 @@ static inline bool kasan_sync_fault_possible(void)
 
 #endif
 
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+#ifdef CONFIG_KASAN_SOFTWARE
 #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
 #else
 #include <asm/mte-kasan.h>
@@ -211,7 +211,7 @@ struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 						const void *object);
 #endif
 
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+#ifdef CONFIG_KASAN_SOFTWARE
 
 static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 {
@@ -235,14 +235,14 @@ static inline bool addr_has_metadata(const void *addr)
 bool kasan_check_range(unsigned long addr, size_t size, bool write,
 				unsigned long ret_ip);
 
-#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+#else /* CONFIG_KASAN_SOFTWARE */
 
 static inline bool addr_has_metadata(const void *addr)
 {
 	return (is_vmalloc_addr(addr) || virt_addr_valid(addr));
 }
 
-#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+#endif /* CONFIG_KASAN_SOFTWARE */
 
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
 void kasan_print_tags(u8 addr_tag, const void *addr);
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 3ad9624dcc56..bce57bbd1baa 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -334,7 +334,7 @@ static void print_memory_metadata(const void *addr)
 
 static bool report_enabled(void)
 {
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+#ifdef CONFIG_KASAN_SOFTWARE
 	if (current->kasan_depth)
 		return false;
 #endif
-- 
2.33.1
