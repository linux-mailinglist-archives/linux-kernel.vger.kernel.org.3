Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D61D57B13E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiGTGwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGTGwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:52:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFF830F5F;
        Tue, 19 Jul 2022 23:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658299928; x=1689835928;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zZPuA8KQqK0L9Z0IU6BHamnYUt2mkeaaGxchXeNh+Hw=;
  b=a4osJnx8ARBZuO/CjaxQfw4khdBhfbKsku6QYzVIhHzMckySEGsnBDPJ
   heE1YjBOIH64vRPxXHxotyG6WcwaNtySvQZX9It7sZ2K/Q+E9P7NNgOYi
   424EvSIff0KuMx/nWM1RegtNMadQma5KIyEke+9ovpmgJIjDBDJNrTLzZ
   68bwSGUY6f1H+p3mEmJCV1xbUv2rxpL76VSO6iFnyPxrIqAXQAO0fL7FG
   mo73s7w6yZovnXVtNjBuatq3LVtaS/P45DV7NJ8U6/2Xcfki5Dg6ZxkdP
   zH33YIsWC3EkG3Q/435LQ1KHHFemvH0QKsZsk8WxL+hy3nupDNvS1aGo8
   g==;
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="105285048"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 23:52:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 23:52:06 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 19 Jul 2022 23:52:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCWduldcO3f4vQd3k4OX4tP37gqSRIQtuI/yxtp2QNpCI1NDA/25GY2/7BOhaFi2D30xE2bp03DLbBNsz6RiZRQ1G17Pth+Q50QnWZ4WHZfOugr/bD9EDBpXoYVIHDQ4ToEIQAfgWRzixLwgPZHOBFTyCjObA3CUdRS0Ixd6DazQIJ2D5USN3DGx9BsRyM5Jj4mVNM9GmrbVA5u6dhvFRM0PH9XWMDirbIG7RC2O7E3Cu00SEN07t6SOYkJIZvDGzYjajlxLFV9roOaRny5h1Z47dMoqaQSzrttXtXpzRXha4BAbTCk9PQcw7VZVoFFXYrHjwFgGmEVQark2KrEJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZPuA8KQqK0L9Z0IU6BHamnYUt2mkeaaGxchXeNh+Hw=;
 b=jcq3WWPovFvHu34IF9q1oeFCYgo1K0d8wOv9B/6jIhu5pef2DpPXFI6aaq/EYiLs6tFR1HCuTaG8hrVICY3oyB0+/L/CMOkE71uXH/BWCYHM7v7pvABML/lgoFr+F+hO/u0b1lZTOi95eXbN3BT8cchDcKyTdXsgrTvkjfQgX6slMmoguU9NBeJrki+1OBNICKUZNzoGOujHtXn9dlttuAEevmSAvzvJjg90bUR8r9fbrvMHZNxubOg43bNEpPzePsfDEpnRyWSkitorz9gjAPywJaU/p0rhq/BncjM75L4H3/3AmR4fFrr+saiNpygfs2DafjWCj8ZX4vrY6NnE7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZPuA8KQqK0L9Z0IU6BHamnYUt2mkeaaGxchXeNh+Hw=;
 b=cwADIRIFRdsQJRriBDUDUL6QBqPKUWWmA4Fap/MOX039VfE84CIZxbDiihkc6TqDFNRFNiv89cdVXtlHWmWvEcIZdkvpLqXYbPkDPaV4BF7KoB9gYpABQOE7VP3grPpE1bJU2/B6zCytjDrfnXb0Cc/FATos4OfaFw4xHivmI5I=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH8PR11MB6684.namprd11.prod.outlook.com (2603:10b6:510:1c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Wed, 20 Jul
 2022 06:52:04 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 06:52:04 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] ARM: dts: lan966x: add clock gating register
Thread-Topic: [PATCH v2 1/2] ARM: dts: lan966x: add clock gating register
Thread-Index: AQHYlPX1nrnmxLeOAUSFrDL+ar5dnQ==
Date:   Wed, 20 Jul 2022 06:52:04 +0000
Message-ID: <3bca9670-4aeb-9171-6ac5-5c0508448840@microchip.com>
References: <20220707132500.1708020-1-michael@walle.cc>
 <7ee463db-3cb5-c340-ac1d-1dfcd2b87dcd@microchip.com>
 <07af76d1-3aa8-3067-f92d-120ad385b698@microchip.com>
 <9a3a5d9633cd8397f98cf2c4056e9864@walle.cc>
In-Reply-To: <9a3a5d9633cd8397f98cf2c4056e9864@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 329d7a58-1f41-4d8e-5702-08da6a1c5ae5
x-ms-traffictypediagnostic: PH8PR11MB6684:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zTzVZ6OoDRr2F2WIOwpmgIF5y6cAZw5cspH2xAhOOi20wRwAaghgFsTGureVcyZT4WcTCoidQQESBamACuQ/G23a6M/PlJrfd/nt2c6jbI1Oxcg3g8O0N9VmwqGCa9BUIDENMqYoRh4mkEDO/a3HjHQPXrI3/GpbUiJF1Qi2uQPQa6suxREEFlbVo5HRlW/RZtreWH1q/uTKkxlwuU016GSZ3Ybf0sr1dYMhz1f6tfZC/IoAuE9aLF/Fcn1YN+UNtmVvxk8Bbh0xfmPkYL15Jj+GQEhjDpVouU+KboBNr7+l3OQ9mmAVEPtgA3G8G6diPExifMFs8sYU1kg0Uv0HmEQgAJT/AJjhw5zgbaFmLU9c+wj4tgBK+L+D2rzk58diKBqsTrvPa2JscZBvmFgMNhTOmNQA2bfXNTHhljEBLshv7S4iUiSJ+rqmq7ZyIns5A96pBV9d8igl87T/RqEKEiUDysvncJ3AXufrqGJEfqgPtf7y3gN/QkmxpbEFyL1uHKtNqXzAINOfQPpuTtaTdk72AyB1tYhHgvrnVUHVDNaylg9YBdOjPgMHUHISBX2jTP3TBdiuU8suIY8qFzQh+Vn/JkdX1Ta90G7uCvtNdGpOEfJWUBoECIQbfrxKtt6WNC+QTOqfJz7/nL+KDltQY7EdHNjJcQnnpzBT8lPyvYqwqsS8BE9TxWd38ztErFBNdDHYVqRMq8bOs57DOezhSU5oO1EMQqhbuPJDxtx9jXyE0p/U68gnjlDZOEGWgcXg7uJmGzgRjDfqwOlIIYsHC5IGWJovNnJ9bLhG/q1uvNk6+o0A/dIWTnqyWvHcf/QWI+U3YNMzqw8rRRmUvNgO75TjtvPgEz2Li2TuEwyN8RAGlxbNs4H5RHaf7ccpV3EE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(346002)(39860400002)(376002)(316002)(76116006)(6486002)(66946007)(71200400001)(478600001)(41300700001)(53546011)(38070700005)(31686004)(2616005)(36756003)(186003)(6916009)(6506007)(54906003)(66556008)(6512007)(66476007)(4744005)(66446008)(2906002)(8676002)(83380400001)(86362001)(31696002)(122000001)(91956017)(26005)(8936002)(64756008)(4326008)(5660300002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0RzM09vUVhFalR4T0w5TjhiUVd6ZnJsQ3RUY1FWOVcwVTY2dElFb3lOWHpT?=
 =?utf-8?B?WnVQMmdJV0FvTWhVVU5WOWo2OWFyZGFsTTZYZElIdjRNa1FMRU11REtTdGxJ?=
 =?utf-8?B?djRET3NCK1BXV0ZYWFU5NU5IaGlpMVVFVTNJeWJJVVdnR0trWkZNZzZpMk9Q?=
 =?utf-8?B?cVIrREZBSks3YXY3dFhaYWIwZWlVZURrOTJmZlhLWGRrOVZDRFI3UTdhKzJZ?=
 =?utf-8?B?c25vREZRRENqQWRZRG5VdW9NMVdpV3FmempXQXAvZENTb1dyNTdtbXZjTmZP?=
 =?utf-8?B?cSsydXZrUWs5dWkyWWU0YllKMVJnUUNTNm13bkFIQWMvQTJiK0wyclpoY2Rp?=
 =?utf-8?B?SzJUSFUxQTBMV3RGVVpBdUw1THk3bml2MkJIRGpLRWtUZ0lpZU5DbVI5aHdp?=
 =?utf-8?B?ODRpL3NrTENDNXM0a0hxaVpSNThPcUYxYTRIZTgrU1NpL2IxQUR2UjVWV1VE?=
 =?utf-8?B?ZXZBbEJKYkhrSEduY2ZXMFhhOEoySTBZOXk3S0ZRRFBFUWErS1N1dWYyczli?=
 =?utf-8?B?UU9McUJqOHFXMHVKVUVHS3dVRTcyVVJCM2xDMC9UdXQyQk9oMWxES3lNNWxF?=
 =?utf-8?B?U2U3cE5ZQnVKOXBIRVdtaHVEWUlobGhMQlB2dENiVlA2ZDFxWnpCdk9Wd255?=
 =?utf-8?B?RmJUTnh4ZlRUd094SVJ0RXMvRVZsd05mU2xvMnVoNmZaT09EenlTRnh3QlhR?=
 =?utf-8?B?WnNVQ25mdUVQd1RlMFdJeDBITElQOVUwdXMzeWJ6eUlYd0hOSFNuNFNRSEVm?=
 =?utf-8?B?VVFudnpWWG56aEUxanFobFBZV3RKZ0dEdXYvL1BqR0swQk43MXJSVThwTVFL?=
 =?utf-8?B?a3piRk96UE9PaVgvS3ZaN0M2K05Wbi9hRDlwQkUzUmRyVFI2MVFFSU41V09m?=
 =?utf-8?B?REl0eC9DcEZkS1BDemtsNnVxWjhEeVluRERaQ2hhLzB3OXB0R2NQaTZBdWdT?=
 =?utf-8?B?R2JjYUZEd2toR3VBVktkNDZ3ZCszSkJucFJCTk9yQm5kNUx3cWRjalVENGtW?=
 =?utf-8?B?Qi9oS0lsQkxpZnNNVmN0UWdpcHhBbVB3WXdkVkphTktXV0hVczZaZ0llc0U2?=
 =?utf-8?B?OWNDLzFwTHRNVTl4VmpUcDlzb29DUjdxV29XcVFNVnFsaGNpMjBoVk5iYVR6?=
 =?utf-8?B?TDFFdHk5cGdEVFJNUitza1k4YmxHeFUydG9PZ3poQW95TUEyeXlJMGF2d2VP?=
 =?utf-8?B?T241dnBaYy9NOUNrRTBOM1NGbFRtUytuTUNBTDViZm9VWGVwMEdvNEFyZXpC?=
 =?utf-8?B?bGNYTjlFYTdYcXovR003Z1NteWNlOE9NK1JiNlJIcVFHWlJ2NXVJNGl0Yk50?=
 =?utf-8?B?eXMyak5lZVd3bUtaUkc5bnhKVnFEcGEwb2RNK1V3WFBYVXl1VzlFRm00bm9l?=
 =?utf-8?B?cGJvOGdEZmc3a1IxK0JCM2tOUXdzQTVQZktyaTVaKy9IbEdDMXpkOXhISitt?=
 =?utf-8?B?R3EwUUtoR0YzUzV5L3kwaVhKWE5qVXBHWkZFYUIrb2VGd3hEaDY4Mm1PVUNL?=
 =?utf-8?B?bngvWDI2TUsvL3NsckpHajd4MncvLzh4TG9OQ3FKWFkxSlJTZGN1VDRvWFVJ?=
 =?utf-8?B?MC9KbHNFMElHdy85N2JKNWNnMjd6bk1kYWkxSEMwT1g1bXk1c1VNR01oQnN2?=
 =?utf-8?B?RllKRitBcXpPbzk3cVprQitSZ29GSFhTMHZTQnJsSjkrSE5yVkRRSEorU0Fz?=
 =?utf-8?B?M0FlQ1RuSmR2WnBKOHBTR1FCUUd3UGlVSllOZDlSb2xjNEZtbU9HNnV0M0sx?=
 =?utf-8?B?dUZXek9GbzgxOFI3MEFRMUpCL2JpQ0hXbUhYUjg0OWd2NlNNcUF5QmlucWsz?=
 =?utf-8?B?c2pTc21pUDZtd2VHYkRLNWJSemJhbTNyTmRHZkJVNU1BL2MvQUJVbWhrQWor?=
 =?utf-8?B?QUM5bTBMTXdMSDlYMXV1QUR3NkxaQ0xvUVByMVFVTEh0MlhRVFhBR0tYSnJq?=
 =?utf-8?B?Y0pXMDU1NEdXU282WkRCNjVBYlkvWG5oY3ZzaStKVGJWalBza1RGai8zcUdz?=
 =?utf-8?B?S2YvbTdhWS9rZ21kTzVhR3VERVIrNTloT29RVXFpVDNWSmw3RDBXKzNURnNt?=
 =?utf-8?B?Tkh3a2xPWVovakJycFplSS9DQzd4UVdqa0JoODduR2F6akpRa3ErQkhKSyth?=
 =?utf-8?B?KzV5SlBHRXdmTGxvZDU3MnpyakFwTVRNdExuR0FqZlR3QkExMmQxWEIrcG9N?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71B8306541210246BF52EFF92E738B88@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329d7a58-1f41-4d8e-5702-08da6a1c5ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 06:52:04.2798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPP9wgS/hHT8KFVCE4O22kk9t3g+Nd64FiQLNFLiJXd3jC70p7rgqq4sy5lzugDhsfVj1znBeeFmlYmzYm6Wsr/GHM04dkR/4FMIr6J0fMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6684
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMDcuMjAyMiAxNjoyNCwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUNCj4gY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBDbGF1ZGl1LA0KPiANCj4gQW0gMjAy
Mi0wNy0xMiAwOToyMiwgc2NocmllYiBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tOg0KPj4g
T24gMTEuMDcuMjAyMiAxMDoxNSwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+Pj4g
T24gMDcuMDcuMjAyMiAxNjoyNCwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4+Pj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UN
Cj4+Pj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4+DQo+Pj4+IFRoZSBjbG9jayBjb250
cm9sbGVyIHN1cHBvcnRzIGFuIG9wdGlvbmFsIGNsb2NrIGdhdGluZyByZWdpc3Rlci4gVGhpcw0K
Pj4+PiBpcw0KPj4+PiBuZWNlc3NhcnkgdG8gZXhwb3NlIHRoZSBVU0IgZGV2aWNlIGNsb2NrLCBm
b3IgZXhhbXBsZS4gQWRkIGl0Lg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdh
bGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPj4+DQo+Pj4gQXBwbGllZCB0byBhdDkxLWR0LCB0aGFu
a3MhDQo+Pg0KPj4gQWN0dWFsbHksIEkgd2lsbCBwb3N0cG9uZSB0aGlzIHVudGlsIFsxXSBpcyBh
Y2NlcHRlZCBhcyBjdXJyZW50IGRyaXZlcg0KPj4gbWF5DQo+PiBmYWlsIGlmIHRoaXMgcGF0Y2gg
aXMgYXBwbGllZC4NCj4gDQo+IFdoaWNoIHdhcyBwaWNrZWQgdG9kYXkgOikNCg0KWWVzLiBJdCdz
IG9uIGF0OTEtZHQgYWdhaW4sIHRoYW5rcyENCg0KPiANCj4gLW1pY2hhZWwNCg0K
