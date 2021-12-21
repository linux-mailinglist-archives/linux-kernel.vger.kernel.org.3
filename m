Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6352E47C55F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbhLURtl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Dec 2021 12:49:41 -0500
Received: from mail-eopbgr90077.outbound.protection.outlook.com ([40.107.9.77]:37600
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240595AbhLURtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:49:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSYJzyvVi8dfvyD7ZSTqqVgAMo9CCSFkeZqUqS0ax63mLEBw39mjpx4nGE7vQj0AQMYlMVqwhQ2b7mXsteOaeKBKShY3jsuPalV2nA8C/4aRUPc3FX/F15rCdf3uA6HKdZASotfUKnQ3GjZHuwdaMhsiAJ2XOAE4XSs13g+tGXkLKC3MlyMvcNzE3NU6pD43wQboJdjq6UYS6G2KAPHk5k3Jgx8IQ6HzSFX81WA/JXeosWShVutmJu0LDq78ihSBRetneSY9X8pejbqp+zj5Vqkg3LRBwgLB8reblmGgyAFNNOrPK3SQ1xFoqjdLKFr0p4tPc53vRTC6wQ9i9LVUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2uoIMr7ouwSiiTxtmQ00wCzL0EFew1/CqzIpuCx3MU=;
 b=j09XNvDAouVh369Eh9aQ0j1JmNKf/6rCUHaAgIFewtWqIQw6DaK+C9PTw46+cbprZw9EVrnXBo5dy6K8eTx8QGEzUBdp/7Fv4E6/RSF7mpWuvmNcH3hHfNL0F1RwhoT/rtkuawTuOmNOT//NCFY6Jc0mq5M9+uprmsXvSxpsCbYaajE4Y9i4xgG6DKT0iaTwDk7vy4CHgBh81AXJ8O7PXuKpUAXwu7Qgz6LOdCu+K3Mq8v8JYHGS4Z4B2huV2pPKI/R/ObSIkwGwAfzd1VtlqPzdM0cR5QBKfrHv1FW5a0LQgMSTk/18Ympo3xgxwj91iChEh+1BDHBrqjaze/nQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRXP264MB0648.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:21::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 17:49:39 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f0ef:856d:b0de:e85d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f0ef:856d:b0de:e85d%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 17:49:39 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/3] powerpc/vdso: Rework VDSO32 makefile to add a prefix to
 object files
Thread-Topic: [PATCH 2/3] powerpc/vdso: Rework VDSO32 makefile to add a prefix
 to object files
Thread-Index: AQHX9pMgi7Z9cv3SfEOftOggZd+0DA==
Date:   Tue, 21 Dec 2021 17:49:38 +0000
Message-ID: <d7e0bc71201b5bfeb2d30722cdfeaa3a66a4207a.1640108961.git.christophe.leroy@csgroup.eu>
References: <09b25a22cd5179eba4580ae95414f18fc162bedf.1640108961.git.christophe.leroy@csgroup.eu>
In-Reply-To: <09b25a22cd5179eba4580ae95414f18fc162bedf.1640108961.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6240991a-157c-4a87-7a04-08d9c4aa429c
x-ms-traffictypediagnostic: MRXP264MB0648:EE_
x-microsoft-antispam-prvs: <MRXP264MB064896975E9B3B854E07972BED7C9@MRXP264MB0648.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fh8E4uOyOEtadum3aeqTyyLaEB06J4BSyPqNvd5uUXSYlNO6hzkiBqz59c5+pPlB2S5G43TuMlzdV2lTTVjyPR9CRUso5PEOc1qWAfuKsBSOYNJ+HDEv0Vqij5HmnZJwEZnXptT3bx+nZ6m2j1sNnXegDQKc+x425Be24FHu0Q358xeKZ+dtWxqCK5kVGs7mn3XbMcpG8XrO8RHbGj1dTxdbcJxHqOdVewBjKPfHPEuQCv9DSqZFg+UOCyo6d7DjtigpH9AsPXW5U9BqsgZk1vnSHQgeQsS2r4dIHtj3l8Qbi0akmEv/YHWQW/ctnPWmkWrdxT3Usc2TB+v6+iSF5QW34w+SLY6FwCPiKD6qCQQpZD3XhLqawg5yuQ36VRWon3q76S0RYcG3OhG4bQ/xtQBfZZc5L4W9KBGjOc72njGp6kLaDfLOvW0SHryvNYaHS1Y6csVpgF5vyVBcKSM0lG+mMKOvEa99DZ9/OL5nzUulEUFThKnbPwJE7QSNJdhwN6bkEpYjizDL+LDxWGBmFDoWKjzR/U4lTEBwhpeKC/2mgQWZbfKUeDjVk+3+RI9+Kkr9lrYUR58hv0tHzc3ZhuFzRDBiSc9gD2oZSVCNNkcZlBCpFZnqunWoezfGNhrV8YWQFe6B9E1zu52OAdi4kKcU7B0mat13qWbLkClyhp/iQZP1Y8G5qjk/dZcDOVn94FgZChYlCGd5QodEU8oRow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(54906003)(186003)(5660300002)(6486002)(38070700005)(26005)(6512007)(44832011)(64756008)(110136005)(38100700002)(508600001)(66476007)(66946007)(66556008)(91956017)(66446008)(76116006)(71200400001)(86362001)(2616005)(316002)(6506007)(122000001)(8936002)(2906002)(4326008)(83380400001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uAPjxtH7jOu6MYyaaLkhBmV+HH8YE3p8LEziYdLKFyTyQ4jUZsGvszEPI0?=
 =?iso-8859-1?Q?yVLqWLPSPGzzOW3XaqcORLz6JVBSWvF8RBB2RynZgUuF47ziX8QpaMnP4L?=
 =?iso-8859-1?Q?1faZNYTgVAgV5iSWDZVad/NCXqLHsjDMJzFVM9gpP745mGYCXz949DaeGp?=
 =?iso-8859-1?Q?6w8mn7pcefUZD1WZH6tkkvhm53scneqiKGfrek56qXNPIN582Yax9hZVfg?=
 =?iso-8859-1?Q?rWmPc2elBR7MuqlBhtLtDsQToyEvFxSzmaKV42dL2nmZXFxrTE2LfkWZHw?=
 =?iso-8859-1?Q?TlRzU1Xgc7toA3+M77wjniPtA6Cx4/CWpf9/2pW75SMcHP4cwIfHKgCTYY?=
 =?iso-8859-1?Q?nu7lwrZe1dq2AWbiQVNBDCYoL45KLZRIUL6W8PvMirmSqEJGEvU6UolX8+?=
 =?iso-8859-1?Q?jw8Ab7a46hNHsdAhcYyFv08eAwNmvnAbchQ0n1SgshDAFd1zXu5S85S4s1?=
 =?iso-8859-1?Q?gbakkA7OcOTEsq/nk20Zwk/joVgO8yFOsnEaLFQS8F8AX5iFH6BcmeXUcz?=
 =?iso-8859-1?Q?68bqEO7ngM34DDtgqalS3o/E7SlxKYSbIxZye+GXeBx8mnrEAV7CV9wPtX?=
 =?iso-8859-1?Q?99KdHw8N3NIPqYs+jS2Hpx/PsCTT4c938v+zFXLURy0CiHfuvdtEbEMCI4?=
 =?iso-8859-1?Q?ehDJRcFsL2Bfo3lKanTEvTbH0IdGzhTBttD7LwSFQ2j4Mpmvm2eWacgp6c?=
 =?iso-8859-1?Q?WVjN7AYniYP7npO/CPGLiC0/IYJxl+LYJj5yC/mwEqsRRPzWPCz2vEJ+xH?=
 =?iso-8859-1?Q?sH4oGhKYsFYYFrrJ3yjwtM9cZR9dGofdaWp0WLp6EVeEAvduokdRmsgw/F?=
 =?iso-8859-1?Q?YcLphK3/tt5q/HZUBmHtF7Dd8HVO5n9Gc6gOcmthl0Y9XwtKLMeLuRA328?=
 =?iso-8859-1?Q?MdBKk4OJX0iGUMYFfm98/BMcE0STBtqN2bqb8CQV8UMyv93gqpLLrWJTLp?=
 =?iso-8859-1?Q?kYcQH1CJvIlzTkEUT5it2h4oifEs0uByoWtBmqLkJCNx92uFuyY2FWzVRc?=
 =?iso-8859-1?Q?7QFPuFLQD5xaXEr06sNOkfgm5gixkKCLvHtUq7AGm1wXizMUYB7Rn9f3mU?=
 =?iso-8859-1?Q?h/YKE7xthwzNR5ZJdfIlREPyYyg6Smwz/UyrWCQxmHh3usDxwvB1tOJ+3W?=
 =?iso-8859-1?Q?TAwL7xOQ+irA+UFqF3it2Yomo4KSV6J+fYWjQ/IEaloVhg9JJl04LhoLsQ?=
 =?iso-8859-1?Q?GIg9UxG0WeS9JZrs+cr+lpZZXevJcd8o9L/XnUyc+ZgDSs2F81Ywul7FW1?=
 =?iso-8859-1?Q?6gMnqy/ub6HdDiitG8CzPuZJTWl3RFN4bRsFS5SIrE0tq/dc1KpxopBihl?=
 =?iso-8859-1?Q?qMYqyptSh/qNxIuXor3FJjjBTXSVhDDybo7Kc7sVJE5RaTNzqtptlb/piN?=
 =?iso-8859-1?Q?UES7QO0iT9H/FUiCKz7TakqLJRhL0g0Oh+GjqEGGwZh08Dkdg5Pwj10bGd?=
 =?iso-8859-1?Q?g3dN04mQeShFdGct2a4ytu3Csvv4DcDKmFMCxt8i4vJclH5RrV7FL/tarA?=
 =?iso-8859-1?Q?Tlq7DI8F2Pz0y1qYYSKokpH/mqsVDmm+OE9GaFP6SshGzLF0OZv6t6IjnY?=
 =?iso-8859-1?Q?ziFGtBj01U1FsIFCN6dZE09JU1fgZgBJitFyX7ktxwDlkpKlxDif6WvtQ9?=
 =?iso-8859-1?Q?uE1eWj/2Xy4kikbEMIVnX1EPvQA98TJ58ukehDEyuFW4J1yWQ2VIVAkiQx?=
 =?iso-8859-1?Q?uKPTe4U7+Prg+DiH4C2FrZ2OSKHsLXF/Gl0HylW6riM/Jk9vdf9iqmHZ7A?=
 =?iso-8859-1?Q?Jr3L+YYLS7rNbbi6YUN0Bmc+A=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6240991a-157c-4a87-7a04-08d9c4aa429c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 17:49:39.0046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+9YPPKPyVvl4pA4v2yarBAO7SfPTWOBZgxevKHHieu3YSqJc23mYkb+l/bppBZB6qjv3CbYpk9Y8lRn0+L8bTOhAgQcWMm6C00npe+3JDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRXP264MB0648
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to merge vdso32 and vdso64 build in following patch, rework
Makefile is order to add -32 suffix to VDSO32 object files.

Also change sigtramp.S to sigtramp32.S as VDSO64 sigtramp.S is too
different to be squashed into VDSO32 sigtramp.S at the first place.

gen_vdso_offsets.sh also becomes gen_vdso32_offsets.sh

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso32/Makefile           | 47 +++++++++----------
 ..._vdso_offsets.sh => gen_vdso32_offsets.sh} |  0
 .../vdso32/{sigtramp.S => sigtramp32.S}       |  0
 3 files changed, 21 insertions(+), 26 deletions(-)
 rename arch/powerpc/kernel/vdso32/{gen_vdso_offsets.sh => gen_vdso32_offsets.sh} (100%)
 rename arch/powerpc/kernel/vdso32/{sigtramp.S => sigtramp32.S} (100%)

diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
index 7d9a6fee0e3d..7d7b38d90ca5 100644
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso32/Makefile
@@ -5,15 +5,16 @@
 ARCH_REL_TYPE_ABS := R_PPC_JUMP_SLOT|R_PPC_GLOB_DAT|R_PPC_ADDR32|R_PPC_ADDR24|R_PPC_ADDR16|R_PPC_ADDR16_LO|R_PPC_ADDR16_HI|R_PPC_ADDR16_HA|R_PPC_ADDR14|R_PPC_ADDR14_BRTAKEN|R_PPC_ADDR14_BRNTAKEN|R_PPC_REL24
 include $(srctree)/lib/vdso/Makefile
 
-obj-vdso32 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o getcpu.o
+obj-vdso32 = sigtramp32-32.o gettimeofday-32.o datapage-32.o cacheflush-32.o note-32.o getcpu-32.o
 
 ifneq ($(c-gettimeofday-y),)
-  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
-  CFLAGS_vgettimeofday.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
-  CFLAGS_vgettimeofday.o += $(call cc-option, -fno-stack-protector)
-  CFLAGS_vgettimeofday.o += -DDISABLE_BRANCH_PROFILING
-  CFLAGS_vgettimeofday.o += -ffreestanding -fasynchronous-unwind-tables
-  CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE)
+  CFLAGS_vgettimeofday-32.o += -include $(c-gettimeofday-y)
+  CFLAGS_vgettimeofday-32.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
+  CFLAGS_vgettimeofday-32.o += $(call cc-option, -fno-stack-protector)
+  CFLAGS_vgettimeofday-32.o += -DDISABLE_BRANCH_PROFILING
+  CFLAGS_vgettimeofday-32.o += -ffreestanding -fasynchronous-unwind-tables
+  CFLAGS_REMOVE_vgettimeofday-32.o = $(CC_FLAGS_FTRACE)
+  CFLAGS_REMOVE_vgettimeofday-32.o += -mcmodel=medium -mabi=elfv1 -mabi=elfv2 -mcall-aixdesc
 endif
 
 # Build rules
@@ -24,13 +25,7 @@ else
     VDSOCC := $(CC)
 endif
 
-CC32FLAGS :=
-ifdef CONFIG_PPC64
-CC32FLAGS += -m32
-KBUILD_CFLAGS := $(filter-out -mcmodel=medium -mabi=elfv1 -mabi=elfv2 -mcall-aixdesc,$(KBUILD_CFLAGS))
-endif
-
-targets := $(obj-vdso32) vdso32.so.dbg vgettimeofday.o
+targets := $(obj-vdso32) vdso32.so.dbg vgettimeofday-32.o
 obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
 
 GCOV_PROFILE := n
@@ -38,36 +33,36 @@ KCOV_INSTRUMENT := n
 UBSAN_SANITIZE := n
 KASAN_SANITIZE := n
 
-ccflags-y := -shared -fno-common -fno-builtin -nostdlib \
-	-Wl,-soname=linux-vdso32.so.1 -Wl,--hash-style=both
-asflags-y := -D__VDSO32__ -s
+ccflags-y := -shared -fno-common -fno-builtin -nostdlib -Wl,--hash-style=both
+
+CC32FLAGS := -Wl,-soname=linux-vdso32.so.1 -m32
+AS32FLAGS := -D__VDSO32__ -s
 
-obj-y += vdso32_wrapper.o
 targets += vdso32.lds
 CPPFLAGS_vdso32.lds += -P -C -Upowerpc
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso32.so.dbg: $(src)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday.o FORCE
+$(obj)/vdso32.so.dbg: $(src)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o FORCE
 	$(call if_changed,vdso32ld_and_check)
 
 # assembly rules for the .S files
-$(obj-vdso32): %.o: %.S FORCE
+$(obj-vdso32): %-32.o: %.S FORCE
 	$(call if_changed_dep,vdso32as)
-$(obj)/vgettimeofday.o: %.o: %.c FORCE
+$(obj)/vgettimeofday-32.o: %-32.o: %.c FORCE
 	$(call if_changed_dep,vdso32cc)
 
 # Generate VDSO offsets using helper script
-gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
-quiet_cmd_vdsosym = VDSOSYM $@
-      cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
+gen-vdso32sym := $(srctree)/$(src)/gen_vdso32_offsets.sh
+quiet_cmd_vdso32sym = VDSO32SYM $@
+      cmd_vdso32sym = $(NM) $< | $(gen-vdso32sym) | LC_ALL=C sort > $@
 
 include/generated/vdso32-offsets.h: $(obj)/vdso32.so.dbg FORCE
-	$(call if_changed,vdsosym)
+	$(call if_changed,vdso32sym)
 
 # actual build commands
 quiet_cmd_vdso32ld_and_check = VDSO32L $@
       cmd_vdso32ld_and_check = $(VDSOCC) $(c_flags) $(CC32FLAGS) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^) ; $(cmd_vdso_check)
 quiet_cmd_vdso32as = VDSO32A $@
-      cmd_vdso32as = $(VDSOCC) $(a_flags) $(CC32FLAGS) -c -o $@ $<
+      cmd_vdso32as = $(VDSOCC) $(a_flags) $(CC32FLAGS) $(AS32FLAGS) -c -o $@ $<
 quiet_cmd_vdso32cc = VDSO32C $@
       cmd_vdso32cc = $(VDSOCC) $(c_flags) $(CC32FLAGS) -c -o $@ $<
diff --git a/arch/powerpc/kernel/vdso32/gen_vdso_offsets.sh b/arch/powerpc/kernel/vdso32/gen_vdso32_offsets.sh
similarity index 100%
rename from arch/powerpc/kernel/vdso32/gen_vdso_offsets.sh
rename to arch/powerpc/kernel/vdso32/gen_vdso32_offsets.sh
diff --git a/arch/powerpc/kernel/vdso32/sigtramp.S b/arch/powerpc/kernel/vdso32/sigtramp32.S
similarity index 100%
rename from arch/powerpc/kernel/vdso32/sigtramp.S
rename to arch/powerpc/kernel/vdso32/sigtramp32.S
-- 
2.33.1
