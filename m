Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A270B582199
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiG0HzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiG0HzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:55:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D6D42AC9;
        Wed, 27 Jul 2022 00:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658908499; x=1690444499;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=JCsiO/P9YNCdpXt/oVwKIPFLabq6faCTiZnJVuNORlg=;
  b=D6gr/gNlgO3a2RUWY/mMIMD0TPcyqftmNRvA7THqyyRW4kAZKGTLySrl
   WknBasY9XvAF+lZZv+EsYn96AzPfw6r4KatyJJAN+QVZrmbC8lMZibnV0
   C42Be9VFUvAa7s4603xtI0naAWOmB3zVxDiTflghgtxcAhQU1TJdqFCew
   iin0yH55B/8BUtbvN/nb1kvNsmYINUXgvhmlAX3rrnU5NChOTtuFDWKhh
   EG4ZQ+Vx6BIINyArTdrFozKn+Y1BCtmeKgRuLvEyGED6PXpekg01N/+5L
   P/eRzhCu54ruwUe9n8sYFLp6ZEDuvgeXf0zwt/wf6N+71WH8VHkq5q+UP
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="183923295"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 00:54:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 27 Jul 2022 00:54:57 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 00:54:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DN9TqCut4gA3nseJrEWxLok5grEaqZOP7aTlF17sgWLyxok1JWmc63QmiamLvSFzg3x02xZuD/HTihlKxArG9eQF7WAILUowspyqEKPoC/ClDbo9UgWoqsowOp1fxSHOuL+KDKUuYgPhJeTjxGYrq4G/9Oao7NhjiTtedU0vU9gVdgc2LXbd11hvztYSRFqzkAJxIkEbWggo/H4k0uZGqkFil2nq/f0aturKKy/wDhZA4oo78qCgkzFDsiHPsRvbgvPRm6obqw6DcFjjjEm1dCfaHDwTC0fiW0ii6n5SGg2UmYnmK7eHjD9CECLvzQBb4H5gfwLLAiEmJAasp1IgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCsiO/P9YNCdpXt/oVwKIPFLabq6faCTiZnJVuNORlg=;
 b=CXfculozUZfjOpykNeNbDNgdtCpkfMc9338ZHS5DMsT9I2PIWWLCYlpgloqS1VP1ldKJSDwzblVevVKZoFcdvfDT048ugoz5FfRS85F0pRZyEVYYed+5ggLllSEUYGgKub/b8thvvUTcYZbNvB4byq9GjMxMyS2xGNoBALShVCqavil38tzDn4ca9d/ScPR32vtw6GlYVaX4ZK9qvy4nwqUr3iISJa1B9aZBQ0KkoadPar4BfDlWaLTN/POZlwNZljk5ugbIXSjWI8sBYspMEYbqOikyK7vY99zoHko17MV/ZdW78GrJsSnjAYaYFHUXBkgXeSMkkAVq7UUeGqaBVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCsiO/P9YNCdpXt/oVwKIPFLabq6faCTiZnJVuNORlg=;
 b=VnzioJz1TPcc0cvU+iCk84e9ZQmqOZaoqyphtgBrskP4JTsZ80m1rZGanWVIxeSTgPWcjPBcIV+8EaxF+dVspWsCYZ9KHp3+6sAS+hU279VwXHStQg6/YetaPjUBZgNd3svO48mbBCNNkQwYwV+ndzRFSSEyYzRtYktASodB6Y0=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN6PR11MB1651.namprd11.prod.outlook.com (2603:10b6:405:e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 27 Jul
 2022 07:54:53 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 07:54:53 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <arnd@arndb.de>,
        <olof@lixom.net>, <arm@kernel.org>, <soc@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <nsaenz@kernel.org>, <Conor.Dooley@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] dt-bindings: soc: microchip: use absolute path to
 other schema
Thread-Topic: [PATCH 4/4] dt-bindings: soc: microchip: use absolute path to
 other schema
Thread-Index: AQHYoY4nJ49D3mePY0ivhhZy3B/hhg==
Date:   Wed, 27 Jul 2022 07:54:53 +0000
Message-ID: <900e14f2-7b26-f500-78da-d47b67022b1c@microchip.com>
References: <20220726115841.101249-1-krzysztof.kozlowski@linaro.org>
 <20220726115841.101249-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726115841.101249-4-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18f8fdee-ac4a-4de0-7610-08da6fa54a41
x-ms-traffictypediagnostic: BN6PR11MB1651:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PtMOS6lGrwSXaknRfczzLAKgBwo7MJFb/iUcktB0XicR8FFpApCENX4Z4lk0dNmFN8gP+Rkbt0XA0/a9lbR1eZYLRggkYH6bDSlSTeJFCRTZq7SSNhZBPMcPj8IZn5gQunDmH8QOnDGJ/EOlWU/AMEt99ghusPmDUgKuHpMoRJfAXfdwdfNSH1PCN/CEyjRbHqP9RW1/6AUhdtgiCVhH4PDQ0sNu9M9/KevaiyG7/O/iVHM7lX+zO6m3dSyU5RU84/DojqXiYZZXeDjgbfQYce6/s8unVPMbU+kSuJ0ShDIBBsHJdqAlPUFBWwfKCZME6MLqf2Hu7wx3CaZvwBL3GwdJYP5ozExATOkbUsgByv+ZOl3M3kGYNJ7ui2JNdF7vpV5t+wwv+TUJk+AdqFucVIkRR/rpRZfOCDUrPkm1YTgVWMxyRMZHO3nmN+kG/SG0QZoDfsWpC1KIb8dul07tx2MK3JRLVd6DNhqnRNmLgHQsCsf24HIZ5LQkVZTZb4SVVQ6LEvn1UUxLJQwGG0KxEGXe5+ES9WKf/seu9OMug6oLEX0pkcVC02wEOADqZtvLc1rFMyTQup01lldaSxEO6d4++gjpVWuhLuw7ACZRIzv3biUTlIpgNIj7NssJjyo1Fw7dO5JiLH72tXq1v5waWKVkw+X09VVN/jClFBIdgnl/m7aBOhOzIAsTIIvO5lmpz1H4a3dIc7xSlTB7tHs8YVqpTQk7JbIoooeEeKjqDhTMwluuZUfros/206NJYv2LNdkiByq2U2dDhsUfJJStvQeD64QrrIEELZiVmPkBvaZEFpsgvml8K8TVWfZysdGcNSKICj7BKPtlH5Bae+XV7+QZ0Dvxbz0x58njtwNB8xmhEucBW4nezIgwO+pG0ZCIi7oKnRdxTGzyoSzFXFqoWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(396003)(366004)(136003)(38070700005)(66446008)(66946007)(66476007)(76116006)(71200400001)(921005)(53546011)(186003)(66556008)(41300700001)(7416002)(2906002)(5660300002)(8676002)(64756008)(6486002)(8936002)(478600001)(83380400001)(122000001)(31686004)(2616005)(110136005)(316002)(36756003)(6512007)(86362001)(38100700002)(26005)(91956017)(31696002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0crY2s4dHFSUjIrSllNbWNkVFB0SFlsb2ZNWmNUU01vYXpwdlJWMmFVL3pt?=
 =?utf-8?B?MWFkdGkvUzNpWGlhT2xEY1hYVlpJSjRTZWJEc3NCbitqV1dZUVRJN3FrTGFT?=
 =?utf-8?B?OURzY2Q4UWZ6U1VzR3JKUnppb2l2TzRKMDQzaGpvcDZZZHArdVE4WlIyajFr?=
 =?utf-8?B?YlY3MWVGMklkZWxHMzEyMXZWYUorazd4VERRYUc3WkJRRGFzb1VpNFhmS00x?=
 =?utf-8?B?c1h4WVF4am9jUWI1MG5yRG95TmM1Y21obTQ1TU90bjRCWXlJU2tuVnM5V1Fm?=
 =?utf-8?B?VUN6ZTMxY0ZDdFpvWVpZSHhvVkdPZ2R4aG5qd0c0aGNaWW5uQ1NxZUQ3Rnl3?=
 =?utf-8?B?YUtjdHdqQVhLN0NWMEkyR1RuNnJjeTkxeDllQ0M0RmtGVmRweHY0bHRqajN3?=
 =?utf-8?B?NlptajM0UUJkZkRYU1QreHppT0RhSmRlbHhZbkV3WHE3b0paRVlsSkF6WS9C?=
 =?utf-8?B?ejdyWTREazBqMzVZRXlBY3EvR2V0U1hWV2RNNkR4cDh5L0dUekhKWjdGR2pE?=
 =?utf-8?B?alRtUmFkaVNySXdjVDFzWEZHUGZqM0Q5VkNvdDI0L2RGYU1xNFhSUVpzend0?=
 =?utf-8?B?c3k3K0ViMU5xTVB4U085UFNNWHhzcC94YXBPaVhaNTEyVFhGanBRSVVLeU9s?=
 =?utf-8?B?b0Z6Y1l4d0cwaDBRN2lTVXJkbDlIamFwL1VCUVNreHVTMVp1UXJsejFkTkQx?=
 =?utf-8?B?aFFIQisrT3UxVDkzWDhIek14UWNSOTF1MG1MZ1N3RHBEblRGVVNYSFd3YjRJ?=
 =?utf-8?B?c0Y5Wm0rVmNPTmNtMEdMWkVuTGZQbmxyUUx5QysvckF1WGNDSDY2ZGtLV0lB?=
 =?utf-8?B?bkdidWJwdWtYZU1wUGJsM3NvNHRSdUNyYjJVSEs0Vk9SRStYNmRpajM0RWVF?=
 =?utf-8?B?N3Jmc2ZJcUl1ckVkL20vR2xqOFB0VEtBblM3YldCc3FwdlRBVzNVR0xuazRW?=
 =?utf-8?B?NEJaMm03UzBwMmNNeWh3bUx3KzRCU29QL042cUhTV0RsVVNaUkx1cEtLa0x2?=
 =?utf-8?B?WDhZRXhrTXVZUmhWWHpYWk5MNVNRejZIRjNMMlV6ZE1GamhxSHltWktEUVNz?=
 =?utf-8?B?bzZnUHhlZWZKdFRGaDh1SUlNREZWQ3hXTm9jR1p4WWxyQWQ5R3dCS09mRkpU?=
 =?utf-8?B?NTdDMWg2RG1NbThZMVJsSmt4alVFSHZXTVBmM0xjbTM0eXNia1dHdG54SGUv?=
 =?utf-8?B?U0lSWmhpdnJjME1XQWk1S3NxQWEwKzNMRitCYUtlcHdsMG5ZdnZsMGNFUUk0?=
 =?utf-8?B?UThrRFQ5SGU4N2JIK1UwbkVHU3YySzBpTTFOSGh2VEhWM212MmlycWd0MUd0?=
 =?utf-8?B?am1pejFkdndaY0RXTm9sdUNzL1pqT256c3piTlhxdU9WeUNCc3dPc0RRa2Qr?=
 =?utf-8?B?UkhkSXdNd2ZNdUJPa2MvZ05vbG5zUnl1a2w0WHllNU9RbHJYYzltUVkyaTY3?=
 =?utf-8?B?OFFqUzQrTTR4MVh3Wnlkc3JkN0VNaGdIK0RCSXF4SnEwYzJ2NysvcmJKM3Fz?=
 =?utf-8?B?MGtoTnk1WVNpamY0R2d6dDhHTVIyNEMyamhIUlZzdk1YRmtjc2VjZVRBRGR3?=
 =?utf-8?B?ZU9rZ2dXRVJ1dTRmZEM2aS9ycmRhZDFxYmtuRm5zTkxoa2U1aGZtOFFCU240?=
 =?utf-8?B?UnBVOFh2TUJkTjFsNUpSdERaODRtSjh1Wkl2eUovQThybXZ1bE9zb0s3RE84?=
 =?utf-8?B?emltRFJ0VnhoNXFKZnVETXZzT21aTlRLUW5RbE1ucGN0UDBPbEZzejFaTXcx?=
 =?utf-8?B?UElYNWFJR2JNdW1rYmpJNy9CbnFBbmtQNjRVNTlKTnR1L2lDWGttaThka0Fm?=
 =?utf-8?B?VWRHZHBHZzNHYTVEQk5Dd25kaUJRajZqSWlvbVpCRFNqU1hMRkQvdEoxSGI3?=
 =?utf-8?B?Qm5xTldaME90SWZRdExCMGxXNFF3Rk5qdDlWSFBSZEtGUjdUelIreWk0bzdH?=
 =?utf-8?B?ZmdkOXlETjFnVGpHRGVJUXM4dWRqeGF1MjdKMjhYdWZhLy9OTmNrbDVteG14?=
 =?utf-8?B?V0p3TE5KeFpoMVpiUkFJWTU0VENZaHZ0cGdKZkQ0am9SWG1oR0FlajNoTVNl?=
 =?utf-8?B?MGJtcHdMcHgvUTU3Y0hwSDdyQkdudmQ1ZEdWTHRYdSt1anlubThmR0k5VE92?=
 =?utf-8?B?cTZqVE1vcWdVOEVvVjRVWWtjeGJ3Ulp4Q0tQaHZ5WUs5T0RlOVY0akpweVhX?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84B9202E68F3FC4489DEF9AEC6A51CAA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f8fdee-ac4a-4de0-7610-08da6fa54a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 07:54:53.2281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wx3DugKn5HijdaKQs8a2RJGTUUa2k/ntR5ywr5/f7AeilfQ5Wz+dMO2hOM3s+FTwAbrsRAMV6aeIjEowkFPlNrvgq7is8eimw4fxCxjzgDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1651
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMDcuMjAyMiAxNDo1OCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBYnNvbHV0ZSBwYXRoIHRvIG90aGVy
IERUIHNjaGVtYSBpcyBwcmVmZXJyZWQgb3ZlciByZWxhdGl2ZSBvbmUuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5v
cmc+DQoNCkFwcGxpZWQgdG8gYXQ5MS1kdCwgdGhhbmtzIQ0KDQo+IC0tLQ0KPiAgLi4uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc29jL21pY3JvY2hpcC9hdG1lbCxhdDkxcm05MjAwLXRjYi55YW1sIHwg
MiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9t
aWNyb2NoaXAvYXRtZWwsYXQ5MXJtOTIwMC10Y2IueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb2MvbWljcm9jaGlwL2F0bWVsLGF0OTFybTkyMDAtdGNiLnlhbWwNCj4g
aW5kZXggMmY4Y2Y2MTkxODEyLi4zMzc0OGEwNjE4OTggMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWljcm9jaGlwL2F0bWVsLGF0OTFybTkyMDAt
dGNiLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9t
aWNyb2NoaXAvYXRtZWwsYXQ5MXJtOTIwMC10Y2IueWFtbA0KPiBAQCAtNzUsNyArNzUsNyBAQCBw
YXR0ZXJuUHJvcGVydGllczoNCj4gDQo+ICAgICJecHdtQFswLTJdJCI6DQo+ICAgICAgZGVzY3Jp
cHRpb246IFRoZSB0aW1lciBibG9jayBjaGFubmVscyB0aGF0IGFyZSB1c2VkIGFzIFBXTXMuDQo+
IC0gICAgJHJlZjogLi4vLi4vcHdtL3B3bS55YW1sIw0KPiArICAgICRyZWY6IC9zY2hlbWFzL3B3
bS9wd20ueWFtbCMNCj4gICAgICB0eXBlOiBvYmplY3QNCj4gICAgICBwcm9wZXJ0aWVzOg0KPiAg
ICAgICAgY29tcGF0aWJsZToNCj4gLS0NCj4gMi4zNC4xDQo+IA0KDQo=
