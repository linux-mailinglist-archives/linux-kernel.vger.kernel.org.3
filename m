Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C084D73A7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiCMHuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiCMHuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F143ECD
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 23:49:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52EA760F8D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 07:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792D7C340E8;
        Sun, 13 Mar 2022 07:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647157741;
        bh=DBF6eWqFEccMz5CgUF4wVXljsDuvc1KVKW+KqHOTp84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LJhTmJ+DS7RlYi5FJ/+gtz2XAOTgVOLJS8rkiCGd9pHlO3L4xjMq8rT5V7n/yjYA5
         yj+rX40msi0c2ezWYYjRraOTHkpT7Jc5ukBSCRztgJ5illZ5CzSL8pUUgA+mTUzumn
         bgqT7Tb+vHbZOTbib0atH23bBuXg6a2GI8yTeRWmi0VzlmRLWbJxz4xjkIW+agdGj1
         UxXBwR4yh/Ic39d0OJwrFT3GyJSk71MOj4AvV3jKP3l6vZVx98OXVmNeSkyGsNO39m
         6kVdTOrlNpCMVAfSR84/TKNjPMnGBq2aXLAsYJCw7N1Y9fRzwq38C+s/Kx6jWnRQgf
         u6pdaKGWwutuA==
Date:   Sun, 13 Mar 2022 16:48:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: tracing : bootconfig : Early boot config for non intrd systems
Message-Id: <20220313164857.cdd7aa7d7977bfff6c91fdff@kernel.org>
In-Reply-To: <20220312101606.41a9fc64@rorschach.local.home>
References: <20220307184011.GA2570@pswork>
        <20220308163600.3109f19854c7b051924f262b@kernel.org>
        <20220308174829.GA2471@pswork>
        <20220309170124.82dcfadbcda6f8ab6ed51797@kernel.org>
        <20220309190651.GA3735@pswork>
        <20220312155358.d6bc78866f4ca31e9a37e23a@kernel.org>
        <20220312101524.5d23c258@rorschach.local.home>
        <20220312101606.41a9fc64@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2022 10:16:06 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 12 Mar 2022 10:15:24 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sat, 12 Mar 2022 15:53:58 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > OK, please try below patch. You can embed your bootconfig in the kernel via
> > > CONFIG_EMBED_BOOT_CONFIG_FILE.
> > > 
> > >   
> > > >From 7478a8fbfe4669ee61fcb12b85b36d7e36f992ba Mon Sep 17 00:00:00 2001    
> > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > > Date: Sat, 12 Mar 2022 14:59:30 +0900
> > > Subject: [PATCH] bootconfig: Support embedding a bootconfig file in kernel  
> > 
> > I'm going to try this out, because there was a few times I could have
> > used this.
> > 
> 
> Oh, and can you send this as a separate patch so that it triggers my
> scripts?

OK, let me clean it up and add a document how to use it.

Thank you,

> 
> Thanks,
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
