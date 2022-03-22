Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054DA4E471E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 20:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiCVUA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiCVUA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:00:26 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020027.outbound.protection.outlook.com [52.101.56.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4D85839A;
        Tue, 22 Mar 2022 12:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odSUaBI2leMzl/HBBIeg+033o4Uc8/hFjPmQ3Hen+hJquymNXYwwZNJXXrLpTN+COwzsOba+Vb/35EBFi8WLHAvTkdzDjSLdmCh94LEDyzUYyY8wM3O+BOBYdAgfqo/R4l7u7CedhUEqHFe0CYsScHCu7LAWcoW0nprYn0vz+QNaldDoGz/XuLuu2uHVFUTXmm/igiMLK1KCOPVFADNAt/jlpCYRrf5zyT0c2yJDNu/RDS3x/ef/sgX4/bSzQ18/jnh022ru4U0h93IbejFtG5H5l4k0QSK2PDOpzeps928F2jhUS52t8OYkLxiJr/xjFVxmAOi9BRlrvLMnDQFsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHD+8943sqXBLsdTqnGVhySR04Rg10cXaliXcMYyDW0=;
 b=bMveAl1ADS5ROhDLfIFNdZg5DmmhajLpOfv6YMxIEdY8L06fl0WnR8DTzWx3uUFd2PDyHwyXU11e6uqc+96ukSCA7BkYUZEs1ElWS1CSOzEVHr5ZYkErwkT/GwW+Fs76j3ZLgR+K8eoseZmKkrgP/IqG3HMQveo50MukxGLTSJEPCzMC4lWtgZs450VMaRYkaMesw6MfwWnu3xryPVNFM6ACPEnzLvNsaLOpg/L19ica7ks4JilJObbaP56O/LJmE7r5jnXgVMH7Ya9m9QzCbm6k7XyJOK2nYR2YzYgAopDr/Ae02w7C6ohJ5o5Wx+Tj7MnldN95SmE5k35FJWd7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHD+8943sqXBLsdTqnGVhySR04Rg10cXaliXcMYyDW0=;
 b=epbBGny8jqQoyE2wKoxaFreWVkSpHECt2/gE+b94SPAg3q86Sq1diui7yG+RVUmyP1fO6YRmjvjyEFEZbkpq3LxDzEpKUXkeOwBXqarp7LLwhFRP01CbLWIIonnws/XVzR8uSQneCGpxODuTrUV5yIS5j/3e8D6n9tcmgWv6HkA=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by MWHPR21MB0175.namprd21.prod.outlook.com (2603:10b6:300:78::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.7; Tue, 22 Mar
 2022 19:58:51 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::71de:a6ad:facf:dfbe]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::71de:a6ad:facf:dfbe%4]) with mapi id 15.20.5123.005; Tue, 22 Mar 2022
 19:58:51 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     jason <jason@zx2c4.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 2/3 v6] ACPI: allow longer device IDs
Thread-Topic: [PATCH 2/3 v6] ACPI: allow longer device IDs
Thread-Index: AQHYLNK4fL59pmJF2Ea4CQMRQ5s3a6ypbsWAgAAEo4CAAAbTAIAAB7CAgAACs/CAAATqAIAAA+TAgAADDwCAImLl4A==
Date:   Tue, 22 Mar 2022 19:58:51 +0000
Message-ID: <PH0PR21MB30253A8BA8B189686B8E65EAD7179@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com>
 <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
 <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
 <Yh0+LA8B1jw8tnl9@smile.fi.intel.com>
 <CAHmME9qW4EiYU6_kTffMdK5ijJY1DF6YRt=gDjj1vKqDxB0Raw@mail.gmail.com>
 <MN0PR21MB3098981B77F513976A62CA57D7019@MN0PR21MB3098.namprd21.prod.outlook.com>
 <CAMj1kXFZZoOeXnjxdU+gOJTN=Szn=eiXgRhSS9_nnHgwADNHjA@mail.gmail.com>
 <MN0PR21MB3098EC13B4E8488E692DB28AD7019@MN0PR21MB3098.namprd21.prod.outlook.com>
 <CAMj1kXFe-B=n1zp6M0yBuqJmmfOXTFbkzj29iK+QpPGK=LxRmA@mail.gmail.com>
In-Reply-To: <CAMj1kXFe-B=n1zp6M0yBuqJmmfOXTFbkzj29iK+QpPGK=LxRmA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e42bb410-e48e-47dc-8809-8d534964cdf2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-22T19:53:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4ca3df2-a555-4b6c-591d-08da0c3e630d
x-ms-traffictypediagnostic: MWHPR21MB0175:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MWHPR21MB0175129053E7BD7688A6ED22D7179@MWHPR21MB0175.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6L4+bQRaBxPk3pBzjGe+jcst6U5yF1isSl4QkGPf/ct8/mgoeE5eFVFVsLP9Mht5zKT+kxe/BJF5qWMUJ5WRDAr3A4Z+RlyAe1ef3qdvP37GqBS19PQZh7QgbXExKxJHyaQUdnDwAg6j69gqkJ+a3krEEW6GJ+vyFNpaZmNsUSV2p+wxKjsgah1+z+CnPwzt6J9zOGfUtv74TGCDa3TvJKL+HG22b/9CiMPJYEbxXewaNdEyxYMXuQQEcyz42gJhj50OPjzlp5glqrE39WzA/W9fK/xC+uPB9HVtFdACnChA3E9Z8u5ve4fG3PCV3x+TPmjm1vxu/l08H99B7dGko//LwDhJWx7eLqcxEoS7YJo4mzK6GV31EelDr11KANjU6FBA7RP3flZCW4zRyOs+qOgrYEawFUgMV422iEL7PC84R3nDJJLRf1CYVU/f5mRgiQge/fcg2gm49sJ1jtP7eqEcClU/bxw0aFnQAfU/eN/n4q2Ymp/0RBOHqPk5fYjPDxxmlLrjLKYwMwkAiVwcGTT9fmR8GupZKVfSU1MC+NhQc00K6Ob2U/tS636kXIaJCahraeqxsGBc9SDNJ1BbMQHMYY3Gxd9Fre5sRkVsQEKpKOCdAdZGXUlUMiCpMrzNXRgv0dlg7VQ4WI8a6yTHfD1aOqDYsCS2W4hlLGHyXvZpzW1WcrvNLhX/bt7ZALdYNeAE32OIQuiPbssDKT5EWtOBxk6xO8X+ZBQwTAqQe5t4/H/vhP8hOXx+joQipS3x/gWgHDh0xpW3Icf5udG2lCQxPf82mz9dGNt+RgSOFME=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(8990500004)(2906002)(54906003)(6916009)(508600001)(86362001)(53546011)(71200400001)(7696005)(6506007)(10290500003)(5660300002)(7416002)(33656002)(52536014)(8936002)(55016003)(83380400001)(82950400001)(82960400001)(38100700002)(66946007)(66556008)(66446008)(66476007)(76116006)(64756008)(122000001)(316002)(9686003)(26005)(186003)(38070700005)(4326008)(8676002)(148743002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjBzZTN4YlRoKzFCSUozbDBEMFNmZEhIZXU1ZjlmaG1TK3lyZ0plZitSN0t3?=
 =?utf-8?B?Smk2MWl3N1pYZmoyZ0U2cFBqNWlpRGg1UTNFY0FWOUlaT25hY1NGRjlLNW1R?=
 =?utf-8?B?WGdla3VvMEFtR0diMzB3SnFsWlQzY3cyZjVPcngyVnBycEdwakJNOHFvcmtr?=
 =?utf-8?B?VmFPOE5QSDAzY0hER0dPRDRJUis0Vmg2azB0b2ZYRjhGOE9BQzA3SXROT2pu?=
 =?utf-8?B?WGF3WEs3Z0VEcVRpM2FaRnhhV2RTNVNOTjFPSktNZ0xYWDJwZjE1UUdUYkht?=
 =?utf-8?B?Z2Y1SGtKS3dnWjZ1SDU1am9HS2wyTjU5bjY4QUtFcjJUeEYyMjFrU2hKeC9B?=
 =?utf-8?B?MnJKU2ZpNWVhRVRHTCt5bS9LaXVjN0NMWEJpdkRxbkM1aml1N1pydFk3N0xB?=
 =?utf-8?B?UHBRQ3NwbEZPRDZzYXJYVFRkSjQ0enVjZkNGRHBNS2tpbkM4S3pXdjZHRUJB?=
 =?utf-8?B?ZGx4Y2FlT3BzS3lqaFNhbFpoV2h1VlZTNVZMb2ZsODJKeWcyZzhzdDdEL09w?=
 =?utf-8?B?azRKRElUVjBzaHZVOFBNOHZHRHFVc2FGZ2FONjdWaTNmSUora3ZTRXE3QmNV?=
 =?utf-8?B?N3REdDcvTjdOL2ROOWljYUdWb0l2WVhzUHZGU2VCWUpoQ2l4R0cvMEc4a2lr?=
 =?utf-8?B?RERUalBueTUwTjB3TGVrclpmbkFKRnB4U3EyTWVYcXZQUHRrcG1DL3VaYVpB?=
 =?utf-8?B?QkFqNzg4dHg0cXloYWk3SEFPcUNyYkwyQ1AzMjdRckpYcTVreStMSlhmVzFl?=
 =?utf-8?B?L2I1VG9rN2NwYms3dVUwcDQxdmR3ZnBaVzlzZCtHVjJoUXhveVR6UUFCZFd4?=
 =?utf-8?B?dUNvbHVhTmpHeDRwcmZZOGNXZW9NeU9ENUNLZFJaS1RFRTFMNnNWSUdDYUt2?=
 =?utf-8?B?RGprbVRvbnExYXltT3JMMndpY0l0WHNMd0dEczFOUk9TVEVPMXRGeWVMTUJq?=
 =?utf-8?B?VC82a05jQ0JHUW5BMUFvQXhFTmJRUWs0RHlOL01yS3drSXZ1clFhN0R1OC9U?=
 =?utf-8?B?VXQ2Y0xBMFIzQnowem5Ja1hnVG5HQlYwMTFrV3BVR2c2S1JYQXF5WUtNWGZR?=
 =?utf-8?B?dHF0bkFoVERUT1hWY3lBY3lra2JRcEwrT1JzbVZ0dS9YUWlUK3Mzc2Fnd0hy?=
 =?utf-8?B?VDFNeUFaSS80UmxzRWFFQjlTVTNBdTVYWmYxVFA0WEFnUXJidUVodlJHWnVC?=
 =?utf-8?B?ZGg5blVsQlJOa21EN2RWUGp0cDhlY1QvZXRjSlFOR1VCaUtqeVl6OFhTdUxk?=
 =?utf-8?B?aktZb1Q0WE4vMFQrMTdad1Q5OHBIdE83L0dBRkJVRnlmV3VaSHpUcTc2VmRW?=
 =?utf-8?B?TDk2YkZKc3pNa1JNd29pS2R2YUJxSjNJdlk0L05kTEx4WFVVdG8rMkNHLzh5?=
 =?utf-8?B?WUVFSGJQa2NOeFl6NnRHbGlTNHNCYS93SFp3cjBlT3RVdnMraFFOalFadnVX?=
 =?utf-8?B?USthcmV1R0V0Y2NJSEVjQ1RrRldGMFRxaVZhTFBKTGZ4K1p0TysrN2Y1QWtD?=
 =?utf-8?B?V0tyL2ovbEtqZXNzSHl6Wk9iaDlZckhDVXpiZEpvbkFhcDlWZGxPU0FUU2E4?=
 =?utf-8?B?QUJid09xS0tqbkUreXhiR2U3cjhoVHd2MHc1RkF3dU5YY2Rwd3FQUmlKZnFi?=
 =?utf-8?B?blNkVUFVM1BNdkxkRVlaZlBZYy9nUzFqdzVTWUxJODg5ZXpxK0VWNFloTHRI?=
 =?utf-8?B?TG55QmxyNVp0SUJsRTV5L0dzZHViazk5eXpIODB4L0J2SFpEZkRmbmJVWTNY?=
 =?utf-8?B?MS9HaFVmbUFFNTZHRld1THNvZFovOEk0QjVGdklyODJOZkNGdlluQ3NtaHM0?=
 =?utf-8?B?cWt2dkhjdmlTVTJSelhTaU5RdFpvS21Ma1F3ZDNPUUk3RWZ6TTlPOW54Rlps?=
 =?utf-8?B?MHVmUCsvM0c1WmZ1S2lsSkx3Rmx4eVZMakJZMVVPdFZ3MWNJTC9tNWlMSllx?=
 =?utf-8?B?ZEI4Yis3YVREQjRQNnI1VlhYUStSa25kSGg3SHMzVnc5OGRpRmZyWlNpYTVu?=
 =?utf-8?B?d0wvUkM3bmt4ZGFXL1VlNm00UkttaHZNZkxBWUxudnZyLzdlZERiKzhBbkx4?=
 =?utf-8?B?NC9XazlmUFpJWjViVHVGWmEzUWlsbjhEUW94WXB4Ulk3UTFSMUtVUWxvU3l4?=
 =?utf-8?B?NzBUeWR1eWkwMGZFYm1RcmdLZGFjbC9WVmRoZ1R0Q0ViNG11MEdibG1wYjNk?=
 =?utf-8?B?TmVsZUt3RiswMWw4ZUM0ZEpNWWFJTHR0Vm1xUU9Udnk4VEUzTjBLVmJONXlw?=
 =?utf-8?B?a0VER2pOWW1taFJaRm9VUGE4enJxVXZNU2dwWUM4RlJQckthYUlJcTExQ3Fm?=
 =?utf-8?B?VG1sODlNcVVqWmVDSVNTams3cS8wd2R1eGpFN29jejUxQnd2OE0rTnZhL1BO?=
 =?utf-8?Q?8bZRoEARWQ/XJNSw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ca3df2-a555-4b6c-591d-08da0c3e630d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 19:58:51.4721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dk2Yx/6+fsVEmu1lfD+J29YFELAxDkovtnDKZZvpJSrk95AFgggh0deuLCITD4k7m2JB9CkGWKYA/rBwUpVpfhxmMnXOKuMG6lcPUZ3NHy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0175
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4gU2VudDogTW9uZGF5LCBGZWJy
dWFyeSAyOCwgMjAyMiAyOjQ3IFBNDQo+IA0KPiBPbiBNb24sIDI4IEZlYiAyMDIyIGF0IDIzOjM4
LCBNaWNoYWVsIEtlbGxleSAoTElOVVgpDQo+IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPiB3cm90
ZToNCj4gPg0KPiA+IEZyb206IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+IFNlbnQ6
IE1vbmRheSwgRmVicnVhcnkgMjgsIDIwMjIgMjoyMiBQTQ0KPiA+ID4NCj4gPiA+IE9uIE1vbiwg
MjggRmViIDIwMjIgYXQgMjM6MTQsIE1pY2hhZWwgS2VsbGV5IChMSU5VWCkNCj4gPiA+IDxtaWtl
bGxleUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gRnJvbTogSmFzb24g
QS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkgMjgs
IDIwMjINCj4gPiA+IDE6NTUgUE0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEhpIEFuZHksDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBPbiBNb24sIEZlYiAyOCwgMjAyMiBhdCAxMDoyOCBQTSBBbmR5IFNo
ZXZjaGVua28NCj4gPiA+ID4gPiA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4gd3JvdGU6DQo+
ID4gPiA+ID4gPiBNeSBwb2ludCBpcyB0aGF0IHRoaXMgaXMgY2xlYXIgYWJ1c2Ugb2YgdGhlIHNw
ZWMgYW5kOg0KPiA+ID4gPiA+ID4gMSkgd2UgaGF2ZSB0byBlbmFibGUgdGhlIGJyb2tlbiwgYmVj
YXVzZSBpdCBpcyBhbHJlYWR5IGluIHRoZSB3aWxkIHdpdGgNCj4gPiA+ID4gPiA+ICAgIHRoZSBj
b21tZW50IHRoYXQgdGhpcyBpcyBhbiBpc3N1ZQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEFO
RA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IDIpIGlzc3VlIGFuIEVDUiAvIHdvcmsgd2l0aCBN
UyB0byBtYWtlIHN1cmUgdGhleSB1bmRlcnN0YW5kIHRoZSBwcm9ibGVtLg0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IFRoaXMgY2FuIGJlIGRvbmUgaW4gcGFyYWxsZWwuIFdoYXQgSSBtZWFudCBh
cyBhIHByZXJlcXVpc2l0ZSBpcyB0byBzdGFydCBkb2luZw0KPiA+ID4gPiA+ID4gMikgd2hpbGUg
d2UgaGF2ZSAxKSBvbiB0YWJsZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9oLCBva2F5LCB0aGF0
IG1ha2VzIHNlbnNlLiBJZiB5b3Ugd2FudCB0byBnZXQgKDIpIGdvaW5nLCBieSBhbGwgbWVhbnMN
Cj4gPiA+ID4gPiBnbyBmb3IgaXQuIEkgaGF2ZSBubyBpZGVhIGhvdyB0byBkbyB0aGlzIG15c2Vs
ZjsgQXJkIHNhaWQgc29tZXRoaW5nDQo+ID4gPiA+ID4gYWJvdXQgam9pbmluZyB0aGUgVUVGSSBm
b3J1bSBhcyBhbiBpbmRpdmlkdWFsIHNvbWV0aGluZyBvciBhbm90aGVyIGJ1dA0KPiA+ID4gPiA+
IEkgZG9uJ3QgdGhpbmsgSSdtIHRoZSBtYW4gZm9yIHRoZSBqb2IgdGhlcmUuIElzIHRoaXMgc29t
ZXRoaW5nIHRoYXQNCj4gPiA+ID4gPiBJbnRlbCBjYW4gZG8gd2l0aCB0aGVpciBleGlzdGluZyBt
ZW1iZXJzaGlwIChpcyB0aGF0IHRoZSByaWdodCB0ZXJtPykNCj4gPiA+ID4gPiBhdCB0aGUgVUVG
SSBmb3J1bT8gT3IgbWF5YmUgYSBNaWNyb3NvZnQgZW5naW5lZXIgb24gdGhlIGxpc3Q/DQo+ID4g
PiA+DQo+ID4gPiA+IE15IHRlYW0gYXQgTWljcm9zb2Z0LCB3aGljaCB3b3JrcyBvbiBMaW51eCwg
ZmlsZWQgYSBidWcgb24gdGhpcw0KPiA+ID4gPiBpc3N1ZSBhZ2FpbnN0IHRoZSBIeXBlci1WIHRl
YW0gYWJvdXQgYSB5ZWFyIGFnbywgcHJvYmFibHkgd2hlbiB0aGUgaXNzdWUNCj4gPiA+ID4gd2Fz
IHJhaXNlZCBkdXJpbmcgdGhlIHByZXZpb3VzIGF0dGVtcHQgdG8gaW1wbGVtZW50IHRoZSBmdW5j
dGlvbmFsaXR5DQo+ID4gPiA+IGluIExpbnV4LiAgSSd2ZSB0YWxrZWQgd2l0aCB0aGUgSHlwZXIt
ViBkZXYgbWFuYWdlciwgYW5kIHRoZXkgYWNrbm93bGVkZ2UNCj4gPiA+ID4gdGhhdCB0aGUgQUNQ
SSBlbnRyeSBIeXBlci1WIHByb3ZpZGVzIHRvIGd1ZXN0IFZNcyB2aW9sYXRlcyB0aGUgc3BlYy4g
IEJ1dA0KPiA+ID4gPiBjaGFuZ2luZyB0byBhbiBpZGVudGlmaWVyIHRoYXQgbWVldHMgdGhlIHNw
ZWMgaXMgcHJvYmxlbWF0aWMgYmVjYXVzZQ0KPiA+ID4gPiBvZiBiYWNrd2FyZHMgY29tcGF0aWJp
bGl0eSB3aXRoIFdpbmRvd3MgZ3Vlc3RzIG9uIEh5cGVyLVYgdGhhdA0KPiA+ID4gPiBjb25zdW1l
IHRoZSBjdXJyZW50IGlkZW50aWZpZXIuICBUaGVyZSdzIG5vIHByYWN0aWNhbCB3YXkgdG8gaGF2
ZSBIeXBlci1WDQo+ID4gPiA+IHByb3ZpZGUgYSBjb25mb3JtYW50IGlkZW50aWZpZXIgQU5EIGZp
eCBhbGwgdGhlIFdpbmRvd3MgZ3Vlc3RzIG91dCBpbg0KPiA+ID4gPiB0aGUgd2lsZCB0byBjb25z
dW1lIHRoZSBuZXcgaWRlbnRpZmllci4gICBBcyBhIHJlc3VsdCwgYXQgdGhpcyBwb2ludCBIeXBl
ci1WDQo+ID4gPiA+IGlzIG5vdCBwbGFubmluZyB0byBjaGFuZ2UgYW55dGhpbmcuDQo+ID4gPiA+
DQo+ID4gPiA+IEl0J3MgYSBsb3VzeSBzdGF0ZS1vZi1hZmZhaXJzLCBidXQgYXMgbWVudGlvbmVk
IHByZXZpb3VzbHkgaW4gdGhpcyB0aHJlYWQsDQo+ID4gPiA+IGl0IHNlZW1zIHRvIGJlIG9uZSB0
aGF0IHdlIHdpbGwgaGF2ZSB0byBsaXZlIHdpdGguDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gVGhh
bmtzIGZvciBjaGltaW5nIGluLg0KPiA+ID4NCj4gPiA+IFdoeSBub3QgZG8gc29tZXRoaW5nIGxp
a2UNCj4gPiA+DQo+ID4gPiBOYW1lIChfQ0lELCBQYWNrYWdlICgyKSB7ICJWTV9HRU5fQ09VTlRF
UiIsICJWTUdFTkNUUiIgfSApDQo+ID4gPg0KPiA+ID4gPw0KPiA+ID4NCj4gPiA+IFRoYXQgd2F5
LCBvbGRlciBjbGllbnRzIGNhbiBtYXRjaCBvbiB0aGUgZXhpc3RpbmcgX0NJRCBhbmQgbmV3IGNs
aWVudHMNCj4gPiA+IGNhbiBtYXRjaCBvbiB0aGUgc3BlYyBjb21wbGlhbnQgb25lLg0KPiA+DQo+
ID4gSSdsbCBydW4gdGhpcyBieSB0aGUgSHlwZXItViBndXlzLiAgSSBkb24ndCBoYXZlIHRoZSBB
Q1BJIGV4cGVydGlzZSB0byBkaXNhZ3JlZQ0KPiA+IHdpdGggdGhlbSB3aGVuIHRoZXkgc2F5IHRo
ZXkgY2FuJ3QgY2hhbmdlIGl0LiA6LSgNCj4gPg0KPiANCj4gWWVzLCBwbGVhc2UsIGV2ZW4gaWYg
aXQgbWFrZXMgbm8gZGlmZmVyZW5jZSBmb3IgdGhpcyBwYXJ0aWN1bGFyIHBhdGNoLg0KDQpUaGUg
SHlwZXItViBndXlzIHBhc3MgYWxvbmcgdGhlaXIgdGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24u
ICBUaGV5IGhhdmUNCmNyZWF0ZWQgYW4gaW50ZXJuYWwgYnVpbGQgd2l0aCB0aGUgY2hhbmdlIGFu
ZCB2ZXJpZmllZCB0aGF0IGl0IHByZXNlcnZlcw0KY29tcGF0aWJpbGl0eSB3aXRoIFdpbmRvd3Mg
Z3Vlc3RzLiAgSSd2ZSB0ZXN0ZWQgd2l0aCBMaW51eCBndWVzdHMgYW5kDQpKYXNvbidzIG5ldyBk
cml2ZXIgKG1vZGlmaWVkIHRvIGxvb2sgZm9yICJWTUdFTkNUUiIpLCBhbmQgaXQgYWxsIGxvb2tz
IGdvb2QuDQpJdCB3aWxsIHRha2UgYSBsaXR0bGUgd2hpbGUgdG8gd2VuZCBpdHMgd2F5IHRocm91
Z2ggdGhlIFdpbmRvd3MvSHlwZXItVg0KcmVsZWFzZSBzeXN0ZW0sIGJ1dCB0aGV5IGFyZSBwbGFu
bmluZyB0byB0YWtlIHRoZSBjaGFuZ2UuDQoNCk1pY2hhZWwNCg==
