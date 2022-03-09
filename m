Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4624D2D32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiCIKhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiCIKhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:37:19 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAF612B747
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:36:20 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso4899677pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 02:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=nBz9I0mFgs5u062cU8PWaEUMW26wc4vG19g0SAhyIOU=;
        b=mY94NA13vTUMuBG5Bb4LFlSz3w6FHEwXWhxPlmNJ1x2gXIe5ylLYwvvWbO0dw3ggad
         /QpIpgbMmdTxCBLWoGyUf5iZXBialoj2hYz/bmjw/3Ge8rDQFXQQ0XT6h4ViJNJbLYmw
         p0QVP1VWTx9++z0xizrfuicuu9RkgpQdMlHZ83iNHBugqVLkSMRmfPMBtc2CYlTIS9jR
         VdnbPO+gOd75CscjnUmSZt5mVBZacYseAi4x2Rn4Y0UCD3t3WMiZwtB9+0vWDEB3K5gt
         W7T17l0rNFhIHyQtW69eTy1xdaHsHxblS/w3IL/XuUKR8iPdpBevan4/w24/RCTtRvkO
         dZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nBz9I0mFgs5u062cU8PWaEUMW26wc4vG19g0SAhyIOU=;
        b=i85JXEZWg2MHDWxj3B+nUM63c+ZQ/iwBlK+F9X/UCz62PXauf+mdDnZ7YvGWvFbWpx
         QLE6+SdeS3XBLXKeEsrMqI9SMRuWe+s3sS4OTvj19EYHIncw8hZ6GWZqILJy5SeAsfWM
         Fkh/dYF6bSVe3PhXAMgBKQ/1e6upvBRQRNFvxDDMiUp+Infoxsa/zgb+HoxstCiZkN7Q
         V0ECYXiQO6O6PnpY0mKr3LozzpdbYbmBNgMsV2G9f6W5HXEaQ9uGbR6VOWcMHi2MLZCX
         Txa7Xuln3PrD2Jv3r/FsaHMQPsd6mU10STxfdMY6M4mCHHZ1om8rFeMkkM+qX65AGcWu
         /Tvg==
X-Gm-Message-State: AOAM530CLs54LCbSpbUSaMCAoNN5HXJINZMYAy+9IJuHREETqw4DzN3d
        hOO1BcCfzkTSyN3Bzyd9cgjNYg==
X-Google-Smtp-Source: ABdhPJzLigLjr3+0rRbWvgtefYE80In5/d68K54nYw/h39qRlT1InJt38j1/Rnfp072s73i8QfoDaA==
X-Received: by 2002:a17:903:24e:b0:151:9fa5:ebdd with SMTP id j14-20020a170903024e00b001519fa5ebddmr22258261plh.84.1646822179631;
        Wed, 09 Mar 2022 02:36:19 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm5915575pjc.56.2022.03.09.02.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 02:36:19 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] bus: ti-sysc: Fix gpt12 system timer issue with
 reserved status
In-Reply-To: <YiX/0c44p8AL1YIG@atomide.com>
References: <20210611060224.36769-1-tony@atomide.com>
 <7h7d99ehu4.fsf@baylibre.com> <YiX/0c44p8AL1YIG@atomide.com>
Date:   Wed, 09 Mar 2022 02:36:18 -0800
Message-ID: <7h8rtj9zvh.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> Hi,
>
> * Kevin Hilman <khilman@baylibre.com> [220304 17:39]:
>> Hi Tony,
>> 
>> Tony Lindgren <tony@atomide.com> writes:
>> 
>> > Jarkko Nikula <jarkko.nikula@bitmer.com> reported that Beagleboard
>> > revision c2 stopped booting. Jarkko bisected the issue down to
>> > commit 6cfcd5563b4f ("clocksource/drivers/timer-ti-dm: Fix suspend
>> > and resume for am3 and am4").
>> >
>> > Let's fix the issue by tagging system timers as reserved rather than
>> > ignoring them. And let's not probe any interconnect target module child
>> > devices for reserved modules.
>> >
>> > This allows PM runtime to keep track of clocks and clockdomains for
>> > the interconnect target module, and prevent the system timer from idling
>> > as we already have SYSC_QUIRK_NO_IDLE and SYSC_QUIRK_NO_IDLE_ON_INIT
>> > flags set for system timers.
>> >
>> > Fixes: 6cfcd5563b4f ("clocksource/drivers/timer-ti-dm: Fix suspend and resume for am3 and am4")
>> > Reported-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
>> > Signed-off-by: Tony Lindgren <tony@atomide.com>
>> 
>> I'm debugging why suspend/resume on AM3x and AM4x are mostly working,
>> but getting the warning that not all powerdomains are transitioning:
>> 
>>    pm33xx pm33xx: PM: Could not transition all powerdomains to target state
>> 
>> I bisected it down to $SUBJECT patch, and verified that reverting it
>> makes both on am335x-boneblack and am437x-gp-evm fully suspend, and I'm
>> now seeing:
>> 
>>    pm33xx pm33xx: PM: Successfully put all powerdomains to target state
>> 
>> Note that it doesn't revert cleanly due to some other changes, but this
>> one-liner[1] effectively reverts the behavior of $SUBJECT patch, and
>> also makes things work again.
>> 
>> I verified the revert (and hack[1]) on both v5.10 stable and mainline
>> v5.16 but TBH, I'm still not 100% sure what's going on so looking for
>> some guidance from you Tony on what the "real" fix should be.
>
> Thanks for debugging the issue Kevin. It seems the issue is caused by the
> extra runtime PM usage count done for modules tagged no-idle. However,
> this causes issues for am335x timers as the PM coprocessor needs all
> the domains idled for system suspend despite the system timers tagged
> with no-idle.
>
> We could patch ti-sysc.c for more timer workarounds, but I don't know if
> that really makes sense. It would add further dependencies between the
> system timer code and the interconnect code, and I'd rather go back to
> no dependencies between the system timers and the interconnect code :)
>
> So I suggest we make the omap3 gpt12 quirk checks SoC specific as below
> for now, they are not needed for the other SoCs.
>
> Then at some point we can plan on dropping support for the old beagleboard
> revisions A to B4, and then reverting commit 3ff340e24c9d ("bus: ti-sysc:
> Fix gpt12 system timer issue with reserved status").
>
> Note that we now have commit 23885389dbbb ("ARM: dts: Fix timer regression
> for beagleboard revision c"), so there no need to (wrongly) enable the
> old timer quirks for working omap3 revision C and later boards.

Thanks for the explanation.

> 8< ----------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 7 Mar 2022 14:28:44 +0200
> Subject: [PATCH] bus: ti-sysc: Make omap3 gpt12 quirk handling SoC
>  specific
>
> On beagleboard revisions A to B4 we need to use gpt12 as the system timer.
> However, the quirk handling added for gpt12 caused a regression for system
> suspend for am335x as the PM coprocessor needs the timers idled for
> suspend.
>
> Let's make the gpt12 quirk specific to omap34xx, other SoCs don't need
> it. Beagleboard revisions C and later no longer need to use the gpt12
> related quirk. Then at some point, if we decide to drop support for the old
> beagleboard revisions A to B4, we can also drop the gpt12 related quirks
> completely.
>
> Fixes: 3ff340e24c9d ("bus: ti-sysc: Fix gpt12 system timer issue with reserved status")
> Reported-by: Kevin Hilman <khilman@baylibre.com>
> Suggested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Teested on am335x-boneblack and am437x-gp-evm and am seeing 

    pm33xx pm33xx: PM: Successfully put all powerdomains to target state

on both boards.

Kevin
