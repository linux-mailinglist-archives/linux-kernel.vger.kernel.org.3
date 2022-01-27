Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E7749E04D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiA0LLF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Jan 2022 06:11:05 -0500
Received: from mail-eopbgr120047.outbound.protection.outlook.com ([40.107.12.47]:31840
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231377AbiA0LLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:11:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I42kGmnE+yS21c18UG8eltM7x0NDEvO+npq6iacmltWC3aV8RqZLg5DtCkSD/my/ksPKcO3U3pDBk2YyqhVL2vs1pOjTGFFpBG6mADTg/HrdEK4AidcUtf5XPaW+RwPfz7G/F4A8RL3b87jzUtaZCGsvw0dFnqsD2LmVq1wW8tV9Ko66D/gd2TBJC0arKme/DGJMPFR9VTOvS2580kUCYkD5ZSUlhRfH6aXXpb4SOI/nZ3ZpU343liLGG/qj5KEHganJs0CbjGr2AtynfwIzqDfgLpDmMmT5a0Cdir2pY7BfjJjVuDwIXrMv1lKK0qOQ87kc7hKH1gO8qXiygEf3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIgTZxqSZO1QNZwfuUqG001grn+BNYRNWoSYcZOdTF8=;
 b=bX7M1rpv8IqdN9283Xnn3xeXMZbXIZxltiDvUVOuujbkRX0k0wgfScGGwsBN3LXmiSs7ZO63tMmGRUnrCffvAsdjCpZ1oe1D1mjNpsVU9CMsqoiYpf5LI6vUl52VuEsvQdve93wIeJRKB3U7nxhICRRP1g987/LVZfplL88DlmgZ4fss0Sl7bm1p8SBDStjnANbMj+CWNzIdWlKvk1vXThyvQ2xMesVAEDM/GUiaHIixiSqVvaUU1a69GJXTA3ZV97CdjgX5YRzNz4Z28gl8KvVykS3mQfoeLMUQTO00hkNdc7j/u112ySwuv9Jdn56FgGxxAWk5Gbrs7o7AhfmTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB0442.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:12::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Thu, 27 Jan
 2022 11:11:02 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 11:11:02 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: [PATCH] vsprintf: Fix %pK with kptr_restrict == 0
Thread-Topic: [PATCH] vsprintf: Fix %pK with kptr_restrict == 0
Thread-Index: AQHYE26SrKWjcZwXqUqoxqk7jKGITg==
Date:   Thu, 27 Jan 2022 11:11:02 +0000
Message-ID: <d7cd39abc28f5e0e08faa8958f35cd929165084e.1643281806.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24b0b010-31e2-4189-ff89-08d9e185b49c
x-ms-traffictypediagnostic: PR0P264MB0442:EE_
x-microsoft-antispam-prvs: <PR0P264MB0442729BE9A411CADC9D994DED219@PR0P264MB0442.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: naXCe6Xod7T0SaI6x8uUQbxFZ+mHWuIEYHTnWcyknVLJqjQ9K7AEwf4FL6Svr7ti8xg0ppg+XkzLW+3AXNFljbcb/X5Bj3bsWJnL04MijsWAKD1Av3cTlX9I0wM/G+70GbVRibpanDPHOL6jrAQ8ierI9oeatOIIWlV8rs3XdzDjoiXYuRrUOQPuOFteCV9bi0O751mjUhlR7WbfQTAWNILZZlHq4jktpS+K0SE+gbM+Y9FaXYQS86m6EiQYIm1nzjIDcyd1UPSIHG6UUJipWh5zJmn7dg4jiO0GR4x5E2Je6A8GedncR/fOsUJMrZ5AtKxb+gyfg7vqDQVhAkl/88+6DsaCwC6hRc2AN96q7IIb0Kt8yDg2OugVDOoQ2dIM9w+qULDB7ZpsSbnbATr6/hfDUQecim+YI67KGL5y1O3rxkor3gbssV1UJuZz2BPj5ShfYwlWZqmOH9lF6CypzPcwC9fuBgT+hGKSPSmfaFnLO/p5QVL9v6oziMvBbK6uzhMBJf/15KfIThtxtKAt/1E4W7mIfqUe8DHxdlHzbTJkzSjrZs5rtng2EjUmH9WBggQQf5bHkcDAph1Sgf2Cjm8rNWKhDbfFyUFlh4kMJSszFhk+G0MhmFvb506/UiOSOxHXt3i2VuhzDNam4LyjzKIfqP45hnp5YkHDk0m4xSiop0R1joOcAj5FFdGeWrlL7pbCdMb/o3hmeWktiTUJkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(8676002)(4326008)(86362001)(186003)(71200400001)(508600001)(110136005)(8936002)(66556008)(38070700005)(6512007)(6486002)(66446008)(76116006)(64756008)(54906003)(66476007)(91956017)(2906002)(83380400001)(66946007)(6506007)(5660300002)(2616005)(316002)(122000001)(44832011)(36756003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dCt1Oags4DN1QSGjQu6Xnkmoz7fWtXZEXLPfI+S2oOKi/nib6CSzqGRdIm?=
 =?iso-8859-1?Q?sE93klO+Cx9+Ih2+z5Up4ssxJZKoCFI2DvDr0YczIUckCp+NMfiLI5px6M?=
 =?iso-8859-1?Q?uSZixLv+rlfPdsmzPMzz3UF5pEu9DxXN76ijuEqDo/usxQarpJNVQeUn1p?=
 =?iso-8859-1?Q?h/n4bKnm1paAg+PSlD86DDqaEMZ9yOXHO7f7i1Uw9eqT8L1rMdPmmBritX?=
 =?iso-8859-1?Q?oOM6JWMM1dNB9hFgn7HCNSoXGDtXlZObn84fZ4smD6w9CAq4yM66KrqFIY?=
 =?iso-8859-1?Q?AoE1n8GM6sZvO6EK2JXhrlQTkCNth2H0SF/9mpDXxCemhxRTLV5z513m/S?=
 =?iso-8859-1?Q?0w+9X3jPSMsWemO/EkB+0SetaZaP2Q1nAw8aq+fuRJwc4mSfkbcHmnWXm5?=
 =?iso-8859-1?Q?s2PG6YspIqpYnxFVfBktSVeeAT6uoFDb0C8sgdZ/+RjEMM9hz+HjUD0E6S?=
 =?iso-8859-1?Q?PZdCOGyOPW/QzKFzSvF8dIvvqWGrNTiK9GCc+k7XC5OGcJQtTrLB+2oLIz?=
 =?iso-8859-1?Q?V6es1FTPe7K2KkCE+7V7Xp3+gQ/qFQoZ8REI02ew04ZWan/Wk6QQPHpwX0?=
 =?iso-8859-1?Q?Xd802xAunU6tmpmBeWhJdFaQhDmB1tKXLA4lxg198OGAfYQZhE62vYHnqq?=
 =?iso-8859-1?Q?23G5IA3J6jCwUuhXK4yRoO6+4GFbJssTyT0wGd8SInfM+WUc337sgj7+wj?=
 =?iso-8859-1?Q?zhlhRQPTywuyc6HPQibm7VAJEJw+06lCBErWWOafvjr7GFTqd0R991VlNU?=
 =?iso-8859-1?Q?6wGeqBFMZT9N7BCOCDuZywfWHJnTdx889dZheqLzBa2W0w9LlnGHzOp7tk?=
 =?iso-8859-1?Q?FhwUsl4NzY3VRUTDU7hA0TPzB/Bbe7mbJApFMgkvvc95KfBhyLupAPlJNc?=
 =?iso-8859-1?Q?fmD+mWB6+aQ7VR3q8yKxo0NNappVnU9SA3cTZ1l5v0/to6JRyBje9f56bN?=
 =?iso-8859-1?Q?oe2QpAg87dkfIVVQs4KXTAGWmkPYB8I0CsgID8I0fCre1i0TLFTADAF7Ql?=
 =?iso-8859-1?Q?kJy/o4nFNql8ddcRDHxGppPOWx92Al1yeLUpKV7YStvVt2Twjmdq616zs2?=
 =?iso-8859-1?Q?jZLh+kXV7PWU5srmeU3p6XOlJyGPkFYPI//7xVr1uGkvjBCI7J9IytecGX?=
 =?iso-8859-1?Q?az2ULyQ3kghixHwamAIC9IBaUKIHon339qfsepAaLOiKiG9Hj7YLVhc8KI?=
 =?iso-8859-1?Q?otQlByXm0HVmD8iFDk4qpofG2ZYAFsMP+yy8hYiObhJesUOCrWkzLM6TrZ?=
 =?iso-8859-1?Q?psW0uJZP6J9VrivzDYjc/28vZi0oJizJ61H8xiUCrgfuU2Ko0fH8HxGH/N?=
 =?iso-8859-1?Q?bPzTOeE7SOV6xuvF+Avd51znLQChv8WKrniZWHvdZSJnvyw5PICe3vSf65?=
 =?iso-8859-1?Q?FBnHzum05qj6BXpp3Kt0nUhid4XG7OTONiOrnlc8ghU2L1NXHCmIOfBuob?=
 =?iso-8859-1?Q?S2cWkKGem0UafgmPsKpO6PePZvs+AAfhR21w8VY533Wbt++fb66iAK204a?=
 =?iso-8859-1?Q?YjXvN1VHpuLD3HDpjlOdzVCbil/UDCGkb0GXhATwoOePVVQw1TnNNBKNnM?=
 =?iso-8859-1?Q?UkBXRoaAbALug3NXhzbIEGp78Gd2xcP9tGYHd3l3yrJQN3XDhOW2DusV/1?=
 =?iso-8859-1?Q?sLr7Jr2EcFeJRegwHqwsrtKDeeEc94DsN007xOrc8bBavgu4nc53adKOK0?=
 =?iso-8859-1?Q?JWNW9baY7a0DXHsgqIP1bJFy62IxRO71U+ovg8IZVFebn1yRmw5KAXl4n6?=
 =?iso-8859-1?Q?2iyrAXY6fNyOnwcDwoFtwGpAc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b0b010-31e2-4189-ff89-08d9e185b49c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 11:11:02.6411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rfMlezRQzE+dAL1lIZ0Sa0cmey0dvbZ9nBBXYm76W9AqrYuxFdhEPe9wy5d58OBYNPjZ8OpwYmV7XHdv3BX55jhhxorNeVzVlhhBCe2l37E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB0442
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although kptr_restrict is set to 0 and the kernel is booted with
no_hash_pointers parameter, the content of /proc/vmallocinfo is
lacking the real addresses.

  / # cat /proc/vmallocinfo
  0x(ptrval)-0x(ptrval)    8192 load_module+0xc0c/0x2c0c pages=1 vmalloc
  0x(ptrval)-0x(ptrval)   12288 start_kernel+0x4e0/0x690 pages=2 vmalloc
  0x(ptrval)-0x(ptrval)   12288 start_kernel+0x4e0/0x690 pages=2 vmalloc
  0x(ptrval)-0x(ptrval)    8192 _mpic_map_mmio.constprop.0+0x20/0x44 phys=0x80041000 ioremap
  0x(ptrval)-0x(ptrval)   12288 _mpic_map_mmio.constprop.0+0x20/0x44 phys=0x80041000 ioremap
    ...

According to the documentation for /proc/sys/kernel/, %pK is
equivalent to %p when kptr_restrict is set to 0.

Fixes: 1ac2f9789c4b ("vsprintf: Consistent %pK handling for kptr_restrict == 0")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 lib/vsprintf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b8129dd374c..9c60d6e1a0d6 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -848,6 +848,10 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
 	return pointer_string(buf, end, (const void *)hashval, spec);
 }
 
+/* Disable pointer hashing if requested */
+bool no_hash_pointers __ro_after_init;
+EXPORT_SYMBOL_GPL(no_hash_pointers);
+
 int kptr_restrict __read_mostly;
 
 static noinline_for_stack
@@ -857,6 +861,8 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 	switch (kptr_restrict) {
 	case 0:
 		/* Handle as %p, hash and do _not_ leak addresses. */
+		if (unlikely(no_hash_pointers))
+			break;
 		return ptr_to_id(buf, end, ptr, spec);
 	case 1: {
 		const struct cred *cred;
@@ -2223,10 +2229,6 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
-/* Disable pointer hashing if requested */
-bool no_hash_pointers __ro_after_init;
-EXPORT_SYMBOL_GPL(no_hash_pointers);
-
 int __init no_hash_pointers_enable(char *str)
 {
 	if (no_hash_pointers)
-- 
2.33.1
