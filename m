Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0985553946
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353066AbiFUR7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352177AbiFUR64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:58:56 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB941AD96;
        Tue, 21 Jun 2022 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1655834334; x=1656439134;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xMPkehhTJYoqjji9OrU2DmqwBrksKcv88iyENsrQ5sw=;
  b=0gj2eCnC/eOK3dbT0A9c4/Cc3rkpg6Slb4UBEzC1sZD3Afd4CMVKPrK+
   e81enUh61xYHkNCBnIaQb7UA7RAVtF4l5G/3tyRysO43g1klkMXKZQq7O
   cEKc7PyvogRQ/Nh7glQdi0XwGPcSWhYrAJ6g3YIW7AHWBbqK4xvskjAOz
   U=;
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 17:58:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArpQGcHV+IZVFTgaWMhNmVTjBHCPQdL0rJ0bbX7nIWd8E5iVUFAa2WPvLlT0UO8YpYx2tkG2sLFWfRl80nrtiucPyI7KN90LcEYwcGnZ44ON868gOjG7YDr6LbuQqtAV318QHTSLA/Com/lIyxtiGeQW+WWsKur1N3Lo2YDaWcdLVtz2gh93JXSJxv+6deUfJZqveOcQAPMuH/aDl/QKyXMxJ8iuZlnHcQBR1Et/lTypH1MVriilPNkhIjcKswFGzeLPBS7lc77SRZjPTXVPj/dqdcUf3vof7YuzyPb4NQkhe1gERil1BiBj/FkpVGE0mtnMmcYLDLP9dGKxXLerrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMPkehhTJYoqjji9OrU2DmqwBrksKcv88iyENsrQ5sw=;
 b=LH/6egHZE1iRXO7/AYeSfEpnEo+wH1MmZExgAs9XarN7BhuJ9ELGQGBmThe/oqCeH7GPhKdbjeyDXMVGsuatK93oEo3IEZ2rAGgVa7xOXxabzn1ck+2RFkp1bqwEAetW2bXMbnETrrSFLOmutm9ZUsCVRiUhwhDfChqRdCKKyxPIkzJaQxrZS1Bi/S8ejddxKRuluLL4KTNKf7Pg9yqCR6SgG8k/WRBts0gsgjajfDUosEr2jZ6StsMr4mdw1gqx5PK70bbwgiFZ6NoO2X1P4HSBfAZijoT8TBiRetwOjTNGNSp/zBya5vud3IDYfxgWIMXL168F0BIImJcEgfGZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from BL0PR02MB4564.namprd02.prod.outlook.com (2603:10b6:208:4d::13)
 by MN2PR02MB6832.namprd02.prod.outlook.com (2603:10b6:208:1d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 21 Jun
 2022 17:58:47 +0000
Received: from BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::74ed:8851:fc13:a4ad]) by BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::74ed:8851:fc13:a4ad%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 17:58:47 +0000
From:   "Vijaya Krishna Nivarthi (Temp)" <vnivarth@qti.qualcomm.com>
To:     Doug Anderson <dianders@chromium.org>,
        "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: RE: [PATCH] tty: serial: qcom-geni-serial: minor fixes to
 get_clk_div_rate()
Thread-Topic: [PATCH] tty: serial: qcom-geni-serial: minor fixes to
 get_clk_div_rate()
Thread-Index: AQHYdRrKW5lyYlSVJ024eBGmtoqqRK05XvEAgAFQ0mOAA1kLt4AEzQpIgAGIppyAAcghDIAUGpQQ
Date:   Tue, 21 Jun 2022 17:58:47 +0000
Message-ID: <BL0PR02MB4564C633F46BBCC315D86322FAB39@BL0PR02MB4564.namprd02.prod.outlook.com>
References: <1654021066-13341-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=UF3x5RHrQH-m1X-4kQSsKiufLnkew=VuJz7W9EAi3GHQ@mail.gmail.com>
 <5d950007-7a92-a41b-e569-79e806adb06a@quicinc.com>
 <CAD=FV=Xm1LJEoU5dKa5pMgqsHuAXuFVpdHvc1REULhAKTPbGnQ@mail.gmail.com>
 <ad393ad2-a247-3c61-5033-185d39b5596d@quicinc.com>
 <CAD=FV=XD+LozhkJZp0C7RUO01T-XuqBA-SJ0EQeyvGk0CxC3JQ@mail.gmail.com>
 <e677fd02-011f-4f4e-fa73-17dc96aea7d0@quicinc.com>
 <CAD=FV=UzjnEjMTLTRVXTrz6aoiBymJtnJ1o8dzPN9hn0Be3tng@mail.gmail.com>
 <da18c508-f32e-fece-6392-e6a95f7c7968@quicinc.com>
 <CAD=FV=Wytm9EYu=4ndN+En2AFEgPK9NjrUMbFPA_h6TwyxGCYA@mail.gmail.com>
 <765a170c-d335-d626-0609-7d0f3967b71d@quicinc.com>
 <CAD=FV=X2wTUH50MqFu=4WifvbTG+df-oYqQBRWeSPES7M2fxNw@mail.gmail.com>
In-Reply-To: <CAD=FV=X2wTUH50MqFu=4WifvbTG+df-oYqQBRWeSPES7M2fxNw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95da3e5b-183f-459a-3596-08da53afb092
x-ms-traffictypediagnostic: MN2PR02MB6832:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR02MB68327EBC7827520E5E818915FAB39@MN2PR02MB6832.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2a5OLd911K6GJBAtQMNNaJJYJCY/YThQIzFk/xa4ISB0TyKz7fFE3Rpwf8lGj7js7bz/QRk7FDZo2riZRmXRNgTu0IldyIAFJJtfB+fSC880Ejm4+BqrnT12/3My9eIiBvSWY9EKG4HdOgvxre8oox0hCbbJ4x9iFBMW4jlV2cnveZLatFzvpn1c7N+zcY/lRTQa4zdbekjNMJuieeIZ7I4vQvcukvAOKHJiH+Np8Isa2DpVbdCUljXSlaE+eHYBk6di+2p/AOPMWv7cj0NFOdjj+J6xjaKD/9j4ExNyVBCn42l5mIh087v8T68vGA+0EaI+Lfj5n45w/qf/0bz6pmdFRq73uVDrf1Bh2sBvqocCk4pECv1vAMrJvQrNDnbN8/6LC7+Aanm21tr2Xrz+CLK1uXB5CjuWnwhLu4hP3v1gCrdWBqGMeI7NIYWlMBLO/Nw32Qr5qENYq/WKmI7l8bX+n21auoP20FCU77Ak5JF8tSV/m9B5nvRAvt0LijKbZeQorMuQjgbpn4ZT2laIUNOWHbF2LElpKHL1IiiH557LUIDPIIOKsnHxiSPQQxvJ/NRyIggZnZ3ojNb3PKpbVPnBS7wrG8bSBssJ8qF0qUXhPi1y2ubbbQWRkZDOLn/WLZ5KvQt0Z3KeMTFuUi4kdR0RuENwpRrCr9Ahhkis8tgHQT/tVwXvdxnVTY1bUnOngIAP+nklFwKUuwXmqYpmCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4564.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(2906002)(33656002)(52536014)(40140700001)(7696005)(478600001)(38100700002)(5660300002)(7416002)(41300700001)(6506007)(186003)(8936002)(86362001)(55016003)(26005)(83380400001)(9686003)(110136005)(8676002)(66446008)(66476007)(4326008)(64756008)(316002)(38070700005)(76116006)(66556008)(71200400001)(54906003)(66946007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXRjQVVvb3AzRjVEVTE4dytlMm9va0JmUnZtaHNWU3FFN2tWb0N4eXdLb25G?=
 =?utf-8?B?d2pJWHpBLzhka1RxYUZkcG5LV0tybFprR0xZbkRHRmV3YkFTbjNLYkNnRG13?=
 =?utf-8?B?OURsWmNlVXN6T2t2ai95Mm12WjZJQWVVbGlsaWd2L2J2OENSZmpURVVhREFh?=
 =?utf-8?B?dGpZNXVqaWNLRDVjTko0b04rRjJUanE1R2JrdjVCYjJQS05JQUhRVVRrZDFl?=
 =?utf-8?B?cVJIVnlDLzcvSlYrMXNyTlVNVXRzeTlIRGhkSDNNb0FmSE9kNW0ya3MxRmlV?=
 =?utf-8?B?WWdRRG00eWxhTHBXRlJyeVZVVmZIY0UxSHUxSDgrMzE1T2IyQ1JBcFd1M3Vm?=
 =?utf-8?B?SllWcTFzZDhnTkhvOG92NG1HczdsZkpNZm91U2hBdEFKNmNyZ2VhNldDMits?=
 =?utf-8?B?L3ZYQkhtWEMrVkhjWVdWQlJzeE5QWVVpeDdQclhTbkZmb3VzazIvSk5GSlNn?=
 =?utf-8?B?OStDNTdqNm02UWlLdWJGQ0JPc3lvbTYxTHdHd0tvTGt0WnVCZjdUQmt5Ymly?=
 =?utf-8?B?REs2VXdtcUFZV3NvdklWaXh2Z2xSOVZFWEQwMmFNNGk3N002VHRxWGh5ZVFu?=
 =?utf-8?B?QTE2MnAyekJVSXUvS0lsVFRtTWthVW9GVnRjZmFaY2FDcEJvMmp1cjAzTzF2?=
 =?utf-8?B?U2pIUm1aYVg0V1RCdEFZOFZYNXRRMFNxWnVoaHpyRXo4WE93NEdFOUVNRnJN?=
 =?utf-8?B?eEtaZmxSbWphZjB3d1g0enNsQkI0UEJiWEhvMWhOdXZjWHIxYmhBYkRabXI1?=
 =?utf-8?B?aVdjaXFubUVLTVFITWdnT1FybUxvWWFLaXVoSXBuQk1xSExxREV4M3dDcE80?=
 =?utf-8?B?TGgya1kyQUV2Z3dPUEUzbDUwTnhYUDFYWGZ5K1Q0R3VWNXJyZ2IvWSs1SjVG?=
 =?utf-8?B?Rk14Z0Uyc0NkdGsrQXV0cVFhZGdRclNqU3dzZlN4MDZ2VG5McUVSdDE3RUNF?=
 =?utf-8?B?MWVTbEFDL3lWT0FkaGR0VjZvNlBKeVhhYXVlRWVSRkROWWpLUURlSG9aUHFV?=
 =?utf-8?B?bWtMOXNKcmRETTdIVUNpQjlta1dqVE1DcllzNS82WTY2MkNQRUhXQm9ic0Zh?=
 =?utf-8?B?VVBDV2hLb2JyNnc5Wkozc0paTEx3MTA2M2tBc3V2VVBxUHhWcGg4OVFKSXpC?=
 =?utf-8?B?TXN3UDRESVVTWGNXWTFMZzU3ZWdUdjFNRWJsSXJRdjNaRkJHblVjYnhOcTRT?=
 =?utf-8?B?SjFnWnRBYjAvRE9HU2doT1FFSDJNTWdHUGl2M0ZuOHBoQ01xRWh0dEVFazBh?=
 =?utf-8?B?L2ZCRzlTQ25qMXFJS1pSK241QThzMVFlYmdtREh6R0gwa2VTclBQSlRmUVpC?=
 =?utf-8?B?VmgzZTFQVDEwai8wZ01YMU9YbHRHa0hZVDc1alRZcTBqZmFMUG9yWjErZnZ6?=
 =?utf-8?B?dlY3Q1lUb2NTZ0FqRHJueWV2Z2JqRDNDb21JZFVTaHNzTklSWHkyTlVlaVRa?=
 =?utf-8?B?VTJUWXVrbHVzRGIySXB0T3kwWXdzRGYxdkdpMXczVkFZbFF1VGtXUStRN091?=
 =?utf-8?B?UmtJWnpKUUIyMjBhdm84TithZlNtTVVvMGNHS2ZsR0FLQWVFaFpxajRaR1gz?=
 =?utf-8?B?dnF2RzVzK1lieUM4K0pVZ2VZdUp2c0ZkbTluSmh6UW0vdU9UVi84cnF0RkdF?=
 =?utf-8?B?QW9pbXZYWlcrTzVCc0JqM3VvS2lnMjRKaVZPVXBBUnVSakNKRi9RZXk2NFpq?=
 =?utf-8?B?amdVSytCRVlCRGhHZTZESVZOQldyL1Y4bjZGYUJXMUNyY2VNaGhlcDFGQXZl?=
 =?utf-8?B?cFIxSkxvejFNc0M2aDNDVXQ4dk0wcGlqWHFINmNLRGdURGtrQkdUWjVNenVS?=
 =?utf-8?B?Nm00UCtTOEViejR3TGFFVGpYeVNGNnQvSU5Rd2dNWEY4b1FCOW9QQjdYZnNl?=
 =?utf-8?B?RVRpeTZEUUQydUtKODBBbUFiek5Ob1ZUUVlmTGdrN0lWOU14SitCV0FrYmZL?=
 =?utf-8?B?VndyODhtWTBjbm54R3FZNXJNbU05eld6b1hZYlBIRWtNWCtjMlVsR2ZqM3h2?=
 =?utf-8?B?SEpmRzVFdStJbjcyc0hyVGovWDFkQVdaZUdnYlI2c3pnL1pzelo3SE9Sb2hV?=
 =?utf-8?B?Zkt2bGpIT2dDd2NrUFYvYzZPQUlJVWNwcWpmOFB1QnZmZHlBWEJJMWVncUZo?=
 =?utf-8?B?aDhpY2pxS0thYXMzQmdYVERzMWpRalI5OWxkdmRod2JPMUFLeWNtZmRLT2dv?=
 =?utf-8?B?dUZmTTVzQldFekptdEJqMlhnZFppQ1VWMW9sQ2xKZUlXTmNZOVpiNmZ5Qy8y?=
 =?utf-8?B?YnI4MkxrRVVTWkZ5V0ptRGtxMlVCaWVXQ1NSNTZnTXJlQmtUdXVEN3NlblJs?=
 =?utf-8?B?NzltdjF4R2ozeXFBQ3hReFVrKy9GbFo2bUZRM0NnVWtvWGV5endJL3orMmJw?=
 =?utf-8?Q?rH+8mn9yWIP9dJq8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95da3e5b-183f-459a-3596-08da53afb092
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 17:58:47.2944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BhxKmfotveBL8StqrylDV5NR4JGmdzckp1zuDKnpB0M9oGZau886BmXrmiJcHEDSvAo3mjoPrEi33AAnk5q/cK7JUqDzziQTkMlK/djtFGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6832
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkZvciBkZXNpcmVkX2NsayA9IDEwMCBhbmQgY2xvY2sgcmF0ZXMgbGlrZSAxc3QgZnJv
bSBiZWxvdywgRElWX1JPVU5EX1VQIHNlZW1zIHRvIGNhdXNlIG1pc3NpbmcgY2FuZGlkYXRlIHNv
bHV0aW9ucy4NCg0Kc3RhdGljIHVuc2lnbmVkIGxvbmcgY2xrX3JvdW5kX3JhdGVfdGVzdChzdHJ1
Y3QgY2xrICpjbGssIHVuc2lnbmVkIGxvbmcgaW5fZnJlcSkNCnsNCgkvL3Vuc2lnbmVkIGxvbmcg
cm9vdF9mcmVxW10gPSB7MzAxLCA3MDIsIDEwMDR9Ow0KCS8vdW5zaWduZWQgbG9uZyByb290X2Zy
ZXFbXSA9IHszMDEsIDcwMiwgMTAwNCwgMjAwMCwgMzAwMH07DQoJLy91bnNpZ25lZCBsb25nIHJv
b3RfZnJlcVtdID0gezUwLCA5NywgOTl9Ow0KCS8vdW5zaWduZWQgbG9uZyByb290X2ZyZXFbXSA9
IHs1MCwgOTcsIDk5LCAyMDB9Ow0KCS8vdW5zaWduZWQgbG9uZyByb290X2ZyZXFbXSA9IHs5Miwg
MTEwLCAxOTMsIDIzMH07DQoJLy91bnNpZ25lZCBsb25nIHJvb3RfZnJlcVtdID0gezkyLCAxMTAs
IDE5MywgMjMwLCAzMDAsIDQwMX07DQoJLy91bnNpZ25lZCBsb25nIHJvb3RfZnJlcVtdID0gezky
LCAxMTAsIDE5MywgMjMwLCAyOTUsIDI5NiwgMjk3LCA0MDF9Ow0KCS8vdW5zaWduZWQgbG9uZyBy
b290X2ZyZXFbXSA9IHs5MiwgMTEwLCAxOTMsIDIzMCwgMjk1LCAyOTYsIDI5NywgMzAwLCA0MDF9
Ow0KCS8vdW5zaWduZWQgbG9uZyByb290X2ZyZXFbXSA9IHsxOTcsIDE5OCwgMTk5fTsNCgl1bnNp
Z25lZCBsb25nIHJvb3RfZnJlcVtdID0gezE5NywgMTk4LCAxOTksIDIwMH07DQoJaW50IGk7DQoJ
c2l6ZV90IG4gPSBzaXplb2Ygcm9vdF9mcmVxIC8gc2l6ZW9mICpyb290X2ZyZXE7DQoNCglmb3Ig
KGkgPSAwOyBpIDwgbjsgaSsrKSB7DQoJCWlmIChyb290X2ZyZXFbaV0gPj0gaW5fZnJlcSkNCgkJ
CXJldHVybiByb290X2ZyZXFbaV07DQoJfQ0KCXJldHVybiByb290X2ZyZXFbbi0xXTsNCn0NCg0K
SSBtb2RpZmllZCB0byBoYW5kbGUgc3VjaCBjYXNlcywgb3B0aW1pc2VkIGxpdHRsZSBhbmQgdXBs
b2FkZWQgYSBwYXRjaC4NCkl0IHNlZW1zIHRvIHdvcmsgZm9yIGFsbCB0aGUgY2FzZXMgbGlrZSBh
Ym92ZS4NCg0KVGhhbmsgeW91LA0KVmlqYXkvDQoNCg0KDQo+IA0KPiBBaCwgaXQgdG9vayBtZSBh
IHdoaWxlIHRvIHVuZGVyc3RhbmQgd2h5IHR3byBsb29wcy4gSXQncyBiZWNhdXNlIGluIG9uZSBj
YXNlDQo+IHlvdSdyZSB0cnlpbmcgbXVsdGlwbGllcyBhbmQgaW4gdGhlIG90aGVyIHlvdSdyZSBi
dW1waW5nIHVwIHRvIHRoZSBuZXh0DQo+IGNsb3Nlc3QgY2xvY2sgcmF0ZS4gSSBkb24ndCB0aGlu
ayB5b3UgcmVhbGx5IG5lZWQgdG8gZG8gdGhhdC4gSnVzdCB0ZXN0IHRoZSAocmF0ZSAtDQo+IDIl
KSBhbmQgdGhlIHJhdGUuIEhvdyBhYm91dCB0aGlzIChvbmx5IGxpZ2h0bHkgdGVzdGVkKToNCj4g
DQo+ICAgICBzZXJfY2xrID0gMDsNCj4gICAgIG1heGRpdiA9IENMS19ESVZfTVNLID4+IENMS19E
SVZfU0hGVDsNCj4gICAgIGRpdiA9IDE7DQo+ICAgICB3aGlsZSAoZGl2IDwgbWF4ZGl2KSB7DQo+
ICAgICAgICAgbXVsdCA9ICh1bnNpZ25lZCBsb25nIGxvbmcpZGl2ICogZGVzaXJlZF9jbGs7DQo+
ICAgICAgICAgaWYgKG11bHQgIT0gKHVuc2lnbmVkIGxvbmcpbXVsdCkNCj4gICAgICAgICAgICAg
YnJlYWs7DQo+IA0KPiAgICAgICAgIHR3b19wZXJjZW50ID0gbXVsdCAvIDUwOw0KPiANCj4gICAg
ICAgICAvKg0KPiAgICAgICAgICAqIExvb3AgcmVxdWVzdGluZyAoZnJlcSAtIDIlKSBhbmQgcG9z
c2libHkgKGZyZXEpLg0KPiAgICAgICAgICAqDQo+ICAgICAgICAgICogV2UnbGwga2VlcCB0cmFj
ayBvZiB0aGUgbG93ZXN0IGZyZXEgaW5leGFjdCBtYXRjaCB3ZSBmb3VuZA0KPiAgICAgICAgICAq
IGJ1dCBhbHdheXMgdHJ5IHRvIGZpbmQgYSBwZXJmZWN0IG1hdGNoLiBOT1RFOiB0aGlzIGFsZ29y
aXRobQ0KPiAgICAgICAgICAqIGNvdWxkIG1pc3MgYSBzbGlnaHRseSBiZXR0ZXIgZnJlcSBpZiB0
aGVyZSdzIG1vcmUgdGhhbiBvbmUNCj4gICAgICAgICAgKiBmcmVxIGJldHdlZW4gKGZyZXEgLSAy
JSkgYW5kIChmcmVxKSBidXQgKGZyZXEpIGNhbid0IGJlIG1hZGUNCj4gICAgICAgICAgKiBleGFj
dGx5LCBidXQgdGhhdCdzIE9LLg0KPiAgICAgICAgICAqDQo+ICAgICAgICAgICogVGhpcyBhYnNv
bHV0ZWx5IHJlbGllcyBvbiB0aGUgZmFjdCB0aGF0IHRoZSBRdWFsY29tbSBjbG9jaw0KPiAgICAg
ICAgICAqIGRyaXZlciBhbHdheXMgcm91bmRzIHVwLg0KPiAgICAgICAgICAqLw0KPiAgICAgICAg
IHRlc3RfZnJlcSA9IG11bHQgLSB0d29fcGVyY2VudDsNCj4gICAgICAgICB3aGlsZSAodGVzdF9m
cmVxIDw9IG11bHQpIHsNCj4gICAgICAgICAgICAgZnJlcSA9IGNsa19yb3VuZF9yYXRlKGNsaywg
dGVzdF9mcmVxKTsNCj4gDQo+ICAgICAgICAgICAgIC8qDQo+ICAgICAgICAgICAgICAqIEEgZGVh
ZC1vbiBmcmVxIGlzIGFuIGluc3RhLXdpbi4gVGhpcyBpbXBsaWNpdGx5DQo+ICAgICAgICAgICAg
ICAqIGhhbmRsZXMgd2hlbiAiZnJlcSA9PSBtdWx0Ig0KPiAgICAgICAgICAgICAgKi8NCj4gICAg
ICAgICAgICAgaWYgKCEoZnJlcSAlIGRlc2lyZWRfY2xrKSkgew0KPiAgICAgICAgICAgICAgICAg
KmNsa19kaXYgPSBmcmVxIC8gZGVzaXJlZF9jbGs7DQo+ICAgICAgICAgICAgICAgICByZXR1cm4g
ZnJlcTsNCj4gICAgICAgICAgICAgfQ0KPiANCj4gICAgICAgICAgICAgLyoNCj4gICAgICAgICAg
ICAgICogT25seSB0aW1lIGNsb2NrIGZyYW1ld29yayBkb2Vzbid0IHJvdW5kIHVwIGlzIGlmDQo+
ICAgICAgICAgICAgICAqIHdlJ3JlIHBhc3QgdGhlIG1heCBjbG9jayByYXRlLiBXZSdyZSBkb25l
IHNlYXJjaGluZw0KPiAgICAgICAgICAgICAgKiBpZiB0aGF0J3MgdGhlIGNhc2UuDQo+ICAgICAg
ICAgICAgICAqLw0KPiAgICAgICAgICAgICBpZiAoZnJlcSA8IHRlc3RfZnJlcSkNCj4gICAgICAg
ICAgICAgICAgIHJldHVybiBzZXJfY2xrOw0KPiANCj4gICAgICAgICAgICAgLyogU2F2ZSB0aGUg
Zmlyc3QgKGxvd2VzdCBmcmVxKSB3aXRoaW4gMiUgKi8NCj4gICAgICAgICAgICAgaWYgKCFzZXJf
Y2xrICYmIGZyZXEgPD0gbXVsdCArIHR3b19wZXJjZW50KSB7DQo+ICAgICAgICAgICAgICAgICBz
ZXJfY2xrID0gZnJlcTsNCj4gICAgICAgICAgICAgICAgICpjbGtfZGl2ID0gZGl2Ow0KPiAgICAg
ICAgICAgICB9DQo+IA0KPiAgICAgICAgICAgICAvKg0KPiAgICAgICAgICAgICAgKiBJZiB3ZSBh
bHJlYWR5IHJvdW5kZWQgdXAgcGFzdCBtdWx0IHRoZW4gdGhpcyB3aWxsDQo+ICAgICAgICAgICAg
ICAqIGNhdXNlIHRoZSBsb29wIHRvIGV4aXQuIElmIG5vdCB0aGVuIHRoaXMgd2lsbCBydW4NCj4g
ICAgICAgICAgICAgICogdGhlIGxvb3AgYSBzZWNvbmQgdGltZSB3aXRoIGV4YWN0bHkgbXVsdC4N
Cj4gICAgICAgICAgICAgICovDQo+ICAgICAgICAgICAgIHRlc3RfZnJlcSA9IG1heChmcmVxICsg
MSwgbXVsdCk7DQo+ICAgICAgICAgfQ0KPiANCj4gICAgICAgICAvKg0KPiAgICAgICAgICAqIHRl
c3RfZnJlcSB3aWxsIGFsd2F5cyBiZSBiaWdnZXIgdGhhbiBtdWx0IGJ5IGF0IGxlYXN0IDEuDQo+
ICAgICAgICAgICogVGhhdCBtZWFucyB3ZSBjYW4gZ2V0IHRoZSBuZXh0IGRpdmlkZXIgd2l0aCBh
IERJVl9ST1VORF9VUC4NCj4gICAgICAgICAgKiBUaGlzIGhhcyB0aGUgYWR2YW50YWdlIG9mIHNr
aXBwaW5nIGJ5IGEgd2hvbGUgYnVuY2ggb2YgZGl2cw0KPiAgICAgICAgICAqIElmIHRoZSBjbG9j
ayBmcmFtZXdvcmsgYWxyZWFkeSBieXBhc3NlZCB0aGVtLg0KPiAgICAgICAgICAqLw0KPiAgICAg
ICAgIGRpdiA9IERJVl9ST1VORF9VUCh0ZXN0X2ZyZXEsIGRlc2lyZWRfY2xrKTsNCj4gICAgICAg
ICB9DQo+IA0KPiAgICAgcmV0dXJuIHNlcl9jbGs7DQo=
