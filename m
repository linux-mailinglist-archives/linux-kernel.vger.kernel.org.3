Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF364AEA9F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiBIGwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBIGwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:52:07 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2102.outbound.protection.outlook.com [40.92.103.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BB1C05CB81;
        Tue,  8 Feb 2022 22:52:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTC89iCezyXSdnveSxiL1GreRndJPp6zuoOCt7770tggwyVCFYcsWGut6NufLQ90ex3mNDc95PA+Dt87n+k7lYWXoM5gOnM/oV/iCNQRTj6JK+qSJoLUGO7Im+dQcX0zbo/9qgK37abKyUSxmlOVNrn/qygY7rGhR73b0uwGA8F6kzBKz4or1mjz0t/pKUyQuIqZFGCOOr2Rac6AfBxLvNzPIFnAB0ALRjY3c59XosoZSDfPFw6YVc9yrYRUup+df0+IsQNXjjak9fQGW7YDTwMgQAE3Ew50MWeoQNjxPqMgQ/bFn4g9uDt4uU2tUMwo2gZwoyBsKD6iM01FGzOfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lde4hKnO3r7vJHOLnIE+rWhLfRUNNVBjdjEtOQwCn18=;
 b=hhNTEh295cd50J+Qm0M7djED+ujY4WcA6apxeBtl/EBY5JJ/zYWK+nCE6myrz6m/1UYFj+5Wx2AZaRS6Wr2stM4Npc8OCW+7C3OkPMRjcBo6OQrrRdY3zJm7YOdQqNBU2/xUfkolQFNGhBVxc0bydk9cHc82IuXCI785NnfFtA+SUUzite5pqmg4sYuUTgNVepaqDD+wQaWAyHOLNNKx8Yxqknq1Php4FH6HfSM/eq6+C5QSw9unZvdkZx/FjSotyKWgn4Tcu4VX0aMhrlPc609Wxd9r0wQudytMxnECmPgDDSiOfpp/M8eqwxcNBVROKNba4pzmEqnvGiXkuJSHog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lde4hKnO3r7vJHOLnIE+rWhLfRUNNVBjdjEtOQwCn18=;
 b=A9SJ1vstUzQqzWQogvBrfgf3S6SZ+RNt83l4qGunWn1qHgYFZOanRSyTJT9gFiR0iWXQWTsEXDLvDJHxGqK/rqb1uapknQw8DAiJxfBXpQ6GD/tGJK8/Lkg6cMpEOSnEvQhgMR9pqeoRSsy7kWc4kjiHYWZ3DthdTigXj1V/CGFEwf85n7F780i45oC3fboG1kIbYNwTKiswAxqLgzBhqfje78pHT5cCQC0t4OMx7XcFSE5YtHz+q83fGgNH3HuNpufYlNWEZoEeAlCn0til5V3FSSZIIOfcX+VHXcD0YJlAAaYt1wbkk/O4QCYvASGM3S4xWg0Y0uI/loGbmNoeFQ==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by BMXPR01MB5336.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:17::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 06:51:49 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%9]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 06:51:49 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "jlee@suse.com" <jlee@suse.com>
Subject: [BUG] Unable to write the NVRAM on T2 Macs if
 CONFIG_INTEGRITY_PLATFORM_KEYRING and CONFIG_LOAD_UEFI_KEYS are enabled.
Thread-Topic: [BUG] Unable to write the NVRAM on T2 Macs if
 CONFIG_INTEGRITY_PLATFORM_KEYRING and CONFIG_LOAD_UEFI_KEYS are enabled.
Thread-Index: AQHYHYGCabk5Suh5dUSojo7N0K3HIw==
Date:   Wed, 9 Feb 2022 06:51:48 +0000
Message-ID: <D7E39A51-9EEA-45E3-85E7-C405A3973B8E@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [t3ob3/MkddjUJcndDJ3woZiFnkhJs+dai+bbxsnuwjnFGzG45umg224f93pjes56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3242d6dd-2c96-45cf-0cdf-08d9eb98a571
x-ms-traffictypediagnostic: BMXPR01MB5336:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ihWf36BDYLmGue1ar22n7c2gls50uxLRPnohxrjha9jfhUTewJW9OF3C8Uo36eqyV5C0VymHma5C4pbuceGB6wMIVTRd/j1c5rte6HdHxboT2RvX8zTh7HpyAEiXNbUcHlbZrg2C9SbAp3aJ4pFEdxBa+nWMvpA+iXoxHeDiATaZJM/pKMFSuDTpyhvzPAl+/IwTqnj8cLhZNs0ghZQRSyi2IukV10678Y/svwJwAC0sbbHhpW5zMq2BT87iBalTktVHUpYvONhMW/Y34vlu8B+pzkJ+gR3OqG4EKGYoT5mnlXxMjDiRXTDNQ0AP2KrX3zSs441jX14YWXYcmd1qfg8gEJPmKWHpu2XVy5fOISVFoRtB8D7hx9RLwD3Z/EHHNsYWhlKckoPGZYHtQFXmE7mK/LpUqnP1WkJcbtNy4699znT8DRefCCr6pffHuSUwSc6oOeCE0Y3MWz3iG8Gt1vhn2HWNeir+cgvPRw8XAKWmIBpjoZNBhv7g7iFnKYrjgPPL02zir3IZF2nVqiMer1itGJ6R6gjjttGG92iH4KIJkZykKu4y+xsA9q6KSoV1b3GloloM9Spzm94U6um26A==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ydAOf0/r5ULBrwXedOrS0FrJ/yxq7SOD7BBPd8z9d/7Yl/fdIgWHicokiJpo?=
 =?us-ascii?Q?uRqJAQeJRvgqR60PwKqpJ1vg1RcWox/0ZLUdQxrjPB08TDwncbTvxAHbJCHP?=
 =?us-ascii?Q?iSeIcNPVq318lQl29HrEYznlW5CnDQLXabWYun9vB2xBI2yUmxq51hfR7Z7G?=
 =?us-ascii?Q?LShn7nky5HB8cIyq/sPfa9GqXJYz22xjYAHCr/91NsjXBkeCgZ+ae3OtcJ+q?=
 =?us-ascii?Q?45y3IFvjQ74p65Iw4N/bKozoVDYth1xEmZRp7RVoTN8d7i27cEyCk6IXJUDV?=
 =?us-ascii?Q?P/Biojgo8IDiLmqA/KUXCew6WuwFjuRhLuo7rmdaus70TV73wvTVnLQpTq+U?=
 =?us-ascii?Q?kc1ChJO6tsBdQQQaSUpoO3tRNG9FwVKsppSuxjMjKuE8BlwO2BtS6tH7tKtA?=
 =?us-ascii?Q?35aCbg/pELbtK+C+/1W59hriE1bE8E+MqFooV0iAxwdoPNRQflODVj2D+K5K?=
 =?us-ascii?Q?hgPPBffdYhqJMSPcnKPy0zVCJ3UWB/zTM3IF2Pc6eGhJk71/IfbvZ7xqtZ3U?=
 =?us-ascii?Q?w9yeHv3r1V1fTI3ZrxGYgQ9IIkgtByBYNfld1MjQI250/zcgRHtLna3jXdtB?=
 =?us-ascii?Q?aPs+SkH1r742wevjCZ70mZLos7kILavb4NXrmFKTb3/TJpxB9+RCGju7duRW?=
 =?us-ascii?Q?4Co8Szdh6g1wiVcH+KtofqZZUwexr1KRHBWgYi6b3oxbYdWrcOGwem1VuPeT?=
 =?us-ascii?Q?cae7fa9cLohL1E846cWuWvxYMXZO9H/VVHFWX/8QrOfpeVhetvplfj5+07IX?=
 =?us-ascii?Q?FoqhAnmm7qhuvTUQndzLQm0fr+Ewk4PlR98JQPPxhA52ktXeNWvVoMiaXyUU?=
 =?us-ascii?Q?ZUJlkoE0NHREjSzXaITQS8p5JgeAc1nOvzmAHbA5Bc5UrwO+0B8CQMnqPInu?=
 =?us-ascii?Q?YDYmdiszpMmgYLfI1ukHcmIB/JHDZVI5RLHdc87VPm5Nq2vXPQtvuLerzPXN?=
 =?us-ascii?Q?5dB6hCGSLahBB54IyqR9/eTq3OC8MOdhGXpzGjFeR9pgAy5f3jiE16UURkDs?=
 =?us-ascii?Q?V9ZtMZLKUDmftj2E78OhMVY2/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <522606C9E919C54A8B273DFE5DAC72D6@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3242d6dd-2c96-45cf-0cdf-08d9eb98a571
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 06:51:48.9560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BMXPR01MB5336
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Macs with the T2 Security Chip, if CONFIG_INTEGRITY_PLATFORM_KEYRING=3Dy=
 and CONFIG_LOAD_UEFI_KEYS=3Dy are there in the kernel config, EFI Runtime =
services fail to start.

Feb 08 17:11:11 MacBook kernel: [Firmware Bug]: Page fault caused by firmwa=
re at PA: 0xffffa79840068000
Feb 08 17:11:11 MacBook kernel: WARNING: CPU: 11 PID: 150 at arch/x86/platf=
orm/efi/quirks.c:735 efi_crash_gracefully_on_page_fault+0x50/0xd0
Feb 08 17:11:11 MacBook kernel: Modules linked in:
Feb 08 17:11:11 MacBook kernel: CPU: 11 PID: 150 Comm: kworker/u24:1 Not ta=
inted 5.15.19-t2 #2
Feb 08 17:11:11 MacBook kernel: Hardware name: Apple Inc. MacBookPro16,1/Ma=
c-E1008331FDC96864, BIOS 1715.81.2.0.0 (iBridge: 19.16.10744.0.0,0) 01/06/2=
022
Feb 08 17:11:11 MacBook kernel: Workqueue: efi_rts_wq efi_call_rts
Feb 08 17:11:11 MacBook kernel: RIP: 0010:efi_crash_gracefully_on_page_faul=
t+0x50/0xd0
Feb 08 17:11:11 MacBook kernel: Code: fc e8 b4 fb 02 00 49 81 fc ff 0f 00 0=
0 76 08 48 3d 30 9e dc a8 74 04 41 5c 5d c3 4c 89 e6 48 c7 c7 20 c5 1b a8 e=
8 9f 7f bb 00 <0f> 0b 83 3d 57 56 12 02 0a 0f 84 89 6f bb 00 e8 9c 1a 00 00=
 48 8b
Feb 08 17:11:11 MacBook kernel: RSP: 0000:ffffa79840592a08 EFLAGS: 00010086
Feb 08 17:11:11 MacBook kernel: RAX: 0000000000000000 RBX: ffffa79840592a48=
 RCX: ffffffffa857a088
Feb 08 17:11:11 MacBook kernel: RDX: 00000000ffffdfff RSI: ffffa79840592848=
 RDI: 0000000000000000
Feb 08 17:11:11 MacBook kernel: RBP: ffffa79840592a10 R08: 0000000000000003=
 R09: 0000000000000001
Feb 08 17:11:11 MacBook kernel: R10: 0000000000ffff10 R11: 000000000000000f=
 R12: ffffa79840068000
Feb 08 17:11:11 MacBook kernel: R13: 0000000000000000 R14: ffffa79840592b98=
 R15: ffff897a816a3200
Feb 08 17:11:11 MacBook kernel: FS:  0000000000000000(0000) GS:ffff897deecc=
0000(0000) knlGS:0000000000000000
Feb 08 17:11:11 MacBook kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
Feb 08 17:11:11 MacBook kernel: CR2: ffffa79840068000 CR3: 00000001001ea002=
 CR4: 00000000003706e0
Feb 08 17:11:11 MacBook kernel: Call Trace:
Feb 08 17:11:11 MacBook kernel:  <TASK>
Feb 08 17:11:11 MacBook kernel:  page_fault_oops+0x4f/0x2b0
Feb 08 17:11:11 MacBook kernel:  ? search_bpf_extables+0x63/0x80
Feb 08 17:11:11 MacBook kernel:  ? search_exception_tables+0x5b/0x60
Feb 08 17:11:11 MacBook kernel:  kernelmode_fixup_or_oops+0x9e/0x110
Feb 08 17:11:11 MacBook kernel:  __bad_area_nosemaphore+0x155/0x190
Feb 08 17:11:11 MacBook kernel:  bad_area_nosemaphore+0x16/0x20
Feb 08 17:11:11 MacBook kernel:  do_kern_addr_fault+0x62/0x80
Feb 08 17:11:11 MacBook kernel:  exc_page_fault+0xd8/0x160
Feb 08 17:11:11 MacBook kernel:  asm_exc_page_fault+0x1e/0x30
Feb 08 17:11:11 MacBook kernel: RIP: 0010:0xfffffffeefc440c5
Feb 08 17:11:11 MacBook kernel: Code: 31 c9 48 29 f9 48 83 e1 0f 74 0c 4c 3=
9 c1 49 0f 47 c8 49 29 c8 f3 a4 4c 89 c1 49 83 e0 0f 48 c1 e9 04 74 2c f3 0=
f 7f 44 24 18 <f3> 0f 6f 06 66 0f e7 07 48 83 c6 10 48 83 c7 10 e2 ee 0f ae=
 f0 66
Feb 08 17:11:11 MacBook kernel: RSP: 0000:ffffa79840592c48 EFLAGS: 00010286
Feb 08 17:11:11 MacBook kernel: RAX: fffffffeefc92256 RBX: ffffffffa82127ba=
 RCX: 0000000000000032
Feb 08 17:11:11 MacBook kernel: RDX: ffffa79840067d20 RSI: ffffa79840067ffa=
 RDI: fffffffeefc92530
Feb 08 17:11:11 MacBook kernel: RBP: ffffa79840592cd0 R08: 000000000000000d=
 R09: ffffa79840068326
Feb 08 17:11:11 MacBook kernel: R10: fffffffeefc8e018 R11: 0000000000085dc9=
 R12: 0000000000000000
Feb 08 17:11:11 MacBook kernel: R13: ffffa79840067db0 R14: ffffa79840067d01=
 R15: 0000000000000607
Feb 08 17:11:11 MacBook kernel:  ? __efi_call+0x28/0x30
Feb 08 17:11:11 MacBook kernel:  ? switch_mm+0x20/0x40
Feb 08 17:11:11 MacBook kernel:  ? efi_call_rts+0x189/0x6f0
Feb 08 17:11:11 MacBook kernel:  ? process_one_work+0x22b/0x3d0
Feb 08 17:11:11 MacBook kernel:  ? worker_thread+0x4d/0x3f0
Feb 08 17:11:11 MacBook kernel:  ? process_one_work+0x3d0/0x3d0
Feb 08 17:11:11 MacBook kernel:  ? kthread+0x12a/0x150
Feb 08 17:11:11 MacBook kernel:  ? set_kthread_struct+0x40/0x40
Feb 08 17:11:11 MacBook kernel:  ? ret_from_fork+0x22/0x30
Feb 08 17:11:11 MacBook kernel:  </TASK>
Feb 08 17:11:11 MacBook kernel: ---[ end trace b0e21a194e80a466 ]---
Feb 08 17:11:11 MacBook kernel: efi: Froze efi_rts_wq and disabled EFI Runt=
ime Services
Feb 08 17:11:11 MacBook kernel: integrity: Couldn't get size: 0x80000000000=
00015
Feb 08 17:11:11 MacBook kernel: integrity: MODSIGN: Couldn't get UEFI db li=
st
Feb 08 17:11:11 MacBook kernel: efi: EFI Runtime Services are disabled!
Feb 08 17:11:11 MacBook kernel: integrity: Couldn't get size: 0x80000000000=
00015
Feb 08 17:11:11 MacBook kernel: integrity: Couldn't get UEFI dbx list
Feb 08 17:11:11 MacBook kernel: integrity: Couldn't get size: 0x80000000000=
00015
Feb 08 17:11:11 MacBook kernel: integrity: Couldn't get mokx list
Feb 08 17:11:11 MacBook kernel: integrity: Couldn't get size: 0x80000000000=
00015
Feb 08 17:11:11 MacBook kernel: integrity: Couldn't get UEFI MokListRT
Feb 08 17:11:11 MacBook kernel: ima: No TPM chip found, activating TPM-bypa=
ss!
Feb 08 17:11:11 MacBook kernel: Loading compiled-in module X.509 certificat=
es
Feb 08 17:11:11 MacBook kernel: Loaded X.509 cert 'Build time autogenerated=
 kernel key: 4fe3a063ebcd82317099edaaf5ee8e3719392e6e'
Feb 08 17:11:11 MacBook kernel: ima: Allocated hash algorithm: sha1
Feb 08 17:11:11 MacBook kernel: ima: No architecture policies found
Feb 08 17:11:11 MacBook kernel: evm: Initialising EVM extended attributes:
Feb 08 17:11:11 MacBook kernel: evm: security.selinux
Feb 08 17:11:11 MacBook kernel: evm: security.SMACK64
Feb 08 17:11:11 MacBook kernel: evm: security.SMACK64EXEC
Feb 08 17:11:11 MacBook kernel: evm: security.SMACK64TRANSMUTE
Feb 08 17:11:11 MacBook kernel: evm: security.SMACK64MMAP
Feb 08 17:11:11 MacBook kernel: evm: security.apparmor
Feb 08 17:11:11 MacBook kernel: evm: security.ima
Feb 08 17:11:11 MacBook kernel: evm: security.capability
Feb 08 17:11:11 MacBook kernel: evm: HMAC attrs: 0x1
Feb 08 17:11:11 MacBook kernel: PM:   Magic number: 10:872:680
Feb 08 17:11:11 MacBook kernel: RAS: Correctable Errors collector initializ=
ed.
Feb 08 17:11:11 MacBook kernel: Freeing unused decrypted memory: 2036K
Feb 08 17:11:11 MacBook kernel: Freeing unused kernel image (initmem) memor=
y: 2952K
Feb 08 17:11:11 MacBook kernel: Write protecting the kernel read-only data:=
 24576k
Feb 08 17:11:11 MacBook kernel: Freeing unused kernel image (text/rodata ga=
p) memory: 2036K
Feb 08 17:11:11 MacBook kernel: Freeing unused kernel image (rodata/data ga=
p) memory: 540K
Feb 08 17:11:11 MacBook kernel: x86/mm: Checked W+X mappings: passed, no W+=
X pages found.
Feb 08 17:11:11 MacBook kernel: x86/mm: Checking user space page tables
Feb 08 17:11:11 MacBook kernel: x86/mm: Checked W+X mappings: passed, no W+=
X pages found.
Feb 08 17:11:11 MacBook kernel: Run /init as init process
Feb 08 17:11:11 MacBook kernel:   with arguments:
Feb 08 17:11:11 MacBook kernel:     /init
Feb 08 17:11:11 MacBook kernel:     splash
Feb 08 17:11:11 MacBook kernel:   with environment:
Feb 08 17:11:11 MacBook kernel:     HOME=3D/
Feb 08 17:11:11 MacBook kernel:     TERM=3Dlinux
Feb 08 17:11:11 MacBook kernel:     BOOT_IMAGE=3D/boot/vmlinuz-5.15.19-t2
Feb 08 17:11:11 MacBook kernel: ACPI: video: [Firmware Bug]: ACPI(GFX0) def=
ines _DOD but not _DOS
Feb 08 17:11:11 MacBook kernel: ACPI: video: Video Device [GFX0] (multi-hea=
d: yes  rom: no  post: no)

Could you help me in solving (probably disabling this security feature on T=
2 Macs)=
