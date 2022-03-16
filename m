Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87A94DAC03
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354317AbiCPHtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiCPHtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:49:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E45D1AF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1647416866; x=1678952866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1sCLpyC6a6fsxn19cvhK/sZpvKemstT65YqGTWDYZLU=;
  b=ynifysM6EY0mo9384MWeSxlkBHUPwBjiXMVDpLUS8NDzubVsRYIaNT33
   VupzbVRW+eTDQxQOvYsXj4tgq0ymg1z9wIHBY3GgVvXNgHxzq0NbonK4X
   YApi7vxCablzVFNnltJ34lSta9KoSh74Zjc74l6zB1/NIgm8H5o9+drgE
   1OHaIR60RRqcV3lnfP3YWDYhuV3fCFmiuSL0vJ8r4vAshyCmIIVjdDApy
   hAOSASMjW0gaquV+QQzNaU2FQ9DrHWhOnVQz4pSwMKt9jQsfHSXDvd4DG
   rlhqaNCirzS9P5hPalfXJJ7JjVgX1jZrChVpJ9Irka6rB/d7UTdENdvqa
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643698800"; 
   d="scan'208";a="89087735"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Mar 2022 00:47:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 16 Mar 2022 00:47:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 16 Mar 2022 00:47:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5PmZYsK8eWBTkSsgDB29lqLFXyjPOHYBmBRQj5LlIzbVdavTuNkql3zCIQoQ7yv0G6HtiOMJWq9aMfZm2hblN+0i6qvWws2wNzWtilv4ilU7a2qFDWHyegnCVy4VMlrmlLDdf4mnD50RFCufMIAtyXL9SEkN7gir4ilYbCrFRXKB28aiqvOCZUS8whFXtOnkDw/or8993PRZubHBXfEhg78ahbu3LKdXVr5FiKioTw/gpQuF/jqJZjGiLoww2cGeJ5uXzipyn4KyVsXjMUZEJOHFm+JBh+2P/UJxerxcb0uzJdfL9O85dEBaE4X5t6oUYSwcVFVdkQ5EonQ/flJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sCLpyC6a6fsxn19cvhK/sZpvKemstT65YqGTWDYZLU=;
 b=FSdCk6DWkPplrGkiycyDit4udTohKX59TesTNEgqZvaUPgUslL2irNcYSphg1ZuQwHQ3opSx1Az9IYRpcAwKfKXk1/U4UiulXCHqteGli6xyP2sIucG4QQ6mJMY2E5ePKwr34ctu/8M4mZg8HHAhcKA9CrkrtY3j9wfx2ka9gGDDdmZ88j9MVc+HJMTjXJw96RILzZOs/KefLfRvr8SYc3pLBP6aofgEjJPvYjytiszxsbDMcudbu23RPiIK3Cydjj1EP5YYQe4iPDCAs1xEugDpX2Y6NehauNn6L2vGYKnMYaKoT87N7N+EtkILEytRAqk91ErKSh83hknoU6SVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sCLpyC6a6fsxn19cvhK/sZpvKemstT65YqGTWDYZLU=;
 b=ihpl+XkyR5iAL4m5LxiwlVw9vq2mx88qEUSJSYKR0gM63/bRjCaDRNcN27pfwYqe7NfpFHuzR7U4nhKGL6GUJU9J6r+ScOH21ovuwiQUp/PgKI8Iue6RMU2gLgj5ZfzsuogpDe1gefwA2ENNTXRC5aNDDQqsF4rqctK2w1PjFhw=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BL0PR11MB3155.namprd11.prod.outlook.com (2603:10b6:208:68::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 07:47:40 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5061.028; Wed, 16 Mar 2022
 07:47:40 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Alexander.Stein@tq-group.com>, <linux-mtd@lists.infradead.org>
CC:     <michael@walle.cc>, <p.yadav@ti.com>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: Fix shift-out-of-bounds
Thread-Topic: [PATCH 1/2] mtd: spi-nor: Fix shift-out-of-bounds
Thread-Index: AQHYOQodYTda3weuU0+yf380GWE6EQ==
Date:   Wed, 16 Mar 2022 07:47:40 +0000
Message-ID: <b8d01f36-663a-928a-6dbe-64952b5bd8d0@microchip.com>
References: <20211106075616.95401-1-tudor.ambarus@microchip.com>
 <20211106075616.95401-2-tudor.ambarus@microchip.com>
 <5550605.DvuYhMxLoT@steina-w>
In-Reply-To: <5550605.DvuYhMxLoT@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71e7b21a-2b15-4626-5887-08da07213f98
x-ms-traffictypediagnostic: BL0PR11MB3155:EE_
x-microsoft-antispam-prvs: <BL0PR11MB315570D75A268FF33BFA9997F0119@BL0PR11MB3155.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4II6D7W0QAm4y1TQICSwl6z+4PxAjTtw6ZYyxYYJHKFiqQsnyzAvHDAilvtmPlh6kre13uTz3+YDvxTSS0mCpZjYH/vcIW2jal2QsBrtyRjDmguhdBeYoFgfoa0Rb9kH2FnsIW24rdZpsEklox0sJMp6jQTPMBUHFO0EgEUKnwZYU/TmpwFkcB7SX2pvyJBRBoMfS9lgFEufbqWQ/fDoNz4rGvGdgwl1JtRI43L9evPVxXmRAiVkC9xxEWbqdhnlrAkBlIc0J1qDChkK9xr6459TZEqXopWzhgh+d/4Z5rRdGxryLB+OIaAq4KRhHJQKOjUaEgwaGq+RSKLxFbNbj4xdBEM4tek7sRj+PopYJ5UO6moRR44DOeUYZh2Cjs4aZYTDoWA7NOkk5rdUq/8LsPPyTlEzSXtKZotYUpIQ7sTrJvXOEabeWOO3CnNHcJWsj04mdi6p1tht9z+Co6hJpUNgV8FuD3/VMYFAL8CVzcqLR1Fq9z8OkDPRUHhsgMlojRnSZbN+u8v4B9lIEprjFXQJBdJO5Q4HYL+PMjmAyrDk4djMNPor65TC7JyT2CDNH0UOWRlh8PkbQJr9St1HvK0lXiG5mWaiXdO3d3iLCMmAYL6JfIZSSZoeEfNHivywiaK4AiF20Xo52wvan2rUgfbNbb66a1oUuxzGPMTCRf5uguCed7gBdIYQASVSdUT4qsAfB7xKYSF33zzU+kOEz67tI5xFbewlIFzzi29254JKJC+/h/Vwejd8OyQFdRn9ybFsQIuMbn6Z3UNman4qAGfG3e5kMyW6wvxdV6VlXdNFsMzoFlZVOAxrxjYzkA5r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6506007)(6512007)(53546011)(66476007)(66556008)(66446008)(8676002)(66946007)(316002)(54906003)(110136005)(76116006)(64756008)(4326008)(91956017)(122000001)(71200400001)(38100700002)(2616005)(186003)(8936002)(31696002)(5660300002)(26005)(83380400001)(2906002)(38070700005)(508600001)(31686004)(966005)(6486002)(36756003)(43740500002)(45980500001)(10090945011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmNONzlPTHpwdDBVMEU4MmZwNzBYNGR5VXRkODFiT2lVT1Y1anp5ZnB2Unhj?=
 =?utf-8?B?MnVCTlZjK1BZV1FWUEcybnQrUkk1YURGZzVCWnM3by9Vbm94VWowY2dnT3dp?=
 =?utf-8?B?KzcrbzZRTFhtbGo4UHlrQ0tEMTVJYVZRRFl6RytyZUw0OVE1WVpBUnc1V2hE?=
 =?utf-8?B?OUdzQXBiQlNJQmlVc3ZSSWRQZlN3Vzc0UmQ2S05wcWdBZEdmSmlLMTJnMVgz?=
 =?utf-8?B?WUI0T1FlR1pYM2RWajhCNDBSclVoTEptQUNOeHhNbWFXQ3lKWk4yYmNJWGdJ?=
 =?utf-8?B?ZFV1VTBPRDVURFZIL1JvOThIWjgxa25LbmQwaVlHOE9pY1MwNDhYSlpuWnpa?=
 =?utf-8?B?L0gzWFBqTjFELytzUHk1MHN0YXNCTEUyQWJIYTRMc2VmV1hhdTROYTBqL3hR?=
 =?utf-8?B?NkpkRnBNQkl0cldkM1pkNUI4cGdGNjVJOU1GdlJLdnc3Q0tSTkJpaHdOcnZr?=
 =?utf-8?B?Ti9ydHlVTUFYVkFXWW5zcmNMSEZjOXVhK0xPRjM4OVJZZmxGeWVJbWNuZE5Z?=
 =?utf-8?B?UFp2aWZXeGo2MFZ2RnNCazlqNWdtWkFkTWtxNCtWdDNZRmF1aERvRjQ1VS9k?=
 =?utf-8?B?dFVSc2g0SElwbk1xQTQ0MkdYdDFJTW5uTnk2OUd1Z0gxTEVPM3YvSFpMWjlX?=
 =?utf-8?B?cVZtV3BSa2pZcjhrUGxRak9KSHRENXZETXFkMmFpYnB1Q2Ewc3FBdDMvTWhV?=
 =?utf-8?B?dU90dDFZOVppbVhFNE1LZGdQN0xNeTBhYkxaS1REemQ3cHN3QmYzN1V3VVMx?=
 =?utf-8?B?RlhCNG1CWkNSMHM4Z3BZNjR4YXZoNE9LRHVDbnRtVEtNa3I5WDBCblZjMFVo?=
 =?utf-8?B?d0ZYN2c5R0VGaU16VmpUQXdXcVlYMUpZT0NOSGRYRkp2bkpmS05BK0hlbVNO?=
 =?utf-8?B?OW1WREpoVGV6b1lWaHNWSmY0cU1mTHZhUjJ6ZVlqc2lvVTY3L2NmTWZKNzlT?=
 =?utf-8?B?OENTTjlKNlMvMnpWcXNOWVFwaFEybjY0WWpEMFFqOW4xeW43NFIxdEcwZjF1?=
 =?utf-8?B?VitUS3VpVEZEeEduRDQrQXNOODJBL3RiVVY5TFdGN2k4YmtNNzdBVTBIc29I?=
 =?utf-8?B?WUJGRm9JL0UvU3NNZ1JWcUZmblhNOU9XbWJiNWlOWjlrK3lKeEVOOHNnVjlG?=
 =?utf-8?B?OU9JSDZaZ1B1VjZoMXFRV2RiMVhBUkxTamNmeTJOQ3hLUURhVkVnVG1QbzNM?=
 =?utf-8?B?eFhtaVk2Si9RVHo5emRTaVF2czJ5TEFYNzB1RjV6SU5QYmdjNkp3dzRBaDZu?=
 =?utf-8?B?MkwwVnR4L042NERSQTViWDhiY3ozZlpQbUxhbk5nZEFBT0VEbWM3eTdiM1Iy?=
 =?utf-8?B?WDk1cng3SHhFUExBckZPQmJaTDlOMFFlVzdHODVna2ZaVlZzd3NjUzRESUpm?=
 =?utf-8?B?WEZnelNxQlA2R29heTRuN3NXZWZtZFhvYWxtaGgrazNqSERheWFBWlNGN0R2?=
 =?utf-8?B?ZENEandsa1paeEJoTWN1akVVbTNmOE9NL3RsSzhYaXppUnRjYVVTRHpoT1BZ?=
 =?utf-8?B?cnllakVvM1JYaUxYekVFZ29La1NkSlczUDRvZk1PUlpQVmZ0MExMcUw0VDZR?=
 =?utf-8?B?QVNCaWY3WmtBSzJ3UGUvZm5KZnoyVzMvclIxSDl5LzhOd0tvLzlpL0dCVmtQ?=
 =?utf-8?B?bDNod0pDVnRxUmlQbVRIYVprYjQ3WGZ6aEZETFk2ek5wN2NVVHNlU2ZVWjl5?=
 =?utf-8?B?anhTVmV6VFR6L2JtQXJtMjdhOEtLY3Q4c3lYdjgwZFphSEQ3clQ0VGJFOFF2?=
 =?utf-8?B?L0xBTTI4c215aDQ4V0U1dGFycFFnNTR4cVI4Z251NGFDOStsTnRHTU9ST1lX?=
 =?utf-8?B?aXdQc0xpdjQ5b3UwL1drRHh5YVErSnJTbGZ0dms4VFpTbXdSTmVodnl2UjA2?=
 =?utf-8?B?UDV1LzJpUWJhSklxaWRmK24zc0RsWUNQelBBaEQwUTNNNXFuOGFMVUxzREZw?=
 =?utf-8?B?RlBFZGYyZDQ0VGRQcEp3Vk9QQjlKbUorYVhFVlRrSDVZNG9lb1lCRXdKL1BI?=
 =?utf-8?B?WCtxTk9UYXhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E316F2577CC8074D937D3BDFCD324884@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e7b21a-2b15-4626-5887-08da07213f98
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 07:47:40.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHqGbf8+smFIWTnBAbAz/CGjjxwAiJVz6+ZfApQPL+tIpy9ep2XTFhJlqzLgdLYw/XSOI5eFen6Z53TSVleHkqFvifoNR+ICFhwhkJbXw8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3155
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNi8yMiAwOTozOSwgQWxleGFuZGVyIFN0ZWluIHdyb3RlOg0KPiBbWW91IGRvbid0IG9m
dGVuIGdldCBlbWFpbCBmcm9tIGFsZXhhbmRlci5zdGVpbkB0cS1ncm91cC5jb20uIExlYXJuIHdo
eSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVu
dGlmaWNhdGlvbi5dDQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4g
DQo+IEhlbGxvLA0KDQpoaSwNCg0KPiANCj4gQW0gU2Ftc3RhZywgNi4gTm92ZW1iZXIgMjAyMSwg
MDg6NTY6MTUgQ0VUIHNjaHJpZWIgVHVkb3IgQW1iYXJ1czoNCj4+IFdoZW4gcGFyaW5nIFNGRFAg
d2UgbWF5IGNob29zZSB0byBtYXNrIG91dCBhbiBlcmFzZSB0eXBlLCBwYXNzaW5nDQo+PiBhbiBl
cmFzZSBzaXplIG9mIHplcm8gdG8gc3BpX25vcl9zZXRfZXJhc2VfdHlwZSgpLg0KPj4gRml4IHNo
aWZ0LW91dC1vZi1ib3VuZHMgYW5kIGp1c3QgY2xlYXIgdGhlIGVyYXNlIHBhcmFtcyB3aGVuDQo+
PiBwYXNzaW5nIHplcm8gZm9yIGVyYXNlIHNpemUuDQo+PiBXaGlsZSBoZXJlIGF2b2lkIGEgc3Vw
ZXJmbHVvdXMgZGVyZWZlcmVuY2UgYW5kIHVzZSAnc2l6ZScgZGlyZWN0bHkuDQo+Pg0KPj4gVUJT
QU46IHNoaWZ0LW91dC1vZi1ib3VuZHMgaW4gZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmM6MjIz
NzoyNA0KPj4gc2hpZnQgZXhwb25lbnQgNDI5NDk2NzI5NSBpcyB0b28gbGFyZ2UgZm9yIDMyLWJp
dCB0eXBlICdpbnQnDQo+Pg0KPj4gRml4ZXM6IDUzOTBhOGRmNzY5ZSAoIm10ZDogc3BpLW5vcjog
YWRkIHN1cHBvcnQgdG8gbm9uLXVuaWZvcm0gU0ZEUCBTUEkgTk9SDQo+PiBmbGFzaCBtZW1vcmll
cyIpIFJlcG9ydGVkLWJ5OiBBbGV4YW5kZXIgU3RlaW4NCj4+IDxBbGV4YW5kZXIuU3RlaW5AdHEt
Z3JvdXAuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1
c0BtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMg
fCA5ICsrKysrKystLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5j
IGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+IGluZGV4IDNkOTdjMTg5YzMzMi4uYTFi
NWQ1NDMyZjQxIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+
ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+PiBAQCAtMjIzMCw4ICsyMjMwLDEz
IEBAIHZvaWQgc3BpX25vcl9zZXRfZXJhc2VfdHlwZShzdHJ1Y3Qgc3BpX25vcl9lcmFzZV90eXBl
DQo+PiAqZXJhc2UsIHUzMiBzaXplLCBlcmFzZS0+c2l6ZSA9IHNpemU7DQo+PiAgICAgICBlcmFz
ZS0+b3Bjb2RlID0gb3Bjb2RlOw0KPj4gICAgICAgLyogSkVERUMgSkVTRDIxNkIgU3RhbmRhcmQg
aW1wb3NlcyBlcmFzZSBzaXplcyB0byBiZSBwb3dlciBvZiAyLiAqLw0KPj4gLSAgICAgZXJhc2Ut
PnNpemVfc2hpZnQgPSBmZnMoZXJhc2UtPnNpemUpIC0gMTsNCj4+IC0gICAgIGVyYXNlLT5zaXpl
X21hc2sgPSAoMSA8PCBlcmFzZS0+c2l6ZV9zaGlmdCkgLSAxOw0KPj4gKyAgICAgaWYgKHNpemUp
IHsNCj4+ICsgICAgICAgICAgICAgZXJhc2UtPnNpemVfc2hpZnQgPSBmZnMoc2l6ZSkgLSAxOw0K
Pj4gKyAgICAgICAgICAgICBlcmFzZS0+c2l6ZV9tYXNrID0gKDEgPDwgZXJhc2UtPnNpemVfc2hp
ZnQpIC0gMTsNCj4+ICsgICAgIH0gZWxzZSB7DQo+PiArICAgICAgICAgICAgIGVyYXNlLT5zaXpl
X3NoaWZ0ID0gMDsNCj4+ICsgICAgICAgICAgICAgZXJhc2UtPnNpemVfbWFzayA9IDA7DQo+PiAr
ICAgICB9DQo+PiAgfQ0KPj4NCj4+ICAvKioNCj4gDQo+IFdoYXQgaXMgdGhlIHN0YXR1cyBvZiB0
aGlzIHBhdGNoPyBJdCBpcyBub3QgYXBwbGllZCB1cCB1bnRpbCBub3csIG5vPyBIYXMgaXQNCj4g
YmVlbiBzdXBlcnNlZWRlZD8NCj4gDQoNCkkgdGhpbmsgaXQncyBtYXJrZWQgd2l0aCAiY2hhbmdl
cyByZXF1ZXN0ZWQiLiBJJ20gZ29pbmcgdG8gc2VuZCBhIHYyLg0K
