Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DE951D33F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390079AbiEFIYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390168AbiEFIY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:24:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D05413D13;
        Fri,  6 May 2022 01:20:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651825224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XvECXZlKv//5WXr2Qh3h1YJR2CNLvzofteXK2A2O1ho=;
        b=C8ni3HIp+lksZAPvlwAD6tGqGcAuY5WJ7CQCJojWPzOWWgQTwgRyNAgCBFQkV5VfxGHFGe
        j0MqyYE+lNEt0MQkpP1deH5GhC+aE0GlsIllCQm8coNDB+hSk34j0R0CiEKpxsoyzbGmtt
        Su3DU3ch9uDjbQwNHvnkTMAclmQFDC4jTzbTDvWR7T+JOI2VDOlgW+SEZAFnENWVURKSq4
        8W+P05Oix32+ZM4SwrKRoZkCtr+Q805Y12gvaEma15l7o6dcJCAG27PGQDKIQJOmVB+9q3
        kw0oucAN942TB66n8wMEAs2fo1vHp2B047hKLXSIrSU/6/SAqw2dPQTFIZ+r2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651825224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XvECXZlKv//5WXr2Qh3h1YJR2CNLvzofteXK2A2O1ho=;
        b=EvVTeBAWPkgbWcXilyuBQ16WAspalSc/xW7PUI/iM2W3GpiEZJY2Q7Lf7/3O4+mx8be/Ik
        7JbcLOHcn+8IU6BA==
To:     Tony Luck <tony.luck@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 03/11] stop_machine: Add stop_core_cpuslocked() for
 per-core operations
In-Reply-To: <20220506014035.1173578-4-tony.luck@intel.com>
References: <20220428153849.295779-1-tony.luck@intel.com>
 <20220506014035.1173578-1-tony.luck@intel.com>
 <20220506014035.1173578-4-tony.luck@intel.com>
Date:   Fri, 06 May 2022 10:20:23 +0200
Message-ID: <87wnezgji0.ffs@tglx>
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

On Thu, May 05 2022 at 18:40, Tony Luck wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> Hardware core level testing features require near simultaneous execution
> of WRMSR instructions on all threads of a core to initiate a test.
>
> Provide a customized cut down version of stop_machine_cpuslocked() that
> just operates on the threads of a single core.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
