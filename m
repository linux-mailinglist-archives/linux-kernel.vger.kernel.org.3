Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2449B51D288
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389693AbiEFHvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389681AbiEFHvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:51:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6EC674E9
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651823262; x=1683359262;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eGph8ILNojY/FqkSlV8Lp/Dt+iJJQ7ntmGjTuQwdnT4=;
  b=OuOLbpxKyAm1EyYK/G/Fv81HTfpAOLIqAyUFrvXmWC/9xrBtJKqpbcyz
   EupqCDX+XIdg7t+tP/GM8/OFEnaZx5eJ7MPtf567LfMHIHwuHWojbqdKT
   2KlNxCp/YfuQEVfySrSd3BD846rHCy14cE4bIJSoUq/IBWMN+dhjzYtRn
   QFcR0dSKw8K8NnZNpTzysHX2MMmeAHkfj/FrHb45EcNzNZbGHDFlLrjJN
   a+iyiC5j2QfWtjNXDszRxX1hdVfpnDPYXoLhmGQTae2CYvJn6C9Csa1O5
   cQRkLYW/XrtI/hMm0Q4MX/7MbmHr6mHmJqffVMw7iy13f/fVcDD5fCCES
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248919364"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="248919364"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 00:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="695048367"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 06 May 2022 00:47:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 6 May 2022 00:47:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 6 May 2022 00:47:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 6 May 2022 00:47:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 6 May 2022 00:47:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ck98mRp53Pl4WMDqb5SElPX1C8MoOEEWuqol9u1WsSTt3WScLQEosBJx/pdvYpH1LtLR7c5CgXTvObhjXDkjYWvYgWjm0PwXAwz2lU6w4iEKHzbw9oIzU4isrkNhmYUFAI2C9ww4zN0jApZqix4gC8fLJBMa7L5qBBoGEgFVFXV/DwcI+UQ2zGF2hH8Jy9jvfvMA9lMUSPsi36Ng/sfhxv90D2/SA3VjGNbRPw9lMFiv9ZdzSLSFID+9BshtaPSwKfHNLl7gHeEXdSknPnG2sq4oyF5mXOSYHtKHnn8O3DasWmpoY/MEKwFRRk88qN99T+Xox3x1aZZ4WlZ6GqLJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGph8ILNojY/FqkSlV8Lp/Dt+iJJQ7ntmGjTuQwdnT4=;
 b=VjDo18gGtB5TT0EDtxHkdLThdYdKV1u2f8gO5vc0QJ5uQS5+hbzG0BXTDVDkFLkJVfO0H+CrbT8svGs560i8Is1etd8NMihtumIlXqBbzhZvnQagFUCchIpa9BN3PREOEv3m47nrSA9KNX4s3MjXtC9yUGuN9wfHxM2UfJzV/vnhFycb1oJ03yGcooGbo6T70/4JH+HIXwnnfCgAMGhqt6EBzUeaYxjQk5Gn0ZD9n7eA8G2djqAx0Pui08GlO7VyvyXE6JPWRIf+R3qjThpg4O08GROyCN4R7JHmxJmuN/hIz1dL5us++Bj4ZypnGlhjLW8t2V7LKi0DOspyDTXuKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DM4PR11MB5405.namprd11.prod.outlook.com (2603:10b6:5:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 6 May
 2022 07:47:38 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::3114:d1ec:335e:d303]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::3114:d1ec:335e:d303%3]) with mapi id 15.20.5227.020; Fri, 6 May 2022
 07:47:37 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Rodel, Jorg" <jroedel@suse.de>
CC:     Dimitri Sivanich <sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: RE: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Thread-Topic: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Thread-Index: AQHYYLnAHmosHc2CfUSQkp312mWw2q0RWsAAgAAL7nCAAAi2gIAACU3g
Date:   Fri, 6 May 2022 07:47:37 +0000
Message-ID: <BL1PR11MB5271CDF6FDB952B86199AD698CC59@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <e2afd89c-b1cf-9fde-4ce2-4be3c1fdaf07@linux.intel.com>
 <BN9PR11MB5276F4D5F8AD33293233B9AB8CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YnTJ/YqQpru3YPC+@suse.de>
In-Reply-To: <YnTJ/YqQpru3YPC+@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8283b681-b711-47a7-dd0b-08da2f34b0b2
x-ms-traffictypediagnostic: DM4PR11MB5405:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM4PR11MB5405FB1F215D6194EDC625DE8CC59@DM4PR11MB5405.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j2/a5FL4kc5OH2chqzAPq4tQq2HV31iEV5QjpR6EECdtcJKRGCFIFn77yadiL9D+UE2nQHRcyfs4cZ0FPxMK30O6GDTnc+PM8vclmzCl+jM2HmRktBf3Xd+RMHKgRE2C+pXwsc2YttgVX9UKjzyWT5tWW90IDyDjHz9iYqcrVbewcD4mAk+ro0EKi1LzwvZi0LyAS7S7+yurIHIFhw21Kjph6Fyv+ICDvb2Z7Scq/iHVDh8ARsqd8PLcdXRnC4PTcveDCtbtDaeoq+KhvUU0IpVVvtx0pBvU74Hg4E/lOVDMHAPwYHYI8reiMAH04V/k2SWerjc5bwqyEQdIXsOuWt9tAZRLdPHtX9iU+e8NLhSm1tup3zpYJISidPF954F2SU+PsdR8VcjRbvLCa0lQvaUXM2VSrO9gTjS18IUtENFP6KYVnCYBHJ0JScsHcPdc/JIu3XgKpE5I7sQhAwYXtINWw9QwcjZvtjzWCwCSWVlCD3J6wS0YRLtgCYNkPcom8AQEtOWPjbYB+Xna1h97VEzMA5Jpx/HfhBLQ/1SB7facgXlbX71MG14gRkeFe4GP2ODCdSfv3cwtfA5qX6z8vx98zqsx4OfIfYGXsK3ShMAay9oeY1U46o84NSuRNbg9BBYp5MTVZHmIIAkWXvkOYprfR/FxVP/qUTdAU4Acz4gIayUK3rnoQKzz0JfUTiVoaYhQMDg3xn196UXBYpepzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(7696005)(38100700002)(2906002)(82960400001)(122000001)(86362001)(316002)(186003)(52536014)(8936002)(6506007)(508600001)(5660300002)(9686003)(55016003)(4744005)(26005)(8676002)(4326008)(66476007)(66556008)(66446008)(6916009)(33656002)(66946007)(76116006)(54906003)(64756008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1RnQ0ZhRU92WENzdFFFOTRmdHFYZXZGRWRsK3U3MlZnaWRiRisvZDdVOGFi?=
 =?utf-8?B?b1ArdnNDa3NHMDNYR1FHQ0hBMzNEY2xEbllqR1RiVmtZblRac0plbFhTRFdj?=
 =?utf-8?B?YUlyMU9tbmVJU0kvZU5QS2IxeWY2MzJtME1idVJzaTgyVVdYNGszcVYvb1RQ?=
 =?utf-8?B?K3hRU1RrL1plWnczUklaM0tYNGdkMEV2YXYvcDh6NndYUVhxZXBkRGVZTnBL?=
 =?utf-8?B?ZmtiaDJPM3YrbUxBUnFydEowTmpUTWZqRkFxRHA3eld4NkZGL1FpQWVJRTgw?=
 =?utf-8?B?akZBa3p4dnp2dnNZL2IvNFlpZloxZ1pkR0llL1QzOFpPTGlXazRRTHJTcmpw?=
 =?utf-8?B?MWQ0d1FGb3dZb1ZMMlJoQ2tNdGRBWmdVUTlORG12ODlUMmVQSTJYVHQrY2Qy?=
 =?utf-8?B?QzJYWnprRU55KzZack4wZDQyL1B1VTY2SVJrcHVvbUpwb28wcHVrOUI2RUVK?=
 =?utf-8?B?aXMwWVdETkhnZmhlTCtVUlQ4YWcvUmJjZmV3a2NLWnZYSUVlUHI5Q0dXSy8y?=
 =?utf-8?B?NEFQOXcvV3dEUWNZMTRsMWpNNWdjZTF2eHVRWWJQUnBCcW00cGZYekE2elNq?=
 =?utf-8?B?Nk0zdUlIRWZmandYRnUxa2RET0Vrc1ZEZVdkOFJyejRIYnpoMmw4UWkxaE45?=
 =?utf-8?B?TkRFWVg2QkF0eXZKV29hNDRHSS9YcUVkRDg2a2hxRTY4SDk2SmZHam03bi9V?=
 =?utf-8?B?b3JmOFk3R0lBLzU0NzhSZ095VFZKWEhmMHlQY3IxZ3Z1TURUQ2JtME5POEIv?=
 =?utf-8?B?Vk5Yd3pYOU5HUVRKbmFwZUlqZkFESGFxUFl6U1lOaUk5dWtPemQvZjk1a0RW?=
 =?utf-8?B?T2lWWllKRmtIZnJJZzFWcjhRNEpsaGsza1lhZkI1R1VlZzZYRzFRb2NnekN3?=
 =?utf-8?B?Qmg4TUkvRzRaL0QyekwxcTdpWVZGTDlsSENkTkRlVnBVcnBvcEEzcWU5c2Vs?=
 =?utf-8?B?NW9SZUJCeVRZOUJKVDExU3p4WjhncmFSdmFQREhoR25lUW15b3hlVW5QQUgy?=
 =?utf-8?B?Q25IWkVweENqeGxnMVhKanR0eFlvcG9yRjR2d05pUDR5QkZMY0w2eXZ0Ym14?=
 =?utf-8?B?ejFZcFZUQVpUNUR1cWlmUDlvY1VhNmh2aXpKR1F4MlVBOUhraVFMcXEzTUo2?=
 =?utf-8?B?ODVoKzg1ckVMdmc4NWtkZW1yZzNJU2F6VFg4TFVCQXczemhTYWN5WENSNlps?=
 =?utf-8?B?dmN0cnREbXZZS0ZpTkJLbDFkSzIxNEorQ3JsR25OK2YwRzJpYXVSMDBhT2Yy?=
 =?utf-8?B?dUE1dURRSW9vSlV6QmdkMjJLR2VQb2U1THJrMStFeVdsYTIxNktadUlBNmxq?=
 =?utf-8?B?Z1lKOXN5VDFhUjZzNStEbG5TRzUzK1lpVHZ3UkFKMUh4U2M5dHFIVnlLbVB1?=
 =?utf-8?B?dmRjYVF4Zll5NmFiaTdiNHBRdUQyei9RazdPQ0J5Yms2Z1g0RFpCZmdhV1hO?=
 =?utf-8?B?L2REWDQ0cFE3M1ZsVk51NkVvc2svMFBBUWNuZm1qekNvL0lIR0pKQktFaGs0?=
 =?utf-8?B?cFJ6S1NjWndudWt4R3NMTUlBLzBlTCtjYzNVK1NpVExDRC9URXZNWVB6QkRk?=
 =?utf-8?B?eEplaEhZQ0xFM3NCZzJQb2J5MVMzNy9ENVVZUTRuQnU2ZERsb0lQWFh4VkNY?=
 =?utf-8?B?VFBpbitzTXBHR3Nwd01kTng3WmZJUSt1OUNPbWUxUENiazJ5azJXMktQTnlk?=
 =?utf-8?B?U2JXakVQNU00NU9Hc2ZieldHTXVqbFk0TUdWSmVtSkJXZ0E0b0ZyMHJLQkxr?=
 =?utf-8?B?N2NtUkRwVlJtTWF1dnRzMVRjWFQ3RXFmWWk0VWxvNk9GY0luODV0MlFiajZj?=
 =?utf-8?B?TC94T0QyeXh5UWY5cVpvdXFqbjBGRmtVcUxIeW1XeVdxRVpXWThRNlEvYmdH?=
 =?utf-8?B?T1NhcFNhYXVhNmNYUTk1ZGFKRVArNUJ1a1psZ0Z6ZkplZnpzRHpEaXlKMzZL?=
 =?utf-8?B?QkNDaUVrY3Y2TW9ncmNiZ1FIVFZrU0xBUStQRlU0ZjNOSkNzQlcwc3NVZHpI?=
 =?utf-8?B?aWkrVEc5TjB6RWphaHp2K2Y1WGlIYkhML1oxaHNxVDRUYlhOcHVBOVFqQlh5?=
 =?utf-8?B?ZFNGR0U0b0d4YWllUXpLM0h2MzhDckhCV3FHdWlwL0taM0ZoNXZhaDRJc01r?=
 =?utf-8?B?cjlYR3ZiSm92aHIrU3NUTnZSczdwVTdXRkNDSWY0VjVXZHdDSkxvTStwUUFl?=
 =?utf-8?B?OVlnSTE2U2lCZGNNRTBQZ01rMlVPQmtRcEFCc2dBa25qUGJIeWN3Z2JJekk2?=
 =?utf-8?B?Rnc1d2hCazRHSTQwUlJBUm1Rbzg1KzczcXI4dTFXYU11VDBSYitUQXg3emZH?=
 =?utf-8?B?U25VZXM1Rk1EVEY0TjBHbUtpbytLZ3pwL0t0Y3ZxM3RYSmxZSW5aQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8283b681-b711-47a7-dd0b-08da2f34b0b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 07:47:37.5194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eq0lEkSFz+NRjNFE3h7I/tzpBIUPHpmVCvitsvjt4tDkjrFsOdcnQRbEA7j6u4x7PJuoquyt+802BcDQTsQXSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5405
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

PiBGcm9tOiBSb2RlbCwgSm9yZw0KPiBTZW50OiBGcmlkYXksIE1heSA2LCAyMDIyIDM6MTEgUE0N
Cj4gDQo+IE9uIEZyaSwgTWF5IDA2LCAyMDIyIGF0IDA2OjQ5OjQzQU0gKzAwMDAsIFRpYW4sIEtl
dmluIHdyb3RlOg0KPiA+IGFub3RoZXIgbml0OiBkbWFyIGlzIGludGVsIHNwZWNpZmljIHRodXMg
Q09ORklHX1g4NiBpcyBhbHdheXMgdHJ1ZS4NCj4gDQo+IFRoZXJlIGFyZSBJdGFuaXVtIHN5c3Rl
bXMgd2hpY2ggaGF2ZSBETUFSIHVuaXRzLiBJcyB0aGF0IG5vIGxvbmdlcg0KPiBzdXBwb3J0ZWQ/
DQo+IA0KDQpTb3JyeSBJIGp1c3QgZm9yZ290IHRoYXQuIGhhdmVuJ3QgdG91Y2hlZCBhbiBJdGFu
aXVtIHN5c3RlbSBmb3INCm92ZXIgdGVuIHllYXJzLiDwn5iKDQo=
