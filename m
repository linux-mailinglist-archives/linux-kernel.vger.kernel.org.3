Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCB051FC50
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbiEIMP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiEIMPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:15:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1BA149ABD;
        Mon,  9 May 2022 05:11:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652098315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fdMlXl/5cbOn67j58YZZq3Iq75451DHzugIa12n6YdQ=;
        b=uw8lq4AsfqLcbN4Dvu2spbaWFtpItEctuzNfDt1KLAXwEV+7SEEKdAxcy6LqH9DsYWZ7qR
        vWhkZp+n3rYuXxlKOvBwmb6FJT5KM010IFdFurHrTHaWtN17SRf8DAZ16CMjh4D6teTvKV
        Uz66TJlF0vViY4BIyUCTWfOX2Rv7d3HtIRZJZsIqche3E1aG94M4PEEa8UfD2lX08dMqmn
        kjnf4R4SHeZ+DzPUnKh2kMdxCo/rGV1vhDqtnvhdae30v/0IcAXhhEnUwkpSe3O3YG5RXN
        +jbR6ZOYkQv2IiUzhLYUmQAJDy/1wbz7uNwdoZEnDBiLd5URRJHaEzCLf26CjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652098315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fdMlXl/5cbOn67j58YZZq3Iq75451DHzugIa12n6YdQ=;
        b=WLJ4qQc0Pa4ernlDQdXt7u481TctoUyjRBzb8N1ON36rdqEHvGO8EI2nCJDOqwl1NJs8OL
        JMEO5k5QQKc/lxDA==
To:     Tony Luck <tony.luck@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v7 08/12] platform/x86/intel/ifs: Add scan test support
In-Reply-To: <20220506225410.1652287-9-tony.luck@intel.com>
References: <20220506014035.1173578-1-tony.luck@intel.com>
 <20220506225410.1652287-1-tony.luck@intel.com>
 <20220506225410.1652287-9-tony.luck@intel.com>
Date:   Mon, 09 May 2022 14:11:55 +0200
Message-ID: <87wneurjlg.ffs@tglx>
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

On Fri, May 06 2022 at 15:54, Tony Luck wrote:
> From: Jithu Joseph <jithu.joseph@intel.com>
>
> In a core, the scan engine is shared between sibling cpus.
>
> When a Scan test (for a particular core) is triggered by the user,
> the scan chunks are executed on all the threads on the core using
> stop_core_cpuslocked.
>
> Scan may be aborted by some reasons. Scan test will be aborted in certain
> circumstances such as when interrupt occurred or cpu does not have enough
> power budget for scan. In this case, the kernel restart scan from the chunk
> where it stopped. Scan will also be aborted when the test is failed. In
> this case, the test is immediately stopped without retry.
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Co-developed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
