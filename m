Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715335115CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiD0LFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiD0LEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:04:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8367156F9B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651056704; x=1682592704;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AHd4hzZ3nfWReKhfHQW0ei0Fsm2Zjcd2cNtU5wKIfhg=;
  b=f0hfSf9p1WsKu4M/BbRYlYQurGybQqOBxPqJZRCm4Aa7R0hKG8sH1oM+
   u/wjnMB+FeiY17VVy12UsLU2BSFI6TiKNBM1H0HwDYYpNBnI0zWo1bVll
   W93OgbmjdCkkaij3XXccIZg4wlxzLrvQRaqFvTO3B8ZSnpjc1wIA7gsHp
   NJU1CBo4Klh50AbBLapimEtOgijJRH8qYDkcCj5nuYt7aVCGEb3VazpeU
   GWKsOk4Ipw3Wc9nl3D2/L6zM7fFjT/Vq9C2g86e1y6CZ/mrSIh2XM8R64
   OiDUDCC331uFXr1H3Vcq3YJ+lQylB9WhwioNga6cfNReyrRnhYxeIItV7
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643698800"; 
   d="scan'208";a="153991522"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Apr 2022 03:51:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 27 Apr 2022 03:51:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 27 Apr 2022 03:51:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTaFTlF1VZOR4UAA+hFzjeDsFs46Ohb3jIGRdz6HnFq1kzQLiSiASzspVZXXcq6wS6WT83dFEDT6x2v3QsJejcWzJ593stYlT2a3uSTV7zgOXtqRLdeWRz6UHQliZ/BqcNp9k/itpvlAeFOau7k6tKrCWsiEmkA4TKuVX3dofnm9Q6wdaZo/36TH+qL9EyHYV+HmntOfpmHl5McJvrDaGk6GtTKCzyhJmdNRZVOaNnrW/3dw40R0stW9Z0SjsoNDcvTzhj7Jx8BQoQFUiTJxPyha2gdqS3/ZXrbrSNLZycLiPrKvRLH2vwQRuPuI5jOlH3ETjU7jq0fW491NLJSQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHd4hzZ3nfWReKhfHQW0ei0Fsm2Zjcd2cNtU5wKIfhg=;
 b=VUeOFs4SLYo+FymknD30MOqJajqmrtYZfw1VRySi7zha8F7S3A/+SIjHJ/M0FaodiThaj/JCGYHrnUIPD/iSGoRgcxoFAM6hSZUtJas6Rej90qQILJYG52O7PGOR6pEu/QFL62ArkeD1N+riad/2+eJ5/pedRZgobK/S/NsGrQyVE0qyMKLVQpp12lDDMoeuakZqx8mUJoyGwQjrorV/LrmpdBT5tkYHLtgE8QrY7Hmjz3s1v1g37BrCRbuNB14wXDhfg1aq+wzsLL+P+S7prjaW13i2tDdWidfrxnnysZnZNMy1e0VPus4U79Ne8C7Bv+PkKNxwIWT4CYPBMUhxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHd4hzZ3nfWReKhfHQW0ei0Fsm2Zjcd2cNtU5wKIfhg=;
 b=ZwiirYd1osl8ZwVrugTvCdEujhTrYTinxW7yQX1lFgBYCiIj338XykE6XE9yV9BnFS6GSEVJZIKedBPIaXZuixln22U50t03MbYllAX9Z4ejcawpXkaFRpSQKlAr9wioTWrw7Sn49VElix7whDZk8a/kZsG65A/AzCoyCyrTTSM=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BY5PR11MB4403.namprd11.prod.outlook.com (2603:10b6:a03:1ba::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 10:51:31 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::2447:4025:79e6:7c08]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::2447:4025:79e6:7c08%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 10:51:31 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <chentsung@chromium.org>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [RESEND PATCH] mtd: spi-nor: core: Check written SR value in
 spi_nor_write_16bit_sr_and_check()
Thread-Topic: [RESEND PATCH] mtd: spi-nor: core: Check written SR value in
 spi_nor_write_16bit_sr_and_check()
Thread-Index: AQHYWgX8ewfNtQDrSE2YBtaW8mA4Jg==
Date:   Wed, 27 Apr 2022 10:51:30 +0000
Message-ID: <89d43450-b702-8f9b-f4e0-6f28a1cc03c9@microchip.com>
References: <20220126073227.3401275-1-chentsung@chromium.org>
 <20220131171929.uk3z5sr453c3eefp@ti.com>
 <0e02112a-317c-e95b-e0d3-7ed2c74c3509@microchip.com>
 <c6b2956d-85f6-19c3-4282-23a72a1b5849@microchip.com>
 <20220427085925.wlmsnr7qgi5wteod@ti.com>
In-Reply-To: <20220427085925.wlmsnr7qgi5wteod@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4df55f37-4033-4ed9-1d54-08da283be372
x-ms-traffictypediagnostic: BY5PR11MB4403:EE_
x-microsoft-antispam-prvs: <BY5PR11MB4403F42E9538D80DEF585230F0FA9@BY5PR11MB4403.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7WwFA6MYdgmGSYqsXrD/0UqHDbGHKZeHMnbuvxR74kVVNwJz59k3YvD3ZuQ85TBRONyPw9K+77pXb9i40Es8gYfa12dQMLKB856Z4gb3h2TiLoRECnwf1+Xv4RnYljaOl7v0jST5UKa2cOeeQ0UTgGoOMbk9cPuZWsNLzZp484Xk56nCQa4jCH+dwgRjHSK34BFr+88VzY0xz9vzdD5nDTouvatthA7cB7pSyKeH7jmXDJN3YfSLOQBNFl9ENYf/oOGwwwbL3fWUVMMoDAbaNroC/eKss4Elrc/xMArfUOIr4Vthv4RZbAckLF79u9h2H58cfsrWeOJuIZDpts3tZ+i5UKlv4CzHyYiiKYlYnRwMdW1OeVeHoq9UjXkarTvUbUg40eatZlVAjeG+BdW5B8xx6reACmdh44RlfOED096C4azcexVMr0OVLk7k72VZeKmMNmJ39YNQaLw5xG1wBbxXw+7xW902Pr+o0XZwvqXVgTFp7D6WMhsPE2CnrXSzycmKyqeo61sVL+x+4D7DvgsKXclFpIb8Hh9xxBJaRWdikXtnraW5jJ2CFZC7HSk0MIDzT5z6P8hivoxVO7g+FBzJovCIkI2mp9oDkS3KJfGCBGuPipFI95GUZvhmI3+DNqniGYfeHnMKfIKMtKm+q0M991NJzcJHaEYckKBZKGHxrOrAJs32zZMbGkdIVsffgDhy7mQhxuwLayl8PHi7eiSdafoZbWIVIg7esILJXYlWGgS8YlnCUxvW+E+0eYCtwQDX6hzbGwfeT0n78wLZSGJzPKNOIZ92mya9RH/b65eWZGObUmAKSFc1lZ8bhcVH6fxGjHqVd7rvbKP5tYau+Wg6YAyh0htlKapkRZ8ME5o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(91956017)(966005)(76116006)(8936002)(5660300002)(31696002)(122000001)(64756008)(66476007)(66556008)(66446008)(4326008)(66946007)(6486002)(86362001)(316002)(2906002)(8676002)(508600001)(36756003)(71200400001)(2616005)(53546011)(31686004)(83380400001)(38070700005)(38100700002)(186003)(54906003)(6916009)(6506007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDlFWDVxeXhib0F0UnJoWk93M0hjOVJNMEpJNXQ2Zy9rakowR0hudkQrSXVZ?=
 =?utf-8?B?czFFY05jOGFYaFJZbkRVMGpJbXo2bWFmdFRmdVZqTW1GV0I5MGVsdDdYbE5x?=
 =?utf-8?B?YlpLS0FONXRyQmF2aHU4VFFZRHdiLy9hKzBQQWJpRnpyaDBlNXNjQ3RPOFVy?=
 =?utf-8?B?TWllVXZDYkRPRnpBQ0NsZUxjdXVXcjJpTXNNd0dkS2VZRFVOa09ZWnZ2c0Ju?=
 =?utf-8?B?YndUODRMaHhYZG5Xd05aYjNSRnY3VHpjeDVPSVROMFF0Yll1NjFFRTJtRkdr?=
 =?utf-8?B?cVVxYndwYzJBK250aWVkRFp2dXEwUWgzYnpOTURRK1NHRW9WbThEbHNGWkF3?=
 =?utf-8?B?K0lNVFZJcTRiNEpCZWRUcE9qRkFxVWYyU3dtcmVCc2lDMHUwUHF2VUEvYXpu?=
 =?utf-8?B?cDRXQk8xRnhJRTMzYVg0YWNiK2Ftc3BMZWFsd3R1TFFFdXRSZkJUNGptSHIz?=
 =?utf-8?B?bXlrdHpsODhDaklUb251RjFJMWh6WWs1YmlNVVZMZ2pHdlJVcm95d2Y2cEU1?=
 =?utf-8?B?KzlYU2c5NzRtaVRtQXhaVlpWRTF4aDIxZGtYQ2xQUGsybHFPNXhiaEN5TUU2?=
 =?utf-8?B?VU9vOGZWaFJxTU9vNjdjUitieUpsVjBnQXl5aVJsL2VEbU5mUzlhSWkwcTBX?=
 =?utf-8?B?c3Bac3ovdytNR2NkNjNQUUh6S0lCWFIvOGhqVVRIKzdVNTRjeTVrZXZMeCt4?=
 =?utf-8?B?NUIxWFNYS3ZybDZ6a3RjR2Vrd3Mxd2JDNmlkdHNuK21kZElZcnM5blJPOU5G?=
 =?utf-8?B?dS81cDF3QlFZd1FyVGdZVkdMUW1Fa0JyVkpmV0QwcTBMTVZPTS81QXRCTUdL?=
 =?utf-8?B?YWY4YmFpY1U3RlRGc1RBUW5lYjJoYVUyMDBGczh6Y215R3NST21XYTVPaWh4?=
 =?utf-8?B?d2ozSzc0VmxPdWhpU0JqSHJLNkNWek5TMVdVQnljNEQ4U3VZbmdnbXRiS09q?=
 =?utf-8?B?YmtWanRWTEUyT2lvNmVjbjdUbWpaOGxEeW41OUtmZXZLWExqM0ZlUGgzcHRI?=
 =?utf-8?B?dVJ3YmNZT044WHk5Wis1WkJnSUk0aU8vOHliUDJKQ25JZUJwT1dkd1A2Vzdr?=
 =?utf-8?B?eDl3cjJHNDlHRHUxcC93ak5DdXl1aHVpM21NczM0NEtrQmxyWmo1SjBGcUti?=
 =?utf-8?B?M3g4Yi9FT3B6WDZnTUVHZVZnQzUzUXBDSmZxNmFTVEd4Q0h4Qm9qMG9mYUFj?=
 =?utf-8?B?UEhzVlFGUWFvQXBRUnlnV1V3U280Y2lIcjNXQThRK2FTVFBLVHpjcXlSdWZV?=
 =?utf-8?B?RnhuZjBrVHlSbEU2MkZRMHpjdjBGRDRsOG8rblI2T0VVVmVKWGd0ZFJnQy9i?=
 =?utf-8?B?MHlyTzJuZUhKMGxNWDlKdWp5aDVwTEk0SHYzdEQxY1ZtSzRPMnRPN011Zi80?=
 =?utf-8?B?MHlyOUlScEJ5Zi9xOTdTQVUxcFFFbjVHUkoyZDhuRFdqT3FYQytuNjUyT3Jh?=
 =?utf-8?B?TTNKWndkdUF5bWZVNVRrZzdTYXJMZkdHazBsVEdNUWdGS0R1bW9qV3BMcllX?=
 =?utf-8?B?bW85dVM3Qlk3NWtsWlhPcklncjBQL0VtZHh4djhPT0FBbFJKSUovazEyaGdP?=
 =?utf-8?B?cW5RQnozb1NMUnlUcTJpUllkeGtYQTllVXBZMnNDTUxqSk1qWDNkcVhIUEpF?=
 =?utf-8?B?TDhDRmJaOGwvR0RhQWRscXR2anJuOGRqeUc3cWdaTHhDcjVHYUxtN0R4L2gr?=
 =?utf-8?B?L2VlRDlESlhZcTJFRHZDUlNlbTJBZnJQRVpCdjdSaTBFMXlydEw1cCttMmps?=
 =?utf-8?B?eTNoU1JyVkhSem5lQU5hTUlZQlNtMmxRMDlRY0JpT3ZOQ09NMHVSQ2JhaklN?=
 =?utf-8?B?SnBUbFZKQ0lrZUdpMlNOM2VXczl4cnN5UkZ3TkZBRVhTUktlSFpaSFRiTlE4?=
 =?utf-8?B?UWRrM0kwcFZCdVRldlJ4UnMzdkEyeWxLT21RVlM1d3lOeWRTd3pqNHk1QzdY?=
 =?utf-8?B?eVdYNGR5dXlIUHRoM0xoTlJkVjJLQjdQVFJyMENjdFprTkRLYXYzWFV5VVBh?=
 =?utf-8?B?ZlJjeHJDSVUwNmxIRnp2bEJNd2poWi83blI0NWtqWmlYejJraUk1bGJSZ1NG?=
 =?utf-8?B?RDZ1TGZHR2Q1SDRzVzhEOFJieEsrM0YxSThYZHJPSmw3ZlBLdjVDTEtZKys0?=
 =?utf-8?B?RklNTWk4c3M5Sk9iemkrTjJPaFd4d1F3TUltVitxeFhPdG9ZcllmeHlDdDhS?=
 =?utf-8?B?b0F5Wmx2VXhTSjRIVXY1Tk1tYlpFSXk3NjNOM0JERWxTY1M2bkdOeEpFVGg2?=
 =?utf-8?B?RXJIdlUyU3JhMy9IdU80RGhPeFptTUdycWtNYTZxVWo2RXZocXl2Y2RLcXNE?=
 =?utf-8?B?clV1elFucm45bHB4SDFzUjl1REVKdTQrQ2crblV4RUJkL0VablpaeWN6aUd1?=
 =?utf-8?Q?bL9fuGrXJlWgVNLg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <394F9607FC7E0E40A22BEE9513A18BDA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df55f37-4033-4ed9-1d54-08da283be372
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 10:51:31.0278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FE1oqBf8tJBzchiHQEPdu1oEF/XyveLfFBIAz4Qs+u5CVgpxKfcguaORZH9aGlja5cW5Q/WBEey0NapFUsbjqEomUwsqN95cwCvkpxVWAoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4403
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yNy8yMiAxMTo1OSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjcvMDQvMjIgMDc6MTRBTSwgVHVkb3IuQW1i
YXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gNC8yNy8yMiAxMDoxMSwgVHVkb3IgQW1i
YXJ1cyB3cm90ZToNCj4+PiBPbiAxLzMxLzIyIDE5OjE5LCBQcmF0eXVzaCBZYWRhdiB3cm90ZToN
Cj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4+DQo+Pj4+IE9uIDI2
LzAxLzIyIDAzOjMyUE0sIENoZW4tVHN1bmcgSHNpZWggd3JvdGU6DQo+Pj4+PiBSZWFkIGJhY2sg
U3RhdHVzIFJlZ2lzdGVyIDEgdG8gZW5zdXJlIHRoYXQgdGhlIHdyaXR0ZW4gYnl0ZSBtYXRjaCB0
aGUNCj4+Pj4+IHJlY2VpdmVkIHZhbHVlIGFuZCByZXR1cm4gLUVJTyBpZiByZWFkIGJhY2sgdGVz
dCBmYWlsZWQuDQo+Pj4+Pg0KPj4+Pj4gV2l0aG91dCB0aGlzIHBhdGNoLCBzcGlfbm9yX3dyaXRl
XzE2Yml0X3NyX2FuZF9jaGVjaygpIG9ubHkgY2hlY2sgdGhlDQo+Pj4+PiBzZWNvbmQgaGFsZiBv
ZiB0aGUgMTZiaXQuIEl0IGNhdXNlcyBlcnJvcnMgbGlrZSBzcGlfbm9yX3NyX3VubG9jaygpDQo+
Pj4+PiByZXR1cm4gc3VjY2VzcyBpbmNvcnJlY3RseSB3aGVuIHNwaV9ub3Jfd3JpdGVfMTZiaXRf
c3JfYW5kX2NoZWNrKCkNCj4+Pj4+IGRvZXNuJ3Qgd3JpdGUgU1Igc3VjY2Vzc2Z1bGx5Lg0KPj4+
Pj4NCj4+DQo+PiBjYyB0byBzdGFibGUgcGxlYXNlDQo+IA0KPiBTaW5jZSB0aGlzIGhhcyB0aGUg
Rml4ZXMgdGFnLCBvbmNlIHRoZSBwYXRjaCBoaXRzIHRoZSBNVEQgdHJlZSBzdGFibGUNCj4gc2hv
dWxkIHBpY2sgaXQgdXAgcmlnaHQ/DQoNCnllcywgYnV0IGluZGlyZWN0bHkuIFRoZSByZWNvbW1l
bmRlZCB3YXkgdG8gc3VibWl0IHRvIHN0YWJsZSBpcyB0byBjYyBzdGFibGUuDQpTZWU6IGh0dHBz
Oi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3Mvc3RhYmxlLWtlcm5lbC1y
dWxlcy5odG1sDQoNCj4gDQo+Pg0KPj4+Pj4gRml4ZXM6IDM5ZDFlMzM0MGM3MyAoIm10ZDogc3Bp
LW5vcjogRml4IGNsZWFyaW5nIG9mIFFFIGJpdCBvbiBsb2NrKCkvdW5sb2NrKCkiKQ0KPj4+Pj4g
U2lnbmVkLW9mZi1ieTogQ2hlbi1Uc3VuZyBIc2llaCA8Y2hlbnRzdW5nQGNocm9taXVtLm9yZz4N
Cj4+Pj4NCj4+Pj4gSSBkb24ndCBrbm93IG11Y2ggYWJvdXQgdGhpcyBiaXQgb2YgY29kZSBidXQg
dGhpcyBwYXRjaCBsb29rcyBmaW5lIHRvIG1lDQo+Pj4+IGZyb20gdGhlIHN1cmZhY2UuIFdvdWxk
IGJlIG5pY2UgdG8gaGVhciBmcm9tIFR1ZG9yIGFib3V0IHRoaXMgdG9vIHNpbmNlDQo+Pj4+IGhl
IGFkZGVkIHRoZSBmdW5jdGlvbi4NCj4+Pg0KPj4+IFJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVz
IDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pj4+DQo+Pj4+IEFja2VkLWJ5OiBQcmF0
eXVzaCBZYWRhdiA8cC55YWRhdkB0aS5jb20+DQo+Pg0KPiANCj4gLS0NCj4gUmVnYXJkcywNCj4g
UHJhdHl1c2ggWWFkYXYNCj4gVGV4YXMgSW5zdHJ1bWVudHMgSW5jLg0KDQo=
