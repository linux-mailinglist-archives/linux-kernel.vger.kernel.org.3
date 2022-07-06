Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C8B568BF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiGFO4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiGFO4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:56:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B553D58;
        Wed,  6 Jul 2022 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657119394; x=1688655394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XiI4XLPodIeQLjyeJmfeCKSvp+1wy1pO+mJsI6COatk=;
  b=DyVpJZhjcI61vCwoFEL3kQCaqHfWIs3qsVxeLRq93H6Yq/Howgbn5bNi
   DCDnD7NJejI0u8OYYIZI1/iZR70O4LG8y7TMKNeaIwScRynmVCM04ZBsn
   ezBAvj1YtdRP9DH1G/0DRelqe02hvGE/yNSK8YAgkdJ1/QY0OqyjEtp6b
   VrWrphf/KLYdB3hZhI9/FamNF8z/uXzIoK2Zutd9+1ouagrMLubrUhfwV
   jpIzBv4iWHmEw8xLkcCucP0f5TpSaByk8PtNNAAhyubwy9hq/drN4nFkS
   c8QCThSdUhUBTHimM1hQrY3EQ6CDsYJCgkTBcwoKvx0Grs9mIoNaUzaRa
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="283791964"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="283791964"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 07:56:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="593361673"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2022 07:56:33 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 07:56:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 07:56:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 07:56:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 07:56:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkTWKu4+8L3bGV7x+E9CVEG2AscLGZCt8AcbXa5zBzvW1vr8t2tPsesrQux0ZhjvLOv0nFkdLzDMb/Y8J6kWy18xxubdu8pDjCsVerybwHOxz5uUqwxyJmrolIWcqnf+YuwGfVgcJRIeU0UJSTcOjBNNLLnbiRRoMS19qUBeWS+YsT1n/DRkoAX57UysbriZGKsdUGYuLsX8sD48epzSrW1t8JdmqQaxpRs0TstSE7DHhOuOt+yiTAYVtgCKiwNttt9zxHuU5yxkbh5HLvPB61kyJlgkiq5fKUrrzK4dxm5T3AwoA0I0DOkG4i4kP6MCmIsKygB8i7Va6viTD+w1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiI4XLPodIeQLjyeJmfeCKSvp+1wy1pO+mJsI6COatk=;
 b=hkY+j57bcuCVcQiK9D7Un5igCwWMgeL76w2TV7cYTzTaBIzwlpyk1t3S/m1E/niRkWoYS6s4u6D5mbr45BJwHy5MhoclxkseL5V/zqI1BtOPPof3QVmDtp06eialvcpBu9c/WENvPFW4kMhxk+Sk8jx2i+teBx0hi5JmIirPOhboLT6X+DMrTIWB7BPCwzCLhh3OfQeN32Tz82odhOVzOiVknQqqj2bEw4en88PfXWjwNJ/Li/s7bXh4KQbrl0yI87fWuH38veoUf8Ev4+8y0ixNd+slrV0uIpJSrXde5IMXjChTOBUw39qtVqa3kIiUPUz9vX6xNEWjJQ2O5cdhiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18)
 by DM5PR11MB1483.namprd11.prod.outlook.com (2603:10b6:4:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Wed, 6 Jul 2022 14:56:30 +0000
Received: from SJ0PR11MB5816.namprd11.prod.outlook.com
 ([fe80::1488:f4c4:ce21:6dd5]) by SJ0PR11MB5816.namprd11.prod.outlook.com
 ([fe80::1488:f4c4:ce21:6dd5%3]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 14:56:30 +0000
From:   "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
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
Subject: RE: [PATCH v5 1/4] spi: dw: Fix IP-core versions macro
Thread-Topic: [PATCH v5 1/4] spi: dw: Fix IP-core versions macro
Thread-Index: AQHYkPCRGjq1VVmQwECShWCDCNojKK1xPWeAgAAwz9A=
Date:   Wed, 6 Jul 2022 14:56:30 +0000
Message-ID: <SJ0PR11MB5816A2F6C1F517E2E332778885809@SJ0PR11MB5816.namprd11.prod.outlook.com>
References: <20220706042039.5763-1-nandhini.srikandan@intel.com>
 <20220706042039.5763-2-nandhini.srikandan@intel.com>
 <YsV4yU42in8qqQrw@sirena.org.uk>
In-Reply-To: <YsV4yU42in8qqQrw@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9db4d5ab-e1c7-4616-5580-08da5f5fb5d3
x-ms-traffictypediagnostic: DM5PR11MB1483:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 42AE6QUjwVV1emrcVPVtLNzRlOp1k2WVads3F57dTx33xg4S+GoAoI06KDsdfbpBTmU2V6o/V3gmKxo45O2Tv0hyjJ8S6+eoBae0CUHVASq0/xxS+2eYisrntf9eQTPzuthZYwetRoDKVsiifQOzITEtkdAspvdcAvTsHM9VDe8vy0TdQQPRQlhX6DVBGV9AM/bJ399rO08//eY9jRTex5GjmBubj+bs7PoP6SEn07rrPLUvWWIVu2A8QeCCl1pyzDW+2dU4w1fi73ZXb/9l0O35ExOseIEezHZmavRYF6yIb7mfJMEoF4B2iesNUM7JhYGrlD+Scjk2JmH0YsnAVCz+iiwM9WacUc3CpZMhnLFkYhUDPa2ei43d/a4NkJEO/UtY5dtJ16y8igAovluAQVciUdphrpEdoJyuyVYwLjow30h44yr93mLHpIYxJGX7ooKN77qoKgP+UGszMxAa4zbX3YnfRlCOW0YP9w5a6y+tKF1zObqCPXh8fptMi9RQQAw+RfajguHmoYKknvn3ASyfUsEtxv9apLOiDh1BAxnSLomGoLsPxXtUTJio/D1w9cNh6l2irZry1sDY9rBXy8zrfICzovG8/ExER+kokzpwJ+/IyeddhTib75SxWn6jyCEVKem/JxXkh+z/5JAF0DotTWbrM/XiW2Lhz5BY9M7nAwPsmDpRdMHQAD9MdVUmdUMqM2O9HP1NH74IMcbCo7kvibc8HMBKs4Zaa8iu5P7s9I280iJAOFANZPa1Qrmu9ckmSF3QcU/hUNsD007/MUU5p6QA3ePB3L4wIlgS18wRDNsQVihvZD9kUeU9PssJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5816.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(396003)(366004)(39860400002)(346002)(8936002)(52536014)(38100700002)(478600001)(33656002)(76116006)(66946007)(4326008)(8676002)(9686003)(64756008)(66446008)(66476007)(66556008)(82960400001)(5660300002)(86362001)(71200400001)(122000001)(26005)(55016003)(186003)(53546011)(316002)(6916009)(7696005)(41300700001)(6506007)(83380400001)(2906002)(38070700005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FwZc/pEtnKY+ApGdiOiyNx7zS4tLYM3t7dZXPHNPyIxPXCVux+yDuibafY0r?=
 =?us-ascii?Q?PM7bfpOqz4LTafAxtCKCSOsz518eReUz9NSowo+n/TBl0t5Bi8Ifhy0zhO15?=
 =?us-ascii?Q?Onzu1BJnDTvVbbV9TzXS4CtMCJT5mBXsTBmFSfsRVLxw07qOpRt6h7f+UNUk?=
 =?us-ascii?Q?PdhQnXmhTiWBlT0DHDhKgOhdC6W+KMyC9zSqDgd4erQ4rwjZivfjJ/aHQYzz?=
 =?us-ascii?Q?nuxx8WmkbaTvbRqqY2MFxgoCBzVw8se6uAd+TFD3GhLgbT+x4uRiP7irbFog?=
 =?us-ascii?Q?g6cSZ93k2GceYFphF/lRvVuknpGggU6paL6SWqoVZn79RK/vUaPPZA2lTouc?=
 =?us-ascii?Q?9Cpd/wH9t71g6hJ/ssXqsOTs7NaqGPZ7ysXxpL7VH5oneajLPeJ3JP5fhSpA?=
 =?us-ascii?Q?pFRIAFNXCeAxleK2ZlbvA28EpHj5rONhH0NqA+eqKYIM8br5BiDmcVk3W5Qv?=
 =?us-ascii?Q?3I/hqwKoa4g5Dj0IE+/bmMOnN5Y2Y+sXvvhH4qchmmoVXammH23hZDWzsVRF?=
 =?us-ascii?Q?wJ7XJAiyiqgHJEqOKymu44vtWDpGpvmIJsHQIHXlovJPEbGBwufBuxOkk1Ei?=
 =?us-ascii?Q?rl9MRW5sqBYa1MYgHwIRI2viX/cGAHQA7r6R478Q7H3/qIXBekyOefZN5/ql?=
 =?us-ascii?Q?6FF2bEZl3QvHiRXg7ERcX/jRqca4LSEMTE24rRcMLp5pls0zoTWgvrfzbBG5?=
 =?us-ascii?Q?p/KET16oYlil2GI8osOBmowe7qaEjS7b8/mcvOM+4GVaAYz5fvaM3M1H578V?=
 =?us-ascii?Q?kHtqIHxSxDDUps4U22zUTrHLO26wVvxbirIDSL3bldoOia837RrCj9f5AKkz?=
 =?us-ascii?Q?vwf1yJTu5YGlPWewVI2GPverpA/BLtRM5QGN0nhl5GRwDtSgq8ik95w+oSXW?=
 =?us-ascii?Q?r8TJWTvdQRO7uhUrr8vxJeysjIurE4lnZAdhmXNnREw2R7zfSPRPVM7VOwMm?=
 =?us-ascii?Q?k2OggJyGudHL1s3toLCdbZFuGLxrxHw7dHWAmxwNEMscr9Tv6aGDJwO01Zzn?=
 =?us-ascii?Q?dhERP4qBVxgPsm0IUueZh1AfHE4oS69M+uwlndj8FERIxVhfxZnHA2EHtKYT?=
 =?us-ascii?Q?uyrqfnfdhDy4Sh7xcu1beAKMAfhQLqNx8qQa0gqSTRTA8TchY/I+TMFwNtDb?=
 =?us-ascii?Q?SFOJ2xsfW+4qOFz0U5HZjx5ASHMehM/V+K/PrNGH2CxL9G4upccPSQ0kYlCG?=
 =?us-ascii?Q?VsXGqazCqfIMaYLLJv9EzIL8rDVeOEps5twEjD9gpT4GE9S9+Bi3ZpSCxtCz?=
 =?us-ascii?Q?b87u/rYRlONVVdoumkCVl8VhkBg/pkSKVWsB8TrOhtoeaE0bP0UD+gQvZ2Wc?=
 =?us-ascii?Q?aZblk2+HIUGR/TfJ4TvJPdSdwOuHg7/RiuFyyQXU8XCmS6BIlUCU32ZZhwhy?=
 =?us-ascii?Q?y/zcyKiPmcn/KN97Z8sFEe3WJ+qRteowoqi/3v9Vg52lphdCy6MUrjeqy767?=
 =?us-ascii?Q?iTul3Te/w62Nt6DMcbZGnBb2LUcbZsLdUrkbT7+tT+ZN+9RgGHK6iFdMGYYK?=
 =?us-ascii?Q?8q5KmSJib0gJ53+zOMPD7n1x3/BICV0bjuyedS0d2JrklEpbbuyqFuj78OBG?=
 =?us-ascii?Q?sQAOpZRjYlOuAXH2PyKkzuK6TvBN92GyitLIxOEoVHEJlFcDWDvbdKBIeuYg?=
 =?us-ascii?Q?rQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5816.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db4d5ab-e1c7-4616-5580-08da5f5fb5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 14:56:30.3091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EWUtCUW2tJ1QW2OEXVU0gh0PyumGU5ejvxH5DE0BGzJu9gX7K0Pig7Ex9md85yz5/b83Zo0wFa0q8mHa3bxxyem6nNcVCXgAWZ60rs2LAvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1483
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



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, July 6, 2022 5:28 PM
> To: Srikandan, Nandhini <nandhini.srikandan@intel.com>
> Cc: fancer.lancer@gmail.com; robh+dt@kernel.org; linux-
> spi@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; mgross@linux.intel.com; Pan, Kris
> <kris.pan@intel.com>; Demakkanavar, Kenchappa
> <kenchappa.demakkanavar@intel.com>; Zhou, Furong
> <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> <mahesh.r.vaidya@intel.com>; A, Rashmi <rashmi.a@intel.com>
> Subject: Re: [PATCH v5 1/4] spi: dw: Fix IP-core versions macro
>=20
> On Wed, Jul 06, 2022 at 12:20:36PM +0800, nandhini.srikandan@intel.com
> wrote:
> > From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> >
> > Fixes: 2cc8d9227bbb ("spi: dw: Introduce Synopsys IP-core versions
> interface")
> > Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
>=20
> What is the problem and how does this patch fix it?
The macro was introduced by Serge Semin in the patch set (2cc8d9227bbb) but=
 it was unused.
It is used by one of the patches in the current patchset and without the fi=
x it leads to compilation error. I had included this in v4 and Serge Semin =
had asked me to add the "Fixes: 2cc8d9227bbb" tag and keep it at the top of=
 the series. So, I have kept it as first patch in this patchset series.=20

- Nandhini=20
