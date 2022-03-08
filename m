Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7E44D125A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344969AbiCHIh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiCHIh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:37:58 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120054.outbound.protection.outlook.com [40.107.12.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC623CFEA;
        Tue,  8 Mar 2022 00:37:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5e1XtslXsKy+QseJ8Txg/NaA8Ji0/TbVJH2aDDQ8A7uwFtuhgVK9pr2UH6nodclHkIAN3yE3ZawxZTWe0Kb1f19I7kXh9SZOq0HZ+n1Daq3Th1ZO19WdMUZEGEx6qux0CPuxiS/PGahy2qQQFxzo4hZJzohGf7W+ENZXYxCNTZ+VuoRINaZ1eKIUC/Y3eWyByy2Ub/GoueZE/1/CKctnKejJ6+YpoLJGMj8y5ufxvMdrHoBSrGI6XbhuBpctfYoIWFrjRSRcJFAPJKd5zr0YBlQSbE/ARxHUhy+/Agrtv7cBdX7RQioqTPnLEh2YNU/TovWuHViyJqs5cLqRnDeOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPW0DiYaw3/cx063kBhIHMdgFkEatYlZRtucML1V4co=;
 b=L+TwBZ0oogOOblzoWmBhtVmW7qLbWc7x0rKHyl9Oe4iSTE3rWvTEg3ynB0cJKt1MiaTxZh+05phJXP5HamuEPskIki7SLp+JMPMLnNsoBPgy7NSAuNTuJj3WUiG24m/smr6InQIG++UUKye9VHMvWRWFEzzZmw5QO+HdkV1eMve/7vnbrFyScLMDC/s6BuYjzS39HIiE2sQnx0ZNUOpDnc+j536OqJDOUzWjmqIAGRfdCDjOuja+Yi54GbLqYhZ6NJ9LDSkExa4YlkjjbxA/qPNhlTDrTyfZO00WgOMAu8TIeWF8x1yyY+la4qW/KosY1JTulMYnWH+0VFQoZi9OJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2141.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 08:36:59 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d%4]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 08:36:59 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
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
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "pmladek@suse.com" <pmladek@suse.com>
Subject: Re: [PATCH v10 13/14] module: Move kdb module related code out of
 main kdb code
Thread-Topic: [PATCH v10 13/14] module: Move kdb module related code out of
 main kdb code
Thread-Index: AQHYMkt16m+IO7braUScQZYMgYdLQKy1KsOA
Date:   Tue, 8 Mar 2022 08:36:59 +0000
Message-ID: <82088b20-6129-aecc-c43c-1c78171717c4@csgroup.eu>
References: <20220307174509.2887714-1-atomlin@redhat.com>
 <20220307174741.2889588-1-atomlin@redhat.com>
In-Reply-To: <20220307174741.2889588-1-atomlin@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfcdd45d-ea1d-48e3-9d3e-08da00decf94
x-ms-traffictypediagnostic: PR1P264MB2141:EE_
x-microsoft-antispam-prvs: <PR1P264MB2141E86E3FF82DD02BE0E445ED099@PR1P264MB2141.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nU/cHM+Pzbhgu80D5QebU3ZSnzYKDWwen7muuLeY910t87qo694kKQg3g3kWbQGH1qK4DcASBYnt/sJRxPcrUr5kKfXNKT8A+yEt49x+rqB3iO0AnVhpyBvPBYW0Y0j/NzAeWRIAOzgThmWwWadrHWLmqYNxbvV+dQ82NWTX72YgAaUVTuecYyHpL5m3TEb8wDeLRTzmUGPIK7ZJ9lwElyOAEMpXqhHP3SeEJakRhpvxwgcjs/g8wJlYTKBXxgDMIgbtOXM4rzciHx92duUI0O8mwa8WTJst6YNHu2z+CKkunLWpvtLs4TLAmYCTzU6gn6sqAyETyjyprZ5qtxEcBvvbTXhguO4FyE4B1mY0KYDPq0N7f0Bzm1CGLlKZP+XpmrJUfKyDDC2/Y/W597VfPlpl3TLspMdIiJtA5A792jspD1e4SQTrTdF0f/h64EamQfDDG4CWfW2qFwq6o4U842YM4QNrv1zq8tLax6ZkGub+q6wFmbIuKy/DnUzkMCwNZ4xkvDS8KYOxnlrA1M8e1FkHeOI8y9Ztf2T4zjW9rOqDIso4BZ5u0JSVbdUImDUG1aIuXlMhp/0FWyXTpjHzirP1hW+heoOJ6mJXiphxn4KL3tDKgNWnsxljIuARTLHL1FDmvmWzNbviHZDoojmXU39r8omgd42f7DMRMoTNvNpNH14q4O2N2IR2Xn13P5wfTKBfjdD4YbSJ7yLQOB7Pa+68WxE2btZx3Hkndw1cY6AqI2tVziPKKJ04NR1zQaIs8vr2AZALwzvnab5U2VG5wg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2906002)(8936002)(7416002)(316002)(91956017)(44832011)(31686004)(508600001)(6512007)(6486002)(110136005)(54906003)(71200400001)(5660300002)(6506007)(38070700005)(86362001)(31696002)(2616005)(38100700002)(66946007)(26005)(186003)(66476007)(4326008)(8676002)(64756008)(66556008)(66446008)(76116006)(83380400001)(66574015)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWpkUTNvcFNLaHlyUk11T24reVB4dkNjeEVHMHIvRzVTcVVkZEFwd0VUbWJY?=
 =?utf-8?B?Ykpia21CRlRsRVRZS2JiZ3NtanZsd0ZOV3hwQmNSa1lQTG5LajYzMjkrTFhx?=
 =?utf-8?B?dW8zSysxTTFwSE1jdkJBRTlWV1dEVUFwZjdRSlpYeHhUeFYvS015RE1UMUdJ?=
 =?utf-8?B?d0R1RXdlMmNKdVB3ODc0SzdQd3dqaGxGR1djRmVPYThROGJLa2lIeXpmNFBm?=
 =?utf-8?B?Z3RTK2xRQWVCM2xaOEJUcWp5VkxmRVdKTlR6aVpiZWNGVlE1OERrYU0xOVlB?=
 =?utf-8?B?Wmc2SWVNbmtYYnloUlBudTR6Q2t4Vm5pczFjR3padUNZd09FUmtOODVTWlhX?=
 =?utf-8?B?NC9xYUhwcXFwQk12TGRGTW9LcW1Zd1RXaThJMWRBVTdobkhzYnpkcWdrKytR?=
 =?utf-8?B?M0FDWDBZSmxCQU9EWUVKb0F1amZNTmZjaUdpTHh2YksvRDA0M3hxSFJwTU9X?=
 =?utf-8?B?Q2ZvL3JvdnAvU2loTmJyZGFBWWEzeUE0d2xkQ0NBQnNGQ01GWllOdlFNQ1Jl?=
 =?utf-8?B?UmNHa1VJamttYm9hd1c2enNYeWF4dlprSFhWdUkrbG85NC96eGVOTUQrQUs2?=
 =?utf-8?B?VjZNNk1ickVhTkN1RjBNZkU4TXVBV1Bwa1phdEppWENWMHhWN1lycXpMYmV2?=
 =?utf-8?B?dEtQMlJtS0FCdDYrbGluZUpPYXJ1dnVnNStwMnVJZTJXYUVhRHhNNzdFOUlZ?=
 =?utf-8?B?eFRTclR6VC9VQy9iUjMxVWhzakh0T3FQTGZxc0tmMXcrdVlmMjZ1eXNUZi9F?=
 =?utf-8?B?SDkxWW5SMyt3K09qRUhMK1dDS2ZBRTgyRTVPdkVxOVBjalZ0NVNlVzA5Qndl?=
 =?utf-8?B?aXZCSmd5OElwQURYVFVmSWI2SmFzY0pvZnlQM1ZzUExiWDM0eTc2YW5tVjJw?=
 =?utf-8?B?VFZxMDZPQWY5MDlBM2V0NmhYZEtiRlZscmVYRDVHUGI2MEhIK08xM0ZiVEpt?=
 =?utf-8?B?cTlIcTB3anFkeW9mUXVneWs0YjAxVk45YzVRbTlUU0MzbHd1dDZ0eTdkVDJG?=
 =?utf-8?B?VkI3SCttS3VFRW5pLzlvWVU0cUNtdGRuak5SNVo2VExnai9rVlMrVEhRUVdo?=
 =?utf-8?B?bjZpY3h2aWVkNzViWlZ6c0I4MjVXSVpRWHJSZ0ljOVhTYTRWNVNNcDY1dEJI?=
 =?utf-8?B?eUFNU0dDM3FhanFPZHE2djRLNUw0OWRFNUo5OHRZS1hLN3J3YnpQNHhZeVpx?=
 =?utf-8?B?eWtwd3dCUCswWDc2bjgyS3BCbmlyeWJHd0M2NnM4Sk9JVEdwczJidVVTYmdF?=
 =?utf-8?B?SDBQL2hTbUJzd1RlR3FyV0ZEdEEvcFpJOEF4SDFMVTArcFFwV20zUHp6TWxN?=
 =?utf-8?B?L2JCM3BOK1NMRnJMWVR2aDNZaXNhY1ZUbkpBVXo0ZW1GeHRLSFVhR2Q3bXVW?=
 =?utf-8?B?SHNnMnhuaWFFOWI3VWdMSG55Z0MydlUxRUxhSC81d1ZlZlNlbjExL252azRD?=
 =?utf-8?B?eWpHZXFpWVBUYnlqaXM1UFRWelRCa3FETml0eHRvbFFOY09MTE1BQ3M0aUJQ?=
 =?utf-8?B?eG1yQjM0NFE1LzFrbk9NaEkxM2pSUFViOE80YXE3Y1oyV3VoN2lLK3FiYXpZ?=
 =?utf-8?B?MjdEeWN4RXpTaDNGOGJzU1BOUjFiL0tqdVNFZ29FdDVJM2dJTHAwZkxtVGVB?=
 =?utf-8?B?MzNCRUIyYk5hY2FHNXpmZjZmaDBiTEdhd01DaXFta1MyZUZTMUNQKzJCQ1RN?=
 =?utf-8?B?UW81VDNFNDZGOE9OY1B5NkJUSEpaK2g4ZzhBb0NhQUZOWWIvaEJDNGRnZVIz?=
 =?utf-8?B?Z3VNbHZqeDdRbm1UalZ0dzg1bHdqMWd0RUtqYkY0Uks2MkJLZzVPYTk3bXFX?=
 =?utf-8?B?ZlJqa2MzYjRqNTZxdzdhc1RKazQ5UDZqcVk1MW1wa054cGVXSWNadndiblVk?=
 =?utf-8?B?STZNZS9aS2JiSmxzd0hWandNd1M2NWoycUNlaVFuTmhwaXpVYi9pdEFLUFI1?=
 =?utf-8?B?ZUFheHRnMU51dXc4Mm9ic0ZnZDJoWmYyUFNYNVYrUFNxRG4rTUhzNGF6enN4?=
 =?utf-8?B?Znh6NW1Mci9DOHJDL2IzSGw2anBZS2JwNXhaUUYrZGxOTjJqOTlabjlMVXhP?=
 =?utf-8?B?SDFwUzVjRCtJRFhjWFZGYk8vbm5EdnN0MEN6Rjc4MlFoOTNKd0o5ZFRrdERI?=
 =?utf-8?B?QkdlY0JESUc0c3gxV01yZ0hQQW8xMHgrY0lVbld4cThGYkV5NjdWMFZZRjUy?=
 =?utf-8?B?WVJTbjBlOG1tTDJyN2x3aTNBRS9YM1Rvai92MVc5WlQrVmk4T1NTMEVWNXRB?=
 =?utf-8?Q?srG0PnCb7IYASalbsrvyAwy9nsaJ0N7t/oE8KMarJU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <639DDC337C50D142AFE622D32F7B447A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcdd45d-ea1d-48e3-9d3e-08da00decf94
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 08:36:59.0772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRYLjCWNvHlLqbIEooYXPL9MtPq3r0ogQDLpHqSumKf93P6nRK9T8c1yrZPE1M2CtkJ81iE8agXXZ6MxcWFd1vxWzI/h4XKzV0gED0tbclc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2141
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA3LzAzLzIwMjIgw6AgMTg6NDcsIEFhcm9uIFRvbWxpbiBhIMOpY3JpdMKgOg0KPiBO
byBmdW5jdGlvbmFsIGNoYW5nZS4NCj4gDQo+IFRoaXMgcGF0Y2ggbWlncmF0ZXMgdGhlIGtkYiAn
bHNtb2QnIGNvbW1hbmQgc3VwcG9ydCBvdXQgb2YgbWFpbg0KPiBrZGIgY29kZSBpbnRvIGl0cyBv
d24gZmlsZSB1bmRlciBrZXJuZWwvbW9kdWxlLiBJbiBhZGRpdGlvbiB0bw0KPiB0aGUgYWJvdmUs
IGEgbWlub3Igc3R5bGUgd2FybmluZyBpLmUuIG1pc3NpbmcgYSBibGFuayBsaW5lIGFmdGVyDQo+
IGRlY2xhcmF0aW9ucywgd2FzIHJlc29sdmVkIHRvby4gVGhlIG5ldyBmaWxlIHdhcyBhZGRlZCB0
bw0KPiBNQUlOVEFJTkVSUy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFhcm9uIFRvbWxpbiA8YXRv
bWxpbkByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAg
fCAgMSArDQo+ICAgaW5jbHVkZS9saW51eC9rZGIuaCAgICAgICAgIHwgIDEgKw0KPiAgIGtlcm5l
bC9kZWJ1Zy9rZGIva2RiX21haW4uYyB8IDQ5IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiAgIGtlcm5lbC9tb2R1bGUvTWFrZWZpbGUgICAgICB8ICAxICsNCj4gICBrZXJuZWwv
bW9kdWxlL2tkYi5jICAgICAgICAgfCA1NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ICAga2VybmVsL21vZHVsZS9tYWluLmMgICAgICAgIHwgIDQgLS0tDQo+ICAgNiBm
aWxlcyBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCA1MyBkZWxldGlvbnMoLSkNCj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQga2VybmVsL21vZHVsZS9rZGIuYw0KPiANCj4gZGlmZiAtLWdpdCBhL01B
SU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggMTk1Y2YxYWMyZWU4Li40MGM3MTdmOTNj
MWEgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBA
IC0xMDY4OSw2ICsxMDY4OSw3IEBAIEY6CWRyaXZlcnMvdHR5L3NlcmlhbC9rZ2Rib2MuYw0KPiAg
IEY6CWluY2x1ZGUvbGludXgva2RiLmgNCj4gICBGOglpbmNsdWRlL2xpbnV4L2tnZGIuaA0KPiAg
IEY6CWtlcm5lbC9kZWJ1Zy8NCj4gK0Y6CWtlcm5lbC9tb2R1bGUva2RiLmMNCj4gICANCj4gICBL
SEFEQVMgTUNVIE1GRCBEUklWRVINCj4gICBNOglOZWlsIEFybXN0cm9uZyA8bmFybXN0cm9uZ0Bi
YXlsaWJyZS5jb20+DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2tkYi5oIGIvaW5jbHVk
ZS9saW51eC9rZGIuaA0KPiBpbmRleCBlYTBmNWU1ODBmYWMuLjA3ZGZiNmEyMGExYyAxMDA2NDQN
Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9rZGIuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2tkYi5o
DQo+IEBAIC0yMjIsNSArMjIyLDYgQEAgZW51bSB7DQo+ICAgDQo+ICAgZXh0ZXJuIGludCBrZGJn
ZXRpbnRlbnYoY29uc3QgY2hhciAqLCBpbnQgKik7DQo+ICAgZXh0ZXJuIGludCBrZGJfc2V0KGlu
dCwgY29uc3QgY2hhciAqKik7DQo+ICtpbnQga2RiX2xzbW9kKGludCBhcmdjLCBjb25zdCBjaGFy
ICoqYXJndik7DQo+ICAgDQo+ICAgI2VuZGlmCS8qICFfS0RCX0ggKi8NCj4gZGlmZiAtLWdpdCBh
L2tlcm5lbC9kZWJ1Zy9rZGIva2RiX21haW4uYyBiL2tlcm5lbC9kZWJ1Zy9rZGIva2RiX21haW4u
Yw0KPiBpbmRleCAwODUyYTUzN2RhZDQuLmYzYTMwY2Q1MDM3ZiAxMDA2NDQNCj4gLS0tIGEva2Vy
bmVsL2RlYnVnL2tkYi9rZGJfbWFpbi5jDQo+ICsrKyBiL2tlcm5lbC9kZWJ1Zy9rZGIva2RiX21h
aW4uYw0KPiBAQCAtMjYsNyArMjYsNiBAQA0KPiAgICNpbmNsdWRlIDxsaW51eC91dHNuYW1lLmg+
DQo+ICAgI2luY2x1ZGUgPGxpbnV4L3ZtYWxsb2MuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvYXRv
bWljLmg+DQo+IC0jaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4
L21vZHVsZXBhcmFtLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L21tLmg+DQo+ICAgI2luY2x1ZGUg
PGxpbnV4L2luaXQuaD4NCg0KTm8gbmVlZCBvZiBsaW51eC9tb2R1bGUuaCBoZXJlIGFueW1vcmUg
Pw0KDQpJbiB0aGF0IGNhc2UsIEkgc2VlIHNldmVyYWwgb3RoZXIgZmlsZXMgaW4ga2VybmVsL2Rl
YnVnL2tkYi8gdGhhdCANCmluY2x1ZGUgbGludXgvbW9kdWxlLmgNCg0KU2hvdWxkIGl0IGJlIHJl
bW92ZWQgaW4gdGhvc2UgZmlsZXMgYXMgd2VsbCA/DQoNCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9t
b2R1bGUvTWFrZWZpbGUgYi9rZXJuZWwvbW9kdWxlL01ha2VmaWxlDQo+IGluZGV4IGNmOGRjZGM2
YjU1Zi4uODhmNWNkY2RiMDY3IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvbW9kdWxlL01ha2VmaWxl
DQo+ICsrKyBiL2tlcm5lbC9tb2R1bGUvTWFrZWZpbGUNCj4gQEAgLTE3LDMgKzE3LDQgQEAgb2Jq
LSQoQ09ORklHX0RFQlVHX0tNRU1MRUFLKSArPSBkZWJ1Z19rbWVtbGVhay5vDQo+ICAgb2JqLSQo
Q09ORklHX0tBTExTWU1TKSArPSBrYWxsc3ltcy5vDQo+ICAgb2JqLSQoQ09ORklHX1BST0NfRlMp
ICs9IHByb2Nmcy5vDQo+ICAgb2JqLSQoQ09ORklHX1NZU0ZTKSArPSBzeXNmcy5vDQo+ICtvYmot
JChDT05GSUdfS0dEQl9LREIpICs9IGtkYi5vDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvbW9kdWxl
L2tkYi5jIGIva2VybmVsL21vZHVsZS9rZGIuYw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBp
bmRleCAwMDAwMDAwMDAwMDAuLjYwYmFlZWJlYTNlMA0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBi
L2tlcm5lbC9tb2R1bGUva2RiLmMNCj4gQEAgLTAsMCArMSw1NSBAQA0KPiArLy8gU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4gKy8qDQo+ICsgKiBNb2R1bGUga2Ri
IHN1cHBvcnQNCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTAgSmFzb24gV2Vzc2VsDQo+
ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiArI2luY2x1ZGUgPGxp
bnV4L2tkYi5oPg0KPiArI2luY2x1ZGUgImludGVybmFsLmgiDQo+ICsNCj4gKy8qDQo+ICsgKiBr
ZGJfbHNtb2QgLSBUaGlzIGZ1bmN0aW9uIGltcGxlbWVudHMgdGhlICdsc21vZCcgY29tbWFuZC4g
IExpc3RzDQo+ICsgKgljdXJyZW50bHkgbG9hZGVkIGtlcm5lbCBtb2R1bGVzLg0KPiArICoJTW9z
dGx5IHRha2VuIGZyb20gdXNlcmxhbmQgbHNtb2QuDQo+ICsgKi8NCj4gK2ludCBrZGJfbHNtb2Qo
aW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2KQ0KPiArew0KPiArCXN0cnVjdCBtb2R1bGUgKm1v
ZDsNCj4gKw0KPiArCWlmIChhcmdjICE9IDApDQo+ICsJCXJldHVybiBLREJfQVJHQ09VTlQ7DQo+
ICsNCj4gKwlrZGJfcHJpbnRmKCJNb2R1bGUgICAgICAgICAgICAgICAgICBTaXplICBtb2RzdHJ1
Y3QgICAgIFVzZWQgYnlcbiIpOw0KPiArCWxpc3RfZm9yX2VhY2hfZW50cnkobW9kLCAmbW9kdWxl
cywgbGlzdCkgew0KPiArCQlpZiAobW9kLT5zdGF0ZSA9PSBNT0RVTEVfU1RBVEVfVU5GT1JNRUQp
DQo+ICsJCQljb250aW51ZTsNCj4gKw0KPiArCQlrZGJfcHJpbnRmKCIlLTIwcyU4dSAgMHglcHgg
IiwgbW9kLT5uYW1lLA0KPiArCQkJICAgbW9kLT5jb3JlX2xheW91dC5zaXplLCAodm9pZCAqKW1v
ZCk7DQo+ICsjaWZkZWYgQ09ORklHX01PRFVMRV9VTkxPQUQNCj4gKwkJa2RiX3ByaW50ZigiJTRk
ICIsIG1vZHVsZV9yZWZjb3VudChtb2QpKTsNCj4gKyNlbmRpZg0KPiArCQlpZiAobW9kLT5zdGF0
ZSA9PSBNT0RVTEVfU1RBVEVfR09JTkcpDQo+ICsJCQlrZGJfcHJpbnRmKCIgKFVubG9hZGluZyki
KTsNCj4gKwkJZWxzZSBpZiAobW9kLT5zdGF0ZSA9PSBNT0RVTEVfU1RBVEVfQ09NSU5HKQ0KPiAr
CQkJa2RiX3ByaW50ZigiIChMb2FkaW5nKSIpOw0KPiArCQllbHNlDQo+ICsJCQlrZGJfcHJpbnRm
KCIgKExpdmUpIik7DQo+ICsJCWtkYl9wcmludGYoIiAweCVweCIsIG1vZC0+Y29yZV9sYXlvdXQu
YmFzZSk7DQo+ICsNCj4gKyNpZmRlZiBDT05GSUdfTU9EVUxFX1VOTE9BRA0KPiArCQl7DQo+ICsJ
CQlzdHJ1Y3QgbW9kdWxlX3VzZSAqdXNlOw0KPiArCQkJa2RiX3ByaW50ZigiIFsgIik7DQo+ICsJ
CQlsaXN0X2Zvcl9lYWNoX2VudHJ5KHVzZSwgJm1vZC0+c291cmNlX2xpc3QsDQo+ICsJCQkJCSAg
ICBzb3VyY2VfbGlzdCkNCj4gKwkJCQlrZGJfcHJpbnRmKCIlcyAiLCB1c2UtPnRhcmdldC0+bmFt
ZSk7DQo+ICsJCQlrZGJfcHJpbnRmKCJdXG4iKTsNCj4gKwkJfQ0KPiArI2VuZGlmDQoNClRoYXQn
cyBhIHVnbHkgY29uc3RydWN0LiBDb3VsZCBpdCBiZSBhIGZ1bmN0aW9uIGluc3RlYWQgdGhhdCB5
b3UgY2FsbCANCmZyb20gdGhpcyBsb29wLA0KDQpTb21ldGhpbmcgbGlrZToNCg0Kc3RhdGljIHZv
aWQgbHNtb2RfaW5fdXNlKHN0cnVjdCBtb2R1bGUgKm1vZCkNCnsNCiNpZmRlZiBDT05GSUdfTU9E
VUxFX1VOTE9BRA0KCXN0cnVjdCBtb2R1bGVfdXNlICp1c2U7DQoJa2RiX3ByaW50ZigiIFsgIik7
DQoJbGlzdF9mb3JfZWFjaF9lbnRyeSh1c2UsICZtb2QtPnNvdXJjZV9saXN0LA0KCQkJICAgIHNv
dXJjZV9saXN0KQ0KCQlrZGJfcHJpbnRmKCIlcyAiLCB1c2UtPnRhcmdldC0+bmFtZSk7DQoJa2Ri
X3ByaW50ZigiXVxuIik7DQojZW5kaWYNCn0NCg0KDQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7
DQo+ICt9DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvbW9kdWxlL21haW4uYyBiL2tlcm5lbC9tb2R1
bGUvbWFpbi5jDQo+IGluZGV4IGI4YTU5YjVjM2UzYS4uYmNjNGY3YTgyNjQ5IDEwMDY0NA0KPiAt
LS0gYS9rZXJuZWwvbW9kdWxlL21haW4uYw0KPiArKysgYi9rZXJuZWwvbW9kdWxlL21haW4uYw0K
PiBAQCAtMTA4LDEwICsxMDgsNiBAQCBzdGF0aWMgdm9pZCBtb2RfdXBkYXRlX2JvdW5kcyhzdHJ1
Y3QgbW9kdWxlICptb2QpDQo+ICAgCQlfX21vZF91cGRhdGVfYm91bmRzKG1vZC0+aW5pdF9sYXlv
dXQuYmFzZSwgbW9kLT5pbml0X2xheW91dC5zaXplKTsNCj4gICB9DQo+ICAgDQo+IC0jaWZkZWYg
Q09ORklHX0tHREJfS0RCDQo+IC1zdHJ1Y3QgbGlzdF9oZWFkICprZGJfbW9kdWxlcyA9ICZtb2R1
bGVzOyAvKiBrZGIgbmVlZHMgdGhlIGxpc3Qgb2YgbW9kdWxlcyAqLw0KDQpJdCBzaG91bGQgYmUg
cmVtb3ZlZCBmcm9tIGtlcm5lbC9kZWJ1Zy9rZGIva2RiX3ByaXZhdGUuaCBhcyB3ZWxsLg0KDQo+
IC0jZW5kaWYgLyogQ09ORklHX0tHREJfS0RCICovDQo+IC0NCj4gICBzdGF0aWMgdm9pZCBtb2R1
bGVfYXNzZXJ0X211dGV4X29yX3ByZWVtcHQodm9pZCkNCj4gICB7DQo+ICAgI2lmZGVmIENPTkZJ
R19MT0NLREVQ
