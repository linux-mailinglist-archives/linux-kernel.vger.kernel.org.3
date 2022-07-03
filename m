Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866B95648DC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 19:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiGCR6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 13:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGCR6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 13:58:21 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120085.outbound.protection.outlook.com [40.107.12.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E7FC63;
        Sun,  3 Jul 2022 10:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzJgatCMz5ba3G211K7ceCDUR8nUJIXf7jBzEbEpRcDkRlLgddq3oI6NkLoo5ERm3bwBVP8Z3ez3YuYTWKNdPkx8Vz6Bt8/RFUCuaQN6u1Tq+hcjuvpKo6C148YIHGTPUwck1STrwdZXW/laJiEW5LAD4/+7ynlhTuNo1W6TiGRGAE15X05zZFUeZfFrzC9SZ0rXlXOgcX9TH8Fq/hrRHnz+FloglI9Cw/wIzn1chvnEPu0ThV/RCAfGZapaQgqK/4LeRXbW2AATFng8k3/m/Na1+omufvZb1M2Fnare43T8xNazH/1ap2j/A7QhA29V4nQJU1zQiOOfLglckhU9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Olz7i5qKbB/PnOqfwANTz9FnxhPS87Q/zjkgOuPbJgU=;
 b=Lkc1bR2Uwu/BChbLUeaUv8/4ScPV34WKo2e0BE1gigZJfWkuS8Fz0BnyoduJZWvr8hhUdM/Eyy3gmcFs1rKu9tFhaGdJy5JOsefegaR4eOBtgIeWzGm9bWyTRCrCqYEQpTIoDxP6cZH/ZDYbFtvlvaAMfks+0HwdHjUEGJXOd5hGb5bismZYJab7uujUZtq02GRuS92q4rL6LaMDpmFvgXbLo0oF1hFAAfnhMphD9zDB1+J/JR5tHy6qUhdnTktxTe4i7kOUwu7b+U0nNrPhOqTl5Wb+jCpRyeDi0lQMZAKzxTCsKvezyiq7y9ECnl244r3dkEQpnO8KICsemB7tfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Olz7i5qKbB/PnOqfwANTz9FnxhPS87Q/zjkgOuPbJgU=;
 b=DvdE0xChqNePt6zR5nMyXqhDFwPHLX/AwirfE/0Dg3eFe2GfBmJCyjZ2k2s1Ge5v+wBic/HcFJLV9Qt1NbQzsndWg8OJYNx6vnRxgDXZqbAHaZXQYNT7Voil/JOzRkoaUV85EPUlXuQDmlukqZsdY7xrMrjz7wY50pbwzOdtu8GJ/bzDkNuiN70eV1GXXax91MAM+KsiywaMoE7oTLPf3/Tv1g8mlSus50+KVSZplQA6OGo2HO54S6615UHjeuJ9gMYdBEEe6iSgsZWqgoiCpo9Sq5u23FuTqmuH8snuRULHp2OOOM8Rr9L0Omv13J/SWcdyT+ORNTGCB+V83WzTLA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB4150.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:255::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Sun, 3 Jul
 2022 17:58:16 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e063:6eff:d302:8624]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e063:6eff:d302:8624%5]) with mapi id 15.20.5395.020; Sun, 3 Jul 2022
 17:58:16 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Aaron Tomlin <atomlin@redhat.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 09/14] module: Move kallsyms support into a separate
 file
Thread-Topic: [PATCH v11 09/14] module: Move kallsyms support into a separate
 file
Thread-Index: AQHYNGkPEmx3nSpTUk+0k/50afpCQq1k38UAgABG4ACABaXlAIACOcIAgABQ8ICAAAmDAIAABKMAgAA+u4A=
Date:   Sun, 3 Jul 2022 17:58:15 +0000
Message-ID: <df94b5f9-764f-6334-f142-51773c3911bd@csgroup.eu>
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102413.3438665-10-atomlin@redhat.com>
 <20220628000526.11c57cd8@gandalf.local.home>
 <20220628081906.jln2ombfej5473xi@ava.usersys.com>
 <Yr92YtG12f+II+ea@bombadil.infradead.org>
 <20220703083324.az24ou7nrngvp73v@ava.usersys.com>
 <20220703092305.1e5da4c2@rorschach.local.home>
 <20220703135708.kn535pdrqv24f7kn@ava.usersys.com>
 <20220703101344.59710a42@rorschach.local.home>
In-Reply-To: <20220703101344.59710a42@rorschach.local.home>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3802d33-84f3-432a-c3af-08da5d1d9ae8
x-ms-traffictypediagnostic: PR1P264MB4150:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +CRZsMPixKZrXyP1Ly0zUEhfWpb1Dtzu7lQRFDYxB5mEecpb2UdjLoqZ5C96qtfn0GmmizyqfhkSqoLKFW90tj9BNtqlqisPCYSnCkPKkp7U7bAPA3j5rlD74lxjmafX5JCFYeL6GMd0VpVALZFfNzl2hC9tw62izpElCrSiyhnHhMn4/+4tHsygyoQvezFcE7dejGqaqLYaaxIwDzclvcead6QBP4vXE502yTpqSvyOIm1n/q29OGRyx6aTWpTyMzmUA8pptEq+imDvj0tKYQGW2y56KaQeY9YUzNgjkt8Up56MIfn2oU+8ekcaWftLJFW5CjHwLVhL0aCzk5EpdJ69zPiFSZmOhfDSGtE9cfTxaprp4eJYL0CiVQbPPEYQVo6BVvvEG/b95QEIiAIUIRymnSX3A5oKkzKUPwYF8NXHI/sRv9j2AnoIWEeGhQXNkqGuMzX1VsX8VKZLts4biaRuHd9PXexo6B65y5s4r+RgUnHAKJ2H217E+48zME3mBDSaM1GQKceS/dJNoCtOaDttZzhmagCaMREL6Ozkhfb4gt8xiPpr9OHLhJcWIWXLcgs4BquHirfXD3dZPoHvDAeTmYJvAbEkT4qqZkESy6VzEM0qAaPUu3jlhBmsnm/n+BJHzCqjKFPToh5mTc+bgyIA4VJ78sx9/g58+mDpZLAthnGTRO/huLmmifjaN5JBKjquRb9IgVPQ0X/3iA7MIbDPU85V5A9Xsgyf2i41rK4wuc9rAL3vGErQks9ATu1ZO8IqqMDA/hKfElWjXVzOqbkYzO5ZqrrI3vFArZjGcAPhwQTCLrxa4M4EYrfu9sQYT8gEn/A62K3sgX+JVTpEeICZ+6h1NXZYw7QTdnZvQ10WRh84oOOhz2aiYBAyGVzT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(396003)(346002)(136003)(376002)(366004)(186003)(66446008)(31696002)(66556008)(4326008)(66946007)(76116006)(316002)(6486002)(91956017)(64756008)(66476007)(8676002)(110136005)(54906003)(36756003)(31686004)(71200400001)(6506007)(6512007)(2616005)(7416002)(5660300002)(478600001)(86362001)(8936002)(38070700005)(122000001)(41300700001)(2906002)(4744005)(44832011)(38100700002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDZVenQwVUZKK0VHQzBZS24zSEM3Y25zWHNhc1hwRjhHUHRIaHpCb0xFbUZF?=
 =?utf-8?B?ZWR1c3orQlRNZW5haCtPOCtqWU5GVjBIaFhYaE1lLzF2T2Zqei8rM3JMdUFG?=
 =?utf-8?B?aFVnNmpucVBRaEc3cWxHQ2NleEVEdUZPeUNpU05TdEVITWQxb1lpanU2Rm9v?=
 =?utf-8?B?WjVWb0RQZTJrMUY3Y2dhOU92ZmEyVUJBWUUxckZuRzlrbGkrT2tYTFY3TkF2?=
 =?utf-8?B?QVJUeTU5NkpBa3VHL21IRlJPRjE0eTlyMWRaeEx1cjlnZGNrWEJPVmp6NzBa?=
 =?utf-8?B?YnZEOEQrV291RVgwZllxdTN6anhva3pVVTRLemlIYkVDRk9EWmdIZGpvMXpF?=
 =?utf-8?B?bGJ3bGpMc0pkb044Z2lSUzNIM28vK2F3RDcxemxNbUhoYmRQL21FcDJGdnJz?=
 =?utf-8?B?MzdsdlVqbGRpRktFS1lhdGZMM3Y4Rlk0a1Q3TmdXMUZLUmsyU1luMkI4OHNE?=
 =?utf-8?B?a3FnenVPanVldzlsN21UTDdnQ2d4ZWNSOElIa2REK3FleFF5NEFVS1VGV2o0?=
 =?utf-8?B?NmlveTlvUGVRMnVITjR3ak9yNStLZmQ0SEZCTDhKOTVWS2REclhEeXpkMHVT?=
 =?utf-8?B?bCtEb1NQSFBPNzMxckRVZ0dJeUxVNGJaVXpQVWhJdEVkMjlUTG04SU9nbmx4?=
 =?utf-8?B?WnNLMjFBNEVHTmpnemNGTUxYK25wN3RSVkVqWDFKTlFVYlBlRXNpZHVlclkx?=
 =?utf-8?B?NW1jelRiUE90RVIrL3hySVR3SVU1Um82amQ1THpuWDBVM2JrTkMrbnJCYXRK?=
 =?utf-8?B?cUE3RVA3YmYxS2RQekIvYnNBa0pWMys0OG8vYjFjRmRiZDIvcnhCSHFqL2FU?=
 =?utf-8?B?RDBKelduWlhHUnlHRW5ZcFlQcjdhOGt3eExvWENpTkVjdDNjSWx0ajVWd1BD?=
 =?utf-8?B?QTlDZEVzc2x1bFpmN2FMYUJMV1dIYXdvblhReG8rN05ZaytJeEFqNHRnNDN0?=
 =?utf-8?B?NGh4MGJEOCtEYkdvbVdJYmF6b1dSY2xucTRNWFJiVG16Z0xlaE1BZk0rdnQz?=
 =?utf-8?B?NXRLVEdqR2dlNVRJTkMrcFhsLy9YMkJnWjJaTCs3TGZFbU92ZnJGNG0yMldk?=
 =?utf-8?B?a2ZsRFIzN3RIME14REpsTFduaWNxc3NvVzl2MWNVUUQvMng3dlhDTEVGd1dm?=
 =?utf-8?B?T0t6OERDYXc3TkFKUDhhK1lBdUpqNmpiM3lnd2ZMcUt1cE1tWUNieTVFS0Ux?=
 =?utf-8?B?N0s5eUlBL3lwdHlyVlJxMjZTWFFrdnFrYlc1ZmlDeGE0c0dWZkQ3eWJKdS9y?=
 =?utf-8?B?Q1MwNUFYUEc0eE9MdTdHM2h3dkdKKzVBQmZjSFpsWVJUYVJzSERFN1plVGl3?=
 =?utf-8?B?OGNmY3dtYkZyMWc4d1c3Z0tBc1Z0Q1FPaWdVSG9RdkRnS2JVck12bW5Sa1Ba?=
 =?utf-8?B?Y1JkdDFYT3hGbVhmL0Q5amJ1dFc2UmlESS9ZNGZJMjFrZnVjNWw0SEIxWU1Z?=
 =?utf-8?B?YWlqdHAvdUZSbFh3cXBkQTJEZERDRUhaTzJlRlo1aW0welBvTFBXY1NEN1hG?=
 =?utf-8?B?RzcxNDhnbnpkMGxOejM2c0NpZnVnYXRrSDFreisyTmRnNlByVTI2b3B6ZkdN?=
 =?utf-8?B?cWpEQnlHTUQrRTV2RGxQNTFEOVQ0SnZWTmw0ZnB1Wjk1NXV5emNwMzFTZjJH?=
 =?utf-8?B?UmpSM05DMytmWHNZYmdMS0xya1pZR2Z5T3M0a1NPendJV3NaQWcyQkNSL0lB?=
 =?utf-8?B?MllrSWgxNFptY0RmSHAxb3dQemlNRE9TZ21qaWozYlRqVitFRHVPNVZDWHU5?=
 =?utf-8?B?R2FCcVdJTHc5bFhDQXZFQ0dGcEhWNE5KNEJkTHpjNXBjTytRMVRuNkJMQUZE?=
 =?utf-8?B?cWw3dnhOeDB4ZWZ0QTZlZWhjYm5XWUpzNUM3MXRXSHRRRWFnYk01T3ZLWE5j?=
 =?utf-8?B?VkttaXhnYWI2T2JiaFFsaGVDY1hRWFVHcEVtaFY1Q01KSFphSko0YitIU2lr?=
 =?utf-8?B?RHlOSFcxT1l1OVMzYVIrVXJmMTllck1iNCtpUlVoM3FYTFBFWTVkMUtqc0Fj?=
 =?utf-8?B?ZzNoQVE5akFIdEVLa0pRdmJvWGNoalMzOUxWVWpweHZiYUtxQncvQVNrQ0s1?=
 =?utf-8?B?d2gyV25KNVJuTmRYY3ZsdHRjU3F3U29aMlBydDdYV0xmRVFLSGFiUGZXemxr?=
 =?utf-8?B?THoxWnRUdGJHVDVBQlAybzFjWkVUMTZ1V1BTQ0tnQUdQMlBVNlBtMHF2Ynho?=
 =?utf-8?Q?L8nAvZbCjgkI8+pMbzNevcw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3E09F73FF750D44B1F0E9E7703B056C@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a3802d33-84f3-432a-c3af-08da5d1d9ae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2022 17:58:16.0258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xtbmzt/J6wEh+sTDE+gzB5Lr5xDi7spPopNXl06kN39DJYwEdOr/5HbVBrOEQMsaFeHh49c08qat5EfBwoZSpSep277dKWkIg5lwqYdtsMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB4150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAzLzA3LzIwMjIgw6AgMTY6MTMsIFN0ZXZlbiBSb3N0ZWR0IGEgw6ljcml0wqA6DQo+
IE9uIFN1biwgMyBKdWwgMjAyMiAxNDo1NzowOCArMDEwMA0KPiBBYXJvbiBUb21saW4gPGF0b21s
aW5AcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPj4gSGkgU3RldmUsDQo+Pg0KPj4gSSBjb21wbGV0
ZWx5IGFncmVlIGFuZCBub3RlZC4NCj4+DQo+Pj4gWW91IGV2ZW4gc3RhdGVkICJubyBmdW5jdGlv
bmFsIGNoYW5nZSIgd2hpY2ggd2FzIGEgbGllLiBDb252ZXJ0aW5nDQo+Pj4gc3RybGNweSgpIHRv
IHN0cnNjcHkoKSAqaXMqIGEgZnVuY3Rpb25hbCBjaGFuZ2UhDQo+Pg0KPj4gVW5kZXJzdG9vZC4N
Cj4gDQo+IFNvcnJ5IGFib3V0IGJlaW5nIGhhcnNoLiBJdCdzIHNvbWV0aGluZyB0aGF0IHdhcyBl
bmdyYWluZWQgaW4gbWUgd2hlbg0KPiBkb2luZyBrZXJuZWwgZGV2ZWxvcG1lbnQsIGFuZCBzb21l
dGhpbmcgSSBmb3VuZCB1c2VmdWwgZm9yIGFsbCBzb2Z0d2FyZQ0KPiBkZXZlbG9wbWVudC4NCj4g
DQo+IEhvbmVzdGx5LCB0aGUgaGFyZGVzdCB0aGluZyBhYm91dCBrZXJuZWwgZGV2ZWxvcG1lbnQg
aXMgdGhlIHJldmlldw0KPiBwcm9jZXNzLiBUaGUgZWFzaWVyIHdlIGNhbiBtYWtlIHJldmlld2lu
ZywgdGhlIGJldHRlciB0aGUgY29kZSB3aWxsIGJlLg0KPiANCg0KSSdtIHByb2JhYmx5IHRoZSBv
bmUgd2hvIG1pc2xlYWRlZCBBYXJvbi4NCg0KV2hlbiBJIHN0YXJ0ZWQgc3VibWl0dGluZyBLZXJu
ZWwgcGF0Y2hlcyB5ZWFycyBhZ28sIEkgd2FzIGdpdmVuIHRob3NlIA0KZ3VpZGVsaW5lczoNCi0g
QWx3YXlzIHN1Ym1pdCBjaGVja3BhdGNoIGNsZWFuIHBhdGNoZXMuDQotIFRyeSB0byBuZXZlciBt
b2RpZnkgdGhlIHNhbWUgbGluZSBvZiBjb2RlIHR3aWNlIGluIGEgc2VyaWVzLg0KDQpXaGljaCBp
bXBsaWVkIHRvIGFsd2F5cyBmaXggY29keWluZyBTdHlsZSB3aGlsZSBjaGFuZ2luZyBvciBtb3Zp
bmcgY29kZS4NCg0KQ2hyaXN0b3BoZQ==
