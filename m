Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74D466D6E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 00:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349329AbhLBXJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 18:09:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48358 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240957AbhLBXJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 18:09:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E8726289E;
        Thu,  2 Dec 2021 23:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05F3C00446;
        Thu,  2 Dec 2021 23:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638486384;
        bh=VUEYdAFJhKTrltiaV7nF0XjUQpLcjDDZsHHE3Cltt/A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CW89NRiawMbLw6uHQrUgjZYn15mnKjZoJvsqaO2xz6iWLk4iRz4NqNhvhUU2eLbis
         iB8+R1EXrV18TlBa2LnW5YyC8eOLsq26WcWnw7mggeS0X9tt0xc2kPR2OB6L5JGvMu
         76+znuCTFR4Leec9rMRg+6obnDm9R0ig85R/rFLxlXBLoO69bZ6dAv0FYgJWWu+NQL
         0HJ7Ett3Ou7N6js6rOJp6SBAjrXOHLpn+R0gx+tfv3xuveqLN3WJQkUm5DfG7P9/XC
         D+E9u5bNrTP188nhKcZ5QjwjuQxVkHAFHVuvCHkiaX0/imTpPt6+NbJAIwNvnTYtRp
         FqOUlckDMzACQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211201072718.3969011-1-vkoul@kernel.org>
References: <20211201072718.3969011-1-vkoul@kernel.org>
Subject: Re: [PATCH] spmi: pmic-arb: Add support for PMIC v7
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Date:   Thu, 02 Dec 2021 15:06:23 -0800
User-Agent: alot/0.9.1
Message-Id: <20211202230624.C05F3C00446@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2021-11-30 23:27:18)
> @@ -1169,8 +1270,12 @@ static int spmi_pmic_arb_probe(struct platform_dev=
ice *pdev)
>         pmic_arb =3D spmi_controller_get_drvdata(ctrl);
>         pmic_arb->spmic =3D ctrl;
> =20
> +       /*
> +        * Don't use devm_ioremap_resource() as the resources are shared =
in
> +        * PMIC v7 onwards, so causing failure when mapping
> +        */
>         res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "core"=
);
> -       core =3D devm_ioremap_resource(&ctrl->dev, res);
> +       core =3D devm_ioremap(&ctrl->dev, res->start, resource_size(res));

What does this mean? We have two nodes in DT that have the same reg
properties? How does that work?

>         if (IS_ERR(core)) {
>                 err =3D PTR_ERR(core);
>                 goto err_put_ctrl;
