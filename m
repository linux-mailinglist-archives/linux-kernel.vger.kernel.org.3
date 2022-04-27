Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFAF511090
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357877AbiD0FhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242326AbiD0FhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:37:13 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B152E14CC03;
        Tue, 26 Apr 2022 22:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1651037642; x=1651642442;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aL6K7UCDQUw3L8hv5GTbt8AmUudFkgYuZh3aKLei0wo=;
  b=1OU6V/VjLh8lG3WLrp6ePRYjyDxBjghElCadfPItZL55dmyhW51PkYN6
   1C5uYkB5C5M5pj642Bc5/1oAgQcqqkhv2Ejw56BOB/GeVCwlpjuxaG+id
   k/s6wfWw3fVxoDlUxHowfd4h4ncEh3KOX2mEUDSE8DpDBHwXjXRsBl1j4
   4=;
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 05:33:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjvRry73RiuFOVQEuhc32NV3n51zoUuaWuwZlxc/5v+9O420tDTqB0ApYgODOLTwa9PQxPQsGd+4xATGAFfnOI7Gpc0cDHzk7fO5dgq7w1l275cU2KvVNMXsHdJq1/KV9E/dLA1Nb1yryqHNimECzJu6O978kH3n6bl6VJ6wUsK93A8L7pvD0k75aPcqBp/GadXecg4lOvzt6VztU/YoVl3/V02/3ihNsrOEYGKI0K389qXQhgd3Ic/luKuRHvBMeIBZpuPbP+xIZWGt1Etwg9r96efDFPSl6S8csjHazs9bErNert/LdAEcH4xzi3TawwpneH+kEyHutMk7cWgx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aL6K7UCDQUw3L8hv5GTbt8AmUudFkgYuZh3aKLei0wo=;
 b=ZL2R+yfSvQ1LA7SluNhgqC1lAVuhyYAePt8XqrlUDCYIMR0u7Rs6vpnLEHAQqP+o9Vu58d+1yawEYOeSFytNHY00pDbYlmr5WMccr6Nj+d9yqwV/3fKbYA50srm8oRO1W7Fo2+d15F4+dW3yvx831kwKW6amD6jnGwrgJ+e0Dq+Xhfq/ShNz7o2NpPS0W4oMbH3UN1GnFxVAXXdgVXIgtmRHIt2qq4kgq/l0PHlNdNkQp8Kz9WvJDSzBp8x3DZT2NpO6PdRZFRB1Ood0UoYqxqYBbf0SfcmObX7HYJOrB3I23UvGpX5RDPT11R/tR59iC86m97dbfDawKGEEBKiD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN4PR0201MB8725.namprd02.prod.outlook.com
 (2603:10b6:806:1e8::6) by CY4PR02MB3191.namprd02.prod.outlook.com
 (2603:10b6:910:7c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 27 Apr
 2022 05:33:56 +0000
Received: from SN4PR0201MB8725.namprd02.prod.outlook.com
 ([fe80::e4a7:ff94:cf7b:1447]) by SN4PR0201MB8725.namprd02.prod.outlook.com
 ([fe80::e4a7:ff94:cf7b:1447%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 05:33:56 +0000
From:   "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>
To:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "mka@chromium.org" <mka@chromium.org>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        quic_rjliao <quic_rjliao@quicinc.com>,
        "Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>,
        "abhishekpandit@chromium.org" <abhishekpandit@chromium.org>,
        "mcchou@chromium.org" <mcchou@chromium.org>
Subject: RE: [PATCH v4] Bluetooth: arm64: dts: qcom: sc7280: Add IO regulator
 handler in SC7280 CRD platforms
Thread-Topic: [PATCH v4] Bluetooth: arm64: dts: qcom: sc7280: Add IO regulator
 handler in SC7280 CRD platforms
Thread-Index: AQHYVLSpiaDjD2QRfUiyiBgfwN0pWaz9phWAgAWhRdA=
Date:   Wed, 27 Apr 2022 05:33:56 +0000
Message-ID: <SN4PR0201MB872525C890830DE9321AEE6AE3FA9@SN4PR0201MB8725.namprd02.prod.outlook.com>
References: <1650458740-16957-1-git-send-email-quic_saluvala@quicinc.com>
 <YmQcu2GVES4FuwFU@builder.lan>
In-Reply-To: <YmQcu2GVES4FuwFU@builder.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01976d51-3557-4e31-bdcc-08da280f8646
x-ms-traffictypediagnostic: CY4PR02MB3191:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR02MB319169CD914CE5B9C23456229FFA9@CY4PR02MB3191.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qJ3mdzXZucuLJEVk6a6i54kcfmKDZ+UWGSwhdFDSl8l7C6rV1TyufVKgk/95LPjiYETTcoN155zp39Q+LNJrklCNXYkqf+vAlN1XBrJVFX5ws89q8rIzU3UJZv90I1fXjqGd08PbNKaN9WY14eFsp039TYy1bcPYAHK8rAjHd4zqfo/VQL4Un23YiFgZ7TVkFC3N8mU4svFDakJoHqvQHbZ9ULXRn61p8qt0fqKVvmmCNM1d4x+8dHFpJGIslPEGAvrwTShxlkBR3jJKaD2qSIGwICyR06IXTQiSop4+OQpp+P98YELD+GEOmv6t5/DiFJSrbvYzofUk4gWZoNQuPiwLRqWbxUm05Fh+ugmWZPeeooH+6F+T7qHY8Hlw+iatCO0D5j8SoO7FGSTyIbOVWN/5KWQCnEGxDoSls/3kAi02CNYUgmWwipOKmA6QdIt2pZV0f27FpqCvuCd81wEgcPYfJMTkPzuvyw6425z3u3/9gPiZgnZRoIPh0KJAZgFRI15YFdgOScjpGjJKv9rRadW5UGqHaSZjYZd0tu0MGTv/F9e75xIiLT4P2bdtTSF8iMlEkBQvRKCBn8tMxrKvHyBcWBn9DM8XxUXST1XzTD3roFkNEVI67NVPBSqy9R5HTdlLAEbam9z1vIrYRokGKFPYovtVEvAqn8RbBffxhqQ2dCkyBPStL/YbXElID13F/Jrp1HKjKuaJhNEIoZEAhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0201MB8725.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(64756008)(53546011)(26005)(52536014)(9686003)(8936002)(66946007)(71200400001)(66556008)(76116006)(83380400001)(316002)(54906003)(6506007)(66446008)(110136005)(4326008)(122000001)(7696005)(38070700005)(38100700002)(508600001)(86362001)(8676002)(7416002)(5660300002)(186003)(55016003)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DnKRvYc13vrVljb6XUTRMKOGoZP41CS7U5ESBCYpBOUUZ4q2Ymwd6ZeCHUHY?=
 =?us-ascii?Q?byZua8InOhebpaxFD8v4k5H7vM2O8RB2qGIQGtg8Gnh5A+6Gz7HbrP3NQQ1d?=
 =?us-ascii?Q?Yq9qIliCEVBgabpd3hNutnbrnG6ISQj2ETzytyQjLHFW7K1ZCP2CFSyp2UAh?=
 =?us-ascii?Q?8rxapDh5DvTJnAyt4751F2xuO8umKHSFLWKEch2f7K8sSJfABBI66tOcccdD?=
 =?us-ascii?Q?EX6U9ZBDzVRiqk3RfQkP8waOGs0aZ2gVfEvU+XCKmxauT/QO6tBRv7uUt1sO?=
 =?us-ascii?Q?iXnwn4nINQ8WhnqEwt5/qMUpLBQpDfGVtBzya6AMUSoP/NY5e+TWdTS5paYF?=
 =?us-ascii?Q?SqBRi9oylw/gxbF5/YZkz/etkhKsdWfFR1KGn8IpKIRMOkBVYW3pZNxxVJ3G?=
 =?us-ascii?Q?i364vErO3g/Wu2Lq0rDt8/eKsKhthjDvWof0G2DxXLYkMH2I5gxKb5nbu2UR?=
 =?us-ascii?Q?LpqlAo5j7QK1U1qUGrGOW8dqQDou8XNdniL/lt+GsHQbtJunTU7mdS0D4Yfv?=
 =?us-ascii?Q?sAvShZjaDZiPFXDqXHaB1XDZ6Z1lM2zebTL1adebW1kUjbsrfRFvG9O933+t?=
 =?us-ascii?Q?lr8SeaqVf+q8O5GIQWUdEp67s2P6KzMLPJG4BtDwwOyNWH8FrPMc5y9mo+5R?=
 =?us-ascii?Q?7Fo8tqobjYLo5EvRaTIO9m0P9gVLJ/t59JLL5i48lWW6eRWVdWBPhFueR5md?=
 =?us-ascii?Q?0Ofu56uTj1DMw6N0bgPaMQJtkIKD7hKKnTEOSn954xKnQXOYjWZItdUvFmzA?=
 =?us-ascii?Q?eIdLcMQqUxH/CQrK1aTqJzJek08GTSlaPPuvPvv3yle7nT8uC9LAdJGctmWW?=
 =?us-ascii?Q?6g7dhP5PWjLc0hv4XeC6vDdZdlE3+qQTRMKrAMQNV6Cr1rE7oKdFPorVNkaR?=
 =?us-ascii?Q?qHmcgfhRo4ekX3Lclk1sPqs7IQAI2JkCaNH7YMoo0W63cFjIMWv6xAmeH5Az?=
 =?us-ascii?Q?gqYSZbAhzht63DB4pStsKduAmjgNfI5xzctk/ZslzOVgvH1v1K+P9eBshkhb?=
 =?us-ascii?Q?Lp5rixqLBDYx6sHbr69EeX5ZDM6/KuGT6gy4Ou0XMi62CbY1aC0kIdb9dOB8?=
 =?us-ascii?Q?P4WFXBupV53Bo1aKVzhSjM4UOpP0D1wDeiQtg96sYEo1Kt9uot++4Y2ZNrIV?=
 =?us-ascii?Q?DvShkyUQ2zca2AvRIPoRrL9XcLwiqGutgjMwAXIgPGkrq2L8fY7g8WVjygPX?=
 =?us-ascii?Q?4Ky01kahCy7HfJGNq5YSzK1ErgRm0G8opqqeH+cMAMD1u6MhT4g1dhnzm6gE?=
 =?us-ascii?Q?nOjLIRLyjV6baSk3peqZvn7lpL+vs5T5qWnYV4cwMpS7fDPFJP1kJe435uBf?=
 =?us-ascii?Q?YhS5COCywS3aSLKI4sTcNIdJjOkLNUALM8VIgX+7niSmorlxhvoOby3U+4KN?=
 =?us-ascii?Q?xlKiiKbs6qJ/VzddI8qQgKenY/YhcGWWuuX37DPxC2+QKAprNpGW7eBNGK9i?=
 =?us-ascii?Q?cBorsbY/K/nXnbKL6QklAu3N83zDp7m36eYMah9jgmEfoeXNjiCsaNKsgQYb?=
 =?us-ascii?Q?eOo3NLjENdyB1tUh5s8Y3oH0QhDok13F5cXWNrOSB7AqcfqhE/xyglJnEiJB?=
 =?us-ascii?Q?357V66bpcHcJEb9apQjCrR4vvmHtBle0Uo2JmwcKplwc/znZsLhCDiY/6+Ot?=
 =?us-ascii?Q?Jesge4jctTu57jUeik655vhHkUq+/5Lp3rpEnatRyE92vxYhFfCwRWUlC9mL?=
 =?us-ascii?Q?i3W5+3fM/R5P8PqLbjV3c8HBbjuI3mn3eNuE0kBAKs48WKVGgJDkEYn77Bua?=
 =?us-ascii?Q?RoWAqCp07g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB8725.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01976d51-3557-4e31-bdcc-08da280f8646
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 05:33:56.8281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUlb6QrofXuxMO2I3mHjafxHyPa2r7vygJButYEV0l+skUoYfkRiN1/IrdNu60whv9fS+Gvgl7u5P9myosQQDmIm26nsTRh0jp9leRcljFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3191
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Bjorn Andersson <bjorn.andersson@linaro.org>=20
Sent: Saturday, April 23, 2022 9:05 PM
To: Sai Teja Aluvala (Temp) (QUIC) <quic_saluvala@quicinc.com>
Cc: marcel@holtmann.org; johan.hedberg@gmail.com; agross@kernel.org; robh+d=
t@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-arm-msm@vger.kernel.=
org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-blueto=
oth@vger.kernel.org; mka@chromium.org; Hemant Gupta (QUIC) <quic_hemantg@qu=
icinc.com>; Balakrishna Godavarthi (QUIC) <quic_bgodavar@quicinc.com>; quic=
_rjliao <quic_rjliao@quicinc.com>; Harish Bandi (QUIC) <quic_hbandi@quicinc=
.com>; abhishekpandit@chromium.org; mcchou@chromium.org
Subject: Re: [PATCH v4] Bluetooth: arm64: dts: qcom: sc7280: Add IO regulat=
or handler in SC7280 CRD platforms

On Wed 20 Apr 07:45 CDT 2022, Sai Teja Aluvala wrote:

Look here:

$ git log --oneline -- sc7280-crd.dts
737f9ea6cee7 arm64: dts: qcom: sc7280: Rename crd to crd-r3 073a39a2a63a ar=
m64: dts: qcom: sc7280: Add pmg1110 regulators for sc7280-crd
3ebf11fa4a35 arm64: dts: qcom: sc7280-crd: Add Touchscreen and touchpad sup=
port 248da168fbae arm64: dts: qcom: sc7280: Define EC and H1 nodes for IDP/=
CRD 427b249504ea arm64: dts: qcom: sc7280-crd: Add device tree files for CR=
D

You have 2 commits specifically touching this file and you have 3 touching =
the platform. Your change touches only the single board, so it should match=
 the two.
[Sai] : Noted. I will update in next patch
As said before, your subject is too noisy, you can express this change with=
 less words. Something like "...: Override Bluetooth vddio" completely cove=
rs the "what" of this patch, in 54 characters.
[Sai]: I will decrease to less words
> As IO regulator varies in different SC7280 platforms updating this=20
> handler in individual platform bluetooth node.
>=20

"Bluetooth vddio in the CRD differs from that in the IDP, override it."

Makes it clear what area is touched, what value is overriden and why it's o=
verriden.
[sai]: will update in next patch.
Regards,
Bjorn

> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> ---
> v4: updated commit text
> v3: Updated commit text to reflect the change
> v2: updated reviewer comments.
> v1: intial patch
> ---
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts=20
> b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> index e2efbdd..6cbbddc 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> @@ -35,6 +35,10 @@
>  	};
>  };
> =20
> +&bluetooth {
> +	vddio-supply =3D <&vreg_l18b_1p8>;
> +};
> +
>  ap_tp_i2c: &i2c0 {
>  	status =3D "okay";
>  	clock-frequency =3D <400000>;
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
>=20
