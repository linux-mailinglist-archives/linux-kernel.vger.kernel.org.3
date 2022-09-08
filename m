Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7D65B1474
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiIHGMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiIHGL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:11:56 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120082.outbound.protection.outlook.com [40.107.12.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54487ACA25
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:11:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTBBYDO8/yQNEciFBPa/EkfJHrEhmI9cmYUXeF9Cso0baoyrA+nGybK3mWFfg4cpPHOQZuAel5uxgJJYZHtGQFrolwUznYUqXSNw2+UetJ9V9mqoekX/M3uFBXRIP1iGm5o1yazcYn8sgbcjgWaWpABvpseZqb6QsIzlz5rONVbtgDAeBnBh8SDuOKiAiEQ7cZZohcLjE8BWi9BcjGOdngw16yHOLBuOPon1MbHxJuEmnv4HAspNZyKsLBx3WyMuTk3UtKdrc+5wBJ+CKK56hcnwIM24+PEiNaB5DFDCU/A66TqVJeSJAnLtMBrAXqaJD3dpj36ksWwqDXG45AbGXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PN+51+SoO3NeBxaRk3AnzRxitd8drTQKHO4oL1YAAio=;
 b=hIQfWPogWllah0Cu6Cyi/XotNG0p32XwSND/fdhwVo/QMY4QH8qn9ghQ1tznaPwcsNFn7RjqptgGpSKBTqGqnLTR3RS/x81KGZKg3CxaCBn5dIMz1a1I4w68vZ136KZpGp60KyPFVOxg4qcoIexuSqafRrSFz/k5IEqDj42U/nPBVfSu41uawYoiOWd05l2tMl7zI/BOivbf20az13AaolmT9U3mRXyeWxZdeAF8CA6Mso1jFXU0vBGA0WZ5VMsYyHsCBN7IQHrwbo4PFnevpro+1g8Gof7dD2pC9iSepJPdv2PXeksG4XtX7605ted/E7MZgyRrcZfCRruk7F/sGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PN+51+SoO3NeBxaRk3AnzRxitd8drTQKHO4oL1YAAio=;
 b=LQIS8kJYdFxALc3j6LJtY10BkRITwVtttRzFjEVFHE3AYP3l/kQsPnX9yjqpm3rpIVaMoC+pt2BHpkxvgjQTy7baXP3YXgX2iQVXQ/96IKbi/x0oIR2oFRDQ8tQvdI4hQpue4535QJgD/qEvLy4SgK5Pq63bgf4GhCrHLept7D11xlxEZdfcQn9lCIlY2rKsflrp0pDG/7h2HUpPhLx6fan8jTIwJDL+yTTwwyNfYZiAjmgIKRpYchkPKRxnhh8Y3h59DVy0oa5iUpwT7ZJJmZ0naO7Re/2BN7MR9/5YzFM8qauzhJLVRhrTcmZI1GnwNblWZRoSp3QKpAjK4GZhkg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB3301.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 06:11:52 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 06:11:52 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Gray <bgray@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        "sv@linux.ibm.com" <sv@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "agust@denx.de" <agust@denx.de>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v2 0/7] Implement inline static calls on PPC32 - v2
Thread-Topic: [PATCH v2 0/7] Implement inline static calls on PPC32 - v2
Thread-Index: AQHYkvCn1ZX8CT7LUUOpHA8ZAimGXa11mwyAgFWD4QCACer3gIAAZAEA
Date:   Thu, 8 Sep 2022 06:11:52 +0000
Message-ID: <9e4be6b5-d9c3-8968-8edd-320708909347@csgroup.eu>
References: <cover.1657301423.git.christophe.leroy@csgroup.eu>
 <CAMj1kXFqs=YAbTDJOgzpse9ZkggSxPNNJJphEA=J94FQzF55qg@mail.gmail.com>
 <d35a2039-1755-b0be-6733-bb7ec19b2ea8@csgroup.eu>
 <47772b9ae10be6dbe5b0cfcd0bc14efc8fb22c0c.camel@linux.ibm.com>
In-Reply-To: <47772b9ae10be6dbe5b0cfcd0bc14efc8fb22c0c.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c47862a-a9dc-4ac0-b80c-08da916105dd
x-ms-traffictypediagnostic: PAZP264MB3301:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GeJrCsvKvzDPLVs9IlbaYxFO+R5dZed/xv9MMX//pViRXyCYNShwn9PtmUMGrvlEQ/Hy9JAymhInGL6bcnsib/p1rRX5CEtJwCV00Z17kuaaNLqI6KqCFf6O+O61lcuOoSnKnrAb/OBap8phf7ynewFPnYyUhuJ0w1F1uoSXoY0NSuyayYj1lDn9dhw0xKe9wvZiUJfcUL3YAUGlb8p2EDmrfK86pTG3vOKuzxSRbFbQZMsJHHoDx+inJSIMVaxC+4+0ughvre6Vqx6jt5zWJOVAiMkE44wR0Iphln6EUj8tn9v99uV9ofv0X16Ovj2kIxlHjv/4gdckdWa5cSitfv2EjP0f0/F34EjrsLmxPDLiE+WdLdcNPN6ynCYzfu+gQu49IMxjKDhATfobVCXT95U9ZkC7yJvAh2F9DPJFKIjuhUjU5aQOucT8XVSDKR2T2oNsewUh/4MFsOptlpyCyc0JZqQBbcawXt5Jbk1gPnMajWyia5qT4qRptZRNo2B2XCpaO4XHFsAtbfh6SiSVFokxZlouKNyMcS2zsbi3pL0XUHIJKgHG8hIFbYE/ePLkJEaLCqSV/BhLZ1MITyaM96nMwKAy7hrEIBXtnJBzTvmpfT73jnW1dMpCB57ClJO9F4nq3fg2KGxuXCWj3x+jtlNrf86bKjFGCS/cQ1mJOlb+g+4PClMrL8I4BB6+frWVz+KWEHxhPQK6q/9xgpGnml/KmFOxv2BL26TZ+EXZHYjlae0zNQu1eMZYf3PcNW2r/uIuKotRU1xRgvPeJ7NTqlI9P1pT1NfXoDKOTC7xriI2NtGfxyaYYS5n64IaWp/atm3FlvZhq+8Wy2zOfZeIEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(122000001)(8936002)(5660300002)(44832011)(31686004)(4744005)(7416002)(2906002)(38100700002)(91956017)(66476007)(36756003)(8676002)(4326008)(66446008)(66946007)(64756008)(76116006)(66556008)(316002)(54906003)(110136005)(31696002)(2616005)(186003)(6506007)(38070700005)(26005)(6486002)(86362001)(41300700001)(71200400001)(478600001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEJubm50aEl0dEVjaUxRMG0wT1l5NUVJalBkT1JmZDZoNTBtVS9VVGlMRFo1?=
 =?utf-8?B?QU9QM3JubjFLdHlvWitHa3VWV3paOEpvMlE5MFdYcUlhdlBVblJZcURyRE1O?=
 =?utf-8?B?d2xpaTlNZnpLWlA1MUw3UmwrK3hhQnprK2tucXc4L2d0NkRDZU5CN3BNenJu?=
 =?utf-8?B?OTRSNk82Q1ptalYwaXZmK1J0WCsyMkMvaS9pSktpTExqb2l5UUdWSkJJMXY0?=
 =?utf-8?B?bzA3MDlEL2Z4ZnZtTzdOazlqWlArYlhpcG04SGdXZkUyNDIxdi9abXQ2ZXZY?=
 =?utf-8?B?NmY3U0pTY25jZElHYXZNTldwcWpFbGNmU3ZnUVFTdGR3S0lDdDVnTDZKTUxr?=
 =?utf-8?B?Yk9iL3VSU2Q1d1dWNEdSMVVJQWF1aHJDNC9Wb0FnVG8yLzM2dEZsZVRvWXdE?=
 =?utf-8?B?UXlYUUJ0TjZZT2xhSGxrdEZESzdTOVJGb2JneVdOeTFDUEtxaExiVzJ0QWIx?=
 =?utf-8?B?bWhEZFI2OEJUMnorbExKMFR6MlpvQWUxU2xkQ2p0L2JUNWgyUWJqZjNLZjcr?=
 =?utf-8?B?N0lCdHlVa1VGb0Ivbk55NzQxcTgvNXJYWWZybndHeVFCTVdBbm1ZWDF0WjFR?=
 =?utf-8?B?bHVydm5rWEQveXNMaTB5VUJweHpHYm5uTWF6eEpyZjNDSFVZY1doWkpCekRh?=
 =?utf-8?B?KzZiOE9jY3lDdHc4UU9DRUNJQ2s0VHZabEZ6K0l1eXcxc2ZVMXRsSHg0OFly?=
 =?utf-8?B?S2ptdlQ3Mms4MFkzSldWWVVYcnhjbURuOG5Wa2xic0pkTndyRUhwck1Ta0NI?=
 =?utf-8?B?b3h1ODlUeGFSc0VWZ3YyNytJL0ZMaFVUY0YrZlphN3F4Z3FrZEhzdXl2SUdS?=
 =?utf-8?B?OHZrZ3RSYTVYVUh1SGMrWE9EZ2NWMitZbkVhNXlXamVBcHJKclZXZkZZTzUx?=
 =?utf-8?B?OHo4YVBPT1AvM0xVdFRKODJtcHR5WUVaRWkyMFc1dnF5MkRFWEduWVRsRFNL?=
 =?utf-8?B?NmkyMldtakYwbG9jc1QvUkUzU1N1RElCNU15SVh6REowQXIrTDZWOWpDenhn?=
 =?utf-8?B?czh5eGNNTGxBN2IrTTNTMmpuUUZzY0hHZ0IxTUozU3VkTVNDRG9la3VvT0NZ?=
 =?utf-8?B?cC9IVGhWV1VrbW9hVXVGK1RjTjRjYThTbkRrblVEU2cxQmJHdGkyTjJmNXJS?=
 =?utf-8?B?d2xuTFBqd0EvcGswWUZ2NnczNC9uNkhpMDdOTU1IUU8zckg3UExWVldLTEdN?=
 =?utf-8?B?Zm5MWFF3Y29pOTN1VGZaNFF1ZjFPME1RdVpzSkYrQU9ZUDFVN3lYL3BsaVV6?=
 =?utf-8?B?cTZwaHBnV3BpSng5eVVLWVk4eVNHUWwyV2pUOTJzOUcvTHpmV21QYVVMQ1RS?=
 =?utf-8?B?ZUpJZzJyQ00yeTJ5UzFzUUNqMnVBVkxYVU54ZG9PTmpoa0J4ZDlLT2xaRmFL?=
 =?utf-8?B?TkhYSGhnWWRvWGRveWVMdGJvWGkvRFhvdVY3YmllTks4cXJpL2VDZjFaWjV0?=
 =?utf-8?B?dDlsSEU2Z0hzWFExNm56SmN6eExtQkQ2ZXAweGJ1TkFkR0k3VUIxdk5BNDB2?=
 =?utf-8?B?cHgrNzIvUjBKdnZVZERuM0hGdFJwWmllNVZtMzN6ZjN3Mm9PbHBhaHZacktR?=
 =?utf-8?B?OGdJeVZwTmQyZnJNbjVTMXQvUHdLb1hrRmtzd0lIK1ltMkpqTm03dHhXYi9V?=
 =?utf-8?B?dU91d3IxUG1iKzhHSW04YVJwaG5pQzZzbUkwV1M2dzhIUXlmM2NqR0R4T0ZV?=
 =?utf-8?B?bHdSVnlrWURRbEFLM2xXT3Z1LzF3SUYwUUlDT3M5dXRQOUVwT3pkZXkxam04?=
 =?utf-8?B?cFF2Y0JTc01jL095SVpKeEx0ajdzbXpDOHVZaEZRb0pvWHJFWXJNZUQ0MVlr?=
 =?utf-8?B?NnlRTmc2WlBxa0U5N3BTMnNtVDRnOXZKTXhDL2wwNk5YVjc0eFRDVFZKZVlI?=
 =?utf-8?B?aGUrZEhNVUMvY0NxMFZNRDJvR3p0VVlVUzNENjVlU3RBS0dzOWFKck9MSnBV?=
 =?utf-8?B?MVEwNit1VXJIUEhvazhReW43dHNJemJENmlEWGpaOGpzenZqWGhDL0U4Q0RX?=
 =?utf-8?B?ZHluVFhESENTWlBaNEw0bUZZdGpJZjdOOXN5ZkU2M2F0a0NldlN2bDc1U2Nu?=
 =?utf-8?B?MVp5bExCajZaYmcrajdCOS92YWdEdVk0TkpYS3QwODl1RC9ZODFZV1JpSFRa?=
 =?utf-8?B?Z0d1aGJNNVk2Ukt1NDE3TjM0dHNWUkFjN0NuZHVpdzZrNkpIUHcrSDBWRHVG?=
 =?utf-8?Q?gU2XbuSmnqcWAB2AvOW3N7I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9475CF6A66DA604C8A35333CB3721317@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c47862a-a9dc-4ac0-b80c-08da916105dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 06:11:52.2305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YD2A0J8DHNgZPVMfTFg20AVOu8QhUjNRG7sziHywoT0cZAXz85G/1DkrimtGLixTndYc6U3O9IZGIIhWAmMRo+nhsCSJTkUcAGyHsAPpZZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3301
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA4LzA5LzIwMjIgw6AgMDI6MTMsIEJlbmphbWluIEdyYXkgYSDDqWNyaXTCoDoNCj4g
T24gVGh1LCAyMDIyLTA5LTAxIGF0IDE2OjQ2ICswMDAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3Rl
Og0KPj4gU3VycHJpc2luZ2x5LCBJIGdldCB3b3JzdCBwZXJmb3JtYW5jZSB3aXRoIGlubGluZSBz
dGF0aWMgY2FsbCB0aGFuDQo+PiB3aXRoDQo+PiBvdXQgb2YgbGluZSBzdGF0aWMgY2FsbDoNCj4g
DQo+IEknbSBub3Qgc3VyZSB3aGF0IGhhY2tiZW5jaCBpcyBkb2luZywgYnV0IHdoZW4gbWljcm9i
ZW5jaG1hcmtpbmcgNjQgYml0DQo+IG91dC1vZi1saW5lIGNhbGxzIGluIGEgbG9vcCBJIHNhdyBh
IHNpbWlsYXIgdGhpbmcgd2hlcmUgYWRkaW5nIG1vcmUNCj4gaW5kaXJlY3Rpb24gaW1wcm92ZWQg
dGhlIHBlcmZvcm1hbmNlIGRlc3BpdGUgZG9pbmcgbW9yZSB3b3JrLiBUaGUgY2F1c2UNCj4gc2Vl
bWVkIHRvIGJlIGEgY29tYmluYXRpb24gb2YgdXNpbmcgb2xkZXIgaGFyZHdhcmUgYW5kIHRoZSB0
YXJnZXQgYmVpbmcNCj4gdG9vIHNob3J0IChqdXN0IGFuIGludGVnZXIgaW5jcmVtZW50KS4gTW92
aW5nIHRvIGEgbmV3ZXIgbWFjaGluZSBhbmQNCj4gYWRkaW5nIGEgbG90IG9mIE5PUHMgdG8gdGhl
IHRhcmdldCBtYWRlIHRoZSBwZXJmb3JtYW5jZSBtYWtlIHNlbnNlLg0KDQpZZXMgbWlnaHQgYmUu
DQoNCkkgdGhpbmsgSSdsbCBmaXJzdCBkbyBuZXcgdGVzdHMgd2l0aCBDT05GSUdfREVCVUdfRk9S
Q0VfRlVOQ1RJT05fQUxJR05fNjRCDQoNCkNocmlzdG9waGU=
