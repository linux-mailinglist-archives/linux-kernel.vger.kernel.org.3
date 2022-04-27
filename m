Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B23511B73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbiD0N5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbiD0N5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:57:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E834248B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A526B82778
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 13:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A50CC385A9;
        Wed, 27 Apr 2022 13:54:16 +0000 (UTC)
Date:   Wed, 27 Apr 2022 09:54:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] recordmcount: Handle sections with no non-weak
 symbols
Message-ID: <20220427095415.594e5120@gandalf.local.home>
In-Reply-To: <1b9566f0e7185fb8fd8ef2535add7a081501ccc8.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
        <1b9566f0e7185fb8fd8ef2535add7a081501ccc8.1651047542.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 15:01:22 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> If one or both of these weak functions are overridden in future, in the
> final vmlinux mcount table, references to these will change over to the
> non-weak variant which has its own mcount location entry. As such, there
> will now be two entries for these functions, both pointing to the same
> non-weak location.

But is that really true in all cases? x86 uses fentry these days, and other
archs do things differently too. But the original mcount (-pg) call
happened *after* the frame setup. That means the offset of the mcount call
would be at different offsets wrt the start of the function. If you have
one of these architectures that still use mcount, and the weak function
doesn't have the same size frame setup as the overriding function, then the
addresses will not be the same.

-- Steve


> We don't need the non-weak locations since they will
> never be executed. Ftrace skips the duplicate entries due to a previous
> commit.

