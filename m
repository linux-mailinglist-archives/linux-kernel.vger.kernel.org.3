Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450C659B528
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiHUPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiHUPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:42:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1868E2408A;
        Sun, 21 Aug 2022 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661096578; x=1692632578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QeTdN6to9cLC+6kKRr69GQCT5aZDW2PxRhM5SToQzrA=;
  b=G03qqehUi5JliWPufXX8sn0ovzN6VEU1zySZpqFN6P4sd7s++/NL9BSC
   mOmYXjpZHVAd499zw9tqA3lt1Fc4yG1QSwKuJifyEFMABx1yUDE6SzHAx
   ZNYGq5c4aPMG0XRz+PaM6SKxcEy6KtC44zQMVIVAczl9L8RQmOennr11/
   YpRs9GN+HaDANv66JaFdjo/xROwykzgxKYPA9xflr7XdEQ79hZJ7e6qax
   aIPsCG1zABocCaSbK2DGlHNloLfewHE7QtuHfVgER/y/HJV42KhSePpYU
   87oc12gVCYS1ZaJmcX94twcFqWG4Wv5htYoZunhFbIxBIqjWSP0f1RLGz
   w==;
X-IronPort-AV: E=Sophos;i="5.93,253,1654585200"; 
   d="scan'208";a="177266561"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Aug 2022 08:42:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 21 Aug 2022 08:42:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Sun, 21 Aug 2022 08:42:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7XYRJj9JMmZ2jD9a0U6drppiZq4FBTeM2p1Y+ISICIC9hR1XhpKqhLgVwSIp1os72quKIxihyrEwNNDKYFuNz5OYI8htd/BtSpDZXh0kjNwmwm9EvCJgcwfRr9lA2apR4XWboLzMdD4nN7IICyrZ6/IBU0WaG7MQVSct0leMyIAhE4iy3EedUSlW2PnGn7dzZ/hJvPOeuSLuo+EJ57WbzjaaDE9bZ1530HHg3VKYjkMMQkQfmj/fFeMnLPv86bmKzztjqMHygSFAQLCRlBxnl83grJ9IOk8aS1g7ki56FoSDq2ypDqQ/AxA+sT/3a11pNXI+TiVQyIecU4OEPNKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeTdN6to9cLC+6kKRr69GQCT5aZDW2PxRhM5SToQzrA=;
 b=fDMQ0EKJ7Xtx+DKhCW/ZWyspstakp8myzdH6RW9n5iQcTFLXpzPC3jMANZDZxnsbFF0sqSkQMkE8E3va/xgGC4m52UQwH12BXy8vOrbtTq51E7fL/7B/a3B4vqgp/vp3egDtuMowIcYvlbnKXHDlvs+lpZbO3rtxxgs6t5TbbMJki6c34tcW5Dq4wpPdmaW9t5zRwJrrnKk3cVr/uWeDqihBakmRzUT38Xq8pyJzPZQjKY0HqWxjegJCkM8DXAZSqLbqlYHFDs2HAdWTKfljj+s9orZPylM3x8NZ02i5oVzapYLaIg4JGQvlY1lEEuPnYUJZ/ljuNghWkGZAiIxU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeTdN6to9cLC+6kKRr69GQCT5aZDW2PxRhM5SToQzrA=;
 b=tCIo9qVqgcrZuDeO/qC8VQikSifAow3XfzlFheYq34aP+6NMCiX+at4BT2SKAn51FBzaKiFjw6Kl+JWicFQHLuxUyITXUhYEkHEw3e/nDtWJjfyzKMR+FnGgkn9TxpCHbH+IoAE4gemHp/1rhc+iO3w3XuvDHOHqbJDxd/nPxT4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR1101MB2337.namprd11.prod.outlook.com (2603:10b6:404:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Sun, 21 Aug
 2022 15:42:56 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.021; Sun, 21 Aug 2022
 15:42:56 +0000
From:   <Conor.Dooley@microchip.com>
To:     <yuanjilin@cdjrlc.com>, <johan@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb/serial: fix repeated words in comments
Thread-Topic: [PATCH] usb/serial: fix repeated words in comments
Thread-Index: AQHYtXOnbmmEbJPTGEuuT0oz5x+LR625fnSA
Date:   Sun, 21 Aug 2022 15:42:55 +0000
Message-ID: <6f3059bf-1a12-8ad4-305c-50fc5e0782bc@microchip.com>
References: <20220821153441.6165-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220821153441.6165-1-yuanjilin@cdjrlc.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2decff3-d115-47d4-3fa9-08da838bd12e
x-ms-traffictypediagnostic: BN6PR1101MB2337:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nXyrGu3l8kJkUKkY/Sj963y/XGq4ar8Kw4dmmvTUTTZ42IDVLYLo8PakhpBvh+mti5Ah8yMqyKRNTHYK0eKwdStZIKslABKgEUR9BApv2Uq89XcKQZiHEUZ+73tNkvyN0Im5O7hSMyst9SPuOddWi1fxykE1Vc2gS1emEzkWmuK4Nu1dc8roWgdgyg6g7mtAbFZDz4+Hf0XndCrVdJQAKBWySSA1DNjLSoawyGQ5ZtXwILnEx4Qfg+t6URQD6VAt2Mtti1/JaQ6KMBjNKmk92cfRuiufaRLlUfG688UpWYCrfhGGEgM1xC+xEXXS/UuN8yOuIFM7JXYGEtphonSXm/TmmhhkjVMPy+Tg8lXPur9vrk/g6gzr/Amh/piOPPjsyiok5p7UI/SHsXkCunbwMs8zyDVX8sL6E98hS900gFgRytLhio+4f9lGw2KAafps/s3BOznES/SS+hY4NVyoPNztIlV8A3q5CEkW13O5OwTu1sd4zGLDQZmbZhRtgbQvApaigMcFvHAnB8VXY5bSTedT1wGcL4b0jD+FiTNuEkiTkBMKfnE+2SqejJ5vsWLlNsdWKa39JxeLTQlqBHTLvP+4/JHxGg8iDFD9gDSlnGETmCsdL2gXwvJeMM8V3Ejg8+2+zmscarxTyim9J/lDFDGVV1ewkywjkzT2adWnvXOjFOOSo39nhUz0tGNtP8GaOYuMBpxrHYvvI1wcta7+YNIKUpJeW5Gd6JDRwNbUrvMNUoaLGzS36FQ7VPntGSqGdqqodu9K0I1Ywx54TepmeZzcMhyi9eSqoWy7BIXVO6cnI8WMjk9KaiZJvqAMl1M1xTLGMU0b8wvFrxIWp2VYKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(136003)(39850400004)(366004)(376002)(38070700005)(83380400001)(38100700002)(36756003)(122000001)(64756008)(4326008)(8676002)(66446008)(66476007)(66556008)(66946007)(76116006)(91956017)(71200400001)(8936002)(6512007)(26005)(5660300002)(6506007)(478600001)(6486002)(31686004)(316002)(54906003)(41300700001)(110136005)(31696002)(186003)(2616005)(86362001)(2906002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk9FelhrWmUzY3BZclYyMXRmTnRQQjR2RUpvWEpjRlpnSHFTU3BUUU5YbXda?=
 =?utf-8?B?SVhDVTJTalJyVjFKSGMxSW0vME9yc2h5aUg4eThUYmdUTUdkbmJFTzJuSUlu?=
 =?utf-8?B?ajc0NUI2UU81Q1YwOXBISHcySVVSR016M01qZjk4d00zZmhNUGxOQjc3VHQr?=
 =?utf-8?B?YTlLelVPazhVZ3JQdHBpUFVmdjd5YnJHME1QVEZ3aUo0NlRUMjFMUm1wV0tJ?=
 =?utf-8?B?Q0tXMnlUU0Zja2tCdW9aK3RnbzBrSm9zL1NvSUVJUkw0QTdLR3lhZnhoakYr?=
 =?utf-8?B?bUZTRmlCVFFRREpLKzB2UGNaSWE4Tkd2eVhBZDRLcXV1UmJad2lVL21Pb0Ur?=
 =?utf-8?B?NnpsRFVpeUVyRTZTV1JnNWpYM3NvV0E2WmlGUTVwT3dtM1Z6ZkJKd0xhWEd5?=
 =?utf-8?B?ZVN0VVFqOUY0blBmZ3IrUXBqWjN2M1dEQldNcDJqNnZJaVhrUDZ6bzQ5QTZT?=
 =?utf-8?B?NmFGemJtYjFUdGRwaGVsczk0eDVEODlHSW5LZHpPRTNzcnQ5aWhXUjY2ZDF2?=
 =?utf-8?B?ZEF3UW5qM2RoOGRLVWE5ZDE2SmtmMUdBZkdHQml2dkdyVGduaHo5ZjNaYXNa?=
 =?utf-8?B?Q0dFM3kwam1BL1M5S0VPTXF5dUVVRUxab3E0a3czZ0ViVVB3d2lkbFlRcExH?=
 =?utf-8?B?VEFMakVHWVk3a2VSMGNhYnZlZkNhR0J1dzZuNC9BSDEwek94SHNYczRTWmp3?=
 =?utf-8?B?d1pOTXFaMy9lamlHUWw1R0kxSGJyNGlyQXJIemZWMVNqdXpMSmVweE9mSm0r?=
 =?utf-8?B?TWJxR0hXaGlwTVM1Z2gya2M2bmw0OG1ubUUvTmptbzI1NnVHMHNYWHV1Q0Fi?=
 =?utf-8?B?cVpua2J5RU9ZTW1QNXFQZFhOeFNRT0tCQnkyU0FGM1BSWHNGVEdFTlpnYWVi?=
 =?utf-8?B?WnU0OFpBU3dqKy9UanFCRGlnRS9XWEp3MTBNK1JnL3d1VkdleFdjYmxoVkpT?=
 =?utf-8?B?RUdoRElLTUsycC9xaksyd3liaHNOZU52RkVGVWMvM0J6Z1I3VlA3N1Z2UGx0?=
 =?utf-8?B?eXZsV0g0cHd2Q21IekUzZ3dMM1FDVHkvOFg5NXlUNFdDNlBmaG80RVZzRnNU?=
 =?utf-8?B?ZytwdWVrNGpUbk5TNXZjbUVHZ29oRFFVNTdzU0FZSkNuNituQ0gvMGZET1RU?=
 =?utf-8?B?Zy9HQjQ0b0tZcVVjaXhXL2pqcldZWHNnc2ExUWVXVUVjVmhzNzdIdzllN0E4?=
 =?utf-8?B?MXRuN0FnajVmSjZHY1VQSDNRNVRnY1RQSUV5ZXlJLzBIQjVjUGtqQUhQMzRZ?=
 =?utf-8?B?cVlYNlgrUUZyRU5GR1hOeTJyMWs3UVlFY21tZDhiYU0xVkVLTm80NklaenF2?=
 =?utf-8?B?b2QxSkdqdUVKbW9JbFpqa1REVXhxU2RwUVFCNUVIenVGZTBZVnBzQXZoVUpw?=
 =?utf-8?B?VlZicThxb2J0NEJGK2ZiWW11c2dMbzVIdFhoc3plZlZRUzNWb2t2T2twM3Ju?=
 =?utf-8?B?S1hEVXNGZ3VoVE9vcmFpbVlUOVJ4TzFPMDJ1RmtDdGV6bE14RE84ZGJBd1Fi?=
 =?utf-8?B?R3V3NTdCYkpVQk8rcTMrbG5qYUVZRG5ZMlhxeHBZWk9BcWdLWjJHYTloeEpM?=
 =?utf-8?B?cTkvaG5udXlSMEd3bDd3d0N1dXdGV0cyRDdJMDRQdEVmUTFuVEdBczJoQUhC?=
 =?utf-8?B?TGNxU3Z0eDhmQUZJY0RqNDRlWmZob3dXa0ZXYi95L2ZKS1Nyb2sxcGpzSFJr?=
 =?utf-8?B?U3ZQQk95bGpBdS9UNytBeCtySXJ1cU4zVFIxbXBQVHA3cnZ1WUFObVZjZ3po?=
 =?utf-8?B?TnJPZHNYb2ErMkoxYmM3ak1rUzBSYUNVdTdISGwxcHdQcTlEc0dSOWFGd1px?=
 =?utf-8?B?KzB6VEhhaEZYVEpCNG9FTUVNT1M4ZFR2NTBLQ2pTdzhvclhKNXltQUYyV3Ur?=
 =?utf-8?B?M1UrczljYUxQOFdTbU5QWEpPUkdFY3pwdzNyYkF2dDN2YWlGTWYyU3lFNlB2?=
 =?utf-8?B?ZmNKSnl6aDlhcUk4VUpPV0dnSnczZFBXVVdBMnJ4aVY5cVREWXNrUkNUUFJF?=
 =?utf-8?B?dGs0RnpabVNNOEx2Y0tVdWk5SVZ4QTdmSmI0VktwQVhpWkZsc3hid0ZwTDBN?=
 =?utf-8?B?RWVqU0lBK3M2SnQxSGxmc2lrSEZ3eGtJRCs1eVgraG5rZVJZb3FReDhQNkls?=
 =?utf-8?Q?D3xVbG76v/+SW5TjKcp2iNVU6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EA0E3CA22696640A93664BFEF545085@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2decff3-d115-47d4-3fa9-08da838bd12e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2022 15:42:55.9039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +zLeNhZoEVf66sqUiW4EndiC4zIK29ImpOBfeOYhfSDCXvWf8SOLMmP5ZTTzWvMreAG3dUrPiHjfP2wUg8mr8Mjr9t/i6taEfp9xwArzfls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2337
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQpPbiAyMS8wOC8yMDIyIDE2OjM0LCBKaWxpbiBZdWFuIHdyb3RlOg0KPiAgRGVsZXRlIHRo
ZSByZWR1bmRhbnQgd29yZCAnbW9yZScuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaWxpbiBZdWFu
IDx5dWFuamlsaW5AY2RqcmxjLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9zZXJpYWwvbWN0
X3UyMzIuaCB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9zZXJpYWwvbWN0X3Uy
MzIuaCBiL2RyaXZlcnMvdXNiL3NlcmlhbC9tY3RfdTIzMi5oDQo+IGluZGV4IGUzZDA5YTgzY2Fi
MS4uZjc5YTFmMWI2YTk4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9zZXJpYWwvbWN0X3Uy
MzIuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9zZXJpYWwvbWN0X3UyMzIuaA0KPiBAQCAtMjczLDEz
ICsyNzMsMTMgQEAgc3RhdGljIGludCBtY3RfdTIzMl9jYWxjdWxhdGVfYmF1ZF9yYXRlKHN0cnVj
dCB1c2Jfc2VyaWFsICpzZXJpYWwsDQo+ICAgKiAgQml0IDU6IERhdGEgU2V0IFJlYWR5IChEU1Ip
LiBSZWZsZWN0cyB0aGUgc3RhdGUgb2YgdGhlIERTUiBsaW5lIG9uIHRoZSBVQVJULg0KPiAgICog
IEJpdCA0OiBDbGVhciBUbyBTZW5kIChDVFMpLiBSZWZsZWN0cyB0aGUgc3RhdGUgb2YgdGhlIENU
UyBsaW5lIG9uIHRoZSBVQVJULg0KPiAgICogIEJpdCAzOiBEZWx0YSBEYXRhIENhcnJpZXIgRGV0
ZWN0IChERENEKS4gU2V0IHRvICIxIiBpZiB0aGUgLURDRCBsaW5lIGhhcw0KPiAtICoJICAgY2hh
bmdlZCBzdGF0ZSBvbmUgbW9yZSBtb3JlIHRpbWVzIHNpbmNlIHRoZSBsYXN0IHRpbWUgdGhlIE1T
UiB3YXMNCj4gKyAqCSAgIGNoYW5nZWQgc3RhdGUgb25lIG1vcmUgdGltZXMgc2luY2UgdGhlIGxh
c3QgdGltZSB0aGUgTVNSIHdhcw0KDQpUaGlzIGRvZXMgbm90IHJlYWxseSBtYWtlIG11Y2ggc2Vu
c2UgYmVmb3JlIG9yIGFmdGVyIHRoZSBwYXRjaC4NClNob3VsZCBpdCByZWFkOiAib25lIG9yIG1v
cmUgdGltZXMiPw0KDQpUaGFua3MsDQpDb25vci4NCg0KPiAgICoJICAgcmVhZCBieSB0aGUgaG9z
dC4NCj4gICAqICBCaXQgMjogVHJhaWxpbmcgRWRnZSBSaW5nIEluZGljYXRvciAoVEVSSSkuIFNl
dCB0byAiMSIgaWYgdGhlIC1SSSBsaW5lIGhhcw0KPiAgICoJICAgaGFkIGEgbG93IHRvIGhpZ2gg
dHJhbnNpdGlvbiBzaW5jZSB0aGUgbGFzdCB0aW1lIHRoZSBNU1Igd2FzIHJlYWQgYnkNCj4gICAq
CSAgIHRoZSBob3N0Lg0KPiAgICogIEJpdCAxOiBEZWx0YSBEYXRhIFNldCBSZWFkeSAoRERTUiku
IFNldCB0byAiMSIgaWYgdGhlIC1EU1IgbGluZSBoYXMgY2hhbmdlZA0KPiAtICoJICAgc3RhdGUg
b25lIG1vcmUgbW9yZSB0aW1lcyBzaW5jZSB0aGUgbGFzdCB0aW1lIHRoZSBNU1Igd2FzIHJlYWQg
YnkgdGhlDQo+ICsgKgkgICBzdGF0ZSBvbmUgbW9yZSB0aW1lcyBzaW5jZSB0aGUgbGFzdCB0aW1l
IHRoZSBNU1Igd2FzIHJlYWQgYnkgdGhlDQo+ICAgKgkgICBob3N0Lg0KPiAgICogIEJpdCAwOiBE
ZWx0YSBDbGVhciBUbyBTZW5kIChEQ1RTKS4gU2V0IHRvICIxIiBpZiB0aGUgLUNUUyBsaW5lIGhh
cyBjaGFuZ2VkDQo+ICAgKgkgICBzdGF0ZSBvbmUgbW9yZSB0aW1lcyBzaW5jZSB0aGUgbGFzdCB0
aW1lIHRoZSBNU1Igd2FzIHJlYWQgYnkgdGhlDQo=
