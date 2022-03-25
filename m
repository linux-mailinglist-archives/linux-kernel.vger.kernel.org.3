Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EBE4E6F57
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 09:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354092AbiCYIS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 04:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354017AbiCYIS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:18:56 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2091.outbound.protection.outlook.com [40.107.24.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1600BCC52E;
        Fri, 25 Mar 2022 01:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlSLyynfP/e3vkVLIeTUb5TaJkYtthXy8D6fmE4bNHZvNd+/OYn4pssvB75IUlAxF4zSD2TQoN+oVyLGFocHxbq9RktzAGnJ83XVh+45Ay41ZH+q47O+KEQPqJ3rKensd8C9QLloVaggcDnrg2JD+ANbEu/e40ZSBtVQeRqlHfhGj+45ok6Un9U0N5k37rA2dQm+tDwX840aXlxxgcnuAvEdnJ8FIJ2jb8eJlSkFlSzEIfqEnS35hCRTMVm6UJmDw1imJt2DPQBY4u032DcGWYHxx8GJWwpPilqg79/T7RDo2KS56yWpQiJ25Zlj3cepCmkagGhhFU3srqQH1FTrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQnpWcV6STwRuE/W/PMJ2D/POwRpWlPzdddDN6gI12Q=;
 b=mzgK4AEq2EAUJag4qayLDcUTbMQzB1mdq4xP+7+wMVSctFioxLKrcNRb98QMomtx4gEWw4+v57/4hjuZYzIVUIK6s0Fhb8tmu5aYHfxngbEryKwS7yDTnQSHnq4mJnlfkCVCVeewYoysR3F/CFeDAum+ct2ScVYS9Gq7SeRHiEjCme1FcDR1En+odP8SzW9+mUBoNy1Z/PjzmGfXoGXIBp/4c0UmZenO2fs6hyzj1t5JHrr5mBHeFpGQYVZAxEzsujNZp6+JDeTSp41cpwbH9p+eIK3USraO0EA4umRMb4RHNUezS6OT/cDlrwSE7m+md9ShlpF5AAS0GMlFzifT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQnpWcV6STwRuE/W/PMJ2D/POwRpWlPzdddDN6gI12Q=;
 b=lI79xh1j2bTVpJ8SzuKDtBBGpUy8uVdocUYdy7MO39fbh39gj884MXiDYqwCsk1UtsrXCJmNvT8pgpW2AUxpZpX0QeJWd1E8TMNZ7wNeZDecYN4LHa156harU82LBiqSzgw7saLfsCepigM3Y/SD5CuqmF+GnC+2LC/iNnnyEG0=
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0419.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Fri, 25 Mar 2022 08:17:19 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ac85:57a0:359e:149e]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ac85:57a0:359e:149e%4]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 08:17:18 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "reinhold.mueller@emtrion.com" <reinhold.mueller@emtrion.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alexandru.marginean@nxp.com" <alexandru.marginean@nxp.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: freescale: add initial support for
 verdin imx8m plus
Thread-Topic: [PATCH v2 3/3] arm64: dts: freescale: add initial support for
 verdin imx8m plus
Thread-Index: AQHYPsNqm8hovDUEHECkFLlYioGjzKzPKhgAgACZ3QA=
Date:   Fri, 25 Mar 2022 08:17:18 +0000
Message-ID: <bd89bb9bf215484be9894fb0ae4052324c84ab9a.camel@toradex.com>
References: <20220323143600.170778-1-marcel@ziswiler.com>
         <20220323143600.170778-4-marcel@ziswiler.com>
         <Yjz5fBwxhr0aBNsU@pendragon.ideasonboard.com>
In-Reply-To: <Yjz5fBwxhr0aBNsU@pendragon.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd0eb169-046b-458e-eeeb-08da0e37e118
x-ms-traffictypediagnostic: GV0P278MB0419:EE_
x-microsoft-antispam-prvs: <GV0P278MB04190DF716F6F9BDEEF4E672FB1A9@GV0P278MB0419.CHEP278.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iuk1PbajAN3p/U4lbrHZMxXZrAfxP8oYGSg51wMP4+mvLaNBUyUYWAro0Znv4JVzmuCK4ncj/coCdpCJZBcWBR4Gk6qNu/zqBpvaLJYW6MefhlHYO1BiC9V5dZwSgTuAD4Nj5Pk2NzF2dq79NsACuXn+4p42ahuCpYImM3xHmw9V+dlmVab1PNR5OnhOG4tIe6KgNnqm4R2WFU+XA1VVXouNO6xO2IKILshL4E0F+9v1JWgMMs02+UvqzYFmCXhNxE5TqFshvn3OEvqA4QP6YP1KoS3f9lEA3Jz1c6DippbDzjDrqPVT3Wt2E0qCi5TUTEMKrEEsa1pi+g7RrcZrb188960tyuyXjO0igh8UGi4Ix5W3PWhFyFZ9hzN7G9uxIk9aVToFrWsjAy95cxGjz50Wqt45yRghqBOidqfOTd4PJQ5I6qXiXYx1BG0dEBnzy0FufGl6jHjAJ7U49W2bbZqCIRPSS0kaRFzioag5rernsnsUEnfZAui55PN5HAv0HLWuqxR0T0vfA2MFLVFINWcdFz+XrjMnXHG0yFNlce7rhgJquo6iFIwu7h8sjCUsFDIQ1H201Gi4j0ll9dc06sTwX2wuRVRuLbJa8xCM4RLpcOMh2Jpvz50brM4qLIouvcB86mWrlw4C4GV3aH4/AW/zCDEmaSlJq8CjCt8fJu/b8EnZKfDF1h9+zb5t+vM91BI8e+YVmx4Gl1+eAmfEC9DBGguk8iTrdTX46eWVDDuOw/JKAuNrEBtXAmZNkRWEnUWXyJwput1o6DLXxySFW0RoHRoLd9GVM46xy4msT3pCyJaeTn7tfxQJj/s2j5xA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(376002)(346002)(366004)(39850400004)(396003)(136003)(186003)(4326008)(66946007)(44832011)(26005)(5660300002)(8676002)(66476007)(122000001)(7416002)(76116006)(66556008)(2616005)(83380400001)(6512007)(71200400001)(6506007)(8936002)(38070700005)(66446008)(64756008)(86362001)(6486002)(316002)(38100700002)(966005)(2906002)(54906003)(36756003)(6916009)(508600001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3JPREduZlljQkhQWWJPa0RiemJVZmNvbEdNbHBrcXZtNDN2ZXArOWMzd3hG?=
 =?utf-8?B?Uk1XTW4xN3h2Z1RIdFp3MHNHNGEzWWhENXVzcm9pSjFKYncxTWpyZS91Z0Nu?=
 =?utf-8?B?S3VjZXFidnNHakVsZ3JsOU9HaVdrN29iOHo1OHBwb2ljSVM3RTRsS1p0Q0JE?=
 =?utf-8?B?Q3pzKzZPa0pVT1B1WWY4Lyt6UGI2K3lPMVk0S1VIQlIxZ1FtOFlKWEtqYXZF?=
 =?utf-8?B?dTFtajdydHZxb3FjaHk5ZmMweWJ6b0p3WjByTGYvUmNBemN2MUZVTHRPNm9n?=
 =?utf-8?B?N0t4STZuS2hrc05KMDZ1RlVHdjJ0RGhVcWlvYXpyOTExYUx3OW9ZN0QyYWoz?=
 =?utf-8?B?ZlpyM0F4Q090S1pYeTNVczI0NlltcUtoWmVWZ3ZtdFNxS2hWV2xKaDV2Wkp6?=
 =?utf-8?B?TkNzWktTekNPVlB3c3BDVnJCWkdZRWN2dEdaNHluYTJqRS81SFE0Y3pDTlhC?=
 =?utf-8?B?UEwxcDA4cEhYdGZOaGpCTG5ORThGUDNNUmRjRVdjZThqaFBWd3BqR1JTUmRw?=
 =?utf-8?B?VzZCUDA2VFBBSDlQT0MyTENaa3ljQnVuVXRiNGgraHVodmR0dkFzaGlDeUJj?=
 =?utf-8?B?aFB0cnFHbjdGVkRTblgwTGhlbU1pVkY2SHZsUUMvbEJxSHdGaXFSaDhTaSth?=
 =?utf-8?B?N3NZcGc0Yi9najZQdzdOT2dRRlZRSGRjVkVOVnlkU1lMeFRET1R1bHNQLy9U?=
 =?utf-8?B?bFd2VVpITU12ekRsUk5MUzh2czRGRktzMUtvaXFpK0JPd2lYTjNZeUVXL2tl?=
 =?utf-8?B?azB5Ym9OZUc1eFRSMm9rRk9IallUMEFkQjNFN25VSlpkWWRHdlNCcU94NTlw?=
 =?utf-8?B?dE10Q0RKV3lzaVZqZU93YUloS3RVQzQzT3k2eGVFVnFwRGM0d3VscGhLcDdy?=
 =?utf-8?B?YjAzK25sQXpWdTR3dExnbWNoWDhNbFNzNjhZekdkSVIvTHVoOXdKZTdScjhX?=
 =?utf-8?B?WHd3U29OOVdzN0RlMG9NYnV6Y2srWVoxODhibjNjOUdwYlBZRlVvMTdWMFBx?=
 =?utf-8?B?VFpqQ01QZk5kNnlzclI4Q1NmUEk4OTg5TmZndFc2eHk3ZDVZcDYwMHVLVzll?=
 =?utf-8?B?THZsa0RNUGVlR3Y1U1VQbVJzSEV4ais5TXdTY1hOUlpEaTBPdk9pNEpWV3ow?=
 =?utf-8?B?emZnTVI3NmVVZEN1NXJEd3ZlaU1JVmdYRTM1b1YweUVzeUkwbHNBRHpsdGxF?=
 =?utf-8?B?R3B2NVhvVVlzVlZMMGRnYTA3M3FOcUQrMVNFWnYxTi9meFMvelNQQzk2TEIv?=
 =?utf-8?B?NFhRemQ0SVBCUzJuR3lZNWJJb1pIUm03SU56aEhwWlFYeGcvRjE5YjBYVlhD?=
 =?utf-8?B?a2FnbDRYQ3AzNVZuYTRsOU55cWQySGY3TlpacHdQV0o3QkdVSUs1WkdMN1Ev?=
 =?utf-8?B?ejFndHdUZDFxR21LcitGTVdEY09FRm1BVDJBOFhyUkduVjg5dUIyWGNQS3NK?=
 =?utf-8?B?bk0zbDVIYXVwdmFCa2xsVkp3N2VZcTZPWnBmNDE1NVZzOXE2c0daVVRiL0t5?=
 =?utf-8?B?czlVMU8rQnJHY0krcXZBV1ptWHNZbVBZaTY2YTBRbXNZb2JBWGNYcmV1Mm5t?=
 =?utf-8?B?WWtYTFUxQWNWaGZTNnVDOUFXOWVBNnRsaVBSSE1uMXJ3UDJOOXVDLzlZd01z?=
 =?utf-8?B?eGIvdWdKbzFXeVJ6cTZjdnh1RGc1WmJLRXRsbGIrWU9SaUhycG1iMnFkN1B2?=
 =?utf-8?B?SHJFYTVocmtUbkQ0QThvSW5uV3ZuT2owZktRWVFIQUl1RVk0U1cwN3FYV1ZX?=
 =?utf-8?B?OG5jcXRkdzd0RmZIU0pPTS9nQzg2dWxvbXQ4ejErVVcvaExCTWlBa21SWXEr?=
 =?utf-8?B?cXE5ck9JR1JFWnkvbzFvVm50TE9qSk54Z3M5aVR6WVJLWWRLaXZESXhEajZD?=
 =?utf-8?B?MnIyQzB2d3JZeUt0dXpCU0x2dWdBSVFKaTlGR3Bnd3dKTE5Kb00zZll5RHBE?=
 =?utf-8?B?ZlkvVmpnNDJKYk5TcjRYWEEzNDdxUkFRR3hTdFdJUkdvMHFNR3dsemhXMk8y?=
 =?utf-8?B?cjZnZE9RT2FudCsyR2JTRXg3R0xFNWFjNzl6d1RxdE02bU4vdjdaTE1Ga0Za?=
 =?utf-8?B?YXA5RUpUQlYyMXNZYURHTkRtQ2ZkRG5hT216cXcydXJvMmdFRzB1U00xb2ow?=
 =?utf-8?B?YUY4YVFUeUlEb01Xd21WcTZWQjhrbVBnTTJjMmFGUkFhTlFNWGhmUG9CQy9V?=
 =?utf-8?B?MmtDR1IyVWRTajZGZDBlamlTNG5BamtxVWN6OWw1WUViWFVUK3V6TVVaRFQx?=
 =?utf-8?B?V1EzTmZDWkg5TmxsY2pUTmRZakMrZmhBamhEMVN4ck52TGdkb3V0RUFTWm5s?=
 =?utf-8?B?UG1nQjRhT0VJbHFhMlFWanI5WFBja1FNTU9ZT1ErY3QrS2UwTzhCTnpqSitN?=
 =?utf-8?Q?RydJis9ECGNqH/ZfqKfyHSdS3hDJOr/b417vv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B69C5498DE4024EA39FBBB20A94109E@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0eb169-046b-458e-eeeb-08da0e37e118
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 08:17:18.8375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARnP8M3Yjx7bBxjl63sRxDNJosADcv1IDfODsi7Mu7VEH/SRoAZTuZCkBFrHASd12FBnhUbJl/fpDTd2Up5+gIaXhwS4VvLHybupwuCwA6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0419
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGF1cmVudA0KDQpPbiBGcmksIDIwMjItMDMtMjUgYXQgMDE6MDYgKzAyMDAsIExhdXJlbnQg
UGluY2hhcnQgd3JvdGU6DQo+IEhpIE1hcmNlbCwNCj4gDQo+IEEgY291cGxlIG1vcmUgY29tbWVu
dHMuDQo+IA0KPiBPbiBXZWQsIE1hciAyMywgMjAyMiBhdCAwMzozNjowMFBNICswMTAwLCBNYXJj
ZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4gRnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlz
d2lsZXJAdG9yYWRleC5jb20+DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBhZGRzIHRoZSBkZXZpY2Ug
dHJlZSB0byBzdXBwb3J0IFRvcmFkZXggVmVyZGluIGlNWDhNIFBsdXMgWzFdDQo+ID4gYSBjb21w
dXRlciBvbiBtb2R1bGUgd2hpY2ggY2FuIGJlIHVzZWQgb24gZGlmZmVyZW50IGNhcnJpZXIgYm9h
cmRzLg0KPiA+IA0KPiA+IFRoZSBtb2R1bGUgY29uc2lzdHMgb2YgYW4gTlhQIGkuTVggOE0gUGx1
cyBmYW1pbHkgU29DIChlaXRoZXIgaS5NWCA4TQ0KPiA+IFBsdXMgUXVhZCBvciA4TSBQbHVzIFF1
YWRMaXRlKSwgYSBQQ0E5NDUwQyBQTUlDLCBhIEdpZ2FiaXQgRXRoZXJuZXQgUEhZLA0KPiA+IDEs
IDIsIDQgb3IgOCBHQiBvZiBMUEREUjQgUkFNLCBhbiBlTU1DLCBhIFRMQTIwMjQgQURDLCBhbiBJ
MkMgRUVQUk9NLCBhbg0KPiA+IFJYODEzMCBSVEMsIGFuIG9wdGlvbmFsIEkyQyB0ZW1wZXJhdHVy
ZSBzZW5zb3IgcGx1cyBhbiBvcHRpb25hbA0KPiA+IEJsdWV0b290aC9XaS1GaSBtb2R1bGUuDQo+
ID4gDQo+ID4gQW55dGhpbmcgdGhhdCBpcyBub3Qgc2VsZi1jb250YWluZWQgb24gdGhlIG1vZHVs
ZSBpcyBkaXNhYmxlZCBieQ0KPiA+IGRlZmF1bHQuDQo+ID4gDQo+ID4gVGhlIGRldmljZSB0cmVl
IGZvciB0aGUgRGFobGlhIGluY2x1ZGVzIHRoZSBtb2R1bGUncyBkZXZpY2UgdHJlZSBhbmQNCj4g
PiBlbmFibGVzIHRoZSBzdXBwb3J0ZWQgcGVyaXBoZXJhbHMgb2YgdGhlIGNhcnJpZXIgYm9hcmQu
DQo+ID4gDQo+ID4gVGhlIGRldmljZSB0cmVlIGZvciB0aGUgVmVyZGluIERldmVsb3BtZW50IEJv
YXJkIGluY2x1ZGVzIHRoZSBtb2R1bGUncw0KPiA+IGRldmljZSB0cmVlIGFzIHdlbGwgYXMgdGhl
IERhaGxpYSBvbmUgYXMgaXQgaXMgYSBzdXBlcnNldCBhbmQgc3VwcG9ydHMNCj4gPiBhbG1vc3Qg
YWxsIHBlcmlwaGVyYWxzIGF2YWlsYWJsZS4NCj4gPiANCj4gPiBTbyBmYXIgdGhlcmUgaXMgbm8g
ZGlzcGxheSBmdW5jdGlvbmFsaXR5IHN1cHBvcnRlZCBhdCBhbGwgYnV0IGJhc2ljDQo+ID4gY29u
c29sZSBVQVJULCBVU0IgaG9zdCwgZU1NQyBhbmQgRXRoZXJuZXQgZnVuY3Rpb25hbGl0eSB3b3Jr
IGZpbmUuDQo+ID4gDQo+ID4gWzFdIGh0dHBzOi8vd3d3LnRvcmFkZXguY29tL2NvbXB1dGVyLW9u
LW1vZHVsZXMvdmVyZGluLWFybS1mYW1pbHkvbnhwLWlteC04bS1wbHVzDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+
DQo+ID4gUmV2aWV3ZWQtYnk6IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRl
YXNvbmJvYXJkLmNvbT4NCj4gPiBUZXN0ZWQtYnk6IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQu
cGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4gPiANCj4gPiAtLS0NCj4gPiANCj4gPiBDaGFu
Z2VzIGluIHYyOg0KPiA+IC0gRml4IGNhcGl0YXRsaXNhdGlvbiBvZiB2ZXJkaW4gaW4gY29tbWVu
dHMgYXMgcmVwb3J0ZWQgYnkgTGF1cmVudC4NCj4gPiAtIEFkZC9tb2RpZnkgdG9kbyBjb21tZW50
cyBhcyBzdWdnZXN0ZWQgYnkgTGF1cmVudC4NCj4gPiAtIEFkZCBMYXVyZW50J3MgcmV2aWV3ZWQt
IGFuZCB0ZXN0ZWQtYnkgdGFncy4NCj4gPiANCj4gPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL01ha2VmaWxlwqDCoMKgwqDCoMKgwqAgfMKgwqDCoCA0ICsNCj4gPiDCoC4uLi9kdHMv
ZnJlZXNjYWxlL2lteDhtcC12ZXJkaW4tZGFobGlhLmR0c2nCoMKgIHzCoCAxMjkgKysNCj4gPiDC
oC4uLi9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXZlcmRpbi1kZXYuZHRzaSB8wqDCoCA0NCAr
DQo+ID4gwqAuLi4vaW14OG1wLXZlcmRpbi1ub253aWZpLWRhaGxpYS5kdHPCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgMTggKw0KPiA+IMKgLi4uL2ZyZWVzY2FsZS9pbXg4bXAtdmVyZGluLW5vbndp
ZmktZGV2LmR0c8KgwqAgfMKgwqAgMTggKw0KPiA+IMKgLi4uL2R0cy9mcmVlc2NhbGUvaW14OG1w
LXZlcmRpbi1ub253aWZpLmR0c2nCoCB8wqDCoCA1NCArDQo+ID4gwqAuLi4vZnJlZXNjYWxlL2lt
eDhtcC12ZXJkaW4td2lmaS1kYWhsaWEuZHRzwqDCoCB8wqDCoCAxOCArDQo+ID4gwqAuLi4vZHRz
L2ZyZWVzY2FsZS9pbXg4bXAtdmVyZGluLXdpZmktZGV2LmR0c8KgIHzCoMKgIDE4ICsNCj4gPiDC
oC4uLi9kdHMvZnJlZXNjYWxlL2lteDhtcC12ZXJkaW4td2lmaS5kdHNpwqDCoMKgwqAgfMKgwqAg
ODIgKw0KPiA+IMKgLi4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtdmVyZGluLmR0c2nCoMKg
wqDCoCB8IDEzNzMgKysrKysrKysrKysrKysrKysNCj4gPiDCoDEwIGZpbGVzIGNoYW5nZWQsIDE3
NTggaW5zZXJ0aW9ucygrKQ0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtcC12ZXJkaW4tZGFobGlhLmR0c2kNCj4gPiDCoGNyZWF0ZSBt
b2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtdmVyZGluLWRl
di5kdHNpDQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1wLXZlcmRpbi1ub253aWZpLWRhaGxpYS5kdHMNCj4gPiDCoGNyZWF0ZSBtb2Rl
IDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtdmVyZGluLW5vbndp
ZmktZGV2LmR0cw0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcC12ZXJkaW4tbm9ud2lmaS5kdHNpDQo+ID4gwqBjcmVhdGUgbW9kZSAx
MDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXZlcmRpbi13aWZpLWRh
aGxpYS5kdHMNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXAtdmVyZGluLXdpZmktZGV2LmR0cw0KPiA+IMKgY3JlYXRlIG1vZGUgMTAw
NjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC12ZXJkaW4td2lmaS5kdHNp
DQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1wLXZlcmRpbi5kdHNpDQo+IA0KPiBbc25pcF0NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC12ZXJkaW4uZHRzaSBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC0NCj4gPiB2ZXJkaW4uZHRzaQ0KPiA+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi44Y2FkMWQ4NjU3MjANCj4g
PiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1wLXZlcmRpbi5kdHNpDQo+ID4gQEAgLTAsMCArMSwxMzczIEBADQo+IA0KPiBbc25pcF0N
Cj4gDQo+ID4gKy8qIFZlcmRpbiBJMkNfMl9EU0kgKi8NCj4gPiArJmkyYzIgew0KPiA+ICvCoMKg
wqDCoMKgwqDCoGNsb2NrLWZyZXF1ZW5jeSA9IDwxMDAwMD47DQo+IA0KPiBEaWQgeW91IHJlYWxs
eSBtZWFuIDEwa0h6IGhlcmUsIG5vdCAxMDBrSHogPw0KDQpZZXMsIHdlIHJlYWxseSBzYXcgaXNz
dWVzIHdpdGggY2VydGFpbiBkaXNwbGF5cy9zY3JlZW5zIGluIHRoZSBwYXN0LiBJIG1lYW4sIGl0
J3Mgbm90IGxpa2UgcmVhZGluZyBhIGZldyBieXRlcw0Kb2ZmIGEgRERDL0VESUQgYXQgc3VjaCBs
b3ctc3BlZWQgbWFrZXMgbXVjaCBvZiBhIGRpZmZlcmVuY2UgdGltZS13aXNlLiBTbyB3ZSByYXRo
ZXIgYXZvaWQgaXNzdWVzLiBBbnl3YXksIGNvdWxkDQplYXNpbHkgYmUgb3ZlcnJpZGRlbiBpbiBh
IGN1c3RvbSBjYXJyaWVyIGJvYXJkIGRldmljZSB0cmVlIHNob3VsZCB0aGF0IEkyQyBidXMgYmUg
dXNlZCBmb3Igc29tZXRoaW5nIHdoZXJlDQpzcGVlZCBtaWdodCBtYXR0ZXIuDQoNCj4gPiArwqDC
oMKgwqDCoMKgwqBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAiZ3BpbyI7DQo+ID4gK8KgwqDC
oMKgwqDCoMKgcGluY3RybC0wID0gPCZwaW5jdHJsX2kyYzI+Ow0KPiA+ICvCoMKgwqDCoMKgwqDC
oHBpbmN0cmwtMSA9IDwmcGluY3RybF9pMmMyX2dwaW8+Ow0KPiANCj4gU2hvdWxkbid0IHlvdSBh
bHNvIHNwZWNpZnkgc2NsLWdwaW9zIGFuZCBzZGEtZ3Bpb3MsIGxpa2UgZm9yIHRoZSBvdGhlcg0K
PiBJMkMgYnVzZXMgPw0KDQpZZXMsIHdvcmtpbmcgb24gdGhlIFZlcmRpbiBpTVg4TSBNaW5pIHVw
ZGF0ZSBwYXRjaCBzZXQgb2YgbGF0ZSBhbmQgY29tcGFyaW5nIHN0dWZmIEkgYWxzbyBqdXN0IGRp
c2NvdmVyZWQgdGhhdA0Kb25lIHllc3RlcmRheS4gV2lsbCBzZW5kIGEgdjMgc2hvcnRseS4gVGhh
bmtzIQ0KDQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoGF0bWVsX214dF90c19tZXp6YW5pbmU6
IHRvdWNoLW1lenphbmluZUA0YSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGNvbXBhdGlibGUgPSAiYXRtZWwsbWF4dG91Y2giOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAvKiBWZXJkaW4gR1BJT18zIChTT0RJTU0gMjEwKSAqLw0KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnRlcnJ1cHQtcGFyZW50ID0gPCZncGlvMT47DQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludGVycnVwdHMgPSA8NSBJUlFfVFlQRV9F
REdFX0ZBTExJTkc+Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWcgPSA8
MHg0YT47DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIFZlcmRpbiBHUElP
XzIgKFNPRElNTSAyMDgpICovDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
c2V0LWdwaW9zID0gPCZncGlvMSAxIEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICvCoMKgwqDCoMKg
wqDCoH07DQo+ID4gK307DQo+IA0KPiBbc25pcF0NCg==
