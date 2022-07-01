Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810275638CF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 19:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiGAR5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 13:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiGAR5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:57:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9FB3F897
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 10:57:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1859BB83108
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 17:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB96C3411E;
        Fri,  1 Jul 2022 17:57:25 +0000 (UTC)
Date:   Fri, 1 Jul 2022 13:57:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nachammai Karuppiah <nachukannan@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [RFC PATCH 0/7] Trace events to pstore
Message-ID: <20220701135723.12b4f179@gandalf.local.home>
In-Reply-To: <CAEXW_YQk44VdSrZFtpfyCPHcrDxEFaEe2Wu900CZcWWodw3+xg@mail.gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
        <CAEXW_YSt49yGH+Wc63zfm4i7n1M_YxETbAA8nxmfDH1B3WFQXg@mail.gmail.com>
        <CAL_JsqK7QRgCcD01MfVermvTGgLPj8KC412kxSQg2zsp_46fgQ@mail.gmail.com>
        <CAEXW_YTr9VaEY78S_C5iN1EH3hySZOED8F37t1A=7PNgbQK9CA@mail.gmail.com>
        <20220630154847.134d3d67@gandalf.local.home>
        <CAEXW_YREDKcgn9jkVeFMjBqjA51HGZ=1Tp4z4oUhngJ3Wyz8MA@mail.gmail.com>
        <20220701124628.36009f4a@gandalf.local.home>
        <CAEXW_YQk44VdSrZFtpfyCPHcrDxEFaEe2Wu900CZcWWodw3+xg@mail.gmail.com>
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

On Fri, 1 Jul 2022 12:53:17 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> Interesting. In the case of pstore, you know exactly where the pages
> are for ftrace. How would you know that for the buddy system where
> pages are in the wild wild west? I guess you would need to track where
> ftrace pages where allocated, within the crash dump/report.

kexec/kdump already does that (of course it requires the DWARF symbols of
the kernel to be accessible by the kdump kernel).

But if we write the raw ftrace data into persistent memory that can survive
a reboot, then we can extract that raw data and convert it back to text
offline.

Thus, I would like to remove the converting to text and compressing into
pstore, and possibly look at a solution that simply writes the raw data
into pstore.

-- Steve
