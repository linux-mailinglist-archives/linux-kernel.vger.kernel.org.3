Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480E851FAD0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiEILHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiEILHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:07:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E958F2317FF;
        Mon,  9 May 2022 04:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UY26TIh4P6PxL43Rszw225Ukp93ZF56YSYZPRraiwVawEc+ftztfDcgQLmpueh6NLzEwoyFQhyy+7KxkEmHoDGp7K7v6Rw/4vX7qi+Ql/0ucwK/xQHYXG3IKV2Wtnx/lo08621yJCu0Iljk5ZDsvYV/ghDJeKUEKxT+A4HI1l0m6E7q4fBqaX3HHzuzhz3LVW712F6oJKbxHrd3v9JEcHuKYqcm+DFb4eSFfQe5xl7pKIMBoAsS6mPXMQ5dHsRXb21nTNxZ7xPdd7jKPMlKZQJScJqx4Y/8BeOdIG0zsHnO1OZlXcvM5FPLX7ocUWpYujzoNifjYg0+wL4HOphvgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHspxwN5EIklWPhnur9KyFhKkfZPyCulTx6tif3oYnQ=;
 b=Gh7dUmzBZVnM3F4hoOoM3tGvGBYypdZiBW9Ngl6k2VlY/83T2Js0KiD/ETGpSuX0ldZ9vH4Bllu0wWjLZRjr2fqYab8e2v/mxhAv0s0nJ969lTVzAccr0RBRg2uVsGH/ZJ2PwmCOzu5QL1XhTWhPBtuph3HSW41rvh3mWK0f/DIzzpzHDgsauMXBYYk2CrhzgIuZcefq4TINvMzm4vbeY2r9O/UnYMeV6Y/YHwKvCuo857matoWyGHEhKaw560etrvXmy0e+e9/dc4hz6Je9jqH792KzqNq+BzDcV4doQoNSV7dDHXXkD7Ojh5pwRAD7mh4c115MEYwQjAZFBt/jZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHspxwN5EIklWPhnur9KyFhKkfZPyCulTx6tif3oYnQ=;
 b=gEPejjT8o4RtuQbSDtdmAxG4tffbPIIOVM4/IyqHyjJMHqFdb45lknUafiufYqSdMO387AuMiVEwuXe6rIXlRU4CF79VrmoWhVEFYAO7mCOwWwjuRiHgQ9yUkfCbY6envIXdJnMiXyPn6hQN5aeWfbWFXCtLWnXA+WujlgPNWEqRUxfPTdVP2OmgJtvcXBdgm4qwRnMeiOtyJsJWRYoBPeyhKGGiBxrAqdHNPB7+eb7FG5TQN5pljPl60XT1gzaMe3LgNGBd0GeWhdwXtSguW1/aPEAB2VOS/s6rnTd/YYVmemyXrrgyLERgAwbnGBHJxW3pPLaxZbYvEEMndi0cWw==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by AM6PR10MB1912.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:3c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 11:03:06 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::99a1:b485:c2b1:7ee0]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::99a1:b485:c2b1:7ee0%3]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 11:03:05 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] tty: n_gsm: fix mux activation issues in gsm_config()
Thread-Topic: [PATCH 2/3] tty: n_gsm: fix mux activation issues in
 gsm_config()
Thread-Index: Adhjk9Mfxk/desayQOWbiqS+kvKvxg==
Date:   Mon, 9 May 2022 11:03:05 +0000
Message-ID: <DB9PR10MB588149B7E9A31D3476762776E0C69@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2022-05-09T11:03:03Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Privileged;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=d8458585-4c24-4c3a-8d9b-a26596864e7e;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f855522-38d6-45d6-88da-08da31ab7e94
x-ms-traffictypediagnostic: AM6PR10MB1912:EE_
x-microsoft-antispam-prvs: <AM6PR10MB19126026CA2D76F33E5ABCFDE0C69@AM6PR10MB1912.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wbiHmrRSXY/9WY0IXs3yfDVXGP2HQAwa+BY/o+Dm2/2NA1KbJESV4WCCr270jfvcZAslQnBuJUk4d9hrUZuQhLBGgleDJS+NiygDdhUv5N4Ve6OhBszLeOXmxBujN/YQ2Txs2Biwy28fFRfVVYPcf1YnenQo9BMPzrKhOizppIMCDyxcbYrVMH8ZElpWvk9am1jMPRHfem6JP7grOIyAn9wofOE5yyPh4PU4qBYNjvu8v5gdtDi4Xv3SHjcVZ6oQ02eTAOZYNbbywrSc7pZyIelo0BF7BX0wnnmZiGArHOsaNuBpj92IusxHfXA8Av9klVfIKxdkpQ1uI4pYjz/gc6HYAYTaan8PN8/YpnCYTGLC6ROx7wph29CS0cU37bWFY9anVkiWJmEBSzcWaef2nAFGfiZP7BQkktmAlNGhgyFHM/R8ZAEfB3IT71mBEUjM4R/FHmp1wxuTacCBxRS2d5vuBiZRhVR0g2YIXXs5C0mXbw6BxfcW7sZMWs7fazIy0+scnegP3g2H7qVIVGJ4lyRJobBZYzLBfgV8AcGugBADsrvzIpd5igYV28tEsIuqdjnc802BvTPH5d2CLYIvnPiun5U2Pppb0NnWEWVGeX2xzs+pc3A6bfYQeSifHN8fROGfhqMTJ636GYhZb9ccNnE2QxDgVMgGJozCitnMFcJBNGwod017anDfIhYNK0pfntcvAI1CSZKG98QE/86Gsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(55016003)(186003)(9686003)(122000001)(66556008)(4744005)(4326008)(8676002)(64756008)(66446008)(66476007)(66946007)(76116006)(52536014)(33656002)(5660300002)(2906002)(110136005)(316002)(8936002)(82960400001)(38070700005)(6506007)(7696005)(508600001)(38100700002)(55236004)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXJRakd0bERQLzkwQkZPOFlqK05NQmNYVlpJZmpiN2kydm91YlkwbE53SWZV?=
 =?utf-8?B?ZWZzNWJ6RlFxd2JuSm42N2Z5UnBmTDMyZmJTeHVVZWtJNDBRb2RCbENqTjMz?=
 =?utf-8?B?bk85dXA1RTFaNUlxS1pUM1dRNm1zOG16eTFUSnYzb080ME5EVVZIWmtpMDBj?=
 =?utf-8?B?UVdNVmp4TDl4ZzlaNjVWUWhZRTkwQ2RBZmhESVNkQVBya3h1R1djYlRpUTZL?=
 =?utf-8?B?YjcrbHZvdXRaT0tpeWRqVnFmZGZQMXRmNVRqNTNUSjFObzZPNnRlaWJDTzJo?=
 =?utf-8?B?a2NIbzJCMTE4cFQrYmFicEVKckpDSUNLZ3IzNFQ5Q2FmeFNMODBPOUhrNTNH?=
 =?utf-8?B?T3l3T3RWZ1QrK0VuVXZMSENVS2dsOWl5N0VWaUVzaEw4ajZuVHRKUzBkcWVk?=
 =?utf-8?B?NmRkK0xZeTlyeE81QTllYWlwOTZURmlPWnhkMUJaNWZzSWFrdm9QaWdKNk9r?=
 =?utf-8?B?bjNlL1VzdXFGaE9kNFRSMlZoZUxKZ1lwTk44dzd6eUpkY0NKQ3JQQ0FSTm42?=
 =?utf-8?B?YmtpYnUyZlRqaFlleDdJMW0rbmRvSE5IQ0RXRmtOdHhqZWtRR1V4ejFRRVNI?=
 =?utf-8?B?MjBqeUF5MnprWjl0alpZWWhxa2lOaDB3N01WRU13T09ySnFDcVNYVEFtZWdU?=
 =?utf-8?B?NWZNMGwycTZHSXhtdWhwYW5rT0V1V2hQV0xqME5lS202UlhOUnZRbGFxL1dQ?=
 =?utf-8?B?bHlDN3VpNDNRQ20reUxJOVFrQ3oraVZQNlpGdlRwTUo2dy9YUjd2L0YvK1Fi?=
 =?utf-8?B?TVgrcXAxQWxQN3pRUXY1dmE2Zk9MTm5DVHRHdVZLeE1hV3dESlJoVnhaWGZm?=
 =?utf-8?B?YkVhVlNTOHFIZWJGa3JuNDBrOS81MWlYWDJ0ZHZLSGE5OEZuR0V6dTdNZDFD?=
 =?utf-8?B?M3BMRWZjSWlXd2R0clF6cFd5bGYzMmJxUXBKUSs3Mk1LSm93QVZ2M0Z0c3hJ?=
 =?utf-8?B?eWp6Q2hTV2JVQ0FvNkNBR3o0VHZ4elpmUmRCbEc4dC90VTFsSjVBTXh3bGxm?=
 =?utf-8?B?OG83ejNVOW03SlBsdjZrUm1iN1VJcE8zK2pEK1VxU0ZjdWFpQXhJMnBnanR6?=
 =?utf-8?B?bGppTlZWVXZPVUlUMzBGaXB0alRhNHBpbXAwL3hvNGs1bjRqUUN2SzZrYmxo?=
 =?utf-8?B?SjYwR1ovZlhuTVRhMzdqYlQ0d24rV01yVzFWc21acVBLNzg1ZkZialFBcmFF?=
 =?utf-8?B?M0FpYkRubERlNlQwU25hVzYvU2twNlk1bDV4OUtiNmloVVd4SVMvQ0hHSU93?=
 =?utf-8?B?ZlBBdUZ1V1NrWDZ3OVBrc0Y1L2g5UFg0aUhyNHZpRmZpajdaZEJMQkR0Yk9s?=
 =?utf-8?B?OHJzM25WczBya1RPZ3BuaHNVT0VuNHhNYWlnckpMeUZzejFQSkc0OCs4OFNm?=
 =?utf-8?B?VUg1MDBLczhQb01kRDN6MzVtWDFEY0g0Mll3bER1NzZxR3ZkVUJqUXhRY2ZX?=
 =?utf-8?B?T0d4YnBEMitpdUk3S2VqZm9WYUUwNWZXa2M1ejVZbTlEcTU0ZEtqd3Y1Vk5R?=
 =?utf-8?B?cmtmOEZTc0NNTCtpNU4xTkdCV1pyWk5RTXBPajVPeEZPc0hLNHhqY01Sa0xN?=
 =?utf-8?B?b1Vqenc5b1ozdmRWSCtFd0prb0JXaFNLaTlWOVdHdVJvMEk1RkRjWlhWSlVJ?=
 =?utf-8?B?UWIxK3FVRGpYbjB5V0NMSzVYSXhLNU9sekVsUXZ4MkhkOVFFcTV4NDJBTmpZ?=
 =?utf-8?B?dWlzRkszSnc5dDlocloyRjA5dTM1UVU4VGJJeW95eVRnSllPL1VuUmNybVV5?=
 =?utf-8?B?ZlZWWUdra2N6UUtXYnFjdHpOQVM5ZUxhRjhiWkR4S0NmRW5iSzUvNWpzKzZQ?=
 =?utf-8?B?VElpOVh4aVd0N01kQjJGUlE4UXdEemVaTm82NDNkS1VYMU5mTnZwZVpqWmtv?=
 =?utf-8?B?TktrdGZBUHRuM0dGT3prbmNhNDFwK3NXd2QyRUhiNWcrUngvWFBLYVlSV093?=
 =?utf-8?B?WGJyWk1oSWhMRDdTSVE0NHlXMDFMaU9UUDg1VW02TDZJTWIwdzNCdFZxR3FU?=
 =?utf-8?B?aW44Tk5RU2xpOXJlVlZLcjVGSGpWV3VUMndWMWZCVjhJVi9JR2NHUmV2Wk45?=
 =?utf-8?B?d3ZHVHZadWdXKy8wOWVqWW1PZ3ZuQ0FwZlYxM0ZTK2FZZkNSMmZFTG1zalZM?=
 =?utf-8?B?QVFoMmtJTVBLazJFa0hLanQ2ZFNZYms4Wjh1RWxHOFpWZ041NWorcE0zZC9n?=
 =?utf-8?B?QVlpME10Y0ZDYmVRTE1VbkNOeFBBYVJwRnRJYVAvOXF1Rm8rdk16c0xCcFdl?=
 =?utf-8?B?V2pZODI0OFZwWTQvTVllL0lXbzBldUZlWXY5WlBzSktHOXc3RHZ1WXcvU3Ey?=
 =?utf-8?B?SFhpUHprR09QNVY0Ynh0NXV2SW1iSXNzOWRrTTdCQnFGZXN3WXZOVHpaM0Zu?=
 =?utf-8?Q?i6v4SGcMTuLj8+6A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f855522-38d6-45d6-88da-08da31ab7e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 11:03:05.8710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G19X78qOXMT5o15PSoynkuwE+QlsF73AALwqSowzQOQ58niv96CUHFLEEpETxkN6qkjhP8BgFHxytGPHbMTA0Ml8I+qPQkmqgeWxB89krMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1912
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICAgc3RhdGljIGludCBnc21fY29uZmlnKHN0cnVjdCBnc21fbXV4ICpnc20sIHN0cnVjdCBn
c21fY29uZmlnICpjKQ0KPiA+ICAgew0KPiA+ICsJaW50IHJldCA9IDA7DQo+IA0KPiBXaHkgaXMg
dGhlIGluaXRpYWxpemF0aW9uIG5lZWRlZD8gWW91IGNhbiBhcyB3ZWxsIGRlY2xhcmUgdGhlIHZh
cmlhYmxlIG9ubHkgaW5zaWRlIHRoZSBpZiBiZWxvdy4NCg0KWW91IGFyZSByaWdodCwgdGhpcyB3
YXMgdW5uZWVkZWQuIEJ1dCB0aGlzIHBhdGNoIHdhcyBhbHJlYWR5IGluY2x1ZGVkIGluDQp0aGUg
dHR5LWxpbnVzIGJyYW5jaC4gU2hhbGwgSSByZXN1Ym1pdCBpdCBuZXZlcnRoZWxlc3M/DQoNCkJl
c3QgcmVnYXJkcywNCkRhbmllbCBTdGFya2UNCg==
