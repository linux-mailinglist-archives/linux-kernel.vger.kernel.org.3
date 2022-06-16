Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C6254D760
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348379AbiFPBwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356763AbiFPBvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:51:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9915058E4C;
        Wed, 15 Jun 2022 18:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53FB1B8216B;
        Thu, 16 Jun 2022 01:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6B9C3411A;
        Thu, 16 Jun 2022 01:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655344303;
        bh=hjN2r08/Oq7KGlqc8uknY5gQep3L96XqgvBKskBTPlE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dU/ISs4d4Ack/I6FjYr0aw/jfP3YLcgMhOr4ndQcbUXGsZwhf42pungTuY/GpMgid
         UHG4f5wabbidmEZ4n56Vy0GA24aztj6iRmWJQ4eY638Mt4GgfpfepDmx2Rny2ZOenN
         MctBeWc3VGj3SiEShC2UMBG5Z8BP77T+DB9oU4ey97jdco28ZwWtbvcgPWYQxK7Y46
         kiU4QdAQZ83KiNBwzZNs/2iAWb7ktrBEqLv5e8q+Zk5X3hw0nMBAQRdqAMSWbIsbnf
         9xWydgjdbBnLBRMk/GOXwT8RuGNcb/UlEdtKAc4CTFtEpJYN+mYiXj9c4PyXKExE8P
         dRU9HdJICqZ9w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220523093346.28493-7-rex-bc.chen@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com> <20220523093346.28493-7-rex-bc.chen@mediatek.com>
Subject: Re: [RESEND v8 06/19] clk: mediatek: reset: Revise structure to control reset register
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
Date:   Wed, 15 Jun 2022 18:51:40 -0700
User-Agent: alot/0.10
Message-Id: <20220616015142.DC6B9C3411A@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rex-BC Chen (2022-05-23 02:33:33)
> To declare the reset data easier, we add a strucure to do this instead
> of using many input variables to mtk_register_reset_controller().
>=20
> - Add mtk_clk_rst_desc to define the reset description when registering
>   the reset controller.
> - Rename "mtk_reset" to "mtk_clk_rst_data". We use it to store data of
>   reset controller.
> - Document mtk_clk_rst_desc and mtk_clk_rst_data.
> - Modify the documentation of mtk_register_reset_controller.
> - Extract container_of in update functions to to_mtk_clk_rst_data().
>=20
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Applied to clk-next
