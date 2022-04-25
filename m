Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3589250E04B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbiDYMcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242000AbiDYMao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:30:44 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BC5274868
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:27:38 -0700 (PDT)
Received: from [192.168.0.33] (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net [81.96.50.79])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id E0D111401AA;
        Mon, 25 Apr 2022 12:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1650889656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JvZasaRue4LULzli2YoizhY0uu4LfZQCutAOVvrO+Lk=;
        b=jtcM6Z6fsk02UkmXstWVp6K+wBrCR3oZFZ84/iA/4c93TR3UAfA6CLNvsLjjKbXAt3TWOx
        S7+eqWQ4rnlzNNTejHoH+ld0PmQCJN5TObro8dOtYlnrW2y/ERkmtG6nutBLG5ace+7vjB
        5B93nYc2RPs9GSRhyrwmrfBQHcLej/0=
Message-ID: <bf90c37b-0184-845c-dd6a-c2f4a038b075@postmarketos.org>
Date:   Mon, 25 Apr 2022 13:27:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Caleb Connolly <kc@postmarketos.org>
Subject: Re: linux-next: Fixes tags need some work in the pinctrl tree
To:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220421091055.12d6465c@canb.auug.org.au>
 <CACRpkdaD1G9J+jTJH4oGrcF_dinMjBjHCGMJqRZh8FC0dy+Xfw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACRpkdaD1G9J+jTJH4oGrcF_dinMjBjHCGMJqRZh8FC0dy+Xfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi both,

Apologies, I made a silly mistake when submitting this series.

Patch 2 
(https://lore.kernel.org/linux-rockchip/20220328005005.72492-3-kc@postmarketos.org/), 
contains a fix which should have been squashed into patch one - the first hunk 
of the diff, the bug is a bitwise compare to an enum which isn't bitwise:

if (param == (PIN_CONFIG_OUTPUT | PIN_CONFIG_INPUT_ENABLE))

In hindsight, I think it was a mistake the add a Fixes tag to the first patch, 
it doesn't fix a "bug" it just adds behaviour which arguably should have been 
implemented in the patch it fixes.

The patch shouldn't be backported to stable as it will introduce a bug if ported 
without the second patch (and as above, I don't think this series should be 
backported at all). Could you let me know how to get this dropped from backporting?

Again, sorry for the hassle this has caused.

Kind regards,
Caleb

On 22/04/2022 21:57, Linus Walleij wrote:
> On Thu, Apr 21, 2022 at 1:11 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
>> In commit
>>
>>    6548c9dc711d ("pinctrl/rockchip: support deferring other gpio params")
>>
>> Fixes tags
>>
>>    Fixes: e7165b1d ("pinctrl/rockchip: add a queue for deferred pin output settings on probe")
>>    Fixes: 59dd178e ("gpio/rockchip: fetch deferred output settings on probe")
>>
>> have these problem(s):
>>
>>    - SHA1 should be at least 12 digits long
>>      This can be fixed for the future by setting core.abbrev to 12 (or
>>      more) or (for git v2.11 or later) just making sure it is not set
>>      (or set to "auto").
> 
> Fixed it up by rebasing, thanks!
> 
> Yours,
> Linus Walleij
