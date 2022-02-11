Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D534B2764
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350652AbiBKNtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:49:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbiBKNtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:49:06 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504D4EB;
        Fri, 11 Feb 2022 05:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1644587345; x=1645192145;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gzJKIqt1pDf1nuQihWfkue5wgkCs47I40sJtkMrn1ps=;
  b=YnDQXKaoeJX5Kw0HnW+H+aBncGG/hnKqzlL5hqIT8x6UfztI8cFMIeIS
   eYTBdAo7MgXa8M6yIXofaSl6uCbi/+uu1UtYADcQZmdzdH0kzbiYaoTDY
   0EHuiTxifufESUCib1J4BG5CnjG64oMMG5ZrZR0yTajwy6tpLBKN1a4fI
   k=;
Received: from mail-mw2nam08lp2170.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.170])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 13:49:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQYH1yCDYFyHWsDgCG4vA2x3wvul30E/vMAAeSpZYrO2iu3Dp0stE8U9OiE8NXg1DiqFTMJHBg5vK7V7nQEdWPoKW1ZvVH6Hm/63EVNuy2RGDPSiwexeTOXfY5uszbDXzh1+ysu2XfXKzr+yW1cJNzDA+ZByv23tSzK7Y8lGXxtjMhB6wPY6Qd6VSdd+bOAVTnMsCrm5Dl62SZAdTvhTXZ8Ipb/yAD+6HtkMCUmtYMrOexdhWHngfFVI6zX5aEeC8TujJnGQ6LtLNnPBDv8QP5wiZpPgD+VXYj429v+kWf3ncgiOXm6lXBAp/qccpTnvpZKvOCHulLwwUWT1fVov+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzJKIqt1pDf1nuQihWfkue5wgkCs47I40sJtkMrn1ps=;
 b=W2Cx1hz2nZY/ujeY5lsNHE0pXDCC1K3pM7BFJNxDDEh1SGzebS80DxejuvvUJt7Azb7lMz4dNRjeXif9M4BuCPwWMqkALSF3EFEWvR65eljhaxmeEcnen1H3QopJdCvrJ+4UwcmoBcQitiAu/Aaure3+xuusXWY4irL3yk6a6Bz5sG0D5UxTYxxqknrXeNjCVIxm1YSDHmtP9nhi5JbxG45j3zqa/FXFc+5AN6gZOXTU209+dWh+GmKzPWzKOEt2VaO0hv0v4ZG/dPSCoblFEmPpiUx9XPspmMhJKfoWhQGYL/ESaCy0McUBplhrtEJ3m7TvBuP9382k0ZXJj8Fbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN4PR0201MB8725.namprd02.prod.outlook.com
 (2603:10b6:806:1e8::6) by CY4PR02MB2453.namprd02.prod.outlook.com
 (2603:10b6:903:6f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 13:49:02 +0000
Received: from SN4PR0201MB8725.namprd02.prod.outlook.com
 ([fe80::45ac:4918:6d01:3009]) by SN4PR0201MB8725.namprd02.prod.outlook.com
 ([fe80::45ac:4918:6d01:3009%5]) with mapi id 15.20.4975.014; Fri, 11 Feb 2022
 13:49:02 +0000
From:   "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>
To:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        quic_bgodavar <quic_bgodavar@quicinc.com>,
        quic_rjliao <quic_rjliao@quicinc.com>,
        quic_hbandi <quic_hbandi@quicinc.com>,
        "abhishekpandit@chromium.org" <abhishekpandit@chromium.org>,
        "mcchou@chromium.org" <mcchou@chromium.org>
Subject: RE: [PATCH v2] arm64: dts: qcom: sc7280: setting the vddio supply for
 Bluetooth node on CRD
Thread-Topic: [PATCH v2] arm64: dts: qcom: sc7280: setting the vddio supply
 for Bluetooth node on CRD
Thread-Index: AQHYHN0JCTQRi4S5dky48gKpz7KY6ayNheAAgADcoxA=
Date:   Fri, 11 Feb 2022 13:49:02 +0000
Message-ID: <SN4PR0201MB8725606835F55D90A4F50FDAE3309@SN4PR0201MB8725.namprd02.prod.outlook.com>
References: <1644318803-14950-1-git-send-email-quic_saluvala@quicinc.com>
 <YgWwNiLDCZ0jEV30@builder.lan>
In-Reply-To: <YgWwNiLDCZ0jEV30@builder.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 470cc0bc-0406-4615-d86d-08d9ed65431e
x-ms-traffictypediagnostic: CY4PR02MB2453:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR02MB2453F006D5BA1E7D1C385E4C9F309@CY4PR02MB2453.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2TnY2JsVoaKfiUJkgxCGXP/Db0aMwEBO8mnTiw0aHIki0xyEx5AN4I5EX2XnsB8KKgC+p8shzeAcjtIij4E8sNozA4/kaVUrpBSxHBTcRQP5RjH2pWWrzHsaHsbbgEawX2FmWzXvgn/kBjxEi4L2plCw1ggq+qUbbza8mYPvy9xCg4Uy/zANCkT2jqW6OOqiGzYUP1bllnL9yOmlEiwX5QZEjpAVdwSthZZVwfs8YWDjGYmnrpDoh0VniFygT1s5p3wq1xkZN2OfiKZ88gg31AGa6kqggzy2pFk6MxpPWxgB05xz9TZJIe6WtSpdBVmWPsjaiqPZHsDSI5SmztDQAVtXdVrp548VAxI5UVYDsEgOAwClFln6jJg2N3wZdxZVSFZBUla08v580zVWQRGAmzHSoZQu1L1HocpCPAycPdFsXOZlbP7aYR28y2At4daNlH39awbCw6iRC8nFXA+QVvMQU+MMNlTIsAuQe8gms5fdpDimcs2BLiMsEgYZkPbmiYsPDQ5Pxse9TOFh8OC0ZFqHSCcU3gJKT+LhVAi0J9NZ4T9XZUq8DOLTUekObED5mtyFtx6MhNQO84zkgaEdzYQmMd1UxkhY05fwGeYnI8Pz9/qzDjf4YWGF53bxXBZxkgNCcw0vW3PBY9FfE1piYKuiU+u5uNm03pGnM2ixd6Q6ztdok1CmWekxGGvPp44QA2EFL7mFN9KXtfYG/w+Rqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0201MB8725.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(8676002)(64756008)(9686003)(5660300002)(4326008)(66446008)(6506007)(52536014)(53546011)(71200400001)(54906003)(508600001)(8936002)(55016003)(110136005)(38070700005)(86362001)(33656002)(122000001)(26005)(186003)(38100700002)(83380400001)(76116006)(66946007)(66476007)(2906002)(316002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LbQvVMlbKLx6uB9HUk+fldlR1VBY+jN0ZG8+VdBUNU0uPnj0rOCiFmPfCgaV?=
 =?us-ascii?Q?zmpj2jIvQRE0bzTInl35NggBW0FVzCuMCxLynWo3WeqkhgJZ4RHljJ7QBnpT?=
 =?us-ascii?Q?ayyyKrOC3C92ePS/muMsxV7aQ1OwN5IorpSPAt+iU5jN/xjEoBryOK55wQOk?=
 =?us-ascii?Q?I/8xTsNs7Cezp5e9/EngprQ3Y+QOpzO3HM2fS7b4+tempgyH7QlBP0D0ub4d?=
 =?us-ascii?Q?PFGyzJ5DF55OCUvjRF+RK6hKvnnOlDbAIaheepovGrCE1iLCYm8+agUSz2Sp?=
 =?us-ascii?Q?wi2Eu1cEdh+PLDi/aslyu46XF5zIDwE2cRxAtyZ9l8DAQai5+gQceDB+z+jU?=
 =?us-ascii?Q?1FqsXpHNefURysoj9CJ79UbxcY0WWwyCcTeToKeUzgdNr1h6aL0cGZn/s05s?=
 =?us-ascii?Q?4ZSmPySheE/K5UH9ORC0DS2gLLS2lEWJz08O96DVN/FpUuua54iQ35dKU11K?=
 =?us-ascii?Q?71/1PnYBkb5VbMpN5xSpBPRJ7g5cFAg7gDUqzchqr1I7h2ieWBHZk9+F5+6n?=
 =?us-ascii?Q?cbh6v6DZE45E65jJ7Vljd3L0Rv6QRchzE1cmMMEXMhPOmKkau8fohyC4NPu5?=
 =?us-ascii?Q?gozaJe9ikgFQ8fN6J64pzVmiXww17H9XQ0JNYN6oUV9A48mqG/XqhqxsVL3U?=
 =?us-ascii?Q?rDcHFBk/AOOQALQeCsovRus0K2p4jLiwhD8ad0YDVmf/+k4C/NO5ish6LmnG?=
 =?us-ascii?Q?W+rMT+sZxDlnA/6FouXQOMt1VNejEqCiLrtxTjgbJCNw+hBx8qE6CNuiKzkg?=
 =?us-ascii?Q?QZ+3Rz7nZrHd2mEKq8J6aqjbm5zWaIm4lFB0EZ+eoDD/2C0Jj5DFO6/FLV0B?=
 =?us-ascii?Q?WNXPZyZIXEp6oYHwJBnoTzMAGyVpgIpF53LC4C/zQC0cPugmkT1ikOOvR8HG?=
 =?us-ascii?Q?52SRPzPx7bwaQZaej34o7KJahR0FRiSLSyd7O+jpvKsHJihMlenoos6v8b3u?=
 =?us-ascii?Q?PBc1DIrwafo1Xdji9MZSzHckn7HuEyL8kgisx5+G1C5klyKepW6fKJccb4gP?=
 =?us-ascii?Q?Beqk0E5xFGwqRmiGFEUYFKeMX/GeMky5dwQPYT3FsmNtoaNejRtZIIq4cOlJ?=
 =?us-ascii?Q?7Vtwy2yNYfjKz79f/HsnqBa3SsGcKPKIbsuBRadigBTVq8a/Xqb22ISuFL4g?=
 =?us-ascii?Q?59g4/IdJ/5umrNFBt61AXqorT6uepgGM35/ny0L9gW1XvDeCRrl22M5lbtlr?=
 =?us-ascii?Q?fVXjRbGmK9DfLmwi7WSMz1Gw+7Qa5YLHaOZyxr5CNzMgKXwkvKGGNvEMad5v?=
 =?us-ascii?Q?JJaxjlaHHxlnVaXXZisRAvzvDEphurpE8uAtniN3Z3WBdqFP0PzNXZTiX7GT?=
 =?us-ascii?Q?fzpOHEt2mKZYF+t5b/a2dG7ENZOtuTstNxrP5NitHzi2mBfoyG+sXlW82yye?=
 =?us-ascii?Q?rbU8fd/rV9bmi48+EV+g4zdRzkUwRepelc3HaDHek9XHkp6z97zKxP24MxU2?=
 =?us-ascii?Q?HgxdnOCNHdAZ/b0g/Q6E6ySYOKgq63OF/pkeNuGSfE8DqhY/XWRXlpXEbtwj?=
 =?us-ascii?Q?RbH/ZFIKRudrt//h7hyg5/owvMVE0hFSEc8Yu6Rz78wWOL1gbOO+N7CJZF5o?=
 =?us-ascii?Q?/s3ELU6u+aVU/d+OC2m7ztJrlD+bE8At6EFKPPCTMB00AS5yc0MjpdYlgEd8?=
 =?us-ascii?Q?ql5x77FYMcsERwAkkoeJAQmyAh6JynocnGPWCgC8081N4NUqIaeBapbpKeX1?=
 =?us-ascii?Q?J4QJ6w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB8725.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470cc0bc-0406-4615-d86d-08d9ed65431e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 13:49:02.1804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtA30nX+9xwy/kLzu5CpT8c4Wd7FLKIjyuVJr66ABB3E011fykjzI3VGEIPAGAlAk4EJZnd5/O+IEcVzNsIUpb12Ylbk/8IrJoi2STr1aec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2453
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Bjorn Andersson <bjorn.andersson@linaro.org>=20
Sent: Friday, February 11, 2022 6:09 AM
To: Sai Teja Aluvala (Temp) (QUIC) <quic_saluvala@quicinc.com>
Cc: marcel@holtmann.org; johan.hedberg@gmail.com; mka@chromium.org; linux-k=
ernel@vger.kernel.org; linux-bluetooth@vger.kernel.org; Hemant Gupta (QUIC)=
 <quic_hemantg@quicinc.com>; linux-arm-msm@vger.kernel.org; quic_bgodavar <=
quic_bgodavar@quicinc.com>; quic_rjliao <quic_rjliao@quicinc.com>; quic_hba=
ndi <quic_hbandi@quicinc.com>; abhishekpandit@chromium.org; mcchou@chromium=
.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: setting the vddio supply =
for Bluetooth node on CRD

On Tue 08 Feb 05:13 CST 2022, Sai Teja Aluvala wrote:

> setting the vddio supply for Bluetooth SoC WCN6750 node on SC7280 crd=20
> board
>=20

While this does better describe what the change does, as Matthias requested=
 on v1, it fails to provide any information about why this done.

Is vddio simply not powered on the IDP? Or did someone forget to add it to =
the idp.dtsi?
[Sai]: Vddio regulator handle is different for IDP and IDP2. So in common d=
tsi file i.e. sc7280-idp.dtsi we haven't enabled vddio instead we have add =
the regulator handle in board specific dts file.
So for CRD too we are adding it in the sc7280-crd.dts file.


Regards,
Bjorn

> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts=20
> b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> index cd2755c..53ea3b4 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> @@ -23,6 +23,10 @@
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
