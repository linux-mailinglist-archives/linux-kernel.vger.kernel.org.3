Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11652569E70
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbiGGJS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiGGJSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:18:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F23326D9;
        Thu,  7 Jul 2022 02:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657185531; x=1688721531;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rHYSVxA4iP1uch6UvW6qlMFRdMHbaf6JLPNZNBnvdzM=;
  b=FdHXHqb9lwqDm+3vfA6NU3LqOyxZwtnwDRg4Q+GnyODfu6H3UyEBikxG
   cGu8GEB2b1PBizt3GklxuqK5DNJMejRlXbhxuCUk0UrAKTtXPt57hFRDj
   G/3DLfvhN3N9U+eXuIDSQ6L8asMGZREwnvbucKInnqeYN+IQnohF5zBUT
   VwiEIVvpN6zAt5SmuRBn1BgaHA8siBEtJHy/dxWzQPEW8EKBznVJHFKsF
   AeqZzhtGJ1uz1/KkmXYNQX4j+Qje47BkRII/DO1Lqj2ZcP+okmmDInAWM
   NPKW33AzqZU8rUzWkvw4LJVs8UqidpEsJ9W8OMWjsuxsHY/HL62UEB9dm
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="171406156"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2022 02:18:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Jul 2022 02:18:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 7 Jul 2022 02:18:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOIQXhSBInyQNuOtB+VJbR08eV2p2pulTuP4C/TL5UbdFfcZOZAJpVuVB1gep1w9YaowteRGlKxLJPlhKoDYTzOsGRPBL3YmymONfn8Nn9n4Z6A8JGtZNbZsCWsQJrJDl/fmG65QKSWp+ih8hXMGjvcfITDGA8nkIy/836zZ4Pr5TQMi5/UB3PtbpX3sUsbKBahNA1y11Wh6jh75TqI55leNQZe7xLcu+VorqEXMLfFIcROJNbxADPMX1v/sUbps5Wqr6vYsBqxV0Vu4Ax/Az39VGZKPmxYN+DLYpaAkepKS/FmUo7UBMy22dtBntO2OFR6+8N1WfiX+K3tSxvX1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHYSVxA4iP1uch6UvW6qlMFRdMHbaf6JLPNZNBnvdzM=;
 b=cBmXMiEagFKmFKeDxIxUKMYEsvWilV/9UZo0DxEhZyp9irP7bB5PA0yynDl86yKISivVeoRk2i3XXFeRhJ3rtSD3e56zDa4Ci+mzVt8+FP8EEv0pa24SBYD+KagdVqj0FpFp1z1UDJbYVQRjI/w2f+QntlDvJBGDkCco/xfjGKTdrESYNbYVYgRqeJQtzSp/5xC3Ghq68rPY5hawntzzq20AVcd1XLjKok08mPk22Dc8Z2tgTf+0KnqL2zhYtZQHzxH1BSWSZj7A7OGFuPJ73sw6Ah8ptBdVz4c46YncONii6KSSJE1zfZusK4dHnbCmYI3aCJW/y/rQM9EpU7ijaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHYSVxA4iP1uch6UvW6qlMFRdMHbaf6JLPNZNBnvdzM=;
 b=f/JWbZeUbXdTx3GhR8lXs5du4dldKqu0X6F0UhsxKnbYm8B/CEmSOJesVwapGG9l5GRrxVKu2ZyuCfASSEQ+b2dTV903ekgfJ54mIcE3132eUKTFJU4zvH0NKrTyrTlUENCYPVZYgG89/V0B/1DE+SzokkHB5SEOM1hAN4NYCKM=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ1PR11MB6274.namprd11.prod.outlook.com (2603:10b6:a03:457::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Thu, 7 Jul
 2022 09:18:49 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 09:18:49 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Cristian.Birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: kswitch-d10: enable the USB device port
Thread-Topic: [PATCH 2/2] ARM: dts: kswitch-d10: enable the USB device port
Thread-Index: AQHYkRQjKznbj7Msf0eVP/ME+ToE5w==
Date:   Thu, 7 Jul 2022 09:18:49 +0000
Message-ID: <326e23f3-5312-0a0d-500c-a51c1e99c5f1@microchip.com>
References: <20220705130637.1386120-1-michael@walle.cc>
 <20220705130637.1386120-2-michael@walle.cc>
 <32a2193f-aea1-6237-a993-d0ba89cce431@microchip.com>
 <1747f5d89ca65a9e54d95e7dd77c4709@walle.cc>
In-Reply-To: <1747f5d89ca65a9e54d95e7dd77c4709@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1fb2a2b-7d54-49b6-f9d5-08da5ff9b39c
x-ms-traffictypediagnostic: SJ1PR11MB6274:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cE4c9JlQhDVLukCcxfaBnZ5jRRQTXkb7hgag+buC/ZT30XGDkOLO/J5qLYrrK6dRyCj0wPQQHIWKMlzUlhf8GGc6mCispEb+kHs6IHOMhQ44YkiXpcsbBuM8NC58quuwogrSGn10YEfZKHbS9vUZhShdNQNrELidNlJ4RQJAoUKXz9YSfb7CKU0EqBym97xCHyHpdA6yx5wW0N0Y2rv76h589aGf5KPN3wDRPhX9qQXUv2hlYKnla1vL7QF9vxDwxbgRNknGvdorCIS6VdHBfWr+BdVspcSgFj45kFsxiG/iJWKZIzt1eITLFXEMrlOU42g4o+C11GmP9gwndqr1sypQvoWWXnUkHxT3sZKky7fJ5FwTo6ZWSoCOfIHofc0bfX0LMlQQE5kKRYSDjlIg1GegmEEvbxh1LlJ8SpmoEc/D00UzXkdlRQVo31bUcXTl80leR07XfSBk9hS7fCZAMxNjJ9ylVqEOKsjrPhhBWR9hJKUqgA1xtVjnZ1YZXuhWxyZ8Acoc6KTHpCa9j1m6nOm8+gBF0R4+P2a8fAJkD48WEEdwEhynfTefRpt+/9DYKLvQHNd5ImYX0Lj5JXe2aSDs7NFyKl7VWvj7vx67zKdMN9888bCLHweoHS2tUD4kPIB9knvFreImujk/8d3NK6zpQNO/fmjBGyDygw3vBktptx84Klzu+d+O8EWTI6f6TY41vdlCk/35+O2p0DcUkrDqgCbsThyQ3LYtCYPEKZrE9L8Rf4Atkry/twEH1HrVe4FNCFxLAw0n0G72DojzV8nldSwQyoNKaZVsWRdMVH+d3fy8dpXjs6gs4pOlDvCKhjC2Voi+6cSKBdXyaRw85OfQjSxPDJG6QB2b+utPlSAPe1oKF76TC55MdIuCkFYe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(346002)(366004)(396003)(2906002)(5660300002)(6486002)(38070700005)(36756003)(83380400001)(478600001)(31686004)(66946007)(66446008)(54906003)(2616005)(91956017)(316002)(31696002)(186003)(8676002)(71200400001)(66556008)(6916009)(8936002)(4326008)(86362001)(38100700002)(66476007)(53546011)(41300700001)(122000001)(6506007)(26005)(6512007)(76116006)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWJIRVBTZzJkbFliZE9Jb2VjSFpLdDB3Vm94RXhZdmk2VFVrREQ5bGIyUms1?=
 =?utf-8?B?OFRwOENQOUN5UnljQnZmRkJHUFV0SkJWb2NjNFhQN0VvY1BkUGRtVi94cDRa?=
 =?utf-8?B?Sm9XZ05Nc3ZRekEyVUh6WWFMcUdwUGF4bzNuZTZhd1l6RTNPdVB4KzEvT3NW?=
 =?utf-8?B?OThlKzliOVFDMGtyMXhRYkd4bTEyZ0JRbmR3Zm5xTFltV09zRGhoSXI2ODBo?=
 =?utf-8?B?dzIxbnJIL3pxckdqbHZNSzNsT2JwS0tjRGJLSk5kTGFjQXEyYWRISVpXTG5t?=
 =?utf-8?B?MEVQcHh6b1ZyQm40UHc2OTJCMExiREIzSHQxWXNFeDNmM29NVFlqclBFbUVL?=
 =?utf-8?B?NnFIV2g0OGdweGlDSnJyQmtuREZVdCtycmVzbHphK21LVmIwNjdzMUVtbjRW?=
 =?utf-8?B?SDVuQ1JIWEcycXM5Q204eHhwMFdZbVlvZXhhODVEbHhsVUFpM29nalJKdVJz?=
 =?utf-8?B?MXVjSnBFa3pNM2taSVZiQjNmbG1Zb0gxQUdhMHVyT29qaXNXVWdkVVRiR1Jt?=
 =?utf-8?B?UHJmNzM4N3QyQnQrT2pJbnVReTJEUVdDTFNOd2JmdEJzem9WNHN6R2hVaEZO?=
 =?utf-8?B?Y2R1Z3hXa3RPWFgwVlpWMFlHVGx2MVV6OFpETmt2ZW9kWW1FZWpNb1UvOXl0?=
 =?utf-8?B?WWJxSXFEc0J2Mzg3M0lGdGVCMmMxRjJRdEVrd0pjUU4rNFFkTzBGb0VlMW82?=
 =?utf-8?B?UndHQ1lrVFV2TFcxUkg5WkNkb1V6Sk9oUWhTUGlEcGNETDU2c3R4MmlabS9r?=
 =?utf-8?B?M2hTMGU4bk8zc3J3THJVZXY1d2h0M0pTWVBybnd3QnIvdnkvd2dzOU03V0Q4?=
 =?utf-8?B?UXpOaUMyRkZWN0RMb29DQlBIZzNpckgzU1JzOU1ZV1Ara3Q0Y1VZR3VaTUZ1?=
 =?utf-8?B?N3BQUThLeDJqTm1walhyZ3ZCTVdUTjM1QlkzWUpwZkhqcVp4UjhBRGJnalVn?=
 =?utf-8?B?VkE5elBadWhEcnJYa3hSTHJ1SjNZeFhIaXd6c3oxbVduTk9SQWdnVUNldjdu?=
 =?utf-8?B?YnE1N1k3a1pNemVhRXkwenVHeTlROExMRkRNdmRPa0FCZ1JxV3FrY3lJSFMy?=
 =?utf-8?B?anEwUm5HSHZ2T0ZndVF0Q1NORGwvNzdiZlBiLytXbjJmNDJNY2JXOUZFa3Zt?=
 =?utf-8?B?VloxbVc3Rk54N3BPOU5zQW1aZUJNeUJxS3ViRnlPdjI1ZTVEczZwVmdtakhQ?=
 =?utf-8?B?QWJsSUNBMWNUTm4wR1orTWRFakNoaGorNVN5VVQ1blRpYSt5bnRQNFlmZzBJ?=
 =?utf-8?B?N082S2hZbEJpY21KQWxSSmFvNll4VFl4eW8yUHY0c1VPWnIrYVVpOG1jNFZr?=
 =?utf-8?B?cThXZE9taW4raXdKeCtVcWdTYzdhUWVvSEQ0WXZLMzRxczF4QXZPdU9FMGRK?=
 =?utf-8?B?WmpMbllIVHBpZU5rcUtTaFRjc1hxMXBXRTFHcjZHME9OaU1SYTU4dlpZY2tm?=
 =?utf-8?B?NnlNTmRTRFRiTC9pT0tONnpPYUZ5bHBkanlvdm41dWl0M2hhbE4xb2JVSU9q?=
 =?utf-8?B?dXBVdWZtZUVNbDVRSnVPcWhFa1JBVFR0dUhBeERub1FYNWFFM0puS2pVNGdi?=
 =?utf-8?B?RWpJU2RJY09kV2J6QnNLMi9HeEpNVXZBQnBkaTdLUFB0Zjdjd1JONVZDQmEw?=
 =?utf-8?B?eThDZTAwdWMxb2psbGpnTEh3UWxsZE5rejlwcFpOdUlpYXRubnFVdzZyeThj?=
 =?utf-8?B?UmZCNDhKS0Z3VnJlYVhOd0NJY3A3WnpnZkVhN1VFd3d5Unk4VTBzT1VlR0Na?=
 =?utf-8?B?d3FvSEdtZEpsKzNBMTFPMi9lbUV2bVRKclRaREMzYWJ2aGpVeUpsSWdCY1lR?=
 =?utf-8?B?em1ZUWRnSjc2YWdRM0NrMC9OMHJTcUJWV0VWbWdxckw2bW5mOU91MmxaMnVH?=
 =?utf-8?B?ME9zOWV3ZjRHck9DZGUzdFBENmZrQi92cUNwdllWRndYKzF1enJ3SnNIdk1J?=
 =?utf-8?B?WlM3UnhGcHRRRFFiUnlZSnVudExMOFhpdEdEYWNpYUx1N0l5UGtZSmxobDBM?=
 =?utf-8?B?Rmg0RE9abWxQTTdNdnB4MjkwK1RNa0dTQzQ2ZFl2SGRPSVRQZFRkaFROSDM4?=
 =?utf-8?B?ckdiWERsQjJYRVRzRVdMTG1zZFZzZWtxK0p4M0JqSW40UTFCOWZSb3JURmoz?=
 =?utf-8?B?Z2VibnlUN2tUeEVYVDVPQ2p1ekhlSExDNTF0ZE9MYVczZDBXWGlsdEw5R3Ur?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A43351BD24F664B81E0D81AD3DB4ADB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fb2a2b-7d54-49b6-f9d5-08da5ff9b39c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 09:18:49.0938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZeZMeCZh9/mAWoWIJQt8dMEsAGnTalbZzVDmwwx5+JdjpsBLSwDhrfkGe//e9gyfxvo8wyGj3Iw3EmdQkJtuwWmkSQ3Zw6Hs4cHL2ZkxkgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6274
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYuMDcuMjAyMiAxMTo1NywgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUNCj4gY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBDbGF1ZGl1LA0KPiANCj4gQW0gMjAy
Mi0wNy0wNiAxMDo0MSwgc2NocmllYiBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tOg0KPj4g
T24gMDUuMDcuMjAyMiAxNjowNiwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4+PiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93DQo+Pj4gdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gTm93IHRoYXQgdGhlcmUgaXMg
ZHJpdmVyIHN1cHBvcnQgZm9yIHRoZSBVU0IgZGV2aWNlLCBlbmFibGUgaXQuDQo+Pj4NCj4+PiBT
aWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPj4+IC0tLQ0K
Pj4+IMKgYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1rb250cm9uLWtzd2l0Y2gtZDEwLW1tdC5k
dHNpIHwgNSArKysrKw0KPj4+IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPj4+
DQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2Nngta29udHJvbi1rc3dp
dGNoLWQxMC1tbXQuZHRzaQ0KPj4+IGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1rb250cm9u
LWtzd2l0Y2gtZDEwLW1tdC5kdHNpDQo+Pj4gaW5kZXggNWE2YzVmN2MzNzFhLi5kMGQyNmUxMzZj
MzggMTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1rb250cm9uLWtz
d2l0Y2gtZDEwLW1tdC5kdHNpDQo+Pj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1r
b250cm9uLWtzd2l0Y2gtZDEwLW1tdC5kdHNpDQo+Pj4gQEAgLTIwMCw2ICsyMDAsMTEgQEAgJnN3
aXRjaCB7DQo+Pj4gwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0gIm9rYXkiOw0KPj4+IMKgfTsNCj4+
Pg0KPj4+ICsmdWRjIHsNCj4+PiArwqDCoMKgwqDCoMKgIGF0bWVsLHZidXMtZ3BpbyA9IDwmZ3Bp
byA2NiBHUElPX0FDVElWRV9ISUdIPjsNCj4+DQo+PiBDYW4geW91IGFsc28gYWRkIHBpbmN0cmwg
dG8gYXZvaWQgaXNzdWVzIGRlc2NyaWJlZCBpbjoNCj4gDQo+IERvIEkgbmVlZCBhIHBpbmN0cmwg
bm9kZSBldmVuIGlmIEkganVzdCB1c2UgaXQgYXMgYSBncGlvPw0KPiBJc24ndCB0aGF0IGhhbmRs
ZWQgYXV0b21hdGljYWxseSBieSB0aGUNCj4gLmdwaW9fcmVxdWVzdF9lbmFibGUgb3A/DQoNCkkg
Y2Fubm90IHNheSBmb3Igc3VyZS4NCg0KTG9va2luZyBhIGJpdCB0aG91Z2ggaXQgSSB0aGluayB0
aGUgaXNzdWUgZGVzY3JpYmVkIGluIGNvbW1pdCBJIHBvaW50ZWQgbWF5DQpjb21lIGZyb20gdGhl
IGZhY3QgdGhhdCBzdHJ1Y3QgZ3Bpb19jaGlwOjpyZXF1ZXN0IG1heSBiZQ0KZ3Bpb2NoaXBfZ2Vu
ZXJpY19yZXF1ZXN0KCkgd2hpY2ggbWF5IHJldHVybiAwIGluIGNhc2UNCmxpc3RfZW1wdHkoJmdj
LT5ncGlvZGV2LT5waW5fcmFuZ2VzKSBpcyB0cnVlLiBUaGUgY29tbWl0IHRoYXQgSSBwb2ludGVk
IHdhcw0KaW50cm9kdWNlZCBhZnRlciBjb21taXQgMmFiNzNjNmQ4MzIzICgiZ3BpbzogU3VwcG9y
dCBHUElPIGNvbnRyb2xsZXJzDQp3aXRob3V0IHBpbi1yYW5nZXMiKSBidXQgSSBkb24ndCBoYXZl
IG1vcmUga25vd2xlZGdlIG9uIGl0Lg0KDQo+IA0KPiAtbWljaGFlbA0KDQo=
