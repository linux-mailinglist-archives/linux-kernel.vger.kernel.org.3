Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A88596901
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbiHQFsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbiHQFsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:48:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2BA7A754
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660715253; x=1692251253;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rF1FVd/EEu7D/deP/eCZrcE9f1LFq2wpJjiw01gRx7Q=;
  b=Ph2+pnRJZivgBm+7VhHVADb4nSWg/78ZPgeKiRo1XYm5k2zqPspFwQjy
   q/HIamtKfS269RN2jdjmbmMf69XM6pez9Xe1rwHSpZ73aU1XWu6Myfgao
   0J0uw9nkI8ikYoITTHyzI1vzPF5tF4rKvItf+YJDPFFEAlZ3NmTIeJGBh
   PYMuWHjFBqBPMYM2i+AB36qoI7/DAuVFguFBxf22E9AfvqNMCmj7tvcQy
   lLYiQLG7opnNFTHWLCR4h18nmSowwfVaQQA90MumpaZuwjupBlkPhtTfL
   EI6c22V3HHOxVPaosnMjEY6jX/DolxkpaTVvNei6HZXLa38YDjavhkZFi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="272800463"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="272800463"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 22:47:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="749580451"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2022 22:47:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 22:47:16 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 22:47:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 22:47:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 22:47:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buLC0cDkRkv9eqKs6xhAEUA+bpRsJeNskl8KCnUR8rIn/er8nGhXbymx0RuxS5tLpVBajDuMp3eUg0MKNIdH/8zd1dfCjvhDPsbdAa7WxmaQHMnfbsUO6dW9rZJaOVDPbNpDe6XwFebRj14a1qxnaasmq4AHGBC5DO8L504n3eTBI6Q8Ej+ZYCqrABD3+oNfaUR+EGXF4yWtq5P0qGq/IsTId8OoEOfE8azSvLJBuNVZkgORS6LtLf8JCgj4owpMjAx6B0NaMNBx7x1r1tqdtuxpr9+DRQWNs91byjgz8un8Z3nEeVUcIv87MygOG7MA19r/eqJAJuI6ug1mgjbH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99tVV5qErWdSLxxlmbcYiJbnj7emp/2PczAeCywkidA=;
 b=cd3CsTxjefJ842LQ5VbL3wVNvoy8Kw7ks/z8c5VjD/3jk9L/Phpl0EURjRxXdLw4lTTypTEgS1f26DXiCoc1Oqn1Tk1MitmO/L0EH6lTlzWiJI5CKZLCxclFI6KpM384X/+P90jy+f23XGeF54IKoBV0KLLVo9G03vPVa3evaBineYPJDvPChTnzp1jSXOmHIK9O0daqur0BHJ6slcpnJiOcsv6kv+HajbTRNlXlwjESNc6sSXjTrdqwnRdS376v2TXsTKkk/O2/b0TQRnO9w4y+Ocj4rVD00z/dZLQk+3VL6j4yKWChWowRC1nAYhYI2+yi1JeqyQkfvK2opqB/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by CH2PR11MB4407.namprd11.prod.outlook.com (2603:10b6:610:47::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 17 Aug
 2022 05:47:09 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 05:47:09 +0000
From:   "Wang, Haiyue" <haiyue.wang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: RE: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Thread-Topic: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Thread-Index: AQHYsRbS1IjgnpM1/EaZo6nPqIEeuq2yRsoAgAAoZ1CAACcnAIAAAFyQ
Date:   Wed, 17 Aug 2022 05:47:08 +0000
Message-ID: <BYAPR11MB349565A7C67907DE0AF3BDF6F76A9@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
        <20220816022102.582865-1-haiyue.wang@intel.com>
        <20220816022102.582865-2-haiyue.wang@intel.com>
        <20220816175838.211a1b1e85bc68c439101995@linux-foundation.org>
        <BYAPR11MB3495F747CBF95E079E8FC8A5F76A9@BYAPR11MB3495.namprd11.prod.outlook.com>
 <20220816224322.33e0dfbcbf522fcdc2026f0e@linux-foundation.org>
In-Reply-To: <20220816224322.33e0dfbcbf522fcdc2026f0e@linux-foundation.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1c65e43-ed22-438a-3329-08da8013ecb1
x-ms-traffictypediagnostic: CH2PR11MB4407:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AyNEReQfP909prkkGatqPvITkraCd80MEo4nlMzkb0TXHyLnNUbnyqkFNra8W+VkF+qcm/zG58bpHnImoIPjd0yNilokTsM2Ih0b38Dtfm+jtaOiPDjFYqIoVDnBeWUA7cw2XuPQ7Ff8iLUUYBqtXD2/2nL15UocXaXKlvHar/1ImWdGsb3uuTrzubZV/jp6BWaaG3bP9I76EZ+/CeYS7VMJ5xnYq95COIwYc7HSAE6B/cCkSFWhROFd5iaR4zaRLPQXvCoXnzU1/YibUVipefVca9T7Eb1Hd9N13SqmJKVcAPGd4rDFqcMEWXYcoLucfiknXvmIVrYAJfUndhDezZfx6/l67YKhIvbky+DPWKrFn6tmWPOV6zaxRR4/+g8AUzL+0TjJ6+JhDhQNm5AnU5U3icGKOEQWSS7FZkJILtl6FkDgbU/o8Rb/rlZnlLW5Jl7e9EQZqYhyDPjpPYXFZLacM7rD7vz0tbnGjTGyEgbGTbEBParw1vPzQHTOGH/GlFCu4NkxUzP4eXSfUS6wY/PsBWHwLpIaWbmCWX5IdK8bcWQA4Usqjx+qj3OOQzpITGLlRHdhAPuBIe2omT+gl+5tunoCROnvRhm+Py9WsOzLj8T8zqH3LG57mXehSCqEDGA8tSI34lFebfFI4fMCfxkWIGDUEj3gLNdl3lHIMOEu09FnbHx+EPfxOxOq1R746GH91jep2hsULjDEm4PRj3zbSS/L5yVrQmT8pZq2jGsU7wBweRuMs9tQdFPkcUiiltotTD/6rwYAI5Hz5GIcXGfXblxKFhT1c/xM/S9DaXo3CphIpoAmgnC7JrlKipCVF+h+l/diqVlkT3/8dZFcCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(39860400002)(396003)(346002)(4326008)(71200400001)(86362001)(76116006)(8676002)(66556008)(8936002)(66446008)(66946007)(64756008)(66476007)(52536014)(478600001)(186003)(82960400001)(38070700005)(7416002)(41300700001)(38100700002)(83380400001)(5660300002)(26005)(2906002)(33656002)(6506007)(7696005)(54906003)(53546011)(6916009)(9686003)(122000001)(316002)(55016003)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4QsOszrjRSWqhsH4HXJeGJtMrmFw16GId0Kye0mwegWtRICTMA+HRbRnQXo5?=
 =?us-ascii?Q?7e1+8FinO3CpKjfk+DfF35DhF5jX5TG6GYwQB2K/d+vKy6E8JH+7JmsMQITO?=
 =?us-ascii?Q?dN3xBUYmAaVp0uI/Z+Bw6FKnkNncw4kUNKqNAtAY30mfj+lkY0j6Lh4dA0Vo?=
 =?us-ascii?Q?v15MzFVuNI9XcO38l7kLl9/ZPbzlwWQMidR01q24vFXHMjqrvg7l5Zi98AtK?=
 =?us-ascii?Q?WGkea4A1E0+L2m1l3RFd64Da6WCEDtefxuJfkil1DFokTnu2CvzTafCJnzhq?=
 =?us-ascii?Q?REDviugqCCygX5wRxbuSL0cikMxrDIvEhU9J5Z+VsZZEg9z3KRzSfwgTf0xB?=
 =?us-ascii?Q?U74/lje7hYr7z5J7JGRpcVS4pKXNg6FIo8whahQLjl18TL5sDeYou4XKzO5C?=
 =?us-ascii?Q?vSGcODoY5XNnjlBfM12cjArY9R4r165di3VVRB012UutjAxSLIRwwq8Hxsu/?=
 =?us-ascii?Q?wEKTuyiwoNXxrs0M2KpYcULjyYyhqLqjL0ajDnUVtDA8G9bwaomVqFxVVEA/?=
 =?us-ascii?Q?U881OKergth55A5lH4NNlEvblPG+HHUYUzyXTKUZsNTlYULEsim19aFedafX?=
 =?us-ascii?Q?E6p8YIfaWSBVNUqwC5baJzYK48fk9UAn44dfK8DF/6Hxk7yX9UdRWiHHjXE1?=
 =?us-ascii?Q?UQBLaAynBLLJWDY7hq5WyGLtIJgVHxJC1H45pKQjpfhFouGWjqlHm7+cK7B8?=
 =?us-ascii?Q?08a4UkORtta3yMdh84lSNaNnDoAKekLhjKeWp+fON2Owaqiu9u9qUFS86Sp3?=
 =?us-ascii?Q?Fs0UyHC5RD/e7iZjg7Zjdq7PqdXNwLNGAAzlAarpZatAm1+cZQDACXyMgKZN?=
 =?us-ascii?Q?JCgGLb7c1h1TdsmedCOW6IUSK7VWm6+BKCecV6Lr4CBGLLy1oi93pH3oatZM?=
 =?us-ascii?Q?tv84WbTVNfdAiU34XkLlWk2Ggx2Vw4UCQnoVrh0ToE6B0c1WtiRB5/A/BeO9?=
 =?us-ascii?Q?HiJTEv8wlURpVWCgnEIgaPL9F0q73nx9O+dN5CYSjcQ2WLTBtH/xiqpLgoaR?=
 =?us-ascii?Q?XosUqYHvrHTYAFlnPNTDXxGfL0KGD4LkcYOHofsejBl4Ub0dVo63OaKU4Ab7?=
 =?us-ascii?Q?GHrpcnzZEgzEh27QnHvu4PA0VpVJX1zOAzax33tso8TtgEPiAkrYOp0hkcXf?=
 =?us-ascii?Q?P00UhFLzB3HDkM0hnxOEN5wNQlGrpowGZh9/HJyPJA8/TZn8qq35mvewJ80O?=
 =?us-ascii?Q?GgzyEYP7IhE9psd5zim7n8ZSBeX4GOJktApNWhDb6/wb4vnKTAEa/H6ZQOpw?=
 =?us-ascii?Q?dM0FefJpbJWP4/EeyN4jm0CqRhMcZzbzrcwHQmuuf/LTOHWhSeLM9Q23JBvU?=
 =?us-ascii?Q?xUBgenI42hTDQWMnxPttn5+0jlax/8GuWjJCQNQs+8ev/8jcmrxIU91WhPk5?=
 =?us-ascii?Q?tv4ZHaIYhyGAerZaNfV4aulkWBPqV4i7Sz59z2ZXBb8M6oh27+9XSVDaQ23Q?=
 =?us-ascii?Q?oNZ3HYSY6J2esuoiPvSpmv22HRdXvz1TlAeCu/UDVTF3aprEiy85rRyOqggR?=
 =?us-ascii?Q?fRyl5UeXGO2xkmgtAvHZa2TfAXTz7cojS7JTwjdS4dmi02d3G6+OzJmKFK09?=
 =?us-ascii?Q?GZCJ3LML6OMGliHmUsJXKG5ocOT0jZ+itivC4N85?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c65e43-ed22-438a-3329-08da8013ecb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 05:47:08.9491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgGY/2cRFvWNN5kbFFCwnF0KmowETd7VjcOOud0GeJi8WkDtsyL+/huojHIc1e8Bk1hqcfvJFxKqZW0/KEPCAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4407
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrew Morton <akpm@linux-foundation.org>
> Sent: Wednesday, August 17, 2022 13:43
> To: Wang, Haiyue <haiyue.wang@intel.com>
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; david@redhat.com; a=
popple@nvidia.com;
> linmiaohe@huawei.com; Huang, Ying <ying.huang@intel.com>; songmuchun@byte=
dance.com;
> naoya.horiguchi@linux.dev; alex.sierra@amd.com; Heiko Carstens <hca@linux=
.ibm.com>; Vasily Gorbik
> <gor@linux.ibm.com>; Alexander Gordeev <agordeev@linux.ibm.com>; Christia=
n Borntraeger
> <borntraeger@linux.ibm.com>; Sven Schnelle <svens@linux.ibm.com>; Mike Kr=
avetz
> <mike.kravetz@oracle.com>
> Subject: Re: [PATCH v6 1/2] mm: migration: fix the FOLL_GET failure on fo=
llowing huge page
>=20
> On Wed, 17 Aug 2022 03:31:37 +0000 "Wang, Haiyue" <haiyue.wang@intel.com>=
 wrote:
>=20
> > > >  		}
> > >
> > > I would be better to fix this for real at those three client code sit=
es?
> >
> > Then 5.19 will break for a while to wait for the final BIG patch ?
>=20
> If that's the proposal then your [1/2] should have had a cc:stable and
> changelog words describing the plan for 6.0.
>=20
> But before we do that I'd like to see at least a prototype of the final
> fixes to s390 and hugetlb, so we can assess those as preferable for

Got it, make sense. ;-)

> backporting.  I don't think they'll be terribly intrusive or risky?

