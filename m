Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC8E570058
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiGKLZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiGKLZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:25:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0B964E0D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657536986; x=1689072986;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iq8NbfZz2xpGB3pJbBR1VoapBMSz+Xa6uhqlOylzLjY=;
  b=TQEamuNsg+dCwpSu8Pi5MVG7c64HhJwjlArzAFLNRK+GGmd4/29MaYKF
   YtJ3FvYDuYAn9OkWxJVzhcDeLzaTIo9dWrQrmPNdO1OtcEPPy5Bxoioef
   L2YUH6hWgNlHxhOSwdOIFWE8l05iuXM9mO/ot2Jf4IDuDF0tK9v3c+fg8
   RPqBpAPICQTKnVUekR4bBIyP6F6Wt5Ip2cx89OK5K1TH2FXoS18HjwxSp
   gRj7bJePnHs7bfiROWx5hUNj3EZmxPgE66mW0qlaQita1dH5MOGVoaioe
   CsDVBxW+UQFOcqcCGW400/6BZiWRWXNDRZyOceHRi47ODVtXbX/3FLKqd
   w==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="167256946"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 03:56:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 03:56:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 11 Jul 2022 03:56:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb8S9aA+u7wtXUG7Ip54Id9hvQy3fPf6oXUH9i0o0GrYr4NfFtM1n3hRoSWYAyemE8Wpw8VRRcdX5+2ONWDNLvWT2tWAc0lzZ8/IQK+HNYiqPetB/u/CHjccQwdbw+ZSWxKWxqbAMpmJeO6bgfIKo+OhlPS83jE7L7fCKZSy+wOOlFdIF+6by5VdMfuzIUY3seGxvM0wmGqXgM30r0barIMIrqIv0tiFh1UHBTCNaJcUWN6Z+0wowJ3liHSMu/0nH0E58V3mUrl5IFCohMulBv+00p4HVWxUw7/tg+qoWy6oFL5NBOtu5VMX+OBvRAwilSxzWA0x8svep1YSoYuCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iq8NbfZz2xpGB3pJbBR1VoapBMSz+Xa6uhqlOylzLjY=;
 b=Qgkzo87pAL2+/6A33DULnpllN3GbswQF8ED40ECEKxs6BkheOoB0ssvSNdYIwhMs8qGwC14Ofeko5s/bT5bMejjVBSIl99eGB3bI5hWo5KBKLvuEqtb7MiT0LA9QrtM1aXnjED2vgFjf0PyYHBD6DXgUPlEH9VMYg37Rf2a4ingaA2EuGA1LaFT7nTsIot2xPsc1tpjdNjyqeQe2AslFlSiffmPQeoNoMUG4fZgF7KADP0BX9vjy2GIa6dWpOld95R/3CzQNcNIifQ9NQ0eb9jR0dcwRqiNLNSMaHPEhQt3pUwghWO+KX1aajOEK5HaED7K3Vu2RdQgKQqaYsJL8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iq8NbfZz2xpGB3pJbBR1VoapBMSz+Xa6uhqlOylzLjY=;
 b=ihNoByiIxKZke+uPiqLCWbNo+mztKIPtINmT440b/7/1qrdBbgMR1FJxhy//ZrG4Fk2n/uS4/Ru19KTRcN4PEQXtvpSVTALmrOail8ehL17ZvO9Co5z961zKZmsCyiclc6HB7oIUgHWa80PNX3df9BS5bubYp0RAGN9ehJtX2S4=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.26; Mon, 11 Jul 2022 10:56:19 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 10:56:18 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <maz@kernel.org>
CC:     <tglx@linutronix.de>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] irqchip/atmel-aic: remove #ifdef CONFIG_PM
Thread-Topic: [PATCH 1/2] irqchip/atmel-aic: remove #ifdef CONFIG_PM
Thread-Index: AQHYlRTZjhFawXyZr0qUSUiXbBu8+w==
Date:   Mon, 11 Jul 2022 10:56:18 +0000
Message-ID: <b694cc9b-7be9-8bba-985f-b4cba69543ca@microchip.com>
References: <20220706074630.829607-1-claudiu.beznea@microchip.com>
 <87let0kp9g.wl-maz@kernel.org>
In-Reply-To: <87let0kp9g.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3874dde2-6cf9-416f-ba25-08da632bfbf6
x-ms-traffictypediagnostic: DM4PR11MB6019:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MFvVEakgUdMItzfswilrh+I0g9dMKxxizjfSqYfNhM2qPw7DUtEAPAdggjLWwseqCkCFRaMvwJ7qgZha+DXoWQzqsaZYgKnQrIk7shx633c8hwvztwPiAUmCxUCOJLUtnz/F0zPy4dIsetaUgF0pvTt9P5gzRyXqVMK/+0Bbo1muitiQqRRCc2LGQYexNKNDbNC6YPe+40k8ZpkTUiXvYPcX+VthF9qMtBzgmdfae7TYUysy0EIMKJrXKGaMs+PmHLCB5DZr2MinuWuovwV6dzYx9a0r1PP0serU8gJg5In768Ib9+tttrcX1jk/UxNVyVyYPB5WJsXLq4jCcil6Xnzxmtv2hgwHVxvqJK9Y22Wk63TvzBjSqO93Gj9KjlHd+NfHMgkGL2jXuTg7Gy7wV5BHsZMHfKIGWrXHVmo9tSCfms28hXbaLGXaLbIgsQILbwsvQrt47EMHSI+9NR0IuHLhLlMcb4V1liFjyPyTbMn89DOcrLIBiBOrE8SNt33ia04/ZDjrx8dlIsZtfcPuPQunyuV5NtY/8fY2JOQoo8X02ZhK6rDqQmauf1ERQNRps20Uo1thW0wWXyNkShQs8oEvOp3I7E6gp8rK0ZF2wf26kn2PspOzoRzeofHx2Jc/27hLW/n1vdGMOMn7YgJ4pRTyXrhIYyS4adSOBpn7Q3gIsmkFIMe9xglZ4K3Ef4CDTj5kRbwkTOg4HEXY992qC/B/YPK+n9r6NwePH1sg35jA9PQHA8mxTaPslMm1CmZeJnmcghQAvsFz0KFVF655epWUR9zPFyO4wohcDfPJCl5dEw3REHzkvFTQ5YIlScpWINYsp6VRfz92oTXYz6GwPGcYfLiS/ybEUaHZqMT+Yy8Nj7seHnSJfkH+0jvK2xo/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(376002)(396003)(39860400002)(136003)(36756003)(31696002)(86362001)(38100700002)(2616005)(186003)(53546011)(83380400001)(6512007)(6506007)(38070700005)(26005)(122000001)(66556008)(66446008)(54906003)(6916009)(478600001)(31686004)(6486002)(66476007)(8676002)(316002)(66946007)(64756008)(71200400001)(41300700001)(91956017)(76116006)(4326008)(8936002)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXlqYms5R1krRFVHR0ZscjFJeENhZDFPNlhkVTMxLy9oQkk0ZGRhYXdEM20x?=
 =?utf-8?B?TzMvME9CTHNCSk5GUUFXV3NFWlRoUm85VzRyVE1xdmVmN24xODlyUTB5RDJ1?=
 =?utf-8?B?VGxiNjI1NU9KRHZOVDhFVmRLbXp2TTRHOGdxVjdMM3RNSzRKZGVKa1hnRndR?=
 =?utf-8?B?NUptQUlqM25Icm9TNUIxSkErSWlxV1liNHUxQlM2SFBGOHhUV1lLa2xxY0p4?=
 =?utf-8?B?ejlPNzltYzBtblc2anI4Sm5Cb3Y4dVdLSkVPaTZnVTdQU01zclpoUUNKM3Rq?=
 =?utf-8?B?TldYWmt0MnMwODBMRG0rWER1N3NuRkw4Qm5zSkNwcGF2S1c3OTVwVUdMSUpi?=
 =?utf-8?B?NVd4SHM0MTQ2UWNXZGxvcmJBZjlrRVJ0U3I5bTl0QlhWeFJkd3hnbzJOL3lC?=
 =?utf-8?B?VUp0STBRKzZyTFRoQ0JzcE9YNm5MbnNXdXBIUlJSRzE0MHFNUWxoR3orcDFP?=
 =?utf-8?B?aGxzWnk3SUluTTg5c2hEckNJUWNiOCs5Y0k2YUtmUmRocnNzN0JDTWVhdXhv?=
 =?utf-8?B?OUR0MDBsbzA1NjZ5aTZuMTN0c1RkTlhnYi8rMmk5WEMyY2R5QzhZblBNVXM3?=
 =?utf-8?B?RGdvaldnbFZjWWh5Zi9tRVJ2TVppRHFTTmF4QjJieXM5RHg3dCtOTU9Vd00y?=
 =?utf-8?B?TGVVdjUzN1BUZE9sZlNZSkE3am5PZUkyQ1AzamkxL0J5OUo2dkxGNHdZRU5D?=
 =?utf-8?B?eW5vQUhuNkRkbHFCbEZ0MnAvaDkzZEJFRGVtT1BFQzYyeXJnU1pzNU1hTlZy?=
 =?utf-8?B?MzJRbzhmNVJySFZjbzVvTHE4OTdvaXlNZWxGNjQ4MDZtS3R6Yi9yUnZxQVBl?=
 =?utf-8?B?RHpMdWtiTlB2RnZyaUltYk9waTZzWjFuem0xTlpadUZiNXkvL2J6R1doVnND?=
 =?utf-8?B?U2d4TDNSWU5ITUdqMDdkZVNXbHhqZUd5TEV2UkdhNjVvL0cyc292bXZEMXYx?=
 =?utf-8?B?bk9Tck1WeFdWQkJjVTNRbG11TDBiZkh5ejJ3NTVIcGI1SmMzTHNsQmpoZ3Jl?=
 =?utf-8?B?WGhYN21WMzZmSEh0QnVCQXhZbUx6ZjVNU0xyNm8veGt4bWtuNHljdFJSUU5X?=
 =?utf-8?B?RGdYSFlyQW5UVGdHZDRpai9iSXo1SmdqK3ViWFpTY2JCNngwSXBWZEdEWFZI?=
 =?utf-8?B?eUV0UU5INFRQd1VmczBnRlJkYzNrYzYwdGZwMjlodlJSK2lkbitUaW5GRnQv?=
 =?utf-8?B?ZHhvb1Y2dU1tSC8zOVBPQkEzaU01U3RZTE4rUElwUDJuQ3FxSlVwNGpXYi9q?=
 =?utf-8?B?aE5mMy90R3JqOW90dUlUS1ZkWTY1TUlpTWJFWFVuSlEvNzM1UGFjN2oxcll5?=
 =?utf-8?B?dmRJcHMzeW1WME5tL0J0ZEt1UEh5VDFUUStMeWEwdVNsQk1YeS9yN1NYRWtM?=
 =?utf-8?B?ZnIxTjhNQWd3cHBPdVlORjlhWUE4Q3N4MUtQWm5YS3F5cVAxc2ZtY01FNnhS?=
 =?utf-8?B?Zzh6V0IvRXBSKzY1ZkxPR2JzVWtZZmt3R09tQXVHL0p6bjNFaUVoaUZuN0Qy?=
 =?utf-8?B?amwzRld0clAxS2ZubGVGeHZlRVY1VXVLUjhHRGVuVGVkbk5DM1VqSE42eGRP?=
 =?utf-8?B?bkoxaEVkQ1ZNRm9JUUlNMVRCRmRHM1lTbEhCQTJtLzdFeGpyRU5QRkhTNkQz?=
 =?utf-8?B?aTgwMWpFdjdtdlFkaDErU25OU0J6SSthU2VpTEFoaTE1V2dRMVVURkxWUGVl?=
 =?utf-8?B?ZmRNNHpNS1MxSFp0ZC9za1JubHVENlVWUksvSFl6UE1pRm5IYXd2d3RaVG02?=
 =?utf-8?B?dFRrYStITlJuTzlnZWZSM3lxUVpPK1IrbXNVd3pySGRzNFZ0WVN1dXBkN1pv?=
 =?utf-8?B?Y0UwdFRTbCs4TllHWDM4RmhaNm9OTmdiZzBCaE5TeTh3bTg2Y2VRbjRpNEVh?=
 =?utf-8?B?MTBjU3VjZDRtV29ZU0VSU0ZuOEUwVjQrSllOc2VsVHNPZHlqajJqQkcrcTk5?=
 =?utf-8?B?cnpZUm9rcGxUNXduNmxIVUNvK2pRV2dyQzJQMmd4RkxoTnpOSVpzWHdEdVlL?=
 =?utf-8?B?a0crcHlTdWR2TWJaY3AxR1VNNXN0ci9OM01VWnh3Mm5PZ0ptL3VqNThPN1Jw?=
 =?utf-8?B?N1dydjNuMFhodTArWnFoTU85NDVHeVBKL1pVME82NFVSblZvRy9VSmg2SFNa?=
 =?utf-8?B?Ylg2Z0M2TEN1aEJrYXpPNUxhRS9ES0dxeHpQVFMrWHdqblJJalI3SlJsV0xm?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CFC140100A93548B3AAB8926AFEDAA8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3874dde2-6cf9-416f-ba25-08da632bfbf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 10:56:18.8028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1vLdbRNSfgNATuDluEA6EgfWIVyboCIIQ25v/DBx1js6OFmVBUIDGb8tP+A1Bk8lB6w8Z6yP9/BBFZTRQEbXrMG25GArPC8RYJmxbBVGhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6019
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcmMsDQoNCk9uIDExLjA3LjIwMjIgMTE6NDksIE1hcmMgWnluZ2llciB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBDbGF1ZGl1LA0KPiANCj4g
SWYgeW91IHNlbmQgbW9yZSB0aGFuIGEgc2luZ2xlIHBhdGNoLCBwbGVhc2UgYWRkIGEgY292ZXIg
bGV0dGVyLg0KDQpPSywgSSdsbCBrZXB0IGl0IGluIG1pbmQuDQoNCj4gDQo+IE9uIFdlZCwgMDYg
SnVsIDIwMjIgMDg6NDY6MjkgKzAxMDAsDQo+IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5l
YUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4+DQo+PiBSZW1vdmUgI2lmZGVmIENPTkZJR19QTSBh
cm91bmQgYWljX3N1c3BlbmQoKSBmdW5jdGlvbi4gQ29kaW5nIHN0eWxlDQo+PiByZWNvbW1lbmRz
IChhdCBjaGFwdGVyIENvbmRpdGlvbmFsIENvbXBpbGF0aW9uKSB0byBhdm9pZCB1c2luZw0KPj4g
cHJlcHJvY2Vzc29yIGNvbmRpdGlvbmFsIGluIC5jIGZpbGVzLg0KPj4gZ2MtPmNoaXBfdHlwZXMt
PmNoaXAuaXJxX3N1c3BlbmQoKS9nYy0+Y2hpcF90eXBlcy0+Y2hpcC5pcnFfcmVzdW1lKCkgaXMN
Cj4+IGNhbGxlZCBpbiBpcnFfZ2Nfc3VzcGVuZCgpL2lycV9nY19yZXN1bWUoKSB3aGljaCBpcyBO
VUxMIGluIGNhc2UgQ09ORklHX1BNDQo+PiBpcyBub3QgZGVmaW5lZC4gV2l0aCB0aGlzIGdjLT5j
aGlwX3R5cGVzLT5jaGlwLmlycV9wbV9zaHV0ZG93biBpcw0KPj4gcG9wdWxhdGVkIGFsbCB0aGUg
dGltZSBhcyBpdCBzaG91bGQgYmUgYXMgaXJxX2djX3NodXRkb3duKCkgaXMgbm90DQo+PiBjb25k
aXRpb25lZCBieSBDT05GSUdfUE0uDQo+IA0KPiBCeSB5b3VyIHZlcnkgb3duIGludmVzdGlnYXRp
b25zLCBhaWNfc3VzcGVuZCgpIGFuZCBjbyBhcmUgdXR0ZXJseQ0KPiB1c2VsZXNzIHdoZW4gIVBN
LiBBbmQgeWV0IHlvdSB3YW50IHRvICpwcmVzZXJ2ZSogdGhlbSwgZGVzcGl0ZSBiZWluZw0KPiBk
ZWFkIGNvZGU/IFdoYXQgcHVycG9zZSBkb2VzIGl0IHNlcnZlIChvdGhlciB0aGFuIHNvbWUgYmxp
bmQNCj4gY29tcGxpYW5jZSB0byBhIHJ1bGUpPw0KDQpPbmx5IGNvbXBsaWFuY2Ugd2l0aCB0aGUg
bWVudGlvbmVkIHJ1bGUuDQoNClRoYW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVhDQoNCj4gDQo+ICAg
ICAgICAgTS4NCj4gDQo+IC0tDQo+IFdpdGhvdXQgZGV2aWF0aW9uIGZyb20gdGhlIG5vcm0sIHBy
b2dyZXNzIGlzIG5vdCBwb3NzaWJsZS4NCg0K
