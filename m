Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6930F54F0BC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 07:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380106AbiFQFsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 01:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiFQFsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:48:15 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120070.outbound.protection.outlook.com [40.107.12.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82665532C9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 22:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c10E+KqxIPRU+3VW1bVi/26pG2IcDzPMtuBt6WglOlSR2MIKK7XPAITQQ9y3qwqirIBIJx6MSnwXrxpF/mJib9dLff2ZaWzqZowO+22Q+cWtKNcMWuQ0IrsFUEveZ6gXykhVD5/weHQHIrF7IGfhAujdeUtZevTVHWwRyX8e37M6myzKi57C4pkodh6z3ZogdJPh45/Ct+syK6k0mZhkxvpRNx96G8Fv90+ySwQuAF4lluV+2olRGenuGbL3AXHL8cVetKfNYdXCZYIcKm4n7PKnymwRk1rCWRQnLrVuiooPn+IZqolx7w/tK9mB0u4VvtRT6/T+HgUhhx7L0goVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0OjQ1t+zvDmp4BQXCh0/BnX6pXkKufGQY9pLbQAxkA=;
 b=TuhYTHKTwfZBsE6B1YxRDzznv8/xN6Phh/V8cqy7DrBE+SaB7/tH9Lk/xm6pRDDos1qb/qZ53rEwUF9OlMx/icdmxSX+6qruyNuk2yboIRHILGFm9JqjH5y9Th5hlIPt5Oqu+kDuPD/vJ+XpvxxIA/AZYI+RyE3uKdbmWCuRO8novUSZH4FS0jBsj6bIEtK//fw6jdtoD9gHUkwMUUzmK1YA2dnxQ2kcXc88npLZadymHoMo3K/1qoNLiG7f2A8mZ8adG0VDPsusMtZkgj/PaJwNoIae5vSk4UgNWLSYzPUhZKz0rbxLVsePlYnD21b07bv7Ic2dT++bKqurFIXFtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0OjQ1t+zvDmp4BQXCh0/BnX6pXkKufGQY9pLbQAxkA=;
 b=WC0HFbaFiQE7xP+AUXs7KhpF0yXFNOZe0RK0RSwvxPaxQbC9tXvuamgjFUyCMbTxI7gIX724+dU5grFwoUG3QAzqUSrF4SGbab7fT8QLBbpOeoT2BScNwZtk7vdszOUPaTFZ0tJi4FpYNVOWacsmLawzrqngp1g2G8UcKe2Nf6HnNLKq5VKFRON9SHXhB9ML3nCSuuBg562nXq+wvAGaWdCbHc0k3bLacju0AKg26o4Ngg0aqEs29Hbk0DGcvSK7yvd0c1KFZEGBIDKgxUcqCSkqiLfLuRfOsbfEMzpPLjU3oJMQDbaEh0mf0iq6DS/19PhQB9IMenA7Vaa7JnXURw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3010.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Fri, 17 Jun
 2022 05:48:11 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356%5]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 05:48:11 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 2/2] mm/mmap: Drop generic protection_map[] array
Thread-Topic: [PATCH V3 2/2] mm/mmap: Drop generic protection_map[] array
Thread-Index: AQHYgTbqSfMGmo1TpEeDUHkZHTGmdq1Rhi2AgAAHb4CAAWTJAIAAJtWA
Date:   Fri, 17 Jun 2022 05:48:11 +0000
Message-ID: <43205917-0517-4e45-6fbf-4fc849fb0325@csgroup.eu>
References: <20220616040924.1022607-1-anshuman.khandual@arm.com>
 <20220616040924.1022607-3-anshuman.khandual@arm.com>
 <7cf922f4-2367-e173-0280-cb498391d9f7@csgroup.eu>
 <YqrJvV/dWK/iyVvR@infradead.org>
 <7c72a97f-d7d4-db27-faa5-fec01673cca7@arm.com>
In-Reply-To: <7c72a97f-d7d4-db27-faa5-fec01673cca7@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5886dec7-64e3-43ae-d9af-08da5024f6f2
x-ms-traffictypediagnostic: MR1P264MB3010:EE_
x-microsoft-antispam-prvs: <MR1P264MB3010AD9600612404840B6567EDAF9@MR1P264MB3010.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xUFvbyn/qgOwkzMni9nQY7u8ZnnkldN9EH2XZWFytQuxU+UNMNgs3su5oYOyq73ITl5NiCZ5gkoT6qQUJDP9kEqYNiLLSsea6ddQ13kMcQ+swIYxpgBvhK/8FuCpKnIgA9Xlihcmjq7o2jScEugo79SAhXA2K1d4TwqJbyEnKoUFbnF5Ivx3Iq4ZTKaAxmO+M4AGTkvgckE8GotjCyezaqfe7X05MLPc2fXxujT/ZqzEQBCyJFBLb4tCQFD+CDsGE6PhhyWr3vFD29Xq0leaDAqIJD4zTLoPK5UzaiUPC2RUOWZ8pK3l599b8ASqBFYEyKomqyeRpt9FX+T39NezALy9xqD0IgHeGRQYYpxHkeAk5vLR/AclmfnH1Lsr+LSZU7Q29J832SsGWGoWlBU9gxC8JZV3IMPpvoR0tJO4L8wSZxkcYA2at+ByqKTeYTDMXy0VD2qm3oe/J8vBqtBNhmBUstaj6DCt3LYT33Kz8myg+GAPUsMmGWRlFCnTOA0GrsHIfq4XGNbN3xkqSJZP0umboBCB00tH1Ki+Hj3XhH3wSVAitJIcSQpcPmDy/5rU2yy34iae9kUa+6Zo6wJMwdyZPPwgCfBP6r/Prkq+nrv4wm+bGnvQWWezeu2ghTi1BV6EWU2/SS/zBnv/AXwpRnWPOtPGW5ivk+l+HmwtWmQzQWWai9Xp5tVKcNlazL3Ib7c9FBIFu1vRCJpPjLkrrSbBp74OBngrTI/hhuk8zzm6BcZUjUUBlXgM4Cb1+WCjfrojWPl1h74CnVBL9vy3asB6/ZTSi6kNh821w3kOeUs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(122000001)(498600001)(44832011)(6486002)(2616005)(316002)(5660300002)(38100700002)(8936002)(186003)(83380400001)(53546011)(6506007)(26005)(38070700005)(76116006)(6512007)(86362001)(64756008)(66446008)(2906002)(31686004)(4326008)(66946007)(66476007)(66556008)(8676002)(54906003)(31696002)(110136005)(71200400001)(36756003)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um9JTktoTVV0Sjl2eDFNTE01Mzk1Ri9kczRaeXBoK0o1aE5EVWpnZDFnT21L?=
 =?utf-8?B?RmN1aGdZdTRUaXBkeEk2K01pemozeTc1UUlHU0g2RStKdHliV21LZnVYazRh?=
 =?utf-8?B?a0YwbHYxUmY0L1prS2FGSmdmWm5wWENuQXV5eVFINmFsakxuQXdsMzl5OVZ2?=
 =?utf-8?B?dFdrVml2U2dhNG55b21zRURmNDB0dGpQY0F5cVZxckxjWmFhSThjN3ZWaitE?=
 =?utf-8?B?T3kwcEJLWWhRTjRabk9WWG1GOWt4ZGNtVzFhUFJ5dW1NNTZuS0ZJZjgxYUdi?=
 =?utf-8?B?MzgvQ0YrUXgzb0Q5TzR4RnYvMlF1K3FvYkx2WUFadExFR1lRTllFMTVOS1NI?=
 =?utf-8?B?MWRjd1Q1QXlJOHc4M3dETXQvK0xwcTA1cVBUVmozbmpBbFV5b0FXZWNKTWw1?=
 =?utf-8?B?RWR1Mm8xYWwrdlVsbDU1SnBqd0xiNFdZc2VUcmNMRGRjbWVGN3hoalV5S08r?=
 =?utf-8?B?VmJRWmNSSVhaaEJSZk5Pb2JwVytSdWlzdlQ0YkNQOTVsRFl6VWZyZS9hTnlp?=
 =?utf-8?B?REk5U1hwMGsyN0JvMXBHY013TnBKYjlKR0NVcnYzUWVVOXRTZEZVdDZ2WjRQ?=
 =?utf-8?B?Qm5xandmUFhaTWR6cWhZanliOW9sZWo4alNoTkRnR3BEZ1NvaW1FcTczQnhr?=
 =?utf-8?B?V0ZSNmQ3S1ZrRjJOcWlKWms0L1ZWdDBDZTRIQlpxeWQ2aE5QVGI2b3k3VDZY?=
 =?utf-8?B?QXJTc2hkdytnZWM5TTBXMS82MnZiWnVyZzdadGhUaEdFYlU0U2lLT3dlWjJD?=
 =?utf-8?B?NzU3UGduMGlUT1QxRnV4Z1pJSUlWZDFYa1NPL24vTHdYT21LeW5SUk4wbm1p?=
 =?utf-8?B?cUxyNGRxOE5WT1VKbDJiMW1MTkprQzFEUXZER0xOOHllU0xyd2RhR3dQeEM4?=
 =?utf-8?B?dTVZOUpscGFkVDZQUE5ES242ZUthM0xzMlRRbEVqT3VOd2tsVElJRm5Hb0Ux?=
 =?utf-8?B?a21MV2l6c01pQ2ZzM1hBYUowWWErbEZOaHNLSnkrSklUUHF0eTdCZlB1TFpX?=
 =?utf-8?B?OVF5dGkxU3lyQ25ZYkpGaG1VSzVPTkZCdStHNnU2M3VmVHd6TkNwVFI2a1RG?=
 =?utf-8?B?SERySTdyb0NROTA0bmFyTFE2dUozM1JqT2lkS1dvUXk0WlJpcjVnc0JGQjZo?=
 =?utf-8?B?akJQUUl2eTBVQTdHdW9uRXFBZEprK3Q2UkFiaGhFamVtN0phakJzQm81anVX?=
 =?utf-8?B?d0tDZ2h4OG12UVh5UDFrM3FRV2JPVnlQV2MwMnNXT1MxVWgzcG55SU53RzRp?=
 =?utf-8?B?V3NNL2c4OWtLdzVDcXFjVDJJSkNFeG0vYm52MGhGY2g0aFBDYXpNbllibW1Z?=
 =?utf-8?B?Yi93bmw3OThRdzR2aUpBdnFBeWl0cjhkK0FUUFNpbGlvNTU1QVY1aUxBempR?=
 =?utf-8?B?dnp4aVVkYmt2WXdjanlSRjd0Sm9NQmU3akNHYjJJK0lncUlEL1Y2K01MZHZ5?=
 =?utf-8?B?cDdyU3ZOeUpLZVZQLzFaK2dXMTVEL0FQdGgwS3daNG1iMlBZT1d3MVloaHBJ?=
 =?utf-8?B?Rk1oQVFPSHU2ZzZtYmVkSWRxNHE5ZjEvVHZVMjdRK1hFNlIvZVZCYWM2MVNH?=
 =?utf-8?B?VHhrQ01hZ0xuaDJWRDNUdWt4K25icVNOdkgrZ084QzBkR2Y4S01XaFF1RTJr?=
 =?utf-8?B?UjFIVkVEU3pkOW5DcjY4cGRPb25GeTFCZVlvQmxyVVJMV0pDY1lFT1k3cjg5?=
 =?utf-8?B?YTVxejExSC82MVEwdmQzUmo0L0trWVA4SUdZQ0tCSUN4SFY4NmUxTUFnUHlU?=
 =?utf-8?B?emtWbllLSUZKOEdBcGp2OUNVMTZkNzRmZlFVYkNHMlViOXFSUWkxc2VwcFNZ?=
 =?utf-8?B?SEt1N0ZpYWU0VkJVRE5vT01BZTByY0VrdXdnTkppQVZQRGFhMDA1MTZFM2hM?=
 =?utf-8?B?VmkwU3l6VzZOUlJIbi9hVlVUSU9ObjltMC9XNC9QQklXSEcyTm5NMElBaE1k?=
 =?utf-8?B?a210bjl1TmhoM2hWOTVqM0tPUVI2UTNSdFExcldQQVdFSVg4czIra3Z1d3FW?=
 =?utf-8?B?WW5PVU1KV3RkaFl2dEs4M0s2SFdtRjEzMlc3dWNLdTlVZ2VnMzBIaThqVlJY?=
 =?utf-8?B?c3I0cUFjUVJxdWxVYVB3QXE5WWEzOVJ5NkYwNmRRUHFoay9kSFRQdERzTVdD?=
 =?utf-8?B?Q3VTY08rcko4bXNrbEVINmZZL2lkS0cwVVpJeThiWGVBNFMwSSswcDFIWDFT?=
 =?utf-8?B?bFhtM3pFdjVSYTV4V3JXL1pzSmFIS0xzQU8xcVVTeVNMYzdRSU5hZlBBTFpO?=
 =?utf-8?B?UjlvSC9xeUVBbnE2ZVdJbDFSSzE0b0xpVkxyTStHREVrOUFGQW1LNkJJMHNo?=
 =?utf-8?B?b0szSWVlMzcwaWFVaHNab0xhTHVET0RPekxvNXo3MGtIUmJLdmlJNEhGZy9T?=
 =?utf-8?Q?2XLOfrwAvmHv6USkdtzacr767HonHZ+aItGvh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD42E866D5516243BE264B827AA23C70@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5886dec7-64e3-43ae-d9af-08da5024f6f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 05:48:11.8345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjZSFtyVjepBg+xxRBGH1OdRvK9INvdHSk2wAkhfUvMV/zeHt9OH8EHXy1qBgktHeV/cFNva7LkUfszpTXr18t/sYxe74w6qFoykBEmHiRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3010
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE3LzA2LzIwMjIgw6AgMDU6MjksIEFuc2h1bWFuIEtoYW5kdWFsIGEgw6ljcml0wqA6
DQo+IA0KPiANCj4gT24gNi8xNi8yMiAxMTo0MiwgaGNoQGluZnJhZGVhZC5vcmcgd3JvdGU6DQo+
PiBPbiBUaHUsIEp1biAxNiwgMjAyMiBhdCAwNTo0NTozOUFNICswMDAwLCBDaHJpc3RvcGhlIExl
cm95IHdyb3RlOg0KPj4+PiArLyogTm90ZSBkdWUgdG8gdGhlIHdheSB2bSBmbGFncyBhcmUgbGFp
ZCBvdXQsIHRoZSBiaXRzIGFyZSBYV1IgKi8NCj4+Pj4gK3BncHJvdF90IHByb3RlY3Rpb25fbWFw
WzE2XSA9IHsNCj4+Pg0KPj4+IFdhcyBjb25zdCBwcmV2aW91c2x5LCBub3cgYmFjayB0byBub24g
Y29uc3QgPyBNYXliZSBkdWUgdG8gYSBjb25mbGljdA0KPj4+IHdpdGggbGludXgvbW0uaCA/IEF0
IGxlYXN0IGl0IHNob3VsZCBiZSBfX3JvX2FmdGVyX2luaXQuDQo+Pg0KPj4gTWF5YmUgd2UganVz
dCBuZWVkIHRvIGR1cGxpY2F0ZSB2bV9nZXRfcGFnZV9wcm90IGluIGFsbCB0aGUNCj4+IGFyY2hp
dGVjdHVyZXMgYW5kIHRodXMgYXZvaWQgbWFraW5nIHByb3RlY3Rpb25fbWFwIGdsb2JhbCBpbiBh
DQo+PiBjb21tb24gaGVhZGVyIGVudGlyZWx5LiAgVGhhdCBjZXJ0YWlubHkgc2VlbXMgbGlrZSB0
aGUgY2xlYW5lcg0KPj4gaW50ZXJmYWNlLg0KPiANCj4gQWdyZWVkLCBhbHNvIGl0IGRvZXMgZnJl
ZSB1cCB0aGUgcGxhdGZvcm1zIHRvIHByb3ZpZGUgYW55IGFwcHJvcHJpYXRlDQo+IHF1YWxpZmll
cnMgZm9yIHRoZSBwcm90ZWN0aW9uX21hcFtdIGFycmF5IGkuZSBfX3JvX2FmdGVyX2luaXQsIGNv
bnN0DQo+IGV0YyB3aXRob3V0IGltcGFjdGluZyBnZW5lcmljIGRlY2xhcmF0aW9uIHVzZWQgaW4g
YSBnZW5lcmljIGZ1bmN0aW9uLg0KDQpNYXliZSBhbGwgd2UgbmVlZCBpcyB0byBrZWVwIHByb3Rl
Y3Rpb25fbWFwW10gZGVjbGFyYXRpb24gYXJjaGl0ZWN0dXJlIA0Kc3BlY2lmaWMuDQoNCklzIGl0
IGEgZ29vZCBpZGVhIHRvIGR1cGxpY2F0ZSB2bV9nZXRfcGFnZV9wcm90KCkgaW4gZWFjaCBhcmNo
aXRlY3R1cmUgPyANCk1heWJlIGl0IGlzLCBidXQgaXQgd2lsbCBhbHNvIG1lYW4gY2hhbmdpbmcg
Y29tbW9uIGNvZGUgbGlrZSANCm1tL2RlYnVnX3ZtX3BndGFibGUuYyB3aGljaCBhY2Nlc3NlcyBw
cm90ZWN0aW9uX21hcFtdIGRpcmVjdGx5IGFzIG9mIHRvZGF5Lg0KDQpPbiB0aGUgb3RoZXIgaGFu
ZCBpdCBtZWFucyB3ZSBjYW4gdGhlbiBkcm9wIA0KQ09ORklHX0FSQ0hfSEFTX1ZNX0dFVF9QQUdF
X1BST1QgY29tcGxldGVseSBhdCB0aGUgZW5kLiBJbiBhIHdheSB0aGF0J3MgDQphIHdheSBiYWNr
IGludG8geW91ciBmaXJzdCB2ZXJzaW9uIG9mIHRoZSBzZXJpZXMsIGJ1dCB3aXRob3V0IHRoZSB1
Z2dseSANCnN3aXRjaC9jYXNlLCBtYXliZSB0aGF0J3MgdGhlIGJlc3Qgc29sdXRpb24gYWZ0ZXIg
YWxsLg==
