Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34404BF5D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiBVKa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiBVKa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:30:57 -0500
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D4115AF05;
        Tue, 22 Feb 2022 02:30:32 -0800 (PST)
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21MAS3Tu019550;
        Tue, 22 Feb 2022 10:30:26 GMT
Received: from eur04-db3-obe.outbound.protection.outlook.com (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3ecvxggbm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 10:30:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilVXIB5q0gDwE9P+fH4Hg495Iyz3ZE7COl+nZhb52Too0i+1YUp7DKs2p5z9XrOREwfyux6QDvEaPOa08Yx3yo1B7pjbMp1Y41iJFjkVR6AxwpuYahmu70HsQ0TQw54E07CimYf6hngrUX+g8OGCKh9ibVJyGPCApkdB4K0YNJVSWjQcX7X7vRybruqbStK86klwe+suecQsLxWD4q8vwaQvkYRAp3zB6cAwdtp/ocoTB5KgusL6lqfE5wzIGGV4U2c8FSu4RON1LTp/WCxA4ZDahkrecfNOoBQrDkfY89+5YaG57Bfb3L2TO7HDPLfH6lcCq9OKCKSJAAnB/YtXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieBIf2u1eyu1iua3f27va5bqPeiRQdxZqP4mdICqIys=;
 b=nakx/AOqsZCXTYt8aAj4ZPDUqj3RHuK5wsk7GNVK4b9wxqZ0L8XSk5ACDRopjT1jFIRLs1L37x6BenXzbsvQZWgRQaLCatJxjTSyNeHp3rCyjUEFUV4CvfBod3P+u6S6LuVZlIxLlT8jCDt9MSkvQfxmDgWKx03BWOt2+CLM01xfdPYKqTU1bY7HVfyEBxWdpBVlC/LdgORMBh5pWbGYRc3Pux+xr98czKdQ5ADh/gohWZtFJSdYVuZNgFXi31zLyzUrCoBrMo8ypMQmE4lTkjdVUtF1kedSbe9ZvYfgej1kXIXLZpOnFZvLHz2qF6ubLu6V5HPcRZP5i7q7tCfZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieBIf2u1eyu1iua3f27va5bqPeiRQdxZqP4mdICqIys=;
 b=p+42pZvod7zRym0AJKoflB47P4zbwlSvud4h10iQo9dmYoynmFqfBWBnIn+1rRDhf+/+pL0WHScX6MT7zkLFzGejtfoKIa1kKFGnZiKhg/5GDaui/fPEfZY0au4Nc+0kQG8r6tFOzCKL6/gazqK9tCEJXDlh+lFtieJ9E15tJw0EaYCJnRr4PDSPVj2SafbgSmirtY3yv6RBVCy6ACzAJeZKxrYfPow490Dj1ov4f3P47q1DfG3S3Ub1IEzT/r0lBcfJFWf2skPjNf/lLhxIyAsfpVXpd/T2Ujx3x8sB4/e+CC2f+pq3y+JOKfEL3lTfCEA64WvTgy9MwWtyWFke2Q==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB6PR0301MB2213.eurprd03.prod.outlook.com (2603:10a6:4:50::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 10:30:23 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 10:30:23 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Topic: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Index: AQHYJ0gzI98NnKSQaEaZikv/1tAERayefeSAgAAKkQCAAK8mgIAADbkAgAAI1wCAABGoAA==
Date:   Tue, 22 Feb 2022 10:30:23 +0000
Message-ID: <20220222103022.GA496631@EPUAKYIW015D>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <2546477f-4190-e838-3095-f47b31802445@kernel.org>
 <20220221213932.GA164964@EPUAKYIW015D>
 <7f17ab8f-429f-d2e0-8f5f-bfa2dd19cc49@kernel.org>
 <20220222085532.GA439897@EPUAKYIW015D>
 <e9ef5936-63dc-f959-13f3-6ab3e9bf140b@kernel.org>
In-Reply-To: <e9ef5936-63dc-f959-13f3-6ab3e9bf140b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff184e1a-ac31-4f0c-45e5-08d9f5ee5565
x-ms-traffictypediagnostic: DB6PR0301MB2213:EE_
x-microsoft-antispam-prvs: <DB6PR0301MB2213DE6ACADF77728354E39FE33B9@DB6PR0301MB2213.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gs1rueY+Xj8c4OjR0Y3ljOh0KmGnXDyFCeIrcS10V6Q3wjrTLssxg+igWLwSiQYR/ctMXnv8e+9dfiEOlRyDKJF9UCdvNQ2aJuFY8eNWIg2xp2H0RaINpD7/ewpQBVABvYu9fePDl1OeQz2/Uta3kjyJNlgGithlVnGen/nCuzBVJq8EWKOTlNeIJrkc6Iu2tw5suxEmWCjJ15JowPZ+hJENABjYnGhEYai1uhd9A+2kxOE/HpUK56jCOrHjp0IMzK92yfH4DwbtglwWPmdm7Cbi8BN8OXMy6uuBnai0fZoZiV6e2jNxNT/Uc2+n2aM7AkgvL5FFRLpjbdQu5ObGbohKAKNJ54lNQaBAB3aoECGsoQ3f5CSobBqfsYEQv7OXyhIK9B3L+R/WYe5tflg/wcy1I5BaEEPlZRrNTBeXppbNROyH5xRlQ30b6pi0dSiYrDPhb5Du4Fyzsxp1fLlC64GqLr13Ae/vxeW+n5fg+z28HLcbwFDYTLsYoFOIYOae4ZCmfOADYUu3/pf+9ehisHQn4VEjBfDqgjw3HiEW8v/uuHSjA4RiVzOb9vreMBbEqHIe0SO9q9h0FaoMWH/09r8K39N+Aqkl+QT/9mQ40cz/1WmkiILWUmFAJIkS15XQze6enSPwcbQpXdnA4Qx9+sFSzdds2TRW3vrH2p05FeFRBoboL55P0pNt3pRvv6/ZSn4VYl6AgwDMJXXlfvbmBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6916009)(33716001)(33656002)(38070700005)(86362001)(26005)(186003)(53546011)(71200400001)(9686003)(6512007)(54906003)(508600001)(6506007)(6486002)(316002)(66556008)(2906002)(8936002)(122000001)(66446008)(8676002)(64756008)(1076003)(66476007)(4326008)(5660300002)(66946007)(76116006)(91956017)(38100700002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ls5tsCz3UnIlA2Y4VXJsevLxaFSjtF9IZeIUqoEsU03Obsrl3IAml58oOVML?=
 =?us-ascii?Q?hTbWCumo3lX0mYJ5bodJzHgGck6jmeuEeDRTQZb/oRWqd6zWHXYBiTN+NpGY?=
 =?us-ascii?Q?npkiBTTOfA3+EfTKZA7TAdXGv5BmVf3tqp203m59I/E9GH4KnsPbgNaZIV5u?=
 =?us-ascii?Q?8nvWn6Ke39uKQoVNw23Tz+oqTTx3yyU7jSI4XL0LcldiGij2GT/2KP59TLvv?=
 =?us-ascii?Q?u7u60Pwl+U4uTyIvTd4YCw1Ji0mMRPoVcQXnt5cFNbhBiyVsE21BPHW8wibs?=
 =?us-ascii?Q?MAfIe257ZhrdV4cuCNWO0yMijZ8Rm3JeRFSGb3mcMkG1FTMWMlVhX/zzRLoh?=
 =?us-ascii?Q?Wzm78E8qV8bCB9KRlgQ5B93QcYbvvMM3k/ZCUDdRqlF7ElT16wUDi8JEYjea?=
 =?us-ascii?Q?tkUMaOIYCHy/BsW+IxrZlPvFiuEfEqj9nBDbxjWt6Uesi6RNt/l7IX/DAnJ9?=
 =?us-ascii?Q?Lc6Q9Sff0FN1tncOIfmNpmL9uSmtXdI+gTM2W/k9brzX6+0c13591pqhiPvR?=
 =?us-ascii?Q?M3v/Ww0hpAOXykaYB5IZSBWkt9No0zSbo2zRsR/zLq4v7lqdvNLiLP6l8jEj?=
 =?us-ascii?Q?a5O62q58lfthVQnPPZ5r+jVdRFGZIej9m9iBEXEtwng0+NxiFTLhMunAP9zT?=
 =?us-ascii?Q?u9Ixqv7wocYq3I2Jaoc7FNNKphrvAqJEDkcQXpT1CpodYJ2h3WE6VqwSE789?=
 =?us-ascii?Q?foxSm9VyRG+XQo0Ko8CwwBn+zsVNXMD6Bgcw4Fw/QUzi3EN1SWFT72mRTPrZ?=
 =?us-ascii?Q?el3AWhZaYTmXqF/0GPFKCrc2pJEx17KLTF7GAuzWIzJUx3gV72M31fybLFa+?=
 =?us-ascii?Q?08WapDAHnVen2zes51kfolGHUSDhksdo3L4jQ6LHv+FrvttuXwafw6Y56AxK?=
 =?us-ascii?Q?RI48fNpRLFx5apy7rPLz3TxSJFb1+H6KZajNIn78l//sG7a+WCKRoSIv7+2e?=
 =?us-ascii?Q?pV9ISBiBw2zezVnAgiynA3z3e5NGp7Z9mlnCYLAASUeHFPZ+3om+dEYP5ij4?=
 =?us-ascii?Q?GslPfjf2CvAq29v3fQGxrrYYXSFsyC8Sx05jHCUhyJkEglbvkaJsjgZmREp5?=
 =?us-ascii?Q?vFDbxG8yath19aRl/OlwCbnAg4icwkZ49Jh/Ft4KxlEa6cxxpDnFs8oA0+ne?=
 =?us-ascii?Q?lC7GLs1+W/onF7EkMvfEeA5TwQdxFndyNsa+VSP71fCdqgFiYyAjwHfKEi4w?=
 =?us-ascii?Q?DehHRCvAFwdIsvzs0x4UCzaarQvFFC/XkwH6ab3XABdZ2lewZnd+UHTXHiiw?=
 =?us-ascii?Q?d9BvaIxgGoKRw790Xt+DRTyna56ENBKE5pMfNZW9gP/o0y0xsN7k+8ccmjcZ?=
 =?us-ascii?Q?p0XUtmoL2HUbeGrr2sVNHNsioZa6aKR4Z3GL0M70nopTqRpT+wNAm1tflz77?=
 =?us-ascii?Q?lW3oETbGuaIFFepGblsaC+1dV3JRTZ/hefTpAXNXsz+6GVTsI6iPlJjwdVkp?=
 =?us-ascii?Q?vslbrbv/q9SE8eJSm2gT8qrVzewi6Fu0bY7JLW0Ig2zZ9VmBWD2mrygt+RK2?=
 =?us-ascii?Q?ODIjqHQXzTDa5aQEDjR7ZBSfIjYIzbiAFuHuwgC4arw1QYh8XfVhSnrewuMf?=
 =?us-ascii?Q?yr1sCPp1NarXs6+A/9eOYcKjFRql8yvP3eh3EmUeQIP68FociNu5NUD6WVlz?=
 =?us-ascii?Q?eY0Trn2O3oeZq6aa24vlwxLdX6/31OG9+W2hTEv8amUFGYb9nRTM/hGtOwly?=
 =?us-ascii?Q?yRo7ytlv7wSq4C78SDtnVUPoKdg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79C2AF3261A1D3419CF4BA5F0CCCE8DD@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff184e1a-ac31-4f0c-45e5-08d9f5ee5565
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 10:30:23.2576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icmKpKW/laPAu72Rl0lMoxxv7Hrp+hLURb16+Srx6r8F0o3PURKZdjJVu6LWp0GtAoMRwJnBSg6J9C0wFOpjcVk54wu6FG56aRfowjicpXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2213
X-Proofpoint-GUID: J2YKrbeuyn6lVnEyc3cdldh78uDVeVgB
X-Proofpoint-ORIG-GUID: J2YKrbeuyn6lVnEyc3cdldh78uDVeVgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_02,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=991 clxscore=1015 phishscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Feb 22, 2022 at 10:27:10AM +0100, Krzysztof Kozlowski wrote:
> On 22/02/2022 09:55, Oleksii Moisieiev wrote:
> >=20
> >>
> >> 2. Does your example work properly? Passes dt_binding_check? Reg looks
> >> different than unit-address.
> >>
> > dt_bindings_check passes without errors. Also I've checked this file
> > explicitly by using command:
> > yamllint -c Documentation/devicetree/bindings/.yamllint Documentation/d=
evicetree/bindings/firmware/arm,scmi-devid.yaml
> >=20
> > Reg value, if you mean reg parameter from an Example, was taken from
> > r8a77961.dtsi file.
> The check does not pass. You have an error there:
>=20
> Documentation/devicetree/bindings/firmware/arm,scmi-devid.example.dt.yaml=
:
> example-0: usb@ee0a0000:reg:0: [0, 3993632768, 0, 256] is too long
>=20
>=20
Probably I've missed that. I'll doublecheck.
>=20
> >=20
> >>
> >>>
> >>>> 2. Your schema does is not selected by anything. How is it intended =
to
> >>>> be used? Nothing is including it, either...
> >>>>
> >>>
> >>> The idea is to use this parameter to set the device_id for the device=
 in
> >>> the device-tree, which matches to the device mapping in the Firmware,=
 so
> >>> Trusted Agent can use it to the device permissions.
> >>> Please see Sections 4.2.2.10 and 4.2.1 [0] (Link was provided in the
> >>> cover letter).
> >>>
> >>> I'm currently propose the new feature, called SCI mediator to Xen-dev=
el
> >>> community. Please see link [1] from cover letter for the details.
> >>> In this feature - Xen is the Trusted Agent, which uses scmi_devid
> >>> parameter to set the device permissions.
> >>> We think that this parameter will be useful for other possible SCMI
> >>> implementations, such as other hypervisor or SCMI backend server etc.
> >>
> >> We talk about different things, I think. I was asking how is this sche=
ma
> >> selected?
> >>
> >> I gave it a fast try (dtbs_check) and it confirmed - schema does not
> >> have an effect. It's a noop. You need something like "select: true", s=
ee:
> >> Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml
> >> or this schema should be included by other schemas... but then I would
> >> be happy to see actual usage in this patchset (more commits...).
> >>
> >=20
> > I think select: true will work for me. I'll do dtbs_check and
> > dt_bindings_check after making all changes and prepare v2 if there will
> > be no further comments.
> >=20
> > Also what do you think about maintainers: field? Is it correct? I'm not
> > sure if I used it correctly.
>=20
>=20
> I think you should add arm,scmi maintainer next to you.
>=20

Should I update MAINTAINERS file as well?

Best regards,
Oleksii.
