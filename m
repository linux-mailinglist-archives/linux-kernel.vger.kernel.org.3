Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECAC4D2FF8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiCINda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiCINd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:33:26 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DC1254;
        Wed,  9 Mar 2022 05:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1646832745; x=1647437545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fU5XX6lr2X2rBT8ggergtJZwyZn1exyB3febI2YY2P4=;
  b=2rCSW9TvE6zCQ1bC984GoE93P7lanKt4lFhEBzS0oh0kLhSbJTkXnleG
   bb29ik86nt2aChhtnxg3P3Njth3y2uX74+81yzn8BWxn/xnX+GNTp/lKi
   wvBtinW4/xlgbhlf+V5JzrnThrbb5m+1TTt3rZLbwSQjvjkEha/LeLI5o
   Q=;
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 13:32:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVIKxrNwiB4N7jlZZ6JJvajCGQSb5ludfyKZx22rxAUGVNudDN737oyMxGy6r2P86MlSm3Ss5Nc/+fZ1mVBkklnKC3C4XXVhfkJ8HkeJCmH1uO5UhJtmDUkl+S7k2bWPDNWX2omKN5frNfYNb5iRy/2JtcyHcRURhPsJCGmn2+sP3JmQTz0WrKyfKZe9lvNmrz1K+tNK8kF/jU7KSa3SH9yTXnDDxyw998F+Lhf1Wncrsb7QGy4vC82L84/e1OR1gWkBO5lfYvIq4AdjcbHaXYBmroMPg2pjqgic9VW+Ny+RjpXsrT4ov41qarrH94NrwNlhBLU8k1vBgw0MxY/IeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fU5XX6lr2X2rBT8ggergtJZwyZn1exyB3febI2YY2P4=;
 b=RIl/t8834hd6PjdezHJ5KYwVZ6VpsWWyEtBfqVnUgVIJBY2NhOYB8evngBBEWX1Na7vGGYuMUzcSnMh9CEBhZfUWSHSkixm/Zo2xGeiLwNPdQR6gZGiP9Q05dgYeSMXydXhADBcpsMx9rqy/qFtr8kdodOtfKEOjY9H7h42VT5fanG7lmT3ZRuwpQieSClaFmKIHUUpUHHA9ObMIYgcBPdSG/rcmbC7wwGTckjob12NmMZRUBe/KbKQeti4YRO4J5oDv6njS+VKQUiEsZ2OQb0pz0FRPV4NMR4WppmFiKsD1XzjLor3EBGSB3H2D2m/PuHsI3TAgIpLCXfB8woXq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from BYAPR02MB4565.namprd02.prod.outlook.com (2603:10b6:a03:15::17)
 by SN6PR02MB4591.namprd02.prod.outlook.com (2603:10b6:805:b0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 13:32:18 +0000
Received: from BYAPR02MB4565.namprd02.prod.outlook.com
 ([fe80::a0d3:236a:537d:118]) by BYAPR02MB4565.namprd02.prod.outlook.com
 ([fe80::a0d3:236a:537d:118%4]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 13:32:18 +0000
From:   "Vijaya Krishna Nivarthi (Temp)" <vnivarth@qti.qualcomm.com>
To:     "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>,
        Doug Anderson <dianders@chromium.org>
CC:     Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Mukesh Savaliya <msavaliy@qti.qualcomm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dilip Kammath <dkammath@qti.qualcomm.com>
Subject: RE: [PATCH] arm64: dts: qcom: sc7280: Configure cts sleep pinctrl to
 bias-disable for sc7280-idp
Thread-Topic: [PATCH] arm64: dts: qcom: sc7280: Configure cts sleep pinctrl to
 bias-disable for sc7280-idp
Thread-Index: AQHYIaNir99tB67bpEut/O2NV51De6ysZZ+AgAMmebCAB6PVkA==
Date:   Wed, 9 Mar 2022 13:32:18 +0000
Message-ID: <BYAPR02MB45650334FEF776E0C6CBFF1AFA0A9@BYAPR02MB4565.namprd02.prod.outlook.com>
References: <1644843828-20464-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=XtkXganjG=ddgaq4-p+cAK1c4jqG=8Ux_xxdUrPpXhVA@mail.gmail.com>
 <BL0PR02MB456421F83B9C88139514399EFA059@BL0PR02MB4564.namprd02.prod.outlook.com>
In-Reply-To: <BL0PR02MB456421F83B9C88139514399EFA059@BL0PR02MB4564.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6bb779d-81d3-4380-8cf4-08da01d13ba4
x-ms-traffictypediagnostic: SN6PR02MB4591:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB45918EA3D4F73274D8E61B9EFA0A9@SN6PR02MB4591.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QMKqiysT4LxWti60LZ12kgHOw7JtrLyP88QXsptesCt+/N0J6CTqr4jv5dAHW4glVe1JZcAuELweZugemT66ycrw7M6YL6QSih7cjnSJIwYrrCL6lxPmCPd35IkhijdLQplUaUO9d+lQQ7KRcg1ZMaBieJEFAf935yqWts7E8trn0PxmA8oDxPE3jTCwxe8ETo5qX6wkvqrcct2e2RdOkGabtTSByLC9TaTQ2tesqVM3zJGw1EkpikCkHby7beuuaA2Bl9gcexcTAK9Sx+73Pndhl0iPn1uT55lKs1uzg7xgRH02owlJd7DFfhQh5wRkj74ABpIP6v0aHs95iwIDuPXj44CMcfgVyMb6gSSeJEiIfMm4EQ8K2L35x+RLyZ/TGCi0qChguUYnAtaU7MzyPSNmzz9Km/9V2Wn+uLhqytOFhNIEl9F1RbkmEKeImJ47QwK1t4WXLWY7My3oEYusdnfyV9wNtLcxbt1gnVb79UabSXawaYDQnBui/o3yzmuK/mqJ4ceMG5w8/aWkDBwnPilBO2x2/dRrOWqm3aaNt1iD/P4BmHqNB/eda1uTPMmfTHArHHEpMAQ55h3FE9tOSHkQLnnf0b5CungGmo+RPAlvLbT4XC1YxG7Va7QZ4wuHepf8L1YXlZdw3X4v9vcX5Ugfpctl0/PeGS8osbr27W6ulSJiFHjOeiq7GhA+7Erho63kGYK2vsSR+6PRp81F5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4565.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(52536014)(4326008)(66446008)(8676002)(64756008)(66476007)(66556008)(76116006)(33656002)(508600001)(2906002)(5660300002)(8936002)(316002)(110136005)(54906003)(4744005)(38100700002)(122000001)(38070700005)(86362001)(186003)(107886003)(53546011)(71200400001)(6506007)(55016003)(9686003)(7696005)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlUyUW12eVQ1MncwdlpYdU5FU2JCWnVPbVRramxya2JCYUtUblZKaWIvdzBD?=
 =?utf-8?B?SkZMS0hDSlVHVW03dXZKQjRnbVdLZGdPN3BYSWgwRE5QZVpveDJTeTRXY0hT?=
 =?utf-8?B?TytLU0M5YzE3VGhvemxmbStTQmd5dEFHU3hyVFQ2Rm01bXh6RWIwNTJhMlRI?=
 =?utf-8?B?VER5MVVvcGFSalJXMGEwd0JlZDVHN0dPT1RVR3VrODc5SDBDVXl2Y3h1MnN2?=
 =?utf-8?B?cFdXcUErcHBGWjNOYzVRbVphQkttU3F6aU5kT2EzU1B6UERqekd3VEovd2VW?=
 =?utf-8?B?RFNQaHVGZllTVk5hNVRrQ2gyUGMrTGFQaC95OERpeFdwcXdSSGJJUnY1VUhI?=
 =?utf-8?B?eEg1MGlCQ21GVjJObksxenYxS0paNnAyb21SSnZBei9NSURVdHlrdFJ6b1pT?=
 =?utf-8?B?bTgwUUVpcGlTdHNic1FLOUVnRVZreEJ4WFc5VnJuMkRvVkZFNnpIR25ta2d2?=
 =?utf-8?B?QkhBQlYvVkNiRUI1V0tMaXRoell0Qm9oZkY1b0VOSTZsS0hmelVKUllyK1Nv?=
 =?utf-8?B?cnQvWitKcmVFU1l5M1BPMVNMQUhhT0ltR1BhUWhNRGYyd04zTmJvRURJaEJo?=
 =?utf-8?B?OC8rWC9jQSs0WlpGdVV2QlFBN3N0M1hrd1lJNlBDdStKU1dFazc2c09IQXVB?=
 =?utf-8?B?dDdiaFd1SGZDN09lbldoZjhZM3Z4TmtkZ3FCMVZyZTY3dXFjbU45V29CWU1P?=
 =?utf-8?B?dk1oRmRZZlRBaElUSW9wcFdNUGNXRHVKeGZPbzJoNjdZVEFUaW84VXdEczBi?=
 =?utf-8?B?cWJlR0FibVZvZXZ1MkM4ai9OVlJBSHlBeU1zWlhqeEE0bDdGekQwM0hNaXlW?=
 =?utf-8?B?cmRIdm9DVmZveEpIRWtEUVpNUER3bXhNSFZiTzN1Q0pneHpTWFlkL2U1bUg3?=
 =?utf-8?B?dEk0R3F3L0UxN3pWRUZxVU56b2RyVGgrYnVuMWtaWlRCUm16TmhQSEZxdnFy?=
 =?utf-8?B?U2U3TWkzM0g2Tm1hc0lqT2l4ZGVrZjU3LzB3TnFURDZpeE5lQUZBRUlIRUZX?=
 =?utf-8?B?NC9lUTdGUTlnT0VPZnpWVnlNWHVSZG9semFtbVdhNGx3UjhZWWdOMlgyY1ha?=
 =?utf-8?B?NU5PLzhPWXU1UXlWRng4QmNoQXJPRG9mT0Q1YjBhTk5vTEx4MWliZEF1RW1U?=
 =?utf-8?B?U0F3KzI5bkQyZ0JWbzJwamwxTTV2ZnVMVXVnRXRSYU4yWHFudVFqMWxGWUNa?=
 =?utf-8?B?VTh3Q1JPa3Ixc3kxaWxrbVpRTW5YNGxZSHpyQjFpQkJQbkJRUmhzZkNiUHNR?=
 =?utf-8?B?Snk3akVmK1JBL3JoM0FhZUcxbVJNM1VHdHdmYXBaMXBhOTZVR252THJOSmMw?=
 =?utf-8?B?UDIyL3Jkcms2eUlIbXAzNS9YWGwvUzJGa3FkYjh3TWR0bUxZMFRnUmh2VzBP?=
 =?utf-8?B?MllNWHFNVXdiZTY4czV1L2ZuZlBZUHp0L01xWW5nRFp6NDNKaGROazBrTFl1?=
 =?utf-8?B?VU5hTExRNlNrdHBrK1ZwOVJ4N0U2T1FGd0RMNVJXS0hwakVTNk9SQ1Ztc2d2?=
 =?utf-8?B?cm9wZzB5d3hpMmtnbE52ZW9RSVBIT1R3N3V2MjVwRG1adzVCa3U4QVBobzZ2?=
 =?utf-8?B?RGJuZ2NBb2hvS1hVVmMvamZYNXI4WmdveWtNV3lnOHZsR1pKUzZsekxuUkxp?=
 =?utf-8?B?N2Z2ZWVPWDBuODgwR1FzT3Eyb1Z3aWlnRXU3R1VVR1RmbkdsTTlnNmtOa1JW?=
 =?utf-8?B?MDJZVC9pRmxpbnliaTk5TnJ1K3RPbE8wMlFZTzFiczNqNENrSHBERDBxRHY1?=
 =?utf-8?B?L0J3YVpUREd4alBYMHlEeVZCZGNPNkw4dmpwZkcyQ2FWc2N2TnV3VHRzYXp3?=
 =?utf-8?B?YllCNmNJc0VaSXhpeHYxUTBodWhhZm5aMS9yVkcyN1VyVDhITXlzTzhNN3Zj?=
 =?utf-8?B?ZC9jTXBLbEdqNVpnajlCdS8wU1R1RC8rb2lHSUFhaFFHcm5WTDY5QVhzU1RJ?=
 =?utf-8?B?ZFlwSkFPMWV6cnR5QWpkcm9VUkljNk15WHpFSlV4YXVqam5CL2EzOWkyZGVP?=
 =?utf-8?B?d0tvc2VtKytPcmNaeXhyNDZsbGJacWRXVDVkM3duM2pvaUREZXh2ZjlrME8y?=
 =?utf-8?B?Sm94ZTlFclRiL2dsby8rdENrT20zT1V3RWpxQk1obklqa2hscU1Nc0hMcXdJ?=
 =?utf-8?B?eFBBN1lhUkV3RVA0ZHhrVlkrOEIwa3E0TlQ1eWxRalNVSUNpbmhKMWNHWkwr?=
 =?utf-8?B?NTI4SXM1QUdyVWtRZVFhVUVFVW1oV1h4ZjQ2S0ZHaGZMS3NWM25KV0JoSWFW?=
 =?utf-8?B?K3Jwb1JpWU00aGlVbDhFb3p2NkJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4565.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bb779d-81d3-4380-8cf4-08da01d13ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 13:32:18.5060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Da3ppCzNwvm/fD1bNp59LrUYQjxoApC0UWLkUmNe2CRIinIBc7bLN6j4pTTSV8FYYz/WTUYTIRKgXD/q8m0L+T9FM4VVtC1e4tl/S22rows=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4591
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2UgYXJlIHRlc3RpbmcgcG93ZXIgcmVhZGluZ3Mgd2l0aCBiaWFzLWJ1cy1ob2xkIGNoYW5nZS4N
CldpbGwgdXBkYXRlIHByb2dyZXNzLg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBWaWpheWEgS3Jpc2huYSBOaXZhcnRoaSAoVGVtcCkgKFFVSUMpIA0KU2VudDogRnJpZGF5
LCBNYXJjaCA0LCAyMDIyIDEwOjI4IFBNDQpUbzogRG91ZyBBbmRlcnNvbiA8ZGlhbmRlcnNAY2hy
b21pdW0ub3JnPjsgVmlqYXlhIEtyaXNobmEgTml2YXJ0aGkgKFRlbXApIChRVUlDKSA8cXVpY192
bml2YXJ0aEBxdWljaW5jLmNvbT4NCkNjOiBBbmR5IEdyb3NzIDxhZ3Jvc3NAa2VybmVsLm9yZz47
IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwu
b3JnPjsgbGludXgtYXJtLW1zbSA8bGludXgtYXJtLW1zbUB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVu
IGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQgRkxBVFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdTIDxk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+OyBNdWtlc2ggU2F2YWxpeWEgPG1zYXZhbGl5QHF0aS5xdWFsY29tbS5jb20+OyBNYXR0
aGlhcyBLYWVobGNrZSA8bWthQGNocm9taXVtLm9yZz47IFN0ZXBoZW4gQm95ZCA8c3dib3lkQGNo
cm9taXVtLm9yZz47IERpbGlwIEthbW1hdGggPGRrYW1tYXRoQHF0aS5xdWFsY29tbS5jb20+DQpT
dWJqZWN0OiBSRTogW1BBVENIXSBhcm02NDogZHRzOiBxY29tOiBzYzcyODA6IENvbmZpZ3VyZSBj
dHMgc2xlZXAgcGluY3RybCB0byBiaWFzLWRpc2FibGUgZm9yIHNjNzI4MC1pZHANCg0KVGhhbmsg
eW91IHZlcnkgbXVjaCBmb3IgdmVyeSB1c2VmdWwgaW5wdXRzLg0KV2Ugd2lsbCBkaXNjdXNzIGZ1
cnRoZXIgYW5kIGdldCBiYWNrIGFzIHNvb24gYXMgcG9zc2libGUuDQoNCi1WaWpheS8NCg0K
