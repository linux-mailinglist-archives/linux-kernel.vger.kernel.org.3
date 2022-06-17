Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4861854FD04
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiFQSkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiFQSkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:40:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8940735248
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 11:40:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42D50B82B67
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 18:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FCFC3411B;
        Fri, 17 Jun 2022 18:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655491247;
        bh=n1lMVZHWVS0s9aDUcOtGjcugDZEPYPqWAceVrfKJziE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bllBknQfo46lK+t1UGHu5aGmd06g7XjsWGWnzWmnjLS9WZN3el6Sn6e1xs8vYeQFO
         IF89QLRSpSERHH+Lj2NQ4I2sCX/GeD8qcKFpMKnmBuDwu+cim8pzGtCOAJBfagJEwS
         QLNFsb/NcuYn3HU7dNf3D5SZsDb3dKC8yCV4jcGISWFJV1vOIeL9MaihKnG/onXbWb
         3kL3DoUbr0SOFiP/R5G2mQim/U0QnZtaBEglQt54p63vdS7LwUKtUy83rXxVvcQLlx
         K62HaqnltGH5RYcLP3aHisBh1lAV6lUsB4Mn+dxKb1yPaRnpJ6Rov6SHDjpFdr8WZj
         JlaSo35snxlnA==
Date:   Fri, 17 Jun 2022 11:40:45 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     HighW4y2H3ll <huzh@nyu.edu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix use of uninitialized variable in
 rts5261_init_from_hw, when efuse_valid == 1.
Message-ID: <YqzKrdI0JBORlptt@dev-arch.thelio-3990X>
References: <20220617044755.37535-1-huzh@nyu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617044755.37535-1-huzh@nyu.edu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 12:47:55AM -0400, HighW4y2H3ll wrote:
> Signed-off-by: zhenghao hu <huzh@nyu.edu>
> ---
>  drivers/misc/cardreader/rts5261.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
> index 749cc5a46d13..f22634b14dc8 100644
> --- a/drivers/misc/cardreader/rts5261.c
> +++ b/drivers/misc/cardreader/rts5261.c
> @@ -403,7 +403,7 @@ static void rts5261_init_from_hw(struct rtsx_pcr *pcr)
>  			setting_reg1 = PCR_SETTING_REG4;
>  			setting_reg2 = PCR_SETTING_REG5;
>  		}
> -	} else if (efuse_valid == 0) {
> +	} else {
>  		// default
>  		setting_reg1 = PCR_SETTING_REG1;
>  		setting_reg2 = PCR_SETTING_REG2;
> -- 
> 2.35.1
> 

I know Greg already replied but this has been fixed already [1]. Due to
a small snafu [2], it won't make 5.19-rc3 but I hope it will be fixed in
5.19-rc4.

[1]: https://git.kernel.org/gregkh/char-misc/c/bd476c1306ea989d6d9eb65295572e98d93edeb6
[2]: https://lore.kernel.org/CE205655-557F-486C-AF6A-099749208327@kroah.com/

Cheers,
Nathan
