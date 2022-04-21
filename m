Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D707509C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387750AbiDUJmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387734AbiDUJmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:42:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507A21AF37;
        Thu, 21 Apr 2022 02:39:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDEAD6173A;
        Thu, 21 Apr 2022 09:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6CDC385A5;
        Thu, 21 Apr 2022 09:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650533969;
        bh=FM4K4GimvOUO9EAO3cOMcgI/tP4keYbR1YmyZ2NCvaw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=BTr9737XNaLMhuCmDu/TG/xln2Mx3w8DVBB/78kAh9dt6u0K9rzjaU6ArElKCfXk4
         cY1kDWH0a1oTQIiYu+D35SLic0w5tUYlV9FTePwg8lw/cmqyMr/271Qa7jhmEYJ5oy
         I0EsU5tROcj4F3tCJx6ip3pb7glxmBVt9v1Eqx8XPWI3LSZIjRTQDx3L0CFQWaa/AO
         6Uc0AEZQfnORo1TD4FBup7dH1DnjKdWo/mAWdE2kb0pGdXmcPu0VVuHghhBuvzQmUy
         Z4aJ65D+qpFsnGHqTkib56hSb/f9IXh/q43YyZWHyjZlLWiKNcIYaU52dNqn2ofXi6
         gFCnZN/zbMvUA==
Date:   Thu, 21 Apr 2022 11:39:25 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Miaoqian Lin <linmq006@gmail.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Alexandrov Stansilav <neko@nya.ai>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: elan: Fix potential double free in
 elan_input_configured
In-Reply-To: <CAO-hwJJyrPUdOm6JuzbE4Hi4pYi6hZDhf8zkJoczeOwj5jeaaA@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2204211138450.30217@cbobk.fhfr.pm>
References: <20220416073721.3954-1-linmq006@gmail.com> <CAO-hwJJyrPUdOm6JuzbE4Hi4pYi6hZDhf8zkJoczeOwj5jeaaA@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022, Benjamin Tissoires wrote:

> On Sat, Apr 16, 2022 at 9:37 AM Miaoqian Lin <linmq006@gmail.com> wrote:
> >
> > 'input' is a managed resource allocated with devm_input_allocate_device(),
> > so there is no need to call input_free_device() explicitly or
> > there will be a double free.
> >
> > According to the doc of devm_input_allocate_device():
> >  * Managed input devices do not need to be explicitly unregistered or
> >  * freed as it will be done automatically when owner device unbinds from
> >  * its driver (or binding fails).
> >
> > Fixes: b7429ea53d6c ("HID: elan: Fix memleak in elan_input_configured")
> > Fixes: 9a6a4193d65b ("HID: Add driver for USB ELAN Touchpad")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> 
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Thanks for the patch!

Hmm, this patch never seems to have reached my inbox, but we've had some 
trouble with our mailserver over the Easter weekend, so that could be it.

Thanks for the fix indeed, applied now to hid.git#for-5.18/upstream-fixes

-- 
Jiri Kosina
SUSE Labs

