Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C248516C83
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383829AbiEBIyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359557AbiEBIyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:54:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F839FF6;
        Mon,  2 May 2022 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651481474; x=1683017474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pL5OVrhbqd0knP42n3JADfQLg7bvlQ8KJZ5v3aT/UU8=;
  b=H7QHGQzS/lWHnzAOp+kdKWLU0fR11qlRm83IzZU0wZ69CMWbpAXTLq8Q
   rV4d/nzmmlOOqTKNFD4UeK5+qPuAhJIrbtibbHuVIwfZ3A5PyPWsDF18j
   oqOAHb/d9gR4nmyKNkUolpqiGv4Bl1I/hFvjEEqMXl90r6K+8NZmF3JS3
   DIwc7NFzNmg3AXhPurIOv6eqSmzDnZ0AJVWk4xFnVPb59hffP1Ra8DBGj
   BL/V2N2sv/rpasy/UFF8s5vcOcORCaUTVnMvKcUTVZ/1fPxSzZVbnH0Th
   zyoR7/lCB6MOK6obmdRZ7UHlcFPaMHJl9nmvkEN/RZ7kGDG/8N5Idk/XD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="353588247"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="353588247"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 01:51:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="689876775"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 02 May 2022 01:51:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 2 May 2022 01:51:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 2 May 2022 01:51:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 2 May 2022 01:51:13 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 2 May 2022 01:51:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZSXIydPKyvOghB5sJ3W2cI+GjHqPNerXkjyugqnlnq8jf/Zs4svtIIAiTvI/jAJbwrMkcJMZVByAGZFR5bMk4AwvPPYnLdBjMCRlkJfKDsxPMvCJFlfqdQ48BNf5lKuXv13xAW/LhEJ/CbNUwMHNopFJJzlmTnNGPmLBMsmfDsAbHlEDIgxmPxXrX9rZ6aKy/JCSXe3Sdwu9M5aq5kb5c1YTABPursk5OQS67dt2/DvUayxsoNXJNB9kb8UmJ7PgEOXwSOTuCdq2kkI7hFlewnemKpOe9W9EK+2VkdyErAFDNZdWHrBUX42gMgpllPReSK/ULiiKsaSP6U95hVvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GGHwkJnC/HGRumHQLZP0QzBCwOszJfhIQTOlcz8Rf8=;
 b=jHDeSHOSS2rlQ8d6k8q9kDr2WzXz0wza2rAq+eVfHXovlvE3sE5mb6ZS/31GoNd70QQzh0/G+FI8hqBafr4hgIoOUZJGTKKFBlqrDtZPA/FG697tKuJfvkLg+34sIhG4uf69gR+phcd60yAli6bcHIhfklAOr5Pu1Ura87n2nOgUhcHrsxj6e33QyVbe4wrJ2dO9+J10Xia1xp3ytP5M/7r148vqVUqUTP51J3VpImIdZ4dBq3zX8zUQ9eFOtV6iXNFfRi37CZ8iUL1yI0XVVIemAdm37Z2NSRjjoaNXpuNKkpt255LOCv7l54A5Zq313fgCo5v57duftDfAmh/2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18)
 by SA2PR11MB5194.namprd11.prod.outlook.com (2603:10b6:806:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 2 May
 2022 08:51:06 +0000
Received: from SJ0PR11MB5816.namprd11.prod.outlook.com
 ([fe80::7d0d:3d90:3bbb:462c]) by SJ0PR11MB5816.namprd11.prod.outlook.com
 ([fe80::7d0d:3d90:3bbb:462c%7]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 08:51:06 +0000
From:   "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Pan, Kris" <kris.pan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "A, Rashmi" <rashmi.a@intel.com>
Subject: RE: [PATCH v4 3/3] spi: dw: Add support for master mode selection for
 DWC SSI controller
Thread-Topic: [PATCH v4 3/3] spi: dw: Add support for master mode selection
 for DWC SSI controller
Thread-Index: AQHYMtgoq5JfEBCuBU6bkaYDj8pnVqzuB92AgBXKJlCAAeLWAIAF53uQ
Date:   Mon, 2 May 2022 08:51:06 +0000
Message-ID: <SJ0PR11MB58167AE8F52DD81B68AE91A885C19@SJ0PR11MB5816.namprd11.prod.outlook.com>
References: <20220308103331.4116-1-nandhini.srikandan@intel.com>
 <20220308103331.4116-4-nandhini.srikandan@intel.com>
 <20220413130249.ueisqj5xs3komhmr@mobilestation>
 <SJ0PR11MB58160274EABEA39BFA625F5485FA9@SJ0PR11MB5816.namprd11.prod.outlook.com>
 <20220428143454.igdqqbbtufrzrizz@mobilestation.baikal.int>
In-Reply-To: <20220428143454.igdqqbbtufrzrizz@mobilestation.baikal.int>
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
x-ms-office365-filtering-correlation-id: 3bd0bcc6-738f-4483-a5b9-08da2c18e54f
x-ms-traffictypediagnostic: SA2PR11MB5194:EE_
x-microsoft-antispam-prvs: <SA2PR11MB51944BBFCA95E62017B864EA85C19@SA2PR11MB5194.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q3nxa+b4dWaeTEly7ROENfS17Y7rKA+xiLBOoMX+QxgSNpw34Q+rC+oYWm9ZyBKAQzGBln7eRedyilLfh8fN4RsDTX4AGIk4CiONn++zRMMPQeOaizkN8rqO18RHNjksZGVwBHTn0qGV5Hu13+MSbJPklGXEfxb1Jh0NuFA1DGQG3qmNLDM/u6SacfTWbgB1mnJmD9lv+i777Bpl2QDa3lzFm6VkU12YGaoadmQKYWr8oUAZZaySeEOsR3vps10riKo60cQ1Q1kPE+JVGmah/EnIBoOVNOrEjerTRBjTQCwEJ4BM72JOYyTbrBRS6CIkyntgd1btnarHCcMlWyF34uOXVc+uMrABq6GT0i8q9V618KSZTOtZ7IkS0rqpm4kXjFP3VK0PUc3FkoGHIQ3a8XjxayydfX09CV2R2/OIM+S7I0LWQY/xRuHVTtyQOJrn6QtPUEBKs5A5EJchGGDlhjpH1v7ufJxClPJCsGvmcidPPSSzvVyx16wghXF1NXxs7WsPM56+RrtNDccIkks/iSlCI1AGiKAF/TB/jX97pTJVxz3pVWgTsuoMT3fFCNd75XJVFugzgDkEd+72QDG4DoMii/DBSmbKR2iIu2Re7V8tZrr9aJ8NAJV76r6miAhvA+XycY/HQy0iOcmU4f13gfAu9RS70nxnsOvEzODyCt6rqygYxIsSV2ssCvzNgmuUk7rm9Gp8Kp1KFzTIDfdRZsayag7Oy9rDfqWW236rI27lUgXXT5BMLxpY290IJtOFUg5rB6NfMa0/czfs1WMn9KZk7Ot3GgLDOYOHPDjPg5hvQ36xw+aLSTwxRb4w2x1aKfalYWAO2yJ7L43I53C2PQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5816.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(86362001)(83380400001)(508600001)(2906002)(71200400001)(966005)(6506007)(26005)(53546011)(9686003)(186003)(33656002)(7696005)(8676002)(66476007)(64756008)(66446008)(66556008)(122000001)(76116006)(4326008)(66946007)(38100700002)(38070700005)(54906003)(5660300002)(6916009)(52536014)(82960400001)(55016003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZlFRC1w2BGM/ewmaZReP2cf1uHRfvCfDQV8lodP/c05D90uEIEPqbCMjOc4v?=
 =?us-ascii?Q?IhdJOs/SNlnqRJ78umRsd5NPTlcu5FFaC461DTgpBa8Ar+Hz9FvwIMU/ETij?=
 =?us-ascii?Q?Ch34FdkZuFNudox3LOlCJ8ilDivspIqUdZ9/CsumNYc1IWrWpQIc2AcocJSc?=
 =?us-ascii?Q?hIxWmy1OxaFBGuzxOEvIPul11klvPNqJjwmzQOC+7YdlDfd3K2T+NSzIBAHU?=
 =?us-ascii?Q?4WACtVVkDYXdGFNE9sP4dRQGwA64XkyeAcCgyxUKAxLRFk5ssizhBUAnyq+a?=
 =?us-ascii?Q?xj5FhTQAeB9nG2MRJSSuPvQTmJt8PC38hPrm9RHeEX0pQ2oQ1AgmDui6wMRp?=
 =?us-ascii?Q?fvqqRhB7QBXmCM6Pw0ZiNHpUnNRM9Xu3o2jzrbQ1B/O8wxsS0ZMVL9X52Lx6?=
 =?us-ascii?Q?VM7nJ0twuEVGq80/0TsjBHQHk7QH09SJ625P7krvFd5TrkSrtWAKf09zUaki?=
 =?us-ascii?Q?MO4uyHMYKWN8STw7G9jtron/vlWy6ziRxpIL42rCMRrnCteSJfN9cOy3TIoH?=
 =?us-ascii?Q?GdQscP8UAO+vuKEcA5EuZyGJF7TEAQLV559y6odJ1yU7oRPXoJ1ui5bmCXXN?=
 =?us-ascii?Q?5fdWUu3CdMTmZNpr5OVzTK1dWRBLHvJ08SqOjDf/b0WPvMCa2SWyLGQlQnQk?=
 =?us-ascii?Q?swGztw1dKZw0JaGGe0TIpDXUcBI1un/wm26VcVcgj98/k8gOeNAUY3p+2FoO?=
 =?us-ascii?Q?g0VGzLSe3/1/zF8dMWOmefRaJDGlN9oMVnOdNTT1NYUPFxyCDzn0jJ19yTjq?=
 =?us-ascii?Q?wSkv9Sdza4wOq6BAiPIgPlwzWmazQG9VWiaX85zm3g6/T78AulS00lU5P63E?=
 =?us-ascii?Q?e0DcP2XLWAx1o3LDyoUM/MIEzF34rh9QVGt8nd6kjiM+sQLMaUaDLGNKwdR6?=
 =?us-ascii?Q?+VBInBovE9DtvTEU4znjUx6eOkvLQDDW02ifdzEErHAHVkGS49F9PByxA/e6?=
 =?us-ascii?Q?nBKEdxq2J7l+WSeDr/OHfv+cY6SB4MCKYsFWk9paE4nJnBzzW4rLPu+Ztb+f?=
 =?us-ascii?Q?zb67aTUPahq008GQGKa+A2lTzKr49FlUXRNijNX/T1GqlPutGzaxlHJVB98n?=
 =?us-ascii?Q?4hcd39ddJ5aTViT0IM+byGOR936OabAdcDTXA3v1exwkzKiW19aFgdMdXNB2?=
 =?us-ascii?Q?QCI8ZaWkX6ygKBvyXrlyjLsszQyUDuddmwnwCHKSVhivY1o9GYFDcBuHmu9M?=
 =?us-ascii?Q?RpkWX23nkcCnsq4HVkTFkSMi/M9dWYuddRS2cUvBZPxfGPCb4FRU2r2fxiWk?=
 =?us-ascii?Q?D5kcF5h/SF7PXdn2iGS2JbKxXlpTjIM5LBnXMRVGxVqtG5GMlhWVgP5iKdPI?=
 =?us-ascii?Q?RSwaxDD9cd9Jhy87S2ouHoxBUNzlfR15BZ6W3WLXX069+M2toG5NQUbxjELL?=
 =?us-ascii?Q?bDOVVBmkO1ReYF+fTqt2tpv3Th9H6br7qoMLNYcAuT8uysH8TLq4gPPya4zI?=
 =?us-ascii?Q?7/USCEJ/HwZdzSgCUzwhGP7GdFT7nvdDoVUOLyrADWYAWgCHM10eUXSbat6j?=
 =?us-ascii?Q?8WqydWmpVvHb699Pfwp5mMDpzemIhlKfnve7exOpAyU8BUB0Bo1ihtV0WR5g?=
 =?us-ascii?Q?zqrXgtyh+mFBRpv3d2OKIAe3jUOmKTQjh+8FppnS2f1ceBBLnAWiT5xs5JRF?=
 =?us-ascii?Q?3dS4PIuZVDiCiwXt8k3n9f6q/ffEVrOXk2zRFq9FtZagYTSppPB/NH+qm0Y/?=
 =?us-ascii?Q?ijbhIVBlhTOMEdkYu6XP5lgqG39SG3n9o8WmTSwg83kRGRZcOc9fxOgSbk/4?=
 =?us-ascii?Q?bdaG5+583cOKWueNmyUWa9vqMtPpJN0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5816.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd0bcc6-738f-4483-a5b9-08da2c18e54f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 08:51:06.3761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fFN2AI2/UzIVydjp7AUXvOh0n1OgFeVHfuMO8YghgbfWxXehU/eXOE36LS49bCaN0q8jszbD6f+CMg459t+wSziNiEdKFO33Eg1PYH0iInE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5194
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Thursday, April 28, 2022 8:06 PM
> To: Srikandan, Nandhini <nandhini.srikandan@intel.com>
> Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>; broonie@kernel.org;
> robh+dt@kernel.org; linux-spi@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> mgross@linux.intel.com; Pan, Kris <kris.pan@intel.com>; Demakkanavar,
> Kenchappa <kenchappa.demakkanavar@intel.com>; Zhou, Furong
> <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> <mahesh.r.vaidya@intel.com>; A, Rashmi <rashmi.a@intel.com>
> Subject: Re: [PATCH v4 3/3] spi: dw: Add support for master mode selectio=
n
> for DWC SSI controller
>=20
> On Wed, Apr 27, 2022 at 09:51:47AM +0000, Srikandan, Nandhini wrote:
> >
> >
> > > -----Original Message-----
> > > From: Serge Semin <fancer.lancer@gmail.com>
> > > Sent: Wednesday, April 13, 2022 6:33 PM
> > > To: Srikandan, Nandhini <nandhini.srikandan@intel.com>
> > > Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>;
> > > broonie@kernel.org;
> > > robh+dt@kernel.org; linux-spi@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > mgross@linux.intel.com; Pan, Kris <kris.pan@intel.com>;
> > > Demakkanavar, Kenchappa <kenchappa.demakkanavar@intel.com>;
> Zhou,
> > > Furong <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> > > <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> > > <mahesh.r.vaidya@intel.com>; A, Rashmi <rashmi.a@intel.com>
> > > Subject: Re: [PATCH v4 3/3] spi: dw: Add support for master mode
> > > selection for DWC SSI controller
> > >
> > > Hello Nandhini
> > >
> > > AFAICS this patch should go before
> > > [PATCH v4 2/3] spi: dw: Add support for Intel Thunder Bay SPI
> > > controller Thus you'd perform the DWC AHB SSI Master mode conversion
> > > first, then introduce the new controller support. Otherwise without
> > > this patch applied the DW SPI driver is most likely left broken for
> > > the Intel SPI controllers since you drop the DW_SPI_CAP_KEEMBAY_MST
> > > macro usage in [PATCH 2/3] while the new DW AHB SSI Master
> > > functionality is introduced in the next patch [PATCH 3/3]. So please
> > > convert the series to the harmless configuration on each git image st=
ate.
> > >
> > Sure, I will reorder patch 2/3 and 3/3 so that the master mode conversi=
on
> happens first followed by new controller support.
> >
> > > On Tue, Mar 08, 2022 at 06:33:31PM +0800,
> > > nandhini.srikandan@intel.com
> > > wrote:
> > > > From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > > >
> > > > Add support to select the controller mode as master mode by
> > > > setting Bit 31 of CTRLR0 register. This feature is supported for
> > > > controller versions above v1.02.
> > > >
> > > > Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > > > ---
> > > >  drivers/spi/spi-dw-core.c | 4 ++--
> > > >  drivers/spi/spi-dw.h      | 7 +++----
> > > >  2 files changed, 5 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > > > index ecea471ff42c..68bfdf2c4dc7 100644
> > > > --- a/drivers/spi/spi-dw-core.c
> > > > +++ b/drivers/spi/spi-dw-core.c
> > > > @@ -307,8 +307,8 @@ static u32 dw_spi_prepare_cr0(struct dw_spi
> > > > *dws,
> > > struct spi_device *spi)
> > > >  		if (spi->mode & SPI_LOOP)
> > > >  			cr0 |=3D DW_HSSI_CTRLR0_SRL;
> > > >
> > >
> > > > -		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> > > > -			cr0 |=3D DW_HSSI_CTRLR0_KEEMBAY_MST;
> > > > +		/* CTRLR0[31] MST */
> > > > +		cr0 |=3D DW_HSSI_CTRLR0_MST;
> > >
> > > Could you please conditionally set that flag here? That's what we
> > > agreed to do in v3:
> > > https://lore.kernel.org/linux-
> > > spi/20211116191542.vc42cxvflzn66ien@mobilestation/
> > > like this:
> > > +	/* CTRLR0[31] MST */
> > > +	if (dw_spi_ver_is_ge(dws, HSSI, 102A))
> > > +		cr0 |=3D DWC_HSSI_CTRLR0_MST;
> > >
>=20
> > In case of Keem Bay, though the version of SPI controller is shown as 1=
.01a
> from the HW register, it still needs the MST BIT31 to be set in order for
> controller to work in master mode.
> > Also since the older versions of the controller which do not need the B=
IT31
> to be set, the bit was reserved. Hence there is no impact by setting this=
 BIT31
> for older versions.
> > So, the condition check was removed.
>=20
> I am completely confused. Earlier you said that both Keem Bay and Thunder
> bay had v1.02a DW AHB SSI IP-core:
> https://patchwork.kernel.org/project/spi-devel-
> general/patch/20210824085856.12714-3-nandhini.srikandan@intel.com/
> Now you say they are based on the different versions of the core.
> Please clarify.
>=20
> -Sergey
>=20
HW IP team informed us that the version used by Keem Bay SPI controller is =
1.02a. But in the IP version register it is updated as 1.01a. We are checki=
ng with the HW IP team regarding this mismatch and this will be taken care =
of internally. Apologies for the confusions. I will add the conditional che=
ck as per your suggestion.
> >
> > > >  	}
> > > >
> > > >  	return cr0;
> > > > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h index
> > > > d5ee5130601e..2583b7314c41 100644
> > > > --- a/drivers/spi/spi-dw.h
> > > > +++ b/drivers/spi/spi-dw.h
> > > > @@ -23,7 +23,7 @@
> > > >  	((_dws)->ip =3D=3D DW_ ## _ip ## _ID)
> > > >
> > >
> > > >  #define __dw_spi_ver_cmp(_dws, _ip, _ver, _op) \
> > > > -	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ver)
> > > > +	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ ##
> > > _ver)
> > >
> > > Nice catch. My mistake. Could you please move this change into a
> > > dedicated patch with the next fixes tag?
> > > Fixes: 2cc8d9227bbb ("spi: dw: Introduce Synopsys IP-core versions
> > > interface")
> > >
>=20
> > Sure, I will convert this to a dedicated patch. Just for confirmation, =
the
> patch should be a separate patch with this title "Fixes: 2cc8d9227bbb ("s=
pi:
> dw: Introduce Synopsys IP-core versions interface")"
> > and not part of the current patch set series.
>=20
> You can add that patch to this series (better to the head of it). The tit=
le can
> be something like: "spi: dw: Fix IP-core versions macro".
> The tag needs to be added in the commit log above the Signed-off-by tag.
>=20
Sure, I will add the patch to the head of this series and add the tag.
> -Sergey
>=20
> > > >
> > > >  #define dw_spi_ver_is(_dws, _ip, _ver) __dw_spi_ver_cmp(_dws,
> > > > _ip, _ver, =3D=3D)
> > > >
> > > > @@ -31,8 +31,7 @@
> > > >
> > > >  /* DW SPI controller capabilities */
> > > >  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
> > > > -#define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
> > > > -#define DW_SPI_CAP_DFS32		BIT(2)
> > > > +#define DW_SPI_CAP_DFS32		BIT(1)
> > > >
> > > >  /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-
> cores) */
> > > >  #define DW_SPI_CTRLR0			0x00
> > > > @@ -100,7 +99,7 @@
> > >
> > > >   * 0: SSI is slave
> > > >   * 1: SSI is master
> > > >   */
> > > > -#define DW_HSSI_CTRLR0_KEEMBAY_MST		BIT(31)
> > > > +#define DW_HSSI_CTRLR0_MST			BIT(31)
> > >
> > > Could you please drop the redundant comment above and join the macro
> > > with the DW_HSSI_* macros group?
> > >
> > Sure, I will remove the comment and group the macros.
> > > -Sergey
> > >
> > > >
> > > >  /* Bit fields in CTRLR1 */
> > > >  #define DW_SPI_NDF_MASK				GENMASK(15,
> 0)
> > > > --
> > > > 2.17.1
> > > >
