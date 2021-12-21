Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1B947C560
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240613AbhLURtx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Dec 2021 12:49:53 -0500
Received: from mail-eopbgr90040.outbound.protection.outlook.com ([40.107.9.40]:13408
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240595AbhLURtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:49:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkTif5pN10opXAFREXPIn9fZ/H1hpj7Hf2oKCogoEd1w2nkQVs1XFgzV/qj+6z1eqhZK+RONh2lddMVqMtju/TaHKELPprU1IjW7wlDIh+qBAiH1ACbhbl8wx6rqzzU3sBKHRqA6zSbX/gdxbg6xKUhnk+prSoSF/cevtpxf1MLyXa3zFXWHwcTF1fEZgDDCXwI/2kYuMtCZVbLGqvj7BFHHNPAvdYJtnh23veHBqwdf5nLb3YHGkVyhAVbKrwuMGvxFZtcCEDpNf6W4iOdgaUFma1WlCX2vjqpHEhrC0oipAVUPLmSQmpHRsyMrPQEbQkUPzczx0fVk+S9ODfoJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ABRNgxLzQ0BNDUAEuOwHogI29Vp1CUKg8nHHCja20Q=;
 b=Kfsate+xDt1WQ3e7EzOIMzFQPBeSEbVnaohVdy0RT28e7sv9/xeD/eKnzqrpflyJGvQnfPl5QvUsmi45277+szqBFcSfUo6mpXm0TQTr1r8Bl7S47NqpEQuQycGWvqO6NUZ14QJDCjwNd5GEPSGOEEDsumOQyb1UiddYNPXnEZzl84i/RN3Q9hKi+zgMB9tut1XHUKROtGrpguxdtPVtsKwuQhWWBA0So8dNlDkWCHjmmuJSsQWNsk2/RziirS2dMgsvQL9xRCyXt/bwZJ7WrsP5UN5PQzNotLeiiphQrNNDKLs/e1fTyuTZRWLWUdy71buw1r4HWVrl4RZcZLHwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1798.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16; Tue, 21 Dec
 2021 17:49:49 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f0ef:856d:b0de:e85d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f0ef:856d:b0de:e85d%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 17:49:49 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/3] powerpc/vdso: Merge vdso64 and vdso32 into a single
 directory
Thread-Topic: [PATCH 3/3] powerpc/vdso: Merge vdso64 and vdso32 into a single
 directory
Thread-Index: AQHX9pMmIYKmuL/N/EycBwCGCuWhQQ==
Date:   Tue, 21 Dec 2021 17:49:49 +0000
Message-ID: <c4ff129869fa6b0c936ff7e388eee42bb5f46778.1640108961.git.christophe.leroy@csgroup.eu>
References: <09b25a22cd5179eba4580ae95414f18fc162bedf.1640108961.git.christophe.leroy@csgroup.eu>
In-Reply-To: <09b25a22cd5179eba4580ae95414f18fc162bedf.1640108961.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50cf7717-6ec8-457a-0677-08d9c4aa48eb
x-ms-traffictypediagnostic: MRZP264MB1798:EE_
x-microsoft-antispam-prvs: <MRZP264MB17989C2860337C1A26902803ED7C9@MRZP264MB1798.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30tA/uyjmtt1tvueV3F2o8q5aMUCvquRv+CYcHRfMkfeJCh5pb9qMup2DI5e7QHheHJSbkCk2zAYUCrKqIe422Knoj0BECqb41EJOlruwhuOLh+vTDlybfzboaAclTNyltqESXKXB6uDIW5G+M/4MN8CcZdleiHPrkZ3aMeRyMGbbsyAfzEeQ48vq6ZIn9UcYfTKPXn2l39ke2t5FcVs3qdvuKuTW7By/nrheNfV7RkMFwv7m/rWexGoduoc/dgRqqTD17gqhzed9VW664j20qMXklJMZ50APGHB6nHJGQRviTpgbStRdEBlmOKOf7LNa0rnZUUZy5yvYjqh45SdL/TqDmgCcCVtWxKC+0bO+/xe0tO9/W8H9KewbUKnkdZrcbEArpBR1sTtfDOVkOgfIshV8EMgVctr4BcEc28DPrjyXeAyBSBYnPbW0Mlc9apd/ejdB2wZZWAnQwfzCUy9e47LrGwplaIlQ+DBF1S1iix+e3HZYIxrNsI7q1XU8O1/5/o+TVaiEwAMY6p4ayYrBVq7C1ybBU6oDZ0lE4Z50HphLEjLKXD7mloW55r2d+LwECRyq2GFbXG7m1tW0R5PNaRao1+fSLy7ZRNAZpavQx0mPCDRUUywRYdCaGAEGUBtcXfphorrUVP7kguUDDxptE/YFB5g4BQe6N7h2r1lxFXqePAvUfh264rw7GaFOVTlkNrUYEF3uwu71k0WlqWDxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(66556008)(66476007)(66446008)(2616005)(5660300002)(66946007)(6506007)(6512007)(6486002)(26005)(508600001)(2906002)(76116006)(186003)(91956017)(30864003)(38070700005)(54906003)(86362001)(110136005)(8936002)(316002)(122000001)(83380400001)(36756003)(71200400001)(44832011)(8676002)(4326008)(38100700002)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?klfINtBARgOogFVzGD5/BHmxC7XDLBvS6zfAEPPcQWvrovW5QGtawNvHx3?=
 =?iso-8859-1?Q?MQsGppJ3kwWwMxqvhbFm7GMEI0iTbdmr6UtQ6f2WmvLSK3vqjzhvZl2DZP?=
 =?iso-8859-1?Q?uIiWnFKYLYbklUnwCUGAQEOP3YpkltJdGFW09wPildMwT4Bcp5V+pJVHao?=
 =?iso-8859-1?Q?5gilS9HHxE933yTSjB82odx0ZyqjESEfxtEOe28Q4V72DWe/OWmJPEAlKV?=
 =?iso-8859-1?Q?ean1eEEr2AU/x2GgAnA8uMLxSPvkKS6l1hfFO4HyDSpCokFCHjH9ey32L8?=
 =?iso-8859-1?Q?wFTPPM5VDswN+PR/EwzJ2M3cyzIxQnMqjFwlJ8tB+tOIuHzXjqLWj/O6lM?=
 =?iso-8859-1?Q?x6apqJmDQc59nlgbnDszzzGCVUrLx9H8jWQxqZfYwWtiUWh6zg1Ugq03em?=
 =?iso-8859-1?Q?AA3WUtsL0j9CtHrUTTsSUldWl4Sdt2ynjF8NU629h1J7IoltW3TFYPw4sk?=
 =?iso-8859-1?Q?H2cgjXzCb36+/yh51ATIL4eRRzoKplIDYvvQD/Usr+jPlAUuzB3M44lcLL?=
 =?iso-8859-1?Q?lBIkmxkpneEFD2reoQf+MzDTdJbJO9OAYFFmoO+8e61CNOSYxqjRTRq4hY?=
 =?iso-8859-1?Q?5CYogI4W7hbn9sb+/sHWJ3zDUoH7RSWrj5RdP3yeEIId8lcFD4VaZzROtI?=
 =?iso-8859-1?Q?0+Emtu0MDrGBOLIWxSyfQNJc3ZEKfmLOEgng/7UjVFCiFZ4VjJluouy/V3?=
 =?iso-8859-1?Q?gOyTBnA+j5Hs8Uq/EyoK3KkdnZxvDp/gyeRsqgvhoZXjxEHjYKtd5fLr/+?=
 =?iso-8859-1?Q?A2erEfZxNpHryDnDHLq0680f52YQ95YI1VlCTmu4BiRL1JAwsIVxR1u4ms?=
 =?iso-8859-1?Q?q2vzlcfwG0E2Ixk4noBEwOeppYWcpz6gqrK4lRd4EY8KzIJ8LEIi+MuFmg?=
 =?iso-8859-1?Q?Z2Nli2lAt2lhtOpNm6HjjsxHBhv+HAkpGe/OE92VY/WM8K6n1rDsKOjm+O?=
 =?iso-8859-1?Q?V7IJeOyAXVtKA/clCh0LQXS22y3AL7zy43Dl2aKQEVuxJHoAFB2Wn4qxZW?=
 =?iso-8859-1?Q?iP0gC9LaBwSl1GHJWsHmbHgAM3RcGXp2yndJ+acjzJbZpTt9umLeCrmWF2?=
 =?iso-8859-1?Q?5FBAsguj5ILVneOe9h0iTsdBxuK7UHb0SdofRUeIjsIqjBviPSoP7yGYU8?=
 =?iso-8859-1?Q?T1keONJgUbr39HYg2jqgE4oVBIdMr2PpBtE9+xKgZzNTWSiAOHIfz6Uhfd?=
 =?iso-8859-1?Q?W5IsVzILVFFulJDYkggMQN9mewshx0uo3W0rl1Zb1SuqoxxjskwYO89tZ2?=
 =?iso-8859-1?Q?rgscUh0xG+0qIdcJq817JOaC098r/izXP/Pfw3TDdfgd2gni5Z/veAuJFE?=
 =?iso-8859-1?Q?RkE/H+XNnP52yyjrPt4VAqEv0zheMtv65km8cgIZiPxhFPgwHE1wnGqqKt?=
 =?iso-8859-1?Q?atiCxIICiw3+PDya71RdamjxGXBY+Vhxdtwphxj1+DsvONERhDDlGkilLD?=
 =?iso-8859-1?Q?D5g51ciPg4BWxwcSgFDw9qIpafehdokfbMNhll74liGYBMzPxOYWvl4AqQ?=
 =?iso-8859-1?Q?4IBBHN3P474p5IGG8SZ/sTHT2rXNcggLcNN8IqMaUuE4nkNl9HiecCEIdr?=
 =?iso-8859-1?Q?zH+5fJUD8/vcbSiQpl1atPjdnJXcr9IPxTEn9NjmVroGn+K4Eof7nQk82Q?=
 =?iso-8859-1?Q?2YYTcT/i8lj2uwiJduWSH8hob85eiJYpN70iTjgDZZR/07mu7S9KYjSVRR?=
 =?iso-8859-1?Q?qIAsmHImIGXoQkRSTIs02qu7Eq0N8L8FAn60H9QtrLYT6ECnt7wGMytpwc?=
 =?iso-8859-1?Q?Cyj27a3YLhX24uYNHFJJ29Gr4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cf7717-6ec8-457a-0677-08d9c4aa48eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 17:49:49.5701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DF6qIuM/0Qm40i5uyNo3/HD9fI5ZMPeqjCStJyYPm8qN6gzLzOdUusNXe0s8eSBj+VCFv+CiSn8FJ60BOYrUCBKLKT5LDYuAxMdEtYbTFYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1798
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merge vdso64 into vdso32 and rename it vdso.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Makefile                         |  4 +-
 arch/powerpc/kernel/Makefile                  |  6 +-
 .../kernel/{vdso64 => vdso}/.gitignore        |  2 +
 arch/powerpc/kernel/{vdso32 => vdso}/Makefile | 35 +++++++++
 .../kernel/{vdso32 => vdso}/cacheflush.S      |  0
 .../kernel/{vdso32 => vdso}/datapage.S        |  0
 .../{vdso32 => vdso}/gen_vdso32_offsets.sh    |  0
 .../gen_vdso64_offsets.sh}                    |  0
 arch/powerpc/kernel/{vdso32 => vdso}/getcpu.S |  0
 .../kernel/{vdso32 => vdso}/gettimeofday.S    |  0
 arch/powerpc/kernel/{vdso32 => vdso}/note.S   |  0
 .../kernel/{vdso32 => vdso}/sigtramp32.S      |  0
 .../{vdso64/sigtramp.S => vdso/sigtramp64.S}  |  0
 .../kernel/{vdso32 => vdso}/vdso32.lds.S      |  0
 .../kernel/{vdso64 => vdso}/vdso64.lds.S      |  0
 .../kernel/{vdso32 => vdso}/vgettimeofday.c   |  0
 arch/powerpc/kernel/vdso32/.gitignore         |  3 -
 arch/powerpc/kernel/vdso32_wrapper.S          |  2 +-
 arch/powerpc/kernel/vdso64/Makefile           | 56 --------------
 arch/powerpc/kernel/vdso64/cacheflush.S       | 75 -------------------
 arch/powerpc/kernel/vdso64/datapage.S         | 59 ---------------
 arch/powerpc/kernel/vdso64/getcpu.S           | 33 --------
 arch/powerpc/kernel/vdso64/gettimeofday.S     | 58 --------------
 arch/powerpc/kernel/vdso64/note.S             |  1 -
 arch/powerpc/kernel/vdso64/vgettimeofday.c    | 29 -------
 arch/powerpc/kernel/vdso64_wrapper.S          |  2 +-
 26 files changed, 44 insertions(+), 321 deletions(-)
 rename arch/powerpc/kernel/{vdso64 => vdso}/.gitignore (72%)
 rename arch/powerpc/kernel/{vdso32 => vdso}/Makefile (56%)
 rename arch/powerpc/kernel/{vdso32 => vdso}/cacheflush.S (100%)
 rename arch/powerpc/kernel/{vdso32 => vdso}/datapage.S (100%)
 rename arch/powerpc/kernel/{vdso32 => vdso}/gen_vdso32_offsets.sh (100%)
 rename arch/powerpc/kernel/{vdso64/gen_vdso_offsets.sh => vdso/gen_vdso64_offsets.sh} (100%)
 rename arch/powerpc/kernel/{vdso32 => vdso}/getcpu.S (100%)
 rename arch/powerpc/kernel/{vdso32 => vdso}/gettimeofday.S (100%)
 rename arch/powerpc/kernel/{vdso32 => vdso}/note.S (100%)
 rename arch/powerpc/kernel/{vdso32 => vdso}/sigtramp32.S (100%)
 rename arch/powerpc/kernel/{vdso64/sigtramp.S => vdso/sigtramp64.S} (100%)
 rename arch/powerpc/kernel/{vdso32 => vdso}/vdso32.lds.S (100%)
 rename arch/powerpc/kernel/{vdso64 => vdso}/vdso64.lds.S (100%)
 rename arch/powerpc/kernel/{vdso32 => vdso}/vgettimeofday.c (100%)
 delete mode 100644 arch/powerpc/kernel/vdso32/.gitignore
 delete mode 100644 arch/powerpc/kernel/vdso64/Makefile
 delete mode 100644 arch/powerpc/kernel/vdso64/cacheflush.S
 delete mode 100644 arch/powerpc/kernel/vdso64/datapage.S
 delete mode 100644 arch/powerpc/kernel/vdso64/getcpu.S
 delete mode 100644 arch/powerpc/kernel/vdso64/gettimeofday.S
 delete mode 100644 arch/powerpc/kernel/vdso64/note.S
 delete mode 100644 arch/powerpc/kernel/vdso64/vgettimeofday.c

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index e02568f17334..e668612812d6 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -419,9 +419,9 @@ ifeq ($(KBUILD_EXTMOD),)
 prepare: vdso_prepare
 vdso_prepare: prepare0
 	$(if $(CONFIG_VDSO32),$(Q)$(MAKE) \
-		$(build)=arch/powerpc/kernel/vdso32 include/generated/vdso32-offsets.h)
+		$(build)=arch/powerpc/kernel/vdso include/generated/vdso32-offsets.h)
 	$(if $(CONFIG_PPC64),$(Q)$(MAKE) \
-		$(build)=arch/powerpc/kernel/vdso64 include/generated/vdso64-offsets.h)
+		$(build)=arch/powerpc/kernel/vdso include/generated/vdso64-offsets.h)
 endif
 
 archprepare: checkbin
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 5fa68c2ef1f8..c626c55e35fc 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -194,8 +194,8 @@ targets += prom_init_check
 clean-files := vmlinux.lds
 
 # Force dependency (incbin is bad)
-$(obj)/vdso32_wrapper.o : $(obj)/vdso32/vdso32.so.dbg
-$(obj)/vdso64_wrapper.o : $(obj)/vdso64/vdso64.so.dbg
+$(obj)/vdso32_wrapper.o : $(obj)/vdso/vdso32.so.dbg
+$(obj)/vdso64_wrapper.o : $(obj)/vdso/vdso64.so.dbg
 
 # for cleaning
-subdir- += vdso32 vdso64
+subdir- += vdso
diff --git a/arch/powerpc/kernel/vdso64/.gitignore b/arch/powerpc/kernel/vdso/.gitignore
similarity index 72%
rename from arch/powerpc/kernel/vdso64/.gitignore
rename to arch/powerpc/kernel/vdso/.gitignore
index 84151a7ba31d..dd9bdd67758b 100644
--- a/arch/powerpc/kernel/vdso64/.gitignore
+++ b/arch/powerpc/kernel/vdso/.gitignore
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+vdso32.lds
+vdso32.so.dbg
 vdso64.lds
 vdso64.so.dbg
diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso/Makefile
similarity index 56%
rename from arch/powerpc/kernel/vdso32/Makefile
rename to arch/powerpc/kernel/vdso/Makefile
index 7d7b38d90ca5..954974287ee7 100644
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -6,6 +6,7 @@ ARCH_REL_TYPE_ABS := R_PPC_JUMP_SLOT|R_PPC_GLOB_DAT|R_PPC_ADDR32|R_PPC_ADDR24|R_
 include $(srctree)/lib/vdso/Makefile
 
 obj-vdso32 = sigtramp32-32.o gettimeofday-32.o datapage-32.o cacheflush-32.o note-32.o getcpu-32.o
+obj-vdso64 = sigtramp64-64.o gettimeofday-64.o datapage-64.o cacheflush-64.o note-64.o getcpu-64.o
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday-32.o += -include $(c-gettimeofday-y)
@@ -15,6 +16,17 @@ ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday-32.o += -ffreestanding -fasynchronous-unwind-tables
   CFLAGS_REMOVE_vgettimeofday-32.o = $(CC_FLAGS_FTRACE)
   CFLAGS_REMOVE_vgettimeofday-32.o += -mcmodel=medium -mabi=elfv1 -mabi=elfv2 -mcall-aixdesc
+  CFLAGS_vgettimeofday-64.o += -include $(c-gettimeofday-y)
+  CFLAGS_vgettimeofday-64.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
+  CFLAGS_vgettimeofday-64.o += $(call cc-option, -fno-stack-protector)
+  CFLAGS_vgettimeofday-64.o += -DDISABLE_BRANCH_PROFILING
+  CFLAGS_vgettimeofday-64.o += -ffreestanding -fasynchronous-unwind-tables
+  CFLAGS_REMOVE_vgettimeofday-64.o = $(CC_FLAGS_FTRACE)
+# Go prior to 1.16.x assumes r30 is not clobbered by any VDSO code. That used to be true
+# by accident when the VDSO was hand-written asm code, but may not be now that the VDSO is
+# compiler generated. To avoid breaking Go tell GCC not to use r30. Impact on code
+# generation is minimal, it will just use r29 instead.
+  CFLAGS_vgettimeofday-64.o += $(call cc-option, -ffixed-r30)
 endif
 
 # Build rules
@@ -27,6 +39,8 @@ endif
 
 targets := $(obj-vdso32) vdso32.so.dbg vgettimeofday-32.o
 obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
+targets += $(obj-vdso64) vdso64.so.dbg vgettimeofday-64.o
+obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
 
 GCOV_PROFILE := n
 KCOV_INSTRUMENT := n
@@ -38,26 +52,42 @@ ccflags-y := -shared -fno-common -fno-builtin -nostdlib -Wl,--hash-style=both
 CC32FLAGS := -Wl,-soname=linux-vdso32.so.1 -m32
 AS32FLAGS := -D__VDSO32__ -s
 
+CC64FLAGS := -Wl,-soname=linux-vdso64.so.1
+AS64FLAGS := -D__VDSO64__ -s
+
 targets += vdso32.lds
 CPPFLAGS_vdso32.lds += -P -C -Upowerpc
+targets += vdso64.lds
+CPPFLAGS_vdso64.lds += -P -C -U$(ARCH)
 
 # link rule for the .so file, .lds has to be first
 $(obj)/vdso32.so.dbg: $(src)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o FORCE
 	$(call if_changed,vdso32ld_and_check)
+$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o FORCE
+	$(call if_changed,vdso64ld_and_check)
 
 # assembly rules for the .S files
 $(obj-vdso32): %-32.o: %.S FORCE
 	$(call if_changed_dep,vdso32as)
 $(obj)/vgettimeofday-32.o: %-32.o: %.c FORCE
 	$(call if_changed_dep,vdso32cc)
+$(obj-vdso64): %-64.o: %.S FORCE
+	$(call if_changed_dep,vdso64as)
+$(obj)/vgettimeofday-64.o: %-64.o: %.c FORCE
+	$(call if_changed_dep,cc_o_c)
 
 # Generate VDSO offsets using helper script
 gen-vdso32sym := $(srctree)/$(src)/gen_vdso32_offsets.sh
 quiet_cmd_vdso32sym = VDSO32SYM $@
       cmd_vdso32sym = $(NM) $< | $(gen-vdso32sym) | LC_ALL=C sort > $@
+gen-vdso64sym := $(srctree)/$(src)/gen_vdso64_offsets.sh
+quiet_cmd_vdso64sym = VDSO64SYM $@
+      cmd_vdso64sym = $(NM) $< | $(gen-vdso64sym) | LC_ALL=C sort > $@
 
 include/generated/vdso32-offsets.h: $(obj)/vdso32.so.dbg FORCE
 	$(call if_changed,vdso32sym)
+include/generated/vdso64-offsets.h: $(obj)/vdso64.so.dbg FORCE
+	$(call if_changed,vdso64sym)
 
 # actual build commands
 quiet_cmd_vdso32ld_and_check = VDSO32L $@
@@ -66,3 +96,8 @@ quiet_cmd_vdso32as = VDSO32A $@
       cmd_vdso32as = $(VDSOCC) $(a_flags) $(CC32FLAGS) $(AS32FLAGS) -c -o $@ $<
 quiet_cmd_vdso32cc = VDSO32C $@
       cmd_vdso32cc = $(VDSOCC) $(c_flags) $(CC32FLAGS) -c -o $@ $<
+
+quiet_cmd_vdso64ld_and_check = VDSO64L $@
+      cmd_vdso64ld_and_check = $(VDSOCC) $(c_flags) $(CC64FLAGS) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^) ; $(cmd_vdso_check)
+quiet_cmd_vdso64as = VDSO64A $@
+      cmd_vdso64as = $(VDSOCC) $(a_flags) $(CC64FLAGS) $(AS64FLAGS) -c -o $@ $<
diff --git a/arch/powerpc/kernel/vdso32/cacheflush.S b/arch/powerpc/kernel/vdso/cacheflush.S
similarity index 100%
rename from arch/powerpc/kernel/vdso32/cacheflush.S
rename to arch/powerpc/kernel/vdso/cacheflush.S
diff --git a/arch/powerpc/kernel/vdso32/datapage.S b/arch/powerpc/kernel/vdso/datapage.S
similarity index 100%
rename from arch/powerpc/kernel/vdso32/datapage.S
rename to arch/powerpc/kernel/vdso/datapage.S
diff --git a/arch/powerpc/kernel/vdso32/gen_vdso32_offsets.sh b/arch/powerpc/kernel/vdso/gen_vdso32_offsets.sh
similarity index 100%
rename from arch/powerpc/kernel/vdso32/gen_vdso32_offsets.sh
rename to arch/powerpc/kernel/vdso/gen_vdso32_offsets.sh
diff --git a/arch/powerpc/kernel/vdso64/gen_vdso_offsets.sh b/arch/powerpc/kernel/vdso/gen_vdso64_offsets.sh
similarity index 100%
rename from arch/powerpc/kernel/vdso64/gen_vdso_offsets.sh
rename to arch/powerpc/kernel/vdso/gen_vdso64_offsets.sh
diff --git a/arch/powerpc/kernel/vdso32/getcpu.S b/arch/powerpc/kernel/vdso/getcpu.S
similarity index 100%
rename from arch/powerpc/kernel/vdso32/getcpu.S
rename to arch/powerpc/kernel/vdso/getcpu.S
diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso/gettimeofday.S
similarity index 100%
rename from arch/powerpc/kernel/vdso32/gettimeofday.S
rename to arch/powerpc/kernel/vdso/gettimeofday.S
diff --git a/arch/powerpc/kernel/vdso32/note.S b/arch/powerpc/kernel/vdso/note.S
similarity index 100%
rename from arch/powerpc/kernel/vdso32/note.S
rename to arch/powerpc/kernel/vdso/note.S
diff --git a/arch/powerpc/kernel/vdso32/sigtramp32.S b/arch/powerpc/kernel/vdso/sigtramp32.S
similarity index 100%
rename from arch/powerpc/kernel/vdso32/sigtramp32.S
rename to arch/powerpc/kernel/vdso/sigtramp32.S
diff --git a/arch/powerpc/kernel/vdso64/sigtramp.S b/arch/powerpc/kernel/vdso/sigtramp64.S
similarity index 100%
rename from arch/powerpc/kernel/vdso64/sigtramp.S
rename to arch/powerpc/kernel/vdso/sigtramp64.S
diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso/vdso32.lds.S
similarity index 100%
rename from arch/powerpc/kernel/vdso32/vdso32.lds.S
rename to arch/powerpc/kernel/vdso/vdso32.lds.S
diff --git a/arch/powerpc/kernel/vdso64/vdso64.lds.S b/arch/powerpc/kernel/vdso/vdso64.lds.S
similarity index 100%
rename from arch/powerpc/kernel/vdso64/vdso64.lds.S
rename to arch/powerpc/kernel/vdso/vdso64.lds.S
diff --git a/arch/powerpc/kernel/vdso32/vgettimeofday.c b/arch/powerpc/kernel/vdso/vgettimeofday.c
similarity index 100%
rename from arch/powerpc/kernel/vdso32/vgettimeofday.c
rename to arch/powerpc/kernel/vdso/vgettimeofday.c
diff --git a/arch/powerpc/kernel/vdso32/.gitignore b/arch/powerpc/kernel/vdso32/.gitignore
deleted file mode 100644
index 824b863ec6bd..000000000000
--- a/arch/powerpc/kernel/vdso32/.gitignore
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-vdso32.lds
-vdso32.so.dbg
diff --git a/arch/powerpc/kernel/vdso32_wrapper.S b/arch/powerpc/kernel/vdso32_wrapper.S
index 3f5ef035b0a9..10f92f265d51 100644
--- a/arch/powerpc/kernel/vdso32_wrapper.S
+++ b/arch/powerpc/kernel/vdso32_wrapper.S
@@ -7,7 +7,7 @@
 	.globl vdso32_start, vdso32_end
 	.balign PAGE_SIZE
 vdso32_start:
-	.incbin "arch/powerpc/kernel/vdso32/vdso32.so.dbg"
+	.incbin "arch/powerpc/kernel/vdso/vdso32.so.dbg"
 	.balign PAGE_SIZE
 vdso32_end:
 
diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
deleted file mode 100644
index 3c5baaa6f1e7..000000000000
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ /dev/null
@@ -1,56 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# List of files in the vdso, has to be asm only for now
-
-ARCH_REL_TYPE_ABS := R_PPC_JUMP_SLOT|R_PPC_GLOB_DAT|R_PPC_ADDR32|R_PPC_ADDR24|R_PPC_ADDR16|R_PPC_ADDR16_LO|R_PPC_ADDR16_HI|R_PPC_ADDR16_HA|R_PPC_ADDR14|R_PPC_ADDR14_BRTAKEN|R_PPC_ADDR14_BRNTAKEN|R_PPC_REL24
-include $(srctree)/lib/vdso/Makefile
-
-obj-vdso64 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o getcpu.o
-
-ifneq ($(c-gettimeofday-y),)
-  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
-  CFLAGS_vgettimeofday.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
-  CFLAGS_vgettimeofday.o += $(call cc-option, -fno-stack-protector)
-  CFLAGS_vgettimeofday.o += -DDISABLE_BRANCH_PROFILING
-  CFLAGS_vgettimeofday.o += -ffreestanding -fasynchronous-unwind-tables
-  CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE)
-endif
-
-# Build rules
-
-targets := $(obj-vdso64) vdso64.so.dbg vgettimeofday.o
-obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
-
-GCOV_PROFILE := n
-KCOV_INSTRUMENT := n
-UBSAN_SANITIZE := n
-KASAN_SANITIZE := n
-
-ccflags-y := -shared -fno-common -fno-builtin -nostdlib \
-	-Wl,-soname=linux-vdso64.so.1 -Wl,--hash-style=both
-
-# Go prior to 1.16.x assumes r30 is not clobbered by any VDSO code. That used to be true
-# by accident when the VDSO was hand-written asm code, but may not be now that the VDSO is
-# compiler generated. To avoid breaking Go tell GCC not to use r30. Impact on code
-# generation is minimal, it will just use r29 instead.
-ccflags-y += $(call cc-option, -ffixed-r30)
-
-asflags-y := -D__VDSO64__ -s
-
-targets += vdso64.lds
-CPPFLAGS_vdso64.lds += -P -C -U$(ARCH)
-
-# link rule for the .so file, .lds has to be first
-$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday.o FORCE
-	$(call if_changed,vdso64ld_and_check)
-
-# Generate VDSO offsets using helper script
-gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
-quiet_cmd_vdsosym = VDSOSYM $@
-      cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
-
-include/generated/vdso64-offsets.h: $(obj)/vdso64.so.dbg FORCE
-	$(call if_changed,vdsosym)
-
-# actual build commands
-quiet_cmd_vdso64ld_and_check = VDSO64L $@
-      cmd_vdso64ld_and_check = $(CC) $(c_flags) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^); $(cmd_vdso_check)
diff --git a/arch/powerpc/kernel/vdso64/cacheflush.S b/arch/powerpc/kernel/vdso64/cacheflush.S
deleted file mode 100644
index 76c3c8cf8ece..000000000000
--- a/arch/powerpc/kernel/vdso64/cacheflush.S
+++ /dev/null
@@ -1,75 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * vDSO provided cache flush routines
- *
- * Copyright (C) 2004 Benjamin Herrenschmuidt (benh@kernel.crashing.org),
- *                    IBM Corp.
- */
-#include <asm/processor.h>
-#include <asm/ppc_asm.h>
-#include <asm/vdso.h>
-#include <asm/vdso_datapage.h>
-#include <asm/asm-offsets.h>
-
-	.text
-
-/*
- * Default "generic" version of __kernel_sync_dicache.
- *
- * void __kernel_sync_dicache(unsigned long start, unsigned long end)
- *
- * Flushes the data cache & invalidate the instruction cache for the
- * provided range [start, end[
- */
-V_FUNCTION_BEGIN(__kernel_sync_dicache)
-  .cfi_startproc
-BEGIN_FTR_SECTION
-	b	3f
-END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
-	mflr	r12
-  .cfi_register lr,r12
-	get_datapage	r10
-	mtlr	r12
-  .cfi_restore lr
-
-	lwz	r7,CFG_DCACHE_BLOCKSZ(r10)
-	addi	r5,r7,-1
-	andc	r6,r3,r5		/* round low to line bdy */
-	subf	r8,r6,r4		/* compute length */
-	add	r8,r8,r5		/* ensure we get enough */
-	lwz	r9,CFG_DCACHE_LOGBLOCKSZ(r10)
-	srd.	r8,r8,r9		/* compute line count */
-	crclr	cr0*4+so
-	beqlr				/* nothing to do? */
-	mtctr	r8
-1:	dcbst	0,r6
-	add	r6,r6,r7
-	bdnz	1b
-	sync
-
-/* Now invalidate the instruction cache */
-
-	lwz	r7,CFG_ICACHE_BLOCKSZ(r10)
-	addi	r5,r7,-1
-	andc	r6,r3,r5		/* round low to line bdy */
-	subf	r8,r6,r4		/* compute length */
-	add	r8,r8,r5
-	lwz	r9,CFG_ICACHE_LOGBLOCKSZ(r10)
-	srd.	r8,r8,r9		/* compute line count */
-	crclr	cr0*4+so
-	beqlr				/* nothing to do? */
-	mtctr	r8
-2:	icbi	0,r6
-	add	r6,r6,r7
-	bdnz	2b
-	isync
-	li	r3,0
-	blr
-3:
-	crclr	cr0*4+so
-	sync
-	isync
-	li	r3,0
-	blr
-  .cfi_endproc
-V_FUNCTION_END(__kernel_sync_dicache)
diff --git a/arch/powerpc/kernel/vdso64/datapage.S b/arch/powerpc/kernel/vdso64/datapage.S
deleted file mode 100644
index 00760dc69d68..000000000000
--- a/arch/powerpc/kernel/vdso64/datapage.S
+++ /dev/null
@@ -1,59 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Access to the shared data page by the vDSO & syscall map
- *
- * Copyright (C) 2004 Benjamin Herrenschmuidt (benh@kernel.crashing.org), IBM Corp.
- */
-
-#include <asm/processor.h>
-#include <asm/ppc_asm.h>
-#include <asm/asm-offsets.h>
-#include <asm/unistd.h>
-#include <asm/vdso.h>
-#include <asm/vdso_datapage.h>
-
-	.text
-
-/*
- * void *__kernel_get_syscall_map(unsigned int *syscall_count) ;
- *
- * returns a pointer to the syscall map. the map is agnostic to the
- * size of "long", unlike kernel bitops, it stores bits from top to
- * bottom so that memory actually contains a linear bitmap
- * check for syscall N by testing bit (0x80000000 >> (N & 0x1f)) of
- * 32 bits int at N >> 5.
- */
-V_FUNCTION_BEGIN(__kernel_get_syscall_map)
-  .cfi_startproc
-	mflr	r12
-  .cfi_register lr,r12
-	mr	r4,r3
-	get_datapage	r3
-	mtlr	r12
-	addi	r3,r3,CFG_SYSCALL_MAP64
-	cmpldi	cr0,r4,0
-	crclr	cr0*4+so
-	beqlr
-	li	r0,NR_syscalls
-	stw	r0,0(r4)
-	blr
-  .cfi_endproc
-V_FUNCTION_END(__kernel_get_syscall_map)
-
-
-/*
- * void unsigned long  __kernel_get_tbfreq(void);
- *
- * returns the timebase frequency in HZ
- */
-V_FUNCTION_BEGIN(__kernel_get_tbfreq)
-  .cfi_startproc
-	mflr	r12
-  .cfi_register lr,r12
-	get_datapage	r3
-	ld	r3,CFG_TB_TICKS_PER_SEC(r3)
-	mtlr	r12
-	crclr	cr0*4+so
-	blr
-  .cfi_endproc
-V_FUNCTION_END(__kernel_get_tbfreq)
diff --git a/arch/powerpc/kernel/vdso64/getcpu.S b/arch/powerpc/kernel/vdso64/getcpu.S
deleted file mode 100644
index 12bbf236cdc4..000000000000
--- a/arch/powerpc/kernel/vdso64/getcpu.S
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *
- * Copyright (C) IBM Corporation, 2012
- *
- * Author: Anton Blanchard <anton@au.ibm.com>
- */
-#include <asm/ppc_asm.h>
-#include <asm/vdso.h>
-
-	.text
-/*
- * Exact prototype of getcpu
- *
- * int __kernel_getcpu(unsigned *cpu, unsigned *node);
- *
- */
-V_FUNCTION_BEGIN(__kernel_getcpu)
-  .cfi_startproc
-	mfspr	r5,SPRN_SPRG_VDSO_READ
-	cmpdi	cr0,r3,0
-	cmpdi	cr1,r4,0
-	clrlwi  r6,r5,16
-	rlwinm  r7,r5,16,31-15,31-0
-	beq	cr0,1f
-	stw	r6,0(r3)
-1:	beq	cr1,2f
-	stw	r7,0(r4)
-2:	crclr	cr0*4+so
-	li	r3,0			/* always success */
-	blr
-  .cfi_endproc
-V_FUNCTION_END(__kernel_getcpu)
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
deleted file mode 100644
index d7a7bfb51081..000000000000
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ /dev/null
@@ -1,58 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Userland implementation of gettimeofday() for 64 bits processes in a
- * ppc64 kernel for use in the vDSO
- *
- * Copyright (C) 2004 Benjamin Herrenschmuidt (benh@kernel.crashing.org),
- *                    IBM Corp.
- */
-#include <asm/processor.h>
-#include <asm/ppc_asm.h>
-#include <asm/vdso.h>
-#include <asm/vdso_datapage.h>
-#include <asm/asm-offsets.h>
-#include <asm/unistd.h>
-#include <asm/vdso/gettimeofday.h>
-
-	.text
-/*
- * Exact prototype of gettimeofday
- *
- * int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz);
- *
- */
-V_FUNCTION_BEGIN(__kernel_gettimeofday)
-	cvdso_call __c_kernel_gettimeofday
-V_FUNCTION_END(__kernel_gettimeofday)
-
-
-/*
- * Exact prototype of clock_gettime()
- *
- * int __kernel_clock_gettime(clockid_t clock_id, struct timespec *tp);
- *
- */
-V_FUNCTION_BEGIN(__kernel_clock_gettime)
-	cvdso_call __c_kernel_clock_gettime
-V_FUNCTION_END(__kernel_clock_gettime)
-
-
-/*
- * Exact prototype of clock_getres()
- *
- * int __kernel_clock_getres(clockid_t clock_id, struct timespec *res);
- *
- */
-V_FUNCTION_BEGIN(__kernel_clock_getres)
-	cvdso_call __c_kernel_clock_getres
-V_FUNCTION_END(__kernel_clock_getres)
-
-/*
- * Exact prototype of time()
- *
- * time_t time(time *t);
- *
- */
-V_FUNCTION_BEGIN(__kernel_time)
-	cvdso_call_time __c_kernel_time
-V_FUNCTION_END(__kernel_time)
diff --git a/arch/powerpc/kernel/vdso64/note.S b/arch/powerpc/kernel/vdso64/note.S
deleted file mode 100644
index dc2a509f7e8a..000000000000
--- a/arch/powerpc/kernel/vdso64/note.S
+++ /dev/null
@@ -1 +0,0 @@
-#include "../vdso32/note.S"
diff --git a/arch/powerpc/kernel/vdso64/vgettimeofday.c b/arch/powerpc/kernel/vdso64/vgettimeofday.c
deleted file mode 100644
index 5b5500058344..000000000000
--- a/arch/powerpc/kernel/vdso64/vgettimeofday.c
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Powerpc userspace implementations of gettimeofday() and similar.
- */
-#include <linux/time.h>
-#include <linux/types.h>
-
-int __c_kernel_clock_gettime(clockid_t clock, struct __kernel_timespec *ts,
-			     const struct vdso_data *vd)
-{
-	return __cvdso_clock_gettime_data(vd, clock, ts);
-}
-
-int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz,
-			    const struct vdso_data *vd)
-{
-	return __cvdso_gettimeofday_data(vd, tv, tz);
-}
-
-int __c_kernel_clock_getres(clockid_t clock_id, struct __kernel_timespec *res,
-			    const struct vdso_data *vd)
-{
-	return __cvdso_clock_getres_data(vd, clock_id, res);
-}
-
-__kernel_old_time_t __c_kernel_time(__kernel_old_time_t *time, const struct vdso_data *vd)
-{
-	return __cvdso_time_data(vd, time);
-}
diff --git a/arch/powerpc/kernel/vdso64_wrapper.S b/arch/powerpc/kernel/vdso64_wrapper.S
index 1d56d81fe3b3..839d1a61411d 100644
--- a/arch/powerpc/kernel/vdso64_wrapper.S
+++ b/arch/powerpc/kernel/vdso64_wrapper.S
@@ -7,7 +7,7 @@
 	.globl vdso64_start, vdso64_end
 	.balign PAGE_SIZE
 vdso64_start:
-	.incbin "arch/powerpc/kernel/vdso64/vdso64.so.dbg"
+	.incbin "arch/powerpc/kernel/vdso/vdso64.so.dbg"
 	.balign PAGE_SIZE
 vdso64_end:
 
-- 
2.33.1
