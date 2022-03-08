Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BB54D1346
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242700AbiCHJ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbiCHJ0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:26:12 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041B23E5CB;
        Tue,  8 Mar 2022 01:25:15 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2287DmDd007806;
        Tue, 8 Mar 2022 04:25:10 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3em5n8dkcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 04:25:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WS3IkBaMtWwuGq3zs46jBmGLeyh5H6JcU4m6xAFIwPhOGsKYhq/ARQkV80YjHpS/8eNREDffqhqANZpYnqJlC42w4sCOdYuxdawt/GxFeRxFMOAf6DLYqR2gaZ9f3BV1ka/SotUiaDJ9iUOIFPXcOy5KeLjG1Zl5FBzLV9+1y0Od3f7r84Ut1g4hkgW4oLczZYK+xhQwwtxVhm0vmhXAOeNtLXIqY6UbcLSkvwDpn9FQekCvDpyL6FMvi2v0KZAUAcKc/59JZ57DF2U79rmfeQ6+vSlCnqs0r0Aopz+fTP/z/LqQxLbxiQuyB/NbTjcPsdjIohrGNEqM/JpzLPwaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5OY1CBKXvdumMzmLfCEwdZX/TJPtc53NZofoF2KgFo=;
 b=dtnMHYIjVqTtTX/T5zaBftA3JmqrIteGq+uYJcrbcLMPG8Q0Ixo/HqdzYAuSzqoSNTpsSHXkIV6R7F4U14c9x3tunBaEUrjt9Ofe6JAJcbi0/cl/bK1+pVvZIpTqhcUPBKsTH3sS1He5DahtH4ZxSEVIAVqrDhY69OyKr0PTXDxqH7QVZw+Ye3Ada+Ht+BFeY3yf9rT5WpeAEl3Umk9X93d7BLgiNhmKbKYF6hbmbWTw0IrPS9KwUoMYMkuw1BuFGT4RTNCcv2ph0/MweEXGTxUznt8zsPkrg1XOV7hTsV5Ygbs5uu5IiSshETKTLBD97xXukyYKNdYYEU4xf6zZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5OY1CBKXvdumMzmLfCEwdZX/TJPtc53NZofoF2KgFo=;
 b=vekiqd4H+UtvmXhzTjZM7NCCeZSDNg6yJsgLWCnArZmK1uQKL2wkbjfxm3ez/G7TmV6ypTnQwRvsrjBBLb8zoTfjN/rcJMEvg5fhQ1iMJadFZs6qNv99Gj0IyU5S1N3aLvoCz/1vixZokM30+MtJgwJsS52+GjVSc0zhJgW30zw=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by SN6PR03MB3805.namprd03.prod.outlook.com (2603:10b6:805:76::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 09:25:08 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 09:25:07 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: RE: [PATCH v3 1/1] device property: Allow error pointer to be passed
 to fwnode APIs
Thread-Topic: [PATCH v3 1/1] device property: Allow error pointer to be passed
 to fwnode APIs
Thread-Index: AQHYMmIeiO1ypglm0UKwY/7o4sN2wqy1Nheg
Date:   Tue, 8 Mar 2022 09:25:07 +0000
Message-ID: <PH0PR03MB67867223806C29FF1DF90E6499099@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220307202949.75300-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220307202949.75300-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFlUSXhPV1JrWVRZdE9XVmpNUzB4TVdWakxUaGlZemd0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGaVhHRnRaUzEwWlhOMFhHRXlNVGxrWkdFM0xUbGxZekV0TVRGbFl5MDRZ?=
 =?utf-8?B?bU00TFdaak56YzNOREl4Wm1OaFltSnZaSGt1ZEhoMElpQnplajBpTnpRMk1D?=
 =?utf-8?B?SWdkRDBpTVRNeU9URXlNRFV4TURNNU1qZzVOekUwSWlCb1BTSm9TR0ZrYUhC?=
 =?utf-8?B?V2NXMTRiMmw2Um1WSFNFRlJkREZtWjJaMloyODlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVSjVkMXBDYTNwcVRGbEJaQ3RNZFRWUVQySlFRMVV6TkhVM2F6?=
 =?utf-8?B?ZzFjemhLVVVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVlpKUlhadlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a53d981-3d0f-4427-9a6a-08da00e58908
x-ms-traffictypediagnostic: SN6PR03MB3805:EE_
x-microsoft-antispam-prvs: <SN6PR03MB38051A960BE02263AC40F06A99099@SN6PR03MB3805.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BBUDgnh737rzt3Tbg1JPpyRlkJ+HpebwesZCkZtzI7hVa8NZJAiep86RuElhXwsYXntxOpNPIE+WJcLAzbAODo10AF3VpZ+wqvAK34bGMZiJcukIcrHA3h83V8k54KydANdk4/nf0qlnR3OZqu+wv6WYrEL72bgDJIcp81b8lldwu6JPUIlblXooO/Q3RbYdrmhL0anQHxUgRtOEcLdMyf5PhBD9HRmLW3uJJUqLiON0/A7irxN1n7dxvmRZa1HX6Ofng5e6IpDk+LgtgDpOt63p2nVDvPck12cYAKv3GWX1H1RAED02IBJa6+GiQTjn626e9oN8r16WQ0tx/JZZ9gNM3Dufq8bGb1G7FlsbEYNnrS/68whTDzmA7zvVqG6oMbW4SBn5SgbFKgZseEt8u/NVE8gQiZ2Lww4U74W8pGQWmwxPIvZ8WAhFbjjwu+rOBkqEmzXLNjbFEbVlsHCeVwh0RTm5fADQPIbm3xYhimKTWpmGA7LH5e2LEi6Q/xTPuH7GbUpZrcVmKTuLPScmjwhZuu5fkdWfU/gx09oQFQIA/G+Vs1S+sWvzTdYrNzswPcwNheuk9O5xdqn0lEr5agP77RhJPZkKLuTioE3l7VHcFBYsRPtWkUbasAjq0nqcnUcaAdehDb6utPcPPxjit64pk/ErVHQny0WsS9AVhfHkUI/cbSCVqNIfDqHrzJxSpA197ACes+6vkrOTrX05gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(110136005)(83380400001)(8936002)(8676002)(71200400001)(76116006)(64756008)(66476007)(316002)(66556008)(66446008)(86362001)(55016003)(33656002)(4326008)(52536014)(26005)(186003)(66946007)(9686003)(2906002)(122000001)(38100700002)(38070700005)(7416002)(5660300002)(508600001)(6506007)(7696005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDkrTVVkcDk4aUkrbmh3N2xwSEhGMFo3bXNYNFZtTHJxaDRuWDV6SmRHN2VV?=
 =?utf-8?B?a1BjcVJhOEFEK2VHL0xiT1ZUYTI2RTRFVjJJb1c1VHU0U0llTThHUDcreXZ3?=
 =?utf-8?B?QlFmcU5Odk55QTBUb3B2U2hOV2NleUhrcnRwbE1uTDloWm5laUNjZUI2bFVx?=
 =?utf-8?B?emc1MER2Vko1RGRLb0tweWVGckticDB3ZjJIeGd1MlduY3l3cUhqSDkzL2tJ?=
 =?utf-8?B?ajQyaFVoS3lJZDVSbGxzYS9FbFR1cEQ5NVpwSGswRzZKdnNuRmQ2SWhsaklL?=
 =?utf-8?B?TndzWG50eTc4V05ZdnZBMnMxN1FIUW0zZjVvVWdFQUNLZlgxb1NhcUMvMnBD?=
 =?utf-8?B?Z1ZjYUlscEw5RUxrWmxnbGlTbFpYc0sxOEFNZ3RPUFBRQ0g0R2laSlNwdUhH?=
 =?utf-8?B?eEt1WHZmMndrUFkzU21pSHpKcFQ3amhXaVBaLzdBQUFXT1hHKytVOUZJRVNh?=
 =?utf-8?B?bS8rZHF3bEJHR0djbHhSdjRJcTFCV290NmFkM0N6YU1oS1hsYVFleFpHaVZh?=
 =?utf-8?B?OFlqNC9XQlkxdFNnOFRyaW5SajZXWWdnZUc2NEhYVUtKQUV6ZzRVeCt3enNs?=
 =?utf-8?B?QnlMYVJYcWNTWXNNQ2NSci83S1ZjUXdkZzVFM1R4VVRBcldLRnI0VExYZ1dk?=
 =?utf-8?B?N1Y1SHV4SFVZc2dlQ0d0TzAveTdjN2NiMXYyR0hGT3Z3TzhTOGdQaWhIMW5E?=
 =?utf-8?B?bktRMnVkZUZkMm9PRVprek1TZUwxSWNUanZkVGxEaDRMaUZLMDNselJVUHFm?=
 =?utf-8?B?elA0L0FkOG1Fdy91WW1wUSt2MU55d2dJTmpCdG1Ka0ViZzdFYnBNRUNHWGFR?=
 =?utf-8?B?U2JiNFNDNzNIYU45V3J3MHY0dDRRZ1NVTzcwNWZPVHpNdHdqdi83TmhSVHEx?=
 =?utf-8?B?M3NZUytncWl6Q2wrbWczZHNiTU90dklCTVhObWhVTXA1TmY5cm43b0JHZnAy?=
 =?utf-8?B?aHF6WFpLYzU1Snl3ZTE4d2ZiV1BLa2R6R1oxd1dHdzhMTkUwYlZVZFhZMXdE?=
 =?utf-8?B?T0YwMFFuUlRQakFQeUhVZmsxTmUyVVkyUnBnMlRqdmxkc1g1UnYyT0c1MlBX?=
 =?utf-8?B?bk00Vkd6WGRaTERVS29sRjhHVkJSeVlPT0VvV3hhclZHUWtZSlhXY0NJSjM1?=
 =?utf-8?B?WW05WjR6bnRBWE1YL1RvNWx1RHlFZjRiNjMyMmhpeWN6eVlDUFBRZU9iNmhr?=
 =?utf-8?B?dko0YWxzZnV5U3NhK1p0VHRVeEpRZVZvSFJ0VzdLclVFVE42aitIZjV4TlNa?=
 =?utf-8?B?MEhlMXpsdjdrUVl3NXN4VGZ1Qjc2R2Q1dE5PakxKbG4rMFZpQzFHTFVnUHRU?=
 =?utf-8?B?MlBqQmZ1QkQzNzhvTWZVWGJPYWR2QTZwSjRJVHpJc0cxbis5d0NhQ0tIbGJv?=
 =?utf-8?B?UUIyWS8vakw2Yy9mU21ISVZMMjVhVU55WDB0aFN0Unk2aXVoUHdrWkJFQ2ow?=
 =?utf-8?B?S0RRTVQwYzdZYkFFR1hxWkNoM1MwMXVYR04vRk4zRkk3YzNMZGNOWXYwR3Bp?=
 =?utf-8?B?bFNNNmg1L1k3YWx1ODhxSzZJS0hUVmEvNzRXQ21XcjBYOFFzVE9tNGpicm14?=
 =?utf-8?B?VERNZlVEQXc1OUdjaFVSOWJ3cEJsRU5TL1N5bEFDSktBY1RvOFFqK0VrR2Rx?=
 =?utf-8?B?YTdLVkRJQ0JyRUIwZlhPZGhOV3J1MUN2bmppSnJoazA0aGlzTm4yb0lXbnBJ?=
 =?utf-8?B?dGdFaFphOVhVOU1kOXBzQVhjS1d5b1pIR2M3UEpGN1VPTjlLL1ZSbGFRTWln?=
 =?utf-8?B?VUtyMEpKbnM3aXdZaFNtY1FSWVYwVElGNkxWakxtWHh0ejVjYmFicGRGRDlY?=
 =?utf-8?B?c0pJVzRJMWtTUkZKc2ZERmR2clJYUnpMTWg2ajJPQzhtQUhqbUgxNlhzQjVT?=
 =?utf-8?B?Z1JNMGZrOVdrWlVPRTVhQVZSamFtNTJGN3h2eldKUnhJME9sYTllaCtRSUxR?=
 =?utf-8?B?elJ0bCtrdmdTK3pZYmJ2TExEWldPMzhHT01WbnRjSG94bmZuek1IeFplNnls?=
 =?utf-8?B?bThTNERLYlV5TG11OGduTVNvWm90SGh5cExBVlE3MUJMZXV0SW9BT2dwN0Jm?=
 =?utf-8?B?dDZORFA3U3lodGZ1WXVvVGowM0FPR3E0b05rU3M3SjJXVmJ1Ylk5YThWRWxI?=
 =?utf-8?B?TjYyN3dmc0prV0t4b2FZOFpUMlZUcG9ZS0JjMWZNa05HbXhQNmxlZ2Roak1M?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a53d981-3d0f-4427-9a6a-08da00e58908
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 09:25:07.1337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzwWmV3x6oiXJEnrhUCxqqz1wus55OPGQCcb9gHjo2pY7mRSiryewp3Ebk19kJIOYifyMvQZ3rSzxAlyypXcWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3805
X-Proofpoint-GUID: U-EIFhsAQU9LRVmd8fzsUnFOoFNJfOfe
X-Proofpoint-ORIG-GUID: U-EIFhsAQU9LRVmd8fzsUnFOoFNJfOfe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080048
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWFy
Y2ggNywgMjAyMiA5OjMwIFBNDQo+IFRvOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hl
bmtvQGxpbnV4LmludGVsLmNvbT47IFJhZmFlbCBKLg0KPiBXeXNvY2tpIDxyYWZhZWwuai53eXNv
Y2tpQGludGVsLmNvbT47IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBEYW5pZWwgU2NhbGx5IDxkanJzY2FsbHlAZ21haWwu
Y29tPjsgSGVpa2tpIEtyb2dlcnVzDQo+IDxoZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29t
PjsgU2FrYXJpIEFpbHVzDQo+IDxzYWthcmkuYWlsdXNAbGludXguaW50ZWwuY29tPjsgR3JlZyBL
cm9haC1IYXJ0bWFuDQo+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IFJhZmFlbCBKLiBX
eXNvY2tpDQo+IDxyYWZhZWxAa2VybmVsLm9yZz47IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3Jn
PjsgU2EsIE51bm8NCj4gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYz
IDEvMV0gZGV2aWNlIHByb3BlcnR5OiBBbGxvdyBlcnJvciBwb2ludGVyIHRvIGJlDQo+IHBhc3Nl
ZCB0byBmd25vZGUgQVBJcw0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gU29tZSBvZiB0aGUgZndu
b2RlIEFQSXMgbWlnaHQgcmV0dXJuIGFuIGVycm9yIHBvaW50ZXIgaW5zdGVhZCBvZg0KPiBOVUxM
DQo+IG9yIHZhbGlkIGZ3bm9kZSBoYW5kbGUuIFRoZSByZXN1bHQgb2Ygc3VjaCBBUEkgY2FsbCBt
YXkgYmUgY29uc2lkZXJlZA0KPiBvcHRpb25hbCBhbmQgaGVuY2UgdGhlIHRlc3QgZm9yIGl0IGlz
IHVzdWFsbHkgZG9uZSBpbiBhIGZvcm0gb2YNCj4gDQo+IAlmd25vZGUgPSBmd25vZGVfZmluZF9y
ZWZlcmVuY2UoLi4uKTsNCj4gCWlmIChJU19FUlIoZndub2RlKSkNCj4gCQkuLi5lcnJvciBoYW5k
bGluZy4uLg0KPiANCj4gTmV2ZXJ0aGVsZXNzIHRoZSByZXN1bHRpbmcgZndub2RlIG1heSBoYXZl
IGJ1bXBlZCB0aGUgcmVmZXJlbmNlDQo+IGNvdW50DQo+IGFuZCBoZW5jZSBjYWxsZXIgb2YgdGhl
IGFib3ZlIEFQSSBpcyBvYmxpZ2VkIHRvIGNhbGwNCj4gZndub2RlX2hhbmRsZV9wdXQoKS4NCj4g
U2luY2UgZndub2RlIG1heSBiZSBub3QgdmFsaWQgZWl0aGVyIGFzIE5VTEwgb3IgZXJyb3IgcG9p
bnRlciB0aGUNCj4gY2hlY2sNCj4gaGFzIHRvIGJlIHBlcmZvcm1lZCB0aGVyZS4gVGhpcyBhcHBy
b2FjaCB1Z2xpZmllcyB0aGUgY29kZSBhbmQgYWRkcw0KPiBhIHBvaW50IG9mIG1ha2luZyBhIG1p
c3Rha2UsIGkuZS4gZm9yZ2V0dGluZyBhYm91dCBlcnJvciBwb2ludCBjYXNlLg0KPiANCj4gVG8g
cHJldmVudCB0aGlzLCBhbGxvdyBhbiBlcnJvciBwb2ludGVyIHRvIGJlIHBhc3NlZCB0byB0aGUg
Zndub2RlDQo+IEFQSXMuDQo+IA0KPiBGaXhlczogODNiMzRhZmI2Yjc5ICgiZGV2aWNlIHByb3Bl
cnR5OiBJbnRyb2R1Y2UNCj4gZndub2RlX2ZpbmRfcmVmZXJlbmNlKCkiKQ0KPiBSZXBvcnRlZC1i
eTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5keSBT
aGV2Y2hlbmtvDQo+IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+IFRlc3Rl
ZC1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gLS0tDQo+IA0KPiB2MzogZHJv
cHBlZCB0ZXN0IG9mIHNlY29uZGFyeSBmd25vZGUgKE51bm8pLCBhZGRlZCB0YWcgKE51bm8pLA0K
PiBhbWVuZGVkIGNvbW1pdCBtZXNzYWdlDQo+IHYyOiBhZGp1c3RlZCB0aGUgZW50aXJlIGZ3bm9k
ZSBBUEkgKFNha2FyaSkNCj4gDQo+IE51bm8sIGNhbiB5b3UgcmUtdGVzdCB0aGlzIHdpdGggdGhl
IGx0YzI5ODMgc2VyaWVzIHRvIGJlIHN1cmUgaXQgaXMgc3RpbGwNCj4gb2theT8NCg0KU3RpbGwg
d29ya3MhDQoNCj4gIGRyaXZlcnMvYmFzZS9wcm9wZXJ0eS5jIHwgNzYgKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tDQo+IC0tLS0tDQo+ICBpbmNsdWRlL2xpbnV4L2Z3bm9kZS5o
ICB8IDEwICsrKy0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspLCAzOCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvcHJvcGVydHkuYyBi
L2RyaXZlcnMvYmFzZS9wcm9wZXJ0eS5jDQo+IGluZGV4IGMwZTk0Y2NlOWMyOS4uNjM1YTBlNTU2
YTRmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Jhc2UvcHJvcGVydHkuYw0KPiArKysgYi9kcml2
ZXJzL2Jhc2UvcHJvcGVydHkuYw0KPiBAQCAtOSw2ICs5LDcgQEANCj4gDQo+ICAjaW5jbHVkZSA8
bGludXgvYWNwaS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2V4cG9ydC5oPg0KPiArI2luY2x1ZGUg
PGxpbnV4L2Z3bm9kZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L29mLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KPiBAQCAt
NDcsMTIgKzQ4LDE0IEBAIGJvb2wgZndub2RlX3Byb3BlcnR5X3ByZXNlbnQoY29uc3Qgc3RydWN0
DQo+IGZ3bm9kZV9oYW5kbGUgKmZ3bm9kZSwNCj4gIHsNCj4gIAlib29sIHJldDsNCj4gDQo+ICsJ
aWYgKElTX0VSUl9PUl9OVUxMKGZ3bm9kZSkpDQo+ICsJCXJldHVybiBmYWxzZTsNCj4gKw0KPiAg
CXJldCA9IGZ3bm9kZV9jYWxsX2Jvb2xfb3AoZndub2RlLCBwcm9wZXJ0eV9wcmVzZW50LA0KPiBw
cm9wbmFtZSk7DQo+IC0JaWYgKHJldCA9PSBmYWxzZSAmJiAhSVNfRVJSX09SX05VTEwoZndub2Rl
KSAmJg0KPiAtCSAgICAhSVNfRVJSX09SX05VTEwoZndub2RlLT5zZWNvbmRhcnkpKQ0KPiAtCQly
ZXQgPSBmd25vZGVfY2FsbF9ib29sX29wKGZ3bm9kZS0+c2Vjb25kYXJ5LA0KPiBwcm9wZXJ0eV9w
cmVzZW50LA0KPiAtCQkJCQkgcHJvcG5hbWUpOw0KPiAtCXJldHVybiByZXQ7DQo+ICsJaWYgKHJl
dCA9PSB0cnVlKQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJcmV0dXJuIGZ3bm9kZV9jYWxs
X2Jvb2xfb3AoZndub2RlLT5zZWNvbmRhcnksDQo+IHByb3BlcnR5X3ByZXNlbnQsIHByb3BuYW1l
KTsNCj4gIH0NCj4gIEVYUE9SVF9TWU1CT0xfR1BMKGZ3bm9kZV9wcm9wZXJ0eV9wcmVzZW50KTsN
Cj4gDQo+IEBAIC0yMzIsMTUgKzIzNSwxNiBAQCBzdGF0aWMgaW50DQo+IGZ3bm9kZV9wcm9wZXJ0
eV9yZWFkX2ludF9hcnJheShjb25zdCBzdHJ1Y3QgZndub2RlX2hhbmRsZQ0KPiAqZndub2RlLA0K
PiAgew0KPiAgCWludCByZXQ7DQo+IA0KPiArCWlmIChJU19FUlJfT1JfTlVMTChmd25vZGUpKQ0K
PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiAgCXJldCA9IGZ3bm9kZV9jYWxsX2ludF9vcChm
d25vZGUsIHByb3BlcnR5X3JlYWRfaW50X2FycmF5LA0KPiBwcm9wbmFtZSwNCj4gIAkJCQkgZWxl
bV9zaXplLCB2YWwsIG52YWwpOw0KPiAtCWlmIChyZXQgPT0gLUVJTlZBTCAmJiAhSVNfRVJSX09S
X05VTEwoZndub2RlKSAmJg0KPiAtCSAgICAhSVNfRVJSX09SX05VTEwoZndub2RlLT5zZWNvbmRh
cnkpKQ0KPiAtCQlyZXQgPSBmd25vZGVfY2FsbF9pbnRfb3AoDQo+IC0JCQlmd25vZGUtPnNlY29u
ZGFyeSwgcHJvcGVydHlfcmVhZF9pbnRfYXJyYXksDQo+IHByb3BuYW1lLA0KPiAtCQkJZWxlbV9z
aXplLCB2YWwsIG52YWwpOw0KPiArCWlmIChyZXQgIT0gLUVJTlZBTCkNCj4gKwkJcmV0dXJuIHJl
dDsNCj4gDQo+IC0JcmV0dXJuIHJldDsNCj4gKwlyZXR1cm4gZndub2RlX2NhbGxfaW50X29wKGZ3
bm9kZS0+c2Vjb25kYXJ5LA0KPiBwcm9wZXJ0eV9yZWFkX2ludF9hcnJheSwgcHJvcG5hbWUsDQo+
ICsJCQkJICBlbGVtX3NpemUsIHZhbCwgbnZhbCk7DQo+ICB9DQo+IA0KPiAgLyoqDQo+IEBAIC0z
NzEsMTQgKzM3NSwxNiBAQCBpbnQNCj4gZndub2RlX3Byb3BlcnR5X3JlYWRfc3RyaW5nX2FycmF5
KGNvbnN0IHN0cnVjdCBmd25vZGVfaGFuZGxlDQo+ICpmd25vZGUsDQo+ICB7DQo+ICAJaW50IHJl
dDsNCj4gDQo+ICsJaWYgKElTX0VSUl9PUl9OVUxMKGZ3bm9kZSkpDQo+ICsJCXJldHVybiAtRUlO
VkFMOw0KPiArDQo+ICAJcmV0ID0gZndub2RlX2NhbGxfaW50X29wKGZ3bm9kZSwNCj4gcHJvcGVy
dHlfcmVhZF9zdHJpbmdfYXJyYXksIHByb3BuYW1lLA0KPiAgCQkJCSB2YWwsIG52YWwpOw0KPiAt
CWlmIChyZXQgPT0gLUVJTlZBTCAmJiAhSVNfRVJSX09SX05VTEwoZndub2RlKSAmJg0KPiAtCSAg
ICAhSVNfRVJSX09SX05VTEwoZndub2RlLT5zZWNvbmRhcnkpKQ0KPiAtCQlyZXQgPSBmd25vZGVf
Y2FsbF9pbnRfb3AoZndub2RlLT5zZWNvbmRhcnksDQo+IC0JCQkJCSBwcm9wZXJ0eV9yZWFkX3N0
cmluZ19hcnJheSwNCj4gcHJvcG5hbWUsDQo+IC0JCQkJCSB2YWwsIG52YWwpOw0KPiAtCXJldHVy
biByZXQ7DQo+ICsJaWYgKHJldCAhPSAtRUlOVkFMKQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+
ICsJcmV0dXJuIGZ3bm9kZV9jYWxsX2ludF9vcChmd25vZGUtPnNlY29uZGFyeSwNCj4gcHJvcGVy
dHlfcmVhZF9zdHJpbmdfYXJyYXksIHByb3BuYW1lLA0KPiArCQkJCSAgdmFsLCBudmFsKTsNCj4g
IH0NCj4gIEVYUE9SVF9TWU1CT0xfR1BMKGZ3bm9kZV9wcm9wZXJ0eV9yZWFkX3N0cmluZ19hcnJh
eSk7DQo+IA0KPiBAQCAtNDgwLDE1ICs0ODYsMTYgQEAgaW50DQo+IGZ3bm9kZV9wcm9wZXJ0eV9n
ZXRfcmVmZXJlbmNlX2FyZ3MoY29uc3Qgc3RydWN0IGZ3bm9kZV9oYW5kbGUNCj4gKmZ3bm9kZSwN
Cj4gIHsNCj4gIAlpbnQgcmV0Ow0KPiANCj4gKwlpZiAoSVNfRVJSX09SX05VTEwoZndub2RlKSkN
Cj4gKwkJcmV0dXJuIC1FTk9FTlQ7DQo+ICsNCj4gIAlyZXQgPSBmd25vZGVfY2FsbF9pbnRfb3Ao
Zndub2RlLCBnZXRfcmVmZXJlbmNlX2FyZ3MsIHByb3AsDQo+IG5hcmdzX3Byb3AsDQo+ICAJCQkJ
IG5hcmdzLCBpbmRleCwgYXJncyk7DQo+ICsJaWYgKHJldCA9PSAwKQ0KPiArCQlyZXR1cm4gcmV0
Ow0KPiANCj4gLQlpZiAocmV0IDwgMCAmJiAhSVNfRVJSX09SX05VTEwoZndub2RlKSAmJg0KPiAt
CSAgICAhSVNfRVJSX09SX05VTEwoZndub2RlLT5zZWNvbmRhcnkpKQ0KPiAtCQlyZXQgPSBmd25v
ZGVfY2FsbF9pbnRfb3AoZndub2RlLT5zZWNvbmRhcnksDQo+IGdldF9yZWZlcmVuY2VfYXJncywN
Cj4gLQkJCQkJIHByb3AsIG5hcmdzX3Byb3AsIG5hcmdzLCBpbmRleCwNCj4gYXJncyk7DQo+IC0N
Cj4gLQlyZXR1cm4gcmV0Ow0KPiArCXJldHVybiBmd25vZGVfY2FsbF9pbnRfb3AoZndub2RlLT5z
ZWNvbmRhcnksDQo+IGdldF9yZWZlcmVuY2VfYXJncywgcHJvcCwgbmFyZ3NfcHJvcCwNCj4gKwkJ
CQkgIG5hcmdzLCBpbmRleCwgYXJncyk7DQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MX0dQTChmd25v
ZGVfcHJvcGVydHlfZ2V0X3JlZmVyZW5jZV9hcmdzKTsNCj4gDQo+IEBAIC02OTgsNyArNzA1LDcg
QEAgZndub2RlX2dldF9uZXh0X2F2YWlsYWJsZV9jaGlsZF9ub2RlKGNvbnN0DQo+IHN0cnVjdCBm
d25vZGVfaGFuZGxlICpmd25vZGUsDQo+ICB7DQo+ICAJc3RydWN0IGZ3bm9kZV9oYW5kbGUgKm5l
eHRfY2hpbGQgPSBjaGlsZDsNCj4gDQo+IC0JaWYgKCFmd25vZGUpDQo+ICsJaWYgKElTX0VSUl9P
Ul9OVUxMKGZ3bm9kZSkpDQo+ICAJCXJldHVybiBOVUxMOw0KPiANCj4gIAlkbyB7DQo+IEBAIC03
MjIsMTYgKzcyOSwxNiBAQCBzdHJ1Y3QgZndub2RlX2hhbmRsZQ0KPiAqZGV2aWNlX2dldF9uZXh0
X2NoaWxkX25vZGUoc3RydWN0IGRldmljZSAqZGV2LA0KPiAgCWNvbnN0IHN0cnVjdCBmd25vZGVf
aGFuZGxlICpmd25vZGUgPSBkZXZfZndub2RlKGRldik7DQo+ICAJc3RydWN0IGZ3bm9kZV9oYW5k
bGUgKm5leHQ7DQo+IA0KPiArCWlmIChJU19FUlJfT1JfTlVMTChmd25vZGUpKQ0KPiArCQlyZXR1
cm4gTlVMTDsNCj4gKw0KPiAgCS8qIFRyeSB0byBmaW5kIGEgY2hpbGQgaW4gcHJpbWFyeSBmd25v
ZGUgKi8NCj4gIAluZXh0ID0gZndub2RlX2dldF9uZXh0X2NoaWxkX25vZGUoZndub2RlLCBjaGls
ZCk7DQo+ICAJaWYgKG5leHQpDQo+ICAJCXJldHVybiBuZXh0Ow0KPiANCj4gIAkvKiBXaGVuIG5v
IG1vcmUgY2hpbGRyZW4gaW4gcHJpbWFyeSwgY29udGludWUgd2l0aCBzZWNvbmRhcnkNCj4gKi8N
Cj4gLQlpZiAoZndub2RlICYmICFJU19FUlJfT1JfTlVMTChmd25vZGUtPnNlY29uZGFyeSkpDQo+
IC0JCW5leHQgPSBmd25vZGVfZ2V0X25leHRfY2hpbGRfbm9kZShmd25vZGUtDQo+ID5zZWNvbmRh
cnksIGNoaWxkKTsNCj4gLQ0KPiAtCXJldHVybiBuZXh0Ow0KPiArCXJldHVybiBmd25vZGVfZ2V0
X25leHRfY2hpbGRfbm9kZShmd25vZGUtPnNlY29uZGFyeSwNCj4gY2hpbGQpOw0KPiAgfQ0KPiAg
RVhQT1JUX1NZTUJPTF9HUEwoZGV2aWNlX2dldF9uZXh0X2NoaWxkX25vZGUpOw0KPiANCj4gQEAg
LTc5OCw2ICs4MDUsOSBAQCBFWFBPUlRfU1lNQk9MX0dQTChmd25vZGVfaGFuZGxlX3B1dCk7DQo+
ICAgKi8NCj4gIGJvb2wgZndub2RlX2RldmljZV9pc19hdmFpbGFibGUoY29uc3Qgc3RydWN0IGZ3
bm9kZV9oYW5kbGUNCj4gKmZ3bm9kZSkNCj4gIHsNCj4gKwlpZiAoSVNfRVJSX09SX05VTEwoZndu
b2RlKSkNCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICAJaWYgKCFmd25vZGVfaGFzX29wKGZ3
bm9kZSwgZGV2aWNlX2lzX2F2YWlsYWJsZSkpDQo+ICAJCXJldHVybiB0cnVlOw0KPiANCj4gQEAg
LTk4OCwxNCArOTk4LDE0IEBAIGZ3bm9kZV9ncmFwaF9nZXRfbmV4dF9lbmRwb2ludChjb25zdA0K
PiBzdHJ1Y3QgZndub2RlX2hhbmRsZSAqZndub2RlLA0KPiAgCQlwYXJlbnQgPSBmd25vZGVfZ3Jh
cGhfZ2V0X3BvcnRfcGFyZW50KHByZXYpOw0KPiAgCWVsc2UNCj4gIAkJcGFyZW50ID0gZndub2Rl
Ow0KPiArCWlmIChJU19FUlJfT1JfTlVMTChwYXJlbnQpKQ0KPiArCQlyZXR1cm4gTlVMTDsNCj4g
DQo+ICAJZXAgPSBmd25vZGVfY2FsbF9wdHJfb3AocGFyZW50LCBncmFwaF9nZXRfbmV4dF9lbmRw
b2ludCwNCj4gcHJldik7DQo+ICsJaWYgKGVwKQ0KPiArCQlyZXR1cm4gZXA7DQoNCkkgbWlnaHQg
YmUgbWlzc2luZyBzb21ldGhpbmcgYnV0IGJlZm9yZSB0aGUgY2hlY2sgYmVpbmcgZG9uZSB3YXMN
CidpZiAoSVNfRVJSX09SX05VTEwoZXApJy4gSXMgdGhlcmUgYW55d2F5IGZvciBlcCB0byBiZSBh
biBlcnJvcg0KcG9pbnRlcj8gTG9va2luZyBhdCBPRiwgSXQgc2VlbXMgdGhhdCBvbmx5IE5VTEwg
b3IgYSB2YWxpZCBwb2ludGVyDQppcyBiZWluZyByZXR1cm5lZC4gRGlkIG5vdCBsb29rZWQgYXQg
b3RoZXJzIGltcGxlbWVudGF0aW9ucyBvZg0KdGhvdWdoLi4uDQoNCi0gTnVubyBTw6ENCg0K
