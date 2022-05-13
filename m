Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C23D525CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiEMIOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiEMIOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:14:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934911FE1C2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652429638; x=1683965638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ogns5GDgPczjGjIjwC/Is6wXz1aPqD1xyoE30XEGMys=;
  b=iwacV+YggFxY3FVJzTYN+h1eTw6A+UD8COzYgWbDv5oI8N9FGm6QJFcR
   As5hmSDIDAZn4WR3wpVFoOKVWcWlVoI5uQrd1vqMmqSNWlBm0Ue3Zu2Wo
   8skysXWAD1UaneSB6iRExIkJzU6D+MSj3nX9CgSbNOdU93ZsgYBTikbma
   0r/YXHMiB47n1oQA3aSMq2LIe8lfL92tWM7Kkkk9Lbn3uA+la0eREbSKB
   wUzx9CrHfaPaHLVmPPxMP6RNgZUT9t6qvFod/cjsjbLFQkkmAGRLuTgc/
   BejjTyb9R7QUsChm8b14sKYkalipnwXBmhtKCTFJ049AeAlv5GpdipCuq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="330848227"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="330848227"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="698403145"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2022 01:13:58 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 13 May 2022 01:13:57 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 13 May 2022 01:13:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 13 May 2022 01:13:57 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 13 May 2022 01:13:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7HFOWFISpWF+aygBCDRFvcr44D3jEIW3Lpm4pcB81CTPDmbiENN1ihJjRWAFAuisg4sO1egdKOgpmp4GxMJBVVsNz4nphyuwKGBB20Jf1wPZ+9dM2I5+XrWahjj4g0lKdx0MOlAZlaXHGXbreMsXox2sstyR3FtxkRT1T5E5o8qf9l4arcYjYIWtXd5O6OBdcEOFBqVTETF/anCB3XBXFwf41i75TdAwKVvjr9s4D4A3Z5X2MXPhdHoo1wvlMUhdQO1W48QjiOlT0ZnoFv7I3ftSms4qPDgUr3CaiYnDx5eOon/2x/Xule2/iNKdTGh1+O80LJNGIycWLF0APYgsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogns5GDgPczjGjIjwC/Is6wXz1aPqD1xyoE30XEGMys=;
 b=gydCP8oplAWeTyAA6KMw09TvUNMLODk97rMRqV+q2oubwnOjgqpEe7iLXpOG177Z75aPbcFX3///JjLUItJghbLKQm0733QHXvSRabooo/oFY7MpePTY3+/7PJgf68L02JcxJMk5eXopJU5usXyug6U31C7rXBJgpHLiT9xoim4/7olDKa/KcBVqqLmzbKDagxQ1d52oYSmaZM4EPZaH+A8YQtuRoURo2GcvF69kIcHjOerMq/RDvlfgp2COX84s1+s0a8f2y9mKn3I85+/GZLoaHc6X+qTVwzhNY7I88tYHSATCi4jrCYaG3mbtwi6Q48yHFQcfsQMFuKPU3yb0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4903.namprd11.prod.outlook.com (2603:10b6:510:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 08:13:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5250.013; Fri, 13 May 2022
 08:13:55 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
CC:     Qian Cai <quic_qiancai@quicinc.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Thread-Topic: [RESEND PATCH v8 00/11] Fix BUG_ON in
 vfio_iommu_group_notifier()
Thread-Index: AQHYUr6bKxnUEgkSRUuDEn2xbHeWB60L2TwAgAKm84CAADTvgIAAAYqAgAhKUgCABZn4AA==
Date:   Fri, 13 May 2022 08:13:55 +0000
Message-ID: <BN9PR11MB5276B0B40AF2283962793F6F8CCA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220502161204.GA22@qian> <YnI8Xy54M3XQpS0T@8bytes.org>
 <20220504115135.GA49344@nvidia.com> <YnJqER3qbzHucfkx@8bytes.org>
 <20220509183310.GS49344@nvidia.com>
In-Reply-To: <20220509183310.GS49344@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77650d57-47ef-426a-77b7-08da34b88632
x-ms-traffictypediagnostic: PH0PR11MB4903:EE_
x-microsoft-antispam-prvs: <PH0PR11MB4903B85841A07702563A596F8CCA9@PH0PR11MB4903.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pjZJUGOJ3DA7H76vsWu2aVDZLR5aSXnFfIdP1UjmyFWpr3pgLYLxkAS3/ZG2WnZuiwgiFgoFC6yVgcS9/VGEdHiEt2HDpBV5QuGBRIxYAx9KqVOne8v1N2Eo/BD3jQ4WEDkr24utewbqzEuOInaxRepSF3uvsUSUCdDr2z2nq/P8Uk53P/lP5pBMZZP9s3EtQNdZQTdiBIB1EV7T3Y53lDAiFpJ0vfYuULFAa7cRggdgo15duX9Aso3zNa+1/IzTNmUDjkuJlMLUNWXf2OgpbazDWo75mbD53wIhzPu42lwJ4O6sqX2OuP0eeyINBojXpBymg8Gx4dxUPJ9v1KZ1iqQW55Ccx5RrCwVvzrpd315V3zYYF11PGMvuRyFqLj0UXudt0f4BHEc+8eDunUsWnV8b437+gGcfHFESUC39s1jA8CJJNuns3k2N6IrnLq7k1h+A4VITgtcbMtp9Bz6DUkIJ7oRQH6pp/eNCageEjQjydZJynTpu0n8EW29JsJS0QA/TfkCEBAv9E6mGpisRqm6w7Uv4M2yH3vCzkxC5exxzR0tvdcSvMurngyKPNyAqa4hzHodHGDsgAU3NI5ASqxps9MrQDdAKw2y+OKOZATW6D1Qy750nPKisfkc2knWW32jaTU2mObNScxz3SKjNvfIqGHCLrIEWp6yerMIL2+SfUzCM5Q0Y+fwd9eWJ1R4+MDcwSWn0N6hMQojHhLp2jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(86362001)(76116006)(66556008)(8936002)(64756008)(66946007)(66476007)(508600001)(66446008)(4326008)(26005)(5660300002)(186003)(7696005)(9686003)(6506007)(33656002)(55016003)(52536014)(2906002)(316002)(110136005)(54906003)(82960400001)(38070700005)(38100700002)(71200400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTFYcmtpY2d4ZktmcjA5T0pjMXk4SmM0Qkx4bmpwQ0hUMit5OFg5SU9NbDly?=
 =?utf-8?B?RmZ2MkxZK0dzamhHUXM5NFN6emRIWTdLc0NYUnUxYm1rSklWUDJ5QUdWL0lw?=
 =?utf-8?B?ZURFbUExUmFkcUFwV084dTE1dzh4aXF1aFFwTHZIVnFlcVhmdCtQQlcvbnAr?=
 =?utf-8?B?ODYxRndTR2NNaDlJeStmQVBKZnZndzM3U0x4MzMzckY4T3pOMlNPNmlPRFFw?=
 =?utf-8?B?S3VYcEtPclh5SlVYWUxiM1JNa3VUOHBZb0hDbFFJVjFENS9tbk1XRngwSDhL?=
 =?utf-8?B?VjFac2NFR1JraU1oTjdoTmFNZVJscTk3czhqcHJXeVRrWTNDRXVub0dRSlVG?=
 =?utf-8?B?M0FEdmhZZzhTeWkzTExmWUtSU3AzL0tjMytwaGZ5bkx5RzU5QmlVSDRqbjUy?=
 =?utf-8?B?QWtsZjQwMFgra2xjdHNPVWoxZ0FFdUJ5OFBNRWpxc21WSlpPeWRYNnBLQW9M?=
 =?utf-8?B?bjYweGJlMm9HYTZsWTRiR2VVWG9hUUVENC9PZHhxa0pTblVWQ0h4RWJ0RWMw?=
 =?utf-8?B?T3lmNjFuR2pEYm15WnV0VFozUnJFb3NtSzB4RU1wcGxmaWtEME11ZDJEb09X?=
 =?utf-8?B?T09MTUFBb3JwZndQeWpJWm8veU5TSUVuNG43S2k4QlpFUmVoTDdUNVNOMm4r?=
 =?utf-8?B?dXFoTEwrd2NkMC9QU1Z0Q2xHeW9aNlpxd1BodTE4SmxGYzRSUTFwamplbHFh?=
 =?utf-8?B?RXRFZ1JCM0VveUU3Q1pqY3JhZDFQTVprcUFxeUxscDBRU0gxSFpFK1NHZDRS?=
 =?utf-8?B?c2IxUUlwVE5CT2xtWklWWGZ1dURkNG5DSnF0b0xOYWRvNFhGNEc3Ky9KYmox?=
 =?utf-8?B?UFNWVDVFWXc2MmhVdTNnYm5QQ0s3a01MS1dKV1B1RXBEa2xCcTRjMlRONVRZ?=
 =?utf-8?B?TnVpZkpTS1FvalRJdVU4c2dlT0hYUmNPdnNnazMzRzA0OEJxdUVEVzMrM01M?=
 =?utf-8?B?T3krR2xKci9GS2xGeG9VQW53TERvcXk2VHRoK3JnNWVlK3l1a1VSMFNIcjBh?=
 =?utf-8?B?cnc0ek1OQ1phdnV0SFRnUnNpYzdsaHhXVVVyL1pnc2pscDQrRnFpQmI0ZVZQ?=
 =?utf-8?B?QkkxbzdSTjMydThERWNpcVI4SEpUOEtoTTZMbW05NnNUZVp1a1UxcE8zLytS?=
 =?utf-8?B?dHdlZUZ3WGRQcStubEQ5TlQrNEwzVnV5Uk4vL2dzQTJ1Qms1WU9NNVlwRTRP?=
 =?utf-8?B?ZDhoRk5rSHBDeWp4MHI1c0FKYjlQSlpYZ2U5Mzl5cVEwM3ZtaytuV3QzdmRX?=
 =?utf-8?B?NnhLL29sUmFUa2dkMXJUWTR3YUVNdEhjSlNXM1A5aS83bjdtR1V6RGtmTFFK?=
 =?utf-8?B?ZkdmV0tjNE4yN0NQNFU3VmlWQTBBOWFLYm9VbWEyK0tmTjZFZ0R0d1NtS1Vl?=
 =?utf-8?B?amdTLzVCblBnMmdzdjJsbm9pL3lXdnM1dGh2VGwzdkJTZDAySVhrOHBnVXpu?=
 =?utf-8?B?NXV3RERXbm5haGtIRlpCUEhld0Q3RzJhTklIYmdIR3d3bjNQSEw1aFFxYUpH?=
 =?utf-8?B?RG1GTjRtTERMWGwwTzZWaUQxcGc3cU5kNGNYbVE1UE5tRVBIU3NzakZyeU1p?=
 =?utf-8?B?TDg5dnAycmxCZjE5UVdaY0ZLS21aajI3MVgrT2dNbUJJMC8rb3NMaXZWQTZV?=
 =?utf-8?B?MmtDRmFrejV3U01mYzc3eXJUL2l4cGhpeGROOVcvMEczU3lrWVIrNXhNNWpQ?=
 =?utf-8?B?RlRkSjhrNmdLYVZOMjk1VnFkbWJsTURnOVdtOUtObTdnRnVzRWJTMmtweElI?=
 =?utf-8?B?R1NaaDFMRUhKSGJ4TW16QmNCMkZsSWoxSnFFUU0zd2ROY0NTWElEUm1JNjhL?=
 =?utf-8?B?S3U5bmdhM1NuY2dSemxqRVAzR0dOWW1HbmVDV21Pc1FIMGRKT01XeUlIa1Ny?=
 =?utf-8?B?bHprRUNFY2VrZlpzQ1JzbkpOVjVtNXY5R1hEb3lGYlk1Ukd6YWhRREtlYlFY?=
 =?utf-8?B?WjBoUjk1WGgyMGJQMWRXaG15YVJxbkxzUmpMSDU0c0xlSEcvb3pTdUJ4QVh4?=
 =?utf-8?B?Z29pdGNmOWRUYXlZQmp2eDZpQkJyb0w3eG9PczZGU1ZZOGhrbndCdUNJLzAv?=
 =?utf-8?B?TDdHSTFVZHhsSTJvampVVWhrYjBHdEV5R2Z2VlBudzRXYTRlZCs2eWhqK2ZC?=
 =?utf-8?B?QW9DK2FnWHVFOXBkY3pHdDFndjZuNEJuM1BzQWJrQzk1TlBDY1lRaVpadDFE?=
 =?utf-8?B?OXNYaUszSUE2aHAzQnpsZHRpT3JKU3A3ZUhKWVMwb3ZJUDR6ek5oK3JEeUI5?=
 =?utf-8?B?R1NFRnYwUTd0cW9DSFNKdmMvMHNYYnZzSkZ0MTNRNDJySnp2QklMckdxVjNS?=
 =?utf-8?B?eXRZbmVVOW1iOThqdEhzakozMVJoY1J1MUw4UWJHU2Fxb1F5SGtMUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77650d57-47ef-426a-77b7-08da34b88632
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 08:13:55.6116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qv6UCOgvsO0VEaj/rtCraLs5kBVEvmEvfpmTwsTqDAcsRH4/CT34vhakv86iSx5yqj/NI0UWwmG0DGfYIVv7Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4903
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

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUNCj4gU2VudDogVHVlc2RheSwgTWF5IDEwLCAyMDIyIDI6
MzMgQU0NCj4gDQo+IE9uIFdlZCwgTWF5IDA0LCAyMDIyIGF0IDAxOjU3OjA1UE0gKzAyMDAsIEpv
ZXJnIFJvZWRlbCB3cm90ZToNCj4gPiBPbiBXZWQsIE1heSAwNCwgMjAyMiBhdCAwODo1MTozNUFN
IC0wMzAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gPiBOaWNvbGluIGFuZCBFcmljIGhh
dmUgYmVlbiB0ZXN0aW5nIHdpdGggdGhpcyBzZXJpZXMgb24gQVJNIGZvciBhIGxvbmcNCj4gPiA+
IHRpbWUgbm93LCBpdCBpcyBub3QgbGlrZSBpdCBpcyBjb21wbGV0ZWx5IGJyb2tlbi4NCj4gPg0K
PiA+IFllYWgsIEkgYW0gYWxzbyBvcHRpbWlzdGljIHRoaXMgY2FuIGJlIGZpeGVkIHNvb24uIEJ1
dCB0aGUgcnVsZSBpcyB0aGF0DQo+ID4gdGhlIG5leHQgYnJhbmNoIHNob3VsZCBvbmx5IGNvbnRh
aW4gcGF0Y2hlcyB3aGljaCBJIHdvdWxkIHNlbmQgdG8gTGludXMuDQo+ID4gQW5kIHdpdGggYSBr
bm93biBpc3N1ZSBpbiBpdCBJIHdvdWxkbid0LCBzbyBpdCBpcyBleGNsdWRlZCBhdCBsZWFzdCBm
cm9tDQo+ID4gbXkgbmV4dCBicmFuY2ggZm9yIG5vdy4gVGhlIHRvcGljIGJyYW5jaCBpcyBzdGls
bCBhbGl2ZSBhbmQgSSB3aWxsIG1lcmdlDQo+ID4gaXQgYWdhaW4gd2hlbiB0aGUgZml4IGlzIGlu
Lg0KPiANCj4gVGhlIGZpeCBpcyBvdXQsIGxldHMgbWVyZ2UgaXQgYmFjayBpbiBzbyB3ZSBjYW4g
aGF2ZSBzb21lIG1vcmUgdGltZSB0bw0KPiBkaXNjb3ZlciBhbnkgYWRkaXRpb25hbCBpc3N1ZXMu
IFBlb3BsZSBzZWVtIHRvIHRlc3Qgd2hlbiBpdCBpcyBpbiB5b3VyDQo+IGJyYW5jaC4NCj4gDQoN
CkpvZXJnLCBhbnkgY2hhbmNlIHlvdSBtYXkgZ2l2ZSBpdCBhIHByaW9yaXR5PyBUaGlzIGlzIHRo
ZSBmaXJzdCBzdGVwIG9mDQphIGxvbmcgcmVmYWN0b3JpbmcgZWZmb3J0IGFuZCBpdCBoYXMgYmVl
biBnYXRpbmcgcXVpdGUgYSBmZXcNCndlbGwtcmV2aWV3ZWQgaW1wcm92ZW1lbnRzIGRvd24gdGhl
IHJvYWQuIGhhdmluZyBpdCB0ZXN0ZWQgZWFybGllcg0KaW4geW91ciBicmFuY2ggaXMgZGVmaW5p
dGVseSBhcHByZWNpYXRlZC4g8J+Yig0KDQpUaGFua3MNCktldmluDQoNCg==
