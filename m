Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9152850A1E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389007AbiDUOQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389085AbiDUOQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:16:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ABF3C4BF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650550405; x=1682086405;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QJbP8ss8Q1o9mO7q3AsI9Of1WELCeQBzgtEZzTca21E=;
  b=X44XuU0OPHtWwHFSNFZdu0DvjlsTlu47W0Ad/kiHQeo/WWArknhLG8CK
   RKaOgUDfN9x3l20V+DLDVxEiROT7V7JIeBeF/COLBt9SPrTmpu3lkOb7T
   yJ686eV5xlyxouNKIBxtrbMvsbZ3azADVgjPNqPFwac0E1ewdTni6Pdq5
   A6HfJvka0Oyigh902twm1pIzTjPMGTo/p2l+4IFOp5qTqW6zjv6XjdGVJ
   5WQ9/Z+CrukUTp6lkC3cBOQCmpcjGmGRnALMoyFMXDMIQlBW7/MEeKPow
   /GIPdoa4dOlDytWTVNyArsNVXah+HymAxJgnQOyiO4aXZGTjWglSxtf4K
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263208930"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="263208930"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 07:13:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="866223505"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 21 Apr 2022 07:13:25 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 07:13:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Apr 2022 07:13:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Apr 2022 07:13:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmeohtTYns4KN0cWZH2pScg0RZGWobJWy2De44Rpo6LIqLujUE+/HIlTtkYfPawiOTorBjJacG8ljRXf09UV/EaAjrRXRoGWSAMg0qcXm4Kun2COG9aSxoZZxxOcSGdLGtoAyIehB87APNHS9FSrSvDmxtdZ7flnsXjQ/6vJSo6/dIjblK5iESeDBImXnDH5U2am+isvOIO2UcM8HvzvqgQAMn0Ip9Iq/mokD8HajFobgfWEgPvCXn/I5ayUvRJLU6laVb49rX7UKgupKWrZ9NBKn24a4N8GnHU/tOCNFvMrodR3i5QGDf31OFI2latn898a2suala/9r+C3QOXLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJbP8ss8Q1o9mO7q3AsI9Of1WELCeQBzgtEZzTca21E=;
 b=g453nXl4zkcmvezgE8en4ghS0/mwdBU8XdD+AD3fg83HllXiKB2hfhvK2J8dubt73IsDGzgXV3g5xRk83GV9BbkKwwNg/PhfAym3Y+xhkIh7E+9bBo+YcvTjWgieqDQWn2c66TrnYWNk2gGWJcOsg97Uij7ei1c2bRsNzO9dde4XGSUNTHlUEPhoHDIys9aEMN9uIaxNMeMxYmqHD5lr0+pYCECQENMotECMa+vQ04y0CJYPSJp2ecUv7+0Nj7ZGrjzgwlES5gSqE2xLSuhQs064uXFrslXjAYxZst30djw+iGdZb91xvH2/1eawe7fIqaCXXTU32f0lm2sErBg3dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5549.namprd11.prod.outlook.com (2603:10b6:5:388::7) by
 DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Thu, 21 Apr 2022 14:13:18 +0000
Received: from DM4PR11MB5549.namprd11.prod.outlook.com
 ([fe80::e5b8:93eb:e06b:f1ab]) by DM4PR11MB5549.namprd11.prod.outlook.com
 ([fe80::e5b8:93eb:e06b:f1ab%7]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 14:13:18 +0000
From:   "Wang, Zhi A" <zhi.a.wang@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PULL v2] gvt-next
Thread-Topic: [PULL v2] gvt-next
Thread-Index: AQHYVNSMOPXpKvGgN0OvGCZ3HfiQDqz5AfeAgAAP2ICAAAGGAIAAJZkAgACWCICAAA3+AIAADw0AgABtrYCAABCNgA==
Date:   Thu, 21 Apr 2022 14:13:18 +0000
Message-ID: <9cf8c65d-11cd-feab-1def-db1176153c8d@intel.com>
References: <5a8b9f48-2c32-8177-1c18-e3bd7bfde558@intel.com>
 <20220420164351.GC2120790@nvidia.com>
 <20220420114033.7f8b57c7.alex.williamson@redhat.com>
 <20220420174600.GD2120790@nvidia.com> <20220420200034.GE2120790@nvidia.com>
 <55cb46db-754e-e339-178c-0a2cfaf65810@intel.com>
 <20220421054738.GA20772@lst.de>
 <165052329083.6597.933445971686511585@jlahtine-mobl.ger.corp.intel.com>
 <20220421131403.GF2120790@nvidia.com>
In-Reply-To: <20220421131403.GF2120790@nvidia.com>
Accept-Language: en-FI, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbfdf7c2-2bdf-4180-2c3e-08da23a11559
x-ms-traffictypediagnostic: DM6PR11MB4705:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB4705D84FC412F0CE75D3AF31CAF49@DM6PR11MB4705.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 53vElOueQqsEih5AAnQR993/PCHPoxtYmEHzZ/Ux3in4h4eB4kOF7NgBsLT+cX/IQqd/vTtcoBTYb9gOPLxEe3hUzNG5+34ety/L5hoFtyd1IkPDajd+4gr6xNIMEkIKddVtS1UhIo4UDJETKfHRbQTAEqC5/iNo0JTh5uhTvgB6LrOnnQmE4c6YllVdpLt4qiEzolBnaFdOKjEcOS/ps2l9R1tKFtl+WButuoAqA0Ah29iNgIzIuGK4Jc5TFjlNAd2d7OWP5rWa4skkWajl7igl77AirmCsAqPBdDhHsQRtiGy0gAXQGfoBj6G640YNQHTxHiKkhgpibxKok3zM5+Gl88Q4zSjknxv05ifrCytZWRChzvP8yShD8iQalU4xChgKEcw5md7eOwpetE06HWOFTWmsoxk92EFqheab8ueQIOx80zi8lPj0VcHy1XPtNb50Wzg34YkItAk0uuiIriMfrrAynJRI1JYF0WeHf10WkMc90RLNdYmMNaYi/ac2eFMRqxtTFvGxO+LUt0xf4DOGl/CiY948MxlO+1SKK/2uaJP/BZ8UkMRvygS0JC6Imyl9ciMfRQ0kAoTZAymgy6fwPvJuUF/Hdmk8vyyYBOmV/cTiXQcmpuY32xpjxZSm2IGQ/ByMTkOx6sGLeN84vpoqC8bR2WHzNCv9bXp5ioljQkQ5aXRk9qOnRc3lpim/OQRUhpa9Y9Ok1eJ357SOpzjjuSlP6zhWHqgXRH7BviucAa9NDgBsiug2eDHv3RWeVh9GejtKm+UsLNx9UtPRRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5549.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(2906002)(8936002)(508600001)(4326008)(5660300002)(7416002)(8676002)(26005)(6486002)(76116006)(31696002)(66946007)(66556008)(53546011)(66476007)(66446008)(64756008)(6512007)(6506007)(86362001)(91956017)(71200400001)(110136005)(82960400001)(54906003)(38100700002)(38070700005)(122000001)(316002)(36756003)(31686004)(83380400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?PiwQ6AHFs/tJ9oRttLwP1Gu7Iy0u9bVvBAk+OJ732ISciknTMLGd3Q8S?=
 =?Windows-1252?Q?EEDRSYTWIVZFN3Q8fkVBMqecqpFQsBb3+5pb9NGvPAc5SGuxCIwUaz3u?=
 =?Windows-1252?Q?mWsZyXpMVc7vZ6lIGP3JqDGLOjySE+MYVhzCo7PJG7BXJoRE434rfPqU?=
 =?Windows-1252?Q?jmVh1UIVsRsDJI3XmEVmOa/jA3rDR3jG8sG/RHc3yzNSMmWR+fQqNh4/?=
 =?Windows-1252?Q?KORpc1P0OwHUV+z6SRFHfhNogJkXU45/1ygJweEFOTjPSfBmqJEd5Po3?=
 =?Windows-1252?Q?/KhbW75Xu6h0tgj6wTShQ/Ro7Ce8MM6S9Cw/CTmuafs/iIUXjB5dNdVR?=
 =?Windows-1252?Q?9D9MOrEbhGxXoAjgbaK6PFRBPe9hSKrkGnonwe5BP3uST//7YYJgZPRo?=
 =?Windows-1252?Q?1Np444Z4wQFTQXv05WwXx0RnA2AM5n27+ZpuZcsMchAtA/DIXJG0z9V1?=
 =?Windows-1252?Q?wwE6ZKjyKgtwt/HdcN+TLaZePoNoLdwG04WXBe5zeE7jM+aO6un7fXPW?=
 =?Windows-1252?Q?1nwo+XaZ4oIcNylzeB2vuQ97CmSORy6HGa1QGuXkdgWEg41PEGTajToy?=
 =?Windows-1252?Q?EndeEyhftLsp9r2lwqU1hW82G+46s+X5ePAF8kW6c2jn9ESQqVb8knwq?=
 =?Windows-1252?Q?CHe7Xu263NJAwDdeNPE8d2Kyr/crgzaiWfNUmDKP9XMjlnOKcRmv6hQ6?=
 =?Windows-1252?Q?VUmolcYXa1Y2ImG4HM0DZz/lokYzxdm91hyn1HYSdiFzkh0mJwpBwTLX?=
 =?Windows-1252?Q?I8Ksh47ihQpgyPnzIFDGnIEFw5QokLo7j8nyl8/c85615MYuNgf1vxUT?=
 =?Windows-1252?Q?oBbtlvscdep7aRbvP+F3Q3Q469Bb0C18SdI9cA9Jyn83t6aGP/aJg9zk?=
 =?Windows-1252?Q?sHTlwSKaKbV5GWnmibjMz5CWsESC29gmqb7Npv9ItlFH4TmncLKv95KT?=
 =?Windows-1252?Q?KO2pSKolWnBR098k+Rzx+VRfbyBwAvWgg9kvovSC1naUVyIGNbQvu0DA?=
 =?Windows-1252?Q?U7nStIbqgkRShoRTQEZ4aZ0f1bKFEzntB/Zt77EDGwbmhXMRHCjULlTP?=
 =?Windows-1252?Q?yPOZ62kNc9R7NaOie9Z4AQ9RJzRkmKlHnwgynEjm/Fv7gNawI9gxTBSU?=
 =?Windows-1252?Q?SYud/2kywC5ic3D7YUmhI5IS5PPCmNaZakE1ESHusfIXvDz7FJwAPFDv?=
 =?Windows-1252?Q?HZo2EwgNm3zNlgozdnJo8RcayfRIQn1uY/FmOdcsLUO0sXvxVSQmnXLG?=
 =?Windows-1252?Q?jwKIm/O6QfMSlhxmvBhuO1+ZeIWqeIPYEyKId8Ytwi0g/r+1xc9p7Vgx?=
 =?Windows-1252?Q?v5DKPm9Nm25fclC/GzEhAwYimKa4p2eGSWikgYQxqCH3adfBEHJXgj3u?=
 =?Windows-1252?Q?gjtCKfaRAbIx1qtrPfemO5+vyPdrsBaKO4a+3vtMVqQ5VaAIDf05EP+D?=
 =?Windows-1252?Q?MKJBSA2pZIHlHVBgvj26YwSA84AWzWBW90F8RtCesdqcJmaEvGcNuAUH?=
 =?Windows-1252?Q?Tdedq6b3eTgNVi84x00+4yBnY9MfpQMLAekId9xTxmPTf9fV65SuDEHT?=
 =?Windows-1252?Q?RWFX+FZ4vtkmbtaf8+BcLmoWkug44A9EDdyu/cjlw4mVk309Rhxj1j4F?=
 =?Windows-1252?Q?lGjPQBdC4R+rmbhjDosBPe9wa/2x4n572f+7VNgdYDqT8XvdXgwyN59k?=
 =?Windows-1252?Q?h9m0L5SxDK2t4a1KYVO9LduPmG7W27fqgSyQKIh97r7zCvBLNQ7YyOhj?=
 =?Windows-1252?Q?pFLFnoDZ+SwGnciLuJ44hid75r8mwFfNojcTwOmveGzNUpm4hg7CKB94?=
 =?Windows-1252?Q?bwYX8JN5IhF8ePxL1SJQmEuvv+2jJfWtPmtaFRx2yqnnjCfb9ciBfmsh?=
 =?Windows-1252?Q?Tp+OVs90wyyuAg=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <821F7C6144B5EA49861A35B3C826C7DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5549.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfdf7c2-2bdf-4180-2c3e-08da23a11559
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 14:13:18.0750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4VfLk9hdEX9seJJOkGXgAizCI+2mUqN0qNUvjYd6f74k2SITEvuJ0ZGvPmmLV6Ck4M54nWn6w4lwS28oT1PMeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 1:14 PM, Jason Gunthorpe wrote:
> On Thu, Apr 21, 2022 at 09:41:30AM +0300, Joonas Lahtinen wrote:
>> + Tvrtko
>>
>> Quoting Christoph Hellwig (2022-04-21 08:47:38)
>>> On Thu, Apr 21, 2022 at 04:57:34AM +0000, Wang, Zhi A wrote:
>>>> Is it possible that I can send two different pull based on the same br=
anch?
>>>> I was thinking I can remove this line in the original patch and then a=
dd a
>>>> small patch to add this line back on the top. Then make two different =
tags
>>>> before and after that small patch, send one pull with tag that include=
s that
>>>> small patch to i915 and the other pull with tag that doesn't includes =
it to
>>>> VFIO?
>>>
>>> Yes, you can do that as long as the small fixup commit is the very last
>>> one.
>=20
> Keep in mind when doing this that best practice is for every commit to
> compile.
>=20
> So if you add a commit with a new #include to this topic branch that
> commit will not compile.
>=20
> Best practice is to fix the compilation breakage in a merge commit,
> either created by you or created by your upstream.
>=20
I see. Let me update it.=20
> Jason
>=20

