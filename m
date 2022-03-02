Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF74C4CB05B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244744AbiCBU5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiCBU5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:57:10 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120053.outbound.protection.outlook.com [40.107.12.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69C1DBD09;
        Wed,  2 Mar 2022 12:56:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3obWv1afm+CbH1/MBgSl9StZauw0MBmRTnJHoUXu6k9ttoLEa80ZG1Y6NvnbjiFOoeqh2cfG3Kin8OMUs9I1Kbz6bPOqXRnZojxlJR8lRfHuZ/yC8jwl30djh22cpQrjitm+5HF5rDAHuKtNq3h2S4CYgYaFzSUnIwCzSw/ot6MfBOgexKbVvA5ny8Gn1e7vMvC0qs7PTK0NrRPBph2alAtifUCzb/H7gcDMkE3WUha/xeWUAN6WmQYU96EqDU1SOF9uSAKxXKuXk6sheBk6fMDFff0YaKjTjVQPJozCrR4kYg/px9tF3p0pfI/21VbGe0XNIAJvZ64pf6T3mM6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pE+RgoAjHMclF1wNCYRvDtq280QMxHRxd2BmsazQjBM=;
 b=OKSLUvuO/xjaUmbW7zGHm8EWgVbz0vIK8Jjpjad3l8vXyIRnvHYZNqmJUT47/shVb6kivD2F8MUnWGOW6XjCIBkV3JiinHsNVMAdeASEzJ2+xYPsAInrTL4midvQEZzoShi2P2H+soW1BIxVYOgCSykJL0LcnIfR75gbtLACxZKy0T9U9qlpyg36LyXJ8ci2ebxdl79jwqwuwQCebEMfgI+NAa5SAIIg8tbO1jMXs8hkhZJq0xbAyyHwTcd/WwbGEhPAi23ScPXGZmTbCH536TGswkyKhemjSw5DvFSkUKmM0TBkOLaULVGjPHd00e9vz4WsKhZ9o16JGlafm/UNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3857.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 20:56:23 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d%4]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 20:56:23 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
CC:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
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
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Thread-Topic: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Thread-Index: AQHYLP0NLQDPLAcjo0Wbm4P6rm2iw6ysSI2AgABGk4CAAAbXAA==
Date:   Wed, 2 Mar 2022 20:56:23 +0000
Message-ID: <a87aac32-52b1-3d56-6331-1c241fea032f@csgroup.eu>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
 <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
In-Reply-To: <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3176f11e-6468-40c2-f9e1-08d9fc8f1c48
x-ms-traffictypediagnostic: MR1P264MB3857:EE_
x-microsoft-antispam-prvs: <MR1P264MB3857DCAD51E40474582F2CBCED039@MR1P264MB3857.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rvLo57vj8t4L1R/X2ed/ho1DIK6fJ/iihLoMWJsBt6IGu3/VY3dRlA2zFpYMlZ7u75NkGmlHa+jkdUHwF6EDC+gsD2lv4rtg/BXOlmrExY/8eepfATqnPYH1WQld37jNgqHacY1X92s5sHSjDhaGh8Cn8oXnwm/Ee5HM0QRnr4QMOVrYvu/c0jzBOFrf3GLJ1WNA+hGKbh8lfss34n948ts0lN8Lg2Qzra3e71v00bDKsxVl4RpvGeXJIbgmdg2qkyczjlLlKKppprqaaCfZ9VUn4ANrt/FB5zrPr6RRGhxo5qsUq+sc9o6g21F5MSh5fiEtqJTX719FkbAcwQ8KnAd9IEXnAu477/e2NIlQdciPgMf6acMNo5Hlg3ihp4sIeg6eb1+1cMpO/bMu4ue9V5aQznysxkg1P3KevsbwuKEsCf3QgyZFNP+9dGoE4UnAATLjcu0kwEityVkEk1PhslfFtV+6raof8PRLF5gJTCuzBeGCTN46InYI4muUoU+8aIctThOnSMQyqxo1PToRW1Ci7eGtti4dAP8c/WO9EdKe2RsMvdy/RZKLG4MnA95ZBP3dpGEVgJx9yXK6oyXF1kCXMZvPgDTcONUb0mjIg97t3H2prE0E9DSraap7dBjLbTCmSNh2K8UDYIxgjXRgtUGC590ITYrsZUPi54RjBqo5ZhduzQsgMnJMF4m80G5DiQ1hCkWm038NSUbvQrMZaFSiPMsWo1BqDZxYJveBHZ/k7gq7gBM0ezt6/yHAPTDlUEW8GSI0EzNEHh40yvxTvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(8936002)(316002)(31686004)(6486002)(64756008)(66446008)(66476007)(66556008)(4326008)(8676002)(5660300002)(26005)(54906003)(110136005)(31696002)(38070700005)(86362001)(7416002)(91956017)(36756003)(508600001)(44832011)(66946007)(76116006)(2906002)(6512007)(122000001)(6506007)(38100700002)(2616005)(83380400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU1KWWdwbTlnUnFyS1lsakFMTitHbEYrSTBuL1VVa1lzVE9kbnlqRER1Mi9W?=
 =?utf-8?B?RGZYbWdSN00zRy9SMktQenBHSVJYUmh5QkJ0aHptSnNvRm1GS3RKSnEzVVM1?=
 =?utf-8?B?KzNZazlWSzl1Z3kzbERUQWNDSkd5dE9GeUo0cXErTllEbTc1K2d5SXA2WFpG?=
 =?utf-8?B?T2xrMFl3blZLNzhUdnJxQzhnTlV5ZkNXeWFIVUg2eXhXNkkvbFFJWDlYNTJt?=
 =?utf-8?B?UnV3T3AydUFJTFJtcjdkWGJnZVBWdjRmZUFiTkZWcyt3T0twTFFxdzVNSGdW?=
 =?utf-8?B?M2J6MHVOQ0dLTFhidEszVjB0TUI0blo5bUZSVS9zMnpqMWlXRkZybFhyVWJN?=
 =?utf-8?B?R1pkYTVMT1ZIdjlUdm1wdjRtSEZ2bXJtcWlCZ1NpU1hFYkpOYW4rMkNnRnZm?=
 =?utf-8?B?Ly9RcWFadUxldGhjTXBueFFTSFN6UFJBVzM2V2ZMUFNrMEtIZVZBSXBiLzlh?=
 =?utf-8?B?aTVjQWtyeGVOUGREckV0QmtiejJoODhRYWYxVHR4UUlwcVpua0hySEM2TkR3?=
 =?utf-8?B?bEFQTDN0ZlVpRGZWcDR6emlFd2VIb0wwK09BVE1NeFd0OFVMcitHYXo0Nys0?=
 =?utf-8?B?Q1BUT01CREJZNHNpeFdKcTl1OFc2b2JiY3FMK24xWWovNHpZckk1SHNIMW40?=
 =?utf-8?B?aTVZQWdEQ1lBMUhwVlRVVDNqMXBaVUpPK1NvZ0YvZEY0dWdEMmZ5dEs3dDB0?=
 =?utf-8?B?OXI1eVd6MTU1YmE2VnZDcnB2akxXSXVNbjBESThuSWs4czBBd0xxRTN6RXd0?=
 =?utf-8?B?VmVHRGovbHM3Y0NqSFVVbWtYVmgwcW4yQlAyTVF3UnR5alhqT2hBZmZNOER4?=
 =?utf-8?B?eG50M1VGK3pPM3pVWlIxeURwNHRpekcvNlRLZFRXVXpEK2pPU2pRR2d6SUwx?=
 =?utf-8?B?ajIrbnNTUDhwNmd0Tk8zbWpZU3d0U01oc3JRNmVmTlI1Snh6MjNOOS9Odk5N?=
 =?utf-8?B?c0hCS1VXOW1jV1ZGMWhVQ01vU0YzNG9kNkthQnFTNSs5QW5QRWcxS2Y1SHN6?=
 =?utf-8?B?a2h1ZG84M0hxcUZEMGZlSVF4K2VHU2s0WWx5OWxZNmpBeUVDY1RmTzdNdlJO?=
 =?utf-8?B?K0V1aFRsZTRJdHRIaHk5WlNHak1XbFZqeG1LbDNFS1ByWlZxbS9SOHE2NWx4?=
 =?utf-8?B?TVdYc2dJM3M2STVVa0hFanprZVA3SXp2VTRMdjd4b0h6ejlNNlJRbnNoVFBZ?=
 =?utf-8?B?bkorZHNuVGdBcWxrbzBYV1NQUjBwMmZLWVJqV0xZbGZaODB1KzZsQWI1V1lq?=
 =?utf-8?B?cVhVM3NMSkhzTmtnTkxlcC9QbXZZd2RVUmdoMml2dWtpaC9VVkhJNllZdHVV?=
 =?utf-8?B?ZmQ2cDFXN01HWnIvdEdmam53TlViVCtteER0cXY4UzFZZnJIMEcwelJQNFpC?=
 =?utf-8?B?MGh2dHk5Mk10N3pTek1BaGRvOTZ2THY3Mjgwc0dGaVZpRGQ1M3BLdmhyNmk0?=
 =?utf-8?B?OU1ldlpMQS82LzU5dFBLWmZYOHI3VGFPUXkrakNlMDloeTdWVmE2cnhoYlN5?=
 =?utf-8?B?Zi94RnhqVll5RWplWnhMQmFlSGNnYVFYSTZGMTBQQUJaSkRqT1RzMjNkOE5w?=
 =?utf-8?B?UGxLMUNTV1gvNEhOZkxNclNMb29ZUTQzeWozWlRWendKVVJiQ0t4WVpPcXg0?=
 =?utf-8?B?WUFRaXFyamxhZ1BjOGhJMk5xdXRlczRHdXFFY1J0eld1b0lPNHVwN3lNQkpY?=
 =?utf-8?B?eTNXTEFwYXlUbnMrQTlUcGJtaFd2SHlKbGIvSXM0V2JpNGtxSVd1TXcrMmx5?=
 =?utf-8?B?RDRZV0pYakhyYWtudlh0Z3dYVHRhbU04VlRKQ2tFUWRISXp5emkwU0UwT2Zj?=
 =?utf-8?B?MUJUcmtEM1VNb0ZmZUxXZUF4MmdnTGdnZE96N25scXovMm83cUplTjR0UFNZ?=
 =?utf-8?B?NzFaQ1Z3eHBVU2JMZjV6VmFkdUZGSDBKMFBza2VUUEN4KzNGVDViMjMvQmNp?=
 =?utf-8?B?NnEyZ0Q0MFVEVVVIMWdReTdqcWxFVmNxNDg1SG9HREdqbmV5Y3NXQlVpalpY?=
 =?utf-8?B?V21zamhXV3JIdkVzTEt2QW01MDFzZ21GYktDd25IZnIyK1laWkk2V1BRSVY0?=
 =?utf-8?B?SmpXaUhaTmlpRGRNK1dqTU90aWxXSWcxMnlvdXRmNFplUlA3OHVyN1ErMmVw?=
 =?utf-8?B?ays0Ky9EYnNJMW1BcjMyM1NrajZMUnI2aEthdWw5V2grWFRod0tWTGJkbUFB?=
 =?utf-8?B?N0wzd0VTTEFiaFFpdGFoV045dVBKS2VJME1mVyt0WndrRjNsWXlVOU9KVHdE?=
 =?utf-8?Q?rVag2lCfdbG1Bxz3MeuR0aj0J9ewjTXIr0IMvROkp4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30F7EC41584B1E40B55F1A34DED28C05@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3176f11e-6468-40c2-f9e1-08d9fc8f1c48
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 20:56:23.4234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8xjyxplyQ1b92MaY2JKWazEqsNzWF8lVAsQGct+B7jsmDCCYA4oCuHtM0Loh48WBrVc7dtvMUG8raYNLiibemT3PSri78rMSVaQQi5sqGok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3857
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAyLzAzLzIwMjIgw6AgMjE6MzEsIEFhcm9uIFRvbWxpbiBhIMOpY3JpdMKgOg0KPiBP
biBXZWQgMjAyMi0wMy0wMiAxNjoxOSArMDAwMCwgRGFuaWVsIFRob21wc29uIHdyb3RlOg0KPj4g
T24gTW9uLCBGZWIgMjgsIDIwMjIgYXQgMTE6NDM6MjFQTSArMDAwMCwgQWFyb24gVG9tbGluIHdy
b3RlOg0KPj4+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlLg0KPj4+DQo+Pj4gVGhpcyBwYXRjaCBtaWdy
YXRlcyBrZGJfbW9kdWxlcyBsaXN0IHRvIGNvcmUga2RiIGNvZGUNCj4+PiBzaW5jZSB0aGUgbGlz
dCBvZiBhZGRlZC9vciBsb2FkZWQgbW9kdWxlcyBpcyBubyBsb25nZXINCj4+PiBwcml2YXRlLg0K
Pj4+DQo+Pj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lA
Y3Nncm91cC5ldT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBBYXJvbiBUb21saW4gPGF0b21saW5AcmVk
aGF0LmNvbT4NCj4+PiAtLS0NCj4+PiAgIGtlcm5lbC9kZWJ1Zy9rZGIva2RiX21haW4uYyAgICB8
IDUgKysrKysNCj4+PiAgIGtlcm5lbC9kZWJ1Zy9rZGIva2RiX3ByaXZhdGUuaCB8IDQgLS0tLQ0K
Pj4+ICAga2VybmVsL21vZHVsZS9tYWluLmMgICAgICAgICAgIHwgNCAtLS0tDQo+Pj4gICAzIGZp
bGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRp
ZmYgLS1naXQgYS9rZXJuZWwvZGVidWcva2RiL2tkYl9tYWluLmMgYi9rZXJuZWwvZGVidWcva2Ri
L2tkYl9tYWluLmMNCj4+PiBpbmRleCAwODUyYTUzN2RhZDQuLjUzNjliZjQ1YzVkNCAxMDA2NDQN
Cj4+PiAtLS0gYS9rZXJuZWwvZGVidWcva2RiL2tkYl9tYWluLmMNCj4+PiArKysgYi9rZXJuZWwv
ZGVidWcva2RiL2tkYl9tYWluLmMNCj4+PiBAQCAtNTksNiArNTksMTEgQEAgRVhQT1JUX1NZTUJP
TChrZGJfZ3JlcHBpbmdfZmxhZyk7DQo+Pj4gICBpbnQga2RiX2dyZXBfbGVhZGluZzsNCj4+PiAg
IGludCBrZGJfZ3JlcF90cmFpbGluZzsNCj4+PiAgIA0KPj4+ICsjaWZkZWYgQ09ORklHX01PRFVM
RVMNCj4+PiArZXh0ZXJuIHN0cnVjdCBsaXN0X2hlYWQgbW9kdWxlczsNCj4+PiArc3RhdGljIHN0
cnVjdCBsaXN0X2hlYWQgKmtkYl9tb2R1bGVzID0gJm1vZHVsZXM7IC8qIGtkYiBuZWVkcyB0aGUg
bGlzdCBvZiBtb2R1bGVzICovDQo+IA0KPiBIaSBEYW5pZWwsDQo+IA0KPj4gSWYgbW9kdWxlcyBp
cyBubyBsb25nZXIgc3RhdGljIHRoZW4gd2h5IGRvIHdlIGtkYl9tb2R1bGVzIGF0IGFsbD8NCj4+
IGtkYl9tb2R1bGVzIGlzIHVzZWQgZXhhY3RseSBvbmNlIGFuZCBpdCBjYW4gbm93IHNpbXBseSBi
ZSByZXBsYWNlZA0KPj4gd2l0aCAmbW9kdWxlcy4NCj4gDQo+IEluIG15IG9waW5pb24sIEkgd291
bGQgcHJlZmVyIHRvIGF2b2lkIGFuIGV4cGxpY2l0IGluY2x1ZGUgb2YgImludGVybmFsLmgiDQo+
IGluIGtlcm5lbC9tb2R1bGUuIEJ5IGRlZmluaXRpb24gaXQgc2hvdWxkIGJlIHJlc2VydmVkIGZv
ciBpbnRlcm5hbCB1c2UgdG8NCj4ga2VybmVsL21vZHVsZSBvbmx5LiBQbGVhc2Uga2VlcCB0byB0
aGUgYWJvdmUgbG9naWMuDQo+IA0KPiBDaHJpc3RvcGhlLCBMdWlzLA0KPiANCj4gVGhvdWdodHM/
DQo+IA0KDQpEbyB3ZSByZWFsbHkgd2FudCB0byBoaWRlIHRoZSAnc3RydWN0IGxpc3RfaGVhZCBt
b2R1bGVzJyBmcm9tIGV4dGVybmFsIA0Kd29ybGQgPw0KDQpPdGhlcndpc2Ugd2UgY291bGQgZGVj
bGFyZSBpdCBpbiBpbmNsdWRlL2xpbnV4L21vZHVsZS5oID8NCg0KQ2hyaXN0b3BoZQ==
