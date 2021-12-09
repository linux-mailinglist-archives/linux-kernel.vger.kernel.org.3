Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AEA46ED50
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbhLIQrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:47:41 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:36120 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhLIQrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:47:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 88AE8CE2688
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 16:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78191C004DD;
        Thu,  9 Dec 2021 16:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639068240;
        bh=jzrOQ074e6pO+62fuwp9i9WowIk/tBJipTmWGXoOAM8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TffshsNjVu/YXuKKxVUfwVvCtQFaNNIfAoLRzvCMZ9vA7bWObKRU45qzEJo+CF/jK
         tggMDq20+DX+rkY9jOEVCb+rT2m1Zc7dwxRyMi5h5HyR/UxvhAEW9ExJVlsLOVfrbz
         gDRKZD7pgyW9/dy1PqW+c2YsjzzeSgy9XEhlLaQ/lK6oFKV0M0dQOkdH/QfXJykkXA
         Ecszs54jPJvmpHkdp0f5w4F4Yv/u4EuqAuoEQ+FW0nZtV21CTJ7XBTCq8eaI8jLwzZ
         3gGw/seew+Qh0CmHlTriVuneZZH86FMhy13jayPDB3LkpqgxUPVriYcxztmt0HhMoM
         uGH3n5RanGk0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2D7105C414D; Thu,  9 Dec 2021 08:44:00 -0800 (PST)
Date:   Thu, 9 Dec 2021 08:44:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, tglx@linutronix.de, yanghui.def@bytedance.com,
        brookxu.cn@gmail.com, luming.yu@gmail.com,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com
Subject: Re: [PATCH] Clocksource: Avoid misjudgment of clocksource
Message-ID: <20211209164400.GC641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
 <b32b91a9-7cd8-e24b-b608-8bf55a8abe16@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b32b91a9-7cd8-e24b-b608-8bf55a8abe16@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 09:14:05PM +0800, Gang Li wrote:
> Hi all,
> 
> How about changing clocksource_watchdog from classical timer to hrtimer?
> hrtimer is more accurate and stable, and makes it much easier for us to deal
> with misjudgments.

To make hrtimer more accurate in the busy-system scenarios that are
under test, we would need to specify HRTIMER_MODE_HARD.  Otherwise,
hrtimer handlers execute in softirq, just like timers do.  So without
the HRTIMER_MODE_HARD, the hrtimers would be delayed just as badly as
we are seeing for the normal timers.

Unfortunately, use of HRTIMER_MODE_HARD has response-time consequences,
especially when the timer reads need to be retried.  So my guess is
that hrtimers are not a helpful path forward here.

							Thanx, Paul
