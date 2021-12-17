Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9353B478C52
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhLQN3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:29:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:60746 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhLQN3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639747752; x=1671283752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=avRAO9BzbZElEZgcpfykxX1ahhioetAdU71Hr8Yls6Y=;
  b=TmhHWRAfJ7vNjlf17g04rrsWhOvtyPqK41L5oGpbpzbhCC+djplvqyXs
   ZjRBLnfL8qenmGsNnva6sLDh/cQR8GVGugmoA81g3VkF3V/K/9ta61UFR
   LaGCJ+ElVJOhRhDDtHH0+iTpHuAtXNrSPYbLKGRNemJ9+u4DPk33h/EDE
   auUEPgfZDhU9CnBiFsgfQ9J8MgzFDgClDXb6rFu0yHrgumIMN6A7J2JDF
   +PB5ovIO1+f5HZoaRU/ioJBsapuO8I3VLpug6R3Cyz1LAZiuLpsvPkKqq
   04CQcjRIjXfiYvuU+Yt8/uFJVME3p2QyKPaKHp2gQEDnacqVlD0YfIZrn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="300527837"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="300527837"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 05:29:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="569023058"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 17 Dec 2021 05:29:11 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 05:29:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 17 Dec 2021 05:29:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 17 Dec 2021 05:29:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkINCpdeaCCYEcMRrL3OBGIqtiJj7jg5K8OThTA2JdL9yjrWVwf7HlZ1zInFS8av6bdgS4FsSBZRNaCEBZYhWNzyve91Eg8PnZ5B/nbvMwK8iL9Veo+f2kMsMEvu+61c56sw8uiqEgTJfXfORnJf4iZyEULg48I9PytEUsAMtE4BHjCwQwi9+1NvK8fW089CRrKQadG0p+W3xypQs/JwYNgk7R6OiP14zlktoGKkUXbquX3a5IhHx+qSQ1tU6RqJgowEkKmqXqWS5vw0ZJA1uAYo5Djs4x4m72/CLOHyWLQOnR7ZOAbZbzX95scZ3YQOYYjxRo+qDe7IKzw/+6aB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UU/eI7jv3mSgY85UhQmmiC0JSJe4WUAhwDLk8DOXh+w=;
 b=AppweIwZbPxRYIhbZOy++hIh0mB7lI/c65AUSHqiYKZT39puabH7ZJdGQ9N25wlqFSuHn9zRyCNhXwJMnKxA3p1YuI80UBdJLKcguTN+9CrFmR6bIXmRvJkxvdnWpQD2cPmbfYsbOOxrDoODvxAJG9Vt01QPf1KVmR3w3AWbtDR8jRcJ1G7OAhm8QxLRL7KhuaKtUzJ85lFxaCVnQ9LOMDGTvXrUn71fetMdlFoMh3/yzt4J4CrtsgR4IIWAekvZs6RyjoFlhbmR+Fs+WO7RDI4Vc1xpgP4YbB3o5wScCRHwN29dg/eKCGTwd84i8cn2rZkPZkeDHMsXFwwDFrJRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5669.namprd11.prod.outlook.com (2603:10b6:8:36::10) by
 DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Fri, 17 Dec 2021 13:29:09 +0000
Received: from DM8PR11MB5669.namprd11.prod.outlook.com
 ([fe80::d1cc:7fb5:4e2b:bca6]) by DM8PR11MB5669.namprd11.prod.outlook.com
 ([fe80::d1cc:7fb5:4e2b:bca6%6]) with mapi id 15.20.4778.017; Fri, 17 Dec 2021
 13:29:08 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>
CC:     lkp <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: drivers/edac/i10nm_base.c:256 i10nm_get_hbm_munits() warn:
 'mbase' not released on lines: 249.
Thread-Topic: drivers/edac/i10nm_base.c:256 i10nm_get_hbm_munits() warn:
 'mbase' not released on lines: 249.
Thread-Index: AQHX8xafu4Y7Bcmzg06agVf5XnOlsKw2pX3w
Date:   Fri, 17 Dec 2021 13:29:08 +0000
Message-ID: <DM8PR11MB56692F596CAAC7D7AA252B4789789@DM8PR11MB5669.namprd11.prod.outlook.com>
References: <202112161000.15tF7PTx-lkp@intel.com>
In-Reply-To: <202112161000.15tF7PTx-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c423d8c-9e63-46f6-831f-08d9c16134b5
x-ms-traffictypediagnostic: DM8PR11MB5655:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM8PR11MB565562225C82B0A73F47391F89789@DM8PR11MB5655.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: upoV9VSA/ZJGcBwxLPRyxnB0UDM4RJvrLJ5ZYF6eKUZfAuT4BRFt2lWvouTuKAeNDBORz974Qx6q5KTok6x4yse8KJfPdTxm4pFUrDd65GCxj+6LN0lWCBmecYFh6YOLLz0mohkTIBwweVyYbjrKPrM19/Da7OykMLIjSJdjJ0yAxxUEyhUa+46RfZTobgkEA03a+CIcmcYxgx//q+HOAGXnnOS8yRuj/A1OPvKxkm6IKJ4Tq4RqIfCKVC4ZG47G8oB3TfQWBcEYVeojhqN+bkMhZFqy4TSpQEUSzXtOefQhXIrv5VsbX9mkWCNK921z6Fa0KQaN4j9MquVPXxUikLiJsrA9APHvfsWRHUG1l9+PYCi/+E4F71LbtIdhLMKuyEPdpNMGn5IBHczxHAkGEBWDo9B2mFFdnNoxibboEo8egJj0A9J+FGsPyhcFCiIinN45e8U/IPowPA3same2smTEvZ4EywtX048oRYBbVHEqbVYitRsI0rfNfsAqqHtZ2wrj8CwmJoK9lGuy5gqqvjRKeYACq0jddqEMgQxKLdHnXBlvfO6jhTs4gXXu+tA4VMd6EFOnhsMQEwawnC4XFUvRd9TXQh7i4oFRXUg0SAfSzmahbTv46JpFgsm7WCGme0+9PjMSIz5u0Rx/uGx4Qj/nna2PhzPDqz8FbLakodrrdxP4juk+C8rvS/zjVHKTh1eg+kBKL4Vxv07Nd4Xhcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5669.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(66446008)(33656002)(2906002)(38100700002)(66946007)(71200400001)(83380400001)(66556008)(186003)(4326008)(7696005)(76116006)(107886003)(5660300002)(316002)(4744005)(52536014)(55016003)(54906003)(66476007)(508600001)(86362001)(122000001)(6506007)(8936002)(64756008)(8676002)(110136005)(9686003)(82960400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nK25CHYfnTs5YVu2p3VfwqZsp+wq+ISBCgPjtorrp0Xs45MUl5Kv0OUSMvb2?=
 =?us-ascii?Q?hJnp30qWRvpMTO43BAxyjQUqvaBmfbcNjPu5EpgytB02pqpTaTe47J8snSbn?=
 =?us-ascii?Q?BKDWu2Xb6q56eMq2U3P2mgjoMqaf1lw9JrCr6/CO+DaoIMEnglVFW73rPkcu?=
 =?us-ascii?Q?9NVjW1FAEndtb1SlD8I5abVgDoQiSzNz1nCCu/g13wqd6ka5vH5KnjG+6lJY?=
 =?us-ascii?Q?hDTN8x94db2yG4mHSkoLd5lhXD4ZvGasydmcduhApRMZ/PDuJNWZPoQvzVR/?=
 =?us-ascii?Q?XuNBmOIMbOm+5fXJ5hUvHWNiO7FPoW/0s0U/Dx63j8rq88IUSTot07r8tUG9?=
 =?us-ascii?Q?pq2RR7uMhFGfz3wVMyYrzDAmV7B6O5Gq7WcnC1T5b7OMaBlAk3H/nVTIAshL?=
 =?us-ascii?Q?xcWbuUK7mE4a8tx+jzMMrUH7+N1r4xNkY7b8//+a/TcHY62JwuoszUHPkWLO?=
 =?us-ascii?Q?ms/VEF0sxQe0yeLBbosecHTeuxOWPAWGsXgJlex9CB+D+fuAqA9QwvBKJNhA?=
 =?us-ascii?Q?Ukh57lf+Vdzek1lsj8E5dIlxGUTXW3g6XbGttD42bg6p0QHoVLmFJV3LzK9L?=
 =?us-ascii?Q?l21WBiLZLJYceECd7DqQxfhY/yfiQwEoUY4HfRdHgfZ4/bcbu32R3U+JAltm?=
 =?us-ascii?Q?hNWlpVAPFbYExZfBQQjz1roI7CdeYb7qWkejaRjDqed7++aGc6Qmyd3cMP4n?=
 =?us-ascii?Q?tdm9LdgsRNOp6WjwjP59JLse2d8m7IPO9LOI+GXTJq+MOFzHAe2Dhe8q803X?=
 =?us-ascii?Q?nTQOgz6vV4qSri+mbNy2/FYGHbCeckThz1BVjaXuBeTt5Qi0EurXGhbe+j4U?=
 =?us-ascii?Q?OpYDTgKMWOTQxSO0st7/D2XEba68pWAqrPkZPpMYjlpL4YPqXxdgVrezeCLy?=
 =?us-ascii?Q?GVzkkJq8MkJcNKAP1hZZbCNe3t5YpozliANk/aBVO/ApIt8vJ1Z4CUkRVxPR?=
 =?us-ascii?Q?MqWdjtlCtY2eHTmRvpSJt1rSRs72mo7HDnE1SjRH4W28kNbKYzDjCOWiXY9A?=
 =?us-ascii?Q?I4HG5KL7PzhdUqJ07IuvdERyqN/Xuw5fcVm08ianJUOQDnoHodfITRmRC4eq?=
 =?us-ascii?Q?YqMg/3LlXXvlVXA0eBNNNqDdx0w+WSIDo+lTXkiQrGqv6MQLxNI2XppaSUAm?=
 =?us-ascii?Q?keMJENSouiqAHj1LAxaC3iks7pjl5GSqTyMA9zSMg0msNlYRdyB3vx2RX3F+?=
 =?us-ascii?Q?bA2Be3Z9FeqagQGazihPF/xjX1F0BXnFhbogNuxFJQMOwymtaNMnV22qa2Xi?=
 =?us-ascii?Q?CwFWnd8jkF3E7wugWiXAfj2ke1Hjk9Jd5IHhPMafBQJ22ekWQzag9qO9vB3x?=
 =?us-ascii?Q?f+tDaGLYnWiR4sJL6cGdxZki7v7z3diVT8epB5EB5N/bMBlZLFn57auqYKsV?=
 =?us-ascii?Q?R0XRooTZMvkUpO20py2e9xS10S73Kzt0IcM+AY61jzqzNymQQthaeuxiXzlp?=
 =?us-ascii?Q?/UgllvfVEVVlQaWIoccIGLKBCjuHHPI37bBMmqykWhQb3NKz4OrAg7GgyavL?=
 =?us-ascii?Q?JVd52gzB5zVkFMmILY5+/znZU8CXdn8KKCKGD1l1YbzY76rPEqCvoyUgFb7Z?=
 =?us-ascii?Q?iHANKlvW9pl2rDpZBMGcAOYxz4k6NL7AMzpZPFLJJU9CqO+LR2lvEcEGYL1q?=
 =?us-ascii?Q?RXVPW5p9YoyPqb3qNfLoZ6o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5669.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c423d8c-9e63-46f6-831f-08d9c16134b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 13:29:08.6810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHBgzQyozwbKA1URbnecwpkIGCryX0u6beGJIxAcbWQWf+5W9SEST8eiS50+ZOMYjjY1H0Z6M6JibYAFTt2VwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5655
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dan Carpenter <dan.carpenter@oracle.com>
> ...
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20

Sure. Will add the above tags in the fix patch.

> smatch warnings:
> drivers/edac/i10nm_base.c:256 i10nm_get_hbm_munits() warn: 'mbase' not re=
leased on lines: 249.
> ...
> mbase =3Dioremap(base + off, I10NM_HBM_IMC_MMIO_SIZE);
>                                                                 ^^^^^^^^^=
^^^^^^^
>...		=09
> if (!I10NM_IS_HBM_IMC(mcmtr)) {
> 	i10nm_printk(KERN_ERR, "This isn't an hbm mc!\n");
>            return -ENODEV;
> }
> No clean up before the return.

Thanks for catching this issue. Will fix it.

- Qiuxu

