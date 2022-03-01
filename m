Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B04C851C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiCAH1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiCAH1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:27:44 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA3E7DE03;
        Mon, 28 Feb 2022 23:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1646119610; x=1646724410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ddAW8PLLozdiHQizAGCkWgnTAQaUtrx69r/wkZCMwfo=;
  b=Cpi37bnjT/DXpV86QxX4TCG3bQRxoaC3li8vJ8EXdKisAr24o5JW1n0L
   eP+uWLTKgJOdUgCvbJdOPy0koDZZsLUgP2syco14SZbWf7YTVBlkIu6eK
   H+CEINg7s4PqP6FquZ3W1UiEfxGYcK28g9Ay8OtceAcw/7XIH4Lx6eH2M
   g=;
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 07:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mX8i0eVel47EVHI4TSFUsPZll3B3WlrHFtArOFA/qsvR0OwdXVV3kFJAZ/xxN/zEP+Q4Y6iOwRIRNJOQKgGsBgp+KD4yBmUsZ+Ph6jL5BhUxnYLpLq7CYwDiBMpceepQtl/fldDstc1oDbE3l6pJqVlmVacvFa9Czb4NWz8E7n3aoLFP3NnRDDm5ETwgN4FZt+b51066UelS4S5sbDJzhRCrGHhp9I7fQubPkjk0ge/AMNkyfl1ZAtApNH2HtmCjWqGYRFMnSMhMdgU3OoJqZSzvCr4Cn2LDs6ovzE+W+JoH7iWcs8iP09hpS4YXDmfEpGevNFvHTZtxa/KC7fUQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddAW8PLLozdiHQizAGCkWgnTAQaUtrx69r/wkZCMwfo=;
 b=QMZ2MXSNrM5fhApi5Q1bXSU2Q55vnmGPc60DVNI+537jsP16aLc6zqVmLiGS17l95cTgVo4ugSxIXXymUpdU1epoUseUj9rulDpUkjkFRZEJj1K3rWJ4/5YHYRcCyOqkE1lge+3ILbKsnbjd0/TbZJDj4XwgcffK3gm69V7uo78pkaDXtMiabK6T2IXRjUhh7yu94A5tV6Ezs3JpqxPaL2kMtvwateVYSHWm2SdQdMprmhlXswJfF8AZuu47WKlj+2Hh5EovpYQSpsashwh+2E9juJxHCKL5vEFMUquC0fC5bDKZ4r9z3l/ZLZts5WhBblvJ6I/8A24tJopYudycnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by DM6PR02MB4569.namprd02.prod.outlook.com (2603:10b6:5:28::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Tue, 1 Mar
 2022 07:26:45 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%8]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 07:26:45 +0000
From:   "Sajida Bhanu (Temp)" <c_sbhanu@qti.qualcomm.com>
To:     "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>
CC:     "Asutosh Das (QUIC)" <quic_asutoshd@quicinc.com>,
        "Sahitya Tummala (QUIC)" <quic_stummala@quicinc.com>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>,
        "Sayali Lokhande (QUIC)" <quic_sayalil@quicinc.com>
Subject: RE: [PATCH V1] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Thread-Topic: [PATCH V1] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Thread-Index: AQHYLTlhZk9WmiFVZkCBJEL+rKkKnayqHuTg
Date:   Tue, 1 Mar 2022 07:26:45 +0000
Message-ID: <SJ0PR02MB8449DEBFDE8077932C8B7F9ECD029@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1646117728-28085-1-git-send-email-quic_c_sbhanu@quicinc.com>
In-Reply-To: <1646117728-28085-1-git-send-email-quic_c_sbhanu@quicinc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d76764cf-6f45-4e23-982c-08d9fb54d75e
x-ms-traffictypediagnostic: DM6PR02MB4569:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB4569C9CB79545179EAC0633FCD029@DM6PR02MB4569.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6nDfmnHcIh/JEvg3JiTOiNqYOph1+LuVVHI8eQ0kobbzMpxBhXeRvrkftqr57++hVO3wxsVu3znOoEz92E98AOMl3+dXX7DAPw/npo24Mh1NHQM//tr3xPEsaAVF8rbV6iLv/vzcH6eWoB6UErI22j6Gz+7kXC9zAHt2csqC+Pk2FkiSKvR2dBFo42ErcWVKmnaLXC+7HLBND43Dxa+yeBLDFeJDmRLoQ2IZPaU1QEOOFvp+CEC0S8eZyiaIbaH3m4Dk88oYSo2JzRIcislGo8PTQELwc1drxH5N9FzxPszmqbFdmRxV4mjAESjYbdhYBUC3B28R0td7CYqS4zUe6R6eoOdnFIoun0rotZTbrhDQgSrYH39ZEQcdspWc8hvV1FMCWCZQ8bZCnFBw0uK6dX0yFLW1ALX25JBrqKyb5QTTz5kZueGs7jjWleXun6ccGMccgTnGOYuCPhmyaXrNJKzw33TsOhmzel98zhYFp+7F9tujys21vHWp8czkZWKi+DQDA/EsxCHs4OBytKBu1Sh3vFl0+X2Kg+ZNtxmDJ/xJ30m49STTThzq1KI58u1Rv8UhlBgh+kCgoKbEnxlSP7+SUcjaLgeYgBvQXh88FcnWqiM+flDyx1pIaFiKXmzLVfQViXDDLgvlIoDxmHFOMrf4BPk98nHcy1K1FdxP0lJcfQcCoGKhnykoEZf4IT79zbpnvxPZBqfzKqtBOy4DAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(71200400001)(122000001)(107886003)(83380400001)(38100700002)(186003)(2906002)(52536014)(8936002)(4326008)(33656002)(8676002)(55016003)(5660300002)(76116006)(66476007)(7696005)(110136005)(316002)(86362001)(66446008)(6506007)(66946007)(53546011)(64756008)(66556008)(54906003)(508600001)(38070700005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?esGR6X2sgiLHPG3wG5cV+6qMn7WvEZCoSWIHogk86eyF1sTT4wIoU9oR4e4y?=
 =?us-ascii?Q?jWaADHOnB/T8k0nj1N1wYGAW63MvRVqifUVv1yKmnnnz4WdFbLj7ZEvWNMio?=
 =?us-ascii?Q?KPDdeh6NORPw9DsouVlQMM17ZU1RSbxdKo2EgDt9Na7yItDivEH6KpS1kpha?=
 =?us-ascii?Q?M5/uEh8a+aU3bsJ3jMH7Z1wtyZ9kWWJP3Vg5AP8mpz3si97lFRfMqGZgUHEe?=
 =?us-ascii?Q?EYuA6iEpnBz+TB7gMg8PitiO7eaKzTBjqn9/eu3uHxisF8r2GiKXHuAb/kBz?=
 =?us-ascii?Q?l7mO3Sddb4Z5/yyuA3Uj8EkdetwndIg55c0nzNQ5/6kHuFooFiHG/+ew2LgL?=
 =?us-ascii?Q?Iwan/t90EaSslVBZBIfPcf0ATbFAvOX02Vdo9q0uao3HLMlE9VJu7mpf+flC?=
 =?us-ascii?Q?6cjwWUOH6llHy9N6wpDAhlujIhMqqlyHYArtsA8PN4U3cncRzDIJjca2a6Z7?=
 =?us-ascii?Q?KGE/S/jiiTqGNYpKQuZht9Ncox2a3mOc32FFt+kxi5vNxBOAaZTTNcXCY+X8?=
 =?us-ascii?Q?WGlk1Q+Bh1bOmwsk7D/AivnlPm4QJvRGlg6jn6lmX5Ikp/jk65LyQkIPng3w?=
 =?us-ascii?Q?ATX4ARCReDM/pa0bOqR5I993Ke6B3TR0aYs3p/Vn3pjgeL48mD7tYmLP8xNd?=
 =?us-ascii?Q?3i1CGeW1yEm0OEuoWYu/3iKtIRhTvsKrdW2eM9RDpDPYInKEWur2Y4nUz0mw?=
 =?us-ascii?Q?LkusLnJ4w0RWA+feZaH/b3zhWtYvtxkeOmDvlUre2qI9yc650DRbKS3N5uol?=
 =?us-ascii?Q?nyu/LmwbQLm2DZtfOeb+AE45PTU30tlaVa7nl38xJ2momLWwOTY6MO+4qEr+?=
 =?us-ascii?Q?OAgPXfga8U3sIQhWSK2fIe7hGjzI4kM2e6AwRes/AJZrlFhC/qbpfZ9Iafjh?=
 =?us-ascii?Q?JVsk3yRgPH7nNdj5b4kfq8q5XcG21vV7y/iaZKEz9OPqJclzWHzo4/73zhCX?=
 =?us-ascii?Q?F9YTkuKldinKWFLODg8QIWPj141LxPwcuQh9Ehryc9t6jDxQu6gpK7pvS4VY?=
 =?us-ascii?Q?KACtjSsTYFus674fJNOFOYqxXCEKtvYckGuhJW19OQazOEQQQBLK7Yfkk0LX?=
 =?us-ascii?Q?SRppDpvEJYZQ2OK1lh7CUdViGezDsPxZqZGsSkKy1tyfQSyGcnh1RRHbl0v0?=
 =?us-ascii?Q?5NYtGSv9WFJCVjH3Trt74IWirJHxtco8vmC2XmqCieFEpf/krOSpKCZgp+69?=
 =?us-ascii?Q?jYes55lvFBz1RdAfw4xbqPMsUlyt7t9JoBfPQPcf6efnpCfnr3NrPqi9+fqd?=
 =?us-ascii?Q?IxaKJzm+j1lk6k9go6aRZY0srQC8o28syOwIucvliekkLX/noF17/W+1cgGi?=
 =?us-ascii?Q?xlnu8O2iBBsG8SGNVKp9eRFThHI3CLpalL6tvq8b23a4MUs4FylPhXNZwEQj?=
 =?us-ascii?Q?hS+mSL6eUVXfCzWtB3SmKndQWME1/jno9PYR10lXdmCwc3JxSI9l/d47R8DI?=
 =?us-ascii?Q?K4324MP9zPy9GxFMM/AmLU45q/z0H+2YrYSfBJe8zG7PWtMG5WaRZ2Ft4FxY?=
 =?us-ascii?Q?JbwzqIaVJ1FD/u22vvrzZBXtIxshd/9GY7+uFw16W0rfrbbIrQvDRisrKC57?=
 =?us-ascii?Q?7Htcmu8sWenvAPYq2ZhS6IR8+NHTrRdhSiL3bRcx92jwcNLI/VymgxhuHvDu?=
 =?us-ascii?Q?BkzC/1q7xDEwAx6Pwhahi7oUlvJ3ThtGxlpKGw3cS6NshhPRbElBGN6K4lbr?=
 =?us-ascii?Q?RVlysg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76764cf-6f45-4e23-982c-08d9fb54d75e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 07:26:45.6729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQEsKbePRO96Cx7DkbtE3uHUuPHa7lrN3IL0qcEAsgaDUNsUP/lVaJu36saL44s2ef2gXfQ74jvDkCLOg1grtkeyCeh+24nnumWSNTlqUjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4569
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

++

-----Original Message-----
From: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>=20
Sent: Tuesday, March 1, 2022 12:25 PM
To: ulf.hansson@linaro.org; adrian.hunter@intel.com
Cc: asutoshd@codeaurora.org; stummala@codeaurora.org; sayalil@codeaurora.or=
g; cang@codeaurora.org; rampraka@codeaurora.org; linux-mmc@vger.kernel.org;=
 linux-kernel@vger.kernel.org; linux-arm-msm@vger.kernel.org; Sajida Bhanu =
(Temp) (QUIC) <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V1] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC

Reset GCC_SDCC_BCR register before every fresh initilazation. This will res=
et whole SDHC-msm controller, clears the previous power control states and =
avoids, software reset timeout issues as below.

[ 5.458061][ T262] mmc1: Reset 0x1 never completed.
[ 5.462454][ T262] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI =
REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [ 5.469065][ T262] mmc1: sd=
hci: Sys addr: 0x00000000 | Version:
0x00007202
[ 5.475688][ T262] mmc1: sdhci: Blk size: 0x00000000 | Blk cnt:
0x00000000
[ 5.482315][ T262] mmc1: sdhci: Argument: 0x00000000 | Trn mode:
0x00000000
[ 5.488927][ T262] mmc1: sdhci: Present: 0x01f800f0 | Host ctl:
0x00000000
[ 5.495539][ T262] mmc1: sdhci: Power: 0x00000000 | Blk gap: 0x00000000 [ 5=
.502162][ T262] mmc1: sdhci: Wake-up: 0x00000000 | Clock: 0x00000003 [ 5.50=
8768][ T262] mmc1: sdhci: Timeout: 0x00000000 | Int stat:
0x00000000
[ 5.515381][ T262] mmc1: sdhci: Int enab: 0x00000000 | Sig enab:
0x00000000
[ 5.521996][ T262] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int:
0x00000000
[ 5.528607][ T262] mmc1: sdhci: Caps: 0x362dc8b2 | Caps_1: 0x0000808f [ 5.5=
35227][ T262] mmc1: sdhci: Cmd: 0x00000000 | Max curr: 0x00000000 [ 5.54184=
1][ T262] mmc1: sdhci: Resp[0]: 0x00000000 | Resp[1]:
0x00000000
[ 5.548454][ T262] mmc1: sdhci: Resp[2]: 0x00000000 | Resp[3]:
0x00000000
[ 5.555079][ T262] mmc1: sdhci: Host ctl2: 0x00000000 [ 5.559651][ T262] mm=
c1: sdhci_msm: ----------- VENDOR REGISTER
DUMP-----------
[ 5.566621][ T262] mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:
0x6000642c |
DLL cfg2: 0x0020a000
[ 5.575465][ T262] mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:
0x00010800 | DDR cfg: 0x80040873
[ 5.584658][ T262] mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 :
0xf88218a8 Vndr func3: 0x02626040

Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---
 drivers/mmc/host/sdhci-msm.c | 48 ++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c in=
dex 50c71e0..f10b3c7 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/interconnect.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/reset.h>
=20
 #include "sdhci-pltfm.h"
 #include "cqhci.h"
@@ -284,6 +285,7 @@ struct sdhci_msm_host {
 	bool uses_tassadar_dll;
 	u32 dll_config;
 	u32 ddr_config;
+	struct reset_control *core_reset;
 	bool vqmmc_enabled;
 };
=20
@@ -2482,6 +2484,45 @@ static inline void sdhci_msm_get_of_property(struct =
platform_device *pdev,
 	of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);  }
=20
+static int sdhci_msm_gcc_reset(struct platform_device *pdev,
+	       struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
+	struct sdhci_msm_host *msm_host =3D sdhci_pltfm_priv(pltfm_host);
+	int ret =3D 0;
+
+	msm_host->core_reset =3D devm_reset_control_get(&pdev->dev, "core_reset")=
;
+	if (IS_ERR(msm_host->core_reset)) {
+		ret =3D PTR_ERR(msm_host->core_reset);
+		dev_err(&pdev->dev, "core_reset unavailable (%d)\n", ret);
+		msm_host->core_reset =3D NULL;
+	}
+	if (msm_host->core_reset) {
+		ret =3D reset_control_assert(msm_host->core_reset);
+		if (ret) {
+			dev_err(&pdev->dev, "core_reset assert failed (%d)\n",
+						ret);
+			goto out;
+		}
+		/*
+		 * The hardware requirement for delay between assert/deassert
+		 * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
+		 * ~125us (4/32768). To be on the safe side add 200us delay.
+		 */
+		usleep_range(200, 210);
+
+		ret =3D reset_control_deassert(msm_host->core_reset);
+		if (ret) {
+			dev_err(&pdev->dev, "core_reset deassert failed (%d)\n",
+						ret);
+			goto out;
+		}
+		usleep_range(200, 210);
+	}
+
+out:
+	return ret;
+}
=20
 static int sdhci_msm_probe(struct platform_device *pdev)  { @@ -2529,6 +25=
70,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
=20
 	msm_host->saved_tuning_phase =3D INVALID_TUNING_PHASE;
=20
+	ret =3D sdhci_msm_gcc_reset(pdev, host);
+	if (ret) {
+		dev_err(&pdev->dev, "core_reset assert/deassert failed (%d)\n",
+					ret);
+		goto pltfm_free;
+	}
+
 	/* Setup SDCC bus voter clock. */
 	msm_host->bus_clk =3D devm_clk_get(&pdev->dev, "bus");
 	if (!IS_ERR(msm_host->bus_clk)) {
--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member o=
f Code Aurora Forum, hosted by The Linux Foundation

