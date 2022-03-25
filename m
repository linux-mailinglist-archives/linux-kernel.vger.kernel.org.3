Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F7E4E784A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357206AbiCYPq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376991AbiCYPmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:42:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5190D4A92D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:37:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F119617B1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 15:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7953C340E9;
        Fri, 25 Mar 2022 15:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648222640;
        bh=z/tj9379s2brMQn0z0S3F/M1BsjmaTZ7Dhjo9GF9rsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uc02Fcd8vpsITGYBkaTuWcxMb3swn8zJ5k1vtS7Oqv0nOfa3FlEpj+NCBaNdntpZu
         GAUApysYOGYkpOYvrby5Oky5Q/+CtUXik8/mIze4WQZqW1XtLd3DyaJ6FYq+cjHJHt
         jsBX3Be+C5BmlvLSRTkZEgMXLYexaSRZA+dyAjJxTM/4e7iWofjPa9CTmT5Bt0Mzwi
         YX/qF6NFIX3MyZ6gnzXIV5dX2IpAs1iBvqK/i/kTYIdFrK8+AhxuGvud4T/tBq2Avq
         24jRIw5vf/mW36k1ZLCTxSeRVJ0KnpTM1EbSH+S7CkSuduUO1/71KTgxqVpVmmsQzm
         bmOOiSey1UNVA==
Date:   Fri, 25 Mar 2022 16:37:14 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/1] ns: Move MAX_PID_NS_LEVEL to ns_common.h, reuse it
Message-ID: <20220325153714.eau4ja6pcr2a34sh@wittgenstein>
References: <20220325112127.18026-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220325112127.18026-1-pvorel@suse.cz>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 12:21:27PM +0100, Petr Vorel wrote:
> Move MAX_PID_NS_LEVEL to ns_common.h and reuse it in check in
> user_namespace.c.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Christian, all,
> 
> I don't see putting MAX_PID_NS_LEVEL into ns_common.h as an elegant
> solution but IMHO better than use a hardwired number or redefinition in
> user_namespace.h.

Hey Petr,

Weird I either deleted that message by accident or didn't get it.

> 
> Kind regards,
> Petr
> 
>  include/linux/ns_common.h     | 3 +++
>  include/linux/pid_namespace.h | 3 ---
>  kernel/user_namespace.c       | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index 0f1d024bd958..173fab9dadf7 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -4,6 +4,9 @@
>  
>  #include <linux/refcount.h>
>  
> +/* MAX_PID_NS_LEVEL is needed for limiting size of 'struct pid' */
> +#define MAX_PID_NS_LEVEL 32

The only two namespaces where this applies to have the same hard-coded
limit. If you want to get rid of the raw number you should just
introduce a generic define that expresses the limit for both pidns
and userns. Using "MAX_PID_NS_LEVEL" in the userns case is very
confusing. So if you wanted to do this introducing something like
#define MAX_NS_LEVEL 32
and using it in both places makes more sense.

Christian
