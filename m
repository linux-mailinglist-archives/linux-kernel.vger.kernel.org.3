Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E1A53A972
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbiFAO54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiFAO5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:57:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378C848E57
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2ADF6146E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 14:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B984C385A5;
        Wed,  1 Jun 2022 14:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654095469;
        bh=MXWRHmHSAdjhUaccIo0GyTsXK1sAkJ+6VcfxiNE/aa8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q7Q/u9SdHy7/54IqiM3lHp33kCIsrtoRoWmSaUub+yI92Yx+/758enal6HsDjJ2N/
         j2gbWw9id+DzQTFsQ/vcXnwydJG82nB8+LJAPQH9EDl9SAz6IxMgG7x1DfshbgnogF
         V5P0bWJeaj6gbOXeekilS7usGIfKw1CvVJgJHwgspzQzxgvFq2G3Nv4Dhfd7HkoXCB
         AzSXCtjX+BZuBUGjP3b/+mA5JKh5cl7ZfolzoCXENhFWruQ99SlX2G6498HeYLvEIk
         dzWXDd8g1WJWp6Z0JBHcWrYQpLqTmJZJNhJhTFU3kZS1U+QoNQHcjsMQEhICp9PAwY
         4ZSkEWFtLbihg==
Date:   Wed, 1 Jun 2022 23:57:44 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] selftests/ftrace: add test case for GRP/ only
 input
Message-Id: <20220601235744.93ba3c80951680c3d6bb6961@kernel.org>
In-Reply-To: <1653978552-18637-4-git-send-email-quic_linyyuan@quicinc.com>
References: <1653978552-18637-1-git-send-email-quic_linyyuan@quicinc.com>
        <1653978552-18637-4-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linyu,

On Tue, 31 May 2022 14:29:12 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> add kprobe and eprobe event test for new GRP/ only format.
> 
> Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
> ---
> v3: first add in this version
> 
>  .../testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc  | 7 ++++++-
>  .../testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc  | 7 ++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> index 60c02b4..97856df 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: Generic dynamic event - add/remove eprobe events
> -# requires: dynamic_events events/syscalls/sys_enter_openat "e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]":README
> +# requires: dynamic_events events/syscalls/sys_enter_openat "e[:[<group>/][<event>]] <attached-group>.<attached-event> [<args>]":README

Hmm, this is too restricted. With this change, this entire test only runs after
patching this series.
Can you change the requires so that skip checking the first half, like
  "<attached-group>.<attached-event> [<args>]":README
and check whether "e[:[<group>/][<event>]]" is in the README for the new
test code?
 
>  echo 0 > events/enable
>  
> @@ -87,4 +87,9 @@ echo "-:eprobes/$EPROBE $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
>  ! grep -q "$EPROBE" dynamic_events
>  ! test -d events/eprobes/$EPROBE
>  
> +echo "e:mygroup/ $SYSTEM/$EVENT $OPTIONS" >> dynamic_events
> +test -d events/mygroup
> +echo "-:mygroup/" >> dynamic_events
> +! test -d events/mygroup
> +
>  clear_trace
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
> index b4da41d..6b102a7 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_kprobe.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  # description: Generic dynamic event - add/remove kprobe events
> -# requires: dynamic_events "place: [<module>:]<symbol>":README "place (kretprobe): [<module>:]<symbol>":README
> +# requires: dynamic_events "p[:[<group>/][<event>]] <place> [<args>]":README

Ditto. In this case, don't touch the requires line (because it is not
updated) and just add a README check for below new code.

Thank you,


>  
>  echo 0 > events/enable
>  echo > dynamic_events
> @@ -23,4 +23,9 @@ grep -q myevent1 dynamic_events
>  
>  echo > dynamic_events
>  
> +echo "p:mygroup/ $PLACE" >> dynamic_events
> +test -d events/mygroup
> +echo "-:mygroup/" >> dynamic_events
> +! test -d events/mygroup
> +
>  clear_trace
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
