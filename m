Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC45596C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiHQJtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiHQJte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:49:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF04369F53;
        Wed, 17 Aug 2022 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660729771; x=1692265771;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vBPGymD7uNkZ3xcnyVHgyiRy2USO/CXkxPlQ4nuUQTI=;
  b=i4v4VKGBNseNvHGB9l+cCP4BxQxGTvToHIZjsYXmnwfl5sBH0kBbUbUb
   2syG3aMj/RRMLQJRdC8HukGNHfTlj4aWLnVGqexPPGmghlBg/J26Knu6s
   o9Nq1kjZ4WoO7qhXeTl2Gi7gBksO/mKn4uRwUOecF5I3MrMxTcHkQ7KV9
   XLdFBj9/b6eemILS4naMgrs/Z9Pq/FcfK1edLVGBM4+Uff3Xcp8yzG1oF
   XWzAjs9k/mWOsbV6f5PSj0JdSCmTwfejtIUmVJysWgI2c5HUnCsbT1IJv
   Qs7/bq8ZAIxzGyUBabeXza7xojApMeKpMN+3rSl1LqpF1yBUYOsr2UiH1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="292448642"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="292448642"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 02:49:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="558065002"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2022 02:49:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 02:49:30 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 02:49:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 02:49:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 02:49:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0VQ+KSkW64XowDEsuhEvjoe4pMR1jNBH2mmtIeFx0rB9DOQS78WaKc2E5gxSGzMdXIic3CQ+wTuxzOand6LMt5GXZcRDOOi/kF6KI0ceDnZEjtrK83fYJL1rbejsbyQAnzgazPirvIdXq0P9h12dBgkKvZ58xqzdHOqa7tBU4E5qgPQz5DRE0SWIgrspd0xwM+SdLrRyiY9KDERdjsAMTzyfXa2dFIhSwBXSpo7AiTzQyj/9vYjbMRkBWDYe6vBtUVZikGnKJH3bjUeNwlekcUMJ+e5Y4hjf5+E2JgKSIsqSClf/2DPumd0AcX+DpAshe7J3xngaVgOvTqIGVJs/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBPGymD7uNkZ3xcnyVHgyiRy2USO/CXkxPlQ4nuUQTI=;
 b=TbA9C+hQuuQwPOQGW32KcgLaSfEtMhmKrRUGzpo8Zv1MPtWfvj5pCVTwpPeu8KFwTQ7Xp0Q614/auBzFYHXszb/2PicyY8E875QBhrgQ0S4tvYoTKNwRP+ywj0SIzCbaJNY4coro6VM/1XF9qctXf29FvyGzed+7XsRHdYD5fahfXIM3Rbyhqy7R2Flan31hUFPyBMiOKT+s678NXqCcmSA7yzl/BuJryyZhuZ9ZBZR82RHa5vQYzc21TOMM/fW1Tx1OH/5/+bVdi4NupGs5UYbn2qJDGTMZKHXip/sL0BjHHdEF1SEEpw/71B2jZTYvZx/vHu/nguy40A/0N1oxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 09:49:26 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::1d3c:4dc0:6155:2aee]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::1d3c:4dc0:6155:2aee%4]) with mapi id 15.20.5525.010; Wed, 17 Aug 2022
 09:49:26 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>
Subject: Re: [PATCH] x86/sgx: Allow exposing EDECCSSA user leaf function to
 KVM guest
Thread-Topic: [PATCH] x86/sgx: Allow exposing EDECCSSA user leaf function to
 KVM guest
Thread-Index: AQHYoa++zWDhEpkhMESdCjfUrWNTaa2y+eWA
Date:   Wed, 17 Aug 2022 09:49:25 +0000
Message-ID: <5efaad269ff8dfcbecff311dd42b019530995049.camel@intel.com>
References: <20220727115442.464380-1-kai.huang@intel.com>
In-Reply-To: <20220727115442.464380-1-kai.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ae12cab-aff8-4e1b-0a08-08da8035c577
x-ms-traffictypediagnostic: PH0PR11MB4965:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QwjICkJeSk+/iJV+cM5Cb7OiQ35qo07MDgFFJ7D2WNgdudQ559cJbGuwEfrP87IGXsUiN4uusAH7umlmsOmgEmDAO41hOBd6ZlFEJWtSwrzu7EsiLghUWY/hYA4g2b5sIGI4Z6VaErmaF4N3kvgutRW4R4xucM287bHqOL6GV5IKdDe3I6zAbyAy5owzJFnI7Egqt6e/Pl0M5NqE8v1S+1QBnWTFM5op2tgiTcDOwvITP2nFvgqmvD7lvBAt9Hulg+UXr0Xsj1XgslT3SZdoWITdEkpckL3dbBaPECiZcuFBp4iFthVxJhZr2uEhs3tuGjFJsjDWtOP7Rvy+seGUQ6cvn+wOn1kCACdAsQYDUVPXQTxgP38kLS+G6h6aVtD8IFyvEQu8AtUWKNt401Jf47kM+uBSHue/vErexkkiU3UjsCdGYMKxNbB4X02jsLSaYiwd5TBr1KBz4CZbKTI+2cF2UNPU1yZvy5/0l/2at9AuCRBiGgMn2m3c7nbPx9jcJtdQjRvQ86BirtxIWsiclj/vdzzxYOl+NiUvTS0oro2a0vcJxq4T3jqSjsV10A0TCFUQJaOwj25AdLa0wBycQnr1JVCp2XT1yEVsZsVHtth1gKB7KoIlNrTqWRCd1E/lortnSUaAMe+xgLOJQV4u10zQujPGryy9dL1xo7ZbiQNN/Jcx6v/pZS9MvWJ+p7YlacaBI7dy1Rp4Oaasdfe14mNTTkUfNbKVX3dz/RcQ1P9C3+mNsw2LhBj/Kt0eMm7AbyVf2vDYTPzOqtHndDZGeCYKB3MKFCL22Gyr1pJSgrhrmFeBq/sY/3CTSkMJa5FJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(346002)(136003)(376002)(86362001)(186003)(38070700005)(36756003)(122000001)(2616005)(83380400001)(6512007)(82960400001)(6506007)(316002)(54906003)(478600001)(71200400001)(41300700001)(66476007)(66446008)(66556008)(8936002)(110136005)(66946007)(5660300002)(8676002)(76116006)(2906002)(26005)(91956017)(64756008)(38100700002)(4326008)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEQ5S0VwZkcvS3Ewdzk5MGxDT29WZ01oZGxlWUZOTmdVYVdtZWxBTldFd1V0?=
 =?utf-8?B?TktLR0VORlhyeFRJQlNlQWp5T2xZWk5Za0tnSGIrMUZvbXg2OXNGSzB2QWRz?=
 =?utf-8?B?a2o5RjhFbEp0UUFPREZSYTU2bWNMT1dDMHQrdVRkTDhRWThNdlgvTmNoT1FO?=
 =?utf-8?B?RVpvUjdWVFlWd0hsYUNRQ3F2bDBnZ0tKYVUxN2VSUU5kOStOTno3N3ZTZGhG?=
 =?utf-8?B?MTlJZjB3SkUrd0dkTXRYZVp5OUFYMmpydEdzYXRxUkQ1OFR2d1lsT3RUeFNB?=
 =?utf-8?B?V1JMUkZwRUhWNnJuOGNHUXpDM1FTWjlhREwxaC9DekZCcEFaREdnVy9FaVll?=
 =?utf-8?B?d2VQdE9RMzdSb2E1d3BwYlRzRG45ZTk0ZktWWnlRaUkwb3I4aDZqNndTRStu?=
 =?utf-8?B?U0U0c1UrMy80U05xbmkrU3QxY0NIclY5bCtKSlF3L0pJN3U0Y0NzODJuZ081?=
 =?utf-8?B?MHQ3dzd6elZKMUVkVGt1TlVxVFZ4QjNVWjUyZEJFenR4ZTVvVys1VUNGY3BC?=
 =?utf-8?B?QnJFMlFzMDVOelNKTkhTajZ2OU12Qkl5WHM5NWVscS82emZNR1E4cTJ6VmF2?=
 =?utf-8?B?THljS3NWbkk2aEtBN2NLbndWN1p6UmhYUE1LODhycEwweXNNZk1GdWxNajNW?=
 =?utf-8?B?eGcrdE0yd1V3SXpJUS9HaktJSVJQMEliMkxVajJhRGhtcFFBSlVIL21GNU5p?=
 =?utf-8?B?QWRqZnI4RlU1b0ZHMlV4V28ySng5anFLaE5yMTFBM08vWHBWMDdhbVhNVGRz?=
 =?utf-8?B?R2UrVFhzQ0puTEg4YjFnRGpVOVNIY1VjQ2YyYitIbTJ2VGJiVDU4em5oQ3JW?=
 =?utf-8?B?Z3lvaTlTai9zVWV5NUpSYlV0b25JRC9VTjBQN01TVkRrLzBvQXpXSjhVMDR3?=
 =?utf-8?B?TzNtK08vZnkyM2szQVB3SjM4OEhUSjVvMkw0d3kxWnh2b0tVdGY3L254RDd0?=
 =?utf-8?B?UWNWcEVHb1lMaHdjVnVYdkU1N2czM0ljM2JYUTdkYTIwRFZpb3o4dGszMGx4?=
 =?utf-8?B?NUJISlZQY0ZZSXl0K0NhTHZWdTNub2t1dHY2ZVlPZVRTR1dZTjhmUk9IVXVj?=
 =?utf-8?B?VWp5K0ZOamZiYndEc2FFbTc0SnZIdWRpOTBjK0VSTnZsN0R1UWpHZ3lDL241?=
 =?utf-8?B?QTREcFZVYm5vRzNxQ0RpRXJuWDVKTGNJQkNRWGFRMk4yekNxald1RUJISUhH?=
 =?utf-8?B?ekhHNnNSY2FaOWdaa0tGckhkQ1VLRWZTSVoxY0s3NVI1YzRjNmdYY2lwMUVw?=
 =?utf-8?B?UUs0enB3TnRCR0FxdWMxOSsrYUE0SXdvU3lKWG1ic0ZjOHpieGRNaWxpMExV?=
 =?utf-8?B?MFJpeWF6M29SNmhtQk4yZG9lODQrT2lQWHNrQzlrTFkzZS9ZZEpiZ0JReGU1?=
 =?utf-8?B?dDVTcUdiVVFFQ2s5SHMxRlBaTk52bnNoQTZKY2Z1aW12SGp2L2Q4ZGY1aG5m?=
 =?utf-8?B?UVhYbVJqNVlIcDNNMHFUb2wrck0vQWJVUXZsUkE0RTBpYjgwdVU5ZE1WbUoy?=
 =?utf-8?B?QkdGN3FVV25vMk81ZG5UaG1QdDArakZQVnNsSmIyV1FJUW83VDZsdlRmREE1?=
 =?utf-8?B?a0kwa3UvcDZwZVFpa3pFUjZmQmR3cmJ2VlNGcy9BS2RCb2trTmJ5eHJXeHox?=
 =?utf-8?B?OGJSeGpVdlZyOVNicm9oNnFDQkNWWHFmVVN5U3BkS2RzbTcxOGdqeUJNRWxt?=
 =?utf-8?B?Y3pZY2hZaThyR2dCL0FDWmFocVZsWVFPNVMyTVdiU09DQTFRTUdsSzJDaW9i?=
 =?utf-8?B?REd1YVNmN0k5b3BXbmowU3NuZTh3UGJsN2lHVkpqNit4VjYrRElsUFFxaHJC?=
 =?utf-8?B?akY2T21jSk9ZY215d2V3S2twcUJOSFFoNlUyZXNSRjFqOGFyY2VESjladEp2?=
 =?utf-8?B?K1RMK0lGbWFoTmlKU2xaRTdjZDBGMjlIeUlnbjhZZTZkdm5ibGE2WXJSc1Vx?=
 =?utf-8?B?OEVoUTRuQTR2Um04NUVZaEs0c3NmQW8wcXdQeGNhaklHYW01UG40NFdhWlZ6?=
 =?utf-8?B?azZFYlBTU0NXVXlIcFhwVmM4ZWxQMm1RU3d6a3MvdHhrSm5YK3VPS3NQN29l?=
 =?utf-8?B?M0JmeXY5eE1JM0pMNHFjWDBlZEJjM3R2cGZPVlVEbS9tbUhuby9MbWdVLzJM?=
 =?utf-8?B?KzlrQkc3SURIQjc2MGFyYTZON3BkcE84R05RNXlHVFBtbjRnZitEVVJ2RSs4?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A02DE42F18DE74DB58FFB53BC7DCC77@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae12cab-aff8-4e1b-0a08-08da8035c577
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 09:49:26.0243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFXMaLS7K4l7jv6e+u6rY57hHsT/11dS2kBZ/JmMeqQmcb6RAFFz8yDc3vcEge1QwanIsUWVScWODM+FsDOIWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4965
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA3LTI3IGF0IDIzOjU0ICsxMjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+IENv
dXBsZWQgd2l0aCB0aGUgbmV3IFNHWCBhdHRyaWJ1dGUgdG8gYWxsb3cgb25lIGVuY2xhdmUgdG8g
cmVjZWl2ZSB0aGUNCj4gQUVYIG5vdGlmaWNhdGlvbiwgU0dYIGFsc28gYWRkcyBhIG5ldyBFREVD
Q1NTQSB1c2VyIGxlYWYgZnVuY3Rpb24gdG8NCj4gZmFjaWxpdGF0ZSB0aGUgQUVYIG5vdGlmaWNh
dGlvbiBoYW5kbGluZy4gIFRoZSBuZXcgRURFQ0NTU0EgaXMNCj4gZW51bWVyYXRlZCB2aWEgQ1BV
SUQoRUFYPTB4MTIsRUNYPTB4MCk6RUFYWzExXS4NCj4gDQo+IEJlc2lkZXMgQWxsb3dpbmcgcmVw
b3J0aW5nIHRoZSBuZXcgQUVYLW5vdGlmeSBhdHRyaWJ1dGUgdG8gS1ZNIGd1ZXN0cywNCj4gYWxz
byBhbGxvdyByZXBvcnRpbmcgdGhlIG5ldyBFREVDQ1NTQSB1c2VyIGxlYWYgZnVuY3Rpb24gdG8g
S1ZNIGd1ZXN0cw0KPiBzbyB0aGUgZ3Vlc3QgY2FuIGZ1bGx5IHV0aWxpemUgdGhlIEFFWC1ub3Rp
ZnkgbWVjaGFuaXNtLg0KPiANCj4gSW50cm9kdWNlIGEgbmV3IFg4NiBDUFUgZmVhdHVyZSBmbGFn
IGZvciB0aGUgbmV3IEVERUNDU1NBLCBhbmQgcmVwb3J0IGl0DQo+IGluIEtWTSdzIHN1cHBvcnRl
ZCBDUFVJRHMgc28gdGhlIHVzZXJzcGFjZSBoeXBlcnZpc29yIChpLmUuIFFlbXUpIGNhbg0KPiBl
bmFibGUgaXQgZm9yIHRoZSBndWVzdC4NCj4gDQo+IE5vdGUgdGhlcmUncyBubyBhZGRpdGlvbmFs
IGVuYWJsaW5nIHdvcmsgcmVxdWlyZWQgdG8gYWxsb3cgZ3Vlc3QgdG8gdXNlDQo+IHRoZSBuZXcg
RURFQ0NTU0EuICBLVk0gaXMgbm90IGFibGUgdG8gdHJhcCBFTkNMVSBhbnl3YXkuDQo+IA0KPiBN
b3JlIGJhY2tncm91bmQgYWJvdXQgaG93IGRvIEFFWC1ub3RpZnkgYW5kIEVERUNDU1NBIHdvcms6
DQo+IA0KPiBUaGUgbmV3IEFzeW5jaHJvbm91cyBFeGl0IChBRVgpIG5vdGlmaWNhdGlvbiBtZWNo
YW5pc20gKEFFWC1ub3RpZnkpDQo+IGFsbG93cyBvbmUgZW5jbGF2ZSB0byByZWNlaXZlIGEgbm90
aWZpY2F0aW9uIGluIHRoZSBFUkVTVU1FIGFmdGVyIHRoZQ0KPiBlbmNsYXZlIGV4aXQgZHVlIHRv
IGFuIEFFWC4gIEVERUNDU1NBIGlzIGEgbmV3IFNHWCB1c2VyIGxlYWYgZnVuY3Rpb24NCj4gKEVO
Q0xVW0VERUNDU1NBXSkgdG8gZmFjaWxpdGF0ZSB0aGUgQUVYIG5vdGlmaWNhdGlvbiBoYW5kbGlu
Zy4NCj4gDQo+IFNHWCBtYWludGFpbnMgYSBDdXJyZW50IFN0YXRlIFNhdmUgQXJlYSBGcmFtZSAo
Q1NTQSkgZm9yIGVhY2ggZW5jbGF2ZQ0KPiB0aHJlYWQuICBXaGVuIEFFWCBoYXBwZW5zLCB0aGUg
ZW5jbGF2ZSB0aHJlYWQgY29udGV4dCBpcyBzYXZlZCB0byB0aGUNCj4gQ1NTQSBhbmQgdGhlIENT
U0EgaXMgaW5jcmVhc2VkIGJ5IDEuICBGb3IgYSBub3JtYWwgRVJFU1VNRSB3aGljaCBkb2Vzbid0
DQo+IGRlbGl2ZXIgQUVYIG5vdGlmaWNhdGlvbiwgaXQgcmVzdG9yZXMgdGhlIHNhdmVkIHRocmVh
ZCBjb250ZXh0IGZyb20gdGhlDQo+IHByZXZpb3VzbHkgc2F2ZWQgU1NBIGFuZCBkZWNyZWFzZXMg
dGhlIENTU0EuICBJZiBBRVgtbm90aWZ5IGlzIGVuYWJsZWQNCj4gZm9yIG9uZSBlbmNsYXZlLCB0
aGUgRVJFU1VNRSBhY3RzIGRpZmZlcmVudGx5LiAgSW5zdGVhZCBvZiByZXN0b3JpbmcgdGhlDQo+
IHNhdmVkIHRocmVhZCBjb250ZXh0IGFuZCBkZWNyZWFzaW5nIHRoZSBDU1NBLCBpdCBhY3RzIGxp
a2UgRUVOVEVSIHdoaWNoDQo+IGRvZXNuJ3QgZGVjcmVhc2UgdGhlIENTU0EgYnV0IGVzdGFibGlz
aGVzIGEgY2xlYW4gc2xhdGUgdGhyZWFkIGNvbnRleHQNCj4gYXQgdGhlIENTU0EgZm9yIHRoZSBl
bmNsYXZlIHRvIGhhbmRsZSB0aGUgbm90aWZpY2F0aW9uLiAgQWZ0ZXIgc29tZQ0KPiBoYW5kbGlu
ZywgdGhlIGVuY2xhdmUgbXVzdCBkaXNjYXJkIHRoZSAibmV3LWVzdGFibGlzaGVkIiBTU0EgYW5k
IHN3aXRjaA0KPiBiYWNrIHRvIHRoZSBwcmV2aW91cyBzYXZlZCBTU0EgKHVwb24gQUVYKS4gIE90
aGVyd2lzZSwgdGhlIGVuY2xhdmUgd2lsbA0KPiBydW4gb3V0IG9mIFNTQSBzcGFjZSB1cG9uIGZ1
cnRoZXIgQUVYcyBhbmQgZXZlbnR1YWxseSBmYWlsIHRvIHJ1bi4NCj4gDQo+IFRvIHNvbHZlIHRo
aXMgcHJvYmxlbSwgdGhlIG5ldyBFREVDQ1NTQSBlc3NlbnRpYWxseSBkZWNyZWFzZXMgdGhlIENT
U0EuDQo+IEl0IGNhbiBiZSB1c2VkIGJ5IHRoZSBlbmNsYXZlIG5vdGlmaWNhdGlvbiBoYW5kbGVy
IHRvIHN3aXRjaCBiYWNrIHRvIHRoZQ0KPiBwcmV2aW91cyBzYXZlZCBTU0Egd2hlbiBuZWVkZWQs
IGkuZS4gYWZ0ZXIgaXQgaGFuZGxlcyB0aGUgbm90aWZpY2F0aW9uLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KPiAtLS0NCj4gSGkgRGF2ZSwN
Cj4gDQo+IFRoaXMgaXMgdGhlIHBhdGNoIHlvdSByZXF1ZXN0ZWQuICBGZWVsIGZyZWUgdG8gbWVy
Z2UuDQo+IA0KPiBUaGlzIHBhdGNoIGlzbid0IHRlc3RlZCBhbmQgbmVlZHMgS1ZNIG1haW50YWlu
ZXJzJyByZXZpZXcuDQoNClNvcnJ5IHRoaXMgcGF0Y2ggaGFzIGJ1Z3MuICBJIGZvcmdvdCB0byBo
YW5kbGUgdGhlIG5ldyBYODZfRkVBVFVSRV9TR1hfRURFQ0NTU0ENCmJpdCBpbiBzY2F0dGVyZWQg
Q1BVSUQgaGFuZGxpbmcgKGFuZCBmb3Jnb3QgdG8gYWRkIGl0IHRvIHRoZSBDUFVJRCBkZXBlbmRl
bmN5DQp0YWJsZSkuIFdpbGwgc2VuZCB2MiBhZnRlciB0ZXN0aW5nLg0KDQoNCi0tIA0KVGhhbmtz
LA0KLUthaQ0KDQoNCg==
