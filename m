Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB50E4B9E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbiBQLNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:13:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiBQLNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:13:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B4E1DE8BC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:12:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 023FCB82120
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36156C340E8;
        Thu, 17 Feb 2022 11:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645096363;
        bh=4vyVg3lYc5vB8v5XnU2hefV+S70YYNeOi2ZcjG7nAjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SSa1IC9fhvgmDYrRdk+if9uK/wx/p2iG8u6OuXqRB5Wq7RueEdM5eEPNn0LpV8OR2
         UGqmOwhNlci7MoZEZ1WgXBNTPwVT3ndz8c+lVQHs6a09eCy/52v4sg9gNwLIbXyJfP
         lLjocmdmjo8aUEEyNk2/dTw8wo7+FRbV+PrvHqU4elOo4Yt5RW4HYEDLntJsvEdb9K
         Aszae3Zx0BwuHr+9N8Yn/87KbfIqAMFSWXSQD9XgtCPDjcZvv4VVZKXHEP9DiqXkDk
         /DtseDkGdMqow6HGU12gHFo9E+cSASArZT/SIpI93JvWx+mfuubbPhjoCOjRQliTuz
         Ox7aB3HXQf+UA==
Date:   Thu, 17 Feb 2022 12:12:40 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] sched/preempt: Tell about PREEMPT_DYNAMIC on kernel
 headers
Message-ID: <20220217111240.GA742892@lothringen>
References: <20220202145954.458370-1-frederic@kernel.org>
 <87mtj9nn3q.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtj9nn3q.mognet@arm.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 06:24:09PM +0000, Valentin Schneider wrote:
> On 02/02/22 15:59, Frederic Weisbecker wrote:
> > Displaying "PREEMPT" on kernel headers when CONFIG_PREEMPT_DYNAMIC=y
> > can be misleading for anybody involved in remote debugging because it
> > is then not guaranteed that there is an actual preemption behaviour. It
> > depends on default Kconfig or boot defined choices.
> >
> > Therefore, tell about PREEMPT_DYNAMIC on static kernel headers and leave
> > the search for the actual preemption behaviour to browsing dmesg.
> >
> 
> Looks sensible. One small further cleanup nit below, otherwise:
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
[...]
> 
> I got suspicious of that PREEMPT_RT line, but it works because
> PREEMPT_BUILD and PREEMPT_RT are mutually exclusive. Nevertheless, could we
> clear out the ambiguity and make that into:
> 
> if   [ -n "$PREEMPT_RT" ] ;      then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_RT";
> elif [ -n "$PREEMPT_DYNAMIC" ] ; then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_DYNAMIC";
> elif [ -n "$PREEMPT" ] ;         then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT";
> fi

Good point!

Here you go:

---
From: Frederic Weisbecker <frederic@kernel.org>
Date: Wed, 2 Feb 2022 15:59:54 +0100
Subject: [PATCH] sched/preempt: Tell about PREEMPT_DYNAMIC on kernel headers

Displaying "PREEMPT" on kernel headers when CONFIG_PREEMPT_DYNAMIC=y
can be misleading for anybody involved in remote debugging because it
is then not guaranteed that there is an actual preemption behaviour. It
depends on default Kconfig or boot defined choices.

Therefore, tell about PREEMPT_DYNAMIC on static kernel headers and leave
the search for the actual preemption behaviour to browsing dmesg.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 init/Makefile       |  3 ++-
 scripts/mkcompile_h | 17 ++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/init/Makefile b/init/Makefile
index 06326e304384..d82623d7fc8e 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -31,7 +31,8 @@ quiet_cmd_compile.h = CHK     $@
       cmd_compile.h = \
 	$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@	\
 	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT_BUILD)"	\
-	"$(CONFIG_PREEMPT_RT)" "$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
+	"$(CONFIG_PREEMPT_DYNAMIC)" "$(CONFIG_PREEMPT_RT)" \
+	"$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
 
 include/generated/compile.h: FORCE
 	$(call cmd,compile.h)
diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index 6a2a04d92f42..ca40a5258c87 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -5,9 +5,10 @@ TARGET=$1
 ARCH=$2
 SMP=$3
 PREEMPT=$4
-PREEMPT_RT=$5
-CC_VERSION="$6"
-LD=$7
+PREEMPT_DYNAMIC=$5
+PREEMPT_RT=$6
+CC_VERSION="$7"
+LD=$8
 
 # Do not expand names
 set -f
@@ -41,8 +42,14 @@ fi
 UTS_VERSION="#$VERSION"
 CONFIG_FLAGS=""
 if [ -n "$SMP" ] ; then CONFIG_FLAGS="SMP"; fi
-if [ -n "$PREEMPT" ] ; then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT"; fi
-if [ -n "$PREEMPT_RT" ] ; then CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_RT"; fi
+
+if [ -n "$PREEMPT_RT" ] ; then
+	CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_RT"
+elif [ -n "$PREEMPT_DYNAMIC" ] ; then
+	CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_DYNAMIC"
+elif [ -n "$PREEMPT" ] ; then
+	CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT"
+fi
 
 # Truncate to maximum length
 UTS_LEN=64
-- 
2.25.1

