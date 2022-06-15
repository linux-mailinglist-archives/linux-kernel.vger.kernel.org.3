Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA1E54C726
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346678AbiFOLHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiFOLG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:06:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D2211A3D;
        Wed, 15 Jun 2022 04:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655291218; x=1686827218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fcmMvhDwd8rya76Zq47xWXueI8YhpscMWLM9bZ6wcB4=;
  b=LeHKvA7UzngBz2OkHPqRMadlUa1I0tRBrcqC4wJNI7U4Y3fgaR8fDoTT
   +LjU/OdevGRxsdxne4qJxq77l4+HUeebRcGtuBJq5uensq7gHaxzpzu6P
   0X3WU3sUBFEYANbrPyWSCPT3U25baqvXq6fpS+uaAdsZ06r9iVsqgzwCB
   x7YFt7+HmCY74Cg8VZK7Ag10v4kHMmI3yIqKLAgtF1MYJf4Rz04LuWyct
   ql1C535CuhCJNLEWPM++BRIsn6mRDPEVkKIZxMAfAZrBh9JKmYmEgnO8S
   FJzKwt8JC7CVBGS+QlrQ5pwS39yeYhBgaWrYzd8SekaRFgpiMmF6UmyHJ
   A==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="178045299"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2022 04:06:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Jun 2022 04:06:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 15 Jun 2022 04:06:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nB8BroRnrb10mx5O/qQXg+La9VDdhl2Vq0KJ/F65DgRVYbzHXqzvVL3fEhrDxRQGvbMJ23PikD+Ad+M4AzgWWI+4Ia3momG8anQsHwhrLT4PMV8qBC4As5d/6EYeXmmn6ng8o6aFjFm8IKLTxh1Uh2++6GL7d25UDIFwbMcRYKMGxbZ6jgoLWB73MJ6LfUUKZOXfPCpxUV7KbIJk6Sgd/sOHvIJ2MZ5jJSrEHmknnfBQRqOcZuaPrQaO9yP0leUhXI1hhxHQzKkR9uPddK9mwYEqeYi/LAXGCI52i7ZLDma6o9etqmk7vaiY3RsLFKc9cWqn12c2EUw/+caeOU6kqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcmMvhDwd8rya76Zq47xWXueI8YhpscMWLM9bZ6wcB4=;
 b=IyIi/t9Ac985aG+vidwFTQIjtyQNZITTUhZ2HWz9dHdxTEw8sX6oNNr5V3zM5BKT6ZDO/0vA1NmsqTqixEv+9dqHtyPEylwXfLM7PyjhxElY/Iu5xGzuye0Jd67fimBJv1q5QL8n+C9vH4As9mlrgDX1WpRjMBuTbjJfA8H9+DhJhUpDNdc38Q11CdZNwoWL/ZwtUnCcutAQ4mEwdORHYC1RFVsxFj/sdJ8FwMX6fQpU299tw2YZLk0iLeDRY50BqkqsFsL0loKEM+BeVtbgdNGCE3Cvhna3a1in/krFkf2SRo0nmpGKyRw/MG5NTs1l6+12aWExNCzCQFw07baK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcmMvhDwd8rya76Zq47xWXueI8YhpscMWLM9bZ6wcB4=;
 b=hIwOSTJ9453aEKDzuqMsoXuiP2X3cBNoGkmgOEskdxs+Lz5keDm1fOzEeAYODECWx7O8dIHcyJKaXOmNY4JWCw4uh6rcTw9Ze6hVOAACvmx8XleTTGgRvydsH4VDA6Yi2VY5HRFpW/Sh0S4SZqe2/B8cBcHM/66ZOco5wI0Deh4=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by CY5PR11MB6510.namprd11.prod.outlook.com (2603:10b6:930:42::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Wed, 15 Jun
 2022 11:06:37 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::c9c8:3bab:6b8f:5376]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::c9c8:3bab:6b8f:5376%8]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 11:06:36 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <hverkuil@xs4all.nl>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <jacopo@jmondi.org>
Subject: Re: [PATCH v10 0/5] media: atmel: atmel-isc: implement media
 controller
Thread-Topic: [PATCH v10 0/5] media: atmel: atmel-isc: implement media
 controller
Thread-Index: AQHYXtNy0DBb1d5tjEaFV5GKOhbPdK1QklAA
Date:   Wed, 15 Jun 2022 11:06:36 +0000
Message-ID: <1da0d3e3-7c63-eac8-c3ac-9083d5d16c88@microchip.com>
References: <20220503095127.48710-1-eugen.hristev@microchip.com>
In-Reply-To: <20220503095127.48710-1-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87b83c53-3b92-4c0d-068f-08da4ebf1d76
x-ms-traffictypediagnostic: CY5PR11MB6510:EE_
x-microsoft-antispam-prvs: <CY5PR11MB65104CEC4F7603FDFFD01961E8AD9@CY5PR11MB6510.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BR5fGQ4Y5u/kvxCp5XCA12arm4h8dzepUbE8cjfSoDTHH9DKxiNfZDnJT5UOB/k7QO9KqGNmisR1P/IbhNrlGci+1ALI5o37mb02ebAapGncJtxowP/cEj5MC9lOQGDXG2AhDIVxnAIQIPd2cnCUklUBBDq51gz1ChtFgNL2lUNnmnfTDuIk7CaVT5xY65b8zBc14cVwyNaqvRgqNRDGWXnUGuZfA/GJVHT1f89jJTpMkxBYcRPpgZKg93+oHTmTZpQweh714a9d3Y4y9tipC8Lv9XGaDmxlcaIlOTT5WPrsOO+McS9Xxe0w10f4qAf29z1LwnPQQGamJD68FycrKE4qDQJjKODMbAD9VvjBlH8tzGzxVX2RrNWZi/c2WgkleShZcqEOUmaHA5rm20OQr7EsVq5ZCZI7DsMcWHLOjMzY8JvBRM3OphnguLYvyrHjUEKq7yn/ANpm6cCIKPp1toQ7L4T2+ICYMv7Ke3GT7ax8MWKGHVhisjwbMXSoLXmNG5+uIgwKKwaMbZ18eIoQ/fUsOgpzsOLnbSc3W/HLQnO/TJaYnxgEPq9oU8Lf2PbmkgvnJc1xHVQMF8LqGpRG8xEA38Gpm9/EFfctBffvbiqlxAyKjKq8Uurn/NlMvDFjJKYDlPsyRBn8u8ShkXa1LCQ29AX27CEybaOXUXQveFQpBywSU1nZm6g9Q5ORo4CjPb6yQrbDIozzThezHbDl/vA2TbaDdSBhzky2SVnXEJyNGSMlMIoZhMMDrrXir6bwMvH3VthBB4S2xevIz1eEDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(31696002)(86362001)(76116006)(83380400001)(186003)(71200400001)(316002)(66946007)(4326008)(6916009)(64756008)(8676002)(66476007)(91956017)(31686004)(38070700005)(508600001)(66556008)(66446008)(6506007)(6486002)(5660300002)(54906003)(38100700002)(6512007)(2616005)(53546011)(8936002)(36756003)(2906002)(26005)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU16R1VNZUNQem15Yjd2dFhFTGZzWDIzb0hLb2ROZlJTaDlNWEhxcCs0d3Yr?=
 =?utf-8?B?cWMxR0xMTkJFbC9OMlpPeTA0WCtLVks3RVk4NWV2TVZMYkJiWDh2NHpEREtO?=
 =?utf-8?B?WTdBZVh0UnVNOERmT1RkcUVrdTdrZmdiRDFmOGVMRnJxTm4xRE1NbENRWkJh?=
 =?utf-8?B?Rys4L0VvSkx3RDJOTFppTnZTNi9FVnJreDVHTTNKM1Nvb0RPZUw5TndxOTBH?=
 =?utf-8?B?bncvU0xmblF3SzgvWDZHak4zRjNkR0ZlZFN6NlJtZ3BXL0c2SkVzRGJWZ3Zs?=
 =?utf-8?B?YmI1UjVnY3VwZlpWRXFXY2ZwdlByTXZrOUdJQUdZQkFrQWwvWEhUaEpWaHVG?=
 =?utf-8?B?bkVna1ZycDhTMkFvS0hRNDJxYTc4VkROTEVVZzhPMG52aUVmWE1oRm45NDMv?=
 =?utf-8?B?b05Sa1N4MTFET3lSbVEwMEFQZkIxN2JHQVdDTUI0OFA5OHlRSm0rQ3hKdThB?=
 =?utf-8?B?YTM5cFJmRmdEQkcwNHZSZmN1aGcrY2ZjRVIwbkZMdGl1RUJIL090ZDBxQWti?=
 =?utf-8?B?RVMrUHpOdE1TdEgyRE5ERHZSUzhSSXpkN3NuODArdXlOSFVDQXZKa2N0Qytx?=
 =?utf-8?B?L21iQTdYc1E5K255cHJocUZRT3NpWWpzVnI5V2hlWjI2SE9kbktJMUFrUytK?=
 =?utf-8?B?UnBsL1JPYXAyM1BXR1R2dHdaQnFMT1BpL1VHNWxuM2FKT2cwN1NHblhmczJs?=
 =?utf-8?B?UnRCTHZ4K3NLdkx5bXZnSzljZGlsTy9rWHJHM0tJazRuRzR3MDRBaGROSzNX?=
 =?utf-8?B?dVBBZVhPTUxKcVJHcE94V3lhbUlFYzdacDFwTWpUMi9PZVZlaU1iNERiNlUy?=
 =?utf-8?B?UnB5M215NWk2Q1lkdzJmMWlLL2VUMWFhUlFmejh0TGd6Um00ZFltQTNBOHg4?=
 =?utf-8?B?Q0pUZzBERjJpL1hlU0ZwbU92ZWtGMnNjMksrQVFNSjdrT3RXbWJhRDhJbTB1?=
 =?utf-8?B?MGpaVUpzaTNZWmM3amZXdTgwdXpnVkQxL1dLY3g3LzA3K29rczU0MzFmNzJp?=
 =?utf-8?B?WkZOY2l3RE8rUzFmaVBhZ2pnRWtLNVFvajhYY3pSZURMTGl5Tlk1S3BZZith?=
 =?utf-8?B?dUlPSVZnL2FUaFZJajUvR3FTZVp5alBqSnJSWWR4dUU3MGRyVDNKZFlMd3RM?=
 =?utf-8?B?T1dOeDNzQ0NtYWlJd3NYUzErUm15NXI5ZG1idkdtRUJEUUpkYWhGK21sTXQy?=
 =?utf-8?B?TG9UODdsTTgwOElrU2s2Vnh3UEtnZmVHSkZNUDJEbUtaTkIxU3FCem94K2hI?=
 =?utf-8?B?WmJsb0lhdVZzSE92NTZNdWRvOXY3d2lxQVIrVzlhOFB0SW5tZGlTYzA1NVN6?=
 =?utf-8?B?RTFGdG5mTkk0V2ZsU1pRSUh0QTBoRWRXSzJmaFpGUVptUVZOdUJjZ3ZFWDht?=
 =?utf-8?B?akx1TlpKSXlpYkhXMGRlY1pqbDRaVHIwNDI0TVRyRnNxZ1I0Q1FMbm9McDUv?=
 =?utf-8?B?eU9UL3V4anBCc1ZKZVNFRCtoUGFNTmc2RmNLSGtJMEw5VE1iZW83a0ZkOTcr?=
 =?utf-8?B?T1l3WmtNcVlVYlVwRUFOdC9ucHpTTkVRdEVJS281TnVRSmo3QnlXZmlMVysr?=
 =?utf-8?B?Y1VQcWlLQnZFR1BISHdaTUEyV0lIU3RxRnFqNkpFc3hXOVUxODl4bEx5TE9U?=
 =?utf-8?B?R0F1aTBIcXRZN2w0UG9tM1FBMytOLzRVYzBWUU9yaGY1dlRwc2RwcGFGNG43?=
 =?utf-8?B?NnRSZE02TUk3QVZ4U1QrYTZUUTRIaW85dFpRM2VBVm5kcVBldXprT2pYODI2?=
 =?utf-8?B?cVhES1RVNlNjd0MzQm84djhJdHR0cmlVZGZzdjdRNzJSZ0tmNk8wcVJrWW8z?=
 =?utf-8?B?QXhWK1NienJDWm9uUXJhcHpHVStEbDNuMlhiQ0ZJSURvZm9vU002ZXN3WER1?=
 =?utf-8?B?Q2w5UXBBTFNqNUpENUpFVGVKTVR1RmxObTdGTjJYQ0lTZU9FUENEOVdHbC9O?=
 =?utf-8?B?cDNHVHRNRFh3cU1PNGE3dWxiYzJ5aHdSL0hwOUZ2TzRUZ0Z4d2wyMERNRVVL?=
 =?utf-8?B?OWlIcnVkcWFhbHZGSzBUOG0yaTlaTFBFbkc2Sisvd3pqTWhSL2xFSlZWRVZu?=
 =?utf-8?B?VW4vamNGRmJrNU5NR3M2L3lhMHlPT290MWZhTE9uY3ZsOVFON29kTVdJRm14?=
 =?utf-8?B?UFQ1S01DK2txdXdQU08vejhFVFhHK0hEQU5JUHo5OXdsN0ZzL01jVnlXNmVq?=
 =?utf-8?B?NzFleWtNd3ZhT3U5SXRsdlRaV1cvdnhoOHd2WEhiZjJqUzZIVHptREhGMG5E?=
 =?utf-8?B?RDB0UUk2UFlWMnBpRGZTbG5jVFRqamxTcUF2UUdIZVArNmYyQUpxdzJWaVVr?=
 =?utf-8?B?TXdEOGxsd04ybWNCR1JMZzExY1dxY0NKOFRHeGFQSXJES3p0WXZ0THZCUlBZ?=
 =?utf-8?Q?mfDggVAlQjJxHrTE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F7CA46F553BB742A17A241247BE2323@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b83c53-3b92-4c0d-068f-08da4ebf1d76
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 11:06:36.6184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0f7Tujxfqfms00GQotTesy6+Ik5oyu8Ue3QbyU7ZnG7rGO5PSWI9fVm4qfi585iaHddrHRM9CTh4RdcGM6D/V12fuYX2fCxfQHcvLxSQiN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6510
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zLzIyIDEyOjUxIFBNLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0KPiBUaGlzIHNlcmllcyBp
cyBhIHNwbGl0IGZyb20gdGhlIHNlcmllcyA6DQo+IFtQQVRDSCB2OSAwMC8xM10gbWVkaWE6IGF0
bWVsOiBhdG1lbC1pc2M6IGltcGxlbWVudCBtZWRpYSBjb250cm9sbGVyDQo+IGFuZCBpdCBpbmNs
dWRlcyB0aGUgbWVkaWEgY29udHJvbGxlciBwYXJ0Lg0KPiBwcmV2aW91cyBmaXhlcyB3ZXJlIHNl
bnQgb24gYSBkaWZmZXJlbnQgcGF0Y2ggc2VyaWVzLg0KPiANCj4gQXMgZGlzY3Vzc2VkIG9uIHRo
ZSBNTCwgbW92aW5nIGZvcndhcmQgd2l0aCBoYXZpbmcgdGhlIG1lZGlhIGxpbmsgdmFsaWRhdGUg
YXQNCj4gc3RhcnQvc3RvcCBzdHJlYW1pbmcgY2FsbC4NCj4gSSB3aWxsIHRlc3QgdGhlIHBhdGNo
IDoNCj4gW1JGQyBQQVRDSHYyXSB2YjI6IGFkZCBzdXBwb3J0IGZvciAodW4pcHJlcGFyZV9zdHJl
YW1pbmcgcXVldWUgb3BzDQo+IGFmdGVyd2FyZHMsIGJ1dCB0aGF0IHBhdGNoIHJlcXVpcmVzIG1v
dmluZyBteSBsb2dpYyB0byB0aGUgbmV3IHZiMiBjYWxsYmFja3MuDQo+IA0KPiBGdWxsIHNlcmll
cyBoaXN0b3J5Og0KPiANCj4gQ2hhbmdlcyBpbiB2MTA6DQo+IC0+IHNwbGl0IHRoZSBzZXJpZXMg
aW50byB0aGlzIGZpcnN0IGZpeGVzIHBhcnQuDQo+IC0+IG1vdmVkIElPX01DIGFkZGl0aW9uIGZy
b20gZmlyc3QgcGF0Y2ggdG8gdGhlIHNlY29uZCBwYXRjaCBvbiB0aGUgZHJpdmVyIGNoYW5nZXMN
Cj4gLT4gZWRpdGVkIGNvbW1pdCBtZXNzYWdlcw0KPiAtPiBEVCBub2RlcyBub3cgZGlzYWJsZWQg
YnkgZGVmYXVsdC4NCj4gDQo+IENoYW5nZXMgaW4gdjk6DQo+IC0+IGtlcm5lbCByb2JvdCByZXBv
cnRlZCBpc2NfbGlua192YWxpZGF0ZSBpcyBub3Qgc3RhdGljLCBjaGFuZ2VkIHRvIHN0YXRpYy4N
Cj4gDQo+IENoYW5nZXMgaW4gdjg6DQo+IC0+IHNjYWxlcjogbW9kaWZpZWQgY3JvcCBib3VuZHMg
dG8gaGF2ZSB0aGUgZXhhY3Qgc291cmNlIHNpemUNCj4gDQo+IENoYW5nZXMgaW4gdjc6DQo+IC0+
IHNjYWxlcjogbW9kaWZpZWQgY3JvcCBib3VuZHMgdG8gaGF2ZSBtYXhpbXVtIGlzYyBzaXplDQo+
IC0+IGZvcm1hdCBwcm9wYWdhdGlvbjogZGlkIHNtYWxsIGNoYW5nZXMgYXMgcGVyIEphY29wbyBy
ZXZpZXcNCj4gDQo+IA0KPiBDaGFuZ2VzIGluIHY2Og0KPiAtPiB3b3JrZWQgYSBiaXQgb24gc2Nh
bGVyLCBhZGRlZCB0cnkgY3JvcCBhbmQgb3RoZXIgY2hhbmdlcyBhcyBwZXIgSmFjb3BvIHJldmll
dw0KPiAtPiB3b3JrZWQgb24gaXNjLWJhc2UgZW51bV9mbXQgLCByZXdvcmtlZCBhcyBwZXIgSmFj
b3BvIHJldmlldw0KPiANCj4gQ2hhbmdlcyBpbiB2NToNCj4gLT4gcmVtb3ZlZCBwYXRjaCB0aGF0
IHJlbW92ZWQgdGhlICdzdG9wJyB2YXJpYWJsZSBhcyBpdCB3YXMgc3RpbGwgcmVxdWlyZWQNCj4g
LT4gYWRkZWQgdHdvIG5ldyB0cml2aWFsIHBhdGNoZXMNCj4gLT4gcmV3b3JrZWQgc29tZSBwYXJ0
cyBvZiB0aGUgc2NhbGVyIGFuZCBmb3JtYXQgcHJvcGFnYXRpb24gYWZ0ZXIgZGlzY3Vzc2lvbnMg
d2l0aCBKYWNvcG8NCj4gDQo+IA0KPiBDaGFuZ2VzIGluIHY0Og0KPiAtPiBhcyByZXZpZXdlZCBi
eSBIYW5zLCBhZGRlZCBuZXcgcGF0Y2ggdG8gcmVtb3ZlIHRoZSAnc3RvcCcgdmFyaWFibGUgYW5k
IHJld29ya2VkDQo+IG9uZSBwYXRjaCB0aGF0IHdhcyB1c2luZyBpdA0KPiAtPiBhcyByZXZpZXdl
ZCBieSBKYWNvcG8sIHJld29ya2VkIHNvbWUgcGFydHMgb2YgdGhlIG1lZGlhIGNvbnRyb2xsZXIg
aW1wbGVtZW50YXRpb24NCj4gDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIGNoYW5nZSBpbiBi
aW5kaW5ncywgc21hbGwgZml4ZXMgaW4gY3NpMmRjIGRyaXZlciBhbmQgY29udmVyc2lvbiB0byBt
Yw0KPiBmb3IgdGhlIGlzYy1iYXNlLg0KPiAtIHJlbW92ZWQgc29tZSBNQUlOVEFJTkVSUyBwYXRj
aGVzIGFuZCB1c2VkIHBhdHRlcm5zIGluIE1BSU5UQUlORVJTDQo+IA0KPiBDaGFuZ2VzIGluIHYy
Og0KPiAtIGludGVncmF0ZWQgbWFueSBjaGFuZ2VzIHN1Z2dlc3RlZCBieSBKYWNvcG8gaW4gdGhl
IHJldmlldyBvZiB0aGUgdjEgc2VyaWVzLg0KPiAtIGFkZCBhIGZldyBuZXcgcGF0Y2hlcw0KPiAN
Cj4gRXVnZW4gSHJpc3RldiAoNSk6DQo+ICAgIG1lZGlhOiBhdG1lbDogYXRtZWwtaXNjOiBwcmVw
YXJlIGZvciBtZWRpYSBjb250cm9sbGVyIHN1cHBvcnQNCj4gICAgbWVkaWE6IGF0bWVsOiBhdG1l
bC1pc2M6IGltcGxlbWVudCBtZWRpYSBjb250cm9sbGVyDQo+ICAgIEFSTTogZHRzOiBhdDkxOiBz
YW1hN2c1OiBhZGQgbm9kZXMgZm9yIHZpZGVvIGNhcHR1cmUNCj4gICAgQVJNOiBjb25maWdzOiBh
dDkxOiBzYW1hNzogYWRkIHhpc2MgYW5kIGNzaTJkYw0KPiAgICBBUk06IG11bHRpX3Y3X2RlZmNv
bmZpZzogYWRkIGF0bWVsIHZpZGVvIHBpcGVsaW5lIG1vZHVsZXMNCj4gDQo+ICAgYXJjaC9hcm0v
Ym9vdC9kdHMvc2FtYTdnNS5kdHNpICAgICAgICAgICAgICAgIHwgIDUxICsrDQo+ICAgYXJjaC9h
cm0vY29uZmlncy9tdWx0aV92N19kZWZjb25maWcgICAgICAgICAgIHwgICAzICsNCj4gICBhcmNo
L2FybS9jb25maWdzL3NhbWE3X2RlZmNvbmZpZyAgICAgICAgICAgICAgfCAgIDIgKw0KPiAgIGRy
aXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvTWFrZWZpbGUgICAgICAgICB8ICAgMiArLQ0KPiAg
IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLWJhc2UuYyB8IDQ4NSArKysr
KysrKystLS0tLS0tLS0NCj4gICAuLi4vbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLXNj
YWxlci5jICAgfCAyNjcgKysrKysrKysrKw0KPiAgIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRt
ZWwvYXRtZWwtaXNjLmggICAgICB8ICA1MCArLQ0KPiAgIC4uLi9tZWRpYS9wbGF0Zm9ybS9hdG1l
bC9hdG1lbC1zYW1hNWQyLWlzYy5jICB8ICAzNCArLQ0KPiAgIC4uLi9tZWRpYS9wbGF0Zm9ybS9h
dG1lbC9hdG1lbC1zYW1hN2c1LWlzYy5jICB8ICAzMiArLQ0KPiAgIDkgZmlsZXMgY2hhbmdlZCwg
Njg1IGluc2VydGlvbnMoKyksIDI0MSBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2Mtc2NhbGVyLmMNCj4gDQoN
Cg0KSGVsbG8gSGFucywNCg0KV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgdGhpcyBzZXJpZXMsIGRv
ZXMgaXQgcmVxdWlyZSBtb3JlIHdvcmsgb3IgDQpjaGFuZ2VzIHVudGlsIGl0IGNvdWxkIG1vdmUg
ZnVydGhlciA/IEFueXRoaW5nIGluIHBhcnRpY3VsYXIgeW91IHdvdWxkIA0KbGlrZSBtZSB0byB0
cnkgb3IgdGVzdCBvdXQgPw0KDQpUaGFua3MsDQpFdWdlbg0K
