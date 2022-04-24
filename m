Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF9350CFEF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 08:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbiDXF6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 01:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiDXF6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 01:58:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C19F2C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 22:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650779732; x=1682315732;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ty86MNbN1cTVgpBMtgfw1qRiaW/r+Ls3dQPDP+gBLtk=;
  b=EP0wx0IhgKrAbSlwrbZ3DcrKXT8bz6DVTU1GH/dTOqc5wWShqpX7w3+q
   vA/nr4KFg4E3UESu3PNpnDxT4m0bY8SXLxQph2cVLIwiTYYsNqz/iP+nw
   PR9lPzD98yScAT16FeBqWfJPSqyYz+SJJs3OZhE/8qArsOJKaAmkG4tUX
   /vmqmb0rov785Z7Krs5Rxmv6UksFTWQuXVujZZKm5lsJlOyMggPCbnzKi
   dA3d1YdTE1baVMhNShaP2b1z8nkUglM6mUXp7L7t1bBlITG45az/Hws44
   Nl7o9M3I5TC0fsAIDAMkME8ZU8MC594eGmhBUP+3Vk/uJNOac2RtCboNn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="290133063"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="290133063"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 22:55:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="659666552"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 23 Apr 2022 22:55:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 23 Apr 2022 22:55:32 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 23 Apr 2022 22:55:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 23 Apr 2022 22:55:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 23 Apr 2022 22:55:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VL5VS08GNxJep073WUL6rNGFeLZoi72PUtf0mkGvFx/GeHoWIyANlJBiCdH4jtFiSHJvEPnuN91tlq4b6wYaQdnNNaYSbML/bJCMiRjCB4xkV7ukFP9ZGlJ9rST1BRKuYFRv3s+08RSl+Gad7r2VjgccGJlv9DGy6c+sFGuwiIMdh0/AoMy+G8IlxZ9t7snWCTgRRanQZwQYIagmx7WIuj5OGDUnWf2U2eg19ElFlydPlXeSP6HUawVnvQwYAWIykc3dzTrPr8xtdcWKMUU1BrKQm8rZw+28ClOLA50YRoCioJKPglaj3+5b87Z8YBkfz/Xiyo62o3C9xz6uoWKFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ty86MNbN1cTVgpBMtgfw1qRiaW/r+Ls3dQPDP+gBLtk=;
 b=nMKFHp3Cc4W+Wdd9AbnT2kkRR4E1l6LdNsF3plq6x5/QTVNmIOSYL9Hy7CNlx2UlX0+vBMeC/JmSngLkP78OvC7oxcBJTFEBaZeAFXo8lw4iucGYZZJdHJNBtAlvPqzkj6MS9EZ9AJAcTXIQaG0HV3i4vUCXvlELfCp6VhJQ4yDziMqxgx4Ioz03eRMMXFbZ181PxbzXAnMaagtZPTmg2PNUQ57841YJ0w1VRnxOId1tfYgrVBfLinbqkuANM5k798M5CwLFSAgEqImdvKa6ixofujQiZ/Z6kK9xC4Jh6pLsm8kGMAVT1oF/lMNWaGRETwCvnXNnKi2jcTCLtTsBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN7PR11MB2689.namprd11.prod.outlook.com (2603:10b6:406:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Sun, 24 Apr
 2022 05:55:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5186.020; Sun, 24 Apr 2022
 05:55:29 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in
 pasid table entry
Thread-Topic: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in
 pasid table entry
Thread-Index: AQHYVXRiJweT3/DMakGQhv0qzMieEqz7Od6wgACuJICAAoO6kIAAE28AgAAVTRA=
Date:   Sun, 24 Apr 2022 05:55:29 +0000
Message-ID: <BN9PR11MB5276FA1633851ED6CBD955E38CF99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
 <20220421113558.3504874-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52767A16DC6BB80838C876068CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <503795b0-282c-2a8a-b669-5e7a0fc4a696@linux.intel.com>
 <BN9PR11MB52766E90CF544C2B00F364008CF99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4b2cd2a7-d715-882c-9cce-533dcff8bc79@linux.intel.com>
In-Reply-To: <4b2cd2a7-d715-882c-9cce-533dcff8bc79@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6c9ba23-9a8e-4866-184f-08da25b7096e
x-ms-traffictypediagnostic: BN7PR11MB2689:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN7PR11MB26898A3FB4B212370B11E6988CF99@BN7PR11MB2689.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HBsENvAgbdSbLmrBIWPYihcUt62hHY6Wft8P+Qw6DXvDXKCtFy+NpPCEg1rQEQTBgZizkPa0OhGaePZlfIr3Fj3EWQMIAvg5tgD+F+cYefCnCN3HgCBzzaDsPnjrZ4puWQ1hUAxphqJP+B8PQ9fTVShwxpIp2tmDdi+vdnll9JY4KAlrGIZjIV4aOsVXekjlmN5jeQAZTMa0gAxa0C/i13COCjCxh6hqWZGWjqIu5gsHh6h4hN99qhkPp9dC94dQ9X4yl+RqMXCG8gnT4lslXndmdyVnCtNU45o6UsMUhAwlIGDhPqV6FkuzOlW9WqMYJD5luxzJNjevH67RIhYYEhbAkMqcdHANTemKtNtM71vRLnaAMp5W+ygOiv6iOMJ9rs+n1Av/1tGsFSVfxtLBVkd8sdZbUG4Ol5EmqC5yxBsw2ESBrdkYJUkEZmCIZLZRPiyznpyi+KnkBPMFQXpVhm8VOSG02p38PVrEB5QWJGkv4l2LXhxrLCHZTkQsM0ouFubYujl4/nJ2aobptDx78bVj01Ky1gfFSVsngHX1DHBmqGCFk0N7KxT276kt7cDDCkkc8bbxFLlz7VzbVHbI8kqvUTcoSMykNGTxTusR5ZIgqRkv+wX75+0gP0eYZlbanpTvAmsKP/FByNvuMpW40PUD1oR1wBVI09QHJjeKgLzjvOBNwBKNjzsr8ICzU7ZjOpg6aYCms3vBJTGj2rTe+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(9686003)(26005)(55016003)(6506007)(110136005)(7696005)(508600001)(122000001)(82960400001)(38070700005)(38100700002)(83380400001)(54906003)(71200400001)(186003)(86362001)(6636002)(2906002)(8936002)(5660300002)(52536014)(66446008)(64756008)(66476007)(8676002)(4326008)(33656002)(76116006)(66556008)(66946007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mi9MelhUVEw0MkxjaEQrcmVVUlFPN21jRWZiS1NIM2dBYWpwSEZmNlgvL3V4?=
 =?utf-8?B?Zm4vT29DNkg0MFEvR2xiVTVGZHlBVHBtL2QycTROdXVQSTdMbTBRb1YrRjNV?=
 =?utf-8?B?bklUTTZzd3Zyc0Q5cER5VGhCTFhSTkp2MVI5bHVkZU5JREQzRjUxTU9aQjlo?=
 =?utf-8?B?NGpQUjhLcjVUeVBzQXlkdlFUeW51dFlSb056N3pVQXlUeVMrUDRhU1UwOVZF?=
 =?utf-8?B?WHMzbmN3cmQvMFFmdXBFazRmUzBzeDZQcVZGcmpSK0NGRXJPTWVrazIzTGNK?=
 =?utf-8?B?MER4M25qK2JPSFhCOWVwZThPWXkxTzVmczdsS2dCR1NCWnBrTEg2UmF5OEl1?=
 =?utf-8?B?L0tNWE5yV1FGWHdBdTYvVjdkR3o4QzF2NXBNbDJqYTZoUXpadiswcHZpQW9C?=
 =?utf-8?B?VURXUlN5YU01YlJsaWM1bDhCNytNZGJHY2NhTklSNHlRUk1KRkhVR1JIMHQx?=
 =?utf-8?B?TGZmRUdTZFJ5d041cyswZnNMcTJEQVRkUzBYeWR5TjZseUpZT0srKzdTNWZG?=
 =?utf-8?B?TWZYSTE1Mjg0TUV3cDRaMThDU0Rpak5rc0xORVp1VmExK2RLWmJMeGlJUFNX?=
 =?utf-8?B?UjN6b1VWR3pOd0RIaER2OFp2Y2I2YTMxeHRhcGZYTlhvVkhlWm8zOFp1aDRh?=
 =?utf-8?B?dys5eGJ2Vm1yUHpXQW5XK2lHOVBRMVlXNm52ZDZKMjhhMkdsV0lVVnNYOEJy?=
 =?utf-8?B?MUhQY2JTYmhVWitPUCtCeUNzTDdWbVloTVZ5bG1jN0ZMbUxxU3M1WXJEaTdK?=
 =?utf-8?B?Qy9jRnpLREdQVnZWTXR3U1psRVRqSW1FZjM1YzRBVDBJT3pqZ0FWenFVZGVH?=
 =?utf-8?B?VHZ1NTRFaWF2TGJIZERRdk50bk9XMHRPcmhOeXgyZkluRHNNQVVESG5RVGsr?=
 =?utf-8?B?Q1NHbjhFS0xDUUF0WXlOWEMyN0U4SWhYWWJEN3lkNjEva3hXUWJXbGpJWXpi?=
 =?utf-8?B?UHJjQnZZV1E2cVQ0bVhha09kZDBNYXk2Vi9ITlYwQm83c3p4dVV2NWJUUm5U?=
 =?utf-8?B?S0JzZkhlV3J1b2s2eFQ4RFJ5N0FLUjF0cUp5OFVKMldVV01pN0x0QVZ0dWxt?=
 =?utf-8?B?a1F2c2hZTTZNdnR2Q2pzaFE2RjdKTDUyUUJWZEROTUFjVmQzcFlhbEE3SWJl?=
 =?utf-8?B?RTZpM3NmVzNIclh2d1VsSzdMZ01lU0VLblhwZm1NQ0lQalVTL0RhUDAwZEFj?=
 =?utf-8?B?dXJFTkZ3a1pkN1c5L1d4d2NCU01Wa1BGYmUvT0RkalgxQlE2SUVBTDRwWkZi?=
 =?utf-8?B?OEdESzV1NTlGajJYWDkxNWJ6a2hibThGNDlxZ2lTVWc1eGFaemV6eDY1dEE2?=
 =?utf-8?B?S29hYlh0LzlNU2k1bCtSYTlWbEJpeGxXU3Zpakdqd2MyaDdxaDgrdEp0MHpp?=
 =?utf-8?B?a1V4b2tFQlY0U05tREd3TGk3M2x5SGFMUm82Wkk5YkVaczZWQ0lvUk5VRE9B?=
 =?utf-8?B?WXd3ZnI3VUFZd0k4Z1pnMmkvcytEckY3T1VZdDN0d010Q2cvNVA4VXFrQ3Rp?=
 =?utf-8?B?ZERtSDZPK1dPamtpVjFEZThGSTh4ZC9CVnoyRUkwUzRZWnpnUEdQYnJwR2l1?=
 =?utf-8?B?SlI5UmFWcjhCN01TYUdLTVk3TzRwdXY3YjlteTNDbGNGRG5UWEEyQm1hWi9o?=
 =?utf-8?B?OHJzRCs1YUZxVzFaLy9HL093eDk2c2l0R1ArV0ttR0RlK0pEZmUyaXBJZlFI?=
 =?utf-8?B?SzJwZFNaSDdmMGxnY3pWbFF2bmtCMjVLU2FWWFJqNVNYMkY4SW1lZ3RJa25K?=
 =?utf-8?B?OGM3N2Q3NDR0aEgyL09rQXM0VzFSWmFpWWlyN3hzU3IrU2I2UGhnMmlmV3JF?=
 =?utf-8?B?cE1BUURBRWFnTmFTRDA4RlhJKzRFTWJFcTUvcmNybUVGLzdrSXNRcis0WjZv?=
 =?utf-8?B?Z2ZvdVpObW1wSHRXNmZPcDg4L0RscURYUGhGejJldzUzM2pHOWZpaU5EOW5R?=
 =?utf-8?B?eTVoR2hybGNEa2FwcTNRRGx4RzRtc3YrVUNOQUxHckYrUkZBNXNMbG1YcTcr?=
 =?utf-8?B?M1lweFc5a1kwZjVlcjhNVEd4TnMzYkxaYlgrNGJRUmxXcllyRkhVOEgrZlFh?=
 =?utf-8?B?aUxaVHJZNGF3Q0M2SS83Q2RoV2p1clVjOHZEeXVLK3FmMWFPcCtrMU9CenNi?=
 =?utf-8?B?d3h5TkVQelNXVXl3TGkweWpTcjBJWnVZcFR2OGZ5L1VMWldXKzNHZzZub2Fy?=
 =?utf-8?B?QzRRNGgvNElabXZDMGNOSlNsV3g3endFWDFaVFBicVg2YUFjUjVvRjhQOS9Z?=
 =?utf-8?B?clpOMVBkelZBS1MrRkhkQnZoYjBnUC8wY2JURGFISjJjdjJBait5ZEdVT1ZO?=
 =?utf-8?B?NDZJUUc3TVB2SkJ4SWlzVDd6MmFVRXlXdS9rWitidU1SeGZiSzZCUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c9ba23-9a8e-4866-184f-08da25b7096e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2022 05:55:29.3174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0i4rhC5bOSR4Pvg8t9jxTn/0ZYbAxx7eLJIECyRFSEwtvyXJo6nz21BVr1kItmu57ODO4dL4Uq7fq1f/nfbLtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2689
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIEFwcmlsIDI0LCAyMDIyIDEyOjM4IFBNDQo+IA0KPiBPbiAyMDIyLzQvMjQgMTE6MzcsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+Pj4gVGhpcyBzaG91bGQgYmUgcmViYXNlZCBvbiB0b3Agb2Yg
SmFzb24ncyBlbmZvcmNlIGNvaGVyZW5jeSBzZXJpZXMNCj4gPj4+IGluc3RlYWQgb2YgYmxpbmRs
eSBzZXR0aW5nIGl0LiBObyBtYXR0ZXIgd2hldGhlciBpdCdzIGxlZ2FjeSBtb2RlDQo+ID4+PiB3
aGVyZSB3ZSBzZXQgU05QIGluIFBURSBvciBzY2FsYWJsZSBtb2RlIHdoZXJlIHdlIHNldCBQR1NO
UA0KPiA+Pj4gaW4gUEFTSUQgZW50cnkgZm9yIGVudGlyZSBwYWdlIHRhYmxlLCB0aGUgdHJpZ2dl
ciBwb2ludCBzaG91bGQgYmUNCj4gPj4+IHNhbWUgaS5lLiB3aGVuIHNvbWVvbmUgY2FsbHMgZW5m
b3JjZV9jYWNoZV9jb2hlcmVuY3koKS4NCj4gPj4gV2l0aCBKYXNvbidzIGVuZm9yY2UgY29oZXJl
bmN5IHNlcmllcyBtZXJnZWQsIHdlIGV2ZW4gZG9uJ3QgbmVlZCB0byBzZXQNCj4gPj4gUEdTTlAg
Yml0IG9mIGEgcGFzaWQgZW50cnkgZm9yIHNlY29uZCBsZXZlbCB0cmFuc2xhdGlvbi4gMm5kIGxl
dmVsDQo+ID4+IGFsd2F5cyBzdXBwb3J0cyBTTlAgaW4gUFRFcywgc28gc2V0IFBHU05QIGluIHBh
c2lkIHRhYmxlIGVudHJ5IGlzDQo+ID4+IHVubmVjZXNzYXJ5Lg0KPiA+Pg0KPiA+IFllcywgdGhp
cyBzb3VuZHMgY29ycmVjdCBmb3IgMm5kLWxldmVsLg0KPiA+DQo+ID4gYnV0IHNldHRpbmcgUEdT
TlAgb2YgMXN0IGxldmVsIHRyYW5zbGF0aW9uIGlzIGFsc28gcmVsZXZhbnQgdG8gdGhhdA0KPiA+
IGNoYW5nZSB3aGVuIHRhbGtpbmcgYWJvdXQgZW5mb3JjaW5nIGNvaGVyZW5jeSBpbiB0aGUgZ3Vl
c3QuIEluDQo+ID4gdGhpcyBjYXNlIFBBU0lEX0ZMQUdfUEFHRV9TTk9PUCBzaG91bGQgYmUgc2V0
IGFsc28gYWZ0ZXINCj4gPiBlbmZvcmNlX2NhY2hlX2NvaGVyZW5jeSgpIGlzIGNhbGxlZC4NCj4g
DQo+IFllcy4gQWdyZWVkLg0KPiANCj4gPiBDdXJyZW50bHkgaXQncyBhbHdheXMgc2V0IGZvciB1
bm1hbmFnZWQgZG9tYWluIGluDQo+ID4gZG9tYWluX3NldHVwX2ZpcnN0X2xldmVsKCk6DQo+ID4N
Cj4gPiAJaWYgKGRvbWFpbi0+ZG9tYWluLnR5cGUgPT0gSU9NTVVfRE9NQUlOX1VOTUFOQUdFRCkN
Cj4gPiAJCWZsYWdzIHw9IFBBU0lEX0ZMQUdfUEFHRV9TTk9PUDsNCj4gPg0KPiA+IFN1cHBvc2Ug
d2UgbmVlZCBhIHNlcGFyYXRlIGludGVyZmFjZSB0byB1cGRhdGUgUEdTTlAgYWZ0ZXIgcGFzaWQN
Cj4gPiBlbnRyeSBpcyBzZXQgdXAuDQo+IA0KPiBDdXJyZW50bHkgZW5mb3JjaW5nIGNvaGVyZW5j
eSBpcyBvbmx5IHVzZWQgaW4gVkZJTy4gSW4gdGhlIFZGSU8gdXNlDQo+IGNhc2UsIGl0J3Mgc2Fm
ZSB0byBhbHdheXMgc2V0IFBHU05QIHdoZW4gYW4gVU5NQU5BR0VEIGRvbWFpbiBpcyBhdHRhY2hl
ZA0KPiBvbiB0aGUgZmlyc3QgbGV2ZWwgcGFzaWQgdHJhbnNsYXRpb24uIFdlIGNvdWxkIGFkZCBz
dXBwb3J0IG9mIHVwZGF0aW5nDQo+IFBHU05QIGFmdGVyIHBhc2lkIGVudHJ5IHNldHVwIG9uY2Ug
dGhlcmUncyBhIHJlYWwgbmVlZC4NCj4gDQoNClRoZSByZWFsIG5lZWQgaXMgaGVyZS4gVGhlIGlv
bW11IGRyaXZlciBzaG91bGQgbm90IGFzc3VtZSB0aGUNCnBvbGljeSBvZiBWRklPLCB3aGljaCBp
cyBhbHJlYWR5IGNvbW11bmljYXRlZCB2aWEgdGhlIG5ldw0KZW5mb3JjZV9jYWNoZV9jb2hlcmVu
Y3koKSBpbnRlcmZhY2UuIFRoZSBzYW1lIHBvbGljeSBzaG91bGQNCmFwcGx5IG5vIG1hdHRlciB3
aGV0aGVyIDFzdCBvciAybmQgbGV2ZWwgaXMgaW4tdXNlLg0K
