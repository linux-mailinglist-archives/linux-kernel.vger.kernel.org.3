Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E861592EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiHOMFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiHOMFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:05:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF821DB;
        Mon, 15 Aug 2022 05:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660565114; x=1692101114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9Mr+wEAV7hXjVO28XCzBfK6dSh5nvwRd3j2e9CxG1aU=;
  b=gcqIfSxDchXMCvOfpfT8wZiVEvZBk7WWAEl849ZSbd/HQJcYr6BHNJ4q
   xh4FVMW+H81cOSnZGc7TqPTRGNV1gGyEzDMbHSdsYfpxve9V7cAkp42ZS
   Q5MyHN+D0d5HC1B1P6wUbWvNmBi/w01TmYbgtwhp4cZk6tj6Ai+0szYJO
   y1b+uO9qjoLZ0Z1JB7eHbRRi0n6iadvowa4ASAVXkZuFFHz7FjhjbEa5K
   yfm5ccOpc21fHykG+8shmIymZCY7yjAAFSVqnCVWjBdLjA/7jZZSQiH/r
   S27KhK28Cs7xshdFol68nRXV2H+aLkjoIJtMdgyghbNrDEkKsYSYdLZF5
   w==;
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="109045410"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2022 05:05:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 15 Aug 2022 05:05:06 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 15 Aug 2022 05:05:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeoHJXH3vRUJJiDjHq3ENhQ2MDUDQJwuD32u91649vOBgR8bA4RlnqEVWLboVynHCDCjWsV4c9J92CBmj/GoQbqi/w05PnVB2it7nn1LJ00nMmz4L1U1Nba8UkvCbkD1mwc1OICnSsenWOd71cSGAphPjLlGqc7DuJqfv1zCgQHnkGqg/P/l4oWnUUH5svIleW67G4ySdX+WiuiTYW5DqgSLwRU/1sbXNapesceektkRVm2/tehqKZ1dFZlaGvfKiLvrFSN3SEz5aFbQKn0EcirjNKM15KvE66hwhLJoJVQ0thsKbAxd/Q2vQGcLSWycThLHFe4SprT/OhD155ni5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Mr+wEAV7hXjVO28XCzBfK6dSh5nvwRd3j2e9CxG1aU=;
 b=fsFuijenv2Dn2Ni789d6lzcXs0WjS5ng1BdHCL85OEMPR/ftpXlzUjt0bXTFLQo3/l3E4N8E5tF1wdpN1w+WdkWq9XkyF0Pe70ZLv5Mhsefy3S/IaD1ZoSYMSCH7uRcqcOsXXLTD9oghNiPLO6+mUWVvzAP9VvfOCsaqoVWLU0VMeukUpuOhuz0ONAJo7e5C9SAaEEVwmItBwOaLMQT0FJEg3wAy4fJvM/CrMdHxYLNaBKcaGrtNMv4Kq6VRyCUKUDniXEnYWHsGPSHtTzSXzQYrCGxmEc6dfqgU3WiMErohuoFg3UoPfFmMHVZgyjDL7P45NWEYvGWCCp83RtoSAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Mr+wEAV7hXjVO28XCzBfK6dSh5nvwRd3j2e9CxG1aU=;
 b=ZFvym8VhE6+ZT/tMCivDlJWG2zXDyGCYkRGrSAYGiWsjmMCrgM2yHz5YlrhIJAai8NjPmPG1t4eTIrrPjyklQJ+63vQSZVz5Gj1JdlACInNLhbZiPFJDOlLwpedjjXE8RsL7Yy/XrF3eAmslFaiS5geodKdiLEhImA7bqq/xsrU=
Received: from PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10)
 by DM6PR11MB2809.namprd11.prod.outlook.com (2603:10b6:5:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 12:04:58 +0000
Received: from PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::d9b3:8e55:269c:b122]) by PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::d9b3:8e55:269c:b122%6]) with mapi id 15.20.5504.021; Mon, 15 Aug 2022
 12:04:58 +0000
From:   <Lewis.Hanly@microchip.com>
To:     <linux-riscv@lists.infradead.org>, <christophe.jaillet@wanadoo.fr>,
        <brgl@bgdev.pl>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <palmer@dabbelt.com>
CC:     <Conor.Dooley@microchip.com>, <Daire.McNamara@microchip.com>
Subject: Re: [PATCH v5 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Topic: [PATCH v5 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Index: AQHYsHWR/8SoMA+OEEG87REI8d8DDq2vkwWAgABKiYA=
Date:   Mon, 15 Aug 2022 12:04:58 +0000
Message-ID: <22cfe2a9dc4e4a9f2ddf34474c685a5fb87313e7.camel@microchip.com>
References: <20220815070606.1298421-1-lewis.hanly@microchip.com>
         <20220815070606.1298421-2-lewis.hanly@microchip.com>
         <271c00a5-fb5d-ff9e-3c4d-ec2732b991ba@wanadoo.fr>
In-Reply-To: <271c00a5-fb5d-ff9e-3c4d-ec2732b991ba@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11cb051b-c9d8-4636-3d45-08da7eb65fd0
x-ms-traffictypediagnostic: DM6PR11MB2809:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vCBODYcg2XB076EQUsW4zQCnh3yHjrV2kteyqr9zxdVZuPOa6Fn0BH4ANT94y/Qqx6TxOSW+POAcvT96SzujnIlbdhbrXOGu4wnF6yxCPJaoHrJTaDPGQ3mqtIKyPoJK5jF/GTVte446rQkH5mTTIMtD6RPi7t4H8YYS04CJ8Y5iJHmljv1XAqf0iUa/QsL5oSKkzPwRacuicQxs3pMX5+6pr5juf3cBXpFaGvWRtPEDE209SdWqfSv3piYah12xyCqfx3FRPsimzJ1fs1XnuX9YZjdG69U3lEb0aoE/yvJoRZ6pFqDCmcAkdLNTATp8cbBArNiE0xuFwhbhg1Zwk2UI1dBHFyk71Ftp3SPF0+Iz+lEKld6XFoFZjiQhwBrlvk/VLBXGFIvi/RUWomSu5jtpVndIN/HsqOWtEo3M/30cdcDcic3u365bVDCBQdXFEUHR2f+HpfCY3rCw3chsAMCBTgtM+e2B8ZKzwKB44zauH9kRaO65BCChA6JPFhGdMOycOFDOMDXdlVB2Ssz1uZtXgdy5t8/qLrg9S9Md4qrX+k08dpL5caP+NNHpkkef6P29Q1YRa0vCBus88nSAd9S3suzpWG61dQ8nKpNY+j5E8WLQo5GrvErLpYG3TS3UXLPkiyPKKNrFvqRs9W3gz9jO3urJCDMCRU2V/mKEYoVN3w3L4IcPrOAkQMuAXDOlQoswm06QEyS7XY6PTPXkKb5lfsVYCvo5Ojq3qyvH55L/Za7RRpHd+ZEl69pQ9n7gpZS5oXqbb+9jWiBf6cgQ9UtFQKnNqAWSqhaW/vW/88bUh0Qn+dxztRYNVu5JOhYA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(396003)(376002)(39860400002)(366004)(91956017)(71200400001)(41300700001)(316002)(54906003)(478600001)(6486002)(26005)(38100700002)(4326008)(110136005)(64756008)(66946007)(8676002)(8936002)(66446008)(66556008)(66476007)(76116006)(5660300002)(2906002)(36756003)(38070700005)(107886003)(122000001)(186003)(86362001)(6506007)(2616005)(83380400001)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1RoaVhqV28ySnRyT2czR1FUQzg4bHFGU3NYK1hSRGlxVjVQNGVtRVFGTkd5?=
 =?utf-8?B?Y3B3YnFZcUdycnFMNkNZMys4TjUxSW04dHlFVitrVkJsaE9qTDFJNTZtb0My?=
 =?utf-8?B?Z2VTcjI2cEZHMUdQTzlLS214TUs4Z1gzTHR5VDBiRTZxSXlNbzlxRVpVMmJS?=
 =?utf-8?B?dnd1Wm1CMGtYZUpOTHJKVWowUFJvbHFrTFRrRnBQN1VXK2ovWHZua0RiNitm?=
 =?utf-8?B?N01ScVBIdWZzR1JaOSttMmkremlYR2xDdmdBZkNSTzhiM0J1dyt3aWRkUmU2?=
 =?utf-8?B?ZXBjTnNGaEFvdHpHTFZMa0d3UFlmRXdlcm1RQis2U3N0OG8zUlVWYXVGT2di?=
 =?utf-8?B?UDgveFQ1SGs3aExSRGNaOEMzZXd0U2hPMFZiN2w0aXBTMHNTRGJkcEVwVVlO?=
 =?utf-8?B?ZzI0Rmk5UWZYRHExM2lTS1BTMmw3b0FSOUorK0VwbDlscFh2RXRHc09xR1dG?=
 =?utf-8?B?TnZaQXBMN2h6cWVWVnVpdlVnWVoxQWRobFNxWWZZT091TngvZ1lacmJnNXNl?=
 =?utf-8?B?Zms1YWNqY2RVTWJSSWplYTVlWmdtc2kyYXNSYUdKa3JTY1Z5UVg0TFhTRlV6?=
 =?utf-8?B?WVozVjgzYlBaMUx4R09aSTg1Y3NuMkNFb0laVy9ZWU5qYUtiVmRLY1NiK29y?=
 =?utf-8?B?NHQ1R3liN1hGdWZPUmJMM3lDUzBwbVZhcVBZY2tLZ21LOW5CWWNqT21ZNVIv?=
 =?utf-8?B?eEVpU0ZPSkh3OHgweGNsdFV6cDhBK0J3eTFVVi9KN1J6UFRtK25aTmE1RExM?=
 =?utf-8?B?RTVWdFBCdDVuVGVoOHJWdWJlYmJTM1RlTEpncU4yWVZBcEN4OVVoT2lhU1gy?=
 =?utf-8?B?U09kamxFUVBpRXRYemFoakwxQzcxOEUvUHNYME1DL0o4RUdhK0pSanEyM1R5?=
 =?utf-8?B?TjBadGEzVFlIeDMrdlFvNkJDWGZkbGdpakNpb3V1V2xhK09OMHlOYVpzKzFX?=
 =?utf-8?B?ZmZKcXhVMnZNNmR6MUNYVng2ZjRsSDNuaWxFK0tDeWJsUk5TK0FJaHdPVmFi?=
 =?utf-8?B?NnlGQUxLbGl2dHQ2eHRheUY3ZFF3cjkrOGNxeU9TVEFFcTNkS3J0Mk5xWWtZ?=
 =?utf-8?B?SENEUkhCNjl1TFJ3ZWFCL0VUbTFHU3V4MG1vUmVpZHRFVW9YOFd1QTNWZTI5?=
 =?utf-8?B?R2NScUNsSFM0NjdDeFRqZnpyWU5BRVlXcXh0RHpnWUhYTkZoWkx1eWRQbk13?=
 =?utf-8?B?T0FYSTVjL3NoU3NSOUxOeTFsN2tOTWRUY1dxVnNoenZnNVcvY2RMYTdBYjYv?=
 =?utf-8?B?cVd6TXFscnEwK0ErdlpUcTAxUitVSWJORGZ2OWZHWkVJdlZUYXc3WWlaYUI2?=
 =?utf-8?B?TmV1Nk9aUWJaMFVjMXBxNVZnckpSeFQvWUdQc0s0bWliL0FMS1laUU1NU1p6?=
 =?utf-8?B?Z0E5UHpOMHdFR1pSTUluOE1sWGI4SlQxVWEzNi9yV04xckw0U1h3TUNHV0x3?=
 =?utf-8?B?eGlDZ2xocEZwZ3RTekFmWHI5LzJNc0pJN2FremVxV3BldnZha09ZMm5MV1RV?=
 =?utf-8?B?azVUQkYzZ0krOUFuREZSVEZmQXJqUGlHa09hL2psZW9JbGQ2dnJ0THZLM0FX?=
 =?utf-8?B?SFV2bHBjM0F4OFQ1NkVXTGRsU2tZcmNubzV1Q0JEaU9YY1NKZ2sxZlZBY3E1?=
 =?utf-8?B?dlpvRUxZWkZlTGVGVnIrZzdpVU4xNExQdC9XRkMxd2xHUy9Yd0JCVkJTRnVh?=
 =?utf-8?B?bmliSGovMmtQU05YUHhWendEUDFnUGhTQmNSWFJaVkZXSUFlVmxxeXlsU3pp?=
 =?utf-8?B?SDVxRFBqRmZLbDZMbDVXbjJpY1poVzJTNE8wMjFFR1V3ZFY3a0dMOFBOMFlZ?=
 =?utf-8?B?SmtBM2hwRkFuOTV4Q09NUmJmUHRoYnJsWE55dzdpUEtVRFk2MGw3Z0p1a2xQ?=
 =?utf-8?B?eUZIYUJsRllKOWxFcm9tRkpTd2VjMlY3clFoQ09UR1J4K3c5RlFmNmxKSkcx?=
 =?utf-8?B?MkFYN0Y3NU5BWHY5ZWtuWDZkYUxUdWNVWEh4Zm1kOStVWUR4MmhIb0JHZVVY?=
 =?utf-8?B?NDVURVB4dGplQ09KckFjaXFnT3NlTTRleWpGelJ0NzdVcTU0a2xFNElScXhi?=
 =?utf-8?B?dlFWZ1cvc3BmcmxaRE9FZ1laQjhiNVR5SmQzTGJMWDA3QXdRL1hYSzdDanNz?=
 =?utf-8?B?RXpDaHVGak5GR0p0Y3gvR1RWaU9lYjFEZ1laWEJ3S0RmMVB2Z3pIVHNlYSt2?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D80A4C88DE101C478ACA5503CE0E5760@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cb051b-c9d8-4636-3d45-08da7eb65fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 12:04:58.2351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wYCOJPAh/f7wue9U91azl349NOcO4bpa3Ozep20VcTb4ejWxyu1gvJfAOcIUYqvcVQ1pkho05Iw9d0bGabkdNJu24yH4wJ42v494QWFcXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2809
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTE1IGF0IDA5OjM4ICswMjAwLCBDaHJpc3RvcGhlIEpBSUxMRVQgd3Jv
dGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gTGUgMTUv
MDgvMjAyMiDDoCAwOTowNiwgbGV3aXMuaGFubHlAbWljcm9jaGlwLmNvbSBhIMOpY3JpdCA6DQo+
ID4gRnJvbTogTGV3aXMgSGFubHkgPGxld2lzLmhhbmx5QG1pY3JvY2hpcC5jb20+DQo+ID4gDQo+
ID4gQWRkIGEgZHJpdmVyIHRvIHN1cHBvcnQgdGhlIFBvbGFyZmlyZSBTb0MgZ3BpbyBjb250cm9s
bGVyDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTGV3aXMgSGFubHkgPGxld2lzLmhhbmx5QG1p
Y3JvY2hpcC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwaW8vS2NvbmZpZyAgICAgfCAg
IDcgKw0KPiA+ICAgZHJpdmVycy9ncGlvL01ha2VmaWxlICAgIHwgICAxICsNCj4gPiAgIGRyaXZl
cnMvZ3Bpby9ncGlvLW1wZnMuYyB8IDMxOA0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzMjYgaW5zZXJ0aW9ucygrKQ0K
PiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3Bpby9ncGlvLW1wZnMuYw0KPiA+IA0K
PiA+ICtzdGF0aWMgaW50IG1wZnNfZ3Bpb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiA+ICt7DQo+ID4gKyAgICAgc3RydWN0IGNsayAqY2xrOw0KPiA+ICsgICAgIHN0cnVj
dCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKyAgICAgc3RydWN0IGRldmljZV9ub2Rl
ICpub2RlID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+ID4gKyAgICAgc3RydWN0IG1wZnNfZ3Bpb19j
aGlwICptcGZzX2dwaW87DQo+ID4gKyAgICAgc3RydWN0IGdwaW9faXJxX2NoaXAgKmdpcnE7DQo+
ID4gKyAgICAgaW50IGksIHJldCwgbmdwaW9zLCBuaXJxczsNCj4gPiArDQo+ID4gKyAgICAgbXBm
c19ncGlvID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCptcGZzX2dwaW8pLA0KPiA+IEdGUF9L
RVJORUwpOw0KPiA+ICsgICAgIGlmICghbXBmc19ncGlvKQ0KPiA+ICsgICAgICAgICAgICAgcmV0
dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsgICAgIG1wZnNfZ3Bpby0+YmFzZSA9IGRldm1fcGxh
dGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gPiArICAgICBpZiAoSVNfRVJSKG1w
ZnNfZ3Bpby0+YmFzZSkpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShk
ZXYsIFBUUl9FUlIobXBmc19ncGlvLT5jbGspLA0KPiA+ICJpbnB1dCBjbG9jayBub3QgZm91bmQu
XG4iKTsNCj4gDQo+IFBUUl9FUlIobXBmc19ncGlvLT5iYXNlKT8NCj4gImlucHV0IGNsb2NrIG5v
dCBmb3VuZCIgYWxzbyBsb29rcyBvZGQgYWZ0ZXIgYQ0KPiBkZXZtX3BsYXRmb3JtX2lvcmVtYXBf
cmVzb3VyY2UoKSBjYWxsLg0KWWVzLCB0aGFuayB5b3UsIGhhdmUgZml4ZWQgaW4gYSB2NiB3aGlj
aCBpcyBvbiB3YXkuDQo+IA0KPiA+ICsNCj4gPiArICAgICBjbGsgPSBkZXZtX2Nsa19nZXQoZGV2
LCBOVUxMKTsNCj4gPiArICAgICBpZiAoSVNfRVJSKGNsaykpDQo+ID4gKyAgICAgICAgICAgICBy
ZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoY2xrKSwgImRldm1fY2xrX2dldA0KPiA+
IGZhaWxlZFxuIik7DQo+ID4gKw0K
