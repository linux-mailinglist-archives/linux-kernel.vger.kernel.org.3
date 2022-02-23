Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AE24C0E08
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbiBWIJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiBWIJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:09:23 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A38143ECA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645603736; x=1677139736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pfGf1wL7X0eQhqEkCmOJJV/M5Ph7ihTkY5Gz0o5MM44=;
  b=Aor5cQVPvJYJQaROxLqutpJnzBVpaV/IiP2CuOFdmXOLvP/lLl/jyvd5
   BRx/HaDsUSHoTzWfX/kO9Jv81eaDtr3+8L0SK8rDFfP+5sPahkWo/m8Pw
   dx+uVHkTE0DpiiIbqfGxnWy22dtTU7uU1Wx7sbfmBu5f0epUzOhyK3FaH
   VZ8VfHkTQm8lQqf7CijrzBADCNmOiHIvabksKl7mR9Swh/MU8Zln+QddP
   0QQ91N3ZHw1YOKGi5dtKoSrTXN8N8YUuomlQ1TqblJ/C5s/0hZmzJlz0K
   b9v9h1om7gNi9K9i2UbMXPFxzvPimfrIvnvZAyYZH2hR2eyQRTOxWbhi7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="232531161"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="232531161"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 00:08:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="627994441"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Feb 2022 00:08:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 00:08:55 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 23 Feb 2022 00:08:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 23 Feb 2022 00:08:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 23 Feb 2022 00:08:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnR5FqkyQa8n3OFWA7V+UfbOLgciZRyhDKFilulf/syvGmU4bu/7yrEdB2gD6oLWAbA6PTHKGWXNC/CXybdsAdb5SpxfVCBebMqlzUifMCw3nkKCZUe2lp3YSbGqaimN/2YeswddOk7Sfn8OXapjsygvK8iEgLx7yjiutO1zStf3dDNlzMFo+CMdX8JHdRF0vETxtEGelAfs+mvNCBxfDgP8ti3syU4Ko+R0Bjxz+YPpAB8v8RmvZvLtcwGqiWQKwy/A/MRRm2v08K4SATZ/T8g9BZ4ea4DpLNhMY33+szVGejDV4uxsMoC531EkZ291qT4TRTlQbrW8T+XJmp0hGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQvZe2brWPZtEt9L1WXJhIDc1j/5TVgxCsVJlzOCDa0=;
 b=maZ7gxAelygwK1wAuVBAs6EdXgpAGCQce9n+tRZePFjLrvz7cFGWNhjCZyLy/6INKDqjOFIkKEOKW67O2wct6kG0OJCps53SvkKbVpy69locoG+26N008mmji2zsvn/atePDqMu9/xArbABDYmhKAKXCrc8paYWR60k3q79rEmiHGbFkSb06AXhzEI3GFLGxu6UCwRy+/jWE+TkHjMWxd3TB8L4hry1WW1JuEZVW2bT5sX5MbvmErzQbNBpASqzmsZr42FdGMe2KotcxIpe0tra0bv0/oOz+1hYh7ecCKmRnheMLrG9sGrXySgsoyOkrN5dyZkF+qUgsBMjJ4dqo+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CH2PR11MB4374.namprd11.prod.outlook.com (2603:10b6:610:41::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.23; Wed, 23 Feb
 2022 08:08:53 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c%5]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 08:08:53 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     syzbot <syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "balbi@kernel.org" <balbi@kernel.org>
Subject: RE: [syzbot] KASAN: use-after-free Read in dev_uevent
Thread-Topic: [syzbot] KASAN: use-after-free Read in dev_uevent
Thread-Index: AQHYJn4xBH205WNMF0CseYQWl0QGTKygscgggAAK2QCAAArWIA==
Date:   Wed, 23 Feb 2022 08:08:52 +0000
Message-ID: <PH0PR11MB5880A932C8B8E0368370B4DBDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <0000000000005a991a05a86970bb@google.com>
 <00000000000033314805d8765175@google.com>
 <PH0PR11MB5880C431590170767B4BACFEDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <YhXehCLx9LVwCIO6@kroah.com>
In-Reply-To: <YhXehCLx9LVwCIO6@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a56c1abb-a48c-4e7a-e0b3-08d9f6a3bb2f
x-ms-traffictypediagnostic: CH2PR11MB4374:EE_
x-microsoft-antispam-prvs: <CH2PR11MB43742EC42690A14D7278CD40DA3C9@CH2PR11MB4374.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 76SRIyARWf1EG3o2PEmn1qJ77whbG2D/B56xrGM/TlM8wyp1pB18SZHorAtQkKzTNso6scY+ySyC2Cq1ri2QykMUyA3QZvzcwedmF9rGB16be1maOYsSklai6tBk/UCPAWp5RaW5bO0WT2b9s2DausL99TszMkQ/saoaGerTJYxJW9cWVIrOgCF9U9DVG+nfEO4nMsQjI6QBL3KnDIJwvVFP6X4oJK6xTqtqKqZRgcnKk73oG33jf0SlsCv141qwyWdOpQ0jezN/0C8smrqUuz7MfejYlE6oo4R/G9Fca+5ndiuunMWMohvW4qeuRbLzGMymgRkrrDYvX/FzXz7Fxk5fOy1VgYFn9XnpT00yVi51SFBaBpVTyKhm4036A0Jb8b0EaAfG5UCzOGa54BsEXBwd4/TofxYQx5DCSDYx1G/x2MNfJLik/T9H/PzvoYGyeAvbkYuk3p+F3ZIJsFeWqEijVj944FFucAGfihpD8gvGmlHeyVUON4G5/OPBHoeP7FBMap7cLFeXQhErw3sXdVTTcrQjFpN9EEdP9ndBG2nnpmizvToVvo411DwD+F7/oa3aH0MQucp57cXOsxox646ad5vSy0unPkLN7KLbhnAfGtWundlygrWGIHE/R2F85CxUEbhuWjGsTCSKMxDj67+k+Y4/PaKagfk4yAoQi7ZP5oOr4+KbBs7aFsWQr3ZtMo+bc6TsKGZuSxDgYFiATEe/O2WldWPejotN8C7/kwVuW4388CiboaIBt+BI+yyjlxGyJQu2yCsXNJXfmRPSOPNxg4hEw26K9DzsLZPqinY3w006R/NPST+0qUKz2g57
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(6506007)(7696005)(83380400001)(966005)(8936002)(2906002)(508600001)(52536014)(33656002)(5660300002)(38070700005)(55016003)(66556008)(86362001)(66946007)(6916009)(54906003)(38100700002)(186003)(66446008)(26005)(64756008)(4326008)(82960400001)(316002)(66476007)(122000001)(9686003)(76116006)(8676002)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FW8+6MUf4L9xCJ+Cg/ercOIMiB21YNdPW7qjn6ckEhnpnmhIBD0ytM2FkXrY?=
 =?us-ascii?Q?SZkvOogDv22My2mZPTLIIftIycCzYKqXvmglwaaACQ3Fs+e+bPzzl7XiJnZ5?=
 =?us-ascii?Q?+C/5i0BO7zjxFoMXrw9r0RuzqKg2GuVPyZxX4xhwUf3GiIfFRx1S42gmQh4J?=
 =?us-ascii?Q?MTosLWxNjnM4EKWx5jUWAhmUI5yVrne21mc7iMfgZWJqma5h1jdXh+C/JiJd?=
 =?us-ascii?Q?8k6Fj8uXXitn8XTTfwbjlxyCeaJcxUnG4xrjYzpG1t7XE1nb4hShrT2aX0Ha?=
 =?us-ascii?Q?X+OreS/1MViNMclk7avas9zyOtP1fetfI9LuV63grlS6a+7EL18TN6U4IFo9?=
 =?us-ascii?Q?r5Uk6gBbTH7bq1BfKuh1ZYzmZ6tipVWVICHm0KU4Y63F5wBbpy8kKZt/Fvpf?=
 =?us-ascii?Q?KyjRT5061glKIESZCtSJwkP15GenKqV4RsbquMKXMBergmHZ/NZZml5IoJl9?=
 =?us-ascii?Q?yXSo3V+8bfARCki/dgIH7z7GAA4RUGwaKhU0OZnteRMQjxSdLl1GC0t6jbRI?=
 =?us-ascii?Q?altVe/7/N1noEIWZzeUr17Rcg7w8c0CU4Y6nG+jW/ek9dzwcnk7GIsJZc5HM?=
 =?us-ascii?Q?IcolFJVkkiqpkDytFaxfaGWX40URhLlJ4YY5w5Gdt/UDrTtGwBEhgURizFGf?=
 =?us-ascii?Q?ZzCtfSs1rYCUuDocqJeK98Om63l8NLwk0Z9XQisdoRKcfU9kmgruFsahB1jw?=
 =?us-ascii?Q?ezgxMuuoPMnXB6RAhhIys9J6ADv9yM9j5rHg7ycn6VppQXyFcxDicVSNV99A?=
 =?us-ascii?Q?jlhXrpFvEjNdMRY8qaZJkR9K2bCb/pUuwGjqPgG97wkOAQRcQEyl70GjXS+/?=
 =?us-ascii?Q?0Y189VsisRwpvbK7aZ6ibsRLfr5U/8MaGHOe4V/u6z7+i2THsoH7hwMEK5Jf?=
 =?us-ascii?Q?YCNMHrGQ40Fy6TXMBitqna0/XHYoye0jtHK+kXt4D9Qf5xS3OpNZLfjruHHr?=
 =?us-ascii?Q?cATixqIHSwI7eNw5U/3S1xImp4qohYURMRS/46cesYZMq9ZDtnKREb9mj6Jl?=
 =?us-ascii?Q?d1ZdMBJ3kIMzNb0rDALrSJAgHmmq90MuPWmhb3CrpEVaE4LLOVZ7pws1JhjS?=
 =?us-ascii?Q?VMUeUDvV+ToSM3fp7uQiYLcz4VtLDXgVDnoxu4SruMrtiZRXmU0uRTV4m4Go?=
 =?us-ascii?Q?+bHX41VqJxt7TCX8Ivc8gdQ+U7IjjxooYzfeUPr43Fhxw+j0jNoONJn1smXu?=
 =?us-ascii?Q?Avx7XlYus31oESP1wNMK+mPLwEFv9VjolMRjMgnS0evDAU3TIB4hzFCv/yh2?=
 =?us-ascii?Q?DyoBv2MMHfIz21wJeu7gA4LWlTyWEx405Eqye4ZCWCKTmIHlZYwXhuG8QvMY?=
 =?us-ascii?Q?R5ReMdh/0hEaxoIzKsHgBe5oqXAevr/SOmcfA9M9+Rp2s8UqWYdgFYq/uzQf?=
 =?us-ascii?Q?4Tv1VPeYboeUZ9YCLM8ENNKanZMMCUv0IH9YznPxhBl2/jJNFC7eHICFZKjC?=
 =?us-ascii?Q?U0l2TTTWLUCozshTiC7VGdJTZ8GXCymLTbkk6JMcS1xT4e8//V5UrYoIvsE2?=
 =?us-ascii?Q?Ie8vsufvptSSd4ODlPBBVxRRPTHMB1O7+qQaO9YT1ywXSfskL2g0yW5IZ+fg?=
 =?us-ascii?Q?ZqilbkThbAs8Cz812qt0E4FGblaI8MuGuQ4AWKqD5+vbmAzFqr4lKd40+s0i?=
 =?us-ascii?Q?9Fxyrtu/s6Zr3J0Y/xFlbKg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56c1abb-a48c-4e7a-e0b3-08d9f6a3bb2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 08:08:52.9589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: klq//GeDleKL1VcTESAzb99B2sX62z/a4HaStMsoDWwzGz5D7XAqfXjLSwzh8m/6/V3CcSZf7AvJXlrKKYERqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4374
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Feb 23, 2022 at 06:51:10AM +0000, Zhang, Qiang1 wrote:
>=20
> HEAD commit:    4f12b742eb2b Merge tag 'nfs-for-5.17-3' of git://git.linu=
x..
> git tree:       upstream
> console output:=20
> https://syzkaller.appspot.com/x/log.txt?x=3D110a6df2700000
> kernel config: =20
> https://syzkaller.appspot.com/x/.config?x=3Df6a069ed94a1ed1d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D348b571beb5eeb7=
0a582
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12377296700=
000
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in dev_uevent+0x712/0x780=20
> drivers/base/core.c:2320 Read of size 8 at addr ffff88802b934098 by=20
> task udevd/3689
>=20
> CPU: 2 PID: 3689 Comm: udevd Not tainted 5.17.0-rc4-syzkaller-00229-g4f12=
b742eb2b #0 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0=
-2 04/01/2014 Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_address_description.constprop.0.cold+0x8d/0x303=20
> mm/kasan/report.c:255  __kasan_report mm/kasan/report.c:442 [inline] =20
> kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
>  dev_uevent+0x712/0x780 drivers/base/core.c:2320
>  uevent_show+0x1b8/0x380 drivers/base/core.c:2391
>  dev_attr_show+0x4b/0x90 drivers/base/core.c:2094
>  sysfs_kf_seq_show+0x219/0x3d0 fs/sysfs/file.c:59
>  seq_read_iter+0x4f5/0x1280 fs/seq_file.c:230
>  kernfs_fop_read_iter+0x514/0x6f0 fs/kernfs/file.c:241  call_read_iter=20
> include/linux/fs.h:2068 [inline]
>  new_sync_read+0x429/0x6e0 fs/read_write.c:400
>  vfs_read+0x35c/0x600 fs/read_write.c:481
>  ksys_read+0x12d/0x250 fs/read_write.c:619
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 =20
> entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f964cc558fe
> Code: c0 e9 e6 fe ff ff 50 48 8d 3d 0e c7 09 00 e8 c9 cf 01 00 66 0f=20
> 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d=20
> 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
> RSP: 002b:00007ffc0133d258 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 000056497b21a140 RCX: 00007f964cc558fe
> RDX: 0000000000001000 RSI: 000056497b218650 RDI: 0000000000000008
> RBP: 00007f964cd22380 R08: 0000000000000008 R09: 00007f964cd25a60
> R10: 0000000000000008 R11: 0000000000000246 R12: 000056497b21a140
> R13: 0000000000000d68 R14: 00007f964cd21780 R15: 0000000000000d68 =20
> </TASK>
>=20
>=20
> Hi All
>=20
> This should be because when the raw_dev is released, the 'driver'=20
> address has expired, although the usb_gadget_remove_driver() empty 'dev.d=
river ' NULL, but UAF cannot be avoided.
>=20
> static int dev_uevent(struct kobject *kobj, struct kobj_uevent_env=20
> *env) { .....
>          if (dev->driver)
> 2320                 add_uevent_var(env, "DRIVER=3D%s", dev->driver->name=
);
> .....
> }
>=20
> Whether protection can be added when operating 'dev->driver'?
>
>When the driver structure is unbound, this should be set to NULL.  Why isn=
't that happening?

Yes, it should be set NULL at:

close
raw_release
   ->usb_gadget_unregister_driver
      	-> usb_gadget_remove_driver
         	    {
                  ......
                   udc->driver =3D NULL;
                   udc->dev.driver =3D NULL;
                   udc->gadget->dev.driver =3D NULL;
           	    }

kref_put(&dev->count, dev_free)
   -> dev_free
         kfree(dev)   <------------------------------------------ raw_dev b=
e freed


if the udev process not meet it. The UAF maybe can trigger.
Did I miss something?

thanks,
Zqiang

>
>thanks,
>
>greg k-h
