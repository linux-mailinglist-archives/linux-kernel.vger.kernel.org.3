Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AC958E194
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiHIVNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiHIVNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:13:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6DE61100;
        Tue,  9 Aug 2022 14:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660079592; x=1691615592;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R2eqGTq08XADGU3vAuUW+JBH8a+AX/zcHjRizXfhqgA=;
  b=g+3MX94xk6Y7qZAmEaPZkLMRZjCkOCoLKSO87lZ9agpR6z1kp5S577UW
   1Fqqf81lIwmr2iTYRV8QK/pI2mFBx9wMEoi5tS0+tj52g6OeyOdPDp513
   cDx9EvRsJjoREhEeedGuHyM5YIjcpdQlE5f0WkqPLjTf5MrZGSVBrrGUx
   iHQ59ite7I6+5lgN01tFjB+s4y6zvz6AhYtIiGZi9wRVcNhqjDx/ovFpO
   TcFH7qUZ+h+I0GjvDl5o+q5PigGz0CrpPkdWQq834d9LsP25LdeCL/ROW
   rOYM6Qx+6nwlVaSEaSN9OMeaBBVz6x/JILYMGXTOYGXFg1eglKsVGDMUr
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="185807837"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2022 14:13:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 14:13:10 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 14:13:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBRSpzdPNBgPVFChV7HJDs/F1+LdsQUzzMHcDBXsj7INg8QBMGbNAjdualbJjfvVzEoZ4gNWw0Ujjqm3mPviJYeeBbHsOyJ2SE7vzadmkH3ypQmJx98BG0bOAApvv+KJxVqttakWsEf7PwklgUIY9SOLP0HMaqhKJ5KLom6uylYfpqcbRxEpoUJ12JRdb8q44O9HLMcfdcjKB/HKdEGFfcQgLIFNEb4Ac6V5J8bRsiZyk/vBRYSnu7JXxl3d2S8lLeliY8UA5d1H1Z4IqEqPfo3chuK60wilXS8/r0fZnN6uIgoGYYoRBrXmPdJ3eMUnWeyTcpIcE+8aDelMYyMV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2eqGTq08XADGU3vAuUW+JBH8a+AX/zcHjRizXfhqgA=;
 b=RTGdrARJiDX2kTlC4/yA3yFwu5nDl1XxFqLLD5tq78fdOaMIJT3NRxLdc5VuZj2DXNvTRrIRzX2+tbq/HWek6ft95OjWPl8bHzrOkN90iPpINg0Hl79IXzQArrjRGcLQYTURUKC0mxlYiGKQZQlo9J2K96oqKcb6vq2ZCNF9uNvfL3QWpvVSRhVRv6z7ISf1ObLzajsUJMH24aUCmHbrNZBOK9+P5yiMl2mQUI7c8PjGqbbInjsfGILYAoEex9vGiBOAwe8HMH6EpWezkIRZnYdv0rE3ptcVh6fWIivIkbhrAohgFYMvx2H3Bax+dCSQpaJlaE7rqqw2QG6kQQ6tIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2eqGTq08XADGU3vAuUW+JBH8a+AX/zcHjRizXfhqgA=;
 b=MkSkmaqHerab71HQ5jRIlY9PEIQhbbFrjIOazDThWyL7us2f9N5iasQZAvX1Zrtr0o/CjxlQ/8t8CdbZznaFSLTl6gqg404ZE9mX+zXKYUDrEIgL8dft0gFTAdMfpZv5F+qzHL5R5UO8DWV9dqjA2sHiRfgV40aYouXD+NIXVdk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 21:13:05 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 21:13:05 +0000
From:   <Conor.Dooley@microchip.com>
To:     <xianting.tian@linux.alibaba.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <anup@brainfault.org>, <heiko@sntech.de>, <guoren@kernel.org>,
        <mick@ics.forth.gr>, <alexandre.ghiti@canonical.com>,
        <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
        <corbet@lwn.net>, <Conor.Dooley@microchip.com>
CC:     <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <crash-utility@redhat.com>, <huanyi.xj@alibaba-inc.com>,
        <heinrich.schuchardt@canonical.com>, <k-hagio-ab@nec.com>,
        <hschauhan@nulltrace.org>, <yixun.lan@gmail.com>
Subject: Re: [PATCH V5 4/6] RISC-V: Fixup getting correct current pc
Thread-Topic: [PATCH V5 4/6] RISC-V: Fixup getting correct current pc
Thread-Index: AQHYpmoWKDGeRD7OZEqsYpbx58+Qu62nHMwA
Date:   Tue, 9 Aug 2022 21:13:05 +0000
Message-ID: <3fbfaa49-8ee9-a65c-133b-d0f072f0eb6c@microchip.com>
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <20220802121818.2201268-5-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220802121818.2201268-5-xianting.tian@linux.alibaba.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e2267a1-f939-4957-8b94-08da7a4bf361
x-ms-traffictypediagnostic: DM4PR11MB5262:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KxGKAeM0XZbcTB6q7jDqnI3a3ndYyGo4r6mezeHymPQFCU0fw291G7fnuhiFtWB4b38Mah5Jaz+X/gs6jGNntFAgs2uleajPbdo0zclw9u7vvDklLCcUInZ3xlBVyrWD1QWHtplafm3iKe7K0dEyNplXSgDzYVZ6FOMDyh/hL8PLCkTi6Mz7P+22fBx02jKn6V9iejuH2l4o3BQqB3BJ4jXVz7tucZixmyRTEkdKryq1D6eKKlmi0TSE4zv17rCVF+ZEaUvOBARjXr7r9Ayxtr4DRpELTH6WS2yvoJ7q+hnlnKvwe3LZaagmRGNk3/Bgbc2Bs2LAcZa/GlkxzNk/oSQ2+TYuWxw2wBqXe9CdV5xlxJr/znY+wN4PBjpJkX4ndpJixosDkyxs5vQ/8D08j6arIBwA+DVAAdLJ7xO3VLNrMG7qMdzBuvTGRqQLhx8XtAQ5e6ZhwLbiPk7vWLJ9hnrYwoB+xyKhljc5aXcdc2k4AR3u4xgHDtRRkyhxw3VHnG3s5TU6Zjsp5xBKGpeKAju4naBazHBR6oIoyTKBT0fjDU1f3zYPSQQmL0mAuyaY+zZYSL4JgM4loZ4cVTAjk3aDNDjKCwc6QTwpmuTkiK1O0ZNOBR5AODCmhMs/wIR6U7r0+ExQ1PUZI/WUuLDkcqP1V5Zn0947z5Ysg1KZcRKNSd4SbqinnuWx2Mv35aCQAQ/1+LXOnE4UkMEVsKeftqz0IUD0W5mt1Ev+fW40a7DUOzkYyN/qiURZX8cAusWoLXluMJ9HkH6GuW3GcvifBc4EOy0+XgGCDfS0Jq+1f5NM4xKJCEe4HbaBnV4PX3O0ex6n8BXse6+CoDy6RfmjGVwXH5GJdvFOQZhhLeTcil8C1HmvNczEGvGW1U8iPHD/NHrJDmIgRnNNIYZe1AkOk1/3ji//Nokpe7iMxYMnQz57DKFoYw02daGvSJg5cKs9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(376002)(396003)(136003)(41300700001)(26005)(921005)(2906002)(53546011)(83380400001)(6512007)(2616005)(38070700005)(38100700002)(122000001)(6506007)(316002)(6486002)(186003)(71200400001)(31686004)(91956017)(66476007)(64756008)(4326008)(8676002)(36756003)(66446008)(66946007)(76116006)(66556008)(8936002)(110136005)(54906003)(86362001)(478600001)(5660300002)(7416002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnJhMGw0bHdEYytRWDVJUnVXKzlXRDk5d3ZVTXhjeVkrUG9JWExueDlmYldm?=
 =?utf-8?B?TXRKb0c4NlE0K1BSb0hWKzF5dDJiZk9UNUNIRUxXTkdBdStmd2xiNG1oV1l0?=
 =?utf-8?B?anh5SGhoTEZpUW5PbHdtVGpFRnEzU3p3eVlKT1RoZkR0UnI3QmFPQmlvbE9G?=
 =?utf-8?B?TXpQTHFUdithMlIvZS9GQW9yWkpsQm43ZlNLWHlFV2ZpR0FxNUpKV1lXeHdu?=
 =?utf-8?B?bW0wS0ptWXZJZDdiNkZRVmZKemQwTm5YMmNQL0M1UDZmMVRac0U4MkxzaXNK?=
 =?utf-8?B?emlVRnJRaDdycTdWdCtOQUtndkJRYnhVRzRUNEUrYkc1Wk9URiswczhCRDQ0?=
 =?utf-8?B?bmlEVDZhY2VUcncxeHoyaU4rdC85VDByNE5nNXVtR2dSQkladGEvUDlmelFv?=
 =?utf-8?B?YlpQQm1CR3FZZlBKMHRNelVhcy9EL3Rzb2dVQWFTU2Jia2c5ODMvUjByd244?=
 =?utf-8?B?OFJoanhONXdJV0R1aC90QlNQdGh3Y3BiQURqQTNZTDBEdTJSNlFGcVdJbE45?=
 =?utf-8?B?bnVxT0RsL1VJZEJPaGNWeDNadmNBaEdhOEE5amRzWVoyeUZUc2J0OXdNZzEx?=
 =?utf-8?B?VVlVeG44T2NuQ1ByN0pmdVNubmEyQ0lwclU2MW5WMFBXT2dHNFhnVlU0Vyth?=
 =?utf-8?B?M2k4cVlUSS93Y3c4Y01aclpIV0NuUk1RSmptV1hJTTIvM0F5ZG42MnhxeFQr?=
 =?utf-8?B?cXd5NGgwdm53d1BhMVV0Ry9Va004R3ovNmxxWkR2MTh5V0s4bHZ5V1Bvcm1G?=
 =?utf-8?B?Y1FuTS95dnYzUVk1NnYzQk9Ybkc1L3JIRDJLUDJ4K1VxU1pQZnN6WFZHbll6?=
 =?utf-8?B?UXNVVkpHR3RTT2RWVHlOUkt1NDZES2kzSUV2VllWWmVqZGE4TUFiRHZXd0s1?=
 =?utf-8?B?bzlsaWVzdmI3UHNMOXg1SStaS0ZUWlRRV0c0VXdjaTNGeXRFakRxbU1DanRX?=
 =?utf-8?B?dUVNN3NvWmliRU5tdDVsU1NINGxKbFF4VXhRSytjWTE5MGNNRTI2dEx4Nk1G?=
 =?utf-8?B?TU55dTYxK3hIdmVOVjVjUkdYekkwb3lMa1phVXlFZ0c3THJ3UVFINmxOZ1Ny?=
 =?utf-8?B?TkFRbmVxd2UrdnlKNkNnalhFVGI4V1hPSVgvMzNmc1NIMmFrY2lPY1dJalRY?=
 =?utf-8?B?c1ZFczZKZTlZRnlCL1dQWDIvT1BqSEJ0ZEV1V1NMOEsrR01XMjU4cXdBeVJ4?=
 =?utf-8?B?TSs0NEgwZ3lKcTFpK094V0thWXVKME4xbG9GRWtoZkhZblV4QWpkczBjRmFj?=
 =?utf-8?B?YWxPOUFWdDRsMTBoL0xkZlJpanh4MDk3dlZnT0NNSHRoTm5NNmdBZkloclJS?=
 =?utf-8?B?WVdScTZIU3dpbEt6K1J5T0g0blE1KzVONVlLcU04TkFjd1JMTTF2RnNiT3c0?=
 =?utf-8?B?WEgwQy9SYUFjL05KMlBtM0xmeWU5RE1lZUlmNXRwVmZqcDVDMG16bDY3a3pX?=
 =?utf-8?B?aG40OTZIYlF2Z1cwUExSVEtKdncxVGpDdjRYQU5wRUluc2xlOThkMlQzNFVK?=
 =?utf-8?B?bnhRMzJtWEtQQkRmdUNacHlkSndROTZWK2dHL2ZrSXRPcGpXaWRzblhiWi84?=
 =?utf-8?B?MkhaOUVWdFFaNTZSc2o5STIzdWJERkE0N0U2ek1zYlRBa3N4VmZMMVdkeXRH?=
 =?utf-8?B?YzBJelgzeW1oK2gvSGlLTHkxdytuNUtaSHBSdW1Tcm11a1hIQS9ZQUZ6UGlm?=
 =?utf-8?B?WVlsVENWSTYreU1rcVJoZFVpSVpGYmVIM0llQVdLLzZLTkxrZDFUSTB2REY2?=
 =?utf-8?B?VW1MMkR3dGhGMzJ1YWdUYkJBYzdvMG1QMTFHZzJJZzVKVUowcUdac01QcllY?=
 =?utf-8?B?Y3dNdk5ZZURpZCtMWGVJdVJ4dHdKZWpObHMyTTlsKzIvUkFaRHh4MXFZUnp5?=
 =?utf-8?B?UVdZajdVTU1kR1hLQW1xVVFjMXRWcG4xQnd5YSs1dllmT3dya0RlZjVzalN6?=
 =?utf-8?B?anFJWHZ4MlQ5ODZZNUFINzBERXZWVFNFemdySjN3UUNETXRZV0x5RGF1NGJm?=
 =?utf-8?B?UTl6Snoyc0pVZzkxSUdjNTRkb3NKNDE1blBleHlVeHRwZmhOSUlhSG9rYnhC?=
 =?utf-8?B?YWVNR2grYng2YUFjMFVYc05EdXlDaVE5T2xGR3NQS1pXaHp1b0hyaTZLU283?=
 =?utf-8?Q?MHOnDhZFMkXGuPwSmp3clj+38?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <414BA810584B9C4793C814D331FD7416@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2267a1-f939-4957-8b94-08da7a4bf361
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 21:13:05.0105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RC3v01IqREVqrRcocYGw4P/w8CEyRvFsowZjqUvyhAp75BhFQ0O1LcYtsERHjx6Eqqau3iKMppe/cya4OaxN70I0K2DkvVuUm7ZvW6Dj0KA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIvMDgvMjAyMiAxMzoxOCwgWGlhbnRpbmcgVGlhbiB3cm90ZToNCj4gV2hlbiB1c2UgJ2Vj
aG8gYyA+IC9wcm9jL3N5c3JxLXRyaWdnZXInIHRvIHRyaWdnZXIga2R1bXAsIHJpc2N2X2NyYXNo
X3NhdmVfcmVncygpDQo+IHdpbGwgYmUgY2FsbGVkIHRvIHNhdmUgcmVncyB0byB2bWNvcmUsIHdl
IGZvdW5kICJlcGMiIHZhbHVlIDAwZmZmZmZmYTU1Mzc0MDANCj4gaXMgbm90IGEgdmFsaWQga2Vy
bmVsIHZpcnR1YWwgYWRkcmVzcywgYnV0IGlzIGEgdXNlciB2aXJ0dWFsIGFkZHJlc3MuIE90aGVy
DQo+IHJlZ3MoZWcsIHJhLCBzcCwgZ3AuLi4pIGFyZSBjb3JyZWN0IGtlcm5lbCB2aXJ0dWFsIGFk
ZHJlc3MuDQo+IEFjdHVhbGx5IDB4MDBmZmZmZmZiMGRkOTQwMCBpcyB0aGUgdXNlciBtb2RlIFBD
IG9mICdQSUQ6IDExMyBDb21tOiBzaCcsIHdoaWNoDQo+IGlzIHNhdmVkIGluIHRoZSB0YXNrJ3Mg
c3RhY2suDQo+IA0KPiBbICAgMjEuMjAxNzAxXSBDUFU6IDAgUElEOiAxMTMgQ29tbTogc2ggS2R1
bXA6IGxvYWRlZCBOb3QgdGFpbnRlZCA1LjE4LjkgIzQ1DQo+IFsgICAyMS4yMDE5NzldIEhhcmR3
YXJlIG5hbWU6IHJpc2N2LXZpcnRpbyxxZW11IChEVCkNCj4gWyAgIDIxLjIwMjE2MF0gZXBjIDog
MDBmZmZmZmZhNTUzNzQwMCByYSA6IGZmZmZmZmZmODAwODg2NDAgc3AgOiBmZjIwMDAwMDEwMzMz
YjkwDQo+IFsgICAyMS4yMDI0MzVdICBncCA6IGZmZmZmZmZmODEwZGRlMzggdHAgOiBmZjYwMDAw
MDAyMjZjMjAwIHQwIDogZmZmZmZmZmY4MDMyYmU3Yw0KPiBbICAgMjEuMjAyNzA3XSAgdDEgOiAw
NzIwMDcyMDA3MjAwNzIwIHQyIDogMzAyMDNhNzM3NTc0NjE3NCBzMCA6IGZmMjAwMDAwMTAzMzNj
ZjANCj4gWyAgIDIxLjIwMjk3M10gIHMxIDogMDAwMDAwMDAwMDAwMDAwMCBhMCA6IGZmMjAwMDAw
MTAzMzNiOTggYTEgOiAwMDAwMDAwMDAwMDAwMDAxDQo+IFsgICAyMS4yMDMyNDNdICBhMiA6IDAw
MDAwMDAwMDAwMDAwMTAgYTMgOiAwMDAwMDAwMDAwMDAwMDAwIGE0IDogMjhjOGYwYWVmZmVhNGUw
MA0KPiBbICAgMjEuMjAzNTE5XSAgYTUgOiAyOGM4ZjBhZWZmZWE0ZTAwIGE2IDogMDAwMDAwMDAw
MDAwMDAwOSBhNyA6IGZmZmZmZmZmODAzNWM5YjgNCj4gWyAgIDIxLjIwMzc5NF0gIHMyIDogZmZm
ZmZmZmY4MTBkZjBhOCBzMyA6IGZmZmZmZmZmODEwZGY3MTggczQgOiBmZjIwMDAwMDEwMzMzYjk4
DQo+IFsgICAyMS4yMDQwNjJdICBzNSA6IDAwMDAwMDAwMDAwMDAwMDAgczYgOiAwMDAwMDAwMDAw
MDAwMDA3IHM3IDogZmZmZmZmZmY4MGM0YTQ2OA0KPiBbICAgMjEuMjA0MzMxXSAgczggOiAwMGZm
ZmZmZmVmNDUxNDEwIHM5IDogMDAwMDAwMDAwMDAwMDAwNyBzMTA6IDAwYWFhYWFhYzA1MTA3MDAN
Cj4gWyAgIDIxLjIwNDYwNl0gIHMxMTogMDAwMDAwMDAwMDAwMDAwMSB0MyA6IGZmNjAwMDAwMDEy
MThmMDAgdDQgOiBmZjYwMDAwMDAxMjE4ZjAwDQo+IFsgICAyMS4yMDQ4NzZdICB0NSA6IGZmNjAw
MDAwMDEyMTgwMDAgdDYgOiBmZjIwMDAwMDEwMzMzOGI4DQo+IFsgICAyMS4yMDUwNzldIHN0YXR1
czogMDAwMDAwMDIwMDAwMDAyMCBiYWRhZGRyOiAwMDAwMDAwMDAwMDAwMDAwIGNhdXNlOiAwMDAw
MDAwMDAwMDAwMDA4DQo+IA0KPiBXaXRoIHRoZSBpbmNvcnJlY3QgUEMsIHRoZSBiYWNrdHJhY2Ug
c2hvd2VkIGJ5IGNyYXNoIHRvb2wgYXMgYmVsb3csIHRoZSBmaXJzdA0KPiBzdGFjayBmcmFtZSBp
cyBhYm5vcm1hbCwNCj4gDQo+IGNyYXNoPiBidA0KPiBQSUQ6IDExMyAgICAgIFRBU0s6IGZmNjAw
MDAwMDIyNjk2MDAgIENQVTogMCAgICBDT01NQU5EOiAic2giDQo+ICAjMCBbZmYyMDAwMDAxMDM5
YmI5MF0gX19lZmlzdHViXy5MZGVidWdfaW5mbzAgYXQgMDBmZmZmZmZhNTUzNzQwMCA8LS0gQWJu
b3JtYWwNCj4gICMxIFtmZjIwMDAwMDEwMzliY2YwXSBwYW5pYyBhdCBmZmZmZmZmZjgwNjU3OGJh
DQo+ICAjMiBbZmYyMDAwMDAxMDM5YmQ1MF0gc3lzcnFfcmVzZXRfc2VxX3BhcmFtX3NldCBhdCBm
ZmZmZmZmZjgwMzhjMDMwDQo+ICAjMyBbZmYyMDAwMDAxMDM5YmRhMF0gX19oYW5kbGVfc3lzcnEg
YXQgZmZmZmZmZmY4MDM4YzVmOA0KPiAgIzQgW2ZmMjAwMDAwMTAzOWJlMDBdIHdyaXRlX3N5c3Jx
X3RyaWdnZXIgYXQgZmZmZmZmZmY4MDM4Y2FkOA0KPiAgIzUgW2ZmMjAwMDAwMTAzOWJlMjBdIHBy
b2NfcmVnX3dyaXRlIGF0IGZmZmZmZmZmODAxYjdlZGMNCj4gICM2IFtmZjIwMDAwMDEwMzliZTQw
XSB2ZnNfd3JpdGUgYXQgZmZmZmZmZmY4MDE1MmJhNg0KPiAgIzcgW2ZmMjAwMDAwMTAzOWJlODBd
IGtzeXNfd3JpdGUgYXQgZmZmZmZmZmY4MDE1MmVjZQ0KPiAgIzggW2ZmMjAwMDAwMTAzOWJlZDBd
IHN5c193cml0ZSBhdCBmZmZmZmZmZjgwMTUyZjQ2DQo+IA0KPiBXaXRoIHRoZSBwYXRjaCwgd2Ug
Y2FuIGdldCBjdXJyZW50IGtlcm5lbCBtb2RlIFBDLCB0aGUgb3V0cHV0IGFzIGJlbG93LA0KPiAN
Cj4gWyAgIDE3LjYwNzY1OF0gQ1BVOiAwIFBJRDogMTEzIENvbW06IHNoIEtkdW1wOiBsb2FkZWQg
Tm90IHRhaW50ZWQgNS4xOC45ICM0Mg0KPiBbICAgMTcuNjA3OTM3XSBIYXJkd2FyZSBuYW1lOiBy
aXNjdi12aXJ0aW8scWVtdSAoRFQpDQo+IFsgICAxNy42MDgxNTBdIGVwYyA6IGZmZmZmZmZmODAw
MDc4ZjggcmEgOiBmZmZmZmZmZjgwMDg4NjJjIHNwIDogZmYyMDAwMDAxMDMzM2I5MA0KPiBbICAg
MTcuNjA4NDQxXSAgZ3AgOiBmZmZmZmZmZjgxMGRkZTM4IHRwIDogZmY2MDAwMDAwMjI2YzIwMCB0
MCA6IGZmZmZmZmZmODAzMmJlNjgNCj4gWyAgIDE3LjYwODc0MV0gIHQxIDogMDcyMDA3MjAwNzIw
MDcyMCB0MiA6IDY2NjY2NjY2NjY2NjY2M2MgczAgOiBmZjIwMDAwMDEwMzMzY2YwDQo+IFsgICAx
Ny42MDkwMjVdICBzMSA6IDAwMDAwMDAwMDAwMDAwMDAgYTAgOiBmZjIwMDAwMDEwMzMzYjk4IGEx
IDogMDAwMDAwMDAwMDAwMDAwMQ0KPiBbICAgMTcuNjA5MzIwXSAgYTIgOiAwMDAwMDAwMDAwMDAw
MDEwIGEzIDogMDAwMDAwMDAwMDAwMDAwMCBhNCA6IDAwMDAwMDAwMDAwMDAwMDANCj4gWyAgIDE3
LjYwOTYwMV0gIGE1IDogZmY2MDAwMDAwMWM3ODAwMCBhNiA6IDAwMDAwMDAwMDAwMDAwM2MgYTcg
OiBmZmZmZmZmZjgwMzVjOWE0DQo+IFsgICAxNy42MDk4OTRdICBzMiA6IGZmZmZmZmZmODEwZGYw
YTggczMgOiBmZmZmZmZmZjgxMGRmNzE4IHM0IDogZmYyMDAwMDAxMDMzM2I5OA0KPiBbICAgMTcu
NjEwMTg2XSAgczUgOiAwMDAwMDAwMDAwMDAwMDAwIHM2IDogMDAwMDAwMDAwMDAwMDAwNyBzNyA6
IGZmZmZmZmZmODBjNGE0NjgNCj4gWyAgIDE3LjYxMDQ2OV0gIHM4IDogMDBmZmZmZmZjYTI4MTQx
MCBzOSA6IDAwMDAwMDAwMDAwMDAwMDcgczEwOiAwMGFhYWFhYWI1YmI2NzAwDQo+IFsgICAxNy42
MTA3NTVdICBzMTE6IDAwMDAwMDAwMDAwMDAwMDEgdDMgOiBmZjYwMDAwMDAxMjE4ZjAwIHQ0IDog
ZmY2MDAwMDAwMTIxOGYwMA0KPiBbICAgMTcuNjExMDQxXSAgdDUgOiBmZjYwMDAwMDAxMjE4MDAw
IHQ2IDogZmYyMDAwMDAxMDMzMzk4OA0KPiBbICAgMTcuNjExMjU1XSBzdGF0dXM6IDAwMDAwMDAy
MDAwMDAwMjAgYmFkYWRkcjogMDAwMDAwMDAwMDAwMDAwMCBjYXVzZTogMDAwMDAwMDAwMDAwMDAw
OA0KPiANCj4gV2l0aCB0aGUgY29ycmVjdCBQQywgdGhlIGJhY2t0cmFjZSBzaG93ZWQgYnkgY3Jh
c2ggdG9vbCBhcyBiZWxvdywNCj4gDQo+IGNyYXNoPiBidA0KPiBQSUQ6IDExMyAgICAgIFRBU0s6
IGZmNjAwMDAwMDIyNmMyMDAgIENQVTogMCAgICBDT01NQU5EOiAic2giDQo+ICAjMCBbZmYyMDAw
MDAxMDMzM2I5MF0gcmlzY3ZfY3Jhc2hfc2F2ZV9yZWdzIGF0IGZmZmZmZmZmODAwMDc4ZjggPC0t
LSBOb3JtYWwNCj4gICMxIFtmZjIwMDAwMDEwMzMzY2YwXSBwYW5pYyBhdCBmZmZmZmZmZjgwNjU3
OGM2DQo+ICAjMiBbZmYyMDAwMDAxMDMzM2Q1MF0gc3lzcnFfcmVzZXRfc2VxX3BhcmFtX3NldCBh
dCBmZmZmZmZmZjgwMzhjMDNjDQo+ICAjMyBbZmYyMDAwMDAxMDMzM2RhMF0gX19oYW5kbGVfc3lz
cnEgYXQgZmZmZmZmZmY4MDM4YzYwNA0KPiAgIzQgW2ZmMjAwMDAwMTAzMzNlMDBdIHdyaXRlX3N5
c3JxX3RyaWdnZXIgYXQgZmZmZmZmZmY4MDM4Y2FlNA0KPiAgIzUgW2ZmMjAwMDAwMTAzMzNlMjBd
IHByb2NfcmVnX3dyaXRlIGF0IGZmZmZmZmZmODAxYjdlZTgNCj4gICM2IFtmZjIwMDAwMDEwMzMz
ZTQwXSB2ZnNfd3JpdGUgYXQgZmZmZmZmZmY4MDE1MmJiMg0KPiAgIzcgW2ZmMjAwMDAwMTAzMzNl
ODBdIGtzeXNfd3JpdGUgYXQgZmZmZmZmZmY4MDE1MmVkYQ0KPiAgIzggW2ZmMjAwMDAwMTAzMzNl
ZDBdIHN5c193cml0ZSBhdCBmZmZmZmZmZjgwMTUyZjUyDQo+IA0KPiBGaXhlczogZTUzZDI4MTgw
ZDRkICgiUklTQy1WOiBBZGQga2R1bXAgc3VwcG9ydCIpDQoNClRoaXMgcGF0Y2ggaXMgYWxzbyBh
IGZpeCwgYnV0IG5vdCBhdCB0aGUgc3RhcnQgb2YgdGhlIHNlcmllcyB3aGljaA0KKEkgdGhpbmsp
IG1ha2VzIGl0IGxlc3MgbGlrZWx5IHRvIGJlIHBpY2tlZCB1cCBmb3IgYW4gYXV0by1iYWNrcG9y
dC4NCg0KQXMgaXQgZG9lc24ndCBzZWVtIHRvIGRlcGVuZCBvbiB0aGUgcHJpb3IgcGF0Y2hlcywg
Y2FuIHlvdSBtb3ZlIHRoaXMNCnVwIHRvIDIvNiBpbiB0aGUgc2VyaWVzPw0KDQo+IENvLWRldmVs
b3BlZC1ieTogR3VvIFJlbiA8Z3VvcmVuQGtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFhp
YW50aW5nIFRpYW4gPHhpYW50aW5nLnRpYW5AbGludXguYWxpYmFiYS5jb20+DQo+IC0tLQ0KPiAg
YXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfc2F2ZV9yZWdzLlMgfCAyICstDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9h
cmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9zYXZlX3JlZ3MuUyBiL2FyY2gvcmlzY3Yva2VybmVsL2Ny
YXNoX3NhdmVfcmVncy5TDQo+IGluZGV4IDc4MzJmYjc2M2FiYS4uYjJhMTkwOGMwNDYzIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9zYXZlX3JlZ3MuUw0KPiArKysgYi9h
cmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9zYXZlX3JlZ3MuUw0KPiBAQCAtNDQsNyArNDQsNyBAQCBT
WU1fQ09ERV9TVEFSVChyaXNjdl9jcmFzaF9zYXZlX3JlZ3MpDQo+ICAJUkVHX1MgdDYsICBQVF9U
NihhMCkJLyogeDMxICovDQo+ICANCj4gIAljc3JyIHQxLCBDU1JfU1RBVFVTDQo+IC0JY3NyciB0
MiwgQ1NSX0VQQw0KPiArCWF1aXBjIHQyLCAweDANCj4gIAljc3JyIHQzLCBDU1JfVFZBTA0KPiAg
CWNzcnIgdDQsIENTUl9DQVVTRQ0KPiAgDQo=
