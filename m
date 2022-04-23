Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7B750C686
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiDWC0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiDWC0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B1519C742;
        Fri, 22 Apr 2022 19:23:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76AA0615A2;
        Sat, 23 Apr 2022 02:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04D6C385A0;
        Sat, 23 Apr 2022 02:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650680612;
        bh=haZUNetI18mwticLWcDQIHl1eNz0IU+GIiz4lHFqO2o=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=NJVBlWtCwHJSzgU8Bjes7Sdh8ZHwb3qWfO2cph12yW4KJKdJ3CgqbEvh0q/SzGTTf
         CdqygZJCDjvDSpo0lvse2ZJEwUCi6xSlmYwE5TnvilFFZ5dz/ksZgfPd/CNhd7uRuY
         TJir3f622QHjlMRS4GOxI7zjKvjyybz4GJZRacem74bO+/3PnWPmOGN1Fc4Ppybp4t
         fmLJOwMSg6Lk+t252b5EC5t35QxapQRpjLkstpdlctW82g3XD8DvGazuepzK4PFA4F
         lS/cJB/zUlCW63iKpc/SDog9tbXpueL3eU2vk0eecxsDLJsn1MfIzQAP3YRQV8RHKJ
         bpDp6ZBUcJJtQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8e893363-3e47-2abe-7111-b3fb0888d4fc@gmail.com>
References: <20220422012059.52267C385A5@smtp.kernel.org> <20220422013317.30362-1-linmq006@gmail.com> <20220422014411.4F96BC385A7@smtp.kernel.org> <8e893363-3e47-2abe-7111-b3fb0888d4fc@gmail.com>
Subject: Re: [PATCH v2] clk: imx: scu: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage
From:   Stephen Boyd <sboyd@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 Apr 2022 19:23:30 -0700
User-Agent: alot/0.10
Message-Id: <20220423022332.C04D6C385A0@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miaoqian Lin (2022-04-21 18:59:54)
>=20
> On 2022/4/22 9:44, Stephen Boyd wrote:
> > Quoting Miaoqian Lin (2022-04-21 18:33:16)
> >> If the device is already in a runtime PM enabled state
> >> pm_runtime_get_sync() will return 1.
> >>
> >> Also, we need to call pm_runtime_put_noidle() when pm_runtime_get_sync=
()
> >> fails, so use pm_runtime_resume_and_get() instead. this function
> >> will handle this.
> >>
> >> Fixes: 78edeb080330 ("clk: imx: scu: add runtime pm support")
> >> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> >> ---
> > Please don't send patches as replies to previous versions of the patch.
>=20
> Sorry, I thought I should keep them in one thread, to provide the context

Please link back to previous revisions with lore.

https://lore.kernel.org/r/<message-id-of-rev1>

and then add a change log below the triple dash referencing that lore
link and anything that has changed since that revision.

>=20
> for other people to follow up. Am I suppose to resend it?

Yes. Might as well practice making a changelog at the same time.
