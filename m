Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8465159CB81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbiHVWcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiHVWcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:32:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8905073A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F19C7B818BB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E36C433C1;
        Mon, 22 Aug 2022 22:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661207569;
        bh=ItAyCqwjSMtDVmqItbQkcW3XDj9c3QE0aoJtZWZrWKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgNmjn2fTZj2GpfPbIlnH9NpAgH8hUV9G+2T2J31aSOHTqxLCYnebkdL2lA2a9FWD
         iUT9y4IYV0yCXCY2FK6gonZyoVEUDcXAYRx+UlWQgjoeGp0FAZ4c9UXoSqfp8yY5V5
         dkI45jD6ThRoq0eBYGxwgpBOMX05jI0r/hCkMrkO0KA/VJt/oZsYF/fOlMLsPZ0/dI
         nsOz+GqX4xWAlAPYuYyhaHBhkP3BHPni5gmZ3Dc/kGeepmj+TocZgAXZzMJ/ayMIOR
         PHRuBS2TbHC+Zd9ze1C5buUyCZd49xTzft5G9BBWQgNmnj/txhcIEQQNbCwwIi+XQV
         qsdSMOQlvFGcQ==
Date:   Mon, 22 Aug 2022 15:32:47 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Matt Flax <flatmax@flatmax.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] ASoC: codes: src4xxx: Avoid clang
 -Wsometimes-uninitialized in src4xxx_hw_params()
Message-ID: <YwQEDyk17Q06mIVR@dev-arch.thelio-3990X>
References: <20220822183101.1115095-1-nathan@kernel.org>
 <72de09df-5dee-8bd0-5c91-359e4bc36ca8@flatmax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72de09df-5dee-8bd0-5c91-359e4bc36ca8@flatmax.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On Tue, Aug 23, 2022 at 08:00:07AM +1000, Matt Flax wrote:
> Hi Nathan,
> 
> On 23/8/22 04:31, Nathan Chancellor wrote:
> > Clang warns:
> > 
> >    sound/soc/codecs/src4xxx.c:280:3: error: variable 'd' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
> >                    default:
> >                    ^~~~~~~
> >    sound/soc/codecs/src4xxx.c:298:59: note: uninitialized use occurs here
> >                    ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_11, d);
> >                                                                            ^
> >    sound/soc/codecs/src4xxx.c:223:20: note: initialize the variable 'd' to silence this warning
> >            int val, pj, jd, d;
> >                              ^
> >                              = 0
> 
> 
> If you really want to get rid of these warnings, you can use this default
> for the variables :
> 
> pj = 0x0;
> jd=0xff;
> 
> d = 0xff;
> 
> It doesn't really make sense why we would choose to initialise these
> variables, but if you want to silence the preprocessor, then perhaps those
> values. Put a message that defaults are not known nor specified in the data
> sheet and these values are chosen to be unlikely matches of real world
> values - which ensures regmap updates later from an initial unknown chip
> state after refresh.

Okay, I could do something like this?

diff --git a/sound/soc/codecs/src4xxx.c b/sound/soc/codecs/src4xxx.c
index a8f143057b41..db4e280dd055 100644
--- a/sound/soc/codecs/src4xxx.c
+++ b/sound/soc/codecs/src4xxx.c
@@ -280,9 +280,14 @@ static int src4xxx_hw_params(struct snd_pcm_substream *substream,
 		default:
 			/* don't error out here,
 			 * other parts of the chip are still functional
+			 * Dummy initialize variables to avoid
+			 * -Wsometimes-uninitialized from clang.
 			 */
 			dev_info(component->dev,
-				"Couldn't set the RCV PLL as this master clock rate is unknown\n");
+				"Couldn't set the RCV PLL as this master clock rate is unknown. Chosen regmap values may not match real world values.\n");
+			pj = 0x0;
+			jd = 0xff;
+			d = 0xff;
 			break;
 		}
 		ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_0F, pj);

These warnings need to be eliminated because Linus requires a clean
build as much as possible [1] [2], which has been codified by
CONFIG_WERROR, which is enabled by default with allmodconfig. As a
result, clang allmodconfig builds are broken [3], which you might have
already seen. If there is another way this could be written without
potentially uninitialized variables, I am open to it.

[1]: https://lore.kernel.org/CAHk-=wg-mH-_GYpkhz_psjBWG6ZcjKnPo83fg7YMj_by+-LRTQ@mail.gmail.com/
[2]: https://lore.kernel.org/CAHk-=wi4wyvuXs0SUq-2x=XHxWmJ6jVKRD-WpE0kWgWiqVJNbg@mail.gmail.com/
[3]: https://lore.kernel.org/YwNMUlAmu%2FqCjuva@debian/

> All a bit messy really.

Indeed :/

> > According to the comment in the default case, other parts of the chip
> > are still functional without these values so just return 0 in the
> > default case to avoid using these variables uninitialized.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1691
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >   sound/soc/codecs/src4xxx.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/sound/soc/codecs/src4xxx.c b/sound/soc/codecs/src4xxx.c
> > index a8f143057b41..cf45caa4bf7f 100644
> > --- a/sound/soc/codecs/src4xxx.c
> > +++ b/sound/soc/codecs/src4xxx.c
> > @@ -283,7 +283,7 @@ static int src4xxx_hw_params(struct snd_pcm_substream *substream,
> >   			 */
> >   			dev_info(component->dev,
> >   				"Couldn't set the RCV PLL as this master clock rate is unknown\n");
> > -			break;
> > +			return 0;
> 
> 
> Don't return here, the rest of the chip is still functional and probably in
> use. Print the dev_info and continue.

I'll send a v2 tomorrow morning (for me at least) if there are no other
comments.

Cheers,
Nathan
