Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368E159F9EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiHXM1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiHXM1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:27:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559991A041;
        Wed, 24 Aug 2022 05:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661344025; x=1692880025;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kLQOLMRAOVS1NL234iTQjRnJuIrwJwasZMOAhoJfWs4=;
  b=D8ZhvEEHmYHNtJKgI+77pBEtcF5TEI+99gYeyce8cEyhOPC2CF3EVW+m
   uvMqtQ7zBCYoK91KLin4kGR8bLUrHYLIQrheRjLQH4zYQapIS3xjoL51t
   Jra8763U64KMT37svf+k3A7xmJ4qIoO714xmikF+0neRfggG89TvVeW/e
   ihgSL2lHO5ad7KGqUu2tCbYbjOQgcpCtCpFHF8myaCi5Kby+LSYaCf+9v
   93nx7+rKyKfL6Y5cMt16oIJD5QN/vXE/dbxX+gHBymUd7Dgn0dNEz0VlU
   1vxlzVDRa3z5GGY2b+Ou4A6VNyr7yNs97UIa1UiCmE0noyJVqQLkljMcf
   g==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="110495675"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 05:27:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 05:27:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 24 Aug 2022 05:27:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7HLr6JMwzxUbNXehhnrFs2BgvJMhu/jFPTz80minXgw188CDad4WzcD+gKwMjxic/Adw7jxt5OuFjuspRY5JPtrw7Lb6hW5U+L2j0ffJTNDc1CVCqy7JIIoFwuXMxPpsXNX+yDmiky4iAcZiHqJ57b7+wHI+E4foSg6v0KlZVmqaswK7EdWziAfdyxCd9ckVOcUdy7TPItckQ1xCKy9NitjFpxPqqFPaY/d0qYhKE0iy8VX7p+QjgxIDDDLUHk41EDgNhNbD3Fgi3Ebxhm6ZtZeQDIvghMhVEFETtgXX4OYmFvx+Gn8yXpE+FZJxZocRxfMzILryNOIdwdjytbEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLQOLMRAOVS1NL234iTQjRnJuIrwJwasZMOAhoJfWs4=;
 b=AhVnuLykyYo2wYgG8rZYf8dIy5xMhXyKIT+LVCiCPt3JG6i4d7u4CRSwnad9s065N6gaJN9ywaJnRSBHBADckwexIelimcNMZBXzDurQTLXwFwIL17VF1arY7VKwxwfnNgxvnK5vylL8DII5x1mx3r/0HKJJcOmg+n6mzKLpDmTgHJWsK/wiSbbV00ogNzNkqwfwZHyYFSfvzuJnVAyTR/8YLabuhLllzqT1KOwDZUt1TXC2lxD51RXF1waAJrZSHV11JdMdpFS9YM4PlXFGc7XqwGa8O5xnWsYu6RFddca2ocvKoduEisp1/jovSjlP1NlajThCZu55pnsoGH9y/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLQOLMRAOVS1NL234iTQjRnJuIrwJwasZMOAhoJfWs4=;
 b=sAiOBYz9QEHA+AnFmckYDH6A9DyPEjoRd+jvKMKhgl7VeLx6kQ5Cw+Qons3nEAAm+u6FS9ifyVibCUlTE69h8eAiWJzETrAHyayk+aaiSA6+Zl3ozE5r3lV3DUVEV6PCB+WNqseE4OSdoys9YjtRtlRKFZfNjSTfZ1sEFOmnLv4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY8PR11MB7082.namprd11.prod.outlook.com (2603:10b6:930:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 12:27:01 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 12:27:01 +0000
From:   <Conor.Dooley@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <christophe.jaillet@wanadoo.fr>, <Daire.McNamara@microchip.com>,
        <a.zummo@towertech.it>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH] rtc: mpfs: Use devm_clk_get_enabled() helper
Thread-Topic: [PATCH] rtc: mpfs: Use devm_clk_get_enabled() helper
Thread-Index: AQHYt5IndXqzWMJbz0OfuNYZ1M2LkK290O0AgAAPZICAABoVAA==
Date:   Wed, 24 Aug 2022 12:27:01 +0000
Message-ID: <7976bb16-db1f-aee4-d075-97296e91d3df@microchip.com>
References: <e55c959f2821a2c367a4c5de529a638b1cc6b8cd.1661329086.git.christophe.jaillet@wanadoo.fr>
 <f76fb247-5160-61ed-a0a3-037d2f40d2f9@microchip.com>
 <YwYDI04TDD0RWn2B@mail.local>
In-Reply-To: <YwYDI04TDD0RWn2B@mail.local>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41da9156-21b7-4e63-915d-08da85cbf241
x-ms-traffictypediagnostic: CY8PR11MB7082:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQrM7qgMoVISreGSM5KyeogOaTCObcoqlqeLznnAfge1mjwDabPnsAkCJgi2iG1nrrAuZpt1MfwMVyUsKM8ZQpuWQQPHUJsVm3lAaK8E2wIUSw8tODYUBYHaUS1YZX3WsACjM1IxEthbl7J9Do45CJe7plBx+ylEG+/42hsxjgTcvdO5yrp4SECkY5zTc24ES7gHiLBAEe7B4gtN/XlDem8yAkFSFdNVbKCp1I4AyponlM4kGdwNrWeyvwDkWpSkPnSvVNE8Heo816iK6J9+BGvCiEiui3sRiB3y5VsGVHm7wgI8+UkCm1IMuWnvkUUzRB1bc8TgB20tSiVBn63IxHnsJn18jzEaqjoSCxW8Gooz45bBazUnFaW7boDyqof5tebPXO0Ov5aGDoBuQYJOUZt1X0YdioXN4yeaa4MttDCLjHoK2doJuQv2i5xHaQMdspqv31c9slIPxhbCxf4oz2Ks9M5fmfy9zN8ddt2JCRzZivWCiYOkoSmAoZwsP06zfvUvk+W3wLgUO6tr6vKWbRJN6Ka2cgOhPYf6ydQf3pbV3bH/0YYHZKaYBHeWxzNZivxq/HgDGOOY6DZb3Kfav3TWT2qUGioQp57977RXY8LNT4CkIxPC++1ml8yWO9nuhdiygC4dP31rd85oD0Ea+BXLOI8D72RvWxoAUjJtOR+QjXp2OnCkjMbQ+qD7ejAj/mUbMItUdwc6mGDwzc/IxY/CLFOZbGB/pfsNZq+5L7LyaDnEqBORANEytjgOQT5haT+EIz9owtS4b8iuawseBlI1AdETyKBLDZRTawZTSpnMaqt64xw+xeKQkY8q5NnP4cbMHw9jUpltH4NbPTBVV+rdO0ECr5EQNRpm+gpGM1AbHCa5ga38ycKheaQ0q6YTcVteuLYcuEA7iv0t2fgG1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(39860400002)(376002)(346002)(83380400001)(38070700005)(122000001)(66556008)(38100700002)(91956017)(76116006)(66946007)(8676002)(66446008)(64756008)(54906003)(6916009)(66476007)(4326008)(316002)(2906002)(8936002)(5660300002)(6512007)(26005)(53546011)(6506007)(186003)(2616005)(31696002)(41300700001)(6486002)(966005)(71200400001)(86362001)(31686004)(36756003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3VVOVBBeXFXUUxuOFRhMmNUQkF6ajBtR3l1cDQ2eHhtMUpqL1ZBcjFQNFlm?=
 =?utf-8?B?TkU5dWxhN2pPVm1VZi9hR25UMnhDNHRlSmhZOWZ2bVExREpTMjZzYVJ0VkNN?=
 =?utf-8?B?N1hpS3hVdmhwNDY0VVhvb3VqTjBpZEo2VFhxYWx0TDF2RERjdDA2aG1QZ1N5?=
 =?utf-8?B?M2tJOVN0UFZScENNdTF2bE1WWU9GbXBaWnJDMDcrZDFYelc5Z3p1bk02TjJF?=
 =?utf-8?B?akVHUjhzdTZZR3JlN0tzTFdiMjFqMkVacXltYTJDZEFLbGR4RW1YMERSQlUx?=
 =?utf-8?B?WUJyeG9XQ2dlcm1LMlJNc3hZQ2Rqc2MzT0hkVWlVT1NZZmFqNVI0Z3RtQSta?=
 =?utf-8?B?dXNWcUJROFk2Zk54YnArYkwzdU5hL01BQ1hhQ0YwUndweFRWLzUxUU9xaUNT?=
 =?utf-8?B?MVdwUy9zUHZwYXhKQ2N4TmVYNm1BZnhYVE9BN3lSdGxBNkNXNHVhZlFicjVw?=
 =?utf-8?B?ZElZTEFsMzZ4OXlVTjFHRGgyWUQ0VkVPYjdBTllYRExGWTlveFB1dEhzdnZs?=
 =?utf-8?B?SkprODQ5a1RIK3pzM1YxSVhqeDBudEVzbkVVQTVqOUI5V0ZzSjRPRVJKNjZW?=
 =?utf-8?B?MDNhRCtoUUx2TThIYkt6RWM4Y3dDRjVrMWJzbURpYkZHcjFBK3BoRnVZdHpR?=
 =?utf-8?B?d3NmZ29sWnA2bHBwTzRrVlpXdC9KdkNIVjg5L3JPaGVLNHlFMWpSdldOWmxY?=
 =?utf-8?B?aW4rY0tFc0V1dWJlcGo0OUpRZC9hR2pSN2lCOER2VEtsQUh4azNFcDZrY25q?=
 =?utf-8?B?NGU2MFhWeUpDRjJ1RGxISVZnZlQ1ZUJhaDRaWDhYSGZUTDlWQmVPeGE0TFg4?=
 =?utf-8?B?RXUwejE4K3RobDJyM0k2djEyWkpxeTEwRUg3K2VkSUxldXZ5MDdaRW5ZVjUy?=
 =?utf-8?B?c095eUt2QWpIWC9qK1dWdzJvaG5GQi9hRnBPY2UreGJDRmJNbWJVSHE3bGlX?=
 =?utf-8?B?MGNRejJHMzFaMHZtQmxCZmlFQmxqNTNaVHRwVStCYktYMWJBd3VyQlRSUW5m?=
 =?utf-8?B?YUpualplNlR6VFlxaDMrajZ5ZE5pbzlHY2dIV3lucS9wSmVNK0NuYVlLeVo4?=
 =?utf-8?B?bktMZjZxVkE5ZTczTjdJY2JZUENURWJMNmJaTXFNR0dDQ24veURZTjJzUlVT?=
 =?utf-8?B?UUZ0bFRqOVJ4RFdDd0thQlBLU3dVelhPaVRmM3VudnQ1d1cvZGxIVGUvVzZY?=
 =?utf-8?B?VmlPZHpIRzE4NmdkbXZnbW8yaUg2bS9YQmlpQy9yTlF3VzRtWWZjeXNNbDZv?=
 =?utf-8?B?eEwzbW1LemZwcXdWWkhlTGIrUGsxaStjY2lmdXRldk40V2ZHMGs0NGxzTFEw?=
 =?utf-8?B?aXo0SENFMlNwREIrVmpyK1BEbGFuWHNjZEJVdW9TTW5SOHRWTDRKNUYxbU9j?=
 =?utf-8?B?UTN1M0dTckJORWNTdHVnWlFwT1hCckExc0VtUkd6SUZ2dzNvS0pTVDlFdzRr?=
 =?utf-8?B?R2VEM3ZGZ2tuMXdYdlg3aHNoZjUrTGptZVF6WlRHa3JOczlzaDNkeEZsWVRE?=
 =?utf-8?B?dTErWW5yL2RYcGtBclFGblZoZXlXWGdXZHRoUFJaWE9BL0Z4UW5sUnhpbFBj?=
 =?utf-8?B?UGlWVWJwUk1mTys3Ly9ZeXM3b0gxc05sUVdHeVJTblFUdnFWc1I0b2h5aHdK?=
 =?utf-8?B?cVViMWN5SW1YditFUDczOFUyT0ZOV0c5aU8zMXF2NW5KamRKNWRQTDZSdkxO?=
 =?utf-8?B?VVhCdGp2OGUzRzVPTTF2N1ZRMy9LalNpZ2MxTXI5Ylc3LzRESEpHdUM2YzJP?=
 =?utf-8?B?SlpGNlJNRzNVa2hsQUxCdUV4U1hHUnVzekI1cThxSHNzNlNGb0ZzQlVLc2Iz?=
 =?utf-8?B?U2QyaklvcTFIeWxYL2NyamJDQjJmZmVmZzI3dkEzZ0pOSEFPV29RdWRrWTRp?=
 =?utf-8?B?RUdreURxd25WSmE0Ny96Z2UyNWNMeWlPL3VlTXVRV0N1SG1rNmh1bnNyd1M5?=
 =?utf-8?B?OHpldk9HVlI5WG4xdWQvdGVGMEZKYkNKWWZyQVBoUDdFZGUvc3Z2bkpNVFY3?=
 =?utf-8?B?Mzh3TXJzWkVBSEpXckp4NmtObUk5WDdZaWtXcXFpL002SGZqNm9Db1A4dzlC?=
 =?utf-8?B?ZHpremhLdzI4YWZjVnZXVTgzeEoybjhROThkT2lhbEx6NXdhNHQ5ZlZLcERv?=
 =?utf-8?Q?U+Vs4cN2VZ+H00Re4Ogk1BHl4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8527556764A1B4086D7610B85B833CD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41da9156-21b7-4e63-915d-08da85cbf241
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 12:27:01.5273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKajtr29qO7pHW4PP1wtRYT1y9z6IJHmSMIhZjXDmyf2lW15HsGvxO9s/ZyRYkPwi9q/Q7b8RSLC6f20cAXfo85sjFnRBclcdYCTeAHoDRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7082
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQvMDgvMjAyMiAxMTo1MywgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjQvMDgvMjAyMiAwOTo1ODozNSsw
MDAwLCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEhleSBDaHJpc3RvcGUs
DQo+PiBUaGFua3MgZm9yIHlvdXIgcGF0Y2guDQo+Pg0KPj4gT24gMjQvMDgvMjAyMiAwOToxOCwg
Q2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZQ0KPj4+DQo+Pj4gVGhlIGRldm1fY2xrX2dldF9lbmFibGVkKCkgaGVscGVyOg0KPj4+
ICAgICAgLSBjYWxscyBkZXZtX2Nsa19nZXQoKQ0KPj4+ICAgICAgLSBjYWxscyBjbGtfcHJlcGFy
ZV9lbmFibGUoKSBhbmQgcmVnaXN0ZXJzIHdoYXQgaXMgbmVlZGVkIGluIG9yZGVyIHRvDQo+Pj4g
ICAgICAgIGNhbGwgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKCkgd2hlbiBuZWVkZWQsIGFzIGEgbWFu
YWdlZCByZXNvdXJjZS4NCj4+Pg0KPj4+IFRoaXMgc2ltcGxpZmllcyB0aGUgY29kZSwgdGhlIGVy
cm9yIGhhbmRsaW5nIHBhdGhzIGFuZCBhdm9pZCB0aGUgbmVlZCBvZg0KPj4+IGEgZGVkaWNhdGVk
IGZ1bmN0aW9uIHVzZWQgd2l0aCBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoKS4NCj4+Pg0KPj4+
IFRoYXQgc2FpZCwgbXBmc19ydGNfaW5pdF9jbGsoKSBpcyB0aGUgc2FtZSBhcyBkZXZtX2Nsa19n
ZXRfZW5hYmxlZCgpLCBzbw0KPj4+IHVzZSB0aGlzIGZ1bmN0aW9uIGRpcmVjdGx5IGluc3RlYWQu
DQo+Pg0KPj4gRmlyc3RseSwgSSB0aGluayBzb21ldGhpbmcgaXMgbWlzc2luZyBmcm9tIHRoZSBj
b21taXQgZGVzY3JpcHRpb24gaGVyZS4NCj4+IGRldm1fY2xrX2dldF9lbmFibGVkKCkgaXMgbm90
IGp1c3QgYSBibGFua2V0ICJ1c2UgdGhpcyBpbnN0ZWFkIG9mIGdldCgpLA0KPj4gcHJlcGFyZV9l
bmFibGUoKSIgJiBpcyBvbmx5IGludGVuZGVkIGZvciBjYXNlcyB3aGVyZSB0aGUgY2xvY2sgd291
bGQNCj4+IGJlIGtlcHQgcHJlcGFyZWQgb3IgZW5hYmxlZCBmb3IgdGhlIHdob2xlIGxpZmV0aW1l
IG9mIHRoZSBkcml2ZXIuIEkgdGhpbmsNCj4+IGl0IGlzIHdvcnRoIHBvaW50aW5nIHRoYXQgb3V0
IHRvIGhlbHAgcGVvcGxlIHdobyBkbyBub3Qga2VlcCB1cCB3aXRoDQo+PiBldmVyeSBoZWxwZXIg
dGhhdCBpcyBhZGRlZC4NCj4+DQo+PiBJIGhhZCBhIGJpdCBvZiBhIGxvb2sgdGhyb3VnaCB0aGUg
ZG9jdW1lbnRhdGlvbiB0byBzZWUgaWYgdGhlIGJsb2NrIHdvdWxkDQo+PiBrZWVwIHRyYWNrIG9m
IHRpbWUgd2l0aG91dCB0aGUgQUhCIGNsb2NrIGVuYWJsZWQsIGJ1dCBpdCBkb2VzIG5vdCBzZWVt
IHRvLg0KPj4gVGhlcmUgaXMgbm8gcmVhc29uIHRvIHR1cm4gb2ZmIHRoZSBjbG9jayBoZXJlIChp
biBmYWN0IGl0IHdvdWxkIHNlZW0NCj4+IGNvdW50ZXIgcHJvZHVjdGl2ZSB0byBkaXNhYmxlIGl0
Li4pIHNvIGl0IGxvb2tzIGxpa2UgdGhlIHNob2UgZml0cyBpbiB0aGF0DQo+PiByZWdhcmQuDQo+
IA0KPiBUaGlzIHdvdWxkIGJlIHZlcnkgc3VycHJpc2luZyB0aGF0IGl0IGRvZXNuJ3Qga2VlcCB0
aGUgdGltZSB3aXRoIHRoZSBBSEINCj4gY2xvY2sgZGlzYWJsZWQsIHRoaXMgd291bGQgbWVhbiB0
aGUgUlRDIGxvc2VzIHRoZSB0aW1lIHdoZW4gdGhlIFNvQyBpcw0KPiBub3QgcG93ZXJlZC4gb3Ig
aXMgdGhlIEFIQiBjbG9jayBhbHNvIGluIHRoZSBhbHdheXMtb24gZG9tYWluPw0KDQpJZiB0aGUg
U29DIGlzIGNvbXBsZXRlbHkgdW5wb3dlcmVkLCB0aGUgcmVmZXJlbmNlIGNsb2NrIHdpbGwgYmUg
Z29uZSB0b28NCi0gbm90IGp1c3QgdGhlIEFIQiBjbG9jay4gSW4gbG93IHBvd2VyIHN0YXRlcywg
b3Igd2l0aCB0aGUgY3B1cyBkaXNhYmxlZA0KZXRjLCB0aGUgcnRjIHNob3VsZCBrZWVwIGNvdW50
aW5nLiBJcyB0aGVyZSBzb21ldGhpbmcgSSBoYXZlIG1pc3NlZCAmDQpzaG91bGQgaGF2ZSBlaXRo
ZXIgZG9jdW1lbnRlZCwgZXhwbGFpbmVkIG9yIHNldCB3aGVuIGZpcnN0IHN1Ym1pdHRpbmcgdGhl
DQpkcml2ZXI/IEkgcmVtZW1iZXIgcmVhZGluZyBpbiB0aGUgZG9jcyBhYm91dCB0aGUgcnRjIGNs
YXNzIGZyYW1ld29yaw0Kc3VwcG9ydGluZyBzeXN0ZW1zIHdoZXJlIHRoZSBiYXR0ZXJ5IGJhY2tl
ZCBydGMgd2FzIGV4dGVybmFsICYgdGhlIFNvQw0KaGFkIGFuIFJUQyB3aXRoIHBvdGVudGlhbGx5
IG1vcmUgZmVhdHVyZXMgZXRjLiBNYXliZSBJIG1pc3VuZGVyc3Rvb2Q/DQoNClRoaXMgaXMgYSAi
aGFyZGVuZWQiIHZlcnNpb24gb2YgYW4gRlBHQSBjb3JlICYgQUZBSUsgdGhlIGNsb2NrIHRoYXQN
CmNsb2NrcyB0aGUgQUhCIGludGVyZmFjZS93cmFwcGVyIGFsc28gY2xvY2tzIHRoZSBsb2dpYyBp
biB0aGUgUlRDLiBUaGUNCmRvY3MgYXJlIHZlcnkgc2NhbnQsIHNvIEkgd2lsbCB0cnkgdG8gZ2V0
IG15IGhhbmRzIG9uIHRoZSBSVEwuIFRoZQ0KY2xvY2tzIHRoZW1zZWx2ZXMgc2hvdWxkIGJlIGFs
d2F5cy1vbi4uDQoNCkkgZGlkIHNvbWUgYnJpZWYgdGVzdGluZyBqdXN0IG5vdywgYW5kIGlmIEkg
ZGlzYWJsZSB0aGUgQUhCIGludGVyZmFjZQ0KdGltZSBrZWVwaW5nIGlzIGxvc3QuDQoNCkkgYW0g
aW5jbGluZWQgdG8gc2F5IHRoYXQgdGhpcyBwYXRjaCBpcyB2YWxpZCAmIHRoZSB1bmRlcmx5aW5n
IGNsb2NrDQpuZWVkcyB0byBiZSBtYXJrZWQgYXMgY3JpdGljYWwgLSB1bmxlc3MgSSBoYXZlIG1p
c3NlZCBzb21ldGhpbmcuLg0KDQpBcHBseWluZyB0aGlzIHBhdGNoIHNlZW1zIGxpa2UgaXQgd2ls
bCBoYXZlIG5vIGZ1bmN0aW9uYWwgY2hhbmdlIHNpbmNlDQp0aGUgY2xvY2sgaXMgYWxyZWFkeSBi
ZWluZyBkaXNhYmxlZCBpbiB0aGUgcmVtb3ZlIGNhbGxiYWNrIHNvOg0KDQpSZXZpZXdlZC1ieTog
Q29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0KSWYgbXkgY29uY2x1
c2lvbnMgaGVyZSBhcmUgY29ycmVjdCwgSSdsbCBzdWJtaXQgYSBwYXRjaCBmb3IgdGhlIGNsb2Nr
DQpkcml2ZXIgbWFya2luZyB0aGUgcnRjJ3MgQUhCIGludGVyZmFjZSBjbG9jayBhcyBjcml0aWNh
bC4NCg0KPiANCj4+DQo+PiBIb3dldmVyLi4uDQo+Pg0KPj4+DQo+Pj4gVGhpcyBhbHNvIGZpeGVz
IGFuICh1bmxpa2VseSkgdW5jaGVja2VkIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgpIGVycm9y
Lg0KPj4+DQo+Pj4gQmFzZWQgb24gbXkgdGVzdCB3aXRoIGFsbHllc2NvbmZpZywgdGhpcyByZWR1
Y2VzIHRoZSAubyBzaXplIGZyb206DQo+Pj4gICAgICB0ZXh0ICAgIGRhdGEgICAgIGJzcyAgICAg
ZGVjICAgICBoZXggZmlsZW5hbWUNCj4+PiAgICAgIDUzMzAgICAgMjIwOCAgICAgICAwICAgIDc1
MzggICAgMWQ3MiBkcml2ZXJzL3J0Yy9ydGMtbXBmcy5vDQo+Pj4gZG93biB0bzoNCj4+PiAgICAg
IDUwNzQgICAgMjIwOCAgICAgICAwICAgIDcyODIgICAgMWM3MiBkcml2ZXJzL3J0Yy9ydGMtbXBm
cy5vDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9w
aGUuamFpbGxldEB3YW5hZG9vLmZyPg0KPj4+IC0tLQ0KPj4+IGRldm1fY2xrX2dldF9lbmFibGVk
KCkgaXMgbmV3IGFuZCBpcyBwYXJ0IG9mIDYuMC1yYzENCj4+PiAtLS0NCj4+PiAgICBkcml2ZXJz
L3J0Yy9ydGMtbXBmcy5jIHwgMTkgKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+ICAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTggZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ydGMvcnRjLW1wZnMuYyBiL2RyaXZlcnMvcnRjL3J0Yy1tcGZzLmMNCj4+
PiBpbmRleCA5NDRhZDEwMzY1MTYuLjJhNDc5ZDQ0ZjE5OCAxMDA2NDQNCj4+PiAtLS0gYS9kcml2
ZXJzL3J0Yy9ydGMtbXBmcy5jDQo+Pj4gKysrIGIvZHJpdmVycy9ydGMvcnRjLW1wZnMuYw0KPj4+
IEBAIC0xOTMsMjMgKzE5Myw2IEBAIHN0YXRpYyBpbnQgbXBmc19ydGNfYWxhcm1faXJxX2VuYWJs
ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBlbmFibGVkKQ0KPj4+ICAgICAgICAg
ICByZXR1cm4gMDsNCj4+PiAgICB9DQo+Pj4NCj4+PiAtc3RhdGljIGlubGluZSBzdHJ1Y3QgY2xr
ICptcGZzX3J0Y19pbml0X2NsayhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+Pj4gLXsNCj4+PiAtICAg
ICAgIHN0cnVjdCBjbGsgKmNsazsNCj4+PiAtICAgICAgIGludCByZXQ7DQo+Pj4gLQ0KPj4+IC0g
ICAgICAgY2xrID0gZGV2bV9jbGtfZ2V0KGRldiwgInJ0YyIpOw0KPj4+IC0gICAgICAgaWYgKElT
X0VSUihjbGspKQ0KPj4+IC0gICAgICAgICAgICAgICByZXR1cm4gY2xrOw0KPj4+IC0NCj4+PiAt
ICAgICAgIHJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShjbGspOw0KPj4+IC0gICAgICAgaWYgKHJl
dCkNCj4+PiAtICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIocmV0KTsNCj4+PiAtDQo+Pj4g
LSAgICAgICBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoZGV2LCAodm9pZCAoKikgKHZvaWQgKikp
Y2xrX2Rpc2FibGVfdW5wcmVwYXJlLCBjbGspOw0KPj4NCj4+IC4uLiB0aGlzIGJpdCBoZXJlIGNv
bmNlcm5zIG1lIGEgbGl0dGxlLiBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBiZQ0KPj4gcmVnaXN0
ZXJpbmcgYSBjYWxsYmFjayBoZXJlIGF0IGFsbCAtIGlmIHdlIHBvd2VyIGRvd24gTGludXggdGhp
cyBpcw0KPj4gZ29pbmcgdG8gZW5kIHVwIHN0b3BwaW5nIHRoZSBSVEMgaXNuJ3QgaXQ/DQo+Pg0K
Pj4gSSB0aGluayB0aGlzIGlzIGxlZnQgb3ZlciBmcm9tIHRoZSB2MSBkcml2ZXIgc3VibWlzc2lv
biB0aGF0IHJlc2V0DQo+PiB0aGUgYmxvY2sgZHVyaW5nIHByb2JlICYgc2hvdWxkIGJlIHJlbW92
ZWQuDQo+Pg0KPj4gVGhhbmtzLA0KPj4gQ29ub3IuDQo+Pg0KPj4+IC0gICAgICAgcmV0dXJuIGNs
azsNCj4+PiAtfQ0KPj4+IC0NCj4+PiAgICBzdGF0aWMgaXJxcmV0dXJuX3QgbXBmc19ydGNfd2Fr
ZXVwX2lycV9oYW5kbGVyKGludCBpcnEsIHZvaWQgKmRldikNCj4+PiAgICB7DQo+Pj4gICAgICAg
ICAgIHN0cnVjdCBtcGZzX3J0Y19kZXYgKnJ0Y2RldiA9IGRldjsNCj4+PiBAQCAtMjUxLDcgKzIz
NCw3IEBAIHN0YXRpYyBpbnQgbXBmc19ydGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4+PiAgICAgICAgICAgLyogcmFuZ2UgaXMgY2FwcGVkIGJ5IGFsYXJtIG1heCwgbG93
ZXIgcmVnIGlzIDMxOjAgJiB1cHBlciBpcyAxMDowICovDQo+Pj4gICAgICAgICAgIHJ0Y2Rldi0+
cnRjLT5yYW5nZV9tYXggPSBHRU5NQVNLX1VMTCg0MiwgMCk7DQo+Pj4NCj4+PiAtICAgICAgIGNs
ayA9IG1wZnNfcnRjX2luaXRfY2xrKCZwZGV2LT5kZXYpOw0KPj4+ICsgICAgICAgY2xrID0gZGV2
bV9jbGtfZ2V0X2VuYWJsZWQoJnBkZXYtPmRldiwgInJ0YyIpOw0KPj4+ICAgICAgICAgICBpZiAo
SVNfRVJSKGNsaykpDQo+Pj4gICAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoY2xrKTsN
Cj4+Pg0KPj4+IC0tDQo+Pj4gMi4zNC4xDQo+Pj4NCj4+Pg0KPj4+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+Pj4gbGludXgtcmlzY3YgbWFpbGluZyBs
aXN0DQo+Pj4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPj4+IGh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YNCj4+DQo+IA0KPiAt
LQ0KPiBBbGV4YW5kcmUgQmVsbG9uaSwgY28tb3duZXIgYW5kIENPTywgQm9vdGxpbg0KPiBFbWJl
ZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nDQo+IGh0dHBzOi8vYm9vdGxpbi5jb20N
Cg0K
