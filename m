Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC5650DDC9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbiDYKXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240753AbiDYKXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:23:08 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EF14C78C;
        Mon, 25 Apr 2022 03:20:04 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P5rOI2009527;
        Mon, 25 Apr 2022 12:19:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=SqyaY18cPEJ0zVd8s72TW+Wjrz7gIjA6d4bTmkbA1kI=;
 b=jbRbLq1TRsVssJtZ1PgB27fwHlNuEmn3hEic5Sk1gvcoU6NDL0wsXq5ylnPb0S2QyHwp
 xiA63xDw15DOkRRyzHbcNCVfpU0NvPil0C4YfndmX2HIOgKWZb98S8mn1VhtvEtL/LVi
 CgHSkw+mwoYl16v56iLYJ3nlCZd6xwPtPMNp0W+Oot/uuPkgH5Pu0CZT5k/9UEZ4RPi7
 pWB/pfc9JcSbhFB3plhMOW5Yk7WCb2Kj1Gz64TkC4rgG6VOe5rdHOgQfFeWhtgCp6QAg
 jkDTi8eugm0W2vC0oOQvAivt/LqT1MjgmbyR3C1TOiqcCQDA1Vjqv8aIaBVXohe4W+qE Vg== 
Received: from eur01-ve1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2052.outbound.protection.outlook.com [104.47.1.52])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fm6vk8hsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 12:19:42 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxuxnSZj9WHDqC1ZUspvxMolM69EBKln7VYZFc/Hvt5TmfzedGnVOsk3oF/ubMl08r51c0iMmqcfoaDZ3J4TEJ6pdNFHAWELGhvmMM+HooawhQxttIyzHRukM5rXzQ59rszxdDy57sPmX3B40QvZFbatr2rtfbKEligQGjxbh5U7E1Knkhb9PALaRW1HnJDRVqw1jFkP/18LF8qRwPzheMY3Uwrqh1Z3RhHzS4AUX77/8jE/qzsBdRMr+6ASdImAkvuDUL842d+7DdAn28CTPCR8RI/96Fr54RP8MEqNOFHfAqELUTTtK5BGm6mnHVXvCDcKwwj6vzVVLC+HQXJWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqyaY18cPEJ0zVd8s72TW+Wjrz7gIjA6d4bTmkbA1kI=;
 b=Sm3AmeAG/ZRf4JFKJt+Ssj5+LRxxZPtv7GVxH1BdPCrLdgi5+fZcmH3wx/xSdWSEZKHPyl2NW2mdGyif2dY2/2JN5U6J+LFqasOTUVIozISBjKZ1R/lM+CsjXBTcGo3CXqJLAYdHRNwa3c8gWPAUMjC4Adjpty+SIrjL89rq09MEb6/dkV5jZuB4P5nSwImoui2Wu+/urbxbfaL6IzHJ8jojq6p54+WuuQGvbkC2TyeLjxFEF0UWp9FhwUHEmK4pwmp9WWVzMkIL29eSgWcrTBT/uoLwd6ydvS3VRyczykvsm+LRS6vTYV0TNbZFjoADKNtU/08FoCz3k9XjaKIGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::13)
 by DB6PR1001MB1126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:65::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 10:19:40 +0000
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c9b:e555:1035:b086]) by PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c9b:e555:1035:b086%9]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 10:19:40 +0000
From:   Etienne CARRIERE <etienne.carriere@st.com>
To:     Marek Vasut <marex@denx.de>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "soc@kernel.org" <soc@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH 6/8] ARM: dts: stm32: enable optee firmware and SCMI
 support on STM32MP15
Thread-Topic: [PATCH 6/8] ARM: dts: stm32: enable optee firmware and SCMI
 support on STM32MP15
Thread-Index: AQHYVlstOtyoewSfQ0uuhrGrUwLfTaz8IIuAgARMqxY=
Date:   Mon, 25 Apr 2022 10:19:40 +0000
Message-ID: <PAXPR10MB4687B8C3DF485E814AE8158BFDF89@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
 <20220422150952.20587-7-alexandre.torgue@foss.st.com>
 <174bea56-3e99-e01c-4133-f1350d34448d@denx.de>
In-Reply-To: <174bea56-3e99-e01c-4133-f1350d34448d@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Enabled=True;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SetDate=2022-04-25T10:19:39.774Z;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Name=None
 (Unclassified);MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_ContentBits=0;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Method=Privileged;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b75c6604-f69b-4bde-b4e6-08da26a51be1
x-ms-traffictypediagnostic: DB6PR1001MB1126:EE_
x-ld-processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
x-microsoft-antispam-prvs: <DB6PR1001MB11264E7D1CB577BE128A5BBBFDF89@DB6PR1001MB1126.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KQFnyFv8iLR/lNbO78059Iyn2r5YWF7MdcfCiT4U0BITg4cud9cJRU7JvW8HukgZKwD2Ut/liFpYE09//mD2VrkQXuBl/4QZT1dzPrqivZtceBy6HGFOoXIgTDRwDwRtIFzyWT2eI1NaKUM5PrmkHzixZU6YVDWiellNo5O117HdtZX1p9fXcJiEsQxv0i7z2PgG66LqzhngsGoPP0D9UrrbH3xJbikkuS7Jbg12lIme0EXiiCp6G551ZM1cZjGwook9l9X73P69c9lX3vNrEk7FErSgm/9fk3/uE+PJk1cxWaz3UQNZofq+hrKrEnl5zAwOw1KRB8rHVn8OpBpIS6C5nDS99gLc+Wm+dTW7mTN1zJMD+gx8Rs3i2tIsLVgiIv+11AmRE0R5IPK7Mz1boSjSFICBCqqIOSO41wbWU9L3aJqy0blLbv7o2s5i2U0Jon5/AznNVX6w1/xVw2ys3DA1qWS+F4EtffQSZYuc1OoWPDHJx1a8/kUzRxuCiDNSSy/thD1rfbgQFMgKfcCXM/oTkeSMmRRjxkFb3AbaEzMprmQTo5t4TEhsx3+oAhfclsLEmEljpdfADhw3kdFiuci98iq2ngyan/cHToLzeBHa9cGp2hNPgv7uWeXCGR7dINiDPLx1p9PWzcHmqgf6lWy2oz34ZXkJ4GkY9JoPcxjUVoOgP9XiEqvccGfIcGmAbm00XnSQRn8ML4hSZQ1y+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55236004)(53546011)(6506007)(7696005)(316002)(122000001)(7416002)(4744005)(86362001)(186003)(9686003)(26005)(38100700002)(8676002)(66446008)(5660300002)(66476007)(64756008)(83380400001)(52536014)(33656002)(76116006)(66946007)(54906003)(110136005)(2906002)(38070700005)(4326008)(71200400001)(66556008)(8936002)(508600001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Wzn7R0uoz4HmolEtBsEbeHlCfw2UIaX5FhmY/bpts2JwTrbhZEeTy2xS+j?=
 =?iso-8859-1?Q?ZQm9U/HOdYOaCMTsMLcXSRq41vZ291nbhmyaAcnhNVyQYKbO5gD9qF13cU?=
 =?iso-8859-1?Q?iuYh0ttfdpH6dvYVBQnbHUVX0MPHFYcMYybWRMybkO21l05ot2CXUzsZXE?=
 =?iso-8859-1?Q?MobcENItAFJ2EbVPilqH6Rxil6Sy8aqxZFhl/NNGPHpKXCMHqyDlgyxQG8?=
 =?iso-8859-1?Q?PvS2qxMRqf1G6gKlaFrCkZgz11NJ8Zo98mscGJHmsWcAOQi82+skfFiTSe?=
 =?iso-8859-1?Q?mmCxYFOhZjOJr7ZxdiWZOHQ0IuyD7jKib4upkGhcLL7c574D0SlXE0BxJE?=
 =?iso-8859-1?Q?JB9i+MSLmE9WY7W8KiYBtFeANJw5WRfMahmzG/7xt5A3RzoANwhRwT93iF?=
 =?iso-8859-1?Q?D5Jj6lWS8GqZeAEsSn+VeUPPhm3/ff6hmUWOVCiZNX8sJz9rG2UlnPUCmr?=
 =?iso-8859-1?Q?C9qYhnOGeLN33HvMEGwJ+DybbRo+J/hbT2+KJmlZStwHA19p2hZ/GAQNBb?=
 =?iso-8859-1?Q?pHuyvIvhiU5dgUqBqMUfa6Zbgii18Q5XoNZePOGdWpc7bNeoESDQMWG3FY?=
 =?iso-8859-1?Q?ymAszZCb90hGjogqFXvr61mVYi6CJ05pE0D2FapGXI49jByo6xZGl0qRSi?=
 =?iso-8859-1?Q?pr9Ukj+r73V98in8EP2oG/ou16yLq6kF1M0MNsAIigqITFte4sPZ9+DWnC?=
 =?iso-8859-1?Q?M++witr3lzvEuXJ2icguB26ap9rV80W2DURDvq+W+/p7byfj5r98bIThdL?=
 =?iso-8859-1?Q?AgsBi/ZFLSa6LdLQDraFFQHlNnn8Z62Za7FScv/5+xoR2IijKOC72PE59g?=
 =?iso-8859-1?Q?KP9ebe3fVSrd4MH+YWDf12/eUr/KTbyucbP1loReO8tbrruNPwgm94+a4o?=
 =?iso-8859-1?Q?ZIrAf7Ik4OMlA8xl+D0ri8ggF98KFM/h/1KHXhw72qLytFxR4fX2e9L0uO?=
 =?iso-8859-1?Q?hzTnR7ZLNZC/0KyRj/tmJ5hqMmytOyK0Cn6OnvnoXDjXpf4V3n5gY75qpw?=
 =?iso-8859-1?Q?n9tR58Zq5hrPakZUDMqEYgyjZl+hbgcfeYg3Dx2kLUxjjiaCh7VNUmwF/W?=
 =?iso-8859-1?Q?X+KtM/MG4UkwXySiHk70DBLlriIYhPk/hHepqmBmCjTdAUOtb7ZNx0fU03?=
 =?iso-8859-1?Q?XFsEleHBMMNoJnxTocriFg/xC+w8t+iQQS0tzG+YhfQjZV+sSaUsiNAJ8L?=
 =?iso-8859-1?Q?qzCaEom8E3CE99/5DE0Rsu1TpXzr684sFiaDdVy8UkrU8P3v8bUTnt4uj2?=
 =?iso-8859-1?Q?+UqFFnuXoR9I/Hr+HrieqmXtg4Miu8LYVLKhbfdAqyeIGwbG1VBQAkZ9au?=
 =?iso-8859-1?Q?hezRXYT1QywfWexiwCGe9EcgLRTVDcWMRbCGxSH3xAU5N3MCZkY86OTzxa?=
 =?iso-8859-1?Q?pqJNu/ZRy/6BHKmXXoX1jeJxewty2EsQwA4O9fpnNKHSheJoZ3uxigrcoo?=
 =?iso-8859-1?Q?ki5Z6vJ8ge821kGoQP/V/oqLWWW1uO1H4vm/L756tqRwu5UJKHAcIVotkx?=
 =?iso-8859-1?Q?CNZdCE+wY0/yQmkeyRI/dfeFcXsfWya42ImSgem16Tubx8JnvJLtrMj5kP?=
 =?iso-8859-1?Q?h5xaPDzh2Oz/9JsMebjFYlhb7XebwhD3BXUd05DtcTXsdurWf+sIpAWn99?=
 =?iso-8859-1?Q?FzCyYk/AnVMmPPCfzknGEigRADl23Knz+uAPVmK0rAXUU/y24GXLewmVN6?=
 =?iso-8859-1?Q?1r/ghotYYvUlu4WV69UlycpVbJ/aJuTH0z581ThBxyWgTdwYIuC2RpvWsF?=
 =?iso-8859-1?Q?AJl1pwnNSFF0jsrlq4Rzuwj1/FiecriaJ5tZfCV899ULDl4Wkz37zSJdY0?=
 =?iso-8859-1?Q?28gwozgxfQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b75c6604-f69b-4bde-b4e6-08da26a51be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 10:19:40.5113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XEQzT1g2niuGPeYajkvDM6P8LG9z9g17B9Hs1AAc5Gi7Rdvs006wqUkTIKGPgJyMNRef5RCIkq58Qg4NCrQUww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1126
X-Proofpoint-GUID: YkkzXfUz51oC-NK3JeyHC9UD1ETF6hy2
X-Proofpoint-ORIG-GUID: YkkzXfUz51oC-NK3JeyHC9UD1ETF6hy2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_06,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1011
 mlxlogscore=819 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204250044
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marek,=0A=
=0A=
> From: Marek Vasut <marex@denx.de>=0A=
> =0A=
> > On 4/22/22 17:09, Alexandre Torgue wrote:=0A=
> > Enable optee and SCMI clocks/reset protocols support.=0A=
> > =0A=
> > Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>=0A=
> > =0A=
> > diff --git a/arch/arm/boot/dts/stm32mp151.dtsi=0A=
> > b/arch/arm/boot/dts/stm32mp151.dtsi=0A=
> > index 7fdc324b3cf9..1b2fd3426a81 100644=0A=
> > --- a/arch/arm/boot/dts/stm32mp151.dtsi=0A=
> > +++ b/arch/arm/boot/dts/stm32mp151.dtsi=0A=
> > @@ -115,6 +115,33 @@=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 status =3D "disabled";=0A=
> >=A0=A0=A0=A0=A0=A0=A0 };=0A=
> >=A0=A0 =0A=
> > +=A0=A0=A0=A0 firmware {=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 optee: optee {=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatibl=
e =3D "linaro,optee-tz";=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 method =
=3D "smc";=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 status =
=3D "disabled";=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
> =0A=
> Doesn't this TEE node get automatically generated and patched into DT by =
=0A=
> the TEE ? I think OpTee-OS does that.=0A=
=0A=
OP-TEE OS does that if it gets passed the DT from early boot stage which is=
 not always the case.=0A=
=0A=
Etienne=0A=
=0A=
