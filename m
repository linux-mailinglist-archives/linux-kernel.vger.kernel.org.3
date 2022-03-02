Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8134CA9CB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbiCBQIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238927AbiCBQIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:08:12 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5DF12A97;
        Wed,  2 Mar 2022 08:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646237247; x=1677773247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d3OhOHCwrdG6EarlkE1gPhDJ/sO2C0ntqnXAnn2B3QI=;
  b=Pk5mYsvbn+n9BVwtXNcxshBUCrWD2keoj/cmsJXHsMrJ1ZFoy9SqilQ+
   BV6IBMmNo/ehdShHkWp9ZY/o0cPrxTmCouLZTmsDYjM9xadzJOXRzofwQ
   uyW3+TdbU5JuilRNeMD0j3X+yRx71BKvybz+g9thClrKf57zULh7R1Dgw
   3FGtwHixZbz8LH1jMaDf8zZeecenwXT5p5JgFwiBgFfcGJpE/NSWDpO/W
   R7Dz9NQ28P9Q7XvqeC8RybKnyVyWmktaJrlQhaHKG8gLXZ06gZZEhM87M
   EZQSv3MJ1Nk1u+HD7lyBV1hbjBrWbixD3qdWiJId/kfZd0mG6FCo7i1mB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="252266567"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="252266567"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 08:07:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="807654698"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 02 Mar 2022 08:07:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 08:07:26 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 08:07:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 2 Mar 2022 08:07:25 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 2 Mar 2022 08:07:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqcjr0xLRD0UdXSrJkRWv+eIhf7ONFw6NIFvaIySX6LvEw6hOOaSmSne3PueduDNf8xGloFtxI2QpkO0/VBPGelN9UFV9xhO8bQdxAB+pEEaOr93El44IfwqGWU2A5Xb7YIruoTt2eXqwfQyBjp9WkLLYcQxN+nh6eXzumMJBNy74KSxvcLAOUAT9dZddWls7f4CvFgNwfaEfgTqjUHq8dws3knxWxGWoq1zfR98nKuBQjOB/MH6QL9q8zRGb77OIEQ0CUzPQgvfr1uke30jXgZhth4iSskHNfJ0WUu9gdPM0fWsbuRkmpcqPjV31ZfEag2Y0U1/QQOgXBC8a/6H2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3OhOHCwrdG6EarlkE1gPhDJ/sO2C0ntqnXAnn2B3QI=;
 b=aMTw4j4HgjC05rdRcLq0w0/z9kFGDzrw7qZ9Y4L+NVn5ElkCxJWeft0cnOiswJOddzTSmVncEU+nXJMrQN16DQpyfGMGrSyrWwa46i7WFk3vWbdtgSEFzoRzN1ryjknlQDR3Bvx5yrPdnhqip+AtEmc6U4HJTg1wWR4KNEK+/DmhPVXaBBvN0j0emmnRslwc9zm/WjltdISSIa4J9p+hmVxzTPr3lObymbphsyP4VfNFnZMgZ5bAnbBJBfwnvVEnx6AhnwwRaELrGD15kv3n0IcSIGwYzD10etFI3BAGY1IWnNrIfmh1T8LFsR+97CxO18PvUYrLYexBpF3fwj6sLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5545.namprd11.prod.outlook.com (2603:10b6:408:102::19)
 by DM6PR11MB4660.namprd11.prod.outlook.com (2603:10b6:5:2ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 16:07:24 +0000
Received: from BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::f047:13:ac5e:a04a]) by BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::f047:13:ac5e:a04a%8]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 16:07:24 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Topic: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Index: AQHYJ9KVLj3sL+vmrk6q1BhORuJTLayrEYYAgADLt6CAABJ2AIAAXvPg
Date:   Wed, 2 Mar 2022 16:07:23 +0000
Message-ID: <BN9PR11MB55458A882EB4A681C4A63B26F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-3-shruthi.sanil@intel.com>
 <91653d8d-1dc6-0170-2c3c-1187b0bad899@linaro.org>
 <BN9PR11MB55451DB929086919F8D06390F1039@BN9PR11MB5545.namprd11.prod.outlook.com>
 <23f86de0-3869-ee22-812d-ba610bac48b3@linaro.org>
In-Reply-To: <23f86de0-3869-ee22-812d-ba610bac48b3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 400f496c-fdc5-4a80-3400-08d9fc66bd2a
x-ms-traffictypediagnostic: DM6PR11MB4660:EE_
x-microsoft-antispam-prvs: <DM6PR11MB4660FBC591174F88B1FDC0B9F1039@DM6PR11MB4660.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FzymriGnU79DtIBWsA/l8jQ6HdZeYtjtzE5v0pDqFKC82qpZN/8IqGzdWIlp3CT9nF+vw3bF9xVKY0rilz5IBJJxkyoY7UwA0L+hmY4xrWyuMuUjkwgsdzYorguTAnW4j3Q8yFEWZNaLLs0IEcyTrtXh+i2ug70axStFsJlCKNhu/LX3cWT8fn510l4kFmDf3sIaFrvStmlfrefVuHBu5ReTFJeGhs3kfjfFjc6TW1V6QfV13x7cd4oxN1tL0q2nWuxZpZNxFZrAfS+NfD0p70tYhNXdH8bKqA8s/GenTzR7NS1ozswn5f2mTTy469IZaewwwCu6BEQZ6UsIFp12Or54U1iUU2zPFRkpJS5o4mjyPMQQGVfGWYEDfrKmBgKYh+ZQQwThMLRStsMMnNhzatax72aYdSbXI6ZvKIWnoJelbpL2a8dy/24YB+w2Qqx5bXLKCl5hjYFOHw7WtVJSN2KngnD+aN3Mfe1H/7dEyoHMz1eo4LhTScpnSiFPi8MhF5UNgtKZiqdLwU1pCtfq0l8zz7nklJu00oPTQ2gj7iFUpSJjYGllarFxCJrYfopNgQ8tx/6jPkUeYzfThlKJ28+nDv44NoBSloeu155cNkzSCykg6qFs9GuJq3oM0NLJRLcViLA522XpWiA2b4M4QTVjD7WZjPM0eMgRv9CAIkayWkxwNQaJ7+K/BhnnrhHW5uSMPVYNihhX3b9ShMlO74vTdU/IiUkpubAsnMYpa+jXWpREPMQYE3C0duitadjxSd5H5EHV7+kL4RqKW4ksvvJOHWEQsOtZ7Wojx2W6fakKqxYJpir87vyks5dn3rRlPMWKXECXKuuqkw9tZvgh4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(38070700005)(26005)(5660300002)(52536014)(86362001)(64756008)(66946007)(66556008)(66476007)(66446008)(82960400001)(508600001)(122000001)(76116006)(33656002)(7696005)(9686003)(186003)(6506007)(4326008)(53546011)(54906003)(55016003)(8676002)(83380400001)(110136005)(2906002)(8936002)(316002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3VRaHF1OFNmdm5RMkNLRVBKQXNLZU9vbXJJWW1xTENjbUN6bFI2U3RTR1Fk?=
 =?utf-8?B?WDZtSSs5Zy8zY2FaNjRsQlkyQ1h5NWlZVlYvWUNKQmlqbnFWenYzK1NUQ214?=
 =?utf-8?B?MG9XUEVjekcwRmNQeDI3Nzk4ZEdJT2JVT0xvWk5rcXBXOFJ5aVlqYkRJVitI?=
 =?utf-8?B?cjFIZVFiWjFaMXlNYzBrZm5hTU9Qd1l5ZnpkMVRYcktKVGw5L01iU0lYRkZv?=
 =?utf-8?B?ZjB1ZjJhMFAxT2Q0aFZYVWlDdEQySktCUUZkajJEOWdrRWJOZWNNazRYMXNC?=
 =?utf-8?B?WHZya2s4UU8zMTNHVmROOFUrSUQ0Y2JnR0ErUy9tR3I1RlRVY0trckFRb0Jt?=
 =?utf-8?B?Tzc2TmJwcm9Id1d4dEkrcjI2YTc4Qnp5dGZHNDU3eG4vWEpaRzU4QzRCeVhO?=
 =?utf-8?B?aFNqMC94cHFselhubjVIcExWNmE1Q1IxenBtWitHbXB3R2Q2aVN5VlY4eS9O?=
 =?utf-8?B?ZXg5SVJaeU5sbkFWZ0FyRTJuT2g0d0VvMldTeit1RVpXUWtNZWJJcFMzZHdx?=
 =?utf-8?B?VXBwbTlkRy9iZ25CYnRkSUJjNE5JY3VwYU1FbFo1MnRxdkU4MWI1T2ZwSUwz?=
 =?utf-8?B?SDFYQ1JkcW1oejRxdVNjVWNoSU5JTWx1UGNMV0Y4MjJTdVRvbUVHbGVSNVBu?=
 =?utf-8?B?TWt5Q0V4RjhmR1JZOXZZRWw5UE5zd2JaVnlEQysxV0phYUxHZFVjaDJXZ2Ir?=
 =?utf-8?B?ZW5IRXRBQURDaFlsYTNIK3BQaklxQzVSekkyREJvV1M4YzVSekE1YWNQdEFN?=
 =?utf-8?B?dkJ5eGdybjg2aGQ4YS9BSzZKcmZIVzA1V0kvTTRJT1JpSnp3L0lSU3cvR0NO?=
 =?utf-8?B?ZC9xc2xmbXBzL3BiNGNESjV5Nll0S3FvcWlHa0tVMlVuQjBPQlRHZFZNUlBM?=
 =?utf-8?B?VjNXbFRyWFpMZHMxRGNmZFBkYnEyTjdidmhjMmV3UzE1dURrZSsrdk1EUmlU?=
 =?utf-8?B?L2FRdjhNSWlTV1MwVCtralZVODVpREJCUFRvaXBGdEo0YUtmSDBaWGZTVUlE?=
 =?utf-8?B?QmhOWFBibnZMUVVFNzFEc1FYYVpTWGhGMko2Nk1TcVpWWGJwRkdhRDhOZEZD?=
 =?utf-8?B?TW5tRGhrN3VzdXZUdU43cUtjbnFLUHFiMTUyQjNGNFQ4TGhoOUpiTlZ2OFBu?=
 =?utf-8?B?ZkM5ZGt3azViUmdiTzF2T1pRVTZHcm5rTzFzcHlFSFNPS3RFS1lPUi91a2ZP?=
 =?utf-8?B?M3kveWJnQUMySysraEdhOFJzY3FEN0JCTWVyVzRVb3FrSVFBSjJjcTczMFdV?=
 =?utf-8?B?empBSDZ5YUpQZjduSVBhdkVkQlFsck1vUk1ldk1vdzR4cDVQaG0zWVBuNFN6?=
 =?utf-8?B?Z0pHM01nR2hpSGRCL1Z2T3dMRHMvMUE4cVZFdmtzODc4QTdjUmUyaTZDTGpn?=
 =?utf-8?B?anY0U3hsZEh0TjZFRm9qMzlsRExUaDZRMTBBOFY2WSt4UnlwdUd0WmFNc2sy?=
 =?utf-8?B?OVlVeVpCdUZ5TnNXRDJNWUZzeGJJR0xnQ3UwUW8vNHNQeitxVHMyWnhPNGNY?=
 =?utf-8?B?NElDbVJjRisrWXZXcFZtVW0zWTlGN3BqTHZxU1ZORjM3TDZ3TFU3alVFUmZV?=
 =?utf-8?B?YUNKWjJtbk0yaWJZTSs5bWNLQ0Z4Y092cktwamxIVTdmZ0tMM1RUOFd4QkZQ?=
 =?utf-8?B?VVJhVEdnenVZbXAyMG1Ga1JHV0hCZkxKQTJlMGNBb01VVFhxWGpQeWw5YS9R?=
 =?utf-8?B?T0g3T3FtdkV4MEZOMmJVRlIzUFhkUHhWUG1ZTlNyZCs5NDcrbkVMdTNEeHZJ?=
 =?utf-8?B?NG0zLzVBdlcvNkZ0NGpBc1h1Zk5Mb1prTDNJOFMyZURZTEdYU0JHbHk5ODVG?=
 =?utf-8?B?TWszK0w1aUhKb1k5QVN0dWEvVVpLNU5OY3ZYZVVMZlJzS1JLcHdtZ2xBa3E5?=
 =?utf-8?B?S2FRYXRLSjZpYjRnRHozNFRlVjFQTGsrNUkyN2VDOFE5SlprbHdwL2ZmUkVN?=
 =?utf-8?B?eVRJNjBPYVhqb01SODdwSDdpenhTSWpEN0xoZy8vR0RaYkRUSkRXd1NtSmVN?=
 =?utf-8?B?d0Q0QWhxZXdtSGM0SmZXY0wycWh1cU1SbDJlNEhRMUdDWlgwR1Q4SCsvdDNF?=
 =?utf-8?B?L1RIMk9rWklOT3U5aDJVV0pGTlM5NjkybWtHYkF1L0VvWmV2LzdzVXQySGFK?=
 =?utf-8?B?V0NiSlI0dDBMS2RYUktnRXhiaFBVa24yS0RIQVRCWFNSTU5OUURtbFhnOHpL?=
 =?utf-8?Q?frtQ6zreyNGoAZXaLDCNwvw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400f496c-fdc5-4a80-3400-08d9fc66bd2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 16:07:23.8909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntmW/8dLNSJQdkANo9Mw3lcIbQX3ciSL7/wUOabJJTNsMtmd1lvpv+fljlvMCkGVf61HeGI4RZ8rYVR6fq17qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4660
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgTGV6Y2FubyA8ZGFu
aWVsLmxlemNhbm9AbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyLCAyMDIy
IDM6NTQgUE0NCj4gVG86IFNhbmlsLCBTaHJ1dGhpIDxzaHJ1dGhpLnNhbmlsQGludGVsLmNvbT47
IHRnbHhAbGludXRyb25peC5kZTsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogYW5k
cml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOyBtZ3Jvc3NAbGludXguaW50ZWwuY29tOyBU
aG9rYWxhLA0KPiBTcmlrYW50aCA8c3Jpa2FudGgudGhva2FsYUBpbnRlbC5jb20+OyBSYWphIFN1
YnJhbWFuaWFuLCBMYWtzaG1pIEJhaQ0KPiA8bGFrc2htaS5iYWkucmFqYS5zdWJyYW1hbmlhbkBp
bnRlbC5jb20+OyBTYW5nYW5uYXZhciwgTWFsbGlrYXJqdW5hcHBhDQo+IDxtYWxsaWthcmp1bmFw
cGEuc2FuZ2FubmF2YXJAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDIvMl0g
Y2xvY2tzb3VyY2U6IEFkZCBJbnRlbCBLZWVtIEJheSB0aW1lciBzdXBwb3J0DQo+IA0KPiBPbiAw
Mi8wMy8yMDIyIDExOjEyLCBTYW5pbCwgU2hydXRoaSB3cm90ZToNCj4gDQo+IFsgLi4uIF0NCj4g
DQo+ID4+PiArCWlmICghKHZhbCAmIFRJTV9DT05GSUdfUFJFU0NBTEVSX0VOQUJMRSkpIHsNCj4g
Pj4+ICsJCXByX2VycigiJXBPRjogUHJlc2NhbGVyIGlzIG5vdCBlbmFibGVkXG4iLCBucCk7DQo+
ID4+PiArCQlyZXQgPSAtRU5PREVWOw0KPiA+Pj4gKwl9DQo+ID4+DQo+ID4+IFdoeSBiYWlsIG91
dCBpbnN0ZWFkIG9mIGVuYWJsaW5nIHRoZSBwcmVzY2FsYXIgPw0KPiA+DQo+ID4gQmVjYXVzZSBp
dCBpcyBhIHNlY3VyZSByZWdpc3RlciBhbmQgaXQgd291bGQgYmUgdXBkYXRlZCBieSB0aGUgYm9v
dGxvYWRlci4NCj4gU2hvdWxkIGl0IGJlIGNvbnNpZGVyZWQgYXMgYSBmaXJtd2FyZSBidWcgPw0K
DQpOby4gVGhpcyBpcyBhIGNvbW1vbiBkcml2ZXIgYWNyb3NzIHByb2R1Y3RzIGluIHRoZSBzZXJp
ZXMgYW5kIGVuYWJsZW1lbnQgb2YgdGhpcyBiaXQgZGVwZW5kcyBvbiB0aGUgcHJvamVjdCByZXF1
aXJlbWVudHMuDQpIZW5jZSB0byBiZSBzdXJlIGZyb20gZHJpdmVyLCB3ZSBhZGRlZCB0aGlzIGNo
ZWNrIHRvIGF2b2lkIGluaXRpYWxpemF0aW9uIG9mIHRoZSBkcml2ZXIgaW4gdGhlIGNhc2Ugd2hl
cmUgaXQgY2Fubm90IGJlIGZ1bmN0aW9uYWwuDQoNCj4gDQo+IC0tDQo+IDxodHRwOi8vd3d3Lmxp
bmFyby5vcmcvPiBMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNv
Q3MNCj4gDQo+IEZvbGxvdyBMaW5hcm86ICA8aHR0cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMv
TGluYXJvPiBGYWNlYm9vayB8DQo+IDxodHRwOi8vdHdpdHRlci5jb20vIyEvbGluYXJvb3JnPiBU
d2l0dGVyIHwgPGh0dHA6Ly93d3cubGluYXJvLm9yZy9saW5hcm8tDQo+IGJsb2cvPiBCbG9nDQo=
