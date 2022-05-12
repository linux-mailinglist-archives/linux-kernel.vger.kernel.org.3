Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB7C52451D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349984AbiELFpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiELFpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:45:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B080216067
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652334299; x=1683870299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UUGNKpz2rgaVYkDLQ07oRSzYeXkyQSzF5yySFlQiOLQ=;
  b=PGpADbsAIfg4Jf9BNBQ/OFxEwiDFNhHkdZgnhZ68YpDnAZKizwBTwtO7
   TZMMu9B11rZebAwRg+ffSRv67xHq9Absok74QXI3jC3zXMAeVrkFWnJDa
   gnvp7vzhmysYHdBm9E7ctU0pQn/P7XMYDuhXZcW2WG8tW/dLPBOnx/BDe
   CffEMoSDyGpqksQwk60wTHWE/Fb6qrkKL6nIorjOQ4Vhyl3+PQYWaITsh
   Noowino8HgGPhhDSocdJkohwAi41YBvRTKYYzBi81MUerJBhAODN5QKjO
   3EETtcfPiI86Q+s2stXdDcuu9rlsAy49Jfz+QdeEJAsGU05lOrZ28XOzt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="332935856"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="332935856"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 22:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="739534669"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 11 May 2022 22:44:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 22:44:52 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 22:44:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 11 May 2022 22:44:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 11 May 2022 22:44:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ry1KP0m2dVxWx8OvKjyNrsqW4hnNkeS3TRe+GkdfmfIwS+EOwwHmO1x2GJe2ENfo+7iDMTIDqKN7CjLJG8354NhRaK76sth5A3M4CRx4s7mUESsbe0wTOKuBHADJS0LtUs6z0YnPQfOjhHrJ4xtim5mqv/E00OK7esPbU6PdS99O9LCktib4Y/CHcfL9Yd81lBhIIdLFbtZbHOimxtcrySFIUfDGSBOE0AFXDVvSbXAIqfdEL9wrhCro6D6uw/jxae9yLDgJAeaKX9RnginMJ1gzq3+hUmPcMkB7MvOKLUnRnMMF3AWVCATvw9nRc4Rlaw4Ql76+rBmb0lyKraEGNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUGNKpz2rgaVYkDLQ07oRSzYeXkyQSzF5yySFlQiOLQ=;
 b=G0wsWZ4hOAFv4gv+hYRqDf5OX8JjB0vaJxFVtI3JvnFCCfQ/WY27oUICCR6MNS8sKKN8YXMfQkGbfBrjpcUEQzjqfVxpbwoOBZJxPdit35tR3w5WVmKKER9gCaSI5aLItSGPKVBKK669MxKrZ+7p4n2ta26RsQo6Sya1Vwtydtpl2KV5uMa5p3QC5TdnjwX0p9uFpJ6JFeo2UwLHd9x1RzDWjx40T+PdwZTv6BTUU8EQF3sdJvdUzT9sy2c3DWp+279v8jOobUflvf986DqfPLqppt0QDIx568lkZukQiBhTZYmbctp41BiXQm+Dsja8AJgU1+0wJ2L6kdAjCg2lhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH2PR11MB4439.namprd11.prod.outlook.com (2603:10b6:610:49::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 05:44:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 05:44:49 +0000
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
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Thread-Topic: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Thread-Index: AQHYZDYuY5mdau8gXkqO6XGUIK16Ua0YO2IAgAELqoCAAH48gIAAy8WAgAAf/TCAAAWWAIAAB3Ng
Date:   Thu, 12 May 2022 05:44:49 +0000
Message-ID: <BN9PR11MB5276AFC5784F4D1FBA90E6058CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
 <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
 <20220511145319.GZ49344@nvidia.com>
 <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
 <BN9PR11MB5276C03134A898CA9EFEE9258CCB9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <64954f2d-2274-410e-269c-84efc0635633@linux.intel.com>
In-Reply-To: <64954f2d-2274-410e-269c-84efc0635633@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fd0cdf0-2a65-4010-dc99-08da33da87a7
x-ms-traffictypediagnostic: CH2PR11MB4439:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH2PR11MB4439002AC12DCCFB669FBBE38CCB9@CH2PR11MB4439.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k/TN0uSFVJX8VZM+12XWEj0EBMOBdQdWNZS4v1MIQWp4u9Q4tvjxvgpA5+LfHRaWXQ23QcfATbbQ3uWpBvNIDvGAHf1dTZtrjrXkYzCxZslDEyt1WBiIcUthIemdfjkoRkzTkJ782eKGQFuf+shMWqELALCSYIGlFCIWqp9YzWrudwuz+SZ+7TADTq+DTyJ6eFiQ5S1owPb/29Ki/x9cTRPE/LE8wfeUAI4xqlL3Q6O33MTrVXwIjztXZMFBDIDnqB20Y03ww2OCAjPgPtrWCu03LBs0ANzsj189cnRaEYjGkoOXeA1ZZ/5CrcEzG/oaIEOOLoadZ5fBysIae90H31tJaeuIgMOZtuAjWPJvX/IbXxVHJ6+Xk3ZaaDzBJs4FVSAVGhRf/qw1PaRQb9a1YrS0eR/qpSkkPHNTTm6Q8g3l08pDAKG5g5coCAGa+E2U+CBClw7EQc+u/yvin3Jk9F9UvCOlaxqs5uoI6Ey3WeY/XDxiBiuY9dDq1efYq3WVnt8jyCDiNPzaFYi3n8iRuBjID0HhTdzkfawzlpmOl8Ordeba+tZrPIyV+KSxqiO4D3P7sIPJ43X46n75caCfGClQWguK8oIY8MKuYhkkcHw2zRNw41Jr5RTCFRclsZtXukJUVIHi4NRqgz6kvmRHSLi2a045QWNNLGBUUtanvSaPaNNG8bQW3OkSBqU7fs5bW/3qx+CTUnzNAq27HiDppA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(53546011)(71200400001)(26005)(7696005)(38070700005)(38100700002)(508600001)(83380400001)(82960400001)(9686003)(122000001)(186003)(55016003)(8936002)(7416002)(52536014)(5660300002)(33656002)(54906003)(110136005)(316002)(2906002)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzlDSkZFU3JmNExCTnh6bnFBNzdISnNBUnVyTVl0aXZjQmIwZ0Q2UEZEZUI1?=
 =?utf-8?B?dGxOV2RBWnNodEJYWm9MYVBpQTE3b2pkK1FhWExCNzI2bkZtaUI5bTdHb3Fs?=
 =?utf-8?B?Qi9aWVk0ZEwvYlZldVlWSnVyWE1oMHU4WS9GQ21heVluMVJ5WjRWTDJXeTJK?=
 =?utf-8?B?U1l5UXVaaDVKTzMrczBUbWtlSVBGU2Q1NUduNlVuRnVta1lzRVVWZ2NtMDlT?=
 =?utf-8?B?ZXllZ3FhYUkxYkJ6WkU0QnorSHkwQzRHMXVGeFNRN3JDQWt2enF6bFZiVzVW?=
 =?utf-8?B?bW4vSFNrbmhGSVE0Zm0vWlJiRlplUGUxSGx6S3d3dkZiOHdnVFZHUDNFemRj?=
 =?utf-8?B?ck5wOFpUb3M0czZ6L1V4Vy9jV3BtUGhCeDVBVy9kemJ0MjNGRmNDV3RqbEdW?=
 =?utf-8?B?ME4vWDBEeFVXd0N4R2tWUDZyeSsyOW9VQlZrR3pJSldsdGcwNWNteVh2S21u?=
 =?utf-8?B?MFN1N1UyTHo4SjFwZk9yWmpRR1V3UWVRMklYakdjZmJxT3U1VHZORnNuRlpr?=
 =?utf-8?B?L0FNNmZIZjNVS3ZFa2ZsSUF5VTJmcXJ2c2ZZb09WQUUyVUw3d3NFWVhqTExQ?=
 =?utf-8?B?RU0rTVY5Z1lZeVljd2RBN3o0dnlEZmJHS2JneVQ4R0ZhQUR4NkdwSUF1UFpv?=
 =?utf-8?B?cW1YZ015V1I0QmZnbWttaTFraEFzcVlqVUl2TTBiVHEyVE5ra2pTRjZ1aG1p?=
 =?utf-8?B?ZVhlWXJSRHFqWE1UVnl4Q1JPWkl6NmI0U0Q0eDhDUVdzT3hUVmhmMVBsMmdJ?=
 =?utf-8?B?UnJGZU8vUUR0ZDY2NXF6MzJnRHE5dks3SktrWUJxUHZLM3Z4ODJ5aHZVaXc0?=
 =?utf-8?B?dUt6elNUb3NaNE52TklpRGszTTFRdHVHV0JGOS9rd3lTdEFRemlBb1dRMmRC?=
 =?utf-8?B?YndFNUVieVNrcWNTSmUrV0hQUTFEdzAzV3dROEVCZUU3RVhmSEdpV2hJUitj?=
 =?utf-8?B?OGd6QkZTYnJHYkFsanpWWG01cTdyNDhMOHUyVWUvRVNGb0VVUUJhbjF5V3Ez?=
 =?utf-8?B?UVFmN3hHSUhad09yc0Y4T1NJaGlUS3hFa0tySDhkRkdmOVZrOVc2bVY4cHRT?=
 =?utf-8?B?ek9QbXlsVk1oeEZ0OStnQUkvZ2NYRllRcDdrNUdQbXladTBoVlVBUEJSdTJY?=
 =?utf-8?B?aUVtTi90TEQ2V2JrTXJJTENLaXY2Wmk4MTV6akZHVHNRMitTdHlzRy9COTVr?=
 =?utf-8?B?ZDVBbkdNWWlxVkRsUWNua2FOT1k1aTFNcjRBR0NTV1dMNldBMWs4TDZ2MzZ2?=
 =?utf-8?B?VFgxY3hGZitJZEFMYTc0KzNMVWdPc3pybjlJQkhCRUNlall3YThzalRCVWpU?=
 =?utf-8?B?ZEFweVFDaGw0dE0xS0VBcEltcGdaNUhnTURJeXlueWlyNjNIbVFDWXp2VS9R?=
 =?utf-8?B?YWZsRGVDTnRYVnNMUXk3T01qL0s3Wjh1bU4wOEtUdUp5T3Z2V1A4RW9Rc1I0?=
 =?utf-8?B?MTRZaXAxMTB1ZWhaMUxrQnVqYmVQeTFGMHlYMm9SMGFUMzJYbGkwREhWdGtK?=
 =?utf-8?B?MGJEREUvTXNOL1UzQVhBdTB2R2h1NzdhZ3NxN0toRTNBZ3VIL1AwZ2tjV2xQ?=
 =?utf-8?B?V2p3QXc3VXIvZzlxaXFlT3hPaTRRS2t6akRHRGtCOVJrU0pFeTNweXI1WXV5?=
 =?utf-8?B?Q3ZLYm5vWVJtVnpSTlNrT0R3Njg5VndKcVlDVkI5YzJRY1cwSkhxUkcrZFhz?=
 =?utf-8?B?d05IYlg4eEI2TDdGdjFLMm9WME5yTEJ0dWcxblVSbFVSbDh4VWk3OFJYdThR?=
 =?utf-8?B?NFo0ZkloN3h2THl2YnlnRmNsMTJRLzgvWEhQdDlBZThGc1NOZWtNNHJKQW8r?=
 =?utf-8?B?UUZsblBnZEw1UHhobzVCaTNVTHdMNWw0SEYyRFJod29iZ0lxMGZJS21EYUt1?=
 =?utf-8?B?RjF5V0xwT1NLM0x4UjRmSjdpSVNlb2VTbzlHd0tOa2lxWVZuZnludG52RVRY?=
 =?utf-8?B?V1JuNUVTVm1zK05oKzgwYUxONC9WNkJiMys0OGF1citORjVrNXRUdmZwb095?=
 =?utf-8?B?M0Vsa1VxdWR3Nk1MUXZBMU0rdm43TjNYQ0RzbjJ1ZWRmemhXSTlwVyt0a1pB?=
 =?utf-8?B?UVJ1S2YxbTB1VXY4c1N1YXVLQjFuaytWK2hEVnRYc2VrOWJMMkFVZ0VDOUp5?=
 =?utf-8?B?VE5NZkptMVFxSklPUVovZys4bFZGVmdiZ3NIN0QxdHU5K29yUE5TNjJiUEIz?=
 =?utf-8?B?V21uM2M5TDJjVFZ1NTYyNW5DbnR5Y09oZzVvUWluTW1QNE1hTU9DRmRkY205?=
 =?utf-8?B?dzVwbm9JOTJydTh3cHdGUXBac3JVUzk5emZYMWJoeWpKeWl4VnVUY1B0dHdt?=
 =?utf-8?B?b3NlaTVvQXRxYys4akJydWtsNUw5VXB1Q2hmVlFDSWIrY2pzQzhhQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd0cdf0-2a65-4010-dc99-08da33da87a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 05:44:49.7689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQnQz0SXhE/zLRE5rsJc1O3Flhr7PBFEH9k94/rW3GqwYASiyJP0LnABJgTdO5oSQao7O/gW+EQdkNOlX/wh3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4439
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgTWF5IDEyLCAyMDIyIDE6MTcgUE0NCj4gDQo+IE9uIDIwMjIvNS8xMiAxMzowMSwgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEJhb2x1IEx1IDxiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMTIsIDIwMjIgMTE6MDMgQU0NCj4gPj4N
Cj4gPj4gT24gMjAyMi81LzExIDIyOjUzLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4+Pj4+
IEFsc28sIGdpdmVuIHRoZSBjdXJyZW50IGFycmFuZ2VtZW50IGl0IG1pZ2h0IG1ha2Ugc2Vuc2Ug
dG8gaGF2ZSBhDQo+ID4+Pj4+IHN0cnVjdCBpb21tdV9kb21haW5fc3ZhIGdpdmVuIHRoYXQgbm8g
ZHJpdmVyIGlzIHdyYXBwZXJpbmcgdGhpcyBpbg0KPiA+Pj4+PiBzb21ldGhpbmcgZWxzZS4NCj4g
Pj4+PiBGYWlyIGVub3VnaC4gSG93IGFib3V0IGJlbG93IHdyYXBwZXI/DQo+ID4+Pj4NCj4gPj4+
PiArc3RydWN0IGlvbW11X3N2YV9kb21haW4gew0KPiA+Pj4+ICsgICAgICAgLyoNCj4gPj4+PiAr
ICAgICAgICAqIENvbW1vbiBpb21tdSBkb21haW4gaGVhZGVyLCptdXN0KiAgYmUgcHV0IGF0IHRo
ZSB0b3ANCj4gPj4+PiArICAgICAgICAqIG9mIHRoZSBzdHJ1Y3R1cmUuDQo+ID4+Pj4gKyAgICAg
ICAgKi8NCj4gPj4+PiArICAgICAgIHN0cnVjdCBpb21tdV9kb21haW4gZG9tYWluOw0KPiA+Pj4+
ICsgICAgICAgc3RydWN0IG1tX3N0cnVjdCAqbW07DQo+ID4+Pj4gKyAgICAgICBzdHJ1Y3QgaW9t
bXVfc3ZhIGJvbmQ7DQo+ID4+Pj4gK30NCj4gPj4+Pg0KPiA+Pj4+IFRoZSByZWZjb3VudCBpcyB3
cmFwcGVkIGluIGJvbmQuDQo+ID4+PiBJJ20gc3RpbGwgbm90IHN1cmUgdGhhdCBib25kIGlzIG5l
Y2Vzc2FyeQ0KPiA+Pg0KPiA+PiAiYm9uZCIgaXMgdGhlIHN2YSBoYW5kbGUgdGhhdCB0aGUgZGV2
aWNlIGRyaXZlcnMgZ2V0IHRocm91Z2ggY2FsbGluZw0KPiA+PiBpb21tdV9zdmFfYmluZCgpLg0K
PiA+Pg0KPiA+DQo+ID4gJ2JvbmQnIHdhcyByZXF1aXJlZCBiZWZvcmUgYmVjYXVzZSB3ZSBkaWRu
J3QgaGF2ZSBhIGRvbWFpbiB0byB3cmFwDQo+ID4gdGhlIHBhZ2UgdGFibGUgYXQgdGhhdCB0aW1l
Lg0KPiA+DQo+ID4gTm93IHdlIGhhdmUgYSBkb21haW4gYW5kIGl0IGlzIDE6MSBhc3NvY2lhdGVk
IHRvIGJvbmQuIFByb2JhYmx5DQo+ID4gbWFrZSBzZW5zZSBub3cgYnkganVzdCByZXR1cm5pbmcg
dGhlIGRvbWFpbiBhcyB0aGUgc3ZhIGhhbmRsZQ0KPiA+IGluc3RlYWQ/DQo+IA0KPiBJdCBhbHNv
IGluY2x1ZGVzIHRoZSBkZXZpY2UgaW5mb3JtYXRpb24gdGhhdCB0aGUgZG9tYWluIGhhcyBiZWVu
DQo+IGF0dGFjaGVkLiBTbyB0aGUgc3ZhX3VuYmluZCgpIGxvb2tzIGxpa2UgdGhpczoNCj4gDQo+
IC8qKg0KPiAgICogaW9tbXVfc3ZhX3VuYmluZF9kZXZpY2UoKSAtIFJlbW92ZSBhIGJvbmQgY3Jl
YXRlZCB3aXRoDQo+IGlvbW11X3N2YV9iaW5kX2RldmljZQ0KPiAgICogQGhhbmRsZTogdGhlIGhh
bmRsZSByZXR1cm5lZCBieSBpb21tdV9zdmFfYmluZF9kZXZpY2UoKQ0KPiAgICoNCj4gICAqIFB1
dCByZWZlcmVuY2UgdG8gYSBib25kIGJldHdlZW4gZGV2aWNlIGFuZCBhZGRyZXNzIHNwYWNlLiBU
aGUgZGV2aWNlDQo+IHNob3VsZA0KPiAgICogbm90IGJlIGlzc3VpbmcgYW55IG1vcmUgdHJhbnNh
Y3Rpb24gZm9yIHRoaXMgUEFTSUQuIEFsbCBvdXRzdGFuZGluZyBwYWdlDQo+ICAgKiByZXF1ZXN0
cyBmb3IgdGhpcyBQQVNJRCBtdXN0IGhhdmUgYmVlbiBmbHVzaGVkIHRvIHRoZSBJT01NVS4NCj4g
ICAqLw0KPiB2b2lkIGlvbW11X3N2YV91bmJpbmRfZGV2aWNlKHN0cnVjdCBpb21tdV9zdmEgKmhh
bmRsZSkNCj4gDQo+IEl0J3MgZmluZSB0byByZXBsYWNlIHRoZSBpb21tdV9zdmEgd2l0aCBpb21t
dV9zdmFfZG9tYWluIGZvciBzdmEgaGFuZGxlLA0KPiBpZiB3ZSBjYW4gaW5jbHVkZSB0aGUgZGV2
aWNlIGluIHRoZSB1bmJpbmQoKSBpbnRlcmZhY2UuDQoNCmNhbiB3ZSBqdXN0IGhhdmUgdW5iaW5k
KGRvbWFpbiwgZGV2aWNlKT8NCg0KPiANCj4gQW55d2F5LCBJJ2QgZXhwZWN0IHRvIGFjaGlldmUg
YWxsIHRoZXNlIGluIHR3byBzdGVwczoNCj4gDQo+IC0gc3ZhIGFuZCBpb3BmIHJlZmFjdG9yaW5n
LCBvbmx5IGlvbW11IGludGVybmFsIGNoYW5nZXM7DQo+IC0gc3ZhIGludGVyZmFjZSByZWZhY3Rv
cmluZywgb25seSBpbnRlcmZhY2UgY2hhbmdlcy4NCj4gDQo+IERvZXMgYWJvdmUgd29yaz8NCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gYmFvbHUNCg==
