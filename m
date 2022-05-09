Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE3C51FE93
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiEINrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbiEINrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:47:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F59A23EB72
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:43:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652103823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wbw2PH2q14vqy2arD6A5/F7F25g9KpGTKHYXn8LUfgQ=;
        b=rIpSMu4/xnQ6lA1lN8+zpOxJHz49PRCVJM48Iy2uMVDhuWdYiha6FIUZDMcDFsq1b+2qS7
        cwrNHuX3hSdsrPdgk4Fu2Qox11ZQlIzflEWGDcydkuJUANuN+RW6CguVxPDyF4lng0CDAC
        8iea3YuBdJV+xfwHOjpEVs9w4JluHqGI02U7qGTqxpG/epTyk0OF+x9qLrvAh935Anmvdn
        skS9Bs4VHzYRPIeFSY8F8sEbdY9wHB0IYHVJFI59WtOQ/9c3f+w+lGDWFj4TUhTWQKBpVJ
        KC7xq/qTQjGfAXsYCV0jdWFWeIN8SBaKhAC2IdGxa+eH43UzOlES5tRwk8phVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652103823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wbw2PH2q14vqy2arD6A5/F7F25g9KpGTKHYXn8LUfgQ=;
        b=YGrx6stVKx4sWKygF1Mm7p3ObN3wWGYMA/PyZpf7D/6W+duuRmq0sMuxGfe51iGt6Y9hhQ
        olIm5/J8DYDvLvBA==
To:     Feng Tang <feng.tang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        rui.zhang@intel.com, len.brown@intel.com, tim.c.chen@intel.com
Subject: Re: [PATCH] x86/tsc: Add option to force HW timer based recalibration
In-Reply-To: <20220509133622.GE40730@shbuild999.sh.intel.com>
References: <20220508144733.91343-1-feng.tang@intel.com>
 <20220509045839.GA40730@shbuild999.sh.intel.com>
 <20220509071652.GE76023@worktop.programming.kicks-ass.net>
 <20220509073003.GB40730@shbuild999.sh.intel.com> <87h75zrpmh.ffs@tglx>
 <20220509112235.GD40730@shbuild999.sh.intel.com> <87levarh7m.ffs@tglx>
 <20220509133622.GE40730@shbuild999.sh.intel.com>
Date:   Mon, 09 May 2022 15:43:43 +0200
Message-ID: <87czgmrfcg.ffs@tglx>
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

On Mon, May 09 2022 at 21:36, Feng Tang wrote:
> On Mon, May 09, 2022 at 03:03:25PM +0200, Thomas Gleixner wrote:
>> TSC accuracy is important in any case. Why would it be more important on
>> server platforms? Just because?
>
> It was my wild guess, as I thought servers used by enterprise or financial
> system may care more about the accuracy.

Guess-ineering is not really leading anywhere. Facts matter.

Thanks,

        tglx
