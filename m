Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497054BFB30
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiBVOvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiBVOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:51:51 -0500
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CB9D995C;
        Tue, 22 Feb 2022 06:51:25 -0800 (PST)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21MEO0u1019526;
        Tue, 22 Feb 2022 14:51:20 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3ed1ja84at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 14:51:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y18iAJoGvT4wHqS21ZE/QlO+Xo+k9mcgyqKzIxMw8sS/NEaM9QaqxXP1g9UeRS8wToIr3YUNp/DtCDrchof6gQsEj6/o221xcnWcahAbbtpSjnvy5RRHycgJjIqWDlWQOy+nl38B4RIY9kgdx7UhWQ9dZnMjJnWPUaCYGHMhuCl0zDhqZJm5ucoQ8FlZYzvrBqVAxuOSh+El3gQSkHVGF7UCPHc7PzpReFOudJxbT2ZJahImPHUM6qc5rXMQJUdpqj95Uv5hfyW3ntBXiB95IpY57Jv1JgaaiMN9BXZSpq48nGzmLWQikCWEbEhXO4gyP97FOqOskL0Lm5sUYHkEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHIHpA29C12ceW9k+mO8CQbbvEjeNpYCzlFoR/aP/so=;
 b=YbfnbAiK2G3Ib+hIOROBaBnzqw3Sm5QKIyQNuN5/knwKizAUg784KEz2in1aD0jXTglxreKziHWDk8/1OsTey3LrMMeba3mvooTSiti+V+NSR+CrDfk73wZfyH9Fh/gume8Jnutpkovag3Ay3i6eTJKe/WS5rpwHY5bHDW9jJ+C8FXj/FiRFjKmspC8+2cIK4/Ym4+CDc9dbfS74wugr4GQ291vib3gGhLBGLYB/wofvTK406UIcnmDNcPqR9S6M0jYyUipxJns9F7KLNAOuXQadYKzIvlhjQ8svCGEgJVzfuDQTE5Ixb6+UGg/ARYZarCKWTKXwtABmXiH+RJmkIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHIHpA29C12ceW9k+mO8CQbbvEjeNpYCzlFoR/aP/so=;
 b=ahBUGI+eQg7tMxEv7aAk6h4UF89okh5ht3jivtMGNj7j58IOr3w1oNtr3AZT2fXwXP7zbSVK9KLw9SIpJNNIlouSRcKItcFdohM5E48zA4G0T5q/NckRWedseOxQVCpNxUQ7Ub7xGj1ZETc3p1zQmhu0HeG4St92C53D87mdcmnmRxrpeBTdjEo7m4Mqx8SAYe+kIZrnbXEtN8xZJaVdJjdIOpLS+ipYz9ReqPn0FJoV2VhrRxrxrUfeI4zt8NoowX7OZiMocpHC4PaxfZCiGcNfzZxlWNy7yYnWnU0y7CBKk1UlZhHEH0JFtCI4m6xIOG+1/P3dx2ZYnHSkD0kppw==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AM6PR03MB4551.eurprd03.prod.outlook.com (2603:10a6:20b:8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 14:51:17 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 14:51:17 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Rob Herring <robh@kernel.org>
CC:     Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [RFC PATCH 1/1] dt-bindings: arm: Add scmi_devid property
 description for SCMI
Thread-Topic: [RFC PATCH 1/1] dt-bindings: arm: Add scmi_devid property
 description for SCMI
Thread-Index: AQHYJ0g0zA4b1xgTn0m4ZMeiASfcF6yfoL6AgAAH+gA=
Date:   Tue, 22 Feb 2022 14:51:16 +0000
Message-ID: <20220222145116.GA2024457@EPUAKYIW015D>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <c751add9b54e9661e463ae265d8d5f0314eac33e.1645460043.git.oleksii_moisieiev@epam.com>
 <1645539763.068794.3016153.nullmailer@robh.at.kernel.org>
In-Reply-To: <1645539763.068794.3016153.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5111ab7d-91df-4e6a-c5cd-08d9f612c7bf
x-ms-traffictypediagnostic: AM6PR03MB4551:EE_
x-microsoft-antispam-prvs: <AM6PR03MB4551BD2C0D1ECD4ABB02DB3CE33B9@AM6PR03MB4551.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: piZO2pXZZkztRQhENOPoYa62bMOew8F6ZnVL1VqBtXdSJeSlM3G9GGX08ZG4rrqOPHt2V1oerSY3h952Dlywk/mOYP3e/8K5kfBGj63GVnSX36jpShIQji3mjlYIDRynnFS6nOUnI5IjGmctWIgrTjDLpBrZpktgvF0bcVirecSKhLjpPIcwaHZNF+xozxKwD6lV+7RAPYlDhiq77VLycOMPAk8SG07lJUlxTGCahnFwbtadWANu7acONanZocc3oAICzonTDSKWBbWxYNa3ws+BLIGjEDnOzMpM/u6OcxL0bhEV3irmCu69dYn9f+M2sfIwf5vBRyRC6cOOBLQXfLw1OGtcRVk05UW/Z8mUxnSMyY4XUyaLKPks2BU29Klx4OWqirNbVyfPNZ4XbS3AzDJjoXsEkd8uCrz85T9MWTeuYwKka2AIEhafxnlaNxBsI5xhXGW/JH6MZF/ZzvmRwTw0GFfPe9iii8QW4hXOFEOAAE4ogBxL8YK2cSWqiySLW4d6tsH7rQMKiFPIQRh4Jl0/cCIfhp+iGN14ccDP+xFrbNCk3XjBgwUm8lBZ1VElnDjZiS0i17rcnR+E3Gb2DWGbMNcQ0yn700CQFnE4bZaIl8ebZqerNZRRIscICPPldvtI58V8otUnny8TZgnkptqVGKo2UmigGXdTJTP43CN56aERLghgJp5IJiPkUgn4K2nMCeFLM5praWjK4+0utN7dKJG2fAPxymhu4q21NcvNiJr07uek2NtXe+tDnx4iQDysGbVLZsEjVFHF+KbjLTinWrCINwbIxSWKeayHbEM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(186003)(1076003)(6486002)(966005)(86362001)(4326008)(66556008)(66446008)(8676002)(66476007)(83380400001)(76116006)(66946007)(26005)(91956017)(64756008)(6512007)(9686003)(6506007)(6916009)(38100700002)(5660300002)(54906003)(71200400001)(8936002)(38070700005)(33716001)(316002)(508600001)(2906002)(33656002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gwsKhteK6n7VZJ2jtcsdXY9oBGPOyVR2LM2OHkr6tQYFhALKMjBHGn33Q+Y6?=
 =?us-ascii?Q?MN+VrnvMBfHOAGEiHNqbc1lyCywnzufTauKmbb4KJhaBrS7Kf8W39prAB+LB?=
 =?us-ascii?Q?7QGJVaaHtjETnPjOtn3FlrFFBM0sT3TusOt3MWwsahH+NjUMu1PB4g+3j3KG?=
 =?us-ascii?Q?osmMu7ta1UWClivriN5lTY3lo8Twm2UZA906DVX/cNCOj/esQXY+kHjlZfrQ?=
 =?us-ascii?Q?u2DVrhEN8D7SMaUxawaisuUGAp1oXziSbjfOrLLTDvqAbzM6AtJsn82OighP?=
 =?us-ascii?Q?JSldmCftG0Z5DQ/bHcPTnDyzI+iJUDlRm1yvp1HOtpxXoXQisvkg7sjIfoDC?=
 =?us-ascii?Q?TqmL2yJP8gCFCURkvvjfop9tHivlwK8MDDalk8TVT84p5ZZLTsO9Ih5YRYE2?=
 =?us-ascii?Q?kKKyHE9YgegZe/No99MZCTT7YnuP5cOBcLOui8LIH+hpNVIjWmI+0pCFwxKn?=
 =?us-ascii?Q?H2UxUCt1YOqDj9fDo0asAhFnbvuUjutuvk7ttRFF7bkUSpsbq6iOdmbShJoq?=
 =?us-ascii?Q?DCKRkumsQwGdx0Q7YETmoS3DyL1sHVcKnFmNUlGoKSBRSTPABzHDXNIzZsH4?=
 =?us-ascii?Q?oKhWEJEg99tRaml5rSvG6EdLYrZFV1lHsXK7MofhUVIzEasCRJZV76LD+vec?=
 =?us-ascii?Q?kadMKO9SrCMr6LnFXtzn+kBZy5fVqcILeLqiAZZ6PuUvdLDv2S4ip+HG41hL?=
 =?us-ascii?Q?M2H5HkkgoRqv8R1KDAsFyBCdKiAgC3Hzbd8gS7UQiVLoE78odXYutkFqZNjm?=
 =?us-ascii?Q?JhTIyFL2qVUV/KsKUAGBP/h7bpLc80w7R0dJ7ITgx0yQoi3gfbptCfY0rbWE?=
 =?us-ascii?Q?6HcecoGLvzx7xyRFBlRwIimtLaM9dUeingpfyaXeOQKG/D37MqgW7D7c97ca?=
 =?us-ascii?Q?n4f3jdA0lsLDGT4o6kyOqxLud3w14PQP2czpSzbqYRWjjxjuMMk7rmGk+MSO?=
 =?us-ascii?Q?Hggy3gcB8YkRdBqNy2cM6GE5orwMzz83p5wmao8ks7b34f4VKOMKkGd7dZnd?=
 =?us-ascii?Q?pnG7P10TTRMiSGvkoS2gOzEg3h2dCHYhSKQwwsCE0I9E38/F2AJ7AOyqD04C?=
 =?us-ascii?Q?7yF1GifYXJfNX32upW8q3pQ3r6M66nCRr4MbgRNMWeQQxrFLpWPeo2ihPpUc?=
 =?us-ascii?Q?6Y45zjmjg1d/O8UqjeCw9xRoczqn+PKX86VQIOqFGN1SjbV8URienkUbj3zr?=
 =?us-ascii?Q?hyKMFXeFV+Yhm9YvPzK4g7h3cy8HFla+inLA8zrz6IpN36SgCV052N8na2F9?=
 =?us-ascii?Q?2Nh+bishCgVmrWUh23dh19bxZ7GXBR6w10UyRM/KqRpAmzNZ+VW7Swp6XSrs?=
 =?us-ascii?Q?teOPBUK/EfBdWCy+9MtHSW1Un+obdL5IHZAdm/0+pTksp5+npGL9XffDrlLD?=
 =?us-ascii?Q?iIUTHM3V256dXrl9XvupcoL9U8hvt7OhrRQTa4tftsVEmlyLemHMA+pcspRb?=
 =?us-ascii?Q?prfcPcvHWbXPNHXFzoabf8cCr8vOIHcvrBjz4XwVm5MgA0+PqvZ2F2enSgg/?=
 =?us-ascii?Q?ytBKijzOCFBupT6nf5D+yRdFsC+xEIIa6aFGDWQmDiQrfqKWsTFQmWAB0XEi?=
 =?us-ascii?Q?ksy7pSQGC58H0+m5V8U7ruy/Sjj62MhH7ImZb04kf+25q/+TLpifysVg89k0?=
 =?us-ascii?Q?TqbwgSP/7TapmUZTRC7rbCiIlixswtR8zlKd5pCaraAaV7UGSZeANNuDdJYJ?=
 =?us-ascii?Q?iEzNVZ4Rgzey6zA6Ve8CQNrSAnU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3893D14DF7DD344AA0CABFDDEE3F3B63@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5111ab7d-91df-4e6a-c5cd-08d9f612c7bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 14:51:16.9776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q43Rn4YQyFRlpORl1eOPO9LmCP6TpKJC68CSVEYjuqesJ5l+yIcsOO5L9cu5bbMuIchOjp2VvRRJmobEg6h92krzNtTB+8nAd0Y6ivks3Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4551
X-Proofpoint-ORIG-GUID: 2ciFPhLH0-_e-YKlvg5laPSlsW0kG-oF
X-Proofpoint-GUID: 2ciFPhLH0-_e-YKlvg5laPSlsW0kG-oF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_03,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 mlxlogscore=783 clxscore=1011 malwarescore=0 impostorscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 08:22:43AM -0600, Rob Herring wrote:
> On Mon, 21 Feb 2022 17:26:47 +0000, Oleksii Moisieiev wrote:
> > Document scmi_devid property for the devices, using SCMI protocol
> > to work with clocks/resets/power-domains etc. This property is intended
> > to set the device id, which should be used to manage device permissions
> > in the firmware. Device permissions management is descibed in DEN 0056,
> > Section 4.2.2.10 [0].
> >=20
> > This property is useful for the virtualized systems, when several agent=
s
> > are running on the same platform. Agent term is descibed in Section
> > 4.1.1 [0].
> >=20
> > [0] https://urldefense.com/v3/__https://developer.arm.com/documentation=
/den0056/latest__;!!GF_29dbcQIUBPA!m_dudHGSVg6mys2GtScvkfHNbQ1mv2kCGeU2GEdc=
V_C0cqHoWuknIkJPdLTaKiq6Ed9f$ [developer[.]arm[.]com]
> >=20
> > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > ---
> >  .../bindings/firmware/arm,scmi-devid.yaml     | 41 +++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/firmware/arm,scmi=
-devid.yaml
> >=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firm=
ware/arm,scmi-devid.example.dt.yaml: example-0: usb@ee0a0000:reg:0: [0, 399=
3632768, 0, 256] is too long
> 	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg=
.yaml
>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://urldefense.com/v3/__https://patchwork.ozlabs.org/patch/159572=
0__;!!GF_29dbcQIUBPA!m_dudHGSVg6mys2GtScvkfHNbQ1mv2kCGeU2GEdcV_C0cqHoWuknIk=
JPdLTaKsRHUfCS$ [patchwork[.]ozlabs[.]org]
>=20
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.
>=20

Hi Rob,

Thank you. I will recheck on my side.

Best regards,
Oleksii.=
