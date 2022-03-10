Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2242D4D3E95
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbiCJBLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiCJBLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:11:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B6211B5EF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:10:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D02B61345
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18C8C340E8;
        Thu, 10 Mar 2022 01:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646874644;
        bh=7UE/AN7koc5W2DTwiCBq0htzqBHnnGLtGO4KphiksVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y4MtSYETuuIRHISJ6XVh0trr3P2h0vdi2iXe3L5P2ab7BJEHJfMJFXpBOaj8tm3X0
         9vhZg/pLgOPqNsEqVaTgcCeOGc8QiSUdSTZzj0ymYBd2mCYnq6XQCnnOpLkab0ac2N
         SYCwIPyovs67dG80Jf/m+dstccFkHu+hod8vk1+w=
Date:   Wed, 9 Mar 2022 17:10:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] configs/debug: Restore DEBUG_INFO=y for overriding
Message-Id: <20220309171043.33e048bb8bc43e5f483fa102@linux-foundation.org>
In-Reply-To: <20220308153524.8618-1-quic_qiancai@quicinc.com>
References: <20220308153524.8618-1-quic_qiancai@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022 10:35:24 -0500 Qian Cai <quic_qiancai@quicinc.com> wrote:

> Previously, I failed to realize that Kees' patch [1] has not been merged
> into the mainline yet, and dropped DEBUG_INFO=y too eagerly from the
> mainline. As the results, "make debug.config" won't be able to flip
> DEBUG_INFO=n from the existing .config. This should close the gaps of a
> few weeks before Kees' patch is there, and work regardless of their
> merging status anyway.
> 
> [1] https://lore.kernel.org/all/20220125075126.891825-1-keescook@chromium.org/
> 
> ...
>
> --- a/kernel/configs/debug.config
> +++ b/kernel/configs/debug.config
> @@ -16,6 +16,7 @@ CONFIG_SYMBOLIC_ERRNAME=y
>  #
>  # Compile-time checks and compiler options
>  #
> +CONFIG_DEBUG_INFO=y
>  CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
>  CONFIG_DEBUG_SECTION_MISMATCH=y
>  CONFIG_FRAME_WARN=2048

Thanks, I queued this for 5.17,
