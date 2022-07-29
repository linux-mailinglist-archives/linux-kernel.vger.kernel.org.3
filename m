Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53303584E86
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiG2KHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiG2KHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:07:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A753B81B01
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659089259; x=1690625259;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bBVPECZ9qZZpkUfubECclhiUqUK8sJyvgyOHPVpe0G4=;
  b=Vax377A1NuLAr0DF0RY7K/MIrCXzDgClGVZQP6LVz2CR9Ridws3aVePW
   F6nw7XNRft9cfVd2ui2boV8hA7RTvKB1VRp+9Cs1lifMacy8l/z/oBggI
   YplSWOSKFoKBAEdop9PEze92PIaZimKBZtWPOj5aSWC07LmEZrup0Q3GN
   BaSm5lZCyzHVqYPnMgugvjf2DSJ9xOqRjt/3nDTw5AmYbdxgDLdD7lLxg
   oDaMv+b4KQqqms1zn7hBcUxiB4pQTuCYPUcJGEn0lhVNzUWtAG5nky59S
   KW+ARAJ090FSIoE1EDkZZjL0Eu/ps+PFWJmPp45w2BPm4+xwB3c1Po6jU
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="170066031"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jul 2022 03:07:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 29 Jul 2022 03:07:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 29 Jul 2022 03:07:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/Y3CpQXMV51gjouWI/hMAe8dZmAtVU7r93ZgQnLNo5GMxKRiYxvef3Nj3RTADdEXxJSWmwZPbkgkllTbNFUC9NeM/25anTHYVM/H+c/f7J2zQryxdNF+eMrRt6p5uxqVCAZ7C7Ej+WBPL3K8jVxwsvwiS3CKsh4B21txspXAGVp/6FXvhuHbPD5WHAomwNFVssUvLrM36+jsY054+f4l2Yk/N9cYcJRRnETfuEUXHotGfzejuYtrTf/pxdIOD8y6oZttNDbbbrZdIIBL9lP85UFdma7pEWiaxIPLBDzJQ5uf2L3FPPdYcIMgme0x/DkX180tADBWFq+5ovOd2Wp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBVPECZ9qZZpkUfubECclhiUqUK8sJyvgyOHPVpe0G4=;
 b=AdjXRLAXBZCljNp3f7i+pqYSojfJh0xkz6vErN8ksCM0Ft8KVpv6MhGGnbNjEloSNJB+DTLuOIwYTtmYnIhaJcoGYC1MiNup+7X4ruRaenTJ8GbYTlPN/IO5EnhbJGYwtmi53RHRp17AtqzrkSNMQnBrAydPwT8Tm1GP9OepinNuuwMQOfgk348LAZVBDegyBgZ5DSSoj1lL4QXpJ7TI94+CuubdBLigKQBxrFx1e44Nf5MRnY0CVsDfl3lVgMghBZs5kParqanVj7nLY5kWNgLBY4DhAncrSqVLMrDcAlszeuspNqNQ6mBt+cCBiV9ZgiqJdZ26ZdqS5emJ5zIrTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBVPECZ9qZZpkUfubECclhiUqUK8sJyvgyOHPVpe0G4=;
 b=vsp7h2fW8Q+Ft56ygZBUknFgx3yfSQXYD4/wOC7wdf4JDkMXzYk3z8J2tzVt4UTjKeT6AnokjCcTfN4pu0GZ0fgi7MGv+GEOtfM0qjuQqTdE7AX23RvL2fcSIKPvjZ4DRzpyd05ceavYxk4FChTMrRARYfqEsyrfRhPRSCQIRyQ=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 PH7PR11MB6449.namprd11.prod.outlook.com (2603:10b6:510:1f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Fri, 29 Jul
 2022 10:07:32 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35%5]) with mapi id 15.20.5458.023; Fri, 29 Jul 2022
 10:07:32 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <ben.dooks@sifive.com>, <sudip.mukherjee@sifive.com>
CC:     <p.yadav@ti.com>, <michael@walle.cc>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <greentime.hu@sifive.com>,
        <jude.onyenegecha@sifive.com>, <william.salmon@sifive.com>,
        <adnan.chowdhury@sifive.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mtd: spi-nor: add support for Quad Page Program to
 no_sfdp_flags
Thread-Topic: [PATCH 2/3] mtd: spi-nor: add support for Quad Page Program to
 no_sfdp_flags
Thread-Index: AQHYmsgjen1JGDoDVkiRJKdzpaguzQ==
Date:   Fri, 29 Jul 2022 10:07:32 +0000
Message-ID: <0203590f-d97c-61ab-eb31-3500b6c96ebb@microchip.com>
References: <20220712163823.428126-1-sudip.mukherjee@sifive.com>
 <20220712163823.428126-3-sudip.mukherjee@sifive.com>
 <3a9877d0-3cc5-6452-764b-d07b38c72b00@microchip.com>
 <CAHyZL-fK-d+dPWG63dcFUz17uP-sG4bnSFVW_gt16snnOVTzpQ@mail.gmail.com>
 <CAHyZL-c9iSd8=CaQ00Nptea4cqp9f7oqS5VefT3vfcr2J3hmSQ@mail.gmail.com>
 <d5662307-200e-171d-58fd-8f26dc02c771@microchip.com>
 <bee82951-47c9-20bc-3cb2-3a52f67a4728@sifive.com>
In-Reply-To: <bee82951-47c9-20bc-3cb2-3a52f67a4728@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a416f3a1-615d-4aa1-9dba-08da714a26fa
x-ms-traffictypediagnostic: PH7PR11MB6449:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q978TgJ2V9cjpq5APXYf8v6jrcgPNVuhnuk9QYeF4Y+sYG4UsNpZRqlbuUz+6QIiUZOGKrSKeObrRDF8os7L/EWCpmOcgKnJ3xw8e72OfdKIExXY+RiDdJfRVqkrEvrrYkk5KEX6LfqK1GQj+cOa20/NE7G1+PGPyS2pg6aLz3ZmBqLQa4rt2eQ1VW+Cc1al62HV+SCLh4QH25UYKtDJ+goaU3IpEgP5LMSo32L3CckvSnzSZ4wQ9qtUjsNL4CxjUhfwBVVAiPg2x+WaBpiGxITa2T9Z5S8VnlAly108j/e2q1BVQ0YSCmhXdZyfkVxDOFeB8N5uXjZjRYKdf4ukMbefy23bhzgOmaqCjzpvyvESBSwCqy2Ayg/b7LBxRH2f9BsU/SXCgZIQjSHfSoKcjIrTLvorTpBGcwzi6Es0XAC/+WaN81qp6ehqDapzbwNQfF0Ct7OjTLWZnLIPkIt2DgpALMdjopasNzL9ZKL9dd+Pz2pe5Qmt+DT15KD/dJ96OSE6cXKV9tCrYDiK6Cd6MoAZ5On5kxsG0iDIoHfJDS9s7SWijUFvbxarz6lCXw9mCJmkzP4Wu2+FLVLjxp0zk9gH4p/41LZvSzp2V8ygrh3USjN8lwCl6TJ0xE9K+h94SYjKXhSF4MC8xlUhTwGbLZB1xbef/Xq2dpKQbWB1qeKrwMHBs/1BYG65EJEHCYTPMPZDWjy0KvWf0hXr87FX3BbGzvmokBDKkypqvIZ8pXqT3HKQmmM533E7d5ue/SBgFEvPAgI4ms7WMhSua4kkw5nXd5GTS/bWe4J492Qvv1ygpZjqqsf4yzeVtAeRMQVZsE6wBg8fXEsFZakdO0DGqBbQYI2eU9lhgx4Likk94uKmNTXkSNHoBNqCM9Jyzj/T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(136003)(376002)(396003)(366004)(186003)(6506007)(110136005)(54906003)(53546011)(2616005)(91956017)(2906002)(36756003)(86362001)(31686004)(6512007)(26005)(31696002)(41300700001)(38070700005)(122000001)(38100700002)(8676002)(64756008)(66446008)(66476007)(4326008)(66556008)(83380400001)(66946007)(316002)(5660300002)(7416002)(76116006)(966005)(8936002)(6486002)(478600001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cC9rQjA2VnY3dmtRVDJLZ3FsWVNCY0V5MHJNeUNINk5hcldKbmhkRHNiZDlM?=
 =?utf-8?B?NW1xOS9hdU1XU21pdmR5dDlTT3BYMHpBYVJ5dzZXa244Z0p2N01JMGI1YnFY?=
 =?utf-8?B?anEycEZQaEFDcE9TbHlXYmpqeTJScHBQU09hRGpONHpxZGllSkRJVG9sek5R?=
 =?utf-8?B?TUcxQVdPWFFrUjNSS0ZoVURqRk5CRytOUnJUNDM1VzdqL3BrdXlXWW1RTDIw?=
 =?utf-8?B?amZneEFxcWxIalo3ZWoyN3VNWThNQytpdlNjZEdOSG8zMHhRUHB0cnloQ2VH?=
 =?utf-8?B?bEJ5Q1VOQUJEN2FORVNML0gwZERoOVlQYW92QVRSVUJNSzZJOWxHRGMxM2NE?=
 =?utf-8?B?VmtMMFYxaXg3WEJuNzJZYzZWbzJaMXpkSm5PM0lWYXdqRTdhNm1nUFJoT0s5?=
 =?utf-8?B?eFE1UmxIajJsc3dWeDBxVnVGcWxMUjdkZFBkMkpyT1R1dVhoNzlnbytUYjJq?=
 =?utf-8?B?V1BQbGlQeXlBNm9RVmVlb2RmWWRkL3FrRThXa0d6ZEVoU1dWdG5rUkFaMVBV?=
 =?utf-8?B?VEJKbVVqc0xiSHVQOHJBY3ZaeFRpeUZUbm1LWlNqYVEwcXJMejRxNHFORHJr?=
 =?utf-8?B?c3Rrdmk4M0NJV1MrU0ZUVzJrNW1NaWNmS214MXR5aXU3SEJaQ2xUc3BSRjQw?=
 =?utf-8?B?N0V4UVRWbENldjFtYmhGNlUvZzZFRFprQVhTOEFGd3ZSU2pza2xScFhxbFNt?=
 =?utf-8?B?eHN4OFAwWFA0T1ZHc1hjdnpUS1dmV1cxYkFJRDV5UFJrWjlHaGZnSWhoZnFp?=
 =?utf-8?B?WDZFZE10alMvOUNCTzU4RnZBM2xSOGdtaUo2dnZpZGd6Ly9uNG04Y1B0ZFZB?=
 =?utf-8?B?WWtVemkzWGl0c1cwbm9YQVZBbkV5eTFvc0pVZXB4bSt2dzZ3NU8wSmtnM2Jv?=
 =?utf-8?B?OFlXTVo2b3owclpBdFZmWTVsZWsrMklkdXU5d3FoWmhFL0NuMjhvaVpZWjV0?=
 =?utf-8?B?cXhjUmpYaUJQTEpsUlNxckhpR29qcUtreURDYU5YaHI4MjFtK1J6TVJ1a0xZ?=
 =?utf-8?B?K01JbUZJUWIyTncveThkR0NLVUlDaWVyNGlYY1dDaC8vMERwVy9NNTcwRXBW?=
 =?utf-8?B?Q3hDMjZpWkpvM0MzcHJQOE5zMzd3SmE2cy8ybU9oQ1dEUzhIa2VKOWNtQ2FJ?=
 =?utf-8?B?Zkp3R3JHU1YyVFNmNEZtRGp3ODBGTHVyaE1EdWkrQlc2MGZsRU94TnhWdFRJ?=
 =?utf-8?B?NktVUTVUMHJNQUhhbmltZ2VsejFnNUg5YWNvVzU3K1E5MmV3bGE0S0Q5TkQz?=
 =?utf-8?B?TmpIM2txd0lEd2pHaDJJVkZMcjJpREN0eXRReVAzQ25ZNnZydVpvd3cxVzE5?=
 =?utf-8?B?SjB4OU9veWo2bHh1b25CdEpBb0ZBSlpqVVNUVTdISFByL2V6Y3J3QWIxK0tV?=
 =?utf-8?B?R0FYUVdmWks2KzROMW5nYnJyWk1ibkc2KzFqTHhnN0V3VExkNmVlWE9GeXdz?=
 =?utf-8?B?elVpam5qN2pYNlUxdjAyZzExVElIZi9NUk1nUTVicG1mU3BRdlUyV0hUbUUv?=
 =?utf-8?B?WWg4SnVMdmErTWlOQnBDN0tBaG5iS1AxUFJGQzVHL1ZrbkZUTW00bVBFMEMw?=
 =?utf-8?B?VUFoMHIyT1RkMjNlUXdaVERjSWd4bXVFRnNURlM0TzRwVU51V1U0bXNQc3RE?=
 =?utf-8?B?WGtkY09xT3lPcGdYS0QyQS9QSE1yRjgzYUNMSXhWSlFZOFNBL1FpMW5JZVJi?=
 =?utf-8?B?aEpxWll1ZDJnay92amN6c3dnRVpGN2ZwOTZNU0puOUdNcm5pT0hyTUloL3Qz?=
 =?utf-8?B?cElOcU9aTkYvYW9HWER2TUhoTnpCbmUwMTlFQXZpYWEyWkt1aHRuL3Fsb2dr?=
 =?utf-8?B?NUVkbVR2TS8za0VaUEJmcUplbUlra205YlFCWXk5U1lKRTJpZGovcVV3NDdn?=
 =?utf-8?B?VG1GTjg4ck4wcWZrWTExUExHL2hDT3JPc0YwRU0zd0RWajc4Vy81TFpEVVlv?=
 =?utf-8?B?bXBYVkYxTW9uTEZKbFhXNzJKQkhqN3lUK2M5ZHExVFhHZUhueHVpa3ZoSTdz?=
 =?utf-8?B?NHhXVGs2MWZXU1hUNithZ25HZm9yTkVodlp2aXJXdlR4N1NJK2FYMC9EdFFZ?=
 =?utf-8?B?WnozZUhzdUd4V0czVGpTZjZMNjBEUVlxUzhuSmZYRlFnMGx2bWlTcVQ0SzdN?=
 =?utf-8?B?ckFEZURwNHdEM2NZd0RMbDY4b0g4bkdDcm5qbWNJUUdSMmp3RlZMUDlvbFlR?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <593D972AEE15714C9A7D568875116A49@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a416f3a1-615d-4aa1-9dba-08da714a26fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 10:07:32.1355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mlu4Q/Z+5wBrfPgHrN8EWuhPfjt0mhXQagvAumQnRr2CuqPmmt1XMaTL8rWJqSrEMyu2ZEgTX9Usjomaq0Z9wSVrbWNQCl5EW29DTG5mKYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6449
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yOS8yMiAxMToxMCwgQmVuIERvb2tzIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDI5LzA3LzIwMjIgMDg6NDgsIFR1ZG9yLkFtYmFydXNA
bWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDcvMjIvMjIgMTM6MjQsIFN1ZGlwIE11a2hlcmpl
ZSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+
IEhpIFR1ZG9yLA0KPj4+DQo+Pg0KPj4gSGkhDQo+Pg0KPj4+IE9uIE1vbiwgSnVsIDE4LCAyMDIy
IGF0IDc6NDkgUE0gU3VkaXAgTXVraGVyamVlDQo+Pj4gPHN1ZGlwLm11a2hlcmplZUBzaWZpdmUu
Y29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4gT24gTW9uLCBKdWwgMTgsIDIwMjIgYXQgNjowMiBQTSA8
VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4+Pj4+DQo+Pj4+PiBPbiA3LzEy
LzIyIDE5OjM4LCBTdWRpcCBNdWtoZXJqZWUgd3JvdGU6DQo+Pj4+Pj4gW1lvdSBkb24ndCBvZnRl
biBnZXQgZW1haWwgZnJvbSBzdWRpcC5tdWtoZXJqZWVAc2lmaXZlLmNvbS4gTGVhcm4gd2h5IHRo
aXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlm
aWNhdGlvbiBdDQo+Pj4+Pj4NCj4+Pj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNh
ZmUNCj4+Pj4+Pg0KPj4+Pj4+IFNvbWUgZmxhc2ggY2hpcHMgd2hpY2ggZG9lcyBub3QgaGF2ZSBh
IFNGRFAgdGFibGUgY2FuIHN1cHBvcnQgUXVhZA0KPj4+Pj4+IElucHV0IFBhZ2UgUHJvZ3JhbS4g
RW5hYmxlIGl0IGluIGh3Y2FwcyBpZiBkZWZpbmVkLg0KPj4+Pj4+DQo+Pj4+DQo+Pj4+IDxzbmlw
Pg0KPj4+Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCBi
L2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+Pj4+Pj4gaW5kZXggNThmYmVkYzk0MDgwZi4u
ZGRlNjM2YmRiMWE3YyAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2Nv
cmUuaA0KPj4+Pj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+Pj4+Pj4gQEAg
LTQ2Miw2ICs0NjIsNyBAQCBzdHJ1Y3Qgc3BpX25vcl9maXh1cHMgew0KPj4+Pj4+IMKgwqAgKsKg
wqAgU1BJX05PUl9PQ1RBTF9SRUFEOsKgwqDCoMKgwqAgZmxhc2ggc3VwcG9ydHMgT2N0YWwgUmVh
ZC4NCj4+Pj4+PiDCoMKgICrCoMKgIFNQSV9OT1JfT0NUQUxfRFRSX1JFQUQ6wqAgZmxhc2ggc3Vw
cG9ydHMgb2N0YWwgRFRSIFJlYWQuDQo+Pj4+Pj4gwqDCoCAqwqDCoCBTUElfTk9SX09DVEFMX0RU
Ul9QUDrCoMKgwqAgZmxhc2ggc3VwcG9ydHMgT2N0YWwgRFRSIFBhZ2UgUHJvZ3JhbS4NCj4+Pj4+
PiArICrCoMKgIFNQSV9OT1JfUVVBRF9QUDrCoMKgwqDCoMKgwqDCoMKgIGZsYXNoIHN1cHBvcnRz
IFF1YWQgSW5wdXQgUGFnZSBQcm9ncmFtLg0KPj4+Pj4NCj4+Pj4+IFlvdSBkb24ndCBuZWVkIHRo
aXMgZmxhZyBpZiB5b3VyIGZsYXNoIHN1cHBvcnRzIHRoZSA0LWJ5dGUgQWRkcmVzcw0KPj4+Pj4g
SW5zdHJ1Y3Rpb24gVGFibGUuIERvZXMgeW91IGZsYXNoIHN1cHBvcnQgaXQ/IENhbiB5b3UgZHVt
cCBhbGwgdGhlDQo+Pj4+PiBTRkRQIHRhYmxlcywgcGxlYXNlPw0KPj4+Pg0KPj4+PiBOb3Qgc3Vy
ZSB3aGF0IHRoZSBjb3JyZWN0IHdheSB0byBkdW1wIHNmZHAgaXMuIEkgZGlkIHRoaXMgZnJvbSBz
eXNmcy4NCj4+Pg0KPj4+IEkgdHJpZWQgZGVjb2RpbmcgdGhpcyBTRkRQIHRhYmxlIGFuZCBJIHRo
aW5rIHRoZSBwYXJhbWV0ZXJzIHRhYmxlIHNheXMNCj4+PiBpdCBoYXMgIjMtQnl0ZSBvbmx5IGFk
ZHJlc3NpbmciLg0KPj4+IFNvLCBJIGd1ZXNzIHRoYXQgbWVhbnMgaXQgZG9lcyBub3Qgc3VwcG9y
dCA0LWJ5dGUgQWRkcmVzcyBJbnN0cnVjdGlvbg0KPj4+IFRhYmxlLiBBbmQgdGhlIGRhdGFzaGVl
dA0KPj4+IHNheXMgaXQgc3VwcG9ydHMgIlF1YWQgSW5wdXQgUGFnZSBQcm9ncmFtICgzLWJ5dGUg
QWRkcmVzcykiLg0KPj4+IE15IGV4aXN0aW5nIHBhdGNoc2V0IHdvcmtzIGZvciBRdWFkIElucHV0
IFBhZ2UgUHJvZ3JhbSwgYW5kIEkgY2FuIHNlbmQNCj4+PiBhIHYyIHdpdGggdGhlIHByZXZpb3Vz
DQo+Pj4gcGF0Y2ggYW5kIHRoaXMgbWVyZ2VkIHRvZ2V0aGVyIChhcyB5b3Ugc3VnZ2VzdGVkKSBv
ciBJIGNhbiB0cnkNCj4+PiBlbmFibGluZyBzZmRwIGZvciB0aGlzIGNoaXAgYW5kIHRoZW4gdXNl
DQo+Pg0KPj4gWW91IHNob3VsZCBkZWZpbml0ZWx5IGVuYWJsZSBTRkRQIGFuZCBnZXQgcmlkIG9m
IHRoZSBOT19TRkRQX0ZMQUdTIGZsYWdzLA0KPj4gcmVnYXJkbGVzcyBvZiB0aGUgMS0xLTQgUFAg
b3V0Y29tZS4NCj4+DQo+Pj4gYSBmaXh1cF9mbGFncyB0byBlbmFibGUgIlF1YWQgSW5wdXQgUGFn
ZSBQcm9ncmFtIiB3aGljaCBJIHRoaW5rIHdpbGwNCj4+PiBiZSBtb3JlIGNvbXBsaWNhdGVkLg0K
Pj4+IFdoaWNoIG9uZSB3aWxsIHlvdSBzdWdnZXN0Pw0KPj4+DQo+Pg0KPj4gRmlyc3QgSSdkIGxp
a2UgdG8gdW5kZXJzdGFuZCB3aGF0ICJtdWNoIGJldHRlciBwZXJmb3JtYW5jZSIgbWVhbnMuIFdv
dWxkDQo+PiB5b3UgcnVuIHNvbWUgc3BlZWQgdGVzdHMgcGxlYXNlPyBtdGQtdXRpbHMgc2hvdWxk
IGhhdmUgYSBzcGVlZHRlc3QsIG90aGVyd2lzZQ0KPj4geW91IGNhbiB1c2UgdGhlIGluIGtlcm5l
bCBtdGRfc3BlZWR0ZXN0IG1vZHVsZS4gUGFnZSBwcm9ncmFtcyBhcmUgc2xvdyBhbnl3YXksDQo+
PiB1c2luZyA0IGxpbmVzIG1heSBub3QgbWFrZSBhbnkgZGlmZmVyZW5jZS4gQnV0IGxldCdzIHNl
ZS4NCj4+DQo+PiBBYm91dCB5b3VyIHF1ZXN0aW9uLCBpdCBkZXBlbmRzIG9uIGhvdyBjb21tb24g
aXMgMS0xLTQgcHAuIElmIGl0J3MgY29tbW9uIGFuZA0KPj4gZGVzaXJhYmxlIHdlIGNhbiBpbnRy
b2R1Y2UgYSBmbGFzaCBpbmZvIGZsYWcuDQo+IA0KPiBXZSBoYXZlIGFuIGlzc3VlIHdpdGggdGhl
IFNQSSBjb250cm9sbGVyIHdoZXJlIGlmIGl0IGlzbid0IGluIHRoZSBhYm92ZQ0KPiAxIGJpdCBt
b2RlcyBpdCBoYXMgdG8gYmxvY2sgdGhlIENQVSBhcyB0aGUgZmVhdHVyZSB0byBob2xkIHRoZSBj
bG9jayBpcw0KPiBub3QgZW5hYmxlZCBpbiB0aGUgMWJpdCAib2xkIiBtb2Rlcy4gSW4gdGhlIG9s
ZCBtb2RlcywgaWYgdGhlIEZJRk8gZ2V0cw0KPiB0byB0aGUgZW1wdHkgc3RhZ2UgdGhlbiB0aGUg
Q1MgZ2V0cyBkZS1zZWxlY3RlZC4gSWYgd2UgY2FuIGVuYWJsZSB0aGUNCj4gNGJpdCBtb2RlLCB3
ZSBjYW4gYWxzbyBzZXQgdGhlIGNsb2NrLXN1c3BlbmQgZmxhZyB3aGljaCBtZWFucyB0aGUgY29k
ZQ0KPiBkb2VzIG5vdCBoYXZlIHRvIGJsb2NrIHRoZSBjb3JlIGl0IGlzIHJ1bm5pbmcgb24gdG8g
ZW5zdXJlIGl0IGdldHMgdGhlDQo+IGRhdGEgb3V0IGluIHRpbWUuDQoNCkknbSBub3Qgc3VyZSBJ
IHVuZGVyc3Rvb2QgeW91ciBTUEkgY29udHJvbGxlciBsaW1pdGF0aW9uLCBidXQgc2hvdWxkbid0
DQptYXR0ZXIgZnJvbSBhIGZsYXNoIHBvaW50IG9mIHZpZXcgYW55d2F5Lg0KPiANCj4gQXQgdGhl
IG1vbWVudCBzcGVlZCB0ZXN0cyBhcmUgbm90IGVhc3kgYXMgd2UgYXJlIG9uIGVudGlyZWx5IGVt
dWxhdGVkDQo+IGhhcmR3YXJlLCB3ZSBjb3VsZCB0cnkgc29tZSBidXQgdGhlIHJlc3VsdHMgbWF5
IG5vdCByZXByZXNlbnQgd2hhdCB0aGUNCj4gcmVhbCBjaGlwIGNhbiBwZXJmb3JtLg0KDQpPaywg
dGhlbiBpZ25vcmUgdGhlIHNwZWVkIHRlc3Qgc3VnZ2VzdGlvbi4gSSd2ZSBzaHVmZmxlZCBmZXcg
dmVuZG9yIGRhdGFzaGVldHMNCmFuZCBtaWNyb24gc2VlbXMgdG8gdXNlIDEtMS00IFBQIHRvby4N
Cg0KU28gSSBzdWdnZXN0IHRvIGFkZCBTUElfTk9SX1FVQURfUFAgdW5kZXIgbm9yLT5pbmZvLT5m
bGFncyBiZWNhdXNlIDEtMS00IFBQDQppcyBub3QgU0ZEUCBkaXNjb3ZlcmFibGUuIFNQSU5PUl9P
UF9QUF8xXzFfNF80QiBpcyBhbmQgY2FuIGJlIHJldHJpZXZlZCBmcm9tDQpTRkRQIGJ5IHBhcnNp
bmcgNEJBSVQuDQpBbmQgcGxlYXNlIGdldCByaWQgb2YgdGhlIG5vLXNmZHAtZmxhZ3MgZnJvbSB0
aGUgZmxhc2ggZGVmaW5pdGlvbiBhbmQgdXNlDQppbnN0ZWFkIFBBUlNFX1NGRFAuDQoNCi0tIA0K
Q2hlZXJzLA0KdGENCg==
