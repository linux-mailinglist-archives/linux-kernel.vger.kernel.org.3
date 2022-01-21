Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BED495D06
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379414AbiAUJpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiAUJpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:45:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43364C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 01:45:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49E9DB81F6D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 09:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767EFC340E1;
        Fri, 21 Jan 2022 09:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642758307;
        bh=WOxxIEMr0IemOGKCxROsr6vfRb6mIvl09qPmB9GOwUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=QQA367PY5kPvcrES3b+7taLp/U58QFaHw8UnojLCo/PQSF4v9jqFgwk2e1lZteJh+
         3H1GiQKVjpekJIVZB39++S+ZHkztxWZ29JyTYP4ZpvX3eW1GWVN9z2LWddLRemK9zM
         6xwSnFRxeUjMsHUb0xzzyRkqwyNRRFGTyt5ya0MH8+028WiFbqLETIh53D/iA5U32w
         lK9fu826M+jtj9Yqtm8+/4xGyVZO7WJa0Wprn2d1t2y0kxPdiXr9NvsxXkqLDe7emQ
         a/b9OkApf73C2T3IrxEIfyuQf3ycFz0lvUAZZ3Ybmj+efjcbNgirh3dKUvpUzZr4QZ
         A7WZwasWucM7Q==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 2/2] mm/damon/dbgfs: Modify Damon dbfs interface dependency in Kconfig
Date:   Fri, 21 Jan 2022 09:45:04 +0000
Message-Id: <20220121094504.27309-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <3bc92242-63b0-283e-6dbf-412459d4a242@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

On Fri, 21 Jan 2022 10:14:36 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> 
> On 1/21/22 1:46 AM, SeongJae Park wrote:
> > Hi Xin,
> >
> >
> > I guess this should be at least v3, as you posted v1[1] and v2[2] before.
> > Could you please also summarize what changes are made from v2?
> >
> > On Fri, 21 Jan 2022 00:04:28 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> >
> >> If you want to support "DAMON_DBGFS" in config file, it only depends on
> >> any one of "DAMON_VADDR" and "DAMON_PADDR", and sometimes we just want to
> >> use damon virtual address function, but it is unreasonable to include
> >> "DAMON_PADDR" in config file which cause the damon/paddr.c be compiled.
> > My comment[3] to the v2 was,
> >
> >      So, unless you make me believe the benefit is big enough and all possible
> >      corner cases are well handled and sufficiently tested, I'm sorry but I would
> >      not be convinced with this change.
> 
> This has really bothered me for a long time. I don't send patches just 
> for the sake of sending patches. I integrate DAMON patches into my 
> kernel, and one obvious problem is that I don't use paddr at all. But my 
> config had to select DAMON_PADDR so that my DAMON codes would compile 
> and work. I wanted DAMON code to be as simple and clean as possible, 
> which is why I sent the patch for three times.

Thank you for the clarification.  I know you really want to improve DAMON and
made great progress already.  I really appreciate that.  I can also understand
your frustration.  Of course, it's optimal to compile only what we need.
However, this code is for the community, not for specific users.  And, I still
unsure how much pain is incurred by the compilation of one additional source
file for you, and others in the community.

And, sometimes we can compile some of unnecessary code and thus make the binary
a tiny bit bigger to make the code simple.  If it seems the benefit of dropping
DAMON_PADDR dependency is clearly bigger than increased complexity of dbgfs and
the change doesn't break any other things to me, I will happily give you my
'Reviewed-by:'.  Else, I'm sorry but I wouldn't.

Also, please note that I have a plan[1] to make more reliable DAMON user
interface based on sysfs, and it would not have such unnecessary dependencies.

[1] https://lore.kernel.org/linux-mm/20220119133110.24901-1-sj@kernel.org/

> 
> 
> I quite agree with what you said, it is necessary to conduct sufficient 
> test and verification, which I have not done enough. However, I will 
> conduct further test later. I don't think we should not modify the 
> previous test case just because it will affect it. I can guarantee the 
> tools/testing/selftests/Damon and kunit Damon test right before i send a 
> new version.

Those are for minimal tests.  I'd like to suggest you to do
https://github.com/awslabs/damon-tests/tree/master/corr, or at least
https://github.com/awslabs/damo/blob/next/tests/run.sh in addition to those.

Also, please ensure you are caring not only DAMON_VADDR && DEBUG_FS, but also
DAMON_PADDR && DEBUG_FS.  This also reveals another downside of this patch.
This requires DAMON tests to cover the one more configuration case.  And
actually it's currently affecting you.  I hope the benefit of next patch
clearly outweighs the effort for that.

Of course, it would be even greter if you can clearly guarantee the patch will
not break other things with the code or comments.


Thanks,
SJ

> 
> >
> > I don't find answers to the requests here.  Could you please add those if you
> > have?
> >
> > [1] https://lore.kernel.org/linux-mm/fbf27c39e8f23d12d5474b9b659d3d45f8dd38ca.1637429074.git.xhao@lin
> > ux.alibaba.com/
> > [2] https://lore.kernel.org/linux-mm/b6bd0063-efb2-62ce-53ee-0193f63262d8@linux.alibaba.com/
> > [3] https://lore.kernel.org/linux-mm/20211123103855.12592-1-sj@kernel.org/
> >
> >
> > Thanks,
> > SJ
> >
> >> So there just do little change to fix it.
> >>
> >> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> >> ---
> >>   include/linux/damon.h | 16 ++++++++++++++++
> >>   mm/damon/Kconfig      |  2 +-
> >>   2 files changed, 17 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/damon.h b/include/linux/damon.h
> >> index 794b5f453662..c83e4588aa45 100644
> >> --- a/include/linux/damon.h
> >> +++ b/include/linux/damon.h
> >> @@ -501,12 +501,28 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
> >>   #ifdef CONFIG_DAMON_VADDR
> >>   bool damon_va_target_valid(void *t);
> >>   void damon_va_set_primitives(struct damon_ctx *ctx);
> >> +#else
> >> +static inline void damon_va_set_primitives(struct damon_ctx *ctx) { }
> >> +static inline bool damon_va_target_valid(void *t)
> >> +{
> >> +	return false;
> >> +}
> >>   #endif	/* CONFIG_DAMON_VADDR */
> >>
> >>   #ifdef CONFIG_DAMON_PADDR
> >>   bool damon_pa_check(char *buf, size_t count);
> >>   bool damon_pa_target_valid(void *t);
> >>   void damon_pa_set_primitives(struct damon_ctx *ctx);
> >> +#else
> >> +static inline bool damon_pa_check(char *buf, size_t count)
> >> +{
> >> +	return false;
> >> +}
> >> +static inline void damon_pa_set_primitives(struct damon_ctx *ctx) { }
> >> +static inline bool damon_pa_target_valid(void *t)
> >> +{
> >> +	return false;
> >> +}
> >>   #endif	/* CONFIG_DAMON_PADDR */
> >>
> >>   #endif	/* _DAMON_H */
> >> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> >> index 5bcf05851ad0..a8952af3c8bf 100644
> >> --- a/mm/damon/Kconfig
> >> +++ b/mm/damon/Kconfig
> >> @@ -54,7 +54,7 @@ config DAMON_VADDR_KUNIT_TEST
> >>
> >>   config DAMON_DBGFS
> >>   	bool "DAMON debugfs interface"
> >> -	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
> >> +	depends on (DAMON_VADDR || DAMON_PADDR) && DEBUG_FS
> >>   	help
> >>   	  This builds the debugfs interface for DAMON.  The user space admins
> >>   	  can use the interface for arbitrary data access monitoring.
> >> --
> >> 2.27.0
> >>
> -- 
> Best Regards!
> Xin Hao
> 
