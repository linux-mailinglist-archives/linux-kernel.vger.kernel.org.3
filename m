Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BD54DB6A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbiCPQry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348446AbiCPQru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:47:50 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50AF28E37;
        Wed, 16 Mar 2022 09:46:35 -0700 (PDT)
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GFnniQ024885;
        Wed, 16 Mar 2022 16:46:26 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3eujvp87t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 16:46:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUsJMyQ/NNs+uXG8IzZOkjJpTUvi4Orby13uzoyX+tcSFIbiTHv9CDhkDE7NUqSsq14hVti99lv10jhz2MmPjLoZNQfEepQbf6QDukK9ci/r8O/RPbNSkuhXyZtgrGw+RRK0Fggjicw+pRoDvvuEJ6QYegaA33fo23DsrBOtxeErCRt3pZY+aGoJiutWW1D9x6dMfaJ0DC6l9Gg6S7diEEtEPDaNlrM84TcoAaE1wpHvVbm2+cikj2cCEC2oZ8uA4AOG1CyVICdlkeJWxaONWO7yM+VYkuRV/mrBxz4/2dJQa8vska3+TvHg17INI4hMIqiVOz+pRdB6bUlGXWKEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+KEGKCPCSphI6iWgnTsxLJnqwEHq2k1wFvqeXx3Rg0=;
 b=hM5sb7X6GxPiYB/fTx59e8LYfSA/2/Pah6I61DsqkGnbaWqqyXIByRPjCOuzAqQxxOVtgNxCXUUQNPQvbQh2OCaLPCaGZkmEMiotz9JSkDXKmHUg6rZPAQcTH5UdA5rhxJxUQAXh6SA3EWATEd1SJu75Un9vBRWEIY4CMKGLVvtd++SLUzZLQ00C5ZIBWf5xkf3OBoGbidqj2IkjcWlVxSmophZUVr6pPFpNVjcUcbVFS82x7iQRexS3gIPp0fXC8iMFF4rtwxRL2MmMrWio+NTJohU2K+4fKWGgfCBFoi/tQneuj+OouI8c5AXXM1xEJ8NCF9gc3ldrVx3QViIzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+KEGKCPCSphI6iWgnTsxLJnqwEHq2k1wFvqeXx3Rg0=;
 b=mwinp5QvltB5u53wxLJaB8NhgtAPSfytp7rXjoIpe8RDGlZ2/f4ikz5ibF316NL2nUjl2UcPqdWKibDsSSjp2kocm6Ngl5HVDyXFUqT+ArpjKfQHLrCukMJD6Gib1QCQF9X0eCldHHF/kgdrj1JuipC+oGmLVw5O6u3mlRfxjSNi5YaknzcGOnbXI40G04ORkoneq7miFK2KvPy9qgqUNYYKyveL4kT69Cvsf1e4TEvUdQXO4S2nHQhKFlGv7H0hArBKQ0K1Abuxe6cAYNWE1RnZ5UCsi6Pt31O8PBRrB09JR1ZnId6M9dhXZrDEWMFP4R5PsggZ0duHArPlA/38yA==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by VE1PR03MB5326.eurprd03.prod.outlook.com (2603:10a6:802:b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 16:46:20 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::b12a:5b52:7c19:fbc]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::b12a:5b52:7c19:fbc%6]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 16:46:20 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: xen: Add xen,scmi-devid property
 description for SCMI
Thread-Topic: [PATCH v2 2/2] dt-bindings: xen: Add xen,scmi-devid property
 description for SCMI
Thread-Index: AQHYMfvS+PrMFPR+OUmb9ZzOrE/y56y17gCAgAxYwIA=
Date:   Wed, 16 Mar 2022 16:46:20 +0000
Message-ID: <20220316164619.GA3489934@EPUAKYIW015D>
References: <cover.1646639462.git.oleksii_moisieiev@epam.com>
 <5859bb58c8caf87985deb84d7f6bfc8182bd6a59.1646639462.git.oleksii_moisieiev@epam.com>
 <Yie47a4lqXjVzgxI@robh.at.kernel.org>
In-Reply-To: <Yie47a4lqXjVzgxI@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fa3db5c-277f-4e50-2736-08da076c7fa1
x-ms-traffictypediagnostic: VE1PR03MB5326:EE_
x-microsoft-antispam-prvs: <VE1PR03MB532698102EB1A7BEBB26545EE3119@VE1PR03MB5326.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ASQRMij0OFz8dTnStWujax1f+lFojug4qLtme+9Smwt8DWd1yjza8bn0IJkRijjxsdClJef83/BsREVvxcnTMgdE8Kx+YdW9n4oHIS1bemB7uKVYiVSfOcabi8ZQvDAmjUTfv3aqX1n9h16s+xyZsS0xOrA9tuBLk9RR3iD0iqii7NYiUgmWIcmmAol8oPlHyEsCzfB6MRw7tPksHNVz0+oeQq1e61oz2K+Ao+2OsSgonAohpH+PcHV1/s7t2Bka6P18LyhYyMhz6BTibuOh5T9jq9tmX7czoJVdW5RzCBWjU7rPrvQFHvswIvSe0VSdKmMEmn2+bOjpG18IXuGTpGgzmYA9aYqJlcombDrT6RkdLx2R3DhWt9tSbfYABUwQUgEKGraWpK22qw0THnNMRFXdTbD5hrrxz7hn8LZcq26C1grIDrFkDMZKaJqwL9b99zD95rDFgFajanDxnBm2iKV25A2uhlk8mddD3VaX2II0i6M5bzpjgPe9JQZdM4CCThTtVLwYl9g7Cx9XfT0xmG9CTvU19xviK/QzVe52fC++aUb/aw06boISWtV2Q/8zx7aB/rLTIlLoGX284v6h3f9PJBGmwEv/5DP2iViuOxL+BtSPwGGmwUegPmrDGoLyj6SAT8Wpi2JTlM80/YnZVaXCXQxaAyWgb0ysBWuljrC5dN5pQawZrb0Qdl4Vo02MNQk2iCivGT2Q76GDY0/zQGaXiiqupowx/Ql4dWH5+imQxBwOgKYgATmeZDn9kmdYLt2S0nvy+QOXKqcY7ZwziMraiD3krxxCDLJRy5SSnIg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(122000001)(508600001)(6486002)(966005)(8936002)(71200400001)(6916009)(5660300002)(2906002)(33716001)(6512007)(91956017)(6506007)(9686003)(316002)(55236004)(54906003)(4326008)(66946007)(38070700005)(76116006)(66556008)(66476007)(66446008)(64756008)(33656002)(83380400001)(38100700002)(86362001)(186003)(1076003)(26005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0vgs1N5W1bb5k09ah5mSoRn1K1yfH9mb61zGjv7aqk64F0w9ewlZ9FVtu5EU?=
 =?us-ascii?Q?aNlGk04sDnv66rlT7/lP8NmcOPQrEBGmWEb00UCPh+WWH9Lvnv9Gs5d/JZVU?=
 =?us-ascii?Q?ZavnFy9Mu0oqNJL+FN+0AFQNRXPJo9v2xmSrm1jFU6dv9xhXJEaK/MnVnYR7?=
 =?us-ascii?Q?AWtVDseHI56YgMc4tekk18tjQB7Hd1tcs4fAmmHg9cXZCd2iC+gt3womBd0c?=
 =?us-ascii?Q?QZudWF6TslPvPoqsFTYvTXukSJ/4wi6cZADd/wpSkKXvIfObQ16PhQr+h1kT?=
 =?us-ascii?Q?f+wD61OaOEtUXzBvefPU7dT1wKkiMOCD+2yZ6YueYG7dwkVH6GN0TAGetitr?=
 =?us-ascii?Q?chWFwE46bvL4y0aMaJJ5E73+ScPqYjJBLoxPz54rO3nAvW6o8dr7HVnKb8IC?=
 =?us-ascii?Q?HYDBSSbzzVNY5JPCUMJ8ApR2PaV9C0Hi7G2aBPsoSl8MNRHLc00DW/9Copr2?=
 =?us-ascii?Q?Fb+rK1i46eeEC8POpB7rvRnId17m7F8lIvbM+y91qCO988t9JDGLmQu3ADAy?=
 =?us-ascii?Q?F2sdLt18i15x6xcg0GzA24u4092crJ/IlTAyxbloD+10K+ByZt4Nxv6GfrY0?=
 =?us-ascii?Q?AaTR3UKksjYNcPAK7yoroxg2Szlr4ztkeY3cLD0IuCE6zTE4tS84KoAGH5lZ?=
 =?us-ascii?Q?jp+JG5rU6+27vmlkVF5U56hP1q0k4RJzcyTKB7ojuZw9FEmraKcFNCBldq42?=
 =?us-ascii?Q?Dx21T0/n0SDDVPBM+AAt5i2zn52D9ghumFFknaXo1drDlJGF1h1tY5Je4CnK?=
 =?us-ascii?Q?JpFxsSyVwwi/J2xkeli9HemR+tbnxfp0WpN5g1hYj5LbCNwdyZ3vgA+VpBoI?=
 =?us-ascii?Q?JwWsDX3CUS4ZJtLhCwmGLweGCaN4ZBLjpvMNfIXA2g2UHRrAB/I+p2HxIODI?=
 =?us-ascii?Q?eSEv75jfRRGZb6TR1TlbqDi4W93/oe3idJV/rRU6jIZKfJ7S5+8AbcJ3jAjF?=
 =?us-ascii?Q?XoYDSL8uGpCoseCbeNryTpveczZK1V1OXKUbOF5VqbBtiQ+ZegxdRArDo+7+?=
 =?us-ascii?Q?CHoD9VeRqIyMvMy40jX1kwtHVHC39kq1GNsjVDkmI2g5dDmy6O7EkbX/Gaph?=
 =?us-ascii?Q?yZy2P41g2SoCR2MoCv8vGolu6sM1Z8z8Ga3kz5e9e937+tWYBn7Qa9HVKYWK?=
 =?us-ascii?Q?GJ3ZlUh69cZVMT6Vswq6gUOOTqRIKw2ifC1bS2xLjBpIJuG8JNTKBHljR6Qm?=
 =?us-ascii?Q?xPnY20MQX8oUSCv81dkmIfWu19hmtYUOAEVmx4Lr5pcxZtYGiGUahUvnnL5O?=
 =?us-ascii?Q?MnSsGL82O+435cJwi6FCzVX+/AvJjK1L/zeihzAb9D8EczS4JtL0SYTA3kV4?=
 =?us-ascii?Q?sORTyniIUSAkJ5RhUFpDS+S6cuG6NRz76MqUskZCMtW33++zUzCtNTJRt9Xi?=
 =?us-ascii?Q?Ss/5J7qcfwgmPhHzLmz1WsBUVGRxXH9q/Oo1wc6L3CeDu5RgPbV2CA1rSpA0?=
 =?us-ascii?Q?Vjg6Af664iBXwY6ORI6YQtzxzTzTaQIBvEIYuB0pY3bVESIXa7FC5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0841B79E5C037B43B720E2A707FDA885@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa3db5c-277f-4e50-2736-08da076c7fa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 16:46:20.4695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLh6kROkjoZrqLJkNU3GfNbEJAhwZoYQVCyVXyd71410395L3GRPQRzsjey1+6A+Av3b+nZ7fqmw5UCithleYC2mUkUUYNFIXVcZ3rC6yjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5326
X-Proofpoint-ORIG-GUID: 7AY5MMDmcK46-Utj1GHfSioHuqQCCEE1
X-Proofpoint-GUID: 7AY5MMDmcK46-Utj1GHfSioHuqQCCEE1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_06,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Mar 08, 2022 at 02:13:33PM -0600, Rob Herring wrote:
> On Mon, Mar 07, 2022 at 08:17:44AM +0000, Oleksii Moisieiev wrote:
> > Document xen,scmi-devid property for the devices, using SCMI protocol
> > to work with clocks/resets/power-domains etc. This property is intended
> > to set the device_id, which should be used to manage device permissions
> > in the Firmware. Device permissions management described in DEN 0056,
> > Section 4.2.2.10 [0].
>=20
> If device_id is a SCMI thing, how is it set for other platforms and=20
> bindings? With clocks or power-domains, the device_id is the cell value,=
=20
> right?
> =20
> Since we don't yet have a device assignment, security, or partitioning=20
> binding, you've come up with some Xen specific solution. Given I know=20
> multiple people want some sort of binding for this, I'm not going to=20
> accept anything short of a common binding addressing the various needs.
>=20

Hi Sudeep,

On your email from 3/4/2022 you wrote:

> The fact that we don't need this to be part of SCMI OSPM user bindings,
> it is not addressed and can be considered as a gap.

> + The reason I want to keep it xen specific at the moment as we had some
> plan to extended the device-id usage in the spec which hasn't progressed
> a bit(I must admit that before you ask), and this addition should not be
> obstruct that future development. If we align with what we define xen
> specific as part of $subject work, we can always define generic binding
> in the future and slowly make the other obsolete over the time.

IIUC you have some plans to provide device_id support to the device-tree
bindings from your side. Maybe we can discuss some of your plans here
and we can come up with the generic device-id binding?
So I will have something to base on in Xen.

Best regards,
Oleksii.

>=20
> > This property is used by Xen hypervisor, which works as trusted Agent, =
to
> > set permissions for the devices, passed-through to the Guest Domains,
> > which are non-trusted Agents. Trusted and non-trusted Agent terms descr=
ibed
> > in Section 4.1.1 [0].
> >=20
> > [0] https://urldefense.com/v3/__https://developer.arm.com/documentation=
/den0056/latest__;!!GF_29dbcQIUBPA!kOUan6_nwTf375KaLzZxwHSYqYp1ptLUolUEoK-t=
3Wb4gsN3ajUC0qQBh6TdAMXQYrn8$ [developer[.]arm[.]com]
> >=20
> > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > ---
> >  .../bindings/firmware/xen,scmi-devid.yaml     | 42 +++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/firmware/xen,scmi=
-devid.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/firmware/xen,scmi-devid.=
yaml b/Documentation/devicetree/bindings/firmware/xen,scmi-devid.yaml
> > new file mode 100644
> > index 000000000000..49dc9951b54d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/xen,scmi-devid.yaml
> > @@ -0,0 +1,42 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2022 EPAM Systems.
> > +%YAML 1.2
> > +---
> > +$id: https://urldefense.com/v3/__http://devicetree.org/schemas/firmwar=
e/xen,scmi-devid.yaml*__;Iw!!GF_29dbcQIUBPA!kOUan6_nwTf375KaLzZxwHSYqYp1ptL=
UolUEoK-t3Wb4gsN3ajUC0qQBh6TdAPJC8yo3$ [devicetree[.]org]
> > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-schema=
s/core.yaml*__;Iw!!GF_29dbcQIUBPA!kOUan6_nwTf375KaLzZxwHSYqYp1ptLUolUEoK-t3=
Wb4gsN3ajUC0qQBh6TdADgb5MTo$ [devicetree[.]org]
> > +
> > +title: Xen SCMI (System Control and Management Interface) Device ID bi=
nding
> > +
> > +maintainers:
> > +  - Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > +
> > +select: true
> > +
> > +description: |
> > +  SCMI device_id property is intended to set the device id, needed to =
manage
> > +  the device permissions via SCMI protocol in the firmware. The device=
_id
> > +  should match device ids, defined in the firmware so the device permi=
ssions
> > +  can be requested by sending BASE_SET_DEVICE_PERMISSIONS (see 4.2.2.1=
0 of [0]).
> > +
> > +  This property is used by Xen hypervisor to set the device permission=
s for
> > +  the Guest Domains. Where Xen is trusted Agent and Guest Domains are
> > +  non-trusted Agents.
> > +
> > +  [0] https://urldefense.com/v3/__https://developer.arm.com/documentat=
ion/den0056/latest__;!!GF_29dbcQIUBPA!kOUan6_nwTf375KaLzZxwHSYqYp1ptLUolUEo=
K-t3Wb4gsN3ajUC0qQBh6TdAMXQYrn8$ [developer[.]arm[.]com]
> > +
> > +properties:
> > +  xen,scmi-devid:
> > +    description: Identifier of the device, matching device id, defined=
 in
> > +      the firmware.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    ohci1: usb@ee0a0000 {
> > +        /* ... */
> > +        reg =3D <0xee0a0000 0x100>;
> > +        xen,scmi-devid =3D <11>;
>=20
> This will cause validation errors unless xen,scmi-devid is listed or=20
> this schema is referenced in every possible device schema. That=20
> doesn't scale, but we don't really have a solution to that. For some=20
> common properties, the tools will add certain properties. If we=20
> come up with something common, we'll need to add it. Or we may=20
> need to come up with something more data driven where certain schemas=20
> are automatically added.
>=20
> Rob
>=20
> > +        clocks =3D <&scmi_clock 4>;
> > +    };
> > --=20
> > 2.27.0
> > =
