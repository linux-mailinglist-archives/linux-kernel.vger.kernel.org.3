Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9214C52F5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 02:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbiBZBKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 20:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241069AbiBZBKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:10:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FEB1CC7F5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 17:10:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D7F661DFC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 01:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D40C340E7;
        Sat, 26 Feb 2022 01:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645837804;
        bh=kg0FEgqg2RbTbd4/G8UmAfj8jgJTKH9dc0ETYajXWGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nLyJE8CkzO6RT7zL90b31sQRzCsqCsr16nYJDGLDEJ+oqkFw5uLAHV3x21H1hvsGk
         WtmN/nKTTFVbm7qJGI54/SUb3fm/5g/0nOcARqnPAytFxZcbHU9X1LsGUg4CehkcpG
         xdjpR0n81fsotdQncJjxyVERHjgDEBwUinQgUq+0=
Date:   Fri, 25 Feb 2022 17:10:04 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH] Drop -Wdeclaration-after-statement
Message-Id: <20220225171004.edfda47af82ae98ef1c18b9d@linux-foundation.org>
In-Reply-To: <YhiQPhsoODiXRAPy@localhost.localdomain>
References: <YhiQPhsoODiXRAPy@localhost.localdomain>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 11:15:58 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Putting declarations before statement is relict of single pass compiler
> era. It was necessary to allocate stack slots before generating code.
> 
> Recently added static_assert() is a declaration. -Wdeclaration-after-statement
> prevents its placement anywhere in the code for no reason.
> 
> Placing variable declarations in the beginning of the block increases
> variable "LOC lifetime" so to speak and chances that it will be misused.
> This is very low probability bug but still. Declaring variables right
> before first use will make "LOC lifetime" smaller.
> 
> 	{
> 		int x;
> 		[x is misused due to a typo]
> 		f(x);	// first correct use
> 	}
> 
> vs
> 
> 	{
> 		[can't misuse undeclared variable]
> 		int x;
> 		f(x);	// first correct use
> 	}
> 

Oh man.  I so wish you'd cc'ed Linus on this one so we could admire his
reaction.
