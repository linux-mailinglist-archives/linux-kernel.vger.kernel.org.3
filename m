Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EBD547F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiFMGgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiFMGgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:36:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4256EB874
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655102207; x=1686638207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BpysRxNBGAw3kIOBBlWFzXnUzZEvkZtGfyy8U4VT0PQ=;
  b=P2qn7n5XvUeFBHeLXrNGedLcTrRSTOIPpNqNGiIb7H91ej2NAMlS2UgT
   eBuZiE4642DPAqHoj8YldAlQ9oRTu8P4JIxAO1hgEioNAnL48Q34YlgxN
   IEsGQiEUEjoQz2/VXf5YdKQBqPNWiA8B2b8biV7rI8FyK0hONo5jxnmWP
   LdYLkx8TDQsgVhJpMDGjgXuzZIaGM7QHTSOEJ2J99f+HYtNxlAm19ivOg
   BuEtrWYn6LhBCQzecrAbAOdlF6ZfKnEvqOB2LwfhL0pfEEH59RZQzLuNS
   HWcANXTFXvV18SIEWzz6zaIlriJ1ASkrCzIJEToNCQxOEnmwV5ht8Dsyn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="258624591"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="258624591"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 23:36:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="829635685"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jun 2022 23:36:46 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 12 Jun 2022 23:36:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 12 Jun 2022 23:36:46 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 12 Jun 2022 23:36:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjM4Bey3wUF+V084LWCeZynQ5GB7391/DC4jAT8fw2oBTikg+YJMsGfourBh5wYAZkVuwUWBsMDgkaU/Ogl9cQ1eEp7/u1AX6P16GolOEzd3ODPkLUC/6S/apUJxXICy98ANUwquL1mTiMUopLK7McTAAIckXPjuOVlbs+7rhVp9nsYQ9l8CRzP5yYsMIX1gxmSzU+GHOR6YyEtc51tpmV0NznDLNa+BDPhki6RWERZfaPEBSsuknJ1n3KXQHLar0vhR96NLpwtrm2HFIRc34PrcAW566JAJgeJrsVQfNwolgp+Is2QGDlQUcziw/Q5Ns+zE16LUuGH97X1AIw03yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpysRxNBGAw3kIOBBlWFzXnUzZEvkZtGfyy8U4VT0PQ=;
 b=QSKG/h3J6ShcguYhmojzclYWhTCevv4jFcCo+i8NM2wfb1Y2XSaKx9j0r+AkSY9uPB6DTHATZsgHg1Px9fmxfTXEB0K5ce1PSQ5Dxr3ZqPLDJF0XJuPM4ppZ+1TnTHG0FqFphmAPDiaKBuDZjGD59eVRxIF2JasLlnErvTf58pZXhIqQgtwSQPqrQblyRsZrwz08dujzxFs2BeZhSnU94VNZWEv42kmKiUaGiwu4LC46XvkPJZChVsOA6HgmKyjJjcT1Ofgan9Sk4pNp6ecHBs3N2fmQUiu7WqDmDpHgdvKOskmrMpr2Oaw/1J6bdb7uhuXpS8thKoy9ZRSdrWta0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22)
 by MN2PR11MB4461.namprd11.prod.outlook.com (2603:10b6:208:192::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Mon, 13 Jun
 2022 06:36:44 +0000
Received: from SA2PR11MB5115.namprd11.prod.outlook.com
 ([fe80::9489:e53a:f37e:e0be]) by SA2PR11MB5115.namprd11.prod.outlook.com
 ([fe80::9489:e53a:f37e:e0be%8]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 06:36:44 +0000
From:   "R, Monish Kumar" <monish.kumar.r@intel.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: RE: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
Thread-Topic: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
Thread-Index: AQHYe9vO7iZneeeix02+6Itt57U7B61GyDHwgAAJhoCAAVlYgIAAM5uAgASGuJA=
Date:   Mon, 13 Jun 2022 06:36:44 +0000
Message-ID: <SA2PR11MB5115C9D7AE1DF332B29625B0C3AB9@SA2PR11MB5115.namprd11.prod.outlook.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com>
 <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
 <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
 <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com>
 <YqG/pybFg0P5yQ9a@zx2c4.com> <20220610061449.GD24331@lst.de>
 <YqMMo2Dv9SZRtR7B@zx2c4.com>
In-Reply-To: <YqMMo2Dv9SZRtR7B@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8eafe2e-c1da-4ef6-5074-08da4d071523
x-ms-traffictypediagnostic: MN2PR11MB4461:EE_
x-microsoft-antispam-prvs: <MN2PR11MB4461BBC39F87ED16CBD8FE92C3AB9@MN2PR11MB4461.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fPKf7icJCCfn4qlEdp6LS4kKfdm5k/ldUuS3ePSNyIQyArPEsgNhe8MPrHN9Kl9jlJYeW4zRkyetA5lq+l8kAFEx/U66xKTkD8VULSl5jEmJ/Wv/CncmYWEBpDyGjVWow3v1BKucOewxCygmWECdWEU7CysJE3bdX1jPCIW+t0Pm+FdDtlrdIdQrl1WIRiwNqdiVcu7Ke9egsXC5n7AVsboZkRdrGCRqoLbSYF5z7PLtgIIa08TwrPjZnQkkhA68Q+/6xHZtjxsICYBUfg2Vizr9iJ40BeahuwNGaKWQqMk6JxuAnS3AFyDskBAQZhm+TBRURLl0LgvquZmS46kG3AyEyZFhsNfpVUAA7JK0eIUOInApO1+1h0ZHX+GfZcZyBrGHq/2MzE2vCamCpf434f9OapbPo9MnG/lBBe7Nj1lLO+H/zFpQ6661+2EaEt9cP9ORUhfnTHaU9oDA47xrjgMQCIaI8jsno5wsIfknMm/nSbS6y6EY7E6J4IOuMzS7LCDHSdeO+dTE/UaQ5R+BbUSZ3EkwnMzlk0PHEEjLrvU+HS/C2eiRvF7GZP/LlSExAnxqioxlnAUA2G3LGrJsPbi39BA+7qWxIdjqzANR4IuUAuJ7i5UTNBc8QiiTUkRXZzrprNm6Yb/qdCuetQSDrO0rRjXmWNnPDobhwglEBBAhKmFw97QZZ0C/Zy2Cup5jyDktJrvSl4gMWOjsi2irYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5115.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66946007)(66556008)(76116006)(316002)(5660300002)(66446008)(8676002)(66476007)(64756008)(8936002)(52536014)(38100700002)(38070700005)(508600001)(122000001)(6506007)(9686003)(54906003)(71200400001)(4326008)(26005)(53546011)(6916009)(7696005)(186003)(2906002)(55016003)(83380400001)(107886003)(82960400001)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckVZYmtlcU1iOU9TNUU5QW4rTVZ2OS82RHFBRGZuR1FmM3BVTllDRkV1aXc1?=
 =?utf-8?B?bWtrWWpSUDcydzRtOHlkb1R4cE5BNGR6NTJuSDh3N3lkV3VOYXRxRExDMFdI?=
 =?utf-8?B?VDZZcW1obk5xbmFaMlRuNlExRitySHlablpWL1A0aEsvNGJKRU5IN09IMytz?=
 =?utf-8?B?dEVJQ2VhWnBBeEdWaFpzWHVvcUtmdUdHT2JXK2pZaVNrUGhSWkRnSXBYSlRw?=
 =?utf-8?B?WHZjNGFxSWR2YXQybmFQRVcrQ0ppRGxDVHVjbUoyeFZvbSt2bWpQS25vM3pE?=
 =?utf-8?B?b0JHK2FFTUtkNFdJMkJidC90ZlJyUUY1endWVHdIVFZyT0xZU3ZqVnlQUVRn?=
 =?utf-8?B?eDFQUUlWMS93TjFVM0o3MS82NmhFczhYNnp5Y3BKQVNGSkRRVldTRGRFNFVo?=
 =?utf-8?B?T2tyMzNtR2N6QnZaQjF6aGoxTUgyaTExelF5QlVOay9pVHpPcy9ZVkxLNUNi?=
 =?utf-8?B?ZEZhUkpaaWgreitGanpxSjNUQ2xHWVcrRGZVNFRXVm1vditMZ1RpYWVDMXZz?=
 =?utf-8?B?cTF1K2RSem51NVVkM0JxVzViOWF0ZFNzL3RwSEx1eTU2V0J4eXQ5clRYdngz?=
 =?utf-8?B?WmtESTNWdlVIb0t0Mlk0RHRnaGJZVVExTVN3TUJhTHI2dXF5K2FuZ2lCVEJi?=
 =?utf-8?B?eTdOblloMDZtYkkrN3JiNmtPeEhHV1NHL1RXanRvV1JMeWR1N1cvM283eHFi?=
 =?utf-8?B?QWFDOUVnK2lHR2prTE5JQzdNKy9nblZIYnVDdUdFMUljdzFFbkFLKy9qRUl2?=
 =?utf-8?B?b3B6Um0xWUhGNE9MRlJkbTEvZ3NnWS8xNGtKYnRJczdpZHVNVXYxOEt3RG5o?=
 =?utf-8?B?eGhjU3BacmtQbnVFMGdIN0tRWjBzN3kxVlcwNE04L01obXpqOVJiME1sQ3Rs?=
 =?utf-8?B?Z3RkdE9IZGhQQTRhb3FBTDN2R1JCZzIrVWxUUmZBZDFNZ0ZPbGlrdXhxeHd3?=
 =?utf-8?B?RCsvTW1heEhmV3lTc2VCTlNTSG1VbUtMWk85VUwwdUJYMXZmcWdMcm1sTDVa?=
 =?utf-8?B?ZFVIejRXKzd4cXQzUG9XN2UrNUF0N2V4K09JL2VuQ0RnZEFxUFNnSXRWeURt?=
 =?utf-8?B?cGtqR0tOUC9DN0lFYlFlcDU1YnIvbUVrb1FYKzdTT1NPVUpDWERhMHlhdmlX?=
 =?utf-8?B?VTBwODVZckVLWHZQUTBDalh2Uk9tQ3ZPS0JKbEhMQ0d1RyszY1phSVMwQ3gx?=
 =?utf-8?B?SGphQnBnZEdTanJ1bTh5Vm5pTTlvVzNWR3NIWlRjMU93ZDdlRHJKWmtqR2xL?=
 =?utf-8?B?SnNQMnJ2dTlvNFJYN2VFZVJhWVVRb09kM3pjUkVUaDNQNU5NMXpwNGJtb3lG?=
 =?utf-8?B?LzhFbEIxMFFMcDBSY3B4akY4cCtjRFgrWVdqTTJUM3pGdm44VDB4YnB2VjhM?=
 =?utf-8?B?RU5DU29teGFlcUZ0dm1NMXhvK011KzZKam56aUhsL2IwUmwyNmM5Z0lLM29P?=
 =?utf-8?B?VUU2eHQ2VDBnZGNBTXZ6cUdQbTBXT1oyL3RSZWN3c3B6Y3hHT3pHQWNmTmFj?=
 =?utf-8?B?ZjBlSlFoRVEvUmVoZW5COFpHUk5TUUJuRCswc0NiZndvU0JxOTN1bXU1MG1i?=
 =?utf-8?B?Y0Zsd3FhbnRNa2hPTkd6OXM2L1ZKRE1QeVp2WGhxNDBuYTJ4cWpxaTZ6MXZV?=
 =?utf-8?B?NXVtMFB2VlNPeUVRM0U5NmxKRXB2ekxITVdvVmVZZFNqRmZXak5sL051Z0hJ?=
 =?utf-8?B?WmdVYUFVNnVYNHpvb1kvTms0Y0VWd3hLTys2KzFpckJMUGdpRWhFZExSTHJS?=
 =?utf-8?B?Q0RCRzRzc2M4ekZZaUhqbUxuOFp2bVlZbWxLd1l5Q1piVTg2bGF0R0dzTUlu?=
 =?utf-8?B?OTViT3BDZzVOY2kvYjRQUlNQZWRNU3lvWWY1NUY1SFgwbFdwOHk5N1dmNTRB?=
 =?utf-8?B?ZkRWNDNmM2dMZnhpTktjUUVwNUliaU1GSnNXUzVkUnFoTDhaTGRjbXdnak1G?=
 =?utf-8?B?YXpqamc4UWZoeURCSU13L09CeDBXbHgyOE5YeTFueWwwWXN0ODJUazhpMVdl?=
 =?utf-8?B?WmRTcUM0UDdZYTA1ekUvUjRNY0xqeHI0Vlc3bkFibDNUQkpIMy9SV3M2czdR?=
 =?utf-8?B?b1JoZ2cwWmJrMDV4UHkrSEJrS1dDVVJIREl6R050ektVclFJZy9RNFJIRlZw?=
 =?utf-8?B?SkV3Vm0rZHNXOHV6NW81cytucGRmNkdMd3g1S3N6S1ZUSnRLcm5OQUk0T2U2?=
 =?utf-8?B?Y2hCK1NMV2ROZ1lVVUlGYUd1K1BreEVjZ3o1YzYzcjNVQU16cWphdnR5NHJV?=
 =?utf-8?B?dk9BUUYyaVpuSFlrek9WWVVBenhHb2psdDNaVTFTNUZEd1hPRUNFQm5NNk5o?=
 =?utf-8?B?MmNBKzRwcVJiMTVuenoxME9DUzFUaUdzby9oajdZTEVieGNSM1lTZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5115.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8eafe2e-c1da-4ef6-5074-08da4d071523
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 06:36:44.0935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBBmqaMl8scXktXuM4+LbpKnWIdhVeZNRU9WLngQPVrOVVlBkLHwK5W5+CsUz7z+bsGLc6T7pwGJtNCke1UB/1uKJGZw2R2vG2KKnBnJmFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4461
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXN0b3BoLA0KDQpQbGVhc2Ugc2VlIHRoZSBiZWxvdyBudm1lIGlkLWN0cmwgcmVzcG9u
c2Ugb2YgU2Ftc3VuZyBYNSBTU0QuDQoNCk5WTUUgSWRlbnRpZnkgQ29udHJvbGxlcjoNCnZpZCAg
ICAgICA6IDB4MTQ0ZA0Kc3N2aWQgICAgIDogMHgxNDRkDQpzbiAgICAgICAgOiA8cmVkYWN0ZWQ+
DQptbiAgICAgICAgOiBTYW1zdW5nIFBvcnRhYmxlIFNTRCBYNQ0KZnIgICAgICAgIDogMVAzUUVY
RTcNCnJhYiAgICAgICA6IDINCmllZWUgICAgICA6IDAwMjUzOA0KY21pYyAgICAgIDogMA0KbWR0
cyAgICAgIDogOQ0KY250bGlkICAgIDogNA0KdmVyICAgICAgIDogMTAzMDANCnJ0ZDNyICAgICA6
IDMwZDQwDQpydGQzZSAgICAgOiA3YTEyMDANCm9hZXMgICAgICA6IDANCmN0cmF0dCAgICA6IDAN
CnJybHMgICAgICA6IDANCm9hY3MgICAgICA6IDB4Nw0KYWNsICAgICAgIDogNw0KYWVybCAgICAg
IDogMw0KZnJtdyAgICAgIDogMHgxNg0KbHBhICAgICAgIDogMHgzDQplbHBlICAgICAgOiA2Mw0K
bnBzcyAgICAgIDogNA0KYXZzY2MgICAgIDogMHgxDQphcHN0YSAgICAgOiAweDENCndjdGVtcCAg
ICA6IDMyOQ0KY2N0ZW1wICAgIDogMzMwDQptdGZhICAgICAgOiAwDQpobXByZSAgICAgOiAwDQpo
bW1pbiAgICAgOiAwDQp0bnZtY2FwICAgOiA1MDAxMDc4NjIwMTYNCnVudm1jYXAgICA6IDANCnJw
bWJzICAgICA6IDANCmVkc3R0ICAgICA6IDANCmRzdG8gICAgICA6IDANCmZ3dWcgICAgICA6IDAN
CmthcyAgICAgICA6IDANCmhjdG1hICAgICA6IDANCm1udG10ICAgICA6IDANCm14dG10ICAgICA6
IDANCnNhbmljYXAgICA6IDANCmhtbWluZHMgICA6IDANCmhtbWF4ZCAgICA6IDANCm5zZXRpZG1h
eCA6IDANCnNxZXMgICAgICA6IDB4NjYNCmNxZXMgICAgICA6IDB4NDQNCm1heGNtZCAgICA6IDAN
Cm5uICAgICAgICA6IDENCm9uY3MgICAgICA6IDB4MWYNCmZ1c2VzICAgICA6IDANCmZuYSAgICAg
ICA6IDB4NQ0KdndjICAgICAgIDogMHgxDQphd3VuICAgICAgOiAxMjcNCmF3dXBmICAgICA6IDAN
Cm52c2NjICAgICA6IDENCmFjd3UgICAgICA6IDANCnNnbHMgICAgICA6IDANCnN1Ym5xbiAgICA6
DQppb2Njc3ogICAgOiAwDQppb3Jjc3ogICAgOiAwDQppY2RvZmYgICAgOiAwDQpjdHJhdHRyICAg
OiAwDQptc2RiZCAgICAgOiAwDQpwcyAgICAwIDogbXA6Ni4yMFcgb3BlcmF0aW9uYWwgZW5sYXQ6
MCBleGxhdDowIHJydDowIHJybDowDQogICAgICAgICAgcnd0OjAgcndsOjAgaWRsZV9wb3dlcjot
IGFjdGl2ZV9wb3dlcjotDQpwcyAgICAxIDogbXA6NC4zMFcgb3BlcmF0aW9uYWwgZW5sYXQ6MCBl
eGxhdDowIHJydDoxIHJybDoxDQogICAgICAgICAgcnd0OjEgcndsOjEgaWRsZV9wb3dlcjotIGFj
dGl2ZV9wb3dlcjotDQpwcyAgICAyIDogbXA6Mi4xMFcgb3BlcmF0aW9uYWwgZW5sYXQ6MCBleGxh
dDowIHJydDoyIHJybDoyDQogICAgICAgICAgcnd0OjIgcndsOjIgaWRsZV9wb3dlcjotIGFjdGl2
ZV9wb3dlcjotDQpwcyAgICAzIDogbXA6MC4wNDAwVyBub24tb3BlcmF0aW9uYWwgZW5sYXQ6MjEw
IGV4bGF0OjEyMDAgcnJ0OjMgcnJsOjMNCiAgICAgICAgICByd3Q6MyByd2w6MyBpZGxlX3Bvd2Vy
Oi0gYWN0aXZlX3Bvd2VyOi0NCnBzICAgIDQgOiBtcDowLjAwNTBXIG5vbi1vcGVyYXRpb25hbCBl
bmxhdDoyMDAwIGV4bGF0OjgwMDAgcnJ0OjQgcnJsOjQNCiAgICAgICAgICByd3Q6NCByd2w6NCBp
ZGxlX3Bvd2VyOi0gYWN0aXZlX3Bvd2VyOi0NCg0KUmVnYXJkcywNCk1vbmlzaCBLdW1hciBSDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYXNvbiBBLiBEb25lbmZlbGQgPEph
c29uQHp4MmM0LmNvbT4gDQpTZW50OiAxMCBKdW5lIDIwMjIgMTQ6NTANClRvOiBDaHJpc3RvcGgg
SGVsbHdpZyA8aGNoQGxzdC5kZT4NCkNjOiBSLCBNb25pc2ggS3VtYXIgPG1vbmlzaC5rdW1hci5y
QGludGVsLmNvbT47IG9wZW4gbGlzdDpOVk0gRVhQUkVTUyBEUklWRVIgPGxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZz47IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+OyBhbGFu
LmFkYW1zb25Ab3JhY2xlLmNvbTsgTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47
IFlpIFpoYW5nIDx5aS56aGFuZ0ByZWRoYXQuY29tPjsgS2VpdGggQnVzY2ggPGtidXNjaEBrZXJu
ZWwub3JnPjsgYXhib2VAZmIuY29tOyBSYW8sIEFiaGlqZWV0IDxhYmhpamVldC5yYW9AaW50ZWwu
Y29tPg0KU3ViamVjdDogUmU6IDIgc2Vjb25kIG52bWUgaW5pdGlhbGl6YXRpb24gZGVsYXkgcmVn
cmVzc2lvbiBpbiA1LjE4IFtXYXM6IFJlOiBbYnVnIHJlcG9ydF1udm1lMDogQWRtaW4gQ21kKDB4
NiksIEkvTyBFcnJvciAoc2N0IDB4MCAvIHNjIDB4MikgTU9SRSBETlIgb2JzZXJ2ZWQgZHVyaW5n
IGJsa3Rlc3RzXQ0KDQpIaSBDaHJpc3RvcGgsDQoNCk9uIEZyaSwgSnVuIDEwLCAyMDIyIGF0IDA4
OjE0OjQ5QU0gKzAyMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBUaGF0IGxlYXZlcyB1
cyB3aXRoIHR3byBwbGF1c2libGUgdGhlb3JpZXM6DQo+IA0KPiAgLSB0aGUgcHJvYmxlbXMgY291
bGQgYmUgZHVlIHRvIGFuIGVhcmxpZXIgZmlybXdhcmUgdmVyc2lvbiBvcg0KPiAgICBBU0lDIHN0
ZXBwaW5nDQo+ICAtIHRoZSBwcm9ibGVtcyBhcmUgZHVlIHRvIHRoZSB0aHVuZGVyYm9sdCBhdHRh
Y2htZW50DQoNClJpZ2h0LCB0aGF0IHNlZW1zIGxpa2UgdGhlIHNldCBvZiB2YXJpYW5jZSB3ZSdy
ZSBkZWFsaW5nIHdpdGguIElmIGl0J3MgYSBmaXJtd2FyZSB2ZXJzaW9uIGlzc3VlLCB0aGVuIHdl
IHJldmVydCBiZWNhdXNlIHBlb3BsZSBjYW4gdXBkYXRlPyBPciBjYW4gd2UgcXVpcmsgZmlybXdh
cmUgdmVyc2lvbiBudW1iZXJzIHRvbz8gSWYgaXQncyBBU0lDIHN0ZXBwaW5nLCBJIGd1ZXNzIHdl
IG5lZWQgdG8gcXVpcmsgdGhhdC4gQW5kIGxpa2V3aXNlIHRodW5kZXJib2x0LCBidXQgdGhhdCBz
ZWVtcyBtb3JlIGF3a3dhcmQgdG8gcXVpcmsgYXJvdW5kLCBiZWNhdXNlIGFmYWlrLCBpdCBhbGwg
anVzdCBhcHBlYXJzIGFzIFBDSWU/DQoNCj4gTW9uaXNoIGFuZCBKYXNvbiwgY2FuIHlvdSBwbGVh
c2Ugc2VuZCBtZSB0aGUgb3V0cHV0IG9mIG52bWUgaWQtY3RybCANCj4gL2Rldi9udm1lWCAod2hl
cmUgL2Rldi9udm1lWCBpcyB0aGUgYWN0dWFsIGRldmljZSBudW1iZXIpPw0KDQpOVk1FIElkZW50
aWZ5IENvbnRyb2xsZXI6DQp2aWQgICAgICAgOiAweDE0NGQNCnNzdmlkICAgICA6IDB4MTQ0ZA0K
c24gICAgICAgIDogPHJlZGFjdGVkPg0KbW4gICAgICAgIDogU2Ftc3VuZyBTU0QgOTcwIEVWTyBQ
bHVzIDJUQiAgICAgICAgICAgIA0KZnIgICAgICAgIDogMkIyUUVYTTcNCnJhYiAgICAgICA6IDIN
CmllZWUgICAgICA6IDAwMjUzOA0KY21pYyAgICAgIDogMA0KbWR0cyAgICAgIDogOQ0KY250bGlk
ICAgIDogMHg0DQp2ZXIgICAgICAgOiAweDEwMzAwDQpydGQzciAgICAgOiAweDMwZDQwDQpydGQz
ZSAgICAgOiAweDdhMTIwMA0Kb2FlcyAgICAgIDogMA0KY3RyYXR0ICAgIDogMA0KcnJscyAgICAg
IDogMA0KY250cmx0eXBlIDogMA0KZmd1aWQgICAgIDogDQpjcmR0MSAgICAgOiAwDQpjcmR0MiAg
ICAgOiAwDQpjcmR0MyAgICAgOiAwDQpudm1zciAgICAgOiAwDQp2d2NpICAgICAgOiAwDQptZWMg
ICAgICAgOiAwDQpvYWNzICAgICAgOiAweDE3DQphY2wgICAgICAgOiA3DQphZXJsICAgICAgOiAz
DQpmcm13ICAgICAgOiAweDE2DQpscGEgICAgICAgOiAweDMNCmVscGUgICAgICA6IDYzDQpucHNz
ICAgICAgOiA0DQphdnNjYyAgICAgOiAweDENCmFwc3RhICAgICA6IDB4MQ0Kd2N0ZW1wICAgIDog
MzU4DQpjY3RlbXAgICAgOiAzNTgNCm10ZmEgICAgICA6IDANCmhtcHJlICAgICA6IDANCmhtbWlu
ICAgICA6IDANCnRudm1jYXAgICA6IDIwMDAzOTg5MzQwMTYNCnVudm1jYXAgICA6IDANCnJwbWJz
ICAgICA6IDANCmVkc3R0ICAgICA6IDM1DQpkc3RvICAgICAgOiAwDQpmd3VnICAgICAgOiAwDQpr
YXMgICAgICAgOiAwDQpoY3RtYSAgICAgOiAweDENCm1udG10ICAgICA6IDM1Ng0KbXh0bXQgICAg
IDogMzU4DQpzYW5pY2FwICAgOiAwDQpobW1pbmRzICAgOiAwDQpobW1heGQgICAgOiAwDQpuc2V0
aWRtYXggOiAwDQplbmRnaWRtYXggOiAwDQphbmF0dCAgICAgOiAwDQphbmFjYXAgICAgOiAwDQph
bmFncnBtYXggOiAwDQpuYW5hZ3JwaWQgOiAwDQpwZWxzICAgICAgOiAwDQpkb21haW5pZCAgOiAw
DQptZWdjYXAgICAgOiAwDQpzcWVzICAgICAgOiAweDY2DQpjcWVzICAgICAgOiAweDQ0DQptYXhj
bWQgICAgOiAwDQpubiAgICAgICAgOiAxDQpvbmNzICAgICAgOiAweDVmDQpmdXNlcyAgICAgOiAw
DQpmbmEgICAgICAgOiAweDUNCnZ3YyAgICAgICA6IDB4MQ0KYXd1biAgICAgIDogMTAyMw0KYXd1
cGYgICAgIDogMA0KaWNzdnNjYyAgICAgOiAxDQpud3BjICAgICAgOiAwDQphY3d1ICAgICAgOiAw
DQpvY2ZzICAgICAgOiAwDQpzZ2xzICAgICAgOiAwDQptbmFuICAgICAgOiAwDQptYXhkbmEgICAg
OiAwDQptYXhjbmEgICAgOiAwDQpzdWJucW4gICAgOiANCmlvY2NzeiAgICA6IDANCmlvcmNzeiAg
ICA6IDANCmljZG9mZiAgICA6IDANCmZjYXR0ICAgICA6IDANCm1zZGJkICAgICA6IDANCm9mY3Mg
ICAgICA6IDANCnBzICAgIDAgOiBtcDo3LjUwVyBvcGVyYXRpb25hbCBlbmxhdDowIGV4bGF0OjAg
cnJ0OjAgcnJsOjANCiAgICAgICAgICByd3Q6MCByd2w6MCBpZGxlX3Bvd2VyOi0gYWN0aXZlX3Bv
d2VyOi0NCnBzICAgIDEgOiBtcDo1LjkwVyBvcGVyYXRpb25hbCBlbmxhdDowIGV4bGF0OjAgcnJ0
OjEgcnJsOjENCiAgICAgICAgICByd3Q6MSByd2w6MSBpZGxlX3Bvd2VyOi0gYWN0aXZlX3Bvd2Vy
Oi0NCnBzICAgIDIgOiBtcDozLjYwVyBvcGVyYXRpb25hbCBlbmxhdDowIGV4bGF0OjAgcnJ0OjIg
cnJsOjINCiAgICAgICAgICByd3Q6MiByd2w6MiBpZGxlX3Bvd2VyOi0gYWN0aXZlX3Bvd2VyOi0N
CnBzICAgIDMgOiBtcDowLjA3MDBXIG5vbi1vcGVyYXRpb25hbCBlbmxhdDoyMTAgZXhsYXQ6MTIw
MCBycnQ6MyBycmw6Mw0KICAgICAgICAgIHJ3dDozIHJ3bDozIGlkbGVfcG93ZXI6LSBhY3RpdmVf
cG93ZXI6LQ0KcHMgICAgNCA6IG1wOjAuMDA1MFcgbm9uLW9wZXJhdGlvbmFsIGVubGF0OjIwMDAg
ZXhsYXQ6ODAwMCBycnQ6NCBycmw6NA0KICAgICAgICAgIHJ3dDo0IHJ3bDo0IGlkbGVfcG93ZXI6
LSBhY3RpdmVfcG93ZXI6LQ0KDQpKYXNvbg0K
