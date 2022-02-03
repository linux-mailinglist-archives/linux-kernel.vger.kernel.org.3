Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130C44A7F19
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 06:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiBCF1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 00:27:31 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:17356 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiBCF13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 00:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1643866048; x=1644470848;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cSivUgOGkPW/7zxHDc3Qegezmq2wyGIPBp2pWGRefzI=;
  b=HmKUNkTlissZICHMz5stUdgaFjb9U2Iv67h73qABxw/wsnyKgbFnErqx
   ybuX3ILGNTXnGB6II89O7CUt4hgxjZUhC4ReXuSbsejwXbeNZRsfGjd1F
   SdzWkcvTe6nXrJsZ1jfocxPD/kmdF5dYjpME1/+YuWS5I8iehRRrGy25R
   U=;
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 05:27:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEYF0LWXoX4y2nox38UDOQm42a1IjqzPBC3i8wz9e/rVBM+/+06xf8xed9QiemEXa0bfwmMwz1ohB6f7WGCVMCi56CCc4YpVhw26DBQNZsR11qeSqQwEVl1BpSJfTwj/TNQuz0kMGXRiiW2JshgGDf5zNy/JYvFKx4HoQTZ9Kulv5Ay8ed1kbBwcGUpcvMHOt4H3t9XvFbduMzebLDf1cm0g/6Ds6xFat/ZWO5KBOWMvJ+WA8BtaOHtUsEXleGxIDF/3KkWAiz9Pzz3YbOubPp+PPIGEkqtcTGgsynI2FmkWr1P9QJTQ4A0HMdytS7+DoFQGeM9vJk4qxi/1aHpVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSivUgOGkPW/7zxHDc3Qegezmq2wyGIPBp2pWGRefzI=;
 b=ByI+7wMss+W9HfDfySpKvdsLxWpkQwqZo4RLJe8HfIKzXl73Zn4wub88xm+leANNWSYrymz0M+3NZzdYcJIlHFWv6BQyqTkgHFhJhXFpzm9LiknU6PYjylVJWTT8ig4sljGLA5gwRw5cTGORNl2df6H/bBBaBIIrNHwM2oRwbCJqe+DrGLJFK70mVR3zCPxqANaTqkYwZdlHiKSQpCx6W6oPHOjmeY2h7Elhfxn3mJmQIQ9G9pguICCmTLSvrRJMVW5SOz7kPuJuaJ3QtobjkGLXALpUd7UCxo5J80w04AvWhChyLZWgjjJb9z6CUdNNJcan0gFqr/you7gILcphLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CO1PR02MB8853.namprd02.prod.outlook.com (2603:10b6:303:162::24)
 by SN6PR02MB4814.namprd02.prod.outlook.com (2603:10b6:805:90::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Thu, 3 Feb
 2022 05:27:24 +0000
Received: from CO1PR02MB8853.namprd02.prod.outlook.com
 ([fe80::a998:9c96:df98:4ada]) by CO1PR02MB8853.namprd02.prod.outlook.com
 ([fe80::a998:9c96:df98:4ada%9]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 05:27:24 +0000
From:   "Manikanta Pubbisetty (QUIC)" <quic_mpubbise@quicinc.com>
To:     "Manikanta Pubbisetty (QUIC)" <quic_mpubbise@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sibi Sankar (QUIC)" <quic_sibis@quicinc.com>,
        "kuabhs@chromium.org" <kuabhs@chromium.org>,
        "Rakesh Pillai (QUIC)" <quic_pillair@quicinc.com>
Subject: RE: [PATCH v10 0/3] Add support for sc7280 WPSS PIL loading
Thread-Topic: [PATCH v10 0/3] Add support for sc7280 WPSS PIL loading
Thread-Index: AQHYF1nX15IDnaDjA06a8NOpDR2LWayBTrlg
Date:   Thu, 3 Feb 2022 05:27:23 +0000
Message-ID: <CO1PR02MB885393107EC4D176861041D9E5289@CO1PR02MB8853.namprd02.prod.outlook.com>
References: <1643712724-12436-1-git-send-email-quic_mpubbise@quicinc.com>
In-Reply-To: <1643712724-12436-1-git-send-email-quic_mpubbise@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 858962ad-5f6a-443a-cef4-08d9e6d5dbde
x-ms-traffictypediagnostic: SN6PR02MB4814:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB48149877B65A2D1E430407CE99289@SN6PR02MB4814.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FifxPJNULJzxUNZJqxwj+mr6uDgbBcdi3lqj9YalSaczL4TXJ8qwPpL4MW2EpcJKfp3K/xIRJLzTBkt46lNXEi1wp78/T0FCqzZOOYUIa1RdjtAJabJDcfVSr1j+fVvaHm3AV4fynJ4GgqRMo+B9JTuITpqDHCCawGrCpZqCL3zgukbeVTxE71wPnG6rtShxgIIHG9+97gceRkqjsUQeqCoWTiJPNO9tg3nKuHKM2fXyMffUD5hMFDBPYJdZ65IwHWaZOi65EQ5EWavvQ/rdFHsYt4CTM1GTFlt7bn3PZcI2UyQuiaMg6iFW3wOBGpEVniqq7CJwQz5EcPNA34I5w9q8S2UBxCGqtX78zZSlsM2402aaFJh3fswRqFn2nSidTzROy0bbhWG7Ld3g+9f0I1eALjwTPiYLPdKhIV/7bp/kPTCCMlIbaiLUSH5TMoszkEt83+DSBqFbdc2hbkRm7uiD/weZOMDF5wx9Xlq6ku6KVu8PrRUIvRr4WtvETFwTciIzhYuBZtzgMWwefkWAtoIbD/wUgPtBFFPJcSRR8i08AvK1tdD3/iA9On64hZ57fTbmUbMPzxmhby5SFX1Vm6nikCW6pDqXSeBSvFwVVrJvOAMPtqG9q624f4ON4ujKgpOKB2Xv7ph2MoXFeg+Rty8/6AWH4uygOsB0B13fGdH1bEF2sLxNpGNQUcnYKmokwWVd8SHb+jhErDH2LHE+jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR02MB8853.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(4326008)(8676002)(66476007)(2906002)(107886003)(8936002)(33656002)(66556008)(53546011)(7696005)(83380400001)(66446008)(186003)(64756008)(66946007)(5660300002)(71200400001)(6506007)(52536014)(76116006)(9686003)(122000001)(38070700005)(38100700002)(508600001)(86362001)(316002)(55016003)(54906003)(110136005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rb+bSvfmpEx4FJnUErfQ2EWqCbKAtvFJCda83UqYqF1DPYbly59B9cuNF7FP?=
 =?us-ascii?Q?GEi9L2WJzGiqjF78Dw71ae9vm8GgRmaN+INKwMOBt/lcXL5+1yMkwkIVqe4n?=
 =?us-ascii?Q?ly3YwdvI6khn1OV4h/zcRw7UZgIZfH5Dh9LRDhcKpVHPsxtOexwCKEruaC1t?=
 =?us-ascii?Q?LfdMRnyacwxS9MFL9LoI5mRXkT86xRbx8ud+CPrGdT5uxOeQGt4UWGzXBMsq?=
 =?us-ascii?Q?qKd79EmWPhKkC5Ny6hmV3i3WUg2g0n/rbTdKdyZHgdMuJByj+klJ4GC4E2xR?=
 =?us-ascii?Q?mABHIZFWtwa3g6LsKKe3xfAiYf9ZAPPQj2wrUh3eGleLByI4dwrrvjClCjm+?=
 =?us-ascii?Q?yV4hF/PH6uZWijuDFlmRkYkfUxge3mwVCJeUeOWGT7CGesM6Wpt14uIC19PX?=
 =?us-ascii?Q?0qJo3YKCR2TBjF//VSqTrB3uXC88RaHpRVjbeeV9bpTnonD18gHEm6tg+qB6?=
 =?us-ascii?Q?73AeZ/zHL+pdBoiEdbi8FVugdYYjUSkMbMRXWxLSgoKhOrWmgj79R4/gqIxT?=
 =?us-ascii?Q?dbOAx1m1XkzMXWlKCkCx5tCnvXWK3xEgJFoIhLyeo3c47J9GvKn52XijMiuf?=
 =?us-ascii?Q?SsNB1hEfI46E/GWmjzbfybO81jrlkIR5CrPCL+NlAi/AB4Ud+YI9bK2VowSb?=
 =?us-ascii?Q?LMzYylrKF+KtDPbEQBJk/IOQ7cxphupdR5AhrB7rwoARtCx8BRlSyeMxjEwF?=
 =?us-ascii?Q?EMLMF6MB08yEDphcBad1yRSmatBF5Bs2sYPsFoKN/dFN3u2dBqlnKPa5eUoX?=
 =?us-ascii?Q?9347G/ud9Qb8btlkI0J2YgDiMNWCKZbskYro9Fjqin91kOLLxqk1CUXTg7N+?=
 =?us-ascii?Q?K4ojH7D4LDjdEyZJrA/JQbm0tFhtu9Nt3W7LF9pcgL2huIB8Y1oaaJO92Fzp?=
 =?us-ascii?Q?XqywERq+KuuQ6jegPmMfzkQV5xcVglIAB3OKYHi9qzlPPBTW2h/vEFPvfQI0?=
 =?us-ascii?Q?jiWDeo9P1HPmS48sp/pmFoRKFx7hrDR7N4ijT54Pxx7NyMXG3bJHt6sElA5/?=
 =?us-ascii?Q?It68fpyt8WNMUuQPpHAFn84XwxufxM1SIjFDXYiaaTFRR/yujDdmmJGT/N6C?=
 =?us-ascii?Q?7DZKbsLFDGSV1lTAD1PXCwe4R1jbnfmH2s/wGmLHdlXBUA+7Css7atw4fE9E?=
 =?us-ascii?Q?yP08XWZw3Gr+dp9eANDjDSgKqNJWPUq6WGCcvC1X8ePOb7khjK2+MKLr5vi8?=
 =?us-ascii?Q?t4dBraS3nYytcssIJZQEODbSMeSfh/Uiljy+0/w6RfKsl+yfr7MVXlmeDlJv?=
 =?us-ascii?Q?Wck2HlyNy9kB2H8hGpY8v3pw6+Hvm03Q52Go3RraHIu7DfhqaLPLxsjGQZhb?=
 =?us-ascii?Q?aZZ/PxkfYNa6q6x/cP0ZUydwvKuAy2v52vIJNuGZkQmck6WjSU4DVp7VTNY2?=
 =?us-ascii?Q?EbHAf8Avmu7vN9D5sHGTEcgozBglswu8uI1DJVC124FxKIjnK3Bj8YW6BPpi?=
 =?us-ascii?Q?Xoi7DcD6afxnySMrOjGXLYGkUa9L0KAWYxyk1LKzEBX79NJR92FVCm/bo+Dt?=
 =?us-ascii?Q?KpPO28qsKR72MTCPaGem6ngX8KJRXD/QucZmBBlrbC+0oq43QUN1G6FrShif?=
 =?us-ascii?Q?zN9uN/PVzgILY5Kc/03t1R8KMRg3k2gD3X9WkpQBT0kc6JXMd4RpbqpPJ9Bj?=
 =?us-ascii?Q?a0Ps5ORlRyk1zCiA2PJpiNErVV7zSvbQEt+o0ciWjFrrWZ/QvyYvARVyCeMf?=
 =?us-ascii?Q?WVn7Kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8853.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858962ad-5f6a-443a-cef4-08d9e6d5dbde
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 05:27:23.7902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DY+clJyqXLCYmy8jpnp5xdZM9i5cGCGxvxdQcSyEbNI/tlRAsRBOZjf9+xHjPxf0w69sm94tKuy1HXFNZS2Em+TQGOw8lTZq0vIearD75P4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4814
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Manikanta Pubbisetty (QUIC) <quic_mpubbise@quicinc.com>
> Sent: Tuesday, February 1, 2022 4:22 PM
> To: agross@kernel.org; bjorn.andersson@linaro.org; robh+dt@kernel.org;
> ohad@wizery.com; mathieu.poirier@linaro.org; p.zabel@pengutronix.de
> Cc: linux-remoteproc@vger.kernel.org; swboyd@chromium.org; linux-arm-
> msm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Sibi Sankar (QUIC) <quic_sibis@quicinc.com>;
> kuabhs@chromium.org; Rakesh Pillai (QUIC) <quic_pillair@quicinc.com>;
> Manikanta Pubbisetty (QUIC) <quic_mpubbise@quicinc.com>
> Subject: [PATCH v10 0/3] Add support for sc7280 WPSS PIL loading
>=20
> Add support for PIL loading of WPSS co-processor for SC7280 SOCs.
>=20
> Changes from v9:
> - Minor cosmetic changes
>=20
> Changes from v8:
> - Disallow num_proxy_pds to be more than the max allowed
> - Add "additionalProperties: false" for glink-edge property in wpss dt-bi=
ndings.
>=20
> Changes from v7:
> - Use "interrupts" instead of "interrupts-extended" in DT bindings.
> - Add glink-edge properties in DT bindings.
> - Use size_t for "proxy_pd_count" in wpss remoteproc driver
>=20
> Changes from v6:
> - Fixed the dt-bindings check in qcom,sc7280-wpss-pil.yaml
> - Fixed CDSP dt-bindings example node (compatible, glink-edge)
> - Fixed the clock-names used in wpss driver
> - Add support to get firmware-name from DTSI entry for wpss.
>=20
> Changes from v4/v5:
> - Add yaml conversion for adsp/cdsp dt-bindings
> - Change clock names in wpss dt-bindings
> - Correct mistake in signed-off email ID
>=20
> Rakesh Pillai (3):
>   dt-bindings: remoteproc: qcom: adsp: Convert binding to YAML
>   dt-bindings: remoteproc: qcom: Add SC7280 WPSS support
>   remoteproc: qcom: q6v5_wpss: Add support for sc7280 WPSS
>=20
>  .../bindings/remoteproc/qcom,hexagon-v56.txt       | 140 -------------
>  .../bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml  | 161 +++++++++++++++
> .../bindings/remoteproc/qcom,sc7280-wpss-pil.yaml  | 219
> ++++++++++++++++++++  .../bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
> | 160 +++++++++++++++
>  drivers/remoteproc/qcom_q6v5_adsp.c                | 227 +++++++++++++++=
++++--
>  5 files changed, 751 insertions(+), 156 deletions(-)  delete mode 100644
> Documentation/devicetree/bindings/remoteproc/qcom,hexagon-v56.txt
>  create mode 100644
> Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml
>  create mode 100644
> Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
>  create mode 100644
> Documentation/devicetree/bindings/remoteproc/qcom,sdm845-adsp-pil.yaml
>=20

Hi Bjorn,
Could you please help review this series and see if any further changes are=
 required?

Thanks,
Manikanta
