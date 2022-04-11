Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEAC4FB5FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343830AbiDKIcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiDKIcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:32:51 -0400
X-Greylist: delayed 68 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Apr 2022 01:30:37 PDT
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCB92F004;
        Mon, 11 Apr 2022 01:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649665838; x=1681201838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u2Tk15c477qxjKq5NL481Jk3lIqUzUoINi4jvpOmMc0=;
  b=ulUvywOTs7PsmZ71aL3CXhr0DNvLs0Tst009HqgiUmF+PaBYoSDaaUL/
   3iic4p954eGlA7uapuapnIzNs6IdwCHy3uzJiMIy4+rkBr7ImgU7j14z6
   csHf+gRZjH4BzC1FVShvsyQcW2Qm9eWgbNqWKmSGi2uMVisAoCDdD5Dc3
   c9sMDDHgt4uFO6dcmEPaPj6WkeVBVCFpnLyAZ8vttH+kobmwWLzVgd1zb
   MH/lBwCR2XcRDPTU+e5aPhUrmtDSsg1dD8LhhZJxoxqYOEdMHbe7OlarF
   28PeFTsNXr5p1uRR1HlGVFM26zuAry6REzBpSrRZiGSZX9A8RacGvdPeR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="53699517"
X-IronPort-AV: E=Sophos;i="5.90,251,1643641200"; 
   d="scan'208";a="53699517"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 17:29:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZiK1+c084jZ3DmtteVNdeYuv2YkONGfR4QEKkeXvUafWBHkjV66r2J9Z0xe/pYqYiw0up3rFSXCrJSPLUER8exI2H4b7hDVqkGthfoEDn93SIfKVJS9nZdUWpCKAgiDuBUX/iJkZYNa44QknMBIQ1AGzV7JaSblDYcTUNQLWDz6ojtmZE20ASz0ciRcggNp5DEClIgtQPUy6UZGrgaepKMbx8OZfZtbM31+vNANCUFYG3MqyxxoC8hns8t61YBIqPPDEqx7dOKlWsu5xIMxwWK+LUiVEbIOZYus3qWdfQ7pXRzOOI6YYeOVe9irPxJrRYyfjaEPbENTVMle/aXk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBEKcFBStcefh0Pa51fsNH1T0b7eDPvtedaiAWC339o=;
 b=E36vYIjTKIvo5JwWMbzsc8WJ6+SIIYARq6xL12qwxfntSvmC0aAHp+KsIy06PT4nqUMw+KroM6Vy/YzvVx63b6Wn+pnEg2xQqUJK8EYdcRj79ijrjfC1ZnmRAsgk0eDs9wtsjBPA5elJSSHxTHwCN/YowB2lS9J/+loGPxBEZ8OtY6bzuxHGfey0uCUyOxuIfogorDWWdcxvNziehqyEgREYKzEm7hCq/ar9GZIk7glmwB/mN4F12agvra4VXeUUjiyabKS42uRqc6kvd/bLfjzwm377/Ox9yoUUDs8pcS9U7NYfUpG4xXXB6pQiT0JnqbPXN8vU20oDuxj1HQ3CFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBEKcFBStcefh0Pa51fsNH1T0b7eDPvtedaiAWC339o=;
 b=dn5kYPA0zG7xbfwlzXi7suezHz/U9qafghrN0FXg6yLKsQQyS5ov0wjKWwcBT/UsgD/NIkrhqtLGx/A2ayy6cDM13oL8L2T/J93tePdmjjc8fEmK/UHt1RpmpoHpfLrSa3WwqhuOuW/xmHVmUkCoeuNjUcj2bz/MuXxlLmr4AkA=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by TYWPR01MB8331.jpnprd01.prod.outlook.com (2603:1096:400:162::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 08:29:20 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::5db:a021:ce3e:8244]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::5db:a021:ce3e:8244%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 08:29:20 +0000
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
Subject: RE: [RFC PATCH v2 3/7] libperf: Add perf_evsel__{refresh, period}()
 functions
Thread-Topic: [RFC PATCH v2 3/7] libperf: Add perf_evsel__{refresh, period}()
 functions
Thread-Index: AQHYRD0e+lbI3eCp10CNuai8nxhivqzqc7Bg
Date:   Mon, 11 Apr 2022 08:29:20 +0000
Message-ID: <OSBPR01MB46008051704CF17164C05847F7EA9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
 <20220325043829.224045-4-nakamura.shun@fujitsu.com> <YkRgHmEc2GDtXfZp@krava>
In-Reply-To: <YkRgHmEc2GDtXfZp@krava>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4abe55ff-d2f8-45b5-e3d5-08da1b95601a
x-ms-traffictypediagnostic: TYWPR01MB8331:EE_
x-microsoft-antispam-prvs: <TYWPR01MB833123231D504A860E9C3B24F7EA9@TYWPR01MB8331.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NMIBaGSz3xcFcgvRx727SD4AVAJe1UzsIkOf51xwYwNrLKTiaTb83TSzwWZQ5UXRwbCkxKBem32lDZgOaEfefGEf3BsULBrlkCXSlq1gtS8+7bnOjv8bW70lISCz7VxU+DLWznorhOL3KzRMIO2y5Eo4To/Sff20gj5Cdo5/4l1H/okdFkeqGLkBHAPIfJaPmBP1NO+NYbIZwz2ne7ZRZ14ShHGTkdFGxdicq3IHQAU+wyA2O2zhJ6JHAsqhQmQ9G4QF1y+hxFjMtwyWqWY58LPs4XaLbszNcVZOz2OUkTamhegtBu5QRzoElAwc9ZB2jY45RaiL1KWpGRNybqSW9c5Gp9rEoo7CG1VY/B974+XCIrGQoWld86oZKls1AxeVedGxbhAmDy5tRxURwHy2rEC/hzHPL4JKkNwPWFAF0OduGPBZg420lr8dHlzGANeT25gUSJdjARwHA6EuMU7Rxpf4N5mr6DxAU1OybKCdHGOUSHp80AeWAb9KOF6fdB+pGWP82q7FcVtCtTo5tqlK3t1CUYWYBkUtkHoj1r7tobVG0dF6kKleutFb8jKIexXi1dVkwqjGd7AYD7hoi3s+s5L4qPPx9YbyrzupnPzVGaTX6X8722G/+3GJs7W1B/oH407uzbLf9bx/Zwr9go6UFE5E8//MnUheIDg7AGeYDKSugSKW5KMQLuStQ5mx5gCKR4TBwmo3YszuosP6wj21MA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(83380400001)(52536014)(26005)(86362001)(8936002)(85182001)(9686003)(7696005)(6506007)(2906002)(8676002)(5660300002)(71200400001)(7416002)(38070700005)(55016003)(33656002)(66946007)(66446008)(76116006)(4326008)(38100700002)(316002)(122000001)(64756008)(66476007)(66556008)(54906003)(82960400001)(6916009)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?b2w2NXNGVEFGb1ZnWk0wOWtZU3NWTmM0UUgraVhScTh2dnpBdzh2bExD?=
 =?iso-2022-jp?B?MW54alJzdDhRRHlEblVaYS9yaEFBMXJieGxFbHFoN2E3NjlXSkFucGJV?=
 =?iso-2022-jp?B?OWJicFEzNTh2bXdpc3ozbmlaMFk2MEVlcFJZRDBnbWlQeGZuUGU5czdP?=
 =?iso-2022-jp?B?d3czRDFQN3BKSVYrZXlhN0EzWHVrY2RhRm1xT0N0emVpRlBWT0RGbUdB?=
 =?iso-2022-jp?B?QzNXcTZ3MzRhb0toa3Vmd3lhbjI5dVFqVncvbk5ycEJsS0NtdjR5Mk1n?=
 =?iso-2022-jp?B?ZDVxNUdIa1U2Ym1QUWpETUl1aWRuN3ZjU285eGJtRndSZnlka3ZUYWVr?=
 =?iso-2022-jp?B?bXkzVVZaVTV3NEdvbW5jRDhSY2dFWThYajlDY1JNdmF5dGNZWkx1clBN?=
 =?iso-2022-jp?B?OUxZSlUwUEFpU3VyeS9ScDMycEthSkNoWkhnQnQ5NUpYeVMycjIrVFRC?=
 =?iso-2022-jp?B?aldNblRVZ0p0UldtcnpoVVQvb3hCMjM0a1VNVzhDbnB1UTRYNWkrV1dD?=
 =?iso-2022-jp?B?MFBSQWxnTzFZd3dValdwOFZKK2FxWlB0SEFVNnpyR0ZxeFRQOGRZL0sz?=
 =?iso-2022-jp?B?aCtsZmdQODRuYmpLTGFzRDZIQllXT003TlBwTVlyRGh5czFmeHhXekt2?=
 =?iso-2022-jp?B?dTBlcCtNMVVhbUZSV2t0UE40MUxQTmVjWTQ1NGk3clR4bGI2QUdNN1Nz?=
 =?iso-2022-jp?B?WUFkS3JpWHo3bmFJZm5OVjRkMU8ycCsvdDZWUXVVRUo4TzN5WnN6NGNs?=
 =?iso-2022-jp?B?UDQ2d1JwSWRQVUVkK1c2aXUyeGQ4bzltalFSVlk2R212bVNRMDVHNXVK?=
 =?iso-2022-jp?B?Z0JUTkhrM1ZkOG03UXlUNitjSWUwZSttNWpyemsyQzZMVy9qYVlwZCti?=
 =?iso-2022-jp?B?NmZxRkJpVmVPT3RQSnIrMzF0dUo1TlhKODFuNmt4dGlrSzYzTTZ0aFFS?=
 =?iso-2022-jp?B?a3BPK1N1OGFLZktyeWE5UU9HVldzbDN6RVVETVlvam5rWnkrR2ltV0Nk?=
 =?iso-2022-jp?B?VkhrVVJYcm5HRTVPd1V6UDRJeE5PTDlmcmJZRnhCa1BaRXR0OVVJQTBE?=
 =?iso-2022-jp?B?a3VOcG1Calc3ZmdPS0wzUy8zVy9uMDEwZmhhT0JRd0taSi95WFo1YXBW?=
 =?iso-2022-jp?B?WGZXSjNRWDFWR0ZrTm9IakZOZDI4SXVwdWx4dm1IaVpRR213cVhTNjd5?=
 =?iso-2022-jp?B?ZGNGZzVabFkwMTlEMGFkK3l3RHQvUWxiSkNjTERtZXAzOVBFT3J4ZzlJ?=
 =?iso-2022-jp?B?b0FhbFI3WTdlaDQ0dlJuaW8yT1QweHN3MzJocHh3RjNYY2lEd215dXU4?=
 =?iso-2022-jp?B?YnorMHAzQ1dMUWNucFpJZ1VFdmxnc0ZpY2o0UWFzVTcwdWRScytKOU1w?=
 =?iso-2022-jp?B?OXo4YkJtSnI1K1BVc29rc3VIWlBDcjI0L0Nlamx0UFZlNnNFdU9tUnly?=
 =?iso-2022-jp?B?cHJrUzA3VkJYc2p5bEEzL2NJNmViOXJOcENmR3R3WjFjWVNMa2w1bjR2?=
 =?iso-2022-jp?B?NWNXWFJIVGhlQ2sydlFXYVdIUmZReVJDeWNDc2ZVNERNZHRubmJrc1da?=
 =?iso-2022-jp?B?aWdZYzVBSXh5dGNDK3FSRkFaVXF1TGx6N25BU1RCYmNUbXYyUmFkcnRz?=
 =?iso-2022-jp?B?MURWYUNGWnBWRU1zVjVHY3hCbzBRMDY2Z1E0Z2NRMXFYZldrbmUxbGsv?=
 =?iso-2022-jp?B?YnZBMWc4OVZPbWtFZGhra1B0N3o4UTA0Tjh4NlNTSXdtZXpsZ3VHdjFK?=
 =?iso-2022-jp?B?WE9SRW5vUFRhVExzbTRzTjVvRUIrbjBuamVEaHZ2aUxrcjVkTm9vUjAw?=
 =?iso-2022-jp?B?Y3BxRDBEL05uOEdRbDN2TkpoaXA2ZVNqSis1b3pXeUorRXB2T2pLSmR3?=
 =?iso-2022-jp?B?b1g3aUptai8rbEo0MXZCWkJ4eVF2a2ZMc29xZWZKbXp1WksrSHJZblBW?=
 =?iso-2022-jp?B?OTZGL2xsV2hUNktyTUl2aERHRG1walBXNzJQanRVZW15dEM2d3BGZ3Ro?=
 =?iso-2022-jp?B?OFFtZ3V0NlNxOHFXRkE1UEVRRTZrQjZaMzRhSGcwSjk3MGRsMFoydFhm?=
 =?iso-2022-jp?B?YWJsSThJeUF5ZnQrR3lFK2VYSzM4enBTMHFoOWM4d1ZCbWtIMjN2MlJB?=
 =?iso-2022-jp?B?S2huNjVNUUxmRUZVNm9PM3I5Ri93b1dmbWI5c04ycEEzS0Nhc1hKL2dE?=
 =?iso-2022-jp?B?VDZRU2xmcnd0QnAyVlRaTkJpTXZwMVl3NWpFV3Z0bkw5Zk0yOXFOSHhY?=
 =?iso-2022-jp?B?cVpDQkJUU1c1VmljUEswMmtOVGc4Y09UQ3gyNTJ0azJybDUzc1ZXWUR0?=
 =?iso-2022-jp?B?dm01Mis2cUhSZ3dFdFZDMmtiMEMzN05zM2lXem56d2pScWxSeVl1c1hG?=
 =?iso-2022-jp?B?d3M3MlQ3Y0ZWS0JDOUhIOERKMitvZStSRm9JdXJDZjBtTk5Xb1BWVjZW?=
 =?iso-2022-jp?B?b1hHQTZFZWM3Q1ZJWXVwVjcyZ0cyREVWb0N4RGd3S0hib2FIYndwV0RC?=
 =?iso-2022-jp?B?Qm91d0xYTElSNWVJWUtsSjhxWXBoZVRaeit3MW9vSDYvdndvSUd1azVH?=
 =?iso-2022-jp?B?TkYxTmZnWT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abe55ff-d2f8-45b5-e3d5-08da1b95601a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 08:29:20.2017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: liWlnQtKPLPiJzqQJCbmuQqD9W4UrjwpHkCrP7ytsUOl/u5i6C0bcKkqoCSLfK9Do0kiiGVo7mjPmhLHOz0uYlf3uLmhmTyQC1wf7kwEM5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8331
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi jirka

> On Fri, Mar 25, 2022 at 01:38:25PM +0900, Shunsuke Nakamura wrote:
>=20
> SNIP
>=20
> > +int perf_evsel__refresh_cpu(struct perf_evsel *evsel, int refresh,
> > +int cpu_map_idx) {
> > +	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_REFRESH,
> refresh,
> > +cpu_map_idx); }
> > +
> > +int perf_evsel__refresh(struct perf_evsel *evsel, int refresh) {
> > +	int i;
> > +	int err =3D 0;
> > +
> > +	for (i =3D 0; i < xyarray__max_x(evsel->fd) && !err; i++)
> > +		err =3D perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_REFRESH,
> refresh, i);
> > +	return err;
> > +}
> > +
> > +int perf_evsel__period_cpu(struct perf_evsel *evsel, __u64 period,
> > +int cpu_map_idx) {
> > +	struct perf_event_attr *attr;
> > +	int err =3D 0;
> > +
> > +	attr =3D perf_evsel__attr(evsel);
> > +	if (!attr)
> > +		return -EINVAL;
> > +
> > +	err =3D perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_PERIOD,
> > +				    (unsigned long)&period, cpu_map_idx);
> > +	if (err)
> > +		return err;
> > +
> > +	attr->sample_period =3D period;
>=20
> what's the point in updating attr? this will be used after event is creat=
ed right?
>=20
This is to maintain consistency between evsel->attr->sample_period and the =
sample_period of the created event.
Users can reference evsel->attr->sample_period using perf_evsel__attr().
So I thought it was necessary to update the sample_period of the event and =
the sample_period of evsel to avoid discrepancies.


Best Regards
Shunsuke
