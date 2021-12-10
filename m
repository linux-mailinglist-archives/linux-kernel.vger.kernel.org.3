Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3260F46F8F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 03:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhLJCJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 21:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhLJCJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 21:09:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66992C061746;
        Thu,  9 Dec 2021 18:05:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B1F98CE2997;
        Fri, 10 Dec 2021 02:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA4DC004DD;
        Fri, 10 Dec 2021 02:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639101949;
        bh=n8sUWaojW+htl7NSLd54cmcp05O+wNy2FaoS7mT4384=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lr/ZjvJzpGDYyRNWbaZolttNd06leFWgfEieqKY8FNO4dNWx58jAA8vrIEHagAjaC
         Y3iO+a3J2L/Q6FJfmBj2/nOyw+waHF4l/L81nnZEgZbT4IO+CmlBAb5EFQEbHwDOKQ
         +eIYb0tn+VyJiFQ2dnaWc5lK3pMGM7XzoO/jZaId1kEY9Fbsgmj6H2BTuDqGGsNhSC
         BGXK3ENBG/Zc9ZZ8WrVu/2kD6h3drZQGGJMic32dhyNpLjrv9hqN4SBh3txZ4MsSi/
         FMtTSd58v84IzJWfwzb25FZnJAZxEqQ5ez3h4oeUUTdNmAoX6oYpzEcnEtGEf/o/tW
         3Vt61vL59FI/Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1638453489.532760.3736891.nullmailer@robh.at.kernel.org>
References: <1638403212-29265-1-git-send-email-quic_fenglinw@quicinc.com> <1638403212-29265-11-git-send-email-quic_fenglinw@quicinc.com> <1638453489.532760.3736891.nullmailer@robh.at.kernel.org>
Subject: Re: [RESEND PATCH v3 10/10] dt-bindings: convert qcom,spmi-pmic-arb binding to YAML format
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        collinsd@codeaurora.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        subbaram@codeaurora.org, tglx@linutronix.de, maz@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        Rob Herring <robh@kernel.org>
Date:   Thu, 09 Dec 2021 18:05:48 -0800
User-Agent: alot/0.9.1
Message-Id: <20211210020549.BFA4DC004DD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2021-12-02 05:58:09)
> On Thu, 02 Dec 2021 08:00:12 +0800, Fenglin Wu wrote:
> > Convert the SPMI PMIC arbiter documentation to JSON/yaml. While at it,
> > update SPMI bus "reg" items constraint for SPMI PMIC arbiter to carry
> > it and update it with a smaller range.
> >=20
> > Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> > ---
> >  .../bindings/spmi/qcom,spmi-pmic-arb.txt           |  67 -----------
> >  .../bindings/spmi/qcom,spmi-pmic-arb.yaml          | 128 +++++++++++++=
++++++++
> >  Documentation/devicetree/bindings/spmi/spmi.yaml   |   3 +-
> >  3 files changed, 130 insertions(+), 68 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pm=
ic-arb.txt
> >  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pm=
ic-arb.yaml
> >=20
>=20
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
>=20
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
>=20
> Full log is available here: https://patchwork.ozlabs.org/patch/1562483

Are any of these problems going to be fixed?
