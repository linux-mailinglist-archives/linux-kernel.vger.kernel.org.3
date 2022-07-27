Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7A1582195
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiG0Hyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiG0Hyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:54:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C72142AC0;
        Wed, 27 Jul 2022 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658908472; x=1690444472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=agd51NtRMUcahIGsp9++obDL8n/Qvm0YI4MgDJPmEjo=;
  b=B69arknxwbQRzQg0l1qCRYLLRxeY8dNSwAFCRZmojXPKFu3LXDlAyWOL
   FdZHRbRJSvsfEYoRjnkx3nJ9mv4FHuJeoHpc9Mw6s5BRX/gmk2ylgCjX5
   OacluOaNQds7tTmL0v2FF2bEw3bIBplpCekVkhX9LDkpRd7heC2Ti6NPl
   snbYQdCtMIf35eNlD4SRxazWxeIUNl6sWpG9Te5LBHnjxB/xRmJAMd6bs
   g/6ZIEuUDk140j4wzxLD+JQ4WGj/GxGS+UiJ2D1cdSnxt71OxU7LtsFwW
   t9C11edSXLjmU39m1jioodKWJm1ghd5qrnFQgQQnCKIsxVOUuXN8GH6ld
   w==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="183923209"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 00:54:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 27 Jul 2022 00:54:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 00:54:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/jfG5Uiow4lMrPPq89RBD5sT2GuHM0XGISw0ATSEPn9V5kTaMTY4SJ54vAgKNvPewf3GibgkeEyCX6JDSHMK66sKQcqYrKToXdCQW7DNyevlwWK5NmhpAD6bHxHLpCTFrFzjEHoCr2FaIL+Jia74K2gAuWYXrmyNdBJxj7ebGrYxPWG7vaH/BhZXfiSBC+5q103+bnYGaMyzuJ2Lh9HkFygxleUdn9dZv8pyuA3OyAcIHOw0r0a90hk50Y5NDVDwkrwYz4baiBG8Y6/FcGWlS6db66pZTKAinkU++8ASTmO1mK+jO1P8zA8i617QNK8jDFCE6L8SdXmp00c0MfdYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agd51NtRMUcahIGsp9++obDL8n/Qvm0YI4MgDJPmEjo=;
 b=h2zOKiRQ4gME3wTar8D61QLI/f6tSUJKybGklErJq7cuIe4P29giaI1riGCmKxxVEQUwypu0iti1SPahx5CsN17wmuTWF+aizUEUZiqLn4FsBTX/2Ih0S46GCSbdb7QTgVtj2XrRz+T8OR9+bWqtW3ybg+RkxgqZjA8lThhONuF9e/9DrXIEA32D514N9aOMwstsLqZBMOfvkdWxFyZfRk3qejT0xIgx7AWTSptfDlU1eddmjojwe3amVdXdkapSfCTzqX5sGY3COOiS0SyUIOlcLlQo6ZeIAIn+SBDuH6V3VZezgDmaAwGTcLkF9i3/HujYslKe+M1F7c6dbS/MTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agd51NtRMUcahIGsp9++obDL8n/Qvm0YI4MgDJPmEjo=;
 b=m8Y87hWu1YsGxl59c389XrBpYCHXceqJSUZPkS1RHdu7VJJZ4i/fgjYFgBakpIIAhCzK3QHnVMRmOvmdWVU9nCc/EqKFsp/p3oCU10/3isZZA10qoBIdkLQhZCcmvXe4EOYwgkAApBJDhcEEdcPdScOKtgEWjRBPKkBt6k5oYuk=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN6PR11MB1651.namprd11.prod.outlook.com (2603:10b6:405:e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 27 Jul
 2022 07:54:22 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 07:54:22 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <arnd@arndb.de>, <olof@lixom.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <soc@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: lan966x: keep lan966 entries alphabetically
 sorted
Thread-Topic: [PATCH] ARM: dts: lan966x: keep lan966 entries alphabetically
 sorted
Thread-Index: AQHYoY4VGnqtrlDt+0yB0t0Kxru9wA==
Date:   Wed, 27 Jul 2022 07:54:22 +0000
Message-ID: <788aaf63-be6c-2dda-4920-b71037301518@microchip.com>
References: <20220726084931.1789855-1-claudiu.beznea@microchip.com>
In-Reply-To: <20220726084931.1789855-1-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76371372-e2d6-4019-a67f-08da6fa537ed
x-ms-traffictypediagnostic: BN6PR11MB1651:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gqyf/q2CpKzloYoHNGjoBvmpsAJhDKRXcp6GtNWzK21nzmKM/rLzS7GZqCT+XAj3uITIc41cad86v8KKMmew/cluelXaFm0yW7WqK+cSlucZMyMV9+fetSqXVjcbNGjTNPhaWB3yLBaP551t65hmvqovzTNC+/gIG7SshUAPzLhDrNjghhPzOeEt+bI+4d3dyL2IuM4QGSzC0Sh2EDwlQ9Do/RcUBvrRgcXpA5io4pfgZJT7gHb+d3tZE2J3uEH+cwriIy9/HBTFbXxAWbsSgONXfpNdAjv7JSTox6C5llEGN6JFIDqI1xz+QDU/Xcy4jvRslv+RWmkVsbnAKWzQCYbiocdGN19vUwqtTajXaABhY+s3IwTsJujdjKJsCwPdBUpG9L5EoYtNGbaVIbPBdf1vOLFrl1vE/+DO7GTVJ0VQGDcf8oPtxCYz8tS9ddwhI/GmcDABmIJpYOE0fiEUwHb5HI/X5H+F/7NwUKepQsDEEox85U9yNkQayiXhox7Mra64zp7AXBs8kemzngRgZkGkpHT0r14OBo57rjKFOYjLm9yln03NsUNw99BTojU9nuv/P3gqPheN7JPwQ8hGQTfc/7m8zTSVXbEx212ilCSAv+uJhu2y7aYzjt+inAsUZevd07uH7kHrgB5ENknaUytQASSKkiv635rjrOLKr4pWOfSIjSrv6ZuanTpGPm5huNuAeP9qxSvIOcrYpLqCkH7sbhoOEbCCyxv+9aVXn9Guf+XsV5iq3nvVF+czx74CP4OdTW6EkXBpf1lJWflkPsfj1FK5+ZkEngB7i36M8P2awEVfpdo6a9pTLjfUpC+ety8W/mqmN6Mp3JNpHcMSNRuWCx3GLa+Jm2BGqXzV4HgcRchxaV9fGXuPx/PvIBj9GdF2KjglvJ0zxnbMPXExuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(396003)(366004)(136003)(38070700005)(66446008)(66946007)(66476007)(76116006)(71200400001)(53546011)(186003)(66556008)(41300700001)(2906002)(4326008)(5660300002)(8676002)(64756008)(6486002)(8936002)(478600001)(966005)(83380400001)(122000001)(31686004)(54906003)(2616005)(110136005)(316002)(36756003)(6512007)(86362001)(38100700002)(26005)(91956017)(31696002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2h0VGF4aGkyRFFHOUJ6aEVVOEErYUMxd09IT05kaGRxMzQyNWZYOGhhY0I4?=
 =?utf-8?B?VDhWV2Jhc1Z0aDNVTktSWi9HYlg0SkJBU2g3YzVpN2xvaVZjS1NGRmdpZ0Ry?=
 =?utf-8?B?MXZ1cHdhZjV1ekpvUkJIOEM1c3RtdzA1SDZNUnBoVHFHQlJZUjJlYkM3TGpw?=
 =?utf-8?B?VXJ2TXhxQStYblBnRFlOZWtsMjB4RndDbVZ0bzNIQVhTc0lBUmI0Vjlyd1N3?=
 =?utf-8?B?V25nWE0wdUF3bVRzcUU2NVBFUXBMQUJqSW9mUGNWRzJwL2crRktpdDJ1cmNJ?=
 =?utf-8?B?OTg2NC9Ld2FOZnNKc0xsMEptRWNNYXVFckVxVjh1ZDMyUEIvcGN5bGV4aVFK?=
 =?utf-8?B?cjlwWmxqUTVic1d2ZG00Rm1udk5hTDNBQ3FaMzhyN2lNT0V2UEpZeU5yaE9k?=
 =?utf-8?B?WkdWajBhZVhDSVpVTzIwbG1RaGRQRktIN3RQUHFiZGVJajhsV0g5aktvQm0y?=
 =?utf-8?B?NWRienBlbm9YRDVJdzJJQStNYlA3aHIwM2MzbXMyQ21Fc2VqaERXZ1diWHVG?=
 =?utf-8?B?bDNQSTQxVzgvOFBLdjNxUkpQOGtTVDdFY0RxdzRBVlQ4ZWRlRk56Lzh0QmFw?=
 =?utf-8?B?ai9kQXcxTkRiSC9MS210UFJrWWFKK1ExSmIzdGtUUkQyMHZrWDM3cWJYQkVj?=
 =?utf-8?B?dXJNbnU1WWxDa0ljMkc0enJrKy82NFlrcHZTdkhTTjRDbU9GY0lMZ2FrY3Rk?=
 =?utf-8?B?bXN5VGhtY3gwNFZJbGt1RFpYL08yMmZZK0k5VFZEZGw5SnZvRXFpUmJKM2kr?=
 =?utf-8?B?OVpQSXNjbE9SSXJqQ21XRnBkQ2d5YUpReS9yWEh5VW5WMkxOUVl1ZkhrbWRC?=
 =?utf-8?B?bWNzck5uS3h5V2hNZ2tiQUVSM3lPMGp3S1kyRHpBL0tuQ3UwVlJjbXk4dWdp?=
 =?utf-8?B?ZnRqRXkyL3RHMGZhcWF1NFlCanJCUjNBTlBCQ0k1ZE9LNEd2TVVWSStRK0hs?=
 =?utf-8?B?ZjVvcFRDZUk2Y29UT3RlTzFOTjZaOXdUMU5VbmlhMUFaNG5xU05ybTR5MUMr?=
 =?utf-8?B?VFRSeG5kdVlpUndQSTZ3dEZLbkxiUEhHTlRpWUFIT1hDNkJPUkhER25ZZnps?=
 =?utf-8?B?WmcxMVhCM24yd2xZd2xMbG9IQi9vN2d3cFV0YVRaMzlEQWlzZVlpMmVZdTc4?=
 =?utf-8?B?bE92UWxXZ1hMRjFGU21XYnZLeFRMZVRrMlNGWUZBUTJtTWhyMzhiaFdrWjF0?=
 =?utf-8?B?UkdoZjAvay9aOXhnNGNsODBGZXRMNGV5UXgwK1ZCV0d1cUdXL3RFbWl4em5r?=
 =?utf-8?B?ZHArK2VRNGZhZlNWUGVHb1NmMEovRVhmWi9DMTY3YnpNRUp0czRQOEtoaFky?=
 =?utf-8?B?OWVtbDh4RnVvVXJOS3RDS0NWRHlJVDlPUlc5aVgwL0tPMmtXVWJEUm9NTzEr?=
 =?utf-8?B?KzVCbXFsZTZCcFc0U1J1RGFFZmNRS1A5T2tOclNaZGp1UFpJRkh3N0VvWWRK?=
 =?utf-8?B?ZjVUeU4vN2FTeW5MQWIyMndlOGpaOUZHQWtSeVdoUXJuT045c08yTGVjdzk4?=
 =?utf-8?B?Q3ZiSkk0N3drbnpFOGwyK0RXYWVwQUt5dGtRSjBRK2R1MDE3SmcrTkl0bXVa?=
 =?utf-8?B?aFR2aWpYbUsydnRwcGl3SnV6YXlJQWFsWEk2WHdFZDBUYjlGVVZBMUp5b2o1?=
 =?utf-8?B?NW1Uak0wclQ4cGIraFpZVWRqTWtIaUIxcmhFWWV2MkRTVzFRTzJURkJqc3U5?=
 =?utf-8?B?VDRkZlhaNDgzQU1nUGtuTXdVRkJob1NmZE5zT0MxWkF4WENKcEdJZlZ6QWln?=
 =?utf-8?B?WHNmVVJUWGpCNXRJWFNubjVqdXFyMHdKUkErZHQyUWM2QUJIcXY2ZXBPVGZm?=
 =?utf-8?B?L3BFcVk2c01LcHA2bklLVmJacXZyWmluRldSTDk3TG41T1VQQ2k2aGhOTWJo?=
 =?utf-8?B?V3lvSERXYi9VdDRlVmpTb21JOWdQRWdQeGs2M05zS1dCdjFPUDU0TytoSi9t?=
 =?utf-8?B?dnIyNEFEUDlhYmg3aFlvVXhiclRkejdERWRaVlRqMUlYQW91dFlNSVd0UXRG?=
 =?utf-8?B?SjUxc0FhRHJjWGVQN3BrdHN6RzVCa2w2QWowcFRhdmhobzlvMkYxV2FMeXdp?=
 =?utf-8?B?QjBRNXdwYzZEd3luOE1sSEU2eDdTWUdOOG5XZ1d5eFZFOXQxenBWWnZ3Y3ZW?=
 =?utf-8?B?R3QrMlFTSGpVVWN5aHV2VEtTWVlIMzZjSmMyaWNDR3hnUm5pZ0Zjenc5VEds?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC4F30B48F676448960D2B064053F7C6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76371372-e2d6-4019-a67f-08da6fa537ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 07:54:22.4798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUA8fAJ7jZ/ubT3GPc0Q7Do+Ya5cfCNC8sBjWtkwhjurfNx9H29RPTPEXYkcYqNfpvbLEDRyf+DaXdMPntfMDq11ZHtnB5SZ5i7G52WqL4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1651
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMDcuMjAyMiAxMTo0OSwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IEtlZXAgTEFOOTY2
IGVudHJpZXMgYWxwaGFiZXRpY2FsbHkgc29ydGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2xh
dWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCkFwcGxpZWQgdG8g
YXQ5MS1kdCwgdGhhbmtzIQ0KDQo+IC0tLQ0KPiANCj4gVGhpcyBpcyBiYXNlZCBvbiBbMV0gd2hp
Y2ggaXMgYXQgdGhlIG1vbWVudCBvbmx5IGluIGF0OTEtZHQgYnJhbmNoLg0KPiANCj4gVGhhbmsg
eW91LA0KPiBDbGF1ZGl1IEJlem5lYQ0KPiANCj4gWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2F0OTEvbGludXguZ2l0L2NvbW1pdC8/aD1hdDkxLWR0
JmlkPTYyMzliMjFiYmM1MzhlOTRhNDM2MmViMjFiMGQxNDc5ZTJhMGExZGYNCj4gDQo+ICBhcmNo
L2FybS9ib290L2R0cy9NYWtlZmlsZSB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3Qv
ZHRzL01ha2VmaWxlIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUNCj4gaW5kZXggNmE2MTY2
ZTNhNDA1Li5mMTJjNWMxYjFjOTMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL01h
a2VmaWxlDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlDQo+IEBAIC03NzAsOSAr
NzcwLDkgQEAgZHRiLSQoQ09ORklHX1NPQ19JTVg3VUxQKSArPSBcDQo+ICBkdGItJChDT05GSUdf
U09DX0lNWFJUKSArPSBcDQo+ICAJaW14cnQxMDUwLWV2ay5kdGINCj4gIGR0Yi0kKENPTkZJR19T
T0NfTEFOOTY2KSArPSBcDQo+IC0JbGFuOTY2eC1wY2I4MjkxLmR0YiBcDQo+ICAJbGFuOTY2eC1r
b250cm9uLWtzd2l0Y2gtZDEwLW1tdC02Zy0yZ3MuZHRiIFwNCj4gIAlsYW45NjZ4LWtvbnRyb24t
a3N3aXRjaC1kMTAtbW10LThnLmR0YiBcDQo+ICsJbGFuOTY2eC1wY2I4MjkxLmR0YiBcDQo+ICAJ
bGFuOTY2eC1wY2I4MzA5LmR0Yg0KPiAgZHRiLSQoQ09ORklHX1NPQ19MUzEwMjFBKSArPSBcDQo+
ICAJbHMxMDIxYS1pb3QuZHRiIFwNCg0K
