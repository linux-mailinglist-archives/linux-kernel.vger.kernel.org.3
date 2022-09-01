Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EAE5A9CB0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbiIAQKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbiIAQKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:10:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7DE2F66F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:10:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA72261F5F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2427C433C1;
        Thu,  1 Sep 2022 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662048634;
        bh=DCp5squR5m5NwHxUhWVUSu23csTamGHJnCEZsRIaMts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPJyeSVZ16sd9K2jtcTBLh6HDPGoj5yZeCTs5fPgdR9nAjlCBqaILmfkj6nNc3u3X
         iMWF8IfNYJpkC+prjLbYYUKTA4AySigkS1XCyL2xfJiClVEExVcO1CRFhstrfV78My
         cU2mdzEa84OjAJOtXYSDma4JNQKNFpuTv9kIqnhY=
Date:   Thu, 1 Sep 2022 18:10:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jbaron@akamai.com
Subject: Re: [PATCH 00/11] DYNAMIC_DEBUG for this cycle
Message-ID: <YxDZd8MQtrTLLNmC@kroah.com>
References: <20220811173541.2901122-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811173541.2901122-1-jim.cromie@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 11:35:30AM -0600, Jim Cromie wrote:
> Hi Greg, Jason,
> 
> Please consider these for this rc-cycle.
>   - 1-9 have Jason's Ack,
>   - 9th removes unused EXPORTed fn.
>   - 10 is simple var cleanup
>   - 11 is a partial decoupling of dyndbg from kernel/module
> 
> Jim Cromie (11):
>   dyndbg: fix static_branch manipulation
>   dyndbg: fix module.dyndbg handling
>   dyndbg: show both old and new in change-info
>   dyndbg: reverse module walk in cat control
>   dyndbg: reverse module.callsite walk in cat control
>   dyndbg: use ESCAPE_SPACE for cat control
>   dyndbg: let query-modname override actual module name
>   dyndbg: add test_dynamic_debug module
>   dyndbg: drop EXPORTed dynamic_debug_exec_queries
>   dyndbg: cleanup auto vars in dynamic_debug_init
>   dyndbg: create and use struct _ddebug_info
> 
>  MAINTAINERS                   |   2 +
>  include/linux/dynamic_debug.h |  22 ++----
>  kernel/module/internal.h      |   4 +-
>  kernel/module/main.c          |  18 ++---
>  lib/Kconfig.debug             |  10 +++
>  lib/Makefile                  |   1 +
>  lib/dynamic_debug.c           | 141 +++++++++++++++++-----------------
>  lib/test_dynamic_debug.c      |  70 +++++++++++++++++
>  8 files changed, 172 insertions(+), 96 deletions(-)
>  create mode 100644 lib/test_dynamic_debug.c
> 
> -- 
> 2.37.1
> 

Is this still ok for linux-next now to go into 6.1-rc1?

Or does it need to be rebased?

thanks,

greg k-h
