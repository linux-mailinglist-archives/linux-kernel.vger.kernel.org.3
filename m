Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44544BD62F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345651AbiBUGoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 01:44:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345620AbiBUGnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:43:55 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2CB25E9F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 22:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645425715; x=1676961715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NOdm07aEZ4LQ/x0f12O8dpCEiyByxY7Qo/HaNXMaA6M=;
  b=ZCzLC1pN4hSdV/x38m+4eWnVKb5UmlgHMUiO0gm+/DIb7dknVr+PvyJE
   dVL7FXoRtljBdSMg97gtxEDQkm1U/0ZgeXmy5M3bWrlotaVnEWAXwORql
   /yymSaPjz0DzeFPZUhwOeXHfdvq7rSg0mxQvwO39vPEZe6oUFMHN65dy/
   y2EssQb2//Vkr20AZ/E7eS+kfoSneQrkfctcHYAUJ2nJ1itH0ckR8IK4Z
   NMinfC8TMMbVK9YQgPCeFJWj5NvvjoDpe4WxGZLGxCXkIc+iFx/ubRS6d
   T8SeWS5S/TLakfInQVVAAZVut4M9B38u99iUbEpXxFzkIBXJXgXiPMHPh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="312189843"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="312189843"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 22:41:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="542519959"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 20 Feb 2022 22:41:42 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 20 Feb 2022 22:41:38 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 20 Feb 2022 22:41:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sun, 20 Feb 2022 22:41:38 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sun, 20 Feb 2022 22:41:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGGLudpRCOOl8SbNFXL4KcpNsFObNOtqbzRczCkDvvxTGYrbXLGloVvbR5ou6vEhCimh8DXyj0GaDOzQPKvKUO3BvOL/aeMNrh+eJok7EOlqgDz4S8DGSYBOqZO7D9I7EAacr/nrZ0P3AByyIo8b2WqMS5xd69xdyz5B/4eswoY1g9kB0n3/7/jcgcKrkVyDoGYHGaEZp/Rcp6MEhlsA5V6TKbZ7tdHowHH9VmpsyeQleV80Ircs+nVENjGhH3MM+TRrL/jig18v2XoG614emBApw+Ry62U/otOqVGZ5W9PJ0r0knCYzBSjXTopwH+IRBPuNQ3zlSOh2elH/NLQU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOdm07aEZ4LQ/x0f12O8dpCEiyByxY7Qo/HaNXMaA6M=;
 b=Nc2vkbW2wZ4Dd2VXgNm3moTUX9oBMtFek3HPRr3bIbuuDWxrEd/ROfBYeqwEUzub2lxgjL0nrqno1ysqAWXm7svM8Lf6hxZGPWKJIGjYM9E6bjGEnmLv1GrWH2yB8/7XbjyMjF0kamQi1+zToEK15OuBnCiyCEEq99U70nUmxg/XigzwjqoyqrTOG8uqfufnjF0RoSnYhdtVx0GMDoueVzvjhWwpc5yqMIgJ/nVq2/evfRsFiT1nf7rh22owY3le8WIzmMBcbpgBwK99Q4kQWVERTgqHrImqgVhdyQYGAdaCUYsqCANrYKZqphsm8YkhvrN+aOOCb56JJ1lQcWTVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4891.namprd11.prod.outlook.com (2603:10b6:806:11e::18)
 by MWHPR11MB2000.namprd11.prod.outlook.com (2603:10b6:300:2b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 06:41:36 +0000
Received: from SA2PR11MB4891.namprd11.prod.outlook.com
 ([fe80::f437:9b7d:d749:a7]) by SA2PR11MB4891.namprd11.prod.outlook.com
 ([fe80::f437:9b7d:d749:a7%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 06:41:36 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "sound-open-firmware@alsa-project.org" 
        <sound-open-firmware@alsa-project.org>
Subject: RE: [PATCH] ASoC: SOF: Intel: Add topology overwrite for Felwinter
Thread-Topic: [PATCH] ASoC: SOF: Intel: Add topology overwrite for Felwinter
Thread-Index: AQHYJKHaUwv5L/YC+U2p0OZj3Ae6BqyZm4eAgAP3LQA=
Date:   Mon, 21 Feb 2022 06:41:36 +0000
Message-ID: <SA2PR11MB4891C99762A4D9DCB2E2D89F973A9@SA2PR11MB4891.namprd11.prod.outlook.com>
References: <20220218082741.1707209-1-brent.lu@intel.com>
 <2267504d-37cc-9a6e-5c4a-6051df95773c@linux.intel.com>
In-Reply-To: <2267504d-37cc-9a6e-5c4a-6051df95773c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0eac2ff2-2d23-434d-47e2-08d9f5053502
x-ms-traffictypediagnostic: MWHPR11MB2000:EE_
x-microsoft-antispam-prvs: <MWHPR11MB2000C6FF77EE527E40424B18973A9@MWHPR11MB2000.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gWFakfODLMAurqIqu+YYIOMA95J0a7zz9B2zCzlsHE5DC1UYvEWIUmhoZgALNy4LxyLu84O72hvylIyM8H3fTOAT9IzEKNqteRVgUPs19yMzm7/CFQ+9ytJCV90l/x+6n7zAODzs39mLODURZ/vwtQvA9KI7yGpOrssjy8y+9GONH3tgJ+UPhFfM8IDo1gncpflKmv7c62Z2v2licwzjfOK+t89d+Dx4egS6V9aMV33UNqyUOLJPmO0YsB27+Q+PUan+TSythRsrd60JpjNSAp8hciOv8eLuLs6Rjbam+xRfeJRIPcJBEe1mbe1LZ75LdpaHHKYMLXmT749BHtvgSsrxFrKjUpLzh1SPWXovsXX3q8Gs4eqk9x9DhJPKQW/JernMNxxaQugCZjYIukQjwQeGSUVJ2KRtNiPylNl8yQvArt2A12W44+CjfZrdVEuReO4D0GHtC+Q0l0mshwnmFjJE5ZPiGCTBmH6Hr5/GKAJt3gGAnMttUw6AAUGd+EMuQs/FPcHp7WtOnKfZ+HsfhGCUovXG+rGsy083iRhs0vLHqwKgSD2fs7+rG0+GVsIMNjZzacp1W+Zz8FjK55uM1If5S0Y6PIvHPGQjjcHWjnHrDz0RQ5E+fdldMZyd/ppVx+31rUOkJdXMvLJpinEXpSFBan7YGZAydRWn4e93d+3lA942f+fPf+9p4auRIusKrmshLjcgORe7KxTKsPpraKKSzXKgfOucyXqgM2cS5yw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4891.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(38070700005)(38100700002)(558084003)(52536014)(7416002)(5660300002)(55016003)(2906002)(8936002)(33656002)(66476007)(110136005)(54906003)(8676002)(64756008)(6506007)(26005)(7696005)(186003)(66946007)(76116006)(9686003)(66556008)(122000001)(82960400001)(71200400001)(86362001)(508600001)(316002)(66446008)(11716005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlRsbVZ1UkNRWTN6ZkVBSjZHV3l6dy9jWkpNdmVkNlUxY1JDU2hSMTY3YWxx?=
 =?utf-8?B?UHd2WEVtQk5jY3VSQlpwRFc0bXFRb2E5VzFxK21uK1NHZUM3ZXlyWDVCbkRU?=
 =?utf-8?B?TUdpNDZsNndTUlREL1FsbzUxR2pZSVhNaDVyY3dpMll5UEFWYXVvSGdXbkdz?=
 =?utf-8?B?eGNUSEsrNStnSDFFZjdPeGh5djExTm9tSWNyT2pNZnJSWDEvd25XYjdCaUVQ?=
 =?utf-8?B?TGZyQWdpL1hUaWRIdTJIVW91YWZmK1ExaUFMakZWUisrWnd5Q2I0Z0theURk?=
 =?utf-8?B?aCtJcGcrY2RYSWNMT1BOWHZ1bm1yRUdlMVNHamo4K1V0MS9tb0ZqcjBmUGd4?=
 =?utf-8?B?SnVWUEZzNWlXb29oc2pPdUFNZUIrNForK1VJUTBnakZHWm9vZEg5UTY3OU10?=
 =?utf-8?B?TjdHdkpiOWpyRVBncWhqU0c2R2V6eXM2VUo4b2YycG9lZW5ZSHhuOWU0U0Nj?=
 =?utf-8?B?RmxGeFlVYkpPbUhCM0hKNGU5VWNSNlBFVzJ1eUp4VVhrVGNrZjFLalllZUZJ?=
 =?utf-8?B?ODZjcVB0cE1JQzNlMUdkRDFYU0xzbG1UTHFjdkRRRGszSGJOSm5GbDZLSnpq?=
 =?utf-8?B?cnNMVXNSRTNROEQ3WWhGQXpUMWRSOWVQcW9WUHh6UU9ETnlmbUoxN0lnSHIw?=
 =?utf-8?B?Sm15OExNaVVYL2tjSTJYQ0tYeVN5SnhRbm8yRFRhV2VxYlVubCtCK1h6WFNk?=
 =?utf-8?B?cDZtWk42cjEydysyUUx0WkxjL1ZUR2lYNVpxWmhDTUxLbk1RaFd6L3ZRc3lp?=
 =?utf-8?B?RWZsL29XeC9zWUc5d2JPblBES2toUVdrNEQzeURnZ0VTUU9rRmp1U1Jja0RM?=
 =?utf-8?B?RTQ0MVVlQVhjQWYxeGwySHZtd2tNNitGNXpHdkpoYU9EY0xiU2pmVEROdzlx?=
 =?utf-8?B?bVF5NmRMNWlta2lNS3pIMmpyVFFFS1pZWlVrTUhaZFhxN3orUzdBK2FsZ1pt?=
 =?utf-8?B?d2RrQkhHd1dHMk4xc3V1eVU1Lyt2YlpzV01vWm4zWTYwS0dCblpxQ2ZUR2Jl?=
 =?utf-8?B?bzF5SFF0NW9KVWJPdUtnSGJFSElqVjIzVkRBT3JDS3p6bWk4ZjJyYmcycDVP?=
 =?utf-8?B?VTVzMzJpQUZYOU9VZllRdE5XWktwdVlBblNXUzlWdFJ5Z1pGZSsrSE1BMmpI?=
 =?utf-8?B?SWkxNzhIU3N6R3lVc3A5WlNiblhGUm9RcTBmTGxGc210aFlINHJsN0l5ZWNP?=
 =?utf-8?B?MFVPbkxxd21sQ2hsakZtVHUwckR0aGFyekt5ZU4rb3FhMThZeVBJYjNYWVhu?=
 =?utf-8?B?YUdNNjk4MVc5SE1hM0NpMVhpSmNQc0ZLUmdkZm5XU0d1dnpsUkVHVkRNZVpK?=
 =?utf-8?B?N3VVTUROSnVWVXRrL0RTcmJFT3JuLzdmNFRSZVVnaTZLR29aNjl1TzdweUF6?=
 =?utf-8?B?L0dUNlN3cVR2Qng3UTRNUnQ0bGcxbHpyUzN0Uys1NjV3a0pGd1pGNmZ4S1A1?=
 =?utf-8?B?djF3OVFabTJFc1dZdmI0SHNGREw1YnRlYnRVbWJ0R2VPdUFzN1FkTTlYMUVt?=
 =?utf-8?B?d09WMGVoRmR6c0QrOG9YKzNwYmFZWmVZQWRuNllScWpneXVtOFNhUG9EV3FQ?=
 =?utf-8?B?S3RkWk5vYkpreEZpTENqQ2E4Zm9tblIzcmZYc0NlOXY0bEJQaUNhWHRrSGx1?=
 =?utf-8?B?elZqeXk2S2hqUnVmanEySk5oem0xc2dmTnM2QVlBMzZmMFc0NXNMRkRNY0tZ?=
 =?utf-8?B?SHNJaUxTaWdybVptZEJTRlJRZEJzc21ZWjc0VG5GcUZjeHZuL3h6dEpKMngr?=
 =?utf-8?B?eVR2TW9SeVVReks1cmdIUE9ZKzg1d0JreWtxbzg4VFV1YlRqdUxuaCtGa1Rq?=
 =?utf-8?B?RkkwNWNWWjVnaEJLZGg0bFl5T091YndhNzJOYUNub0FXeVhHUkxpSXd3YTZW?=
 =?utf-8?B?aDBTMklUSFlMYWFnckVpUk54cXBteVlNWkxRSzFJeFBOSjRkMitFcXg1aWxF?=
 =?utf-8?B?MnJmMm04RFRCd3VVNUF4OE51TnRmT3BUd0plazdYS3ExckRhcVhrak5pa21v?=
 =?utf-8?B?MzFKeVVVZE10V2RraTlicUVvdEVMa21zUGxmL3ozOXY0bGFOcnZxZytiNGlt?=
 =?utf-8?B?bUJGL1NSeUJ5WTY0VEs0QmpoQ3A4eldOSldscEtyekxvV0VXMkxpU1BYYmdn?=
 =?utf-8?B?ZmVvZWFOTGt2Z0ovNExHRXowa1QwNkQ0MzkrMVZHczU5Rm5ZMUcwaG9KbmJR?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4891.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eac2ff2-2d23-434d-47e2-08d9f5053502
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 06:41:36.1994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WF8hLkeu2q/8SnbPOHBxWmZ/vMrbO4HVDtT0oMgvxjxaqxgPHiT1eWD2rXnm9i8Yy1b99BKL+w7Eerp0bTWAOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2000
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gVGhpcyBwYXRjaCBpcyBhbHJlYWR5IGluIHRoZSBTT0YgdHJlZSBhbmQgZm9yIHNvbWUg
cmVhc29uIEkgZGlkbid0IHNlbmQgaXQsIHNvcnJ5DQo+IGFib3V0IHRoZSBkZWxheS4NCj4gDQo+
IEhlcmUgYXJlIHRoZSB0YWdzIHdlIGNvbGxlY3RlZCBkdXJpbmcgdGhlIHJldmlld3MuDQo+IA0K
PiBSZXZpZXdlZC1ieTogQ3VydGlzIE1hbGFpbmV5IDxjdWpvbWFsYWluZXlAY2hyb21pdW0ub3Jn
Pg0KPiBSZXZpZXdlZC1ieTogQmFyZCBMaWFvIDx5dW5nLWNodWFuLmxpYW9AbGludXguaW50ZWwu
Y29tPg0KPiBSZXZpZXdlZC1ieTogUGllcnJlLUxvdWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vpcy5i
b3NzYXJ0QGxpbnV4LmludGVsLmNvbT4NCj4gDQoNCk9rLiBMZXQgbWUgc2VuZCBhIHYyIHBhdGNo
Lg0KDQpCcmVudA0KDQo=
