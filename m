Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2C64FB5F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343793AbiDKIaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343784AbiDKIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:30:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402B23E0D9;
        Mon, 11 Apr 2022 01:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649665685; x=1681201685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l2J+r6T5LofvPQXQ0hxm17NxNkBU0d1Wq5+WFzMw6QE=;
  b=C0WVbV4XKc+auT9JZLYZPWN44Duk9kiPN/67Ji9riCcYgoz+eKBNBkA0
   bBOUdxe1ZNzbfbk8waJaskJkgR/szxlfWIfL3ak/7Ewi45zTJuHMqJPoE
   zoF5/65DcTKu2NSwoGaZUK3RWGp+HF6IqCiKDfogqFX9gTnYswIf6QJtl
   +LkZraLW69b1HWwo3xV2D1YO6z4gPQsdZA65fiROb7fSdIjG2cA7armPn
   rg7hBFM5SK/+qJbgmaJ7UW3zCNnYzXxTA4HPEu0KC+pUnNsFUzfO5TFKU
   jyGNuZNkZm6NITunm76sJbFbPyC3/3h6MX7Lo/aB7CJNDq8YMGzNTyim9
   g==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643698800"; 
   d="scan'208";a="155109283"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2022 01:28:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Apr 2022 01:28:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 11 Apr 2022 01:28:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ubgh0O5OMlxDjgkaSmHqIFPcM64QGL4ETta48adrFSS+2fHddOwrZqWEzMxwjTLifCtSbkuzUgU/EnvRSfPkj6XSoynOKE074BZot99bFN0nEXWUHfc0xtRqd30fxoF6E4EqYeFAb15m0a0omFlK8PV/ouDP/EAbsMFkusFt9DLMF98G/hRCZYiKeepKG9yKoylLzT0ER3tYyqypa6pL0RglXzFDc0t4zY7bXvK3ics3uyCbD8I7kJOFKJVvauEbaahF71tqa50+CHtZ5mtPrzzUhYN94pcO/NWLwadEgKCdGdsOHh5gQczyBzkYmV1rCOcywzaVvUfU5xYZaqdWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2J+r6T5LofvPQXQ0hxm17NxNkBU0d1Wq5+WFzMw6QE=;
 b=RkmDCoJ6nrZOLm+XvfCE0Jm9l1BhPV3rYfn96kfAwMA5P8AtLcDPPe5r3qnZOwGv8dCPx0h55+EdfdWj2BE/CcXvi/Q8RbkBVHAPSRN04+0jpKcz6UMNma5jZUOhyccWV+ZhD6HR/66s8uKmjMuqpp2JQZapBgAvEAFG1EoSi20txAdf4QsHxvUrSiGtEdSuSKsv7/yrGQ/y9nJ9KyQ7WJvc3e/BlNmfLfTlsOP0GPfZmPWAJFscaPqu9MGGh39Hys3/rZxEqn7ZYhslt8VHlhQNRJ4C66E1jnyPRjT7xnC3kdTt1NzNYEnk+wTj2Suu0H9v/PurpI4c2uPIzhF+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2J+r6T5LofvPQXQ0hxm17NxNkBU0d1Wq5+WFzMw6QE=;
 b=Oe8J36rqpQ427wb/DIzgPyO2euWXihXMiLVRj1DCrCn6t6shSc/nCJBBDcPrngg9S1WS4TiwSiAfwR9FXHI6C1BgRYCLQrWK2rM4GSu2S873gALWiVHZ69DUWZIIbhRHi5EIsWS9yYKGswvcN3tSU+MH3rwNWRN9rvqv/TEVEo8=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by MN2PR11MB4046.namprd11.prod.outlook.com (2603:10b6:208:13b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 08:27:55 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%7]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 08:27:55 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <LinoSanfilippo@gmx.de>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <u.kleine-koenig@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <alexandre.belloni@bootlin.com>, <mcoquelin.stm32@gmail.com>,
        <richard.genoud@gmail.com>, <festevam@gmail.com>,
        <s.hauer@pengutronix.de>, <linux@armlinux.org.uk>,
        <alexandre.torgue@foss.st.com>, <Ludovic.Desroches@microchip.com>,
        <lukas@wunner.de>, <linux-imx@nxp.com>, <kernel@pengutronix.de>,
        <linux-serial@vger.kernel.org>, <shawnguo@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <p.rosenberger@kunbus.com>
Subject: Re: [PATCH v4 RESEND 9/9] serial: atmel: remove redundant assignment
 in rs485_config
Thread-Topic: [PATCH v4 RESEND 9/9] serial: atmel: remove redundant assignment
 in rs485_config
Thread-Index: AQHYTX4Ke9QhM15hcEOlcJKfAl+VfQ==
Date:   Mon, 11 Apr 2022 08:27:55 +0000
Message-ID: <4d301703-bca1-8bda-c66a-ae53890ddac9@microchip.com>
References: <20220410104642.32195-1-LinoSanfilippo@gmx.de>
 <20220410104642.32195-10-LinoSanfilippo@gmx.de>
In-Reply-To: <20220410104642.32195-10-LinoSanfilippo@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1205c76-2144-4b13-af49-08da1b952d8c
x-ms-traffictypediagnostic: MN2PR11MB4046:EE_
x-microsoft-antispam-prvs: <MN2PR11MB4046731773779E602BD812DD87EA9@MN2PR11MB4046.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cQ5kawPsIZpN9diGqEf1CNj7yZ2LsHXgsncMD/8aZ9DTjUlSmkR0aPA2/3wWCIkGYehlRy2JzreTYcXGtF0mSY07YwWv1FCSOGG1oI4T85dI3dgZDeT4w7M34Gy0ip2lP0oQ5Q1xzFATNh6Vlfxu0+DC5uWbjRPNQqTezHHaVgHzt/HEt5nYPJZddOSA8WVxyp6CoNxNDxdZDSEdr+/m7DrsMHNCQ7KfMINHvv3GkIjkc7M9lbpXb5qHuIDxgZoveiuIDYoyRwtUBvptGU1+kYNUO2shUHmKyZdX3iFysqd76cI7gV7V85ruIOXpRolug6y6sl6Yyf98dFFVFK6gxDNouRO9oULYLRTuxUYnxuR52sAe+8zMxplo88mzFyuFLmC9EfR8zjqwVYE31B4ZMMdPO/USYVlXHYNVX6PwrxLPvZ77dxjQXZhqYAJLofsdwvjMs7WldsHu1qqaSQglOr97xJVZ3neBi70sMDylgoUFbp8TdYtLTCu5ZDYs3VR8t2sVZ7Zo+uulswz3ZR4/082l9SjbJcgPcYqtiNx9SKtfMSns4+P6KKQQkxI/EGvscB0pDDwGM+x+5NaiJPtJWGODOj9Fmijs/0AmCmUvzk+dgBXecEUEgc0Qo/87YVonWGeRUUFzm6eXu5idDQgkMnigZ09oJSGhVXPEhulN3/9nZdt2CdlVP/uyM+h7C6RBbbVqmFL+9kOoY9s8pt/+/DsPRDSdoHZ4hkgdhb6PW7V83z/OKXEZ6Myb9GVBmcAPJF261EjicNgKM1U5Vu8eiRnqLdgjXavuaAGGZExKyjbP9eVHFpg6AdsRMW7YmcUDUWx3FrJZZf/O+a6u3DAQigMGmk+R5E6yviOF5vPf9FE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(71200400001)(7416002)(8676002)(966005)(5660300002)(6486002)(54906003)(110136005)(64756008)(66476007)(66556008)(508600001)(2906002)(4326008)(66446008)(66946007)(91956017)(76116006)(316002)(122000001)(38100700002)(2616005)(83380400001)(186003)(31696002)(86362001)(31686004)(26005)(53546011)(6512007)(6506007)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUVBd2xXQ1NiREdJem9hR2dTN1JZOXlmVFNGd0RETytKamlxZnkzeVNod0Ji?=
 =?utf-8?B?SlZBL2ZoWWdpbVJ3VUVBRllyL0VTQmZmSEE4UW55bThYS0NtY0IvbEhaZ1lx?=
 =?utf-8?B?Nm9TV2p3WEdoKzVtNVFGamhJWXptUHNUUndIQ2RVSGt0M3VHZzhQOFI2Z1l5?=
 =?utf-8?B?NWozR0ZSeU9GZFFpRUZUSkhENUZMSTNqdlVlWTZ0RVZyOUl5dHJuRVpPWURN?=
 =?utf-8?B?WlZaZEQxS1lPbldxcnRPZEJidEw0UzM1Rm5PWVQ1WUNXL0dDSG55d2pFb2dJ?=
 =?utf-8?B?NWJxTEdlNTM3cmpCOFgvSDlTNktKalFMQTY2Tld6YnMvKzRYSDVIbVBuaVVs?=
 =?utf-8?B?MlR4Y1pUdFlkeVRVK3dmbXJCL0lKcVlpdnh1ZldMSGlOT2pBNWx3aXhEcTg5?=
 =?utf-8?B?Vnc3aUhDbk5CZXUrU1RXSEpHYU0zTzBpYTF0VWZBZnRZZkMxdTFsRERQWkdI?=
 =?utf-8?B?SWgyd0EvZit6cnRIM05VWlU0dXRwclJyYkt1QWlDb0RPeGJrb1kxZGQ3UkZ2?=
 =?utf-8?B?M1pvejk2bHNHbHpNcXRuM0NkcTZhb1M3TDRLTk13eTVRZzBWaE9VZmlBalR0?=
 =?utf-8?B?UCtkQkpZMlZ2S1N2Z1l6QTdaWjhhMmk0UTBHOEhCUHB3RjhIUytSU0JIUU1l?=
 =?utf-8?B?dkQra2dTaGpTWGZsRml4WGN5S29KZ2JMRXVuekhVdmpmQ3ZGVktFUVZ3aWtK?=
 =?utf-8?B?Z0gvcnl1bVQyVUlVSi90SWFpZnYvS3RFTW51YTRzZ0dISFV4U3kvNFZOYWhI?=
 =?utf-8?B?Snp0NnZuNXNsYlRZRjRvR3pXcGpRWmRvMzh1ZlhZT0xOcCsxc0tyLzhhd0RB?=
 =?utf-8?B?enN0bjRYQTQ4QzJMTnB4djdybkt6U0lxQWk0YUlDT09DZ0pkcmZxb1M4ZUFp?=
 =?utf-8?B?bjBJME1ua0U4a3ZlRTJlWHFjc0prV2hlVFc2TzhaenRyZFB1REkyYjBaL0M0?=
 =?utf-8?B?YmhBd3lDSkp2UDQ2YzUrdW85OWRQSUFGMkRWVUFKTXoxWDJiQXU3d2tJcFhX?=
 =?utf-8?B?NTRCMmhiVS9hR2xZSDdEbnhSQ0xYT2RsNnVCK2JkdFI1Y3VncVZPbkdmMEdN?=
 =?utf-8?B?RGRnbllnZXJGZHZUaHlYbUV4Qm8xMU5jeHJ3K0FoVFZ4VDhrZlhCTkt0R3Fw?=
 =?utf-8?B?NDZNVWdaYnpaUmUwejJGOCtVRlN1ZEdXRnlQMFZiWVQ4c29KbVdZYUo5dzhR?=
 =?utf-8?B?N1VLS0xoeWRtZ1hOZXRjVXVydGk3K3hKaVNCYVVaNEN5SkdLNGE0WnIvdWdT?=
 =?utf-8?B?eFJicUt5UGJEZThONWtvakhKd2crLy9PeWdvUDBWM2tEYmxRVG9yZlFhNkN2?=
 =?utf-8?B?bVI0VXhiRTk4ckl5eTlPK0YySzI1L3RYOVI4YXdxbW0xaVV0Mm1oem1mZEhn?=
 =?utf-8?B?Z1B2eWdmOTBudStZQTRUczdsOXd4VXltNjdJRXByOW91YVJCdTEvci93czZT?=
 =?utf-8?B?OFZMcHVGS0FkcURaai9zaFZmWWlSUElHT3F0ZW1jeVRVejd0ekFvaEVrQ1JL?=
 =?utf-8?B?Z0E2eUsvNEdKVUJVN01MWVVEQUVzUlhkNEFtSjAxRHljbVFkbFpEbmNmVWJH?=
 =?utf-8?B?ZThRQk1mY3ZsNEExbSttTFBZVzdNeGV3OGxVb1hsdFN3Mno5T2pXT2FLZ1Zr?=
 =?utf-8?B?RjBHMVVYRXRsTmQrZjdxZXExNWdLMytCUm9ScXhJdEVhWEMvZzIwclJhRUVI?=
 =?utf-8?B?TGJ0blRKbU14dGxNODk0Q0xYM0FZKy9FY3g5UnFnUHVVWlN2Um1ZNm5Za2E2?=
 =?utf-8?B?TklUZzBvM2ZPTWdqTVZPMi9VY2s5em9XTmpGeTZNakpHUTVtSTJIRHpacVZT?=
 =?utf-8?B?OTN3TlduejlMNjFLWWZTZlZvMDZURUdmWHFORVpWektjYnVnZkQra3lhRGlm?=
 =?utf-8?B?anJpR3ZkM3EzU1IrUTczVzBJNktHcExGb0d5S1J5YklVa2orZUFRL3BRUDBp?=
 =?utf-8?B?UHN1RlBhbUZGdnlINS9oeGxLTzJMOG5GZmJUaUZXRTJEaXpValJzVWxBbDF0?=
 =?utf-8?B?SHZidUxJdFJVb1ZhdjRtc0piWTQ4RnZXY1d1Y1JveG92aEhTcDB0c04yWW5y?=
 =?utf-8?B?L3U5YVZlWi8zd3VKbGd3c2dRU3I1QndrWnp0a3pIZ3hYM0VRU1o1MG82UUQx?=
 =?utf-8?B?ODhwTmNoWm9XZTVtUUFrbFRWdWE5V1F1VzBDOHFkME9wSlRIVjQ0L3BLUlB4?=
 =?utf-8?B?VkhLalBTSFZheUhOd080T2F2WjhCeTR5aFo0Vk5aQ1YrLzE1K2dRejg4dFQ0?=
 =?utf-8?B?NmRseTIxMEhQTXJGNW43bTZ2TlFGaEl2SnZWak5qNlIraUpFdzEyZE81QytX?=
 =?utf-8?B?YUc1UDB6QmU1R1ZtaU5tcmFMaklpNWxFczZjT0JLWjBZSVhNc1h2Sjh1T1dL?=
 =?utf-8?Q?F1ZP6jUAn+ZQF59o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50DDB8B73550A94B8D151ACA12372EF8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1205c76-2144-4b13-af49-08da1b952d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 08:27:55.3368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3lBUHw1zBCOG+sXRRZZ3fT5NOgSun2f+NcGaLoKQcMs3TznzMvaP2P8w5KZrd1ZvAeUOZmv4L+y0t+W/FYJhsP6+p3gCYp41a0xbxkxMEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4046
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMDQuMjAyMiAxMzo0NiwgTGlubyBTYW5maWxpcHBvIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEluIHVhcnRfc2V0X3JzNDg1X2NvbmZpZygp
IHRoZSBzZXJpYWwgY29yZSBhbHJlYWR5IGFzc2lnbnMgdGhlIHBhc3NlZA0KPiBzZXJpYWxfcnM0
ODUgc3RydWN0IHRvIHRoZSB1YXJ0IHBvcnQuDQo+IA0KPiBTbyByZW1vdmUgdGhlIGFzc2lnbm1l
bnQgZnJvbSB0aGUgZHJpdmVycyByczQ4NV9jb25maWcoKSBmdW5jdGlvbiB0byBhdm9pZA0KPiBy
ZWR1bmRhbmN5Lg0KPiANCj4gQWNrZWQtYnk6IFJpY2hhcmQgR2Vub3VkIDxyaWNoYXJkLmdlbm91
ZEBnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8TGlub1NhbmZp
bGlwcG9AZ214LmRlPg0KDQpSZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6
bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0KPiAtLS0NCj4gIGRyaXZlcnMvdHR5L3NlcmlhbC9hdG1l
bF9zZXJpYWwuYyB8IDQgKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAz
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1l
bF9zZXJpYWwuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYw0KPiBpbmRleCAz
YTQ1ZTRmYzc5OTMuLmRkMWM3ZTRiZDFjOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90dHkvc2Vy
aWFsL2F0bWVsX3NlcmlhbC5jDQo+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJp
YWwuYw0KPiBAQCAtMjk5LDExICsyOTksOSBAQCBzdGF0aWMgaW50IGF0bWVsX2NvbmZpZ19yczQ4
NShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LA0KPiAgICAgICAgIC8qIFJlc2V0dGluZyBzZXJpYWwg
bW9kZSB0byBSUzIzMiAoMHgwKSAqLw0KPiAgICAgICAgIG1vZGUgJj0gfkFUTUVMX1VTX1VTTU9E
RTsNCj4gDQo+IC0gICAgICAgcG9ydC0+cnM0ODUgPSAqcnM0ODVjb25mOw0KPiAtDQo+ICAgICAg
ICAgaWYgKHJzNDg1Y29uZi0+ZmxhZ3MgJiBTRVJfUlM0ODVfRU5BQkxFRCkgew0KPiAgICAgICAg
ICAgICAgICAgZGV2X2RiZyhwb3J0LT5kZXYsICJTZXR0aW5nIFVBUlQgdG8gUlM0ODVcbiIpOw0K
PiAtICAgICAgICAgICAgICAgaWYgKHBvcnQtPnJzNDg1LmZsYWdzICYgU0VSX1JTNDg1X1JYX0RV
UklOR19UWCkNCj4gKyAgICAgICAgICAgICAgIGlmIChyczQ4NWNvbmYtPmZsYWdzICYgU0VSX1JT
NDg1X1JYX0RVUklOR19UWCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgYXRtZWxfcG9ydC0+
dHhfZG9uZV9tYXNrID0gQVRNRUxfVVNfVFhSRFk7DQo+ICAgICAgICAgICAgICAgICBlbHNlDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIGF0bWVsX3BvcnQtPnR4X2RvbmVfbWFzayA9IEFUTUVM
X1VTX1RYRU1QVFk7DQo+IC0tDQo+IDIuMzUuMQ0KPiANCj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0KDQo=
