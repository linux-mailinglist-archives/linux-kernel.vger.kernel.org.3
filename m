Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299534E86D8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 10:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiC0ILV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 04:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiC0ILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 04:11:19 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E974C40C;
        Sun, 27 Mar 2022 01:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648368581; x=1679904581;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QS96RGjBh1r6UXdxJ4b5/3HpRjogVBkLogYrLsuTxVk=;
  b=pJTuxa59fGAo/OXrmUAe+17hhaU7eZOE4o2TuNscqrueOdRNzbwllwmf
   YOQS8MZyDc83IyART/drhWPpykAyHEZZySpqF+JkafMXT/y8K37fXuhrG
   ad8qV5olw4OkxjeHUAM4oMDOch+imSkO1BOlAzGQJ18rP15dJV1JNqow7
   UDrBp3uJEcyf0ctqcPZDMs1TGhCE0kagP7NoYf0GC36IJX3X65mPvYd6E
   dWl45NJ2IkSqv//mfpiwqolDmtxfgSFDZhf+I4QtE+ucT/g+e2U7RkInX
   iH5jRp9po9HvPJRvZxTyOPhLLO8Am55YRYuCCRt1FvmeoqcEZRZbKODIY
   g==;
X-IronPort-AV: E=Sophos;i="5.90,214,1643644800"; 
   d="scan'208";a="300515137"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2022 16:09:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oe9L/Bgm+C68kGZIxY9jawENb4IfTLjxLMUhjBdOB/nTTZkgKTJ+SaZZN7t5rWf3UYfsQn7MKkQ9dNlWXXMn+G/pUSPuU82v3FMztvcDHS+5oPdi+/B4A+48/BKrgJ9x+q81UXz4RvVDRJa09q22ebR8XyctSOzUpSBJjSijrsVJtFl4GTyVF8O7YZM+g3Nv+CmPVmH3NKjaSF8J60mWrkbH6gWuWH2Nr0unsNJexX/MHr4uSJpM8PTlPH4CTiKjCoP5c807wtNIWb6huKAsuci5kCJ4+Vcl/By1P0Zd/WasCmod+WdOm5Ce7JFjJwEfebzmxV3DEGW0tGzMs6gj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QS96RGjBh1r6UXdxJ4b5/3HpRjogVBkLogYrLsuTxVk=;
 b=LSqMt2tQlAolWcHLpCc7HTY9eu982qpmTrnZB3pPjwo67gngZT3OtyuVYGheQV1Ws/9ymqzhZqIyd2UmJTFWvlRBZnY1faxxGyBuktrhCXmYp4E+IGFi2W5hW+svF+jM6KBPcnIR0zGUKMiGpH9ErVNGM7OMpS/QEzOWkVs+xVnrRh6uSJAepitowP8ji8y4yYtzI8TOANwe8p6z2AVW++Gutf2m6I0geaCYhDmIOJlshZccTIyMQLYGmt56zIfRVNEEA9Im7h57GYPga+CyMOTXJrZoI4Ne9asgz8nrUJqLHZqYJBwGWDhmYfPpz+HGLEfhpdf03scdZslm0Z+Alw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QS96RGjBh1r6UXdxJ4b5/3HpRjogVBkLogYrLsuTxVk=;
 b=dJG1KxYJiXY4TIXeCptw7LS/7G9mY/56GFOFqMhGUeLzSexGdDOip1oKtLOrxH/FQB2xXkDppKvqF5v0u71wELXewt/Am5Pm8p3QAqBIF0NeYy5oEWR6AUxSwGNuWw2L9v1H/uXW5ocoFxkSadH4ARSZa9U7UNA8+ybDXhcCuHs=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM5PR0401MB3622.namprd04.prod.outlook.com (2603:10b6:4:76::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Sun, 27 Mar 2022 08:09:38 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::941d:9fe8:b1bd:ea4b]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::941d:9fe8:b1bd:ea4b%5]) with mapi id 15.20.5102.022; Sun, 27 Mar 2022
 08:09:38 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>,
        Michael Wu <michael@allwinnertech.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "porzio@gmail.com" <porzio@gmail.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        allwinner-opensource-support 
        <allwinner-opensource-support@allwinnertech.com>
Subject: RE: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Thread-Topic: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Thread-Index: AQHYNcu0Jgralp1XlUCNRLBRM2Fhq6y+dQaAgAAo/4CAAARTcIADKbGAgAAUWcCAAAXXgIAAN0wAgAAWTgCAEMRdkA==
Date:   Sun, 27 Mar 2022 08:09:38 +0000
Message-ID: <DM6PR04MB657599A82C0513C46B80EB47FC1C9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220312044315.7994-1-michael@allwinnertech.com>
 <83edf9a1-1712-5388-a3fa-d685f1f581df@intel.com>
 <88e53cb9-791f-ee58-9be8-76ae9986e0e2@allwinnertech.com>
 <DM6PR04MB6575C3B87DFA920EDCD994CCFC0F9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <32b29790-eb5c-dac0-1f91-aede38220914@allwinnertech.com>
 <DM6PR04MB6575A4A2A687A876EA5C04B7FC119@DM6PR04MB6575.namprd04.prod.outlook.com>
 <312d724c-e43f-d766-49fb-9c5b10fe8b07@intel.com>
 <7ec0cf3e316a4ed9987962b4cbf01604@hyperstone.com>
 <a1230f11-a2dd-1959-5444-28c57d3babf6@intel.com>
In-Reply-To: <a1230f11-a2dd-1959-5444-28c57d3babf6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffeb7830-24cb-4be9-329d-08da0fc9235f
x-ms-traffictypediagnostic: DM5PR0401MB3622:EE_
x-microsoft-antispam-prvs: <DM5PR0401MB36228AEDE974E4F55A87E4DAFC1C9@DM5PR0401MB3622.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Du8cqGyFAGGqrQthMy2hbPKDop7CnywRSa64ZFhC4Jkld9EYSt72imuRAkjNxXyh8hjkbw2ZstBirP8ydHNGymZJgAEu900d6Dqi6U2CXD9ITmKwUDVOJHblqyuYExZd8vK1V6w3UR3CToA9g/6sZ+gRyQd5LXjEJAIt1mHgkU5kodhOP6VHbHnvbxdTlexjpydD9coKWzrOaa8XO4wlDyIdwHe/dK4STOcBDY4h/dwYPfzeYCQUF3A8hBYWdVyr5dD2KOIfeE1SphCsicvR1WqKEM8cfTNWM4qwVYqsSkcLQ148K/TzOll3BlSGew6K/7Sl9xX0iP/ei6NKnPuIb8ZTyjNmf/Uwp0GrQVSBX/jFDOKnGKJcjVTCil9nkSBvLGw+pwsxy5h3pPy1zbrTHVktiYiFS8OzklSOAcP8Qqmpd9YrDPDyum3YjKcZ1GByCqdWI7/x34SNObmiJ8JFbPuxPLGSdyOP/dPbqTQauFzFV8mMKzwFuWlsfa9u1TSf+bL/UjqkDazahqmN9wce7IHDJzxaP8010PC5EgnAreoJoQ2TWDk02SQt0GmYsfrwCGEXAj1ENi2jwgA1gtmYmz0Qtnd+mQXTdemA9+WG4tCYWGCtgYHluaZxgk0r02elPj0dGInHoOSHYkmj5ftkN8gM5KcF2NOGjmPZizxvCmVQPkdND8ycFZwxVxZAIk2/19bW1zazvAH8yFS/f1R8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(6506007)(86362001)(7696005)(8936002)(52536014)(5660300002)(26005)(122000001)(186003)(508600001)(55016003)(83380400001)(71200400001)(33656002)(38100700002)(54906003)(110136005)(8676002)(66574015)(76116006)(82960400001)(9686003)(66476007)(38070700005)(66556008)(2906002)(66946007)(4326008)(66446008)(64756008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXJtOSs2MWRaVHA4dEw4eTlKUnJLQ2VYN1UvaWRZNnRpdURqTVFYbTZxRGht?=
 =?utf-8?B?ZHc4YmhmMkx1N20yYzF6SE1sVDJNbWZHNCthd292TW1EWW5Hd2JIcGxwNzE3?=
 =?utf-8?B?U0l5ODdPRVdtd01PTTNvODRRRXBmemJBc2E5R1BxKzA4NTRSRGJwODFhcHNv?=
 =?utf-8?B?UitQcUMrVjM2RkUya1A1SkxHbWdYU05XWVJ1RWlHbnlZRGJlQ1NkWnpYS1V2?=
 =?utf-8?B?SmgzWjdwbTRSaVdXcnl6andQTHYrS1YvcFkxMWgwc3kwSW5kL09wd1V2aEg0?=
 =?utf-8?B?NWc0UTNSZVowVlllS3NPaFlFZU13RjB3Ukp2VnJtRVVrQ0prMDVQNmFTSjJh?=
 =?utf-8?B?MUpCOHlSUnVPVFhFcE1tR09mVkd2ZFFtcEI0Vm5tYXV6dUxYR1VOT2RCRHR5?=
 =?utf-8?B?WHlTSldyVlJ2OUlCQmYzT2xuVnluc0pnQTZFZnpEZ2drL2Zqamw1ODVFYllG?=
 =?utf-8?B?dnBrNlNSQlVEVDlxdnk4K0VjYVFXNFI2ZTJvdWlIUE9rejBNS04xalh6anhn?=
 =?utf-8?B?WVVGR25RV3ZUWldVczE3dXJCUk9FczNvYWZ3TFp6S05DM2tmQ2h2RXlwRVRp?=
 =?utf-8?B?VWhEMEFnTDBqL3I2UkFYaFYvSzNUM1dKZGgzcmY4NXFNZFVuUTJqUHRDQ1lI?=
 =?utf-8?B?U3FER2JGSXV6S2lTbUVZdnBUR1dNT28ycXQ0NysxUXUwZHpGanhYQ2xKdlFT?=
 =?utf-8?B?K01yRXBncnVKNURSVHo3N1Z0VllJZS95MW5mSitHbWpNWndLb0dMa0lYbnND?=
 =?utf-8?B?WGtjMEJ1dVltUVg0Tkl1NDRma0FEWmcySkNPTng2Wi92R3JQYlNMWXNjN0tj?=
 =?utf-8?B?V05TTmVUSFM3akxOdXRkMExPT3BybXdmTGNLckJ4TkNXK3NROEZ4TEhDTUtV?=
 =?utf-8?B?NlRSVHRYampRakdDSFcya2dPTlhVcURqbCt6ME1oL21xQmFKekNPQ0hjcFY4?=
 =?utf-8?B?amRodzdwd0tUT1VDbFdLaUtuNmgrY1MxY1kvVFZVemU3d2J3bWhBT2xiQjZN?=
 =?utf-8?B?em42OURUNThyOHRFemd6SmMvT05PcDh0NFBZd0JMMG9iVk92am9Pa2ZHQzZh?=
 =?utf-8?B?Q29idVBmYXFUOGNvd0ppOStQaWxpRGx1Y2tSK1JlWUE5MmRPNGdhWUtQTTJy?=
 =?utf-8?B?b2NiQUJnQnh0bE00eEhkZ0ZTUDM3N3ppb3JTcFB5WnpmS1pjZDBGTmRCd0I0?=
 =?utf-8?B?RmN0Uk14ZmN1SnNld1BuS2xvYUFVRUhxR0h4cCt4VWxxMEMwdDk0YjB5Nlgz?=
 =?utf-8?B?Q0I4NmlBN3hGMzdyU2RxajQ4VklIT25RQnVMSzBvVkx3OWdKeTEvUEVCRmRm?=
 =?utf-8?B?MFMzQ29TTlBQUjJuWGNxZDJ1THZRZ3ZGSmJkY1RUdEQ0VU5QK3diREZQWE1U?=
 =?utf-8?B?N0NTay84ZllFdkduSUUzNHBIMHlpY1g2UTMvK0twQ1FJUmduNHRwTDR1SU5K?=
 =?utf-8?B?d1Y2RFEzWUNxOUozb1I4dy9HSmxmdzNLZEpxandwOVBTS3E5anBlTUNGdE95?=
 =?utf-8?B?d0lSS0J2MldLbEt4UVU4NWJMSXNiUUV6Vkp0MksrcDIrc0JIZlNFenFzM25R?=
 =?utf-8?B?L2pGS0Z2S0ora3ROYU1hY2lFZ21ldXRFb2VGMWZnU0JGc3hQbTdTTkxEMjAx?=
 =?utf-8?B?Q2RvbU8zT3FBclJJTy9KNnJkcmtMNThUcG5QTEZOM3EwMUhmdTFPMEJ1WWg0?=
 =?utf-8?B?ZHZxaW1vQjdJRkQvQ3FlT1VxM1BLQWE5SWcvWFBoWDNlSWtOVDZzbGpmZWlX?=
 =?utf-8?B?TkpmamV3NUNPSTRBNXg5WkFtN0pKQy9Vc3ZNUHdGSGNrU3Z2a1NHZ2gxVGNv?=
 =?utf-8?B?VW9LTWI0U3dsMHM4dG1wWkExMkJ6OXB2Nm5iM2JueTQwT2s4eER5Z2xBSDVp?=
 =?utf-8?B?ZjdnZHBPVE5EMDBKWlA4aUE0SVFjMHd2VUJYVkxqczNFOEtQRkVSbGx6RHZx?=
 =?utf-8?Q?so6FJ0d0IIo1ERYUt3MmrI33VwKetihf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffeb7830-24cb-4be9-329d-08da0fc9235f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2022 08:09:38.2162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PE+bvmXFYsXbnxYTD3qj2RQX8bcp2+paXcQMAn74iN4IDwmO0TQPQ5laHv3i/HOaZUfs/a9dPEcm+IN/LlI2Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3622
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBPbiAxNi4zLjIwMjIgMTYuNDYsIENocmlzdGlhbiBMw7ZobGUgd3JvdGU6DQo+ID4+IFNv
IHdlIGFyZSBub3QgZ29pbmcgdG8gbGV0IHRoZSBibG9jayBsYXllciBrbm93IGFib3V0IFNEIGNh
Y2hlPw0KPiA+PiBPciBpcyBpdCBhIHNlcGFyYXRlIGNoYW5nZT8NCj4gPg0KPiA+IEkgaGF2ZSBz
b21lIGNvZGUgZm9yIHRoaXMgbGF5aW5nIGFyb3VuZCwgYnV0IGFzIGl0IHJlcXVpcmVzIHJlYWRp
bmcsDQo+ID4gcGFyc2luZyBhbmQgd3JpdGluZyBGdW5jdGlvbiBSZWdpc3RlcnMsIGluIHBhcnRp
Y3VsYXIgUEVILCBpdCdzIGEgbG90IG9mDQo+IGJvaWxlcnBsYXRlIGNvZGUgdG8gZ2V0IHRoZSBm
dW5jdGlvbmFsaXR5LCBidXQgSSdsbCBjbGVhbiBpdCB1cCBhbmQgc2VuZCBhIHBhdGNoDQo+IGlu
IHRoZSBjb21pbmcgd2Vla3MuDQo+ID4NCj4gDQo+IFdlIGhhdmUgdGhlIHNkIGNhY2hlIGZsdXNo
LiAgV2Ugd291bGQgcHJlc3VtYWJseSBqdXN0IG5lZWQgdG8gY2FsbA0KPiBibGtfcXVldWVfd3Jp
dGVfY2FjaGUoKSBmb3IgdGhlICFtbWNfY2FyZF9tbWMoY2FyZCkgY2FzZSBlLmcuDQo+IA0KPiAg
ICAgICAgIGlmIChtbWNfaGFzX3JlbGlhYmxlX3dyaXRlKGNhcmQpKSB7DQo+ICAgICAgICAgICAg
ICAgICBtZC0+ZmxhZ3MgfD0gTU1DX0JMS19SRUxfV1I7DQo+ICAgICAgICAgICAgICAgICBlbmFi
bGVfZnVhID0gdHJ1ZTsNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIGlmIChtbWNfY2FjaGVf
ZW5hYmxlZChjYXJkLT5ob3N0KSkNCj4gICAgICAgICAgICAgICAgIGVuYWJsZV9jYWNoZSA9IHRy
dWU7DQo+IA0KPiAgICAgICAgIGJsa19xdWV1ZV93cml0ZV9jYWNoZShtZC0+cXVldWUucXVldWUs
IGVuYWJsZV9jYWNoZSwgZW5hYmxlX2Z1YSk7DQo+IA0KPiBBdnJpLCB3ZXJlIHlvdSBvYmplY3Rp
bmcgdG8gdGhhdD8NCkhpLCBTb3JyeSBmb3IgbXkgbGF0ZSByZXNwb25zZS4NClllcyAtIFRoYXQn
cyBmaW5lLg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+ID4NCj4gPg0KPiA+DQo+ID4NCj4gPiBG
cm9tOiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4gPiBTZW50OiBX
ZWRuZXNkYXksIE1hcmNoIDE2LCAyMDIyIDEyOjI4IFBNDQo+ID4gVG86IEF2cmkgQWx0bWFuOyBN
aWNoYWVsIFd1OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOw0KPiA+IGJlYW5odW9AbWljcm9uLmNv
bTsgcG9yemlvQGdtYWlsLmNvbQ0KPiA+IENjOiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+IGFsbHdpbm5lci1vcGVuc291cmNlLXN1
cHBvcnQNCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBtbWM6IGJsb2NrOiBlbmFibGUgY2FjaGUt
Zmx1c2hpbmcgd2hlbiBtbWMgY2FjaGUNCj4gPiBpcyBvbg0KPiA+DQo+ID4gT24gMTYuMy4yMDIy
IDEzLjA5LCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPj4+IEhpIEF2cmlsICYgQWRyaWFuLA0KPiA+
Pj4gVGhhbmtzIGZvciB5b3VyIGVmZm9ydHMuIENvdWxkIHdlIGhhdmUgYW4gYWdyZWVtZW50IG5v
dyAtLQ0KPiA+Pj4NCj4gPj4+IDEuIGVuYWJsaW5nLWNhY2hlIGFuZCBjbWQyMy9yZWxpYWJsZS13
cml0ZSBzaG91bGQgYmUgaW5kZXBlbmRlbnQ7DQo+ID4+Pg0KPiA+Pj4gSGVyZSdzIHdoYXQgSSBm
b3VuZCBpbiB0aGUgc3BlYyBKRVNEODQtQjUxOg0KPiA+Pj4gICA+IDYuNi4zMSBDYWNoZQ0KPiA+
Pj4gICA+IENhY2hpbmcgb2YgZGF0YSBzaGFsbCBhcHBseSBvbmx5IGZvciB0aGUgc2luZ2xlIGJs
b2NrDQo+ID4+PiAgID4gcmVhZC93cml0ZShDTUQxNy8yNCksIHByZS1kZWZpbmVkIG11bHRpcGxl
IGJsb2NrDQo+ID4+PiAgID4gcmVhZC93cml0ZShDTUQyMytDTUQxOC8yNSkgYW5kIG9wZW4gZW5k
ZWQgbXVsdGlwbGUgYmxvY2sNCj4gPj4+ICAgPiByZWFkL3dyaXRlKENNRDE4LzI1K0NNRDEyKSBj
b21tYW5kcyBhbmQgZXhjbHVkZXMgYW55IG90aGVyDQo+IGFjY2Vzcw0KPiA+Pj4gICA+IGUuZy4s
IHRvIHRoZSByZWdpc3RlciBzcGFjZShlLmcuLCBDTUQ2KS4NCj4gPj4+IFdoaWNoIG1lYW5zIHdp
dGggQ01EMTgvMjUrQ01EMTIgKHdpdGhvdXQgdXNpbmcgQ01EMjMpLCB0aGUgY2FjaGUNCj4gY2Fu
DQo+ID4+PiBhbHNvIGJlIGVuYWJsZWQuIE1heWJlIHRoaXMgY291bGQgYmUgYW4gZXZpZGVuY2Ug
b2YgdGhlIGluZGVwZW5kZW5jZQ0KPiA+Pj4gYmV0d2VlbiBlbmFibGluZy1jYWNoZSBhbmQgY21k
MjMvcmVsaWFibGUtd3JpdGU/DQo+ID4+IEFja2VkLWJ5OiBBdnJpIEFsdG1hbiA8YXZyaS5hbHRt
YW5Ad2RjLmNvbT4NCj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+PiBBdnJpDQo+ID4+DQo+ID4+Pg0K
PiA+Pj4gMi4gV2UgZG9uJ3QgY29uc2lkZXIgc3VwcG9ydGluZyBTRCBpbiB0aGlzIGNoYW5nZS4N
Cj4gPj4+DQo+ID4+PiAgID4gT24gMTQvMDMvMjAyMiAxOToxMCwgQXZyaSBBbHRtYW4gd3JvdGU6
DQo+ID4+PiAgID4+IEhlcmUgaXMgd2hhdCBvdXIgU0Qgc3lzdGVtIGd1eXMgd3JvdGU6DQo+ID4+
PiAgID4+ICIgSW4gU0Qgd2UgZG9u4oCZdCBzdXBwb3J0IHJlbGlhYmxlIHdyaXRlIGFuZCB0aGlz
IGVNTUMgZHJpdmVyIG1heSBub3QNCj4gPj4+ICAgPj7CoMKgwqAgYmUgdXRpbGl6aW5nIHRoZSBj
YWNoZSBmZWF0dXJlIHdlIGFkZGVkIGluIFNENS4wLg0KPiA+Pj4gICA+PsKgwqAgVGhlIG1ldGhv
ZCBvZiBjYWNoZSBmbHVzaCBpcyBkaWZmZXJlbnQgYmV0d2VlbiBTRCBhbmQgZU1NQy4iDQo+ID4+
PiAgID4+DQo+ID4+PiAgID4+IFNvIGFkZGluZyBTRCBzZWVtcyB0byBiZSBvdXQgb2Ygc2NvcGUg
b2YgdGhpcyBjaGFuZ2UuDQo+ID4+Pg0KPiA+Pj4gSXMgdGhlcmUgYW55dGhpbmcgZWxzZSBJIGNh
biBkbyBhYm91dCB0aGlzIHBhdGNoPyBUaGFua3MgYWdhaW4uDQo+ID4NCj4gPiBTbyB3ZSBhcmUg
bm90IGdvaW5nIHRvIGxldCB0aGUgYmxvY2sgbGF5ZXIga25vdyBhYm91dCBTRCBjYWNoZT8NCj4g
PiBPciBpcyBpdCBhIHNlcGFyYXRlIGNoYW5nZT8NCj4gPiAgICAgPQ0KPiA+IEh5cGVyc3RvbmUg
R21iSCB8IFJlaWNoZW5hdXN0ci4gMzlhICB8IDc4NDY3IEtvbnN0YW56IE1hbmFnaW5nDQo+ID4g
RGlyZWN0b3I6IERyLiBKYW4gUGV0ZXIgQmVybnMuDQo+ID4gQ29tbWVyY2lhbCByZWdpc3RlciBv
ZiBsb2NhbCBjb3VydHM6IEZyZWlidXJnIEhSQjM4MTc4Mg0KPiA+DQoNCg==
