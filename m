Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35E14CA90C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243451AbiCBP14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243464AbiCBP1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:27:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DF2B0EAF;
        Wed,  2 Mar 2022 07:27:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAB93B82029;
        Wed,  2 Mar 2022 15:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643C3C004E1;
        Wed,  2 Mar 2022 15:27:07 +0000 (UTC)
Date:   Wed, 2 Mar 2022 10:27:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Chun-Tse Shao <ctshao@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] config: Using HOSTPKG_CONFIG prefix for pkg-config
Message-ID: <20220302102705.15c32822@gandalf.local.home>
In-Reply-To: <CAL_JsqK59GGhYQSEWvb=HtHTwMh=LXomu2zX4dEQeo4s3A0VtQ@mail.gmail.com>
References: <20220301230629.1892828-1-ctshao@google.com>
        <CAL_JsqK59GGhYQSEWvb=HtHTwMh=LXomu2zX4dEQeo4s3A0VtQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 08:18:15 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Tue, Mar 1, 2022 at 5:07 PM Chun-Tse Shao <ctshao@google.com> wrote:
> >
> > In some parts, pkg-config does not use appropriate $BUILDROOT prefix.  
> 
> The kernel tree knows nothing about buildroot. Please reword this in a
> more generic way that you need to override the host pkg-config.

I don't even know what $BUILDROOT is ;-)

But I do know that it's good practice to allow pkg-config to be overridden.
I have several user space tools that needed it done to allow distros to
install them properly.

Would you be OK with a description like:

    Allow kernel installation packaging to override pkg-config.

?

> 
> > The patch adds HOSTPKG_CONFIG prefix for pkg-config to fix the issue.

A couple of things. It is consider poor form to reference "the patch".
Another thing is that this is not a prefix for pkg-config, it is overriding
what pkg-config is used during the build process.

    Add HOSTPKG_CONFIG to allow tooling that builds the kernel to override
    what pkg-config and parameters are used.

Something like that.

-- Steve



> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
