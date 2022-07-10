Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA9E56D1CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 00:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiGJW1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 18:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJW1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 18:27:42 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2771EA1B4;
        Sun, 10 Jul 2022 15:27:41 -0700 (PDT)
Date:   Mon, 11 Jul 2022 06:28:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657492059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZUFb5ucO1JJlddQkXqD+0kfsu3ItWuXMmHu5j+INC1Q=;
        b=laM9f48VefRkClFbhgfpIKhMHyWQu0k9ZxfIiwuQBKg701eA/tlpKG1C384CQnjzpiq1NE
        Rihkx2xXv2f5yzuri9JIArQ+ZlWPw6dPqYgI28M6ql98Fese0NFMBRgAkJUnBTtVyG6sqB
        rv33k2eZCqLAh34wY9FMIy2AldR15iU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH V4 01/20] rv: Add Runtime Verification (RV) interface
Message-ID: <YstSnnCL45wne7K9@geo.homenetwork>
References: <cover.1655368610.git.bristot@kernel.org>
 <60548902dbccaa7ba420e40e46835693e27f643f.1655368610.git.bristot@kernel.org>
 <YsXLDvjHqOxYtckg@geo.homenetwork>
 <adbf8277-e680-9357-950d-22cf54b1f6ff@kernel.org>
 <YsrsL8zCNcwvdQS8@geo.homenetwork>
 <20220710114242.745d65b3@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710114242.745d65b3@rorschach.local.home>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 11:42:42AM -0400, Steven Rostedt wrote:

> On Sun, 10 Jul 2022 23:11:43 +0800
> Tao Zhou <tao.zhou@linux.dev> wrote:
> 
> > The @*pos of enable_monitors_start() can not be -1 or other negative value.
> > And I checked that the *pos is 0(right?). That is safe. Sorry for not being
> > that ture and maybe this is a notice here. Because if it is a negative value,
> > the returned m_def is a point to a data place 16 bytes before &rv_monitors_list.
> > That is a not ture rv_monitors_list stucture data. But it is not possiable now.
> > Maybe "inspired" from your question. Look it more, I image this simulation.
> > If the monitor(and all is enabled) is more enough to let the *pos to increase
> > to -1. And the returned m_def is last monitor that returned from enable_monitors_start().
> > The enable_monitors_next() check from the last monitor and return NULL.
> > Only show the last monitor. This will not really happen I think.
> > But I am not focus enough to the seq file code or others now, so this may be
> > more possible to be not right. Late reply continued from me..
> 
> 
> So basically you are saying we should have:
> 
> > +static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
> > +{
> > +       struct rv_monitor_def *m_def;
> > +       loff_t l;
> > +
> > +       mutex_lock(&rv_interface_lock);
> 
> 	if (list_empty(&rv_monitors_list->list))
> 		return NULL;
> ?

From the function itself, this looks safer. Thanks.

> Probably safer to have that.
> 
> -- Steve
> 
> 
> > +       m_def = list_entry(&rv_monitors_list, struct rv_monitor_def, list);
> > +
> > +       for (l = 0; l <= *pos; ) {
> > +               m_def = enabled_monitors_next(m, m_def, &l);
> > +               if (!m_def)
> > +                       break;
> > +       }
> > +
> > +       return m_def;
> > +}
