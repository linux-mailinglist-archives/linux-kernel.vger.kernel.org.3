Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A064046580D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353131AbhLAVBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 16:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353354AbhLAU47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:56:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC81C06175A;
        Wed,  1 Dec 2021 12:53:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4880B8203E;
        Wed,  1 Dec 2021 20:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD11C53FCC;
        Wed,  1 Dec 2021 20:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638392012;
        bh=Y4eHT/HolQZWKQOv69dUVXe0zZBCotUuBJFxkF8SwDQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UlRe4S7o0H2Wt9xx/Xs5PQzEjNHgjOpk6IgkmLi3NaN4VTYSeRd1cUiiDt0j0+F+T
         k8Koihaz/GNIIjK3AIfiQHwETDr7cL5ETJNTrNfP577PQDlkWBQrOro0kvxKuV3rHj
         jv0dvaQWX30f22TEkXGpqzFY0X5r1Hmh7AUXm3bwHtefCoYaGT1rT6lYFXi4k1uk8t
         Bwojy8mrP4pDN5Wa6N6OwpSqMUuMPCDa/4LWP/VC/ROLhaCxAC1QKuZl1mnd/d0PBi
         HpuYojfgQBYu3CKsYvsrz2wyotPOPLUqroCWJa2wftqRpKfS9rinLbSnDDfQbcTNup
         yBkiRbud0gdFw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1638174137-23290-1-git-send-email-quic_fenglinw@quicinc.com>
References: <1638174137-23290-1-git-send-email-quic_fenglinw@quicinc.com>
Subject: Re: [PATCH v3 00/10] A bunch of fix and optimization patches in spmi-pmic-arb.c
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     collinsd@codeaurora.org, subbaram@codeaurora.org,
        quic_fenglinw@quicinc.com
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Dec 2021 12:53:31 -0800
User-Agent: alot/0.9.1
Message-Id: <20211201205332.6AD11C53FCC@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fenglin Wu (2021-11-29 00:22:07)
>   Remove [v2 07/10], it's no longer needed after this change:
>         https://lore.kernel.org/all/20211118034719.28971-1-quic_collinsd@=
quicinc.com/T/#u
>   In [v3 07/10], update the author email to match with Signed-off-by.
>   In [v3 10/10], address issues in qcom,spmi-pmic-arb.yaml

Please resend and Cc irqchip maintainers.

>=20
> Abhijeet Dharmapurikar (1):
>   spmi: pmic-arb: handle spurious interrupt
>=20
> Ashay Jaiswal (1):
>   spmi: pmic-arb: add support to dispatch interrupt based on IRQ status
>=20
> David Collins (6):
>   spmi: pmic-arb: check apid against limits before calling irq handler
>   spmi: pmic-arb: correct duplicate APID to PPID mapping logic
>   spmi: pmic-arb: block access for invalid PMIC arbiter v5 SPMI writes
>   bindings: spmi: spmi-pmic-arb: mark interrupt properties as optional
>   spmi: pmic-arb: make interrupt support optional
>   spmi: pmic-arb: increase SPMI transaction timeout delay
>=20
> Fenglin Wu (1):
>   dt-bindings: convert qcom,spmi-pmic-arb binding to YAML format
>=20
> Subbaraman Narayanamurthy (1):
>   spmi: pmic-arb: do not ack and clear peripheral interrupts in
>     cleanup_irq
>=20
>  .../bindings/spmi/qcom,spmi-pmic-arb.txt           |  65 ----------
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml          | 128 +++++++++++++++=
++++
>  Documentation/devicetree/bindings/spmi/spmi.yaml   |   3 +-
>  drivers/spmi/spmi-pmic-arb.c                       | 137 +++++++++++++++=
------
>  4 files changed, 226 insertions(+), 107 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic=
-arb.txt
>  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic=
-arb.yaml
>=20
> --=20
> 2.7.4
>
