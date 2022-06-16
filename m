Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D59A54D910
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 06:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358516AbiFPEAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 00:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFPEAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 00:00:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3314856C01
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655352045; x=1686888045;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4dT/hWTlpHN3a+tw+RrESxrmn8rLeC2p8LG9mcbsEu4=;
  b=WzZu58rNAgjxuBlFc3hWvj2hVwzS52/hw35RWi0CFjZBvDEpaZNdXr9d
   Mphu1C2Gsnr2+HkLBxacZ7QOGUIj3t4bsvA9y/VZsBoZNJ/XPqp58ouVi
   FYuBl8PJ//U8EVSGHxjJT0T5icatzgOHllL6ws6OkZ9nrNEHIxa+JhYFg
   25aPWzZwKUa3dy89QCN3QIySAefBIy9kMhvpC3/BtXuTs7kXUqi4rj7DY
   e+kLmN2VCNTb2xRb+pZMuJVIAe8SjEOgCsFiIH0ddVYDTZnHIk8c3Y0lQ
   2ZtgylPsxHS0CbU7DZeQQZLXkokH7L59U4wgbmWIqvsr6/wEFgIINaoGH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="276733829"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="276733829"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 21:00:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="652985664"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2022 21:00:43 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 15 Jun 2022 21:00:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 15 Jun 2022 21:00:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 15 Jun 2022 21:00:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 15 Jun 2022 21:00:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwpZflOpZfXK8gsp90jqZLDM/HlkJUfJzKscCXK0k8K/ujGi5szdOwaut6K1/B6rkJGYOD7x3oRZwBJibhd/gLSxKbazgmYEzPOHlLJ4mvkv+nYoSF05NQ2HT0y3vUvFDrFDdFVJTRo92oHNif5h0ZRsL0HQzN26r+aM2vdpGkjeX/zk3NJ5Q/ePYmrPlGdsuggiuvE5OuZnbDN+5eoo3Z3yvtHL4RPk3QBJFr7eKscDdSBB5TTqW+QoPzcdJxPR7O4vLm3mbHUMvYvAae5ZIIeLGS/c+AtIkNCGHi8kWtnBBiQSPhdFkFM6rtiXzQPpf8splZ/k9gJlRhL+DBliCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dT/hWTlpHN3a+tw+RrESxrmn8rLeC2p8LG9mcbsEu4=;
 b=c05P5laH04gHqwW5ze9gQ9nojts929G2B8Y/E+cpdHFbBBqqtnssoSgY1dWU5ZW6bRsgnhbLU+aYVMmrDMatcoucoiDrtA5H8VMVPzYDSgDDCm0eqQNpIeHul2zWJ7Y5gS7ER38qYXtaM9ycOyL+UauO5sR4ZKRMxWt6vk21VYCo5vjX0nviflEMe3aR66hCUFUGmDP8Vaa2pOZ1N5lTbohWRWsDfKEE8i8hgswwoa/hNdbWHyU7io3y4Cv73h0q2hGb+k88A+QczHmGywQwaqCpzffJ5RVlxFMwxJte5iCtOqJJG7lQFlbU5oLA+HZdxVeqYktw5++aL2eS5FYKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by BY5PR11MB3912.namprd11.prod.outlook.com (2603:10b6:a03:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Thu, 16 Jun
 2022 04:00:41 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::4847:321e:a45e:2b69]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::4847:321e:a45e:2b69%6]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 04:00:40 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 03/12] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Thread-Topic: [PATCH v2 03/12] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Thread-Index: AQHYf5pCZKyuaZgwUEG5kY3NWG6Wj61OdPXggAAKioCAAX90EIAAdF6AgAD4S5A=
Date:   Thu, 16 Jun 2022 04:00:40 +0000
Message-ID: <BL1PR11MB52711A71AD9F11B7AE42694C8CAC9@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52762E7602FFF7EE4B52AC888CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <28161d94-6f2d-700f-853d-53b42f4d00d0@linux.intel.com>
 <BN9PR11MB5276A9FB934BC5F6FA55D4958CAD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b11b7cca-9e39-ac60-57a9-4e7049579221@linux.intel.com>
In-Reply-To: <b11b7cca-9e39-ac60-57a9-4e7049579221@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9160ed0-2921-4708-cb2f-08da4f4cc77a
x-ms-traffictypediagnostic: BY5PR11MB3912:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR11MB39121E2F530BAD1B1680E1978CAC9@BY5PR11MB3912.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +3z7pcCInemFZ/q+PJfwbku8jY/lKU4buks7UMJ9Xw4OwMIoR4XKSAfi9TR8zkO7WR4ettQtBPdHT2w4KReuQhGQvwe7Cs/AKnhG7OvotrmeZNlGuUKUp+GAQzFTqvaAMtZAE9N99wIVdiZSglwB8ZRosGn1pGKhsdh6R+Y2xP229eUI8bW3WoHzbbB03brByzgmjFFPdb2MeIjuwUNWSJ10iaw64ACgHH5ZcC0MvJM0m2DOZk2Y5pmIMLoeHqaQAHFh3xTtUqjsNrNvHHR4BuU9+LMDQWBR83PqT+k8Qfd65U/Gl3phfitb91uFByJgp7oU1gp/um8Mz1isjyzVyk3gvqLGsDXoCv352kKGxV7JIpkNnBq3fpWbQOj0/+Dbnp9xdwM88Z0vlqEqnoGSd1QwUQOGuBd6sEXyKvVyA3Pk3jGw3W3r/nXEAiO5rXWdFr9Ju0/RZrYjSewwEvdn72WDLAaWkoPxEFlcpz8hd3OeCqPq2EuwpjE8B05K00Nb9hW0wcWiF9SHPe93sydIOBAEkHUDHRlPo8XJHzaiWtBvx7WHxNOUpyXGz9pfppXkzbvez23JG5zW2oC9KHQjvKJ0Pnybq5Hc97RCHKGd2ORXi+1qlQyyJtVxKjNc2Z2CMjEIe57LhrkDt8g4poqn+2jmjQbAG9Qm9gqAtv7wkdDvrF8LtW2619orB+1HpKYWQBE/XQ5mTf05H/mKhn0+SQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66446008)(8676002)(86362001)(4326008)(64756008)(26005)(82960400001)(33656002)(122000001)(6506007)(55016003)(5660300002)(66946007)(8936002)(2906002)(71200400001)(52536014)(110136005)(66556008)(316002)(186003)(53546011)(7696005)(38100700002)(66476007)(9686003)(83380400001)(54906003)(38070700005)(508600001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1NNYjMzMGF0MnBtRmZyOWpjM21ZNDNPRGNtUmt0NzB0bno3bVd6cHA5RDZ5?=
 =?utf-8?B?K3k2bGQ5Y0NhZzN0UmYxdWNodGF5RVhaZGNpWWdxMEJ2ZTU3aGJsZ3hpYkZZ?=
 =?utf-8?B?alI1RU9vY21oZW5tNW0xUlR6UldHb1hMK0hNQWZpM1QxVlhxVm1oWWM2dVh1?=
 =?utf-8?B?eGdWWFhsUDJDZmhldFNOcVNJeWlZN0plamVTQUZPQ2xLVTVWTzNoY2xDdkRO?=
 =?utf-8?B?NDc1SGMrYzZKNitXQ3BlSXUyd2wvUUVIMVdyYjZ5MnBPUHVJbzBpbXVPSm9E?=
 =?utf-8?B?ajcwL1cxVnBhOGdLVkFqQ1JqYnFzazk1a0dGR0VhREZVaXhETk1LalNISGxZ?=
 =?utf-8?B?SC9HcXFyUzBDVUJSTE14dUlGbWVaamNiZ1Z1eStKbGRTWnRaYWVjaDI3NzFT?=
 =?utf-8?B?Z1V3SXptZlNyclZCSmhheVpPSlZwMERYOU9rcGdwUk5wT0FZcUwyUWI4L2dE?=
 =?utf-8?B?b2dVT0RDVE9zTGdIeGsxQ1B2MXpXU0ZJU05MckxnNzFCOXhjRGFIa1ozdDZq?=
 =?utf-8?B?YWZkT1lKMFVvbk1sQ0lqTGxoYnZybVM5eUxvRkl4RlBOZkNPNUZPVHZYS2hE?=
 =?utf-8?B?T2VoQW4zSUdqVGZKUlkvNUdHNGt6eXFIYkhXMXN3N3Fxc0lodTJuUXc2MVdt?=
 =?utf-8?B?TXA4eGNzV2YrRjNVM1RjaTRGajZMTFVEaEh1MjdQeTNDeHppWHZpTXBaaXhl?=
 =?utf-8?B?dnUvbEpsNmdZVm5uVUgwYjNHNENjcnl1TkJPUVRQZnNFQ3haN29uN05wbVA1?=
 =?utf-8?B?MnUxeWY2VTJmcUxBV2JQemY1SnFJcXpVVStkc1hNV1ZzK004V3VnZFpNRU9M?=
 =?utf-8?B?OHZpemEra0JpTEV3Uis1VWlEK3FEN0hmdHJHSm5xaElJN1pFWGpwSSs3OUZr?=
 =?utf-8?B?bjM2alRGKyt4V1JuMHVZK3NpcVhiREZCR1oycGQzL042Qk56eHFVQmxxQ054?=
 =?utf-8?B?QlVyWEZJVmVDalZTU1RmY2tnUXhtL2Iva3M5QXNoMVFidVB5czFkODcvYkJ4?=
 =?utf-8?B?S0NTRndMTVVTc1UrTWMyM2JXQzl5THJTNktvUThxbXBXcDJVUnl5ZnNkZGZJ?=
 =?utf-8?B?N1I1dElKUUxxLzJVdXRISlZyUUlFYzFOSnowTnU5czhOUWVUeHVRM2svZlVL?=
 =?utf-8?B?OUxMeFlzeU5XVFdrTDExUWx3bFNrdUtqTkZyeFdGS2N4VGZoMlZEL0tYY1B4?=
 =?utf-8?B?YkdBSDl6MVI0b2pNOFRDK0E0VWJRK1dIZTBZRWxGUVJaeUNYaXVwcVgybGcx?=
 =?utf-8?B?TXdNWWFpK1lxY1M4RkQ4M2wzbWtFelpTK3pGMkxsVFB4L1lZUGV3R3lQM1RE?=
 =?utf-8?B?Um5NTUdaeTdRS2VHbkhzU3FTYTZvdGM4M0J1NGdIaDBCZ3RxNncvS1Y5cGFM?=
 =?utf-8?B?VGdFNVhvUkUxK0xhbW5uYlIrOHVBbXJvOWk3S2RJTXVrS2Q1TFNKcmFlNjgr?=
 =?utf-8?B?NkRySDRMMStHdS9ZSi8rZDZrNEJEWWtvdnpoZk9ZNWhWV0xFeU1hbnVxMGhX?=
 =?utf-8?B?OWJiVTNrbFVWbGxHQVRnUnRuLzBDbUQxaFNwbFFQM0FHWnAwVUNCR3pCb01J?=
 =?utf-8?B?ZVQ1ZmwwNE1nTmdPVVBnVDZPYWowN2w2U1ZOZFZGQ1RiSkxLSzd5TThHSVhL?=
 =?utf-8?B?RUJJR01SRTdoOHpKRTMvS0dJU0ppYy9NK25iTnQ3NDFJUGpJUThXNzROaEJm?=
 =?utf-8?B?dXI5dEdDbDIydUdtVno2djhLSnpvVGY0enVHMHdZVDE1Y1BIRjJaVGNCb0tr?=
 =?utf-8?B?UTBPTzREVTI3am1lTjlwRTBHREpGL0ZqdHBPZkdEUHZaSHRFWXBvdCsvcjMw?=
 =?utf-8?B?dXByN2VhM1VzTzlUZStvZEMzZmFGL0RvMDJjOFpIMzJIMEVxNlgrZk5vSDNj?=
 =?utf-8?B?ZEp0RWpadExFcmcwVlpSSWk2VXcyMjIzc3FWc3F1cHJDWit3UkZ3Vk8xSDIw?=
 =?utf-8?B?dUtjTXBSTXdkSGtYVjJlNmI4NDkzcnZKU1h1SkJwOWJUcFFKQi9BYUw4Qklo?=
 =?utf-8?B?cGhBUi9wYXZvaTJjRUlqeGsxNmYweUozVk1UOHNFTTd6RHAxblluUjRIVFJ4?=
 =?utf-8?B?Z0JFeE5aWlJia0FFUkd1S0JnTUdlOW1CRlYrSVlzMnRqUzNyUHd1MEFRcjhH?=
 =?utf-8?B?Tm5PS3lpYy9wWEdEWkI1MTlETUxDR1Z6UjJKdERSQ0svZ1dWMjRPUEh2M202?=
 =?utf-8?B?MUZnSHAvVTlUVW9VL0pnM2N5WEJpaitKdWhrTmx5VWVFL1ZLVmtKRjJkOTVs?=
 =?utf-8?B?dDAxYjVPcUhkQVIxS282QjNxRmszWUljdXBIZzdCZXJ1S29Nc0NYQjBYZVE0?=
 =?utf-8?B?WVB4M05EZFpvNkQ2OWhPaVFiWHBST3RjcjFLQ3dObG41N1ZnY1FHdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9160ed0-2921-4708-cb2f-08da4f4cc77a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 04:00:40.8999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3FBhG9OcbkOpZdjqEKv3OPRqfMCHmAc5DSztp9LzIbOskhj2XzZ3NtLdJN3/7viUF2Zud9dLmowxWn8WHYwEZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3912
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEp1bmUgMTUsIDIwMjIgOToxMCBQTQ0KPiANCj4gT24gMjAyMi82LzE1IDE0OjIyLCBU
aWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogQmFvbHUgTHUgPGJhb2x1Lmx1QGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgSnVuZSAxNCwgMjAyMiAzOjIxIFBNDQo+ID4+
DQo+ID4+IE9uIDIwMjIvNi8xNCAxNDo0OSwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+Pj4gRnJv
bTogTHUgQmFvbHU8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiA+Pj4+IFNlbnQ6IFR1ZXNk
YXksIEp1bmUgMTQsIDIwMjIgMTA6NTEgQU0NCj4gPj4+Pg0KPiA+Pj4+IFRoZSBkaXNhYmxlX2Rt
YXJfaW9tbXUoKSBpcyBjYWxsZWQgd2hlbiBJT01NVSBpbml0aWFsaXphdGlvbiBmYWlscyBvcg0K
PiA+Pj4+IHRoZSBJT01NVSBpcyBob3QtcmVtb3ZlZCBmcm9tIHRoZSBzeXN0ZW0uIEluIGJvdGgg
Y2FzZXMsIHRoZXJlIGlzIG5vDQo+ID4+Pj4gbmVlZCB0byBjbGVhciB0aGUgSU9NTVUgdHJhbnNs
YXRpb24gZGF0YSBzdHJ1Y3R1cmVzIGZvciBkZXZpY2VzLg0KPiA+Pj4+DQo+ID4+Pj4gT24gdGhl
IGluaXRpYWxpemF0aW9uIHBhdGgsIHRoZSBkZXZpY2UgcHJvYmluZyBvbmx5IGhhcHBlbnMgYWZ0
ZXIgdGhlDQo+ID4+Pj4gSU9NTVUgaXMgaW5pdGlhbGl6ZWQgc3VjY2Vzc2Z1bGx5LCBoZW5jZSB0
aGVyZSdyZSBubyB0cmFuc2xhdGlvbiBkYXRhDQo+ID4+Pj4gc3RydWN0dXJlcy4NCj4gPj4+IE91
dCBvZiBjdXJpb3NpdHkuIFdpdGgga2V4ZWMgdGhlIElPTU1VIG1heSBjb250YWluIHN0YWxlIG1h
cHBpbmdzDQo+ID4+PiBmcm9tIHRoZSBvbGQga2VybmVsLiBUaGVuIGlzIGl0IG1lYW5pbmdmdWwg
dG8gZGlzYWJsZSBJT01NVSBhZnRlciB0aGUNCj4gPj4+IG5ldyBrZXJuZWwgZmFpbHMgdG8gaW5p
dGlhbGl6ZSBpdCBwcm9wZXJseT8NCj4gPj4NCj4gPj4gRm9yIGtleGVjIGtlcm5lbCwgaWYgdGhl
IElPTU1VIGlzIGRldGVjdGVkIHRvIGJlIHByZS1lbmFibGVkLCB0aGUgSU9NTVUNCj4gPj4gZHJp
dmVyIHdpbGwgdHJ5IHRvIGNvcHkgdGFibGVzIGZyb20gdGhlIG9sZCBrZXJuZWwuIElmIGNvcHlp
bmcgdGFibGUNCj4gPj4gZmFpbHMsIHRoZSBJT01NVSBkcml2ZXIgd2lsbCBkaXNhYmxlIElPTU1V
IGFuZCBkbyB0aGUgbm9ybWFsDQo+ID4+IGluaXRpYWxpemF0aW9uLg0KPiA+Pg0KPiA+DQo+ID4g
V2hhdCBhYm91dCBhbiBlcnJvciBvY2N1cnJlZCBhZnRlciBjb3B5aW5nIHRhYmxlIGluIHRoZSBp
bml0aWFsaXphdGlvbg0KPiA+IHBhdGg/IFRoZSBuZXcga2VybmVsIHdpbGwgYmUgaW4gYSBzdGF0
ZSBhc3N1bWluZyBpb21tdSBpcyBkaXNhYmxlZA0KPiA+IGJ1dCBpdCBpcyBzdGlsbCBlbmFibGVk
IHVzaW5nIGFuIG9sZCBtYXBwaW5nIGZvciBjZXJ0YWluIGRldmljZXMuLi4NCj4gPg0KPiANCj4g
SWYgY29weWluZyB0YWJsZSBmYWlsZWQsIHRoZSB0cmFuc2xhdGlvbiB3aWxsIGJlIGRpc2FibGVk
IGFuZCBhIGNsZWFuDQo+IHJvb3QgdGFibGUgd2lsbCBiZSB1c2VkLg0KPiANCj4gaWYgKHRyYW5z
bGF0aW9uX3ByZV9lbmFibGVkKGlvbW11KSkgew0KPiAgICAgICAgICBwcl9pbmZvKCJUcmFuc2xh
dGlvbiBhbHJlYWR5IGVuYWJsZWQgLSB0cnlpbmcgdG8gY29weQ0KPiB0cmFuc2xhdGlvbiBzdHJ1
Y3R1cmVzXG4iKTsNCj4gDQo+ICAgICAgICAgIHJldCA9IGNvcHlfdHJhbnNsYXRpb25fdGFibGVz
KGlvbW11KTsNCj4gICAgICAgICAgaWYgKHJldCkgew0KPiAgICAgICAgICAgICAgICAgIC8qDQo+
ICAgICAgICAgICAgICAgICAgICogV2UgZm91bmQgdGhlIElPTU1VIHdpdGggdHJhbnNsYXRpb24N
Cj4gICAgICAgICAgICAgICAgICAgKiBlbmFibGVkIC0gYnV0IGZhaWxlZCB0byBjb3B5IG92ZXIg
dGhlDQo+ICAgICAgICAgICAgICAgICAgICogb2xkIHJvb3QtZW50cnkgdGFibGUuIFRyeSB0byBw
cm9jZWVkDQo+ICAgICAgICAgICAgICAgICAgICogYnkgZGlzYWJsaW5nIHRyYW5zbGF0aW9uIG5v
dyBhbmQNCj4gICAgICAgICAgICAgICAgICAgKiBhbGxvY2F0aW5nIGEgY2xlYW4gcm9vdC1lbnRy
eSB0YWJsZS4NCj4gICAgICAgICAgICAgICAgICAgKiBUaGlzIG1pZ2h0IGNhdXNlIERNQVIgZmF1
bHRzLCBidXQNCj4gICAgICAgICAgICAgICAgICAgKiBwcm9iYWJseSB0aGUgZHVtcCB3aWxsIHN0
aWxsIHN1Y2NlZWQuDQo+ICAgICAgICAgICAgICAgICAgICovDQo+ICAgICAgICAgICAgICAgICAg
cHJfZXJyKCJGYWlsZWQgdG8gY29weSB0cmFuc2xhdGlvbiB0YWJsZXMgZnJvbSBwcmV2aW91cw0K
PiBrZXJuZWwgZm9yICVzXG4iLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBpb21tdS0+bmFt
ZSk7DQo+ICAgICAgICAgICAgICAgICAgaW9tbXVfZGlzYWJsZV90cmFuc2xhdGlvbihpb21tdSk7
DQo+ICAgICAgICAgICAgICAgICAgY2xlYXJfdHJhbnNsYXRpb25fcHJlX2VuYWJsZWQoaW9tbXUp
Ow0KPiAgICAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAgIHByX2luZm8oIkNvcGll
ZCB0cmFuc2xhdGlvbiB0YWJsZXMgZnJvbSBwcmV2aW91cyBrZXJuZWwNCj4gZm9yICVzXG4iLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgaW9tbXUtPm5hbWUpOw0KPiAgICAgICAgICB9DQo+
IH0NCj4gDQoNCkkgbWVhbnQgY29weWluZyB0YWJsZSBzdWNjZWVkcyBidXQgYW5vdGhlciBlcnJv
ciBvY2N1cnMgaW4gdGhlDQpyZW1haW5pbmcgcGF0aCBvZiBpbml0aWFsaXphdGlvbi4uLg0K
