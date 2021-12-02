Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26191466868
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359591AbhLBQgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:36:04 -0500
Received: from mail-co1nam11on2041.outbound.protection.outlook.com ([40.107.220.41]:14561
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348040AbhLBQgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:36:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeAyEd9spInw7nEFWVaO0MI9cwv/KOx6kOInbvgBKvKyXZw1sEXGpfNeHWzxKbTj0cap06KOcG4QiFZ4eHCEzDcQ4cWIJJqbN/jGY9r5GZPV3tP0vmKf4rkHbpY22grk46ZSQDBjzIq0eSHCLXrueb1whJrBE2urKUxeKt1uF7Ef1ttb7CTdlz7cwKGk+d4favRqDYmAeo//3pVCG53nO4UsL5wDbXJOXvyR8OhITmf0gzWCajBAUrw1Gz4TjefyZqER7IlP3J8s2wwhxiZ87Oe26ytRIiGEblQNVedgx6GFF4GBFv5GQ7HYhYI8pe3THsw4A7kKbVSdCfxGU4uJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilK9o7/7SCNnpomZaqqTRpr6u0vMrcHAZvL/P7tU3p4=;
 b=b0+NqtW4AfyYqTe/59oPa6Q165sRxB46ZYPWb1rCsvdWTH7+zkQRdLStZjjsNoJrmbF6VLxwjX7duxZ8BxuoaaWi3/xddDKZ+/I3463zDNLTiuWVyut5GzycWo0pN1T8wdXa/kuVx47QligOTuShRgPucJ6yyIug4q00P6c0fEMP5Jxs4kL6dClyToOvUArH2nH7DWPLsYUqRuVAuDlfGrwmKMmGz3L1M72GbKgvvwpq8Je5quew12qloP2WATZ3JGvJlOSqn8IqSfBn1VKJ8JH728lw//u6vadj1VJbanjFAyquEprkptrNP/62BJpo7P2NGoOFGn7TNj29vYX+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilK9o7/7SCNnpomZaqqTRpr6u0vMrcHAZvL/P7tU3p4=;
 b=FJhDQvPgTpIDsi4RawInwrEaeNbA19gsFwJgOJGsVfddTpOm1qxckyuAFzMNtgsT21iGXUG1dbYjKMtaRAF2DEBoMyBQo5xhStJbTdRUTEyIOcIwaRE0ut3hJGbRgQ7A7P4ppqMfNYQhEERydf883eLXxpNiDZ/53q4YQC+clMA=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BYAPR02MB5144.namprd02.prod.outlook.com (2603:10b6:a03:6f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 16:32:33 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::8151:8728:8d6b:c3dc]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::8151:8728:8d6b:c3dc%5]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 16:32:33 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH v11 3/5] iio: adc: Add Xilinx AMS driver
Thread-Topic: [PATCH v11 3/5] iio: adc: Add Xilinx AMS driver
Thread-Index: AQHX4YY/MTM37/bNtkClNWx00Bidc6wUKOqAgAs8+uA=
Date:   Thu, 2 Dec 2021 16:32:33 +0000
Message-ID: <BY5PR02MB69163D602A61CE502527CE11A9699@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211124225407.17793-1-anand.ashok.dumbre@xilinx.com>
 <20211124225407.17793-4-anand.ashok.dumbre@xilinx.com>
 <YZ9+HxSRmT1XHld2@smile.fi.intel.com>
In-Reply-To: <YZ9+HxSRmT1XHld2@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2056ee0-43d4-4cc4-cd1e-08d9b5b157d3
x-ms-traffictypediagnostic: BYAPR02MB5144:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB514474CB6582361148BD575BA9699@BYAPR02MB5144.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bBrVCl7Shhs0BcMYZY5KsM8PkvIQBq4HoIH14z6GFbWtSuNL+LFO9mJVacIuU3PCK6lEVZ/aaUiirhS1FtrQOpEt5f2CP/SZ+fpVmOzG2QolJb5huDskvawlUy1juR0mkhdPhhZEWqRr0wkJepYQnMuNHKtK8DayQThvYIJeVmQl4I6iERnFRWdFjc/D43g/uQIWGjtIfhloZDQbEbarugQL9rjB4Ym07y9R0VUz3OHS3LIPOpEWnkw1HdPgRaK+nUH3qHuKAixyWKaaD4CW4bK95W6o4+ldF2VqSKR46QY9DIMGJkDp9g7xhtSvLHW6fIp4GXBSKpqO62gaGb3KdNAU6lnOEIaEoV+Trn2tLYrRxjwiSf7MY4tt4wMTr/fKenr0krTLCo+9kl5pwWenI2i7hBjc6AEBXskOPtjyhCiLnuhCHS2wQf8pFk35UvZXcpWxFMeqxBAP2JuVquemL3IMIwCUqz6f1MsoNQB4vNixsoKtAw8VbomPs0wI2GIANTViCQQPJgOTvjSj6zDjeysxYMannZMI5iDrt2AOoDC1aDVU1c8v6HYMgDLJuiH9jXNeW5yQQ5yC/soitE/Z0TR/dMr+JIcoL2lgBPxTLeV1L+b3VGPdvIz0Bnwhmj/Nb6Kdn9STUU8GjTWXxbteWP7u05WlUWS6iN92eowp5SioIuPlTgIx8yAs/NQ31GxjY6k9WkiU5Z4D+K2h7qOesg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(4326008)(54906003)(66476007)(6506007)(66556008)(52536014)(6916009)(8676002)(2906002)(66446008)(64756008)(5660300002)(71200400001)(508600001)(7416002)(38100700002)(55016003)(316002)(38070700005)(186003)(7696005)(26005)(76116006)(33656002)(122000001)(66946007)(107886003)(9686003)(86362001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3SaDqy7+rtDz32anuuWEa8YBXFoc9vfj23eSmehHXS/t4lhqF6+aUz/q5I74?=
 =?us-ascii?Q?Ks4o3dncwTraahCX8SEHoqPPOlym1kmVnR1ZgFwsS3tMXHVJhFpBtu0jgB2s?=
 =?us-ascii?Q?gZOcZycAGvI+jor0AmBA9SG9QHTFrFmrDjbYnN+dRAipTxNfcDmdxxhZSc8V?=
 =?us-ascii?Q?rmhJxUUn1q/6NRg3aI60M57FdxV7Q7aArZGYLv1c80v/hjqECg1M5yr1cgS2?=
 =?us-ascii?Q?zI+KGziIUy2aP/oJMZ7rSHysZXM4qd9khhb6T16Y4naaDcrYw3IDVCKqgt8R?=
 =?us-ascii?Q?9EC0d4OtL4QhhiivKRyRhqBkqe/+5BubPlgf94orL+hHqEkVJABoOi/xI4q0?=
 =?us-ascii?Q?yAAuxtbgTCaAaiUNEXQ+XgGyvCcXWtNBpnkSQS0JriTBFlGaZ8Gj+Yi16Oaw?=
 =?us-ascii?Q?1fQUkhg2LrVZxjW2AU6zWnVvAjYThQKpXbt8o0C7719OdmWGMZ+/uet7AAVz?=
 =?us-ascii?Q?/RDbM6+sHBvJbGY7MlrEdsIeIjCHa5u1niWmm3YZbiSJXT958JONSo7ezx4m?=
 =?us-ascii?Q?JByE0OYAIV5peCipW3vP90IXMLi+nZRh//GSF4WmWnezXLcfCo71TeE7yTrm?=
 =?us-ascii?Q?NrT5LZr5S0hiCEULGKao4bg5QFAQ28ft6CPJbQu6sTMe5ajtZlJGfq/FFP2V?=
 =?us-ascii?Q?lTR0FV2RXY3nvxq7QH/PJ6WtXc1fR22g1Ct3/13G4Fr3Z0LFTe3cIVVHhTQC?=
 =?us-ascii?Q?Nux8omnSwfKAAsBdzvtKTVJwo6hqC6ZkZxaaUwIru8DRZPWp3eTpmzv4q1+U?=
 =?us-ascii?Q?Db6fgVF1tUT77E21sdd552i1e/7C5y6HmlHtKWpLhcEtLuacT+mVjW25Y58s?=
 =?us-ascii?Q?iv0ySICNXbg36UOxEs9Zqx/VlwzgES0p30D56LeGsvEiTq2LNuO2QEJ8xUEH?=
 =?us-ascii?Q?Zor96mM6kLUh64z7JRCg9h1W4VshQAuMH+3Fi4R7gS9CwhvkZSG/Rolgdw+6?=
 =?us-ascii?Q?P3lDiXlzh+3fze3Sn8QLsqWSZkG8Nia7qwtohAUM7LCJb5LIi67PVuYSOq8F?=
 =?us-ascii?Q?Cdd/+RTal4koydyiCCXUDDwSvINLnKgoBjdwbjV7XdtUIh0IrMGU1SfkmY+b?=
 =?us-ascii?Q?Ys74bRDsDyCuInMpS8VJM7SLgSx2UOqFoT20uUyn3kAt2yEgKtitEn+EAO8J?=
 =?us-ascii?Q?kdjevOuHF2hT9ItaycsIZDQtn7vU1/OHZKKyOhQkyZhcrqLUasxvBjwJ70dn?=
 =?us-ascii?Q?mbpUrnEEHD8huUZomq9DqNx69iGy28JNsYfKUko6ZQ2bi13enjKQ6/Zwsm8z?=
 =?us-ascii?Q?HQkADWaz7PAafiRklqk1TXBGmpEu1rFw2Tn+IhU0CHY6IQxkHRuXy/JnI9co?=
 =?us-ascii?Q?1OsV2ZneZywo66RVTF+2YZQxSflze4oxpjk1qO8GORhUa+2an2xZV/KHt8ww?=
 =?us-ascii?Q?YRojtwxBgCs8SkcCSZ3tw+1VPGj05cT5jngC5k8E4t30DJNZBnsxlgqhE0Fr?=
 =?us-ascii?Q?V/A3cUcvSeN5BQ3GlbwFLERhYfuxMPRkJsGtkVRyplcSyOiqEhBc0eX16uqI?=
 =?us-ascii?Q?WM/24HUVRDPBzzFMJ2Bi/m4pIdXLOk8LhDdeIv6Ir+7kfGtz5GQyQk+kZK6U?=
 =?us-ascii?Q?EJSidT2tXp17XZyROmWNBZp2vtmdXC69m2bHW/k+Px0q+OLWd94vvkaBCXXQ?=
 =?us-ascii?Q?fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2056ee0-43d4-4cc4-cd1e-08d9b5b157d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 16:32:33.5567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JEUpcVoJ/ASf6FLR0ipnSAL5YLQ+fYuC4/TlAKh7u3JGvLNUoMjP5G/UXU9ojTT0vqz5yW8Ua3ivBDFM49Lk6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for the review.

...
>=20
> > +#define AMS_IDR_1			0x02c
> ...
> > +#define AMS_VCC_PSPLL3			0x06C
> ...
> > +#define AMS_VCCBRAM			0x07C
> ...
> > +#define AMS_PSINTFPDDR			0x09C
> ...and so on
>=20
> Be consistent with the capitalization in the hex values.

Yes. Will fix all instances in next patch.

>=20
> ...
>=20
> > +#define AMS_INIT_POLL_TIME		200
>=20
> Does it need unit?
>=20
> > +#define AMS_SUPPLY_SCALE_1VOLT		1000
> > +#define AMS_SUPPLY_SCALE_3VOLT		3000
> > +#define AMS_SUPPLY_SCALE_6VOLT		6000
>=20
> I would rather make units with these:
>=20
> #define AMS_SUPPLY_SCALE_1VOLT_mV		1000
> #define AMS_SUPPLY_SCALE_3VOLT_mV		3000
> #define AMS_SUPPLY_SCALE_6VOLT_mV		6000
>=20

Will do.=20

> ...
>=20
> > +#define AMS_PL_AUX_CHAN_VOLTAGE(_auxno) \
>=20
> > +	AMS_CHAN_VOLTAGE(PL_SEQ(AMS_SEQ(_auxno)), \
> > +			AMS_REG_VAUX(_auxno), false)
>=20
> One line?
>=20
> > +#define AMS_CTRL_CHAN_VOLTAGE(_scan_index, _addr) \
>=20
> > +
> 	AMS_CHAN_VOLTAGE(PL_SEQ(AMS_SEQ(AMS_SEQ(_scan_index)))
> , \
> > +			_addr, false)
>=20
> Ditto.

Will do.

>=20
> ...
>=20
> > +/**
> > + * struct ams - Driver data for xilinx-ams
> > + * @base: physical base address of device
> > + * @ps_base: physical base address of PS device
> > + * @pl_base: physical base address of PL device
> > + * @clk: clocks associated with the device
> > + * @dev: pointer to device struct
> > + * @lock: to handle multiple user interaction
> > + * @intr_lock: to protect interrupt mask values
> > + * @alarm_mask: alarm configuration
> > + * @current_masked_alarm: currently masked due to alarm
> > + * @intr_mask: interrupt configuration
> > + * @ams_unmask_work: re-enables event once the event condition
> > +disappears
>=20
> > + * This structure contains necessary state for Sysmon driver to
> > + operate
>=20
> Shouldn't be this "state for Sysmon driver to operate" a summary above?

I don't understand.=20

>=20
> > + */
>=20
> ...
>=20
> > +	u32 reg, value;
> > +	u32 expect =3D AMS_PS_CSTS_PS_READY;
> > +	int ret;
>=20
> 	u32 expect =3D AMS_PS_CSTS_PS_READY;
> 	u32 reg, value;
> 	int ret;
>=20
> ...
>=20
> > +	u32 reg;
> > +	u32 expect =3D AMS_ISR1_EOC_MASK;
> > +	int ret;
>=20
> Ditto.
>=20

Will fix.

> ...
>=20
> > +	ret =3D readl_poll_timeout(ams->base + AMS_ISR_1, reg,
> > +				 (reg & expect), AMS_INIT_POLL_TIME,
> AMS_INIT_TIMEOUT_US);
>=20
> Something wrong with line lengths... There is enough space on previous li=
ne
> for one parameter.

Accepted.

>=20
> > +	if (ret)
> > +		return ret;
>=20
> ...
>=20
> > +	case IIO_CHAN_INFO_RAW:
> > +		mutex_lock(&ams->lock);
> > +		if (chan->scan_index >=3D AMS_CTRL_SEQ_BASE) {
> > +			ret =3D ams_read_vcc_reg(ams, chan->address, val);
> > +			if (ret) {
>=20
> > +				mutex_unlock(&ams->lock);
> > +				return ret;
>=20
> Can it be
> 				goto out_unlock;
>=20
> > +			}
> > +			ams_enable_channel_sequence(indio_dev);
> > +		} else if (chan->scan_index >=3D AMS_PS_SEQ_MAX)
> > +			*val =3D readl(ams->pl_base + chan->address);
> > +		else
> > +			*val =3D readl(ams->ps_base + chan->address);
>=20
> 		ret =3D IIO_VAL_INT;
> out_unlock:
>=20
> > +		mutex_unlock(&ams->lock);
> > +
> > +		return IIO_VAL_INT;
>=20
> 		mutex_unlock(&ams->lock);
> 		return ret;
>=20
> ?

Sure. That looks good.

>=20
> Also the question, why mutex only against INFO_RAW case?

All other cases return static values and don't have register configuration =
involved.

>=20
> ...
>=20
> > +		switch (chan->type) {
> > +		case IIO_VOLTAGE:
> > +			if (chan->scan_index < AMS_PS_SEQ_MAX) {
> > +				switch (chan->address) {
> > +				case AMS_SUPPLY1:
> > +				case AMS_SUPPLY2:
> > +				case AMS_SUPPLY3:
> > +				case AMS_SUPPLY4:
> > +				case AMS_SUPPLY9:
> > +				case AMS_SUPPLY10:
> > +				case AMS_VCCAMS:
> > +					*val =3D AMS_SUPPLY_SCALE_3VOLT;
> > +					break;
> > +				case AMS_SUPPLY5:
> > +				case AMS_SUPPLY6:
> > +				case AMS_SUPPLY7:
> > +				case AMS_SUPPLY8:
> > +					*val =3D AMS_SUPPLY_SCALE_6VOLT;
> > +					break;
> > +				default:
> > +					*val =3D AMS_SUPPLY_SCALE_1VOLT;
> > +					break;
> > +				}
> > +			} else if (chan->scan_index >=3D AMS_PS_SEQ_MAX
> &&
> > +				   chan->scan_index < AMS_CTRL_SEQ_BASE)
> {
> > +				switch (chan->address) {
> > +				case AMS_SUPPLY1:
> > +				case AMS_SUPPLY2:
> > +				case AMS_SUPPLY3:
> > +				case AMS_SUPPLY4:
> > +				case AMS_SUPPLY5:
> > +				case AMS_SUPPLY6:
> > +				case AMS_VCCAMS:
> > +				case AMS_VREFP:
> > +				case AMS_VREFN:
> > +					*val =3D AMS_SUPPLY_SCALE_3VOLT;
> > +					break;
> > +				case AMS_SUPPLY7:
> > +					regval =3D readl(ams->pl_base +
> AMS_REG_CONFIG4);
> > +					if (FIELD_GET(AMS_VUSER0_MASK,
> regval))
> > +						*val =3D
> AMS_SUPPLY_SCALE_6VOLT;
> > +					else
> > +						*val =3D
> AMS_SUPPLY_SCALE_3VOLT;
> > +					break;
> > +				case AMS_SUPPLY8:
> > +					regval =3D readl(ams->pl_base +
> AMS_REG_CONFIG4);
> > +					if (FIELD_GET(AMS_VUSER1_MASK,
> regval))
> > +						*val =3D
> AMS_SUPPLY_SCALE_6VOLT;
> > +					else
> > +						*val =3D
> AMS_SUPPLY_SCALE_3VOLT;
> > +					break;
> > +				case AMS_SUPPLY9:
> > +					regval =3D readl(ams->pl_base +
> AMS_REG_CONFIG4);
> > +					if (FIELD_GET(AMS_VUSER2_MASK,
> regval))
> > +						*val =3D
> AMS_SUPPLY_SCALE_6VOLT;
> > +					else
> > +						*val =3D
> AMS_SUPPLY_SCALE_3VOLT;
> > +					break;
> > +				case AMS_SUPPLY10:
> > +					regval =3D readl(ams->pl_base +
> AMS_REG_CONFIG4);
> > +					if (FIELD_GET(AMS_VUSER3_MASK,
> regval))
> > +						*val =3D
> AMS_SUPPLY_SCALE_6VOLT;
> > +					else
> > +						*val =3D
> AMS_SUPPLY_SCALE_3VOLT;
> > +					break;
> > +				case AMS_VP_VN:
> > +				case AMS_REG_VAUX(0) ...
> AMS_REG_VAUX(15):
> > +					*val =3D AMS_SUPPLY_SCALE_1VOLT;
> > +					break;
> > +				default:
> > +					*val =3D AMS_SUPPLY_SCALE_1VOLT;
> > +					break;
> > +				}
> > +			} else {
> > +				switch (chan->address) {
> > +				case AMS_VCC_PSPLL0:
> > +				case AMS_VCC_PSPLL3:
> > +				case AMS_VCCINT:
> > +				case AMS_VCCBRAM:
> > +				case AMS_VCCAUX:
> > +				case AMS_PSDDRPLL:
> > +				case AMS_PSINTFPDDR:
> > +					*val =3D AMS_SUPPLY_SCALE_3VOLT;
> > +					break;
> > +				default:
> > +					*val =3D AMS_SUPPLY_SCALE_1VOLT;
> > +					break;
> > +				}
> > +			}
> > +			*val2 =3D AMS_SUPPLY_SCALE_DIV_BIT;
> > +			return IIO_VAL_FRACTIONAL_LOG2;
> > +		case IIO_TEMP:
> > +			*val =3D AMS_TEMP_SCALE;
> > +			*val2 =3D AMS_TEMP_SCALE_DIV_BIT;
> > +			return IIO_VAL_FRACTIONAL_LOG2;
> > +		default:
> > +			return -EINVAL;
> > +		}
>=20
> Isn't it a bit too looong for a single switch case?

I agree. Will move them to smaller functions.

>=20
> ...
>=20
> > +/**
> > + * ams_unmask_worker - ams alarm interrupt unmask worker
>=20
> > + * @work :		work to be done
>=20
> Be consistent with a style on how you describe parameters in the kernel d=
oc.

Will fix it.

>=20
> > + * The ZynqMP threshold interrupts are level sensitive. Since we
> > + can't make the
> > + * threshold condition go way from within the interrupt handler, this
> > + means as
> > + * soon as a threshold condition is present we would enter the
> > + interrupt handler
> > + * again and again. To work around this we mask all active threshold
> > + interrupts
> > + * in the interrupt handler and start a timer. In this timer we poll
> > + the
> > + * interrupt status and only if the interrupt is inactive we unmask it=
 again.
> > + */
>=20
> ...
>=20
> > +	fwnode_for_each_child_node(chan_node, child) {
> > +		ret =3D fwnode_property_read_u32(child, "reg", &reg);
> > +		if (ret || reg > AMS_PL_MAX_EXT_CHANNEL + 30)
> > +			continue;
> > +
> > +		chan =3D &channels[num_channels];
> > +		ext_chan =3D reg + AMS_PL_MAX_FIXED_CHANNEL - 30;
> > +		memcpy(chan, &ams_pl_channels[ext_chan],
> sizeof(*channels));
> > +
> > +		if (fwnode_property_read_bool(child, "xlnx,bipolar"))
> > +			chan->scan_type.sign =3D	's';
>=20
> Needless double spacing.
>=20

Agreed.

> > +		num_channels++;
> > +	}
>=20
> ...
>=20
> > +		/* add PS channels to iio device channels */
> > +		memcpy(channels, ams_ps_channels,
> > +		       sizeof(ams_ps_channels));
>=20
> One line.
>=20
> ...
>=20
> > +		/* Copy only first 10 fix channels */
>=20
> Be consistent with one line comments (pay attention to the capitalization=
,
> compare to the above).
>=20
> > +		memcpy(channels, ams_pl_channels,
> > +		       AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
>=20
> One line?
>=20
> ...
>=20
> > +		/* add AMS channels to iio device channels */
> > +		memcpy(channels, ams_ctrl_channels,
> > +		       sizeof(ams_ctrl_channels));
>=20
> One line.
>=20
> ...
>=20
> > +	fwnode_for_each_child_node(fwnode, child) {
> > +		if (fwnode_device_is_available(child)) {
>=20
> > +			ret =3D ams_init_module(indio_dev, child,
> > +					      ams_channels + num_channels);
>=20
> One line?
>=20
> > +			if (ret < 0) {
> > +				fwnode_handle_put(child);
> > +				return ret;
> > +			}
> > +
> > +			num_channels +=3D ret;
> > +		}
> > +	}
>=20

Will fix as many one liners as I can see in the code.

> ...
>=20
> > +	dev_size =3D sizeof(*dev_channels) * num_channels;
>=20
> Here you need to have an array_size(). Or introduce a
> devm_krealloc_array().

Oh yes, you are right.

>=20
> > +	dev_channels =3D devm_krealloc(dev, ams_channels, dev_size,
> GFP_KERNEL);
> > +	if (!dev_channels)
> > +		ret =3D -ENOMEM;
>=20
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

Thanks,
Anand

