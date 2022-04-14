Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9138D5017B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359409AbiDNPor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350677AbiDNPQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:16:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F74926DF;
        Thu, 14 Apr 2022 07:59:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649948365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=taiC+lrAFS/tnkPZvEFulCZnvrAxFQiGKHGcqlbV7mc=;
        b=iTe0QCfkyFLaBgNBvQ7IFLqt0DWAk+yGnK6NCh79E9jkR5CdV9I75IFqcsJ3OU9lpORa+V
        OgWt/cgFUjWRlpa/kHLOHXl+lh00bXfSG8yUIDw2Gw/nvJbD9ZtgrTS8wvUC/xvYwlv4IQ
        KZ/gH8q2pcF0FSD4H42f/4goYtQM0wOsS2x2I/xFOFiBQtESgksjmID7MlwQhQnfVfnKxh
        d3EcXdmkaLtYkS9da2ZQXrT0wT0rnaSaHOldG3GxxdjTKYdVp4BMf1ojA2vm1lCHxgLqgf
        8D8RI5SQuhlxzpuWGujNU/zbSJJ3gWX2du8tAAQI/0Nk9cApfWprQL0uK9g2gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649948365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=taiC+lrAFS/tnkPZvEFulCZnvrAxFQiGKHGcqlbV7mc=;
        b=/scsCx2hbnK3QHNX7kt4BtQhegatXU31z8wtBg6ipfLQ6NACtD+jZVXBfO0jZbk662hDQ8
        zBkCQ7APDWo0QLCQ==
To:     Kurt Kanzenbach <kurt@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: Re: [PATCH v2 1/3] timekeeping: Introduce fast accessor to clock tai
In-Reply-To: <20220414091805.89667-2-kurt@linutronix.de>
References: <20220414091805.89667-1-kurt@linutronix.de>
 <20220414091805.89667-2-kurt@linutronix.de>
Date:   Thu, 14 Apr 2022 16:59:24 +0200
Message-ID: <87czhjemnn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14 2022 at 11:18, Kurt Kanzenbach wrote:
> Introduce fast/NMI safe accessor to clock tai for tracing. The Linux kernel
> tracing infrastructure has support for using different clocks to generate
> timestamps for trace events. Especially in TSN networks it's useful to have TAI
> as trace clock, because the application scheduling is done in accordance to the
> network time, which is based on TAI. With a tai trace_clock in place, it becomes
> very convenient to correlate network activity with Linux kernel application
> traces.

Steven, this is available for you to pull via:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tai-for-tracing

It's a single tagged commit on top of 5.18-rc2

Thanks,

        tglx

