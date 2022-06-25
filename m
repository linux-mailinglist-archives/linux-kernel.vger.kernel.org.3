Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4F355A69B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 05:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiFYDfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 23:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiFYDfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 23:35:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CEB3ED20
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 20:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656128130; x=1687664130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a38Y5WuXwD/1FV7d6p5SGTJuxnGhsaIFDf77JdWApsE=;
  b=ZyfezVEOtLTGtbyyTDvdMXFMrf3856Qpt1V7hT8xBum2O1HXfB26yGyY
   TixSHM52V2NLxOF1ATeU8oUmcS88kMHQqysl5XqBKLXUGcjB6NA0CeGSW
   Yd4ytbiTbZqLrtvkeaPgiWAHgymFUaiWjZ9a7jQjfWfTHvlNoJLLOfIqw
   wrO44l3u/msoaSKWlSP5xmnTxe6a6CuvPIhgguX5/xbuZdYmeNPVZU/sg
   FTDn66YrvSviYcM0DiL/sY9lctVpsN9dYqwss1WwY6qgd2Th91t6D1eYj
   GZhxbSaiVoug8/sAnKwULzPKNLrGonWP3dI5XLgHDuuX5LNQLZbawvdG4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="278688129"
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="278688129"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 20:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,221,1650956400"; 
   d="scan'208";a="731562219"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jun 2022 20:35:30 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 24 Jun 2022 20:35:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 24 Jun 2022 20:35:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 24 Jun 2022 20:35:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 24 Jun 2022 20:35:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myCdbQWFkRlile35Z98c+BEtD0ky8gRS3/Hd7qdp6Mo0jnsvqOiIN24PsIELUuWlD841pWKf8rPVqAA5Ah8a8+4YRB+DKNbVQApZmo9WAz57zlHQf6k0lE5xx5kYalgQaEK6urKFNcWm5ijHZadeMRBA7rSy41MYqy18WnGG4fswozA1rw68eEsubsiQNUhyjvD3YRctzXtPjR7UUkpCqytSQlnWoUoHj2B3TYntqWuql3MQfuNyG+F7DPkn1htauPuoPKlJ3/BLJvcqo2llFIPZ2yC//BAoyrcQSoynvkMCCRMK7d1rPsZxhEry3bEX+I5pqGDuK0IUmh0IOw0mKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a38Y5WuXwD/1FV7d6p5SGTJuxnGhsaIFDf77JdWApsE=;
 b=GT3EXArDTsu4szphIhOcENQO0zXUjY9FTMPMVVUeslEjPALYmqcURzBeD6koVYcLD0Gmc2f9tlPfwonAZ6Ilc445+hbJZBOHjsG/VQeJ2UNPGwIqNzIOL+07tqnBRNgCdjDacl+Hj5JyvkFJSn0YxU4X1VMmpjLZSWugWcCYywQ48s42iMLHBtErglDOsdE9JQcOtDHSOBcCtAys8Im+sgnK4Y4KGfGbTUS6ye3hUJkxUCU6ZesRK0dyqlvWKjKpw7t0TG13+rg8cZI0KZY48vYSEq6lOQrrHJcvDXwEtNNz9AIUwL1+Fw9odBsXGJ8K0rhWMPo/+x7mMQkQG6OzqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14)
 by BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Sat, 25 Jun
 2022 03:35:27 +0000
Received: from MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::24ae:1cd3:3192:4c7e]) by MW4PR11MB5872.namprd11.prod.outlook.com
 ([fe80::24ae:1cd3:3192:4c7e%6]) with mapi id 15.20.5373.017; Sat, 25 Jun 2022
 03:35:27 +0000
From:   "Yao, Jiewen" <jiewen.yao@intel.com>
To:     "Nakajima, Jun" <jun.nakajima@intel.com>,
        Sathyanarayanan Kuppuswamy 
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
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 2/5] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Topic: [PATCH v8 2/5] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Index: AQHYiCPy5ieOLNrPTUCf7ntf50MKCK1fd09A
Date:   Sat, 25 Jun 2022 03:35:27 +0000
Message-ID: <MW4PR11MB5872E3B775A680678331D6358CB79@MW4PR11MB5872.namprd11.prod.outlook.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <78873cc1db47ba00a4c01f38290521c1a6072820.camel@intel.com>
 <efb2cdab-289b-8757-fe5e-5348519b0474@linux.intel.com>
 <385B219C-4DB2-480C-913C-411AB4D644ED@intel.com>
In-Reply-To: <385B219C-4DB2-480C-913C-411AB4D644ED@intel.com>
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
x-ms-office365-filtering-correlation-id: 1a3df582-dd47-477d-b5c0-08da565bbeee
x-ms-traffictypediagnostic: BYAPR11MB2869:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oWNTFbPZInrSMZU/qWkNTcE20TH3xth+HAP3mC3yrFu+a8c05hj8q5JsJ90S38M/3rRtjnmhGskCarIinJIMOG6ONN9VIOQtTYGdJrQiun/0FqqT+m4xCvQQR1o/ht59LACizqkUK6QAnOqZg090yq12eYeqeYwmBVonAMHCca6L6cnaQ5LyJXtJsUplPLQWQ7T7P+IHy6L/GU4P4i54OrTC4nH6ON6OO0g79YUyjLXkvq49R47DYGNPVTGJXaEQ/l37DZRL2tmi0rZaeRC0b33LIZmmbTtJqVqJbsW4n2Zb/gtLbyVlN4Ox4C4v4uPzPvLeC0KeC8HcI2mKA5EE1SNPo4A5hns1Pqml0fpQ2mGu8QD2NgWPgglEJAC7OxfSzOIgWaawkQ5N/eydXTncU9SqGJaM0EzDsL/ZVpcY3Fi4yYZZv2z1eMUb3MdYcWtc+x0NJjf6IcZP3pksndZw+sSugYPDFPbMyv1U30nNk6IjcPwbuJUUZemyKhSUyrYomI8BBmdgFTpe9PulbDZNaL2V+faN9vFvXLZQQgFcLrSIl3NzHyuITKOOaZNL1vEJfDiHrvG9rqh0r0YIjqKRslTngJQRJBmHGqKhrKhJaWpCOq5/Mwzd+jiv9RvhVBFM4vgtbED3FVUCBXvHY4RqipegYfxRYv8se/xu+y8eJi/sPK3u2PE+JSMk1rNI+OzZh9lXveZFb/Kx9iMvr44OwgYgkC2CLCpnaTykkzVayHcIxoRG+HJn13zl1jbOfsNRivT64KQd0rPs7YojEaVmFzaZDtgIWcDNBbWtGwji+kw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5872.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(366004)(39860400002)(396003)(66946007)(7416002)(2906002)(82960400001)(122000001)(66476007)(86362001)(38070700005)(83380400001)(478600001)(4326008)(66556008)(33656002)(5660300002)(8676002)(53546011)(7696005)(38100700002)(52536014)(71200400001)(26005)(9686003)(6506007)(8936002)(64756008)(55016003)(186003)(66446008)(316002)(110136005)(54906003)(76116006)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWp6Z0dtOEt4a1daNFVUZ0ZjUjVXVmlBN1VaRkxKbi9kQnBtK3ZTY3Q1UVBF?=
 =?utf-8?B?RFAwY25RczZUZ1RJNDQ2QmRqUHNvYmFaa2t3VUtIN2tQNW5XRmRkdXByUU80?=
 =?utf-8?B?YUU4OEw3c05za1NRSzhFQk03Sk1oN05rUEFUVkpQY1FLM2pyQnFUTnNuSzZC?=
 =?utf-8?B?QnFRY0VMejQrbURlWS92OGwvRVlrQUpmb1dnVVpHdkQ0TXFsTjU1VDBwWEVF?=
 =?utf-8?B?Wk9lMlNqZkM2c2drd09Ub0ZVU0Q0L1R1MThIMEkwa0Y1VUgyN1d2S1lWMHFm?=
 =?utf-8?B?ckhOcUR0VU50VldGMDlBRlI5RGJqYjF0NzI4ZlN0WFR2M0ZmUGNPQmlnU1V2?=
 =?utf-8?B?R2VYQVRRQ2xDcEs2SGdaajRyTk90ZW04ZHM3T2RJN2ZKYkNPMER5ZnJ5K0pN?=
 =?utf-8?B?eHNQTi9qcFlkeVI4Rk1iWitQTEdjZk1Hc2lsQUVjZ0FoWEdlOU1WL2h1RFJk?=
 =?utf-8?B?dGFLU0VvdXlJL1VJUlN1Z0V4N2JLY21LSUV4cEtQT3Uza3dUTXEzTzZ0WS9u?=
 =?utf-8?B?MkdFb2FhK0dmTTMrMWZOblp6cUFjbkZIM0d0M1FiRGE4aTh5QnRFbU13VlBH?=
 =?utf-8?B?Mm4rNWl2bXpEbXhLU3pmNjlzK05kY094b0g2b29uU3RPanYrRFBwaXNNUS8z?=
 =?utf-8?B?TEJGRUEvSTV0bTRnUFUwVzBzZG9aeXQrYThHUDFiYlc3bkswQ2ZaMXpudlJZ?=
 =?utf-8?B?WDkzUGcyQURGWVR2T3JZSm53a1lOYUlIVCtjWi9kc000cGFlemljTFNDMnZw?=
 =?utf-8?B?UEZGei80L2xRVXQzbEZEM0ZYMitCNTJ0U2dITkd1V3Q1Z2lQTG9zVEZhbTl1?=
 =?utf-8?B?L1E2VkNQeUhaME9acHM3NXdJRHVqekRFSXE1UFFwSHRReWNYUkhRUmMrWTQ4?=
 =?utf-8?B?cFk0UURzU1FGS1F0SjdZMUV1OEgveVNaY24zQ25uRzVyd2lxRXdHb3FFeWkx?=
 =?utf-8?B?SzVaNWZkMmt0eEhNTTM5MHJncFpKdHNLb1RKNFBYbVpqYlVncnFTUDRwK3dX?=
 =?utf-8?B?K3lQMUx6d1BQUi9nTG5odFZyMnBzOStoZng2c1BUT0hvazNoVVJNWEt4Zksr?=
 =?utf-8?B?ekhxMnd6NWZnWmdORzNtdHRLRTVtc1FONjZjVHVYblRmMjJST25TL25VdzY4?=
 =?utf-8?B?UXJiSGlic3c3VUl3TEZEeENUaHg3VHN4YUVkWkU5ZzA2Z2QrNVBaL2NwZnlP?=
 =?utf-8?B?QWI0R1g2a0hrSVBrSEVRd0x0c1JzYWJTZWdsK2FJTGZLWlN3ZVpoeHdsSkZZ?=
 =?utf-8?B?RGdwbk15VjhXdGJqY1ltSTMwQkxTdkNpS0RCNzVTUnBDbVZ4SStxb1B1ajc3?=
 =?utf-8?B?NWw2Q0grM0lZT2U2cFRaTmVZbTJxWmgyQXdNOVd6QTZOR29uelZWNWNhZjlk?=
 =?utf-8?B?YllaVUJ4cUhEVWNGenNjWE1wREJTaU9scE10bVA0dEIxMUVGejhEL2pUNU5S?=
 =?utf-8?B?R1krMHR1cmo5UXllVkRwTTNVVmwwSmVzdzdUaTkzVTh1QXB4Zy9zUHlXcTNh?=
 =?utf-8?B?dzZkamNUb1VSSlBTWXBPTVhtem5acVVxTjVlWDdHUnNvVXE1aVdheDJ5cURm?=
 =?utf-8?B?OWxrMG8zU1hKNnlCbFdub0kzNzB2K2pWR3VnbUN0K3BqZ0xQNVlwYmxzbW9H?=
 =?utf-8?B?OVhzTDgyb0l0aWhsWllyZlZxZk0rbGVpOWxJZTJ5RDNXcTgzelA3ZWhxWTN5?=
 =?utf-8?B?RDBaQmJMSFdqM05acktBdWk4SUw4cXB3OXBtUktQMmJOYVZmM2lTdzdtVjZG?=
 =?utf-8?B?TXowRUllOFhQYkNFdWJ1dFFGQmtXUFEycVdub2pXa3laejBlVkVSU2NuaXEw?=
 =?utf-8?B?eU1tS1U5aGxxbTFLSzRzN1Z5TTNvYndJc25pRDB1VjVmOU8vOWprRFlsemV1?=
 =?utf-8?B?OTZFdnhwV20ycjZma2FleEJjSkxQcW5qd2cwSEVyYTRXUlJJdUdZclRmWXcz?=
 =?utf-8?B?Nnp0NXVCaXc5bjJCdW43dlkxdWZrYUNKelNPT0o3R2FQWm9JZ29hYU9FRFNK?=
 =?utf-8?B?MENQb1ppMnlNNHVFNVRhc2l1NnJZbFNYSzV1dkZYK3RNS1dUWUp4SVUzZTln?=
 =?utf-8?B?QzZmNGROS1JxOG9zMmtEcHc5eGJDOWp3alRuQnVLQjcrdUxmcklzUlZtU05s?=
 =?utf-8?Q?f53hUsC1q9QnZ6zmFGyj5Y46f?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3df582-dd47-477d-b5c0-08da565bbeee
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2022 03:35:27.1361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCeiMOABalHLdtx82wMlqsMKwE761hJjJo/ubAMJ+DPfYQsVcrLfubELnYoxgsG+EG+nLSEZSJB3gGJD9yvBjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2869
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

VGhhbmsgeW91LCBKdW4uDQoNClllcy4gSSBjb25maXJtZWQgdGhhdCB3ZSB3aWxsIGluY2x1ZGUg
YmVsb3cgY2hhbmdlIHRvIEdIQ0kubmV4dCBzcGVjLg0KDQo9PT09PT09PT09PT09PT09DQozLjUg
VERHLlZQLlZNQ0FMTDxTZXR1cEV2ZW50Tm90aWZ5SW50ZXJydXB0Pg0KDQpGcm9tOiAiVGhlIGhv
c3QgVk1NIHNob3VsZCB1c2UgU0VBTUNBTEwgW1REV1JWUFNdIGxlYWYgdG8gaW5qZWN0IGFuIGlu
dGVycnVwdCBhdCB0aGUgcmVxdWVzdGVkLWludGVycnVwdCB2ZWN0b3IgaW50byB0aGUgVEQgdmlh
IHRoZSBwb3N0ZWQtaW50ZXJydXB0IGRlc2NyaXB0b3IuICINCg0KVG86ICJUaGUgaG9zdCBWTU0g
c2hvdWxkIHVzZSBTRUFNQ0FMTCBbVERXUlZQU10gbGVhZiB0byBpbmplY3QgYW4gaW50ZXJydXB0
IGF0IHRoZSByZXF1ZXN0ZWQtaW50ZXJydXB0IHZlY3RvciBpbnRvIHRoZSBURCBWQ1BVIHRoYXQg
ZXhlY3V0ZWQgVERHLlZQLlZNQ0FMTCA8U2V0dXBFdmVudE5vdGlmeUludGVycnVwdD4gdmlhIHRo
ZSBwb3N0ZWQtaW50ZXJydXB0IGRlc2NyaXB0b3IuICINCg0KMy4xMyBUREcuVlAuVk1DQUxMPFNl
cnZpY2U+DQoNClRhYmxlIDMtMzk6IFRERy5WUC5WTUNBTEw8IFNlcnZpY2UgPi1JbnB1dCBPcGVy
YW5kcw0KDQpGcm9tOiBSMTQ6IA0KIkV2ZW50IG5vdGlmaWNhdGlvbiBpbnRlcnJ1cHQgdmVjdG9y
IC0gKHZhbGlkIHZhbHVlcyAzMn4yNTUpIHNlbGVjdGVkIGJ5IFREDQowOiBibG9ja2luZyBhY3Rp
b24uIFZNTSBuZWVkIGdldCByZXNwb25zZSB0aGVuIHJldHVybi4NCjF+MzE6IFJlc2VydmVkLiBT
aG91bGQgbm90IGJlIHVzZWQuDQozMn4yNTU6IE5vbi1ibG9jayBhY3Rpb24uIFZNTSBjYW4gcmV0
dXJuIGltbWVkaWF0ZWx5IGFuZCBzaWduYWwgdGhlIGludGVycnVwdCB2ZWN0b3Igd2hlbiB0aGUg
cmVzcG9uc2UgaXMgcmVhZHkuICINCg0KVG86IFIxNDoNCiJFdmVudCBub3RpZmljYXRpb24gaW50
ZXJydXB0IHZlY3RvciAtICh2YWxpZCB2YWx1ZXMgMzJ+MjU1KSBzZWxlY3RlZCBieSBURA0KMDog
YmxvY2tpbmcgYWN0aW9uLiBWTU0gbmVlZCBnZXQgcmVzcG9uc2UgdGhlbiByZXR1cm4uDQoxfjMx
OiBSZXNlcnZlZC4gU2hvdWxkIG5vdCBiZSB1c2VkLg0KMzJ+MjU1OiBOb24tYmxvY2sgYWN0aW9u
LiBWTU0gY2FuIHJldHVybiBpbW1lZGlhdGVseSBhbmQgc2lnbmFsIHRoZSBpbnRlcnJ1cHQgdmVj
dG9yIHdoZW4gdGhlIHJlc3BvbnNlIGlzIHJlYWR5LiBWTU0gc2hvdWxkIGluamVjdCBpbnRlcnJ1
cHQgdmVjdG9yIGludG8gdGhlIFREIFZDUFUgdGhhdCBleGVjdXRlZCBUREcuVlAuVk1DQUxMPFNl
cnZpY2U+LiINCg0KPT09PT09PT09PT09PT09PQ0KDQpUaGFuayB5b3UNCllhbyBKaWV3ZW4NCg0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5ha2FqaW1hLCBKdW4gPGp1
bi5uYWthamltYUBpbnRlbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKdW5lIDI1LCAyMDIyIDc6
NDIgQU0NCj4gVG86IFNhdGh5YW5hcmF5YW5hbiBLdXBwdXN3YW15DQo+IDxzYXRoeWFuYXJheWFu
YW4ua3VwcHVzd2FteUBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBIdWFuZywgS2FpIDxrYWkuaHVh
bmdAaW50ZWwuY29tPjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+Ow0KPiBJ
bmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44
LmRlPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT47IHg4NkBr
ZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6eXRvci5jb20+OyBLaXJpbGwgQSAu
IFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPjsgTHVjaywNCj4gVG9u
eSA8dG9ueS5sdWNrQGludGVsLmNvbT47IEFuZGkgS2xlZW4gPGFrQGxpbnV4LmludGVsLmNvbT47
IFdhbmRlciBMYWlyc29uDQo+IENvc3RhIDx3YW5kZXJAcmVkaGF0LmNvbT47IElzYWt1IFlhbWFo
YXRhIDxpc2FrdS55YW1haGF0YUBnbWFpbC5jb20+Ow0KPiBtYXJjZWxvLmNlcnJpQGNhbm9uaWNh
bC5jb207IHRpbS5nYXJkbmVyQGNhbm9uaWNhbC5jb207DQo+IGtoYWxpZC5lbG1vdXNseUBjYW5v
bmljYWwuY29tOyBDb3gsIFBoaWxpcCA8cGhpbGlwLmNveEBjYW5vbmljYWwuY29tPjsgTEtNTA0K
PiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFlhbywgSmlld2VuIDxqaWV3ZW4ueWFv
QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCAyLzVdIHg4Ni90ZHg6IEFkZCBU
RFggR3Vlc3QgZXZlbnQgbm90aWZ5IGludGVycnVwdA0KPiBzdXBwb3J0DQo+IA0KPiBSZXBseWlu
ZyB0byB0aGlzIChub3QgdGhlIGxhdGVzdCBvbmUpIHRvIHJlZHVjZSB0aGUgcXVvdGluZyBsZXZl
bHMsIGFkZGluZyBKaWV3ZW4uDQo+IA0KPiANCj4gPiBPbiBKdW4gMjAsIDIwMjIsIGF0IDg6NDQg
QU0sIFNhdGh5YW5hcmF5YW5hbiBLdXBwdXN3YW15DQo+IDxzYXRoeWFuYXJheWFuYW4ua3VwcHVz
d2FteUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGksDQo+ID4NCj4gPiArIEp1
bg0KPiA+DQo+ID4gT24gNi8yMC8yMiA1OjMzIEFNLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4+IE9u
IFdlZCwgMjAyMi0wNi0wOCBhdCAxOTo1MiAtMDcwMCwgS3VwcHVzd2FteSBTYXRoeWFuYXJheWFu
YW4gd3JvdGU6DQo+ID4+PiBIb3N0LWd1ZXN0IGV2ZW50IG5vdGlmaWNhdGlvbiB2aWEgY29uZmln
dXJlZCBpbnRlcnJ1cHQgdmVjdG9yIGlzIHVzZWZ1bA0KPiA+Pj4gaW4gY2FzZXMgd2hlcmUgYSBn
dWVzdCBtYWtlcyBhbiBhc3luY2hyb25vdXMgcmVxdWVzdCBhbmQgbmVlZHMgYQ0KPiA+Pj4gY2Fs
bGJhY2sgZnJvbSB0aGUgaG9zdCB0byBpbmRpY2F0ZSB0aGUgY29tcGxldGlvbiBvciB0byBsZXQg
dGhlIGhvc3QNCj4gPj4+IG5vdGlmeSB0aGUgZ3Vlc3QgYWJvdXQgZXZlbnRzIGxpa2UgZGV2aWNl
IHJlbW92YWwuIE9uZSB1c2FnZSBleGFtcGxlIGlzLA0KPiA+Pj4gY2FsbGJhY2sgcmVxdWlyZW1l
bnQgb2YgR2V0UXVvdGUgYXN5bmNocm9ub3VzIGh5cGVyY2FsbC4NCj4gPj4NCj4gPj4gQWx0aG91
Z2ggdGhpcyBwYXJhZ3JhcGggaXMgZnJvbSBHSENJIHNwZWMsIElNSE8gaXQgaXMgbm90IHZlcnkg
aGVscGZ1bC4gIEluDQo+ID4+IGZhY3QsIEkgdGhpbmsgdGhpcyBwYXJhZ3JhcGggaXMgbm90IHRo
YXQgcmlnaHQgYW5kIHNob3VsZCBiZSByZW1vdmVkIGZyb20gR0hDSS4NCj4gPj4gVGhlIHJlYXNv
biBpcyBzdWNoIGV2ZW50IG5vdGlmaWNhdGlvbiBmcm9tIFZNTSBpbiBjYXNlcyBsaWtlICJkZXZp
Y2UNCj4gcmVtb3ZhbCIgaXMNCj4gPj4gdG9vIHZhZ3VlLiAgVGhlcmUncyBubyBfc3BlY2lmaWNh
dGlvbl8gaW4gR0hDSSBhcm91bmQgd2hpY2ggImRldmljZQ0KPiByZW1vdmFsIg0KPiA+PiBzaG91
bGQgVk1NIGluamVjdCBzdWNoIGV2ZW50LiAgRm9yIGluc3RhbmNlLCBJIF90aGlua18gdGhlIFFl
bXUgZW51bWVyYXRlZA0KPiBBQ1BJLQ0KPiA+PiBiYXNlZCBob3RwbHVnIHNob3VsZCBjb250aW51
ZSB0byB3b3JrIGluIFRELg0KPiA+DQo+ID4gWWVzLiBJdCBqdXN0IHNheXMgdGhhdCBpdCAqY2Fu
KiBiZSB1c2VkIHRvIHNpZ25hbCBhIGRldmljZSByZW1vdmFsLiBJdCBpcyBqdXN0DQo+ID4gYW4g
ZXhhbXBsZSBmb3Igd2hlcmUgaXQgY2FuIGJlIHVzZWQuIEJ1dCBJIGFncmVlIHRoYXQgc3VjaCBh
IHVzZSBjYXNlIGlzIHZhZ3VlLg0KPiA+IElmIGl0IG1ha2VzIGl0IGJldHRlciwgSSBhbSBmaW5l
IHdpdGggcmVtb3ZpbmcgaXQuDQo+IA0KPiBZZXMsIHRoZSDigJxkZXZpY2UgcmVtb3ZhbOKAnSBp
cyBqdXN0IGFuIGV4YW1wbGUsIGVzcGVjaWFsbHksICJ0aGUgVEQgT1Mgc2hvdWxkIGJlDQo+IGRl
c2lnbmVkIHRvIG5vdCB1c2UgdGhlIGV2ZW50IG5vdGlmaWNhdGlvbiBmb3IgdHJ1c3RlZCBvcGVy
YXRpb25z4oCdLCBiYXNlZCBvbiB0aGUNCj4gY29udGV4dCBvZiB0aGUgc3BlYy4NCj4gDQo+ID4+
DQo+ID4+Pg0KPiA+Pj4gUmVzZXJ2ZSAweGVjIElSUSB2ZWN0b3IgYWRkcmVzcyBmb3IgVERYIGd1
ZXN0IHRvIHJlY2VpdmUgdGhlIGV2ZW50DQo+ID4+PiBjb21wbGV0aW9uIG5vdGlmaWNhdGlvbiBm
cm9tIFZNTS4gQWxzbyBhZGQgcmVsYXRlZCBJRFQgaGFuZGxlciB0bw0KPiA+Pj4gcHJvY2VzcyB0
aGUgbm90aWZpY2F0aW9uIGV2ZW50Lg0KPiA+Pg0KPiA+PiBIZXJlIGxhY2tzIHdoeSB3ZSBuZWVk
IHRvIGNob29zZSB0byByZXNlcnZlIGEgc3lzdGVtIHZlY3Rvci4gIEZvciBpbnN0YW5jZSwNCj4g
d2h5DQo+ID4+IHdlIGNhbm5vdCBjaG9vc2UgdG8gdXNlIGRldmljZSBJUlEgd2F5IHdoaWNoIG9u
bHkgcmVxdWlyZXMgb25lIHZlY3RvciBvbg0KPiBvbmUNCj4gPg0KPiA+IEFzIHlvdSBoYXZlIGV4
cGxhaW5lZCBiZWxvdywgYXMgcGVyIGN1cnJlbnQgc3BlYywgaXQganVzdCBleHBlY3RzIGEgc3lz
dGVtDQo+ID4gdmVjdG9yLg0KPiA+DQo+ID4+IGNwdS4gIEFzIHlvdSBjYW4gc2VlIHJlc2Vydmlu
ZyBhIHN5c3RlbSB2ZWN0b3IgaXNuJ3QgaWRlYWwgZXNwZWNpYWxseSBmb3INCj4gPj4gYXR0ZXN0
YXRpb24gYXMgaXQgaXMgbm90IGEgZnJlcXVlbnQgb3BlcmF0aW9uLiAgSXQgaXMgd2FzdGVmdWwg
b2YgdXNpbmcgSVJRDQo+ID4NCj4gPiBJIGFncmVlIHRoYXQgZXZlbnQgbm90aWZpY2F0aW9uIGlz
IGN1cnJlbnRseSBvbmx5IHVzZWQgZm9yIGF0dGVzdGF0aW9uLiBCdXQgSQ0KPiA+IHRoaW5rIGlu
IGZ1dHVyZSB0aGVyZSBjb3VsZCBiZSBvdGhlciB1c2UgY2FzZXMgZm9yIGl0LiBJZiB0aGUgaW50
ZW50aW9uIGlzIGp1c3QNCj4gPiB0byB1c2UgaXQgZm9yIGF0dGVzdGF0aW9uLCB0aGVuIHdlIGNh
biBqdXN0IG1vZGlmeSB0aGUgR2V0UXVvdGUgVERWTUNBTEwgdG8NCj4gcGFzcw0KPiA+IHRoZSB2
ZWN0b3IgYWRkcmVzcywgYW5kIHRoZXJlIGlzIG5vIG5lZWQgZm9yIG5ldyBURFZNQ0FMTC4gSSB0
aGluayB0aGUNCj4gaW50ZW50aW9uDQo+ID4gaGVyZSBpcyB0byBoYXZlIGdlbmVyaWMgbWV0aG9k
IGZvciBWTU0gdG8gbm90aWZ5IFREIGFib3V0IHNvbWUgZXZlbnRzLiBJIGFtDQo+IG5vdA0KPiA+
IGNsZWFyIGFib3V0IHRoZSBwb3NzaWJsZSBmdXR1cmUgdXNlIGNhc2VzLCBzbyBJIGNhbm5vdCBj
b21tZW50IG9uIGZyZXF1ZW5jeQ0KPiBvZg0KPiA+IGl0cyB1c2UuDQo+ID4NCj4gPiBKdW4sIGFu
eSBjb21tZW50cz8NCj4gPg0KPiANCj4gVGhlIEdIQ0kgc3BlYyB3YXMgbm90IGp1c3QgY2xlYXIs
IGFuZCB3ZeKAmWxsIHVwZGF0ZSB0aGUgc3BlYywgZm9yIGV4YW1wbGU6DQo+IA0KPiAzLjUgVERH
LlZQLlZNQ0FMTDxTZXR1cEV2ZW50Tm90aWZ5SW50ZXJydXB0Pg0KPiAuLi4NCj4gRnJvbToNCj4g
DQo+IOKAnFRoZSBob3N0IFZNTSBzaG91bGQgdXNlIFNFQU1DQUxMIFtURFdSVlBTXSBsZWFmIHRv
IGluamVjdCBhbiBpbnRlcnJ1cHQgYXQNCj4gdGhlIHJlcXVlc3RlZC1pbnRlcnJ1cHQgdmVjdG9y
IGludG8gdGhlIFREIHZpYSB0aGUgcG9zdGVkLWludGVycnVwdCBkZXNjcmlwdG9yLiDigJwNCj4g
DQo+IFRvOg0KPiANCj4g4oCcVGhlIGhvc3QgVk1NIHNob3VsZCB1c2UgU0VBTUNBTEwgW1REV1JW
UFNdIGxlYWYgdG8gaW5qZWN0IGFuIGludGVycnVwdCBhdA0KPiB0aGUgcmVxdWVzdGVkLWludGVy
cnVwdCB2ZWN0b3IgaW50byB0aGUgVEQgVkNQVSB0aGF0IGV4ZWN1dGVkIFRERy5WUC5WTUNBTEwN
Cj4gPFNldHVwRXZlbnROb3RpZnlJbnRlcnJ1cHQ+LCB2aWEgdGhlIHBvc3RlZC1pbnRlcnJ1cHQg
ZGVzY3JpcHRvci4g4oCcDQo+IA0KPiAtLS0NCj4gSnVuDQoNCg==
