Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9200552AD98
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiEQVh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiEQVhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:37:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E938640A03;
        Tue, 17 May 2022 14:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652823435; x=1684359435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9Bejrb2N5XRimr02nG/zPZW0Sjj1KgzLlZgRkmPturw=;
  b=UnyJkWemArWqD//dmivB6ZM5aFDhpkienvdsOYeVkpxDoBA/3RjuqGYz
   7QdocyP7ftya3vw1pOiwbWDxk9vw915VBm/xfd/AoOjxfaqjVKv6/PRtJ
   FGzQtGjfhO0haCVk/zAApmU+pE+EqpW0v5fNrQGsHM2en2DB3sUNfvRlK
   NFLytACo/+hP2aiXmEhm0F9Phi/j2nnEwLCDKSN6Vc6bn7xxqZM2y0Xhy
   urk2fPjCuKcac6CES7JG3ZCXLrOqUShBhlfkbhq/xfdK5xzQ7RKVHa+5+
   6Hwvi+/QuDe7V8uYM6yRTanFXmOtlicQ6C7COuHWiuMuWOXudP7qpl+Sv
   g==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="159486023"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2022 14:37:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 17 May 2022 14:37:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 17 May 2022 14:37:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5Snft4EGqjZEm1wM7WC/4XL6xl3dyw+iCPTZaW0regPTQc2r/I5T2xskGxHOrOjQH7u8V9VTtBscWMweH3OB3pemHKHRc+nDww/vk0hVMmP6URDp82BWFMKDMZ+6COrlCJ3+xjpNYUKHaGYvtPRDChJKzMST7pquzMP0n5cHvfqIz5YSgaPgaxsWLAeHJGhRt9Tf2zSGS+npKBmnfeEhFtz9kzUQ8CGKyRuhXah7oJ0YNdEZuc3lnyyVC8OUXs/RC+lVwmS/iG4MvGBw5qMIe+KmNNC5ZNe4FodvYE5ZQKCpBtsWX/KpGknXiDpMP/3O1o+X95y1d3iuVyrFdu2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Bejrb2N5XRimr02nG/zPZW0Sjj1KgzLlZgRkmPturw=;
 b=nCX0jwDnXblV31fQmd5pqiE83ulqhxKKhLhmHrUnwNLz5xE2ncVeL4hIL4KUEf8tR1QX8yOUv8os6vGC9wBkIHTsgZ2TpJ3UFGInHjoLYj3slwdUa7IPUngaMWvUq2KoQ4rMR6nds+AP8jxXgHC8kjxeRTlOR0ERqpvfHYnU6JhNpkzEKkp5vKJYAtopeYfC8Fwss9SY6AvGdGqUD6N8TvEvzsM+M7ttfZK4rzbQQwt8mHOEJocWsmTMFoIU7A0szn7gI7NLfuC6m9D91BY12/m0hA3ECqHLrTW1za/9u4rmO+ueyD+hE5mpsUCJUNXnAc+WnIgYYuYNyeh/XN4wig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bejrb2N5XRimr02nG/zPZW0Sjj1KgzLlZgRkmPturw=;
 b=Z9V2gAFiulsx34XCOGQwbmEQVcWZe4+u3akDSrwh+HCZb4j2PFesYtY4kSWBx40FxusLCU4Cu2bCyEKQFpyZalqX4ZyVpbICvl+0fWR9NR/3vO1N3h4bM4A52GiCswhP5DkVV0qZDh+UzshvdxS82oL+ZPDwkwgVxEVyGqotFIw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB4288.namprd11.prod.outlook.com (2603:10b6:208:18c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 21:37:11 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%5]) with mapi id 15.20.5273.014; Tue, 17 May 2022
 21:37:10 +0000
From:   <Conor.Dooley@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <a.zummo@towertech.it>, <Daire.McNamara@microchip.com>,
        <Lewis.Hanly@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 1/2] rtc: Add driver for Microchip PolarFire SoC
Thread-Topic: [PATCH v3 1/2] rtc: Add driver for Microchip PolarFire SoC
Thread-Index: AQHYaP86qvMrzg0sT0yoCeeD82E3M60jkrUAgAAH0wA=
Date:   Tue, 17 May 2022 21:37:10 +0000
Message-ID: <1e438d33-45d1-d126-2c0e-5f6b00d3c979@microchip.com>
References: <20220516082838.3717982-1-conor.dooley@microchip.com>
 <20220516082838.3717982-2-conor.dooley@microchip.com>
 <YoQO9or6g2r3EU8w@mail.local>
In-Reply-To: <YoQO9or6g2r3EU8w@mail.local>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e119e5d0-0c11-4784-5f18-08da384d6641
x-ms-traffictypediagnostic: MN2PR11MB4288:EE_
x-microsoft-antispam-prvs: <MN2PR11MB42881186B93B92A47FE897D598CE9@MN2PR11MB4288.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HnKTUuuiTrO1mQdykt2YQBjeBkyRQZyUnOOwlNJd0nOdnOyjUUGUU9JrpBdFgj7fqU+WcLz1qfC5lqVIdu9t6+madN/tjJql+FdmxjAeyETu3/+RdJH4n7NqE0AgclpwwNRkWFAuJC3/gj+b7BU0GlRSX+w3hjeGLGhX9xKKLiYcqrdXQaXiP1u3LdS7rg30yrkSY2D+IKu9qFmil1ZCkHftcIa475Y74ChKdIucRbc0rm8WP/FexAeMGqhd3S1/MRtP/r3W5hqpiDevyU5ayBQtjYLZYTgtFcSlkZLrxtNjjr5P/1Vnrxfb8VOVPsZAtstEhsrK+MDSigzmuURI3ZRlMQhCHSUjaQtmgg+bUgVkoqn4SnLvg4nh2NK2myZHq1sBAv0mZ3UE0AWkxQRBPFvQNDk+CkS9sSPwfVrVyRZgBd3VDjNFUgbZscbDQirmgE4JeIEXyNniZ1PvnMQN60HbuH8eBEslFgrNgMsCsu8NNrepZlKRVxFgLqtCTX542lGr9zFXq0wqx7HuX553yRZs1j/MGGLPYDPBzvLIalLwCrTN85LEaiAYIjDmZzuF9yRU7eNg0aVon9hhl0HYhc07tYjSYHihqaqPBGJNd0XOGY3hQTcx1Fe0mdWeqtVp4VhFNOZbgE3m4l7BLf1m1LopM5xwEv4egEEy9omfp9N7JluhE80wLritmAOxXkZE6RX1rmEYpF8uKVidj/XMptkhORPni79oW+uy69gdN3+mRbFVTvcEC6GaYhternVrh/tSabgwULzlljBsDOllpqRws1UW4Dye38X7XEqAtqfJYbe5ypqCt8UDs5QhGDIF9nmT9Ka5JLESQVpaYeHRK03KfPsi6k4etLRq+RMZGk8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2616005)(53546011)(26005)(186003)(71200400001)(83380400001)(6486002)(38100700002)(966005)(5660300002)(31686004)(6506007)(8936002)(508600001)(36756003)(8676002)(31696002)(86362001)(2906002)(66476007)(64756008)(66446008)(4326008)(66946007)(91956017)(38070700005)(66556008)(76116006)(122000001)(54906003)(316002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDg1ckJ1Z3hGWGs2UndsZytyeDh4SUZTUkkwNzArUWdaV1RMbEliNHFxOXlY?=
 =?utf-8?B?Nm0yWFovU0RuVWRBbDRiQWlDTVl4YWpnaGJZTUV3aFo3YXZ5RmRuT0VMcTRM?=
 =?utf-8?B?cEpmZitJNTlFYlpCZjh2UW9hSC9zZEJzM1BHQ2h6U01MM1V2d1FTb1Z2bkpi?=
 =?utf-8?B?MDJSTWdHU2R4NWcwVjdCVi9OdHpQa0ViVG52VXY5bXo0NEc2c29KbGVoZFAr?=
 =?utf-8?B?ZlB0Y202S1VnNDNmS202SVlQTm1XaVJlbG1IeEovMWh6a0dZSG8yakgvVkxZ?=
 =?utf-8?B?VzlXSlE3Q3lJaU0rVm5oQXpEVnd6UHJxcExyeVZYV0I3cGo0SURPeUxQejVJ?=
 =?utf-8?B?d1J0Rm11dVBmR1NiR3dxOVd3b0dtWEFZS0d3ckF1dmNZWUVkWDVwRFhtZ1lW?=
 =?utf-8?B?ZnB1TTRzdGlCUDRLNE9oaEtTTUJ3TGdmYkVzY3Ridy9TYkFHOFI2YTFGTEor?=
 =?utf-8?B?SEpaWUFHbE5iM0ZISEc3MyttQUQvbFBmZ0RhenJmUXZMYTdqeHZFV3g5RFFQ?=
 =?utf-8?B?S1J6NVVDd21UNEhCZXMzZ0ZFYmY0NWxjdUsxNkNxNmtkQ3JJaGl4a3RTdWJU?=
 =?utf-8?B?eE8xWFpWa1dGTnpySytuMWcyNFhUSGkxeC9GOGFxdlo3akFkOE5OMktFbzR6?=
 =?utf-8?B?UExoc0ZrSzdudzdMK2Z5NzdaV2JXd25VajBLWmNWblBZZkJkRWU5UkFSamV6?=
 =?utf-8?B?NGJ0RFFyeEJEdzhSdFhPV24xcGFBWTBTTTUvTmJFRTI3NysySXZULzhNbWtr?=
 =?utf-8?B?OTUranRIZGx3M1dvQ0hPR3RmR1pzRWZPOTlXS1h0NGZOUUE5amlJTmtZaGVi?=
 =?utf-8?B?emc5MmxJRTZlZUlvQTVzd0NueTBhL0l6NWdXTFZMQi9GQzZCcjBlYUc3RjZR?=
 =?utf-8?B?dnpqYXdRVFlVTTdDK1hRSE56SG5jZ0EwQzh0aFJCZkpuRHdYQmV2ODJSMlBQ?=
 =?utf-8?B?eWdUQTR2YkVvQXdxaGNiaG9tUFhrdlpPSmplSnhRQmV5cXIrdkdwU0E5aVdt?=
 =?utf-8?B?YnJGenJDQnlvb2djZ1ZnU0hCaXZoZHkzSFZ2NlVRb0pjUWJZb1k0NllRYnps?=
 =?utf-8?B?WEN5aWwyWmJXSGlzU2p3aTBYZ3lianpvU2ZSK1FCNktBWDdvZ0l4WGR0SSsr?=
 =?utf-8?B?YmZYa2ZiVWpDTnpZcm5icVM1Unk1a0REbzFkZXE5SjZrS25hNUxuNFNTb3Fw?=
 =?utf-8?B?L3h1Zm9YNjZSdDl0cjJ4WUlPUlNzaXNueEpzejNFTEJMTlJRUlVPd2tJZFEx?=
 =?utf-8?B?ZTVxWk5nTTBHVlFjOGxFUytZV05ya3hQNjh1YkZBUGNwU2xQNmZxL3FGa1lv?=
 =?utf-8?B?UzVIbGkwYkI1V0kyUDMvYmxJL3N0MElyZERvSVNjMzFMa3Qzd2gvcTVJb1Bw?=
 =?utf-8?B?ZmtCa2pRcS8rUGZRM3JDcFhRelp5YzRUSmgvMklmYndoR2NRUzVqMmtjTkFX?=
 =?utf-8?B?QThCRXp3OHV4KzdRWGhSRWlyUG9SYVNPWktJUjBTaEN2OWxvTG5mb2wxSlhU?=
 =?utf-8?B?dXd3NTJxaDNaVjFrOXQ4RXFLcEdJTjhsbGZyNTRLL1JqNHNxSjg4emlLQm5F?=
 =?utf-8?B?cDNOZDJSVDFYWFpiTFM4d2prcXhzWkVESFArTm15VmRYTjNkaHVQWTRxZ25k?=
 =?utf-8?B?S1RWMSttWXpKUVAwTWFzOWphR1FqampackJWS1dWOVZjYmJBYmxNamcwQWtK?=
 =?utf-8?B?SFh0SGEyZE1yM1puU3hDQkxQUUM5NUE5c3dJdjhNRFFiWGpaNlQyWm1MNWhJ?=
 =?utf-8?B?Q24xYzVZbHZkRmsvamFFTm1VcWhNUlVOalZSUE9yTlYvNDMzY01lSGcvOXVK?=
 =?utf-8?B?TjZwQjJ5R3lIejBHYUdMM1RpMHBMaWpuN0x6Nlo0WDNzdDlRMTIxb2F5Rjgz?=
 =?utf-8?B?Y2pZNEVHbHVra2pwNXlDc1FhK2lLVCsxL0xzM2FyNE8zNlFlUmhSNUtxVTNa?=
 =?utf-8?B?cCtoeGthVEZtb3M1TkxESG9HVW5WdkZqMFl5K04vYW1xcUdLUWNsNDRUellV?=
 =?utf-8?B?QkZOUy9HT1VRYmttNXppRkRFWnhhdkxzVXFURG82alRFdXlvMTcvNGdHOVVQ?=
 =?utf-8?B?UkY3UisydTdndWk3ZXhKeDA3dWZyeS9oUEpqaDZFd1BWdndZU3ZCSFM2MGR5?=
 =?utf-8?B?QjZub1dvNWJwUmRxc0o2djBBcmM4NXZ1L2FZWW9KeUEzMmwxS29oRkFtYklu?=
 =?utf-8?B?K3pBSjVtei9uNENodnVTcFo1VUZPM2YwNjVidVlIMzdCd2JYb1dtVGpKVWdJ?=
 =?utf-8?B?NWRXUGFsMGxyNDhBS3NaQzNPOThrUWtzeFhvNzVRSHpYNGRaZk56bFR4QldM?=
 =?utf-8?B?bVlBczV3cGoxQlR0dWFPc2daOFhXYlZCUnJPd0x6RlQvempGVUYycUhIUFB2?=
 =?utf-8?Q?DG5oIlUUMv9PLmCQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09B2A09AAA98DE4483FBC1683590D1B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e119e5d0-0c11-4784-5f18-08da384d6641
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 21:37:10.4919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V6sB4Pbo3oglqgwO9iotWZ6z+JX57bPTqWpoFeBfg3lgY77dpiDruLxDzvSinpZgZxOxWJybF7KQFlMxyOMiuOkHxaCNsbgZcjQ6jVblGcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4288
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcvMDUvMjAyMiAyMjowOSwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGVsbG8sDQo+IA0KPiBPbiAxNi8wNS8y
MDIyIDA5OjI4OjM4KzAxMDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4+ICtzdHJ1Y3QgbXBmc19y
dGNfZGV2IHsNCj4+ICsgICAgIHN0cnVjdCBydGNfZGV2aWNlICpydGM7DQo+PiArICAgICB2b2lk
IF9faW9tZW0gKmJhc2U7DQo+PiArICAgICBpbnQgd2FrZXVwX2lycTsNCj4gDQo+IEkgYmVsaWV2
ZSB0aGlzIGlzIG9ubHkgdXNlZCBpbiAucHJvYmUgc28geW91IG1ha2UgaXQgbG9jYWwgdG8gdGhp
cw0KPiBmdW5jdGlvbi4+IA0KPj4gK307DQo+PiArDQo+IA0KPiANCj4+ICtzdGF0aWMgaW50IG1w
ZnNfcnRjX3JlYWR0aW1lKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHJ0Y190aW1lICp0bSkN
Cj4+ICt7DQo+PiArICAgICBzdHJ1Y3QgbXBmc19ydGNfZGV2ICpydGNkZXYgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCj4+ICsgICAgIHU2NCB0aW1lOw0KPj4gKw0KPj4gKyAgICAgdGltZSA9ICgo
dTY0KXJlYWRsKHJ0Y2Rldi0+YmFzZSArIERBVEVUSU1FX1VQUEVSX1JFRykgJiBEQVRFVElNRV9V
UFBFUl9NQVNLKSA8PCAzMjsNCj4+ICsgICAgIHRpbWUgfD0gcmVhZGwocnRjZGV2LT5iYXNlICsg
REFURVRJTUVfTE9XRVJfUkVHKTsNCj4gDQo+IEFyZSB0aGUgcmVnaXN0ZXJzIHByb3Blcmx5IGxh
dGNoZWQgb24gYSBEQVRFVElNRV9VUFBFUl9SRUcgcmVhZD8NCg0KSXQncyBhIGdvb2QgdGhpbmcg
eW91IGFza2VkIC0gSSB3ZW50IHRvIGRvdWJsZSBjaGVjayBhbmQgdGhlc2UgcmVhZHMgYXJlDQpi
YWNrd2FyZHMuIC9mYWNlcGFsbQ0KQSByZWFkIGZyb20gdGhlIHVwcGVyIHJlZ2lzdGVyIHdpbGwg
YWx3YXlzIGJlIGFsaWduZWQgd2l0aCB0aGUgbGFzdCByZWFkDQpvZiB0aGUgbG93ZXIgcmVnaXN0
ZXIuIFN0dXBpZCBvdmVyc2lnaHQsIHNvcnJ5Lg0KDQo+IA0KPj4gKyAgICAgcnRjX3RpbWU2NF90
b190bSh0aW1lICsgcnRjZGV2LT5ydGMtPnJhbmdlX21pbiwgdG0pOw0KPiANCj4gcmFuZ2VfbWlu
IGlzIG5ldmVyIHNldCBzbyBpdCB3aWxsIGVuZCB1cCBiZWluZyAwLiBJIGd1ZXNzIHlvdSBjYW4g
YXZvaWQNCj4gYSBidW5jaCBvZiBhcml0aG1ldGljIGluIGFsbCB0aGUgZHJpdmVyLiBPZmZzZXR0
aW5nIHdpbGwgaGFwcGVuIGluIHRoZQ0KPiBjb3JlIHdoaWNoIHdpbGwgcHJvYmFibHkgbmV2ZXIg
aGFwcGVuIGFueXdheSBiZWNhdXNlIHRoZSBtYXggeWVhciBpcw0KPiAxNDEzMzguIEkgZ3Vlc3Mg
d2Ugd2lsbCBhbGwgYmUgZ29uZSBieSB0aGVuIDspDQoNClNHVE0sIGluY2x1ZGluZyBub3QgYmVp
bmcgYXJvdW5kIGluIHllYXIgMTQxMzM4Li4uDQoNClRoYW5rcywNCkNvbm9yLg0KDQo+IA0KPj4g
Kw0KPj4gKyAgICAgcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPiANCj4+ICtzdGF0aWMgaW50IG1w
ZnNfcnRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiArew0KPj4gKyAg
ICAgc3RydWN0IG1wZnNfcnRjX2RldiAqcnRjZGV2Ow0KPj4gKyAgICAgc3RydWN0IGNsayAqY2xr
Ow0KPj4gKyAgICAgdTMyIHByZXNjYWxlcjsNCj4+ICsgICAgIGludCByZXQ7DQo+PiArDQo+PiAr
ICAgICBydGNkZXYgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKHN0cnVjdCBtcGZz
X3J0Y19kZXYpLCBHRlBfS0VSTkVMKTsNCj4+ICsgICAgIGlmICghcnRjZGV2KQ0KPj4gKyAgICAg
ICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4+ICsNCj4+ICsgICAgIHBsYXRmb3JtX3NldF9kcnZk
YXRhKHBkZXYsIHJ0Y2Rldik7DQo+PiArDQo+PiArICAgICBydGNkZXYtPnJ0YyA9IGRldm1fcnRj
X2FsbG9jYXRlX2RldmljZSgmcGRldi0+ZGV2KTsNCj4+ICsgICAgIGlmIChJU19FUlIocnRjZGV2
LT5ydGMpKQ0KPj4gKyAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihydGNkZXYtPnJ0Yyk7DQo+
PiArDQo+PiArICAgICBydGNkZXYtPnJ0Yy0+b3BzID0gJm1wZnNfcnRjX29wczsNCj4+ICsNCj4+
ICsgICAgIC8qIHJhbmdlIGlzIGNhcHBlZCBieSBhbGFybSBtYXgsIGxvd2VyIHJlZyBpcyAzMTow
ICYgdXBwZXIgaXMgMTA6MCAqLw0KPj4gKyAgICAgcnRjZGV2LT5ydGMtPnJhbmdlX21heCA9IEdF
Tk1BU0tfVUxMKDQyLCAwKTsNCj4+ICsNCj4+ICsgICAgIGNsayA9IG1wZnNfcnRjX2luaXRfY2xr
KCZwZGV2LT5kZXYpOw0KPj4gKyAgICAgaWYgKElTX0VSUihjbGspKQ0KPj4gKyAgICAgICAgICAg
ICByZXR1cm4gUFRSX0VSUihjbGspOw0KPj4gKw0KPj4gKyAgICAgcnRjZGV2LT5iYXNlID0gZGV2
bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPj4gKyAgICAgaWYgKElTX0VS
UihydGNkZXYtPmJhc2UpKSB7DQo+PiArICAgICAgICAgICAgIGRldl9kYmcoJnBkZXYtPmRldiwg
ImludmFsaWQgaW9yZW1hcCByZXNvdXJjZXNcbiIpOw0KPj4gKyAgICAgICAgICAgICByZXR1cm4g
UFRSX0VSUihydGNkZXYtPmJhc2UpOw0KPj4gKyAgICAgfQ0KPj4gKw0KPj4gKyAgICAgcnRjZGV2
LT53YWtldXBfaXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsNCj4+ICsgICAgIGlmIChy
dGNkZXYtPndha2V1cF9pcnEgPD0gMCkgew0KPj4gKyAgICAgICAgICAgICBkZXZfZGJnKCZwZGV2
LT5kZXYsICJjb3VsZCBub3QgZ2V0IHdha2V1cCBpcnFcbiIpOw0KPj4gKyAgICAgICAgICAgICBy
ZXR1cm4gcnRjZGV2LT53YWtldXBfaXJxOw0KPj4gKyAgICAgfQ0KPj4gKyAgICAgcmV0ID0gZGV2
bV9yZXF1ZXN0X2lycSgmcGRldi0+ZGV2LCBydGNkZXYtPndha2V1cF9pcnEsIG1wZnNfcnRjX3dh
a2V1cF9pcnFfaGFuZGxlciwgMCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2
X25hbWUoJnBkZXYtPmRldiksIHJ0Y2Rldik7DQo+PiArICAgICBpZiAocmV0KSB7DQo+PiArICAg
ICAgICAgICAgIGRldl9kYmcoJnBkZXYtPmRldiwgImNvdWxkIG5vdCByZXF1ZXN0IHdha2V1cCBp
cnFcbiIpOw0KPj4gKyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKyAgICAgfQ0KPj4gKw0K
Pj4gKyAgICAgLyogcHJlc2NhbGVyIGhhcmR3YXJlIGFkZHMgMSB0byByZWcgdmFsdWUgKi8NCj4+
ICsgICAgIHByZXNjYWxlciA9IGNsa19nZXRfcmF0ZShkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwg
InJ0Y3JlZiIpKSAtIDE7DQo+PiArDQo+PiArICAgICBpZiAocHJlc2NhbGVyID4gTUFYX1BSRVND
QUxFUl9DT1VOVCkgew0KPj4gKyAgICAgICAgICAgICBkZXZfZGJnKCZwZGV2LT5kZXYsICJpbnZh
bGlkIHByZXNjYWxlciAlZFxuIiwgcHJlc2NhbGVyKTsNCj4+ICsgICAgICAgICAgICAgcmV0dXJu
IC1FSU5WQUw7DQo+PiArICAgICB9DQo+PiArDQo+PiArICAgICB3cml0ZWwocHJlc2NhbGVyLCBy
dGNkZXYtPmJhc2UgKyBQUkVTQ0FMRVJfUkVHKTsNCj4+ICsgICAgIGRldl9pbmZvKCZwZGV2LT5k
ZXYsICJwcmVzY2FsZXIgc2V0IHRvOiAweCVYIFxyXG4iLCBwcmVzY2FsZXIpOw0KPj4gKw0KPj4g
KyAgICAgZGV2aWNlX2luaXRfd2FrZXVwKCZwZGV2LT5kZXYsIHRydWUpOw0KPj4gKyAgICAgcmV0
ID0gZGV2X3BtX3NldF93YWtlX2lycSgmcGRldi0+ZGV2LCBydGNkZXYtPndha2V1cF9pcnEpOw0K
Pj4gKyAgICAgaWYgKHJldCkNCj4+ICsgICAgICAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2LCAi
ZmFpbGVkIHRvIGVuYWJsZSBpcnEgd2FrZVxuIik7DQo+PiArDQo+PiArICAgICByZXR1cm4gZGV2
bV9ydGNfcmVnaXN0ZXJfZGV2aWNlKHJ0Y2Rldi0+cnRjKTsNCj4+ICt9DQo+PiArDQo+PiArc3Rh
dGljIGludCBtcGZzX3J0Y19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+
ICt7DQo+PiArICAgICBtcGZzX3J0Y19hbGFybV9pcnFfZW5hYmxlKCZwZGV2LT5kZXYsIDApOw0K
PiANCj4gVGhpcyBpcyBub3Qgc29tZXRoaW5nIHlvdSB3YW50IHRvIGRvIGlmIHlvdSB3YW50IHRv
IHdha2UgdXAgZnJvbQ0KPiBoaWJlcm5hdGUgb3IgYW55IHNpbWlsYXIgc2xlZXAgc3RhdGUuDQo+
IA0KPj4gKyAgICAgZGV2aWNlX2luaXRfd2FrZXVwKCZwZGV2LT5kZXYsIDApOw0KPj4gKw0KPj4g
KyAgICAgcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIG1wZnNfcnRjX29mX21hdGNoW10gPSB7DQo+PiArICAgICB7IC5jb21wYXRpYmxl
ID0gIm1pY3JvY2hpcCxtcGZzLXJ0YyIgfSwNCj4+ICsgICAgIHsgfQ0KPj4gK307DQo+PiArDQo+
PiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXBmc19ydGNfb2ZfbWF0Y2gpOw0KPj4gKw0KPj4g
K3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG1wZnNfcnRjX2RyaXZlciA9IHsNCj4+ICsg
ICAgIC5wcm9iZSA9IG1wZnNfcnRjX3Byb2JlLA0KPj4gKyAgICAgLnJlbW92ZSA9IG1wZnNfcnRj
X3JlbW92ZSwNCj4+ICsgICAgIC5kcml2ZXIgPSB7DQo+PiArICAgICAgICAgICAgIC5uYW1lID0g
Im1wZnNfcnRjIiwNCj4+ICsgICAgICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gbXBmc19ydGNf
b2ZfbWF0Y2gsDQo+PiArICAgICB9LA0KPj4gK307DQo+PiArDQo+PiArbW9kdWxlX3BsYXRmb3Jt
X2RyaXZlcihtcGZzX3J0Y19kcml2ZXIpOw0KPj4gKw0KPj4gK01PRFVMRV9ERVNDUklQVElPTigi
UmVhbCB0aW1lIGNsb2NrIGZvciBNaWNyb2NoaXAgUG9sYXJmaXJlIFNvQyIpOw0KPj4gK01PRFVM
RV9BVVRIT1IoIkRhaXJlIE1jTmFtYXJhIDxkYWlyZS5tY25hbWFyYUBtaWNyb2NoaXAuY29tPiIp
Ow0KPj4gK01PRFVMRV9BVVRIT1IoIkNvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hp
cC5jb20+Iik7DQo+PiArTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KPj4gLS0NCj4+IDIuMzYuMQ0K
Pj4NCj4gDQo+IC0tDQo+IEFsZXhhbmRyZSBCZWxsb25pLCBjby1vd25lciBhbmQgQ09PLCBCb290
bGluDQo+IEVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCj4gaHR0cHM6Ly9i
b290bGluLmNvbQ0KDQo=
