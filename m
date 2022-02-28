Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770184C7D82
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiB1WjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiB1WjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:39:09 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2111.outbound.protection.outlook.com [40.107.100.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550E148331;
        Mon, 28 Feb 2022 14:38:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJIUroA4zzzDjEtTcWGNjankQ6pPKu8CzlEHz1YDMp6HUMKIZ4e405Tx8Nfl51UTzm3k7MBkc6A5EliQbEFNv2LUGN7XEp5QAlyP4rWurjJ3xsNsDHlLhQ7C0WysySRFKG97XL4Fvbo0QxgD0/u4yU4KtRZ44IhRFfapD1kVAVA7QCnMupMCxW4/oDJGPiYudvwXMDVCXoKxtMB/9IFF9uwRfwDJnHFPvjoWIA6LR3FkQSHb52aEY34iO4uEm4ZAtAaLZ9kPf8LqAt7jTcfYmf+tn/4dEt175LH9q+yEf75W7C29h642rE6QGK7ABkHYEtT5B4+mAjJBaMVkdwhI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGqAko0aBfrQuoZDK0kyEXh5zWforLHeVHSKrLZe2qU=;
 b=lZfFA7uymMxC13cy5saDS6YMaOr6S9GNpD4eA0NDB3ReHUGOK/TZDoavZMd24yXHJg4ngoGyxsYduOIjk2yGxajzKzeU7Clgi2w5NgWEQPrDLnwdok8531pUfORiGBwactBdmfkawW66JQyLhQ/b4L5tJ7Deat/MFccPM0C4H6qSzmhiW2QcApida4I2cAgS7rAPhsIGKphrVvuZPvrIupYDskH5DnwACilWsv8/QP+YahkMO7e7b86sv3RrHTwShtlbjHOX59XSdZRzp5GrQQ5XFWbOvH2jqkP7SYaa5zotPipm4WKhH6Uk076toMpL7bx9RTY7eCZTTycwI4TBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGqAko0aBfrQuoZDK0kyEXh5zWforLHeVHSKrLZe2qU=;
 b=NEaet+TkUYKGStAcraoLnUonHjo1S+mGJTaPnk89nwS6LVHChyekH8dH8cjuGstWLFlbm+0gNIGssnpAbtV69frQnVmbxwSP+IbMB45zQLHVIoAWyP169jvu+g/cv1EH9/RCDJmCjTanTuebufLNy/SthfMEzRkPL5aDP5mnzQI=
Received: from MN0PR21MB3098.namprd21.prod.outlook.com (2603:10b6:208:376::14)
 by DM5PR21MB1749.namprd21.prod.outlook.com (2603:10b6:4:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.11; Mon, 28 Feb
 2022 22:38:25 +0000
Received: from MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::69f8:51be:b573:e70c]) by MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::69f8:51be:b573:e70c%5]) with mapi id 15.20.5038.006; Mon, 28 Feb 2022
 22:38:24 +0000
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
Thread-Index: AQHYLNK4fL59pmJF2Ea4CQMRQ5s3a6ypbsWAgAAEo4CAAAbTAIAAB7CAgAACs/CAAATqAIAAA+TA
Date:   Mon, 28 Feb 2022 22:38:24 +0000
Message-ID: <MN0PR21MB3098EC13B4E8488E692DB28AD7019@MN0PR21MB3098.namprd21.prod.outlook.com>
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com>
 <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
 <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
 <Yh0+LA8B1jw8tnl9@smile.fi.intel.com>
 <CAHmME9qW4EiYU6_kTffMdK5ijJY1DF6YRt=gDjj1vKqDxB0Raw@mail.gmail.com>
 <MN0PR21MB3098981B77F513976A62CA57D7019@MN0PR21MB3098.namprd21.prod.outlook.com>
 <CAMj1kXFZZoOeXnjxdU+gOJTN=Szn=eiXgRhSS9_nnHgwADNHjA@mail.gmail.com>
In-Reply-To: <CAMj1kXFZZoOeXnjxdU+gOJTN=Szn=eiXgRhSS9_nnHgwADNHjA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8f73bc16-348a-45c8-a5fa-a68265f48259;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-28T22:35:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2acd1600-fa02-4a51-d3b8-08d9fb0b0828
x-ms-traffictypediagnostic: DM5PR21MB1749:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM5PR21MB1749FC8582377BE2EE8F7869D7019@DM5PR21MB1749.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z93GcgoxOJhQpOlC91Qrgcb9JNuYGiySJu2XuVaqWWeZfRqpt7AWLPyr1gPCqdg51+5eD/57SNr2/+CGODIhNYILsa+472QSST93V5RTKzjgO0ciQXzHnHSwiDXFx2ZLUYCTH+9z2gpiJdwEpe3euh694xBrB2haPgFKsw5HdODet1rN3pvhS5ojWXuWuPsYMG1pR05oc1wlFEpVHyk72ktFIZRR1o1nk2R0SqNSG2Rma5CVf7An19p8/6zPJkMcTbi6Zf1OOVbYUJOOzarWWmHtlQOkzGLNusqS7eF4VmzMNikBXDjwTmNiOyu1ayi6NLF0CLP8OrnBXH4ru2H/ze9THm5XuQpct/7T9GmlWQFNinGhxjEwG8ujaSwFKRmbmo/JK03gQQx7NDOFeMWIhj0tFMg8gKKjYtxrtKUQZwAx2MvZznGLETYzkI7rZoDfhJyJCgLV3ni3HpjpNFGQOHcFafuzkli+Gmzezo9H82RrFXxHoJRpiD4Z4OspYc64AXx5S21r4v0jFBEc/lnv0QcLA06LtMJEZyxDtrfOcMJvdS5Y/q2cyoNRGLckYW/Xk58TIf+NU4aLIs+VnHBv5AXMko2/u2Uoii1n1pqMP/3pqsfs5ekdTMb5UL++/GuOFxY6TWTluJ1M/lHi8EHuyND+JCT3ObzJmx9BB23ZCZyC3HqZKxJs2c615NF+vY8MUJaV9bUjG0eDiYgh0FdtUI+REjdwPpzgt+Pi0scNN+em751kOor036KgoIAZIHtA3iX2tcArf1jlscyA8qhiItatkkbTQh18EVKu0o/yfiw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3098.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(4326008)(52536014)(5660300002)(54906003)(122000001)(66946007)(8676002)(38100700002)(7416002)(86362001)(64756008)(66476007)(66446008)(38070700005)(76116006)(316002)(6916009)(53546011)(82950400001)(66556008)(82960400001)(2906002)(508600001)(33656002)(10290500003)(8990500004)(9686003)(186003)(7696005)(26005)(71200400001)(55016003)(6506007)(148743002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHc4a3Jyd0RQOS95Ymxac3BBRjBxOFNrdUFGL0dXR292YlBwRkpLOHZoekRJ?=
 =?utf-8?B?V3hlalZFaWdRSVlET2xDcUJLUmFCd3VudURPZFBqdHVLekpsRVlqU2M2Z2cw?=
 =?utf-8?B?Z3lPditJSWhpNUJHbTdvZXg1SCtrL1VOMnVEWnZlc1cyRDJIdGRlOWdVcEN6?=
 =?utf-8?B?RzZhSzErRlhSbDRoS3lZL0hKb21ISUkyVm85d3FWWm0xVktaSkhGK3V6emlr?=
 =?utf-8?B?Q1FsM2NWMWtQS0lDay9raG9MOFkzQ3JGVExqQytYS21nYUxEMWF5akFhVk5R?=
 =?utf-8?B?LzB3SU5zSit6VlpIQzMxZ2tIb3JmdDNROUNHNzlTVm1mOXg2b2tIRHZvb0pP?=
 =?utf-8?B?c3IzbHRhVlkxTmQyOGZmWHJUcjYvTVdIYUVSY2dUYTZtZEU4ZUpZclhpREgy?=
 =?utf-8?B?Z0RLcDBtYW4vRkNnS2NzbGp3cmU1aXo1SjZKYm93Q204Vy9MUGliN1V3ZGNo?=
 =?utf-8?B?bjJvV1pqYm90TEpjS0tCbk5yOHFRVzZCYnRnWjg4NzBLenNEWFh5a3hLWXZS?=
 =?utf-8?B?UWpoM3oxTmFpazRGMlo0SHB4N2MxdFhiMWQ1UzlIT2xkRHVVM2Y4QTdnR1Mv?=
 =?utf-8?B?SE5zOTJEVk9nWnVtaXZuT0Q0ZFpmUEFOSjZTZ0E3S2U4VW1RUGJmSzNDVlhN?=
 =?utf-8?B?TGFUT0NwamRxTTJOTEFpSkkvekdoTWhVd0VzT0cvNzJTL09EdGxOSCtPdUNX?=
 =?utf-8?B?eEVsNXpwWURuRktZblBZanRiTVkwcDRDUGhLck5nQW9BSUVQNjdHVkNOYVM1?=
 =?utf-8?B?aUJBSDh4VmxCbHNxUitQMWFIRDBGZDFDS1JlZWd5WTRnb0xDUXhlZTltb1E1?=
 =?utf-8?B?bjRhY3pBWlZ2NWdBWDUxWlAwaUZ1NW44dUVsYzA4V2U3czZ6VTZ0bmxXQzho?=
 =?utf-8?B?eDJ5aHYzbmt5NUtHRVh1LzdKcXRoV2R0THpOMXIwSEpiRnZHVlIzajhRVTJ5?=
 =?utf-8?B?NlgvRjg2SHRGVTU2TldpOWlsTkxBUUF6b3ZJRGowSEF6Znp1TjBjNHc5NlZB?=
 =?utf-8?B?Lzd6akh1OVE0WXVhS0VFUlJONkZHTnIrMkkwajI3RUkrZWVndmo1K3orWGNh?=
 =?utf-8?B?Y2c0TTZ3TnVZV3l3cTFHSG1zZ2FRSmM5SUd4TlErM0hPaCs3aXlRK3ZZZThG?=
 =?utf-8?B?ZThTTXJGeWs4bHB1c2xRZmNzSm1mbHJad1ZCaG1ZcHFZMEJWcWxYREducUFo?=
 =?utf-8?B?UTlrdjRxR1RaQ1RJNnY5TWdROG9xRGthMXVIQkUxVGJCT0pjcFlFSVd0RXdl?=
 =?utf-8?B?dHFGNnJEeEVwVXdpbkc4eWFaT013YzEvNjdFZkxvTTArRjMrZzVZLzYvL00x?=
 =?utf-8?B?UVQ0M1dTUmtQbmptS25INzBsWVhlQVhCRlhodDFUclNwRDZ2cHRkRCt0MUJI?=
 =?utf-8?B?SEppeTFXSXJpN3pYZDI0YjRYaDVrendXZkNhcTFUV3p1NTFJWXIzUmhJYXdZ?=
 =?utf-8?B?b2k1d25HVzdOcXczcE51bzJTVzdMM2pIMFVRNURWdlMvd1crRFhxaEx4cDdo?=
 =?utf-8?B?em9CNGVZT1NJYy95b1MweTR3c09WdEsvSFYvclI3TkdjNDh5dTUwbVlFS0JJ?=
 =?utf-8?B?SnFQdkExMjZrWTlnQXJwZTdEdndGT2k1NVo0QmhwdThPTUl2WGZISVdWR2sx?=
 =?utf-8?B?KzJycGhwd0xhRjRNazVXRHI4UTNRQ1d2b0NCQllqZzBwSzd0T2txNktJdEti?=
 =?utf-8?B?Ujh6Z0dZdElBQy9FVjNLNWMxZXFtMjZOM050d3ZiUG0xbytFaEVSY2k5QWdP?=
 =?utf-8?B?Z3VCaUVYcE9rdDlickZtT0ZrN2pJUTk3Mm5rQjg4VWZndzRHcVdtN0lTemM2?=
 =?utf-8?B?QUM3eHBYSWtHTkIwQ3ZjQjFLMHRvU0RvWXBPNkVWZjR0cUZJaGhvVktYMFR6?=
 =?utf-8?B?eU02V0l3VGYvV2RwbHhMU2U0MzlSRVRodXEzU1kxTGRWM1pQREd4ZDJXSHZt?=
 =?utf-8?B?MUNMV2pXN2o0eVdnUWpQcTVEczRyejZsRzRZQlVuQXhkM1l5R00ranRYcG5O?=
 =?utf-8?B?ZlNpMklMTEJJWE5qV3JKQVhvUWwveHlaenF6R0VBTDk4bG5wRFUybmtFbDV1?=
 =?utf-8?B?TUdvcUNCWDRidkdkWi9MRDhoOGI5bFBmOVFYUTN1QjlqL0VCVlhZU2EwaDhH?=
 =?utf-8?B?N1JndS9ldFpJVzhvUzBWaUhTcXJ1WTlNQ21UUUd4ZzVSODFQVVoweXlyRjlZ?=
 =?utf-8?B?VktFRVIyRFA4QURqTlVTUEhuRWNXeEdtRDdRdlh3L2dJNVZldTBTSjVXdklV?=
 =?utf-8?B?cDlGUG5PeEpHVmFHZkdyUUdrK0RnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3098.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acd1600-fa02-4a51-d3b8-08d9fb0b0828
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 22:38:24.8941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bw4af1bYTNf/+JHex61opr0WWjbBa5/HB2G9C29H/h9Ya/rFD/TXSinYS5c1xGU2WsxPCnvm3TpW31KsnoAFMPUhooCVTLxyH2Ppw+uldag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1749
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4gU2VudDogTW9uZGF5LCBGZWJy
dWFyeSAyOCwgMjAyMiAyOjIyIFBNDQo+IA0KPiBPbiBNb24sIDI4IEZlYiAyMDIyIGF0IDIzOjE0
LCBNaWNoYWVsIEtlbGxleSAoTElOVVgpDQo+IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPiB3cm90
ZToNCj4gPg0KPiA+IEZyb206IEphc29uIEEuIERvbmVuZmVsZCA8SmFzb25AengyYzQuY29tPiBT
ZW50OiBNb25kYXksIEZlYnJ1YXJ5IDI4LCAyMDIyDQo+IDE6NTUgUE0NCj4gPiA+DQo+ID4gPiBI
aSBBbmR5LA0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgRmViIDI4LCAyMDIyIGF0IDEwOjI4IFBNIEFu
ZHkgU2hldmNoZW5rbw0KPiA+ID4gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+IHdyb3RlOg0K
PiA+ID4gPiBNeSBwb2ludCBpcyB0aGF0IHRoaXMgaXMgY2xlYXIgYWJ1c2Ugb2YgdGhlIHNwZWMg
YW5kOg0KPiA+ID4gPiAxKSB3ZSBoYXZlIHRvIGVuYWJsZSB0aGUgYnJva2VuLCBiZWNhdXNlIGl0
IGlzIGFscmVhZHkgaW4gdGhlIHdpbGQgd2l0aA0KPiA+ID4gPiAgICB0aGUgY29tbWVudCB0aGF0
IHRoaXMgaXMgYW4gaXNzdWUNCj4gPiA+ID4NCj4gPiA+ID4gQU5EDQo+ID4gPiA+DQo+ID4gPiA+
IDIpIGlzc3VlIGFuIEVDUiAvIHdvcmsgd2l0aCBNUyB0byBtYWtlIHN1cmUgdGhleSB1bmRlcnN0
YW5kIHRoZSBwcm9ibGVtLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIGNhbiBiZSBkb25lIGluIHBh
cmFsbGVsLiBXaGF0IEkgbWVhbnQgYXMgYSBwcmVyZXF1aXNpdGUgaXMgdG8gc3RhcnQgZG9pbmcN
Cj4gPiA+ID4gMikgd2hpbGUgd2UgaGF2ZSAxKSBvbiB0YWJsZS4NCj4gPiA+DQo+ID4gPiBPaCwg
b2theSwgdGhhdCBtYWtlcyBzZW5zZS4gSWYgeW91IHdhbnQgdG8gZ2V0ICgyKSBnb2luZywgYnkg
YWxsIG1lYW5zDQo+ID4gPiBnbyBmb3IgaXQuIEkgaGF2ZSBubyBpZGVhIGhvdyB0byBkbyB0aGlz
IG15c2VsZjsgQXJkIHNhaWQgc29tZXRoaW5nDQo+ID4gPiBhYm91dCBqb2luaW5nIHRoZSBVRUZJ
IGZvcnVtIGFzIGFuIGluZGl2aWR1YWwgc29tZXRoaW5nIG9yIGFub3RoZXIgYnV0DQo+ID4gPiBJ
IGRvbid0IHRoaW5rIEknbSB0aGUgbWFuIGZvciB0aGUgam9iIHRoZXJlLiBJcyB0aGlzIHNvbWV0
aGluZyB0aGF0DQo+ID4gPiBJbnRlbCBjYW4gZG8gd2l0aCB0aGVpciBleGlzdGluZyBtZW1iZXJz
aGlwIChpcyB0aGF0IHRoZSByaWdodCB0ZXJtPykNCj4gPiA+IGF0IHRoZSBVRUZJIGZvcnVtPyBP
ciBtYXliZSBhIE1pY3Jvc29mdCBlbmdpbmVlciBvbiB0aGUgbGlzdD8NCj4gPg0KPiA+IE15IHRl
YW0gYXQgTWljcm9zb2Z0LCB3aGljaCB3b3JrcyBvbiBMaW51eCwgZmlsZWQgYSBidWcgb24gdGhp
cw0KPiA+IGlzc3VlIGFnYWluc3QgdGhlIEh5cGVyLVYgdGVhbSBhYm91dCBhIHllYXIgYWdvLCBw
cm9iYWJseSB3aGVuIHRoZSBpc3N1ZQ0KPiA+IHdhcyByYWlzZWQgZHVyaW5nIHRoZSBwcmV2aW91
cyBhdHRlbXB0IHRvIGltcGxlbWVudCB0aGUgZnVuY3Rpb25hbGl0eQ0KPiA+IGluIExpbnV4LiAg
SSd2ZSB0YWxrZWQgd2l0aCB0aGUgSHlwZXItViBkZXYgbWFuYWdlciwgYW5kIHRoZXkgYWNrbm93
bGVkZ2UNCj4gPiB0aGF0IHRoZSBBQ1BJIGVudHJ5IEh5cGVyLVYgcHJvdmlkZXMgdG8gZ3Vlc3Qg
Vk1zIHZpb2xhdGVzIHRoZSBzcGVjLiAgQnV0DQo+ID4gY2hhbmdpbmcgdG8gYW4gaWRlbnRpZmll
ciB0aGF0IG1lZXRzIHRoZSBzcGVjIGlzIHByb2JsZW1hdGljIGJlY2F1c2UNCj4gPiBvZiBiYWNr
d2FyZHMgY29tcGF0aWJpbGl0eSB3aXRoIFdpbmRvd3MgZ3Vlc3RzIG9uIEh5cGVyLVYgdGhhdA0K
PiA+IGNvbnN1bWUgdGhlIGN1cnJlbnQgaWRlbnRpZmllci4gIFRoZXJlJ3Mgbm8gcHJhY3RpY2Fs
IHdheSB0byBoYXZlIEh5cGVyLVYNCj4gPiBwcm92aWRlIGEgY29uZm9ybWFudCBpZGVudGlmaWVy
IEFORCBmaXggYWxsIHRoZSBXaW5kb3dzIGd1ZXN0cyBvdXQgaW4NCj4gPiB0aGUgd2lsZCB0byBj
b25zdW1lIHRoZSBuZXcgaWRlbnRpZmllci4gICBBcyBhIHJlc3VsdCwgYXQgdGhpcyBwb2ludCBI
eXBlci1WDQo+ID4gaXMgbm90IHBsYW5uaW5nIHRvIGNoYW5nZSBhbnl0aGluZy4NCj4gPg0KPiA+
IEl0J3MgYSBsb3VzeSBzdGF0ZS1vZi1hZmZhaXJzLCBidXQgYXMgbWVudGlvbmVkIHByZXZpb3Vz
bHkgaW4gdGhpcyB0aHJlYWQsDQo+ID4gaXQgc2VlbXMgdG8gYmUgb25lIHRoYXQgd2Ugd2lsbCBo
YXZlIHRvIGxpdmUgd2l0aC4NCj4gPg0KPiANCj4gVGhhbmtzIGZvciBjaGltaW5nIGluLg0KPiAN
Cj4gV2h5IG5vdCBkbyBzb21ldGhpbmcgbGlrZQ0KPiANCj4gTmFtZSAoX0NJRCwgUGFja2FnZSAo
MikgeyAiVk1fR0VOX0NPVU5URVIiLCAiVk1HRU5DVFIiIH0gKQ0KPiANCj4gPw0KPiANCj4gVGhh
dCB3YXksIG9sZGVyIGNsaWVudHMgY2FuIG1hdGNoIG9uIHRoZSBleGlzdGluZyBfQ0lEIGFuZCBu
ZXcgY2xpZW50cw0KPiBjYW4gbWF0Y2ggb24gdGhlIHNwZWMgY29tcGxpYW50IG9uZS4NCg0KSSds
bCBydW4gdGhpcyBieSB0aGUgSHlwZXItViBndXlzLiAgSSBkb24ndCBoYXZlIHRoZSBBQ1BJIGV4
cGVydGlzZSB0byBkaXNhZ3JlZQ0Kd2l0aCB0aGVtIHdoZW4gdGhleSBzYXkgdGhleSBjYW4ndCBj
aGFuZ2UgaXQuIDotKA0KDQpNaWNoYWVsDQoNCg0K
