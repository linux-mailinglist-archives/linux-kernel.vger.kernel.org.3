Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E864522E19
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243491AbiEKITC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243470AbiEKISy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:18:54 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2055.outbound.protection.outlook.com [40.107.113.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD3C134E53
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:18:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjiDxENKqUCpbzhczzohMug0THW+kkS/0S0yRzWxq/03pAqedHwHsPwOw2y0B7MyDIuIA9ewM3Oa7u31fsGZ48q9bhh0WAiNLGkY/BaG/AfBCmxBWfbsDU4GTwsgVonEvUwnwl/uofIkel+PbN3uRyexZ+Enb+7waxl8u3dVSIgrgFF+4Hivfx+0Ku9ECT2r4wrUTIQdylZNeNbWsPnn6qSn794NcEaBDUfhpJTW4DNNoEeDM01lcdc9Y8CO0nDLiKIPA5ZoK+rs/+M6mXjVmkuqngIsngExU0ETB0fwxRB9FAS5nJkeQ9CLFymRFh8k+c5hmRAJR1KXTjm2DSgEFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsVpzqUjiJ8kOhuz9ZVH0kOMnufMkOqG4EuXMQ26O10=;
 b=iGE7azCW7kMsN+9GavqUuAKzHcyUUplrf5y+b1iM50zrrYtgqkD7WS5NObWcgoObL/anv2oIDWJ92No8nCk/9SD/4cUH38CVnO6Aucj5Sh2RqgeABMv1kEeN5hPvCnteXCmOc674Rkwq+jqiXW3bzX/ntE3uy+vqnEyL/9CnDAS+f9xNWFsNW+jYP7sLK/UdUmOrSCESWWyI2N/CV9FeJtgctyyMdAwQl1kfpG64Va//3TORfiPKm1UIvJ/oQc/Qn4Y7V4nUNKnf0xB8Z92yjbOrCkYKZ0rhKwV+9IQWxZGL/BaJfFOBPSI/VZp4asdSMD5rINwC8hrosqpUORxqlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsVpzqUjiJ8kOhuz9ZVH0kOMnufMkOqG4EuXMQ26O10=;
 b=DMT3vwdR4EVRPghATqpPoWs4qTk9R5D3f/oyYVslUb2lnxq6+WqpgS0Dg6R8IUg5g2llxfIOA+acdQcGtXCC8H+wYfO8OXbKExWghc+UlvA7qjsayyGwgi/ub8Ry7m32DX83G1oMC4uv7iXUrVeF+P1vtwVcEvqQ1Trqn2a6K5E=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYWPR01MB9772.jpnprd01.prod.outlook.com (2603:1096:400:224::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 08:18:52 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d51:985:b999:96b8%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 08:18:52 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] mm/hwpoison: disable hwpoison filter during
 removing
Thread-Topic: [PATCH v2 4/5] mm/hwpoison: disable hwpoison filter during
 removing
Thread-Index: AQHYY5Qdnd4EqpjsAEqlw9G44Sh1za0ZWFWA
Date:   Wed, 11 May 2022 08:18:52 +0000
Message-ID: <20220511081851.GB211620@hori.linux.bs1.fc.nec.co.jp>
References: <20220509105641.491313-1-pizhenwei@bytedance.com>
 <20220509105641.491313-5-pizhenwei@bytedance.com>
In-Reply-To: <20220509105641.491313-5-pizhenwei@bytedance.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85e5e258-5931-4274-3696-08da3326e210
x-ms-traffictypediagnostic: TYWPR01MB9772:EE_
x-microsoft-antispam-prvs: <TYWPR01MB97726003467BB9F9DE1B5985E7C89@TYWPR01MB9772.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gzs2auyVvYbOkEtW+FEbeZiJ7hyQl0ZiH2MbPwFPff+NM3LRnWnr22kbKb0FqeX6rnVy1nA46iKqbwDfsPDEJseAf/KVUR5aRVLSnZymfuEsti6SO+e8Ksn8BfWhdcdd/TvDHyR/nwYBLaB4SWQ/kPmZ30k5QhmFLUWU1msyiKdLUD/jpyKVXjk/Za6Mp9j43u7d4fscM4D2YoFTmFAHKiOSVzBiHBtSHv6o0pU4a6hSlz1mq+TKbwaY5L1hx536Irm7xsZ4jlC85QA7xa0GqX+v2AcYpP5v1EzaWEX7H4yRYp0Q5YBU2epBgfQsaDcvI5V9GYs71PGYuM7oTgpIMXws3veeIcDc7+6cFwKXD6zjp5Xwg5PYAzQrKXTtnU3eEMWQ5Rq9yT8NVWsNdStJr6hqFmRcD5bvcD55F3WqhzZmPif6UfudwHNKDvslgkmt7MTpKpz+gMk9/cf9ItB7zzTO1DeWgjeRoWcIzpgjfOwmESKAlWdStUiL5PC6648RAOb7+374prnpstS2kU6yaUjuvhXmZuahOyjmkcg2IByp9GfmBfwH9JIC1XSXuxRxWXHNeuA/2q+FBhD2Xuf9j5XKNnRZlqc4TXCwZcPeDXZwGnSQCNtcOUeyYLiNCX6wbL8PNp+TrOo9O2fK9oEL/rgAEY8yXQmVUTrOlVl91drR6S+aHHwvK6pyEIm5w6Clt7zEamSrUBmtLnBMmsO8ZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(4326008)(5660300002)(64756008)(4744005)(6506007)(76116006)(8936002)(26005)(6512007)(66946007)(9686003)(66476007)(55236004)(66446008)(66556008)(82960400001)(122000001)(508600001)(38100700002)(38070700005)(8676002)(71200400001)(54906003)(86362001)(1076003)(6916009)(316002)(186003)(2906002)(85182001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0dzSXZCOUhlZzJqTnlwY1liT3EyZnNaT2dTblZUTnFyaUYyVFlCM0M2TGhq?=
 =?utf-8?B?eExWdWdUeUZSdXBCUEFqTThNb1dET0pzd0NWZFRobzhtcHIwdURtdlczZ3F5?=
 =?utf-8?B?bXRNRHlmWVIrNDg5SlZ2bjNtekkybit0NXl6TmttU2xLaU4wRXJqb280Qi96?=
 =?utf-8?B?UDJ3a3YzWnFSTmN3Z3JUZ2FTUVdxUXJTK0RqNjJlZU01eGVDL2ZJb1d2M3hS?=
 =?utf-8?B?V0dkZXNPRXZ2MDdEYWZyUjEwUGcxQWsrMkJCY1JEZi80MWs1anoyZVByaHdY?=
 =?utf-8?B?R005VTJzOFF4eVk0b3FIeWFXQ01ONnV6ajh4enpJTDZPVXN4ZUh1WkgwVEhU?=
 =?utf-8?B?UDVxWHJCK0dJem9zc09NdXQxZlJmZG9nbDJGeUxFVlVhODRNM2tNZXRSL0l5?=
 =?utf-8?B?bmxkZlMvTitTZWlSRTJFcXdEUzJDYTN6NkxPQnNpZ1pmS3pJcVRVblBjVkdW?=
 =?utf-8?B?cmhyODA5bDF3QStUdE5NeEJNdFJjMldHazdrSnp1Q2N6MzlpQlEwaEZuZU45?=
 =?utf-8?B?VzBSRW9ERFNLbXBSMFJCaFBndU4xQ0wyQWJLa2NnTTF3TFdDTzJRNXBQeXdp?=
 =?utf-8?B?UjdXRTBYRXVoRFlwQ01OR05uQitvaGMxOHFhMkd3QWZNS3RER2h0cSsxUG8x?=
 =?utf-8?B?VDlYOUpKWXdnajY5Ui9qUTR2d0RzWjMwSFlka25SU21PSFlDaGdkaXh3eE0v?=
 =?utf-8?B?M0RuYlVXbENlVkpMaUpQNnVLWW9iTTYvQjFoVndtKzN2YzczY2sxb1BTblR6?=
 =?utf-8?B?VTR3RXF1V3dZWVBBSG5yNGozQi9Pdk5YUWJVTUMvc2MvZmN4L0g2LzJFZFlo?=
 =?utf-8?B?TDRVeVNKYzRxSTBqaU8zNlNoU2VJelcycXBOanFWQzI5T011WEdYN0hWSTJG?=
 =?utf-8?B?Q1JpVU1kNFcwWFpIZkY0czhmZHJVMURaWGZiSStmWlFwZzZuOTdLczluUXlv?=
 =?utf-8?B?dTZGb0NUb3YrUFF5WlRTQU1iMTJpWUY5M2I2Q294RERKbFhHQ2F0OVIrZ3Ax?=
 =?utf-8?B?Z3NGMS9jUHhZSnd4K2lhR3Q4MnNlbzBzeXB5VjBvMFhpSXFyUG1TZEQrWUlO?=
 =?utf-8?B?R2NZbHI1VEw2UFUvNWJJU3p3K2xRWWlQMHFIOFhMSDBUSE9tR1Jjc1VYcWFL?=
 =?utf-8?B?dkVBSGdhOUdDWkR1cmMyL1RSaFVWQ0J1d0FlSUtpMXV1MzRsSW9SQkJMUUs2?=
 =?utf-8?B?UWdscUE5UXdtQktKWXlNOUZnTm8wODlkUG9PdjhPRFNiK3NTTFBCTTkvUDJo?=
 =?utf-8?B?U2xnYXdGcmJGVUp2S1UvbFJ4U2hteEdpSnlXTmtBYWo4WTJsQk52SlNMOHNE?=
 =?utf-8?B?Qzk3ODREbmpWYmdOM01xQkEwNlBVZ1NyOVo5bGVjWVlYWkprbGlWQUNqRHpO?=
 =?utf-8?B?MGdrUjh5Q2F5cDlpRzdXbHlRdElDOFZPNEFXRnFlZEx5ais0TkRsK2Z1bkQ5?=
 =?utf-8?B?N2lydkVCcHA3V0JNUGZNMFlMVi9YZHZJQzlzMDFsUXc4eGJjUHN6akF5UUVJ?=
 =?utf-8?B?VXZ4YnV4SUJ4ODZ0c0k2Q0NMOThpeXp3djBPcC9zaHBUWG5KM2sxOEN1dUJK?=
 =?utf-8?B?Z3E4VWw4c2ZKbGJ4Vno4VmxRcGpFR0lGdW83L2NXOURkWVdTZGF5R1BrRVky?=
 =?utf-8?B?WmhmSUIrUVQvallWMFFNMTNQOGZjZjJCWmFUTWxJcWgrWGU1REpZM2liK250?=
 =?utf-8?B?OEpVTU9KYklHNW96MVlCcmtKekVMQ0NEN3BRZlFiMHhFYmxKVExyWW12RzZn?=
 =?utf-8?B?SjBVMWc5ejBHTE5Lc3Q4cWtMQTZMUVFaUnUvaXZFZnpZcS85Y3djT0tlNWpR?=
 =?utf-8?B?Z2Y1YWc2emJTQkhxRnU4eTQwMzdmdmM4dEQyTXlQRlRDZS9hOGNaSTRMVTh0?=
 =?utf-8?B?Rkh5V3YrMTBybTc4YXRBU3V4QmwzSEtQUnd5c3dhVWdBeGxCQ1orK3ZPTTR3?=
 =?utf-8?B?R3ltQUd1YXdWQ3Nuc0RHUVNqQjZRV215SW56MzVWU3VVeFAwcFZNTGZDRHRh?=
 =?utf-8?B?OXhQRVpCUVJDM2VMZnJBZ1Q5UFk5MndtZTYxTEZXakpKNVRKRWJENkE2RU1s?=
 =?utf-8?B?MnpJaDBOU3dzMmlBcGlnRnJvYll5SjRNODdkOTBTenUvUWRMVlo1T09zSFZR?=
 =?utf-8?B?c00yeTBjck1zdlhMeVgvbXVQOWdmSWMrVWpUMkxFcW82VzNBTTZBbHh4ck5E?=
 =?utf-8?B?UXFCOG5CRFRlM2hYMGVudEFkTGhhRVRYc2JweWwvZmFNWEpSRWVqY2RzblhU?=
 =?utf-8?B?VDZwRzM2bDBkc3plZUNhWEZhU2xLY1huMnBXSU9majlGRE93ZU1saWJGSVln?=
 =?utf-8?B?TDI1V29VMnpCMzc5bHo4RzFDQkg2M1pmKzNpdXRjWk5IUjU4bXNyek5XWVZZ?=
 =?utf-8?Q?dAxO9vKulII+MREA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7BAF15723E33A4F932FF2594434F3B3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e5e258-5931-4274-3696-08da3326e210
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 08:18:52.0677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 56k+o4C2WbPMqdqZbIwdn6JGMrkSnBO9dM/7tQ/E/sLMkXodg7sA6oWRKyQD6xSXJ+T1h1Un6Tc98vKt5o1V2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9772
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXkgMDksIDIwMjIgYXQgMDY6NTY6NDBQTSArMDgwMCwgemhlbndlaSBwaSB3cm90
ZToNCj4gaHdwb2lzb24gZmlsdGVyIGlzIGVuYWJsZWQgYnkgaHdwb2lzb24taW5qZWN0IG1vZHVs
ZSwgYWZ0ZXIgcmVtb3ZpbmcNCj4gdGhpcyBtb2R1bGUsIGh3cG9pc29uIGZpbHRlciBzdGlsbCB3
b3Jrcy4gV2hhdCBpcyB3b3JzZSwgdXNlciBjYW4gbm90DQo+IGZpbmQgdGhlIGRlYnVnZnMgZW50
cmllcyB0byBrbm93IHRoaXMuDQo+IA0KPiBEaXNhYmxlIHRoZSBod3BvaXNvbiBmaWx0ZXIgZHVy
aW5nIHJlbW92aW5nIGh3cG9pc29uLWluamVjdCBtb2R1bGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiB6aGVud2VpIHBpIDxwaXpoZW53ZWlAYnl0ZWRhbmNlLmNvbT4NCg0KQWNrZWQtYnk6IE5hb3lh
IEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+
