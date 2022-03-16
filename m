Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2974DABF1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354264AbiCPHnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354276AbiCPHmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:42:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3289C60A9E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647416499; x=1678952499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FXsycBrzwEaTUfn7wHJlJOYwWhr1bB3FPiF2QIFKu+U=;
  b=bEbuS8ZCLe3zqlqRExWptZmxyQHAE2HlDIqVc1RCbJ2F9pwoQya5Vvyx
   MozGDO8V6KRpZhyCO6FZDXtA21CYzJpdai+whDYsffABm9opyXh9rxYWf
   PFfnEvcVPZLIY7ZN/FNeWhBKqY3OGXzbYfew/IJxtAkJpbr5vCRG3G+PM
   g809Rh65TNVkmZaPvDmd93hc6rsNVYcrJArO8CK+BOQyHDSOf6cvBJEcd
   d3vCw4ox7Gjbfry2pAoFXmwxBpLcAktHzwtTPqtKMXZG561CnUgRt3AdL
   amqNWu0cqgwlkfiPWr85Xa7BrM6FL8vSDtSxxvhtmcaY1hkICDGI/qk/E
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342945895"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="342945895"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 00:41:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="598613916"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 16 Mar 2022 00:41:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 00:41:38 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 00:41:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 00:41:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 00:41:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhqmXzsRVUpVU4hQinG8H6vhkAtXGvz33o7xiL6sW8MaIfjhGmiCa09jnSAYaXNsaMbCXaARqPY6G/eawnbebSQ75uR0x5xk22wILltXInuRB/lzkYZzl7GVKsrZ0CNjNEacnBzh+0b+w51bZsshLe6mBGNsPo1snVDzNThr/IzW7B9X3WQIVd7iOPsDujHzTZVlvavvs/rXTbL7A7UrRWFJIZYAJjJIOg6eOYN6mKLjO1o0KbmycUdqfcKhOMk1u3NqElyg8PDXHkkSmaZS8iz6D9ro/oJlYMUcQS7Gr8qFdecUXyXLL9icljqql6Dfd465UQ/xbNWJysN/6o8E1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXsycBrzwEaTUfn7wHJlJOYwWhr1bB3FPiF2QIFKu+U=;
 b=ZbhvIlyIr4vyGYTnzXOs0jRtnmZZGsVumJWzCU/hWISx22rto+arVKICrVAPik4NOlczCNZsvnPzUCLKgxV8BpPH8KfLBTJjVgZTLz1cSQfnv2Vvm3wSviVvFOPZf02q5rUxwELh/LBQLWXOyYVeLV1GsENqzT6axBs0DQ8OpbbKWn5p+IDsqKU0QyoROBCjXK27rN1j3Gm0ADqBWwy9q8OGycNVRIe7yUs8X1pk79tX3/efYAjPk7nULZpea0bOZCuRNvPi4JOrmwn6jvja7VPGMuqz+ZA8r7O9mDsLnLfg8ADYqOgs55eH+BPsj9Fxb9yQ4YyHBkNAcqL8bAdgqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN6PR11MB2653.namprd11.prod.outlook.com (2603:10b6:805:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Wed, 16 Mar
 2022 07:41:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893%8]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 07:41:35 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Thread-Topic: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Thread-Index: AQHYOCoddoPAbs8qR0GMuSnaaH7P9KzAguoAgAEeqfA=
Date:   Wed, 16 Mar 2022 07:41:34 +0000
Message-ID: <BN9PR11MB5276E98AE37EA912B01EB0B68C119@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <20220315143322.GW11336@nvidia.com>
In-Reply-To: <20220315143322.GW11336@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17ea5ec2-5de5-4a00-7d33-08da07206589
x-ms-traffictypediagnostic: SN6PR11MB2653:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <SN6PR11MB265333C213FD93A510539A248C119@SN6PR11MB2653.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0xbu9SNYJXqYo8v2538s07jIY1t0BOo1DFcIqrpcvWWDGcZkhgIaQ9v5rHidPBPLVhEp8WICu6FQuBbQL39s0cyaqvqVPFJjQaggBsJwBYUzLXmdcwh++H8GBH+hwz9E3DEWB41zMhuZrvj80mMfX0t9uKhZx71iDAa7yB5cuLOoXkfWd6Nz4qGoBxGe2HgkOV+REoQLTndWQcDqH+MeirUCi4533gP4b6pr39hkkN7IVHVVZHMdFC/XY8eXuip3NRzmggz3WMAVOAfwWrSS7RqQ6xJF55RfYPeh+ODjha8ED6/jD+3BRYGTmIIfJ0zapNEPjzXZWejnUe+S3/9qlUAE5Cr0dph78zusYkFckbkGBFyHwqRJs5VtcuT1Vq684EefLpfOZF0EB4nl6B7uu+sXXWxXKdpf5Qt43IBa68kZZmq8KhyBUAhD2f4rsdScHlTeLRqmXw/66GmpRBoSvzRhdqFW/gjyvi5dCY5SzNjYEhGYOCBzf7s32+xgJPVXbpPjSCvWp6EIJxfj7vqmGkbQP+b14uxjhvnl3ZgoaECsVjhfpUjDDhTryOZazcj3F7JXQNiGkCYmejGx/iiLV5Q3Qois6cDwgGrj9swQeWswxxQ8uyxY4fyJP4N31+NGm4HHIFcsFAN1iLeVeA034AA184kZ/wAQB8FkNtuYqhnAPsk70dHaqsh3ZA1q1MPfeQj94/pTswtzes/sn0wO4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(316002)(110136005)(55016003)(54906003)(4744005)(82960400001)(26005)(186003)(38070700005)(508600001)(52536014)(2906002)(5660300002)(8676002)(86362001)(9686003)(33656002)(8936002)(6506007)(7696005)(4326008)(71200400001)(122000001)(66446008)(66476007)(64756008)(66946007)(66556008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEVzQWJzZFRobjBFMHpDR2trci8raTI2SWM4THNLQjcycVpzQVpSNTVla3Uy?=
 =?utf-8?B?ZjJ5OHFJZ2M5azcyY1AzZHQ4Q3VvR3RyNDFEdkpSa3FDMktJWlFjWmgxdnNB?=
 =?utf-8?B?Y3hKNzZPNDB0aFBjUFZhRGkvRVl1ekZpRTROeWhpeXhnUXF4SXBxaXQvNlpk?=
 =?utf-8?B?MnFzK2MyelBGNzV6R0hrbW1mVHpBTzJXOXNpVkpsWXV6VlJJNFA4Z1ovWGVX?=
 =?utf-8?B?V0pBRStLQytsVXAwUXE5bHV4Q25VMWUyNzBpNVBRMkdhc1g1MVZ0N3ZsanIy?=
 =?utf-8?B?ZUVWWE85QSsyRGl3WUk5NW5Pc3locXRsNUZBeDR3UlY3aHExVHVxSXFsUDVR?=
 =?utf-8?B?Y2tpc3FweUNoYUdMOVU0MUtwTkwyMG9MaEpsb2poeEZtNHlrcUlDdExZZVFC?=
 =?utf-8?B?R0FsR2I2OGJQMDQ5bjUzcVFSSzFXc0VNNXZGNXFyc0VQZ3VVVWhOVGVsUW04?=
 =?utf-8?B?NlNjZUFOTkpSbEp6am9MQllMMEd5b3pYUTlMOGVrSjZ2QXFpOForNE8wbnVm?=
 =?utf-8?B?YXlSeE9zNzB1c3hDM2xua3g0UEdzclp1dXphVXBOQVErb0pnc1czenpTODFH?=
 =?utf-8?B?Z3ZEbFdUazhpUWt0eUk5VkxETEZCUzlvTzNuTm5jL3U3R25HWGVwOGl3cFpQ?=
 =?utf-8?B?a0MzNnlFTHBrTnhFVWZpQ05Dd2RpR0FreFlwZlpDMFBDNjIwUmUyaEFJU3dP?=
 =?utf-8?B?dUNYRExSR3M4cE93VWRnVWNhNlFQSUttcWVIZjdGZHBxTzZnbkVtSTJJZEgx?=
 =?utf-8?B?ZXcwTGQ5SnBhMjhtMG1nQ3JFOTBRMXdlaWZKdUZDb2VLTW5ld05kVnpCRUFW?=
 =?utf-8?B?T0o2MVlsME9haG5kVEpCQlFidngzejhaL3EvbmRVdmZ0RVh4cjk4ajRLK1RR?=
 =?utf-8?B?dHZWNkJYbHVrL013YW1ISitPelFvOE82Z0RYbWwvdENWWFNOb0lIalZoMzN3?=
 =?utf-8?B?dlJQR3ZmRExWTlNhMzRKbWhoRFQ3UllWVC9Eb0YwL1BISEd1MUs4QjZRS2x1?=
 =?utf-8?B?d3B5ZUlXUm9oNzQzTkE4ZXFITGdHTHh4MXVuaFR3b0NKeXAyZHROMXhEdGh5?=
 =?utf-8?B?Y2JPdVhjL2tsSG1YSWZrNmVzdktrZEcxbm9YSmZobWxST1lLOWwvZTVWekNK?=
 =?utf-8?B?UXRQVFpOZjVCN0N6cG1YRFJ4dmJmSVdBVTM4MnJOejVsL3hvOFlta1NUdkVy?=
 =?utf-8?B?Tmx2REN2Q2s3OVQyWjJ5SEE3WVNYakpMZFA0OUNnc1FZK2JkYlBpV2ZMa1JS?=
 =?utf-8?B?M0hkR21SNVp5bnZMSnVKd29SbDZFRVpER0hJYTBCcG9FUGUyVGRtbnNvL0dj?=
 =?utf-8?B?TnpwTFhBQk1qN3p1TjUvcm1hNWxLYU1BV0NpV3RDN2R0NGNUM0xEV2F1b2lK?=
 =?utf-8?B?ZUliVVpTY1NJY203bUVDSDhzSDlHTmptdFdXcXJIUm1sSWpZdTdHcnZEUWZv?=
 =?utf-8?B?SlN1T2ovMzVvTVJFODcrN3NCbFg5WVYrbTAybjlBcFNGSEduTUVXL0JCc1Jr?=
 =?utf-8?B?aHcyOG9ZU3NIcVN6by9HQ0g3MGFVdStNM0ZFSmdrQUljTWxvMzRENjlpcnZR?=
 =?utf-8?B?bFRlSERJYUJhMjRCanl0VXpjaFhPVXN2QXhoK2kza2QyZzd0V2x6ZXpGYjNv?=
 =?utf-8?B?bGxncFY1OHY0aTFSWGdhNEdYRzVsVmJWOVdveXpkVFFJMUZTVTh6d0JkK1d3?=
 =?utf-8?B?U1JPWkJncWthdG5pVTlydHlQZHEydlVzWkVNVGllKzVqaGdlWk9YMmZNSml5?=
 =?utf-8?B?T25WWFZnZmo3S3p6VXpoMGVic0lrZ2Q1ZWIvVkFMK0lFSVFNRDQzak1tekJM?=
 =?utf-8?B?N01RNUNJV2tVYThpZmYyWThPZVZrZThCQmg5RW5kWjNQa3YyclAyM0NPWHN5?=
 =?utf-8?B?d1NBT0NMbTZQbkVaZGVwNTZLdDZzUzl2WTVRdk40MWdiSFBTMHNIdkRBQnJE?=
 =?utf-8?Q?88rzdXz6EQEawmNjT9VoArnY6IiiqFyx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ea5ec2-5de5-4a00-7d33-08da07206589
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 07:41:34.8329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvW12QuzBKd1c0bZCkdXAMTHSri8JdwhZbD9kelB88wNTJl+bnayV9eVXglzGabjmAZ9FtRMy2zkjiPVukn+9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2653
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBNYXJjaCAxNSwgMjAyMiAxMDozMyBQTQ0KPiANCj4gT24gTW9uLCBNYXIgMTQsIDIwMjIgYXQg
MTA6MDc6MDdQTSAtMDcwMCwgSmFjb2IgUGFuIHdyb3RlOg0KPiA+ICsJLyoNCj4gPiArCSAqIEVh
Y2ggZG9tYWluIGNvdWxkIGhhdmUgbXVsdGlwbGUgZGV2aWNlcyBhdHRhY2hlZCB3aXRoIHNoYXJl
ZCBvcg0KPiBwZXINCj4gPiArCSAqIGRldmljZSBQQVNJRHMuIEF0IHRoZSBkb21haW4gbGV2ZWws
IHdlIGtlZXAgdHJhY2sgb2YgdW5pcXVlIFBBU0lEcw0KPiBhbmQNCj4gPiArCSAqIGRldmljZSB1
c2VyIGNvdW50Lg0KPiA+ICsJICogRS5nLiBJZiBhIGRvbWFpbiBoYXMgdHdvIGRldmljZXMgYXR0
YWNoZWQsIGRldmljZSBBIGhhcyBQQVNJRCAwLCAxOw0KPiA+ICsJICogZGV2aWNlIEIgaGFzIFBB
U0lEIDAsIDIuIFRoZW4gdGhlIGRvbWFpbiB3b3VsZCBoYXZlIFBBU0lEIDAsIDEsIDIuDQo+ID4g
KwkgKi8NCj4gDQo+IEEgMmQgYXJyYXkgb2YgeGFycmF5J3Mgc2VlbXMgbGlrZSBhIHBvb3IgZGF0
YSBzdHJ1Y3R1cmUgZm9yIHRoaXMgdGFzay4NCg0KYmVzaWRlcyB0aGF0IGl0IGFsc28gZG9lc24n
dCB3b3JrIHdoZW4gd2Ugc3VwcG9ydCBwZXItZGV2aWNlIFBBU0lEIGFsbG9jYXRpb24NCmluIHRo
ZSBmdXR1cmUuIEluIHRoYXQgY2FzZSBtZXJnaW5nIGRldmljZSBQQVNJRHMgdG9nZXRoZXIgaXMg
Y29uY2VwdHVhbGx5DQp3cm9uZy4NCg0KPiANCj4gQUZBQ0lUIHRoaXMgd2FudHMgdG8gc3RvcmUg
YSBsaXN0IG9mIChkZXZpY2UsIHBhc2lkKSB0dXBsZXMsIHNvIGENCj4gc2ltcGxlIGxpbmtlZCBs
aXN0LCAxZCB4YXJyYXkgdmVjdG9yIG9yIGEgcmVkIGJsYWNrIHRyZWUgc2VlbXMgbW9yZQ0KPiBh
cHByb3ByaWF0ZS4uDQo+IA0KDQp0aGlzIHR1cGxlIGNhbiB3ZWxsIHNlcnZlIHBlci1kZXZpY2Ug
UEFTSUQuIPCfmIoNCg0KVGhhbmtzDQpLZXZpbg0K
