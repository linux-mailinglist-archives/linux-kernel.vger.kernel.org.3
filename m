Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE6D50AB97
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 00:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391832AbiDUWmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383840AbiDUWmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:42:32 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2399F49248;
        Thu, 21 Apr 2022 15:39:40 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23LJw2ho020802;
        Thu, 21 Apr 2022 18:38:58 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ffqj9fa9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 18:38:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/VQtmvqLuGysD2cRoHCk2pfPfpBO5qNp05wrcaRXzYLSUZeRLpP6dLlrRL3a/r7C7hmjfqrDpQMiddJKihrr8ic7l0O7u5cNtIzRXNMZ/nNucZp/QvM6Teh1l3p3QVjQ25KlMEYc7Pjof5O2zTB52NroXtHEtIvOZccDOVmTp3EFl6IbpXEkmDplmuKOpurr0a69gjrHoA53BDSYXpYlNqkCoyqdUhFxKCrGQ0R1kgwXic8/GmOaj85MUeXblm833sYM0SHeq+Xi9gUtGVuiaQsnnG4kDS4pQjH9Ppcd41Do2TWTYgI6mAyguAN15H5ZMYWdO1C1MWT9Zkigc0BQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D42geyygYVn2S06u7+YqwEsyDPJV3C0Ge0hrfs3rKko=;
 b=fkMj/+8gyLt3ODkIWi2vfSHjdU4p6UqWB6JZT57Cm0Ic7C9BlbuTldOp1lmjovbpIAju7Tg0o79oLSJHQd7XKRWjnXj7Dvxk8EYkdZ/AlMIex5o4yIaQvxJjPruX1Mw/cA05mBQ5mxtyXGhyPSrsWEkRpEg6zWCJy+OVEHsavGec66kjFMLsukFcF5gO+bloAn1XcdWN+X5Z7DsRar8LXphOshe1yi0JVksN7il6p3W2/qj1fCo39m1five29EPe1G9Z5xwXlYzXIsulYcqnyvs/oXR7WLli4u1xXgy9jnV9SdEZ5PLI2xtW+M4crksfQGH7H/ySZ5b0uQZJptaZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D42geyygYVn2S06u7+YqwEsyDPJV3C0Ge0hrfs3rKko=;
 b=bw13l1/3oL1QB/VSSSlEr/ehyMoWg6VsSDH2wTHYBJ/9dvz+vx8ZQxSm9kUH1TwMGxFEL6VBZJKGuHeFAVKe4/VYvcb4P9yp50TIMVfgal2t+nlNf2ak8TU2BT6a/O7dwPlYBUG4i8DVwjD45DrRhrwHHBdPyA0BLuBkce2WKXo=
Received: from PH0PR03MB6692.namprd03.prod.outlook.com (2603:10b6:510:113::12)
 by SJ0PR03MB5855.namprd03.prod.outlook.com (2603:10b6:a03:2d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 22:38:56 +0000
Received: from PH0PR03MB6692.namprd03.prod.outlook.com
 ([fe80::1516:5b91:fe94:152b]) by PH0PR03MB6692.namprd03.prod.outlook.com
 ([fe80::1516:5b91:fe94:152b%8]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 22:38:56 +0000
From:   "Lee, RyanS" <RyanS.Lee@analog.com>
To:     Mark Brown <broonie@kernel.org>,
        Ryan Lee <ryan.lee.analog@gmail.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "tanureal@opensource.cirrus.com" <tanureal@opensource.cirrus.com>,
        "cy_huang@richtek.com" <cy_huang@richtek.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "drhodes@opensource.cirrus.com" <drhodes@opensource.cirrus.com>,
        "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] ASoC: max98396: add amplifier driver
Thread-Topic: [PATCH 2/2] ASoC: max98396: add amplifier driver
Thread-Index: AQHYUSqjJLOSFvxCl0+zgIPo7hfYUKz5AgYAgAHSnYA=
Date:   Thu, 21 Apr 2022 22:38:56 +0000
Message-ID: <PH0PR03MB6692FB5695AE82C3EE38E6108AF49@PH0PR03MB6692.namprd03.prod.outlook.com>
References: <20220416004024.210418-1-ryan.lee.analog@gmail.com>
 <20220416004024.210418-2-ryan.lee.analog@gmail.com>
 <YmAyLuZIT1zYfNeA@sirena.org.uk>
In-Reply-To: <YmAyLuZIT1zYfNeA@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ed7b585-82be-449d-1b66-08da23e7b881
x-ms-traffictypediagnostic: SJ0PR03MB5855:EE_
x-microsoft-antispam-prvs: <SJ0PR03MB585546C712CFF7818E819F2F8AF49@SJ0PR03MB5855.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nZMJ6qyuzDFGZq50E8MXzp62a6V1ZU7KUDgzZu9pH3deSi0gLk8JEI2kYNq7/BvELGAh3Fy/L+TtOVapSXkvz2Y8vEk+08f6iRfNFvNSiJX40NsFEkTEz4y34uoVJelQdX6RzkrSmhuaxJjCOC5NErdZM7WqY1lSt4SgpNi/cdgxo9yThsuU6Bs8H9gvUyIzUr2OnWNm38tHj3RhyLJjGpPxLRkBfL84i2Ym0pkEbKRzC+LwomGQxi5X16yy3o6SBw2qQ85u8XhtIZ/Dgtpoi8OcNN8W4N5ZIf/wHEA5SYT+O4LkrMg61qBOUbV48d4y0onlp7JC9qpuFGlOPn8bvx0T0EI5groqvXxQ2BhOpSVTFZi+yJcVxwE0mHPHO4965JEaheUVTaH9N2u1VhWisNOXLYms3+3bZbCTR5RxdF3PpHtUngdDJlNxgO71+fnGSPRzcUrkg+gi3V8bm6OjRA58ZKbisBe+8iafOda/fe2uYaUyv5Z7oYCbSiuuQYLcGR3Lq43XzEL0qvdokQwsMXSkcuQwHMtOowJppaAskQPW7GqlRBmV8G5raOTtOjeP19MWKTtEhjiFmUR4facuB7tXZpvcfM2UdgVVmFuHmEXswptHbQl96b+IjNeTRwzYQ7U8OGZzdKuAEvBJN+su/o2ksvGFkLE5mGqsXBoZQhWUNpHXGaFKtANe9bZY3cPYtUfgccD725v+xh+ZYjlgmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6692.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(122000001)(508600001)(52536014)(8676002)(53546011)(7416002)(26005)(7696005)(6506007)(9686003)(8936002)(4326008)(186003)(86362001)(316002)(64756008)(66946007)(66446008)(66556008)(66476007)(83380400001)(33656002)(55016003)(38070700005)(38100700002)(110136005)(71200400001)(5660300002)(2906002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5QUIy1Y9GXoIAEPRsTubozxWthQ+Z8LOM6i5siDZrqr5R+AFiLTKvOQo64bx?=
 =?us-ascii?Q?WioMi4ecTvkHp9vk0UwghjVOv14INmA2inqEGZvSqwr1LLvogHdNsvxU2Zak?=
 =?us-ascii?Q?JzOUbYbVSGkPAvU4KSmNurGoIOHshXuDBZxjE6RTeeLfKJa2p0rFYTnNTE8V?=
 =?us-ascii?Q?xQBMYQFo6O5F4QC7a+DmsBkTTc8s5UQ5mShufXifT/0BgnvE7QPEj5Ld8PxH?=
 =?us-ascii?Q?f7z9oqrtzyKkkqWspI78EnvbVNKJLpDdcHvGDVn8x3pAgMjVF6pNfRfu6QNe?=
 =?us-ascii?Q?oKG2JLybR3vySKtkkT0Cx9tfBT90Kk+fh67LvUl0MEroUrdehSSi0fV4Sm3q?=
 =?us-ascii?Q?vA5VCCqA9aWb7wh6dvqP3fxBoCoXRUHpo4I3k4UCjqXgF+cSkUV0CLkdvF76?=
 =?us-ascii?Q?Xd22wcoCZWoOmzuqar3bVi7i6maaSY0FouJgqgaJi+zI76K8Zbq9f2RVz1Dx?=
 =?us-ascii?Q?St2JhhI7+SFawYmrx6PH1UZN+U16dH2MBw2bBn4bOutimogupqVqEiZT9GZd?=
 =?us-ascii?Q?kzHJCN1okh9sFMHIZlr+Rctm7wh/aPwBr6CnVL09K8IPQxbgWszIiPO+3m3v?=
 =?us-ascii?Q?JluSb2ZWqWDoUAtfyZPNhLVIu/w1vxvpzXz5r+u0SBLPjuGh0xPNvoqgoPw2?=
 =?us-ascii?Q?bgZcoLwk0mOHqjNcwHqabeBDAvA73T+eNARmop/JlycKLY8SAMyB0UY9o02z?=
 =?us-ascii?Q?CyIm2cqVKiJB/SN3SAgPb+aRgRU2PFjWdaNtBbQBRi+bLuENIK6jE3tDszIY?=
 =?us-ascii?Q?I6hIs1KoY/rVNMOUXGJILr8Ivzypq3GK401ai3kUVD9YD8nJtW3KKbBr41YH?=
 =?us-ascii?Q?JtMIvp1bnverBl7s7L4L3NwxyOU/PyKjygGmJFbdlBP080TAGfYRQtN6dZOT?=
 =?us-ascii?Q?fxzc64kEH8zhePaC1beRnDOGNENgOc1a0qovCSbPHg7zHRHjUrd+VgCRU8+m?=
 =?us-ascii?Q?REamBSuV2RG/7CMZlpM8pbiPtmTYnAMn0GRVGwtYV6qKfMOa6drIztVHT+jz?=
 =?us-ascii?Q?DKgqk55y27LkLL+/rQySFNI9llNAe2+fqSOP9M/bQ4D0QBZd5wt9TJQ1QtQy?=
 =?us-ascii?Q?x8baK1FsIBhpvE2nR+AEC9lJNbw8HT2Y1gTA6L9Q4lPYZKaTdcCFkP0FoNWz?=
 =?us-ascii?Q?tin8EQeThpzI/kHtzrIjr/JqYLgm34Ttvq0X3P06NVS05ZeiWU4N1Mrwrfgh?=
 =?us-ascii?Q?mVxu+AwBAx84Lmc4eZYGxh8G76aac6Wtgc9AztdgvpMBSAh2q91VD1TNdjMR?=
 =?us-ascii?Q?Qs3WgeyAtEHzp2nJb3iSd6LAJtzF6Zsl3CW8WCIHfYgnLaYuJy7J4Qe26Z6f?=
 =?us-ascii?Q?UAuiDkTZquvqY+wR/vcoOwfGUbQCM+bh+qhdJRZNedLX3ZeKk5KVETNYPa2L?=
 =?us-ascii?Q?Ip9VKgDP1aDk2vmO8YaNzrrzexk+NC3q3zZOKUkDJaM2gl5Wl+7K8+gqzXMa?=
 =?us-ascii?Q?sJKmsTmNANWHhQivz2Ky3C9i1CrSSOUgsbd8dK8ONpy7urVP1qaUCPoypwSc?=
 =?us-ascii?Q?n8XnMoGiWm9o/iB83hbzIlZYiMKiQlUts4xvq09O8Ap4YB9jgxUY2ZFovpHI?=
 =?us-ascii?Q?ixsv4YRgTkkYwFTexz1iDseUeo1VLfqTpjdXQl1oU6dT/cErPMA0Kv9cOggb?=
 =?us-ascii?Q?qjbxTpb8umGiRrSyoMAT2TdAlghGq5nmjTfJaflfSoFQ87HsYmloehs6zFoH?=
 =?us-ascii?Q?LekZXL2fq+SAybNuvZNkYo+W0S3MlcchA97IwxLd1SfneZycq5W1vo4njOVn?=
 =?us-ascii?Q?MvI5MowW2A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6692.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed7b585-82be-449d-1b66-08da23e7b881
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 22:38:56.5608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZhugseY+5Q0Nb4GxRQO2bb7mCwQeg/gdbs07nhiWYkffNJroITDy61LXQs4MWCmTmY4lKOrSCOqRaAkUz/KwEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5855
X-Proofpoint-ORIG-GUID: oB3UhdGuYubW14nt3gEGbfkLy3o-Wp7R
X-Proofpoint-GUID: oB3UhdGuYubW14nt3gEGbfkLy3o-Wp7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_05,2022-04-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210114
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, April 20, 2022 9:18 AM
> To: Ryan Lee <ryan.lee.analog@gmail.com>
> Cc: lgirdwood@gmail.com; robh+dt@kernel.org; krzk+dt@kernel.org;
> perex@perex.cz; tiwai@suse.com; srinivas.kandagatla@linaro.org;
> ckeepax@opensource.cirrus.com; tanureal@opensource.cirrus.com;
> cy_huang@richtek.com; pierre-louis.bossart@linux.intel.com;
> drhodes@opensource.cirrus.com; pbrobinson@gmail.com;
> hdegoede@redhat.com; lukas.bulwahn@gmail.com;
> stephan@gerhold.net; arnd@arndb.de; alsa-devel@alsa-project.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Lee, RyanS
> <RyanS.Lee@analog.com>
> Subject: Re: [PATCH 2/2] ASoC: max98396: add amplifier driver
>=20
> [External]
>=20
> On Fri, Apr 15, 2022 at 05:40:24PM -0700, Ryan Lee wrote:
>=20
> This looks mostly good - some issues below but nothing structural.
>=20
> > +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> > +	case SND_SOC_DAIFMT_NB_NF:
> > +	case SND_SOC_DAIFMT_NB_IF:
> > +		break;
>=20
> One of these must be wrong - the device needs to know if it's
> handling a normal or inverted frame clock, otherwise the audio will
> be corrupted.

Thanks for pointing this out.
BCLK and FSYNC clock polarity configuration was inappropriate.
I shall fix this.

>=20
> > +static int max98396_mux_put(struct snd_kcontrol *kcontrol,
> > +			    struct snd_ctl_elem_value *ucontrol) {
> > +	struct snd_soc_component *component =3D
> > +		snd_soc_dapm_kcontrol_component(kcontrol);
> > +	struct snd_soc_dapm_context *dapm =3D
> snd_soc_dapm_kcontrol_dapm(kcontrol);
> > +	struct max98396_priv *max98396 =3D
> snd_soc_component_get_drvdata(component);
> > +	struct soc_enum *e =3D (struct soc_enum *)kcontrol-
> >private_value;
> > +	unsigned int *item =3D ucontrol->value.enumerated.item;
> > +	int reg, val;
> > +
> > +	if (item[0] >=3D e->items)
> > +		return -EINVAL;
> > +
> > +	val =3D snd_soc_enum_item_to_val(e, item[0]) << e->shift_l;
> > +
> > +	if (max98396->device_id =3D=3D CODEC_TYPE_MAX98396)
> > +		reg =3D MAX98396_R2055_PCM_RX_SRC1;
> > +	else
> > +		reg =3D MAX98397_R2056_PCM_RX_SRC1;
> > +
> > +	regmap_update_bits(max98396->regmap, reg,
> > +			   MAX98396_PCM_RX_MASK, val);
> > +
> > +	snd_soc_dapm_mux_update_power(dapm, kcontrol, item[0],
> e, NULL);
> > +
> > +	return 0;
> > +}
>=20
> This should return 1 if the value changed - you should get an error
> reported by mixer-test from selftests if you run them on a sound card
> with the driver.

Thanks. Shall fix this on the v2.

>=20
> > +	/* L/R mix configuration */
> > +	if (max98396->device_id =3D=3D CODEC_TYPE_MAX98396) {
> > +		regmap_write(max98396->regmap,
> > +			     MAX98396_R2055_PCM_RX_SRC1, 0x02);
> > +		regmap_write(max98396->regmap,
> > +			     MAX98396_R2056_PCM_RX_SRC2, 0x10);
> > +	} else {
> > +		regmap_write(max98396->regmap,
> > +			     MAX98397_R2056_PCM_RX_SRC1, 0x02);
> > +		regmap_write(max98396->regmap,
> > +			     MAX98397_R2057_PCM_RX_SRC2, 0x10);
> > +	}
>=20
> Shouldn't these be user controllable?  Most of the setup being done
> here looks system specific, especially the routing stuff.

MAX98396 is a mono amplifer and 'DAI MUX Sel' mixer control is provided for
audio mono mix. The chip default configuration take the left channel only,
so I wanted to set (L+R)/2 as default. The user still can change this value=
.
0x2057 is an extra register for the left and the right channel selection.
The user do not need to control this register because 'DAI MUX Sel' already
supports same function. Thank you.
