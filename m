Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FBA4F6F00
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 02:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiDGAPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 20:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiDGAPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 20:15:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC7A2174AD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 17:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649290286; x=1680826286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lNPk4W17MOc5Cf8E7h2KTB6+9QqaUK5Nc55KFl+CKMc=;
  b=JGDhcgT/+NIDswdJWqjVMPyTZx6PmQn7+EOJLlMYtM/ExlXDeH2pClrQ
   z2GtRlP04MYpTlDBut3zAYlCzvpukTC8OdCa+bkkyMmOwBjiwYE1A7kff
   4/JN54hntrQ4E+v32dIt7+lKQngKhOxTlb5MTAyxaGhyNLWEK88sGF2t2
   hnv8+w4K6ZNWT5BKiY8MTUueurdgLJamf63HPXxwHJ9B+x5asctCC+Rtw
   x/7wbPT+f8NKUAormFAFloVDVKcZmYdQaOXALSj7EMzRvAWFrz/hOvWyG
   6QDsm9Ve9dLILgxFfbSZUWQLmhw6B3syTPS2jmbfQy2futKu9sfDb+2xj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="261182635"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="261182635"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 17:11:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="524151968"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2022 17:11:25 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 17:11:24 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 17:11:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Apr 2022 17:11:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Apr 2022 17:11:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToF419wIKrM/Akyqmh7Wbrg2pDIHZeQAHnct3Axs0PH3CplR6tv9N3124/5jPtb9rqo5uzx+DLj+T7OLrbD9mYEMSW1D7CyHBoOFeLhpp98YaLiHuBTopLhWfXntjEJf7wo0BjrC5+hqFqKiHzVS5S9Z0QAy/d1yZm6Ue3AEX5ETyjLsrOxeNbFwLfg5xBe/Qeirku/RxO6bl7mwXYo/lHoCY0ZIs+tCzO7FEWlKkR4ZPzybnlRLvfJ3OSt+9nTmtKseoDEpXMMiScGVVAJCZBtWjlBQDWPEQhwTyz9PPUXHgARKoy0cntmZlIVY6i+dABDXq9baYlNy7ZIgMAaG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNPk4W17MOc5Cf8E7h2KTB6+9QqaUK5Nc55KFl+CKMc=;
 b=JvYqNMAydZztVO4w9Lvd4HdmWPAMbuCd2YkgVNayiCJjA24y3+UyiC+eRiXlB+bG5jrbnlLGV/bmnXqI5TcneD1yREgWVLOBq5yUABZ8FNiYjnMCVgeKCYfVO7a2W8Pv1511Mzq6LNA7NGNvRSetdwNQ4G2vtMh6uQmxni08LzZvQLSgYB7+zX+xwFBc/69qEdkpBbfiTsjuy1IbmPgiU3nMni3qjVDGCipUxyIBctklr4Mb79WyGLAXi5QRk+9+S56pDcVDWy90HUAfGuCalCXRWcXNxqnZy4AWDp1UxAsVaIbX0f8cb4T1bESdE/Cr0KA8XJ1D934HY8gaWd6dqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4157.namprd11.prod.outlook.com (2603:10b6:208:156::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 00:11:16 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%9]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 00:11:16 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Thread-Topic: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Thread-Index: AQHYQy+FIia0eWaSv0yH5HJtvKyQTazYSueAgAQE+8CAAP1+AIAEzMlAgAAJVQCAAErBwIAAcAmAgAC/wwA=
Date:   Thu, 7 Apr 2022 00:11:16 +0000
Message-ID: <BN9PR11MB5276AB17E09E609A0556CF658CE69@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-4-baolu.lu@linux.intel.com>
 <20220330190201.GB2120790@nvidia.com>
 <BN9PR11MB5276A39F481E2E31B0FCFEAE8CE39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220402233210.GM2120790@nvidia.com>
 <BN9PR11MB527660D99D154F922B0A628B8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220406012334.GZ2120790@nvidia.com>
 <BN9PR11MB52764E3DE16E19D1F1515D008CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d0f6caea-0cd9-d839-c9fb-0fe49c2bad16@arm.com>
In-Reply-To: <d0f6caea-0cd9-d839-c9fb-0fe49c2bad16@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef7e1d5d-49e2-41a8-af33-08da182b2269
x-ms-traffictypediagnostic: MN2PR11MB4157:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB415792783AF967075B1388E18CE69@MN2PR11MB4157.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6r1DX/xUoRh7wJEDEdmGxZZc5+zeYeTbNZhGI3yq1hm45LvdsGsTN1Ey2YSmM1HwszMIy63Wi433o+1Oe2+YuDYEuID+hFm/wvQ2gX0TZ4t5gFtCeqWjT+7wQmlk4CBVukhVdShOSqa03GlR7rDHra3XEQcKnT8Qt0f1NbiEC1C0mGLyuTzYK/IFcnpOQLGsy8oVnqdNd4tg/qAm9NSheHVcHYl7I4ySaGOdtZy0lV83wBtDUopoyspJajhgeei3jaktob456bp7gOwT3Qu5Y3R+fCWDsoXKfg5wV/RKmcbbwLdQQKPRsdQkMXg8M8pigQ2Ikf+ByO8Bx0p3n8f5KfpIcTonGA7APvTJfAS+/IiTktoRRXaPjKW5dFoieJxKAVm4NtdtOgrbJv8tUGGPMBis0EYY4+VixWKjc3ThVHHtOit+IGNZ6iPVh/qkZ3UYHE/aqeWDmmImtSjI5s4WSK8zhJcneOlNw/VMgIvBaQ10vNEReuZQtfdXCn4kg3vNAEOToteanhnqVC78dDlSfTNe/50nSVLi8ULr2kDazZiXtLZDyc77eQG7hBcEBMIKhoahdSwhb9G+umBgX0OOcbuTuACMwvejDHZTca0Xb+l/o++/0k5BTmiTN6FLFuhUuiOamGU29IwZ/vtmKc7oy8rjMsvtvNKgMku+4FluNUwjxDycHkz15k1qc6Nq9gIegarQosSi+fUMDNL/ZNKOMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(84040400005)(66446008)(508600001)(66946007)(66476007)(66556008)(71200400001)(64756008)(86362001)(82960400001)(122000001)(33656002)(7696005)(6506007)(53546011)(186003)(316002)(110136005)(76116006)(54906003)(9686003)(26005)(55016003)(2906002)(7416002)(5660300002)(8936002)(52536014)(4326008)(83380400001)(8676002)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjhRWkNpN3NUdEZBcmEzNUdtV0tTTlY5dFdaQ0xnL3pQT1lCVUFrRC9mT2FC?=
 =?utf-8?B?bW5RMCt0WXMrei9UazlxM1FxYXZSeG9TR0tLWUc0bWtWaVI4M085a0ErZXY5?=
 =?utf-8?B?dzd4VXMzcVE3MmNGaWtHS3RIbGFVeWhTQmFLRmNNWjJETHVHSFZpd2lVM3hF?=
 =?utf-8?B?aGVnWHgwWWxwQ3M3V0VKaEVaRTYvTGJ2b1V0a2U4NFRoUnNmRVc1VTN5UWVX?=
 =?utf-8?B?RG5NQ1RxaHdRdVlGbEcwT1NiTHdrVWlmQngzSjlzcHNZQktsNnJnRzJUUWxs?=
 =?utf-8?B?ek1tSnNhaWFtTzBnYkMwTjJLVFRLUE5IYmFXeUhtclZZVUFTRCtCUm5HU284?=
 =?utf-8?B?ak14RWFKVzJ1RzNYU3FEZVVrcFM2QU81N1h4OEJzakZGTUlJRjM2SExKSVpE?=
 =?utf-8?B?N3NEWGFBS004UVM0am04KzFyTGlqcGF4R01GMVlXU0V6aW4xTmFTYlN2V3pr?=
 =?utf-8?B?TldUU2JhV1RUMUUycTdqc3p5TlMrVG9GV0RxbWdNTzd3UUx3MTFadFVGVm9r?=
 =?utf-8?B?NGNtYlFkZVErZ2NVcUZIRFJKVHFLdndlcFpXTVV2V2lzem9KSHJvK2U3ODhW?=
 =?utf-8?B?ellYb3d1WVFHUjVhMSthb0VtR1VFZlp0Y0Y2V0E0L3hkNmVjeHptREZnVDNa?=
 =?utf-8?B?RDdVL244TlIwcmdaZHlVeHJWb2FEeWVLYlJUTVJ5WlBqVFBnckNTT21FWXYy?=
 =?utf-8?B?WlhRWFI1QUhJS1luOXJDdWFnVHprVW90R3lSVjN2NDVpc0tKdWlkRm90K0Iw?=
 =?utf-8?B?OWZndVUxRXBaNURFTFVZeU5yK2VXMXJYVzdHcm8wa0ZxMUFFOC9kSkpYN1M1?=
 =?utf-8?B?RlN4d2ZkSXlLMnVHZVhzWXFtbkhGck9lSGJheWRkS3hjQ0ZoRGVNZk90NWFP?=
 =?utf-8?B?U3VVUVh0eFpvaDY0YWFTb1hsNEg1V2p4bUtiU1ovcDdiQStBZGt3VVhpaEdE?=
 =?utf-8?B?anlJOHg2WHFmSWlJdk1OOG9hZC8zQnlVWDRwVWhRdWJoNkREVHpncG44UFAy?=
 =?utf-8?B?R1VGRDg4R0NGMkV6L1ZUY3czbllsNnNDc2x2V3dHY3BqZ1lDZ2N3VkdZL3lB?=
 =?utf-8?B?enRjUHg3SXh2MnE0eDJ5SVZ0elJtQ3pZNVZERkMvbXVzT1pSaDNZR3VGTGl4?=
 =?utf-8?B?SzNPSS96Lzlpc0lKSlAxa2lYRzlhMXpOR2VOV2pKeVlxSXpQVGhqblFlZ2lZ?=
 =?utf-8?B?VXdCZGxTZ1BvN0NlVVBZa1VITmhuU2c2R1ZDZy9mNXVBUWpjQ0NWVVFJYTVI?=
 =?utf-8?B?akNJcm40VmdHekYyek45SG9WY0p3bEtKdmJHbUlFVUlHT2pTcXNZWXBwdG95?=
 =?utf-8?B?N3llcWVUSzFPTlBLQ0NiR050Vjk0Z3lzL2wrbmY1dElsSGtYbDVTdHVLeE5F?=
 =?utf-8?B?WkFXcTl4amRGY0dPYk81Nk0xNkQ2Vy8xUkVXK0ppVXM4cnFqMWN2MmlVWlZq?=
 =?utf-8?B?UEtGdEUvckF3bm8ydms3SGZ1VnpXT0tSYmNaQ0JIRFpPZUJaZUFqbFU5TzI4?=
 =?utf-8?B?b0FWK0dKMXlRS2xqeUh4YTZ1ZEZNKzBYclNoWUF1L0tTMFJHVkVoRW5JNVpB?=
 =?utf-8?B?UXdpN0FNcVdEbFZWMjA1OUZmQjZ5VUpxVjcxNHQ3OFpXN3Blb3JKSGNWMW1S?=
 =?utf-8?B?cjQwUWFnYVhiRzJSZGJreXM5K2ZjcmJacUxTdUZsM1V0bUNHaG1TUWRmT0FX?=
 =?utf-8?B?THBlQ0c3UzU1L2JnVmdlcTg5R3ozL0dRU0lLZ1NUU3V6RlQ2UTVKOWIxeC9C?=
 =?utf-8?B?QTZsTXBXQjJldXhocXdnZmFsN3laU281cWhJb2syWXNQMTF4cFBJbm1DTnhP?=
 =?utf-8?B?elFGQ1JaY2lEN0UxV1cvMjB4dTNQU0VBYUhRSnBSWUJYU3Vjd0syc094Vysw?=
 =?utf-8?B?WEkyZVd4MHhBRnE4N2xBdnlDb2tJV3c1MXR1Vml0MGVKdG1DazJ4eDRlSHd3?=
 =?utf-8?B?OS95cHVqSjZLcEVYZENuWm9SSi81a1UwS3hXSGZTVnBkcHJiRWJ3cnNhaUd6?=
 =?utf-8?B?V1EvalUzcDJrSzRCWHd5MlFFTm1JSEFCc0dGbE16eUNhSkFEcW1UcW1uSU84?=
 =?utf-8?B?dG9GT1hQblBJeWRhd1MrTGZ6UFRzcGVCSFhOMHBsN0tTZm01VUp6d2F4VStZ?=
 =?utf-8?B?ZUFZRHd4bnhDM0l4ZXcwWktpa2NaVW9KVmlwN001MXRvT0g2UmtCeEI1YjIw?=
 =?utf-8?B?czUwQWhtUG96VnpSV09SMnpPLzk1ZnVGK2pyODZlTHRSYTJqalRhSzNmNWx4?=
 =?utf-8?B?dVF3UVpRTVVPODRBbStDT2VWcVRJdTdqZUV4dGRaam5kbXoxdjJUeE81NVdQ?=
 =?utf-8?B?ZGhrQkEzUmYyU2RkQVk5M3VsNGlFcFRBRE1jWm4wdkFhamtzS2tyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7e1d5d-49e2-41a8-af33-08da182b2269
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 00:11:16.5264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWh59woc3YKDwHc93PaSFvZPsku9ZERpo3PEy/UaHzPnprv7EL+1zKHEom6dQ/H8mrPslcHTfHWIr0gYQBzuCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4157
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEFwcmlsIDYsIDIwMjIgODozMiBQTQ0KPiANCj4gT24gMjAyMi0wNC0wNiAwNjo1OCwg
VGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRp
YS5jb20+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgNiwgMjAyMiA5OjI0IEFNDQo+ID4+
DQo+ID4+IE9uIFdlZCwgQXByIDA2LCAyMDIyIGF0IDAxOjAwOjEzQU0gKzAwMDAsIFRpYW4sIEtl
dmluIHdyb3RlOg0KPiA+Pg0KPiA+Pj4+IEJlY2F1c2UgZG9tYWlucyB3cmFwIG1vcmUgdGhhbiBq
dXN0IHRoZSBJT1BURSBmb3JtYXQsIHRoZXkgaGF2ZQ0KPiA+Pj4+IGFkZGl0aW9uYWwgZGF0YSBy
ZWxhdGVkIHRvIHRoZSBJT01NVSBIVyBibG9jayBpdHNlbGYuIEltYWdpbmUgYSBTT0MNCj4gPj4+
PiB3aXRoIHR3byBJT01NVSBIVyBibG9ja3MgdGhhdCBjYW4gYm90aCBwcm9jZXNzIHRoZSBDUFUg
SU9QVEUNCj4gZm9ybWF0LA0KPiA+Pj4+IGJ1dCBoYXZlIGRpZmZlcmVudCBjb25maWd1cmF0aW9u
Lg0KPiA+Pj4NCj4gPj4+IEN1cmlvdXMuIElzIGl0IGh5cG90aGVzaXMgb3IgcmVhbD8gSWYgcmVh
bCBjYW4geW91IGhlbHAgZ2l2ZSBhIGNvbmNyZXRlDQo+ID4+PiBleGFtcGxlPw0KPiA+Pg0KPiA+
PiBMb29rIGF0IGFybV9zbW11X2F0dGFjaF9kZXYoKSAtIHRoZSBkb21haW4gaGFzIGV4YWN0bHkg
b25lIHNtbXUNCj4gPj4gcG9pbnRlciB3aGljaCBjb250YWlucyB0aGUgYmFzZSBhZGRyZXNzIGZv
ciB0aGUgU01NVSBJUCBibG9jay4gSWYgdGhlDQo+ID4+IGRvbWFpbiBkb2Vzbid0IG1hdGNoIHRo
ZSBzbW11IHBvaW50ZXIgZnJvbSB0aGUgc3RydWN0IGRldmljZSBpdCB3b24ndA0KPiA+PiBhbGxv
dyBhdHRhY2hpbmcuDQo+ID4+DQo+ID4+IEkga25vdyBvZiBBUk0gU09DcyB3aXRoIG1hbnkgY29w
aWVzIG9mIHRoZSBTTU1VIElQIGJsb2NrLg0KPiA+Pg0KPiA+PiBTbyBhdCBsZWFzdCB3aXRoIGN1
cnJlbnQgZHJpdmVycyBBUk0gc2VlbXMgdG8gaGF2ZSB0aGlzIGxpbWl0YXRpb24uDQo+ID4+DQo+
ID4NCj4gPiBJIHNhdyB0aGF0IGNvZGUsIGJ1dCBiZWZvcmUgdGhpcyBzZXJpZXMgaXQgaXMgdXNl
ZCBvbmx5IGZvciBzdGFnZS0yIGluc3RlYWQNCj4gPiBvZiBTVkEuIGFuZCBJIGRpZG4ndCBzZWUg
c2ltaWxhciBjaGVjayBpbiB0aGUgb2xkIHN2YSByZWxhdGVkIHBhdGhzICh0aG91Z2gNCj4gPiBp
dCBkb2Vzbid0IHVzZSBkb21haW4pOg0KPiA+DQo+ID4gYXJtX3NtbXVfbWFzdGVyX3N2YV9lbmFi
bGVfaW9wZigpDQo+ID4gYXJtX3NtbXVfbWFzdGVyX2VuYWJsZV9zdmF7fQ0KPiA+IF9fYXJtX3Nt
bXVfc3ZhX2JpbmQoKQ0KPiA+DQo+ID4gSWYgSSBkaWRuJ3Qgb3Zlcmxvb2sgc29tZSB0cmljayBo
aWRpbmcgaW4gdGhlIGNhbGwgY2hhaW4gb2YgdGhvc2UgZnVuY3Rpb25zLA0KPiA+IGlzIHRoZXJl
IGEgYnVnIGluIHRoZSBleGlzdGluZyBTTU1VIHN2YSBsb2dpYyBvciBpcyBpdCBjb25jZXB0dWFs
bHkgY29ycmVjdA0KPiA+IHRvIG5vdCBoYXZlIHN1Y2ggY2hlY2sgZm9yIFNWQT8NCj4gDQo+IFRo
ZSBjdXJyZW50IFNWQSBBUElzIGFyZSBhbGwgZGV2aWNlLWJhc2VkLCBzbyBpbXBsaWNpdGx5IHJl
ZmxlY3QNCj4gd2hpY2hldmVyIFNNTVUgaW5zdGFuY2Ugc2VydmVzIHRoZSBnaXZlbiBkZXZpY2Uu
IE9uY2UgZG9tYWlucyBjb21lIGludG8NCj4gdGhlIHBpY3R1cmUsIGNhbGxlcnMgYXJlIGdvaW5n
IHRvIGhhdmUgdG8gYmUgbW9yZSBhd2FyZSB0aGF0IGEgZG9tYWluDQo+IG1heSBiZSBzcGVjaWZp
YyB0byBhIHBhcnRpY3VsYXIgSU9NTVUgaW5zdGFuY2UsIGFuZCBwb3RlbnRpYWxseSBhbGxvY2F0
ZQ0KPiBzZXBhcmF0ZSBkb21haW5zIGZvciBzZXBhcmF0ZSBkZXZpY2VzIHRvIHJlcHJlc2VudCB0
aGUgc2FtZSBhZGRyZXNzDQo+IHNwYWNlLCBtdWNoIGxpa2UgdmZpb19pb21tdV90eXBlMV9hdHRh
Y2hfZ3JvdXAoKSBkb2VzLg0KDQpUaGUgY3VycmVudCBkZWZpbml0aW9uIG9mIGRvbWFpbiBpcyBz
cGVjaWZpYyB0byBzdGFnZS0yLiBJdCBpcyBpbnRlcmVzdGluZyANCndoZXRoZXIgd2Ugd2FudCB0
byBrZWVwIHRoZSBzYW1lIHN0YWdlLTIgY29uc3RyYWludHMgdG8gc3RhZ2UtMSB3aGVuDQpleHRl
bmRpbmcgdGhlIGRvbWFpbiBjb25jZXB0IHRvIGNvdmVyIGJvdGguIEZyb20gd2hhdCB5b3UgZXhw
bGFpbmVkDQpTVkEgY29uY2VwdHVhbGx5IGlzIGRldmljZS1iYXNlZCB0aHVzIFNNTVUgaW5zdGFu
Y2UgZG9lc24ndCBtYXR0ZXIuDQpUaGVuIGFsbG93aW5nIG9uZSBkb21haW4gdG8gd3JhcCBDUFUg
cGFnZSB0YWJsZSBjcm9zcyBkZXZpY2VzIHVuZGVyDQpkaWZmZXJlbnQgU01NVSBpbnN0YW5jZXMg
aXMgYWxzbyBvbmUgY2hvaWNlLCBhcyBsb25nIGFzIHRoaXMgZG9tYWluIGlzDQpkaWZmZXJlbnRp
YXRlZCBmcm9tIHN0YWdlLTIgZG9tYWluIGluIHByb3BlciB3YXkuIEkgZ2V0IHlvdSBtYXkgbm90
DQp3YW50IHRvIGdvIHRoaXMgcm91dGUgZm9yIHNtbXUgZHJpdmVyIGFzIGV4cGxhaW5lZCBiZWxv
dywgYnV0IGxldCdzDQphbGlnbiBvbiB0aGF0IGl0J3MganVzdCBhbiBpbXBsZW1lbnRhdGlvbiBj
aG9pY2UgaW5zdGVhZCBvZiBhIGNvbmNlcHR1YWwNCnJlcXVpcmVtZW50IChJIGRpZG4ndCBzZWUg
aG93IElPTU1VIGluc3RhbmNlcyBjYW4gaGF2ZSBoZXRlcm9nZW5vdXMNCmNvbmZpZ3VyYXRpb25z
IHdoZW4gd2Fsa2luZyB0aGUgc2FtZSBDUFUgcGFnZSB0YWJsZSkuIPCfmIoNCg0KPiANCj4gSXQn
cyBub3QgcmVhbGx5IHdvcnRoIElPTU1VIGRyaXZlcnMgdHJ5aW5nIHRvIHN1cHBvcnQgYSBkb21h
aW4gc3Bhbm5pbmcNCj4gcG90ZW50aWFsbHktaGV0ZXJvZ2VuZW91cyBpbnN0YW5jZXMgaW50ZXJu
YWxseSwgc2luY2UgdGhleSBjYW4ndA0KPiByZWFzb25hYmx5IGtub3cgd2hhdCBtYXR0ZXJzIGlu
IGFueSBwYXJ0aWN1bGFyIHNpdHVhdGlvbi4gVGhhdCdzDQo+IHByaW1hcmlseSB3aHkgd2UndmUg
bmV2ZXIgdHJpZWQgdG8gZG8gaXQgaW4gdGhlIFNNTVUgZHJpdmVycy4gSXQncyBhIGxvdA0KPiBl
YXNpZXIgZm9yIHJlbGV2YW50IGNhbGxlcnMgdG8gbG9vayBhdCB3aGF0IHRoZXkgZ2V0IGFuZCBm
aWd1cmUgb3V0DQo+IHdoZXRoZXIgYW55IG1pc21hdGNoIGluIGNhcGFiaWxpdGllcyBpcyB0b2xl
cmFibGUgb3Igbm90Lg0KPiANCj4gUm9iaW4uDQo+IA0KPiA+IElmIHRoZSBmb3JtZXIgdGhlbiB5
ZXMgd2UgaGF2ZSB0byB0YWtlIFNNTVUgSVAgYmxvY2sgaW50byBjb25zaWRlcmF0aW9uDQo+ID4g
dGh1cyBjb3VsZCBoYXZlIG11bHRpcGxlIGRvbWFpbnMgcGVyIENQVSBwYWdlIHRhYmxlLiBJZiB0
aGUgbGF0dGVyIHRoZW4NCj4gPiB0aGlzIGlzIG5vdCBhIHZhbGlkIGV4YW1wbGUgZm9yIHRoYXQg
Y29uZmlndXJhdGlvbi4NCj4gPg0KPiA+IFdoaWNoIG9uZSBpcyBjb3JyZWN0Pw0KPiA+DQo+ID4g
VGhhbmtzDQo+ID4gS2V2aW4NCg==
