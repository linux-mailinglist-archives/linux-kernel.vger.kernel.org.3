Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5AB4CC4EE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 19:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiCCSSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 13:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbiCCSRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 13:17:51 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120042.outbound.protection.outlook.com [40.107.12.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C011A41FE;
        Thu,  3 Mar 2022 10:17:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOPeFOtN/dbbm/OaT+a6DG/UGSeOyM8HhzXxdfyNNK/Nsb3pzeOgj0/NTZmEuPQVitQZG61kzGuPV6s+Z8I1PPoZR10ybmrGpsWCrGFd0BtPmqlFq2Qp4qv1PZWYVauuay21/5ZHFAynM4nqS8t6t0NU+mThlgN9Wo+Nta/FRNMJfYHMAG5GSxf3SbNz++3JhZwI8h34idTyxn5OJ5uAEn/LHrf0mNX6Gi0kx/SKN7G7f1SmipwoFqyqjKEx5e1T8VG4b0gp14SxsI4uwKEYPpTvG7v+WML20iGZ3zDAZT3pLdmiMm5TZi6V5Ynxk8Od4AYWo4s+sz30zyHH4KYcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lofI51mwnLKa0YLraXUHdRFiQx3igxysA6RudvaUXgk=;
 b=juQS/0DK/oxB6KRHdubHLYKNfuLlxHWRq7/1+xAOJ5LK9zWPXVdqSuCeVuSDOJdcDdthPZBIkxSIEd0No9xskVttLn0p5hNGLm33wRQ5F31nnTJ+3Pn87S7XXgpeDXDxp5TGwFIJS4SUIu4iC6QrdpVM5r3ZtTZ/5MQ+GiAnd42dRQo5ia0SqdN2MVHbHvFMNwzkIxMXj+P7s/uLghwhnkiAyYvqJvqBKiGyzYJDHwkDA+ZTz0NYQQdn5wr3kpgqQmIMKXoiWhILLMRdxlu090MlYAcu3tvXWbjAFd5jwKRHZyWMqBeQSaOjczDac3AseE9aqoRBjhjN/s0qrrImIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2968.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 18:16:58 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 18:16:58 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Christoph Hellwig <hch@infradead.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
CC:     Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
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
Thread-Index: AQHYLP0NLQDPLAcjo0Wbm4P6rm2iw6ysSI2AgABGk4CAAAbXAIABF7aAgAAXAYCAADC7AIAABlmA
Date:   Thu, 3 Mar 2022 18:16:58 +0000
Message-ID: <5b582422-ef36-009e-7cb7-b85b5022c9aa@csgroup.eu>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
 <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
 <a87aac32-52b1-3d56-6331-1c241fea032f@csgroup.eu>
 <YiDEmRf3X0fxSayK@infradead.org> <20220303145949.inaz2tecmfuek2hf@maple.lan>
 <YiEAxgVYx552UQFS@infradead.org>
In-Reply-To: <YiEAxgVYx552UQFS@infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7186c5b9-9269-4e51-ea5d-08d9fd42014a
x-ms-traffictypediagnostic: PR0P264MB2968:EE_
x-microsoft-antispam-prvs: <PR0P264MB29686A8A0DC305B383BDD0F7ED049@PR0P264MB2968.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KhDpWns0LEWH7FN7eDDVd2HbCOLhfLoTr4YhZomFeFvynzHLQpSrX4+5acO0Kld+9Jm/OPpEfOisrxUkU+1aaYTiZOVlLxrFxLwhtypXK2C+NiXtMYg7JlzGIIps6AvH2CMUTFuNYR+E3WaFw9qqBAESIc3wq2KuOEZi/jN+kiD3f5AMpbmUsibutDi689h7NzWBicyQsUQXXuq+iNrNP+yyHucaF7R3W0bKtED97kQwIFJ01iXJ5BRaNideMX/I2MRYFwJjIFgg97OCMiz1bDtzleF3Vdx2R0l3y5L3N2n6j7VzChjQR+fH4MW9xf0rb1dnMhVKPfONjtQhETSTYkGi/XknTsmQzquW9RswfKKBPdgA3s9SwQ8wAnMUDq982/IRw8ZAk1VRnZJBrSm67+zhXxYW8CuPuHsEeLirIvkkwV8ET3CqVmXsZVCJA7HAeHClXULRkmte4qg/wrkgBGxps4RfxaG30YE6b1NC12W0OMEiTe/AT9wVbz6xIkW3/EsxOM4aA4387s+1cYFaHX+TFTAQCoEiQYhR6oWWu0ORJFfp6RcJtKzaQtvJMyarDBioBkrBPG2Ecz5lyrO2/WMTOkmbJaJpjqSUUqEiRaq8NLJLIRNA87PnyfkPzW3PJLNgruk7HRC/h7JkYm0vRSHIPVsBANuKTO2sZZ0ZLu9MM29CSFDowNBpmfyYK7Mu4JwAMXsBM4G38Eu4y6dmyT2PqSI27xkzdU7AOJpt6viwX62TaCNxkTkAYwUylkmqC9qcylMh2TZudpJKmzCjeQ2hMeGvUnnOC1ien1yN5Pt5USuRlCT+LV2EXr3evf1ruKIAf/2CmWeD0oe6IejYmFwFzYgwdQ/upLD5448dmB4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(86362001)(38070700005)(54906003)(316002)(71200400001)(110136005)(6506007)(966005)(6486002)(83380400001)(6512007)(508600001)(2616005)(8936002)(5660300002)(44832011)(7416002)(2906002)(91956017)(66446008)(64756008)(26005)(66946007)(66476007)(76116006)(66556008)(186003)(38100700002)(31686004)(36756003)(4326008)(122000001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW4rTDZmQUlGSWZYcEF0bjRsZkE3T0lhT1JzWjJ2K3RkeFljcy91Wmlwc3Yr?=
 =?utf-8?B?Z0RtUW9QcFJ0Rmt3Q2xvWk9RbFZiQVk0eURINlpIbHozZUI4R2tOU2cySlp4?=
 =?utf-8?B?MHBidmwrTWk4T2x5NjVDdjdZaU5KL0RvVTExOGFHY0hWbit2R0FNZ3c2MXps?=
 =?utf-8?B?MVROc0JOeTFKRE0xMWhZbmNsaDBFVzIyN1c4N2wwV1crbHk2R1daQXU4UnM5?=
 =?utf-8?B?bTNxU0RCZXZTSVpyWFZoWjNwejFKM0ZvejVuRmw0UkY0Ym5GZGh1NU9UREVL?=
 =?utf-8?B?cGovSEtuaUtiYnowcFZZd2lOQ0F6UzIxZDhScGpKVTJtZ0RBRk1Fa0hjaGk2?=
 =?utf-8?B?WmM2dlg1d3FKNkhQR3luSGRQazBUVlVmdXBmem9SenRIK2dhSzR6MFBnSW0x?=
 =?utf-8?B?L25WdkwxRWNiOUw0T3d3eWh2SG1HNkpkb25UZmFCeFNmQmxwS1F3KzA3WHFY?=
 =?utf-8?B?UXJlUnRPZWpEeUxYMndyK3FhNHFBUWU4NWY4d3ZpRldWZzFvZnh2eHFpMmt3?=
 =?utf-8?B?aEtaeHlJSDVqejlFWk1uY3ErbUdsUlhheXNKeHRueXk0akk1SDUrdHdVNmsx?=
 =?utf-8?B?YlRzVVUwS0MzaUVMR2pjbmI1dml1VldpQ2pHek52TXZUUHBKMm13R3ZIbDVo?=
 =?utf-8?B?czAzYVhVamtSaTB0WjY2eTI3NkQxZGRXWkhOS1lUWXFFM1FtQXpUdHpsQS9u?=
 =?utf-8?B?c3J5LzZ4Q3BZTHZzWnlWQUV6Qkt0ZUtHMFZpTTdRY2R2bGF4Z2o1R2dodm14?=
 =?utf-8?B?djJaK3ZURFhCL1ZkMDhHUEZKVExibGFyczBlbFRqb2pxaFZ0OXNXQm5wL3FM?=
 =?utf-8?B?ckxaR1pTTDRWTkwyTGZLNFNZZUNsWUJvcSt2bW1GS0wyZjAvb2EvOVcyYUFY?=
 =?utf-8?B?YmhYM0Y5ajBkekNXdko2WlJGT0hjMkFoZ09hSjJzaDRobDEwVlgvT01NRzdP?=
 =?utf-8?B?ZlVjVXU1TWpoOGFnQ2lCUFFRdGUrMmhkUnMyUDhUZ016VUVXMzFwdzZpZU1h?=
 =?utf-8?B?YzAzVm9TbCtEK1BCSCthSnZDTzQyUlZraUpVaG9taFM2MXpWWWtOYU9TTGc1?=
 =?utf-8?B?ZUY0YnB6NDdPeFBOTVZjbGhaZllvNVZteXY3R0lGUUphV0hLZkV4QjZsZ0tv?=
 =?utf-8?B?aHIvR2tmTVZoY29ucDhtYmpROExZNFA1TU1qT3VPRllIeGJsZms2Vm9Rc1Ix?=
 =?utf-8?B?dld2WGh3bjR4TmkrTzhGY2tQRXFWN1pHbTRaRVhtcCsveUg4L0M3K2tyZVQr?=
 =?utf-8?B?amxxeXR6WEplRmExeUQ3RWFHZHY3M2JCNkVBNytVZ1Z5Q2FnNkY2QzF5OU9l?=
 =?utf-8?B?ZUFSby85NmJTeUczS09kb3ZOOGk4V0xURjQ2MWcxVWJmNTFnV3lqM3hjRmd5?=
 =?utf-8?B?L3VnbFNRQ2RaQ1YwcHFjKzc1cWlVMjAyY1NxdTR0alV3Tno3ckFLRjcyRmEx?=
 =?utf-8?B?U1B4M3dYR3hZSE5hb2ZrUlZmS3oxb2J3Y3UyOGo4NWNVMHV5SmNpZ29IYURY?=
 =?utf-8?B?TWVad0EyQ2pNcnZoSUN0WWpyWkozd0xFY3FuQWZiVFFHUWxTUzdNNWMvSURH?=
 =?utf-8?B?b0djZnJOa0lqL2Z5NFRZU04yL0ZRMVIzWkJ1WWxBL0cydjlmd05jaGkwZUhD?=
 =?utf-8?B?WWVoQmttdGtRemowTWZyRVF2VE1JZmgweW5sQUY0QVZNYWh3UU9pNWp3RUhR?=
 =?utf-8?B?REVwbFc1cUJDaWtFN0o3bG0zcmJUT1JHK2tLQ0RzMGVTNlE3NTZTYVBUNnA4?=
 =?utf-8?B?TTJ1dXI3bHhtOU9RUkRDQmJ5VXA4L3NPVkN4Wm55ODVCWllMNlQyNHhpNVE4?=
 =?utf-8?B?WWI1UUNsaGYvVWU0citHUTl3TlBON25hL1M1VTdHa0JFbS9aNXJGbVJ3QTA3?=
 =?utf-8?B?c0grMFN5c3NUejJYeHJsT0RNZXVCU2ZrTldiejFUYnVDV3B6cUI1L0lYRVBy?=
 =?utf-8?B?SXdUcTNHOWl4TGs1ZHFyTVd2STdKakhEbFRlWHYvRktiNXUzUVZ0UkdqU3cr?=
 =?utf-8?B?eTVwQ1lNVDRBOExYbkdOZEh4alBvbERUcEs3NDdJajE5QWdSQVJ6dHV6Nk9K?=
 =?utf-8?B?dFJNMytadHZweGUzbEE0cmtVVzlwVm9yQ3R3QmRlZlBubmdQUUpoUjZMcG9z?=
 =?utf-8?B?MVUybnZQZFhRZ2UxOTFNZ3ZBOFpBYzVwbTA0RHdRWVZ2ZzRUUEN1SG13djhG?=
 =?utf-8?B?VEkyQkpDb0J5QmFldk1TcmNwNno4RldRbHBvVHRmVXl2SGxJZTQzNU56bGk0?=
 =?utf-8?Q?DJQZCHcxkT6i9jFSIZSJizDhaIsvJAp5a/NwWEBzl4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54B0FDA717C4CF499BADA2A3B9C3FFBA@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7186c5b9-9269-4e51-ea5d-08d9fd42014a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 18:16:58.0366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oslYlw8jE7cXYy3+kX5vHUCc77SB/LmJTLM7tdjrO+BFqi0C3wVoxTxfCvC1pbeDxXmge/NgSp8Wx6nqMwRiRDFNu6pBe2jRsVlAvd6n890=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2968
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAzLzAzLzIwMjIgw6AgMTg6NTQsIENocmlzdG9waCBIZWxsd2lnIGEgw6ljcml0wqA6
DQo+IE9uIFRodSwgTWFyIDAzLCAyMDIyIGF0IDAyOjU5OjQ5UE0gKzAwMDAsIERhbmllbCBUaG9t
cHNvbiB3cm90ZToNCj4+DQo+PiBPbmUgb2YgdGhlIGJlc3Qgd2F5cyB0aGF0IHdlIGNhbiBjb21t
b24gdXAgY29kZSBtaWdodCBiZSB0byBkdXN0DQo+PiBvZmYgc29tZSBjb2RlIEkgd3JvdGUgYSB3
aGlsZSBiYWNrIHRvIGRpc3BsYXkgc2VxX2ZpbGVzIGZyb20NCj4+IGtkYi4NCj4+DQo+PiBUaGUg
YmFzaWMgaWRlYSB3b3JrZWQgd2VsbCBlbm91Z2ggYnV0IGl0IG9mdGVuIG5lZWRzIHNwZWNpYWwN
Cj4+IHN0YXJ0L3N0b3Agb3BlcmF0aW5ncyB0byBlbnN1cmUgdGhlIHN0YXJ0IG1lZWRzIGtkYidz
IHJhdGhlcg0KPj4gb2RkIGxvY2tpbmcgcmVzdHJpY3Rpb25zLiBJZiB0aGVyZSBpcyBhIHdpbGxp
bmduZXNzIGZvcg0KPj4gc29tZXRoaW5nIGxpa2UgdGhlIGJlbG93IHRvIGJlIGluY2x1ZGVkIGlu
IHRoZSBtb2R1bGUgY29kZSB0aGVuIHdlDQo+PiBjb3VsZCByZXBsYWNlIGtkYl9sc21vZCgpIHdp
dGggc29tZXRoaW5nIHRoYXQgcmV1c2VkIHRoZSBjb2RlIHRvDQo+PiAgIGZvcm1hdCAvcHJvYy9t
b2R1bGVzLg0KPiANCj4gRGlzcGxheWluZyBzZXFfZmlsZXMgc291bmRzIG5pY2UgdG8gaGF2ZSwg
YnV0IGluIHRoZSBzaG9ydCB0ZXJtIEknbQ0KPiBqdXN0IHRoaW5raW5nIG9mIHNvbWV0aGluZyBs
aWtlIHRoaXM6DQoNCldlbGwgLi4uLiBUaGUgaWRlYSBhdCB0aGUgZmlyc3QgcGxhY2Ugd2FzIHRv
IGdldCByaWQgb2YgdGhlICNpZmRlZiANCkNPTkZJR19LR0RCX0tEQiBpbiBtb2R1bGVzLg0KDQpI
ZXJlIHlvdSBwcm9wb3NlIGl0IHRoZSBvdGhlciB3YXkgcm91bmQuIFdoeSBub3QsIGluIHRoYXQg
Y2FzZSB0aGF0IA0Kd291bGQgbWVhbiBhIGRlZGljYXRlZCBmaWxlIGluIGtlcm5lbC9tb2R1bGUv
IGFzIHBhcnQgb2YgdGhlIHNlcmllcyANCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9saW51eC1tb2R1bGVzL2xpc3QvP3Nlcmllcz02MTg5MTcmc3RhdGU9Kg0KDQpDaHJpc3Rv
cGhl
