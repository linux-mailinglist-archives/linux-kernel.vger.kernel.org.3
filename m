Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4526D5849FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiG2C4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiG2C4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:56:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A895378DE8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659063389; x=1690599389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZP/jN6Ek75/GzFnHiLCQMai/IWBTRONjIfo5ZauZ5o4=;
  b=Dgijbbzhf/JeNqpbD5ZnpEM3XIasM8NUdK1CZWVVzTWLoCh+5nR9lVeL
   OzgzBe0G66TyaBA3Hc+1vSUTp/c2anKtde39ityygowLtzXIlxC1hklED
   47ZyDcTYlmn6kbaGk0qfra06eTvWc3LK1BEQIC7fRH27oGg3+ODGhr0f/
   ZVBub5hLzE6Vz1+aWHkTu4duYQXGcymVEOJSiOyNzOqgUL5rgWLv/nqbm
   uC29epYOUgMgrb7FRFo6noFL5DcQl7HSveOlZAXhcfiochMf5Vr5MvNmU
   01H+vHjyVtWFtynqKHeNYf1aFrQwAL2FdpakEDfIlk48BuD8lpirGZpB8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="289445780"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="289445780"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 19:56:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="551586841"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2022 19:56:29 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 19:56:29 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 19:56:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 28 Jul 2022 19:56:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 28 Jul 2022 19:56:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXgnVuBfTM20k/J3wEXUafm7nbb5SMURE6R2mfeLsj9oM7dGGgA2vjbDAqqRcXkGhlAHWFp56VlkpPoG+z5u0QjXciUcE6qNvuTzX5Rco+V0SxkKle7J4A1a8Ep9r6jW3H7pQqtn1B7ZOcdoL+F/Hq7ra5JCEMLdDqNqI4GGG2K2x4gPKqPKtqGh8zXrdj7m9OVoNlA2SfMFUImrTXt9syhVygtbQKCLdOu4NbAO8lMZWsiZDmZg06d2uSnEEaCR5tzJ6LAQkPMZz8782GXamztfFp6pIH1AxJXZIzna3bD50gEqUZw5YRNcLVx1DxT5kwHbGNrvytyaxeDd509GAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZP/jN6Ek75/GzFnHiLCQMai/IWBTRONjIfo5ZauZ5o4=;
 b=g+XKSfjz0ye1/FWGhgy/unzLexvPBzBvLgG/DSbLxsx6EK1kZLZlGZ8tsCGz0rht/zGJgU5ELkpTXpse2u5DcArqzOTuSdZoWborTf86dVp/aP5gvYApCBS1Aehl00wkjBGUNkcNy2/7Ompov8jN0bIAUWvOHcL0f/wwXRkePYbOmJK3YFXzq0MSezVLOqZuo0bA6PsQIEVsPIcswdlOI2+l5IfUEyuN4s/B4Z64Yf/+xQxwKQtMirjdw6m0bHiyeUmCwvfr58Wiw8CI/nLaC4eETGkyK+Nth51XHvHIlHOJJNMCfMBExuh+LtAAIwCeogAmNy56XgydGi3E9ivzYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5550.namprd11.prod.outlook.com (2603:10b6:5:38b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10; Fri, 29 Jul
 2022 02:56:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 02:56:24 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Zhangfei Gao" <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Thread-Topic: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Thread-Index: AQHYkC3GvF//WyZOvUaTLdl04LC2Cq2MG8sAgAEavgCAAhH3gIABB5EAgAB+1ACAANqooIAAlRyAgAD5zPCAAJo9gIAA+HkAgAAA+GA=
Date:   Fri, 29 Jul 2022 02:56:24 +0000
Message-ID: <BN9PR11MB52761058CFCB9397F6A73A958C999@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
 <BN9PR11MB5276974ABA5981A7361953708C979@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220727115339.GM4438@nvidia.com>
 <BN9PR11MB52766C3D37FA985DEBDC30C78C969@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YuJ6MXoNTj0RKCb8@nvidia.com>
 <78376ca4-9b55-7609-abf1-27a1a376a8e0@linux.intel.com>
In-Reply-To: <78376ca4-9b55-7609-abf1-27a1a376a8e0@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 330de074-e11c-46d8-7369-08da710dec91
x-ms-traffictypediagnostic: DM4PR11MB5550:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U4WCEoxYqzIKWO5uK3QBWxMImJw1RFNZxe9Br69tVN7kWk6r5Z83UL3okChKsGvUNtbELV5zf44KoLafFA6nCeXduubMgaoHUgXKZ/aGtLFbUKPUkjUiQPMKymn37+8TGlG3iDcxIxdMp1zEo+tvQWZN6ZmnqGyr2xH9Ogqrs3OqCi5aV6b87cJpj+Pim1UY6KySW0HxYnlxpsu6G1z/0l6QtITGtQcXi6Cy11d0jGdLmrxfQwLWSomME4/PIOSzWIO+tRnlpVXbotVTmH00ww+y6OWfo2jI9sdtFd1laNbPbhIKANa4J2SnngO7rRXQ2vATKozZ1bjiA39cuWa1VYrdnmwlH+Z2gzlFaA9m87tf3tPIz/sQtY6KAeR0rI+iUuV6DKS9aOU4oqiT+D0hmpohNUC2jxSkv2EDos7yv3hKotBwHm+qXkT7oSSvxvA9spGkmOmU+p4BFnNzDfWyIpbdgyqnFqlHQlI2yicWAuSRJd/hEUrldrY2eOtTd3oITxYAMaVhecvDEMDZkwRKtjQJeD3wXc81Dak0wI+i0OQSARt2VmU0zWuL8LK8FLR4FLYQ4rkepgm2ZJvVa89x9YAB8/i+iDxB6ZucCiNhy76cZ/8YlP5DNEATqgnNg7j1np3y9TcgRIIq9oKcB4Dhdz2FqwuVjiHzO1DeXJbqa4nwPyqI8+k2Az8pXLFTMcfK8GAnDLC1wN7uSKTFwwy/frCQpiE/LWYZZQsw2RawSVdYAQoxMynviEaCR1+UGdL0q5HxxbMAS72P+56TbSA4pOXe6hl41nbOL0T/3P75nPPgJf79x31u0t9+n+hbzQ3K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(6506007)(7696005)(38070700005)(66476007)(66946007)(71200400001)(4326008)(66556008)(66446008)(7416002)(8676002)(9686003)(64756008)(26005)(76116006)(8936002)(478600001)(2906002)(5660300002)(52536014)(33656002)(186003)(110136005)(53546011)(122000001)(82960400001)(86362001)(38100700002)(54906003)(55016003)(83380400001)(41300700001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NCt6YStoNm9MMHNNMkEwa05DZFFUQjg5aUlweHVDS0lRbTVWWUxFdVhHc3Bj?=
 =?utf-8?B?emZUREI1QkV5RWQzaTEvcm1xd3BYUy9UVGNWZU40aXFZRzRoejVsMFRhaHRJ?=
 =?utf-8?B?TmpPRU5nWmV1Ny9ld2JSbkpMbTA3cXkzQzE1VllHL2FCT1JVREVRN2k4Q2tK?=
 =?utf-8?B?M2R0RDZtazl3ZVJDWlM2Q3AzZjRjeEc4QkFyNjFTczlZTHJiRU1TU3E3V2d4?=
 =?utf-8?B?NEwwVTV6VCtxR2dBcGE4eUhqSWZGZE5ObmtacFdQUzAyNDdTOHcyTjlmZ1dF?=
 =?utf-8?B?dTM1TWZxL1dGVEFmOTFZaU9ENHpvNEpaUGlLYktYKzZWcnZTdHJlSEZhUm1v?=
 =?utf-8?B?cmMwRUNoUnhSTmdTak1wSnBCL2dZMHJ4N0QyQys4R2hZU2VPWHViMTRxM201?=
 =?utf-8?B?Tm1yRUEvVXdtSlJYbmhrYVZRcGoxTmRMMWlsZXVkM3hiemUrR3NuWmllZmlE?=
 =?utf-8?B?aWtqT3BGdDNwWVU1WEpyMkF0Ymlnak9FeXFVOHVua1RYMU5LS2ovUkk5T3Vy?=
 =?utf-8?B?Zyt1NU41YzJzc1JHL0ExaDFRTnA2UFVWVTM1Q2xSVzVJaEM5ek5ZUVdWZ0Vm?=
 =?utf-8?B?bHVNMTJNVSs1cmxFekR3cjJQNVZrVXoxTjhGS082TFBBN3EwUUpOdklUU0FR?=
 =?utf-8?B?VFVvNVMvSGxvUmd3a002YVhSVUtta1ZFZThIQ2c0Sy9UWmh5c2ZCZFJXeWo5?=
 =?utf-8?B?ekdkZlNCMFYwZ01ScmttSDNWTi8xNEJqOWVmK3NKb3RkYlRGZ2dPUkJzdC9i?=
 =?utf-8?B?blBkaTFRMFdQcDgzSTd0ZWd1WHJqZWNOdzlYZ1NWQ1pvb25xZENvaDdScmdI?=
 =?utf-8?B?Rml2MFZIVkZLbnZlMGxhWjBlbG1JOE1mbmpFMEhWOGhKWTZoSDE3M0cza0hk?=
 =?utf-8?B?anFTc0N4YXlldHBLZXg4Vk5yWHRlVldHaVFuelBBZ1Z0enUyS0hKZ2VpbHFV?=
 =?utf-8?B?QzFyejF4VSt0Mm9KbHQydDI4c3FIWGFtVGZLcEZkMnc2Z3Z5SjJVbEhwczk4?=
 =?utf-8?B?cCtEZllzSHpGMmt3NjBiNHZNMUV3UmV4Sm5udHdnR21kc203RGQ4MmJ2UlZF?=
 =?utf-8?B?cHZjWmhRSDhKc3FxMzNNM3oxVHlJTDBVWHdnamJ3OTM3TnVZZHNHUUc5dWZ3?=
 =?utf-8?B?T3FPQ0VCdWtxb0dIUm5jNHRHQ1ZBbU5nTldjQnJOVGg3Y3dYNmlmR3BuQjlo?=
 =?utf-8?B?YSsxKzdWMUVmQ3Y1bFArZVlXL0Q1L3RrVVpxTWxubkM2Tk9kem9NYVBPZ0Jt?=
 =?utf-8?B?WmMxekVGZUpXOXV0bUpUc3hpQTZOOTVHSGREL3kzUjI4b1ZxTnROendrNVhO?=
 =?utf-8?B?bnJvZXVvK0c1NVA5d0JjMEN1RlRzZkIzSlNUMHR0a1N0N0Voa3VBeXArVTJB?=
 =?utf-8?B?TWdRcUwyT1E4aTBVaGE0WXp1UEJtSUdiaE1WQ3hCVlVJWjBsQng5a05uNGRT?=
 =?utf-8?B?VFlWd2ZlZnY4U2kxZDBnZHFFQmswZkdGd2ZYaUErUE5idEZRcjlKQzlHMDlm?=
 =?utf-8?B?M3hoSG0zejFWclo1djNGNUNzcDByeU5SbE9NRUUrZDdQRkRFK2R6WmRaZDZn?=
 =?utf-8?B?Mm9xNVBJamJPZDhDdTVyRDZ2MVdkeGdYQll2VjhDcHJKNm5PQ0l3RUpYVGJl?=
 =?utf-8?B?dVlNL0ZRSTg5THMxR2JVOG5qZ2lxSXg2Mnd1eUJpTUd3ejhWcE5rdloxSnlh?=
 =?utf-8?B?aFpJUzVDNm1pZWN1TS9wVGkwc1JmS2VvdnFtN0ljVk8vTUJEcHVtV3JydjY1?=
 =?utf-8?B?RGlLeW9HKzBHWDFuSGF2YlMvM1dFYXZ6MWJZMjUwKzNKQjFJTTBEOHRwemNz?=
 =?utf-8?B?a0dPMnA0TTVjMXFJY0RkK3h2ZEVFdGtNVGpJN21rUFFxUGxtUm9nODhUdXFS?=
 =?utf-8?B?SHo4alN0ODN2R1dQQWtaeHV1ZTRvU1kzQUV2bXVQUGZKditEU29oWGZhY0NC?=
 =?utf-8?B?ejdXOUNZU0pPRFk2dGFiRWZyM0ZOT3ZJZ25LWFpOQWJ2Ull5WUpxN0xhNktz?=
 =?utf-8?B?Rk1HMGpISXZucnN6cWRrL2JwU080bXZ3eHEzTEplcGZIU24yNUVQVFY1WXU5?=
 =?utf-8?B?cnBTVVh4ZmtZT3hET1hwRGkzQTdtdmtmVldiNExoSXJuUFJ2RXVsN05Pam8x?=
 =?utf-8?Q?i8LT2VC/mQ6ZFxpksk9pmj52o?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330de074-e11c-46d8-7369-08da710dec91
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 02:56:24.3346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fhp640LaxU/Q1xtZc2/BRByNNXP4SqwKRzF0xAFPRohvK/Ez6TcTbBRgccjWneUG/Y5D5j67NKBnZb5BlgNB4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5550
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bHkgMjksIDIwMjIgMTA6NDkgQU0NCj4gDQo+IE9uIDIwMjIvNy8yOCAxOTo1OSwgSmFz
b24gR3VudGhvcnBlIHdyb3RlOg0KPiA+IE9uIFRodSwgSnVsIDI4LCAyMDIyIGF0IDAzOjA2OjQ3
QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+DQo+ID4+PiBUaGVuIHdlIGRvbid0IG5l
ZWQgdGhpcyB3ZWlyZG8gY2hlY2sgaW4gdGhlIGNvcmUgaW9tbXUgY29kZSBhdCBhbGwuDQo+ID4+
DQo+ID4+IGFuZCB0aGVuIHdlIGNvdWxkIGFsc28gbW92ZSBncm91cC0+cGFzaWRfYXJyYXkgdG8g
ZGV2aWNlLT5wYXNpZF9hcnJheQ0KPiA+PiB3aXRoIHRoaXMgYXBwcm9hY2guIFRob3VnaCB0aGUg
ZW5kIHJlc3VsdCBkb2Vzbid0IGNoYW5nZSBpLmUuIHN0aWxsIG9ubHkNCj4gPj4gdGhlIHNpbmds
ZXRvbiBncm91cCBjYW4gZW5hYmxlIHBhc2lkIHRoZSBpb21tdSBjb3JlIGNhbiBqdXN0IHN0aWNr
IHRvDQo+ID4+IHRoZSBkZXZpY2UgbWFubmVyIG5vdy4NCj4gPg0KPiA+IEkgZG9uJ3Qgc2VlIHdo
eSwgdGhlIGdyb3VwIGlzIHN0aWxsIGxvZ2ljYWxseSB0aGUgdW5pdCBvZiBhdHRhY2htZW50DQo+
ID4gaW4gdGhlIGlvbW11IGFyZWEsIGFuZCBpZiB3ZSBoYXZlIGEgbXVsdGktZGV2aWNlIGdyb3Vw
IGl0IGp1c3QgbWVhbnMNCj4gPiB3ZSBpdGVyYXRlIG92ZXIgYWxsIHRoZSBkZXZpY2VzIGluIHRo
ZSBncm91cCB3aGVuIGRvaW5nIHBhc2lkIHNldCwgbm8NCj4gPiBkaWZmZXJlbnQgdGhhbiBhIFJJ
RC4NCj4gDQo+IE9rYXkuIEJhc2VkIG9uIHRoZSBkaXNjdXNzaW9ucyBpbiB0aGlzIHRocmVhZCwg
dGhpcyBwYXRjaCB3aWxsIGV2b2x2ZSB0bw0KPiBsb29rIGxpa2UgYmVsb3cuIEFueSBjb21tZW50
cyBvciBjb25jZXJucz8NCj4gDQouLi4NCj4gK3N0YXRpYyBib29sIGlvbW11X2dyb3VwX2Rldmlj
ZV9wYXNpZF92aWFibGUoc3RydWN0IGlvbW11X2dyb3VwICpncm91cCwNCj4gKwkJCQkJICAgIHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlpbnQgY291bnQ7DQo+ICsNCj4gKwljb3VudCA9
IGlvbW11X2dyb3VwX2RldmljZV9jb3VudChncm91cCk7DQo+ICsJaWYgKGNvdW50ICE9IDEpDQo+
ICsJCXJldHVybiBmYWxzZTsNCj4gKw0KPiArCS8qDQo+ICsJICogQmxvY2sgUEFTSUQgYXR0YWNo
bWVudCBpbiBjYXNlcyB3aGVyZSB0aGUgUENJIGZhYnJpYyBpcw0KPiArCSAqIHJvdXRpbmcgYmFz
ZWQgb24gYWRkcmVzcy4gUENJL0FDUyBkaXNhYmxlcyB0aGF0Lg0KPiArCSAqLw0KPiArCWlmIChk
ZXZfaXNfcGNpKGRldikpDQo+ICsJCXJldHVybiBwY2lfYWNzX3BhdGhfZW5hYmxlZCh0b19wY2lf
ZGV2KGRldiksIE5VTEwsDQo+ICsJCQkJCSAgICBSRVFfQUNTX0ZMQUdTKTsNCg0KSSB0aGluayB3
ZSBhcmUgbGVhbmluZyB0b3dhcmQgZG9pbmcgYWJvdmUgY2hlY2sgaW4gcGNpX2VuYWJsZV9wYXNp
ZCgpLg0KVGhlbiBubyBzaW5nbGV0b24gY2hlY2sgaW5zaWRlIGlvbW11IGNvcmUuDQoNClByZXN1
bWFibHkgc2ltaWxhciBjaGVjayBjYW4gYmUgZG9uZSBpbiBEVC9BQ1BJIHBhdGggb2YgZW5hYmxp
bmcgcGFzaWQ/DQoNCj4gKw0KPiArCS8qDQo+ICsJICogT3RoZXJ3aXNlLCB0aGUgZGV2aWNlIGNh
bWUgZnJvbSBEVC9BQ1BJLCBhc3N1bWUgaXQgaXMgc3RhdGljIGFuZA0KPiArCSAqIHRoZW4gc2lu
Z2xldG9uIGNhbiBrbm93IGZyb20gdGhlIGRldmljZSBjb3VudCBpbiB0aGUgZ3JvdXAuDQo+ICsJ
ICovDQo+ICsJcmV0dXJuIHRydWU7DQo+ICt9DQoNCg==
