Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508454F61F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbiDFO3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbiDFO26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:28:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA3821B418
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649241897; x=1680777897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aychiyOSAjDiKbfpHo74G/ZESe5MIQMSsUVbe2SMkb8=;
  b=BZnqAn+oQ+CPukhoD7nTbZenyzff8nRB10XCWblVzegE1bER4IEGujlI
   +14ulJILu/io1fHU0BdqPfCZEVU5UcWv1XBzXlDrskzqo8ZiA1npC91bk
   +O1PGO7jFGWtY8raMX840l9ShJvwb23BYZzdIeCS8BHrbSAXewDfq9oGf
   QuZElPqt1tOW1vuUhm1PI2PTW1i1eRtcKFfgLy6v5o43z4IZl4t158QEF
   /6ROPANRP+Z+2wSyeiBucuLUpwQvVhRYEP4SmnY+wsHdMFYJuVj8pXGU7
   VxNOUkyavl7D5CXzvUIMCCWLx0B6PUQL5jRJdVwha/nwI0joMQQh7ti84
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="261005797"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="261005797"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 03:44:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="524417281"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 06 Apr 2022 03:44:56 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 03:44:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Apr 2022 03:44:56 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Apr 2022 03:44:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSpWDkWi9AcJ4MqFxlvn6qrnjSdDnR13mmqkTmnSm94xEkK4WWiMZVb5eIx3vqAn/qAmhqzQXUcPSKfFA7X4Kn90gQg2R5nsCQbfRcAITel3/e09d6cQIG5d3L14AWK5WQmtC59WvDT+VwbLJH5VCeEb343u2/jd0jgdZxkutTL6Q0R49K95VbC6T85whzo9yGZ1k5qcUJjOfGoBteuW6pUGzVYDBtCIiZ0SLyzglkNqixD7FcxaW4un1PD+15XRtuNyJsOVeGcpwHKzpO+tbdjvM4aJeciuqyi7ZGu7CaFggzZigEAs1hydXjHM1ZV2g8hLidaz+aDM70u1TbHPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aychiyOSAjDiKbfpHo74G/ZESe5MIQMSsUVbe2SMkb8=;
 b=ogVChLy6AYLxo3+uL1MXQ9ZvudMHuf+ZxzBkxJA3BK0Nm1CbL28++niZA1EWUzAJ3IZtS/vV7s3QpuRIiD1f2huL6Tls2BMtv96cEA2E+x569UBsFedv5Aj24s2fsKUdMaw/SU/a5qOU1vMQKSgm9Ockcl+uU8zrr7burZHGjjBZBhQhh7XKdx6wAycYSff8PLzNOzz7qPFXCOTyav1R8xZQdCrWmbFBm33mQOaSzwELzEaQLPdSk0IHwXkXwmK0Y+TKt73cIXSkBBbK5ij1B9dY3wWbpp1+WSINdt1UzhOvbHvDCQilkW8f7J9UDOfXp3eF/Ey99aIEn4vM2q2jQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5460.namprd11.prod.outlook.com (2603:10b6:610:d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 10:44:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 10:44:54 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "Alex Williamson (alex.williamson@redhat.com)" 
        <alex.williamson@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Topic: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Index: AQHYQy+FyOvFomDYNUS+m4eyrODKe6zWBZTwgAA4VICAASjOcIAAbdAAgAAjg7CAAAbnAIAELxCggAaGagCAAAkkMA==
Date:   Wed, 6 Apr 2022 10:44:54 +0000
Message-ID: <BN9PR11MB527646AB4F3FE8E9F97ECB8D8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com>
 <BN9PR11MB527691E38BAC4F89FB17BDB98C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330143008.GB2111031@nvidia.com>
 <BL1PR11MB52718E663EF48C45D97FEEF38CE39@BL1PR11MB5271.namprd11.prod.outlook.com>
 <821dc298-47fb-6d06-ba75-de5d62a97b7a@linux.intel.com>
In-Reply-To: <821dc298-47fb-6d06-ba75-de5d62a97b7a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96470ac2-43c1-45dc-a2f8-08da17ba7c37
x-ms-traffictypediagnostic: CH0PR11MB5460:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH0PR11MB54609D23AF8DE80131389C978CE79@CH0PR11MB5460.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OQgrhdb53WOG71omzltmNOlFs6ZF2He9VyUvlF5nWIe2HBd4l5lQjezK0urXJIvyR9n/uXP6bddo9fB1z1FhgC2uWMr3N6XgwhCczLFtGPaRXJEY7M7Lmc7kREIQQG7E/eSHWV8jSrAypCyq1+foDjEa23SlIt5s+hxUV0q8nPDYZSrquQ8b0xSsZPhCaASBSOHSt1HrcMFo7qXRlWCEUXtTKtqKen0GFHW7yY+fEzarUkt1TZQFRe6MzNi253c2TDyGg3HmB5v2mwhHA8CMR9rszpEq/7CghRN/3ouhKbBjaEB4rkabWIJGNOu5jvVwBXcaKg1OKmF4e/H7tQF4oDDPvWyuooqrKeaPVWWEACgKZYSln6TaG7hx16dBrQcgAlkkafzhqJK7nmfvxzgMtonCytlzDg5GIrd+veqORNGLcd6uto2QPm5VLQ7kCQl0TQMMgyH3HMFPNke+b9CpIru4sF6W5Z5/RFlBDRFVAJ5bL/WwWlDqaGQa/x8WvKa9Cn9nWsS9OGnPFydkxuOpipd7MdrlUCGOGbP8Xx9Qf9yKR5A3czKkLWTKj+BfkZKY6+fOUsHGyonWrLyK6/U32A2LV5s/Jg7AXLMYsR2ryjoR8G6vbzdXUAEGgrOuQjuUfcf4jtc//UTn27EkZ6d2bOVHkeWyxYKpqeqOwL2D6IdV2c4KgraohL17iMaIqSTPngPiZpNuBKV2+oH2/m728g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(4326008)(52536014)(33656002)(66476007)(66556008)(66446008)(64756008)(110136005)(316002)(54906003)(8676002)(71200400001)(38100700002)(122000001)(38070700005)(86362001)(82960400001)(186003)(508600001)(26005)(7696005)(9686003)(6506007)(53546011)(55016003)(8936002)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3pSKy85VkVnL0pnU2NWN3ZsZnJQZVNQL0gvWlg2RW9RU0FIOUNhQ2xjMGFW?=
 =?utf-8?B?ZExMWjNrU3N1VnpSMTFFTTF6a1hGWWJwbUl4UGVtV2dlKzkyYTBqcG9MUmpv?=
 =?utf-8?B?ZThLODZQWmFTdkpYU2hIaWVNRmRsS3k0dURQczl5SzZRWjhzR1hHcS8rVGZt?=
 =?utf-8?B?Z1puODhkRnBESXZRdWtyWnpub1k4M2M3WmQzTDB4SjNzSGd2UjR0dkRDdmpQ?=
 =?utf-8?B?RlZUZkZDOStyd0JmSHo4NUJsSUdZUlFHV2hxNW5RRWY3SlMrQ0hMcnJEMXMw?=
 =?utf-8?B?cTdqbGEyL2JoNmhiRmRyQ3JqOVhMMWtVcjFGVmhJY2o2aVcvd2luL3MrWjNV?=
 =?utf-8?B?S3I3cGQ1d2kraWJBNWo1YjVPU0JnellOV2txcVZyaWlPVG5aalhGTTBPeDc1?=
 =?utf-8?B?cHVQelZGN2Z5YlZwY0F4a2VVaFdZaHNDMnNTQWdia1pGSmRRWExBak5kOEdY?=
 =?utf-8?B?SXRnd2NJMHVxUnFIUmtlY0ZOeFV5Tm9wdE5GL3pINzdjN1BtbWY0ZkErRnRa?=
 =?utf-8?B?QThKR0tUOVFqOE1XcnJGWDczNVYrdHY3WDJ0KzRqSFJDbmJVT0lWR3hnVXpl?=
 =?utf-8?B?TGd6NXlmc2EzRGlra21sdFlYTXZUazQzMnZ2aTlaUVc2NmQ0cFU0dkdUY0xX?=
 =?utf-8?B?NjZDMFRNb05tVjNNcmpBVXVTUGFvV2RjdnVyWGpNS0JKcXBoZGcxSFlCSXlZ?=
 =?utf-8?B?azFrU1hwemJ5RTR6RlIvMmRoeGpoMjBDdmx2NjZna2VQVUhJZWlsOC9EcXZa?=
 =?utf-8?B?M3BXK05iRVk5RkRWdEh6aWhnS29mcWpjbitEMUV0dVlLTWowZEhxbWZxckk4?=
 =?utf-8?B?Sk5Sd0haZGV5cFNPL2RrZmZUSnd1VHI3VHJaeEZnVk0xM2dRbXFiR1lxb2NQ?=
 =?utf-8?B?ZGVVcWJyby9kR0xJdktrYXMxT1c1aGhlZ0s0bXZhcmRRYnB3VmVreHhZbVlv?=
 =?utf-8?B?emxwOFNhM0ZuMGFkMTk0L2F3eGYyNWh5KzNud1BDdWZ4WUN5NFdjblNSbzIr?=
 =?utf-8?B?V2t0RFlyaWZteTQ1blA5MnJpemJWdWx1YkxvaWNEM29VbUpRWld4dFpBNjFl?=
 =?utf-8?B?QXhKM0FXU1N3bDNhZkZRWHdqRS9WVEtPbFZDdWZiVFhnOWs1N2Vnd044VkFo?=
 =?utf-8?B?Nm83VUNTTUFtVnNyNFhibzkxTnFJZ0hraVlVNEZPeE9kQ3h4RDlQMkNkRE9r?=
 =?utf-8?B?ZC9qYlg4bHh6anpRU3UxUVNVSTJQNHlEcjNPbUlaUzZZQ3ZWQmJFOUE3Z2Y2?=
 =?utf-8?B?QnhWOFl6TWwwUnZXUVRya28ybVVNVFFWUnFZTklZYkM1aThVVlRrVjJKeTkv?=
 =?utf-8?B?UTRsRUFTeXRHeDhEQnJLblJIRU95UlV0NmVKS1FQWC95NG5wMEl2azloS0Zp?=
 =?utf-8?B?OEhnQUZ2aFNvUCsydHF3VHRaQzhHTHY4UWdMMFBBUjBwVER5SHArc1VDbjFh?=
 =?utf-8?B?ZWVhVnNyd3dXaEw2Z3AxYmxEZ1hFQzBIWGlEL1ViRGFEL29Lb2tPU2k3dnVp?=
 =?utf-8?B?MG5NMTBPOXQxRnlQMENSUWVyNGpHLy9udjJOM2ZPT3lrVUxDclY0VUVQOFpk?=
 =?utf-8?B?Tys5N3BtYUpZQWZKcHhJK1lHdE1UR1NycFU2ZFBpc01qbWFUL0N6NFBCVy9W?=
 =?utf-8?B?V1ZBWjRsVWd0cEZJV3VwZFFQYkw3cTNlUG5XM2R0R1pXYi9PbzE1ZVlsYkV5?=
 =?utf-8?B?dFVtUm03ZE81ZjFWVHFJWUZ5a25ZNUhDZXBKbDBJRUNNakJodUkzUndDeFZG?=
 =?utf-8?B?VVF6Q3ZTZ1BHNjdES0J5L2p0Q2ZaY1NrTnFDSjNGZnk5VjNrNWNTbWIwcUlM?=
 =?utf-8?B?NlBTYS8waVBkN1pIWkcyVTNIY3c2UE5KVlMwMmdhTk84a0l4R2ZFSThTRnF1?=
 =?utf-8?B?Ukdlcjd5RUtwdDRPR1gxOTFaMWYwbGVjRnlpN0Rlc0FWVDd0TXNJMG0rckZy?=
 =?utf-8?B?WVY0cW5TSFhyTzVITnNVVzFzNGNCM3JZVGJubGZjcndiWDNNT0dBWE9Pbm9r?=
 =?utf-8?B?emZENVhrZk9MaTYvd0lxZTF3bm9kbTZBVmVNekpuYjE5MENqQ0lPOWswS1FK?=
 =?utf-8?B?OUE2am42K1RQeVNiWE1XSGZrcXJBNjlid2I5b2p6UVB2YmtqbFk5SDhKVDlG?=
 =?utf-8?B?NTBuenFzOWpIVG5oekcxV3RRVnpVUDY2ZlRDK2wvcC9XcXZ0cGViYmZvUHRy?=
 =?utf-8?B?Z0tqTnBlbzJhYTVlWjJVSlBGd1NETGxIUFNqN1Q2SEJnejdiTTNuMVJlTVUz?=
 =?utf-8?B?VnYxekN5RWlnUm1vVEJVdnl5MmRBTWxqYzltdUhUYUk4RnlTUkoxUGs3Ykwr?=
 =?utf-8?B?Qy9VUWJMQnFHMEFHeHlxR3Bibms0enUrWlNXWWR2Nk9rKzBpWVo0UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96470ac2-43c1-45dc-a2f8-08da17ba7c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 10:44:54.0785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xyqxR5xkGQHMHahQNaWdTdZSJbj+Q5DugJAOCRuGGE4Ty2gWEh9Dkq02AhvoBWUh4dchgAn0J9eCsdmltSIfOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5460
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEFwcmlsIDYsIDIwMjIgNjowMiBQTQ0KPiANCj4gSGkgS2V2aW4sDQo+IA0KPiBPbiAy
MDIyLzQvMiAxNToxMiwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+Pj4gQWRkIGEgZmxhZyB0byB0
aGUgZ3JvdXAgdGhhdCBwb3NpdGl2ZWx5IGluZGljYXRlcyB0aGUgZ3JvdXAgY2FuIG5ldmVyDQo+
ID4+Pj4gaGF2ZSBtb3JlIHRoYW4gb25lIG1lbWJlciwgZXZlbiBhZnRlciBob3QgcGx1Zy4gZWcg
YmVjYXVzZSBpdCBpcw0KPiA+Pj4+IGltcG9zc2libGUgZHVlIHRvIEFDUywgb3IgbGFjayBvZiBi
cmlkZ2VzLCBhbmQgc28gb24uDQo+ID4+PiBPSywgSSBzZWUgeW91ciBwb2ludC4gSXQgZXNzZW50
aWFsbHkgcmVmZXJzIHRvIGEgc2luZ2xldG9uIGdyb3VwIHdoaWNoDQo+ID4+PiBpcyBpbW11dGFi
bGUgdG8gaG90cGx1Zy4NCj4gPj4gWWVzLCBrbm93biBhdCBjcmVhdGlvbiB0aW1lLCBub3QgcmV0
cm9hY3RpdmVseSBlbmZvcmNlZCBiZWNhdXNlDQo+ID4+IHNvbWVvbmUgdXNlZCBTVkENCj4gPj4N
Cj4gPiBXZSBtYXkgY2hlY2sgZm9sbG93aW5nIGNvbmRpdGlvbnMgdG8gc2V0IHRoZSBpbW11dGFi
bGUgZmxhZyB3aGVuDQo+ID4gYSBuZXcgZ3JvdXAgaXMgY3JlYXRlZCBmb3IgYSBkZXZpY2UgaW4g
cGNpX2RldmljZV9ncm91cCgpOg0KPiA+DQo+ID4gMSkgQUNTIGlzIGVuYWJsZWQgaW4gdGhlIHVw
c3RyZWFtIHBhdGggb2YgdGhlIGRldmljZTsNCj4gPiAyKSB0aGUgZGV2aWNlIGlzIHNpbmdsZSBm
dW5jdGlvbiBvciBBQ1MgaXMgZW5hYmxlZCBvbiBhIG11bHRpLWZ1bmN0aW9uIGRldmljZTsNCj4g
PiAzKSB0aGUgZGV2aWNlIHR5cGUgaXMgUENJX0VYUF9UWVBFX0VORFBPSU5UICh0aHVzIG5vIGhv
dHBsdWcpOw0KPiA+IDQpIG5vICdkbWEgYWxpYXNpbmcnIG9uIHRoaXMgZGV2aWNlOw0KPiA+DQo+
ID4gVGhlIGxhc3Qgb25lIGlzIGEgYml0IGNvbnNlcnZhdGl2ZSBhcyBpdCBhbHNvIHByZWNsdWRl
cyBhIGRldmljZSB3aGljaCBhbGlhc2luZw0KPiA+IGRtYSBkdWUgdG8gcXVpcmtzIGZyb20gYmVp
bmcgdHJlYXRlZCBhcyBhIHNpbmdsZXRvbiBncm91cC4gQnV0IGRvaW5nIHNvDQo+ID4gc2F2ZXMg
dGhlIGVmZm9ydCBvbiB0cnlpbmcgdG8gc2VwYXJhdGUgZGlmZmVyZW50IGFsaWFzaW5nIHNjZW5h
cmlvcyBhcyBkZWZpbmVkDQo+ID4gaW4gcGNpX2Zvcl9lYWNoX2RtYV9hbGlhcygpLiBQcm9iYWJs
eSB3ZSBjYW4gZ28gdGhpcyB3YXkgYXMgdGhlIGZpcnN0IHN0ZXAuDQo+ID4NCj4gPiBPbmNlIHRo
ZSBmbGFnIGlzIHNldCBvbiBhIGdyb3VwIG5vIG90aGVyIGV2ZW50IGNhbiBjaGFuZ2UgaXQuIElm
IGEgbmV3DQo+ID4gaWRlbnRpZmllZCBkZXZpY2UgaGl0cyBhbiBleGlzdGluZyBzaW5nbGV0b24g
Z3JvdXAgaW4gcGNpX2RldmljZV9ncm91cCgpDQo+ID4gdGhlbiBpdCdzIGEgYnVnLg0KPiANCj4g
SG93IGFib3V0IGJlbG93IGltcGxlbWVudGF0aW9uPw0KPiANCj4gLyogY2FsbGJhY2sgZm9yIHBj
aV9mb3JfZWFjaF9kbWFfYWxpYXMoKSAqLw0KPiBzdGF0aWMgaW50IGhhc19wY2lfYWxpYXMoc3Ry
dWN0IHBjaV9kZXYgKnBkZXYsIHUxNiBhbGlhcywgdm9pZCAqb3BhcXVlKQ0KPiB7DQo+IAlyZXR1
cm4gLUVFWElTVDsNCj4gfQ0KPiANCj4gc3RhdGljIGJvb2wgcGNpX2Rldl9pc19pbW11dGFibHlf
aXNvbGF0ZWQoc3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+IHsNCj4gCS8qIFNraXAgYnJpZGdlcy4g
Ki8NCj4gCWlmIChwY2lfaXNfYnJpZGdlKHBkZXYpKQ0KPiAJCXJldHVybiBmYWxzZTsNCj4gDQo+
IAkvKiBFaXRoZXIgY29ubmVjdCB0byByb290IGJyaWRnZSBvciB0aGUgQUNTLWVuYWJsZWQgYnJp
ZGdlLiAqLw0KPiAJaWYgKCFwY2lfaXNfcm9vdF9idXMocGRldi0+YnVzKSAmJg0KPiAJICAgICFw
Y2lfYWNzX2VuYWJsZWQocGRldi0+YnVzLT5zZWxmLCBSRVFfQUNTX0ZMQUdTKSkNCj4gCQlyZXR1
cm4gZmFsc2U7DQoNCml0J3Mgbm90IHN1ZmZpY2llbnQgdG8ganVzdCBjaGVjayB0aGUgbm9uLXJv
b3QgYnJpZGdlIGl0c2VsZi4gVGhpcyBuZWVkcyB0bw0KY292ZXIgdGhlIGVudGlyZSBwYXRoIGZy
b20gdGhlIGJyaWRnZSB0byB0aGUgcm9vdCBwb3J0LCBhcyBwY2lfZGV2aWNlX2dyb3VwKCkNCmRv
ZXMuDQoNCj4gDQo+IAkvKiBBQ1MgaXMgcmVxdWlyZWQgZm9yIE1GRC4gKi8NCj4gCWlmIChwZGV2
LT5tdWx0aWZ1bmN0aW9uICYmICFwY2lfYWNzX2VuYWJsZWQocGRldiwgUkVRX0FDU19GTEFHUykp
DQo+IAkJcmV0dXJuIGZhbHNlOw0KDQpBYm92ZSB0d28gY2hlY2tzIGJlIHJlcGxhY2VkIGJ5IGEg
c2ltcGxlIGNoZWNrIGFzIGJlbG93Og0KDQoJaWYgKCFwY2lfYWNzX3BhdGhfZW5hYmxlZChwZGV2
LCBOVUxMLCBSRVFfQUNTX0ZMQUdTKSkNCgkJcmV0dXJuIGZhbHNlOw0KDQo+IA0KPiAJLyogTWFr
ZSBzdXJlIG5vIFBDSSBhbGlhcy4gKi8NCj4gCWlmIChwY2lfZm9yX2VhY2hfZG1hX2FsaWFzKHBk
ZXYsIGhhc19wY2lfYWxpYXMsIE5VTEwpKQ0KPiAJCXJldHVybiBmYWxzZTsNCj4gDQo+IAlyZXR1
cm4gdHJ1ZTsNCj4gfQ0KPiANCj4gSSBkaWRuJ3QgZ2V0IHdoeSBkbyB3ZSBuZWVkIHRvIGNoZWNr
IHRoZSBQQ0lfRVhQX1RZUEVfRU5EUE9JTlQgZGV2aWNlDQo+IHR5cGUuIENhbiB5b3UgcGxlYXNl
IGVsYWJvcmF0ZSBhIGJpdCBtb3JlPw0KPiANCg0KSSBkaWRuJ3Qga25vdyB0aGVyZSBpcyBhIHBj
aV9pc19icmlkZ2UoKSBmYWNpbGl0eSB0aHVzIGJlIGNvbnNlcnZhdGl2ZQ0KdG8gcmVzdHJpY3Qg
aXQgdG8gb25seSBlbmRwb2ludCBkZXZpY2UuIElmIGNoZWNraW5nIHBjaV9pc19icmlkZ2UoKSBh
bG9uZQ0KZXhjbHVkZXMgYW55IGhvdHBsdWcgcG9zc2liaWxpdHksIHRoZW4gaXQncyBkZWZpbml0
ZWx5IGJldHRlci4NCg0KVGhhbmtzDQpLZXZpbg0K
