Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7A54CB341
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiCCAMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 19:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiCCAMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:12:30 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4403338BDC;
        Wed,  2 Mar 2022 16:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646266304; x=1677802304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SNY7Qza6VHAjhqJM42Jkcpa6W7LkJuWPdRt3cg0CIYc=;
  b=S9mBP6psGQphvVIfgcbwkVFe+JqpEP2EUMRazSu+4RnBD+cne0nZQYT4
   rnEt3OMjNQchlig71gY6m9s4MykwYDeUf9Gi1YfQXf1WY2PvII7kWG8qo
   QFdQRS/TM6Qc7nwvDXhunic6rDHUtoAPFQpfNpsuYf6Wh0QuZl8SODXOl
   6mjEi06uNm7w8vvZG+yJXuRNPHOgtllzJAwMPr8adEw+8Cs1HfvQp+2E0
   Tm0EmBtWo4YQtx5S5e/TYEtH/00djWugzYGSGUBVCaJWKeMnPVKjpsqqC
   klp2IzIG1r6p+dBX1SObcY/WLildgrN8HZVbnY996bt1VtGkCKO++KniI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253721238"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253721238"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 15:24:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="779042392"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga006.fm.intel.com with ESMTP; 02 Mar 2022 15:24:51 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 15:24:51 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 15:24:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 2 Mar 2022 15:24:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 2 Mar 2022 15:24:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vcz/yKDI+S+eRL5jnDoUHQxA2LRX5azcDKC5mHm/kZcfm3AwA8qnOYToiFR5VfbwNbvAKePZiPciytuTqFin6HR62nuNTROQ9INZJCugY11LJF/Xwj5JSBSyxWrV9GUhS43Pz3FbjREZOGYKlYcrsmKgu1XgLQBlWbnjgrFYW/Grc32/zX3uaJ5ch9Qjblq3vendWehFCz6UzQI3dk6OqgYMtDJYklNlp3y0Finbm3axHTJ+ultrwAns8AslaVJk70OfgbeHXitLparVpu/cf/DpimmFI5U/NSqt1+Tef85jNMgUy+3FePv6TrihfDkBOxiWaC0mtiH1Re87cWw1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNY7Qza6VHAjhqJM42Jkcpa6W7LkJuWPdRt3cg0CIYc=;
 b=R3G50j7ySt6SviXeu4bXP4RXnoQeA4STCgd47r7mC3dzlKQfHvgjcrlg7MzUD37F0XCWvVgw4V9jystqlodt5VH+BuzF2DkehE69Dv1UbeyjcC7wnZ9euMATZ48hIlY5bsphYmJVJ6czaFXnvE7xSyre2wd8wqkeCqZUt5elB9Cvf/2hmBugOw5yzGkjygaRM+CLZ7HLNiSE++3tarbhFISm97No0QsyxxpmjJiAMj/nJMoIxc3nPBkaFw8J9c7fKX2QKCovonpeJL0NOqk0Qy772MnLaeEi3TmpbDr9ldBRbzFckI3oiS+RXR43HtbHb2M70W21PvKvd0+Y++c/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN8PR11MB3842.namprd11.prod.outlook.com
 (2603:10b6:408:82::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Wed, 2 Mar
 2022 23:24:47 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::645c:646:87b0:7be5]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::645c:646:87b0:7be5%6]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 23:24:47 +0000
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC 03/10] platform/x86/intel/ifs: Add driver for In-Field Scan
Thread-Topic: [RFC 03/10] platform/x86/intel/ifs: Add driver for In-Field Scan
Thread-Index: AQHYLoy17NvOy4xKxkKrWwpbWU/fbg==
Date:   Wed, 2 Mar 2022 23:24:47 +0000
Message-ID: <f0e958c612ac4dab30ba458a08a7681e1114668f.camel@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
         <20220301195457.21152-4-jithu.joseph@intel.com>
In-Reply-To: <20220301195457.21152-4-jithu.joseph@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-3.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d763992f-f809-4e80-68bf-08d9fca3d7a6
x-ms-traffictypediagnostic: BN8PR11MB3842:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB38423C2D80C0540A76FEC55EC6039@BN8PR11MB3842.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ryGRxS8tGxL+vjVsVd7XLMzH15NJ3xJjU7VUjjOTvAdFvxNrFEhBM1nCNrGD++/lZcox64pwp2OKsTFy0F8xOibLdlGAA2trEJTwb8lHjOipMhrxMfNMdCQY52uQO25vVCYExv6ufhzfk6UzqIIwoXb9MPqeDqr2Bir5Sx6+yS3WcNOa1PcyiWKSf8nt6wxEVIDVM08fvhC9WffEGJe1qpBMAjd0Q2/Pl1zjsDTcHR7E3YH9SMUl5R95CjT5B1HMzkahOJp0kal7Yh0R5uq1rGQqzrd1GAkVUftTHwRfU2BiHwnxrv547Wu7/sE+DMzq7KlJ5sWQyGz3ZKyvmX9aBHYpdf08mp0AwQo07ExyBr89AEqs70GroOduxuPe5bEW4Dh4GAx3tswUs4bk/ujJHr8f3svN7D3qwQ57sn316QNsaE+yRrnlARy9x4kM9kQ/6LepbXKB6Bo9EwmdGDcKLkR7+dZhOZ6bzpnfv4UTUxqXJWaxhqFANWTfmOfTwYu2VoiZML84e58Y5TKy3BYZbDGPpsVkNKRPx5G7FRSYhLyGsYnTr2qmDeTg7u5t6MhfylIAgsMYUb6K0JidfRz5yEInZGVDWFyWDgPrS0qxDjk4IbSXwIRnwfU79CAwO/23L88ohQW9PuHGbx23AcvEJzp9VEWZdrwEDqVPGc98l+RJp/9zKGDeuQiAjJwYMd/2Hi5EqhB/QqD3DJU3ARAVzLxNmMh7wsMhRXyOAzx97UhIRX/GUD9ei2JMRyfuMXukt06He7OYfAUJoAcWjMwVESlBw7TQeHexZ6Dcjx3UbyM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(186003)(26005)(71200400001)(6512007)(6506007)(6486002)(966005)(508600001)(54906003)(6636002)(110136005)(316002)(2616005)(7416002)(8936002)(66476007)(8676002)(66946007)(66556008)(66446008)(64756008)(2906002)(82960400001)(38100700002)(122000001)(4326008)(38070700005)(86362001)(36756003)(76116006)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0l2UHBNemxYaU5rWGpYU3BGRytzeHdTTWd6WjE4Uk9xNEhxNCtrVmk2VWJk?=
 =?utf-8?B?Y1Axa3pDdHM5L2tVYzVjZUs4WEhhdkJhWGQzSjBiYmVCLzBvZVhzSFJSRG0y?=
 =?utf-8?B?QUZvVTgyTXJTQVBScW9KbVBHTnIvemIxeTFlZWlpYmpQWUZaajI2b1M3cW91?=
 =?utf-8?B?UmI1ZUFyWTVVSUVYV0NQTmp3SGJSaHcyMGV2OUgzWStpLzJQblBRU0ZVSmU2?=
 =?utf-8?B?RXhYcWVLQ01hVjJxeFM0SldISkNvdWFiaEw1aWpXTXgwYkwwcE9OODFhNnJH?=
 =?utf-8?B?Z1BMZDMzUXFab1NVTmFiUGhkdmRCdmZxSzFFTDRCeGFUZDRoV0d2RmlZR0Q2?=
 =?utf-8?B?NHd3aEY0WmFMTzlBSUhUMUVJKzBXaTBSY29ibWcxVEY4YlBERlRibkJ3aDh3?=
 =?utf-8?B?TnhGa1pJdVRvU0VFOWVlTGFkVk1kNVU0aWZzeFBBYXVIVVYxZHgrSmx1Sm42?=
 =?utf-8?B?YzEzck15NldDZUV1TGVlRml0alErdk9sSkYwbGgwRnFPSEZsUVB5eGprZW5o?=
 =?utf-8?B?S2VKU2dLYTZ1MHpUZEduaUd5MUovUHZuWDAyblhyKzAxTElNYkgxamwxRTdu?=
 =?utf-8?B?bG1PZ3dhVFYxUlFtTm5qdE9DZHZ6TUsrVVN6ano5ZWg5UVowZ2RER2t1TTBa?=
 =?utf-8?B?VS9McjFZZjd0d0JvZExOL2FRekVGYzNVcEJTV2hrd0Zldk9sN3NXMWMzYktN?=
 =?utf-8?B?RVR3VWwxUC9BTytreC8zd3N6MjFkanQvdjdWMERtYWtKSUVBcWFoMU9kdkE0?=
 =?utf-8?B?Uk1EaXVxMGxLUzNOUzdkOWRxNE1iNGtTZUhhS2pTTE1wRU9KangwNmswY0kr?=
 =?utf-8?B?SGY0allnWE93N2tiamx1TUsyTUZZTTMxcDc3dXk2L1h2ZmlJa00ybUY1bnNi?=
 =?utf-8?B?QmFnZEp1YkFEZEF4ckFMZ3RKNk82QWxrcEJYcGlHcm1HOCtiRnhZeVhmMWsr?=
 =?utf-8?B?cDRDVVhvcTJDNEg3b1p6SWVIUFZXaGx3NzR3dTBoVDFmRUR0MWRCK0ZHMFF4?=
 =?utf-8?B?cXh4eHN4d04xUFBrV0NaV3dnTEFkVjFkTmpzSXowMzltZlgwME9ma2N2bmFx?=
 =?utf-8?B?VmVKdHpEN1R2MjU1QXhyLyttVDQxNG94UEZrQTQya2pBVEpBSTNtbUcwSkJw?=
 =?utf-8?B?K09iRXVUZnR2MUxidTFXblRud2s5WVV3aS9VUjU0VkR5YWtvdUJvQjRHSnVY?=
 =?utf-8?B?Yno2Z2dJOFM2VEgzUmNzSjNDQ2VsNFM2Ny8rSzJONmI5dlYxRkgrdkhoVjVo?=
 =?utf-8?B?VURmcGt3N0JWTXJwUDV3U1NuRjBqejlxejVSM0YrQXk5NjFLNGo0V3h4Rmwy?=
 =?utf-8?B?WERQR01YUzNraGR5dTRrZjViZ2NuRE1HZW5DYXVJdytHTjYvUWcvcHhrcG0v?=
 =?utf-8?B?a004ajF2Ny83b0Z4YWVxaHBrN2lsMUxLWi84OEtPUnFMeGNHTW9rV2dDU0x1?=
 =?utf-8?B?a1gva2N5ZjdYb1kxWVFvYVZwK29WbWk4eHA2TzdKbjNUZVhSNTFoelJybGkz?=
 =?utf-8?B?NVRtWURCbW1wYkR6NmJIUWN5T1FlREhyWXpDSGRlSlhLUnRQR2ptK0pnaWcz?=
 =?utf-8?B?ODhGUG4xUm95MmlkbC9sOTJjUktYSWo3VjdUckdvQm85ZkliY0FmcGZiY1hh?=
 =?utf-8?B?M0QvVmN2VDJKaWpWdEZYU2NPNGFRc0xvZWxIa05ybDJZUFVXNVQwZnJ4eXN6?=
 =?utf-8?B?T2RZUFYrU2ZuZXpYeGE0OGtxMjRvMTdnbUdlVFd3Q2hJU2pQcXI0ZzB1Y0tB?=
 =?utf-8?B?WDBWSDZoOVVHZkhGT1N5QnE1dFhBbDRUaGVlTG1jVTR4NHhiZjBwYUJ1amZR?=
 =?utf-8?B?RDNGM3N1RjhtSFEvY0VqYldPcUJjQWI3MmI3OFZlWHVtemVpSkVhYXlnOVhY?=
 =?utf-8?B?Rnc4U3F6SHZrLzlmN0JkOG0yazJZY0hpeGVOQ0p3VDZiUlU5WnRMRkc1eHdI?=
 =?utf-8?B?Uit0Qm4weVBsTkpRSnA3TFIvZ2V2dG9tN3cxeDlRWEZTdXQrVDRSbGNKMFhw?=
 =?utf-8?B?ZVFxcVlLMitVUEFDZTNPamdyQnNyWWI3WW5KOW4zQkx2cmxJQkNmZWVNTk95?=
 =?utf-8?B?NWdndkdYSlpKcHhaZG1CSElEV2NDdDRkUjhXYURLZW5tcFJPSFo3Yy9KMnkr?=
 =?utf-8?B?VTNvS2t1cHVIaEtReWh5TTJ6Ky9DZkRxT1dYcUo3OVNNTGpHYis2UmRjc3ha?=
 =?utf-8?B?aHNpajFvMVBkUVFWSU9ublYrMzFkK2pDRXh4MC8zK3BESDgxWjNDd1RReHlQ?=
 =?utf-8?Q?s78gS7qrSwtbV0OZp3A/sNS/WeJyz3UmWJ7Bbt2hDs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6125D5DF7CE3664AA3996D448725C1AC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d763992f-f809-4e80-68bf-08d9fca3d7a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 23:24:47.6261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SVBkgcmHHLlNQEnvnmuLiMVcBqKb02gK947EVxf7TNPbCUWXcDhtHMbVz2VKtGZXbwSo8a0169lKaJN1X5DDycfa95Do20fYObFKIB5e8Uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3842
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTAxIGF0IDExOjU0IC0wODAwLCBKaXRodSBKb3NlcGggd3JvdGU6DQo+
IEluLUZpZWxkIFNjYW4gKElGUykgcHJvdmlkZXMgaGFyZHdhcmUgaG9va3MgdG8gcGVyZm9ybSBj
b3JlIHRlc3RzIGFuZA0KPiByZXBvcnQgZmFpbHVyZXMgZm9yIHBvcnRpb25zIG9mIHNpbGljb24g
dGhhdCBsYWNrIGVycm9yIGRldGVjdGlvbg0KPiBjYXBhYmlsaXRpZXMsIHdoaWNoIHdpbGwgYmUg
YXZhaWxhYmxlIGluIHNvbWUgc2VydmVyIFNLVXMgc3RhcnRpbmcgd2l0aA0KPiBTYXBwaGlyZSBS
YXBpZHMuIEl0IG9mZmVycyBpbmZyYXN0cnVjdHVyZSB0byBzcGVjaWZpYyB1c2VycyBzdWNoIGFz
IGNsb3VkDQo+IHByb3ZpZGVycyBvciBPRU1zIHRvIHNjaGVkdWxlIHRlc3RzIGFuZCBmaW5kIGlu
LWZpZWxkIGZhaWx1cmVzIGR1ZSB0byBhZ2luZw0KPiBpbiBzaWxpY29uIHRoYXQgbWlnaHQgbm90
IG5lY2Vzc2FyaWx5IGJlIHJlcG9ydGVkIHdpdGggbm9ybWFsIG1hY2hpbmUNCj4gY2hlY2tzLg0K
PiANCj4gQWRkIGJhc2ljIHBhcnRzIG9mIHRoZSBJRlMgbW9kdWxlIChpbml0aWFsaXphdGlvbiBh
bmQgY2hlY2sgSUZTIGNhcGFiaWxpdHkNCj4gc3VwcG9ydCBpbiBhIHByb2Nlc3NvcikuDQo+IA0K
PiBNU1IgSUEzMl9DT1JFX0NBUEFCSUxJVFkgaXMgYSBmZWF0dXJlLWVudW1lcmF0aW5nIE1TUiwg
Yml0IDIgb2Ygd2hpY2gNCj4gcmVwb3J0cyBNU1JfSU5URUdSSVRZX0NBUEFCSUxJVElFUy4gUHJv
Y2Vzc29yIHRoYXQgc3VwcG9ydHMgSUZTDQo+IHNob3VsZCByZXBvcnRzIHRoZSBNU1JfSU5URUdS
SVRZX0NBUEFCSUxJVElFUyBlbmFibGVkLg0KPiANCj4gUGxlYXNlIGNoZWNrIHRoZSBsYXRlc3Qg
SW50ZWwgNjQgYW5kIElBLTMyIEFyY2hpdGVjdHVyZXMgU29mdHdhcmUNCj4gRGV2ZWxvcGVyJ3Mg
TWFudWFsIGZvciBtb3JlIGRldGFpbGVkIGluZm9ybWF0aW9uIG9uIHRoZSBNU1IgYW5kIHRoZQ0K
PiBNU1JfSU5URUdSSVRZX0NBUEFCSUxJVElFUy4NCj4gDQo+IE9yaWdpbmFsbHktYnk6IEt5dW5n
IE1pbiBQYXJrIDxreXVuZy5taW4ucGFya0BpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEpp
dGh1IEpvc2VwaCA8aml0aHUuam9zZXBoQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFzaG9r
IFJhaiA8YXNob2sucmFqQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFRvbnkgTHVjayA8dG9u
eS5sdWNrQGludGVsLmNvbT4NCj4gLS0tDQo+IMKgTUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNyArKysrDQo+IMKg
ZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvS2NvbmZpZ8KgwqDCoMKgwqAgfMKgIDEgKw0KPiDC
oGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL01ha2VmaWxlwqDCoMKgwqAgfMKgIDEgKw0KPiDC
oGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL2lmcy9LY29uZmlnwqAgfMKgIDkgKysrKysNCj4g
wqBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9pZnMvTWFrZWZpbGUgfMKgIDcgKysrKw0KPiDC
oGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL2lmcy9jb3JlLmPCoMKgIHwgNDkgKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiDCoGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL2lmcy9pZnMu
aMKgwqDCoCB8IDE0ICsrKysrKysNCj4gwqA3IGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlvbnMo
KykNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvaWZz
L0tjb25maWcNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50
ZWwvaWZzL01ha2VmaWxlDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGxhdGZvcm0v
eDg2L2ludGVsL2lmcy9jb3JlLmMNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wbGF0
Zm9ybS94ODYvaW50ZWwvaWZzL2lmcy5oDQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMg
Yi9NQUlOVEFJTkVSUw0KPiBpbmRleCA3NzdjZDZmYTJiM2QuLjRjOTkxMmMwZDcyNSAxMDA2NDQN
Cj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTk2ODUsNiAr
OTY4NSwxMyBAQCBCOsKgwqDCoMKgwqDCoMKgaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnDQo+
IMKgVDrCoMKgwqDCoMKgZ2l0IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9sZW5iL2xpbnV4LmdpdA0KPiDCoEY6wqDCoMKgwqDCoGRyaXZlcnMvaWRsZS9pbnRl
bF9pZGxlLmMNCj4gwqANCj4gK0lOVEVMIElOIEZJRUxEIFNDQU4gKElGUykgRFJJVkVSDQo+ICtN
OsKgwqDCoMKgwqBKaXRodSBKb3NlcGggPGppdGh1Lmpvc2VwaEBpbnRlbC5jb20+DQo+ICtSOsKg
wqDCoMKgwqBBc2hvayBSYWogPGFzaG9rLnJhakBpbnRlbC5jb20+DQo+ICtSOsKgwqDCoMKgwqBU
b255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+DQo+ICtTOsKgwqDCoMKgwqBNYWludGFpbmVk
DQo+ICtGOsKgwqDCoMKgwqBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9pZnMNCj4gKw0KPiDC
oElOVEVMIElOVEVHUkFURUQgU0VOU09SIEhVQiBEUklWRVINCj4gwqBNOsKgwqDCoMKgwqBTcmlu
aXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4NCj4g
wqBNOsKgwqDCoMKgwqBKaXJpIEtvc2luYSA8amlrb3NAa2VybmVsLm9yZz4NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL0tjb25maWcgYi9kcml2ZXJzL3BsYXRmb3Jt
L3g4Ni9pbnRlbC9LY29uZmlnDQo+IGluZGV4IDhlNjUwODZiYjZjOC4uNzMzOWU3ZGFmMGExIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9LY29uZmlnDQo+ICsrKyBi
L2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL0tjb25maWcNCj4gQEAgLTQsNiArNCw3IEBADQo+
IMKgIw0KPiDCoA0KPiDCoHNvdXJjZSAiZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvYXRvbWlz
cDIvS2NvbmZpZyINCj4gK3NvdXJjZSAiZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvaWZzL0tj
b25maWciDQo+IMKgc291cmNlICJkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9pbnQxMDkyL0tj
b25maWciDQo+IMKgc291cmNlICJkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9pbnQzM2ZlL0tj
b25maWciDQo+IMKgc291cmNlICJkcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9pbnQzNDcyL0tj
b25maWciDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9NYWtlZmls
ZSBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL01ha2VmaWxlDQo+IGluZGV4IDM1ZjIwNjY1
NzhiMi4uYmQ3ZjJlZjVlNzY3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9p
bnRlbC9NYWtlZmlsZQ0KPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9NYWtlZmls
ZQ0KPiBAQCAtNSw2ICs1LDcgQEANCj4gwqAjDQo+IMKgDQo+IMKgb2JqLSQoQ09ORklHX0lOVEVM
X0FUT01JU1AyX1BEWDg2KcKgwqDCoMKgwqArPSBhdG9taXNwMi8NCj4gK29iai0kKENPTkZJR19J
TlRFTF9JRlMpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Kz0gaWZzLw0KPiDCoG9iai0kKENPTkZJR19JTlRFTF9TQVJfSU5UMTA5MinCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCs9IGludDEwOTIvDQo+IMKgb2JqLSQoQ09ORklHX0lOVEVMX0NI
VF9JTlQzM0ZFKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKz0gaW50MzNmZS8NCj4g
wqBvYmotJChDT05GSUdfSU5URUxfU0tMX0lOVDM0NzIpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqArPSBpbnQzNDcyLw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYv
aW50ZWwvaWZzL0tjb25maWcgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9pZnMvS2NvbmZp
Zw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjg4ZTNkNGZh
MTc1OQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVs
L2lmcy9LY29uZmlnDQo+IEBAIC0wLDAgKzEsOSBAQA0KPiArY29uZmlnIElOVEVMX0lGUw0KPiAr
wqDCoMKgwqDCoMKgwqB0cmlzdGF0ZSAiSW50ZWwgSW4gRmllbGQgU2NhbiINCj4gK8KgwqDCoMKg
wqDCoMKgZGVwZW5kcyBvbiBYODYgJiYgNjRCSVQgJiYgU01QDQoNCkFyZSB0aGVyZSBhY3R1YWwg
Q09ORklHX1NNUCBhbmQgQ09ORklHXzY0QklUIGNvbXBpbGF0aW9uIGRlcGVuZGVuY2llcw0KaW4g
dGhpcyBkcml2ZXI/IEl0IGxvb2tzIGxpa2UgdGhpcyBjb3VsZCBjb21waWxlIHdpdGhvdXQgdGhv
c2UgY29uZmlnDQpkZXBlbmRlbmNpZXMuDQoNCj4gK8KgwqDCoMKgwqDCoMKgaGVscA0KPiArwqDC
oMKgwqDCoMKgwqDCoCBFbmFibGUgc3VwcG9ydCBmb3IgSW4gRmllbGQgU2NhbiBpbiBJbnRlbCBD
UFUgdG8gcGVyZm9ybSBjb3JlDQo+ICvCoMKgwqDCoMKgwqDCoMKgIGxvZ2ljIHRlc3QgaW4gdGhl
IGZpZWxkLiBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UNCj4gK8Kg
wqDCoMKgwqDCoMKgwqAgTSBoZXJlLiBUaGUgbW9kdWxlIHdpbGwgYmUgY2FsbGVkIGludGVsX2lm
cy4NCj4gKw0KPiArwqDCoMKgwqDCoMKgwqDCoCBJZiB1bnN1cmUsIHNheSBOLg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvaWZzL01ha2VmaWxlIGIvZHJpdmVycy9w
bGF0Zm9ybS94ODYvaW50ZWwvaWZzL01ha2VmaWxlDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
IGluZGV4IDAwMDAwMDAwMDAwMC4uMDViNDkyNTQwMmI0DQo+IC0tLSAvZGV2L251bGwNCj4gKysr
IGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvaWZzL01ha2VmaWxlDQo+IEBAIC0wLDAgKzEs
NyBAQA0KPiArIw0KPiArIyBNYWtlZmlsZSBmb3IgdGhlIEluLUZpZWxkIFNjYW4gZHJpdmVyDQo+
ICsjDQo+ICsNCj4gK29iai0kKENPTkZJR19JTlRFTF9JRlMpwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKz0gaW50ZWxfaWZzLm8NCj4gKw0KPiAraW50ZWxf
aWZzLW9ianPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oDo9IGNvcmUubw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvaWZz
L2NvcmUuYyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL2lmcy9jb3JlLmMNCj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi5mYjNjODY0ZDMwODUNCj4gLS0t
IC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9pZnMvY29yZS5j
DQo+IEBAIC0wLDAgKzEsNDkgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wLW9ubHkNCj4gKy8qIENvcHlyaWdodChjKSAyMDIxIEludGVsIENvcnBvcmF0aW9uLg0KPiAr
ICoNCj4gKyAqIEF1dGhvcjogSml0aHUgSm9zZXBoIDxqaXRodS5qb3NlcGhAaW50ZWwuY29tPg0K
DQpJIGRvbid0IHNlZSBhbnkgbmVlZCB0byBpbmNsdWRlIGF1dGhvciBpbmZvIGluIHNvdXJjZSBm
aWxlcywgdGhhdCdzDQp3aGF0ICdnaXQgYmxhbWUnIGlzIGZvci4NCg0KPiArICovDQo+ICsNCj4g
KyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gKyNpbmNsdWRlIDxhc20vY3B1X2RldmljZV9p
ZC5oPg0KPiArDQo+ICsjaW5jbHVkZSAiaWZzLmgiDQo+ICsNCj4gKyNkZWZpbmUgWDg2X01BVENI
KG1vZGVsKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFwNCj4gK8KgwqDCoMKgwqDCoMKgWDg2X01BVENI
X1ZFTkRPUl9GQU1fTU9ERUxfRkVBVFVSRShJTlRFTCwgNizCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBcDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBJTlRFTF9GQU02XyMjbW9kZWws
IFg4Nl9GRUFUVVJFX0NPUkVfQ0FQQUJJTElUSUVTLCBOVUxMKQ0KPiArDQo+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IHg4Nl9jcHVfaWQgaWZzX2NwdV9pZHNbXSBfX2luaXRjb25zdCA9IHsNCj4gK8Kg
wqDCoMKgwqDCoMKgWDg2X01BVENIKFNBUFBISVJFUkFQSURTX1gpLA0KPiArwqDCoMKgwqDCoMKg
wqB7fQ0KPiArfTsNCj4gKw0KPiArTU9EVUxFX0RFVklDRV9UQUJMRSh4ODZjcHUsIGlmc19jcHVf
aWRzKTsNCj4gKw0KPiArc3RhdGljIGludCBfX2luaXQgaWZzX2luaXQodm9pZCkNCj4gK3sNCj4g
K8KgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IHg4Nl9jcHVfaWQgKm07DQo+ICvCoMKgwqDCoMKg
wqDCoHU2NCBpYTMyX2NvcmVfY2FwczsNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqAvKiBpZnMgY2Fw
YWJpbGl0eSBjaGVjayAqLw0KPiArwqDCoMKgwqDCoMKgwqBtID0geDg2X21hdGNoX2NwdShpZnNf
Y3B1X2lkcyk7DQo+ICvCoMKgwqDCoMKgwqDCoGlmICghbSkNCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiAtRU5PREVWOw0KPiArwqDCoMKgwqDCoMKgwqBpZiAocmRtc3Js
X3NhZmUoTVNSX0lBMzJfQ09SRV9DQVBTLCAmaWEzMl9jb3JlX2NhcHMpKQ0KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9ERVY7DQo+ICvCoMKgwqDCoMKgwqDCoGlm
ICghKGlhMzJfY29yZV9jYXBzICYgTVNSX0lBMzJfQ09SRV9DQVBTX0lOVEVHUklUWSkpDQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT0RFVjsNCj4gKw0KPiArwqDC
oMKgwqDCoMKgwqByZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgX19leGl0IGlm
c19leGl0KHZvaWQpDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqDCoHByX2luZm8oInVubG9hZGVkICdJ
bi1GaWVsZCBTY2FuJyBtb2R1bGVcbiIpOw0KPiArfQ0KPiArDQo+ICtNT0RVTEVfTElDRU5TRSgi
R1BMIik7DQo+ICtNT0RVTEVfSU5GTyhuYW1lLCAiaWZzIik7DQo+ICtNT0RVTEVfREVTQ1JJUFRJ
T04oImlmcyIpOw0KDQpKdXN0IG9taXQgTU9EVUxFX0lORk8gYW5kIE1PRFVMRV9ERVNDUklQVElP
TiBpZiBub3RoaW5nIG9mIGltcG9ydGFuY2UNCm5lZWRzIHRvIGJlIGFkZGVkLg0KDQo+ICttb2R1
bGVfaW5pdChpZnNfaW5pdCk7DQo+ICttb2R1bGVfZXhpdChpZnNfZXhpdCk7DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9pZnMvaWZzLmggYi9kcml2ZXJzL3BsYXRm
b3JtL3g4Ni9pbnRlbC9pZnMvaWZzLmgNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi5mM2Y5MjRmY2VkMDYNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2
ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9pZnMvaWZzLmgNCj4gQEAgLTAsMCArMSwxNCBAQA0KPiAr
LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSAqLw0KPiArLyogQ29weXJp
Z2h0KGMpIDIwMjEgSW50ZWwgQ29ycG9yYXRpb24uDQo+ICsgKg0KPiArICogQXV0aG9yOiBKaXRo
dSBKb3NlcGggPGppdGh1Lmpvc2VwaEBpbnRlbC5jb20+DQo+ICsgKi8NCj4gKw0KPiArI2lmbmRl
ZiBfSUZTX0hfDQo+ICsjZGVmaW5lIF9JRlNfSF8NCj4gKw0KPiArLyogVGhlc2UgYml0cyBhcmUg
aW4gdGhlIElBMzJfQ09SRV9DQVBBQklMSVRJRVMgTVNSICovDQo+ICsjZGVmaW5lIE1TUl9JQTMy
X0NPUkVfQ0FQU19JTlRFR1JJVFlfQklUwqDCoMKgwqDCoMKgwqAyDQo+ICsjZGVmaW5lIE1TUl9J
QTMyX0NPUkVfQ0FQU19JTlRFR1JJVFnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQklUKE1TUl9JQTMy
X0NPUkVfQ0FQU19JTlRFR1JJVFlfQklUKQ0KDQpJcyB0aGlzIGhlYWRlciBnb2luZyB0byBncm93
IGFueSBtb3JlIGRlZmluaXRpb25zPyBPdGhlcndpc2UgdGhlc2UgMg0KbGluZXMgY2FuIGp1c3Qg
bW92ZSBpbnRvIHRoZSBzb3VyY2UgZmlsZS4NCg0K
