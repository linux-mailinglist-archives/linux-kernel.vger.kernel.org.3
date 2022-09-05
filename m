Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945DC5ACC1C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbiIEHSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbiIEHSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:18:17 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20711.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F82A4D263
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbKNf6q6NF+F6DU9r9pSvWs8je3QTt426mOl0cavC1KyHABvpfVpgY0iFJn3Nr3/haS9BkqEtcBAYyuN/g4h9bHM376FYHM0c2AbqoU6KRYdmm14KYP/zWRpX2e++IFPS9qBO3yM1++OadEM2x5/x1t8ov6zHQxPgBm6mdeUIZjI/lrLbeibvNStpKSffCtoj2S/uiNf4FDy7bVJnAqGsX9DPxUMUrOAZId2ae70vBZOgiouuZzx0dfoi38fMhbmXdREIv07i9OxDvWYo055Nysz+H2PRSLSkeM8Wums17W7JkVfxiTzWIpsKkD0lOmPUvwyER7RtlyGsoZHISF4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxrZ0YdD3UJbBIBaXUpw3YmdytIe6pFVqtVvyOAkGmk=;
 b=EiKobd/8nvPufj45dIrb+5OcEntOlxvgy4xWEMxwXZ535SLIjnkPOBMXF8PM94DNCz0h9AJHrLGnZGk5ykxZuxib6r2p4pJRIZfr/WdhccLXG2Fq0Q+9Vy2vqA9ayAjvEVtq5NLzda6e65zCeffA8/pIgraVLptmTLv8iKO9lyxzW1/V++1th0Sd1EtaCIdcJ4dKvvdxy+y/N0Ok8g+MuDePCleRF4NNLY3pK+jy/W0IYH2w0ynlL2S7dqZ5klMvcqj4IrUZP4mCBtCm1bMU0zx1975J/jcu4y0/2E23lVGXgRkKsafJOspYSdodWTPzyzjlBePQWt06eP1e6MNE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxrZ0YdD3UJbBIBaXUpw3YmdytIe6pFVqtVvyOAkGmk=;
 b=kts6NozTbX8NRPvKrFYu2vJMqjL+DuiYFWGTzQLqsyoqaIH3/DF9PvBqw9dCyjpCElsoSR4+5XMVbgP/B2FLNpvzFUwY7Q2d5sVGkvb7CXEldOzNYBF+1x2h8BbIxVV4DB5KdW8TVnrt1nGowLtNdVGaiSGP5Q12QxnObA/xlgrWdXm8oQq8d8Yp3gD6PMAF6CkywXdj+vQzQ2vPTuwCiw7iiLq+0jtsrbGF2l5UrWAUz56zSqXiha34KUKHPgktHCjJlMuvUsH7OmdpuqZywJ0j2xWfDmLuoWgItAxhsu1CSIQs8f3wag1L9pZ8PJCRG9NzyyLrL06FGsh5q5DhPQ==
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com (2603:1096:301:37::11)
 by TY0PR06MB5006.apcprd06.prod.outlook.com (2603:1096:400:1ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 07:12:02 +0000
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::5c66:2101:a7ac:8df0]) by PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::5c66:2101:a7ac:8df0%9]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 07:12:02 +0000
From:   =?utf-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
CC:     "zhaojunkui2008@126.com" <zhaojunkui2008@126.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGtlcm5lbC9zY2hlZDogZml4IEtNU0FOIHVuaW5p?=
 =?utf-8?Q?t-value_error?=
Thread-Topic: [PATCH] kernel/sched: fix KMSAN uninit-value error
Thread-Index: AQHYwNBwYwIEMRKPCUWw7v4rA8QeV63QY38AgAAHc2A=
Date:   Mon, 5 Sep 2022 07:12:01 +0000
Message-ID: <PSAPR06MB402186F56F858E16CB33081FDF7F9@PSAPR06MB4021.apcprd06.prod.outlook.com>
References: <20220905023715.1920088-1-bernard@vivo.com>
 <f16cd8cd-ce91-46a3-7180-855b762b34c0@bytedance.com>
In-Reply-To: <f16cd8cd-ce91-46a3-7180-855b762b34c0@bytedance.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c1be7f3-196f-463f-3cbe-08da8f0dee2f
x-ms-traffictypediagnostic: TY0PR06MB5006:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tfjto/XqqAJUNXzhYMofjvF+3V1pgU8hXcHhMWAMeVOcm8rsGvY+lBpHFO/EzpC+IBNqnGs98jafPjlWOxmfmk74UOcqLaJU9DGXwIr8UDhFGeuPbWRIPzEbI1W6kWmaBx2Ld+tnid0D/+Grj4PhuZxiu47KF8hCkSK1xsX8mLjSigjrfSres2fw7Vp1iCBpTn2ocPScf1gosFat5R4iyswOFdrOcDtO8fl3FGdU1KMfTMmSGxdLo7FrMskUBmiN+uQnj8kZwfdz+TK+LBBVu88gTyszUJ09RaH4eC/sd07WbTX/1TFQwT6HsKgDzV2cDUeKzYofb7uuqnDxctdPcPSX1F7q/ZJJqeDbcglrtu1cqGYgHp43tAYhe0zhgXw8C24hndc5p4Bgyx8HEvzyHyDNfJoTfvzibaLjacC008jETpNMk7SJu5+urlOoIevhIG4sDRZCa6TzXlicRoB/jzSce/srRxP+f+7kBL1ZazgBvSySQLChwl9O3jU9rGUunOO20u1bIbMA3n1S9bA5Xw4IZrf6H8y5ZmxBZwbJmoUcXhAoTqm5coH69htICj31gSJi8IA+Ul3+I0ua/n4nwWwrSxqUB/3g8kqu6wcyViCdoTuT/4ithB8cKw7XD2EUfXSQ7ZTs5+A9vz0dJXfvbVXu/09JHBk33iPO+pnLiycD5lt+nHoIl737nvTnJB793tUxiDWQjYoTZ5uvj9S/so2ORV7k9TUV6Db5nvtdaA+Zx+57u2PtZzvDKHpOxF8Zl5CRUvzLbpR+wZU+raWB9rd6QFotm3hqLfrJs81uMBl9kA/Ew+aYr7oVoCtQZaIZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4021.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(38070700005)(316002)(38100700002)(83380400001)(4326008)(66556008)(66476007)(66446008)(64756008)(76116006)(54906003)(55016003)(6916009)(66946007)(8936002)(7416002)(53546011)(9686003)(26005)(6506007)(122000001)(52536014)(186003)(5660300002)(2906002)(966005)(71200400001)(41300700001)(7696005)(478600001)(86362001)(224303003)(33656002)(85182001)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEhPVGxINnN4RXkzcWFFTzlOaU9iMnljT2Y0QTFENHIrZS9sVGpReVYzaDRX?=
 =?utf-8?B?ajRHVWVlTit3b2huT2R3WEFqNDIvWHk0emRSbDZ6SW5XY1Q5S08yUTBYM0Fz?=
 =?utf-8?B?OWtKekxMaUlvdXlLOEZxaFBLWnIrbFgxNkpzMG9oVVo3ZEpDUGQ1NnRLUUxQ?=
 =?utf-8?B?UjJkeTBUdCtpRWtDMVRmUnVqdm9TUHpDQWJCQjdyYlRwdTcvUGtLZG9EQXND?=
 =?utf-8?B?UjU5NklRTkQ1dU1Jd2Zpd0FPb1Y3TFFsSDA5c2t2ckdNS2FmUGwyNHRtRlh4?=
 =?utf-8?B?ZXR5UHJpeU9uYmUvZDJoZWVHM2dsS0dBY0R6cC9QL3N0RHRuZnUydmZ3TUlr?=
 =?utf-8?B?c216cEkxbTZJdjIvT2tiUkdlRVdrTHZhSksra2R1WWNBMzFLYktKSmgxd2lL?=
 =?utf-8?B?eVA3aEVzVDFDWUhSUURYMjU3U0FGYXBGRWVBcitmVVJERmFUYUdxQkFuK3h1?=
 =?utf-8?B?eHRqQXdvNXV6RllGaVRRWW9VbFM0dk9ZeGRpQkpzOFI5aUg0VXNYWUZYYXZD?=
 =?utf-8?B?SWo3MWVIQkZCNFplRHUvUEVPUFhoakczRi9CcEJ2cGZnWWpnU2hTVmRDeFE4?=
 =?utf-8?B?bGlhN212NWFKK1FGMEtHOFpQaXBwVi9Ld2oyTnVWeThLYUpjaCtDM1R2OG45?=
 =?utf-8?B?Ym1uTmdqOUdSS3o4V1F3WGdqS1MxUEF0c2M2QUJyVGFOY0lOcFpKRWtjU2RW?=
 =?utf-8?B?M2N1eWNBTXFDL1lMTnk5QTNEZXVXWVNSbWNhT0JEVXlLc1Z1a3Z1UkFSZHBo?=
 =?utf-8?B?NENFY0xGcExER2xWUVBsWVk0K1hMWFlGYkhHblE4VmxVMVZldDRaY2N3bzNJ?=
 =?utf-8?B?aDlTaklzZlFlNGlzMlRUQ3Y1NVg3UjFHb2ZUQlJRZjRBaDVpSnhtOHhLY1R2?=
 =?utf-8?B?NFZVN0RqVzhqekZWdm5Ncm1PR2VzbWI5OWVJZUUreFJuMWZES0NlcE1JV0dG?=
 =?utf-8?B?UmlocnRDb3VTNHZ3Ukt0ZGVlbitLc0ZiTkxDWVRWTFQyblhJNXgwS0EwSmtD?=
 =?utf-8?B?YXFqeTI4ckZZS05qWE9NSU1SdHJYaFZad0tYVk52NTA5Tm9LcW8yQlh3WXUr?=
 =?utf-8?B?SEJCZ0JsZzVHSlZqOWxvT2NFMWpkcU53cGRDL1BZci9HaUM4a3REbHZ3VHFa?=
 =?utf-8?B?WHNpdEowRGh3VnA4TkYzbU5XV211Qzhpc3puaWw5YTM4Sjg1Y29leDdHeHJT?=
 =?utf-8?B?emRlY1RMQXBYemllRkQwNzFha0R1QTlCcmpTN0laVy96MjU3VFhBT2tkS05N?=
 =?utf-8?B?enJoSjAwQXlhRFdoU2dHQ2hid2lLQVNCSnVncEZwSmJxcWZkeGpILzdNOUJo?=
 =?utf-8?B?eG1iQ1FWc0pXbVo2a3l3cENnTjBmT0VUWlhJMVVsU09XdkdHNWhtVi8yblc5?=
 =?utf-8?B?b2xXY2lhN3YvUmg1WG5Fc2R1RXRQNWVRZTExMlQ5N0l4N0hDRE56V09qMDIr?=
 =?utf-8?B?OG4xVWNSL3RrRkZ3OXZBbzVid0tGTkdoWnFzeVk3dmxiTlpwUUNMSW12WWU0?=
 =?utf-8?B?TGQ2QWd4VENRcXRlb3VCVHo0QVBPUW9wYmNxYS9pWlRocUFMYWIraFM3WWdi?=
 =?utf-8?B?WHRjaGlQbkl5WE5Rbnl0Q01PK3ByeUhGZmZnZ0xQNjd6U21Rck1KN09MdnNh?=
 =?utf-8?B?WURBY3p3ajdRSmxsRFZ0QlZMZUVxM00zSXltUkNtT1VGWE5sdE41VDFtZENw?=
 =?utf-8?B?Zm52NE5rTXlCZ1Z2aFFydVJUQ2lIUHpOTC9jWWhKSUg0Q0wyazFLUjhPWkIv?=
 =?utf-8?B?bXVIRThHWEZkR2h1NlJKQk0zSS9zY3lKdko3UDhkZVZHQ01sSG1OenpMcDJh?=
 =?utf-8?B?RHZYakdDOWd4LzdYeCtPaTZXYXBEWEhqOHJSMDM4Qms1RkdvREUwcmNkdURt?=
 =?utf-8?B?MnJITGZxbC92dnloYUNVUTJNOS8xT2xRT3pHams2a0xGM2ZaMnNGY20zOUhU?=
 =?utf-8?B?RGk4OUw3YWxjdVVhOStRaGRRRUhJM1h5S3R4VWRLU0VxbjI3YkRUczRjTmN1?=
 =?utf-8?B?OEdoN20yT0crRUl5ZU9TR1BZeTVjeWttWkxjYUIrMkY1cUJYTmMvbVAzUzUv?=
 =?utf-8?B?SjRiT2hVQlZnRFIrU2x4UlZySDJZdEpReE54WWh2YmlvQjBLYkIwK1ZXRXpn?=
 =?utf-8?Q?l7bs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4021.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1be7f3-196f-463f-3cbe-08da8f0dee2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 07:12:01.9297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1iUES5l9AkjD99h7nzdPCbaGEJBsz8AvhQCkot1qKK+Uvd32SFs+OobHWTbk9ocIZS6FmgYW+YfMB2+lAqRjJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hlbmdtaW5nOg0KDQpGb3IgS01TQU4gaXNzdWUsIHN5emJvdCBkb2VzIG5vdCBzdXBwb3J0
IHBhdGNoIHZlcmlmaWNhdGlvbiBmcm9tIExpbnV4LW1haW4gb3IgTGludXgtbmV4dCBicmFuY2gu
DQpDdXJyZW50bHksIG9ubHkgR29vZ2xlJ3Mgb3duIGttc2FuLmdpdCBjYW4gYmUgdXNlZCBmb3Ig
S01TQU4gaXNzdWVgcyB2ZXJpZmljYXRpb24uIFRoZSB3YXJuaW5nIGxpa2UgdGhpczoNCktNU0FO
IGJ1Z3MgY2FuIG9ubHkgYmUgdGVzdGVkIG9uIGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUva21z
YW4uZ2l0IHRyZWUgYmVjYXVzZSBLTVNBTiB0b29sIGlzIG5vdCB1cHN0cmVhbWVkIHlldC4NClNl
ZSBodHRwczovL2dvby5nbC90cHNtRUoja21zYW4tYnVncyBmb3IgZGV0YWlscy4NCg0KSXQgc2Vl
bXMgdGhhdCBHb29nbGUncyBjb2RlIGhhcyBub3Qgc3luYyB3aXRoIHRoZSBsYXRlc3QgY29kZSBv
ZiBMaW51eC1uZXh0Lg0KVGhpcyBwYXRjaCBkb2Vzbid0IHNlZW0gdG8gYmUgbmVlZGVkIGlmIHRo
ZSBjb21taXQgMmI5N2NmNzYyODlhIGhhcyBiZWVuIHN1Ym1pdHRlZCwgdGhhbmtzIQ0KDQpCUi8v
QmVybmFyZA0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IENoZW5nbWluZyBa
aG91IDx6aG91Y2hlbmdtaW5nQGJ5dGVkYW5jZS5jb20+IA0K5Y+R6YCB5pe26Ze0OiAyMDIy5bm0
OeaciDXml6UgMTQ6NDINCuaUtuS7tuS6ujog6LW15Yab5aWOIDxiZXJuYXJkQHZpdm8uY29tPg0K
5oqE6YCBOiB6aGFvanVua3VpMjAwOEAxMjYuY29tOyBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0Bj
bXB4Y2hnLm9yZz47IFN1cmVuIEJhZ2hkYXNhcnlhbiA8c3VyZW5iQGdvb2dsZS5jb20+OyBJbmdv
IE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFk
ZWFkLm9yZz47IEp1cmkgTGVsbGkgPGp1cmkubGVsbGlAcmVkaGF0LmNvbT47IFZpbmNlbnQgR3Vp
dHRvdCA8dmluY2VudC5ndWl0dG90QGxpbmFyby5vcmc+OyBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0
bWFyLmVnZ2VtYW5uQGFybS5jb20+OyBTdGV2ZW4gUm9zdGVkdCA8cm9zdGVkdEBnb29kbWlzLm9y
Zz47IEJlbiBTZWdhbGwgPGJzZWdhbGxAZ29vZ2xlLmNvbT47IE1lbCBHb3JtYW4gPG1nb3JtYW5A
c3VzZS5kZT47IERhbmllbCBCcmlzdG90IGRlIE9saXZlaXJhIDxicmlzdG90QHJlZGhhdC5jb20+
OyBWYWxlbnRpbiBTY2huZWlkZXIgPHZzY2huZWlkQHJlZGhhdC5jb20+OyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQrkuLvpopg6IFJlOiBbUEFUQ0hdIGtlcm5lbC9zY2hlZDogZml4IEtN
U0FOIHVuaW5pdC12YWx1ZSBlcnJvcg0KDQpbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9t
IHpob3VjaGVuZ21pbmdAYnl0ZWRhbmNlLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50
IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQoNCk9u
IDIwMjIvOS81IDEwOjM3LCBCZXJuYXJkIFpoYW8gd3JvdGU6DQo+IFRoaXMgcGF0Y2ggdHJ5IHRv
IGZpeCBzeXpib3QgZXJyb3I6DQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQo+IEJVRzogS01TQU46IHVuaW5pdC12YWx1ZSBpbiB1cGRhdGVf
dHJpZ2dlcnMga2VybmVsL3NjaGVkL3BzaS5jOjUyNSANCj4gW2lubGluZV0NCj4gQlVHOiBLTVNB
TjogdW5pbml0LXZhbHVlIGluIHBzaV9wb2xsX3dvcmsga2VybmVsL3NjaGVkL3BzaS5jOjYyNiAN
Cj4gW2lubGluZV0NCj4gQlVHOiBLTVNBTjogdW5pbml0LXZhbHVlIGluIHBzaV9wb2xsX3dvcmtl
cisweDk3Mi8weDE2YTAgDQo+IGtlcm5lbC9zY2hlZC9wc2kuYzo2NDgNCg0KSGVsbG8sDQoNCkRp
ZCB5b3UgdGVzdCB3aXRoIHRoZSBsYXRlc3QgUFNJIGNvZGUgdXNpbmcgbGludXgtbmV4dCBicmFu
Y2ggdGhhdCBpbmNsdWRlIHRoZSBjb21taXQgMmI5N2NmNzYyODlhICgic2NoZWQvcHNpOiBaZXJv
IHRoZSBtZW1vcnkgb2Ygc3RydWN0IHBzaV9ncm91cCIpPw0KDQpUaGFua3MuDQoNCg0KPiAgdXBk
YXRlX3RyaWdnZXJzIGtlcm5lbC9zY2hlZC9wc2kuYzo1MjUgW2lubGluZV0gIHBzaV9wb2xsX3dv
cmsgDQo+IGtlcm5lbC9zY2hlZC9wc2kuYzo2MjYgW2lubGluZV0NCj4gIHBzaV9wb2xsX3dvcmtl
cisweDk3Mi8weDE2YTAga2VybmVsL3NjaGVkL3BzaS5jOjY0OA0KPiAga3RocmVhZCsweDMxYi8w
eDQzMCBrZXJuZWwva3RocmVhZC5jOjM3Ng0KPiAgcmV0X2Zyb21fZm9yaysweDFmLzB4MzANCj4N
Cj4gVW5pbml0IHdhcyBzdG9yZWQgdG8gbWVtb3J5IGF0Og0KPiAgY29sbGVjdF9wZXJjcHVfdGlt
ZXMrMHgxOTNkLzB4MTlhMCBrZXJuZWwvc2NoZWQvcHNpLmM6MzU1ICANCj4gcHNpX3BvbGxfd29y
ayBrZXJuZWwvc2NoZWQvcHNpLmM6NjA0IFtpbmxpbmVdDQo+ICBwc2lfcG9sbF93b3JrZXIrMHg1
ODcvMHgxNmEwIGtlcm5lbC9zY2hlZC9wc2kuYzo2NDgNCj4gIGt0aHJlYWQrMHgzMWIvMHg0MzAg
a2VybmVsL2t0aHJlYWQuYzozNzYNCj4gIHJldF9mcm9tX2ZvcmsrMHgxZi8weDMwDQo+DQo+IFVu
aW5pdCB3YXMgc3RvcmVkIHRvIG1lbW9yeSBhdDoNCj4gIGNvbGxlY3RfcGVyY3B1X3RpbWVzKzB4
MTkzZC8weDE5YTAga2VybmVsL3NjaGVkL3BzaS5jOjM1NSAgDQo+IHBzaV9wb2xsX3dvcmsga2Vy
bmVsL3NjaGVkL3BzaS5jOjYwNCBbaW5saW5lXQ0KPiAgcHNpX3BvbGxfd29ya2VyKzB4NTg3LzB4
MTZhMCBrZXJuZWwvc2NoZWQvcHNpLmM6NjQ4DQo+ICBrdGhyZWFkKzB4MzFiLzB4NDMwIGtlcm5l
bC9rdGhyZWFkLmM6Mzc2DQo+ICByZXRfZnJvbV9mb3JrKzB4MWYvMHgzMA0KPg0KPiBVbmluaXQg
d2FzIHN0b3JlZCB0byBtZW1vcnkgYXQ6DQo+ICBjb2xsZWN0X3BlcmNwdV90aW1lcysweDE5M2Qv
MHgxOWEwIGtlcm5lbC9zY2hlZC9wc2kuYzozNTUgIA0KPiBwc2lfcG9sbF93b3JrIGtlcm5lbC9z
Y2hlZC9wc2kuYzo2MDQgW2lubGluZV0NCj4gIHBzaV9wb2xsX3dvcmtlcisweDU4Ny8weDE2YTAg
a2VybmVsL3NjaGVkL3BzaS5jOjY0OA0KPiAga3RocmVhZCsweDMxYi8weDQzMCBrZXJuZWwva3Ro
cmVhZC5jOjM3Ng0KPiAgcmV0X2Zyb21fZm9yaysweDFmLzB4MzANCj4NCj4gVW5pbml0IHdhcyBj
cmVhdGVkIGF0Og0KPiAgc2xhYl9wb3N0X2FsbG9jX2hvb2sgbW0vc2xhYi5oOjczMiBbaW5saW5l
XSAgc2xhYl9hbGxvY19ub2RlIA0KPiBtbS9zbHViLmM6MzI1OCBbaW5saW5lXSAgc2xhYl9hbGxv
YyBtbS9zbHViLmM6MzI2NiBbaW5saW5lXQ0KPiAga21lbV9jYWNoZV9hbGxvY190cmFjZSsweDY5
Ni8weGRmMCBtbS9zbHViLmM6MzI5NyAga21hbGxvYyANCj4gaW5jbHVkZS9saW51eC9zbGFiLmg6
NjAwIFtpbmxpbmVdDQo+ICBwc2lfY2dyb3VwX2FsbG9jKzB4ODMvMHgyNTAga2VybmVsL3NjaGVk
L3BzaS5jOjk2MCAgY2dyb3VwX2NyZWF0ZSANCj4ga2VybmVsL2Nncm91cC9jZ3JvdXAuYzo1NDMw
IFtpbmxpbmVdDQo+ICBjZ3JvdXBfbWtkaXIrMHgxMGEzLzB4MzA4MCBrZXJuZWwvY2dyb3VwL2Nn
cm91cC5jOjU1NTANCj4gIGtlcm5mc19pb3BfbWtkaXIrMHgyYmEvMHg1MjAgZnMva2VybmZzL2Rp
ci5jOjExODUNCj4gIHZmc19ta2RpcisweDYyYS8weDg3MCBmcy9uYW1laS5jOjQwMTMNCj4gIGRv
X21rZGlyYXQrMHg0NjYvMHg3YjAgZnMvbmFtZWkuYzo0MDM4ICBfX2RvX3N5c19ta2RpcmF0IA0K
PiBmcy9uYW1laS5jOjQwNTMgW2lubGluZV0gIF9fc2Vfc3lzX21rZGlyYXQgZnMvbmFtZWkuYzo0
MDUxIFtpbmxpbmVdDQo+ICBfX3g2NF9zeXNfbWtkaXJhdCsweGM0LzB4MTIwIGZzL25hbWVpLmM6
NDA1MQ0KPiAgZG9fc3lzY2FsbF94NjQgYXJjaC94ODYvZW50cnkvY29tbW9uLmM6NTAgW2lubGlu
ZV0NCj4gIGRvX3N5c2NhbGxfNjQrMHgzZC8weGIwIGFyY2gveDg2L2VudHJ5L2NvbW1vbi5jOjgw
ICANCj4gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NjMvMHhjZA0KPg0KPiBzeXpi
b3QgbGluazoNCj4gaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2lkPWQwNGM1NDA3
MjA3ZDExZTQ2MDA3Nzc1NTE3Yjk3NzY0MQ0KPiA3NGJjNDVkDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IEJlcm5hcmQgWmhhbyA8YmVybmFyZEB2aXZvLmNvbT4NCj4gLS0tDQo+ICBrZXJuZWwvc2NoZWQv
cHNpLmMgfCAzICsrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL3BzaS5jIGIva2VybmVsL3NjaGVkL3BzaS5jIGluZGV4
IA0KPiBlY2I0YjRmZjRjZTAuLjQ2ZjA0ODEyMTUyMCAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3Nj
aGVkL3BzaS5jDQo+ICsrKyBiL2tlcm5lbC9zY2hlZC9wc2kuYw0KPiBAQCAtMTk1LDYgKzE5NSw5
IEBAIHN0YXRpYyB2b2lkIGdyb3VwX2luaXQoc3RydWN0IHBzaV9ncm91cCAqZ3JvdXApDQo+ICAg
ICAgIGluaXRfd2FpdHF1ZXVlX2hlYWQoJmdyb3VwLT5wb2xsX3dhaXQpOw0KPiAgICAgICB0aW1l
cl9zZXR1cCgmZ3JvdXAtPnBvbGxfdGltZXIsIHBvbGxfdGltZXJfZm4sIDApOw0KPiAgICAgICBy
Y3VfYXNzaWduX3BvaW50ZXIoZ3JvdXAtPnBvbGxfdGFzaywgTlVMTCk7DQo+ICsgICAgIG1lbXNl
dChncm91cC0+YXZnX3RvdGFsLCAwLCBzaXplb2YoZ3JvdXAtPmF2Z190b3RhbCkpOw0KPiArICAg
ICBtZW1zZXQoZ3JvdXAtPnRvdGFsLCAwLCBzaXplb2YoZ3JvdXAtPnRvdGFsKSk7DQo+ICsgICAg
IG1lbXNldChncm91cC0+YXZnLCAwLCBzaXplb2YoZ3JvdXAtPmF2ZykpOw0KPiAgfQ0KPg0KPiAg
dm9pZCBfX2luaXQgcHNpX2luaXQodm9pZCkNCg==
