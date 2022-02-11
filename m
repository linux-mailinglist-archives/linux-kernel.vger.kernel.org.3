Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325DD4B203E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244994AbiBKIfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:35:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiBKIfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:35:19 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2129.outbound.protection.outlook.com [40.107.255.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A56E58;
        Fri, 11 Feb 2022 00:35:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMGId1XO8nE4ZONja30M+0NeiJtC3/CLwqXxullTZPhZcAafrn3NiAI5M2yt04qpjUCVUwYm0kqBnvAYSm/LFT8/w3tJrb4IdbqpSdhzdMnOfLzkTsJ7Xx+tCuVgaLo17VpUK4U/nH16tC2j8IDZ9t+Qn9c2mbL62IgskeP8tRWIPvvaGbYEwAgkDbxVNEVR/wU6apqQFw6iX1mCE0kAuELBQ3puQjW/u1ubvt4RUYc6F3+KLqEyTfC65xezRzwDtzhR16OIxp/nBc6lA8u/QVzPUyHetWtQPDQZ+lqC/DLEeapNQk6res+rIsyQjIVltJC23jnvTAL7xK4r1L2psA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5zWXXxWnMFoIu6BokyrJYxvdEWEwcADXgTIbxl6s3Y=;
 b=ScM/v3W4ShYJIPp4IrLjDZzO+Twzm6R53a7BPJMfGohm9+JjnHO/djHrKO48GpEjxzqhFlZ0LqE8DCw0frQkN5c2J4Z5XtZsQrNJw8C9GCWX6McgFWkVjohETNNoSyKOi6MY3/pQ+PSApfqDSRyBbsJcbOibd8J3vPv6fp/Bxf9pVsVDvQGMdU4CDG6zzJYJ0zWEffITb7GuLqPo8Xem0drvQKkA/QulwEHTV8XZE4LtDFuwzMqtJ95nQtHDkaWMuvQk/9M+VfStu22+vgfvoDnNZCsmTxRWL8YjJK9XF6QI2/8VPqqhRpymi0lPAtFL1m3++j6XWs0YKgkO4E9XKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5zWXXxWnMFoIu6BokyrJYxvdEWEwcADXgTIbxl6s3Y=;
 b=IaRGcgiQLBY4gd1EaTjSTVdNbMl0+olVUFeBaQPv+iIzd7OPIXIJuRiHu79H+pjQu63/tS5EZqq9pRBTuKK+lk8jah3+o3B7OPGEyLBUIzmxzAw/G+x+lYRxFI7dbUP4YZ6OrngNe9YARKYTy5aDGTcxt1h06NMhmiwT9vVbhNo=
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SEZPR04MB5627.apcprd04.prod.outlook.com (2603:1096:101:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 08:35:11 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 08:35:11 +0000
From:   =?utf-8?B?UG90aW4gTGFpICjos7Tmn4/lu7cp?= <Potin.Lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrick Williams <patrick@stwcx.xyz>
Subject: Re: [PATCH v2 2/2] usb: typec: fusb302: add support of
 supported_pd_rev
Thread-Topic: [PATCH v2 2/2] usb: typec: fusb302: add support of
 supported_pd_rev
Thread-Index: AQHYHN4ve7vLXdK2VEWhZgSwegQj6ayJxcOAgADMXICAAO9JgIACiWyA
Date:   Fri, 11 Feb 2022 08:35:11 +0000
Message-ID: <3546810e-281d-cc8d-2231-f409e69d180a@quantatw.com>
References: <20220208082026.4855-1-potin.lai@quantatw.com>
 <20220208112226.9108-1-potin.lai@quantatw.com>
 <20220208112226.9108-3-potin.lai@quantatw.com>
 <1acc1733-da53-6255-5cad-15f79850f44f@roeck-us.net>
 <fed6bad9-bf9b-90b5-57fd-083401f6c990@quantatw.com>
 <e2aec7c6-2d73-6446-89c9-797850f9402f@roeck-us.net>
In-Reply-To: <e2aec7c6-2d73-6446-89c9-797850f9402f@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24920ecd-509e-428a-509a-08d9ed396b40
x-ms-traffictypediagnostic: SEZPR04MB5627:EE_
x-microsoft-antispam-prvs: <SEZPR04MB5627FDDD78BD0C6CE3D7A9CF8E309@SEZPR04MB5627.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mItuqufYGcxSesNe+70YgzBJSSj7tzNeKqjPxH2QPpDQ77GM4H/GFtVCUa0PbTlg+Tyrw2FIM8+F66BLJukqET5JOAtRbIbK7jzWN5V/E1k1X1avlpsoDm0Md2uCRPQahc/g/cWZwsFRV7VS4WIKPKFKFyiZa3oGHTnDo2xKU6HPD7Oosncf+72cQp/o27FH1Z5kMj6RT0f/jtYBNqMFpICu/ZNrtv2fWV6H5kl4N6GU1VLiLapoeKzVvNQbs0r9amy51KZHiWN8kdu/hFEg3wuL9dSiZlUM96QDLmdRmGsBnpD5ohhEujdBj+u068Dmj89llGzDijFcUb64t6KWRSWzMQsFUkZXxSx0StEJQe046ynfuIdnhuuavHiPbFu3Zwi+ScwyNKuPJykzqr+8z9CqO6zIavXmMcnn1/5LKHs1b7bdp/BCb7qQ9vW72mybSguv2YKkFHb3e3OztGLjeLGvWGyRaB+rerDfmXEvz5EsJAd6h3eEOcUNV0l5W9S+i4SM1MI8B1xbqi4CtPwLFliyUN3SwtJGakc+tlGnaAxxtjE/NiyYDJvnVfghRM5GuyrCBiIRPVvHRFmUqSMX7onBUUNL8yq7xCKsNWi+QjB6k1rmR9goRKU8YcofO0dZscG2hb4OSZ98DJYX6xM8dzqqju/BPrhX7+Kbgz0a9+ZFW5fT4+0Ri1I9gPXA5n+oimAGldf4wcrK/B/daY9VS0pKgc0xbg8EzqzZ0WPpA26/KBUiVe2oIRGiWtS28/vP4vJvvGKZQlmE6QNveaZbqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(83380400001)(85182001)(122000001)(36756003)(316002)(2906002)(6512007)(31686004)(8936002)(71200400001)(66946007)(8676002)(6506007)(66476007)(64756008)(38100700002)(5660300002)(66446008)(66556008)(86362001)(54906003)(76116006)(508600001)(6486002)(31696002)(26005)(186003)(4326008)(53546011)(110136005)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0tpVDRYMFFxWld4VGtVSEtlV1dJMm1VeFQrQ0hIbW9VYUREVm4zNHdFeS9w?=
 =?utf-8?B?bXo1bEFJNlJsWHVKZEp2Y3VQYkp4bTFraEh0bldLdkE2ZFpSQUdHMURIWWkz?=
 =?utf-8?B?TzZtK1NyNTNGMUlleHJodzBXT2JodDFhakhNSUxWT0lHbWhIeU1oNGVQSTJo?=
 =?utf-8?B?RUwwZG8xaDZwVERyd1g4eUU4S05kQUhUODBOYWF1R2QwamJFVHFFb1hSRXQ3?=
 =?utf-8?B?V1lLTytIVmZVa1ZDL1M5OURmNlVQZmZxUEQxSE1DUzcrdW9aY0dNVzFyZ0c3?=
 =?utf-8?B?WXU5am5ESE9FR0V6azAzNE9sTk82TVdFbFJtVUVEYTJsODZoNk9Ta21tMzhk?=
 =?utf-8?B?ZDIrd0RnWk9qcGJTZkNGMkU1N0ZPY0h3Ty9lWjhvWXdYd20xeEkydlhubzVQ?=
 =?utf-8?B?QzBUL1hvcExRWk1YeERQNU1pTGZLRkR3ZkpGd0d3K28vYytROE5teFdIYlZS?=
 =?utf-8?B?dGVqazNKdy83S00wRmJDWk13WmpTZ3NOM2dwTVM2Zm0yUHNVQ3BXaWk4UVl3?=
 =?utf-8?B?QUNJVUtKcUtUaHVUUkNXNmtvMVdUdGNjZ1JZL3pkM3NHRSt6UGpsVlRTNU8x?=
 =?utf-8?B?aG5ZaHNqR215K2NTYkswU2tRUTFESFVUTlRpRDZrTDdZSXMvRlY1bjk0RmFJ?=
 =?utf-8?B?VEFIU016am45b3ZaQ01hVCs3T3Fzbm1DWW9NdUsyMVNJM1ZLeURTbXFtZUNx?=
 =?utf-8?B?WWpvMEFXRUlwUnViRWhoa2taZmlhaVZaTUJia0lwY0FvaWJ3MkdWZ2dqaDha?=
 =?utf-8?B?OFV2SkZReFIvejNpbnNCWUVLTldMb3FHTUJKYjJESVJTRlhjeXZacjVlL3NY?=
 =?utf-8?B?TkswT3dYSS9nSWYzRFVLeGZGWng3RW5vamp0Q0pSWkFwcmJQc3FnRHFwa01O?=
 =?utf-8?B?cUUrUXZndis4cnBpbFlRbGw0U1VteHh4Mkw4a1hRdTdvZ0hYYVNtdWJ0YUdC?=
 =?utf-8?B?OUFmODZieHg5TG42WDhXMUVsYzdpWC96T3d6STA0ZWZhNVNRM1FUdURtaDZ2?=
 =?utf-8?B?d2hFTW1vWkc0QTdnQVI0MUR3aFU0NmgxdHJpd1hLaEdkVDBnNTYyN1NxSExN?=
 =?utf-8?B?aGlDMzFib2RXUTN1andoZnZDTXJ6czBrNlVGZHUvbzYxaTdscHE2cjZZZTlT?=
 =?utf-8?B?UzFoaWI3ekR1TVh4VkVaT2xaWjg4QXhzWDBnbVZOeFZ5ZmhVWkRqUGNMMmw3?=
 =?utf-8?B?RzlHeHZneUp2YlNTbGowa0hRUHgybWY3MmdGajhQSml6ZGpsSnlSemUxYXV2?=
 =?utf-8?B?a2tDV2xJOWdIZmtxSE5OT2pMWHQ0a2JlbTdVM0o4K25Oc01mSUg2NHFSdVEv?=
 =?utf-8?B?c1pzamFLeHFPbFIrTS83bGpSQlhiT2JEaCtpenRHcHpNUWJUNHUxQ3RTbW9w?=
 =?utf-8?B?a1o3QUlJQlY2Z1l3THZ1cDYxZm9VSVJGcnZZdkEzelozN0FHcUplYnAyNi9l?=
 =?utf-8?B?bmwvcENKZG40VjkxMEtkUGZSejA2NWF4ZTI1OXY4QVVYL2t3bFkzWEZ5VEVP?=
 =?utf-8?B?WkREcXc2Z1VybmU1TVJmOFBKeHkxV0ZrY2dtbmkxNkRiRTRZb1dwMUw4L3JF?=
 =?utf-8?B?TkYzMUt3SVhubENLcVlPSlJrVWQ5VTRoeldkRWZFZGhoNFFiVDdhY1FPNFc4?=
 =?utf-8?B?c050MFRaZW53S1BFWFg4YkhpdExLZ1IvRWtmd1I1d2NNZmJoejZBSGcwSHhz?=
 =?utf-8?B?TkxhWmZGdWJBa2RsenZTRnlTNklwZFBoOHEyMkQ1bjFZZEtqcDR2U0Q4Q25L?=
 =?utf-8?B?NmRTUmRuV0wreFE5YUZ5QjRVcmhNVHd1WXkwT3RaTDIxenBCYWlUaW1HMC9W?=
 =?utf-8?B?czZ4UkRncjlWT0EwRGxnYWtVUjN2WnRacllxVUthc1lhT3ZicmxyaGhkYzF4?=
 =?utf-8?B?c1JuZlpWdWxtOEhLUUJnTS9vdE5VbHdyY2RDSk8wWUJDcEpvd0hVWFZicE1K?=
 =?utf-8?B?Nk1lbW5STjZZd2FRR3pFa1h4YVMrYWM2WXNISWR0VzRZR01jM3E2Sk45eG15?=
 =?utf-8?B?ZHBKVGpwYnBmcUk1d2lTQ2lzbjN6RlZwZG1qWUZGUy9BbGpUMllrKzVONVJs?=
 =?utf-8?B?aXJVZnBybHErZ1FJSFJrNEpJdGs1OTV4YmZaUGg5R0xTc0MzQUhwMjN0R0hT?=
 =?utf-8?B?cUR2ZWo0SHl5SGsyQVFrdSsxb0c1VVJoUmZiNmZVallwYlpOZUlpMzdWZlNF?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21BA7F0FF6F80842BB4F2B5FDD21117B@apcprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24920ecd-509e-428a-509a-08d9ed396b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 08:35:11.7306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3VYY/PAC37tp3yMOpwwDf2rWS3F2p6Y7k/cw8myCgwT//Lsi0sV2dYLxLbGx5ymCGrf4IcZsboIK7KVBtV5Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB5627
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R3VlbnRlciBSb2VjayDmlrwgMjAyMi8yLzEwIOS4iuWNiCAwMTo1MCDlr6vpgZM6DQo+IE9uIDIv
OC8yMiAxOTozNCwgUG90aW4gTGFpIHdyb3RlOg0KPj4NCj4+IEd1ZW50ZXIgUm9lY2sg5pa8IDIw
MjIvMi84IOS4i+WNiCAxMToyMiDlr6vpgZM6DQo+Pj4gT24gMi84LzIyIDAzOjIyLCBQb3RpbiBM
YWkgd3JvdGU6DQo+Pj4+IEFkZCBzdXBwb3J0IGZvciBwYXNzaW5nIHN1cHBvcnRlZCBQRCByZXYg
dG8gVENQTS4NCj4+Pj4gSWYgInN1cHBvcnRlZC1wZC1yZXYiIHByb3BlcnR5IGV4aXN0LCB0aGVu
IHJldHVybiBzdXBwb3J0ZWRfcGRfcmV2IGFzDQo+Pj4+IGRlZmluZWQgdmFsdWUgaW4gRFRTLCBv
dGhlcndpc2UgcmV0dXJuIFBEX01BWF9SRVYNCj4+Pj4NCj4+Pj4gRXhhbXBsZSBvZiBEVFM6DQo+
Pj4+DQo+Pj4+IGZ1c2IzMDI6IHR5cGVjLXBvcnRjQDIyIHsNCj4+Pj4gwqDCoMKgwqAgY29tcGF0
aWJsZSA9ICJmY3MsZnVzYjMwMiI7DQo+Pj4+IMKgwqDCoMKgIHJlZyA9IDwweDIyPjsNCj4+Pj4g
wqDCoMKgwqAgLi4uDQo+Pj4+IMKgwqDCoMKgIHN1cHBvcnRlZC1wZC1yZXY9PDE+OyAvLyBQRF9S
RVYyMA0KPj4+PiDCoMKgwqDCoCAuLi4NCj4+Pj4gfTsNCj4+Pj4NCj4+Pg0KPj4+IFRoZSBuZXcg
cHJvcGVydHkgbmVlZHMgdG8gYmUgZG9jdW1lbnRlZC4gSG93ZXZlciwgSSBhbSBub3QgZW50aXJl
bHkgc3VyZQ0KPj4+IEkgdW5kZXJzdGFuZCB3aHkgaXQgaXMgbmVlZGVkLiBXb3VsZG4ndCB0aGUg
c3VwcG9ydGVkIFBEIHJldmlzaW9uDQo+Pj4gYmUgYSBjaGlwIChmdXNiMzAyKSBzcGVjaWZpYyBj
b25zdGFudCA/IElmIHNvLCB3aHkgZG9lcyBpdCBuZWVkIGENCj4+PiBkZXZpY2V0cmVlIHByb3Bl
cnR5ID8gSSB0aGluayB0aGF0IG5lZWRzIHNvbWUgYWRkaXRpb25hbCBleHBsYW5hdGlvbi4NCj4+
Pg0KPj4+IFRoYW5rcywNCj4+PiBHdWVudGVyDQo+Pj4NCj4+DQo+PiBNeSBpbml0aWFsbHkgaW50
ZW5kIHdhcyBhZGRpbmcgZmxleGliaWxpdHkgZm9yIGRldmVsb3BlciB0byBkZWNpZGVkIHdoaWNo
IFBEIHJldmlzaW9uDQo+PiB0aGV5IHdhbnQgdG8gdXNlIGZvciBuZWdvdGlhdGlvbi4NCj4+DQo+
DQo+IEkgbWF5IGJlIG1pc3Npbmcgc29tZXRoaW5nLCBidXQgSSBkb24ndCB0aGluayB0aGF0ICJm
bGV4aWJpbGl0eSBmb3IgZGV2ZWxvcGVyDQo+IHRvIGRlY2lkZSB3aGljaCBQRCByZXZpc2lvbiB0
aGV5IHdhbnQgdG8gdXNlIGZvciBuZWdvdGlhdGlvbiIgaXMgZW50aXJlbHkgYXBwcm9wcmlhdGUu
DQo+IFRoaXMgc2hvdWxkIGJlIGEgY2hpcCBwcm9wZXJ0eSwgbm90IHNvbWV0aGluZyBhIGRldmVs
b3BlciBzaG91bGQgZGVjaWRlLiBBcyB3cml0dGVuLA0KPiB0aGUgY29kZSBkb2VzIGFjY2VwdCBQ
QyB2ZXJzaW9uIDMgZm9yIEZVU0IzMDIgYnkgZGVmYXVsdCwgd2hpY2ggc2VlbXMgb2RkIGFuZCB1
bnVzdWFsLg0KPiBJZiB0aGUgY2hpcCBzdXBwb3J0cyBQRCB2ZXJzaW9uIDMsIHdoeSBhcnRpZmlj
aWFsbHkgbGltaXQgaXQgdG8gZWFybGllciBQRCByZXZpc2lvbnMgPw0KPg0KPiBJIHRoaW5rIHRo
aXMgcmVxdWlyZXMgYSBkZXRhaWxlZCBkZXNjcmlwdGlvbiBvZiB0aGUgdXNlIGNhc2UuIElzIGZ1
c2IzMDIgaW5kZWVkIG5vdCBhYmxlDQo+IHRvIHN1cHBvcnQgYSBzcGVjaWZpYyB2ZXJzaW9uIG9m
IHRoZSBwb3dlciBkZWxpdmVyeSBzcGVjaWZpY2F0aW9uID8gSWYgeWVzLA0KPiB3aGF0IGlzIHRo
ZSBsaW1pdGF0aW9uLCBhbmQgd2h5IHdvdWxkIGl0IG5lZWQgdG8gYmUgY29uZmlndXJhYmxlIHdp
dGggYSBkZXZpY2V0cmVlDQo+IHByb3BlcnR5ID8NCj4NCj4gVGhhbmtzLA0KPiBHdWVudGVyDQo+
DQoNClvCoCA0MTQuMzc1MjE1XSBBTVMgRElTQ09WRVJfSURFTlRJVFkgc3RhcnQNClvCoCA0MTQu
Mzc1MjI4XSBjYzo9NA0KW8KgIDQxNC4zODA4MzRdIFBEIFJYLCBoZWFkZXI6IDB4MjkxIFsxXQ0K
W8KgIDQxNC4zODA4NDZdIEFNUyBESVNDT1ZFUl9JREVOVElUWSBmaW5pc2hlZA0KW8KgIDQxNC4z
ODA4NTBdIGNjOj01DQpbwqAgNDE0LjM4ODIwM10gUEQgUlgsIGhlYWRlcjogMHgyOTEgWzFdDQpb
wqAgNDE0LjM4ODIxMV0gUEQgUlgsIGhlYWRlcjogMHgyOTEgWzFdDQpbwqAgNDE0LjM4ODIyMF0g
UEQgVFgsIGhlYWRlcjogMHg3YjANClvCoCA0MTQuNDk5NTk0XSBSZWNlaXZlZCBoYXJkIHJlc2V0
DQpbwqAgNDE0LjQ5OTYxNV0gc3RhdGUgY2hhbmdlIFNSQ19SRUFEWSAtPiBIQVJEX1JFU0VUX1NU
QVJUIFtyZXYzIEhBUkRfUkVTRVRdDQoNCg0KSW4gbXkgY2FzZSwgaWYgSSBrZWVwIGl0IGFzIFBE
X01BWF9SRVYgKDMuMCksIEkgYWx3YXlzIHJlY2VpdmUgaGFyZCByZXNldCBhZnRlciAiUEQgUlgs
IGhlYWRlcjogMHgyOTEiIChHZXRfU291cmNlX0NhcF9FeHRlbmRlZCksIHRoZW4gZW50aXJlIHN0
YXRlIG1hY2hpbmUgd2lsbCBzdGFydCBvdmVyIGFnYWluIGFuZCBhZ2Fpbi4NCg0KSWYgSSBmb3Jj
ZSBQRCByZXYgYXQgMi4wLCB0aGVuIEkgd29uJ3QgcmVjZWl2ZSBHZXRfU291cmNlX0NhcF9FeHRl
bmRlZCBtZXNzYWdlLCBhbmQgc3RhdGUgbWFjaGluZSBiZWNvbWUgc3RhYmxlLg0KDQpOb3QgcXVp
dGUgc3VyZSB0aGUgcmVhc29uIG9mIHJlY2VpdmluZyBoYXJkIHJlc2V0LCBteSBndWVzc2luZywg
ZnVzMzAyIG5vdCByZWNvZ25pemUgUEQgMy4wIG1lc3NhZ2UsIHNvIGl0IGRvZXNuJ3QgcmVwbHkg
R29vZENSQyBhdXRvbWF0aWNhbGx5LCBhbmQgdGhlbiBpdCBjYXVzaW5nIHRpbWVvdXQgb3IgZXZl
bnRzIHRvIHRyaWdnZXIgaGFyZCByZXNldCBmcm9tIHRoZSBvdGhlciBzaWRlLg0KDQpUaGFua3Ms
DQpQb3Rpbg0KPj4gSSBzYXcgeW91ciByZXBseSBpbiBhbm90aGVyIHBhdGNoLMKgIEkgYWdyZWUg
d2l0aCB5b3UsIGl0IHdpbGwgYmUgc2ltcGxlIGFuZCBjb25zaXN0ZW50IGlmDQo+PiBtb3ZlICJz
dXBwb3J0ZWQtcGQtcmV2IiB0byB0Y3BtIGZ3bm9kZSBhcyBvdGhlciBjYXBhYmlsaXRpZXMuDQo+
Pg0KPj4gSnVzdCB3YW50IHRvIGRvdWJsZSBjb25maXJtLCBpcyAidXNiLWNvbm5lY3Rvci55YW1s
IiByaWdodCBwbGFjZSB0byBwdXQgZG9jdW1lbnRhdGlvbg0KPj4gaWYgYWRkaW5nICJzdXBwb3J0
ZWQtcGQtcmV2IiBpbiBmd25vZGU/DQo+Pg0KPj4gVGhhbmtzLA0KPj4gUG90aW4NCj4+DQo+Pj4+
IFNpZ25lZC1vZmYtYnk6IFBvdGluIExhaSA8cG90aW4ubGFpQHF1YW50YXR3LmNvbT4NCj4+Pj4g
LS0tDQo+Pj4+IMKgIGRyaXZlcnMvdXNiL3R5cGVjL3RjcG0vZnVzYjMwMi5jIHwgMjAgKysrKysr
KysrKysrKysrKysrKysNCj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykN
Cj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL3R5cGVjL3RjcG0vZnVzYjMwMi5j
IGIvZHJpdmVycy91c2IvdHlwZWMvdGNwbS9mdXNiMzAyLmMNCj4+Pj4gaW5kZXggNzJmOTAwMWIw
NzkyLi44Y2ZmOTJkNThiOTYgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvdXNiL3R5cGVjL3Rj
cG0vZnVzYjMwMi5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL3R5cGVjL3RjcG0vZnVzYjMwMi5j
DQo+Pj4+IEBAIC0xMDksNiArMTA5LDkgQEAgc3RydWN0IGZ1c2IzMDJfY2hpcCB7DQo+Pj4+IMKg
wqDCoMKgwqAgZW51bSB0eXBlY19jY19zdGF0dXMgY2MyOw0KPj4+PiDCoMKgwqDCoMKgIHUzMiBz
bmtfcGRvW1BET19NQVhfT0JKRUNUU107DQo+Pj4+IMKgICvCoMKgwqAgLyogc3VwcG9ydGVkIHBk
IHJldiAqLw0KPj4+PiArwqDCoMKgIHUzMiBzdXBwb3J0ZWRfcGRfcmV2Ow0KPj4+PiArDQo+Pj4+
IMKgICNpZmRlZiBDT05GSUdfREVCVUdfRlMNCj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgZGVudHJ5
ICpkZW50cnk7DQo+Pj4+IMKgwqDCoMKgwqAgLyogbG9jayBmb3IgbG9nIGJ1ZmZlciBhY2Nlc3Mg
Ki8NCj4+Pj4gQEAgLTEwNTYsNiArMTA1OSwxMyBAQCBzdGF0aWMgaW50IHRjcG1fcGRfdHJhbnNt
aXQoc3RydWN0IHRjcGNfZGV2ICpkZXYsIGVudW0gdGNwbV90cmFuc21pdF90eXBlIHR5cGUsDQo+
Pj4+IMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4+Pj4gwqAgfQ0KPj4+PiDCoCArc3RhdGljIHUz
MiB0Y3BtX3N1cHBvcnRlZF9wZF9yZXYoc3RydWN0IHRjcGNfZGV2ICpkZXYpDQo+Pj4+ICt7DQo+
Pj4+ICvCoMKgwqAgc3RydWN0IGZ1c2IzMDJfY2hpcCAqY2hpcCA9IGNvbnRhaW5lcl9vZihkZXYs
IHN0cnVjdCBmdXNiMzAyX2NoaXAsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdGNwY19kZXYpOw0KPj4+PiArwqDCoMKgIHJldHVybiBjaGlw
LT5zdXBwb3J0ZWRfcGRfcmV2Ow0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+IMKgIHN0YXRpYyBlbnVt
IHR5cGVjX2NjX3N0YXR1cyBmdXNiMzAyX2JjX2x2bF90b19jYyh1OCBiY19sdmwpDQo+Pj4+IMKg
IHsNCj4+Pj4gwqDCoMKgwqDCoCBpZiAoYmNfbHZsID09IEZVU0JfUkVHX1NUQVRVUzBfQkNfTFZM
XzEyMzBfTUFYKQ0KPj4+PiBAQCAtMTEyOSw2ICsxMTM5LDcgQEAgc3RhdGljIHZvaWQgaW5pdF90
Y3BjX2RldihzdHJ1Y3QgdGNwY19kZXYgKmZ1c2IzMDJfdGNwY19kZXYpDQo+Pj4+IMKgwqDCoMKg
wqAgZnVzYjMwMl90Y3BjX2Rldi0+c2V0X3JvbGVzID0gdGNwbV9zZXRfcm9sZXM7DQo+Pj4+IMKg
wqDCoMKgwqAgZnVzYjMwMl90Y3BjX2Rldi0+c3RhcnRfdG9nZ2xpbmcgPSB0Y3BtX3N0YXJ0X3Rv
Z2dsaW5nOw0KPj4+PiDCoMKgwqDCoMKgIGZ1c2IzMDJfdGNwY19kZXYtPnBkX3RyYW5zbWl0ID0g
dGNwbV9wZF90cmFuc21pdDsNCj4+Pj4gK8KgwqDCoCBmdXNiMzAyX3RjcGNfZGV2LT5zdXBwb3J0
ZWRfcGRfcmV2ID0gdGNwbV9zdXBwb3J0ZWRfcGRfcmV2Ow0KPj4+PiDCoCB9DQo+Pj4+IMKgIMKg
IHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgY2NfcG9sYXJpdHlfbmFtZVtdID0gew0KPj4+PiBA
QCAtMTY4Myw2ICsxNjk0LDcgQEAgc3RhdGljIGludCBmdXNiMzAyX3Byb2JlKHN0cnVjdCBpMmNf
Y2xpZW50ICpjbGllbnQsDQo+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGZ1c2IzMDJfY2hpcCAqY2hp
cDsNCj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXB0ZXIgPSBjbGllbnQt
PmFkYXB0ZXI7DQo+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGRldmljZSAqZGV2ID0gJmNsaWVudC0+
ZGV2Ow0KPj4+PiArwqDCoMKgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9mX25vZGU7
DQo+Pj4+IMKgwqDCoMKgwqAgY29uc3QgY2hhciAqbmFtZTsNCj4+Pj4gwqDCoMKgwqDCoCBpbnQg
cmV0ID0gMDsNCj4+Pj4gwqAgQEAgLTE3NTYsNiArMTc2OCwxNCBAQCBzdGF0aWMgaW50IGZ1c2Iz
MDJfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGRldl9lcnIoZGV2LCAiY2Fubm90IHJlcXVlc3QgSVJRIGZvciBHUElPIEludF9OLCByZXQ9
JWQiLCByZXQpOw0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byB0Y3BtX3VucmVnaXN0ZXJf
cG9ydDsNCj4+Pj4gwqDCoMKgwqDCoCB9DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoCBpZiAob2ZfcHJv
cGVydHlfcmVhZF91MzIobnAsICJzdXBwb3J0ZWQtcGQtcmV2IiwNCj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAmY2hpcC0+c3VwcG9ydGVkX3BkX3JldikgPCAwKSB7DQo+Pj4+
ICvCoMKgwqDCoMKgwqDCoCBjaGlwLT5zdXBwb3J0ZWRfcGRfcmV2ID0gUERfTUFYX1JFVjsNCj4+
Pj4gK8KgwqDCoCB9IGVsc2UgaWYgKGNoaXAtPnN1cHBvcnRlZF9wZF9yZXYgPiBQRF9NQVhfUkVW
KSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBjaGlwLT5zdXBwb3J0ZWRfcGRfcmV2ID0gUERfTUFY
X1JFVjsNCj4+Pj4gK8KgwqDCoCB9DQo+Pj4NCj4+PiBUaGUgZWxzZSBwYXJ0IGlzIGFsc28gY2hl
Y2tlZCBpbiB0aGUgdGNwbSBjb2RlIGFuZCB0aHVzIHNlZW1zDQo+Pj4gdG8gYmUgcmVkdW5kYW50
Lg0KPj4+DQo+Pj4+ICsNCj4+Pj4gwqDCoMKgwqDCoCBlbmFibGVfaXJxX3dha2UoY2hpcC0+Z3Bp
b19pbnRfbl9pcnEpOw0KPj4+PiDCoMKgwqDCoMKgIGkyY19zZXRfY2xpZW50ZGF0YShjbGllbnQs
IGNoaXApOw0KPj4+DQo+DQoNCg==
