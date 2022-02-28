Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE92A4C764E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbiB1SCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbiB1Ryq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:54:46 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30C765D4;
        Mon, 28 Feb 2022 09:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646070266; x=1677606266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uLcBX4qnGVJwurtW/1BqkEVeJpKLQNa3F1ganKApq0E=;
  b=fLr0N0QQf98DeLI8Z8KgyLLdl03wjwlWLq4nTbPcxEo73BsM1Z8EJw8S
   2nHEIf83TcEtYQnYiDDlPC9dNaXsqKTY8ZiSOVQDPX8h5hj+dyF+pOa3q
   9VjXpd9wPIwe0Yu8I5DukpZO02rNdPQyo2cNXFV+BAJ7ftxJfrSA4npet
   BKiYXCDqa6ne8R4ykVHDgTh7gmBIDqlf1mfJu5YYLFBmal2tYWy23iVAC
   VxyMoTyMeLVxHm462lN/5Eon7AqCfxsL8i01i/lKh9dnUiEgU5PhW3w1W
   cNuHdPVXsFkrJLhThODUn6K6RsPQKi8FjVLYYDgySdA3BCkjXw8FKtWnV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251773780"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="251773780"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:44:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="534540639"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga007.jf.intel.com with ESMTP; 28 Feb 2022 09:44:26 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 09:44:25 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 09:44:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 09:44:25 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 09:44:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbIfkiZ5Qk/wXFtKZcQxdLrkkO1im/2SJnnii5YJ2LBqitMlyDLVUr/eYWB7mmOXGNlK8A2BEITF6FQb5qAhhYkpWHBxs3ghsmBp6lcGVFfs90A8k49rxTPoWkA+iyf2blA97PrKeNBaGftQmZj13u5OWt+MmAYRachHmRPm3/7r9xy1lFYmLL2TPyQeZpx/c51wJv0gMxlMyq06TALBDumVi4sBPrnbFdRd7AvHTd/iWeelh3TFKQoZHJ4/aYKhhsOeuCcmiXV/AEN/CsJMNWcr5aywWB1yT3nwXo4hWmbdQwsa/kiXdpOeMgxADY34p9AdJy7KZSJRhJ2NGL3D2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLcBX4qnGVJwurtW/1BqkEVeJpKLQNa3F1ganKApq0E=;
 b=mKa/AgRanRg4jTE17KR+pRSrSEb5GO+YFFoTSGBgc1pa/yshrNxzgNDh/UbIP/1vkTKB9tacCT5RqIvYw5Gj0NDSrCDLTIxVV+fV3xUA34NSlNB4tBhZW8lH5sNaeT0eZBF9N7luLLBLnCcKtSozex7B0c9lhGnVo14f8mdZy0pdqjt2UYUXnvT0qZiy3IZ7kIPfQBh9tYxkLOutuhCYkDxK+EgZ18KprNXvuuZ/zm1D+MZsBeabep6bX45Z91q87nqvZIUHLbgfgN5I63Bd/Zqzo1xwzlZnbSLt2F0dzMCDUzM0adGgyhg5vhvrqRM/wqe8jg/ebgmiETe2xcLHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5591.namprd11.prod.outlook.com (2603:10b6:8:38::23) by
 BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.26; Mon, 28 Feb 2022 17:44:20 +0000
Received: from DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::4d22:453d:a721:125a]) by DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::4d22:453d:a721:125a%4]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 17:44:20 +0000
From:   "Dhanraj, Vijay" <vijay.dhanraj@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Thread-Topic: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Thread-Index: AQHnSY0LvXD3+ZEFlRgON4KL/8w9CQKxAYDdAWBBDjasYq43gIAHcQAAgAAv5ACAACOccA==
Date:   Mon, 28 Feb 2022 17:44:20 +0000
Message-ID: <DM8PR11MB559199F9E34A9CD75F2CB7A4F6019@DM8PR11MB5591.namprd11.prod.outlook.com>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <Yhy/GvJegnTqYdq6@iki.fi> <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
In-Reply-To: <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e593e460-03dc-437e-2ff4-08d9fae1f36c
x-ms-traffictypediagnostic: BYAPR11MB3672:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB367228B3F3AC7B8F4291EDECF6019@BYAPR11MB3672.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8I8OVrwLDIApz1gKiViyXOcEWINBJdC6LW4PydehQ2VdG/1DPyylZcXZmDUJZwbzYeMD1kxsCAMV2nalh0TFwXTD1eF51kwDDb+a0nCXFIKlnveK2dnDLe21OAdeDXt0+RPH1NJYuTpC5c9zXUp7J+MIR0CpoFJ4mWiHVoP9FzvS1sqBOpzmBSmjfSxpJsF1AeUzce517ZNCOEJmAVw0fj9fo+2BnykLyYE+JvrgWyVbL8i2Vg1HJL1LiDjqEDNRKyugx6dfTNsV66bQ4SgxksvPqBq5ZcNzUyPLvfF6R1+bJXO6LOi2B+MWgmxQNLGCaUYLvIoGXqBUNQr/M+mYmj1AE2Tj1dIMCI7Mb2eN1E6TwlhYnXXjbdNtx07faT1tuBWxAE1yHkAgEVwAOjOL/HkU1MKc9AWINZlNRyRDq+WvoFXy0Vwfo0u3tYF1WHDeyWqMno2pylhVkTfSOq1GtKaDZ/EWTZo60pQegk2vrLvqHJkM0TKdP5XvbxlMpHCx8HXiVBiNU2Q65x6uzoZqAJe3TYnT8dT38oFwdXoEtUcmiURH1HooPuL/NGCTiPZ5SMtrDRC+jS+LzdaGhOUNryvUapUa7PpxblQB9FeD6Z/cpJ/bCJVOqMn+OkPGsfmvRpr7YMcTd1Pl2QfFPxAQc4u6Htvnw5qxiSjqLXhQEizPnNrxx7B/6HSjLZsnGnxQl9nx1r/IShrBLfn2XiMC2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5591.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(6506007)(53546011)(7696005)(33656002)(38100700002)(71200400001)(83380400001)(508600001)(122000001)(55016003)(110136005)(54906003)(8936002)(316002)(52536014)(86362001)(7416002)(5660300002)(38070700005)(9686003)(26005)(186003)(66556008)(8676002)(66446008)(66946007)(64756008)(76116006)(66476007)(2906002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXU0NmRVVEY2Q1pmVEFKK0RkVkNqbkdLajhnQXNSby9FcGE3SENGWlo5YlVh?=
 =?utf-8?B?ZGpIOWdxUzJ6QW4xVGFNS2hFQ1p6eDV5UjFMNlNzalk5VFQycmx5eVFaTWZu?=
 =?utf-8?B?TDRXWWdveC9COHVEVUxtU2NRREN1c2I5MlRUYXkwaXZTcHpUU0RHc2NIa08v?=
 =?utf-8?B?Q05vODNJMGNuQUo1VUMwYm4xY1B4VlVMVGp4K3lQQzE4Q3dnZ1NveTFaeFQ3?=
 =?utf-8?B?dzBpcmhISGZ0bjRsOENEQ2xzQ1BtSWVHNmlQY2RscVhINlplbEVyOWQwZ20r?=
 =?utf-8?B?REtpcTVMSjlFckY4clIvNlNpa210c3NnUGZYZkNLdkNYWDNreHltdmRxRDRn?=
 =?utf-8?B?ZThqZzd2M0RiUXhtMlhodE85aWpzL3hXc1dmRGpiZmg2enlCNEpmcTd3czJy?=
 =?utf-8?B?RGQyalB0RDFKRE5JbVFnOGREbHBrN0MzVEU0Y1AzWm1vMmhoZ08xZGxDaFlE?=
 =?utf-8?B?bVAzeDlHazhqamxtVFdjc1RsWHYrWFR3blpMUHFRdEI3Z1B0RHpEZ0M2azFM?=
 =?utf-8?B?eTQyVnVHNERMY1VaOHVqaG5BbTRTZzZscjVNUjhJbzhlSGptNDRCUG1iTjFt?=
 =?utf-8?B?SHNFcFNpQmhxc202OHRyYS9nOWFuSzVzV3RXWW1qTVM0ZE9peHdrdSt4MDd5?=
 =?utf-8?B?YmF0dDV1QXhnb2xPWklOMmhyUWR2dG5qWnBRWUxYWWFFakxFeC9DODhUWVhX?=
 =?utf-8?B?V0dNWnZrR3VEWnFkQU1rckdPTHh0TlNYZWNweFdDeG1TTWJ4b2RtL1d4RkxF?=
 =?utf-8?B?OGxlVk1TRkxvNlNrc0lnN3BZYWVSdWhObitnaUs5VzQ0Ty9Pa2pQazJ1WUZD?=
 =?utf-8?B?YWFzbHhwaGVXOVJjRFUwWW9Xd1RnQUhrVVlJV29hMEtxMUV6S0s5UzgxNEtI?=
 =?utf-8?B?aTVxbTRhZVBmRFdWNVhOdEN5aFFVNGo2RjZoYUlDM3NVajhFcEtHeWdRS1Vz?=
 =?utf-8?B?NDVhUmt4WSsvRXRIVEVkSVJPV0YwcHkveUFaZDVld2VIL2dJY3pjUFhBaitY?=
 =?utf-8?B?OFF3SCt4QjlDeElnUEllWFJUU0FqOXVaeS8rZndDY05QWk1nK3VTRWRRS0c1?=
 =?utf-8?B?R001NkcvWWJsWjMzZGJZU1NrdDVlT29tV2VKdUJ2aTdmUHBkSzNxWERFUVNz?=
 =?utf-8?B?Y3JuelpvQTUyY1cwTCs0TGlhSVhQNXpUclN1ZjNPdWdzS0ZySml5cy9vUFhL?=
 =?utf-8?B?UkQvb0RQcDlERGZwUFBubEYvSXk4UDV6SkNwRHZhUHgyRzVQaVZ6YXhRUzBo?=
 =?utf-8?B?d0RjZEZqVlRHQno0cjNPMHZ0RHc2MXZIVEtGSTFQMHMxLzkwQTFta2czUncy?=
 =?utf-8?B?NzMyeDlYQ2YvK0RkbHJ3d3BOQjNONzFqZWtVTkhXM2llZThaNXlWWlRQM3Fw?=
 =?utf-8?B?RExXUm9QbngzMXJaRENnZ0JVZHE1NG5EMU4zT2dsdWNISVBVREI3dkxDRE9F?=
 =?utf-8?B?K0lSUGxzOHgzVVNuUG9UeG9IYnkzV0dUaWtlREtRc2Nabm52SmlMYTVJeVYr?=
 =?utf-8?B?bndoTFJ2Mk05VlpTWndsM2RNQlZBa0I3RWk4Z05icklHNTZzYlNtbDlobGRC?=
 =?utf-8?B?WFluZGVTdnFMVWRtL2NaSnFKUzFtRVpidnVmMlhtTXpRSTZNQ1o1RUFUOGY5?=
 =?utf-8?B?eDlWcjRsUmRqVThTSkdCTU9WSXlTT1hUWlZJYVA1cSswODdOcXl2c0dmbC9Q?=
 =?utf-8?B?dkJSMEtUemJaNkRWa3JkcFZxNVhXT3YrN1kyU0NCNmphaVRDWmVsVGR2enFj?=
 =?utf-8?B?RzhtSkx4YVpFT3JKMkUzcHRuTXBJRFhsaDRwTllGMzhYQy9MdE1rZzdoUVEw?=
 =?utf-8?B?eWt5dmhjZWNTcFlOb0xXVUtIUzFkVUN1b3E5YkxLekR5ZTdURnIyWkJjdHFH?=
 =?utf-8?B?YmNoNGJFdHBDOC9UTXZ0WmxJb3cyK0lwbE1YQXMrVTMyVkpuall1b0FkRWJS?=
 =?utf-8?B?bWFpV3RHbEF3Q2tqL1RGU1cvL1FPOTh1blAzQW0wSlk5dUI1Z292c1lnTy9W?=
 =?utf-8?B?ME1ETnNxY3BFOWdoSFZiakJUcXVlWnlDV0Jwc2tVemhZeHZtZ0U0d3UyQkJN?=
 =?utf-8?B?L2xPTTZ0UTlBQVRYNDNoVnhMKzVQd2JyMjR1UmhSb1llbEJWYWJ0UEpjN2tv?=
 =?utf-8?B?N3JkT1NnVW9KazU2L2ZMN2d2RVd2R2M3eDNsK3E4U1A2Rk5tVTZsd3pPNk56?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5591.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e593e460-03dc-437e-2ff4-08d9fae1f36c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 17:44:20.7237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/BKqdsaZaeoYFdtahRl+0JNuPJyt2voE0eahLUBS9by7WpyzWSBnReAWTYeNuGcw8Qma+VdI91NRs4a65TyTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3672
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAyLzI4LzIyIDA0OjI0LCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+ID4+IFJlZ2FyZGlu
ZyB0aGUgcmVjZW50IHVwZGF0ZSBvZiBzcGxpdHRpbmcgdGhlIHBhZ2UgcGVybWlzc2lvbnMgY2hh
bmdlDQo+ID4+IHJlcXVlc3QgaW50byB0d28gSU9DVExTIChSRUxBWCBhbmQgUkVTVFJJQ1QpLCBj
YW4gd2UgY29tYmluZSB0aGVtDQo+ID4+IGludG8gb25lPyBUaGF0IGlzLCByZXZlcnQgdG8gaG93
IGl0IHdhcyBkb25lIGluIHRoZSB2MSB2ZXJzaW9uPw0KPiA+IFRoZXkgYXJlIGxvZ2ljYWxseSBz
ZXBhcmF0ZSBjb21wbGV4IGZ1bmN0aW9uYWxpdGllczoNCj4gPg0KPiA+IDEuICJyZXN0cmljdCIg
Y2FsbHMgRU1PRFBSIGFuZCByZXF1aXJlcyBFQUNDRVBUIDIuICJyZWxheCIgaW5jcmVhc2VzDQo+
ID4gcGVybWlzc2lvbnMgdXAgdG8gdmV0dGVkICgiRUFERCIpIGFuZCBjb3VsZCBiZQ0KPiA+ICAg
ICBjb21iaW5lZCB3aXRoIEVNT0RQRSBjYWxsZWQgaW5zaWRlIGVuY2xhdmUuDQo+IA0KPiBJdCB3
b3VsZCBiZSBncmVhdCB0byBoYXZlIGEgX3NsaWdodGx5XyBiZXR0ZXIganVzdGlmaWNhdGlvbiB0
aGFuIHRoYXQuDQo+IEV4aXN0aW5nIHBlcm1pc3Npb24gaW50ZXJmYWNlcyBsaWtlIGNobW9kIG9y
IG1wcm90ZWN0KCkgZG9uJ3QgaGF2ZSB0aGlzDQo+IGFzeW1tZXRyeS4NCj4gDQo+IEkgdGhpbmsg
eW91J3JlIHNheWluZyB0aGF0IHRoZSB1bmRlcmx5aW5nIGhhcmR3YXJlIGltcGxlbWVudGF0aW9u
IGlzDQo+IGFzeW1tZXRyaWMsIHNvIHRoZSBpbnRlcmZhY2Ugc2hvdWxkIGJlIHRvby4gIEkgZG9u
J3QgZmluZCB0aGF0IGFyZ3VtZW50IHZlcnkNCj4gY29udmluY2luZy4gIElmIHRoZSBoYXJkd2Fy
ZSBpbnRlcmZhY2UgaXMgYXJjYW5lIGFuZCB3ZSBjYW4gbWFrZSBpdCBsb29rIG1vcmUNCj4gc2Fu
ZSBpbiB0aGUgaW9jdGwoKSBsYXllciwgd2Ugc2hvdWxkIHRoYXQsIGFzeW1tZXRyeSBvciBub3Qu
DQo+IA0KDQpWZXJ5IG5pY2UgYW5hbG9neSB3aXRoIGBtcHJvdGVjdGAgYW5kIGFncmVlIHRvIHRo
aXMuIEl0IHdvdWxkIGJlIHNpbXBsZXIgZnJvbQ0KdXNlciBzcGFjZSBwb2ludCBvZiB2aWV3IGlm
IHdlIGNhbiBhYnN0cmFjdCB0aGlzIGFuZCBtYWludGFpbiBhIHNpbmdsZSBpbnRlcmZhY2UNCnRv
IHJlbGF4IG9yIHJlc3RyaWN0IHBlcm1pc3Npb24uIEJ1dCBpZiBjb21taXR0ZWUgZmVlbHMgaGF2
aW5nIHR3byBJT0NUTFMgaXMgdGhlIHdheSwNCnRoZW4gd2lsbCBtb2RpZnkgR3JhbWluZSB0byBh
ZG9wdCB0aGlzIGFwcHJvYWNoLg0KDQoNCg==
