Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03CE4D5D22
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbiCKITn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiCKITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:19:42 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2099.outbound.protection.outlook.com [40.107.215.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13011AF8C0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:18:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjU0AsZAkZY8covYWPUH0OJZb64rDnB2oHljwaqlzSgWvKjFTb9Kz7BLr1DjXMtXOBU9I6/IcKHpQoJdEHZvtlVbXjVt5y2PpPIkkAN8ONw0fV2j0M3jkzqnDMD3dMtPCgc7dqpTCHNZ8T8xEKG4PQH7rxjie6M/ufLDyocp6w3yhWZo9PQ+3xoUElw4o2xOxxCaBZ+qC/Crk3OxR16hxcpjq0cBoTHEE9JPryOIBq8QuqanNBvlxNwTRE+ydBHzWBSm/Dzmt4S1B0Fe2h8ARV2XMNinG2gLiup3ctnW1Z/IN94DG0uMno3iIy9ckADMIISUpAaghh8eXhFO0WGGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=po1t0nEmkT41l4GKexgqxqac/vqXTXqaRux0jgnet5A=;
 b=YWMHhL2TPubXRhqNTu5LGbRDEzvLz4S/sHhMtxMzKEZ1X+nGtkzpXQQZTm9SbxG23YqF5paKvcRVFhFRT2nCuwgnt74eCFtRh3qCGPps05VZE5r6ugvVcrhmbzOxgsCC1lHDULZPSVHlEbq6kfav45TCeF6KQ1RBw9334D+iTHMA/VBqOtCIZiO+KdUt/mGeYpOyCyREphjoIS65RKRw/tu4iRJF84s0t9kZtMJl/yIbqkTE66Fig9bqFgX3bQq/W3v1UbetzSTnJzF/taSB9sQcLVTY4v1nGXOPSnsjZkGd+2O/wNBGXujaS9iS9uAISqq39Z6iomrfeLutqF+7tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po1t0nEmkT41l4GKexgqxqac/vqXTXqaRux0jgnet5A=;
 b=gnzRhcfbMBk0xvyORA0+DdszUTded0305BUb7OL7ayMmDFxoBe97KWgDCiKUnowVwqjQ2QFDced0K2kPChKmoDBWUMHzruKXVGQpXjyeYRPnOju8xsPZsm/ZiYKfLy/xDuzPsryd/HkoGkX0v9vR9m9MGX4NoqwkQpvFFYmRgEo=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS1PR06MB2837.apcprd06.prod.outlook.com (2603:1096:803:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 08:18:35 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 08:18:35 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sched: topology: make cache topology separate from cpu
 topology
Thread-Topic: [PATCH] sched: topology: make cache topology separate from cpu
 topology
Thread-Index: AQHYNH6wtHW6B7ixb027761a5egjaKy4qoqAgACydgyAAHYBAIAAAhW+
Date:   Fri, 11 Mar 2022 08:18:34 +0000
Message-ID: <SL2PR06MB30826C314139509EC4778C1BBD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
 <CAKfTPtAvbpUUaOqP3gmOT7fLk8-7v70LzBUiQ-vgDvc7ZZujag@mail.gmail.com>
 <SL2PR06MB30828CF9FF2879AFC9DC53D2BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtBM9WBEgP_PpRHNaATvp9FrBeV2NXhg_EAp4xYtBZYCWQ@mail.gmail.com>
In-Reply-To: <CAKfTPtBM9WBEgP_PpRHNaATvp9FrBeV2NXhg_EAp4xYtBZYCWQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 74faff43-d4c6-2812-387d-04c1cbdb4365
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae87ab24-02ff-4d48-55c4-08da0337bcd7
x-ms-traffictypediagnostic: PS1PR06MB2837:EE_
x-microsoft-antispam-prvs: <PS1PR06MB2837A8B278B93F70A125E9FFBD0C9@PS1PR06MB2837.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XVb8Pt2gN5QOAu2OBhoALYZNCuqfywGjIjdX3GWde6S5lELhnPZrl6pNIEvbgJOiGBv/3PuFvRAVs2V4aDPemdkKvnbBoWnF+M6mNDxP1+pfi5jk/YSmc3/VqZboHUCVwP8xLppXyp1AatoW0xwfNFf346iOtFGt9DNJ4KrubnAMRNsQkvbyX1KDz/+1wxlHj4Qiv+kdgVxWAigzcbrQ2p16UwVMOfs73RjdtHH0dYgm8Sp/o5PDM4OFiVjLk9jTMx6pW0AkM1VIEuzsX4qXZQYPQabHMlKsJtCMM1SfdFVzgtwIOF/QTUl4v+vcCqGZ0KlqiBxK7bAqc4bceOAKNumMwq6W6XZBB719PPj/XYNorhSeU72dSyqTsj5oh378SaSVnLYVVu6ZPEo7/MzsZVrRGCIkXa8ut/srlbQwYkQbAIIUSwrMajx4CZGFn0gp8/Kmt9dWhjahBgFS9wkVvl1fwHJADR+zi8+xDV/HmjpZqVdgREldl8iGMnyaTgcS/mclSAHqVjE7y4lwiZkzDRtIBrk6ol/c3eHBCb63syhaIVolrTYXDRMDaBH8u5/F8hYHM7SvG4IB1E31ERDnPy8ncMGodEO3JkX4PJePNQ0zfuBmgX+XPje2A8G+g8VwIxhhNebTeRyhgAIBPqmq6Dbhgo06QjYLlcjKf2eGwNG20xL9gC0mHSaYTLJt7fSQ7yRte/eNWCi+44bfksW9NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(8936002)(38100700002)(86362001)(38070700005)(55016003)(9686003)(66446008)(66556008)(4326008)(6506007)(66476007)(64756008)(7416002)(8676002)(7696005)(5660300002)(122000001)(52536014)(66946007)(71200400001)(508600001)(33656002)(91956017)(76116006)(6916009)(54906003)(316002)(2906002)(85182001)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SG9uWE0wMUlLanVtVkI4dWliTVduRWlzSSs2TkVRczZ5WndWRGxGNXQyeTBT?=
 =?utf-8?B?QjR2Q0F0VmRpa0grUE8wUERNcEMxUkczdTlBZk9tRXBQVHZHY3ZSVkRMS2wr?=
 =?utf-8?B?NjB4b2k4Z0Q0T3JKQkFMR2Y1MjY2VWlWWjdtMFZRUHhXOWNPempoT0ZIUENs?=
 =?utf-8?B?eUJKbGE5K252blJ2K3Q4SUs2dm5XalJUUXBxVDRWUjkzSlVVOWlQWDgvSTlC?=
 =?utf-8?B?ekYyQkxrYWZFbTFpMHlQdUJLQWNxQ1dzVUUvb0NaRDk5UzVIelZDOEVrdjJh?=
 =?utf-8?B?ZzVQdi9lWW9LUUZFcWtJajNiVmVKOTFDQmh1T1lEZmhEZWF4MUpwNGVjcll2?=
 =?utf-8?B?WWdRZ0M0THhSZXN3R1hhUTFkTjNlYWVHZXU1L1BhdHRqbFJySGVCYVZzTzZI?=
 =?utf-8?B?QmZ6RVZJMlJqQU9xTVJrbThLSHMvUnVZZHhVeUFqbkV6cVczS2RWZmJLbXpt?=
 =?utf-8?B?dVdCUS9yY293dnFsaUhhL2xlc0NEdzgvQm9XOG1oSTZ3cWhsamM2WVRjNzhy?=
 =?utf-8?B?Ukt3OGxLcUhhZVNqaFlpbmF6clJaSlBmMXpkdCsvK0VjbFdrZFRyRHU1Zlpl?=
 =?utf-8?B?WWZQTW5PdkJXeC9Fd0VkdjNWRXVZQ0dlR0NRMmxUZTluZnE4aXlpcGFXY0Fu?=
 =?utf-8?B?L29zUUtpdGFLNllVYnJsU1ppWW5kcEozbGRndjBlTkVnT3FCT0xqWjM0RktT?=
 =?utf-8?B?UmxhVzBLakFpc3JGOFZGODQxRnlGR0x6QUpweHlJUGRxTzJZelNuVm5hVHYz?=
 =?utf-8?B?ckk0elBCQUFEWjN6WHpuUVA3cWZnNjZ6ZnF0NEJEbFQ5OFk3SS94bVFFNmV0?=
 =?utf-8?B?aEM0ZHFpa29wWkJhdGIwWWVweEgzcVBhdThFY2QvR1VwQnJnZk41UGV5WGJt?=
 =?utf-8?B?T0hkZTNLSEVoYW1lOXJJL2lWa1FQSHVkdEhabUljT1RzakFwelcyZnNacEls?=
 =?utf-8?B?ZTlnOVQzWllPV2RORDdVY1hoRDdtSEFXTWFVNGs5cFIvS2U1Y3JlMGRTeG1w?=
 =?utf-8?B?ZGRMZjF0bEthclQwcENncGJEbHBNc2R2MnYwRFBpR1BWK2RzV0RDOEdNUFJh?=
 =?utf-8?B?UmxRaUlIWDkzK2hUdzBZM0NkTmozYXEzVlFTbWs5Y3I4OWdVSlM4TGx2aGZF?=
 =?utf-8?B?UURKck9QTWRrUUw1bzFYUzF6b0t0dW4wUGNJdVpSU1Rld0lkT200YStlZ0hY?=
 =?utf-8?B?VVVoZElkNDZxYnZjVkNTKzFJRnp2TnBWbXVJUVVsaUVKdWFOZ0xDR0FweW9D?=
 =?utf-8?B?N25kazlEVkRUY0UxLy80TWxZR0dxV0dUM1IwNVRPeHNXTkNHOXFpVVBOcEJX?=
 =?utf-8?B?dk05ZXZLUllNSjJ5NnRkengyZkFzQ3BGSU1GalBoK0lCb1hEc2FBUjY3QWxq?=
 =?utf-8?B?V0FzS3FwR0pPR0RyYUx0MkptYWo1NVZ5OVJUZzlheVNzdEV2UGJPYUo4ZVQ4?=
 =?utf-8?B?eVNkNmtGeHM5cHVHVHk1S0VBRm4zSDRTS0NFNVBuSVd4Rjh1ZjdmSWNab1Ji?=
 =?utf-8?B?WFh4Z005akVkN1N0TnBPU1BBZ1ptMGZWSFgyVHI5QlJxZW16eGtxTTQ1cTN5?=
 =?utf-8?B?dDh1b2o0QWxEa0JrckZzQ1M0bk1zazdOc3lhV3F3L1FpTmhrdmFZU1h0TWpY?=
 =?utf-8?B?U3JqZS8xSkhIMWtlVW5xVzBjUTBlNUF0M29UTFoyUXZZdU9zZW5wOTNvWURi?=
 =?utf-8?B?OFFNZlZXY1RzY1VrMFF5TDFHdFNLenRRUldwY3RBRHc0VlVOc1p0Z1VKbURG?=
 =?utf-8?B?Q2JYSk00WEJEdmhveFF5RG9rZGZKTHZGYy80dWdyVVR6RkdCOE1KSHFMbUcy?=
 =?utf-8?B?QWpvQm5Sd3NaTy9GMk5xNGJGMUFzaUEyVlJBeXl2NXdaaDNLMWhlYkdFU3Bt?=
 =?utf-8?B?MjVQTW5kTGVrUExRQWJRNEdMSVhKOGk3TTRmZGlReko0cU5wejBmUDVMbjVW?=
 =?utf-8?B?TVQ1NnQ0VmIvZFBTZkRIWEZ6aElQWWVjQXE2UlJ0ZW5qVFE5dm5ualBXcDNn?=
 =?utf-8?B?OHg2dGtuc29pdDJUb2dtOHJHU1VXUTdoOW5OdjBTTVdUQmV4OE5CZExFT3hU?=
 =?utf-8?B?T3hZdkFET2JkOFV4bDZRakx2a0pPWEVrZWVrSWVPRFN6eHJoNStnQUlWZUR0?=
 =?utf-8?B?eTE1YTRlRDMxa1dybk5yOGJiUkJxSFdPNHp0alYvU3dYOW8rRStnei9DeFdE?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae87ab24-02ff-4d48-55c4-08da0337bcd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 08:18:34.4066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YbVbvwYhtAGMByoAxRBnkfoc3MIOOoLpqKCQ2j7TQbHAVkTqoRakwzQJ02D23FnshOiyrQsUyIuKBFnD+nGjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR06MB2837
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+Cj4+Cj4+ID5PbiBUaHUsIDEwIE1hciAyMDIyIGF0IDEzOjU5LCBRaW5nIFdhbmcgPHdhbmdx
aW5nQHZpdm8uY29tPiB3cm90ZToKPj4gPj4KPj4gPj4gRnJvbTogV2FuZyBRaW5nIDx3YW5ncWlu
Z0B2aXZvLmNvbT4KPj4gPj4KPj4gPj4gU29tZSBhcmNoaXRlY3R1cmVzKGUuZy4gQVJNNjQpLCBj
YWNoZXMgYXJlIGltcGxlbWVudGVkIGJlbG93Ogo+PiA+PiBjbHVzdGVyOsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKioqKioqIGNsdXN0ZXIgMCAqKioqKsKgwqDCoMKg
wqAgKioqKioqIGNsdXN0ZXIgMSAqKioqKgo+PiA+PiBjb3JlOsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoCAxwqDCoMKgwqDCoMKgwqDC
oMKgIDLCoMKgwqDCoMKgIDPCoMKgwqDCoMKgwqDCoMKgwqAgNMKgwqDCoMKgwqAgNcKgwqDCoMKg
wqDCoMKgwqDCoMKgIDbCoMKgwqDCoMKgIDcKPj4gKGFkZCBjYWNoZSBsZXZlbCAxKcKgwqDCoMKg
wqDCoMKgIGMwwqDCoMKgIGMxwqDCoMKgwqDCoMKgwqAgYzLCoMKgwqAgYzPCoMKgwqDCoMKgwqDC
oMKgIGM0wqDCoMKgIGM1wqDCoMKgwqDCoMKgwqDCoCBjNsKgwqDCoCBjNwo+PiA+PiBjYWNoZShM
ZXZlbG4pOsKgwqDCoMKgwqDCoMKgwqAgKipjYWNoZTAqKsKgICoqY2FjaGUxKirCoCAqKmNhY2hl
MioqwqAgKipjYWNoZTMqKgo+PiAoYWRkIGNhY2hlIGxldmVsIDMpwqDCoMKgwqDCoMKgwqAgKioq
KioqKioqKioqKnNoYXJlIGxldmVsIDMgY2FjaGUgKioqKioqKioqKioqKioqCj4+ID4+IHNkX2xs
Y19pZChjdXJyZW50KTrCoMKgwqDCoCAwwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgwqDCoMKgIDDC
oMKgwqDCoMKgIDDCoMKgwqDCoMKgwqDCoMKgwqAgNMKgwqDCoMKgwqAgNMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDTCoMKgwqDCoMKgIDQKPj4gPj4gc2RfbGxjX2lkKHNob3VsZCBiZSk6IDDCoMKgwqDC
oMKgIDDCoMKgwqDCoMKgwqDCoMKgwqAgMsKgwqDCoMKgwqAgMsKgwqDCoMKgwqDCoMKgwqDCoCA0
wqDCoMKgwqDCoCA0wqDCoMKgwqDCoMKgwqDCoMKgwqAgNsKgwqDCoMKgwqAgNgo+PiA+Pgo+PiBI
ZXJlLCBuIGFsd2F5cyBiZSAyIGluIEFSTTY0LCBidXQgb3RoZXJzIGFyZSBhbHNvIHBvc3NpYmxl
Lgo+PiBjb3JlWzAsMV0gZm9ybSBhIGNvbXBsZXgoQVJNVjkpLMKgIHdoaWNoIHNoYXJlIEwyIGNh
Y2hlLCBjb3JlWzIsM10gaXMgdGhlIHNhbWUuCj4+Cj4+ID4+IENhY2hlcyBhbmQgY3B1cyBoYXZl
IGRpZmZlcmVudCB0b3BvbG9neSwgdGhpcyBjYXVzZXMgY3B1c19zaGFyZV9jYWNoZSgpCj4+ID4+
IHJldHVybiB0aGUgd3JvbmcgdmFsdWUsIHdoaWNoIHdpbGwgYWZmZWN0IHRoZSBDUFUgbG9hZCBi
YWxhbmNlLgo+PiA+Pgo+PiA+V2hhdCBkb2VzIHlvdXIgY3VycmVudCBzY2hlZHVsZXIgdG9wb2xv
Z3nCoCBsb29rIGxpa2U/Cj4+ID4KPj4gPkZvciBDUFUgMCB0byAzLCBkbyB5b3UgaGF2ZSB0aGUg
YmVsb3cgPwo+PiA+RElFIFswwqDCoMKgwqAgLcKgwqDCoMKgIDNdIFs0LTddCj4+ID5NQ8KgIFsw
XSBbMV0gWzJdIFszXQo+Pgo+PiBUaGUgY3VycmVudCBzY2hlZHVsZXIgdG9wb2xvZ3kgY29uc2lz
dGVudCB3aXRoIENQVSB0b3BvbG9neToKPj4gRElFwqAgWzAtN10KPj4gTUPCoCBbMC0zXSBbNC03
XcKgIChTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTKQo+PiBNb3N0IEFuZHJvaWQgcGhvbmVzIGhhdmUg
dGhpcyB0b3BvbG9neS4KPj4gPgo+PiA+QnV0IHlvdSB3b3VsZCBsaWtlIHNvbWV0aGluZyBsaWtl
IGJlbG93IGZvciBjcHUgMC0xIGluc3RlYWQgPwo+PiA+RElFIFswwqDCoMKgwqAgLcKgwqDCoMKg
IDNdIFs0LTddCj4+ID5DTFMgWzAgLSAxXSBbMiAtIDNdCj4+ID5NQ8KgIFswXSBbMV0KPj4gPgo+
PiA+d2l0aCBTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTIG9ubHkgc2V0IHRvIE1DIGxldmVsID8KPj4K
Pj4gV2UgZG9uJ3QgY2hhbmdlIHRoZSBjdXJyZW50IHNjaGVkdWxlciB0b3BvbG9neSwgYnV0IHRo
ZQo+PiBjYWNoZSB0b3BvbG9neSBzaG91bGQgYmUgc2VwYXJhdGVkIGxpa2UgYmVsb3c6Cj4KPlRo
ZSBzY2hlZHVsZXIgdG9wb2xvZ3kgaXMgbm90IG9ubHkgY3B1IHRvcG9sb2d5IGJ1dCBhIG1peGVk
IG9mIGNwdSBhbmQKPmNhY2hlL21lbW9yeSBjYWNoZSB0b3BvbG9neQo+Cj4+IFswLTddwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHNoYXJlZCBsZXZl
bCAzIGNhY2hlICkKPj4gWzAtMV0gWzItM11bNC01XVs2LTddwqDCoCAoc2hhcmVkIGxldmVsIDIg
Y2FjaGUgKQo+Cj5TbyB5b3UgZG9uJ3TCoCBib3RoZXIgdGhlIGludGVybWVkaWF0ZSBjbHVzdGVy
IGxldmVsIHdoaWNoIGlzIGV2ZW4gc2ltcGxlci4KPnlvdSBoYXZlIHRvIG1vZGlmeSBnZW5lcmlj
IGFyY2ggdG9wb2xvZ3kgc28gdGhhdCBjcHVfY29yZWdyb3VwX21hc2sKPnJldHVybnMgdGhlIGNv
cnJlY3QgY3B1IG1hc2sgZGlyZWN0bHkuCj4KPllvdSB3aWxsIG5vdGljZSBhIGxsY19zaWJsaW5n
IGZpZWxkIHRoYXQgaXMgY3VycmVudGx5IHVzZWQgYnkgYWNwaSBidXQKPm5vdCBEVCB0byByZXR1
cm4gbGxjIGNwdSBtYXNrCj4KY3B1X3RvcG9sb2d5W10ubGxjX3NpYmxpbmcgZGVzY3JpYmUgdGhl
IGxhc3QgbGV2ZWwgY2FjaGUgb2Ygd2hvbGUgc3lzdGVtLCAKbm90IGluIHRoZSBzY2hlZF9kb21h
aW4uCgppbiB0aGUgYWJvdmUgY2FjaGUgdG9wb2xvZ3ksIGxsY19zaWJsaW5nIGlzIDB4ZmYoWzAt
N10pICwgaXQgZGVzY3JpYmVzCnRoZSBMMyBjYWNoZSBzaWJsaW5nLCBidXQgc2RfbGxjX2lkIGRl
c2NyaWJlcyB0aGUgbWF4aW11bSBzaGFyZWQgY2FjaGUKaW4gc2QsIHdoaWNoIHNob3VsZCBiZSBb
MC0xXSBpbnN0ZWFkIG9mIFswLTNdLgoKVGhhbmtzLApXYW5n
