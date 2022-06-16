Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086E954E507
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377701AbiFPOiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376918AbiFPOiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:38:00 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5406120BFD;
        Thu, 16 Jun 2022 07:37:58 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1BA05240007;
        Thu, 16 Jun 2022 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655390276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AffThJ0/PxGNjxerxTAn0ejOKaeR6A8gRvY3EvAGqMk=;
        b=QXO2bGvu8Trep4mecw9AonLkzv9k4fOr6tBtBkomlPNpXhphHVgHbi7Hhj8hmxPcARoW/n
        6lp9/a+RL+/O3SN8dJ8P2jd4lBFJwVfmxjK4r9ZkC4HfK0QBke6ZkAJOzVAFb6cR076aQ5
        nTO/gG//tf3+mdtkQuebFCofIDBicPCR8IOKAeVEIsZB87/ZMLWAblNI+n02dd27VOC6nV
        uJrDpHaaiBQVvgNwIh648zJcMef6aAPHJVyydWSAtt7SP3o9zQELt4isdUgjS/jbExUnTw
        L+yLeRPq004Pna/T7Js29Yz2olNWugJQrjYe+ed3U4wC/EkvXw8juumsREhtrA==
Date:   Thu, 16 Jun 2022 16:37:51 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] mtd: nand: raw: qcom_nandc: reorder
 qcom_nand_host struct
Message-ID: <20220616163751.2b5962df@xps-13>
In-Reply-To: <62aa76ad.1c69fb81.7e2d3.0c8e@mx.google.com>
References: <20220615000612.3119-1-ansuelsmth@gmail.com>
        <20220615000612.3119-2-ansuelsmth@gmail.com>
        <20220615171132.GA3606@thinkpad>
        <62aa76ad.1c69fb81.7e2d3.0c8e@mx.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ansuel/Christian,

ansuelsmth@gmail.com wrote on Thu, 16 Jun 2022 02:18:08 +0200:

> On Wed, Jun 15, 2022 at 10:41:32PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jun 15, 2022 at 02:06:10AM +0200, Ansuel Smith wrote: =20
> > > Reorder structs in nandc driver to save holes.
> > >=20
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com> =20
> >=20
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> >=20
> > Thanks,
> > Mani
> > =20
>=20
> I'm sending v8 with a different Sob so I'm not adding the review tag (in
> v8).
> In short the new Sob is what I will use onwards, wanted to keep the
> Ansuel reference but it was suggested to use Christian Marangi and
> nothing more. It's just a name change and we are the same person and
> nobody is stealing ownership of the patch.
> Sorry for the mess.

Mmmh strange, but okay. You are supposed to contribute with your real
identity, not under pseudonym anyway.

Also, you could have kept Mani's R-by in v8 but anyway. Mani, can
you resend them?

Thanks,
Miqu=C3=A8l
