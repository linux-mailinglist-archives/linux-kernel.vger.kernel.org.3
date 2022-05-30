Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95596538577
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242853AbiE3Pwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbiE3PwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:52:16 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A48AEE1D;
        Mon, 30 May 2022 08:24:22 -0700 (PDT)
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24UEFNPa016020;
        Mon, 30 May 2022 15:24:09 GMT
Received: from eur01-ve1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2052.outbound.protection.outlook.com [104.47.1.52])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3gcwnyrq3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 15:24:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJFvwRTZh5y74YMuHGkdIVSEOPvDmLeYOOPyQyTuoB18lD5AtpvQa5hoNE3qPlJVGOyk3ZZRlMHDda1vWkD3mjLR0hWHOrIMbVmkQVge3X9ib8hnaS5sgl5wzcS/sGzsRDOU0XkeK50DPYwgkaEvSKDlqdwpoQ68vd9kRhEOMN4AnQlkmFytHcL1x+hjJ2VseLWiT/y8uCO4c+j4KTGkBhwKZ8l0bucqd+zp1wT9fvGxnaC4/t2oM5/xXm305inNyiw2YzvihZlFyt+AVQFpcop3rM6Iu3tYLvXQqnEC2O+JFY4VJorZO/8+UKbGEt0M5bNcnN7qeXXTD+5yD1Bfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Beb7aPgNSQrNbzDhx+9BB59QSpANHQdrpqZ6X6WlaW0=;
 b=MRfebuLz1BgmZY8UAb2kGkHuNr5AFJqkz7xo6AuZ23SEZWt5qhpMr/qGRiExi1/mKF5J2l1kWc9Zl/Zr5HHBd9oKu7O172/gHcJx8N3emkygQTDKfzufyc5JT8K3qSu4XIyC//5VoWY91s4UK/Q1ma6oq96jZfLBj+OQcpB2eGRq7Rc7MmMAEsX9iAN8AgX5Wqw46c4cqnCNYCDjNBcbtHEKAx7yDf+Hx13ccm3OwQSyH1/kjvlmYBjtEb0wlmKpuNJC/I3Na3L+UWU7SSrmvgN1TS3ie802h0oGCUxntHPt2jg1+xjq0gdJuHwYu5HgMQCBL6uDJj4uzSBJE22ORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Beb7aPgNSQrNbzDhx+9BB59QSpANHQdrpqZ6X6WlaW0=;
 b=JotzPdldfgi9PMwt7KCjgoRUYDYHvYpUYdJsA/erocHgBO48cn+d2T8rgv65lWTWGwWXcjUsMq4cVViw1cvb2mX6krjCwNkDgFeIV7TGGJ01ffsNwEJCWy6JUYEB75sNxuyxU6qMiSJid8IWYhgtgX4SYGUC5q+EIvQCokDvbfLlTrgMXp9oDu0nSEAP7AF8oO6mStF6+Z5VVSNIiSelXtEuLkc9NDFH8Y5lxfHHqvju2I8xNzMAu6Qm/RqmBv8hJnDOUwmGMq+tn5ojk5DmBBi/ojtV2RXb/dCgyf9OuufWW7bkUnRpzvfILo57pFiiVoMtWWCnZKhXOekmHN10Yw==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AM5PR0301MB2529.eurprd03.prod.outlook.com (2603:10a6:203:8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 15:24:06 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::31b5:dfd5:2d38:c0b2]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::31b5:dfd5:2d38:c0b2%9]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 15:24:06 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] dt-bindings: Add device-perms property description
Thread-Topic: [PATCH v3 1/1] dt-bindings: Add device-perms property
 description
Thread-Index: AQHYYHKYED1XNg8RU02ShVh4atz7mq03sbOA
Date:   Mon, 30 May 2022 15:24:06 +0000
Message-ID: <20220530152405.GA887870@EPUAKYIW015D>
References: <cover.1651749565.git.oleksii_moisieiev@epam.com>
 <0adca4afdd5cffb978fb67ca13a6aa80f16aaffd.1651749565.git.oleksii_moisieiev@epam.com>
In-Reply-To: <0adca4afdd5cffb978fb67ca13a6aa80f16aaffd.1651749565.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 911d2ed2-2abe-42bf-74a1-08da42506f7d
x-ms-traffictypediagnostic: AM5PR0301MB2529:EE_
x-microsoft-antispam-prvs: <AM5PR0301MB2529F6A4134E89E2A00D7EAFE3DD9@AM5PR0301MB2529.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVNA1Mg+LvZuYo8wPx3fDYQvkIk33k+y50nJBDGd8cbnzmIr7J8j0Kv6TF0WpfO0qQcWFAdd4i6ecUFXptccVyscBlpGDKrPXjL+exRhZUac+LAuQ+m6n5CtY0nEkkoHZUmTWtA2WVpeorG21gYkLhpQ+rurRX8XbjNSQyA96cPUr35HGA+x1tw6KCkdpz702DbqXV5FcnuOzHIwB+ni2ymGenMD8Kn/3oktDbKTRWToseOV+Rza66FuVWKbLVRE4j9LG9yqJ+hsdSwta/S7D46SYu1dv53YIOz7VvUIhMvIHw3NftmXJrblHfutd6NRxtgZKsoAho7vrMButlwhYTsaVjcVLPZRF0QAAEZrtC5FX7qQ0XY8uFvdWxCuH8+DC3H7PVwpB7bTynGiGh4OYwOfBzrPMg7EC+sSgCroSIZLALarPWlhODI6tIsh5NmwhnN9T/75X/yYNaiW+AgEPhqz9wpS9m1rLuwWQ8d3goYOzM48SM+kA9jePfPa796bAtvCQQpB1wVgDdohfBmzZt1bnPxXwgHluiVM3AaTJ4Xrtz1tmE3uwC+aHSW/Rao+PgU9KzGj8kEmEC1VT6qY6Lmzc2cr1Nrc1mVN+sAZx0mAlbXb9QA4vReAo7xIe1mTlofCEsD+gFETKjXtTXUH4L+GeZ4nvSqa8rX/hPn0W44e26OutSbyjHVFxWd3viRRJoB+b8sa1JMQNJavuFYVY/4gA2dCtY7NYl6jZEWmKOBIXwYscsVCiddqCk0YRcmxdjw2rArI8uzIkPWsHTLloa2J1HO/jwbAAFoHv36i02Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(1076003)(86362001)(6486002)(9686003)(508600001)(122000001)(6506007)(6512007)(38070700005)(26005)(186003)(966005)(54906003)(38100700002)(8936002)(33716001)(66476007)(66446008)(64756008)(66556008)(4326008)(8676002)(2906002)(71200400001)(66946007)(33656002)(5660300002)(83380400001)(76116006)(91956017)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vFzLKMYTbwgTMXdIyFfeEomyS86EftskbrHPAPTYtuH4r7XPpfd78Zxzn4tx?=
 =?us-ascii?Q?nQZM5Df9MaHAm37KU6iMUH7Q5JPgwHAexN7HtqHwpzeYuErGgeC6QlYFY9Ki?=
 =?us-ascii?Q?X3Ay0EwTxBOuWV+n7HEcJZW3E6H1t2fhirfPJxxC+t81vYOGeTW/yq+milmc?=
 =?us-ascii?Q?pUUZBrzZaR7FDheHG1BMV82y7kuiItIlla2xMt8AapTEngkXgkuGnMh2FTlV?=
 =?us-ascii?Q?m/qrcwgJCyqw9eQG3RaWBE9DAwkPVBPfhl09e0uxKOjlHEIIqf8OfTjbZvuU?=
 =?us-ascii?Q?uZeGxe1apJgKtii26ScP+1xRhPMoMSplYmCsdq9uJAScMRQKcjirUVo17/Fv?=
 =?us-ascii?Q?ZYDTAEwbRp2ER9jPpJvqL/RQLfMR8ufZSjVPjHfEK7z/BTvCrUKwUwryh7Xm?=
 =?us-ascii?Q?6SV2l8USzJ7R37RoMBs6Xb6VycmwssNwgn42+htB7EFvIUHz8y4chVbvlq6O?=
 =?us-ascii?Q?32rM7s96XSr9TxbJHE4sRkUsVZNKaXSrpVjzF6+hr4Ph0LVh/rCJcJEHAQr7?=
 =?us-ascii?Q?sEU7Noh5avtjZVVxC5pUIk9EHx7gmwNWocsXI6Z43E/+CIHO1ajFlQcQIDrk?=
 =?us-ascii?Q?T+w+A3IYOTyeBWVuxaMrMghQ+7ek6JHFR+WfDrTPl81TgMFc2YugHh4xSuoZ?=
 =?us-ascii?Q?0SQZPuaHXLz1DEhgvcrHJdeL4DaOuCzUamzMkNII+p/8/m9fyBA13HQqwnWq?=
 =?us-ascii?Q?oCLMdnUxSi3fuRjjRi9EojF/MSaK8IdZUyqPS6zxNkYdo35sBBxMrATIITKc?=
 =?us-ascii?Q?EiHcDcS+1ZZ15CFDewlupHF7+gTC2kgjKmh2Wys329jtrYkctvKkCpZK2GlW?=
 =?us-ascii?Q?FCjnnEdRK2E3xxMovwILj+rmwDPj0QtHJAegnAsGo934iqBPWbwulbookNZx?=
 =?us-ascii?Q?x97Se09Qb1Vd2qR4WOHSac7jAZnaUJlQijzjojSrc9HHj+5FSfXSv8AjGUtg?=
 =?us-ascii?Q?0zWvkJhzo4wi2FMQOx1svqkdL/uzeFAdRS54wWBVmNxV6aAdlbXCgSGHPcE5?=
 =?us-ascii?Q?XnqduI5nGEqTZjDqs9Fc1CyabhVj5jWi761GqNm8VpJ1aYoytosgby0tcFXT?=
 =?us-ascii?Q?fvsKhtI5SEYK3rQPoXPjElZ1KR45UoPxJfgNsU7u9UvrUhDNRysJOLzW2UOo?=
 =?us-ascii?Q?8FoflQRFkQMqwc81rvxZlCKVTgQtR6MOIqcjKiqlRNvXReZduxP3Z25/neo+?=
 =?us-ascii?Q?Jl8306tr60Tc9JRRQFrPp6/wOZoW5xDTFjj/mipozll8mwLG+k2hYa3eEunD?=
 =?us-ascii?Q?V9vKfTpxIw4WG7pWq2YgGgfAkw1cXoJWJpR9VwDIUiK4vAViAPGjCAgQOMMl?=
 =?us-ascii?Q?6YOh7eZX62xK192Opvb1SSArJKOdPHXd/nico6JFIWPp3Ko5+cscvjiBW8PO?=
 =?us-ascii?Q?EftEuJh/g3E5KtGyaHHytANFokJ+tffzFnmbdQufMj3t27Uf0zf2jW9kStPe?=
 =?us-ascii?Q?aWsPNshywao2DzFwmJLsI5ps5Cmbbbvu0lfkq5qwEGFFb8NfMipLmhHnZQid?=
 =?us-ascii?Q?1OKbBfdRxFtGD1CPpJfnJzULMsf+failfXy4gR4YgPNK1rs8Ct/ATtsF5DN9?=
 =?us-ascii?Q?xLD06BxjeTwGAlrfxC0Qw40T/oZZisq6+2n8zRmvmsIw+2BVj2bei35dK8yn?=
 =?us-ascii?Q?gbPkKytJmnUfdql+tD/D8GzCaO3AFT/+vu3HIbQmeaOR1a9ASieG42xrfFs/?=
 =?us-ascii?Q?Xio9R0dQTUhc6gZ6LgqJMpcYMsq3BYTQ64qg0mKaR/W08BnHjsFcF3nybpeL?=
 =?us-ascii?Q?ypRJawLplNAJwJLnMUT9+SWlRqbHK/HHmBx58prRjSyLQIIoo/PO?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37150E89F07E50408E2F2D3C41CE8FDB@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911d2ed2-2abe-42bf-74a1-08da42506f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 15:24:06.1018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXbEzDOwM0HfUKzG58zGiov8fNStwBc7VCKtJtxULHNlGFIYNRoer1QGxl+M5IPo+cHnEjrwEfOCN6zJ9PHmzc0ZNDVK/JJ2HyC3nx13Hx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0301MB2529
X-Proofpoint-GUID: FEF4v7A90AuCXtqCEF1AS2aPy6YjTnhA
X-Proofpoint-ORIG-GUID: FEF4v7A90AuCXtqCEF1AS2aPy6YjTnhA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-30_06,2022-05-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=657
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205300080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Did you have a chance to take a look on the patch?

--
Oleksii.

On Thu, May 05, 2022 at 11:23:50AM +0000, Oleksii Moisieiev wrote:
> Document device-perms property which is intended to set the device
> permissions for the System Management interfaces.
> An example of this interface is SCMI (System Control and Management
> Interface) which controls clocks/power-domains/resets etc from the
> Firmware. This property sets the device_id to set the device permissions
> for the Fimware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 o=
f [0]).
> Device permissions management described in DEN 0056, Section 4.2.2.10 [0]=
.
>=20
> For SCMI this property is used by Trusted Agent to set the device permiss=
ions
> for the Non-Trusted Agents.
> Trusted and non-trusted Agent terms described in Section 4.1.1 [0].
>=20
> [0] https://developer.arm.com/documentation/den0056/latest
>=20
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> ---
> Changes V1 -> V2:
>    - update parameter name, made it xen-specific
>    - add xen vendor bindings
>=20
> Changes V2 -> V3:
>    - update parameter name, make it generic
>    - update parameter format, add link to controller
>    - do not include xen vendor bindings as already upstreamed
> ---
>  .../bindings/firmware/device-perms.yaml       | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/device-per=
ms.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/firmware/device-perms.yaml=
 b/Documentation/devicetree/bindings/firmware/device-perms.yaml
> new file mode 100644
> index 000000000000..5cf45f7f26d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/device-perms.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2022 EPAM Systems.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/device-perms.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Device Permission settings for the Firmware
> +
> +maintainers:
> +  - Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> +
> +select: true
> +
> +description: |
> +  The provided property is intendend to set the device permissions for t=
he
> +  System Management interfaces.
> +  An expample of such interface is SCMI (System Control and Management
> +  Interface) which manages the device permissions via SCMI protocol in t=
he
> +  Firmware. Binding provides ID for each related device which should mat=
ch
> +  device ids, defined in the Firmware so the device permissions
> +  can be requested by sending BASE_SET_DEVICE_PERMISSIONS (see 4.2.2.10 =
of [0]).
> +
> +  For SCMI this property is used by Trusted Agent to set the device perm=
issions
> +  for the Non-Trusted Agents.
> +
> +  [0] https://developer.arm.com/documentation/den0056/latest
> +
> +properties:
> +  device-perms:
> +    description: Link to DT node, which should set the device permission=
s,
> +        device unique identifier should be set as the parameter.
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    ohci1: usb@ee0a0000 {
> +        /* ... */
> +        reg =3D <0xee0a0000 0x100>;
> +        device-perms =3D <&scmi 11>;
> +        clocks =3D <&scmi_clock 4>;
> +    };
> --=20
> 2.27.0=
