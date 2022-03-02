Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745634C9DAD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 07:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbiCBGSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 01:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbiCBGSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 01:18:42 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28C750070;
        Tue,  1 Mar 2022 22:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646201878; x=1677737878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PFf/xLBV+paY2WOKOvnRCgxQIASk+94nnxTqoP/kdLk=;
  b=XO2jnKwtikUhdTbPN353HVdrl84DUc5LBgm9EmGPpXOtLYLWUlWAPSA6
   EORPXOCaGhxnPjuDwCeLASZxuT66ArU9cOL9yKWv1NQ3GXaptxUNdgmhY
   6polel6Nozrp3KF1B+dyLpIjYoEh+Fsa4E5iEV5/4nKRu2rEQwIKU8eBh
   BS5rW6NK+axEQd4rROnPaPAWJUBHNm6wGp2brLs9N4mtlmBJXX2pdKXQU
   Idnctq+2r9YBdOt8g4zZMxb20eQaeMcWPzrLo5M+GLfCLlzu0FnJ/o0MR
   8sxaxvKPI9Yym2tvkY7ByMt7+kSsMAVsb3aUDXtIsFGqNjk4usV/8R4Ff
   g==;
X-IronPort-AV: E=Sophos;i="5.90,148,1643698800"; 
   d="scan'208";a="164170971"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2022 23:17:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 1 Mar 2022 23:17:56 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 1 Mar 2022 23:17:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRBHUrXEqYSNQgcg1KqiHCldbsMhOCaBdnHk48zjetZxO39RrP2m5dUuWzmtsso/h6rjx1JiTmlGMx7zE2zkXYq7LkcvduJ1dTAJqIojStWJPCIBoqmBw82hPu19imjrWKNXMHfvk/I3PwqM4NKrUdK37I+e8rcTFgVi3LEgj7vS6fix8diqpmDcbEbsocsuErWhETAbIpFdmurXOfK2BMkt5HwIql7oRjt/+JYti6TuiIeZWdScMbStm3AMt7fSgWJ2r3cvSVZLwFcycT9ij1ONIk8GIo91a5EDDL3Uq2hT3cbKYOJIo36GuD2dH9S3CMYunlKsCnrinJbaz5JxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFf/xLBV+paY2WOKOvnRCgxQIASk+94nnxTqoP/kdLk=;
 b=dyDxI5P7Geyaut5zJdbmwXsIhPQVloRt2Rs12uejTtr/gF/pOlY7+ZnENkAYFbVQtu8117l7NWrA6Hup4/nMHM+1PEsVveZWhDw5kdXuAqHjVcMRT9ikgW5KMLVl7llzncMA5ZT3QcUvkCTcTTwwapbKdLgCaFKoFQkqATcU75p9Av7llMlJSId3sqJ+G11/fPiWQKgjlcmtpafoPlpNPs5eoiLIVLlFwHaf+Tw5J4QKx5kRrNeYyLbgqwtKk92hituIkR3DNgGjjLQgmMABiadnJi5OIG1Y8RsnxutH/rjtkFy/E3cRvHYSa/qdlTcp2gLP0d1M3TURGt4or4c03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFf/xLBV+paY2WOKOvnRCgxQIASk+94nnxTqoP/kdLk=;
 b=KtzCkfYFfa4ZhAdIc35BEOF6JqRmWexe6yFHvsX6IrHyhASuddZIYVX2cd/0mVhM3iJnA7u8/ySlbTctfiDC2d7mA9WGmc4oBKxXx1Z2kY5OFj/yY64+uTs1+tFFHkpWTuylDeBRfqX6XWaYl6kNZYtE5qBmeegKjoFVjDKnDSM=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by DM6PR11MB2539.namprd11.prod.outlook.com (2603:10b6:5:bf::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 06:17:50 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::11a5:42e0:3f3d:fcdc]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::11a5:42e0:3f3d:fcdc%9]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 06:17:49 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <linmq006@gmail.com>
CC:     <mchehab@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <hverkuil-cisco@xs4all.nl>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] media: atmel: atmel-isc: Fix PM disable depth
 imbalance in atmel_isc_probe
Thread-Topic: [PATCH v2] media: atmel: atmel-isc: Fix PM disable depth
 imbalance in atmel_isc_probe
Thread-Index: AQHYLTyv2eV9YsEfvUCD0pCSaw20wKyqjEgAgAEKioCAAAktgA==
Date:   Wed, 2 Mar 2022 06:17:49 +0000
Message-ID: <396f655f-6baa-d974-960d-5b436325e2d5@microchip.com>
References: <20220105111056.4662-1-linmq006@gmail.com>
 <20220301071859.24285-1-linmq006@gmail.com>
 <4661c8c3-8975-d1f5-9728-f7d1d585437e@microchip.com>
 <20220302054457.GA1088@VICKYMQLIN-NB1.localdomain>
In-Reply-To: <20220302054457.GA1088@VICKYMQLIN-NB1.localdomain>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caeb994b-e738-47f5-de17-08d9fc14608d
x-ms-traffictypediagnostic: DM6PR11MB2539:EE_
x-microsoft-antispam-prvs: <DM6PR11MB2539F3A0CAD5C04D65D3186FE8039@DM6PR11MB2539.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v+IEkkQZw3FpElNmhlVs6JUgEXJAgc2xkvP/A4NCEl6oMz7T1/zPQZQjZYgtMz+8/zjVJU4tTsWTNP7Bfx+DO3SkZVU7RRcxCkMlFItCfnMJZyIrvgwS11f3Gd8T2NDqo3CTRH7YBicPs9LYxEYDsiAC/vCSWwTEntQAIL16zvIiPt3Jn8EeXD8rooRFKDmbvhFlGWSEvueJZG0IprHcRzHqv0MlJOa8KVBlz9+Alp+FUMX89CcvlypTVnlG4MjgTvah4hB/L7lWlkFySsJ2U5xlP1pXuJH2sQ2ihH9SaRjBtisKPDCht5TEJ2g78aGUytadYJUfghxj2b+QvlJyUaqyh0gaYzZaczALbeFkK6A1Zfr4Jz9dWRGRLO7IztAB/A5rpHqFsjJkEk4cLTmQQvwpBTCpC90n8TdcI/mqL3dcPGMwKBgm7QOFjb7b/3EwoZuiWh4auvGU3HbsKfwc5JMlJTedoINJtEZfqGNpesevp8GZ5zImQ8w6dNm6jdFO/j7olO9FkeaiZir4PeUnA8XzCN/7DB+SnYb9yqxflU5dnDzQjvx5w1a2JR8fxR23L49j7fC+uq+1EzBtVLBqou7N/Mp/jCkpYsqzroCkxDCDaGifZMfk/Wq8TStl5AoTMEnHwXS2oMjUfad7BDsZHJgaC4Y9UczU/iR4n8hPEigDnF+6qh6CJVnebaGfRBoo/iQs6rtkqA1lJWX3CYvcNECvbFsusQYTWFZgeofuoF3KremLwYpZgdAZyMeyKZjLQ8lRcJnf2WzbdH5gTU9N7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(6506007)(6512007)(6916009)(31696002)(122000001)(54906003)(316002)(71200400001)(508600001)(31686004)(6486002)(38100700002)(8936002)(36756003)(83380400001)(2616005)(8676002)(2906002)(26005)(186003)(4326008)(5660300002)(38070700005)(91956017)(66556008)(66476007)(86362001)(64756008)(66946007)(66446008)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1gwY1Z6Y2RKaG5xRDRwRDVNd2QrRloyTHpZWUFCNWZJWWRhdUptRSsyK0wx?=
 =?utf-8?B?ZkxTamhRQ3FhV1VvZlhwOXNSYkV3TDN5Mm4xR0JUQ2taYVBIYzd1aXhia1NG?=
 =?utf-8?B?dklYaWR4a0czSklTZDBqSVdxMjM5d29XZnBSSjgxZCtFcWNqdmNsejFCNENY?=
 =?utf-8?B?UTVrckRXdFBBZVlaN0pYOS9OOHl6YXozc2U1eDFQT3NvdkVLMUh1Z3JsVzhJ?=
 =?utf-8?B?YUtjRStzMzl4UVN5NmdCelAycW9TN21HOUo0dXRkMUQwRFhDSnQzdklMTUtn?=
 =?utf-8?B?OGFRV1VtNk8xSnpmT0xnMnBlV0tuWExkWGFNK0p6ZWJRL1IzdUQ5UTUwaHJN?=
 =?utf-8?B?ajdXa2JnRlVQcnVEM1Q1SGordlgwY3ZjaEtuYXFvSjRoMkxGMlFIZ1dvcFhq?=
 =?utf-8?B?TndkcHlUa1J5Q0kzTVIxb1hHcHpMM1FKMUhqTDh0SXlaMUVoYmhOSlBGazNN?=
 =?utf-8?B?U1lvZmJNdE9UQzVUUW56a3RWbzZ0dWFEOC9Oam0rRVFzYTIzR1ZoKzc5d1Rx?=
 =?utf-8?B?OHIyTkFvVTBxWXVjRXhBdGxUOUZuZy9wSWVncXFsbW5sUkl6STc0Q1hPRk1p?=
 =?utf-8?B?UGdwbUNJb0diSVF2dUNoMnhYSWRHbjBmY0NLcVNMUEN6c3FYdEZqbTJ5L1ZH?=
 =?utf-8?B?UEVTS0ozM2UxeUZYUVNDa25Fb00yUmI1ZVI2VjJXK1BQRUd3dGk4eWltRVdn?=
 =?utf-8?B?cnh2NGMrbU1xN0x1QjVIMFhoUnRlemtLdmszU3VQOENFYlE5Tkxla1ZDOSt3?=
 =?utf-8?B?YVYxWDZJWFZuM3k0TERIUy9wZ1FjQmFzSkJYUnJVME1OMHZ2SWdubFZTNm5o?=
 =?utf-8?B?N3RBV0MrZ2lTRlNjRk1ST2gxc20yMXBncW5aTkVGeEwxSFhibnlPYno2RGdC?=
 =?utf-8?B?RmlrbUN5N2RYa0duQjJ1ZkpMaENSaVJ1K3pwUGxOSXN6RnpDcG9tNWlBdndP?=
 =?utf-8?B?c3ZCZ1BPclVnWjFOc2x1cys4dEJ6MnZXRy9RcEQweDJ0R20wOCtBL3IxK0Js?=
 =?utf-8?B?WnBoRkxGQnZDWnViYytrVW8vanNMaHRhU3FzTnVBUnFzV3BYMVRqR3d4dVk1?=
 =?utf-8?B?UU9BTFlrbDBQdHVUNGx5ZkJtMkg5TXpqZVJXYzc0NFJLQzRMcUNlTWg2QTUx?=
 =?utf-8?B?TUNJQmFvWnEvaTJaaG5pcXY1WUN3a28yNTAzeXNqTjRYL1E0WlVMVUhDdlNj?=
 =?utf-8?B?OWh5bEd6U1VJM3NCU1lHcTN6ckdWdXoySm1IdTNpbTlOYWhHeTV4dGE2TzBL?=
 =?utf-8?B?U3hBUHBVZ2xSSVhzMWJXNVp0Y1luZlVFZXU2QnpYRisrTm5yS2lQdHJ0cFFO?=
 =?utf-8?B?VGRtdGtsQUtKZUhnVlB6NFdjTitNTHAraUVPUmY1eDFIazZBME54T2dxTWFa?=
 =?utf-8?B?RXgrZ0g1STljVWdLRUxLZEdZL3NqL1FyZDI2SDZFN3JWM0lVQ0sxNzVqRUN0?=
 =?utf-8?B?RU5zOTlnbXltTFBsMzdkSFgrSmh5Q3ZZcjZIcXRCZnpSRHB1Qmlpdyt1TXdi?=
 =?utf-8?B?NHhaR1p3eUlLUU9WaDY2d2I2dGVGdG5NRTVxOTFDMmZPcWdMSHFBdXFOVjRq?=
 =?utf-8?B?ZHovV0MzRVJodzkyS09uK2NpaGhndzZDbzNiQUpCMitsQS9hTXBUL3FyZXUx?=
 =?utf-8?B?ZWJZYTBvNVJyWlk1bDVhcDJmVjdRbGJIVVJBelNQbTV2WW1zcWtqU1lYNzI0?=
 =?utf-8?B?SHh6ZDZIRjQyMGtaK04vQXR6aTRJc2Y4aFI0b3JsbFA0c3c1Y0R6VDVkalVt?=
 =?utf-8?B?eTRyalIwcGVHSjR5ZGdWNFpKMUNqalRzYk9SdEMzUkNDLzJmUmhGK2pzQlIz?=
 =?utf-8?B?R0xqSEdIZkZPZVM1aWVaU3NvK2tKYy9QWHFRZnVPS2VYbjdUTWNhSll3elY4?=
 =?utf-8?B?TzJBcm1JUGRGUHFia0Z4UkxPTHB6RHgxWVBKUnRKMDZtVXZuV0ZKNDJXMVY1?=
 =?utf-8?B?djU4V2JTQlF6U3RiZWZQU25FeTZjYlZ5Q2xNQlNqeDE5UEF2SDVMQXV2azNJ?=
 =?utf-8?B?ditYVU42WWV1c0tWV3FnQ0hrVzh5aEhpNE9XZ3cvSjV2NW1maUhENkljZUJL?=
 =?utf-8?B?bHVuN0x1WDhwSTZ6VGFxL2E4Mjh1LzdWdGl1ZnpTK3JGdHdpTFFnNCs1Z0JK?=
 =?utf-8?B?WVRvdTZZcGViM0ViRXhoQWFveGNXQzhwZWZRb04vRVJTRWtLUUVnRXlYcklv?=
 =?utf-8?B?V2cyemlBR1dVZmpEeC8zUXh3RUc4T3YvZko0OGxEditQaUw2NVdMY2RHeWw2?=
 =?utf-8?B?N05pNncvTG9OTEwybFNoNDNzWmZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0DFFB5BC82AC74EA1B52896B64F12E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caeb994b-e738-47f5-de17-08d9fc14608d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 06:17:49.8154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIb/3FoeJNLg2Le1JJ66XYRuO0d1fml9A7PDmWwSJ6RQ70Khnz4pYyiLfDmY7h9ZuSDAC1NQPHF5cAVulXn0xH5znjofMpsC+RBVggBmC10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2539
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yLzIyIDc6NDQgQU0sIE1pYW9xaWFuIExpbiB3cm90ZToNCj4gT24gVHVlLCBNYXIgMDEs
IDIwMjIgYXQgMDE6NTE6MDJQTSArMDAwMCwgRXVnZW4uSHJpc3RldkBtaWNyb2NoaXAuY29tIHdy
b3RlOg0KPj4+IC0tLQ0KPj4+IGNoYW5nZXMgaW4gdjI6DQo+Pj4gLSByZW1vdmUgdW51c2VkIGxh
YmVsLg0KPj4+IC0tLQ0KPj4+ICAgIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwt
c2FtYTVkMi1pc2MuYyB8IDIgKysNCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9h
dG1lbC1zYW1hNWQyLWlzYy5jIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1z
YW1hNWQyLWlzYy5jDQo+Pj4gaW5kZXggMWIyMDYzY2NlMGY3Li43ZjFlYmJiMjU0MzcgMTAwNjQ0
DQo+Pj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1zYW1hNWQyLWlz
Yy5jDQo+Pj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1zYW1hNWQy
LWlzYy5jDQo+Pj4gQEAgLTU1OSw2ICs1NTksOCBAQCBzdGF0aWMgaW50IGF0bWVsX2lzY19wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4+ICAgIGNsZWFudXBfc3ViZGV2Og0K
Pj4+ICAgICAgICAgICBpc2Nfc3ViZGV2X2NsZWFudXAoaXNjKTsNCj4+Pg0KPj4+ICsgICAgICAg
cG1fcnVudGltZV9kaXNhYmxlKGRldik7DQo+Pj4gKw0KPj4NCj4+IEhlbGxvIE1pYW9xaWFuIExp
biAsDQo+Pg0KPj4gQ291bGQgeW91IHBsZWFzZSBwZXJmb3JtIHRoZSBzYW1lIGNoYW5nZSAob3Ig
c2ltaWxhcikgaW4NCj4+IGF0bWVsLXNhbWE3ZzUtaXNjICwgYXMgdGhlIHNhbWE3ZzUgSVNDIHdp
bGwgcGVyZm9ybSB0aGUgc2FtZSBhbmQgaGFzIHRoZQ0KPj4gc2FtZSBidWcuDQo+Pg0KPiBIaSwg
RXVnZW4gSHJpc3RldjoNCj4gDQo+IEkgdGhpbmsgeW91IGFyZSByZWZlcnJpbmcgdG8gbWljcm9j
aGlwX3hpc2NfcHJvYmUoKSBmdW5jdGlvbiBpbg0KPiBhdG1lbC1zYW1hN2c1LWlzYywgYW5kIEkg
aGF2ZSBsb29rIGludG8gaXQuIEFmdGVyIGl0IGNhbGxzDQo+IHBtX3J1bnRpbWVfZW5hYmxlKCks
IGl0IG9ubHkgaGF2ZSBhIHJlZ3VsYXIgcGF0aCB3aGljaHMgcmV0dXJuIDAgYW5kDQo+IGluZGlj
YXRlcw0KPiB0aGUgcHJvYmUgaXMgc3VjY2Vzc2Z1bC4gSXQgZG9lc24ndCBoYXZlIGVycm9yIGhh
bmRsaW5nIHBhdGguDQoNCkhpLA0KDQpZb3UgYXJlIHJpZ2h0LiBJdCB3aWxsIGFsd2F5cyBoYXZl
IGEgc3VjY2VzcyBwYXRoLg0KDQpZb3VyIHBhdGNoIGlzIGZpbmUgZm9yIG1lIDoNCg0KUmV2aWV3
ZWQtYnk6IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCg0KVGhh
bmtzICENCg0KPiANCj4gcmVnbWFwX3JlYWQoKSBmdW5jdGlvbiByZXR1cm5zIGEgbmVnYXRpdmUg
ZXJybm8gaW4gZXJyb3IgY2FzZXMsIGJ1dCBpdA0KPiBpcyB1c2VkIHRvIGdldCBNaWNyb2NoaXAg
WElTQyB2ZXJzaW9uLiBJIGFtIG5vdCBzdXJlIGlmIGZhaWx1cmUgbWVhbnMNCj4gdGhlIHByb2Jl
IGZhaWxzLg0KPj4+ICAgIHVucmVnaXN0ZXJfdjRsMl9kZXZpY2U6DQo+Pj4gICAgICAgICAgIHY0
bDJfZGV2aWNlX3VucmVnaXN0ZXIoJmlzYy0+djRsMl9kZXYpOw0KPj4+DQo+Pj4gLS0NCj4+PiAy
LjE3LjENCj4+Pg0KPj4NCg0K
