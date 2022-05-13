Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418EE526890
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383116AbiEMRfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383106AbiEMRfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:35:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA1010FDD
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652463337; x=1683999337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1ZOBnbfWeFj5UaqKAqhuYVGn8EDAhtlGZm2qXXRI5+0=;
  b=SODuwSRNdru764uoy/rxfQddb7TpBqhsO3Rf0HXuGzfL3esLlVSMH8hF
   /vGcDhrJLFOf4YRvKhI4/O7Wv3p9iu2EIthFBkSW8D7gbauvPz/Q4tAnO
   A3uOCZ8dCG7516fXKeT+OPmvl+5kf1H0U8YkZ1e7tZJXYZjgwBt1/0zPB
   raf2sxw8FLQcSfqbdKFEEt7n+w82RgrphplPsNQf/7G5FGc3rRHFyf29V
   /y/4lg56Kns7LmEEo6/bOSEh8ic3wQLM0Ja8E/uGy6kfudfwoD8KEbFsT
   uPrfLsKibHCrh06X8XthIURXHQxekHCpZkRxzLsd4DbhSNd4Qy1tMI8oK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="257916499"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="257916499"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 10:34:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="815482734"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 13 May 2022 10:34:47 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 13 May 2022 10:34:47 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 13 May 2022 10:34:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 13 May 2022 10:34:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 13 May 2022 10:34:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqhErB0hzJ+IyKjqpW7xJWN1443MkBVsDxJs8g4NmR218roklSxGYEPci94NyZwlLTj/lcycq/b+XhfvXczMK74eF90qDQoZLfRerR2nylvwZUFWAFpdwTyzpMmE568F8qmbS4/CC12Lydqn8UMAjnCOiPuiLLdWLDxux5vYV5yC0dzlEqzlbKx+aGEPSg+4SV4IVkPFnBLvW8LGi+JKUv/tvvybSDm5fyKQ937weAHWtXXOtIRioxzy7K28lLHwjx8sBXq95Xc+3mPhP2/1Dl7mGD+HGLC0pFjreYa+DhPyC3ynIQbNFatnoLGkVWD3Q7aWs1tsgV7I0cf4FZLA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZOBnbfWeFj5UaqKAqhuYVGn8EDAhtlGZm2qXXRI5+0=;
 b=QQ2KdxAuKDAMZCBZyrwkdhGn/HH6nIS63STgN/JUlohszcxKtrt3NMc5EkLfenp+QBWkZsFc+QBnuTIQz6Mc5HaH1ukjznHNSFv/sQDHUWIKAXsHguxy7Br7UtUtp/QswjEkQWUBKheRBSNpfQvZaFuuQjpF+7jiia2vcTLIBNnsCLKABuewi0HGX927I1xrz7QSXhYeZ8UXYOhaw4fa8e6g1dx/OsOVloFKu7+Ty5sVsypMNPwaLYm0EQXkIb/DmA1nFrye5Hc6wBei0R18fMYlf8t27KaghYCKV+3M3oFCHdqrmRvZedNJ50BjQ/BaRNdOat7rAl7ppjqp2D1TeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL1PR11MB5285.namprd11.prod.outlook.com (2603:10b6:208:309::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 17:34:13 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5250.016; Fri, 13 May
 2022 17:34:13 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "glider@google.com" <glider@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>
Subject: Re: [RFCv2 03/10] x86: Introduce userspace API to handle per-thread
 features
Thread-Topic: [RFCv2 03/10] x86: Introduce userspace API to handle per-thread
 features
Thread-Index: AQHYZOBkvB2PlILtfUOVczGp43rrrq0c3EGAgAA5TwA=
Date:   Fri, 13 May 2022 17:34:12 +0000
Message-ID: <da0f438bb459050e5a586a17382e961259449761.camel@intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
         <20220511022751.65540-5-kirill.shutemov@linux.intel.com>
         <CAG_fn=V8k3hiviv3htV6wWZ6fUBri=MORfXGJ+Kz7GdRDZvesA@mail.gmail.com>
In-Reply-To: <CAG_fn=V8k3hiviv3htV6wWZ6fUBri=MORfXGJ+Kz7GdRDZvesA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92247c80-8339-4d73-6873-08da3506cbb8
x-ms-traffictypediagnostic: BL1PR11MB5285:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BL1PR11MB5285EEC261ADE06CD71FAE7AC9CA9@BL1PR11MB5285.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ADB9V7dgWVkl/l6ci/cYJ20sWQTwEygMXpnTjWtebqhbWt2fv3x8bIEbWEm3l+csQljk2lhkjnLM0p8+zSs+uZsg953RoMIvVyDHWmMkRzEoJCc8yXGDKF5rQb8dh0Yv0Yq6TahGd/9uyua3NlVZMyN/JgHc7enVQXkBCrRzAhS5j0rAY4aBMs9ndROcg0FBK8Mfxz5oVXUytdiPnG6sr4tc/lNqCoSQqT1z4A0NodiDfOFgQpxJ688X5MxgH7Je74qnm4quEe9m/C9fxLSC6JA45hxxPUnWrcjFeOMo0X9fS1vVOS0148QnU8Ry775K/vTOrFsbKMVHEQr0hGI2wpM21op8nveih/8VbDnEWaCel8PX+jIgTn/8zRKKpBrgsVUtpLw1/Zf4+aaYQdUNQTpElYl7Dq0xmeR4ECMIlQNAOUlLTMxcfDG8AG1T/eAsKVHHjTLDrrYwxqrjC92AecXxyDar+7n7X0FeUXt5fPYAMk0KI3sfTEJJYw8Xy5iv9XDqXwcx0Y2GG7f7oFm5+6IzTC8HE2tW8RmzRKUsN/9eejYcHt4S7hEg4GmdcI4c750YZ/2frRlQaGT0PwgehBn4RR2eoo8sbRNdUjX94DTpzPc+AhYYYJ2J0UlOSL0WRQ62P1PP/LIvINKLiHplpj0qe4dIsctdX4/42jfBXh41nRCGCV6AVFwGHjXESRGmvk+jA+J4FgOPii++JjdvMrJL2PGmKi+7mgtzPx97+rk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(26005)(2616005)(6512007)(6506007)(186003)(508600001)(4326008)(8936002)(76116006)(316002)(66556008)(66446008)(8676002)(54906003)(110136005)(38070700005)(91956017)(38100700002)(6486002)(4744005)(7416002)(82960400001)(122000001)(5660300002)(71200400001)(2906002)(36756003)(66946007)(66476007)(64756008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VU1IZ096aTJKOUY0L25lUElHQnZIelRINXpJY05rQmk2d2xDbFV3RDhVVHh3?=
 =?utf-8?B?cUh1YWthZWN2ZU1UN2crYmhUUEpGdTdCQStzY2lsaS9ROU1jR25qV2I1amFF?=
 =?utf-8?B?eWtlR2NGNXdRdFhJSFIvYThsRG1IWHQ3NDM2cDB4eTFlUllpVjhta0xROGlX?=
 =?utf-8?B?NVk5RUtOWGhBOEdNQTBBdnVLQU1QR1lXbU9LOFNpNlZERDJ2ME4xdTQ4WFlF?=
 =?utf-8?B?TDArU3VBQm5QSVVGZnRBRzY0cGtORFVFNmNkVnEySnFiVEJJbS9CS1lUUGlJ?=
 =?utf-8?B?bEZpL2ZwYzMyNkx0SDkwNWlmYlNTSUY1cXNmUGRNbWFDNGZMVSttMmlta3la?=
 =?utf-8?B?S2E4aEp2azIxbVlRSy8vRk5wTUMxRjJVSzVJd1crV3FlMWlzT05uNUUvTG4v?=
 =?utf-8?B?cVFNWU5Ua1J3alg2ZDZtcVZSajlQNUNuNHphQ25Ca3M1bUZjZ0paOTRYQVR6?=
 =?utf-8?B?bWR6YXh3cGpUU0dYVlVGQ0VvTDBlUXcyL2JvVVZoMGVMcTVsclNYd0NTZFBm?=
 =?utf-8?B?dThoU1pxeE04aDhBNVZkcEFFa0MydlA3N0NyUU1oa0h2YkN0RlQ2MmZjZ0xv?=
 =?utf-8?B?cU9ER05sMzhXdVdrSThMRnAyaExsMVpSM2hQV3owZDI1eTc4ditCT3pjS0xD?=
 =?utf-8?B?TEJJckp3KzdSa29HclQ3eEVFSnUzZy9RVGlrRkNBMldMa1J3cUtzblZpbVp6?=
 =?utf-8?B?UEhwQ0tJQXpyeUFhWGNsUE1SS0pHOERhSXFOdjdHSzJleW91c3J0YW5zVndy?=
 =?utf-8?B?Vm9ZL0NrcW0ybjY1WUdlYmdLQzMzK2Z2TlQvNzBWaHloMjU4dThxTjlUbjJJ?=
 =?utf-8?B?aEJ4dmNpNENUMDF5U0hvbkk5emVQV1RZeVJNczYvSjcyS1MvNWpqTWpZcDhO?=
 =?utf-8?B?K0ZIc0I3RnMrOTAvM0l2dlQvVkhlVVlKbG94aGNPN0VkOGRPSmJvZVZjN25v?=
 =?utf-8?B?dTlOTlgwdUtnVzN0VzJKZXhOaEw2OVpxdGw5WlVUNjlXaElLZUtOTjN2Z0lJ?=
 =?utf-8?B?YzFlTmduckFmWWFvQ1hSbmtQRUgzWTN6Y3JpeXFpMzJoaXgzU2JPaTBYVnBt?=
 =?utf-8?B?M1pTdkZ1RVE1QTc5aXVOMS8vUFhFUUlPQlJuUHdiMVVReGdJbWJsZWFzdmdL?=
 =?utf-8?B?NCszRjh5SW9nRFF4Q2NSbzZ4alJxOGFIV3BZd1c1UEdnRGJvei9rSW10bXlq?=
 =?utf-8?B?aWRXRXVUcjFVQnZ2dnIzMlBHMVM2c1JQYktiVDdla3F5Uy92T0Z2OXFNZHE5?=
 =?utf-8?B?UlZFUlNqYmM5bzdpdnJYRHdPZ3VFRUsvM2FTb0J3K1ZNK3A1aFhReElVTjlT?=
 =?utf-8?B?QTFPK1VKd2RJSld5M2MyY21pSjhHSUpoOEZmYzg5N1A4L01wVnkvSlJsV0RY?=
 =?utf-8?B?M2NqdUhCbkVRQ3RXc2tiamlueU05cFcza0tacFovd3h4c3hJNEVmUDF6dTlW?=
 =?utf-8?B?N0d0QVlGYTErMWhHKzJRZ0x3elpVSHRFMG1zMEJIWStaOHc5ZlNlZDVLSkNS?=
 =?utf-8?B?OFUvdXNMM1NEb3dReDRDZCtodThUaGphcVdwR04vWjVoalR2eVB4QVlwalkx?=
 =?utf-8?B?a1RDUi9GUmlqZVo5MzJ3cStQVmk2R2w3eXVQOVIvdS81em5oZFFpTVdKYUUx?=
 =?utf-8?B?WGtFT1h1M3llQUVRQlFNenJxaXV5b3U0aVRiWVZwZWJ0OUJydjBjU0hrWDlF?=
 =?utf-8?B?N0x3MFZYeDJ6Q3Z5Sk1DdDV3aC83cmVCTFlGL1g4RUc0a0p4dVMvZEVuN1pR?=
 =?utf-8?B?Uk9HYTN0MGZyS0hmbzVWNDlDUU5JaGpGbHRhNnZidU0xYVRkYUp3Vk9kc3gr?=
 =?utf-8?B?TmwycEprblMyY0xlRHF1TXZ3bmN4VHorN01tamxvdXFDOHVQdzB6cHVHM3h4?=
 =?utf-8?B?NnFUa1NxMUNtK2VueEQ4SjVyb3VmZjhHNXBvUnNuT1VkSXgzcmplRVZKTnZS?=
 =?utf-8?B?MVp1QWhMbnlNWlIxSW43bTBKMUpFN3huSWlDU1pDZkpDV2hsd3AvSzArYjFN?=
 =?utf-8?B?QnZ1TTlmMkxuRUlmTE4vWmwxL3ptSG1QOFRadTV1U3o3UkUwTkFrdW1XWDlN?=
 =?utf-8?B?MGdTOUx6alFDME9CdVhPQzQ0MldUMzlPWGd2bjQ3TGJXQklhVk4vaGxjTUg5?=
 =?utf-8?B?aEhhc002TVJ5MS8rNmpBUzlGVlBtTkhnL3huc3ZmUUxDWk5EdTdkSXQ0WkJh?=
 =?utf-8?B?aFF0N1lHVlpxTnVwcnF5Yi9hYURSbEFyQmkyaHVSRHRCZGR1RTdoeklhNjha?=
 =?utf-8?B?SXFNaVFSSHdOY3NsOWQxdXM2dUNTY0h0ekx6cEJWYnMzcUV2ekhhTkUzWE9O?=
 =?utf-8?B?cVJhRDY4VEhNYnpLSG9CcUtkb2tkblNJWHB0anhUc3J6NXo4UGhZL0dwSSt2?=
 =?utf-8?Q?75EJraOnFjkItPdVA/QN+gQdotJDHvVCj1ZpU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9046618B76FB6C4FBCDC6901174D818A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92247c80-8339-4d73-6873-08da3506cbb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 17:34:12.9970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oqnj3ktj+oGZfm8dbtmGfJKTx5m99Bgfk+sFjx7LMfRvekl32nIZ8XFw/jI9RmXEQ1EJ5/hXBQucHt3GVcwsmFlEZGmAVJ8Yd4pmVTXyRfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5285
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA1LTEzIGF0IDE2OjA5ICswMjAwLCBBbGV4YW5kZXIgUG90YXBlbmtvIHdy
b3RlOg0KPiA+ICsNCj4gPiArICAgICAgIC8qIEhhbmRsZSBBUkNIX1RIUkVBRF9GRUFUVVJFX0VO
QUJMRSAqLw0KPiA+ICsNCj4gPiArICAgICAgIHRhc2stPnRocmVhZC5mZWF0dXJlcyB8PSBmZWF0
dXJlczsNCj4gPiArb3V0Og0KPiA+ICsgICAgICAgcmV0dXJuIHRhc2stPnRocmVhZC5mZWF0dXJl
czsNCj4gDQo+IElzbid0IGFyY2hfcHJjdGwoKSBzdXBwb3NlZCB0byByZXR1cm4gMCBvbiBzdWNj
ZXNzPw0KDQpIbW0sIGdvb2QgcG9pbnQuIE1heWJlIHdlJ2xsIG5lZWQgYSBzdHJ1Y3QgdG8gcGFz
cyBpbmZvIGluIGFuZCBvdXQuDQo=
