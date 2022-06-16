Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D175354D765
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350913AbiFPBwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357710AbiFPBvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:51:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CAF58398;
        Wed, 15 Jun 2022 18:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3582BB8216D;
        Thu, 16 Jun 2022 01:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4729C3411A;
        Thu, 16 Jun 2022 01:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655344311;
        bh=yy6FP82JvrA88f4HpGfB5WIAhBe2yJmZ1L6j/1ZUcTI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gOUzU4BTqgL5SlQT2sTlJMVWB+jaQpbckylBTz9Atv4GBRu++FURvZJtJ+8MdRoUW
         w1LkahtE1kVdXeXrqjuCzpDSki4LclTG6z8qk76PB20Op4/bawin0KKOT9cgllOThl
         Byki1+fWqBmWYSgJDCJ+79Yc43M1xO/wMmHy/1v/6hC4I3h4ZNOwypJFsNMukbv4VE
         qu+vkHHZ7w7vzKKW95n3vw/c9I5LzwW1APWhRPxbKAayHDy7jQiBcskc5/2kUX4HZd
         ydtGem+O7nU5PcQHIo4sxER/iIwZsaVEPVBHXP7wkZNsoZn1mh0NCDgJsDigVN4XQv
         ZjDmsk5sp4NLA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523093346.28493-8-rex-bc.chen@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com> <20220523093346.28493-8-rex-bc.chen@mediatek.com>
Subject: Re: [RESEND v8 07/19] clk: mediatek: reset: Support nonsequence base offsets of reset registers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Wed, 15 Jun 2022 18:51:49 -0700
User-Agent: alot/0.10
Message-Id: <20220616015151.B4729C3411A@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rex-BC Chen (2022-05-23 02:33:34)
> The bank offsets are not serial for all reset registers.
> For example, there are five infra reset banks for MT8192: 0x120, 0x130,
> 0x140, 0x150 and 0x730.
>=20
> To support this,
> - Change reg_ofs to rst_bank_ofs which is a pointer to base offsets of
>   the reset register.
> - Add a new define RST_NR_PER_BANK to define reset number for each
>   reset bank.
>=20
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Applied to clk-next
