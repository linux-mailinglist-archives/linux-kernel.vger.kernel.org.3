Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6014453D712
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 15:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbiFDNvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 09:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbiFDNu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 09:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285DE30F7E;
        Sat,  4 Jun 2022 06:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3F0160BC1;
        Sat,  4 Jun 2022 13:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1901EC385B8;
        Sat,  4 Jun 2022 13:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654350654;
        bh=d6+D9ng5G1Kvhv1UO7/YcgjRZpugrzbBdMNBiqJuB18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rRJQ3cX19WpPecZLsN4cJv41ZObrO0bpm26XzveAU8NalBZgJySQakI1qVP2G2tg0
         ZAPFPZ3+QpnJeGm96OoNAdJrzi3K/wwu/gxo/I4HSODUaTg0KiIKxE7RRDc1H6TWAy
         0Vd1cTikIpfUdA9QLZl6rq0N1N0gNjz9DkHQZ289M4m4+LNaRqaxDwVgJu71azxya6
         /XRgh7DD1AOV701YIeUCxFrTR1ni71d+PVGfJTuZD56UFDG7p1C9KBo51G6Y/sQLUw
         4lfoXiXhg1Ba3Rui3USeKL77quzEonZ9N3jQqUU6V0RjrKe3fYYPebestq/XYNeQRq
         ZO/aohFuBpnMA==
Date:   Sat, 4 Jun 2022 14:59:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "noname.nuno@gmail.com" <noname.nuno@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1] iio: trigger: move trig->owner init to trigger
 allocate() stage
Message-ID: <20220604145955.2a1108ca@jic23-huawei>
In-Reply-To: <20220601174837.20292-1-ddrokosov@sberdevices.ru>
References: <20220601174837.20292-1-ddrokosov@sberdevices.ru>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2022 17:48:32 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> To provide a new IIO trigger to the IIO core, usually driver executes the
> following pipeline: allocate()/register()/get(). Before, IIO core assigned
> trig->owner as a pointer to the module which registered this trigger at
> the register() stage. But actually the trigger object is owned by the
> module earlier, on the allocate() stage, when trigger object is
> successfully allocated for the driver.
> 
> This patch moves trig->owner initialization from register()
> stage of trigger initialization pipeline to allocate() stage to
> eliminate all misunderstandings and time gaps between trigger object
> creation and owner acquiring.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

Hi Dmitry,

I 'think' this is fine, but its in the high risk category that I'd like
to keep it on list for a few weeks before applying.

Note I'm still keen that in general we keep the flow such that
we do allocate()/register()/get() as there is no guarantee that the get()
will never do anything that requires the trigger to be registered, even
though that is true today.  Which is another way of saying I'm still
keen we fix up any cases that sneak in after your fix up set dealt with
the current ones.

Thanks for following up on this!

Jonathan

