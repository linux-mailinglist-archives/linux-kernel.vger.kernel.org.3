Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1829C4DC10A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiCQIZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiCQIZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:25:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BED16A6BC;
        Thu, 17 Mar 2022 01:24:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D64CCB81C54;
        Thu, 17 Mar 2022 08:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F12EC340E9;
        Thu, 17 Mar 2022 08:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647505477;
        bh=g9I/jXLKEOIhoMMZHTxu8j3Nvvx6SE0sTX1XUewT5vk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ah63fmT6gXUhBv8QAmpMn6N0b7E8uPIJlaUu+9v1KLYL3n6YCwUTtZqffokOmduoS
         3wIbXAQNl9DPEq8tWZQ93qQKYJ5TjEix6VMDq/8nPyY1OFh9OWL80WwbyrENjaWwMs
         g2P/PtHk8B3mR1w74xMsgsPwE8+17SardoygraHiYp9ja/5LnkviNeLxfrr9/ZY60I
         u3FwtIKPGQBuDmdNEeXMPGMav2FL/1x4WHo8b+mshzmNPCyaK6kTGxisf8zxnoRY7w
         bwsypJnTRKaU5qI6r7bknGk5B1s2f9DUhFdq6dy7An68PgtZXtU5wAmABiLqlAEp1V
         +raCTpolW4S0w==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nUlQx-00F7JV-0A; Thu, 17 Mar 2022 08:24:35 +0000
MIME-Version: 1.0
Date:   Thu, 17 Mar 2022 08:24:34 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
In-Reply-To: <CACRpkdbvm4nnoTWORJV1h0qKFyaCE0q6JXLpXmi3f0nvx5wZ7g@mail.gmail.com>
References: <20220316183227.725bfd37@canb.auug.org.au>
 <CACRpkdbvm4nnoTWORJV1h0qKFyaCE0q6JXLpXmi3f0nvx5wZ7g@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <6ea692dcc15e032236449b22855f9028@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linus.walleij@linaro.org, sfr@canb.auug.org.au, bgolaszewski@baylibre.com, keescook@chromium.org, j.neuschaefer@gmx.net, tmaimon77@gmail.com, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-17 01:01, Linus Walleij wrote:
> On Wed, Mar 16, 2022 at 8:32 AM Stephen Rothwell <sfr@canb.auug.org.au> 
> wrote:
> 
>> After merging the kspp tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
> (...)
>> I have applied the following hack patch for today.
>> 
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date: Wed, 16 Mar 2022 18:12:14 +1100
>> Subject: [PATCH] fixup for "pinctrl: nuvoton: add NPCM7xx pinctrl and 
>> GPIO driver"
> 
> Patch looks good but didn't apply to he pinctrl tree when I
> tried to simply apply it there.
> 
> Since it is touching IRQ handlers, I suspect this could maybe
> apply to Marc Z:s or Bartosz trees? Or can you see which one
> needs this?

Yes, I've now picked this up.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
