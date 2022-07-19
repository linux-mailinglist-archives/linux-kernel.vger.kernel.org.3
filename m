Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE0E57943D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiGSHdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbiGSHdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:33:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DDD33E0B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658216010; x=1689752010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vK+LoGi4wJzrpr8SjTTQ55mnKQTqQ6ntaR6mnGIw2XU=;
  b=UGhJlAzu2gUBAr2nV8+vbQ59HirQJj2y/vhrFikyEa9OKCw9d5BU9cFQ
   H5cgflcVnJxmYVeZw3+Wu5cquNNVwJ2Y+JEgEQQeL9jasOg78h83beOdq
   OZ+2LnvotfjGCb2PgbIva4MkY33pogAYYrPcQbcZ+XrkfuDNpCBrDyps/
   /TcPoa7LWuGiMuovaceMOcPx3XEv6jy/219x2a+f+nONWWprWmkTiB5iz
   HFclAt/yr3WfTMcu/wGjTexsxXJZhB3F7EYuhrSXc3g2U0pzNMz1DA4NQ
   5A2KwiOuBWYZhZEwMqPrh+SNiZJHWX2SFMUcJGcaZ5ZY5cB5dTc2r6Jo/
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="168460023"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 00:33:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 00:33:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 19 Jul 2022 00:33:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRRwZmcStIYoWJ0X6p9SffSrVE/iUkyEUmVkm7Z7ImCBaDxIak7YOtiHFpK1k7vzMxs43YG7luOsh8xRSshYWfc7h8FMowJHsocNNKHB/azZgQheissIW/SeA+ggeqPiAV5EY7huiXeRtCZx3lobKLYZ6P5g1FF+Y6NYk/Lk+aam6Nw+MvozwLyBuRBNCtOmtZF1dchWl5l5NgheqEu306qNAzUAKBvkuYtz2hyEmsArrpptf4CGbSrTvt+OK3gIOsTmjr5jtF3Aw9Ne5zcC+ZLn968dhKO7LKPXWA/nPBm62shwx/KkMmsgzpdCa9rrfb9SEBvUzfbvEE4MTiqDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vK+LoGi4wJzrpr8SjTTQ55mnKQTqQ6ntaR6mnGIw2XU=;
 b=ldCzHLge7whK1fDYevflfXqfOICPTCU56tjpvOJrumpJjtuR0r1bmr/jykUXUt4yjLIel3HOeTDAkpvqoPNNqWFk8xzUAHjuWcuq5XNLZ+qbnQedbiqOpeuymMU5lh1eawbc+KLFZ9bCfFVHOMuPBnxpPFFZVLJu4RPmeb6+ypRxN17N8oNFHNGy/lp/qrjMMyDfQzaKHgoy+VG5E/l6Hw2xwBrdqwQLjvcgk9FgbDGtSkeSFfKMmHIH+tJ97S5g1BDSKHPlU4Vy/LjDE44C2jMimMLdkkEc8uFLCJ3Bmbty+UY1EsYuQtxlP7yPgQt/hnBRu343xkJEmXGCdHILBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vK+LoGi4wJzrpr8SjTTQ55mnKQTqQ6ntaR6mnGIw2XU=;
 b=b/2o88AMCMjj7RGOHWVOoFI3OiQ+Yha11p/U2nuCZnFei3n2Y0OXTJbhM3NXZSqjiovzK8hjzSsaDn6IeYl+G1PKF1fINfdtEdMKSN1Rcmhq9ax7Y6WrRabDYVq79dc//cBcleCgOS0RXEhsrREyp3ykM4VO4eAeUqPPKFLgNQM=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 CY5PR11MB6533.namprd11.prod.outlook.com (2603:10b6:930:43::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Tue, 19 Jul 2022 07:33:27 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:33:26 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
Thread-Topic: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
Thread-Index: AQHYmzRwuAFPdIe45ECo1RhI0CKwAw==
Date:   Tue, 19 Jul 2022 07:33:26 +0000
Message-ID: <7365146d-b001-2a14-014d-62a6b19f4381@microchip.com>
References: <20220510140232.3519184-1-michael@walle.cc>
 <20220510140232.3519184-2-michael@walle.cc>
 <160ddac1-6d0a-c922-1380-09e7823a285e@microchip.com>
 <02125e047cfbf347d81811224be3141e@walle.cc>
In-Reply-To: <02125e047cfbf347d81811224be3141e@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbc86dd6-6844-47af-b808-08da6958f844
x-ms-traffictypediagnostic: CY5PR11MB6533:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2VV4cnh4Kab2ul+ImFWJq1efVRSPJQpYqJXSgepy8fYHZ0IDAcEcpxzwQwcbKcjxAj0Qni8582BECkZZKE4Fd1CCWvizo6L1NaV1mgIbSP3u869+KC9KozZDkT12teknKR72Co0fjWdG45C6lSzb5OTCUmAfslAbc9ZDZ+j3qpKIUOOIu/HrN2qEvssrm7BErGfigtLFnXvvGY9sVTdwn5fB5qUY9mMd4S7tlK+GP70uUs+eF1sAAAlsSxCnLHtH/O5rsS0A7FbNFnyDIyOz/DqS/hJ9iKVpdkwtpu03lfqGKiQMr0WlzpJQIvrFyHkJU/y0pC1Q7nSMkBg2OMTEDu8ozVtiNboVWeQwt7L73fM8AINY0I2qnV71Zo9o/DmQ58W+dLerQleNDo0vnIIWtjWCSjvcE373XG8XGz8qtQ9eM185UC0k8lO9SFt/3Vx/hpIu1/OQtzHKeP3YsEHykKtyTqcxC26H6G1J27tswMqf0tSvIO5YDMisanpvBQZyi0hwyf02sTFjbgi9Mbdllux9vqLCjmPjvp5KlV6//Ey9xOjk5Wcu4enKQojjrHGn/qFs9pBD+bQq0N591YbqQjXclT5hafH0emhV2zEGSqekJ9698e9N1VUZjgb9egnBbUJW0uom5mSg5slWzD3Q0mcho8qMWIwydt3ad4EgI6e5PYfPp+ICWrl+HCsnSDOFjOWRlDzn9o2PWTHqcciZIfKApy2UnWzw7jlBf9+pHo+BVltpn0R//uENhEGpvqXfqOSZs3sIPCf9rwVWbcQKfZGmRi9SdyqYmLyCTMph6AVGJgqkcNiQTVY8XVzuZfaavv/Od9M2io1ip8IcZM1baE8yfIF3ZtVciJw1+ywBwpj6NZ1qeXtyKVqfkcN7E5mvHcTOHrJzi/cPwIZQ087RlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(39860400002)(376002)(136003)(4326008)(71200400001)(38070700005)(26005)(64756008)(31686004)(2616005)(41300700001)(91956017)(478600001)(36756003)(186003)(66946007)(66446008)(38100700002)(66556008)(8676002)(66476007)(53546011)(6512007)(122000001)(76116006)(5660300002)(6486002)(966005)(86362001)(8936002)(316002)(54906003)(31696002)(6916009)(2906002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1dnMFhYank5L0JwTE14OE4vYWxyRUloemRuZ1AvUkJqSDZrMWs0V3ZKRW9z?=
 =?utf-8?B?NkRZZ1haQkFYemlLZ0F0VmFOcE9IbzN5WUZKVjg1ZUJNdHZETWQ0QzlESkV5?=
 =?utf-8?B?Y1dvS2h2dHhFYU1tTFpCaGswUXdDZ29mRXI4bU1GZzQrUUh4a0R1VVhGVmhs?=
 =?utf-8?B?WFEwRjV2ZXB0OEd4ZlRLK1J6RmFEVitaREdZSzhLRndYQTNTay9NcmFBdnZM?=
 =?utf-8?B?a3JyTk12T3NuM3BpRGViUnF5WnpRczlGYWRjVEgwbEdDYjlkWW42WWFUZmZl?=
 =?utf-8?B?UzBwSVhNNXRKT1FKWWpFcERKR3lyajZZSjB4UVNrOENzMkxDQ0VGODI4a2J2?=
 =?utf-8?B?anFyWE9tOVBaTS9GNmEvNVlqSzVLL0ZFRFgvMENFTWxkd0NGSVYzb2VFdWV0?=
 =?utf-8?B?ZkM4ZUlDNGZMS0VYd2dvNzROVk92V1FEV2V0ak1uR3RGUHJKTktIZjNzTWcw?=
 =?utf-8?B?N3EvSWZLQVovSzZ1anBnUFd5UTYvVElraUFvQytYd1VveXl6bUVqbU1reGZk?=
 =?utf-8?B?a0RaaU5YQkZtSzNFc2phMTdyZWE0SG1iUGN5R0VOVDhRbGRSQlJBU1JxQnVk?=
 =?utf-8?B?Z2EwZldvVXRwVzdXLzlUMnN4dVZHSW44TGdlL2JYanlnNG1CU2NUdlkrajk4?=
 =?utf-8?B?cjBja1R4c3FQWTNNdmRRV1BxcTZGMGQ3dHVBd2Z6SlE5THN4TVp2L0ZZM2ls?=
 =?utf-8?B?L0RSNHczNUpFWkY1QmdOeSswSjU2SkRkbzNKQUt1TEJYUzJoKzRPT2ZLQTBj?=
 =?utf-8?B?cnlrTXBBd0wxWmsrTGVCVWlZSTNnQTNBZnBIWllxdDBjNTdVN1Z2Q1k2UGpR?=
 =?utf-8?B?cFAzYzhseW5kM3J0alJSY1BCUTRiWTkrc2YweDdydEc4dUZCdVZhL0w5OW1C?=
 =?utf-8?B?QXpHa2loeWw2QVZ0MjA1am0xUnV6MUVra21sZHgvQWdJVnVTQnQ5NUZZd3R3?=
 =?utf-8?B?dnpyZHpRcGplajQvM0tCMExtU2h0SWZNbVl6MWlGOTdwZ2FEVmdGSEFFMjdR?=
 =?utf-8?B?RE0veVF6NEIyNTVFMDQxWTQ2S2tlQlJ1S3BIWVkyNXZ4NTlsRGlZM05YTFJr?=
 =?utf-8?B?STBFSmhVT1ZNYmE3MHJtbk8yb0dvTld0WnVpL01ZaHBmZDBLL2N6RTNyZ1lQ?=
 =?utf-8?B?YmNYTHJOVXQxU3djSnJtSWhZZDExYUxidkdhc3BLQWZ1UU41N3NVQWVqMFkw?=
 =?utf-8?B?eTFubzk0M042TmlONjcxbGE4ZW8wSGpybXhHUHU4MW5vdHRkRHhBTzFuZDBl?=
 =?utf-8?B?WXYvQVlJaVZLd1ZvK1A3NGhmc3lZRzdaNUk4ZmtHZ0pubWNHd08wUlZRQkRa?=
 =?utf-8?B?WldpT3N5aU1yV0ZkeGJpSVNGSy9JeDlYbzlYNzhzZk5lSzJZb0Z0NjdvSDEx?=
 =?utf-8?B?ekw5SHc3UXkzdk9xOGpGRzFqZ2pVcFhMV2RNQkN6cUhGclliYjNWajFrYTVs?=
 =?utf-8?B?SkYzeGxOUFBlLytuUzJycDVQOEVYRzh4N2RCQkRXOXlseUJaak9VL05OTW9t?=
 =?utf-8?B?WEppamFWa1dNTDFFUDdadHdrZUZkYUNMUTE3ellKQzNOSVgwdkxNU1Rta2Fw?=
 =?utf-8?B?bnpXd3hHQWp4OGNaR3pCL1hReWN0TXQ5OG90ZG9wTStIemhSVkNLYjR0NFpX?=
 =?utf-8?B?MThtTzBjdXkza2pqTHhoUUMvakxoQ2VQdHRiRGtyMEJSOUlLaHNvZ1pKMFNS?=
 =?utf-8?B?eUlxVktPWEZXbHppWGJmeU0wRURneDdpVFI3VlovOEwwaitIRUtzTXZXQWlO?=
 =?utf-8?B?YXc4T0VRTTF5Z1lkOVJLWlJvUFpLNHVobTZtUlZ4TXE5OFpxK2ZIcWlTbGdr?=
 =?utf-8?B?MUxjYnBPUlpMRVlDV2RSbDBtL25ONkppZGttOTA0MmQvNEUwU0R4UXZqQVlz?=
 =?utf-8?B?SWFzTTAyUzdRczRTblIxYVhQVUxvaHBSUFRwdE9SMWkzZFFhYjVucmlKd2RB?=
 =?utf-8?B?YWFzS3BCQURSSFozNUVLSlBIaEovQ1JrMXVnYlFGWno2bnpkbG54SHRUUnZZ?=
 =?utf-8?B?dGFLMmVqWVJVK1BuYjM3ZGllUnBLQmY5T05Kazl2Z3BxMk9hRkc3bUN6city?=
 =?utf-8?B?TVA5U1pScWJRZjdlRmVrUERsWmxTRHFOOTVzUGxBNHdGZXEwcFErZVFPMzBq?=
 =?utf-8?B?bUZ1eXpFRGcxalNVQUk2U2xVSWRGWE9Mb2h2YytsYTBRS3JzUlJjSUF2L2x3?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADEF2DA4AB233944A7B13BE6B5F4FED7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc86dd6-6844-47af-b808-08da6958f844
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 07:33:26.9012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgGzB3A5x0Fqq1wqa3Bup3OuDfSV/wp5Xqc8sSn73QObO4g9GXWSYdNqtjcP5mx1/1T1ASp7srohORk04/V+HKHUW2mDmX8d+UzfeIxwunY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6533
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xOS8yMiAxMDowNywgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTA3LTE5IDA3OjU3LCBzY2hyaWViIFR1
ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDUvMTAvMjIgMTc6MDIsIE1pY2hhZWwg
V2FsbGUgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdw0KPj4+IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4+Pg0KPj4+IFVwIHVudGlsIG5vdywgZmxhc2hlcyB3ZXJlIGRlZmluZWQgYnkgc3BlY2lmeWlu
ZyB0aGUgSkVERUMgSUQsIHRoZQ0KPj4+IHNlY3RvciBzaXplIGFuZCB0aGUgbnVtYmVyIG9mIHNl
Y3RvcnMuIFRoaXMgY2FuIGJlIHJlYWQgYnkgcGFyc2luZyB0aGUNCj4+PiBTRkRQLCB3ZSBkb24n
dCBoYXZlIHRvIHNwZWNpZnkgaXQuIFRodXMgcHJvdmlkZSBhIG5ldyBtYWNybyBTTk9SX0lEMygp
DQo+Pj4gd2hpY2gganVzdCB0YWtlcyB0aGUgSkVERUMgSUQgYW5kIGltcGxpY2l0bHkgc2V0IC5w
YXJzZV9zZmRwID0gdHJ1ZS4NCj4+PiBBbGwNCj4+PiBuZXcgZmxhc2hlcyB3aGljaCBoYXZlIFNG
RFAgc2hvdWxkIHVzZSB0aGlzIG1hY3JvLg0KPj4NCj4+IEkgbGlrZSB0aGUgaWRlYSwgYnV0IHlv
dSBuZWVkIHRvIHJlZmluZSBpdCBhIGJpdC4NCj4+IFlvdXIgYXNzdW1wdGlvbnMgYXJlIHRydWUg
b25seSBmb3IgZmxhc2hlcyB0aGF0IGFyZSBjb21wbGlhbnQgd2l0aCBTRkRQDQo+PiByZXZCIG9y
DQo+PiBsYXRlciBiZWNhdXNlIHBhcmFtcy0+cGFnZV9zaXplIGlzIGluaXRpYWxpemVkIGJ5IHF1
ZXJ5aW5nIEJGUFQgRFdPUkQNCj4+IDExLiBJIHRoaW5rIGl0IHdvdWxkIGJlIGdvb2QgdG8gc3Bl
Y2lmeSB0aGlzIGluIHRoZSBjb21tZW50IHNlY3Rpb24uDQo+IA0KPiBTdXJlLg0KPiANCj4+IEFs
c28sIEkgdGhpbmsgeW91IGludHJvZHVjZQ0KPj4gYSBidWcgaW4gc3BpX25vcl9zZWxlY3RfZXJh
c2UoKSB3aGVuIENPTkZJR19NVERfU1BJX05PUl9VU0VfNEtfU0VDVE9SUw0KPj4gaXMgbm90DQo+
PiBzZWxlY3RlZC4gd2FudGVkX3NpemUgd2lsbCBiZSB6ZXJvLCB3aWxsIHlvdSBzZWxlY3QgYW4g
aW52YWxpZCBlcmFzZQ0KPj4gdHlwZT8NCj4gDQo+IFlvdSBtZWFuIHRvIHNxdWVlemUgWzFdIGlu
dG8gdGhpcyBvbmU/IElmIHNvLCBzdXJlLg0KPiANCj4gLW1pY2hhZWwNCj4gDQo+IFsxXQ0KPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tdGQvMjAyMjA3MTYwMDA2NDMuMzU0MTgzOS0x
LXF1aWNfamFlaHlvb0BxdWljaW5jLmNvbS8NCg0KTm8sIHRoZXNlIGFyZSBvcnRob2dvbmFsLiBJ
ZiB5b3Uga2VlcCB3YW50ZWRfc2l6ZSB0byB6ZXJvLCB0aGVuDQpzcGlfbm9yX3NlbGVjdF91bmlm
b3JtX2VyYXNlKCkgd2lsbCByZXR1cm4gTlVMTCwgZG9lc24ndCBpdD8NCg0KDQpNYXliZSB0byBh
ZGFwdCB0aGUgY29kZSB0byBzb21ldGhpbmcgbGlrZQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRk
L3NwaS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCmluZGV4IDIxY2Vm
ZTI4NjRiYS4uZGQ2Y2Q4NTJkMWVmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9j
b3JlLmMNCisrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQpAQCAtMjE0OCw3ICsyMTQ4
LDcgQEAgc3RhdGljIGludCBzcGlfbm9yX3NlbGVjdF9lcmFzZShzdHJ1Y3Qgc3BpX25vciAqbm9y
KQ0KICAgICAgICBzdHJ1Y3Qgc3BpX25vcl9lcmFzZV9tYXAgKm1hcCA9ICZub3ItPnBhcmFtcy0+
ZXJhc2VfbWFwOw0KICAgICAgICBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9lcmFzZV90eXBlICplcmFz
ZSA9IE5VTEw7DQogICAgICAgIHN0cnVjdCBtdGRfaW5mbyAqbXRkID0gJm5vci0+bXRkOw0KLSAg
ICAgICB1MzIgd2FudGVkX3NpemUgPSBub3ItPmluZm8tPnNlY3Rvcl9zaXplOw0KKyAgICAgICB1
MzIgd2FudGVkX3NpemUgPSBub3ItPnBhcmFtcy0+c2VjdG9yX3NpemU7DQoNCmFuZCBmaWxsIG5v
ci0+cGFyYW1zLT5zZWN0b3Jfc2l6ZSBldmVuIHdoZW4gbm8gU0ZEUA0KDQpBbHNvLCBwYXJhbXMt
PnNpemUgPSAodTY0KWluZm8tPnNlY3Rvcl9zaXplICogaW5mby0+bl9zZWN0b3JzOyBmcm9tDQpz
cGlfbm9yX2luaXRfZGVmYXVsdF9wYXJhbXMoKSBiZWNvbWVzIHN1cGVyZmx1b3VzLiBJIHdvdWxk
IGNoZWNrDQp0aGUgZmllbGRzIHRoYXQgSSBkb24ndCBpbml0aWFsaXplIGluIGZsYXNoX2luZm8g
d2l0aCBTTk9SX0lEMw0KYW5kIGNoZWNrIGhvdyBJIGNhbiBtaXRpZ2F0ZSB0aGVpciBhYnNlbmNl
IHRocm91Z2hvdXQgdGhlIGNvZGUuDQo=
