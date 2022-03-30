Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5434EC656
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346703AbiC3OUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241633AbiC3OUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:20:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0A0B7C62
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648649930; x=1680185930;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3dG3ruhfTxuCg6tsSftFqJsbwEuvatX41R6BYMQm9+c=;
  b=K2dRyKWpxZvnamNHDLqz/FFr1aYshTs/otzVRmw8JJbzAjStSjdSVAt7
   idRPPMooLno1d44oCRX90phua4ZT/7FOy+jDBRV6HvROQ43+64K1iaWxZ
   3ZWLx+VuTZKOLmVEeAvJAq9QKY0z1+GwRLF0rt52INW4CwxVxGfPM29Ki
   S2Su4Ipj6FhFbry6hrkCjHorW0+R3pWCCwMHrrdLLLNl1z3Y6GGHzMAfa
   hwB5fvK+ysWrdKNNtCBgYzgrhCDa2GZ2EuE1iedJOVDSJdVjm7oiEp8N/
   JK4m8ussq+bQsavQcdueblXvBxn2Y8hXdlNuVravaXdBiK9DTz9i8Q96u
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="258384079"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="258384079"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:18:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="695114497"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 30 Mar 2022 07:18:50 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 07:18:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 30 Mar 2022 07:18:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 30 Mar 2022 07:18:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7Su9VhELiwtpx/9tB6W8Kk9k+EeknWeMeIoYbUlQ1xnK6r9HcANpxwiVybYYLsRvw+bdRApUXdM+lrZVWmta1OBxBlHhxop+d50bzzH8V0fyD/c9M2/N9OA6Cn1Wlg3V0K2rf+i2RI3SGBbpT+ApEF1xEFom8i4u28cOelNPgDrB1aKRuwjf601aCDAXVAoswI+Tnlr841MW03TVLrGXu6GJu5QORvm41W6l5ul5gVL6YXbAX34yOW2o6I4vyc861OC6cltZvLTM4XX5s8aEvKTXO67XheQqV+TDmViByk8Qox7RZ6xXHJLKQWqpEjJ4OPecXJLP1mvzYm/8UTpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dG3ruhfTxuCg6tsSftFqJsbwEuvatX41R6BYMQm9+c=;
 b=YifwBAYuggHdrHvU0t7tLGf3g8T7T2xtrBlzTu81Om0xbHOoGhLhMjix63qsKM7hBmsutTclyvjQRVZtByImStVasUzKmrf4y6+B4e1IEd9J30mrQXkJGBzFMCZqpzVAzrgNYpXtsA0BaWMet7A+Hj4wJcfD+xxGlHaFsC3TSm3whIQAB1xvWx9e0hofhFamR7wIP9ochM+QIEaO8RTzz1XiNJLYzSyH2OL/wYZIdbgUL/TKQ0Jc/UM1gvSc1AZVvrLo9/xGOAeYkQZDCtlKaRp6EmX12jQrkjU1nHmj2IwYKKDbRfphk0zHnFUh/Yhv7ujAbkcufNGMh9bqxCrskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB5778.namprd11.prod.outlook.com (2603:10b6:806:231::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 30 Mar
 2022 14:18:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 14:18:47 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Alex Williamson (alex.williamson@redhat.com)" 
        <alex.williamson@redhat.com>
Subject: RE: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Topic: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Index: AQHYQy+FyOvFomDYNUS+m4eyrODKe6zWBZTwgAA4VICAASjOcIAAbdAAgAAjg7CAAAOWoA==
Date:   Wed, 30 Mar 2022 14:18:47 +0000
Message-ID: <BN9PR11MB52766A3E3BC82EEF437258198C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5ac878b-52f1-4aa8-db51-08da12583482
x-ms-traffictypediagnostic: SA1PR11MB5778:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SA1PR11MB5778D649EA46AA87AD7E44E38C1F9@SA1PR11MB5778.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gnAPQS7t8BffAUnVab/skLQB06lhjzPTcSALQ3eZBdv/FUbrTmN+nSwIcwidp+K0IUKsrzU59oS0n0SyhpV8LbLM5D5X/k2WIyQtPUuBgjNVusqIM4FpDYCr1fepYujktmxbTh+f9ALgGmetnrcZkWhNS1qsaSCfKasOglEa7acU2YgSxfr5/INwgoW3P3vb7I8Cmyxta/kGDGmcZvxbpbF8SE1k7DUF0AQTW9BuHHE2wJUwUhs4wkHXZ/8Fc6+1kX/IplPqxh0DD68s5E8qUgDJWKCIf9vnH0ks9/3dKdmLVrfoAv4Wk3jVf0xNvihVK/z/ikp9F2RbbhO2k0EHrhTpJ8S4JSBrWuJ3EcI/3DBnywbW+bgq7AFlHMFE5RjKZwMzQyzwv4zFgMjTTOfovHTttZkDbALuZqlA5umYpYDhCGDNmSuWLHyfxXyp/+oBufU06BvZnGAA1gsPkNdgY4TD52YWcEctGMjDBczgFaxyO9JORBC9hVvurQT2lqV9b49Q63xbQXdDXFpEAfkEjlzDcIufGzdfDYEePEpK0t6htKIaTnppP0d+RZfiNb4gbFI1hFl/hJZ4jkNEjgos39w+hnU3mGG2w9MypaQ/X89ZmIz/kIqIyBO0GOxoV2BM6ogK6W9Tj1D0YaGvZb5j0aW5nV36pLePsCwnBWIqPCZznTk2/foCMk4DKBQJzjFW3t/jNiiUCZQlqUOHb7LLZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(33656002)(122000001)(26005)(66946007)(186003)(66556008)(66476007)(66446008)(55016003)(64756008)(8676002)(4326008)(2906002)(5660300002)(86362001)(76116006)(83380400001)(52536014)(71200400001)(38100700002)(508600001)(9686003)(7696005)(6506007)(8936002)(54906003)(6916009)(82960400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ghM4VdpyMEDXXudOX4T5ELiEHyAVTTeSRC3SpFoOGxeweSQ+zmiKboPfSO5C?=
 =?us-ascii?Q?sB96kXK9afDWjMLzpq3laMICTbrYokL39QGpUk+VTsFa5n2AqGEKZt1oBz7G?=
 =?us-ascii?Q?977ZqvJ/TLiKZzYu5tu8sYYSifzEAwalt7gic/Wg1e3odmHgmJ313hb6hDm7?=
 =?us-ascii?Q?hN6dyFLc4jAMCIB9VrSzSWqcM3eNNoHMtsG6jFXlPiCh+9S1hqkI5UpnnlFQ?=
 =?us-ascii?Q?rTmZerikE2ZPf5SI0061VGV0XM4fRqcoVXf3XM7GkBsLjuWZvO1TH/X7wOvT?=
 =?us-ascii?Q?UmP5ix9sWEPkxxg/VSzmSw1tWyfsBxIVRJmKDJysQrNz7Yw1VE/s03pLyc+r?=
 =?us-ascii?Q?6ngtSCwa/oh3z64V0CRq9ttZz2DF/3+aPQZvw7OoNXbCsmaR/xfkld1ehgv/?=
 =?us-ascii?Q?/O84AEI9wInRz6RK3ssQCHubnzaLGfHtSca97Udqvq8xmumWVqRdbcp6kiKR?=
 =?us-ascii?Q?SAcxRcxZhxktBsqu/2FGhdn470UA81TMBMBSD0p7MefNMEO/5HGq9P+xuLJJ?=
 =?us-ascii?Q?6/DYkad9zC1v/g/n+XcjXufzvT8GClmg58JOIvbXTjWxVn+LxATav31llAa5?=
 =?us-ascii?Q?hcMSmxxJLfiRuiBRFzIiuKc5UWgsuOwkH6l7OHUR55orukxCTEEB/bHoGGox?=
 =?us-ascii?Q?KS32LgEsrDxQQYlx4Exv1esevq46+UFOKHQNlGKEhz3ZfWX7SAxx3budRNFq?=
 =?us-ascii?Q?VfKcqIehn22C1g0mavg6TWaOT85g/AqTWQ4t/wbDjjB8ZmdcWC/UDT8/dWI4?=
 =?us-ascii?Q?Nv+ZRCJtG7HZAj42T6PRBpzdgmPjuvBkkUTECZKc/jS+MAANbg/wqW2QkFDh?=
 =?us-ascii?Q?2lTdcxdkKYiKzCOPlTi7WqGocTgNKvvHdafhWY5lxROsD8uIQ/VTGaQHhLnq?=
 =?us-ascii?Q?A+Et6f5hTXGip0WJzkug5aabkPABTrei6HshNSOI0jQFWikE3mUh9u+HEeCh?=
 =?us-ascii?Q?CoBeoGd1NS+B59y3FrF0YgRMOb+DR5n0CiMYAY1l2Ol6H17QxBOZtf41ZRcn?=
 =?us-ascii?Q?hURmUcMtQiBug46WMOY9wXLh1WTLJeAWRRlbDdUEazNXCoPo33a65c835Gei?=
 =?us-ascii?Q?WVKYvs07AqJZ5uE+YhmCH0Tn1gviT3g4ujFmdq6SUv4hDz9ndzw4sPhJ1qo/?=
 =?us-ascii?Q?n9xWTYgoUFomHpXfq3TPHgO1S5XsDwlQx1OMVukr6CrDO5q2/FuiU3PLEcNv?=
 =?us-ascii?Q?qod2+jwgp9VXWHwFLmJ5XMHIp1gNWG2PW+qZL+zyE3C4GODxEwncd87RnnA4?=
 =?us-ascii?Q?LnALkZJgJ9eqSfebM2biKxZERep7R0NGP1HB2m/CXxhZW5KulW/MnFL0Y4K8?=
 =?us-ascii?Q?x51WUZbBqY5G1qcRLJHJfGLu2/aC1WqxLqaKT+vYTzy7VujD+48ePLrN/Q46?=
 =?us-ascii?Q?DgJdi3F51Putswoy+LDb+urBnVEdPUjGaqQHKa9q5ELR9SRqn+8dBJK2T+g8?=
 =?us-ascii?Q?aDaynYfq5RYwpGi3TMlPjkP2goPdSowI6S68/kVTyqLdtfmQAqY0WdDtdlwU?=
 =?us-ascii?Q?Q4RN3e2tQeFf8OYJPfMMlWF4Rcb0EHQo4nzOk4hlKaep4oQfQs5v+RE4a6Am?=
 =?us-ascii?Q?MC9PYH84vOgMUiE3zdJ0jQHVH5EZAqnXr/iJXTYUkqE8qscTn6jXswJP/sZZ?=
 =?us-ascii?Q?de7IhhfiuL2wUPs9a0gKJmU6UVZChAf2k+hGQZcydqMDhvpPnpq07ndrQgk7?=
 =?us-ascii?Q?EGhDDAwwAMxCK0uMOz5IkNOmXqyn3vL6TuWF5LIY8FW1jcga+7t2GzxYwhFX?=
 =?us-ascii?Q?TmKzWxfmtg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ac878b-52f1-4aa8-db51-08da12583482
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 14:18:47.2353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vffY+waatIq/g6UhYn8LLvYaCKAaTrJUGkMe6A5kZSbJ28XjiFbwBPVfbfH/CT/qrvvHVxvY+rlfhFzBnMrYSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5778
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

+Alex

> From: Tian, Kevin
> Sent: Wednesday, March 30, 2022 10:13 PM
>=20
> > From: Jason Gunthorpe
> > Sent: Wednesday, March 30, 2022 7:58 PM
> >
> > On Wed, Mar 30, 2022 at 06:50:11AM +0000, Tian, Kevin wrote:
> >
> > > One thing that I'm not very sure is about DMA alias. Even when physic=
ally
> > > there is only a single device within the group the aliasing could lea=
d
> > > to multiple RIDs in the group making it non-singleton. But probably w=
e
> > > don't need support SVA on such device until a real demand comes?
> >
> > How can we have multiple RIDs in the same group and have only one
> > device in the group?
>=20
> Alex may help throw some insight here. Per what I read from the code
> looks like certain device can generate traffic with multiple RIDs.
>=20
> >
> > > > ie if we have a singleton group that doesn't have ACS and someone
> > > > hotplugs in another device on a bridge, then our SVA is completely
> > > > broken and we get data corruption.
> > >
> > > Can we capture that in iommu_probe_device() when identifying
> > > the group which the probed device will be added to has already been
> > > locked down for SVA? i.e. make iommu_group_singleton_lockdown()
> > > in this patch to lock down the fact of singleton group instead of
> > > the fact of singleton driver...
> >
> > No, that is backwards
> >
> > > > Testing the group size is inherently the wrong test to make.
> > >
> > > What is your suggestion then?
> >
> > Add a flag to the group that positively indicates the group can never
> > have more than one member, even after hot plug. eg because it is
> > impossible due to ACS, or lack of bridges, and so on.
> >
>=20
> OK, I see your point. It essentially refers to a singleton group which
> is immutable to hotplug.
>=20
> Thanks
> Kevin
