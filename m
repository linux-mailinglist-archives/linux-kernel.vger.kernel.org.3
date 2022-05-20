Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEB652E5E1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346187AbiETHGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344021AbiETHG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:06:26 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F6333E8F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1653030385; x=1684566385;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yQf2s7sJ4DKei/fjxX1Jwand0zmpF+Q6O7NNJPbHA9M=;
  b=YAZCRiSUVpXkjaVMVRVjKtC92YSu8LMkuip0m3VVYY5dAzolOMxVWQTq
   9iw+sfjjvYMLB3xV4G0/OptSgo4UClUdfIAeFjQy8oPzIs9q1LZ0nOWEy
   YKF99AthIHN33Ec/DeX6qMXiMVD+qAfL3NrPhAWGTJQLePjqu/xX2vwPm
   5dqhndb/BaLBOSuYtzH3c9nDzQDotyYnisd/hxpwpRSAIDQ7K5SlRsI7R
   rTSM5RsMSzK5BV33XNbljdApRQQRu0Iyn65mzvxvF/yLfD9jZDh07hl0V
   CO9G5wRxG3uzSBDzdFluGjLj2/GaCjOMMHkh94ugYpmTvZaomZ0HWO+aN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="56601921"
X-IronPort-AV: E=Sophos;i="5.91,238,1647270000"; 
   d="scan'208";a="56601921"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 16:06:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8Aos8pBWFN/Tkvu2+m9QKfXs/7ldsp0MDSbVcvAoCTR1POIJMlhCps/XcIAxdl9UOIUfGRJTlRsDONZSbf6Kg6kR6EHIYNgDgmiMFgzZwAVNamdhn1IyqiUoJrhrs7ToLi0ldszmy7IgPGBFNgba7O6KA323KLgZWAZ/NeIABe0dvVllTxGoI27Ovzt2Kz94ufLHMwpUDPp7XnKhkhshKSqAf08oXd/tEW9Ba79CHO+j3GY8OG+ECTYs8tTWD78pkGLyhm8XAhHxeFMz1p3VkhdIeMmhXQAMudDriLZmavh14/8Afl3+Vx2qGEkkmK6hpwXBlsebGVeWGKYB9B8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQf2s7sJ4DKei/fjxX1Jwand0zmpF+Q6O7NNJPbHA9M=;
 b=ToXZxbyh7zl//4UcAh0FCIvu9Sb2Wv5tsylg1ti1ZBXHRVX/QnTEN0WQNKKfGeoLo4pRuI/3NOOYLtE1azCXYVI7SNAeF6XFQEXAGKvy/YIFFC9KzBfSFtZEH8azmKB5rssP4q3C/3NGNVHdfjn/CKeGYXxbAfls2z0wuOJikqpY7SEPpk141u9o9LLP2JKzPibmRhoBSUjYvgKpuIfiorZOzEmdvSxEnHKzki2ffz2tDWaUTvcmy5K1mI+wJFEr43tQCQ2dsBCovqBxGYYFHe+pz5cpJc4LgvAeBWo/xzx+MhthqBw3UsBE1JpRy+fWAUenlux+lVMDd5fURccNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQf2s7sJ4DKei/fjxX1Jwand0zmpF+Q6O7NNJPbHA9M=;
 b=iQ27Wx+vXBB2ialChjTZvDHRL6Trf9LUNyw+Xni/GNz40lR7CuT8RJPK3g0U3S3FzyO4pI8TPo20wACNnsN8RBPDQlXQHmrG3n6E5cxM1SGUDB3IuzVwgjsrJfs4CAzqtLgbYCqwwq+99k745PoP3zy9suRZdRZGiOFlPcrHp1E=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OS3PR01MB6579.jpnprd01.prod.outlook.com (2603:1096:604:109::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 07:06:14 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::a041:7644:4eca:ec8%7]) with mapi id 15.20.5273.015; Fri, 20 May 2022
 07:06:14 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Greg KH' <gregkh@linuxfoundation.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 3/8] soc: fujitsu: Add hardware prefetch control
 support for A64FX
Thread-Topic: [PATCH v4 3/8] soc: fujitsu: Add hardware prefetch control
 support for A64FX
Thread-Index: AQHYaoDnGErzvCOJfkeeIsbg4+Ss960kN6OAgAMiFxA=
Date:   Fri, 20 May 2022 07:06:14 +0000
Message-ID: <OSBPR01MB2037281E0102321816A9215680D39@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
 <20220518063032.2377351-4-tarumizu.kohei@fujitsu.com>
 <YoSb1wrgmLhXmvge@kroah.com>
In-Reply-To: <YoSb1wrgmLhXmvge@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30cd59c7-91ad-4c2b-2592-08da3a2f3a75
x-ms-traffictypediagnostic: OS3PR01MB6579:EE_
x-microsoft-antispam-prvs: <OS3PR01MB6579896B3550BD0C8ACC028780D39@OS3PR01MB6579.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IZ726PvOA5wPC6jnZ03sNXMILZxp8YthrwBI1/9i8dTvnbNlQ3i9wawsP3oHcFFnTkkC6RJrk0wwAO39O6M0V95LeSevQKCrgoTUEmCEyKbd6ejTPs6Njni4+OgvpE0gUs2amI76SrVKZ2oJn2ckJbyn2AdtlQAjk2GPkbhK9Mo4HlIV/L+6syqfavIHCLgUhFrqfdxMrs+PirG1mwgNvi4TMWnqIRSPEE7sS+qqtyHY4gkW5OKf2GfqWli1v9d1KkunwpJSeZZc+Sv3+C4swUGWGIopC4oLfV1xoFDrebTY3JrcfEr3qafWnJfMbRD4vQeTDgCxs+ivlTQomt4ZdcfHi1vJd5wq24fmvo+UrKQdCqPa2gas8vZhTgt6nNHYbX8peoO4ygeNJ1U4HINiLKXn3Bdc5Tcam5MF8l9Y0B617rkZ0Vwnjo45atOoeitjO5Fa/JTdxalJPW0vy9PPVSp13iOKyrGHhs/JiXw0Ly5x4/79HNcEFOjZHJsopl7e1mMFT6Z4sdsttenD5ZvaF1+EIXOmM1KL62Apvvm5u0ZDwEyvyz2X83Q4E49460/H8LQ/FIlSTN3iS3ikFBp0E7L7Lb83vBnyuLE4Cp8nrjWALDzF8vQw9xWEvp0wABoG4wbdS9op85JMwDQgkksFEgk4QQUEhiwDjFjycFlV3r2hZRXynQeVKic5DPjZl63z5TIM2npUfznAnhrgMX2hBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(6506007)(26005)(9686003)(71200400001)(558084003)(122000001)(33656002)(82960400001)(7696005)(508600001)(38100700002)(38070700005)(66946007)(186003)(2906002)(66556008)(76116006)(86362001)(52536014)(85182001)(8676002)(4326008)(54906003)(66446008)(64756008)(66476007)(7416002)(6916009)(8936002)(316002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZFdmY1VCdFdKTUVDU1RLcDQybUJSd21KK1l1dUFCUm1WdUNMd3Bxc2FF?=
 =?iso-2022-jp?B?T0NXcnhrL1ZtNlIwc1JzMWlIcnkyYUZWYTVsYzhmZFpMbnNXV1lXZ0l3?=
 =?iso-2022-jp?B?QTR3byszN0oxclVjVi9PY3g3LzRDUm1iTGhDNW9Dc1NnTlNpL0FoczlF?=
 =?iso-2022-jp?B?UVdYdjAzMG05dVVLK3gvMXU2ZTNYSDd1ZkJFcWV3TnJUK2hKWlNwdlF4?=
 =?iso-2022-jp?B?M2g2Z3dFTW5wcTI4d1ZXcW12UXUzanhOcDFBNlhJSVJVNkNyd1VidEVR?=
 =?iso-2022-jp?B?MGd6THU0M0ozYWZtMElLRktsdlB0TncvalRQZG9WdWxXN0M1V21EMHpT?=
 =?iso-2022-jp?B?RmlxL0VCWUx3am9PT1BBUWtQM2ozQ0xBUGFSSFVadndmSlJGZWZoekxx?=
 =?iso-2022-jp?B?cVJ1VDhoYS9UTHhZUWphbFVaVHZCbnd6REQ2bWt5ZjRxbTFNU0FhN2pC?=
 =?iso-2022-jp?B?OHkwRXBJMjZBMG5RN3pJQ1dldzZzUVRkRXJvQjZ5aDUyWndBV2wzMzZZ?=
 =?iso-2022-jp?B?UEd2a0dsUXZoeDY0anU5MWU4K3U0dmFVako1d2pXWXhJK3lCVEp0N1Bk?=
 =?iso-2022-jp?B?ZHIvVVRZYVNJbFNLbjhzTG9OQzJldnJRc0xSRHpPOWkrb1dtcnFQdHdr?=
 =?iso-2022-jp?B?NmVQOXROZTJXNXpVbkkxbTExTlRyMjRNR3JRdGFLTkhoRGpYdUtsekti?=
 =?iso-2022-jp?B?aWZGeCtTdHdXaFQyK3NUN0JQOXRzejJkK0VaL0tGVmI4ZStucDlZR3BM?=
 =?iso-2022-jp?B?U1RCc3FkRVJWZGN6cjFTaDh3Z0E0TTFDMDc4eC9mNlVkQmhBemtLd09J?=
 =?iso-2022-jp?B?cGw5UUFVKy9ncWVBQndrRUNadmlFamFkOE1JU0FlRWVneVRzeVpoTHZQ?=
 =?iso-2022-jp?B?TTJYTFNhemZBcHl6RzVaTFRhYVhaU1ZwL1ZkZmUxdE9LRFh5Njhtc2tE?=
 =?iso-2022-jp?B?bHZ0RjB1THNwLzRqcWc2OWpqVnF6WFdBV0RReXN3TGNYMnpuZldFNmQ2?=
 =?iso-2022-jp?B?RnBVczRZYWFLczMrOGRrVWxJdXFnbmFFdW45aGtxZUNycmJQOHM2cU8r?=
 =?iso-2022-jp?B?d2Q3ZENlemswQ1VyWVBTVFZEc3l1S1MxZE9rUWpROVQ3ZWY2YTdxVG5v?=
 =?iso-2022-jp?B?ZEE5VGM3a2RNMGF1OEJ1TndEcE82NnhYSUxtNDhudDNUSURtbjRIYVV0?=
 =?iso-2022-jp?B?Um5XRDI1SmJodktkVTZmUHhLVmNWUHo3bkZVSElqQUFaT2dZRmxDc0VG?=
 =?iso-2022-jp?B?V3pVK2J6TkNuTXNKR2tBY2Y4UE5hZ2Z3a2wranJJQmdLWXdlbEJPbUlm?=
 =?iso-2022-jp?B?QkQzcDlkMHVyU2pkd2JtNWc4Y2FpTzFwUVJwL0NiVjI5YVNlWDJ2VFdi?=
 =?iso-2022-jp?B?WUcwMU5hSC81OTRrRVdGMkhDMUlYL2h2dzVRbGM4MzdaNzNucytxN3hi?=
 =?iso-2022-jp?B?Z2NWYnYza0ErN0V6ZlJUR3pSTFpmMEFLSnRRaDcxamF3ZXM0WmExeHQ2?=
 =?iso-2022-jp?B?d0VJT3JHbC9JOEE5Mmp6Szk4MUhHRDBXbW9mbjhRL2JMdm5taitXRFdk?=
 =?iso-2022-jp?B?U3pXTnVaN3dWVVFNVTF0RWk5cGVxUGltdzl6UmttRUpkei9HSVo1eS8y?=
 =?iso-2022-jp?B?VXovTmd6eElHMm9MWTY4ZmRUUWlDMXMzcjBEeDVtM0JpVnZoWDd1OHRr?=
 =?iso-2022-jp?B?WTlFUlFhbVRJTzBYZkhNcmIxbThMY3F3Wk9sbGN4RlM4OTh1MldxWVV4?=
 =?iso-2022-jp?B?dXA1cG1pQ2lFT1ZZbTVxMk1pNnJhZ2UzaWVGUi91cXJESlJCdGZnQk9s?=
 =?iso-2022-jp?B?NFVjYThaTVVOUndZclNFVCt5SmkzMmhGVVNwQS9nazVJNEJ6MjVDVVlK?=
 =?iso-2022-jp?B?Mk1KMXRFMC9XVTZNS1RseWxNWHdYRnNqVE9aOWU1WTVLcTlGQTIwTnRS?=
 =?iso-2022-jp?B?eTBocWVZV0dPdjN4VnJFWHNud21PeGFMZlREQ29ZTUFibnRLb21MbFM3?=
 =?iso-2022-jp?B?aWszSHc1c1BQeTJJTCtGMzRRcXR3R25LdzVzdFJXQmJHY3hUZzhIWHU2?=
 =?iso-2022-jp?B?UjBUTG4xSEtacGVtaEQ4ZFdBR0ZaQ0t1YXE3R2R1WnpDUmU5Y1B1R01Q?=
 =?iso-2022-jp?B?SUNudGdqMEZTSnJQSlN6T2sybXNTZTFtZktqVDVsdG02MEdMT1o2SXky?=
 =?iso-2022-jp?B?VWxnTkhaTFBEVUF6UWpYb2Rrd3JFRVdGOUhNZ1dKdzVCeFJTSGNVSlhP?=
 =?iso-2022-jp?B?NHdVc1FhRFRoN3J4SUkrSTNFdGxPM3g4SnRCblp3TEQxQmpwSEJWeGhL?=
 =?iso-2022-jp?B?dVFUa3BTV3VxWmRJVEVkdlJFalUySXgvOTY3bG9qRzhpTzhBSXNITTE5?=
 =?iso-2022-jp?B?VmRWOWpCS0tGNmZFalFDdjVsSXhqUnZFRVlocW9RNlpjSFJJYjIyMnJp?=
 =?iso-2022-jp?B?cDRFZE9YbjFZdlR4aTREMTFCbEI0L2JJaS81aWhRaVA2RkRlOXRsWEhK?=
 =?iso-2022-jp?B?RnpGMmJoUVVXcy8yYWpjOEJ2bTlxSDdGNEk1bzRWMXIrbTVicllNcE5R?=
 =?iso-2022-jp?B?ci9mQUI0dz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cd59c7-91ad-4c2b-2592-08da3a2f3a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 07:06:14.4507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MiL/Ib3n9uFuUiB5OyUO4kXWgm8uaJyUnqnD+35xHHFps5obT5w6kbYHHs1F9fCTHrdO7uaUkPuOlHTXiMl+LsQbI0FdEMAeZi9/nJjcTpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6579
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> How will this driver be properly loaded by the system if the hardware is
> present?

I will consider how the driver loads properly.
