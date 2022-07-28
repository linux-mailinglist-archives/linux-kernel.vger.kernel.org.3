Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FE6583748
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiG1DHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbiG1DHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:07:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08BD5B7B7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658977618; x=1690513618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ii8Che1co717PO8dcd3SIGgzrQPTZTmTAl+Q8XfWFtk=;
  b=eB510rzDKd6nNbn2U2x9YgPoyrBqDh6kta1yaScmlyp1kX1fcVurfH+h
   sV745yd04cb2Ei/S1IghlEjI52INCaFLJ22v+g0uAjW1oq98+dW11JhsJ
   /Bmt3TFt03HMdcOJ+UnBHnx9W7d9RW10iWfVV5cwHRUpzUX36nnk6jM/y
   F3Y8H5WgSx/dkI/54hPrhrabwl2q+OLkJEb6Ajl+AXdjo0/UK7qnvkZ4/
   9jtLFwb3DfBVKi6es8GrFwU2PHMi4M/3eV7HWsYlyRXhpD/eXFRic/Iul
   aGN0GcjEdqcUc5s5lUFRJ3JO2HMnKydt1uLopNi5lhWyGI1q6EueljRXx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="352403247"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="352403247"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 20:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="604388062"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jul 2022 20:06:55 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 20:06:55 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 20:06:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 20:06:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 27 Jul 2022 20:06:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cG/A8OuoA0JVpxkr7cDLozcm/xmCnOXBaJSfr89VeP6MsZGkUl5XFM5P3yh5Erh9DogDGJyNPlFuXBd8CIWhC6YvoqS0pM/DcjwVRzbQkpe2R8nzkYH8C8JFWtIPtZB2aLKq6oNc5EWghlRXokQufRFNdnN91b0LtH+wpi4hfI12DJs35TwLfkSDb7ilKih64gZcYpSQn99in+1c6UBGXPaV3I14sw3TBtsn+6+TVO0c3+5Oey8P0isqMejRlQ+PlmJ+2B9Q7yKMD9DuOGcWQbK+nj+i0QGaK0HV78iGqOqSzT1znmv48oG6eZK5UX23+XEJgIQIDNT8ZrpkGWlatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saOjpPXrWdM8Zfh/ZPchMoCiqS/n1EN4XfWmC3S0i1o=;
 b=LuauxbC4uhAnYqL5Cx4dXlsnTjt8H2gvWrRfXdQpFgLfipMpMaeA8I1CzSZj1/+U46xppyKPwl7Tm8ab8USIRrCgCz2Wfj23ZsGa+Li6Lrsq8XI6e/laioi0RlgHXvYKuOhot61LXyRMhjfEzviC6rn/TjxxTmfIKGJKdR6+ex5O8u+zc+KmfFfvTzv21S07Buh4Sa6f1lLrZ04D32OXsgnuDXPuNHpMZ4mPGNJmRKJ2Npl3MG30dgUnsbcmy+T9bYOLpm9lEkeGBM0bJWqptDiW4EIr/s8Yur/eG50m0ghWr47sy1kULfFVHwLMaULjsndA1XMT8ylTGQGQ+rR1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL0PR11MB3315.namprd11.prod.outlook.com (2603:10b6:208:6c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 03:06:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 03:06:47 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Thread-Topic: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Thread-Index: AQHYkC3GvF//WyZOvUaTLdl04LC2Cq2MG8sAgAEavgCAAhH3gIABB5EAgAB+1ACAANqooIAAlRyAgAD5zPA=
Date:   Thu, 28 Jul 2022 03:06:47 +0000
Message-ID: <BN9PR11MB52766C3D37FA985DEBDC30C78C969@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
 <BN9PR11MB5276974ABA5981A7361953708C979@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220727115339.GM4438@nvidia.com>
In-Reply-To: <20220727115339.GM4438@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c75f3671-84a9-4cf7-6b33-08da70463582
x-ms-traffictypediagnostic: BL0PR11MB3315:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9mDJyuAf5J++vrm74jlyczYUMhiMwnMn4vmmCtxEBIHxDE4wT9sSQ/VEneqoigupKFczRvFCCPs1h2LJ8xjQt/7ZJ6SJjMrQnqZzKrjpH6GZYFht4TQDrjjCAKB08SRQHYHj4NrkdHBV70+RMFVUfgWa7j0m+NMaBdDwghn84v3br1AqxLSuJv3kj00IdpA+cY5FPo4KIwMKdUCJuSl+nUOelLvt4AVlqvyy2nmsUvvxiQowXbfmLHnwsUuztdiuowZuoL2yAIMOUCYbYI7PE+Y1lhqPreR6FGoWXLmLyQSyP2IIXI7PZU6/PfCTaSc8/l1SggEUj5IfQ0gpJFos5sO4YcJCyXn6Cg/YT5LRugNx47Ytdy9levpz5rm1vBifjwUhokFS1B+SOJEngB823txbvTfslpqtXCtiV4OUYC3D+O+YpLUAK6G23v8/v3CZ0ppFxf7PxF5WW8ifv+Ck8ALN/kNlYOXhp3EPQuOgdmFRFE23klSbXYu6VUs3rXuMj8lA0KeO9tYvkqK3f5tlWMvLtl+miU9isd5dMJm+UCi2P4NfpcKYJ99ryIv/Wc2ov3trR4MRzJtzT7wWJZUaC9oZIk0hXpJJZK16gDEU5sKTnWoG9yIti+pNAXpnMivI8oaW7XlTsQgxSCh8ar7TfLnzAAd8+JQ1C+/xOvqMUAmPmti3x7gVof5NxJO8zuIz+x3jbd+JYnxSHU3Cl7wvLY5AY5pHpVYxf4Djm0rKPwUy4EKwoIsvTO74TW8lhSU8l85Vd3yy/KbUiQmajquuL2bAhbfjM8CIU9aiI6jHj8IGDz5meJolsY2787eyxwn2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(376002)(39860400002)(136003)(122000001)(5660300002)(38100700002)(41300700001)(38070700005)(52536014)(7416002)(8936002)(71200400001)(478600001)(66946007)(66476007)(66556008)(76116006)(4326008)(64756008)(83380400001)(66446008)(8676002)(316002)(82960400001)(53546011)(7696005)(6506007)(6916009)(54906003)(186003)(9686003)(26005)(86362001)(2906002)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c3vAGjOVXK0XjIx1t4JTCIOjN9jQDRR6DfdI39/oPSo5+/KJwBT8PHXFVnqB?=
 =?us-ascii?Q?RGgwUbpPkBUuXDlDjvek9nQnL8xICIDVosPJvbx31R8B/nnbwKg8W4AetepM?=
 =?us-ascii?Q?VcBYeVx1pzIb5c4leDHhFBCZsOQDsSrNMcyLn46hUxi0J7nj0uxbk1lhfsQE?=
 =?us-ascii?Q?wQ277rO/M4mCWd6KOOCQj1qJivx8LxdEd9gnkV+4zaG2/hKeS1X7zq7ufQPb?=
 =?us-ascii?Q?sPSX0HXquvpzdktQ6m98LPVC57TaJNcpxUgYP1FLqIN5k1z3ZM0WLbDOvrH3?=
 =?us-ascii?Q?7pNu1kqRy7pM9tgW63/82ftMMGo2tuZKdQIPgvFcB5gAsWGbFNh+tJ1RQKEk?=
 =?us-ascii?Q?bbV/9MJUTPifPjwdokEdQGTtlPpcJjGCo7EGJOiRAaeIDcRFfSFxKokDl/iv?=
 =?us-ascii?Q?l+s1dQT7TXqDEsO7L+TNpfxmjvTZ3PEiyQx8zYrd9cMO+Jt2inc052jNXomR?=
 =?us-ascii?Q?n9bEJj9fsXEK9f86GW/jG4MVzeOkfm/wyVIUfezJSNbr1IsXLdzz4tCHuBi/?=
 =?us-ascii?Q?xaPc02G9PfwE1ew0ENwiI0k0VMFyituNZtOlkCowKrs7UZgkS7+XH7YkFmsA?=
 =?us-ascii?Q?4/yfoF4dt7j+8BfBLejH3xK0N7vwd9g63BYqlKA9M0wBIulwerDWxZQwInHp?=
 =?us-ascii?Q?pA4nbBDppUzz1PTuPztmAlaSxOAOCUCLn578mvAzL0MGkNIGXTVk9Q2oDqla?=
 =?us-ascii?Q?THFXgqZCeOimGL4KIvxt/LwESR6K/WSc4HTQo091sVVeO5ouq4+9aqexGy8r?=
 =?us-ascii?Q?brBehSG9R5kaZRe2L+hZZFxHhE2QFjZ7d4sYVkNoQpGzU/GUFqhSpe+/HAiQ?=
 =?us-ascii?Q?erbgSICbr28azPw6vZaN7YnyZZF51E8i+tTS3b9SiBdRDu/KFQLUHmTirIlJ?=
 =?us-ascii?Q?yoY/Yz0M9fWYv29w/TL9BLug1Z6bWduGr+HLTCRMD+i4kvBVOkjv9+sel5oe?=
 =?us-ascii?Q?Oihaf+wP6PANjdiKHYtWPDXOoiYjgbkgmB9xK1fscwtMn66EMBea6HMzRI7N?=
 =?us-ascii?Q?MpdjZ4U9PHtv3fHKsJBgmuhyf0HCmktWRGScSp59dp0pk448fyvpj1F0rHPl?=
 =?us-ascii?Q?mmtFLKFAs0G3o0HjsncpBerayJrA8ZCBDQztMBCHjeHjrEYvfwb3s44ARj4t?=
 =?us-ascii?Q?NCeizJfn7mEYsJj5Y78gGNGb45svXwQN106+/LNCQ5SaG1eQ3zKMu+8LEbWh?=
 =?us-ascii?Q?iGYExfWtfxerfcIxYTpYM6JXbLZMWcC90HhIeVasYTAWyry6UWYs2Y/ABJI1?=
 =?us-ascii?Q?IqmtlwdC67YZJIv1HU341mqtoeKejqi2vd0vNoErDZrxC3h0uWl156wh+dHQ?=
 =?us-ascii?Q?V8YXjy0wcb3ml9M0cA53I4oW9BAWw0X55FaXg98YvH3ogL8kl1DfT6jNBc9I?=
 =?us-ascii?Q?kZRsGfyoitxjACvXw/rAlrrV8VrI9JoH+wbFNRK79elzoAHWCZEl71QPKTW7?=
 =?us-ascii?Q?AJr0HyU3OkrGFoYFi5NGxgsX7WOBpL1Vi9x3U6OrFlqgmDHYY87dpaTkYwR/?=
 =?us-ascii?Q?pzvRzaaAQyNEti6EZYoKafclpWg+ukIhmrpjCIU02E+7dnA4bBVw0gPejXeb?=
 =?us-ascii?Q?N14/2rQi7Ks8Gg4EDIjawoPWHiAIkw5Q7AyEWRsp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75f3671-84a9-4cf7-6b33-08da70463582
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 03:06:47.3795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcpuqboWUUW78uZIyx730rx4cS4xu2aUwQ7jj16wDqQ+vdPIMW/aDW+5edc9/jFIJtUX7ag4p/05IEwrI3crkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3315
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, July 27, 2022 7:54 PM
>=20
> On Wed, Jul 27, 2022 at 03:20:25AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, July 26, 2022 9:57 PM
> > >
> > > On Tue, Jul 26, 2022 at 02:23:26PM +0800, Baolu Lu wrote:
> > > > On 2022/7/25 22:40, Jason Gunthorpe wrote:
> > > > > On Sun, Jul 24, 2022 at 03:03:16PM +0800, Baolu Lu wrote:
> > > > >
> > > > +	 * Block PASID attachment in all cases where the PCI fabric is
> > > > +	 * routing based on address. ACS disables it.
> > > > +	 */
> > > > +	if (dev_is_pci(dev) &&
> > > > +	    !pci_acs_path_enabled(to_pci_dev(dev), NULL, REQ_ACS_FLAGS))
> > > > +		return -ENODEV;
> > >
> > > I would probably still put this in a function just to be clear, and
> > > probably even a PCI layer funcion 'pci_is_pasid_supported' that
> > > clearly indicates that the fabric path can route a PASID packet
> > > without mis-routing it.
> >
> > But there is no single line in above check related to PASID...
>=20
> The question to answer here is if the device/fabric supports PASID,
> and on PCI that requires ACS on any switches. IMHO that is a PCI layer
> question and perhaps we shouldn't even succeed pci_enable_pasid() if
> ACS isn't on.

Yes, this sounds a better approach than inventing another function
for iommu core to check.

>=20
> Then we don't need this weirdo check in the core iommu code at all.
>=20

and then we could also move group->pasid_array to device->pasid_array
with this approach. Though the end result doesn't change i.e. still only
the singleton group can enable pasid the iommu core can just stick to
the device manner now.
