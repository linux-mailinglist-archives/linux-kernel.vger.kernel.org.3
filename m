Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8300257080D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiGKQK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiGKQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405097AB15
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C08AC611C2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C238CC34115;
        Mon, 11 Jul 2022 16:10:16 +0000 (UTC)
Date:   Mon, 11 Jul 2022 12:10:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "XueBing Chen" <chenxuebing@jari.cn>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: use strscpy to replace strlcpy
Message-ID: <20220711121014.6f9e75cb@gandalf.local.home>
In-Reply-To: <20220711104125.1d9ba146@gandalf.local.home>
References: <49ec0969.e32.181eda74871.Coremail.chenxuebing@jari.cn>
        <20220711104125.1d9ba146@gandalf.local.home>
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

On Mon, 11 Jul 2022 10:41:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 11 Jul 2022 22:26:12 +0800 (GMT+08:00)
> "XueBing Chen" <chenxuebing@jari.cn> wrote:
> 
> > The strlcpy should not be used because it doesn't limit the source
> > length. Preferred is strscpy.  
> 
> That's not enough justification to make the switch.
> 
> These calls are done at boot up. If there's a bug in the source, I rather
> have it crash.

And unless there is good justification and understanding of how the code
works, blindly switching strlcpy() with strscpy() can have undesirable
consequences:

  https://lore.kernel.org/all/20220701094403.3044-1-adrian.hunter@intel.com/T/#u

Please stop changing all strlcpy() to strscpy() unless there's good
justification to do so. Just saying "strscpy() is preferred", is not
justification to make the change.

-- Steve
