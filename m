Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B88B484A57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiADWEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:04:45 -0500
Received: from ip-16.mailobj.net ([213.182.54.16]:44176 "EHLO msg-6.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232504AbiADWEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1641333864; bh=lHp0UvUah92KKPlvcUMbQFYVc6g3XCuqxRZn264QpCQ=;
        h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:MIME-Version:Content-Transfer-Encoding;
        b=YfHu3Ib4CMPne8gVNPiPiQTXmUrIkJsbFR81gzI6KBYVxwS/AYsm8gmLsnCdxImEn
         xWdlrQ5pk99RQ6dHA4AV4updH9D3trai3BsehQ7HRyHS5ZQUv5LmWJpkXA2fz2rLf3
         mMd4ZylTryve+On95vjiOOd7II1rI5KqcpsrdYe0=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Tue,  4 Jan 2022 23:04:24 +0100 (CET)
X-EA-Auth: oxHs20R9oJarhLAFe19phH5Y2A6Qj5HoKCXz1xSYEm9MYXCDPfcQDk36oOEfmjvlC29iFnXNW4jJQRAnmlnylrbQAQabHawFfNezHUH5Bqk=
Message-ID: <fd7f6a115ece824c75f5b8fd02f1fc84cefca176.camel@mailoo.org>
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sc7280: Add nodes for va tx
 and rx macros and external codecs
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Date:   Tue, 04 Jan 2022 23:04:23 +0100
In-Reply-To: <1641208380-15510-2-git-send-email-quic_srivasam@quicinc.com>
References: <1641208380-15510-1-git-send-email-quic_srivasam@quicinc.com>
         <1641208380-15510-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 03 janvier 2022 =C3=A0 16:42 +0530, Srinivasa Rao Mandadapu a =C3=
=A9crit=C2=A0:
> SC7280 has VA, TX and RX macros with SoundWire Controllers to attach with
> codecs like WCD938x, max98360a using soundwire masters and i2s bus.
> Add these nodes for sc7280 based platforms audio use case.
> Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.
>=20
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
> =C2=A0arch/arm64/boot/dts/qcom/sc7280-crd.dts=C2=A0 |=C2=A0=C2=A0 4 ++
> =C2=A0arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |=C2=A0 52 ++++++++++++++
> =C2=A0arch/arm64/boot/dts/qcom/sc7280.dtsi=C2=A0=C2=A0=C2=A0=C2=A0 | 113 =
+++++++++++++++++++++++++++++++
> =C2=A03 files changed, 169 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dt=
s/qcom/sc7280-crd.dts
> index cd2755c..035cca9 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> @@ -72,6 +72,10 @@ ap_ts_pen_1v8: &i2c13 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pins =3D "gpio51";
> =C2=A0};
> =C2=A0
> +&wcd938x {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qcom,us-euro-gpios =3D <&tlmm =
81 0>;
> +};
> +

Maybe using a defined value is possible, rather than an obscure zero ?
GPIO_ACTIVE_HIGH ?



