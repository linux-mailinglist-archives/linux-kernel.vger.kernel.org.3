Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FCF57A135
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbiGSOPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbiGSON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:13:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F4E8599E1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:39:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE352153B;
        Tue, 19 Jul 2022 06:39:35 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F01D3F766;
        Tue, 19 Jul 2022 06:39:33 -0700 (PDT)
Date:   Tue, 19 Jul 2022 14:39:31 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] amba: Remove deferred device addition
Message-ID: <20220719133931.7dkcejvc6s4a7y4z@bogus>
References: <CGME20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5@eucas1p2.samsung.com>
 <20220705083934.3974140-1-saravanak@google.com>
 <7482d3af-4b02-4c1d-0386-b0a4ddf529da@samsung.com>
 <8a04332e-e7b1-8bc3-d569-5052427bcb13@samsung.com>
 <CAGETcx93rWqt-Cyz_8JZ4mxcLpJruzSM1QOAgpkPSM-G1sBXWg@mail.gmail.com>
 <20220713145827.yxeoqj6vmkzhrrpv@bogus>
 <CAGETcx_V9qxeO+vks8kwpwWZth+fys_TTt=JwV2JkvUNHvTtvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_V9qxeO+vks8kwpwWZth+fys_TTt=JwV2JkvUNHvTtvA@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 06:55:23PM -0700, Saravana Kannan wrote:
> On Wed, Jul 13, 2022 at 7:58 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Tue, Jul 12, 2022 at 12:38:33PM -0700, Saravana Kannan wrote:
> > > Sudeep,
> > >
> > > This makes me think the issue you are seeing is related to your
> > > hardware drivers. Can you look into those please? I'm leaning towards
> > > merging this amba clean up and adding delays (say 1ms) to your
> > > clock/power domain drivers to avoid the crash you are seeing. And then
> > > you can figure out the actual delays needed and update it.
> >
> > I haven't got a chance to debug the issue on Juno much further. One thing
> > about the platform is that we can't turn off the debug power domain that
> > most of the coresight devices share.
> >
> > One thing I also observed with -next+this patch is that with a little log
> > it can access the registers while adding first few devices and then crash
> > which doesn't align with platform behaviour as we can't turn off the domain
> > though we attached and turn on in amba_read_periphid and then turn off and
> > detach the power domain. Ideally if first device amba_read_periphid was
> > successful, it must be the case for all, but I see different behaviour.
> >
> > I need to check again to confirm if it is issue with platform power domain
> > driver. It is based on SCMI so there is some role played by the f/w as well.
> 
> Yeah, this log timing based behavior is what makes me suspect it's not
> a problem with this patch itself.
> 
> However, just to rule it out, can you try making this change on top of
> v4 and give it a shot? This is related to the issue Marek reported,
> but those are more about permanent probe failures. Not a crash.
>

This patch(version v4, fails to apply on -next but the conflict is trivial
and in the deleted code so I just retained your copy of all the functions)
plus the below change fixes the issue I reported on Juno.

I won't give you tested-by yet as you have plans to revert some things
and I resolved the conflict here though trivial, I prefer to apply the
patch as is with all associated changes and test once more.

Thanks for digging this and fixing it.

-- 
Regards,
Sudeep
