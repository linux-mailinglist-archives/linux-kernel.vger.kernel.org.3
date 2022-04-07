Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513C24F75FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbiDGG2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240254AbiDGG2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:28:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E9313D35;
        Wed,  6 Apr 2022 23:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649312800; x=1680848800;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=POKA+BzYE6fvSdeeA50WOBXm6GBDORiWD0ixHCK+GPU=;
  b=gLD0SqH8ZISB6q+jYd3tdBP1AVTqaiUCbulli5fY1JiGzbnvMaUyb0O7
   OQHg9zz4Qdx+C9Pu5U8Iy3coSimAM3ppeJ52+GlADL8WuUGU8pU1xTCsC
   OSigHJ7xQWE6NsEBLtYrNUPjMBlfQKnLr8MhENBlFsa/7NagvroFh8bS1
   kay6pDvHLnnuFqPj6j1iZRpGCrp1CQ4hOSFRrnrU6JfpBVEZ6NjWTTtZu
   WLFZUqaI25IMt0ECWBqY2U6jEVmF1kI/43yQ2lNSSLHCPZR2qelEaSuPY
   tkfPWo4cIXH7eMZjA2hKTyeNWbioFLHyomvk/nZt3K0qYoDdbrv+7tJc9
   w==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643698800"; 
   d="scan'208";a="159673523"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Apr 2022 23:26:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Apr 2022 23:26:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 6 Apr 2022 23:26:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nt2l+AWv71LamkeJqlE+WqksPJCyEErh70CFTc4bB2WClAcZ0gA+exLnS+HZRQcIut47gXlRkAXdxIcdUuVHNqVKMOSeJbfVxyS7oJKly5dCnlbnz2nekP3OJravxKexN1dHgZhXdflliALEZ3Xag5CxMUOCWJCuITWvYNK3m0DJYDkXQJu0i3ch/q2Vrot24ePg7pvvJV9zvnjNx0DeBF3VrXQ+XbXP3GsQDA6mdaRmUQxS0p8oEhXDwAsRQLvy43BMrALIkc9EEGXAT6vrFAAbON5awXz7h0uEr63VC6lgrt+wKVfuH3MkzKXXwI0cPjJLJVD+Bx4w96P9abCueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POKA+BzYE6fvSdeeA50WOBXm6GBDORiWD0ixHCK+GPU=;
 b=TMQOSw+PjkaH56gnivy45iI/SzQNxXiZOflmOJJOASv7dQ6psyQ5eNuCkyytQOMfMSBMY0S1NWtXV2yiwafV41hDWeREo8eIDvNtL45LH46qr7yZc5TkmINsDeNS/9ekWamBj9wWPzHrqeTA09eE6nENvIp36fGE7q+V8dGD5+u1tzpjD0OXowapRkGWawjz2ZRTsEHE9+t5tcYJE+J1lmrmuRKmufDYiNr48jIJT13erhHHmu84VPl7f0Pz+gAn3oYcgkdVibBy26C3tvOG5a3yxx0pSeuGqh28QOG+w0e6Sub3QL43pNU+jiHGLJT/VR0W5hNJsD59/9FUi4/fJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POKA+BzYE6fvSdeeA50WOBXm6GBDORiWD0ixHCK+GPU=;
 b=veURw1A55w87oy/ikRRQmeXoWtDwagas3FVAsVC+YJCzLfvX3Jll8MOMWPysFJ6KK3RGoRCfRCh43NwQ/MaN9uIDqm9WuAG6FAb1CbXY5hTqBW7PmCKBqIfxssm0A63VuQcvduTn6HKoILT31hwRhxFEd48ey4Cavt+6SOmvB6Y=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by SN6PR11MB3071.namprd11.prod.outlook.com (2603:10b6:805:d6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 06:26:37 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%7]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 06:26:37 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Tudor.Ambarus@microchip.com>, <Nicolas.Ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Mihai.Sain@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: sama7g5ek: Align the impedance of the
 QSPI0's HSIO and PCB lines
Thread-Topic: [PATCH] ARM: dts: at91: sama7g5ek: Align the impedance of the
 QSPI0's HSIO and PCB lines
Thread-Index: AQHYSkhvqPPZ9iBRZEaUnnDvnC7rzQ==
Date:   Thu, 7 Apr 2022 06:26:37 +0000
Message-ID: <8f778b95-d68e-6575-ff8b-f1dd8d4d8777@microchip.com>
References: <20220406130505.422042-1-tudor.ambarus@microchip.com>
In-Reply-To: <20220406130505.422042-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ea7588e-bcb2-4744-2d49-08da185f91cd
x-ms-traffictypediagnostic: SN6PR11MB3071:EE_
x-microsoft-antispam-prvs: <SN6PR11MB307198D5A051563A09F560A487E69@SN6PR11MB3071.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LskkKsEU/A5nrGaXhFr5++ojOelgPL/WJUDjbFtfvmqtWBUeTaVmoKlOPnjKQUspBbIx1k9HQ9cRZI3RTlAI/BGQE1zvPMD45Unty9v0hH3KesT3WRjSniGt52CXe2by+oEtG938Y5kzEMqQnyUxRXZOjObYXsCyPuzp3xCfzkcmjUYKHig+QSYeJ/X0eaaF0eYHVNr2iXTb3EoxbceZtfFuacQxM9QCrZjxj55A6VEZD6i9nFFzJflWA1NdJBYrf71kxEJgYq5BXeJ8nVDv5nA5xwbbx+RWVfsPMMtzBNaMeTiV5XRuP8IDpSc7/Eq0myBirLHV4oae5r0/CePuJTLENyAKv7ojEX0ObRuRDuXiYFWiD+W1AAZgBWL7zs7s0YfRu8XCwi1NL5ilPr6oVnyTvqRzUoscd/vNvW6y3T6ddyzScMy6nLJ1SRb+d59yT3pK2SEA61aMwlMIg1NuyAVRXYvZBTEf925lA1USXojK1zS2bt25pryy8wo41KS1Ni3gQHStk+TtBjTJtAqA6IJZ5t50j16z/pscqxr+AogtQ3i3zV4/TxYMcvqfsm1dRKDH3/rm3D67tPnfUNxFn74KUedUqdgWAtvJWA5vLcZcp6S/IgXgFYM1jhSkwfGM6ZEZGEZ6O+78b8gkYJ6JFxZbkt2JPNcrapAGE7piUJGxst5zWVL4DWbPb2P9RQ3lmelWj54Nw+80MlY13KKt6rfn/7xTxSLG2I3iqR9UWm1iAPG2paVwi+ziT6Me7tGvrp8x5jR6/2ypD7C/yomx0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(31696002)(6486002)(8936002)(5660300002)(107886003)(508600001)(53546011)(2616005)(6512007)(26005)(186003)(2906002)(110136005)(6506007)(6636002)(4326008)(91956017)(38100700002)(76116006)(66556008)(38070700005)(8676002)(64756008)(66446008)(66476007)(66946007)(316002)(122000001)(54906003)(36756003)(31686004)(71200400001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHdnVUZhTnl5VVluN3NuWjFKWWFTZENJVDhpM1F2ZUwrNGxCQmN3WTNYbjMw?=
 =?utf-8?B?R2hMQ0tIa3hyMGxUT1RTNHhFVHlyWUFNc29QMENzaHZPTEJiVlIxYkJwNndZ?=
 =?utf-8?B?eStwTkpGYzFON2hqcncyWkdPRWlFZUdOTHdlTjB0TmdqR211Wld5R01hMVZY?=
 =?utf-8?B?bU9idkU2WnRMQU5UbDZUMWRYeE13MEZackJzZ29nR1RTZnp1YXhIYzcvMGFC?=
 =?utf-8?B?TXJicHIvZUk5U3VUdTk3b2lJYzNLODZPZjFNZk85Q21yR2JSSCtyWDl1blVU?=
 =?utf-8?B?SkdGTVpUN0V4QzdBdXhKMlU5T3FQQzRRdXBkajdURzhicHFHZW54RWpRUU1y?=
 =?utf-8?B?cDdJcm53bk5JazJ4WDd6cWd0L2hXK2lzVTZDazZrOFBLSEpyeHdKZlBQSUxq?=
 =?utf-8?B?WlhDQTNiMXhaMm5jeUJEK0hRQXp5WDBzdGxPajZmSnpMZW5nbWhCS1piTWda?=
 =?utf-8?B?SG5Wb1dJaU9WZEk1RzdZNzRDaWJUQS9kLy9vb1dodkdzMitMY3o3bEVlTkRP?=
 =?utf-8?B?YWlMZTczK1VXQXVsSGVZL3cycGt3RXdBbGhTUkdhVVdJTXdqaEprcTBOaU53?=
 =?utf-8?B?YU91dE83SU95dzVtSTJibEQzcXVYZnRjZU1UWW9uNmxndWFPZytTb1JUT29G?=
 =?utf-8?B?cUltVXVXZDZoSWhxTTdqbFlueW5mVS85WHUvMkFYYXNUZzFpR3cvRzFjTGth?=
 =?utf-8?B?SlpZVUdrQlRNZmwrQU8xR2hMRWZWRXFFakI4SU5rVUF2ZEE2dXdIc1Y4aWVv?=
 =?utf-8?B?bStXSEl0Q3Z2bm8wN2taYXU3N1lwT3kwRGY4M3l3Y3RVbkhoMG5ZRlZmdTVj?=
 =?utf-8?B?Q1hsSmdlZ3gvVi8wcGY0MkQyZ3pCdmF6MEJLRUZSVjVHQmVNb1o2OFNJeHN3?=
 =?utf-8?B?akpUSXQ0R0tNd013OHhPTGlCVXFTeWZ5ejB2MGtCYUdhYkNEQkM2VFBDVk1i?=
 =?utf-8?B?SnNNeUVYcmFXdWUySUhSS0UzbEFNQjBGWEdFN0xtVk1pWU9sT2tRQi9EM1NG?=
 =?utf-8?B?TWRmZEhiU1d1OEdBQ1lyOTVNMkRrUjkybmtjZDU4S0twRkpVVUlmaDJqUXFr?=
 =?utf-8?B?M1ZlMWMrTDBpZ1orZEo4K0VXcGE1ODV0ZU5tSnpxR21rZVNEc0E0aC8vQXAw?=
 =?utf-8?B?YldYbUF2UWRBaVk5cE1OUnBYUDRVdCt2LzAzZmhYSmZoRng1QUsrbHNENVl6?=
 =?utf-8?B?R3BvZHpGeHRGa1QxQXEyVjA5VmhubTdpRkpGcFowVUFMV1FuY3YwOU93amhN?=
 =?utf-8?B?UjgzZ3B1VGRLeGtBYU9jcm5iQTNpT0hZN2pvQVQ5SnNyVlRiRzJGYUsvaS80?=
 =?utf-8?B?cmMrSi9oTmE5NU1lRGZZNVV6czg1a3Npc1hFTzF6cEZDOFVWdjZZQWI3VEpZ?=
 =?utf-8?B?R1ArNkZtd2c3MHYzaUE1a0V5UjUzYk5oZGlLRHFZUFdOZFdXdk9kUnNWUFRT?=
 =?utf-8?B?Uk5XUXVoTGNGWk5mMy9wdU5xaGVNSFFtZFlMTHdVVHpBTmZUbnE0dTFILzRG?=
 =?utf-8?B?ZCs1UlI0S1VtdDBuM08ydXRjU1hPdE0vcXBpMUdIaGN0VnlsYlUvWDlOVWF0?=
 =?utf-8?B?c2VwVXZWV0VpQktTUDlER1JLMG1mNUhHMUlET0lINWxxNkp1L2hvaVpySnlM?=
 =?utf-8?B?UWlvaTJVRVp2c2ppdGVvMThmSUlZeEZKK083NWVzSCtKcE8xeGtIZTB0akFZ?=
 =?utf-8?B?Znlyb0gxY0FQTFpzTVY4WnlEdzdDSnpGak1WVzB1MHJUeWZyS2tDWmovZllu?=
 =?utf-8?B?clN3US96M0xXSHpCeFRGNndGMTNFRStxSTlEVU1UNHhUVlMrKy8rd2NiV3dj?=
 =?utf-8?B?SjdqbUZuL1hhQXV0WnMySTYydGFCMjJRWGFWLy8rWUltd1ROUTRuZ25RMmZ6?=
 =?utf-8?B?dHY3YjVKajNSQWxRNC9MTUhpaDU5TDBsWk16c0ZzQU8rSTE4djEzdTlNb1dT?=
 =?utf-8?B?dDFTUDB6MVozWVh0ZXlUUnBTbHlnWm5DYTNNdXo3VkF6ZWM5bVFudnIzV0Nj?=
 =?utf-8?B?VmlxOGNldjdETDR4YW5sRW52OFBsSzkxbGU0bHBLYy9RL2ZRcGF3OUo0YmxE?=
 =?utf-8?B?T1N3NWVRbzlLSS9XMy9WcXV4Tzd5cTBrM2ZNTDcwd2ZuU2pMbUZqUkU0R1RB?=
 =?utf-8?B?c0V6dEo0ME8yRUsvdW02SnhnU1o2RnQ5R3owbmttOUR3MHNLWWt1aTFrTlZR?=
 =?utf-8?B?VHc0V3JsNU1WeFZQcmRxYmYrOGFycDFaR0xPam1vbHNoelRHWjhrVTJLWjNZ?=
 =?utf-8?B?VGVUREJka25LK3JKNnhMQURKcTFENzVIaytySGYrUjYrMWswUEhGMVQ2UE1i?=
 =?utf-8?B?STdHR0dyblBRZ04yaTlQQmFudXQ3Q3BtWEE1bmlrZy96SjdWU0F4aUxQN3Vn?=
 =?utf-8?Q?h3pyC0u1Qa/8zI/g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B99A8262CA69840AFEB0F725A928CCB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea7588e-bcb2-4744-2d49-08da185f91cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 06:26:37.2667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0AeZNVdxmuYzXNZSeYuWuBIDOHZKBNL4gxuuboNLpXfcEkyQDlNf2NvC4/o+UKhbjBtMxiDKKTvaAQWQWZtjdZ+G3CYR9Zv6lK7/otMI0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3071
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFR1ZG9yLA0KDQpPbiAwNi4wNC4yMDIyIDE2OjA1LCBUdWRvciBBbWJhcnVzIHdyb3RlOg0K
PiBUaGUgaW1wZWRhbmNlIG9mIHRoZSBRU1BJIFBDQiBsaW5lcyBvbiB0aGUgc2FtYTdnNWVrIGlz
IDUwIE9obXMuDQo+IEFsaWduIHRoZSBvdXRwdXQgaW1wZWRhbmNlIG9mIHRoZSBRU1BJMCBIU0lP
cyBieSBzZXR0aW5nIGEgbWVkaXVtIGRyaXZlDQo+IHN0cmVuZ3RoIHdoaWNoIGNvcnJlc3BvbmRz
IHRvIGFuIGltcGVkYW5jZSBvZiA1NiBPaG1zIHdoZW4gVkREIGlzIGluIHRoZQ0KPiAzLjBWIC0g
My42ViByYW5nZS4gVGhlIGhpZ2ggZHJpdmUgc3RyZW5ndGggc2V0dGluZyBjb3JyZXNwb25kcyB0
byBhbg0KPiBvdXRwdXQgaW1wZWRhbmNlIG9mIDQyIE9obXMgb24gdGhlIFFTUEkwIEhTSU9zLg0K
PiANCj4gU3VnZ2VzdGVkLWJ5OiBNaWhhaSBTYWluIDxtaWhhaS5zYWluQG1pY3JvY2hpcC5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlw
LmNvbT4NCg0KSXMgaXQgbmVjZXNzYXJ5IGEgZml4ZXMgdGFnIGhlcmU/DQoNClRoYW5rIHlvdSwN
CkNsYXVkaXUgQmV6bmVhDQoNCj4gLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE3
ZzVlay5kdHMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE3
ZzVlay5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE3ZzVlay5kdHMNCj4gaW5kZXgg
MDg2ODVhMTBlZGExLi44Zjk2NDMxNzBiYTMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2F0OTEtc2FtYTdnNWVrLmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNh
bWE3ZzVlay5kdHMNCj4gQEAgLTY1NSw3ICs2NTUsNyBAQCBwaW5jdHJsX3FzcGk6IHFzcGkgew0K
PiAgCQkJIDxQSU5fUEIyMV9fUVNQSTBfSU5UPjsNCj4gIAkJYmlhcy1kaXNhYmxlOw0KPiAgCQlz
bGV3LXJhdGUgPSA8MD47DQo+IC0JCWF0bWVsLGRyaXZlLXN0cmVuZ3RoID0gPEFUTUVMX1BJT19E
UlZTVFJfSEk+Ow0KPiArCQlhdG1lbCxkcml2ZS1zdHJlbmd0aCA9IDxBVE1FTF9QSU9fRFJWU1RS
X01FPjsNCj4gIAl9Ow0KPiAgDQo+ICAJcGluY3RybF9zZG1tYzBfZGVmYXVsdDogc2RtbWMwX2Rl
ZmF1bHQgew0KDQo=
