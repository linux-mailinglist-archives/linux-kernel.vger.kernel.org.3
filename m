Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD72455A4F7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 01:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiFXXlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 19:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiFXXlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 19:41:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9FA8AC00
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656114103; x=1687650103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HOFGZbRE+ELtya22hBLbeh25PQh68L7GJhsn5MVjAfI=;
  b=JWqtXkrtbP358JRqIZMw3eg1keN6mH/wgTqchqIRaY2WHqK3kHra78yM
   mlMDwKPW0nOezEQ5eA0NjkW/h8CdvdkztudFZKvLjSDvf+e0zQV/CluaA
   iykjSeKRR2v09Ysf5V9F/iJP2xXI6qE3zBHhLWbm3gwop6B70cl4PChxM
   y6KiutBTU+wZaCw9fKGJ63zg0Bw73/RytvQJXXjHU/RJMEV5RJb9l9EKp
   Hsr//T8fyj4UdjwJDSyfxFjfzbBFvN3GND+YbjdFaWZdVIoMAzL9szHtA
   js6FGMh6UQEqTymUHagHFU+xCrSLizV2u4e+WzuXiXOVCX2XsB8vNHROn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="281163878"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="281163878"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 16:41:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="691730890"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jun 2022 16:41:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 24 Jun 2022 16:41:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 24 Jun 2022 16:41:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 24 Jun 2022 16:41:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 24 Jun 2022 16:41:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itZJjb7PLBuJvhuqfALkPD+YOw8Xk7pj39Ptsvds/mcMb4EJo/nmyQpmUxmvoynBb/gFAJUmGSMpMbtbJ52lQvwSxdPl5qII/7Kg8Q8hbCiExRWlGZcOgnzNYwHSVcAPICnSlC1AWZJlwIRYOG44UjbepLIjr0kevJS1tcGM1C11ZQVqAmse1J5XdzWSTjQ1Piuv97K9SMooMBqvXx81qR71906fqQzNLA2p2La1W9vKFzQHCQ9HXVzwZ4peL5rphWgYJkqysBkSTgKALNkUG82Ffja/ip6cEC3EWwQBAVmmcewZkzN2AhXGPse4ySTQ7wsXrBwxYiB2Dfbe05IraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOFGZbRE+ELtya22hBLbeh25PQh68L7GJhsn5MVjAfI=;
 b=BIs3ebKx1O9rbiqug1xtF7898zcb+px0lXpyXC7ukGsb+eiyep4mkPqQ19PH2PW6nhdN7FNGPZ+p3h88uSBu5nLSQFQKOBqNzLkOhkH7zVXVVrGpf+1xsKxoBr5WCv7rE1VNODUCnzWuFd9Y3aB462B8jAR2ZodgP3ZZkOd8q2Bu4cbdP/JselVj4e1mkE0Z5UlbCHCcYIbfDWd8YP19n8qw4EAgTLUlIZuxfFBYA/ty/TZkNRJe49JSwSXnstIIdJZjc3gIB0tRMwC+hBE1qnhL74LOuGnXOrXlJZOW/RiFRzuqwXoWUiuPbrgXGyRclKVWCYVuW5UZK/KAj1T+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4435.namprd11.prod.outlook.com (2603:10b6:a03:1ce::30)
 by BYAPR11MB2645.namprd11.prod.outlook.com (2603:10b6:a02:c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Fri, 24 Jun
 2022 23:41:38 +0000
Received: from BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::aca8:ad93:7fed:9fda]) by BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::aca8:ad93:7fed:9fda%5]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 23:41:38 +0000
From:   "Nakajima, Jun" <jun.nakajima@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     "Huang, Kai" <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        "Isaku Yamahata" <isaku.yamahata@gmail.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Yao, Jiewen" <jiewen.yao@intel.com>
Subject: Re: [PATCH v8 2/5] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Topic: [PATCH v8 2/5] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Index: AQHYhLy24rlbI/OJSU2PnXDxVfpfoq1fPmqA
Date:   Fri, 24 Jun 2022 23:41:38 +0000
Message-ID: <385B219C-4DB2-480C-913C-411AB4D644ED@intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <78873cc1db47ba00a4c01f38290521c1a6072820.camel@intel.com>
 <efb2cdab-289b-8757-fe5e-5348519b0474@linux.intel.com>
In-Reply-To: <efb2cdab-289b-8757-fe5e-5348519b0474@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eacd8617-db1e-4287-5e9e-08da563b150d
x-ms-traffictypediagnostic: BYAPR11MB2645:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jhTwT4eEo9+bWdlCaG6wMXJ23h/c7MOZoNw29eh6PzGOKMTcFs/Yr0hIkW2z8M3GkKhK5f1MsR3hhsKuf+OawuFDap2rNG5J/9ON6lz13ZZIBJZaSTv1QZ0dYNgEK/P8zVpsyMVfKzze8g/GF4zskAA2k1PNkmj0QUrJyCTD6MlCQokw29nAL8t0FZqARfALEJcwhuBVYXCIyRm5BbIh/aWCdAm7vrfYxt7qNRagKaGny8NUOWpf6bMpCaF02nY6igaADhCksNm75I88dptQOEglIitOAgNSMBDtPdgiuRs/++GkCA0Pxc/Z0O+twg8dqsPdWkvL+Rd/evZHMgnG6jVTwHh8gIhhy2Ol5xWiDKDH/QxVPcQ8LykIjmk1i0MbHIytP9N9RfPl042vT14fGhZTie4OsaocejVE+MDnF95S1OGGaCHITGKhch6AY4YIJOknMuEh9aKaLLJp7Y24NT+WIEKoF/JEds+9xkdeB7MvkI8hvVDFWzlbLqBu/jZWoKwVgj3eER4ylmJBVwkKEd7PIpSs2RUilU+0fgMgB51ZGElYbOygse19d+Hj7FTGC6BnQsZwgc/teBxYnBNbxekbdGDKDhIX5sUtWd0bA2hqhlucfJivAY5Y43UJGcoZx5L3tUQnh05L77iqHtSOQ/TEwKLGW37cNyNof79C1qG4kSlsHqriwjj1HBthlm8O2g2auYTV3Pw0H+00p9+CfAojZFF5YdyTSW9ojXBkteySMASDvkDJlWKcnDik9rk4Dcw15gGxrkz3dUuIBsqxoxWlxmBMk8k4sUC8Cj8Mm9ZqXfSMciiNAtOS6YUxJamE49YosaYezTqHKdr5Zpo3ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(346002)(396003)(366004)(7416002)(38100700002)(8936002)(86362001)(5660300002)(2906002)(83380400001)(82960400001)(2616005)(66946007)(122000001)(66556008)(41300700001)(64756008)(316002)(4326008)(66446008)(8676002)(66476007)(76116006)(33656002)(38070700005)(71200400001)(6486002)(478600001)(36756003)(53546011)(6506007)(186003)(6916009)(54906003)(6512007)(26005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWlUNnZ2Umt5b3VxL01YQ0xGZEZhOWJpNUswYU42MmhHTE91ZFV1VXEvN2Qw?=
 =?utf-8?B?R1VIcEVxdm1LcU81SlNuVVZmcEd6Q1ZpYThjTFZOODZCWHFHSkIxK2RPTXkr?=
 =?utf-8?B?VGNRellaNTZCZytKZ1o3ci9GcDJDdVJQdmRySnNVZXNpejRGVHdQc1pOSlFp?=
 =?utf-8?B?Unk5T1ZTcnVzSkFnU2ZNSHVVSlI2eW1wcnMxTVBmMVdBdlhmS3FFaWx5dExT?=
 =?utf-8?B?MUlVWUpQWDZNYWVXc3BrNG1MRU1BUXRudDlkVWQvWVhUcThtUG5RL1Q1aXhy?=
 =?utf-8?B?ZXNVK1ZTVlFIQlNOZ1RBaEtJNm9rSVdmZkEzcjVnTGtBM0laU2I2S01oTllj?=
 =?utf-8?B?d3Z6d2dRTVRCazdOVk4rSVUyMytRNmhFMDRjWEcxSVN1bmR4UjZlWDBSNkRZ?=
 =?utf-8?B?RDZEVHdnSHQzM1VuemV6R21uUzdOanN0NHNMenVZelI4UE5scjdOWmpVcFRj?=
 =?utf-8?B?TEFZckkvQ0RMYnVLUVU2b2VwWGJ4WDhFbXNIVXFIeENCVHFmcWg0RDErWVE5?=
 =?utf-8?B?MGNYM3dkNFM2S0pRaGNkYnloMW9EOGQxcU1hL2gyMDRudFRXNVZ5dmE5NFBi?=
 =?utf-8?B?T0Z4YTJ6V1QwUE5qQzdpbnJtb3J3VmVLTitWQjIxT2QxLzFNTDlXMUoyWmFO?=
 =?utf-8?B?SWxRTERuMk45TnFYRDJIdkxaenFGR0Y1UjdvZEZMbm5mUlFjcGlrZTA5cG1t?=
 =?utf-8?B?Z3dqOSs1aitoenNCVGZTaHpwcSs5U3NKTmVMY0RqN0ZPRUVGWXJRZU1nOTNw?=
 =?utf-8?B?aVd0Z2pLakNtdk1Bem8xRlRseFJvaEhSU3FhWEtBTldEcjJsQW1tVHZSRXAw?=
 =?utf-8?B?NWhkcUgrWGhhWjY1VWJJeUtaUWdTVDZwRWtGU0M1OEJ6N3Q4SjcwKzNVdGpK?=
 =?utf-8?B?MnZtWGhtTXJ4OTkyRE55dHN3ZHFEVnUxdXQyZ2NlMzFrSVJPcTdkOTFxVmZz?=
 =?utf-8?B?OVZibFFKRGRuWXJRaDVVOGJsS0t5MGNSRzR1QzVuTCtjRzh1dEdQSCs1YWdU?=
 =?utf-8?B?TmVveitPeVJXd3grOEFaa1BOZnVYZUhaeExDeHYxV0NTL1hvZTR3MHpBdHlN?=
 =?utf-8?B?SXBCVEwwTGh5Smt3czNtZ3hHKzA0SmhWZkZHZ09VekMrQmFnS0VNUWI2SjJG?=
 =?utf-8?B?UjcwMmhCRmtDNmUveHE4OVBhUFFHM0V3U2s0VWJYbUF3c3VSdndqM3ZPV2xs?=
 =?utf-8?B?dkJ5V2FRd1lkQ3pLUnBlQXMreWhaM2ZITnJBMXVuRUhtV0VYL2FaalBIdVJ2?=
 =?utf-8?B?Vk90aDBveEJpeXEyVHVXOVZENXRyeU5tMERvdEZ2RGFLK2sycmM4WnJOSHFi?=
 =?utf-8?B?TFdMVmdJYWJHaE1DSkxuV1N3Mm1uaVllampkQjdQS1pOdGw2WWo5S3NhcTQ1?=
 =?utf-8?B?YitGME8vSWY1dWkxQktSb284ZnZaTWovamMrMW5BZHA5eGpsbFBITm0vWnAv?=
 =?utf-8?B?YkdsdEZXdTdKR0NhclNZcG9PWjd0OGlidjJqNFJ2eHB6K3FldFdUczZtbnBP?=
 =?utf-8?B?RG4wbnRXS1AxNHN2dVRkSWg1U1kwTUhaQjJPZDArYTgvNE5zOGoxTnhGZTNt?=
 =?utf-8?B?RG5ITWhOczNoY2MzUHlBRDRFckRtTlI3RjhJYkFwTmhBSVNyTlFON0NEN01t?=
 =?utf-8?B?eFlCY25RZ3RaUlVKcW0zUWFZQUw2VG1LdXFiQTJDUzlnSjZiK3M0czNwWHpJ?=
 =?utf-8?B?U1lBTDd1OVhsekUvc0hwMldHK04zZC9pTXlvS3hyaVZvcW4weXhiZndlRHR5?=
 =?utf-8?B?N2dSWTRpa2Y5OU53M3FZTXMzOUNCY2x3RUZMdFl2U0lTR00xN0JyWFJUTTNT?=
 =?utf-8?B?VnN2V2trcmtHWDJRSCtkSWRPZ2IvcStESGNSY1VXMUxsR01Wdlg2anphdmVC?=
 =?utf-8?B?WjFGOTV2emhZL3VtalpESXVaWnBlQzhlTlM1V3Y1MEpXWXNOcDk1Rkk1OEN4?=
 =?utf-8?B?cmNINVdjZ3BzcHpGL1FxSkVwMnFaVGdrZmswcm9XV01iUkR3dytCcHpWeUhX?=
 =?utf-8?B?UG12Ujl0L2tBc1liMEIxRmJaQ1FHNzUwKzJJeXBkdjc4RG1meUUvUHZxMnR1?=
 =?utf-8?B?UmZ5WlF6ZHJkeXFYOGNDUUw0Y0c1TVRDTFFaRUszWGIwVFE0M3lTaEJYS0pn?=
 =?utf-8?B?OG1ZdTNNUjQ5MUUrUU9JcDRZM0xRK3RwYnR6VGxYdW4yeFIrbTdBZE5oNUlF?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C52C7F5E3D89144A94B1A301BEA024D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacd8617-db1e-4287-5e9e-08da563b150d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 23:41:38.1978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRdAPMFtK/cjLjh3ff/f8gojByozZ0h+hGBuCjd13ZxVHYB076ofWLFlmkQNQ6MApGdlrhK+oBTA5Ub05qbmGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2645
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVwbHlpbmcgdG8gdGhpcyAobm90IHRoZSBsYXRlc3Qgb25lKSB0byByZWR1Y2UgdGhlIHF1b3Rp
bmcgbGV2ZWxzLCBhZGRpbmcgSmlld2VuLg0KDQoNCj4gT24gSnVuIDIwLCAyMDIyLCBhdCA4OjQ0
IEFNLCBTYXRoeWFuYXJheWFuYW4gS3VwcHVzd2FteSA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dh
bXlAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IEhpLA0KPiANCj4gKyBKdW4NCj4gDQo+
IE9uIDYvMjAvMjIgNTozMyBBTSwgS2FpIEh1YW5nIHdyb3RlOg0KPj4gT24gV2VkLCAyMDIyLTA2
LTA4IGF0IDE5OjUyIC0wNzAwLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5hbiB3cm90ZToNCj4+
PiBIb3N0LWd1ZXN0IGV2ZW50IG5vdGlmaWNhdGlvbiB2aWEgY29uZmlndXJlZCBpbnRlcnJ1cHQg
dmVjdG9yIGlzIHVzZWZ1bA0KPj4+IGluIGNhc2VzIHdoZXJlIGEgZ3Vlc3QgbWFrZXMgYW4gYXN5
bmNocm9ub3VzIHJlcXVlc3QgYW5kIG5lZWRzIGENCj4+PiBjYWxsYmFjayBmcm9tIHRoZSBob3N0
IHRvIGluZGljYXRlIHRoZSBjb21wbGV0aW9uIG9yIHRvIGxldCB0aGUgaG9zdA0KPj4+IG5vdGlm
eSB0aGUgZ3Vlc3QgYWJvdXQgZXZlbnRzIGxpa2UgZGV2aWNlIHJlbW92YWwuIE9uZSB1c2FnZSBl
eGFtcGxlIGlzLA0KPj4+IGNhbGxiYWNrIHJlcXVpcmVtZW50IG9mIEdldFF1b3RlIGFzeW5jaHJv
bm91cyBoeXBlcmNhbGwuDQo+PiANCj4+IEFsdGhvdWdoIHRoaXMgcGFyYWdyYXBoIGlzIGZyb20g
R0hDSSBzcGVjLCBJTUhPIGl0IGlzIG5vdCB2ZXJ5IGhlbHBmdWwuICBJbg0KPj4gZmFjdCwgSSB0
aGluayB0aGlzIHBhcmFncmFwaCBpcyBub3QgdGhhdCByaWdodCBhbmQgc2hvdWxkIGJlIHJlbW92
ZWQgZnJvbSBHSENJLg0KPj4gVGhlIHJlYXNvbiBpcyBzdWNoIGV2ZW50IG5vdGlmaWNhdGlvbiBm
cm9tIFZNTSBpbiBjYXNlcyBsaWtlICJkZXZpY2UgcmVtb3ZhbCIgaXMNCj4+IHRvbyB2YWd1ZS4g
IFRoZXJlJ3Mgbm8gX3NwZWNpZmljYXRpb25fIGluIEdIQ0kgYXJvdW5kIHdoaWNoICJkZXZpY2Ug
cmVtb3ZhbCINCj4+IHNob3VsZCBWTU0gaW5qZWN0IHN1Y2ggZXZlbnQuICBGb3IgaW5zdGFuY2Us
IEkgX3RoaW5rXyB0aGUgUWVtdSBlbnVtZXJhdGVkIEFDUEktDQo+PiBiYXNlZCBob3RwbHVnIHNo
b3VsZCBjb250aW51ZSB0byB3b3JrIGluIFRELg0KPiANCj4gWWVzLiBJdCBqdXN0IHNheXMgdGhh
dCBpdCAqY2FuKiBiZSB1c2VkIHRvIHNpZ25hbCBhIGRldmljZSByZW1vdmFsLiBJdCBpcyBqdXN0
DQo+IGFuIGV4YW1wbGUgZm9yIHdoZXJlIGl0IGNhbiBiZSB1c2VkLiBCdXQgSSBhZ3JlZSB0aGF0
IHN1Y2ggYSB1c2UgY2FzZSBpcyB2YWd1ZS4NCj4gSWYgaXQgbWFrZXMgaXQgYmV0dGVyLCBJIGFt
IGZpbmUgd2l0aCByZW1vdmluZyBpdC4NCg0KWWVzLCB0aGUg4oCcZGV2aWNlIHJlbW92YWzigJ0g
aXMganVzdCBhbiBleGFtcGxlLCBlc3BlY2lhbGx5LCAidGhlIFREIE9TIHNob3VsZCBiZSBkZXNp
Z25lZCB0byBub3QgdXNlIHRoZSBldmVudCBub3RpZmljYXRpb24gZm9yIHRydXN0ZWQgb3BlcmF0
aW9uc+KAnSwgYmFzZWQgb24gdGhlIGNvbnRleHQgb2YgdGhlIHNwZWMuIA0KDQo+PiANCj4+PiAN
Cj4+PiBSZXNlcnZlIDB4ZWMgSVJRIHZlY3RvciBhZGRyZXNzIGZvciBURFggZ3Vlc3QgdG8gcmVj
ZWl2ZSB0aGUgZXZlbnQNCj4+PiBjb21wbGV0aW9uIG5vdGlmaWNhdGlvbiBmcm9tIFZNTS4gQWxz
byBhZGQgcmVsYXRlZCBJRFQgaGFuZGxlciB0bw0KPj4+IHByb2Nlc3MgdGhlIG5vdGlmaWNhdGlv
biBldmVudC4NCj4+IA0KPj4gSGVyZSBsYWNrcyB3aHkgd2UgbmVlZCB0byBjaG9vc2UgdG8gcmVz
ZXJ2ZSBhIHN5c3RlbSB2ZWN0b3IuICBGb3IgaW5zdGFuY2UsIHdoeQ0KPj4gd2UgY2Fubm90IGNo
b29zZSB0byB1c2UgZGV2aWNlIElSUSB3YXkgd2hpY2ggb25seSByZXF1aXJlcyBvbmUgdmVjdG9y
IG9uIG9uZQ0KPiANCj4gQXMgeW91IGhhdmUgZXhwbGFpbmVkIGJlbG93LCBhcyBwZXIgY3VycmVu
dCBzcGVjLCBpdCBqdXN0IGV4cGVjdHMgYSBzeXN0ZW0NCj4gdmVjdG9yLg0KPiANCj4+IGNwdS4g
IEFzIHlvdSBjYW4gc2VlIHJlc2VydmluZyBhIHN5c3RlbSB2ZWN0b3IgaXNuJ3QgaWRlYWwgZXNw
ZWNpYWxseSBmb3INCj4+IGF0dGVzdGF0aW9uIGFzIGl0IGlzIG5vdCBhIGZyZXF1ZW50IG9wZXJh
dGlvbi4gIEl0IGlzIHdhc3RlZnVsIG9mIHVzaW5nIElSUQ0KPiANCj4gSSBhZ3JlZSB0aGF0IGV2
ZW50IG5vdGlmaWNhdGlvbiBpcyBjdXJyZW50bHkgb25seSB1c2VkIGZvciBhdHRlc3RhdGlvbi4g
QnV0IEkNCj4gdGhpbmsgaW4gZnV0dXJlIHRoZXJlIGNvdWxkIGJlIG90aGVyIHVzZSBjYXNlcyBm
b3IgaXQuIElmIHRoZSBpbnRlbnRpb24gaXMganVzdA0KPiB0byB1c2UgaXQgZm9yIGF0dGVzdGF0
aW9uLCB0aGVuIHdlIGNhbiBqdXN0IG1vZGlmeSB0aGUgR2V0UXVvdGUgVERWTUNBTEwgdG8gcGFz
cw0KPiB0aGUgdmVjdG9yIGFkZHJlc3MsIGFuZCB0aGVyZSBpcyBubyBuZWVkIGZvciBuZXcgVERW
TUNBTEwuIEkgdGhpbmsgdGhlIGludGVudGlvbg0KPiBoZXJlIGlzIHRvIGhhdmUgZ2VuZXJpYyBt
ZXRob2QgZm9yIFZNTSB0byBub3RpZnkgVEQgYWJvdXQgc29tZSBldmVudHMuIEkgYW0gbm90DQo+
IGNsZWFyIGFib3V0IHRoZSBwb3NzaWJsZSBmdXR1cmUgdXNlIGNhc2VzLCBzbyBJIGNhbm5vdCBj
b21tZW50IG9uIGZyZXF1ZW5jeSBvZg0KPiBpdHMgdXNlLg0KPiANCj4gSnVuLCBhbnkgY29tbWVu
dHM/DQo+IA0KDQpUaGUgR0hDSSBzcGVjIHdhcyBub3QganVzdCBjbGVhciwgYW5kIHdl4oCZbGwg
dXBkYXRlIHRoZSBzcGVjLCBmb3IgZXhhbXBsZToNCg0KMy41IFRERy5WUC5WTUNBTEw8U2V0dXBF
dmVudE5vdGlmeUludGVycnVwdD4gDQouLi4NCkZyb206DQoNCuKAnFRoZSBob3N0IFZNTSBzaG91
bGQgdXNlIFNFQU1DQUxMIFtURFdSVlBTXSBsZWFmIHRvIGluamVjdCBhbiBpbnRlcnJ1cHQgYXQg
dGhlIHJlcXVlc3RlZC1pbnRlcnJ1cHQgdmVjdG9yIGludG8gdGhlIFREIHZpYSB0aGUgcG9zdGVk
LWludGVycnVwdCBkZXNjcmlwdG9yLiDigJwNCiANClRvOg0KDQrigJxUaGUgaG9zdCBWTU0gc2hv
dWxkIHVzZSBTRUFNQ0FMTCBbVERXUlZQU10gbGVhZiB0byBpbmplY3QgYW4gaW50ZXJydXB0IGF0
IHRoZSByZXF1ZXN0ZWQtaW50ZXJydXB0IHZlY3RvciBpbnRvIHRoZSBURCBWQ1BVIHRoYXQgZXhl
Y3V0ZWQgVERHLlZQLlZNQ0FMTCA8U2V0dXBFdmVudE5vdGlmeUludGVycnVwdD4sIHZpYSB0aGUg
cG9zdGVkLWludGVycnVwdCBkZXNjcmlwdG9yLiDigJwNCg0KLS0tDQpKdW4NCg0K
