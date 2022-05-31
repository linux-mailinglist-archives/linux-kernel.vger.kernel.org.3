Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC5A538B26
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 08:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241779AbiEaGD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 02:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiEaGDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 02:03:22 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8788E205E8;
        Mon, 30 May 2022 23:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1653976998; x=1654581798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6Yzazt607vDNXqR9mLBYj5htow2mbUWMcMqbBZgQk4c=;
  b=e7bw3w+G78KU9fQwWI/okMsuP2BfeH1OQCnt1C21/xMZItLKIBL5Dtvg
   JlqiIjDPX+v8251cv7qs0Wh6tkP+xXGFzgzYKA3k/qLttHiIvnAro9ZCB
   g6USptNX1EcMvbnqTQdUpTOsMuHIv31CRzOyaxtCMwtWL+HWuQmqdTMVC
   U=;
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 06:03:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLnECfyPrz0wf2Ug/mwDgqocjTxcOWDom2vE+F5UiyDMUgy3F2/xeij6LlVHQAxob9qN3imeV/qrqjGNVIgUgfZOe3bDCao1lNhaNO3TnH70ZZfcr1ueKivnMP7fcbwdR01+ZRxs4WgsHaQ3x/pWjcPCsRFEz6JUCt+XFxKObOfo+Afm0Zb17f4j6R1zVFh1bQ/LYK1JZ+xHG9OyXQbDkaWEOQ9VWEkkQUF+B1AoCUDqdb1KncqKpI3GkMbJky/WlyWXO/x+EGKRL3us0Lsivpj9ZYrZ9YHNB0mAjGDySqmQHr98q+45GRuanKV8kkMLG3rUKoik91rIJpQS1Ig5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Yzazt607vDNXqR9mLBYj5htow2mbUWMcMqbBZgQk4c=;
 b=SEAbo8KDx/EJl9JIO7ntTMD9LpiTzUz3X+gOMWMD3McqVijTO7Ju1d9br8coYJkPpET6erInL3jgeRiUKuWPdVvnaswG+QqzU/swBTYYe9RIAIBKaBSGxu7HSX9sdiL9Cw3YbXyy77lgZNcLvM9U9N1B+NajaC1JKY9t+JPYASS3bXU1+eZpHVpTkdnE3oOZ+GGHZ4LlVM1dNKp8Qle+lFn6F5CtfK6K/tmdbpOz8IAYuFK3OqMrtZJWY4efMkC5BrLNI9uL9xrW9AECwFyRv2WzSUfP6u86uadKwDp4/Vz6/uObJBy0se2F6EmXAn95HoxEG6QCGlYGRMXaCzIrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM8PR02MB8169.namprd02.prod.outlook.com (2603:10b6:8:1a::14) by
 SJ0PR02MB7743.namprd02.prod.outlook.com (2603:10b6:a03:321::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 06:03:12 +0000
Received: from DM8PR02MB8169.namprd02.prod.outlook.com
 ([fe80::6012:328c:8e04:b40f]) by DM8PR02MB8169.namprd02.prod.outlook.com
 ([fe80::6012:328c:8e04:b40f%9]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 06:03:12 +0000
From:   Vikash Garodia <vgarodia@qti.qualcomm.com>
To:     "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>
Subject: RE: [PATCH v2] media: venus: set ubwc configuration on specific video
 hardware
Thread-Topic: [PATCH v2] media: venus: set ubwc configuration on specific
 video hardware
Thread-Index: AQHYW646HVrQZx5uckCCAQwdxIK/t604sLNQ
Date:   Tue, 31 May 2022 06:03:12 +0000
Message-ID: <DM8PR02MB81691837C1D61F8CD08D15ECF3DC9@DM8PR02MB8169.namprd02.prod.outlook.com>
References: <1651225672-32243-1-git-send-email-quic_vgarodia@quicinc.com>
In-Reply-To: <1651225672-32243-1-git-send-email-quic_vgarodia@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5556dc82-e260-44f6-f078-08da42cb3e97
x-ms-traffictypediagnostic: SJ0PR02MB7743:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB774346B263B6AF258E378042F3DC9@SJ0PR02MB7743.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v33gxe1eTs4yhePy9Uz3r/1+1mTOwhtyM5/G3jrKVv6ZqzkvKQyNjaIJGI2Ll8obqYu1SkhHU4ZVINdk30StSRCwmwyfTTGth7BeF8oT0lN5U2vzp5xKME6GoxayTLrpTFIpSBVTMCiGk3+6kLcts0YFiPzwd20FVXknjEeZJ/Fh064jnIKYlrHTSo6y8MuDJrTyHPJKrQl2RQUS8o+fkxmMUFajVVYoNNR9W8/H0yrA5MQoj3nvQrTqagw76E4TsatIhLjU8C8tK7+Tk75yXlbRarfo4ljby3uvetT4nqetczgIhC0h0x047FA4Q4Ov4cQCVn5NzhB8dUVonHrwxSiGRBmhYdEk2ebMMJd+5+Oqo2UjN7LIRwi/pI8XlZF5m5ZWigZtR+Ka3GxDtMK5/BQOoyyTAFPfMcvS9dpIN+IM8OivRvQlt5h1F+wIU/1v8uWeG0fmnBRvHV5AhbJbZULBXEBOdbLYO3nQS0yfD8pYNUHapAo11Jof962R37T0l/fDS8SQMoUT+sWRNYjjBbWzwdtDI+tpIw9/g0DT0jQVZ9sS32wxOHmvuglgvf+Jq2N2mKZigTBWJbBtKsHgCqTK6RFTM9UPsxSb3Vwp8fiMKEHIN+NdW343SA7Av0aUlPPb58jMrD9VQfF+SAbmqn2xBND6Cf5ZZTJgzPjTH2xzP9YNpbrIYoInIzxGg9YwZ2mBpeghbzdPra7K+ufqpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8169.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(107886003)(86362001)(7696005)(186003)(55016003)(54906003)(53546011)(6506007)(110136005)(38100700002)(2906002)(316002)(8936002)(38070700005)(26005)(52536014)(9686003)(66556008)(64756008)(8676002)(66446008)(66946007)(76116006)(66476007)(4326008)(5660300002)(83380400001)(508600001)(33656002)(122000001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RatoMBlxmq04kj6/Xd/I8nlIbjo7UnbEJTfTn3Qy2qtlEBdqJNp2qd0V1Aor?=
 =?us-ascii?Q?OHU/J2wjWNSbOeH5Ie2og6891rWAIqFvBCtGvShxZRlv2mCk6RAeeTEK4gfO?=
 =?us-ascii?Q?MtqXeLVqbGCyP/jmyw/hWNUbUGVAHAuhcFmdILniddRnYNBzpj8Ow8WeaY0t?=
 =?us-ascii?Q?GOqUt7EwWQVDONc+KwqhZlIbnfoOR6Wh1xOJsdsGhvybcbAnzAX9lCJjjoKP?=
 =?us-ascii?Q?srMMqTElD7LqZH/0+0Vpea+jDr+naYT4Drz/I6G6nSwWJsr5tvY11Ukojzq6?=
 =?us-ascii?Q?zbgqxfVfHLpzvg/RrDmF312J8e9X11tBE9xyjD42jSCBktNqVsc0s2Piq0Cs?=
 =?us-ascii?Q?PUYaV27N6B7BZmtAbowFOFHyufJXqXoSme4X1iHtWoLtzo7Slb52CT27s+sx?=
 =?us-ascii?Q?LfOrLN91PDVpzMUVv+ehk7Q2y9vj5VqTFCg9o2/sr2W+e0EDv+SbOedHCcbr?=
 =?us-ascii?Q?giweXS5vKvIPQWcqip8Xk6W5rABqyx/1zukld9ZQPmR6pqhMaxwTskO6pSR7?=
 =?us-ascii?Q?32YqJhcVKsbvyyAoZzpspLXYR7vRSxtSfDoso+zBSZUGZooB5/J56pG0Iixx?=
 =?us-ascii?Q?58TW35HeakDCwIUxdQlOo0jfeSus4Om002CoFDZxfp1pzHWvDMs3Hf+Q+r7G?=
 =?us-ascii?Q?NhOF5rrv+Y7CuD9KUkwCIOyYKvCTQQ0C7OJhBgC195EOgTHsbzWecoeXH2pB?=
 =?us-ascii?Q?TlukxomrCEbLZFxllXXa9LelGNS4VgVOoa3faEifSgUoY5jbxFmSJKfWueHB?=
 =?us-ascii?Q?hfJJTYKadS0091Izl2CZYywZttI4Q3GsLu5Cytrh14rMBhhyZDhvznsQEWmC?=
 =?us-ascii?Q?guUAuUwZnO02xDA+SiUxsu2AryiBOS9riAy4DvXbwIGoX4ILgOXKKYVcXitT?=
 =?us-ascii?Q?kJkh1r9RVOu4R+56C0YG+jQXSQIcs5w14SF2hO5vCIKC4WqyYNPPAWtraEJb?=
 =?us-ascii?Q?5qXBMyDZ20PQcN/lWZgWVXr8RpgF4CDWc5dwoNSvF4l7G/HpudxP6IpTS66Z?=
 =?us-ascii?Q?jEJLhaPUBI5POAkhZCEJyeGsPsSv8jJ8h9xxs8cCt3y5IemX9qiayksTa+mO?=
 =?us-ascii?Q?x3QHg+C98tlpc6Jdz1pEseeIcHerhPnE7+p89krm6etJGn6C5KdBaVrwYkBO?=
 =?us-ascii?Q?KodKrWVOPsLqxUWkEbo6dJdXrsEgiDC5FUdQivf+kzcR1fGPdPP7yfoUqZW2?=
 =?us-ascii?Q?U8VZ0xum4MO3OwsOKCpMp+AFy5fswjMpBZS/jJnY/E5EcMY7Ol2DfwRQT7ZJ?=
 =?us-ascii?Q?qPD5XCFAWhxYVlSg/caBbs2yWEM+r1+Ispig2HLIiAxubfjSMQzuI8iTbEzu?=
 =?us-ascii?Q?N3S4hxLgy7/8Pxr1pZRXjYjUKs4M5Az7PEgpslpq4VHKwE9RNPQMOGdC+snZ?=
 =?us-ascii?Q?2h1FeykVBebD/UITF+3XTp139jmxlwSTwo9LfCapzJq3PmxyIAi6p4jUuGwq?=
 =?us-ascii?Q?iP9e/BWxnstREXCfNpUG8i+yagyp9jZUe+wTd7qKL3JHQ3h7mKuKhqZFs/Sq?=
 =?us-ascii?Q?C8im10OoXFQFdhgiJagDOAmdehooDYqGBD9yIIm0/d14iKvssOgSybNyb3wc?=
 =?us-ascii?Q?otIW1gsyMesnQ3j2hRZokovuRPpjiLgyR/jbJcRFgz3jeh59vZwQGZ9Y4q0V?=
 =?us-ascii?Q?OjTjeNc5ULzrzXjBbPzkRdsnzSxCS0qZTvfGbAMn1xFUeZyzV4+1rYGWmHyc?=
 =?us-ascii?Q?riVsTs7dfMgEu7uJzZdAknnnU7Xc9kqGYxMJRbOzJdXPrcSiOQIaIGrhxKLg?=
 =?us-ascii?Q?3ALJAlLM5o8sw9Icroal53mCJeLnbus=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8169.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5556dc82-e260-44f6-f078-08da42cb3e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 06:03:12.1817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyW+MMdvRI0DdkSHpJ5tdq+LJE4lGgcJXRYtdHfkeA/Htn7mMJ+TH2V1EPBrcJH4BX8vppGqKhaUCOKeLxINGFunLt75qdsG0NvZg7aZlao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7743
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly reminder to review

Regards,
Vikash
-----Original Message-----
From: Vikash Garodia (QUIC) <quic_vgarodia@quicinc.com>=20
Sent: Friday, April 29, 2022 3:18 PM
To: linux-media@vger.kernel.org; stanimir.varbanov@linaro.org
Cc: linux-kernel@vger.kernel.org; linux-arm-msm@vger.kernel.org; Vikash Gar=
odia (QUIC) <quic_vgarodia@quicinc.com>; frkoenig@chromium.org; Dikshita Ag=
arwal (QUIC) <quic_dikshita@quicinc.com>
Subject: [PATCH v2] media: venus: set ubwc configuration on specific video =
hardware

UBWC configuration parameters would vary across video hardware generations.=
 At the same time, driver is expected to configure these parameters, withou=
t relying on video firmware to use the default configurations.
Setting the configuration parameters for sc7280.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 drivers/media/platform/qcom/venus/core.c       |  5 +++
 drivers/media/platform/qcom/venus/core.h       | 18 +++++++++
 drivers/media/platform/qcom/venus/hfi_cmds.c   |  9 +++++
 drivers/media/platform/qcom/venus/hfi_cmds.h   |  1 +
 drivers/media/platform/qcom/venus/hfi_helper.h | 20 ++++++++++  drivers/me=
dia/platform/qcom/venus/hfi_venus.c  | 54 ++++++++++++++++++++++++++
 6 files changed, 107 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platf=
orm/qcom/venus/core.c
index 877eca1..75d8e14 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -832,6 +832,10 @@ static const struct reg_val sm7280_reg_preset[] =3D {
 	{ 0xb0088, 0 },
 };
=20
+static const struct ubwc_config sc7280_ubwc_config[] =3D {
+	{{1, 1, 1, 0, 0, 0}, 8, 32, 14, 0, 0}, };
+
 static const struct venus_resources sc7280_res =3D {
 	.freq_tbl =3D sc7280_freq_table,
 	.freq_tbl_size =3D ARRAY_SIZE(sc7280_freq_table), @@ -841,6 +845,7 @@ sta=
tic const struct venus_resources sc7280_res =3D {
 	.bw_tbl_enc_size =3D ARRAY_SIZE(sc7280_bw_table_enc),
 	.bw_tbl_dec =3D sc7280_bw_table_dec,
 	.bw_tbl_dec_size =3D ARRAY_SIZE(sc7280_bw_table_dec),
+	.ubwc_conf =3D sc7280_ubwc_config,
 	.clks =3D {"core", "bus", "iface"},
 	.clks_num =3D 3,
 	.vcodec0_clks =3D {"vcodec_core", "vcodec_bus"}, diff --git a/drivers/med=
ia/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index c3023340..ef71462 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -47,6 +47,23 @@ struct bw_tbl {
 	u32 peak_10bit;
 };
=20
+struct ubwc_config {
+	struct {
+		u32 max_channel_override : 1;
+		u32 mal_length_override : 1;
+		u32 hb_override : 1;
+		u32 bank_swzl_level_override : 1;
+		u32 bank_spreading_override : 1;
+		u32 reserved : 27;
+	} override_bit_info;
+
+	u32 max_channels;
+	u32 mal_length;
+	u32 highest_bank_bit;
+	u32 bank_swzl_level;
+	u32 bank_spreading;
+};
+
 struct venus_resources {
 	u64 dma_mask;
 	const struct freq_tbl *freq_tbl;
@@ -57,6 +74,7 @@ struct venus_resources {
 	unsigned int bw_tbl_dec_size;
 	const struct reg_val *reg_tbl;
 	unsigned int reg_tbl_size;
+	const struct ubwc_config *ubwc_conf;
 	const char * const clks[VIDC_CLKS_NUM_MAX];
 	unsigned int clks_num;
 	const char * const vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/p=
latform/qcom/venus/hfi_cmds.c
index 4ecd444..036eaca 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -58,6 +58,15 @@ void pkt_sys_coverage_config(struct hfi_sys_set_property=
_pkt *pkt, u32 mode)
 	pkt->data[1] =3D mode;
 }
=20
+void pkt_sys_ubwc_config(struct hfi_sys_set_property_pkt *pkt, struct=20
+hfi_ubwc_config *hfi) {
+	pkt->hdr.size =3D struct_size(pkt, data, 1) + sizeof(*hfi);
+	pkt->hdr.pkt_type =3D HFI_CMD_SYS_SET_PROPERTY;
+	pkt->num_properties =3D 1;
+	pkt->data[0] =3D HFI_PROPERTY_SYS_UBWC_CONFIG;
+	memcpy(&pkt->data[1], hfi, sizeof(*hfi)); }
+
 int pkt_sys_set_resource(struct hfi_sys_set_resource_pkt *pkt, u32 id, u32=
 size,
 			 u32 addr, void *cookie)
 {
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/p=
latform/qcom/venus/hfi_cmds.h
index 327ed90..ce7179e 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -256,6 +256,7 @@ void pkt_sys_init(struct hfi_sys_init_pkt *pkt, u32 arc=
h_type);  void pkt_sys_pc_prep(struct hfi_sys_pc_prep_pkt *pkt);  void pkt_=
sys_idle_indicator(struct hfi_sys_set_property_pkt *pkt, u32 enable);  void=
 pkt_sys_power_control(struct hfi_sys_set_property_pkt *pkt, u32 enable);
+void pkt_sys_ubwc_config(struct hfi_sys_set_property_pkt *pkt, struct=20
+hfi_ubwc_config *hfi);
 int pkt_sys_set_resource(struct hfi_sys_set_resource_pkt *pkt, u32 id, u32=
 size,
 			 u32 addr, void *cookie);
 int pkt_sys_unset_resource(struct hfi_sys_release_resource_pkt *pkt, u32 i=
d, diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/me=
dia/platform/qcom/venus/hfi_helper.h
index 2daa88e..d2d6719 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -427,6 +427,7 @@
 #define HFI_PROPERTY_SYS_CODEC_POWER_PLANE_CTRL			0x5
 #define HFI_PROPERTY_SYS_IMAGE_VERSION				0x6
 #define HFI_PROPERTY_SYS_CONFIG_COVERAGE			0x7
+#define HFI_PROPERTY_SYS_UBWC_CONFIG				0x8
=20
 /*
  * HFI_PROPERTY_PARAM_COMMON_START
@@ -626,6 +627,25 @@ struct hfi_debug_config {
 	u32 mode;
 };
=20
+struct hfi_ubwc_config {
+	u32 size;
+	u32 packet_type;
+	struct {
+		u32 max_channel_override : 1;
+		u32 mal_length_override : 1;
+		u32 hb_override : 1;
+		u32 bank_swzl_level_override : 1;
+		u32 bank_spreading_override : 1;
+		u32 reserved : 27;
+		} override_bit_info;
+	u32 max_channels;
+	u32 mal_length;
+	u32 highest_bank_bit;
+	u32 bank_swzl_level;
+	u32 bank_spreading;
+	u32 reserved[2];
+};
+
 struct hfi_enable {
 	u32 enable;
 };
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/=
platform/qcom/venus/hfi_venus.c
index 3a75a27..fa0fc91 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -904,6 +904,52 @@ static int venus_sys_set_power_control(struct venus_hf=
i_device *hdev,
 	return 0;
 }
=20
+static int venus_sys_set_ubwc_config(struct venus_hfi_device *hdev) {
+	struct hfi_sys_set_property_pkt *pkt;
+	u8 packet[IFACEQ_VAR_SMALL_PKT_SIZE];
+	struct hfi_ubwc_config *hfi;
+	const struct venus_resources *res =3D hdev->core->res;
+	const struct ubwc_config *ubwc_conf =3D res->ubwc_conf;
+	int ret;
+
+	hfi =3D kzalloc(sizeof(*hfi), GFP_KERNEL);
+	if (!hfi)
+		return -ENOMEM;
+
+	pkt =3D (struct hfi_sys_set_property_pkt *)packet;
+
+	hfi->max_channels =3D ubwc_conf->max_channels;
+	hfi->override_bit_info.max_channel_override =3D
+		ubwc_conf->override_bit_info.max_channel_override;
+
+	hfi->mal_length =3D ubwc_conf->mal_length;
+	hfi->override_bit_info.mal_length_override =3D
+		ubwc_conf->override_bit_info.mal_length_override;
+
+	hfi->highest_bank_bit =3D ubwc_conf->highest_bank_bit;
+	hfi->override_bit_info.hb_override =3D
+		ubwc_conf->override_bit_info.hb_override;
+
+	hfi->bank_swzl_level =3D ubwc_conf->bank_swzl_level;
+	hfi->override_bit_info.bank_swzl_level_override =3D
+		ubwc_conf->override_bit_info.bank_swzl_level_override;
+
+	hfi->bank_spreading =3D ubwc_conf->bank_spreading;
+	hfi->override_bit_info.bank_spreading_override =3D
+		ubwc_conf->override_bit_info.bank_spreading_override;
+
+	pkt_sys_ubwc_config(pkt, hfi);
+
+	kfree(hfi);
+
+	ret =3D venus_iface_cmdq_write(hdev, pkt, false);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int venus_get_queue_size(struct venus_hfi_device *hdev,
 				unsigned int index)
 {
@@ -922,6 +968,7 @@ static int venus_get_queue_size(struct venus_hfi_device=
 *hdev,  static int venus_sys_set_default_properties(struct venus_hfi_devic=
e *hdev)  {
 	struct device *dev =3D hdev->core->dev;
+	const struct venus_resources *res =3D hdev->core->res;
 	int ret;
=20
 	ret =3D venus_sys_set_debug(hdev, venus_fw_debug); @@ -945,6 +992,13 @@ s=
tatic int venus_sys_set_default_properties(struct venus_hfi_device *hdev)
 		dev_warn(dev, "setting hw power collapse ON failed (%d)\n",
 			 ret);
=20
+	/* For specific venus core, it is mandatory to set the UBWC configuration=
 */
+	if (res->ubwc_conf) {
+		ret =3D venus_sys_set_ubwc_config(hdev);
+		if (ret)
+			dev_warn(dev, "setting ubwc config failed (%d)\n", ret);
+	}
+
 	return ret;
 }
=20
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, =
a Linux Foundation Collaborative Project

