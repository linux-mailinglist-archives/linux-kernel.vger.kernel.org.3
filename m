Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E4C57C290
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiGUDJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiGUDJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:09:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB0777557;
        Wed, 20 Jul 2022 20:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658372967; x=1689908967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m35t5xe4BUp9nIztYaHPzQtUMZZ3lY9IEW+m/sB56Oo=;
  b=ItnQcqI8K844y7VybsvH+mLWlXUZgQ0x1OpGBTstm25N5oszIiS4g05h
   BQWWgOnFieW1fG+jB9ZxzP4TLhA9qpIybNrp0jL6aQny9Cj1Aa8QsQybI
   mYUwD/IwJlrS0PAEoG6SxaGyJjl2wlVGXPIjPxpM1sx8tNZAiBvIJNECb
   /tZWKgZlfzfTNviE2M8kGIpO1vkHUd8ZIcBawwXXYHBvg1O572eK8BetT
   dU2zkduux8GqpjKXHk0wcwxhUbvav36M8/u9eMJrbsfo/ViVaxGeSp2wZ
   eOvmq8OrBVAQS/vy31dS4sxvq6GEBoLVxf/vtAzcuWbaysOnaGHikZ1yA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="373238718"
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="373238718"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 20:09:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="656548471"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jul 2022 20:09:27 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 20 Jul 2022 20:09:27 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 20 Jul 2022 20:09:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 20 Jul 2022 20:09:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 20 Jul 2022 20:09:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NItAW6Ym8VHRUKW1y3BD3YDNv2tGUccSffuZPv/JOfREJ+gP/ore/QEj8LxGp4NOClqMj9N2BpIyCxvzj0TQUspBUXScqW0rp27gDFK5dWgw+9TZkICUgAvL31GsmznvccTBUouGqZZI5sdY5BOtgw2vNhyAztab40YMHhh9uRtUl/wYqZaKPbbbBby9uvH1v73KrZKcbV8mSN2NhcRwqc9ZXfOQdMi7vbhQjgpNY9PSNMbui+VRJba2C4GorqrvYtfHO/RZB8bzIG7gn6tSBmXlBjQpjVUGpblJco2CGOYyKBl53d3TNOv+Z2exAkxItJ0VkUThUXaVrvCUwvMRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m35t5xe4BUp9nIztYaHPzQtUMZZ3lY9IEW+m/sB56Oo=;
 b=ZkR8WSpHhi10X2Zh/drXk0UK55lXDzvL9fOwDwxReZaEmQ+e1O2KMRvjwqQkWQldSMICJbWB3P1fFFp4w8yQcPKCPSxDhVbG/Va8DDGCNa9UZYwsw6le88UqK7wVZoZ8TD7pdzDdOl/vOG7gqP8ChixzEBzPDFLynuEdYlLjogcFiRtu0406nuvzpzYzMZuS21cSlu2qlm3VZ8dqXjUlzZAuY6cDCGYGzYOJ4LLPIz7eFWGUiU3Bd4Fw+sXxSp0X8DPVLAGNCDiXtQW/JWWkw809BCFdeObvFHnQsbcSYzgK2aewhvbwHaH+c4vIQg7qjADf+co4zY0xUgssoFMl9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13)
 by CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 03:09:20 +0000
Received: from PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::6569:5ac:5138:1bc6]) by PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::6569:5ac:5138:1bc6%8]) with mapi id 15.20.5438.024; Thu, 21 Jul 2022
 03:09:20 +0000
From:   "Mi, Dapeng1" <dapeng1.mi@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhenyu Wang" <zhenyuw@linux.intel.com>
Subject: RE: [PATCH] cpuidle: Move cpuidle driver forward before acpi driver
 in Makefile
Thread-Topic: [PATCH] cpuidle: Move cpuidle driver forward before acpi driver
 in Makefile
Thread-Index: AQHYlpGUKmAjRm9DBkW5CrmRNbrVmq18lbSAgACLrhCACXorMIAAfRCAgAEKj7A=
Date:   Thu, 21 Jul 2022 03:09:20 +0000
Message-ID: <PH0PR11MB4824E26602680EED90B7FE2ACD919@PH0PR11MB4824.namprd11.prod.outlook.com>
References: <20220713082426.850911-1-dapeng1.mi@intel.com>
 <CAJZ5v0gsHPav5Ax6+9OMmeApqn7qdJPQmo5MMh=ba6Rtj5NnQA@mail.gmail.com>
 <PH0PR11MB4824DAE06FE50711C3252D93CD889@PH0PR11MB4824.namprd11.prod.outlook.com>
 <PH0PR11MB482497A0CC93F430DA208EDDCD8E9@PH0PR11MB4824.namprd11.prod.outlook.com>
 <CAJZ5v0j57iCNcz8i2P6JtkbiCHB1QS8M6QTngKoiJrm0pnkgUg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j57iCNcz8i2P6JtkbiCHB1QS8M6QTngKoiJrm0pnkgUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eaa28c56-1c7e-426f-cc8c-08da6ac667d2
x-ms-traffictypediagnostic: CH0PR11MB5299:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CJZ8RudNTtB+6p27wo4nwXm2AXmwAf5IIjq+w9l6B+Arf3Q7Q6p684cnWUw6RatHI5asdtHFQMNBKxkTbtrCmpmIVPe72x7LqJhfdH/ckbbEcN7FHhRpwuNL2l/ROOG0jUZcKbr0AQv3ODpkh8t1WDk3UqgA1JbYyvHPiidnIOcTlF1GcDorhurBxMUuYO3B59qqDy9d9zziVL1afFfsIbR15lSdg8HQbwXGvP64N9w1RW/e+kDv5b1lxHc1P1cSnZZS0eFVWZWsRO83NsSfm02TvhXbXDA8jmA4ULkrIbGGXVW0O78HErbV4XICoIJg4MD5YahXKdOE9rJMHZ4VUNTWxpc4msXd5QW2DvDBwtigmrCUtUXAto7ZrkvvtT4mFrGNjUMCMtXJjLNTHTBqe3ZdliDQ11MGjzOVCNXLzZHORqu6uTB61SNVuw5itap06YFrzavytL9DHTQ48P/mUNhxgi5M2GqHohnrN3Ie/Jr86i/D8p79bk8IXlT9garQmibd0JqPO3XZehMZqVlSjf59bhDhvyliVo0wXiNJEnfAPsdVehudRkidarhP1384ztLgg1kq/mqZtIoYrgeEWbI0abcaEZNbZYYt1Tc0Ho1eGeO729qr4SNHoRxECigKOi0itAx+3sSwJnQGGmPGkh1U+T2jz/+I7oSC2HXjkoNxm61WcD2FH9btutCcDXMQUi9f0QkXj/vB+ETdGugI88bh109WEY0m+ToREeUIIkYEga/l8F5NwzzyEOv+CWa3WLPoBUSubN+ELxHznJPH2iwC6md44eGzcQVpiapG2DHSkpd4ECMNeCPsO4DTPOVs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(366004)(396003)(136003)(52536014)(86362001)(186003)(478600001)(8936002)(7696005)(6506007)(53546011)(33656002)(41300700001)(122000001)(55016003)(2906002)(5660300002)(26005)(9686003)(71200400001)(38070700005)(38100700002)(82960400001)(66446008)(54906003)(6916009)(83380400001)(66476007)(316002)(66946007)(66556008)(4326008)(64756008)(8676002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2VabVlkdlZSSkJDWTJIYm1nS01uazByKythN1dUUkw3WHBjV2VVUVgwUUZx?=
 =?utf-8?B?anFOeXMrZEJJUWNxS2dUczVmQlNSNVV6Y1VPUmlLMXlzUXFNeWptbVF1Yldz?=
 =?utf-8?B?bnFHeElwWW1iWDlKT2hYdjZzQnAzekYrNlNrOEhpL3FCdzF1QzV6ZkIyZ3p3?=
 =?utf-8?B?M1RqUmtxVkNhZTR3U05XQ3A1MEFPeDB4T25jWW95S1JRTU1kQlR4cHJrWG5U?=
 =?utf-8?B?SzlnNjlMclMxS2g5c2NkMVY4QStIK2VNRXVRelMxTnpDWnNzdk5PSlllQ3lh?=
 =?utf-8?B?Z3Y5c2lrdWpqN3RkRi9rYjBCb0Q4OE43QUc0Q1FnOUk5T0M1SGRNOGVVLytZ?=
 =?utf-8?B?aTJtQzVJRXhTMW1ja21yRUc3dE5EcjBFbWFPSFVnK2ZhOXhzNjFsRWZkcEoz?=
 =?utf-8?B?WFVnbSthSVVaQnFWRXVlYTlxSmFaVW5DKy9xdS9yTWIzaHFMQXZFb1NGR2VG?=
 =?utf-8?B?Zzd1RGhUZ3hJUjBMYk94TkdMTXVPZW16Wkk0REQ0WlcyQk5oc3B2RFpoamFz?=
 =?utf-8?B?aE1VNVByQUtQanBueFQ3ejJHbXVEc0t1SWhOQmtpbUxoSEVDTmpPMi9malhZ?=
 =?utf-8?B?L1ZKRG1UVGhsRUpQcCtqaytwRUxrQ2RGY1g4MkVqN282SWJTK1VJcitFWnNK?=
 =?utf-8?B?Y29RcjhocUVHMnZvMVhxb3dPTHhkeGpXOU9XTEJ3TSthNDFmQ1NtcmFJODQy?=
 =?utf-8?B?WFUzd3lUa0ZNc3BCdVNjcGtaRHpvTnpBQ0ZsZlZGbEZEeDVCQStkdEtleWxP?=
 =?utf-8?B?Ny9hczFxeThSTThSd3NFL01vSUVHbnNENVdhSzQ4aTdzamdjMWN4aDRxZ2R5?=
 =?utf-8?B?ZVRnclB0QnRUQWxPUWtDa2hyV2VTWTZaLzFSMEVRczFWOTVUM0llSUNhdmhs?=
 =?utf-8?B?eUltU0E2dmJ2ZkNJbXhPZmZwbWNMeW9qK1daVHJ0UUNoV25qd2NqSEJRVVJK?=
 =?utf-8?B?MklEaFpGS1VISXlwbjZSSUZVeHptWW5yTkpTTklwb3RXbzhXNmlyaFhKQ1pV?=
 =?utf-8?B?Z251dE40T1RrOURlbHAySWN4TVFGZEFOeXdHTjIrSXl4SnE5bit1UU5ZeUR2?=
 =?utf-8?B?ZWl1RUVFck90cGZ1MWhkZDZpTmtMc2hyYndmVWFhSEJPLzFEM0M2SWpTTnJj?=
 =?utf-8?B?cWlqQ0QzMmFrWEhYRHBsTnQxUUZEcUtFVEI4SDFncnBIczVJTmVYemRpdzRB?=
 =?utf-8?B?S2UvQjVKRlZQZkhhay9yQkZhZWhsK2t4c29Pb1BRQnN5RjFzTUlaM2lPbjRa?=
 =?utf-8?B?QzFCTkRaNE5NRnhWd0FzL1RhSjdTR0ZDd09PdC9DT3UwMG1ka20vbTdDb1lL?=
 =?utf-8?B?STVFNzJoVHQ2anpzMlU0Y1lsNnlQeHB6bmliSDBHem92aEI4UkFldm1JbCtB?=
 =?utf-8?B?VVQzaGRmMXcyaXNYNmRQK1VoUXBnbkgrMk4zUWY1d0lZS1NPVXRFZWwxdktJ?=
 =?utf-8?B?bmUxbzBSaE9nVi9kWHNZNmw3bWZjSVloaFBLWEVYSW1JYTZ5T1BBeGV5KzRU?=
 =?utf-8?B?WkphL3djcXovZ0xZTFZ2dVRDOXE0VU5yeGtPQ2psK3JKeC9mUXZIN1FXU0xT?=
 =?utf-8?B?NEMvREduVEdLSUt3MDFuNHh2UTNjL0xDNzZtaDNNYkxrN2t0LzliN0xqNGlM?=
 =?utf-8?B?SUlzeHVEQ1BmK3ZLT2F1eUhhSjl3NHgwM282SU5EcGpYMDBtQmd2R3o0S1Er?=
 =?utf-8?B?VzFMVFcwaWNlUVliN3F2SEV1YURGcVd1d2J4eWxVZnRKOXQ5U2F1aEY1NGRZ?=
 =?utf-8?B?cEkxdVBYbW5QajUrVHE0MUZjcG5ZU0tqZ2JQQWJvQTZvUkR0WnBTT1B2bjUr?=
 =?utf-8?B?allLTlZkNjVnbnNFNTBuQnErTVJBS3RRVHU5dEhEQTdldEV4NVFCU01TQlZY?=
 =?utf-8?B?aEJCNEpuZUVBSTY4UHJtRnRQUXpETjJ5Sm8yZGRQTzRzV1Y3N05xM0FtamdM?=
 =?utf-8?B?WFZab2tJZ1l4aUw0M3FNSVhxWUJ1cWtmd1VraFVrMVExL0dHVHRSMis1MWlL?=
 =?utf-8?B?WHZUZmh6ZkZWQ2o1R3I4WWtqVElEVUhBb3JqSFlBQUVEU2xyUVNxMUY3YUI3?=
 =?utf-8?B?OWlpNjV1dytqOE13YzE2L01jVmdGdGZxQ1RHWm5OVm1zUU5Dck9ubVZvaW9a?=
 =?utf-8?Q?7n+ocDfudPcScrFxW3hZJh3hq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa28c56-1c7e-426f-cc8c-08da6ac667d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 03:09:20.3658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YqP9C5DhIG8x6rg3EXBcR69hcGCjme30MYAB+GwljUj4io+LW7x2exq+JDmx5AAHgcqUew+W2ALlVMGLPdhSMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5299
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgSnVseSAyMCwgMjAyMiA2OjI0IFBNDQo+IFRvOiBNaSwgRGFwZW5nMSA8ZGFwZW5n
MS5taUBpbnRlbC5jb20+DQo+IENjOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5v
cmc+OyBNaWNoYWVsIFMuIFRzaXJraW4NCj4gPG1zdEByZWRoYXQuY29tPjsgQXJuZCBCZXJnbWFu
biA8YXJuZEBhcm5kYi5kZT47IEJhcnQgVmFuIEFzc2NoZQ0KPiA8YnZhbmFzc2NoZUBhY20ub3Jn
PjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+OyBMaW51eCBQTSA8bGludXgtcG1Admdlci5rZXJuZWwub3JnPjsgWmhlbnl1DQo+IFdh
bmcgPHpoZW55dXdAbGludXguaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjcHVp
ZGxlOiBNb3ZlIGNwdWlkbGUgZHJpdmVyIGZvcndhcmQgYmVmb3JlIGFjcGkgZHJpdmVyDQo+IGlu
IE1ha2VmaWxlDQo+IA0KPiBPbiBXZWQsIEp1bCAyMCwgMjAyMiBhdCA1OjAwIEFNIE1pLCBEYXBl
bmcxIDxkYXBlbmcxLm1pQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiA+ID4gRnJvbTog
UmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiA+ID4gPiBTZW50OiBUaHVy
c2RheSwgSnVseSAxNCwgMjAyMiAxOjUzIEFNDQo+ID4gPiA+IFRvOiBNaSwgRGFwZW5nMSA8ZGFw
ZW5nMS5taUBpbnRlbC5jb20+DQo+ID4gPiA+IENjOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVs
QGtlcm5lbC5vcmc+OyBNaWNoYWVsIFMuIFRzaXJraW4NCj4gPiA+ID4gPG1zdEByZWRoYXQuY29t
PjsgQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT47IEJhcnQgVmFuDQo+IEFzc2NoZQ0KPiA+
ID4gPiA8YnZhbmFzc2NoZUBhY20ub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGlu
dXgtDQo+ID4gPiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBQTSA8bGludXgtcG1A
dmdlci5rZXJuZWwub3JnPg0KPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjcHVpZGxlOiBN
b3ZlIGNwdWlkbGUgZHJpdmVyIGZvcndhcmQgYmVmb3JlDQo+ID4gPiA+IGFjcGkgZHJpdmVyIGlu
IE1ha2VmaWxlDQo+ID4gPiA+DQo+ID4gPiA+IE9uIFdlZCwgSnVsIDEzLCAyMDIyIGF0IDEwOjIx
IEFNIERhcGVuZyBNaSA8ZGFwZW5nMS5taUBpbnRlbC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IEFzIGxvbmcgYXMgS2NvbmZpZyBBQ1BJX1BST0NFU1NPUiBpcyBlbmFi
bGVkLCBBQ1BJX1BST0NFU1NPUg0KPiA+ID4gPiA+IHdvdWxkIHNlbGVjdCBBQ1BJX1BST0NFU1NP
Ul9JRExFIGFuZCBhY3BpX2lkbGUgZHJpdmVyIGlzDQo+ID4gPiA+ID4gZW5hYmxlZC4gQnV0IGlu
IGN1cnJlbnQgZHJpdmVyIGxvYWRpbmcgb3JkZXIgYWNwaV9pZGxlIGRyaXZlciBpcw0KPiA+ID4g
PiA+IGFsd2F5cyBsb2FkZWQgYmVmb3JlIGNwdWlkbGVfaGFsdHBvbGwgZHJpdmVyLiBUaGlzIGxl
YWRzIHRvDQo+ID4gPiA+ID4gY3B1aWRsZV9oYXRwb2xsIGRyaXZlciBoYXMgbm8gY2hhbmNlIHRv
IGJlIGxvYWRlZCB3aGVuIGl0J3MgZW5hYmxlZC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRodXMs
IG1vdmUgY3B1aWRsZSBkcml2ZXIgZm9yd2FyZCBiZWZvcmUgYWNwaSBkcml2ZXIgYW5kIG1ha2UN
Cj4gPiA+ID4gPiBjcHVpZGxlLWhhdHBvbGwgZHJpdmVyIGhhcyBhIGNoYW5jZSB0byBiZSBydW4g
d2hlbiBpdCdzIGVuYWJsZWQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBE
YXBlbmcgTWkgPGRhcGVuZzEubWlAaW50ZWwuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+
ICBkcml2ZXJzL01ha2VmaWxlIHwgMiArLQ0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL01ha2VmaWxlIGIvZHJpdmVycy9NYWtlZmlsZSBpbmRleA0KPiA+ID4gPiA+
IDlhMzA4NDJiMjJjNS4uOTIxZWQ0ODFiNTIwIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZl
cnMvTWFrZWZpbGUNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL01ha2VmaWxlDQo+ID4gPiA+ID4g
QEAgLTI2LDYgKzI2LDcgQEAgb2JqLXkgICAgICAgICAgICAgICAgICAgICAgICAgKz0gaWRsZS8N
Cj4gPiA+ID4gPiAgIyBJUE1JIG11c3QgY29tZSBiZWZvcmUgQUNQSSBpbiBvcmRlciB0byBwcm92
aWRlIElQTUkgb3ByZWdpb24NCj4gPiA+IHN1cHBvcnQNCj4gPiA+ID4gPiAgb2JqLXkgICAgICAg
ICAgICAgICAgICAgICAgICAgICs9IGNoYXIvaXBtaS8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICtv
YmotJChDT05GSUdfQ1BVX0lETEUpICAgICAgICAgKz0gY3B1aWRsZS8NCj4gPiA+ID4gPiAgb2Jq
LSQoQ09ORklHX0FDUEkpICAgICAgICAgICAgICs9IGFjcGkvDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiAgIyBQblAgbXVzdCBjb21lIGFmdGVyIEFDUEkgc2luY2UgaXQgd2lsbCBldmVudHVhbGx5IG5l
ZWQgdG8gY2hlY2sgaWYNCj4gYWNwaQ0KPiA+ID4gPiA+IEBAIC0xMjYsNyArMTI3LDYgQEAgb2Jq
LSQoQ09ORklHX0VEQUMpICAgICAgICAgICs9IGVkYWMvDQo+ID4gPiA+ID4gIG9iai0kKENPTkZJ
R19FSVNBKSAgICAgICAgICAgICArPSBlaXNhLw0KPiA+ID4gPiA+ICBvYmotJChDT05GSUdfUE1f
T1BQKSAgICAgICAgICAgKz0gb3BwLw0KPiA+ID4gPiA+ICBvYmotJChDT05GSUdfQ1BVX0ZSRVEp
ICAgICAgICAgKz0gY3B1ZnJlcS8NCj4gPiA+ID4gPiAtb2JqLSQoQ09ORklHX0NQVV9JRExFKSAg
ICAgICAgICs9IGNwdWlkbGUvDQo+ID4gPiA+ID4gIG9iai15ICAgICAgICAgICAgICAgICAgICAg
ICAgICArPSBtbWMvDQo+ID4gPiA+ID4gIG9iai15ICAgICAgICAgICAgICAgICAgICAgICAgICAr
PSB1ZnMvDQo+ID4gPiA+ID4gIG9iai0kKENPTkZJR19NRU1TVElDSykgICAgICAgICArPSBtZW1z
dGljay8NCj4gPiA+ID4gPiAtLQ0KPiA+ID4gPg0KPiA+ID4gPiBXZWxsLCB0aGlzIGNoYW5nZSBk
b2Vzbid0IGd1YXJhbnRlZSBsb2FkaW5nIGhhbHRwb2xsIGJlZm9yZSBBQ1BJIGlkbGUuDQo+ID4g
PiA+DQo+ID4gPiA+IEFsc28gd2hhdCBpZiBoYWx0cG9sbCBpcyBlbmFibGVkLCBidXQgdGhlIHVz
ZXIgd2FudHMgQUNQSSBpZGxlPw0KPiA+ID4NCj4gPiA+IFRoYW5rcyBSYWZhZWwgZm9yIHJldmll
d2luZyB0aGlzIHBhdGNoLg0KPiA+ID4NCj4gPiA+IGFjcGlfaWRsZSBkcml2ZXIgYW5kIGNwdWlk
bGVfaGFsdHBvbGwgZHJpdmVyIGhhdmUgc2FtZQ0KPiA+ID4gaW5pdGlhbGl6YXRpb24gbGV2ZWwg
YW5kIGJvdGggYXJlIGluaXRpYWxpemVkIG9uIHRoZSBsZXZlbA0KPiA+ID4gZGV2aWNlX2luaXRj
YWxsLiBTbyB0aGUgYnVpbGRpbmcgb3JkZXIgd291bGQgZGVjaWRlIHRoZSBsb2FkaW5nDQo+ID4g
PiBzZXF1ZW5jZS4gSnVzdCBsaWtlIHRoZSBpbnRlbF9pZGxlIGRyaXZlciB3aGljaCBhbHNvIGhh
cyBzYW1lDQo+ID4gPiBpbml0aWFsaXphdGlvbiBsZXZlbCAoZGV2aWNlX2luaXRjYWxsKSwgYnV0
IGFzIGl0J3MgYnVpbHQgYmVmb3JlDQo+ID4gPiBhY3BpX2lkbGUgZHJpdmVyLCBpdCB3b3VsZCBi
ZSBsb2FkZWQgZmlyc3QgYmVmb3JlIGFjcGlfZHJpdmVyIGlmIGludGVsX2lkbGUNCj4gZHJpdmVy
IGlzIGVuYWJsZWQuDQo+ID4gPg0KPiA+ID4gVGhlcmUgaXMgYW5vdGhlciBtZXRob2QgdG8gbWFr
ZSBjcHVpZGxlX2hhbHRwb2xsIGRyaXZlciBsb2FkZWQgZmlyc3QNCj4gPiA+IGJlZm9yZSBhY3Bp
X2RyaXZlciwgaXQncyBjaGFuZ2UgdGhlIGluaXRpYWxpemF0aW9uIGxldmVsIHRvDQo+ID4gPiBw
b3N0Y29yZV9pbml0Y2FsbC4gSSdtIG5vdCBzdXJlIHdoaWNoIG9uZSBpcyBiZXR0ZXIsIGJ1dCBp
dCBzZWVtcyBjdXJyZW50DQo+IHBhdGNoIGlzIG1vcmUgcmVhc29uYWJsZS4NCj4gPiA+DQo+ID4g
PiBUaGVyZSBpcyBhbiBwYXJhbWV0ZXIgImZvcmNlIiB0byBtYW5hZ2UgdGhlIGhhbHRwb2xsIGVu
YWJsaW5nLiBJZg0KPiA+ID4gdXNlciB3YW50IHRvIHVzZSBBQ1BJIGlkbGUsIGl0IGNhbiBjaGFu
Z2UgdGhpcyBwYXJhbWV0ZXIgdG8gZGlzYWJsZQ0KPiBoYWx0cG9sbGwgZHJpdmVyLg0KPiANCj4g
VGhhdCB3b3VsZCByZXF1aXJlIHRoaW5ncyB0byBiZSBhcHBlbmRlZCB0byB0aGUga2VybmVsIGNv
bW1hbmQgbGluZSBpbg0KPiBjYXNlcyB3aGVyZSB0aGF0J3Mgbm90IG5lY2Vzc2FyeSB0b2RheSBh
bmQgdGhhdCdzIG5vdCBhY2NlcHRhYmxlLg0KPiANClRoZSBoYWx0cG9sbCBkcml2ZXIncyAiZm9y
Y2UiIHBhcmFtZXRlciBpcyBmYWxzZSBieSBkZWZhdWx0LCB3ZSBkb24ndCBuZWVkIHRvIGFkZCBl
eHRyYSBjb21tYW5kIGxpbmUgb3B0aW9ucyBpbiBtb3N0IGNhc2VzIGV4Y2VwdCB3ZSB3YW50IHRv
IGVuYWJsZSB0aGUgaGFsdHBvbGxpbmcgZHJpdmVyLiANCg0KPiBXaGF0IHlvdSByZWFsbHkgc2Vl
bSB0byBiZSB3YW50aW5nIHRvIGRvIGlzIHRvIHVzZSBoYWx0cG9sbCBpbnN0ZWFkIG9mIEFDUEkN
Cj4gaWRsZS4gIElzIHRoYXQgY29ycmVjdD8NCg0KWWVzLCBJJ20gdHJ5aW5nIHRvIGVuYWJsZSBn
dWVzdCBoYWx0IHBvbGxpbmcgdG8gaW1wcm92ZSB0aGUgcGVyZm9ybWFuY2Ugb2Ygc29tZSBWaXJ0
dWFsIE1hY2hpbmUuIEJ1dCBJIGZvdW5kIHRoZSBoYWx0IHBvbGwgZHJpdmVyIGNhbid0IGJlIGVu
YWJsZWQgYXMgbG9uZyBhcyBhY3BpIGlkbGUgZHJpdmVyIGlzIGVuYWJsZWQuIEkgdHJpZWQgdG8g
ZGlzYWJsZSB0aGUgYWNwaSBpZGxlIGZpcnN0LCBidXQgSSBmb3VuZCB0aGVyZSBpcyBubyBwYXJh
bWV0ZXIgdG8gZW5hYmxlL2Rpc2FibGUgYWNwaSBpZGxlIGRyaXZlciBleGNlcHQgZGlzYWJsaW5n
IHRoZSBLY29uZmlnICJDT05GSUdfQUNQSV9QUk9DRVNTT1JfSURMRSIsIGFuZCBidXQgdW5mb3J0
dW5hdGVseSBLY29uZmlnICJBQ1BJX1BST0NFU1NPUiIgd291bGQgZW5hYmxlICJBQ1BJX1BST0NF
U1NPUl9JRExFIiBieSBkZWZhdWx0LiBJZiBJIHdhbnQgdG8gZGlzYWJsZSBhY3BpX2lkbGUgZHJp
dmVyLCBJIGhhdmUgdG8gZGlzYWJsZSB0aGUgIkFDUElfUFJPQ0VTU09SIiwgYnV0IHRoaXMgd291
bGQgY2F1c2UgYWNwaSB0aHJvdHRsaW5nIGFuZCBhY3BpIHRoZXJtYWwgYXJlIGFsc28gZGlzYWJs
ZWQuIFRoYXQncyBub3Qgd2hhdCBJIHdhbnQuIFRoYXQncyB3aHkgSSBkbyB0aGlzIGNoYW5nZSB0
byBtYWtlIGhhbHQgcG9sbCBkcml2ZXIgaGFzIGEgIGNoYW5jZSB0byBydW4gd2l0aG91dCBkaXNh
YmxlIHRoZSBlbnRpcmUgYWNwaSBwcm9jZXNzb3IgZnVuY3Rpb25hbGl0eSAuDQoNCg0K
