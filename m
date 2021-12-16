Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5CE47755F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbhLPPH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:07:59 -0500
Received: from elvis.franken.de ([193.175.24.41]:50693 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238287AbhLPPH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:07:57 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mxsMK-0001iD-02; Thu, 16 Dec 2021 16:07:52 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 7090FC09A0; Thu, 16 Dec 2021 16:05:25 +0100 (CET)
Date:   Thu, 16 Dec 2021 16:05:25 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     zajec5@gmail.com, hauke@hauke-m.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: BCM47XX: Replace strlcpy with strscpy
Message-ID: <20211216150525.GC15172@alpha.franken.de>
References: <20210906134923.102964-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906134923.102964-1-wangborong@cdjrlc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 09:49:23PM +0800, Jason Wang wrote:
> The strlcpy should not be used because it doesn't limit the source
> length. As linus says, it's a completely useless function if you
> can't implicitly trust the source string - but that is almost always
> why people think they should use it! All in all the BSD function
> will lead some potential bugs.
> 
> But the strscpy doesn't require reading memory from the src string
> beyond the specified "count" bytes, and since the return value is
> easier to error-check than strlcpy()'s. In addition, the implementation
> is robust to the string changing out from underneath it, unlike the
> current strlcpy() implementation.
> 
> Thus, We prefer using strscpy instead of strlcpy.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/mips/bcm47xx/board.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
> index 35266a70e22a..74113dcd86e0 100644
> --- a/arch/mips/bcm47xx/board.c
> +++ b/arch/mips/bcm47xx/board.c
> @@ -345,7 +345,7 @@ void __init bcm47xx_board_detect(void)
>  
>  	board_detected = bcm47xx_board_get_nvram();
>  	bcm47xx_board.board = board_detected->board;
> -	strlcpy(bcm47xx_board.name, board_detected->name,
> +	strscpy(bcm47xx_board.name, board_detected->name,
>  		BCM47XX_BOARD_MAX_NAME);
>  }
>  
> -- 
> 2.33.0

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
