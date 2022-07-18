Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7260C5787CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiGRQuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiGRQub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:50:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4402B19C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658163029; x=1689699029;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BYbetZCZmhIpPO479eS5Y16zAWPaBP7Hb0nV7/+8YTY=;
  b=axTISIrQuqJ9LyjOI4oZIeNutEW6uEAtIsJ5KIcYgNlOxd9NcWKoswYj
   2ogMutWg5c2oY37adoENC14+3VDlip4fIIzJz15JQ7y55U0TFEAz5giU3
   yN5q/TYmQwfYt/Di2d4MHN2KM31ZRztdCTKPR8sNte6ad2ONgbOkaLKSb
   v9pfxiJynQemJlNa6DdkB/ipEkxzaMXh0ybZC8lkvjaVzCmirfpLmrRf+
   i/e+p+3tNbmBK59tvLWBDXg5NNSkSoSSfcHyr2V7fVAfq3tBuE0ze9Xb+
   ItuNrHaHR7e7THRNwFKH6PoiN33aOii/VpNDAjNM8j+tbS4MyEJdUPjUq
   A==;
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="168350102"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2022 09:50:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 18 Jul 2022 09:50:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 18 Jul 2022 09:50:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awRvpPL8lu4qGbcM3IBvG2ndhNO6hNiXjP+8MIIy4RUbkhTzYIzld5LltwtefpQhhQphjbNwPCKp2rrTR3uykJEEphjzoSHSqP7OCPUcyvXaNQfcwQy2Cpe5oDg/+37PnDEJxIy2dJ/e7ZZJxqStWK4hqBNVcZ5KCRUyHU736ruNJ7G10C01IMQ+fCUS0IGZBnw8T4qDGxt6Mz4lKEbbtWqWH6NTxoFB/vIfsoBA8cT1/iowM4N+LMZ6/bB9LZC+NwxLpgXWB1P8yf1XZFj2YH50Omo4ShuBDgHHsh6Fjcht+PPETndKY3yfq0/FUB6YmvSwkHyKeSSW2MKuqi+e1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYbetZCZmhIpPO479eS5Y16zAWPaBP7Hb0nV7/+8YTY=;
 b=RcZSd7HdZOkL3pISajydTtziF+8nY9OXdsur4eYosZd3eI0K9UEqA3A+c9WCuDwjL7uH92NrcrFaZWtqr1BLoc8ODqrwEhrAlrjWtge6z19ZTXL2R5DTt7T3Afn5lkIahaOTob7cnPiX9YwlJ94FwOD1pEFDC0UcAslF1QJwbpHGVIbu2KEf9QnRDH1zML54R5IZJYuSpMGD/znf1n7TfJD39H/ABSfc+3ScNo1+rLUkpIcTpImC4Aj42nIC4ij5n2P6/7bD85NN9TVVLgKjegTnYMnqzzlz2CPiixvvCTag2Q5Joa6UxBmGfsifyy07GnOanMn81RlY5iTvGOUQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYbetZCZmhIpPO479eS5Y16zAWPaBP7Hb0nV7/+8YTY=;
 b=nZfTWZGabRtR5KR3H41ZjOJ3TT2/+2o+Q56IMGmdNJjre+Ez4+nzpxDQqtnf6beiX4BR+OxkTFsl/G7ccRZ0xO2NFF/iiSuVfM+UjRezKnGmh/Bx8wTJWpHeS8ndAD23XTW9TF0kTWqneoA3UIbd9YNUZofS2Oh9Le4kEafaVR4=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Mon, 18 Jul 2022 16:50:19 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 16:50:19 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <alexander.sverdlin@nokia.com>
CC:     <linux-mtd@lists.infradead.org>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: Introduce erase_proto
Thread-Topic: [PATCH 1/2] mtd: spi-nor: Introduce erase_proto
Thread-Index: AQHYmsZ2XQoWsO2E/ku+T0Ijf1R7sQ==
Date:   Mon, 18 Jul 2022 16:50:18 +0000
Message-ID: <c1a4e233-f00b-a4c4-8c28-111889f272d9@microchip.com>
References: <20211209100813.61713-1-alexander.sverdlin@nokia.com>
 <20211216200535.jikqd42nohr4477n@ti.com>
In-Reply-To: <20211216200535.jikqd42nohr4477n@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95374ea2-9d9d-4a51-72ce-08da68dd9903
x-ms-traffictypediagnostic: PH7PR11MB6676:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CVicZeJ79CvRoqc8k3zhhWJMLZYjHsK3vc1mnWSC+cbmSU2i4nhvMWao9nuZPnJYB9vSUdTRZXIBWpK1vvGdPNdG1cPNxMMJNK7Ti0ad5afFrVxFZUgt+U/c5SGw5LgkmaXFOw8oPFVMJrTJdwDEUj1qNqffrfFevlL7RhWztlS2QDGPAsXRYSy0+SxyHrel9bQK31L0ieP1b6DohU30VWiES15LD8gcGdgMihlscanXpAclZ1XWoBlqB4BiOpuHAQBLkgv7t9JX18Rk0kArTmMH3rFqkFqNNvalhTkwoOA7QDBSLtDScuLgJbguBPtcti3v25msM7gSPfg7xwGvhqcf3XUmMXpP4IzO9XweaSk93Ow54pi2jBSxr429ZEfBrIyo0Lghs8C1j8kAXVwP8HaZEcwe1ULt7wNWZcy3LFJKoJEPKoX6av0vQd+/8WemzisQhwLKkW4I6Z/GeIh0jUHDxwkswyznryyJ4Qp4XI1t0ImZ8QB4+f6gmDCh8Dmm2bNkX4Ayv4d373ZDK9MlH7JGl9/8D1mQCK2DnjRT2A6qAgcPfkJjAuQQH32SQUSHICsw77V3dianC+AnRR1UyQZagpdcjsX8oE742of9JhFtBahEEkc6NJ1x3ckGCirTGocTgRb5hSUTryLZ4vwgO57u2sDpQGkoKd1ncj64OK/wCtRm21hPpq8C4CWu1ZoGbCTkg3GYm9/97/+sRU7JTCrTdY7mlBTNYnKmV8N/u6K9+bsUGISFR801bwGV0um7/CQztFxXeDwJETeA49efntwVoXrz6rVVqbT5MFFDmn2yUGvGLq3QG6oLbXuBNbrZnLK15c0xAxGAG6RaAGEaNzAdQNPFbyAYtksF5MLC1diSzqd61k2r5Q2nC+4HF1MGElvGSRBdNw65GPoWflsCIKCkqCLgatDPxOTnUQim4ig=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(376002)(366004)(346002)(83380400001)(38100700002)(91956017)(66946007)(5660300002)(110136005)(54906003)(38070700005)(31686004)(2616005)(122000001)(36756003)(316002)(76116006)(8936002)(31696002)(71200400001)(26005)(6486002)(478600001)(66446008)(86362001)(4326008)(41300700001)(66556008)(64756008)(2906002)(66476007)(6512007)(966005)(53546011)(186003)(6506007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N09xaTBobEJzWXhBcSswUS95K3kvREw4c2wwMTNJSGpXc3NRZWtML0Q5dzBO?=
 =?utf-8?B?WjlDMjNkVVhpNi8yaDdRR3lNR0ZTc1o4M0Z5SXVTZkVaWld3blhxVGlRR1o3?=
 =?utf-8?B?RjlRTmVGSHlyNm9MTnE0VXQydEliVk9xK0trdjBTeHdKOWNtOStnOGZrS3pX?=
 =?utf-8?B?WGpyYUVnZVY0YktJREFQSHJ3dnpZTHRjVlZqTE5Ua01DRjlQNFpDNWZkTkY5?=
 =?utf-8?B?SHFKQ0tsVFZuSHQ1b1QxeFJ2QXBFa3BGem5hd2c5OGpzc01iZStjemFYczEx?=
 =?utf-8?B?cUEwZjJ0YzFvSVNtL3I5YjJvYnRSazNHMGZ4V1RJeVBTMytNVzVRM0N1R0pk?=
 =?utf-8?B?VnlONFBYTWpLbjZIZXdSZlN3anc1a2JYeE9YV2tmTGZqTDZndW44WHU4QjZD?=
 =?utf-8?B?TXpOY0FMOUZINHBtTnBTbzA2dlYyNXc3V1JSVjNvb3Z0ZW5SR3JxRWZQcnEx?=
 =?utf-8?B?dXZUQldLdUZULzNXRkk0TXUxd2R5aTB3UjVvUGlIZTJBOUxLYStDeWptZm02?=
 =?utf-8?B?RVdoRkhwN1ZabG1BRFFIbmJiVXdKU0M4ZzhndWsxbldOVC9hUDZrbmZsdkNy?=
 =?utf-8?B?ODlOZ2dzWDllc2k5clN0dnNBYXIrTVZ3U0piOVMzMEg1cFpESFkxV0NNeTBv?=
 =?utf-8?B?RlZGM2ZLbEJJU0xLWHNTYTd3Q3B3d1ZKTmx6anlyRjc5UkNrSzBXZWpQMUZi?=
 =?utf-8?B?dGxYanlNU1lEZmVDamxnQzQybnc5WHBOMEUzU2RuRThtYWVkNDNtUkhTS3ZZ?=
 =?utf-8?B?UGxQVEpPSXZoeDRwRTZ0dmhtMUY3S205bVBEWkoxNk9QRzQvQlZaaW1DQnZQ?=
 =?utf-8?B?SVM1c3BweTYzRDNraEJpdnBJVjlST1RQNHpBVXhFVXJMWDY0REpiT1V0Vytj?=
 =?utf-8?B?WVpPcTB0UzVTZEhPVGsyNXU4eUpUN3VZc0I1eDR1K1RtdEt0R1g2aUVKc1pn?=
 =?utf-8?B?QmNLcUlMN0VqNzQrVnV5WkhSNXpaak4xazJqU3dSajMvWW8zaElOeGFsYk5q?=
 =?utf-8?B?blc4TmlkaHhwSGhIZGk1NUdCTldTQkQ4a0pITTVka3FiSGdFTlJvckxrRXgx?=
 =?utf-8?B?TVpLNWU5TlpDOXFMUVVXY0VOMlA5aTJGZ1lPV2ZlTXNwZDROdHpjaEplMkdY?=
 =?utf-8?B?TVhhQVhzb1RaRHRFRkxJNGtJK1hIbnBtc083SXlhQUg0aE9UaWFvbTlqM01o?=
 =?utf-8?B?OWJSWkVJT3hoVDQ1bXE5TmVZUDRvdWNwWkRYOWZBS3hPU0M5QXRsTkJLaDd2?=
 =?utf-8?B?dEtRZ1YwRFJ0ZnlIRFA3ckRzVmx4LzhxY1JEekVmMmhsck82aFJMcWduR1pu?=
 =?utf-8?B?V0wzS0hmbWd3ZU5LV2orMFQxWFpHRllHQnJXVE5KZGxsVmdlYUgxeUU0dzNR?=
 =?utf-8?B?d08yK3J4cEpldHpxSXpmOUZkN3pSU0ZORGFnRXlNV1hFTjRvUWVpMDh4aWtK?=
 =?utf-8?B?NTlwVTJpSk5GMG80bkRlUXFnOS9wK3NEeG1IbktpZnZ6dkxwQ2x4MGFZZE45?=
 =?utf-8?B?azFPekNFZnU3WjZLb3Npb0o4S0NFUCsweTJYcENobHFqWk5HOG0vUnVTdklH?=
 =?utf-8?B?b2RraEJIQjBjQVRKS2N2R1I2c3IxbkliQXo2TWZHTUFVQzNsVkdTMEVKZVFG?=
 =?utf-8?B?Q2prTUtBYTQrNWtlaTRCTElJVncvWUdka0F5RUNMVThzVkQzSmVuVHg1S3Z5?=
 =?utf-8?B?Q25udE5KVzRCeDF6YUJ5cGNxODVhcmJOQzNmN2ViNzZuaHpMTS8vdzUvSVdO?=
 =?utf-8?B?cjJpckdEcmFTV0pqdmZ6YUhoQTVLbG9KczFqK29uRm1raVFFNmtzclNTbGRh?=
 =?utf-8?B?NnRmUjNDaTNHMHcreEZrOGRTZTFQRURJWkExNVN6bVZoeHY5eDhEMkxnUHF1?=
 =?utf-8?B?VGxuQmRCTVlvY25iMlVwUTFzZ0p1ZEt5UWcwZ1JUNEJZajFRL0c5a2pnK2ky?=
 =?utf-8?B?N1AyanlxVWNtYzBYRHM3bEljQm1XaWxxM0ZKZWhsZTc4N2FFbGZYM1oyRmZI?=
 =?utf-8?B?MkZPRjY5VCtTZjBDMEREeFBmeFVCSkhFcXhGTlJGV0YwZmVQdUZsR0o2MS9l?=
 =?utf-8?B?cDdLMnZRZmR1OVhvNXFOZTlMMC91QjFaTm1lYlZWZTdxNG11b2FoZjZzRU1Z?=
 =?utf-8?B?cnFLOVh4VDBSd085dkpIMjBoejNBelExWEpmOVh0VDNoUEpsVHAzMWNNQXhF?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60AC3F047DEED440AF2F08FABDEAC98A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95374ea2-9d9d-4a51-72ce-08da68dd9903
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 16:50:18.9828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pqu/4dgUDo5+jILSK4Kk5x/ectjeKrtv8XidQ68tqWs12Xf8pqWYRSdALKdQ2zgB9gjN2k/VLdPqY1sxaz6HtTZu7QOFHFC4Tq419a/KkFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTYvMjEgMjI6MDUsIFByYXR5dXNoIFlhZGF2IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIEFsZXhhbmRlciwNCj4gDQo+IE9uIDA5LzEy
LzIxIDExOjA4QU0sIEFsZXhhbmRlciBBIFN2ZXJkbGluIHdyb3RlOg0KPj4gRnJvbTogQWxleGFu
ZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Abm9raWEuY29tPg0KPj4NCj4+IEkndmUg
YmVlbiBsb29raW5nIGludG8gbm9uLXdvcmtpbmcgZXJhc2Ugb24gbXQyNXF1MjU2YSBhbmQgcGlu
cG9pbnRlZCBpdCB0bw0KPj4gYmUgd3JpdGVfcHJvdG8gMS00LTQgc2VsZWN0ZWQgZnJvbSBTRkRQ
IHdoaWxlIHRoZSBjaGlwIG9ubHkgc3VwcG9ydHMgMS0xLTANCj4+IGVyYXNlLg0KPj4NCj4+IEZv
ciBub3cganVzdCBpbnRyb2R1Y2UgdGhlIHNlcGFyYXRlIHByb3RvY29sIHdpdGhvdXQgZnVuY3Rp
b25hbCBjaGFuZ2UgYW5kDQo+PiBsZWF2ZSB0aGUgcmVhbCBmaXggZm9yIHRoZSBmb2xsb3dpbmcg
cGF0Y2guDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5k
ZXIuc3ZlcmRsaW5Abm9raWEuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9j
b3JlLmMgIHwgOSArKysrKystLS0NCj4+ICBpbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmggfCA0
ICsrKy0NCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgYi9kcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPj4gaW5kZXggMmUyMWQ1YS4uZGNkMDJlYSAxMDA2NDQN
Cj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+PiArKysgYi9kcml2ZXJzL210
ZC9zcGktbm9yL2NvcmUuYw0KPj4gQEAgLTE3Nyw3ICsxNzcsNyBAQCBzdGF0aWMgaW50IHNwaV9u
b3JfY29udHJvbGxlcl9vcHNfd3JpdGVfcmVnKHN0cnVjdCBzcGlfbm9yICpub3IsIHU4IG9wY29k
ZSwNCj4+DQo+PiAgc3RhdGljIGludCBzcGlfbm9yX2NvbnRyb2xsZXJfb3BzX2VyYXNlKHN0cnVj
dCBzcGlfbm9yICpub3IsIGxvZmZfdCBvZmZzKQ0KPj4gIHsNCj4+IC0gICAgIGlmIChzcGlfbm9y
X3Byb3RvY29sX2lzX2R0cihub3ItPndyaXRlX3Byb3RvKSkNCj4+ICsgICAgIGlmIChzcGlfbm9y
X3Byb3RvY29sX2lzX2R0cihub3ItPmVyYXNlX3Byb3RvKSkNCj4+ICAgICAgICAgICAgICAgcmV0
dXJuIC1FT1BOT1RTVVBQOw0KPj4NCj4+ICAgICAgIHJldHVybiBub3ItPmNvbnRyb2xsZXJfb3Bz
LT5lcmFzZShub3IsIG9mZnMpOw0KPj4gQEAgLTExODYsNyArMTE4Niw3IEBAIHN0YXRpYyBpbnQg
c3BpX25vcl9lcmFzZV9jaGlwKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QX05PX0RVTU1ZLA0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgU1BJX01FTV9PUF9OT19EQVRBKTsNCj4+DQo+PiAtICAgICAg
ICAgICAgIHNwaV9ub3Jfc3BpbWVtX3NldHVwX29wKG5vciwgJm9wLCBub3ItPndyaXRlX3Byb3Rv
KTsNCj4+ICsgICAgICAgICAgICAgc3BpX25vcl9zcGltZW1fc2V0dXBfb3Aobm9yLCAmb3AsIG5v
ci0+ZXJhc2VfcHJvdG8pOw0KPj4NCj4+ICAgICAgICAgICAgICAgcmV0ID0gc3BpX21lbV9leGVj
X29wKG5vci0+c3BpbWVtLCAmb3ApOw0KPj4gICAgICAgfSBlbHNlIHsNCj4+IEBAIC0xMzMxLDcg
KzEzMzEsNyBAQCBpbnQgc3BpX25vcl9lcmFzZV9zZWN0b3Ioc3RydWN0IHNwaV9ub3IgKm5vciwg
dTMyIGFkZHIpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09Q
X05PX0RVTU1ZLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU1BJX01FTV9P
UF9OT19EQVRBKTsNCj4+DQo+PiAtICAgICAgICAgICAgIHNwaV9ub3Jfc3BpbWVtX3NldHVwX29w
KG5vciwgJm9wLCBub3ItPndyaXRlX3Byb3RvKTsNCj4+ICsgICAgICAgICAgICAgc3BpX25vcl9z
cGltZW1fc2V0dXBfb3Aobm9yLCAmb3AsIG5vci0+ZXJhc2VfcHJvdG8pOw0KPj4NCj4+ICAgICAg
ICAgICAgICAgcmV0dXJuIHNwaV9tZW1fZXhlY19vcChub3ItPnNwaW1lbSwgJm9wKTsNCj4+ICAg
ICAgIH0gZWxzZSBpZiAobm9yLT5jb250cm9sbGVyX29wcy0+ZXJhc2UpIHsNCj4+IEBAIC0yNzI3
LDYgKzI3MjcsOSBAQCBzdGF0aWMgdm9pZCBzcGlfbm9yX2xhdGVfaW5pdF9wYXJhbXMoc3RydWN0
IHNwaV9ub3IgKm5vcikNCj4+ICAgICAgICAqLw0KPj4gICAgICAgaWYgKG5vci0+ZmxhZ3MgJiBT
Tk9SX0ZfSEFTX0xPQ0sgJiYgIW5vci0+cGFyYW1zLT5sb2NraW5nX29wcykNCj4+ICAgICAgICAg
ICAgICAgc3BpX25vcl9pbml0X2RlZmF1bHRfbG9ja2luZ19vcHMobm9yKTsNCj4+ICsNCj4+ICsg
ICAgIGlmICghbm9yLT5lcmFzZV9wcm90bykNCj4+ICsgICAgICAgICAgICAgbm9yLT5lcmFzZV9w
cm90byA9IG5vci0+d3JpdGVfcHJvdG87DQo+IA0KPiBJIGdldCB0aGF0IHlvdSBhcmUgdHJ5aW5n
IHRvIG5vdCBicmVhayBhbnkgZXhpc3RpbmcgZmxhc2hlcyB3aXRoIHRoaXMsDQo+IGJ1dCBJIGRv
bid0IHF1aXRlIGxpa2UgaXQuIFdlIHNob3VsZCBrZWVwIHRoZSBzYW1lIGluaXRpYWxpemF0aW9u
IGZsb3cNCj4gd2l0aCBlcmFzZV9wcm90byBhcyB3aXRoIHdyaXRlX3Byb3RvLCByZWFkX3Byb3Rv
LCBldGMuIFRoYXQgaXMsDQo+IGluaXRpYWxpemUgaXQgdG8gU05PUl9QUk9UT18xXzFfMSBpbiBz
cGlfbm9yX3NjYW4oKSBhbmQgdGhlbiBsZXQgdGhlDQo+IGluaXRpYWxpemF0aW9uIHByb2NlZHVy
ZSBjaGFuZ2UgaXQgYXMgbmVlZGVkLg0KPiANCj4gVGhlIHByb2JsZW0gd2l0aCB0aGlzIGlzIG9m
IGNvdXJzZSB0aGF0IGl0IGNvdWxkIGJyZWFrIHNvbWUgZmxhc2hlcyBieQ0KPiBzZWxlY3Rpbmcg
dGhlIHdyb25nIGVyYXNlLiBJIHdvdWxkIGV4cGVjdCBfbW9zdF8gZmxhc2hlcyB0byB1c2UNCj4g
ZXJhc2VfcHJvdG8gYXMgMS0xLTEgYnV0IEkgb2YgY291cnNlIGhhdmVuJ3Qgd2VudCBhbmQgbG9v
a2VkIGF0IGV2ZXJ5DQo+IHNpbmdsZSBmbGFzaCB0byBwb2ludCBvdXQgdGhlIGV4Y2VwdGlvbnMu
DQo+IA0KPiBJIHdvdWxkIGxpa2UgdG8gaGVhciBmcm9tIG90aGVycyBpZiB0aGV5IHRoaW5rIGl0
IGlzIG9rYXkgdG8gZG8gdGhpcy4NCj4gDQoNCkRvZXNuJ3QgWzFdIHNvbHZlIEFsZXhhbmRlcidz
IHByb2JsZW0/IEFsZXhhbmRlciwgd291bGQgeW91IHBsZWFzZSB0ZXN0DQpQYXRyaWNlJ3MgcGF0
Y2ggYW5kIHByb3ZpZGUgYSBUZXN0ZWQtYnkgdGFnIGlmIGV2ZXJ5dGhpbmcgaXMgb2s/DQoNClRo
YW5rcywNCnRhDQoNClsxXSBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGlu
dXgtbXRkL3BhdGNoLzIwMjIwNjI5MTMzMDEzLjMzODIzOTMtMS1wYXRyaWNlLmNob3RhcmRAZm9z
cy5zdC5jb20vDQoNCg==
