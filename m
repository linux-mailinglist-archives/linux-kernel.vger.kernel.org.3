Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C875093AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383264AbiDTXld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344527AbiDTXlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:41:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4323969C;
        Wed, 20 Apr 2022 16:38:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0C5D61B38;
        Wed, 20 Apr 2022 23:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCADC385A1;
        Wed, 20 Apr 2022 23:38:41 +0000 (UTC)
Date:   Wed, 20 Apr 2022 19:38:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        jithu.joseph@intel.com, ashok.raj@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
Subject: Re: [PATCH v3 10/11] trace: platform/x86/intel/ifs: Add trace point
 to track Intel IFS operations
Message-ID: <20220420193839.6e9d810b@gandalf.local.home>
In-Reply-To: <20220419163859.2228874-11-tony.luck@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
        <20220419163859.2228874-1-tony.luck@intel.com>
        <20220419163859.2228874-11-tony.luck@intel.com>
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

On Tue, 19 Apr 2022 09:38:58 -0700
Tony Luck <tony.luck@intel.com> wrote:

> +TRACE_EVENT(ifs_status,
> +
> +	TP_PROTO(union ifs_scan activate, union ifs_status status),

Really, you want to pass the structure in by value, so that we have two
copies? One to get to this function and then one to write to the ring
buffer?

-- Steve


> +
> +	TP_ARGS(activate, status),
> +
> +	TP_STRUCT__entry(
> +		__field(	u64,	status	)
> +		__field(	u8,	start	)
> +		__field(	u8,	stop	)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->start	= activate.start;
> +		__entry->stop	= activate.stop;
> +		__entry->status	= status.data;
> +	),
> +
> +	TP_printk("start: %.2x, stop: %.2x, status: %llx",
> +		__entry->start,
> +		__entry->stop,
> +		__entry->status)
> +);
> +
> +#endif /* _TRACE_IFS_H */
