Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECD34C9625
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbiCAUTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238336AbiCAUSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:18:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0FB37024;
        Tue,  1 Mar 2022 12:17:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD457B81D1D;
        Tue,  1 Mar 2022 20:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D77C340F1;
        Tue,  1 Mar 2022 20:17:46 +0000 (UTC)
Date:   Tue, 1 Mar 2022 15:17:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [RFC 10/10] trace: platform/x86/intel/ifs: Add trace point to
 track Intel IFS operations
Message-ID: <20220301151744.1ad5e11a@gandalf.local.home>
In-Reply-To: <20220301195457.21152-11-jithu.joseph@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
        <20220301195457.21152-11-jithu.joseph@intel.com>
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

On Tue,  1 Mar 2022 11:54:57 -0800
Jithu Joseph <jithu.joseph@intel.com> wrote:

> +	TP_STRUCT__entry(
> +		__field(	u8,	start	)
> +		__field(	u8,	stop	)
> +		__field(	u64,	status	)
> +	),

I'd suggest swapping this to:

		__field(	u64,	status	)
		__field(	u8,	start	)
		__field(	u8,	stop	)

As trace events are usually aligned by 4 bytes (sometimes 8 for archs that
require 8byte alignment for 8 byte words), but any event, putting the
padding at the end of the event is better than in the middle of the event.

Having the u64 come after two u8 (two byes) will pretty much guarantee a 6
bytes hole in the middle of the event.

-- Steve
