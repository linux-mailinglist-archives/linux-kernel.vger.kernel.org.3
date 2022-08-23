Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BE459ECA6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiHWTo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiHWToG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:44:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC4E57548;
        Tue, 23 Aug 2022 11:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661280380; x=1692816380;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QjTIWxxsNjpgDGpIubNF4uThl6/BrKdMSnFndrkjQec=;
  b=QuOjQyRfje9Ywsf86nxBkI4KSJ1MUFJWwHO82dlG4nfFEmPgg/MQei13
   jXQwMKndriK0M8Jp+bJteymKHliVPhmz5f9C7Rh/dGUnWr4sYwjuJV0wt
   uG6HDyCrLq61fZcesA2DptkwvoBimbd5xhVqPZnS9pqMDKwJuV+pv0PTG
   oZrjFWFHDwiTcqkIAL7YLTmmgUYHszpA6QychpCN3iKpl4OUWozeFd0ux
   vKlicZT1uvR8rYcKTX/94Wb21y/H6u1AxBVghN0lWDAUz4InGJ4bCP8On
   GDXTMtpI6i9ibnWoJ7SzDGTH0tpVYfL+OzwKNwBCFEROnBd6MMVccRVpo
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="170590321"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2022 11:46:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 23 Aug 2022 11:46:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 23 Aug 2022 11:46:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBuHt7lLEccEzFC4ID4TI1CCtMBGriWJi7VZpDljKYwFhIEYv4eMumHC9DrbJhCMdfo9Y1EidO8Jw9qyWWo2GKkPGEOhPi5ouNIJ20nomWXL8au9tui0zk3D54ByyMClQkMyjZMn+LRB5IM5PvvBOPhw2XZlOWLYq2wvQXhRAPgfYkYJC0GSdKuILKRg9JzjIZUYhwgDJH4o4gqAYFdlG6Qt9uRqszAbv0xQR9FbxrxIstoYfGz0yQZxusJIqCuVCoAK/mavj7Ig10mTd48qJcXtW7IhsPrELyqpa0qjsbwSvrRn0fMLNI1N6DOzLFjvzt0NM13gs8VGzcGPekqIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjTIWxxsNjpgDGpIubNF4uThl6/BrKdMSnFndrkjQec=;
 b=l2fqYtn0eUFeRgR3twtXVQOUMiyuf68JKytz6wtM1n/7nnD0d9FG8UXan3ThDq7uOr7/KIadEzdMnpXVdd/LxUQ/Cl6sWuka1oYoTlcAYr6Fai3EBhO46QtCCiLiNCfbr0p3aF/YqBJdoWbL5D+BW6bCxUCrMOXrHKcikDPfLeWD67iVoMmnNHjE/4kWQN0A1yRN/s7pcKxydFImzthArN/+kUk8g9lMk6NGTvgcflOsCDgU4s0EaaIiJyy8DPQndILEdB28rnSSB/2tGIBRvk4KZb6P/8JuWMK4zC8pQ1NATeKmMFRSIaW32rAiuHh4cyLRpLOXgke+LKngvLduuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjTIWxxsNjpgDGpIubNF4uThl6/BrKdMSnFndrkjQec=;
 b=LQ5f6xLReFACt+aumQ+Xrljy256SdSgVqOJe3UlgvSpEb+m5ekPeRYpM9qsaAOeGleNFmPn46jIKox22lQ8E8TGZqvFJdCYARW2LQyJiHxbeQHK9oMC+g1IBrwdtWJ4uQGBXie1iiAQgseaiPN7houIscQS8tBdky2FPNQ3Yrlw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR1101MB2140.namprd11.prod.outlook.com (2603:10b6:4:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 18:46:10 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 18:46:10 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jassisinghbrar@gmail.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Daire.McNamara@microchip.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <Conor.Dooley@microchip.com>
Subject: Re: [PATCH 0/3] MPFS mailbox fixes
Thread-Topic: [PATCH 0/3] MPFS mailbox fixes
Thread-Index: AQHYqMq0ifIJ8TBe/0m/7e784yGH1a287naAgAAArwCAAAB9gA==
Date:   Tue, 23 Aug 2022 18:46:10 +0000
Message-ID: <5e1d3d9d-de5b-d6e9-022b-c5c67e85f4e6@microchip.com>
References: <20220805125618.733628-1-conor.dooley@microchip.com>
 <814208de-e3e4-852b-766d-14889a6c3c91@microchip.com>
 <CABb+yY1DtHmknUPTzp6OiZsFL5zgwptSREfwzzX9d3EW46V0Yg@mail.gmail.com>
In-Reply-To: <CABb+yY1DtHmknUPTzp6OiZsFL5zgwptSREfwzzX9d3EW46V0Yg@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77da975b-e46d-4a4b-875c-08da8537bf21
x-ms-traffictypediagnostic: DM5PR1101MB2140:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cUjXJ3Ofl4NRgHcWe8eTNE275hwygPQ4FiZUPXfBLarJNWFQJj96JpJsr12Q6DtS1krNF/vxmwD9jMf1fd4fUb1nBxwbUKMVGDR/a4wG4CIOVniLBNBJ0hjCM6oQnzzLw7wXP7ex5U6QtnI0fdUE4VkFsUSoZqmrjDBBPbd/K7OrUejNVDCxTQ+FvjMq1a8W4SiOx4NBO4D4+WHX6Ov0SOEHBy6rwRaIzurvoNC97D0gzoj+wYzYumT6gB3PIzm2WvnFPHI6IKCF9E8YnyofQeVvJtW4i+MWXyV+YbUk+KxaaxafreER5uBqwczATMvWh6sjVEGNobSApPNQLniTWHqgneht93iqzxaITi8Vy48s0aCdqsXnULJLga7Pw5dgV0qnZRe4ZHluck+amfYzqjNSOOApMNdAf6HN9dy9LBbejZHlKduZevsJWSi9mm7xk1RuwgH3Pgr/Cx+kJ4Qy+v4bQLi9Gr+1f28bh3T5garWRHtS8qTVUukQbBsRAKxwV0THdGZJ854GwoRD2hwVbjgqTi5FQY6bPWUGGtX39S6Zg1OQVSlEcQ3aRFXIhR3zZJTZ5FsbSnBH48xgjEAontVwXjZlCl5wdujyrXntCbq1aW4ZMbIvmzo+AKbTG5Jp189jIhg7tQWlZk4a72vhu1dC3XXPgUH+GsInjE6vlrxmVU6vv2pyZPbeO93wojtLoAgyq7hIOaWmWWnOPNpGIdwoGcKN4Z971WJT+C8Vp80tZDu76S7PhW/86+CKde0Guf60Z1O1maBpaCWCsDLRF1IEweKuDIjpCNUlTFyIioZPmjFsVhbRjiicKOBC6pc3UY6fXnly8y0/n/UXIVOOkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(39860400002)(376002)(346002)(6486002)(478600001)(71200400001)(122000001)(83380400001)(2906002)(41300700001)(15650500001)(4744005)(36756003)(31686004)(38100700002)(8936002)(186003)(31696002)(4326008)(86362001)(66476007)(8676002)(66556008)(54906003)(91956017)(64756008)(76116006)(6916009)(66946007)(26005)(2616005)(6506007)(107886003)(53546011)(5660300002)(66446008)(6512007)(316002)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWhvUjJqb3NTSHBGT2FNYVR3L3VqN1lQY3YzWDBqbDZ4cTZXdjJFT3pWeDdh?=
 =?utf-8?B?djNGTStIOXZmWjM0OUJ6cnFJOTVxUmRjbncrT3drMlRBTHZhb290a1NTQ3Fs?=
 =?utf-8?B?S3E2Ums1c291aFlOaWxuN3Bwb2NGUGhCQVNSQXhBRmdCUERST3lqZTR4Uys1?=
 =?utf-8?B?dFVYZzdoK3V0c3hGaCt4ZS8zU0JlYTB6blJxaFFjK2FYcy8yaUNjSms3cjE3?=
 =?utf-8?B?K3RVQnVKbXRabWJhK2ljUS9OR3NxeUNsbjFoeUxvd3daRFM3NDNSdFJ4UG05?=
 =?utf-8?B?aFFxUFFYbFZQQWNZUkorVlBqck5jUUlHQjlHempzTmhYSjQ2c3RiQkxaVnJS?=
 =?utf-8?B?YzEvZlFkODFxeU1iOVc0azdPeEQ1eERRY0xvUXY4YXBXQ1M2M2JudFpCZUNI?=
 =?utf-8?B?M1B4cXRhNW1Id1hLRzMvbG1UMHVDRDUxNFBJcU40bllaZUlvTlcwU1JYNlgr?=
 =?utf-8?B?eWUrTm9HaWNXUEFsS2MxYzlHSkIySUs2OWpXc3dVd1pHTkRPZmkyOE9yRzA1?=
 =?utf-8?B?OGpGdFI2MjY3bjNTclRWekh3UXJxcW1hZXhIQklOT1l0UWpLc2d5b01QNTlP?=
 =?utf-8?B?UlNVTVdBMWErV3VhNEJHblJycFBXMm96U2V3U1ZPUkpBd0VyUUR3ckg5R2tK?=
 =?utf-8?B?LzFmV1RuRjJDVHRzejZTTU1ZV0xOay9Rd0Z2OXdicFpwendDYXpRL3BGc00x?=
 =?utf-8?B?M3gweit0aEt2eW5LdnlkRlNIZnM3b3lPUWtDVXZIeFRMeExxYnpqeTRCeHhN?=
 =?utf-8?B?STNrNUM4MWlGN3N0bTZ3ay9wcmlaZ1k3ak5BNDN0TzU0WXZrZ1pBZmFOTE1B?=
 =?utf-8?B?a1dVR2FWM3BobFhabW9vRjVSQTZUS3hyMWhLOWJRTU1rZmUwdGkrZDZidW9B?=
 =?utf-8?B?dUcrWW85NGpyaUZVZlZ6TmdIcmtWbUxmZzYvTDJpUitYQXljQllzNElUMzYw?=
 =?utf-8?B?SmN5UURSWDNJbUNGQ01ISUZ2cnJzR1YxU0hrZzFIWVYvTnJHaU44VjRnZzBD?=
 =?utf-8?B?cXd5aVRBbUJZODdObCsvMmpSZ3JTcGRudEFEMTBIakN2SWpOcml0NDNVU3Zz?=
 =?utf-8?B?R2RUeFpIZjQrc2NhVVl2ampiR3hQTFRFQ1pQM0cwZTNJbFJCWUcwZGdqSWUr?=
 =?utf-8?B?RGZVbUpUWURaWUpwaVNoU3VWUTVhYm9scFJEWEpmVjJZemM1ZkNYNnI0dEpY?=
 =?utf-8?B?TU9HTEJ4eVJvM3dOMWljczBIVU85TlBVN25pcjZ4V1MwSk4rc2NaZDlaU3hP?=
 =?utf-8?B?Wmg1dmxyZWhCSUVPaEhQNW5NbnFIK2FTb2ROQ01xUEV3MEhXRkJHQmhQNXBi?=
 =?utf-8?B?TkQwVVdzSnMrZEFPZnA1b0xvc3UzRXZNdWhIS1M0WmNrQms4Mm8wQlZsM2tJ?=
 =?utf-8?B?cnlJdXpsOEtzWmhzMlN6S3JkaHBHenNRR3ExNFJ0a0tqYnFFRHcrYzRxUVp4?=
 =?utf-8?B?ZjJhSkxrSm1uS1NISEtucXpvRVNicjJYaEh1N2RFUVRhV0pGd2JoQ203MnBD?=
 =?utf-8?B?UVpGT3ZoVDlYenVySk5uT2VNUkh6S3IvR29lUitRK2l3THpUWjNlM0o3SnBn?=
 =?utf-8?B?TGllLzY3T2tjcHplc0lxRU5vQTB0U0l6b0hQRlE5TGw4Z3Y2R2V6NHZUMHd6?=
 =?utf-8?B?MVJKbkYxbnJobmJQSkxiZStLSnZLd2xlcWV3T0gvY1I5QTkrL2RKV2RwZmd6?=
 =?utf-8?B?SmFqSWNZRkxSNE1wc3RyRkZGc3Q0UDk0bnk4dGdySkQ2NHZrSHdtUlNrZklE?=
 =?utf-8?B?R09uY2Rhb2g4NGMxZjB3YVM3cUNwNFdyTVdnRHlNcHhubUxONkJtbXhDdlZt?=
 =?utf-8?B?YmNTOXV1dXBsY2FwODJPMzhoaWt2ckJwN1k1RXZUaG5kQ3JPbnFxM0F0ZFg0?=
 =?utf-8?B?Q3M0SGhtdXVpWXRkeFdPajJXZkhhd0J1MDAwTTN6cUExZmhqZnI2UXptZnZZ?=
 =?utf-8?B?b2NROUNJTzluR005enhnR3FCNXpSRkdadDF2VC9ZblFEazFTdlJmenBRemdx?=
 =?utf-8?B?NjJ6SkhLK0cyWjAvc1Zmbk1KUkJ6aWVrelk3UDZEYzNyalBwaC9pR2hFdFhk?=
 =?utf-8?B?SE5jYXR4YXBON0Uwd09BTTl1V0t6bE1qUStFQ00zTGFQVUdxK3lLaG4wenRx?=
 =?utf-8?B?NnN5R2FxTEpnV2NFU0I0NXdSQkxJK1l1b2xZM3pZWWtBRGZ2UkJpNkZrMURV?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <572AB38BC4DA464182DCFBCB4745F752@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77da975b-e46d-4a4b-875c-08da8537bf21
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 18:46:10.2531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJZQeC7wZ610KvzksW9CoWFu0+QaZWP5YH1A6wCJ9TRul9XM9/r3M0kwcKPqNXL/owBG0df7cY1V+MApOyEwJAgxwigT2795/3BUO95Tp28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2140
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMvMDgvMjAyMiAxOTo0NCwgSmFzc2kgQnJhciB3cm90ZToNCj4gT24gVHVlLCBBdWcgMjMs
IDIwMjIgYXQgMTo0MiBQTSA8Q29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20+IHdyb3RlOg0KPj4N
Cj4+IE9uIDA1LzA4LzIwMjIgMTM6NTYsIENvbm9yIERvb2xleSB3cm90ZToNCj4+PiBIZXkgYWxs
LA0KPj4+DQo+Pj4gSSBzcG90dGVkIGEgY291cGxlIG9mIGJ1Z3MgaW4gbXkgbWFpbGJveCBkcml2
ZXIgd2hpbGUgZGV2ZWxvcGluZyBzb21lDQo+Pj4gbmV3IGZlYXR1cmVzLiBOb25lIG9mIHRoZSBm
ZWF0dXJlcyB0aGVzZSBidWdzIHJlbGF0ZSB0byB3ZXJlIGluIHVzZSBzbw0KPj4+IHRoZXkndmUg
Z29uZSB1bm5vdGljZWQgdW50aWwgbm93LiBUaGUgYmluZGluZyBzY3Jld3VwIGlzIHVuZm9ydHVu
YXRlDQo+Pj4gYW5kIEkgZG9uJ3QgcmVhbGx5IGtub3cgaG93IEkgbWlzcmVhZCB0aGUgcmVnaXN0
ZXIgbWFwIHNvIGJhZGx5Lg0KPj4+DQo+Pj4gSmFzc2k6DQo+Pj4gTm90IHN1cmUgaWYgeW91IHBy
ZWZlciBkZXZlbG9wZXJzIHRvIGFkZCBhIENDOiBzdGFibGUgb3Igbm90IHRvIHBhdGNoZXMNCj4+
PiBzbyBJIGhhdmUgbGVmdCB0aGVtIG91dCwgYnV0IEkgd291bGQgbGlrZSB0byBzZWUgdGhlbSBi
YWNrcG9ydGVkLg0KPj4NCj4+IEhleSBKYXNzaSwNCj4+IEhhdmUgeW91IGp1c3Qgbm90IGhhZCBh
IGNoYW5jZSB0byBsb29rIGF0IHRoaXMgeWV0LCBvciBhcmUgeW91IHdhaXRpbmcNCj4+IGZvciBt
ZSB0byByZXNlbmQgd2l0aCB0aGUgZXh0cmEgZml4ZXMgdGFnIGFwcGxpZWQ/DQo+Pg0KPiBQbGVh
c2UgcmVzZW5kIHdpdGggZml4ZXMgdGFncy4NCg0KQ29vbCwgd2lsbCBkbyB0b21vcnJvdy4NClRo
YW5rcyBmb3IgdGhlIHByb21wdCByZXBseSENCkNvbm9yLg0KDQo=
