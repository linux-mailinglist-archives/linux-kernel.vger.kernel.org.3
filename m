Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E881508353
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376708AbiDTIZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376703AbiDTIZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:25:45 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC8524F19;
        Wed, 20 Apr 2022 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650442980; x=1681978980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QbNJ818p6CYy4l3TxWr5ZqC9FZnvam+uP5tfrVIpQag=;
  b=k0ghTobovvL4vYqGma/3GRhzJ4Rv2wbjI3skfg5OAnssN6/6FXFDD0mv
   KwhPex/yDmTKSK8fbIKzzQaG5+vzcmWCzHEATn2Xnz+VYeTP79691fMzU
   5HN4tN21zg6cklN5ZzptZkGbxCgT9fTOjwF3MVlX7DbrQMSmk2Bq2uCdC
   7yf4VO9GVFz91rMXGS96Z55/eXyyiL3rSDKLVVLHHXMqzIpMWOMaFu/8Z
   WF+O4YrWN/ibUiG1tAjo/a/AcuTbFmvmr8lHEhz+IVN2RkXpCP/fwjJWl
   upjJOhJurebDDhrojUyP7kR9vfzFBAOd+aaYsJQMWlDWiaIU/JGhrQMYe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="54374755"
X-IronPort-AV: E=Sophos;i="5.90,275,1643641200"; 
   d="scan'208";a="54374755"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 17:22:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qmrz7WfMbnNbJ93ThUSUxzhKx/nhXu299VSS1BDkvRUEv24FfrabQ/9k9jIpxP2MQDcI9eI0+9gzZD/wdheAGwaSznDyXjfvhJcNzRCAsRO/+B0rqjdB0P+H2L1y9VyUkHc/hJ5XEoAJuOqOlgvxc+/5/dfmTeN/jaLSoIobA7Va4128tZbfohE6oGaKpPOEziS6nwewJr8P+pTjysJHZOQpSGpiWMBetTB5P5iSfkoOSfs9XkP91KQ9XTRhifB64qm0XDtJmjuesKXEYhHF6b1Ego3UkjbnHrSX1Y/VcKgkagmmYKdzkCqQcZgyV3xsuHY1fpqa+7qYT5HD1Z+X+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzH1haAlG26O3F717sEjHt9ig1VOd0GT3ub1XYDlFqc=;
 b=YQ1UAWnyAa4mNG6lLr40r+Qg0CryzHwDvGQUyWuuKj75hiB5KWANYeXeYCk2fgTjh9PvGroECAykDKGkCz+oWSS0J8JDmiDYVLOK7yV9SmMxb357qRCZ/+dI4Hq8SQigh4gaPX0i3CLd8HvBQLJVSQ+F+U5EkncjUUPfY8ycM4uppVeIGJWD0ExQIGp/C6LvaW5aSQHpZ6NY+OAzxzl1+eqQbqP8W3T6/dybIzRWunnZ3KB/G6/hFlu4WDW2UmdRPZXavZvcPFLy7QEiT0KsFlNJaRhbc7CTnpyPBcjEFzYW1oNId7OHK+/eUTp/72/GwQn6nLovpt8DpZQddgfO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzH1haAlG26O3F717sEjHt9ig1VOd0GT3ub1XYDlFqc=;
 b=fRosNwhVyjnwXdeOa6JyKyQAtOycd98VFpZiAf2MCQ/ZReu/IZsblaqRRr0AGihRgE+XSovNAFLj2+oayp2d33sJeH9ebc9bT71P966XDA1Z2AcFEgpTP1WKXHww3I8q86FqJRAPMzCyACOL4YuYNrUIRmOyDrrW3pkr5juzQt8=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by TYCPR01MB8037.jpnprd01.prod.outlook.com (2603:1096:400:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 08:22:50 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::a482:1e91:f470:a5a0]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::a482:1e91:f470:a5a0%3]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 08:22:50 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     'Jiri Olsa' <olsajiri@gmail.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: [RFC PATCH v2 0/7] libperf: Add interface for overflow check of
 sampling events
Thread-Topic: [RFC PATCH v2 0/7] libperf: Add interface for overflow check of
 sampling events
Thread-Index: AQHYRD0ckzCCT80/f0C9G/z6axerk6zqcc3QgA1aDoCAAModkA==
Date:   Wed, 20 Apr 2022 08:22:50 +0000
Message-ID: <OSBPR01MB4600730F77F5D2E5EA009227F7F59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
 <YkRgDdI8PKH5C7lV@krava>
 <OSBPR01MB460012B9516B2E67CBEEF0B1F7EA9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <Yl8YTSXiC0yP4N3+@krava>
In-Reply-To: <Yl8YTSXiC0yP4N3+@krava>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b57cb02-083c-492d-5732-08da22a6f58e
x-ms-traffictypediagnostic: TYCPR01MB8037:EE_
x-microsoft-antispam-prvs: <TYCPR01MB80372D75ED006F8686EE6429F7F59@TYCPR01MB8037.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7LWMYf7dCs3CGizobEx3qtds25GfuN4dfmhPfjhoZxPinybA9lF2YmOg3b2s3tpfDnhInYZlVV+zCPnlf2Ho5pAAbGbXdTKF0/OvZFLb/izp4Tz94HdZnDayxLD7ScVQYz+MHEVgXnlnVOVmoqjql0iTRii7QDAnzz5EP+VIkYKCV9eRSojUjA8QKZTzNOOGSpYff552t4kpZx8xEQ6dFqovwWPDo8KiO1nRo5lQPMJKVzuiXRdzpREwBPNdKG71iUva54NJQNEpJcTAlTgufjUXF6e/eJYkqSLvHwSbOcnDiFbucJSxx0ErwOWqFKeFt7WA7nGTDjPy0hTNhR+hdRZfa/LPmAlIb58RfPFLNVq5CeYg46zcGrIBpObvSPlvK11x7A08qAeLBzICQjtJAzWW53MrJRNZ4MYHptoJ67NTlLdPG7KD9mM9VeniGJgKfSg/t+Ax/spvpoTj4o13QzHt1HeJxNngoqLAL5UCd3S21qb9qKVKfroZR/AjmU+Ys+aMLbC8xqzy+A4d46NmhZCA2yWiKTLMpaet0viEmrX/ALO3blux3JtXVPeO29QLA38SLSSBNjL2x2dFl3VzUYifSo3bfDxXioYZ8nz3LpDR8LdcXBJ4o2PwSBAG8fAmVz0aRY3gs0gHdGourTcjN3jYq7rBckY2f+g9+sCvXIFCL807syS13G32My2v6VE78pDjx3eZrmUXIk41SdkW5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(122000001)(54906003)(6916009)(76116006)(508600001)(52536014)(66946007)(85182001)(186003)(55016003)(71200400001)(86362001)(64756008)(66556008)(66446008)(66476007)(38070700005)(6506007)(5660300002)(4326008)(2906002)(7696005)(7416002)(83380400001)(38100700002)(9686003)(26005)(8676002)(33656002)(316002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?K1czR204Z0xJSzJJQ3FSU2tnaWthaTRsbnRkeEphL016NUd0ZUUxeDZj?=
 =?iso-2022-jp?B?QmFuRnZyWDZ2MmdKUDg3eGlVdm1xVlJMUWpUVW1iVlR2dVVCRHd0OUg1?=
 =?iso-2022-jp?B?enJHT2ZZN280S2NVWjZkNjJlcC83MDQxZHRWZTZmeUh0dVhnK2xsUExk?=
 =?iso-2022-jp?B?dzY2dklZODRRTTJjNXdNaFZVVmlIZVJtT0FTTTRWaVR0R0hEQnhSeUYz?=
 =?iso-2022-jp?B?MWlFVFh2K2R4RTlJcGdyMXNZdjVrTnYxRHZhT29rSzRiV2ZtbkVsdFJi?=
 =?iso-2022-jp?B?Szg2ZDgyaHpvQ2E1dnJIaEJiR0hkUXgrOUdlQWtCcVhCTnlZbnhuUnFv?=
 =?iso-2022-jp?B?Z1p1QWc4VUN5VkFNUUIvNmV0Y0ZVWTFkZkZtMWRWZmVpaE9mMm5MbzZJ?=
 =?iso-2022-jp?B?cGRjQUJKMTFYeTFYZlR3S1VWNG1Sc2V1azNxaThHNGVGLzgybDRjSVp4?=
 =?iso-2022-jp?B?MmEzdXFMVGJ1TUFGT1dtMjRJM0JacmhuWGQ4YUtKdXdRWjIwVDJVK0RH?=
 =?iso-2022-jp?B?SVN6U2pvRTB3c1UwcWtHQUE2LzcyclhZa1NFU1FIN0w1VERDeUhTczFZ?=
 =?iso-2022-jp?B?THBsSjV3U3h6aW9aSUF2dXdGN0JLZ2QwT3Y1VXB6MFBSTFdLdTFVZnNq?=
 =?iso-2022-jp?B?S0lNajYzQ1A4V2UyeE9WRFJXeVJYZGRsN2U2akhITjlmLzlkZUZseG5P?=
 =?iso-2022-jp?B?Mjc0MHUrekxRc292M1NnVDhrTllNOW1WSkphR0F0VkhrcFZqYVJzaHMv?=
 =?iso-2022-jp?B?VlpBbDRIdjRHNCtLVGUyRFEzcnF3RUhyOHMzdnpWbERuR1hseHd5TC9y?=
 =?iso-2022-jp?B?U0pJS1NGUUtLZ1ozZVYva2FTZ0lVZnNrMXo1aVpFeDVWeW8reGhYbS9r?=
 =?iso-2022-jp?B?YVRJQjFzdjJaT2lXdjRhVjcwQjQvYjNETlowSDJ0RE9Jb3krbEx4OXJ4?=
 =?iso-2022-jp?B?UU1zajg2UlI1Sys0WTAyc2V2TVJYbmhMZVNIUkNwekpOcXl6ek82YnhP?=
 =?iso-2022-jp?B?dXRJemtnbDdrY0RGTXErSEpvV2I4UTFnUmREdGV0Y0JBZjg2Y2dCUDZO?=
 =?iso-2022-jp?B?dHZkd1hyWDdKREhuMWNYVmt2Zlp6aDk3NnVNUTZ6YWlidUlUTlJXRnph?=
 =?iso-2022-jp?B?WHVDU3laK2k2MExqU2VZVVkyaXBINDNrTDlJaTQ3T05HTGFzTzNCdWdy?=
 =?iso-2022-jp?B?aWJzQlN0WVo5bFIvRndGRUxXdmUxZW1BTkVDY2ltYldTL2NnSEZraEVK?=
 =?iso-2022-jp?B?YlAreXd6bTl5WGVlb3JUUERjZGp4cmFEVVoyR1VzTVNDRjFQMmdnWmZH?=
 =?iso-2022-jp?B?WlpudUxvYjQxYzdmNlZ6TU5Qc3k1Zk5ndkplRVNyS1o1MGRoQWZUblBS?=
 =?iso-2022-jp?B?WmkwQWQvWTRIdENNcnRkamEvYXZMQ1BEeHNvWVlpQnhzSnA1ZXFkWXY4?=
 =?iso-2022-jp?B?MkNzV1d6YzRzUHVuaGQ2RXlFVmVFRlZZSzhDa3Z6dEcraS80QWJqUmhp?=
 =?iso-2022-jp?B?S3M3d09tejNHa1ZUbXIrSGx5Zzd2SHpiSEZWTzB5bHA5UWFQRkJiUDhN?=
 =?iso-2022-jp?B?S0VLOU5TMGlVdGI2M3ZDRWlqMERueXNWa29hY2RWa0s1SzE2Q24vSldi?=
 =?iso-2022-jp?B?djBzMjZKN09VNW81UjJzQ3FCdlBIQVExaCthZmRJV2QwUStWWU5vN09F?=
 =?iso-2022-jp?B?ek0zdHNUcEN1U3BHdTA0cjZmT3VmZ1EwWUViMzlhY2daalhwUXJmMkhk?=
 =?iso-2022-jp?B?cHhRcTNBRVhRei85RGUzSmtRU002TUR6ZUcwbzFWMDJiZGlzM05URFFk?=
 =?iso-2022-jp?B?R0xGdGdzSDJ0ZXpsTThnaGlJSmVnWWUwRDNEMnFJZm5pY0MyVkQ0azdG?=
 =?iso-2022-jp?B?Y0hhcUxpdU5FK2Y4c291RWpPOGtYN0tzVTU3RERtRTJ3czduOW1hLzVC?=
 =?iso-2022-jp?B?NDRWU1h2dFIzTUE5TFczaTA3cjFETmZyMGtvMlowRXV5MnVlaDVOYU9H?=
 =?iso-2022-jp?B?K1JJdDBuQWI5Z3IrYWZwUllRK0xvcFUwVWJsWEtqeFh0WlhrOWNsU1Qx?=
 =?iso-2022-jp?B?S3Bzeld3MFZmQnhnYnNqRkZLZ0lONnlaL1h3dGZMSklmclhwdW9sUitH?=
 =?iso-2022-jp?B?aHhKdlIzNkc1WkZkaFJwdEFGVldXV3FOQVFKTjRrNUhPU3V4b1pRWE5o?=
 =?iso-2022-jp?B?NVFxYWRsTVFVeVk1ajlOYzRDeHBTOCtoOXE2MHdvUStUOGVBYjE0LzNs?=
 =?iso-2022-jp?B?eEJtclQwdGRIZDFmMHJWaXJyN3hZTWxMZ1RWZjFlYjR5QUxlTW1IRHlJ?=
 =?iso-2022-jp?B?NWdiMFRoRVp2eEwzY2l0TjFDM2pFazZiOHJuaG82VkMrRGxCd2ZFY1dL?=
 =?iso-2022-jp?B?cXowVTJmbTJlS0ZZWGpoMG03Mm1pa0dvajRqbmdFWTV0aXBDdy9tSnlE?=
 =?iso-2022-jp?B?RWJ5bFBpMHBTZDhyaW1WZkI4U2tzWmJRd2VIcE12WG9LUWc0blg0MGxo?=
 =?iso-2022-jp?B?ZVpFSGxra3lwQVdIWGl5WXRVaFJ3U3piRlZRZG5IY2dKaXZWRFVKbGM5?=
 =?iso-2022-jp?B?TjYvYWx3Zz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b57cb02-083c-492d-5732-08da22a6f58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 08:22:50.5227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ME0zQJEBBk0wolmCRgfX9gDGA1yRCgogF4bGUyM+Ubdy0BqgP0NjWJmQIdq1qlh8lUAMS4AI10dSiVrLqkcowKUAsenZ7nCtnHveC3+zQ5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8037
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi jirka

> On Mon, Apr 11, 2022 at 08:23:54AM +0000, nakamura.shun@fujitsu.com wrote=
:
> > Hi jirka
> >
> > Sorry for the late reply.
> >
> > > >
> > > > Shunsuke Nakamura (7):
> > > >   libperf tests: Fix typo in the error message
> > > >   libperf: Move 'open_flags' from tools/perf to evsel::open_flags
> > > >   libperf: Add perf_evsel__{refresh, period}() functions
> > > >   libperf: Introduce perf_{evsel, evlist}__open_opt with extensible
> > > >     struct opts
> > > >   libperf: Add perf_evsel__check_overflow() functions
> > > >   libperf test: Add test_stat_overflow()
> > > >   libperf test: Add test_stat_overflow_event()
> > >
> > > I'm getting:
> > >
> > > [root@krava perf]# make tests
> > > running static:
> > > - running tests/test-cpumap.c...OK
> > > - running tests/test-threadmap.c...OK
> > > - running tests/test-evlist.c...OK
> > > - running tests/test-evsel.c...FAILED tests/test-evsel.c:286 failed
> > > to overflow count FAILED tests/test-evsel.c:286 failed to overflow co=
unt
> > >   FAILED (2)
> > > FAILED tests/main.c:13 test evsel
> > > make: *** [Makefile:162: tests] Error 255
> > >
> > Thanks for telling me.
> > However, we could not reproduce the test failure in our environment.
> > Could you please tell me the results of your test with the addition of =
V=3D1?
>=20
> sorry, forgot to answer this one..
>=20
Thanks for the information.


> [root@krava perf]# LD_LIBRARY_PATH=3D. ./tests-shared -v
> - running tests/test-cpumap.c...OK
> - running tests/test-threadmap.c...OK
> - running tests/test-evlist.c...
> Event  0 -- Raw count =3D 231217013, run =3D 10196083, enable =3D 2218309=
1
>          Scaled count =3D 503046909 (45.96%, 10196083/22183091) Event  1 =
--
> Raw count =3D 247219790, run =3D 10946246, enable =3D 22182044
>          Scaled count =3D 500979080 (49.35%, 10946246/22182044) Event  2 =
--
> Raw count =3D 268999685, run =3D 11943490, enable =3D 22180868
>          Scaled count =3D 499573115 (53.85%, 11943490/22180868) Event  3 =
--
> Raw count =3D 291383974, run =3D 12941069, enable =3D 22179798
>          Scaled count =3D 499405241 (58.35%, 12941069/22179798) Event  4 =
--
> Raw count =3D 314293846, run =3D 13938576, enable =3D 22178649
>          Scaled count =3D 500095052 (62.85%, 13938576/22178649) Event  5 =
--
> Raw count =3D 337393782, run =3D 14935798, enable =3D 22177192
>          Scaled count =3D 500974014 (67.35%, 14935798/22177192) Event  6 =
--
> Raw count =3D 360218294, run =3D 15933314, enable =3D 22175507
>          Scaled count =3D 501340982 (71.85%, 15933314/22175507) Event  7 =
--
> Raw count =3D 365516630, run =3D 16179860, enable =3D 22173686
>          Scaled count =3D 500922194 (72.97%, 16179860/22173686) Event  8 =
--
> Raw count =3D 365180177, run =3D 16178058, enable =3D 22171705
>          Scaled count =3D 500472130 (72.97%, 16178058/22171705) Event  9 =
--
> Raw count =3D 341205844, run =3D 15233252, enable =3D 22169603
>          Scaled count =3D 496571454 (68.71%, 15233252/22169603) Event 10 =
--
> Raw count =3D 318204949, run =3D 14234754, enable =3D 22167081
>          Scaled count =3D 495524887 (64.22%, 14234754/22167081) Event 11 =
--
> Raw count =3D 296671131, run =3D 13236210, enable =3D 22164791
>          Scaled count =3D 496792783 (59.72%, 13236210/22164791) Event 12 =
--
> Raw count =3D 276639189, run =3D 12237128, enable =3D 22162629
>          Scaled count =3D 501020477 (55.22%, 12237128/22162629) Event 13 =
--
> Raw count =3D 255437518, run =3D 11238588, enable =3D 22160497
>          Scaled count =3D 503677361 (50.71%, 11238588/22160497) Event 14 =
--
> Raw count =3D 232427791, run =3D 10239844, enable =3D 22158353
>          Scaled count =3D 502958545 (46.21%, 10239844/22158353)
>    Expected: 500221918
>    High: 503677361   Low:  231217013   Average:  500223614
>    Average Error =3D 0.00%
> Event  0 -- overflow flag =3D 0x1, POLL_UP =3D 1, other signal event =3D =
0 Event  1 --
> overflow flag =3D 0x2, POLL_UP =3D 1, other signal event =3D 0 Event  2 -=
- overflow
> flag =3D 0x4, POLL_UP =3D 1, other signal event =3D 0 Event  3 -- overflo=
w flag =3D 0x8,
> POLL_UP =3D 1, other signal event =3D 0 OK
> - running tests/test-evsel.c...
>         loop =3D 65536, count =3D 328183
>         loop =3D 131072, count =3D 655863
>         loop =3D 262144, count =3D 1320613
>         loop =3D 524288, count =3D 2621943
>         loop =3D 1048576, count =3D 5243383
>         loop =3D 65536, count =3D 66349
>         loop =3D 131072, count =3D 131789
>         loop =3D 262144, count =3D 264697
>         loop =3D 524288, count =3D 528484
>         loop =3D 1048576, count =3D 1056485
>         period =3D 1000000
>         overflow limit =3D 3, overflow count =3D 2, POLL_IN =3D 2, POLL_U=
P =3D 0, other
> signal event =3D 0 FAILED tests/test-evsel.c:286 failed to overflow count

This test was using standard signals (SIGIO), but after changing to real-ti=
me signals,
I confirmed that the test succeeded.
When using standard signals, it seems that if there is an overlapping timin=
g of standard signals,
the signals generated later will be dropped.


>         period =3D 1000000
>         overflow limit =3D 3, overflow count =3D 5, POLL_IN =3D 4, POLL_U=
P =3D 1, other
> signal event =3D 0 FAILED tests/test-evsel.c:286 failed to overflow count

Fixed implementation of overflow counter not clearing on test failure.


>   FAILED (2)
> FAILED tests/main.c:13 test evsel
>=20
I will post a v3 patch with the above fixes.

Best Regards
Shunsuke
