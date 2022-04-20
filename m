Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0292D509230
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382574AbiDTVnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbiDTVni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:43:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D042FFEE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:40:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650490848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/zvTG++LzR7bh8q+CqpBor0UdcxP8IFE/v40N0VPnYI=;
        b=28F9lsqEuf0V+96smNSq8Lt+q28wECCLnS7OsbR4Gr+dF7ch2Kx+aP4P2bE157v3baFR7J
        QZDl5gTBADBfei1FGO9LAJMjMpifLOGxg/Ga4paxOS9owUltvmyEzGEQEdz8RZ9lPB6FLB
        6ggJ4KYTlKvo0B959fucCJWG9VK5IlSHK66K7zuyOZsSIi9tJ1A1jLE0ELVFQKPNkykYEe
        XajBw3nz7OPdNw+R6F4xWi2jtthjyJdrl/a+uK/jIK1+s+fvTlvaIt5JYi+168saCX0QMM
        d2aWrF6wMyOHqthGc1lWNl4wt8/gjBcosTD+C80GO9MT9JaOgG3/D4pcn0qe2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650490848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/zvTG++LzR7bh8q+CqpBor0UdcxP8IFE/v40N0VPnYI=;
        b=PdFFPRljFHJAOxdsB1/Bi6Q9goCyjvP4CCzZSq/UpbecdVCQnePzqMrsete9AncXowBs2P
        gLk8nsNGxEFBC0Cg==
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>,
        catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     tarumizu.kohei@fujitsu.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/9] drivers: base: Add hardware prefetch control
 core driver
In-Reply-To: <20220420030223.689259-2-tarumizu.kohei@fujitsu.com>
References: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
 <20220420030223.689259-2-tarumizu.kohei@fujitsu.com>
Date:   Wed, 20 Apr 2022 23:40:48 +0200
Message-ID: <87mtgftov3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kohei,

Cc+: driver core maintainers

On Wed, Apr 20 2022 at 12:02, Kohei Tarumizu wrote:
> +static const char dist_auto_string[] = "auto";
> +static const char strength_strong_string[] = "strong";
> +static const char strength_weak_string[] = "weak";

This is A64FX specific.

> +pfctl_enable_show(hardware_prefetcher, HWPF_ENABLE);
> +pfctl_enable_show(ip_prefetcher, IPPF_ENABLE);
> +pfctl_enable_show(adjacent_cache_line_prefetcher, ACLPF_ENABLE);

This is x86 specific.

> +pfctl_enable_show(stream_detect_prefetcher, SDPF_ENABLE);

This is A64FX specific.

So why is this in generic code and why needs x86 to populate the A64FX
bits and make them invisible? Same the other way round.

Now imagine a few other [sub]architectures come around and add their
specific prefetcher control knobs, strings and whatever. That's going to
be unmaintainable in no time.

This is not comparable to the cache attributes where the architectures
share a significant amount of subsets. You just demonstrated that X86
and A64FX share not even a single entry.

The core code should provide infrastructure to manage the
[sub]architecture specific control files at different cache levels.

Not more not less.

Thanks,

        tglx
