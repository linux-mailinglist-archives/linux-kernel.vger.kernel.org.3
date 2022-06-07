Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913D3540193
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245675AbiFGOiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245693AbiFGOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:38:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3264A90C;
        Tue,  7 Jun 2022 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654612695; x=1686148695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xu/6dIdUlhOzznPoWca4v3Yv7EqVj1vc72mr2Dgqe/k=;
  b=hv4PltPSqxBNS7oWfz18cCcu+f3JeYGcyFk7/DqckKMCKUHEFxJRC+Jb
   JlVOOtYprL7jzOIIytz37h05tSUUMu9mqS9J3bOsnOb0KMX+IRq6usXmz
   jwpY4TdflLSE/ZgDSADv+U80QAoGILK7PhaUV+dEG5YafyJq+Y5RHZGI2
   HSWqhhnN4BTJRsavDmwLgRm13NF08mEV4gLENWV248uzWZA0nVVjCCIOW
   GjFQvOagSoYFONNcgfFWzF4ZDYNypXHELzGL9U24hWrlU/sqM3wDZlDMO
   /9di0Btcg5PU7MDpiHdaHdXyec7Ncvvp0fN4Boza6Lop6puqevTvUc3VM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="338154600"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="338154600"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 07:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="579623587"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2022 07:32:47 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 7 Jun 2022 07:32:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 7 Jun 2022 07:32:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 7 Jun 2022 07:32:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tagh9Aw1ih/OLMXrUiAjrTxefh17E56o+1Of0AGQcZrfwYraLh3ruCDK7nqJXgexKkmv2iClylrNjeh+nVow8GczdCX8DlTL7VjXapMhYg/puI3N8Z8yyJJhUEeq1QjeA5yYWTOFMDWcixNokwSfDKoUlL+TqVuDD56Z3geDJGCdfjMjDIBPM25MJV5sdZ+Fx1Pjdx2Y1VwP7V/Y2uGLn9lBXUGvSYtxVMY7kdY1pvqqbbBEfCpc55fsME33hjPdt4rZ/0shLa93nbZ6BjI0NBW+xrqNWBnZLYFJOeGCZBSxtBYMLcVUO2PVy4ftcYzZ5VxcBlQjzJIsvxrqrj/UXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xu/6dIdUlhOzznPoWca4v3Yv7EqVj1vc72mr2Dgqe/k=;
 b=l3ikthXbRGcMCYH+MqoS14w2YzDppb3HdRED/n1OzfEJ4yUuRUrLHunXncfdqIh4mrUufoacevTpCBp7g+/6k8RxqZrN7R94i01UNn4YCKEoCk/1jCsIHLXzvXQ0785NERDtMiBYPdthgeX31VsM9zZQ0mKaMaF5TK/NMfHsXuCECLW0bWnMvEAHrH7BdZ6mnq25zINHUpEP5v7bIxoYzypv3NTdIlFoSJ5Cp+WKsiikhZeG+FVGh67B7UNhz/JHDznF0RU3cMnJ6MxY7LIRIz04IhbE/T5yx4f+INnDlECDnsK5udAAvOD0lIBfHTCui3F8ps0KXZ3j5odQCfF1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 MWHPR11MB0080.namprd11.prod.outlook.com (2603:10b6:301:68::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Tue, 7 Jun 2022 14:32:45 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::f51a:e3e7:96c5:d23c]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::f51a:e3e7:96c5:d23c%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 14:32:45 +0000
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "liqiong@nfschina.com" <liqiong@nfschina.com>,
        "Xu, Even" <even.xu@intel.com>, "Ye, Xiang" <xiang.ye@intel.com>,
        "Pandruvada@lists.nfsmail.com" <Pandruvada@lists.nfsmail.com>
CC:     "renyu@nfschina.com" <renyu@nfschina.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yuzhe@nfschina.com" <yuzhe@nfschina.com>
Subject: Re: [PATCH 1/2] HID: intel-ish-hid: ipc: use time_before to replace
 "jiffies < a"
Thread-Topic: [PATCH 1/2] HID: intel-ish-hid: ipc: use time_before to replace
 "jiffies < a"
Thread-Index: AQHYeaw3gvG9fVU3TUCS9Uxkb96iq61EA44A
Date:   Tue, 7 Jun 2022 14:32:45 +0000
Message-ID: <694cf5fe021898c42b286f18fff71625134ed722.camel@intel.com>
References: <20220606134750.20736-1-liqiong@nfschina.com>
In-Reply-To: <20220606134750.20736-1-liqiong@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9030fbb4-3775-45c6-2f80-08da4892966c
x-ms-traffictypediagnostic: MWHPR11MB0080:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB0080A2315111E01F642F27CAE4A59@MWHPR11MB0080.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /2Ldnd3F+zLCGvuXHc+JSP1kP5xrNlEztosIslw8rCayDtGbv6s6JQ9MAB5Gw1CXR7jpPT/DsmABTlOXYQuPC9A+fmS/KpXp6kEfuX8QPoHwydYRH6fgdWHzHEsCNpmWN69dFhRtqCoQVOzp2XveEi6blVo/jr2XrV1/9NjVBaZHCYzLhiSjeA7L9OfWbnRImT0L42z/kdUoAJesJsCjnqrZAhfKxIf5eZh9yWiU1T2xO3luQIMDmUmju/MPX/JOCxVy1vw+bZTsTlkYrwSpZhhb5xAVUvYJj7TUkV9VG3a7XHFv/+HfwCJAxOH62z007B3sSBgihFCLJmWV4r0GH0Sxn9Tqq0X5XSQlw9NbE7bKSUTIKy82CDVLBlZUO10UcEqpjvFBkXsZENIJZOR3Fa1yu0JYAmO/OU0+HZ23OoG2PWIE/D5tL43pwV8T0zRYGvz4RZgnJc0lgUxu7yVz6UVicPFka7kVh2FNJZ/Q/4XQtzj8BCOPKSohedStlZLIHH/mkgMxx3Z08dVKXS9fGWFw9A8pYmS0AunJyXM1fKY3kyJ3tZE9JM5B7GLUH2vKRq/Gfk3F1n/ivHX37XQmntmk+WkjOQoBAh6In/WvfExLvO0S0v5MFjRmNM5xZcK9MY3Vmc4UQ5vyRLKM315ciHTO0BL+ohglT1EQ+SxEkYB8ddAGiGWurrMBn/Tc5BoEkax/GZVlraiBphVF3aZ42Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(316002)(36756003)(26005)(83380400001)(6512007)(4744005)(2906002)(186003)(122000001)(2616005)(38100700002)(86362001)(82960400001)(4326008)(76116006)(8676002)(66476007)(66446008)(66946007)(91956017)(66556008)(64756008)(5660300002)(71200400001)(6486002)(508600001)(110136005)(38070700005)(8936002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1VUWWd3UG1DRGJRc1pzSXVOeUNHb2c3Qk8zR1JBWkcwdlY5aTdJMlEyMnNw?=
 =?utf-8?B?TmYreTd1bmJ6WkZWRWtsbHM1cDRRb2hRMmtjWmZGYjFkRS9wNEJoMDc4a3ZX?=
 =?utf-8?B?NVNOUk1kN2RiK040M04vcnRJTWEzUHVpUkVueHJob0pSNm4ybzl3bjNEUnRN?=
 =?utf-8?B?eXY5cUxJVTNKMnNvM3pOVVppS0lDUkk1Yk1zYWNiWFdOanBBcWUwTzZqbXFy?=
 =?utf-8?B?bThRelFJYk04QXJlK2lXVm9md0ZYOGhwVEZZODlDUHBXcXBvQ1dzNEhxQzRk?=
 =?utf-8?B?d2p6bi9jYS94cG5MVndlQ2VyN041Z3RqUVhBY1lVRkhwR3FxVmpWNmNFMjda?=
 =?utf-8?B?SnNFVnJiNXhGMzdiaVRrV3NFeGFBbC9YOG12MGp6aUtwMG9EbVFDMG1lWFYx?=
 =?utf-8?B?dXlJY1V0SlFlMkxyZ2dCdDBmU2dsV1BPYU9LMUM1V3NmU2lxdHpzQ3dqckZi?=
 =?utf-8?B?L3NTL1kzWkdwNHFQd0xEelVmUnQzeG5QcUU4MEEza2VOejBnemwxajBJQjBN?=
 =?utf-8?B?VFBsL0cydWU1WWZkd0RkcEMvcUhrczF4UjVRSzdWMUFpTDFTVWxMZUZ2cXI5?=
 =?utf-8?B?ZUJsUDltdHp5WDVaMTVCZTM2NmlDWEJxaGY5QXR1K0VKZXNEMEpLWVB0d0JJ?=
 =?utf-8?B?b0hSVFBBWHdrNlRvaTUxSVlyR0YyeTJkaUYwY3c1aEFIb1ovSlU5VEhMZG9V?=
 =?utf-8?B?OUFkYnFuYzB3UTF6Y1VkM2VhdGFVbmVlejFRVEk5OTBOK2RMWGpWVUVaYUtD?=
 =?utf-8?B?ejgyVmtqalRWQUI4ejdzaXc2MnN5SGRLMEpEM1ZmYUFXMXRzNmtBTXFsV09t?=
 =?utf-8?B?TDRWdXdFbVlHL0JIeFZHUHg2WGhOM3JHVjE5Y3AyaDlMZmN1a2NhQUlOVEVL?=
 =?utf-8?B?T0cvRVQ4QS81UDVaQmtIRjZOYzVUMmRlTWlJYTdoTU9LNlJtMUdDUzRaeTlu?=
 =?utf-8?B?bzlVVkVkd2N5b0ppRVdQS0RYMGFRVlVNZzZWTEhxcHo3ZmVraHhxbFoyLzlJ?=
 =?utf-8?B?QVZPUUY0V2lmRTFDa2VubUVjSFNKangvN3FUeHFsUmcrYjN3WENFaWlBSHNk?=
 =?utf-8?B?YU5LSTJxSVJpTS9sY0R0OVdvd3BxcnhnMjZ3bGh5N3JmSWhIQkU2N3RyRHZW?=
 =?utf-8?B?cWdFUENETTZvdmszKzdUb05wZEFjTjZ4S2pKZWRodU4xQ2xEcml2ZnBhQ0M4?=
 =?utf-8?B?YlJ5TUNKYXlBSk5qMUhISUpzaUlSMTQybTV6Mkdac3dMWW5zU3QrN1RvZ3Qx?=
 =?utf-8?B?MlNHWGZ6ZUROaW9hWHVIVHo3ZWFvbUxXY2YzZCtwVm1qZFRlTW8wdGhzRWhF?=
 =?utf-8?B?V2w0c0Jlc3E2d1EyNjNVek9SeE9zOURncDdHbjdPQWNJUU92aXdUOEw5TGVM?=
 =?utf-8?B?MXJWRUM0dER5ckZ1eHpBV2NzMjJteEkzQmhNd1BzUG9JYlFWaXFZNEZqdm1s?=
 =?utf-8?B?ZzU1RUtEYlFjTVJxNHo2bGJuaWhUV0NLSHN4RGhya3ZLR3ZTL01nQW5uOTdn?=
 =?utf-8?B?ajBRQjZvN3RXMUNWckVsaUZXQzBBQnA4RXBCejdHZGtnZE9COWZXS1R1RWFv?=
 =?utf-8?B?UG1IeGZTclZjVDUrQjh1WTcrdzkwdFBVOFp6ZFZRYk55MlRPRjh4OG53andp?=
 =?utf-8?B?WkJnTng1LzVaYkZUNkVlaVNQWjZORkEzemp5cFI3VlA2ZWwvUUxybWlNalJX?=
 =?utf-8?B?RkowQWlPNHMxeTlkZ2FrMW1kVi82ZUFGODVzbVNOaHV6NUxwL1JmR0dQVmN5?=
 =?utf-8?B?UFVsV3NaTW8zZndYY3FWS2tacUYraUVDV2JJRFppNHdrWkw3MTZ1VGVjKzJJ?=
 =?utf-8?B?VTNrNFpCM2hkalMxQkFvUWd6OWs4SDJwQ1FzVmdER2JFelRjckVuT2hSYVh4?=
 =?utf-8?B?TnlvYi8zK1RIRllNTnRXQVUyYlplOVNqeXZsSEc5UllYRmFubzMwOWFCZHAz?=
 =?utf-8?B?bVVBcUtMNVZjdFBOVlU1QWYzTW9UUkFEcGoxa3Ftd1MwMnNxZGF6dVM1Sita?=
 =?utf-8?B?bzlCc01HWUlCTDRvOEh1ZjlDTkJPRTF4dFFUSnA1bFdlc0FXeFNQb3hUdHcy?=
 =?utf-8?B?b2I2TUhIZHZNeUUxOU1nUXhoT0N5NUI4cCs2dGJpUkVDL2lpbU13c1ZyRUNi?=
 =?utf-8?B?SjlTby9wTzhyVjdSUVdONVpPQ25DSThQYndkWjJPM1JlMjZQbFdaN1MyMklm?=
 =?utf-8?B?MFpJdG1MQVMrSWhSU1dpVTR0UFdhUm8zVlpyb1RYUFh0ZThwdHg3YnJ2amd3?=
 =?utf-8?B?MlNtYVJ3SHFBZURvOGRmSGpUWWpHR0pON1ZwQkgzQzdZblVyY2FiaVZGb3VJ?=
 =?utf-8?B?anVlK1pPaVRnUG14by9FVlFxSHMzMkM0SHNCaDZWMFBLdlBOaEs3VVNsLzAz?=
 =?utf-8?Q?HCKZ+lQOzAdTpon5UYqoSEgngK3V6goKD3c6V?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <745DF0862E807C489937ADA8511A2364@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9030fbb4-3775-45c6-2f80-08da4892966c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 14:32:45.2131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsd8QzDSX2PCci/7BI/uYCPGScgTqlI65/layq9mUsXw6Xdedh9fnHW1lyXSa5x+gcKV1UfANfruzap771UoUvMaNgBsI/WpdMCV45BtFN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0080
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTA2LTA2IGF0IDIxOjQ3ICswODAwLCBMaSBRaW9uZyB3cm90ZToNCj4gdGlt
ZV9iZWZvcmUgZGVhbHMgd2l0aCB0aW1lciB3cmFwcGluZyBjb3JyZWN0bHkuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBMaSBRaW9uZyA8bGlxaW9uZ0BuZnNjaGluYS5jb20+DQpBY2tlZC1ieTogU3Jp
bml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQoN
Cj4gLS0tDQo+IMKgZHJpdmVycy9oaWQvaW50ZWwtaXNoLWhpZC9pcGMvaXBjLmMgfCAyICstDQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaW50ZWwtaXNoLWhpZC9pcGMvaXBjLmMgYi9kcml2ZXJz
L2hpZC9pbnRlbC0NCj4gaXNoLWhpZC9pcGMvaXBjLmMNCj4gaW5kZXggOGNjYjI0NmIwMTE0Li4x
NWUxNDIzOWFmODIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXBj
L2lwYy5jDQo+ICsrKyBiL2RyaXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXBjL2lwYy5jDQo+IEBA
IC01NzgsNyArNTc4LDcgQEAgc3RhdGljIHZvaWQgX2lzaF9zeW5jX2Z3X2Nsb2NrKHN0cnVjdA0K
PiBpc2h0cF9kZXZpY2UgKmRldikNCj4gwqDCoMKgwqDCoMKgwqDCoHN0YXRpYyB1bnNpZ25lZCBs
b25nwqDCoMKgwqBwcmV2X3N5bmM7DQo+IMKgwqDCoMKgwqDCoMKgwqB1aW50NjRfdMKgwqDCoMKg
wqDCoMKgwqB1c2VjOw0KPiDCoA0KPiAtwqDCoMKgwqDCoMKgwqBpZiAocHJldl9zeW5jICYmIGpp
ZmZpZXMgLSBwcmV2X3N5bmMgPCAyMCAqIEhaKQ0KPiArwqDCoMKgwqDCoMKgwqBpZiAocHJldl9z
eW5jICYmIHRpbWVfYmVmb3JlKGppZmZpZXMsIHByZXZfc3luYyArIDIwICogSFopKQ0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsNCj4gwqANCj4gwqDCoMKgwqDCoMKg
wqDCoHByZXZfc3luYyA9IGppZmZpZXM7DQoNCg==
