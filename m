Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42AE57D448
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiGUThu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiGUThs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:37:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847C3357E6;
        Thu, 21 Jul 2022 12:37:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B8A8620AB;
        Thu, 21 Jul 2022 19:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03644C3411E;
        Thu, 21 Jul 2022 19:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658432266;
        bh=lhZFVZo1S3pL3LrjtkdG9MUij/u7N8Jj+E8qD7OoZFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nzQJASRixdEtjX7Tws63cAITqnGNlzoyjdDOzRdKQy5j2V+NwAiry29GGRvd0ae1x
         fvm4KUEM8tDgR8DWA/DrvILXqXp3rRAEOkBXdaVgt29oVhrgU/CyJvUxXt/l4HhOEc
         F73+3eR6WpMHsx9XLXzz8F7ZL7LI7xFchdrFmbnCXZ4lZCymKFqFTcYBimQnyJ25zj
         84j/JC+i0biBawWmjxtQbkzfL6gWX2BywZuRtpwe4N58nmvdOtBryMOGZD4owlBnIx
         B1VNSYGBBUd0MEAUxDpi4kpxGnBMXAdYZpyMLZ8ae4Rc06Mg7255Avd0hk8zWvz6c1
         vA8KBs+WfmLpA==
Date:   Thu, 21 Jul 2022 12:37:44 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, Tom Rix <trix@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH] Makefile.extrawarn: re-enable -Wformat for clang
Message-ID: <YtmrCJjQrSbv8Aj1@dev-arch.thelio-3990X>
References: <20220720232332.2720091-1-justinstitt@google.com>
 <CAKwvOdnSjyOdCZZ9AegCyfns3bvH3fbtbVgdThO2+rJAE=1bag@mail.gmail.com>
 <YtlsY2A2ZWK97Y8O@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtlsY2A2ZWK97Y8O@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 08:10:27AM -0700, Nathan Chancellor wrote:
> On Thu, Jul 21, 2022 at 07:27:34AM -0700, Nick Desaulniers wrote:
> > On Wed, Jul 20, 2022 at 4:23 PM Justin Stitt <justinstitt@google.com> wrote:
> > >
> > > There's been an ongoing mission to re-enable the -Wformat warning for
> > > Clang. A previous attempt at enabling the warning showed that there were
> > > many instances of this warning throughout the codebase. The sheer amount
> > > of these warnings really polluted builds and thus -Wno-format was added
> > > to _temporarily_ toggle them off.
> > >
> > > After many patches the warning has largely been eradicated for x86,
> > > x86_64, arm, and arm64 on a variety of configs. The time to enable the
> > > warning has never been better as it seems for the first time we are
> > > ahead of them and can now solve them as they appear rather than tackling
> > > from a backlog.
> > >
> > > As to the root cause of this large backlog of warnings, Clang seems to
> > > pickup on some more nuanced cases of format warnings caused by implicit
> > > integer conversion as well as default argument promotions from
> > > printf-like functions.
> > >
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/378
> > > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > ---
> > > Previous attempt: (https://patchwork.kernel.org/project/linux-kbuild/patch/20190201210853.244043-1-jflat@chromium.org/)
> > >
> > > Note:
> > > For this patch to land on its feet, the plethora of supporting patches that
> > > fixed various -Wformat warnings need to be picked up. Thanfully, a lot
> > > of them have!
> > >
> > > Here are the patches still waiting to be picked up:
> > > * https://lore.kernel.org/all/20220718230626.1029318-1-justinstitt@google.com/
> > > * https://lore.kernel.org/all/20220711222919.2043613-1-justinstitt@google.com/
> > 
> > Hi Masahiro, Nathan, and Tom,
> > What are your thoughts for _when_ in the release cycle this should be
> > picked up?  I worry that if we don't remove this soon, we will
> > backslide, and more -Wformat issues will crop up making removing this
> > in the future like digging in sand.  Justin has chased down many
> > instances of this warning, and I'm happy to help clean up fallout from
> > landing this.
> 
> Let me do a series of builds with the two patches above against
> next-20220721 to see if there are any instances of this warning across
> the less frequently tested architectures then I will review/ack this.

Alright, against next-20220721, I applied:

* https://lore.kernel.org/20220712204900.660569-1-justinstitt@google.com/ (applied to net-next, just not in this -next release)
* https://lore.kernel.org/20220718230626.1029318-1-justinstitt@google.com/ (not picked up)
* https://lore.kernel.org/20220711222919.2043613-1-justinstitt@google.com/ (not picked up)

I still see the following warnings. I have suggested fixes, which I am happy to
send unless Justin wants to.

========================================================================

ARCH=arm allmodconfig:

../drivers/iommu/msm_iommu.c:603:6: error: format specifies type 'unsigned short' but the argument has type 'int' [-Werror,-Wformat]
                                 sid);
                                 ^~~
../include/linux/dev_printk.h:146:70: note: expanded from macro 'dev_warn'
        dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                    ~~~     ^~~~~~~~~~~
../include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                _p_func(dev, fmt, ##__VA_ARGS__);                       \
                             ~~~    ^~~~~~~~~~~
1 error generated.

Introduced by commit f78ebca8ff3d ("iommu/msm: Add support for generic master
bindings").

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 428919a474c1..6a24aa804ea3 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -599,7 +599,7 @@ static int insert_iommu_master(struct device *dev,
 
 	for (sid = 0; sid < master->num_mids; sid++)
 		if (master->mids[sid] == spec->args[0]) {
-			dev_warn(dev, "Stream ID 0x%hx repeated; ignoring\n",
+			dev_warn(dev, "Stream ID 0x%x repeated; ignoring\n",
 				 sid);
 			return 0;
 		}

========================================================================

ARCH=hexagon allmodconfig + CONFIG_FRAME_WARN=0:

../drivers/misc/lkdtm/bugs.c:107:3: error: format specifies type 'unsigned long' but the argument has type 'int' [-Werror,-Wformat]
                REC_STACK_SIZE, recur_count);
                ^~~~~~~~~~~~~~
../include/linux/printk.h:537:34: note: expanded from macro 'pr_info'
        printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                ~~~     ^~~~~~~~~~~
../include/linux/printk.h:464:60: note: expanded from macro 'printk'
#define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                    ~~~    ^~~~~~~~~~~
../include/linux/printk.h:436:19: note: expanded from macro 'printk_index_wrap'
                _p_func(_fmt, ##__VA_ARGS__);                           \
                        ~~~~    ^~~~~~~~~~~
../drivers/misc/lkdtm/bugs.c:32:24: note: expanded from macro 'REC_STACK_SIZE'
#define REC_STACK_SIZE (THREAD_SIZE / 8)
                       ^~~~~~~~~~~~~~~~~
1 error generated.

Introduced by commit 24cccab42c41 ("lkdtm/bugs: Adjust recursion test to avoid
elision").

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 009239ad1d8a..6381255aaecc 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -29,7 +29,7 @@ struct lkdtm_list {
 #if defined(CONFIG_FRAME_WARN) && (CONFIG_FRAME_WARN > 0)
 #define REC_STACK_SIZE (_AC(CONFIG_FRAME_WARN, UL) / 2)
 #else
-#define REC_STACK_SIZE (THREAD_SIZE / 8)
+#define REC_STACK_SIZE ((unsigned long)(THREAD_SIZE / 8))
 #endif
 #define REC_NUM_DEFAULT ((THREAD_SIZE / REC_STACK_SIZE) * 2)
 

========================================================================

ARCH=arm allmodconfig:

../drivers/nvme/target/auth.c:492:18: error: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
                        ctrl->cntlid, ctrl->dh_keysize, buf_size);
                                      ^~~~~~~~~~~~~~~~
../include/linux/printk.h:517:37: note: expanded from macro 'pr_warn'
        printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                   ~~~     ^~~~~~~~~~~
../include/linux/printk.h:464:60: note: expanded from macro 'printk'
#define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                    ~~~    ^~~~~~~~~~~
../include/linux/printk.h:436:19: note: expanded from macro 'printk_index_wrap'
                _p_func(_fmt, ##__VA_ARGS__);                           \
                        ~~~~    ^~~~~~~~~~~
1 error generated.

Introduced by commit 71ebe3842ebe ("nvmet-auth: Diffie-Hellman key exchange
support").

This one is not clang specific and already has a fix pending:

https://lore.kernel.org/20220718050356.227647-1-hch@lst.de/

========================================================================

Pretty much every allmodconfig:

../sound/soc/sof/ipc3-topology.c:2343:4: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
                 SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
                 ^~~~~~~~~~~~~
../include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
        dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                 ~~~     ^~~~~~~~~~~
../include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                _p_func(dev, fmt, ##__VA_ARGS__);                       \
                             ~~~    ^~~~~~~~~~~
../include/uapi/sound/sof/abi.h:30:23: note: expanded from macro 'SOF_ABI_MAJOR'
#define SOF_ABI_MAJOR 3
                      ^
../sound/soc/sof/ipc3-topology.c:2343:19: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
                 SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
                                ^~~~~~~~~~~~~
../include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
        dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                 ~~~     ^~~~~~~~~~~
../include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                _p_func(dev, fmt, ##__VA_ARGS__);                       \
                             ~~~    ^~~~~~~~~~~
../include/uapi/sound/sof/abi.h:31:23: note: expanded from macro 'SOF_ABI_MINOR'
#define SOF_ABI_MINOR 22
                      ^~
../sound/soc/sof/ipc3-topology.c:2343:34: error: format specifies type 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
                 SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
                                               ^~~~~~~~~~~~~
../include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
        dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                 ~~~     ^~~~~~~~~~~
../include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                _p_func(dev, fmt, ##__VA_ARGS__);                       \
                             ~~~    ^~~~~~~~~~~
../include/uapi/sound/sof/abi.h:32:23: note: expanded from macro 'SOF_ABI_PATCH'
#define SOF_ABI_PATCH 0
                      ^
3 errors generated.

Introduced by commit 323aa1f093e6 ("ASoC: SOF: Add a new IPC op for parsing
topology manifest") for little reason it seems?

diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index b2cc046b9f60..65923e7a5976 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -2338,7 +2338,7 @@ static int sof_ipc3_parse_manifest(struct snd_soc_component *scomp, int index,
 	}
 
 	dev_info(scomp->dev,
-		 "Topology: ABI %d:%d:%d Kernel ABI %hhu:%hhu:%hhu\n",
+		 "Topology: ABI %d:%d:%d Kernel ABI %d:%d:%d\n",
 		 man->priv.data[0], man->priv.data[1], man->priv.data[2],
 		 SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
 

========================================================================

I would really like to see patches in flight for these before this patch
is accepted but it is really awesome to see how close we are :)

Cheers,
Nathan
