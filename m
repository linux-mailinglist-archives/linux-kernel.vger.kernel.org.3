Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AA5543EC2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiFHVnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiFHVnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:43:46 -0400
X-Greylist: delayed 1214 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jun 2022 14:43:43 PDT
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15AE92733
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1654723379; bh=KIO51oCSFBweuGA1Msu2btlmkDy6vYub6CEmYJxxH4w=;
        h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:MIME-Version:Content-Transfer-Encoding;
        b=bDx4yfH5O9J40SpES1cArf5QgrRDpSgNAoMMIwMgccQj4itj658OFVp7qZWAE4hn8
         L37MVHQNQJUw7/7LYIOpMumOgwfpSQace5VzE1Fr997+iHEXCs/PUxqaBeRUXK4Fok
         HP3VShc8/msEIa+BU9WcIrqDZUlSISxKaqbfbphI=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Wed,  8 Jun 2022 23:22:59 +0200 (CEST)
X-EA-Auth: UhNYjE+10JvU06sCLX4eJVHCBIE9YEmsIEtVZsDiqasF96VM03rc5qtn5aeyRFiRMzJkqxMheEJk4YsHAbGb7Qz2NgE5IfNzzY16N2TzQSw=
Message-ID: <78f1adee5c6e0c3547c116d0e78fe5b70f9c15e1.camel@mailoo.org>
Subject: Re: [PATCHv2] iommu/arm-smmu-qcom: Add debug support for TLB sync
 timeouts
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_guptap@quicinc.com,
        Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Wed, 08 Jun 2022 23:22:58 +0200
In-Reply-To: <20220526041403.9984-1-quic_saipraka@quicinc.com>
References: <20220526041403.9984-1-quic_saipraka@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 26 mai 2022 =C3=A0 09:44 +0530, Sai Prakash Ranjan a =C3=A9crit=C2=
=A0:
> TLB sync timeouts can be due to various reasons such as TBU power down
> or pending TCU/TBU invalidation/sync and so on. Debugging these often
> require dumping of some implementation defined registers to know the
> status of TBU/TCU operations and some of these registers are not
> accessible in non-secure world such as from kernel and requires SMC
> calls to read them in the secure world. So, add this debug support
> to dump implementation defined registers for TLB sync timeout issues.
>=20
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> ---
>=20
> Changes in v2:
> =C2=A0* Use scm call consistently so that it works on older chipsets wher=
e
> =C2=A0=C2=A0 some of these regs are secure registers.
> =C2=A0* Add device specific data to get the implementation defined regist=
er
> =C2=A0=C2=A0 offsets.
>=20
> ---
> =C2=A0drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 161 ++++++++++++++++++=
---
> =C2=A0drivers/iommu/arm/arm-smmu/arm-smmu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 2 +
> =C2=A0drivers/iommu/arm/arm-smmu/arm-smmu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 1 +
> =C2=A03 files changed, 146 insertions(+), 18 deletions(-)

Hi Sai, and thanks for this patch !

I've encountered TLB sync timeouts with msm8939 SoC recently.
What would be needed to add to this patch so this SoC is supported ?
Like, where could one check the values to be used in an equivalent
of qcom_smmu_impl0_reg_offset values for this SoC (if any change needed) ?
Current values are not found by simply greping in downstream/vendor dtsi/dt=
s files...



