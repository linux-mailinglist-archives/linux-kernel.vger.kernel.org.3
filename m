Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A774D6BF3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 03:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiCLCRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 21:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCLCRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:17:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40572A8003;
        Fri, 11 Mar 2022 18:16:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CA29616C8;
        Sat, 12 Mar 2022 02:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A49C340E9;
        Sat, 12 Mar 2022 02:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647051392;
        bh=NBibCk+t0yR60zqzNgURK/ogrI+rR6hfVPJg3VVg+Q8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AALGNVaNEZhSo3Fmw6zTudqEFPmnG9P6RuyNvUFa1Ik6BvlmVMZZ0r5JkYT9O8aGt
         MIxLbhG0Mio5rmNWRfjZ/4azDFmDw0+pxDQ55HHlzabHK/iUpMOEO6h/+WEsLWrRdG
         Mxparitf0djsrrJdym3d8ge7u/fnYOZpsWV+PFswpHZ6LkPR0qh7R6w+oOadBGrfUl
         MqkIqANEA9qP7IjCIRolVjS/AlGvMMbzjAjf9oXSsLwqUXTdLma0oMgiHul7L2Hj0j
         HmKm5zcvhFb+mCs4rstZUoPsKsMah8fGuF8D390nLCh25pTmnkUceWxfyvsehNLdx1
         9BHTNVcN06Idg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220218000922.134857-2-j.neuschaefer@gmx.net>
References: <20220218000922.134857-1-j.neuschaefer@gmx.net> <20220218000922.134857-2-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v4 1/5] clk: actions: Terminate clk_div_table with sentinel element
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>,
        linux-actions@lists.infradead.org
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Date:   Fri, 11 Mar 2022 18:16:30 -0800
User-Agent: alot/0.10
Message-Id: <20220312021632.97A49C340E9@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-02-17 16:09:17)
> In order that the end of a clk_div_table can be detected, it must be
> terminated with a sentinel element (.div =3D 0).
>=20
> In owl-s900.s, the { 0, 8 } element was probably meant to be just that,
> so this patch changes { 0, 8 } to { 0, 0 }.
>=20
> Fixes: d47317ca4ade1 ("clk: actions: Add S700 SoC clock support")
> Fixes: d85d20053e195 ("clk: actions: Add S900 SoC clock support")
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> ---

Applied to clk-next
