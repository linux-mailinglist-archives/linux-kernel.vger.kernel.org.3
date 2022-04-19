Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF446506CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350831AbiDSNCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350662AbiDSNCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:02:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD37EC5B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650373187; x=1681909187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2KYvrQLPGUqIVw1DHN+1sxfJPA2T3M6UGH89HneKGq4=;
  b=VtsAajafK2Uq/Ro17298oI4wF6KAMjpqiiYW/Yj0uRXulEsyB/B/4sKc
   Tv9hmBD7tjtQ0nh51YMyWzaGIOndU4iuaD+5+yXz+IyoDgJHD93N4FxPS
   dPH/C4gDUjHMHOEvgltoFatQMZwhl5K6iXaDF+xadfoyAQHUpoAbpIvQq
   0ca/IKEKlaSUUE2FwsmS3xT92A7P4eNq0mIuHRhybyn8xebJHxTUHHMAg
   kqBGoUxEPn5tUUxV/GXhKueucNc3E5HR3gMJPeg14McTucwFAKvS3VgVe
   rMUvLp+bFV+d3waiUITIPsUhHpIwi4eDEv+UtWbwvfdL4HGktgrpJLnxy
   w==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643698800"; 
   d="scan'208";a="92797307"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Apr 2022 05:59:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Apr 2022 05:59:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 19 Apr 2022 05:59:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLrrcT4O0jRAGdd5sJLjTLx3R8PtvnbX0h+t+EiYjZCxuJ4QgbghAKnFgX4KDieGcxILZMuucpd+xqIQuGvdtJ8qhDK0pmd9aTf3di83AkCWL0u0P3Yuv/ImHSQVQhxOt4oNWcXcNQxLsa563bJTb2AMUraWp6eQEtWQ3vD2fIbmFkHSQBararDC7knqUs+iWMFy9NFqDhOQ5hVu7iCjz2c5c/FlHGWhTr+0BN3YxIHJdKlmo1yEwRij+kgP4XxeNkPGgG10WbWckuNZs97eOCcfzDlZ7BkoD/jbrhMFo0ANqtBw5iKpddHbNybMHmleFyCYT1en6H6P0J/cDoiv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KYvrQLPGUqIVw1DHN+1sxfJPA2T3M6UGH89HneKGq4=;
 b=c5dB902+vIAMf7TcT+n5gjLt9NJSaYtga1sNGzq2aZPrAraAjlQnpqJSN3OIe9A4Y3un64m59Nv7MvhpmJBahUAT9/jyFvifGP7yrL6jwS2ixe7+IPzXq6cenBL/9ErlWvFGtyldxmlXLy2zz/SBdsvf2sT/Cqqc2y8e1tzGGbjRUtnDbxj4KtJaQsJXD19qsD938zLamjFvUsJRZYBxjOC21zLTJy1ZSGX/7y0OlflLC3iqkdSM0kgFqcTXF2z0I/4LgTIffg6EUATfMv2j5ieb9rdIZNvHSZxZewiLHppb40N8S7ktI5iQMbXDFxqvif78L8+MnDwuea/BKVyzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KYvrQLPGUqIVw1DHN+1sxfJPA2T3M6UGH89HneKGq4=;
 b=PYmHjNSBY4S+BALb0Qb/YfuUEl+p63mAFNKwuoGRMdcVPhkmcL8wiH17fZ0EafNiFTs8SKsfqo/CeRCn4HlHg1cDZUgclHQrnZX0mph7YT+p4Rw/SfgESn8CobujcIVy4jTaOXng1v8leMuQsgqO+060ZxiYpcO/BmnhH875YqI=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by CY4PR1101MB2293.namprd11.prod.outlook.com (2603:10b6:910:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 19 Apr
 2022 12:59:40 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00%7]) with mapi id 15.20.5186.013; Tue, 19 Apr 2022
 12:59:40 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v3 6/9] mtd: spi-nor: core: Add helpers to read/write any
 register
Thread-Topic: [PATCH v3 6/9] mtd: spi-nor: core: Add helpers to read/write any
 register
Thread-Index: AQHYU+1UjgcwOSWAuEOiQaxrAfyzHw==
Date:   Tue, 19 Apr 2022 12:59:40 +0000
Message-ID: <69943a92-b44e-8c39-5c1d-dedc6829828e@microchip.com>
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
 <20220411091033.98754-7-tudor.ambarus@microchip.com>
 <0e4ec58c21490dcd9cf82ab89bd8c34c@walle.cc>
In-Reply-To: <0e4ec58c21490dcd9cf82ab89bd8c34c@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc177ded-b7ef-4370-93b5-08da22047791
x-ms-traffictypediagnostic: CY4PR1101MB2293:EE_
x-microsoft-antispam-prvs: <CY4PR1101MB2293E8532F5E34BAE2CE64E1F0F29@CY4PR1101MB2293.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5xdCLLSoR0XhdW0uxAmpBOCr9prlc0g7pCV86htVc6G1xv22RSm/mhJD7UbaOtGuuarNc3wGHX3NP7cJVhlzPyKqL1/+6mzYKUJCCNSefTgsb9qCEjzmYRik0BTrJo7VgPOSuugM+XxZ8v2SatKpkxwKuyFHK7hJvnNubZBLfllAwk+kjPjBPOSh1HnLvuhvsF21HFxa2tMP/QWTH9yh8qXHTMDsu9O8gIvwSzNLR05x4sCXs0Y1hAWRJ8VcqmG2zitE0iNMt7ZyeYV1CcruysrN3tu1KmpATwGsudUiW+LTEb/Nts5AAc+kevKHKsV8RwTxG0ZLW09c8+UIGXMuD8veYrhmpIhNEfWutWBOIel2JCEU5I1BKcNLFkbgUZ9scxLWsJZD99TWaMh2wjgWKcaOC/98IAjiJuRZK6qMLa0jblsUtw8pofDV9+TRU3bFzJRXfTVkcO1YWx2YmrRkvFajWypKE2N3ZUnduAFlkNsx/KRx/2I9X0Jb/OMjn/+Z884Prm1ACyNCMelQRCFm8IbXftZcHl9JaUnXSZITu62QjcWXuK2wkgxYBn1+IEgry8LLhQCz8gNa2SSbrAcCagu8Mi2fGiH25Wzf9wVURju3hVq75PGfm9gFbQLLQ34YE5/RxhWeBKdIXrcwk/8Y/wR8zp6RGH+tJewa2NhG21740YS0cqoN4aM1Mdb5H7e4a/eel7NrwBixhM4YZ73T+8pzQxr/Wg5qXNclY37MHPWFRRMX62cSHxpIrG7Xl1s0Ze3V8dF7Oz0cWYeDDBOUSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(71200400001)(76116006)(508600001)(6916009)(122000001)(54906003)(6486002)(186003)(86362001)(2616005)(31696002)(64756008)(66446008)(66476007)(66556008)(36756003)(66946007)(8676002)(4326008)(2906002)(5660300002)(38070700005)(316002)(38100700002)(6512007)(26005)(31686004)(6506007)(53546011)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnhQNnFNWFRQNWp6NmFiL1k3T0c4Q1BNWE5Jb29tNGtmTFBpYVlNQW5ucFl6?=
 =?utf-8?B?YWw1dEZxbGQ1UmpoT0VtanNGemoxZmZPakNEWXd4cHZrRmlpcHE5VWRMd0Zs?=
 =?utf-8?B?a3pEbDNmQ2p3T1pDQkZ5djd4NTcveVFETzExQVU2bFFZRkRrT3B0OWZQNzZR?=
 =?utf-8?B?anpOelFsbk1meFFScEEra1ozNGE3WnFlWDB2eko0RVdTYVoyTkNsQzBuTW44?=
 =?utf-8?B?YkVPTjZXazdyUDVNbE1SQTZJU1ZvQ3p2OXBHM1ZuTUxTM0FtRWdGZ3J3Z29R?=
 =?utf-8?B?WGhVNktCd1Z5RTgrR0dDUGJrRFprTXd1SmZzNG9jSmNMWmthaC9HVUM3Um5s?=
 =?utf-8?B?MWxZb05VUjk0UFp3RnZPQW04Q0xOVllQNmh3MXVTampmZ0htbGluNW9KaW9W?=
 =?utf-8?B?UmxtYVZ4ajF1ajl6WDQ0WVV4ZFZOelFBK2M4UVo4WmFMRm81MDJUYmNSdjJS?=
 =?utf-8?B?Ni9MOUowN2lxeVh6ZmtzV3MxemtKck42eUJwNWwvbmVtdG1BdTFGcmtoWVpj?=
 =?utf-8?B?OUlTMXJnc3lvV0pWSWp4NmJIdzBWVUxjcCtpNXllS0xKQmZzR05Fak9BYWQ4?=
 =?utf-8?B?NFRNYVNwMk05WWRUSitwNThaNTVDRWQ1eUMwR0NQdTcrdHZ5cnFrc1ZQVHN2?=
 =?utf-8?B?NWQ0UVViazR6UkxBWFZnbFJzQmZFSGx6eUQ3cHJ1Tnl1Q1NicXFUd0N0UmhI?=
 =?utf-8?B?UG1mNnVhdk1BeVJOdUhWdEN1ZXFrdGM0QnJFY3NRKzRSd1pxWVptL0VrZFhH?=
 =?utf-8?B?SENFd3g3a2lPZmNlMnQ2N08vbWlyeU5UQTVDYVoralhmVXJ2MURtMzVWbjNL?=
 =?utf-8?B?ZUI1OGpXeC96S3h0WU0vV281QVpaS0xwN2s4QTc5ZWVwaG82YUhNQ1BETWtL?=
 =?utf-8?B?dGhNeURMZ0k3RW9vOWFRVEp6YkpmMldoNHVsZUlVTmxKZEZkeUFPdVpIazdZ?=
 =?utf-8?B?bzVTQWZ5ZDZxZjZUQ2JEa29qYnZQMDZKNzB2bnZ5NVdsaDJsOHg2c05EWWFa?=
 =?utf-8?B?MW4yam5yeDZZZXpFeDZ6clJ0M0pMSjRXcDNvQ3RGcWhQTjF2M0pLbmVLbW1H?=
 =?utf-8?B?VkcxUGg4cGQ2NDg2TTErNFV4SmhPRVFtcWJBYXlwR0xwNDY2M1B3cjFsVkxQ?=
 =?utf-8?B?YjdOKzVPS1RNeDBtRGViZU8yR0xUakliTE1mSXpnbitMc2oway9rZEVna1VK?=
 =?utf-8?B?UnhMUExNRTVGYk5JdlpjSTJPSForM3NFSjBOUDRwWWpGOCtLYXpObEJoVG1R?=
 =?utf-8?B?dnFwWlYvdHlpZXFYZjZPTjhSWHJhZit1Q1owQjRTSEUzQjJMS0dlcHlEWVgw?=
 =?utf-8?B?RUkvcjMwbFlMeTdRelVWWXNPL0Z4U0F5Z3ZWbFVrZmFqWks3UE5LUFZ3OHBE?=
 =?utf-8?B?ZEJLY1c0dm4rMysxVUR1VXR5TVN2TVF2VzlCbnVYVjlMQTZxU2JpUlNzV1Fz?=
 =?utf-8?B?VHJTNWs1MytTWlJVV0pXQWpKdkNmbkRpajJRYUErTlIreE83S3hCTDFnSlZ3?=
 =?utf-8?B?UXVlREF4Y0srZlNaeDE5elJWa2owWlR4OTRJN2NZNUxuTkM2ZWx6WEFRM0RL?=
 =?utf-8?B?V2t3a2MvUUVueENHeFZ0dWxCNFlGRC9DMnF2SEhIMDM5RkVwYitVc3lCRzVn?=
 =?utf-8?B?cXNMWEhyWTNEdE9VZFNwRnRvN2o2M0Z3UG1mREdhUEhQSnFoeVpWcmlDTjRW?=
 =?utf-8?B?RGpKQ0FyMjlyN1djODlXOGdOL05zRGs0cTIvMHduNkVKNVRpS2s4NDdoZE5w?=
 =?utf-8?B?MkxDN3Ntdk1DUmRzeHBwTGtkTEQvNGtWN2xuU2p2ZE1melRDUGs4cWRlWEwy?=
 =?utf-8?B?amh6a3JqdENBeW9MeTdsVEU1YmpmSmw1MmNCLy9WNEgxSlF6VWRINnBFUGpN?=
 =?utf-8?B?MFlEUGlDb3BWdlA1c0JJNXJ2bG43V3dYWkdGckUxOFMycWYxUmUwZHZrMTN3?=
 =?utf-8?B?aVg3ckpsVnZ1SHNtaE5GWml3THJxaXQ0NjZHNkpJcEV2VEhIZy9IcStFVzkw?=
 =?utf-8?B?blJJZEpHRGcrNFZKV1l5UGN6Y29MYS9Wa0d0aVo0T3dKcVJRZ2c2T3hOeTQ2?=
 =?utf-8?B?SVRwOWoyZmtSeUxHMU5ZVGFtRjhYQ1g4SmlVYllnVWJFaWZnbjYyaUhyVUx0?=
 =?utf-8?B?dStpdnVzK2xUSTlZem9jallla2lYalVyVkFid3IvdzM3NFFCOFBFVDh2N2dK?=
 =?utf-8?B?ejRhendZWkJoR3prM2ZYVzFxcXFGNkxxTCt3eHF0dDhsWE1FQ2VaOUpmTW1T?=
 =?utf-8?B?dUJDd3AwUnBNNGVoY3FEMEozTmlRZlEzVGF6UkpoTHdXQWdiZy9tUHBTNHlv?=
 =?utf-8?B?TUR2MzkxNVh2Tm9FSnNRNnRBU2RSUXhSTW0vRGhHQTUvUnB2K0NsaGlUcDg2?=
 =?utf-8?Q?2NYWmqHDf6uDCpKo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41487A4948D5E041A09E1C436DCD6CD4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc177ded-b7ef-4370-93b5-08da22047791
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 12:59:40.7433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PCyOiZc+9lmr4cwB3lMVopiYxbECWEx5sis4wmPNLd2kEli22lfbyZ4G07Q2iIxMgGKYg93jPtmdbGRe4p5i91BdMvsaKmUBBwZ4tqkmKxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2293
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xOS8yMiAxNDoxOSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTA0LTExIDExOjEwLCBzY2hyaWViIFR1
ZG9yIEFtYmFydXM6DQo+PiBUaGVyZSBhcmUgbWFudWZhY3R1cmVycyB0aGF0IHVzZSByZWdpc3Rl
cnMgaW5kZXhlZCBieSBhZGRyZXNzLiBTb21lIG9mDQo+PiB0aGVtIHN1cHBvcnQgInJlYWQvd3Jp
dGUgYW55IHJlZ2lzdGVyIiBvcGNvZGVzLiBQcm92aWRlIGNvcmUgbWV0aG9kcw0KPj4gdGhhdA0K
Pj4gY2FuIGJlIHVzZWQgYnkgYWxsIG1hbnVmYWN0dXJlcnMuIFNQSSBOT1IgY29udHJvbGxlciBv
cHMgYXJlDQo+PiBpbnRlbnRpb25hbGx5DQo+PiBub3Qgc3VwcG9ydGVkIGFzIHdlIGludGVuZCB0
byBtb3ZlIGFsbCB0aGUgU1BJIE5PUiBjb250cm9sbGVyIGRyaXZlcnMNCj4+IHVuZGVyIHRoZSBT
UEkgc3Vic3lzdGVtLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9y
LmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+IFRlc3RlZC1ieTogVGFrYWhpcm8gS3V3YW5vIDxU
YWthaGlyby5LdXdhbm9AaW5maW5lb24uY29tPg0KPj4gUmV2aWV3ZWQtYnk6IFByYXR5dXNoIFlh
ZGF2IDxwLnlhZGF2QHRpLmNvbT4NCj4gDQo+IEkgc3RpbGwgZG9uJ3QgbGlrZSBpdCBiZWNhdXNl
IHRoZSBmdW5jdGlvbiBkb2Vzbid0IGRvDQo+IGFueXRoaW5nIHdoYXQgdGhlIGZ1bmN0aW9uIG5h
bWUgbWlnaHQgc3VnZ2VzdC4gVGhlIHJlYWQNCg0KaXMgc3BpX25vcl9yZWFkX2FueV9yZWcgYSBi
ZXR0ZXIgbmFtZSB0aGFuIHNwaV9ub3JfcmVhZF9yZWc/DQoNCg0KPiBqdXN0IGV4ZWN1dGVzIGFu
IG9wLCB0aGUgd3JpdGUgZXhlY3V0ZXMgYW4gb3Agd2l0aCBhDQo+IHdyaXRlIGVuYWJsZSBiZWZv
cmUuIEFsbCB0aGUgYmVoYXZpb3IgaXMgZGV0ZXJtaW5lZCBieSB0aGUNCj4gJ29wJyBhcmd1bWVu
dC4NCg0KaXQgc3RpbGwgYXZvaWRzIGNvZGUgZHVwbGljYXRpb24sIGRvZXNuJ3QgaXQ/DQoNClRo
YW5rcywNCnRhDQo+IA0KPiBBbnl3YXksDQo+IFJldmlld2VkLWJ5OiBNaWNoYWVsIFdhbGxlIDxt
aWNoYWVsQHdhbGxlLmNjPg0KPiANCj4+IC0tLQ0KPj4gdjM6IG5vIGNoYW5nZXMNCj4+DQo+PiDC
oGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIHwgNDEgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4+IMKgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggfMKgIDQgKysr
Kw0KPj4gwqAyIGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2Nv
cmUuYw0KPj4gaW5kZXggNjE2NWRjN2JmZDE3Li40Mjc5NDMyOGQzYjYgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5v
ci9jb3JlLmMNCj4+IEBAIC0zMDcsNiArMzA3LDQ3IEBAIHNzaXplX3Qgc3BpX25vcl93cml0ZV9k
YXRhKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+PiBsb2ZmX3QgdG8sIHNpemVfdCBsZW4sDQo+PiDC
oMKgwqDCoMKgIHJldHVybiBub3ItPmNvbnRyb2xsZXJfb3BzLT53cml0ZShub3IsIHRvLCBsZW4s
IGJ1Zik7DQo+PiDCoH0NCj4+DQo+PiArLyoqDQo+PiArICogc3BpX25vcl9yZWFkX3JlZygpIC0g
cmVhZCByZWdpc3RlciB0byBmbGFzaCBtZW1vcnkNCj4+ICsgKiBAbm9yOsKgwqDCoMKgwqDCoMKg
IHBvaW50ZXIgdG8gJ3N0cnVjdCBzcGlfbm9yJy4NCj4+ICsgKiBAb3A6wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgU1BJIG1lbW9yeSBvcGVyYXRpb24uIG9wLT5kYXRhLmJ1ZiBtdXN0IGJlIERN
QS1hYmxlLg0KPj4gKyAqIEBwcm90bzrCoMKgIFNQSSBwcm90b2NvbCB0byB1c2UgZm9yIHRoZSBy
ZWdpc3RlciBvcGVyYXRpb24uDQo+PiArICoNCj4+ICsgKiBSZXR1cm46IHplcm8gb24gc3VjY2Vz
cywgLWVycm5vIG90aGVyd2lzZQ0KPj4gKyAqLw0KPj4gK2ludCBzcGlfbm9yX3JlYWRfcmVnKHN0
cnVjdCBzcGlfbm9yICpub3IsIHN0cnVjdCBzcGlfbWVtX29wICpvcCwNCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudW0gc3BpX25vcl9wcm90b2NvbCBwcm90bykNCj4+
ICt7DQo+PiArwqDCoMKgwqAgaWYgKCFub3ItPnNwaW1lbSkNCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPj4gKw0KPj4gK8KgwqDCoMKgIHNwaV9ub3Jf
c3BpbWVtX3NldHVwX29wKG5vciwgb3AsIHByb3RvKTsNCj4+ICvCoMKgwqDCoCByZXR1cm4gc3Bp
X25vcl9zcGltZW1fZXhlY19vcChub3IsIG9wKTsNCj4+ICt9DQo+PiArDQo+PiArLyoqDQo+PiAr
ICogc3BpX25vcl93cml0ZV9yZWcoKSAtIHdyaXRlIHJlZ2lzdGVyIHRvIGZsYXNoIG1lbW9yeQ0K
Pj4gKyAqIEBub3I6wqDCoMKgwqDCoMKgwqAgcG9pbnRlciB0byAnc3RydWN0IHNwaV9ub3InDQo+
PiArICogQG9wOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNQSSBtZW1vcnkgb3BlcmF0aW9u
LiBvcC0+ZGF0YS5idWYgbXVzdCBiZSBETUEtYWJsZS4NCj4+ICsgKiBAcHJvdG86wqDCoCBTUEkg
cHJvdG9jb2wgdG8gdXNlIGZvciB0aGUgcmVnaXN0ZXIgb3BlcmF0aW9uLg0KPj4gKyAqDQo+PiAr
ICogUmV0dXJuOiB6ZXJvIG9uIHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndpc2UNCj4+ICsgKi8NCj4+
ICtpbnQgc3BpX25vcl93cml0ZV9yZWcoc3RydWN0IHNwaV9ub3IgKm5vciwgc3RydWN0IHNwaV9t
ZW1fb3AgKm9wLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnVt
IHNwaV9ub3JfcHJvdG9jb2wgcHJvdG8pDQo+PiArew0KPj4gK8KgwqDCoMKgIGludCByZXQ7DQo+
PiArDQo+PiArwqDCoMKgwqAgaWYgKCFub3ItPnNwaW1lbSkNCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPj4gKw0KPj4gK8KgwqDCoMKgIHJldCA9IHNw
aV9ub3Jfd3JpdGVfZW5hYmxlKG5vcik7DQo+PiArwqDCoMKgwqAgaWYgKHJldCkNCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4+ICvCoMKgwqDCoCBzcGlfbm9yX3Nw
aW1lbV9zZXR1cF9vcChub3IsIG9wLCBwcm90byk7DQo+PiArwqDCoMKgwqAgcmV0dXJuIHNwaV9u
b3Jfc3BpbWVtX2V4ZWNfb3Aobm9yLCBvcCk7DQo+PiArfQ0KPj4gKw0KPj4gwqAvKioNCj4+IMKg
ICogc3BpX25vcl93cml0ZV9lbmFibGUoKSAtIFNldCB3cml0ZSBlbmFibGUgbGF0Y2ggd2l0aCBX
cml0ZSBFbmFibGUNCj4+IGNvbW1hbmQuDQo+PiDCoCAqIEBub3I6wqDCoMKgwqAgcG9pbnRlciB0
byAnc3RydWN0IHNwaV9ub3InLg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5oIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmgNCj4+IGluZGV4IGY5NTIwNjFkNWMy
NC4uN2M3MDQ0NzU5NDZkIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3Jl
LmgNCj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+PiBAQCAtNTU0LDYgKzU1
NCwxMCBAQCBzc2l6ZV90IHNwaV9ub3JfcmVhZF9kYXRhKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+
PiBsb2ZmX3QgZnJvbSwgc2l6ZV90IGxlbiwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdTggKmJ1Zik7DQo+PiDCoHNzaXplX3Qgc3BpX25vcl93cml0
ZV9kYXRhKHN0cnVjdCBzcGlfbm9yICpub3IsIGxvZmZfdCB0bywgc2l6ZV90IGxlbiwNCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCB1OCAq
YnVmKTsNCj4+ICtpbnQgc3BpX25vcl9yZWFkX3JlZyhzdHJ1Y3Qgc3BpX25vciAqbm9yLCBzdHJ1
Y3Qgc3BpX21lbV9vcCAqb3AsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBlbnVtIHNwaV9ub3JfcHJvdG9jb2wgcHJvdG8pOw0KPj4gK2ludCBzcGlfbm9yX3dyaXRlX3Jl
ZyhzdHJ1Y3Qgc3BpX25vciAqbm9yLCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3AsDQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudW0gc3BpX25vcl9wcm90b2NvbCBwcm90
byk7DQo+PiDCoGludCBzcGlfbm9yX2VyYXNlX3NlY3RvcihzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1
MzIgYWRkcik7DQo+Pg0KPj4gwqBpbnQgc3BpX25vcl9vdHBfcmVhZF9zZWNyKHN0cnVjdCBzcGlf
bm9yICpub3IsIGxvZmZfdCBhZGRyLCBzaXplX3QNCj4+IGxlbiwgdTggKmJ1Zik7DQo+IA0KPiAt
LSANCj4gLW1pY2hhZWwNCg0K
