Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7774D6C32
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 04:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiCLDMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 22:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCLDMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 22:12:13 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508412923D4;
        Fri, 11 Mar 2022 19:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647054669; x=1678590669;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=droSS15p37YH6rxr5TXFN0dWTY2d+3DGPo5VRY1H8WE=;
  b=ejgXkBXlIFXsK4exfzL6QDDU81K4mtZxWbk9OCnOq+3YPapqch9BYqP3
   eV0WnYgkdqwf1KQz1WghwCCyvWV6f52icT5rSVqmSs84JxiGbSWfjXukh
   8xOMrrg3zd+jjf578ZWiQXv9VMLogjBeU2qnGvpTzJ2RkwOn50TskfDQI
   dz8Ddq2ZZTzlJTAoy1IAB5Uluj4RvIQ+AjlaySr+BnZeSFndBI1y2w9Li
   OlQwDpcN6p34LOTBDb4ICSm1GGZzSx7720t3P71XmnakR7ofFa6eJcyix
   zOKRvJkWRoI4zkWnYBZBmhvwRVngDfabBXsgcrhHHLM0s/oecdIfYo5B1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="316449517"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="316449517"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 19:11:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="514745273"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 11 Mar 2022 19:11:08 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Mar 2022 19:11:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 11 Mar 2022 19:11:08 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 11 Mar 2022 19:11:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZLNMey1y+eEdCV+7Mtm2XBv/drW72N2GG99b0nffQzV60Cg1WGjDx87Rgxx4p3e+mpL0onunFtIsr1ZD/qHkF9upq8OHKJPscFHgcRh8Ozce6+T82/0M0jjrB0cbR7Kz/I5/ewLjUEm1hcQ9dJrz5TrlH5pUawsqjYdjYI9zyOn1WTy7XOowutew5XXNr4Saa3P3xoEK8Q98fthChkp/KJl7wsW55PLy5Ytn16euUT/V0ETpCXPIlZwPkkHvrsXSQ44890ZzeBRsKWzhCLIEfIBTu+YpTV3AmcW3OELP2CSZj4ay8ILwNqJu/bTOFLdxKplPUT1fSvmKUAukbPEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=droSS15p37YH6rxr5TXFN0dWTY2d+3DGPo5VRY1H8WE=;
 b=LUppdwiWE0ubz39Kr4UweXcLR1Fh4PPJhD3k7ItGyEgxRtnXkQHfemGUmaDuoEcEj0S4ePzemhd+OYHpz/VSUCcAiGK1zDJhzU3Qjhg8pS8/815sJOshVsPpAjZHLmYJhpVDJcz5jfhoyzHA6SHZtDGwcNyF8QoLsyhrbuA+xxSqYOsLhr294MnFduz+ZwudvxABauvYrwmnel05gMBEf0Nz8qyQkY3AdWN67BA0UYyJKqadyrT4VznDM5z896a37P9som8vauUh7S7Hkex0gewel8JdW57mCjE3wntLfHNzI6nxBfD+20ioBP+ONdL19Sw/sCQaDhNMcjSSl7A4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CH2PR11MB4376.namprd11.prod.outlook.com (2603:10b6:610:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Sat, 12 Mar
 2022 03:11:04 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::d90e:5a21:8192:7c54]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::d90e:5a21:8192:7c54%5]) with mapi id 15.20.5061.024; Sat, 12 Mar 2022
 03:11:04 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Thread-Topic: [PATCH v3] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Thread-Index: AQHYNO7gNJl5wtEdME6XCIwd5VJW/6y6BwsAgADvr2CAABoXIA==
Date:   Sat, 12 Mar 2022 03:11:04 +0000
Message-ID: <PH0PR11MB58807AD9A1BAA122218B92DBDA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220311022226.595905-1-qiang1.zhang@intel.com>
 <Yist4IWWR/6BZzeK@linutronix.de>
 <PH0PR11MB58802B8804EDFFC73BA676F2DA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB58802B8804EDFFC73BA676F2DA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df7b00a8-7d6d-4e26-6eec-08da03d5f1da
x-ms-traffictypediagnostic: CH2PR11MB4376:EE_
x-microsoft-antispam-prvs: <CH2PR11MB437628BD754493C34D07633ADA0D9@CH2PR11MB4376.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DB1j1wZhNvVgmglJR8ljgCvep0XkuxQ7l9C0PuRExapGq5il5L4kqZwXhcDBhFJrg8Zw6ucCdBzMX7VZR0uf2UzrpLSr8cB2zITlWIiEfUqCmqM4ySiDiQQVpMEi77Q7kUdcoJtbMjLBmuR8CO4KhqOOXfBQQKUX/s76bHKwFKQ+R4zsJx/jT4myD+U7pYtkLKjR2QgWJM4tFx1syyia+hdiQGxwIXz/1hAnTmWgdcr0m9f1yyYg/gxpEky2tIqCsPImJwTMPRgHBoCzQOUArTBbw3n+bh+Phrt3sTsFHbKQ2eGzJugeiwn+n3LhbMj12XWVDYx5JFB0hsNp1lypkoLG31d8H6y/5EpvIcUKCOs6zeooy04TXY46YtT8SEcXZ/A4vx9wXzx/425eXDLHaOUJnFbsnBLDEZu3EEt9HkZ1nsKlCfGA3BYiQYhjyYzfEJuxjhLiFOjlm3uzGbsrXeO4Tu+yiEtyqwo0Y3IAXjtvMBZd8jyeAvSofalCN6f3HSYBsSAe9CSjnNFFUgDcMPKX9bgAEZ/LGYteh5JIK/aaS3dfCbHcUrW5O63vx1zhhA8unKGNn7zDfHH3yu84Y7GjwglvCP1rksZMkjOGThfwMlOH5YbfY+YlM1i/rZNyql469+7gXo/SW+hjiCdhs6dZhiHHTn/KKnikkRN4L9dLoX+aratRXkq7SkAgiln7ou2Yr4LFOSkSqRfJBmLxww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(83380400001)(7696005)(6506007)(53546011)(82960400001)(8936002)(2940100002)(186003)(26005)(2906002)(86362001)(8676002)(38100700002)(33656002)(5660300002)(6916009)(316002)(52536014)(508600001)(38070700005)(54906003)(71200400001)(4326008)(55016003)(66476007)(66446008)(76116006)(64756008)(66556008)(66946007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEJwdWhFMjJ5SnZRN3FZUmtoMEFybG11RXMzTTVqM0pVTDZNTlgwNXlwRTRG?=
 =?utf-8?B?bGhzeGdRRFRSTFhGMzNwZE4zcEpUUjNhbEVvb1cya1Nzb2lyQXhDa0hiZ3Vn?=
 =?utf-8?B?alRHRFdQdlVPdTNpemYrbnBUaEV5dlRRMVA4NTFON1EvazZNMlZiV1Iwb1pE?=
 =?utf-8?B?RS8wRnNHdFc2K3dJb3NuOXlWU2MzWHBkaXZ1TlF4TTJyWmk4ZFcybXliUzdp?=
 =?utf-8?B?OHZlMlVvTmJyb0EwWEFpMXZsTjMvbVNnVVR3ZnNtWm43bURiZG9CTkhsWk0w?=
 =?utf-8?B?TVdjRHVFdHJKcjZJenBxS3BwNWR1dUpmL3dpOXFmQ2puYmlrRDdnaXpPMU5E?=
 =?utf-8?B?ZkpmRWRMY3FjTjE3clF3a0wvVWpsQTQ1cEFYUVY5a1BXc0JuaGRWcmkyQnk1?=
 =?utf-8?B?MnhVKzR2MEN2R2xTVlBUWWxjWXpqQUNoK3lqdEFPMjFXV2JhaHVGb0RERGEx?=
 =?utf-8?B?NUNER1JkbDJhVm5xcEtXZ3hqNjRmdzFVWXBYTGxMU3pFN0pjbytGbDYvMDJq?=
 =?utf-8?B?MjkrMmQzclZPT3luTWYwN3hYYldIRWYyKzk5bWxYUmVLMEptM1c2UmdmUGlj?=
 =?utf-8?B?c3d4cXVUS2plSWdyV2tZNHVJZHBhTmp0MHVHaTBDa0RqM1pLWGUrNkF0VmYz?=
 =?utf-8?B?ZmMxVkM4djJtK0ZVdjU3YzJSTVpKekduS3VJT3BSRlByRDhFVG1oRENNRFNp?=
 =?utf-8?B?cExrQ0hwTVN1RlE1bmlKMHhOK2IzZ2psOXBsTzlmM2xMeDA5S25UT21DbDFu?=
 =?utf-8?B?RCtWNmpVVWFmbnozTTBwcHNrdm5tNUN2OCs3djdYdDE0emplTkoyYW9odjdz?=
 =?utf-8?B?VzdnMmJ3dGlOeHVCdjBHeklJenpkL2VKNlVTczNvam1MQnI2U0U1VmhCTDhF?=
 =?utf-8?B?d0FGdkZkMzhoU2xjZ2xnT3prdVBqRXdXOWkycko1SjRHK3BVN3U3YmZBdVB6?=
 =?utf-8?B?K3BTcGErb01ELzNua2JPNExtcEJNRmp0Q0lvcXFibHRiSmVWWHlrVzJoTGhi?=
 =?utf-8?B?ZDR3SU5DbVRjNFNLQVNiVzB3MGJWQVpRaGhhdCtTUU95akt3YUFvOUxEbEZX?=
 =?utf-8?B?RTk4SzlndGloY21pcW91d1VPdlpEUFA1eFNqK2EzYjBQVDRUQ2xNdHVhU1I4?=
 =?utf-8?B?SmVyOEZkelB0bXdlQVUyNEZWd0p1WW5CTy9PNGlPNmg1VlNmY0NCbjhkRW1o?=
 =?utf-8?B?dCtBeU5lK2xFdjZCMktsQkZId1hTY2tiRS9ucFhqNkhNeGhOZ0dudnpQQkxE?=
 =?utf-8?B?WFMzcEVHKzZNR0xxeGJ3dFU2aGh6NnpxeWlndGVuc0ZNeUJNNEROR0Z3K2R6?=
 =?utf-8?B?QkZGOU1RVlNZclJsa2l5WUpkTEZpemhBUzgxd212Z3VydmVXbmJ2YTN2MElW?=
 =?utf-8?B?N0JrbWdhRWYxYU9BUXhIN2RhQnBoYURUbno3OUJmYXdoNTZiZnI1YlA0Vkls?=
 =?utf-8?B?UHB5dHdXZGxYbCtzb0lUL0pKekNjSTJ5aGlHQUwzMXk0VUhPWVpIdzFGckJR?=
 =?utf-8?B?RklHQWpseFdXNyt5N1N6Tk1KcExsaWtVMml0QkJjY0pHR2xxclo4NmxOMGcw?=
 =?utf-8?B?UHdRK1N6dzEvR3dXY2dvK01EZTNkcFpZY3dhRW9DUEY5WG8xdm9YS3ZZcGxw?=
 =?utf-8?B?RG5DcE96QVVXS25wV2tmTW9XczgyZVJPbFcrQmF5c3JRNk10ZWVLSGR3S1VI?=
 =?utf-8?B?MDRnQmhzR0RlTHdqS2ppSFhPTVJTejd2aWZ6Mkc4MUxDR3NpdStkNmd1T2ho?=
 =?utf-8?B?dklKdWgrQ3FYSXB4THQrTFFscnloTUJyOFdGaXB6b1BwM1B0NnJHVHZ4MzEr?=
 =?utf-8?B?V1NVMFVrVVlmY3NGbDRGM2lZcWp1bmhJZEM4enZKQ2NuTjMybW9IREJYMHpK?=
 =?utf-8?B?R3pzT2xpSWhmMDZBZTJ2OHM2SExxNmlMTjR5S3gvVjhMdUxiam8rZlRXbXpN?=
 =?utf-8?B?TVNVMlVvT2x2TDVMMXpNa1VJYXR6dW5yYnRaMEg5M1hSWEMvWmNIelpuWjYv?=
 =?utf-8?B?ekpGbkxTSVNvUWtVaUp0RTFiWE1FTTBVUW00VmVKQ2h6dEtaSWhIek9MVEpU?=
 =?utf-8?B?WlB0U2xRUEdoVkpEMTRGVjRubDRlRHNYZEplcFVvREhmVzh0SmZwSVE5ZTQ3?=
 =?utf-8?B?UjA5MndhQzQvSlpTRXB0VnNsYk9ibGtsQWJpOXh5QzF4RDYwRmtlWTkxZThV?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7b00a8-7d6d-4e26-6eec-08da03d5f1da
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2022 03:11:04.6263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aARf6egxtW0I5UCQPZCQN3XRkNIyo5Fw7u+D/UZECcn9sdVaGCGC/nhG+FF/bxYW/nmrkvU7j0YS9TJJWFFpKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4376
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi0wMy0xMSAxMDoyMjoyNiBbKzA4MDBdLCBacWlhbmcgd3JvdGU6DQo+IFdoZW4gUkNV
X0JPT1NUIGlzIGVuYWJsZWQsIHRoZSBib29zdCBrdGhyZWFkcyB3aWxsIGJvb3N0aW5nIHJlYWRl
cnMNCj4gd2hvIGFyZSBibG9ja2luZyBhIGdpdmVuIGdyYWNlIHBlcmlvZCwgaWYgdGhlIGN1cnJl
bnQgcmVhZGVyIHRhc2tzDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
IFBlcmlvZC4NCg0KPiBoYXZlIGEgaGlnaGVyIHByaW9yaXR5IHRoYW4gYm9vc3Qga3RocmVhZHMo
dGhlIGJvb3N0IGt0aHJlYWRzIHByaW9yaXR5DQo+IG5vdCBhbHdheXMgMSwgaWYgdGhlIGt0aHJl
YWRfcHJpbyBpcyBzZXQpLCANCg0KPj5UaGlzIGNvbmZ1c2VzIG1lOg0KPj4tIFdoeSBkb2VzIHRo
aXMgbWF0dGVyDQoNCkluIHByZWVtcHQtcnQgc3lzdGVtLCBpZiB0aGUga3RocmVhZF9wcmlvIGlz
IG5vdCBzZXQsIGl0IHByaW8gaXMgMS4NCnRoZSBib29zdCBrdGhyZWFkcyBjYW4gcHJlZW1wdCBh
bG1vc3QgIHJ0IHRhc2ssIEl0IHdpbGwgYWZmZWN0DQp0aGUgcmVhbC10aW1lIHBlcmZvcm1hbmNl
IG9mIHNvbWUgdXNlciBydCAgdGFza3MuICBJbiBwcmVlbXB0LXJ0IHN5c3RlbXMsDQppbiBtb3N0
IHNjZW5hcmlvcywgdGhpcyBrdGhyZWFkX3ByaW8gd2lsbCBiZSBjb25maWd1cmVkLg0KDQpUaGFu
a3MNClpxaWFuZw0KDQo+Pi0gSWYgaXQgaXMgbm90IFJUIHByaW8sIHdoYXQgaXMgdGhlbj8gSGln
aGVyIG9yIGxvd2VyPyBBZmFpayBpdCBpcw0KPj4gIGFsd2F5cyA+PSAxLg0KDQo+Pj5JZiBpdCBp
cyBub3QgUlQgcHJpbywgdGhlIHNhbml0aXplX2t0aHJlYWRfcHJpbygpIHdpbGwgbGltaXQgUlQg
cHJpbw0KDQo+IGJvb3N0aW5nIGlzIHVzZWxlc3MsIHNraXANCj4gY3VycmVudCB0YXNrIGFuZCBz
ZWxlY3QgbmV4dCB0YXNrIHRvIGJvb3N0aW5nLCByZWR1Y2UgdGhlIHRpbWUgZm9yIGENCj4gZ2l2
ZW4gZ3JhY2UgcGVyaW9kLg0KDQo+PlNvIGlmIHRoZSB0YXNrLCB0aGF0IGlzIHN0dWNrIGluIGEg
cmN1X3JlYWQoKSBzZWN0aW9uLCBoYXMgYSBoaWdoZXINCj4+cHJpb3JpdHkgdGhhbiB0aGUgYm9v
c3RpbmcgdGhyZWFkIHRoZW4gYm9vc3RpbmcgaXMgZnV0aWxlLiBVbmRlcnN0b29kLg0KPj4NCj4+
UGxlYXNlIGNvcnJlY3QgbWUgaWYgSSdtIHdyb25nIGJ1dCB0aGlzIGlzIGludGVuZGVkIGZvciAh
U0NIRURfT1RIRVINCj4+dGFza3Mgc2luY2UgdGhlcmUgc2hvdWxkbid0IGEgYmUgUEkgY2hhaW4g
b24gYm9vc3RfbXR4IHNvIHRoYXQgaXRzDQo+PmRlZmF1bHQgUlQgcHJpb3JpdHkgaXMgYm9vc3Rl
ZCBhYm92ZSB3aGF0IGhhcyBiZWVuIGNvbmZpZ3VyZWQuDQoNCj4+PlllcywgeW91IGFyZSByaWdo
dC4gSWYgdGhlIGJvb3N0aW5nIHRhc2sgd2hpY2ggaXRzZWxmIGFscmVhZHkgYm9vc3RlZCBkdWUg
dG8gUEkgY2hhaW4sDQo+Pj5hbmQgSXRzIHByaW9yaXR5IG1heSBvbmx5IGJlIHRlbXBvcmFyaWx5
IGhpZ2hlciB0aGFuIGJvb3N0IGt0aHJlYWRzLCAgb25jZSB0aGF0DQo+Pj5QSSBib29zdCBpcyBs
aWZ0ZWQgdGhlIHRhc2sgbWF5IHN0aWxsIGJlIGluIGEgUkNVIHNlY3Rpb24sIGJ1dCBpZiB3ZSBo
YXZlIGJlZW4gc2tpcHBlZCBpdCwNCj4+PnRoaXMgdGFzayBoYXZlIGJlZW4gbWlzc2VkIHRoZSBv
cHBvcnR1bml0eSB0byBiZSBib29zdGVkLg0KDQo+Pg0KPj5Zb3Ugc2tpcCBib29zdGluZyB0YXNr
cyB3aGljaCBhcmUgaXRzZWxmIGFscmVhZHkgYm9vc3RlZCBkdWUgdG8gYSBQSQ0KPj5jaGFpbi4g
T25jZSB0aGF0IFBJIGJvb3N0IGlzIGxpZnRlZCB0aGUgdGFzayBtYXkgc3RpbGwgYmUgaW4gYSBS
Q1UNCj4+c2VjdGlvbi4gQnV0IGlmIEkgdW5kZXJzdGFuZCB5b3UgcmlnaHQsIHlvdXIgaW50ZW50
aW9uIGlzIHNraXAgYm9vc3RpbmcNCj4+dGFza3Mgd2l0aCBhIGhpZ2hlciBwcmlvcml0eSBhbmQg
Y29uY2VudHJhdGUgYW5kIHRob3NlIHdoaWNoIGFyZSBpbg0KPj5uZWVkLiBUaGlzIHNob3VsZG4n
dCBtYWtlIGEgZGlmZmVyZW5jZSB1bmxlc3MgdGhlIHNjaGVkdWxlciBpcyBhYmxlIHRvDQo+Pm1v
dmUgdGhlIHJjdS1ib29zdGVkIHRhc2sgdG8gYW5vdGhlciBDUFUuDQo+Pg0KDQo+Pj5ZZXMsIEl0
IG1ha2Ugc2Vuc2Ugd2hlbiB0aGUgcmN1LWJvb3N0ZWQga3RocmVhZHMgYW5kIHRhc2sgd2hpY2gg
dG8gYmUgYm9vc3RpbmcNCj4+PnNob3VsZCBydW4gIGRpZmZlcmVuY2UgQ1BVIC4NCg0KPj5BbSBJ
IHJpZ2h0IHNvIGZhcj8gSWYgc28gdGhpcyBzaG91bGQgYmUgcGFydCBvZiB0aGUgY29tbWl0IG1l
c3NhZ2UgKHRoZQ0KPj5pbnRlbnRpb24gYW5kIHRoZSByZXN1bHQpLiBBbHNvLCBwbGVhc2UgYWRk
IHRoYXQgcGFydCB3aXRoDQo+PmJvb3N0X2V4cF90YXNrcy4gVGhlIGNvbW1lbnQgYWJvdmUgYm9v
c3RfbXR4IGlzIG5vdyBhYm92ZQ0KPj5ib29zdF9leHBfdGFza3Mgd2l0aCBhIHNwYWNlIHNvIGl0
IGxvb2tzIChhdCBsZWFzdCB0byBtZSkgbGlrZSB0aGVzZSB0d28NCj4+ZG9uJ3QgYmVsb25nIHRv
Z2V0aGVyLg0KDQo+Pj5ZZXMsIEkgd2lsbCBhZGQgeW91ciBkZXNjcmlwdGlvbiB0byB0aGUgY29t
bWl0ICBpbmZvcm1hdGlvbi4NCg0KDQo+IFN1Z2dlc3RlZC1ieTogVWxhZHppc2xhdSBSZXpraSAo
U29ueSkgPHVyZXpraUBnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcx
LnpoYW5nQGludGVsLmNvbT4NCg0KPlNlYmFzdGlhbg0K
