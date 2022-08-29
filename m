Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210F85A568F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiH2Vyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiH2Vyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:54:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5CCF61;
        Mon, 29 Aug 2022 14:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 85D63CE12AD;
        Mon, 29 Aug 2022 21:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287FAC433D6;
        Mon, 29 Aug 2022 21:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661810085;
        bh=OeSLXvCWQ7C65bUk1sYHK/hHg1itGBL4NFVbuoULT8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ieQg9ieUPWQlhZDjI3MjCCYc2bqIht15x/+OtR6/G8rnLEdkzpdHkCTXinGhHsokL
         URkGLPeZD1daNiiTdjTARphNIIOYZeFFBvtAj1Qf4MhEn5EnKJYIIREiksGUNwjKdr
         XU+PQOBH35uXCUNngPfCy5dS+M1wBs50yPcJlu2GCM6WGVzs/9vbvEObiENZuyKEHL
         aB62I/h+wlqH0EbXszszVsq0ZeX/5D75rP3tkdCIn2VBbmlQQawkGc//Wbb0gfZr04
         oMr6AplJFaJNFy5PHSz00OGPCpFTv9XcmFMQeHOcJrdRn4uP4EIikktd5Jb3G+Hau6
         gZEQm2hNlfkwA==
Date:   Mon, 29 Aug 2022 16:54:43 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rudraksha Gupta <guptarud@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, agross@kernel.org,
        david@ixit.cz, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 1/2] ARM: msm8960: Rename cxo_board to cxo-board and
 add alias
Message-ID: <20220829215443.dvc5xnmeqnhmxb2d@builder.lan>
References: <20220808234723.5184-2-guptarud@gmail.com>
 <20220809000300.6384-1-guptarud@gmail.com>
 <YvQMyQLohqcc8Fug@ripper>
 <499c8b49-a09e-e775-3242-13d37a13877e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <499c8b49-a09e-e775-3242-13d37a13877e@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 10:51:51PM -0400, Rudraksha Gupta wrote:
> > Clock and dts patches goes through two different paths towards mainline,
> 
> > so they should be separated.
> 
> Gotcha, thanks. I will do that.
> 
> 
> > This breaks compatibility with existing DTB files.
> 
> > What you probably want is to make sure that any clocks with parent name
> 
> > of "cxo", should have a .fw_name = "cxo", then you can make a
> 
> > phandle-based reference in DT and these global names doesn't matter (and
> 
> > in the end we can remove this board_clk from the driver).
> 
> Ah, I see. If I understand correctly, it should be something like this,
> right?
> https://github.com/torvalds/linux/blob/master/drivers/clk/qcom/gcc-msm8996.c#L169-L172

Correct, this will try to find the clock by clock-names of "cxo" and if
not found fall back to do a lookup globally just on the name "xo_board".

So it seems making .name "cxo_board" should handle both cases nicely.

Regards,
Bjorn
