Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7AD4D2F20
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiCIMfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiCIMfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:35:39 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218A31693B4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=nK67APL81JLn2DAt7Qt6f0T7aBnoQTZj/X9iXtjWIUU=; b=4Lgu9
        ZCh0u+tEJoTz3z1+uiapYfpGVVFlP889AEj4Gw/mohxZYScIwXtpbNsm/RDmGKbNcHdLm4zji/hCg
        AcoQEiBgCO5VS9MCJr/LZVGckz3kW2ULRx1ca5IqeZ9uPX1hu4GVDJxHnhKfljGQ/FjSHxRmUWNvX
        OCdSZQ35hijioNZw8WnC2ysUCOmjswbqYOcytezvHvzEF4c4xELaP0iqPQjovaEi5ZnRm8Wsdh3To
        Jjou/gtLs13rLb2HQhGwyypw3gBgFP/2buK0gHqwGrasfYZ0MiLXu1imfn6pNBYSqX4jPxmBBmMPk
        A/3XWaecoMvN1WBU3gkNHZebf4eIQ==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nRvWP-0001JT-Q7; Wed, 09 Mar 2022 12:34:29 +0000
Date:   Wed, 9 Mar 2022 12:34:28 +0000
From:   John Keeping <john@metanate.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tas5805m: fix pdn polarity
Message-ID: <Yiie1OUCvi49f1Q7@donbot>
References: <20220309104104.3605112-1-john@metanate.com>
 <YiiZv7Fc8a4O1nYR@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiiZv7Fc8a4O1nYR@sirena.org.uk>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 12:12:47PM +0000, Mark Brown wrote:
> On Wed, Mar 09, 2022 at 10:41:04AM +0000, John Keeping wrote:
> 
> > Fixes: ec45268467f4 ("ASoC: add support for TAS5805M digital amplifier")
> 
> Please don't insert fixes tags unless you're actually fixing a bug,
> stylistic improvements like this - people try to use the tag for
> backporting bug fixes and so on so extra tags create noise for them.

This isn't purely stylistic - it affects the interpretation of pdn-gpios
in the device tree so that it matches all of the other bindings that use
this property: active means PDN asserted.

There are currently no in-tree users of the binding and the patch adding
it is queued for the next merge window.
