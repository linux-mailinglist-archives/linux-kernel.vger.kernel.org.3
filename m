Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D894D9BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348605AbiCONQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiCONQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:16:28 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0641F527D5;
        Tue, 15 Mar 2022 06:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1647350116; x=1647954916;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OIS6Pl/gnu4zOjcUzNTo3rfVoVnzsEY3rwmylEv8lvo=;
  b=2CPMm8cKL/13KwyCRq/m1/V85dBxwfsSK6cpbHdFuWiV1xJSEI4Xr0hZ
   v7YTeJ7jfAUGFyc0zQEHZHTx+aMsFGoOvm8tqR6994iDEowgDvEUU5CeJ
   CjdwWDoPlNK9LT5QKN7wZw3dviArUcU3hoEznz6K3SUntqAIFddX6BeAc
   Q=;
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 13:15:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGsZxVK9HNXMnT6OSAddnYuc2cm6S1BBMOAvnSwGwfkjz4QkyOCb7a6omHM9bKDmfbTs3mKiNCxUK1iTUMN/j1dOYPr2vwgWCPDCybrrvRGDMUfyInlCZRtuOa61kUSkBD1fkV3UZRh2Nf7qgdAVbgr5DuLWkM6ntIPjlJYZ+1JiEEt48Nak3/93z6besrG2C2fj9+MSmr5O+ZuGnd5O38swmtWpxAshjEcoHAjgbSxqoBWXXNQcOp32vN6kCoimMsNwuF3NFT1R6D83aWoOdeaWQn2rFjBXx0SJ97Xbhxv43mawlFbw185T+iEXdEwjgyLWDXik5h0pxbBMeVLF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIS6Pl/gnu4zOjcUzNTo3rfVoVnzsEY3rwmylEv8lvo=;
 b=Fz+6SDg96a7ThrC4MViAXNRkSY+I09zXo7y0vOApZeNSG7b8itgeErrzrtUvvvO/O56sYTffKQYwMf2D5RFUarpHEF6o7+B97qEvlYbU2fRMWE9gKtTK7zfQ/vfBKEME/IWToXyLdu0D82rD1jqvXLTbSxNduVcBgc4bmjdg10PitRiwX4wNeFpbxOH5xqzo0rNhkTQU2d/IsggSBcaKImp6vyKmmL0l3SUQSbYLXeuzZtm69pLOSZQcQjfC3PUYJLtU1kDhrDnBEZTh4FUAfIDSOrU3CoSBjjREGp4SHF69hjHcVy6UkfyPrmPlA9hGsWUQ8PUwi3s6n24t/LJDsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by SN6PR02MB4960.namprd02.prod.outlook.com (2603:10b6:805:9c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Tue, 15 Mar
 2022 13:15:12 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%7]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 13:15:11 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
CC:     "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Asutosh Das (QUIC)" <quic_asutoshd@quicinc.com>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>,
        "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>,
        "Sayali Lokhande (QUIC)" <quic_sayalil@quicinc.com>
Subject: RE: [PATCH V2] arm64: dts: qcom: sc7280: Enable gcc HW reset
Thread-Topic: [PATCH V2] arm64: dts: qcom: sc7280: Enable gcc HW reset
Thread-Index: AQHYNI2HIzvw5NEH9kOzjXjDNEz/6qy5jqWAgAblocA=
Date:   Tue, 15 Mar 2022 13:15:11 +0000
Message-ID: <SJ0PR02MB844996EC94C9608AB3350673CD109@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1646923503-28847-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <YirIPRvcSSYhxiNv@ripper>
In-Reply-To: <YirIPRvcSSYhxiNv@ripper>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12aa012e-a1f7-4c1b-9b63-08da0685d610
x-ms-traffictypediagnostic: SN6PR02MB4960:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB4960A6034D83A445F0D9D3B3B1109@SN6PR02MB4960.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wFcKOKFy3g0mIg6fKFdHLHuDAAjQCOMMxkbfEaWmthzZOeXU6bkb5N5gNjrs1mW359HbYClG4wVinUa6J+gFuBSO78eRh1qo7V2/+dd1uWCA3Ac2cLGL2Voe7eAqjR6YCeA1X+x4VA1DXF391f8TjlxSYUa/H9E2L/IMpCfrpvbJpvt1cM4f1E48MeKu/dSIOgNP7HCPBqZqNUJ+QuBr1b++3GjHoCPAp+lKog5kdKrFc25Dnw1ow6x2r8SDk0sswQOIzXZZTimnM002Kp/e/7WKZ8jD0xIVxss64rPJoFKOdDBHe1cT5ZIZVVvW6OBGVLCTGb+WPCk72xKtKa15ePXZT0mS2DZUMbgxbEyaleZ406zyTfTCHMpCoxHIOya52hCQ7ZLAQ2Fi7VUqXFWG+p+xbDLfW/YOL1q9LEd+Bo3C5lzM9hY/7NmJomNS1EsS32DmG6lsCtAwtPLiS3zw8phRYMJo4WQbQ4pGvcEtNJfkdF2CHQdIdP/VL0q9uGPv2VlHMD8rEMnvOZSnm1M71fwudN3YC8RQ7Hjc+B+SY7X5uHWoinAjBPBZznj4AFSVwLRO/DPRFCx1v5aVHtaB9B7TNT/2MWy7iW/HpxW/Ib8gMdIiZPd/aXxXURHBrrpFDdeujqmuStA0sTpIVnPaa4fv9xB/K4jXYM8tZdIZWMFjq4gfJqenKlf10PiQ2HqUYZfsbkKRxV7CMNoWfrkJjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(38100700002)(53546011)(6506007)(83380400001)(122000001)(9686003)(107886003)(5660300002)(55016003)(33656002)(8936002)(52536014)(2906002)(508600001)(66446008)(66476007)(66556008)(71200400001)(316002)(66946007)(38070700005)(64756008)(86362001)(186003)(8676002)(26005)(54906003)(110136005)(4326008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GHEqUkefRno1fAsNhHsh9I/ZyCCiBa+z9zwy2ojnJ9Si9Fd5DdUAfigoBKl5?=
 =?us-ascii?Q?J5rpsl9GdH6YbZG0xXO0PkeZeD4+n/gPbwP7OWxy+oO3b1XxFmNc4Oekjw3t?=
 =?us-ascii?Q?2NCXKhDSfgr+m6mX5toKjVe2pdbv9UvwND9WBAoRqp0747jSWTwczi+I4Ail?=
 =?us-ascii?Q?frkE0jlmJPWy2Xb53W1HwjLbSLbGqulcp9BqhefQ/XPM273i13yZU5xp6DSs?=
 =?us-ascii?Q?Vbp/2Scz5nGRnxPNI66c1uJv3MWvmsSXxM0MwvU0ZTy9VoqFLYiZ0VpI7x6B?=
 =?us-ascii?Q?44SG0i6SExsajXEDwv+hBkeCNkmkm+8b+YAWYX0vPnL3kMSGosVtRzbmSSQw?=
 =?us-ascii?Q?+vOFdutCunbGHbtAGAZX44xeyBbys4ZVTp+uFWdA0il1jhNOYiUvCq2Ftjj6?=
 =?us-ascii?Q?bJ3P4ynJhHS8ezst4ocqaUB+R9GRmChl4OTuXvdvKWElePvgbhi04jClsAYZ?=
 =?us-ascii?Q?65T9rN6kMuDifXTIbKC2kW3tcltr6eM2/XXqzVO0oBPYEidKusc9LInuzZo4?=
 =?us-ascii?Q?Xb59f4UI7awT64E8KC7A78JPwme34kLAd5qIE8sO9e5N7RfJY8VN5rHv3MzL?=
 =?us-ascii?Q?UCyRplTQ/rZRM9btyPivo2WztJzRac310URTipsfTTx1H0t48E0gbyPfVGn3?=
 =?us-ascii?Q?CULfG3jwUUCpfdItWlawtmP5NDQhZm/vE0h8XvyZGf4VLNXej1XiZ37OXM9p?=
 =?us-ascii?Q?eNXcPFODLE27HgIa68HWfjVVVrqn/i9/7eSBpwc9vOfSwLpcOUl1z+3iAtri?=
 =?us-ascii?Q?N+XDe5toVeaQ0W7gl4sAW2QcgNFjFhuo5y0SFkyVLvU8US/1jlfvOlYch6Vn?=
 =?us-ascii?Q?CMz+MiuPNjiRC0VQJrW9bao8oah7KIUFCS7TXbAhy6HFj47bQcLM8woB4zmp?=
 =?us-ascii?Q?du35cJeVQRUDYZNy20AJ3KRqJr9X68TIHzo1MChyAWQnoX0Y9Ygr64KnmvkZ?=
 =?us-ascii?Q?C0phujvAyeqMo06W9dzFuihjE6RECoye/WaWF3F60eLAJFjcQEGimZH0XajR?=
 =?us-ascii?Q?zG/NL8NeAMKwYtrbWzb1h5HrJDMLIPGVmRKKUKd1Y+3wqEcwyC7If982jgKR?=
 =?us-ascii?Q?2N2xB4xFlY8W0uz6AhTs2wNmY7e4hkCZvFgPrbjMfRgtXGwbE0puGZZ63Lhw?=
 =?us-ascii?Q?qUNGFesZyWLKyND4JlWE7Y/mQxzuS6DlSVGW55gX5ZLI5GHHwIaHJARDfdUv?=
 =?us-ascii?Q?y17RcjeN96TjZZsqt62X2VwM7K8nG5lnVVLhAh+QCTJ+bb/8F4Cdj4uM2tPS?=
 =?us-ascii?Q?6uQNiTVAZfDzTK2drC0Oe338524qUrdAfpCNYD4Gxu7/+LvlKgdbWtSgnY7j?=
 =?us-ascii?Q?4XrG/sKMED2U48eHhdZp4+j6D4mIr1SdB4+05QGDINzzLtdX+5sGS+ON5Q9U?=
 =?us-ascii?Q?gLxA3FjWCI44TG5zB6GmnYyc0iuIFiYdox6Zeyc3kwXb4t/t9+ywI/pm5sAr?=
 =?us-ascii?Q?OVAoGZVwzaDAXgiovRO3WbEIoUy4LSbu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12aa012e-a1f7-4c1b-9b63-08da0685d610
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 13:15:11.2552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MdFiBZgITsxe/3lltuNgNnc00c16CH6XqnetfaMxIaO7yPzeyn7019Uy+/5KUIhgAZJ4ly1nKjgZgcTEa1HBsjvfKVuREevLOAZbGuDrVss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4960
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the review.

Please find the inline comments.

Thanks,
Sajida
> -----Original Message-----
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> Sent: Friday, March 11, 2022 9:26 AM
> To: Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>
> Cc: krzk+dt@kernel.org; agross@kernel.org; robh+dt@kernel.org; linux-arm-
> msm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Asutosh Das (QUIC) <quic_asutoshd@quicinc.com>;
> Ram Prakash Gupta (QUIC) <quic_rampraka@quicinc.com>; Pradeep
> Pragallapati (QUIC) <quic_pragalla@quicinc.com>; Sarthak Garg (QUIC)
> <quic_sartgarg@quicinc.com>; Nitin Rawat (QUIC)
> <quic_nitirawa@quicinc.com>; Sayali Lokhande (QUIC)
> <quic_sayalil@quicinc.com>
> Subject: Re: [PATCH V2] arm64: dts: qcom: sc7280: Enable gcc HW reset
>=20
> On Thu 10 Mar 06:45 PST 2022, Shaik Sajida Bhanu wrote:
>=20
> Without looking at what Krzysztof suggested, I think $subject should refl=
ect
> the fact that it's the reset of the two SDCC controllers that you're addi=
ng.
>=20
> Something like "arm64: dts:qcom: Add resets for SDCC controllers" would
> allow me to grasp the full purpose of the patch by only reading the subje=
ct.
Ok Sure=20
>=20
> > Enable gcc HW reset for eMMC and SD card.
> >
> > Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> > ---
> >
> > Changes since V1:
> > 	- Updated commit message, subject and comments in dtsi file as
> > 	  suggested by Krzysztof Kozlowski.
> > ---
> >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > index c07765d..721abf5 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > @@ -881,6 +881,9 @@
> >  			mmc-hs400-1_8v;
> >  			mmc-hs400-enhanced-strobe;
> >
> > +			/* Add gcc hw reset dt entry for eMMC */
>=20
> When you read this comment 2 weeks from now it won't add any value.
Ok will update the comment.
>=20
> > +			resets =3D <&gcc GCC_SDCC1_BCR>;
> > +			reset-names =3D "core_reset";
>=20
> Doesn't seem that this binding has been converted to YAML, but the .txt
> binding doesn't mention "resets" and I don't see a reason for having a re=
set-
> names for a single reset.
>=20
Thanks for the pointing, I will add resets entry in dt-bindings in next pat=
ch version.
Just followed existing node formats:
         Ex:=20
                resets =3D <&gcc GCC_PCIE_1_BCR>;
                 reset-names =3D "pci";

> And please keep the empty line before the opp-table.
Sure
>=20
> Regards,
> Bjorn
>=20
> >  			sdhc1_opp_table: opp-table {
> >  				compatible =3D "operating-points-v2";
> >
> > @@ -2686,6 +2689,9 @@
> >
> >  			qcom,dll-config =3D <0x0007642c>;
> >
> > +			/* Add gcc hw reset dt entry for SD card */
> > +			resets =3D <&gcc GCC_SDCC2_BCR>;
> > +			reset-names =3D "core_reset";
> >  			sdhc2_opp_table: opp-table {
> >  				compatible =3D "operating-points-v2";
> >
> > --
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> > member of Code Aurora Forum, hosted by The Linux Foundation
> >
