Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD314535B79
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349542AbiE0I3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbiE0I3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:29:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856D4F1354;
        Fri, 27 May 2022 01:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653640182; x=1685176182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fwhofTuIURZO62Z7cnBI7V7kQZflUskfBXApjUnMEqg=;
  b=WJ+kHIho9AjUil6zqFBDFTFnPHFTmaNHC+5kQ0FDW59Pvy0rmip7A9nE
   GlTqav10VkhKyl/JU1YOT92kGFv8fVBS5kHZO/c78Q2ZeVtzEgdEhUXic
   8loAGkT5yYdNoMlkSDlBAe6/4XzrSN4gFOAsk9YLvvQuj+58Ivj3VDsJa
   mg4ZBcdAmy6dTvi6anh9KWKzz4OclFZ3R5lAIAUAkPbnV5t0Je6YBuFS0
   y/9xJTmzb3tuT5YFG2d9ENQ0n12Is00YfNnXb+u1olX9TMNAXK/gy9c6O
   9QlQrUw3w9K+k/ENoXtxZ+UwaLEq+Te3FIkFrMSGu1aiQp4ef84XnAhlJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274521055"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="274521055"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 01:29:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="610130175"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2022 01:29:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 27 May 2022 01:29:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 27 May 2022 01:29:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 27 May 2022 01:29:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXGq9itIqjs96aJtfiAnJzqPUtrUpz1M/BCfOCTJYb96UNtCT9xPk3ZH0hHIY2UMV770m4Bzw5dMNzV0RuSooYjGyIPFrW+bfNaRHm2E3I+ETUy9krstTDN6m7oyv+poMdN3B8uD2zqjAxJqRxNvrILMJvPog5+KAmXTONwTVDgWbvhb7ytotBqPiTyNHEo0cELnvkj3tIGXS5Ay5SmNEWS6eM8nWe5um4T60gkar7lGzA0NExwXrS/ACZIwf1gffjnETWBL3ufpTJln4XHt99R1ax//cb2G3+I3S2cwXeHcyg/51Cy24wK40F1l/ZDedsIsY4Imx6u6R0yzsVJ0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1VRzS9YdYNvmlGCv7WfbAVQMHw/squO6JgNXL8KkZ4=;
 b=VTqQqI+DIBO4gi95V5C4/coAoMAmPpvfQSmQj9RBv7mE0Wav8UHhlVxH9Am7jk+TxgDDrsIxopcLHA/o79PXE3kkBhym0OFplBqniE32gJ7EjKoPNtpCgiNOTUZS6sujfImbAz/fU/pSTJgm1SEjlhjtR24ytjIenY3H+u3h6mT0CzZw+VugobOfkbVsL7A7If4jdLN6v1TEeVS7KPykUhdSUVtzOP4R7VNTNmd3bmj1kSMMBhAv0TQYBNkn5n7tdPUalUHhM1ceCQoit4ehFSbc8y3Eg1o9DTgZoTLVo8yeQothx0InUnyMsspWMizFB5RnY6/7+s5VLMsuwDassg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL0PR11MB3220.namprd11.prod.outlook.com (2603:10b6:208:2f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.20; Fri, 27 May
 2022 08:29:33 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%8]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 08:29:33 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Remove debug_object_active_state() from
 debug_rcu_head_queue/unqueue()
Thread-Topic: [PATCH] rcu: Remove debug_object_active_state() from
 debug_rcu_head_queue/unqueue()
Thread-Index: AQHYZBspeMDe3A1Muk2pGu69iofBM60b/oOAgAACsSCAAWeEgIAAFeAwgAaO9TCADEieQIABO1aAgADWSiA=
Date:   Fri, 27 May 2022 08:29:33 +0000
Message-ID: <PH0PR11MB5880ECE6C9DE0AC18E9629E5DAD89@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220510030748.1814004-1-qiang1.zhang@intel.com>
 <20220513004955.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58804FA659B1FF7F82C37485DACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220513222619.GP1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588067B25F6F6AE96303055FDACD9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB5880C881CC8E9A24216CE294DAD19@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58805D24C88CA447B07C276CDAD69@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220526181729.GK1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220526181729.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d729630-6ff6-4aa6-a075-08da3fbb06ce
x-ms-traffictypediagnostic: BL0PR11MB3220:EE_
x-microsoft-antispam-prvs: <BL0PR11MB3220CCFE5717011A815C31ADDAD89@BL0PR11MB3220.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F/FyWVaZ/rZA41Bodu7AGx5ulLlxPOW2MJkQQKA4OzEn8qI3DK/mvuZkll4Y9TwTRSKlgeC6DRmlr9yPQOI7Hnu5OJjQRIjITG9fKzo+oP6lH1ZDTD2jVB7/mV5Q+48vXi9tKwp3yig1P9bAF4FXf4xVtFaup4ODBMIArn1WP1inOgHd15seBzIVtGp/YaeP7FheR18Fx0D5Wno0rhkgAnUWBdyykX/pWInyWqUw/0bYoaixXrZvw66jOrj62fEwwz/+1tjT2OEGoIQTvmEh47bN5cq8amOr893DXe9JzLBnMRZD+yeomwT2l4/j0f0QqRXBcika5Q1dIC/rlhDcnsZHtFNoqqZrW91u4cmyZLblvPNw0L3YL5dxiqZ0RHDpDZbp+Fd8uUVQfJzFpf+8bpQl83hzePfi7L3eqe17to7C/3B5hOilZ3FY0EnZPi24ZRJK6/PHovQqTgxv0rGpuu2M3KURmshnHZDAQe1LLkyWFdplFRKkFsXnsF4hChJ8v7p+bUDCv4LHwfvlwUr7imdGhFCTySxGfh1l+4ESIeJAMgsy6f3ha3+9wF7rzTfnTIz1MMUgHD67KLk/7pa9uQFw3wwFy6uRfYkyIsdpQIjN2LicBbOgcOfSHAYluE/598HyCOHuPMApcvGc53Ss06AIX/dS6QIy1LKHT0loIYF/EAwQ3gsKGK2zyT6CJmaUJ4X+nMefYqodkqkc5x9UpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7696005)(83380400001)(86362001)(55016003)(2906002)(8676002)(64756008)(4326008)(66446008)(66556008)(66946007)(66476007)(76116006)(33656002)(8936002)(38070700005)(316002)(30864003)(52536014)(38100700002)(82960400001)(71200400001)(5660300002)(508600001)(6916009)(9686003)(45080400002)(122000001)(54906003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MPdqvbcS17OEkxjl4rzQJaKt+SJJQYdHJoUVMKqPv5+VTKyRWOoduYVTXLOR?=
 =?us-ascii?Q?HuOllXOdh6lBXgvFM2HEAJlnhJADyylV+QCKpD06dPRMOSRY3RIdaaRHaHXY?=
 =?us-ascii?Q?xNI2l+QETED/B98eirplmOKZmvrHW3VWU4D1y9fSl8BFgVLUvuP3NWU1ZP8F?=
 =?us-ascii?Q?P0lGf7ghP/aO9QoF9DjFDbD/TSCSSkGQZ1kQ+3do81Qfd1KknfiIw4t8uxl5?=
 =?us-ascii?Q?KVaGl3gYSnMAed/qHG1wizgrujBPDQ6EScbcg+4mJv2gxv9Pls/nt/iy+ccE?=
 =?us-ascii?Q?v7Dh64HqkdqFWAAL9CtWexKSiDBBny0U7tuSbjHIuBkQzw8bJWsopLxHkUHu?=
 =?us-ascii?Q?B1kjLVWPKp4I1J8QdfNGKiNYvJP9nGs20/c1tKCojk9xbEe+lhRyi4D439H6?=
 =?us-ascii?Q?CUqNXaX+WoLfrW0MT1hgV7abwehmdroJ+z/2gPg/AoUOVP2/9PCKma5M32KY?=
 =?us-ascii?Q?86RLW8E8SgesO5y0S49vY73yM+C73XGR7O2EZZYoDHwlDM+e33MNSVyGn/ru?=
 =?us-ascii?Q?K5UptzlZskDfxRYx3GNv9fbvGDhMjWZIvzy33n4dyCALAVvQTwh4F1JgIVDT?=
 =?us-ascii?Q?wvPVIqdcBNP4AsHyxEbWmsVpVGjDHg46e9QjjRmRPNyxTKFIoIHqyAkwH9pg?=
 =?us-ascii?Q?vhx+muKq+Ag5/Pb9DdU2oCe1sf40pp3viNg0V58eEOjftc1a7+VbqobE1A5e?=
 =?us-ascii?Q?4OMYkJ8BsiJ2eNs2x9G+Vaq0Pij/rwIVCg9+aaMTTr+N4XwDor9uF4q64URK?=
 =?us-ascii?Q?FyKShmBXYC8OGN+6jnrd24mnjjQNplRHaF+2jtVNHMwOLWywCKvLmgGn+lJ8?=
 =?us-ascii?Q?RnmBUz7iK3CAp6VyzDl4Ua9UWcPZbxkzRLlkTPmabNiMajUuw2kWCE/0B+kx?=
 =?us-ascii?Q?w5f/hpXR5jp6fAIy0nueGRMwPKny2DZ+YvPGps7qWv1af9tTRpjzcjw1Fseh?=
 =?us-ascii?Q?0ccFxlPwRnEAN9A1zhQ8nUPGfzOeu7+ot1PUUz08yzcnvJQyH+IJFt3yOZ8e?=
 =?us-ascii?Q?pvDkcRos3DNuDM2S3DVC6swEepHVVnUOQ702adzRMltf8uffQWLOL1Tw3hMZ?=
 =?us-ascii?Q?+ezJfHPcWHQgkSGB+1I6guLe1r9RNdb72sKTrGrCXxkajdEMUbsR0xyLNw41?=
 =?us-ascii?Q?M2FWmfYK7tfMim2wOsFw6DXBpArLr94YjOJ/baZHFn0dPoHnLgpYZRUUtW/Q?=
 =?us-ascii?Q?H6HOvGJP12ql1vi5WkAdhSSiysrJSCO2cwFiJ/d/rRXpoRBGkXw7C5DiRqcF?=
 =?us-ascii?Q?6mOGJj0ic1ZPghAZ+wMvqe1naIdAIaf8Kk4gX008XLS5QLsoz02P1I4r+J7u?=
 =?us-ascii?Q?DeTMdsV7e0vE0VVJaBPkTUAwLQ3paprSAnO2V7Q9PChCWs3vSkWra5IUkrTS?=
 =?us-ascii?Q?r/9UwCRPHNJnj+54N732mbNhwc/KPFajzopZQqvvYbHRziXTOqYHtSfwU9rd?=
 =?us-ascii?Q?o9FfCwPY1KDT17En4n5m4Sa67uODrpeQxgXDrvUHjZTBqMgS4ooFZjDPV5rM?=
 =?us-ascii?Q?5gnX0NEC/J1JohC4H776riYF6/kIVFdqvtu5vs+MGWFJXC5ycDRtGP8ehKxQ?=
 =?us-ascii?Q?VJkjqovaGlR5U6DqSJWJGwmH7v6UH9lzMg1BuM+upBLW7yzJEA9AHQIrTY3Y?=
 =?us-ascii?Q?UwVtwjqrWPUPP9ZokfrTbOfKMSws+7alJsVTgWRi3OsK1D0lp16DwB87CzmJ?=
 =?us-ascii?Q?rdWBRdvCkILyWOEmeIOLBQyCs6Ye9is55xhuMed+SV+0Jr0ZRrA3rTy8DZqA?=
 =?us-ascii?Q?iEGKpJ+zTA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d729630-6ff6-4aa6-a075-08da3fbb06ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 08:29:33.1360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akLteG6YUWYJNBQrToeK7e9E/RAxDMLfp5Dz96TLzPS8XMYYJI2t8T9r45QkJ5P/GPdzacicWonudcahEpUmFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3220
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 11:33:46PM +0000, Zhang, Qiang1 wrote:
> On Fri, May 13, 2022 at 01:03:19AM +0000, Zhang, Qiang1 wrote:
> > On Tue, May 10, 2022 at 11:07:48AM +0800, Zqiang wrote:
> > > Currently, the double call_rcu() detected only need call
> > > debug_object_activate() to check whether the rcu head object is=20
> > > activated, the rcu head object usage state check is not necessary=20
> > > and when call rcu_test_debug_objects() the
> > > debug_object_active_state() will output same callstack as=20
> > > debug_object_activate(). so remove
> > > debug_object_active_state() to reduce the output of repeated callstac=
k.
> > >=20
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > >
> > >Could you please post the output of the dmesg output of a failed check=
 with your change?
> > >
> >=20
> > Original output:
> >=20
> > [    0.818279] ODEBUG: activate active (active state 1) object type: rc=
u_head hint: 0x0
> > [    0.818296] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_p=
rint_object+0xd8/0xf0
> > [    0.818301] Modules linked in:
> > [    0.818304] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       =
  5.18.0-rc6-next-20220511-yoctodev-standard+ #75
> > [    0.818306] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [    0.818308] RIP: 0010:debug_print_object+0xd8/0xf0
> > [    0.818311] Code: dd 40 9e 03 9d e8 48 62 a2 ff 4d 89 f9 4d 89 e8 44=
 89 e1 48 8b 14 dd 40 9e 03 9d 4c 89 f6 48 c7 c7 c0 93 03 9d e8 f6 1a b1 00=
 <0f> f
> > [    0.818313] RSP: 0000:ffff88810033fad0 EFLAGS: 00010082
> > [    0.818315] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000=
000000000
> > [    0.818317] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed1=
020067f4c
> > [    0.818319] RBP: ffff88810033fb00 R08: ffffffff9b50d898 R09: fffffbf=
ff3bf5c6d
> > [    0.818320] R10: 0000000000000003 R11: fffffbfff3bf5c6c R12: 0000000=
000000001
> > [    0.818322] R13: ffffffff9ce769a0 R14: ffffffff9d039a80 R15: 0000000=
000000000
> > [    0.818324] FS:  0000000000000000(0000) GS:ffff888158880000(0000) kn=
lGS:0000000000000000
> > [    0.818327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.818329] CR2: 0000000000000000 CR3: 000000017600e000 CR4: 0000000=
0001506e0
> > [    0.818330] Call Trace:
> > [    0.818331]  <TASK>
> > [    0.818333]  debug_object_activate+0x2b8/0x300
> > [    0.818336]  ? debug_object_assert_init+0x220/0x220
> > [    0.818340]  ? __kasan_check_write+0x14/0x20
> > [    0.818343]  call_rcu+0x98/0x1110
> > [    0.818347]  ? vprintk+0x4c/0x60
> > [    0.818350]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> > [    0.818354]  ? strict_work_handler+0x70/0x70
> > [    0.818357]  rcu_torture_init+0x18be/0x199e
> > [    0.818361]  ? srcu_init+0x133/0x133
> > [    0.818364]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> > [    0.818368]  ? rcu_torture_barrier1cb+0x40/0x40
> > [    0.818371]  ? rcu_torture_barrier1cb+0x40/0x40
> > [    0.818374]  ? srcu_init+0x133/0x133
> > [    0.818377]  do_one_initcall+0xb3/0x300
> > [    0.818380]  ? initcall_blacklisted+0x150/0x150
> > [    0.818382]  ? parameq+0x70/0x90
> > [    0.818385]  ? __kasan_check_read+0x11/0x20
> > [    0.818389]  kernel_init_freeable+0x2b2/0x310
> > [    0.818392]  ? rest_init+0xf0/0xf0
> > [    0.818396]  kernel_init+0x1e/0x140
> > [    0.818399]  ret_from_fork+0x22/0x30
> > [    0.818402]  </TASK>
> > [    0.818403] ---[ end trace 0000000000000000 ]---
> > [    0.818405] ------------[ cut here ]------------
> > [    0.818405] ODEBUG: active_state active (active state 1) object type=
: rcu_head hint: 0x0
> > [    0.818421] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_p=
rint_object+0xd8/0xf0
> > [    0.818424] Modules linked in:
> > [    0.818426] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       =
  5.18.0-rc6-next-20220511-yoctodev-standard+ #75
> > [    0.818428] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [    0.818430] RIP: 0010:debug_print_object+0xd8/0xf0
> > [    0.818432] Code: dd 40 9e 03 9d e8 48 62 a2 ff 4d 89 f9 4d 89 e8 44=
 89 e1 48 8b 14 dd 40 9e 03 9d 4c 89 f6 48 c7 c7 c0 93 03 9d e8 f6 1a b1 00=
 <0f> f
> > [    0.818435] RSP: 0000:ffff88810033fac0 EFLAGS: 00010086
> > [    0.818437] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000=
000000000
> > [    0.818438] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed1=
020067f4a
> > [    0.818440] RBP: ffff88810033faf0 R08: ffffffff9b50d898 R09: fffffbf=
ff3bf5c6d
> > [    0.818441] R10: 0000000000000003 R11: fffffbfff3bf5c6c R12: 0000000=
000000001
> > [    0.818443] R13: ffffffff9ce769a0 R14: ffffffff9d039820 R15: 0000000=
000000000
> > [    0.818445] FS:  0000000000000000(0000) GS:ffff888158880000(0000) kn=
lGS:0000000000000000
> > [    0.818448] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.818449] CR2: 0000000000000000 CR3: 000000017600e000 CR4: 0000000=
0001506e0
> > [    0.818451] Call Trace:
> > [    0.818452]  <TASK>
> > [    0.818453]  debug_object_active_state+0x1d6/0x210
> > [    0.818456]  ? debug_object_deactivate+0x210/0x210
> > [    0.818460]  ? __kasan_check_write+0x14/0x20
> > [    0.818464]  call_rcu+0xb7/0x1110
> > [    0.818466]  ? vprintk+0x4c/0x60
> > [    0.818469]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> > [    0.818472]  ? strict_work_handler+0x70/0x70
> > [    0.818476]  rcu_torture_init+0x18be/0x199e
> > [    0.818479]  ? srcu_init+0x133/0x133
> > [    0.818482]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> > [    0.818486]  ? rcu_torture_barrier1cb+0x40/0x40
> > [    0.818489]  ? rcu_torture_barrier1cb+0x40/0x40
> > [    0.818492]  ? srcu_init+0x133/0x133
> > [    0.818495]  do_one_initcall+0xb3/0x300
> > [    0.818497]  ? initcall_blacklisted+0x150/0x150
> > [    0.818500]  ? parameq+0x70/0x90
> > [    0.818503]  ? __kasan_check_read+0x11/0x20
> > [    0.818507]  kernel_init_freeable+0x2b2/0x310
> > [    0.818510]  ? rest_init+0xf0/0xf0
> > [    0.818513]  kernel_init+0x1e/0x140
> > [    0.818515]  ret_from_fork+0x22/0x30
> > [    0.818519]  </TASK>
> > [    0.818520] ---[ end trace 0000000000000000 ]---
> > [    0.818521] rcu: call_rcu(): Double-freed CB 00000000e2817fcb->rcu_t=
orture_leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory
> >=20
> >=20
> > After apply this patch:
> >=20
> > [    0.647048] ODEBUG: activate active (active state 0) object type: rc=
u_head hint: 0x0
> > [    0.647068] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_p=
rint_object+0xd8/0xf0
> > [    0.647073] Modules linked in:
> > [    0.647075] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       =
  5.18.0-rc6-next-20220511-yoctodev-standard+ #77
> > [    0.647078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [    0.647080] RIP: 0010:debug_print_object+0xd8/0xf0
> > [    0.647083] Code: dd 80 9d 43 a2 e8 38 62 a2 ff 4d 89 f9 4d 89 e8 44=
 89 e1 48 8b 14 dd 80 9d 43 a2 4c 89 f6 48 c7 c7 00 93 43 a2 e8 f6 1a b1 00=
 <0f> 0b 83 05 7b 62f
> > [    0.647085] RSP: 0000:ffff88810033fad0 EFLAGS: 00010082
> > [    0.647088] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000=
000000000
> > [    0.647090] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed1=
020067f4c
> > [    0.647091] RBP: ffff88810033fb00 R08: ffffffffa090d898 R09: fffffbf=
ff467586d
> > [    0.647093] R10: 0000000000000003 R11: fffffbfff467586c R12: 0000000=
000000000
> > [    0.647095] R13: ffffffffa22769a0 R14: ffffffffa24399c0 R15: 0000000=
000000000
> > [    0.647097] FS:  0000000000000000(0000) GS:ffff88815b880000(0000) kn=
lGS:0000000000000000
> > [    0.647100] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.647102] CR2: 0000000000000000 CR3: 000000002f20e000 CR4: 0000000=
0001506e0
> > [    0.647104] Call Trace:
> > [    0.647104]  <TASK>
> > [    0.647106]  debug_object_activate+0x2b8/0x300
> > [    0.647110]  ? debug_object_assert_init+0x220/0x220
> > [    0.647114]  ? __kasan_check_write+0x14/0x20
> > [    0.647118]  call_rcu+0x98/0x1100
> > [    0.647121]  ? vprintk+0x4c/0x60
> > [    0.647125]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> > [    0.647129]  ? strict_work_handler+0x50/0x50
> > [    0.647133]  rcu_torture_init+0x18be/0x199e
> > [    0.647136]  ? srcu_init+0x133/0x133
> > [    0.647140]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> > [    0.647144]  ? rcu_torture_barrier1cb+0x40/0x40
> > [    0.647148]  ? rcu_torture_barrier1cb+0x40/0x40
> > [    0.647151]  ? srcu_init+0x133/0x133
> > [    0.647155]  do_one_initcall+0xb3/0x300
> > [    0.647157]  ? initcall_blacklisted+0x150/0x150
> > [    0.647160]  ? parameq+0x70/0x90
> > [    0.647164]  ? __kasan_check_read+0x11/0x20
> > [    0.647167]  kernel_init_freeable+0x2b2/0x310
> > [    0.647171]  ? rest_init+0xf0/0xf0
> > [    0.647174]  kernel_init+0x1e/0x140
> > [    0.647177]  ret_from_fork+0x22/0x30
> > [    0.647181]  </TASK>
> > [    0.647182] ---[ end trace 0000000000000000 ]---
> > [    0.647184] rcu: call_rcu(): Double-freed CB 000000009a684b70->rcu_t=
orture_leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory
>=20
> >Very good, and thank you!
> >
> >Now suppose that someone passes a pointer to call_rcu(), but then invoke=
s kfree() on that same object before the grace period ends.
> >Is the offending kfree() flagged?=09
> >
> >If the CONFIG_DEBUG_OBJECTS_FREE is enabled, the debug_check_no_obj_free=
d() will check wether the object is activated in kfree() If is activated, a=
lso output callstack.
> >
> >__debug_check_no_obj_freed()
> >{........
> >	switch (obj->state) {
> >	case ODEBUG_STATE_ACTIVE:
> >	 	descr =3D obj->descr;
> >		state =3D obj->state;
> >		_spin_unlock_irqrestore(&db->lock, flags);
> >		debug_print_object(obj, "free");
> >	}
> >.........
> >}
> >
> >Hi Paul
> >
> >The __debug_check_no_obj_freed() only check obj->state,  don't care obj-=
>astate, the debug_object_active_state() is not necessary.  If CONFIG_DEBUG=
_OBJECTS_FREE is not enabled, the kfree() will directly release it without =
check obj state.
> >
> >Any thoughts?
> >
> >Thanks,
> >Zqiang=20
>=20
> Hi Paul=20
>=20
> Sorry to bother you again, I think this change is still meaningful, or th=
ere is something I don't konw=20
> if I can give you some suggestions, I will be happy to accept.

>My concern with this patch is that there might be some odd scenario
somewhere in which valuable debugging information is lost.  Unfortunately,
>I haven't had time to fully explore the space of possible sequences of
>double-free and use-after-free bugs.
>
>It -might- be OK, but I cannot prove it.  Thoughts?

If CONFIG_DEBUG_OBJECTS_FREE is disabled,  invokes kfree() to release point=
er before the grace period ends,
kfree() will directly to release it, there are not call debug_check_no_obj_=
freed() to check this debug-object
corresponding to this pointer, when this pointer is checked before call RCU=
 callback func, the  debug_object_active_state()
and debug_object_activate() also trigger warnings.=20

However, if CONFIG_DEBUG_OBJECTS_FREE is enabled,  when invokes kfree() to =
release pointer before the grace period ends.
We only check the state of the object(obj->state is set by debug_object_act=
ivate()) corresponding to this pointer, the obj->astate
Is not be checked, That's is one reason I remove debug_object_active_state(=
), and I found that few modules use this function.

Now there is another problem,  set CONFIG_DEBUG_OBJECTS_FREE and CONFIG_DEB=
UG_OBJECTS_RCU_HEAD  is enabled
I did a simple test like this:

       struct rcu_head *rhp =3D kmalloc(sizeof(*rhp), GFP_KERNEL);
        preempt_disable();
        rcu_read_lock();
        local_irq_disable();
        if (rhp) {
                call_rcu(rhp, rcu_torture_err_cb);
        }
        local_irq_enable();
        rcu_read_unlock();
        preempt_enable();
        kfree(rhp);

the follow warning are triggered,=20

ODEBUG: free active (active state 1) object type: rcu_head hint: 0x0
[    1.255220]  debug_check_no_obj_freed+0x248/0x280
[    1.255238]  kfree+0x12d/0x610
[    1.255253]  rcu_torture_init+0x16e1/0x1741
[    1.255305]  do_one_initcall+0xe5/0x440
[    1.255349]  kernel_init_freeable+0x342/0x3a0
[    1.255366]  kernel_init+0x1e/0x140
[    1.255373]  ret_from_fork+0x22/0x30

The code shows that if obj->state is always STATE_ACTIVE, there will be a l=
oop,  until rcu callback is invoked
set this obj->state =3D STATE_INACTIVE.  after that this loop ends. If we i=
nvoke kfree() in preempt_disable/enable()
critical sections before grace period ends, it may be trigger RCU Stall.  S=
o maybe we should add fixup_free functions
to rcuhead_debug_descr, In fixup_free function, set obj->state is STATE_INA=
CTIVE and set rcu_callback func is rcu_leak_callback()
to fix this problem.

static void __debug_check_no_obj_freed(const void *address, unsigned long s=
ize)
{
    .. ........................
        for (;chunks > 0; chunks--, paddr +=3D ODEBUG_CHUNK_SIZE) {
                db =3D get_bucket(paddr);

repeat:
                cnt =3D 0;
                raw_spin_lock_irqsave(&db->lock, flags);
                hlist_for_each_entry_safe(obj, tmp, &db->list, node) {
                        cnt++;
                        oaddr =3D (unsigned long) obj->object;
                        if (oaddr < saddr || oaddr >=3D eaddr)
                                continue;

                        switch (obj->state) {
                        case ODEBUG_STATE_ACTIVE:
                                descr =3D obj->descr;
                                state =3D obj->state;
                                raw_spin_unlock_irqrestore(&db->lock, flags=
);
                                debug_print_object(obj, "free");
                                debug_object_fixup(descr->fixup_free,
                                                   (void *) oaddr, state);
                                goto repeat;
...............................
}                             =20


Thanks
Zqiang


>							Thanx, Paul

> Thanks
> Zqiang
>=20
>=20
> >Thanks,
> >Zqiang
>=20
> >
> >							Thanx, Paul
>=20
> > Thanks,
> > Zqiang
> >=20
> >=20
> >=20
> > >							Thanx, Paul
> > >
> > > ---
> > >  kernel/rcu/rcu.h | 13 +------------
> > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > >=20
> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h index
> > > 15b96f990774..0604ecd16627 100644
> > > --- a/kernel/rcu/rcu.h
> > > +++ b/kernel/rcu/rcu.h
> > > @@ -179,27 +179,16 @@ static inline unsigned long rcu_seq_diff(unsign=
ed long new, unsigned long old)
> > >   */
> > > =20
> > >  #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
> > > -# define STATE_RCU_HEAD_READY	0
> > > -# define STATE_RCU_HEAD_QUEUED	1
> > > =20
> > >  extern const struct debug_obj_descr rcuhead_debug_descr;
> > > =20
> > >  static inline int debug_rcu_head_queue(struct rcu_head *head)  {
> > > -	int r1;
> > > -
> > > -	r1 =3D debug_object_activate(head, &rcuhead_debug_descr);
> > > -	debug_object_active_state(head, &rcuhead_debug_descr,
> > > -				  STATE_RCU_HEAD_READY,
> > > -				  STATE_RCU_HEAD_QUEUED);
> > > -	return r1;
> > > +	return debug_object_activate(head, &rcuhead_debug_descr);
> > >  }
> > > =20
> > >  static inline void debug_rcu_head_unqueue(struct rcu_head *head)  {
> > > -	debug_object_active_state(head, &rcuhead_debug_descr,
> > > -				  STATE_RCU_HEAD_QUEUED,
> > > -				  STATE_RCU_HEAD_READY);
> > >  	debug_object_deactivate(head, &rcuhead_debug_descr);  }
> > >  #else	/* !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> > > --
> > > 2.25.1
> > >=20
