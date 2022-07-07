Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E8856A1FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiGGMcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbiGGMcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:32:02 -0400
X-Greylist: delayed 7519 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jul 2022 05:31:59 PDT
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B5E1AF05;
        Thu,  7 Jul 2022 05:31:59 -0700 (PDT)
Received: from pps.filterd (m0174682.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2679qfGv015076;
        Thu, 7 Jul 2022 10:26:17 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3h59fxm0t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 10:26:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+ajOIRKZKbgvuC1e4jIC5aLy3r7mDKLH11Tvhfv7bGRgAZqnnpEXneuUJHTBoFuS9Z3IWOCECTrbAJwdJE7wN5dH1CiweI4qZ5LE/9OyqwRewDTHlOGKl0f0MF2AEV/RiykU4ZIGHJI/bXVdXJj1ew9DFbBjcFxJEMcSyrYcFOtahfPtQ1ZK/AqEMXaPQKdO0g3nCqYbm+2Z+AkNpncNmBtnC4iQiAXVmd/JyIPoamAQTzntdYvq/FGQfy1XiOaxKO+ewtmDtIEJonO7Lcs6MehzWYsPHFjXWO6vMcXKGCTsN4tTUZLTuioQGVZY8AdmpqtHaqYTvgtOWramHWfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQ/TZBzH8wkRxX/wU0UZ4Lp9a7lTIYuDKsiR3KNyjjg=;
 b=CdpLkSSSzphSubm8etozBRA6kmsGXDxRI7lmNs6CQXPv5jMfrEGPnDlR1pJvggFH3N8iX+3vH6dkUCln8FWKPZDSfiHm3I7SNDk+I9HK9wzwbqP1IOfOYHyCMzt+l2cadhuoRCxbogLeTe1iwOH7QFWeAb9i7UudcsmwuSt1w/tqSJc1uJpt6j9RhEsjpBizENVi527RbFhL/jWPEdh//lPLq4h5Gnl0syOT0qC2R6HAuXeuYv71mtHy8yEqEE7mKEMhvKmPhVTDYYlOu3SMMFuaPFCVGqWUaQzPiacXKkt/V9pzAgh7Y0SVq8vexZ5uwjynBvQIqVe+++hmtRZ2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQ/TZBzH8wkRxX/wU0UZ4Lp9a7lTIYuDKsiR3KNyjjg=;
 b=POTHSoTp0vlPPMOazB0XQ66Yb4/pqRGwu3w4vwXzSkIJtOOCcWM1YC573/opzYlG5RBZgd7aGd/9+tiILC0xrqcmQd0RwSxpTfPKyJVL2D/c27EobZy17femvtCRqX7U41YG3SgCceujbTeuCeaqVM1+hW3Lpwqk+GUzQ6NTq7DiNIJVesQQ5ziStI/AXWIlye2X/rCail2TM13IW2mr4dEy2QlFRfOrY8HIAWjuo1cN++IBjiqS1srGfCxq7hDdZCbRsVCUWWKZUqbOIGpOLCTcblVnPyCtcMn3qiwE8sPPfiRwVlEMgNCnfaoWlyc9WBKnRb4relQIXkVJATKbug==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB8PR03MB6012.eurprd03.prod.outlook.com (2603:10a6:10:ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 10:25:09 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2d63:5490:24b9:415b]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2d63:5490:24b9:415b%9]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 10:25:08 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        "benjamin.gaignard@st.com" <benjamin.gaignard@st.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "loic.pallardy@st.com" <loic.pallardy@st.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] dt-bindings: Intorduce domain-controller
Thread-Topic: [PATCH v4 0/2] dt-bindings: Intorduce domain-controller
Thread-Index: AQHYkevVQuji0mJdiUaO5T+/y7MyeA==
Date:   Thu, 7 Jul 2022 10:25:08 +0000
Message-ID: <cover.1657187536.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cb3deec-6dd8-431c-46e6-08da6002f7c1
x-ms-traffictypediagnostic: DB8PR03MB6012:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UdyXLYqfVipFS/1vCakWl+dPDvKvYzAKjGD3ZdCZrEROEmTC7ffJBHeEb9ZS95KKFWWCNL/JnGbSn/nUg1C2Vy5Gz3N1qTetd1oCn9FThUu4THq8ORzjkbl3wJHKv0CazKaF6I2m3wqZR02xv36rfMZrZRCorvI0MLGcfSIMQZOf9sno48dWz+8d+fWwpfcDorxLS3AlTPD0gX1O1A6+n74QzYyDIU9SzIOfT7qVL1v1C8AokS8arqe4A7qjXA+mkbiaiDxqJ8daZa1K+CTKyVmUvL9b450ZJWVIdMlnTMkryiVTstL+8Z7Obvg3Fiv3P6mGegnlBDDGIjoXWBq4hpwj8O3FExASlrcv//jNJiE0N5A9vMYxfKVeT9AG3vhEgKYBZmL26u6OEjdtdEb01pnUGYlxcqWLZ8W6jSRZkxM1KOh7WVA0p/Ro//9NDI7hN1Vl1ircOzbcqierlX0Ipqdr85zlybi+nfN3GiepyQulHRxxz9yRIUVu+8l6lprFtExqHt9nRRu8obyDnu227JmFV/KYIHz682/PBRGuocB+lsfRDyCYNP0MmTdYDYP3AG4vkA/CiSaXvzo0h9ha/HVWbfK2Zzjw/6Q486B6lngQr86PzOm3AvH86Gn/U9pnEiKp1RUmf0vmclS0chsaKKVsep1vy3VTD9BGRqBOznbrUkQTZ1FWALTkJc1gaPCujx81UXRAxFb+M3K/iFSU8Zn3vyBPYchheLcDygB+eAXt1ktRhIhnimBSfGkE+KCvLCNbFXpbG+dgIQ64Q1G4TniFfD1ccj3DoqabkSkdaAdP9r4ancZUM5nY341B3MHUOcV++b+R1G4Ab4huXfOA3tX5zDs4mOcUmvXMsac/XvY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(41300700001)(26005)(55236004)(6506007)(122000001)(966005)(38070700005)(38100700002)(6512007)(86362001)(186003)(2616005)(7416002)(54906003)(4326008)(2906002)(8936002)(66476007)(8676002)(66556008)(66946007)(316002)(76116006)(91956017)(478600001)(5660300002)(6486002)(36756003)(71200400001)(64756008)(66446008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2y0KT4Mgwc4tNbQ5X59hRoDubEGnP13/2E3jWiRJGOJpVLdslrRX4ohyZn?=
 =?iso-8859-1?Q?QmMYr+XmQ13ruGqRuJc/IF5hqb1XVL6C+If4xfMbN/7mhmJSWlH0kS034u?=
 =?iso-8859-1?Q?0iWbmcUsCPAGrNh57hPSREhtYpoaooEZtlf3Avi1qSe6X9jpOjdvyzErAV?=
 =?iso-8859-1?Q?3z9PthdvoGLd8q564yM75cB4wm1mXfXyK6xSTWkpOoUNeoVcbxJYvi6uSi?=
 =?iso-8859-1?Q?+TGmitYCRU5RbaFCQYBdtp4/qxpV3Y4oJiZU8w2nsoGcRmP8m70nmEv9wE?=
 =?iso-8859-1?Q?PHql0RIVALEbzLreqvFJrIg4bh5dIZX7X0ro5Peeyvwn6LHi6IVPD7Tuez?=
 =?iso-8859-1?Q?7e0C33msMKP/1Dmt1uwOG212upzt6wAAbymA2/Qe9QMksNC4oTUBhLBTj7?=
 =?iso-8859-1?Q?jS+JShIcuYEbm/B1yEnbJ1pirxtW1Yo7YeKIFiFrMF8NAPp4Zx/3B1QnK8?=
 =?iso-8859-1?Q?B2ZbR/0S9TdBPtRXcCv1CqWCkhdigBQyTRGcNVKlUxMn04okVPN16VkF2j?=
 =?iso-8859-1?Q?4fR1rBZgOeW3moHICCTjBb8l5zFAFjV2sajSW5il3DRcjdHQj+p1YGaGsq?=
 =?iso-8859-1?Q?XiJb4anfw/UbJWxlhi+wr/MapzybV340Ay+SFYO/4PZgnL6CKJL3eAeE5T?=
 =?iso-8859-1?Q?yl3m0rfgEjF6Pc6iSUVxsEaPr0/L9YXsdpPa2vpK38vf8B/861wO2hbOzd?=
 =?iso-8859-1?Q?lLpsksLabNC/T3Ue+2JNohhw3EfYveyxfEE92U2bb5akEgU9mm/P8hXA34?=
 =?iso-8859-1?Q?taJsohEHk3xSDDU6rnk6eaCeK37UHyiHndlJCW7/TEFSDiT9sEMOLGEnGF?=
 =?iso-8859-1?Q?P/xG5eqZ8MXZnnlQXiOtCmkg3LF9vLexag5rhdc6CMvxVgp4fCLohGqwgr?=
 =?iso-8859-1?Q?6++uwwk/3RgvCWrQT3DJQf6wxOCdNz+9IiVQSfczJ5bRR6eLuRD7qtjEZB?=
 =?iso-8859-1?Q?bvKT4BYCuXUO0ldOyLhKueNZfMMx9t86/B6zo41p6ngMbqoF+o+G/DkdEz?=
 =?iso-8859-1?Q?pFTLerf27K4lCU7aX5+SspmI1D5PaeYQqIzaZT4BHCba7qaSGujaEcZS4z?=
 =?iso-8859-1?Q?M0nl+jj+p4W5BRwuw3WhxLecMS6WY4I7UHzbw7qw2eoqRa/CmnM4FA8dPB?=
 =?iso-8859-1?Q?huEsOXvXYC8vl1gQtSDy6TlgZa4lT447qdhgSiEZNJGIoprI78i8hUDtDe?=
 =?iso-8859-1?Q?2Z6uyT/thaHlmJAfIlHVqswNRB/mYtYVr5Y6d4idumOR9zeUWzvaM3gyeQ?=
 =?iso-8859-1?Q?8+lCOabDGrOF9agoGkpphCp+xwn6Bbun3X8mHuU5bVDMArtpoSFzRzK+qc?=
 =?iso-8859-1?Q?kISrjEBwXTItnBlY34gQfsLASb0fKkYJYyrDTQmZ0lcST5U/iIYs+dg7al?=
 =?iso-8859-1?Q?3Vx5iufNbztX47AAj6wXC687tVp+lHuSB/8oqgTOmwua7H6J8A7AlIeAhI?=
 =?iso-8859-1?Q?44e1cBos7QvQOBGKejWUZqnWyneB+2UGPmsL7TFg8gKbagc2Ue+z7PEtpg?=
 =?iso-8859-1?Q?I1J+mpsnUQ9Dod+o6hJQIaxd7WfzHpL5ALF7MbIy2IWPfZitPzUbeq/Fx6?=
 =?iso-8859-1?Q?Gts2Vu7tDSaRW1dnWXslOmOwC89vh6myoa8vpgq7lytf0sbYWw/ife90hO?=
 =?iso-8859-1?Q?w1ncunrd3AYmv2T5sVbrVt9+BzR5racbQp6Xz51oSzGcI8FH5GIeKxGg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb3deec-6dd8-431c-46e6-08da6002f7c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 10:25:08.9030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nx4euIGvt5IJRANwp9unbuyI2g9ow60TCnxBNI1GjjJlwIK7PJXvfZyrKq17NFgKVvL2kCED7rhweR96crH+dgZI/qLquSY/s1SKgeHDTUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6012
X-Proofpoint-GUID: XG1IcycDazdoGlWkmJOHiTmAmCXjnU0u
X-Proofpoint-ORIG-GUID: XG1IcycDazdoGlWkmJOHiTmAmCXjnU0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_08,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=823
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070041
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing the domain controller provider/consumenr bindngs which allow to
divided system on chip into multiple domains that can be used to select
by who hardware blocks could be accessed.
A domain could be a cluster of CPUs, a group of hardware blocks or the
set of devices, passed-through to the Guest in the virtualized systems.

Device controllers are typically used to set the permissions of the hardwar=
e
block. The contents of the domain configuration properties are defined by t=
he
binding for the individual domain controller device.

The device controller conception in the virtualized systems is to set
the device configuration for SCMI (System Control and Management
Interface) which controls clocks/power-domains/resets etc from the
Firmware. This configuratio sets the device_id to set the device permission=
s
for the Fimware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 of =
[0]).
There is no BASE_GET_DEVICE_PERMISSIONS call in SCMI and the way to
determine device_id is not covered by the specification.
Device permissions management described in DEN 0056, Section 4.2.2.10 [0].
Given parameter should set the device_id, needed to set device
permissions in the Firmware.
This property is used by trusted Agent (which is hypervisor in our case)
to set permissions for the devices, passed-through to the non-trusted
Agents. Trusted Agent will use device-perms to set the Device
permissions for the Firmware (See Section 4.2.2.10 [0] for details).
Agents concept is described in Section 4.2.1 [0].

Domains in Device-tree node example:
usb@e6590000
{
    domain-0 =3D <&scmi 19>; //Set domain id 19 to usb node
    clocks =3D <&scmi_clock 3>, <&scmi_clock 2>;
    resets =3D <&scmi_reset 10>, <&scmi_reset 9>;
    power-domains =3D <&scmi_power 0>;
};

&scmi {
    #domain-cells =3D <1>;
}

All mentioned bindings are going to be processed by XEN SCMI mediator
feature, which is responsible to redirect SCMI calls from guests to the
firmware, and not going be passed to the guests.

Domain-controller provider/consumenr concept was taken from the bus
controller framework patch series, provided in the following thread:
[1].

I think we can cooperate with the bus controller framework developers
and produce the common binding, which will fit the requirements of both
features

Also, I think that binding can also be used for STM32 ETZPC bus
controller feature, proposed in the following thread: [2].

Looking forward for your thoughts and ideas.

[0] https://developer.arm.com/documentation/den0056/latest
[1] https://lore.kernel.org/all/20190318100605.29120-1-benjamin.gaignard@st=
.com/
[2] https://lore.kernel.org/all/20200701132523.32533-1-benjamin.gaignard@st=
.com/

---
Changes v1 -> V2:
   - update parameter name, made it xen-specific
   - add xen vendor bindings

Changes V2 -> V3:
   - update parameter name, make it generic
   - update parameter format, add link to controller
   - do not include xen vendor bindings as already upstreamed

Changes V3 -> V4:
   - introduce domain controller provider/consumer device tree bindings
   - making scmi node to act as domain controller provider when the
     device permissions should be configured
---

Oleksii Moisieiev (2):
  dt-bindings: Document common device controller bindings
  dt-bindings: Update scmi node description

 .../bindings/domains/domain-controller.yaml   | 80 +++++++++++++++++++
 .../bindings/firmware/arm,scmi.yaml           | 25 ++++++
 2 files changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/domains/domain-contro=
ller.yaml

--=20
2.27.0
