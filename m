Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4550957AA52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 01:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbiGSXPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 19:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiGSXP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:15:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ED51E3F0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 16:15:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43DFAB81D0D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B313C341C6;
        Tue, 19 Jul 2022 23:15:24 +0000 (UTC)
Date:   Tue, 19 Jul 2022 19:15:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: Re: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
Message-ID: <20220719191522.4002a5fb@gandalf.local.home>
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
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

On Sun, 19 Jun 2022 20:41:59 -0400
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> Core idea: Wouldn't it be nice if we had a common data structure and calling
> convention for outputting strings?

Because seq_buf gives us this already, the cover letter really just needs
to state exactly what the benefit is to replace seq_buf with printbuf (and
why seq_buf can not be simply extended to do some extra features).

I just applied your series and ran the tracing selftests and several of
them failed.

 # cd tools/testing/selftests/ftrace/
 # ./ftracetest

This means that this is not a simple replacement and that there's going to
be regressions with this change. The question is, is the added benefits of
doing the change greater than the fallout of the regressions?

-- Steve
