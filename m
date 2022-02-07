Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB9A4AB6DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346155AbiBGIpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242918AbiBGInX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:43:23 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 00:43:21 PST
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73ECC043181;
        Mon,  7 Feb 2022 00:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1644223401; x=1644828201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vrGJo5GJMvZVTeRHI+THqvSZPHHn1vX0KIRLXNDrqZc=;
  b=Sk3vkN6+bxlN5waw5XbocE8L3raOAskqff6c6cSLSxKQ1/NYilju/YTZ
   evrudEo/C5YgnrAiMuxuQyJd08Sf/qE92eds0KECv1TLZ3VFKmGuIKwrN
   CEgFA1XZJ0FTdOMS+0pvU6Mvbc+EGparpFu4Yqb7lLCDX/opaKsQ3aFpq
   o=;
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 08:42:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0YbmWfOBz8TeX4kcJPkM1eTIpl9x1JUR0r+aZ5Xut3AnnQCd8LyKBeYCUIM+1025sasUI5kN5z9K0do7mh1B9q+2B1q8rQJ6TWwmWCV3VEDGdkjnMHUzbzkq1BDnyqsUDjhPsxyLU8udrGKPR3aHh7it3Zmg/KOvwW9WuGenTSI5DEjNnyKK03jIITRpPPONJO8+HbjNaZsq4KDWi86PFfQJP1QiQKFJCOiva9TCbY6r727co6JRrXQzJPFk1ZjBYYTZ1nH1fokZ2CxrUHZ406ZQ951DA2MZ8I/xkpJQS06Fnnt6caKA4X9gVbQzwENu4rtMQ3zPOSlIwfDVbbw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrGJo5GJMvZVTeRHI+THqvSZPHHn1vX0KIRLXNDrqZc=;
 b=U6H0if0hJn0G8alnoQ9dUP0mrg4Dz4ttIUSMIEn4YJz69GhQ/FGa6zHn7Uvm8gOZiGwRhtAXHbp2EQRQp0H45eFcvTctUOF3xxuBHpBE0LjIZa+9Yh0ERSl+wVGM5RiMwwG8wXdq1nov8dJULtLdw3reTBIU/iba2rNbXMHpMUd4Ilb9WNx6IPbrn/GJELiangxu5FzCOlP0gTq1Ql/iaBUnCnrt09ppJCOMv1NI60X/Qr0dj4m0v1ib1yXn6b2Zc+UYl98VzGrwP9wJnJ07SGWUT6jsBIGc0Y/iLRLknRUAiBrnZyqg3yniZz8p+uuPX2yCEyY2p/IyLEdNbID7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN4PR0201MB8725.namprd02.prod.outlook.com
 (2603:10b6:806:1e8::6) by DM6PR02MB4361.namprd02.prod.outlook.com
 (2603:10b6:5:22::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 08:42:03 +0000
Received: from SN4PR0201MB8725.namprd02.prod.outlook.com
 ([fe80::45ac:4918:6d01:3009]) by SN4PR0201MB8725.namprd02.prod.outlook.com
 ([fe80::45ac:4918:6d01:3009%5]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 08:42:03 +0000
From:   "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>
To:     "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>
CC:     "mka@chromium.org" <mka@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        quic_bgodavar <quic_bgodavar@quicinc.com>,
        quic_rjliao <quic_rjliao@quicinc.com>,
        quic_hbandi <quic_hbandi@quicinc.com>,
        "abhishekpandit@chromium.org" <abhishekpandit@chromium.org>,
        "mcchou@chromium.org" <mcchou@chromium.org>,
        "Sai Teja Aluvala (Temp) (QUIC)" <quic_saluvala@quicinc.com>
Subject: RE: [PATCH v1] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280
 crd board
Thread-Topic: [PATCH v1] arm64: dts: qcom: sc7280: Add bluetooth node on
 SC7280 crd board
Thread-Index: AQHYG9q6N7JJmMX7QUi4o6d+ajSBrKyHxW6Q
Date:   Mon, 7 Feb 2022 08:42:03 +0000
Message-ID: <SN4PR0201MB87255A93065DE270B624EA07E32C9@SN4PR0201MB8725.namprd02.prod.outlook.com>
References: <1644207878-19839-1-git-send-email-quic_saluvala@quicinc.com>
In-Reply-To: <1644207878-19839-1-git-send-email-quic_saluvala@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a991b84-2f06-4ad6-86b4-08d9ea15b720
x-ms-traffictypediagnostic: DM6PR02MB4361:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB436155798359D430169F50369F2C9@DM6PR02MB4361.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:475;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OHXQtoRP++Lj/YaXRCTAa+QMTZGFtb3brGRnSUBz9QfjXNvRUwBunFcndBt6R+KOL/QTFvh73lfXXoddJ1YjaR3Ia1dX9c5oqMjXRmqktfgJsq8wi3/+661CFySL4u4fCZQx2uqHRG16iES6+SZD3/aO/wtnlWGWbUSIBcz+0eNX55yJv8N9ob4mfIlBfzTDwR+Oei4WNjmWZ2pY4+dfVfP5NuOqar4JLa4FBws4vSZ49LwHNUizewLhwqrDR1iGF4vVQxAMQDpedGSvis4e6TVIVR2rwgFrFudXw2oOlmTExt+N3Jt4KLgCNL7kL+fmv7zPtbS5gog3t7HPMnn8x75N/deMiI4/4ng3KZ3Okvh/vtdRGHAwESeRFXzCR5CXk9sUxfMwD1Txkl01e6YWh67jjAITuEF5I4S5eYAYUINrGrcjkyPu4TUnsGbVIjr0l01dgSNfsRHszlM5J81ULrLftFWkdyeCgGGN5gzS0/zGlN3O88/5uHb8HHgf7zQTQFOAm6q/D5crgK59p60GZjC0lnrZhRGeb6LqlgVutaE1gk6dEvvVMjmjWKnfP33iVhvQLf+gNmi8pNN5NNhuhVqnmHGzpmRLn2AkIrr1uR/nf6DWuExyTqNNr9HpOxF3+8K2i7JenxMPQiz0vLwT3nJIGR9+rZhA+fVPlGenwXEzSE+52WWdvbyfPYF8ALGBZvOmsthDr3g47N9jZBzTfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0201MB8725.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(186003)(26005)(107886003)(508600001)(9686003)(55016003)(83380400001)(122000001)(5660300002)(2906002)(33656002)(52536014)(53546011)(110136005)(7696005)(6506007)(54906003)(316002)(71200400001)(38070700005)(86362001)(66446008)(66556008)(66476007)(76116006)(66946007)(8936002)(8676002)(4326008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qPJ2Ti3F0UpSKySpDNSF1u0IKH87B0kwAZjjbmY7WYUOtbIMMhYRAvmw/iVJ?=
 =?us-ascii?Q?3FxSChJTJqKbiOkFXaN3dS6Iwff8ODs/j/87pltp1wNu85wLzdBrfqEo4db7?=
 =?us-ascii?Q?0rEHcmxw3megI3aK5gwPpzcQkgu2Nss727nbxMmmU5NytFkh/OGeDpctIOHE?=
 =?us-ascii?Q?oeYqpJZaZPHOPftIe83Z+KVUqYSYW/9C4NKAKD/E3civ0606vfHe9n6vkF2I?=
 =?us-ascii?Q?az0KBWak40ClLgu6j7STgv0Un+NVkcwv6oJSraFFs25jwVIm8hsXVKDjeh7J?=
 =?us-ascii?Q?h4Rca63vNGcSG+UHGcvHP3Ddh7AdIm82e+Ng1JhdaPgEi0dJqL/kWieTiIKc?=
 =?us-ascii?Q?uoOYqfhAsTfgnWXmRYyVscI3QUQShX2Eb1M1gHlYIB1d/gOJeZfpIdhFD2oy?=
 =?us-ascii?Q?CsIgvW8UHfTP/dQ+/rk79QGdFH2QH5q1/zkyHjfBOFxPlQ5SPOec4+z8FIiV?=
 =?us-ascii?Q?COLN+xiwtDJdMOzoxzmFjUpsktfI6rakvzjsKn2HnkXxbMhK/Kt8/5P7HU5I?=
 =?us-ascii?Q?nQX1UmqVPT5pGKH/yBpQJ3MAWcR97MSxHxQtWsFNYDfH1fN7SJin83SQ9/DU?=
 =?us-ascii?Q?37Lu7PnUmbiwEpo0cKdmQYaW9LuluqJdD8fW/0rKlYgh9/BT8aVo2nrkdYA7?=
 =?us-ascii?Q?ps86EkL3bXMn4PStvwQ86KCSq4T3P9gJimp1y4im3XXm9OxqYotqFkpCE6uR?=
 =?us-ascii?Q?hCYGv8NAxnvGSwTW84tk6LRc7Yxulfi7xJUmDSy7LKlEw30E+YKF3CKTbU1L?=
 =?us-ascii?Q?r53B12KTZG1PFdGpv2ufXmQC+xnXF1KXoAG4tog6bv6KWGQkyoVR4rYNK5VO?=
 =?us-ascii?Q?I5Dm58H90/G71YkG8ovWe2+W5jp5u1uAJSN1M9UyF8Xf4whLdJ0NJ7m6FhX3?=
 =?us-ascii?Q?Tg9DcsyB2r9z5dAjjFgbA8jq5fCnBrf+zQmh2MGM1RW2MYqwvQCDxCwa5+gn?=
 =?us-ascii?Q?MSuWpxLCMnWnnI75qtYLQFZpJ2Jxqu+7bPmr3ghlGwXYJcuwUECqC4+sL5po?=
 =?us-ascii?Q?GHl3YqcrJj7MUFLnE24ZB8Dyb2spCAmmFIY9QggQentcqbRv58Ebo/1ZLLd7?=
 =?us-ascii?Q?D3yet3J2U3s0Aqz2M5QFSGjkmU/xrmxsDfctfJa7j0vsvi8MYFaCcQnE4QuQ?=
 =?us-ascii?Q?HKCBWyIOP1ZUeNqWvE2XDFpV/POwvuYZMr7kSTFVh5e9xAY8C5alYuOHe5B/?=
 =?us-ascii?Q?CBlNtAeckFJlvVhshgyHPMFIDyfJiaTcOkzLOm9YM6pY7lM78X6Ux37WceEx?=
 =?us-ascii?Q?yAxvNZ7sfS3ej7eueeC9lfeolP3jJlzA2COsiP1cmMhPEjtD1fnFmrZNLET+?=
 =?us-ascii?Q?Si9MAKpAa1XMvv1aAIPv/uQqusN0KXWnMWB03JJnol0nLGOgLAWjATCOppjL?=
 =?us-ascii?Q?trqVzmg5nr8/IqgBWdrCiqNvUM6M1fpV9N3xniM10spKpd6an0RFoNPc9OSP?=
 =?us-ascii?Q?E/nS7I7UcTE6AMjFqlbG5BCF16MjWtSb4XMfZBu6gFMuijAaP8Rrb1AgKuWf?=
 =?us-ascii?Q?cncLBNjxrzSvHR/tkLsVNvnoI9O2Cfz0gjgKbSj80ahJz+iO/3GuTjDxxKSu?=
 =?us-ascii?Q?kWSsELjQIcgdlQ60lFumPcAcHM7upsivQU+zmSHsYaIhOIcDeqEhjOTI1MIY?=
 =?us-ascii?Q?OdJs7XfzdmhcOqrnUnQd5mezR18WYenJDLn4njbWMfPIXVtRCIBbI+HQAG2e?=
 =?us-ascii?Q?VA/huA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB8725.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a991b84-2f06-4ad6-86b4-08d9ea15b720
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 08:42:03.5961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StHAQZffqtxSTjVxggdz42ZFQLVSEtG4vXJFqi77k7YjzHH9LsZTr7Pz+DT9Vmi/MxV8u4cpyH8zlX5TZS5RemHW4nYv6SacTx3PH2sQ5Ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4361
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ bjorn

-----Original Message-----
From: Sai Teja Aluvala <quic_saluvala@quicinc.com>=20
Sent: Monday, February 7, 2022 9:55 AM
To: marcel@holtmann.org; johan.hedberg@gmail.com
Cc: mka@chromium.org; linux-kernel@vger.kernel.org; linux-bluetooth@vger.ke=
rnel.org; Hemant Gupta (QUIC) <quic_hemantg@quicinc.com>; linux-arm-msm@vge=
r.kernel.org; quic_bgodavar <quic_bgodavar@quicinc.com>; quic_rjliao <quic_=
rjliao@quicinc.com>; quic_hbandi <quic_hbandi@quicinc.com>; abhishekpandit@=
chromium.org; mcchou@chromium.org; Sai Teja Aluvala (Temp) (QUIC) <quic_sal=
uvala@quicinc.com>
Subject: [PATCH v1] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280 =
crd board

Add Bluetooth SoC WCN6750 node for SC7280 crd board

Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>

---
 arch/arm64/boot/dts/qcom/sc7280-crd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/=
qcom/sc7280-crd.dts
index cd2755c..53ea3b4 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -23,6 +23,10 @@
 	};
 };
=20
+&bluetooth {
+	vddio-supply =3D <&vreg_l18b_1p8>;
+};
+
 ap_tp_i2c: &i2c0 {
 	status =3D "okay";
 	clock-frequency =3D <400000>;
--=20
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.

