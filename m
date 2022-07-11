Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C960956D687
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiGKHQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiGKHPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:15:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0C065EC;
        Mon, 11 Jul 2022 00:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657523726; x=1689059726;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F78GAs6NCeDeX7Z8lXE1fpMzYWZF7PLjMrozdet3JpY=;
  b=2rGgCeJOLcOqpgxTF5kvbunI+L7gFB1jS/sOBhmm7mKHPF+cP9kVxYHC
   qTN6zUkh4mjFb1R2t9+M1Np3VhVybxQjGmkuaH1nAttM4QS8MGVNMR1yX
   aOjRpHsR2YmOzhPOSSrw7htcperMGszLKKW6sjp1P+cfqdZhK2KecedHl
   eCMbwtx6q4LYrAv8KLwxo1hQaQb2IZX7J5MS1FU8Hxy1lvwQsf4a3MvOJ
   UjUY8gg4iA+87yTtvd16EXAYPeB+htlp2pQ26AMRb6Fb2BpJt86Pcwenh
   1202dA+FZM9kOGdx12JLIMMWk2yfWv4rHIjQ48QbezJoPJQqT+SItAGWf
   w==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="171556892"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 00:15:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 00:15:24 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 11 Jul 2022 00:15:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bflcxOCe/jdJjWJHO0it7X73cyi4YqFOgc7x+ju0XsPl0cf1K+rSJ4s1KFFYRIqFBTeSXhN+OI3j/ic5MGpQu4RZSYcqWTMJSLa8bHMqzwkLVdk5bmC/BAN6PGCK0w957FxgsjQZFg2EHC7nNDiLG5YQmiHG985GvSlNStuFoU0TDCar/tbyEC1cPbIeDRsmgxzy5nW4QPtYvKoAPRboz30xHbFW/oH689KTfXowLNLvAimx9Ro9/zMwZp3O+oN0a75pZdHCEsr72GmD1DEq7WCCAkpsJCD2Om9tpGXJnZbWobho3pG0CR8iU621yqy/25JkVgVX+ZX9/TjoGR8q3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F78GAs6NCeDeX7Z8lXE1fpMzYWZF7PLjMrozdet3JpY=;
 b=kcjlWQJ9WKz+oiSUPENSY/TgDjOFZhmAlobiu8SuZC1A8c3i/+ik0v9qaaQ0MKneLxwAbtM7Eqb0sLt3a01HxO2GvRNSBZaX3cwDoviQC/KgpyXxeSYvPwH+nvJdvm/ZaytLJNU1rBis/6U5wG0dPIqocX+tspTLZzTmoIEYPQ8D2ONVXc8vQlz4Q6Jbo15Akek4I2UbgTio0kqlc/Z5YkhU3qz/VxGu8pUjggs4C2J0Nt3fNWUtxgQNaGtELdGJ4gAFscIwDuD950f5NJKpkZalfNDGW8SRPSYnnEcDcLjiQBhlWX3kUxcVag+726vsEyEZvOHK8EsSG/pDfI7kcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F78GAs6NCeDeX7Z8lXE1fpMzYWZF7PLjMrozdet3JpY=;
 b=ljua1Mx7b5CbM4K8YFIwkSpWb2CecVq+ZD641p/oKxaLviL6t4rTDgG2tiejN9AKNT8qg66MkHP7li4nROINuB/r4QzGsiOwdkFIG82p8v4RTyWiEohkxeo0o+fwMJkp0uFhDsLvSeFy0Ex1lW4xWv6pTkXC2ivarf3H3IP8o8k=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM5PR11MB0057.namprd11.prod.outlook.com (2603:10b6:4:6b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Mon, 11 Jul
 2022 07:15:20 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 07:15:20 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] ARM: dts: kswitch-d10: enable the USB device port
Thread-Topic: [PATCH v2 2/2] ARM: dts: kswitch-d10: enable the USB device port
Thread-Index: AQHYlPX6vaaO7qqzkUSTppAC+UnixQ==
Date:   Mon, 11 Jul 2022 07:15:20 +0000
Message-ID: <1710ce1f-9e03-4618-e674-dd3c5986ffa0@microchip.com>
References: <20220707132500.1708020-1-michael@walle.cc>
 <20220707132500.1708020-2-michael@walle.cc>
In-Reply-To: <20220707132500.1708020-2-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8150083d-284e-46bb-7b40-08da630d1d46
x-ms-traffictypediagnostic: DM5PR11MB0057:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: POFYUypGdGxYyBXWsY/5izJh9fYOGUf/jETc4y1kUer36Qpy2qI4+WmLETP1GkhmFtMekvjny8RZRELEsRoqbiWM0x+X4ffngAhIAo5Sp4/4W/xEk4I6lBGLWqUpeICqFpCOHgdlFYh6vxvnteHIYkvoIitISPhCW9IZsrrlNi+WitL+6hEtjmojH7CNZAsALYEJc1A1VJR8dP91W2/qiogR28UlfMymZWp8oKN+d9NPSPcY6PwdZ4PAp531AJKH4bAc8pLc+rzQi7cKFKarpkHa8/QBxHA+UNwZ42U8OMa4zcZK7iLrl+jkSE7bl45qWUaZRvKAVeGTLgdimFmSQ42XehAxOm5ShBmdShyNGhS4F1kULOLofvphZHAKvI3kBIjtdc8yXhjIzuwV0PJ28l7Q5FZu50J8ePRLzOd3t58tb4eH4WY8js0IbbElV88NKQsW4cmHTwzKgJ0OZzd2CiX0fMUCLYVsOXc1MddolcXtFUyXDsR+ZUmsxOWXtvG8GhCA8udqF0JO34wwK3V79NH8JqDsHFSjZ4Dcw1hhcPLCEfkWlQrKlP6XRcp9N/9rqeeGkTCur7rWrEKF7POclWeA4G/j+sT3d40Rq3N+FZwNKM7jnlCFwyS7vlO3DvPWo8+6CcrAzFUqCbLrkP6xlsY+xEo6q38H38JQIZc88ZIZMRWKhDWKvDFfIzTPYc7BjiuWpDaeBDFCHYRVN9Fp6V6UeJ5RVFNROw77/xP4Gnyc+fsn4BFjC7Sgvoyg3S7Zd7DjO/TSujVdWvaUIMDW+0V3dHiNzEBl35sdnFe0311MaEmzID99y99ugh3TXicxlBjWYtp50ANOnIKp2XFMZhU2JpdzrA5D1NLNoKSiEL9miHqXraD2S+HBxvwrVgqZw+BqW4i0VW6vK1fe/OSrSbwVKA2JzLVukXw8sV1BbP+V90rfGCh1OlVg6HsSsI7W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(39860400002)(366004)(136003)(26005)(6512007)(53546011)(478600001)(122000001)(2616005)(5660300002)(8936002)(6506007)(2906002)(41300700001)(38070700005)(186003)(31696002)(86362001)(38100700002)(54906003)(36756003)(71200400001)(110136005)(316002)(6486002)(64756008)(66446008)(66476007)(66556008)(66946007)(31686004)(4326008)(8676002)(91956017)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFdsNU14R0xHRW94aTFHVGRTRGtvWU1KT2xTVDZKSWVISzFpbmJsZWhpMmNj?=
 =?utf-8?B?aXhZVEFhb2FTMlRIbjlUR2c1TnhJZktVZEV1OWlMQ3JyU2hGQm1JZldLc3Ur?=
 =?utf-8?B?czZwdVY2eFM5a1BuVlg2SnNSTWhWTWNVWWQ5dTlDbUQ3eXBYd0Q2QlRORnM2?=
 =?utf-8?B?a0l5MHp2aE1QTzRJdTFzYzc0eHVsanZyRFJrMFE1M0hENi9PR1NlbjNmcVdB?=
 =?utf-8?B?QmFqUDdOYlNMUS80SmZMcEo1Q0pVaGQreVhxV29YeGFZK3NPdGpNM0VUdjBp?=
 =?utf-8?B?QUNxRnFrelR6b1JNSEdld0s0TCs1VnhoQi93TFo3Vmh4akJ0UDVwZVNLK2Fk?=
 =?utf-8?B?OEl0clJkLzc4VVd3UXNhNzFJOTV4ZkZ4SGdzb2E3bGZHMEZEUXJzRkpoenRX?=
 =?utf-8?B?NHdPQTRMb0p0bEIwY3ZJV2RzVzFrdjZBbkpTbHNZUFpNWjlpY3hDK2FQUXVk?=
 =?utf-8?B?TkNLTDdQS2dmQlQ3N09IV2IvODZENXZzNlRvSzJVdktVOU5jMlE2N3hDbTZY?=
 =?utf-8?B?RFAzZlFFek1Cb1ZSN0pQc2g2NEU5N0JCZEg2eUp0SHhUOXJPcUZHUGg2RjdB?=
 =?utf-8?B?WFM0V1pxZmJ5SThiUHUvZ2Rva1QzS0srbVlScWRpaVlpMTA1ZzAwZW1aZng1?=
 =?utf-8?B?bTBLTmgwK3ZwU0ltMVRiR0d0d0VmNjlwQ2RWRVJIOU04NW9QbHJ6ZFZkTWFM?=
 =?utf-8?B?SXROSWhHOWFhZGcxR04rZjlFNDZZWm9yLzk5RnB4alhYYkI4bGZDZXFiK0Iz?=
 =?utf-8?B?RlV2aHdFTk5GcmloelBicktPSW5zSEVsbkJKNTMyR0crZTJ6TFdPQ0taZlhH?=
 =?utf-8?B?ZGQ4N1ZDWFNKTEFtcE9vc3pGTktmWHBpYjVQQThvSnBQWTlsUnhrdXg2ZHhH?=
 =?utf-8?B?bjJVYTVkQjYvRWZkQjE0RzVaUmhmT2lTbnRUbnhTQ1RoTjlpL2g5UFRLcUF1?=
 =?utf-8?B?ajd0amxrK09JRGdJbXFpWUREM3AyNFhRbVBhdnliUHY2WHU3RHZ1WjVQREVZ?=
 =?utf-8?B?eUdFdkQ3MnNDalRCdkVNSE9PSmFiUnYyakcraVlzUFRtbHI2YWhObWIzM1ZD?=
 =?utf-8?B?N21yRzZRcWtxdlFPT015eGNCL3I2MWxSWmhkbk9YeXdiRG5vSkN0eFlUOFpC?=
 =?utf-8?B?TGlkTWhFRGJTdHg0cXE1NHVjV09xSyszWWtZT1hmUVJQZ1lza0NPRmFOWTBL?=
 =?utf-8?B?U0VzViswTmpwcXBWb3NLS0w0dUhSWkFsclRrYmhxV1hwcE1oQlNpc25wMnR6?=
 =?utf-8?B?aVV5TUcxbFpqbFdnQVBOWUcyUytrSks0MFZORDd4N1Z3YWdvNjJ6dlJqS20z?=
 =?utf-8?B?K0EybFYrRDNJWG1VMy9MWHVuTFhaUnBWT0Noci9DaElHaTg3K1lKRkl6enhT?=
 =?utf-8?B?TWo3N2FXNkN1ZFIwWUlSUGZXRncwa1VjWlltRnhPZm1tOWVFRGpBbU9KRldZ?=
 =?utf-8?B?SE85V0cyNXRxd3FYZHRnbkxnWU9LTnRLdUh0eXEwQTgyUk5INzdKYmZBQURQ?=
 =?utf-8?B?eWxqSnZTaXljcjFIbThmMEhpeUxUZE56Yzh0NTVwOVl6YTduaGl0czZsWW02?=
 =?utf-8?B?aHI4TG0vbHQ5MkRqbHVSVkUranQzQmlrS2labWRCaUxHWm53TGdiaGZlTUVP?=
 =?utf-8?B?LzB1SGpkbFplNkNUS0hqSEU5MmZVdTRPd0VjSjF3UmF6ZVlQVUE5SHJtUTFr?=
 =?utf-8?B?UmJTdnhjc2VVc0xNQVJrSms5ajFsMEFJdGl6b3dvcGEwd2V2ckQ2SWJveWQw?=
 =?utf-8?B?dnoyRTZLeVowTWdFQkdjMzJ1ZkVIS3hJdlBRTzN2dFRoUHozZVdhKzZmYlVx?=
 =?utf-8?B?OE1CVTI1NlMzM0FJZnFNK05lWW1zOWZmRWIvbmVTcmVKSG1sdmJjUWMwZ0VZ?=
 =?utf-8?B?eCtITWpxWVJsQnpLaFNZVitEL1VqSDMvalArQkxhUDYrYjE0eG1QbWJwN3Mv?=
 =?utf-8?B?cXA2aDZjMEJZMjRpUUZyOHVhT0pQc0FRZW82T1lsZ0RqQURIUU1IWWRxQTlE?=
 =?utf-8?B?VjN6dDJXNWZkdGV6amhVYmJma3lKMUF0SDBoUVRSU2dvMCttSVphYmxHaHVz?=
 =?utf-8?B?NDhNZGNtOWcyV2t5ekxYdmtXVXl5eUxrM0ZIM001Wk1zZ0luR2VnMm40Nno0?=
 =?utf-8?B?cjRMbm11emMvTUF1d3A2Tms0enRqQ2ZhQmNNRmQ0MmFvN2dLZkQrdmQvdVgw?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD77E380C5642746AAA323E9EAC60272@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8150083d-284e-46bb-7b40-08da630d1d46
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 07:15:20.2760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: og1rKzvH3g24II6enpWu/2MCZXwhFw7O6kaKwYWGdGqfoeIjq5mievyINLtwGI9Bb5QN2YpPUgx5FhPDyt9jP2hwUExCLd5K89uo7+A6EMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0057
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDcuMjAyMiAxNjoyNSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBOb3cgdGhhdCB0aGVyZSBpcyBkcml2ZXIgc3Vw
cG9ydCBmb3IgdGhlIFVTQiBkZXZpY2UsIGVuYWJsZSBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQoNCkFwcGxpZWQgdG8gYXQ5MS1kdCwg
dGhhbmtzIQ0KDQo+IC0tLQ0KPiBjaGFuZ2VzIHNpbmNlIHYxOg0KPiAgLSBhZGQgcGluY3RybCBu
b2RlLCBUaGFua3MgQ2xhdWRpdQ0KPiANCj4gIC4uLi9ib290L2R0cy9sYW45NjZ4LWtvbnRyb24t
a3N3aXRjaC1kMTAtbW10LmR0c2kgICB8IDEzICsrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9k
dHMvbGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEwLW1tdC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9k
dHMvbGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEwLW1tdC5kdHNpDQo+IGluZGV4IDVhNmM1Zjdj
MzcxYS4uM2VlY2FhMWI3MjA1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9sYW45
NjZ4LWtvbnRyb24ta3N3aXRjaC1kMTAtbW10LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9k
dHMvbGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEwLW1tdC5kdHNpDQo+IEBAIC03Niw2ICs3Niwx
MiBAQCB1c2FydDBfcGluczogdXNhcnQwLXBpbnMgew0KPiAgICAgICAgICAgICAgICAgcGlucyA9
ICJHUElPXzI1IiwgIkdQSU9fMjYiOw0KPiAgICAgICAgICAgICAgICAgZnVuY3Rpb24gPSAiZmMw
X2IiOw0KPiAgICAgICAgIH07DQo+ICsNCj4gKyAgICAgICB1c2JzX2FfcGluczogdXNicy1hLXBp
bnMgew0KPiArICAgICAgICAgICAgICAgLyogVkJVU19ERVQgKi8NCj4gKyAgICAgICAgICAgICAg
IHBpbnMgPSAiR1BJT182NiI7DQo+ICsgICAgICAgICAgICAgICBmdW5jdGlvbiA9ICJncGlvIjsN
Cj4gKyAgICAgICB9Ow0KPiAgfTsNCj4gDQo+ICAmbWRpbzAgew0KPiBAQCAtMjAwLDYgKzIwNiwx
MyBAQCAmc3dpdGNoIHsNCj4gICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ICB9Ow0KPiANCj4g
KyZ1ZGMgew0KPiArICAgICAgIHBpbmN0cmwtMCA9IDwmdXNic19hX3BpbnM+Ow0KPiArICAgICAg
IHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsgICAgICAgYXRtZWwsdmJ1cy1ncGlvID0g
PCZncGlvIDY2IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiArICAgICAgIHN0YXR1cyA9ICJva2F5IjsN
Cj4gK307DQo+ICsNCj4gICZ3YXRjaGRvZyB7DQo+ICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0K
PiAgfTsNCj4gLS0NCj4gMi4zMC4yDQo+IA0KDQo=
