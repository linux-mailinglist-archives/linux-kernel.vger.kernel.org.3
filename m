Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B5D4ED52A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiCaIGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiCaIF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:05:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5D613DE4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648713848; x=1680249848;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4FaiLM7JjYK+VCWPDM+/bjLaQMfpnR1JvwPA5Mi42pU=;
  b=NxcflbbZnEiGWOyC5Q7+qiBlWn6rOgYONW+1UQ9TThlhgUEpe90QOcba
   W2j1GhMBNNdD/Rxhm2vnDAoSduAkHQ7zh+5GN3HhcFrcA1R+RMl9RYapv
   DV00cvBfm80TL3GRX4OTCAksQqn+7QlDg3/OyZVKfLimTgkcOKDAw7yBB
   BKryCvC85i5eyiGN4Yb4Sg2pLo6niBQ6BeF+O5MFC/G7NdgaD1YN8y2i+
   rMhci6exnZ+LjHusixjDQNHGMQFxKkHXfTszJtdAwSeIpy6JKwN7QijFU
   Mnin8KlDKbyDSnpCi/N1m6EmBRaKKREXA+tmOCDO0aVpWu+fG4/zoDRV8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259726809"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="259726809"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 01:04:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="554982081"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 31 Mar 2022 01:04:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 31 Mar 2022 01:04:06 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 31 Mar 2022 01:04:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 31 Mar 2022 01:04:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 31 Mar 2022 01:04:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEpxhi4ASmdfMfsE6WBXU+N/9EqYpP4eHrgo/hQlqOAh85IIj4BW43hUcqs/ptYI3nPSPzF0NgRRIwAGruaOZWMMOUiXuzcFYO+XdgBtW+oD818dRmScQxVru+36eyD5f6yywLzfrNk9x95qhZG77AHsEcM4vqWH7p1fEic/K783cPju1w/98cddWSubV2aEBdlCzBhSkWv9NUszUIsj74nUVns+OdDqvje5UMKM2NVVkelep2VT0Wtw2RCGU+BmWeu/vZBoeUEarLdox3gC0N5Qbb6lT0UCGTZq3OB9XGVHw0LCL418LidDnNaAw89WQjqJ+hIu7TU673os6wnNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFQTq8A1hTz/T3czlNqSfmQGnSC6q48DuiQ25847ekU=;
 b=bGYeeyRxaQAoc2wGw/K3Dq7Mzxs5dgE8Y2roU54wOJybbaaMQWocCnzFTs0TEDwThzA+8zTKGfLZ4i9tYAj6GBSGp/Tt2K7kMwo+9ExkTirzfniqHVvn3caMEXs/PeoKLWPNgBru9VKKCxDaT6nwvgpVrw3Oedcu3WkNQLkYy3QyXdUKBrJwaf54CrjYZy9RUCO6CF6ieDyRNNzFZXVXhey153MVEuyM7LdzP6F9dNmJoVLe/5t3GAX9JNAWZdSHPLrhDah+CV0m20E/fXWgZio8V575BQ34PRFsJsSYyzfFk9+3DjciewVXNpjrrOKejhYQqR/PkL2wua1tuHyg5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5549.namprd11.prod.outlook.com (2603:10b6:5:388::7) by
 DM6PR11MB3754.namprd11.prod.outlook.com (2603:10b6:5:146::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.21; Thu, 31 Mar 2022 08:04:04 +0000
Received: from DM4PR11MB5549.namprd11.prod.outlook.com
 ([fe80::6807:ff2e:9ac6:4d3c]) by DM4PR11MB5549.namprd11.prod.outlook.com
 ([fe80::6807:ff2e:9ac6:4d3c%5]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 08:04:04 +0000
From:   "Wang, Zhi A" <zhi.a.wang@intel.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Zhi Wang <zhi.wang.linux@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        Zhi Wang <zhi.a.wang@gmail.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v7 1/3] i915/gvt: Separate the MMIO tracking table from
 GVT-g
Thread-Topic: [PATCH v7 1/3] i915/gvt: Separate the MMIO tracking table from
 GVT-g
Thread-Index: AQHYQHGFbzTs9dpVNkulZ3C9zD1FsKzUXz0AgAS82gCAAAjAgIAABgwA
Date:   Thu, 31 Mar 2022 08:04:04 +0000
Message-ID: <d6345ebf-ccb1-9cb7-c154-a5e011c62cbe@intel.com>
References: <20220325175251.167164-1-zhi.a.wang@intel.com>
 <20220328065008.GA29798@lst.de>
 <4af59d97-b583-4022-3ec3-360e7df43689@intel.com>
 <20220331074225.GA21004@lst.de>
In-Reply-To: <20220331074225.GA21004@lst.de>
Accept-Language: en-FI, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a01be9a-1730-4b82-0a62-08da12ed0644
x-ms-traffictypediagnostic: DM6PR11MB3754:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB37546A421CF104A7630A0C62CAE19@DM6PR11MB3754.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0hK3tMOlthryaT05JB7ZqqX+XsGt9SHcWYUpIzsJ9aOuZIhVg2n+A5Ff2+mDFnx7KVhqCt5p6o2z1OR6uMsDNVVVeY/dhVREp3yh9lu1KOW7ehYlIExAh2HCgTAJS9lzQ37gDRe7ikzsT2e+sZ/XbEJbp9imxQpJENPqqIAE4WoM9/YnVXZ3+nxR5fuDv5ViojFX+ZR0+1UYHFud91/Psdld0Zotbrjli162nCMt/je1nQv3buQngEP/YPA+WSeCugj3V5AYzrKdvUzzpikUsDbBfYm8GinunKEyuqNaI4jUSOFgejKtqfNxeuR1we+Cyf73LzA+KqpbkPS2peZtvFehvcdIDNFN08szSy8yRouO0lLB9Zmmu4xKfg+NY90knvSjcUmxmn38b4ZM0ZYYgkSU3K598giReYuilLl5v1N1jJW5OzRr+AQ7YLeC3VusQBS48bd1zi2iH5I3ok24qUAAYOwTV+n5KLtjl1W/ZNFDsZ9VZeC7mmoUCMAVryg1FXhHS/Vwumg/wcxSRgWeWaJEEmaplwgBx7GshcX7g6jJwy6/xwqahl5L1aQVGtqkujn51ppdcXBZfbChGbMF+bQpY5gLA6gA9ax6PXq1KFpnz/hbicBd10DLwI783w7NwYg6aQ/td4dRT8YlGw7ODRXF/dwyWEiY4TNcQnRIfMegRlYZDLfPMqC9iFfhQItr34t7lSagC2A70ISqaCXr+eGpxG1iwbyV9srpvemwGSp2szfAEHnpSPZBWMy65PhILSlPtQrYqwIF1a2aVaX7vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5549.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(4744005)(7416002)(38100700002)(5660300002)(122000001)(71200400001)(31696002)(86362001)(508600001)(38070700005)(53546011)(6486002)(6512007)(6506007)(2906002)(82960400001)(8676002)(4326008)(91956017)(66556008)(66476007)(66446008)(64756008)(76116006)(66946007)(26005)(2616005)(186003)(316002)(83380400001)(6916009)(54906003)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?wQL7am/W/C5cQ6uj/nTf8xPxPdNM8xIfQZhACFbonBA9S7gDj6x3aqR6?=
 =?Windows-1252?Q?615gkRCbnzZMrsxZl8PIZse626pE2q5NmDq5VMZI/dLynKwBHh/+c3u5?=
 =?Windows-1252?Q?luFQFCXTa1Ii0xL/TXTEMMB383xLpR4R+I2m5YMCFG7UNkBQifhAblK3?=
 =?Windows-1252?Q?JZ2uzV9OAomn9kTcVQspBfW+2Cg2xfdS97k2p6VujSfsdnohGheDO6cj?=
 =?Windows-1252?Q?pMsjLAviuKG2/p3ECp2ncFq+DLRr8/V1X9FTp100RDz1ByvHFZ01wPQM?=
 =?Windows-1252?Q?abVEoNSxiEQqWtgRfLl8RtJXXzqwdlRHxe6hKQnFYSYIm4FoCBqSZjOk?=
 =?Windows-1252?Q?tQLAbLJT2rvpPKNwct+11tELlPHZaM4B7HsnIb4HIof3RFmxtG/VSiwK?=
 =?Windows-1252?Q?/r6YMmK0Zab9G1pFrb28LxnopUXF2K6pjtVus4JJYJSrC4kCpeI8T8a3?=
 =?Windows-1252?Q?Sqg2ULUBp3Zgc/RoC3CrVtq1iaO2s1xUCzl8An2cIKUSXBn5b8XST1I/?=
 =?Windows-1252?Q?nWZtsdVE5Mr3Y9zlbInWEb0b4Sa4OoKV40CMbTG6JY54jGddsh3Rmkzu?=
 =?Windows-1252?Q?m1GKG4eohwE/tc0gjW4c05Zpkpqx2nTAouAjh5xGRzfwNqMojJtnwBci?=
 =?Windows-1252?Q?JobytGP7eIuDQyXjAcqGzO4W9wdG/0fPn8lucIN5awu4QqSmI2E4zf4M?=
 =?Windows-1252?Q?Tj+9r3sGeZgb/TaaVxk1Ezs5Blml+jD8mbphGboQdSMrWVY7CPQEgFPz?=
 =?Windows-1252?Q?C4igAE5Lyabf0btGsX+YIzuoo9HfHHzeQJMmYHzzPag8HucWSp5bkrb+?=
 =?Windows-1252?Q?HietTNFXOwub7ltsSSiy8kZzlIWxJd6vduIyplyW5bW99MCvEFOUikxH?=
 =?Windows-1252?Q?T02k8S/2FFeZmgFDtbue81ltyGdybbsVSmCS/MSf7JYYK7t2Bk87QOoh?=
 =?Windows-1252?Q?nAVgASJF6PQnoAyQdJZ17zo0AwkxoMfSH2/HBgOekpRkDkXIc3+P7t5b?=
 =?Windows-1252?Q?5MyOyclUiAq9XlNelvIErf5Ch1NBHAv1r7+rx1Qasz7ZmghSlLVa55dJ?=
 =?Windows-1252?Q?jyeSjQgcHCL0eoPuZCBCCqaaE/6T2g0EOA9y8B9RLbn3k/gfY44+QtYY?=
 =?Windows-1252?Q?cWVhkFOaqtK9/8HTtSpwsS75OHr9wpRCHkt4LieeBXqWytJJp/WunY/H?=
 =?Windows-1252?Q?KuCYBdJLzkbgePsopyjh/SIotU7R2Q/rljB96NYEbBpuzMSYlCE9eu/Y?=
 =?Windows-1252?Q?XjkuuTBh3HRslXI5QFqgSHLMzI917ID/A7odgmuytL4C2TIdfmFjDDNN?=
 =?Windows-1252?Q?sCxa2eR3wstqyO77Ya7FQcI8HLcRoJ8o8Dv48L2GQrBLyIKF3dIhJkXh?=
 =?Windows-1252?Q?/+KB9TAhAzoguxpparn2HhqEyLFWBViP54ZG3nsHelYupHOIv2GbBEJc?=
 =?Windows-1252?Q?nMi21big92JoXfG3fKM4AoKfnKMIDq/8Op+egSdKvt9iZN4GD21WgIKL?=
 =?Windows-1252?Q?elPDixb3fgrtBvu9iCFBEuWPN/AkZQBJh45uuFKQTbwJK34YQMKRtXz5?=
 =?Windows-1252?Q?FmLjpcG2NttjZWoGBtyCgtamYIirkXqchGPB4wdrvFtX3cLsvcGXvhD5?=
 =?Windows-1252?Q?w9KVKkPxdox1iprmgP2O4snaotX89HJncwgMJxmE9XkH1EUSqfd7zExS?=
 =?Windows-1252?Q?Kyoo6rcPQLQhaM949wLFcnLJlwZYKdqhkjoopPZS6MJTA4so3t9hMHRQ?=
 =?Windows-1252?Q?D2/j3Bz/5x8PNWqnlZfowL/iubIf7CNP7GchY4KZTWiX/sSy8Vmfslpc?=
 =?Windows-1252?Q?HeIC+CM5AL1nk7bigYxo9cD0qbXkac5TKhYovHO0iTZ6zHYMuNgMlp6g?=
 =?Windows-1252?Q?8rPjD4YvJNQMyw=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <8004A91C58E14146A30DEB4515F959F3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5549.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a01be9a-1730-4b82-0a62-08da12ed0644
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 08:04:04.7235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2lYqF7R9wlf/dLSJt84X9bwmWKO1Uz7RT5MWHl0qEhz/xZnvmUF+8vDC9OETKnvdoJsy9P5PzrwTiZXRgAFTsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3754
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris:

Thanks for the testing. Can you attach the dmesg? I tested mostly on my sky=
lake desktop with some 3D workload.

Thanks,
Zhi.

On 3/31/22 7:42 AM, Christoph Hellwig wrote:
> On Thu, Mar 31, 2022 at 07:11:07AM +0000, Wang, Zhi A wrote:
>> Hi Jani and Joonas:
>>
>> Are you OK with these patches? I noticed I need to change the license of=
 the new file. Will do that when check-in if you are OK with these.
>=20
> So I actually ended up testing the patches, and first they fail to
> compile against current mainline (trivial fix attached), but then
> the guest (also latest mainline as of today) also hangs during the
> initialization of th i915 driver on i7-8550U-based Thinkpad.  Plain
> mainline as the host boots fine, but spews a lot of warnings.
>=20
> Host and guest configs are also attached.
>=20

