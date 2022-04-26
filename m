Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D367C50EE4E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241516AbiDZBwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbiDZBwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:52:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDEB120D04;
        Mon, 25 Apr 2022 18:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D305461748;
        Tue, 26 Apr 2022 01:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29014C385A7;
        Tue, 26 Apr 2022 01:49:30 +0000 (UTC)
Date:   Mon, 25 Apr 2022 21:49:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v4 09/10] trace: platform/x86/intel/ifs: Add trace point
 to track Intel IFS operations
Message-ID: <20220425214928.2aac3391@gandalf.local.home>
In-Reply-To: <1752057af33e4eb28bcea0fd75e44048@intel.com>
References: <20220419163859.2228874-1-tony.luck@intel.com>
        <20220422200219.2843823-1-tony.luck@intel.com>
        <20220422200219.2843823-10-tony.luck@intel.com>
        <20220425105251.3f5e8021@gandalf.local.home>
        <1752057af33e4eb28bcea0fd75e44048@intel.com>
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

On Mon, 25 Apr 2022 16:49:35 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> I see two paths:
> 
> 1) Create a new user friendly trace point for each new scan mode.
> 2) Just provide a generic one that dumps both the 64-bit WRMSR and RDMSR values.
> 
> Q: Are trace points "expensive" in some way ... so better to just have one than three?
>      Or are the cheap enough that decoding for the user is an OK thing?

Yes, they are expensive as each TRACE_EVENT() can add a few KB of text and
data. But you can add a DECLARE_EVENT_CLASS() and then add "printk"
differences that are less memory heavy.

See DEFINE_EVENT_PRINT().

-- Steve

