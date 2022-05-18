Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0752BF30
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239939AbiERQFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbiERQFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:05:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F281A0764;
        Wed, 18 May 2022 09:05:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 225AE614B2;
        Wed, 18 May 2022 16:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BEAC385A5;
        Wed, 18 May 2022 16:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652889902;
        bh=X3NOZZM14krYh97jlLnxREynzXhmiCcmRbnYysiRhck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fpqRgUjNRlT1n5lCCA+scbxCmmG36DFgUgZ2Pj7Z7i3vQ1QdQv/dWCBjo54PEIzgx
         7od1AlzDT+jsF7KNs1YzMLFC78q71QtZxm6rZtYF5QyvBbPsOXNOEDQEuZ9qtSbtTA
         lTrTDGyIOINEjV39VmZjqR8QCIHe9UrsxGnWHvn00GZJf+L/Enr/N0hZxsgOif8m5C
         Y7vBC+yR1rQHXNsxT6bD3uFGjTKYJ+uReckCBXs/44Bh5aO1Dp3dzz60V85TmnVkvm
         R21d1AZjZQ+wT1oIJt6KyufK7DT+vWvCuPf0MCp8tKP0qqKQkdMdwG9gHQH4xB4e0s
         H7JPwolJYumBg==
Date:   Wed, 18 May 2022 09:05:00 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcp251xfd: silence clang's -Wunaligned-access
 warning
Message-ID: <YoUZLHIbxPu15/lN@dev-arch.thelio-3990X>
References: <20220518070517.q53bjzo6lbnq3f2i@pengutronix.de>
 <20220518114357.55452-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518114357.55452-1-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Wed, May 18, 2022 at 08:43:57PM +0900, Vincent Mailhol wrote:
> clang emits a -Wunaligned-access warning on union
> mcp251xfd_tx_ojb_load_buf.
> 
> The reason is that field hw_tx_obj (not declared as packed) is being
> packed right after a 16 bits field inside a packed struct:
> 
> | union mcp251xfd_tx_obj_load_buf {
> | 	struct __packed {
> | 		struct mcp251xfd_buf_cmd cmd;
> | 		  /* ^ 16 bits fields */
> | 		struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
> | 		  /* ^ not declared as packed */
> | 	} nocrc;
> | 	struct __packed {
> | 		struct mcp251xfd_buf_cmd_crc cmd;
> | 		struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
> | 		__be16 crc;
> | 	} crc;
> | } ____cacheline_aligned;
> 
> Starting from LLVM 14, having an unpacked struct nested in a packed
> struct triggers a warning. c.f. [1].
> 
> This is a false positive because the field is always being accessed
> with the relevant put_unaligned_*() function. Adding __packed to the
> structure declaration silences the warning.
> 
> [1] https://github.com/llvm/llvm-project/issues/55520
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> Actually, I do not have llvm 14 installed so I am not able to test
> (this check was introduced in v14). But as explained in [1], adding
> __packed should fix the warning.

Thanks for the patch! This does resolve the warning (verified with LLVM
15).

> Because this is a false positive, I did not add a Fixes tag, nor a
> Reported-by: kernel test robot.

I think that the Reported-by tag should always be included but I agree
that a Fixes tag is not necessary for this warning, as we currently have
it under W=1, so it should not be visible under normal circumstances.

> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> index 1d43bccc29bf..2b0309fedfac 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> @@ -441,7 +441,7 @@ struct mcp251xfd_hw_tef_obj {
>  /* The tx_obj_raw version is used in spi async, i.e. without
>   * regmap. We have to take care of endianness ourselves.
>   */
> -struct mcp251xfd_hw_tx_obj_raw {
> +struct __packed mcp251xfd_hw_tx_obj_raw {
>  	__le32 id;
>  	__le32 flags;
>  	u8 data[sizeof_field(struct canfd_frame, data)];
> -- 
> 2.35.1
> 
> 

Cheers,
Nathan
