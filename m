Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDB74E51D5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244102AbiCWMHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiCWMHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:07:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374A56462
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 05:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648037181; x=1679573181;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ECu5gMt3efKnPTbBPyAiUsYAl19ZK98PoSNUOx2H+to=;
  b=CKsllD+VToTUtq1l1gL3CngJGUmXvQEXPj81ImbriZUne9vqNzf2ug5u
   C78TCDwhVf4zJvZLmMGKaF0FJIKD30mwsjzxFCLtB/T7B0K7qN1mIRrE+
   QazdfKaAen9MpFELME3GwB7NuWjD24MBMC4olbaD3LFtDfBXP6g7U5Usl
   WHI3tjz1tdIhOEkFoUzPAJOzJblxaDZ1nQHxobA4tNySk3xVWnquHIwH4
   pBzDEOmeYl+FQGFfyNsToYG4w27wUml95Gx2acRE3zhawxg4FA6Q9/GuJ
   GTSwZxklVqdL+ZSqJW++ajVaBHtxv8peit+Djr6JXjhmrRxhHhsTc42fz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="258045568"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="258045568"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 05:06:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="583666378"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 23 Mar 2022 05:06:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 23 Mar 2022 05:06:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 23 Mar 2022 05:06:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 23 Mar 2022 05:06:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOqT5NZw8cncZpnSpoVtj3InLk6zkE4rSna8eAhPq61Lfyh/a+54kkLDnGko28Xn7acDXdbNGhJULcQS1h30jOUWoQBr5fQINrQOlRx5Dt7v8UygttIL49YGywApVP/s/UlKGObgRSa7IyP3dJK1XSlZLcU66fsTAxJ/oybtPPFBM4AfcDZvzkqS8zv0DedFOPEmyoSqLM+lGBf14abKBmKH0EOPgRYsG8o9t6npQT9stGVWhUQJOFmm0t9lKDgWgRhL1PvoTFwGf7dWU86W9u0iEdkA85tB6uH0wWWgVUUF++xrm1l9rvopOFFpsqQbsr3zyM6c8sO/VsGrKF0kdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdSEoy+40za70WrST7Z0cxv3kOFWkbaXq/lw0pL1ESo=;
 b=EVE6Om26nZ2MY3ZrA93pnj0i+u2XiNfa80P3i/AUBzSLVUJf9As2rrhaV49OHZvCmECZ+YNE7zrc86fhuaOG5bOgvPV8qb0pLTM/YFnF2w8wm0+OInRvJYEruOUJSRcLFuDcypxIV7CvPHiNMPvOidBptKmwRLronK1xSpswmTvq2vHl5oWpVwVDUqLQHa1vSpVtlsIHKYLBf7TgNyjw8u5COFmMTalWkdIp7IyoQa6Q9hJZiAycx8h4wTyLL3ZFfv9D9vdFCTsqt06zBqurfmaggdWHJWPUvayoUiPZk3g0cjxItleoRq6Cd256zCX40WgQAP40D049BZ7YoPxVIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM5PR11MB1563.namprd11.prod.outlook.com (2603:10b6:4:5::13) by
 CH0PR11MB5395.namprd11.prod.outlook.com (2603:10b6:610:ba::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.17; Wed, 23 Mar 2022 12:06:18 +0000
Received: from DM5PR11MB1563.namprd11.prod.outlook.com
 ([fe80::8559:2882:703d:3890]) by DM5PR11MB1563.namprd11.prod.outlook.com
 ([fe80::8559:2882:703d:3890%12]) with mapi id 15.20.5081.023; Wed, 23 Mar
 2022 12:06:18 +0000
From:   "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>
To:     "Sang, Oliver" <oliver.sang@intel.com>
CC:     "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "Harrison, John C" <john.c.harrison@intel.com>
Subject: RE: [drm/i915/guc]  a0f1f7b4f7: PANIC:double_fault
Thread-Topic: [drm/i915/guc]  a0f1f7b4f7: PANIC:double_fault
Thread-Index: AQHYPpIlSldxcvwPKUmwXaVgOc4ZP6zM1o6w
Date:   Wed, 23 Mar 2022 12:06:17 +0000
Message-ID: <DM5PR11MB156398A2FD2D73A661E3E5088A189@DM5PR11MB1563.namprd11.prod.outlook.com>
References: <20220323084351.GF16885@xsang-OptiPlex-9020>
In-Reply-To: <20220323084351.GF16885@xsang-OptiPlex-9020>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66ba20f0-ca6e-4764-0c2f-08da0cc58988
x-ms-traffictypediagnostic: CH0PR11MB5395:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH0PR11MB5395FD24E0A9A2443D4C734F8A189@CH0PR11MB5395.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F/6RR+4gCkd9FwNnAVcDFoU1LKHUfKLj5lYaXZqy3Yeo6FC54zzX4rEpo08EMdmwnUezLwCbDgqPvugzYZHFP5ycHSvBK3dlHmSkbBgO7xx84i5//oEJS3cv8t6Me9OO1fY3V6zMK1lGAZfTO3KabrovSdkwk051O8fCXEktr5qgSmFyT2Q0wnxlDIWtYA+rNASwRxWtU2Ky2/voLinm0CEkJtL22GrA3CnLX6NPhvIjHzrs4CrbmfExAXBNgULyE+F3MbChekNwwXARklbOsYVjb2V4NMnGcdSSgiqoDdOqTO0vTVTx2oV08lKZbYAPpKKTkkv5h3CYT2xxucp2CRZZn+FUPWf1gplUGqzU2/gkWfLvZIdJ0hrFlBGrLNHBUKJDWDupwFvr2Z3gOWpZxu3wrd5sxX3PNLlH1iYZaBE4Gzc0HwiPailc/cuUPbkpg6G/ngj5Jtw1+e1xA+WhRBylDlJjZYf2bEYh51HmQaz9sFpFSf89gnML6RjfxWnMHRVV2l+AkkSzNc4gK4hg8oWkmnhAEPjkWbaZjFJKbPfQTPMmD1VEmS9DHffKop0SwVCaYpXrUzXHIo1NWVOJmB4iMiOwWzkBGjXrG06pz/UbLN6gmv6c+safTsBkQEnVLTlvVbuSc/Np/3K3vcpurxi6KZfDTLvtpQxoh9o8MJLqMTW/N1s/xctSfBfGi04pzYfrrDOBg4mFyP7X1Odk/aa49C8L89kIeU3WXmgepZO/m06ejeeA/E2thBpls+zOrFJozvtdcyWOCMj2nO7wFBVe8NbBbhJ7/fYfXFdUWZi0LFk/DMkgxXWT7i8y3XQYJgynn0dG/CzE2Ki4Q/M95g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1563.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(6636002)(26005)(186003)(55236004)(107886003)(7696005)(53546011)(6506007)(9686003)(83380400001)(966005)(38070700005)(316002)(508600001)(8936002)(33656002)(71200400001)(55016003)(52536014)(76116006)(66476007)(66946007)(66446008)(2906002)(86362001)(66556008)(38100700002)(122000001)(82960400001)(6862004)(4326008)(64756008)(5660300002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yShc2DEsiR+ZmHAdP2YocREovreaOe4ktMATJu6NImNWxcdr4tAlQWQ2MkbQ?=
 =?us-ascii?Q?q7MIZxu++wVDokar+XNySy2V8ZVgO8ZrQM2NnhSZkSQUGqajJdh4EeIjSQQI?=
 =?us-ascii?Q?cJDIddHmYwecCY+y3mDidu9F+Z4ikKS3iNH4oOT4EHDo2HUxSGrwxtRlrgff?=
 =?us-ascii?Q?g9DT8taEC0796xY0PIxyJ6vrbC8lRLmbeYnT3KfMuagaI3cuj+lfoQYM39s9?=
 =?us-ascii?Q?h8TNBzGWH4UAUI0czR8z2tQT8NJQz1OLGpah4DCizPvJ08CTHbeBpTOfA1qQ?=
 =?us-ascii?Q?hJOfnQutNoJKpzo6djLVZOrXjiMwQecYl8EYEiIspem+Xp0kS5uFLwA4p8h+?=
 =?us-ascii?Q?ftMRqQsXzrsVzPm2hCiVFZ4d1yKa1l9dNvW97wa17M3cKlLj0ex0tzW3iHPu?=
 =?us-ascii?Q?uu4zsq2Q2AZQH33bSm2nB4hq7cybjw9IERkI3WEW0FlSZO2EUQszfK2cs0e5?=
 =?us-ascii?Q?0Dob2GnrfSR+2issT70emXeXDttOVfhEGO4USMEB2GXIabWaXhdxkw7G0ALR?=
 =?us-ascii?Q?Ysd99PjV4qHXKEWPFuwbDwcwaEJHSDj+UwKwRVTqCCLV9tFKqH22OaX9Xv9p?=
 =?us-ascii?Q?uv1fYJZzuwa7gM+En0KPcVZaBJ5CitoUzmymu5kmF3d9ywdGPnYzOXAOzpYm?=
 =?us-ascii?Q?xic3Ba4Y+0Xsnq00gRAnc8rOmbKoqJ9dsFHJG341Yw/Qo2cpkdf+hiL/RcAh?=
 =?us-ascii?Q?hWKU4XiQuQvhj1H8SRUFY4vWgUMSjUrJMQ1TAdaSqS7Hbp2cefkKTLsLkWOD?=
 =?us-ascii?Q?qwIQ2iKp8/opD6r57xa2NoRgr2b8g7Ckt8Xq4o/oFMbomEzrT8O4qdQ2+/1h?=
 =?us-ascii?Q?JpJhgitVVT+hn/XPbJ9MjFXUaOimnWWNBA4BqQCBGYDi56TF7CgNoBOZVoJb?=
 =?us-ascii?Q?Uv1UQDYFEFFuFuZzfrnyv85g/siMpYD1bQa14Hape9j46zMJG9TFJuImd1sB?=
 =?us-ascii?Q?/Rb8Kqj/JlR4cKgjfztjDXoUBwcibb8N+cunRk+f42JHrLt1IEfLtiGIflDr?=
 =?us-ascii?Q?aVZMmIHSbjYwBPv+jNz7ILQ9/Aut95AJfP97qn9lDu/PzW07BFmjJOpFIa5U?=
 =?us-ascii?Q?99j/qNM+43n589ac6Uh6O8gMZLK1o3cde6P/N7uXZVCR9etDWcn7Xq0kse87?=
 =?us-ascii?Q?1jSgzuROIe9TuYbDK6Tg5uywoofkoevR+zvjI2LfFlbgb34m1FF/l8RIG4+z?=
 =?us-ascii?Q?6kwFltb3gf8CJdq/z42+2YXh5EwpvyqNmvcKhCDkQY4ZJjZ1sgNCNk4YrcAs?=
 =?us-ascii?Q?5UNn9avi9OxuHT6/QUyuSnb48uWDHOXW9xfHk03tN2wU0LCckpgmMKxUvkJc?=
 =?us-ascii?Q?VblixO5+ZgTlJK7bdUApc8ONoDCBjx0V0Rb4h1D9D2pwVJXekq3OBsOs9Zcp?=
 =?us-ascii?Q?NHaCiCSeUTI/JpUWq0ALxBXGbZu/QKRYKo6Y4btBnPlfOKeq/hIhJa2rM7Mw?=
 =?us-ascii?Q?cNTEN5YRrFA7u9oxKlySg+IqCm60VsqP4iYPqzF/aGyR81Mq+uNqVubHHbPd?=
 =?us-ascii?Q?S5GQ0cy0yEQSnZU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ba20f0-ca6e-4764-0c2f-08da0cc58988
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 12:06:18.0425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IpiUmy94ZXzqpiGi2JKDq+qf7lYLpeDhFzextobddgltLuqWBTlVBPLVgw6Dz8f1TqYMi5ZJmRbzNDIc/n7dQ4X4RWOg1QEMZ0Pc4OArLYarH1byEUpbgzOGhzKTQjYv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5395
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver, please give me a couple of days to debug this as I don't see how=
 that Patch can cause or impact below failure since that patch only contain=
s changes that get executed at runtime (not driver startup) and only on Gen=
9 and newer hardware that has GuC firmware feature.

...alan

-----Original Message-----
From: Sang, Oliver <oliver.sang@intel.com>=20
Sent: Wednesday, March 23, 2022 4:44 PM
To: Teres Alexis, Alan Previn <alan.previn.teres.alexis@intel.com>
Cc: lkp@lists.01.org; lkp <lkp@intel.com>; LKML <linux-kernel@vger.kernel.o=
rg>
Subject: [drm/i915/guc] a0f1f7b4f7: PANIC:double_fault



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: a0f1f7b4f74fc6eaee0b6783af40dacf431df7b4 ("drm/i915/guc: Print the =
GuC error capture output register list.") git://anongit.freedesktop.org/drm=
/drm-intel drm-intel-gt-next

in testcase: boot

on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):


+-------------------------------------------------------+------------+-----=
-------+
|                                                       | a6f0f9cf33 |=20
| a0f1f7b4f7 |
+-------------------------------------------------------+------------+-----=
-------+
| boot_successes                                        | 13         | 0   =
       |
| boot_failures                                         | 0          | 6   =
       |
| PANIC:double_fault                                    | 0          | 6   =
       |
| double_fault:#[##]                                    | 0          | 6   =
       |
| EIP:handle_exception                                  | 0          | 6   =
       |
| Kernel_panic-not_syncing:Fatal_exception_in_interrupt | 0          | 6   =
       |
+-------------------------------------------------------+------------+-----=
-------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[    8.717641][    T1] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[    8.719470][    T1] 00:06: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D =
115200) is a 16550A
[    8.722059][    T1] sonypi: Sony Programmable I/O Controller Driver v1.2=
6.
[    8.722872][    T1] Non-volatile memory driver v1.3
[ 8.724009][ T36] random: get_random_u32 called from arch_rnd+0x14/0x40 wit=
h crng_init=3D0=20
[    8.724275][    C0] traps: PANIC: double fault, error_code: 0x0
[    8.724278][    C0] double fault: 0000 [#1] PTI
[    8.724282][    C0] CPU: 0 PID: 36 Comm: modprobe Not tainted 5.17.0-rc4=
-01232-ga0f1f7b4f74f #29
[ 8.724285][ C0] EIP: handle_exception (kbuild/src/rand-4/arch/x86/entry/en=
try_32.S:1064)
[ 8.724292][ C0] Code: 0c 81 e1 ff ff 00 00 36 89 48 f8 8b 4c 24 08 36 89 4=
8 f4 8b 4c 24 04 36 89 48 f0 59 8d 60 f0 58 cf 6a 00 68 80 0d 3f d7 eb 00 <=
fc> 0f a0 50 b8 00 00 00 00 8e e0 58 81 64 24 10 ff ff 00 00 f7 44 All code=
 =3D=3D=3D=3D=3D=3D=3D=3D
   0:	0c 81                	or     $0x81,%al
   2:	e1 ff                	loope  0x3
   4:	ff 00                	incl   (%rax)
   6:	00 36                	add    %dh,(%rsi)
   8:	89 48 f8             	mov    %ecx,-0x8(%rax)
   b:	8b 4c 24 08          	mov    0x8(%rsp),%ecx
   f:	36 89 48 f4          	mov    %ecx,%ss:-0xc(%rax)
  13:	8b 4c 24 04          	mov    0x4(%rsp),%ecx
  17:	36 89 48 f0          	mov    %ecx,%ss:-0x10(%rax)
  1b:	59                   	pop    %rcx
  1c:	8d 60 f0             	lea    -0x10(%rax),%esp
  1f:	58                   	pop    %rax
  20:	cf                   	iret  =20
  21:	6a 00                	pushq  $0x0
  23:	68 80 0d 3f d7       	pushq  $0xffffffffd73f0d80
  28:	eb 00                	jmp    0x2a
  2a:*	fc                   	cld    		<-- trapping instruction
  2b:	0f a0                	pushq  %fs
  2d:	50                   	push   %rax
  2e:	b8 00 00 00 00       	mov    $0x0,%eax
  33:	8e e0                	mov    %eax,%fs
  35:	58                   	pop    %rax
  36:	81 64 24 10 ff ff 00 	andl   $0xffff,0x10(%rsp)
  3d:	00=20
  3e:	f7                   	.byte 0xf7
  3f:	44                   	rex.R

Code starting with the faulting instruction =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	fc                   	cld   =20
   1:	0f a0                	pushq  %fs
   3:	50                   	push   %rax
   4:	b8 00 00 00 00       	mov    $0x0,%eax
   9:	8e e0                	mov    %eax,%fs
   b:	58                   	pop    %rax
   c:	81 64 24 10 ff ff 00 	andl   $0xffff,0x10(%rsp)
  13:	00=20
  14:	f7                   	.byte 0xf7
  15:	44                   	rex.R
[    8.724295][    C0] EAX: 020e9000 EBX: ffa03fbc ECX: 00000000 EDX: 00000=
000
[    8.724297][    C0] ESI: c20e7ff0 EDI: ffa04000 EBP: 420e7fac ESP: ffa03=
008
[    8.724299][    C0] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS:=
 00010006
[    8.724305][    C0] CR0: 80050033 CR2: ffa02ffc CR3: 17f06000 CR4: 00040=
6b0
[    8.724307][    C0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000=
000
[    8.724309][    C0] DR6: fffe0ff0 DR7: 00000400
[    8.724310][    C0] Call Trace:
[    8.724312][    C0]  <ENTRY_TRAMPOLINE>
[ 8.724313][ C0] ? paravirt_BUG (kbuild/src/rand-4/arch/x86/mm/fault.c:1497=
)
[ 8.724318][ C0] ? restore_all_switch_stack (kbuild/src/rand-4/arch/x86/ent=
ry/entry_32.S:1064)
[ 8.724322][ C0] ? paravirt_BUG (kbuild/src/rand-4/arch/x86/mm/fault.c:1497=
)
[ 8.724324][ C0] ? restore_all_switch_stack (kbuild/src/rand-4/arch/x86/ent=
ry/entry_32.S:1064)=20


To reproduce:

        # build kernel
	cd linux
	cp config-5.17.0-rc4-01232-ga0f1f7b4f74f .config
	make HOSTCC=3Dgcc-9 CC=3Dgcc-9 ARCH=3Di386 olddefconfig prepare modules_pr=
epare bzImage modules
	make HOSTCC=3Dgcc-9 CC=3Dgcc-9 ARCH=3Di386 INSTALL_MOD_PATH=3D<mod-install=
-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is=
 attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



--
0-DAY CI Kernel Test Service
https://01.org/lkp


