Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C3C49C1DA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 04:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbiAZDLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 22:11:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53413 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236915AbiAZDKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 22:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643166650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C0mi9k2Wv36Blei5iDy0iH94DE1WW0Cz3OmUGyH+6Fc=;
        b=fH6rv8pQBhPPdBMM+hTJedp0+6Gt0gKm/FHACCgE9lj2hMMXm0cH9YJq8OP+0i+oXK1M/R
        CS6T/lia1pWQZpxXQTT4d6AWz08dG/83brQt8TwUFjWBMVB7OQ/xFnqrggwG5bAzIh36f1
        uo/YYOdoDk5Zb1wvsJcE+gKUwyt2DmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-p6hpPyObNz2Txf5tI2kXmQ-1; Tue, 25 Jan 2022 22:10:46 -0500
X-MC-Unique: p6hpPyObNz2Txf5tI2kXmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2AEC108088A;
        Wed, 26 Jan 2022 03:10:43 +0000 (UTC)
Received: from localhost (ovpn-12-215.pek2.redhat.com [10.72.12.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6ECE4E2C4;
        Wed, 26 Jan 2022 03:10:42 +0000 (UTC)
Date:   Wed, 26 Jan 2022 11:10:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, linux-doc@vger.kernel.org, vgoyal@redhat.com,
        stern@rowland.harvard.edu, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        halves@canonical.com, kernel@gpiccoli.net,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, mikelley@microsoft.com
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Message-ID: <20220126031039.GA26064@MiWiFi-R3L-srv>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <Yel8WQiBn/HNQN83@alley>
 <ccd9332e-2917-3020-3590-447fa660ff56@igalia.com>
 <20220122105514.GA18258@MiWiFi-R3L-srv>
 <20220123220711.44f1484c9b510eea8cda9c47@kernel.org>
 <20220124135902.GB8305@MiWiFi-R3L-srv>
 <ff3bc2cf-80bf-3bb0-0dcd-7f9cacdae45a@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff3bc2cf-80bf-3bb0-0dcd-7f9cacdae45a@igalia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/24/22 at 11:48am, Guilherme G. Piccoli wrote:
> On 24/01/2022 10:59, Baoquan He wrote:
> > [...]
> > About pre_dump, if the dump is crash dump, hope those pre_dump notifiers
> > will be executed under conditional check, e.g only if 'crash_kexec_post_notifiers'
> > is specified in kernel cmdline. 
> 
> Hi Baoquan, based on Petr's suggestion, I think pre_dump would be
> responsible for really *non-intrusive/non-risky* tasks and should be
> always executed in the panic path (before kdump), regardless of
> "crash_kexec_post_notifiers".
> 
> The idea is that the majority of the notifiers would be executed in the
> post_dump portion, and for that, we have the
> "crash_kexec_post_notifiers" conditional. I also suggest we have
> blacklist options (based on function names) for both notifiers, in order
> to make kdump issues debug easier.
> 
> Do you agree with that? Feel free to comment with suggestions!
> Cheers,

I would say "please NO" cautiously.

As Petr said, kdump mostly works only if people configure it correctly.
That's because we try best to switch to kdump kernel from the fragile
panicked kernel immediately. When we try to add anthing before the switching,
please consider carefully and ask if that adding is mandatory, otherwise
switching into kdump kernel may fail. If the answer is yes, the adding
is needed and welcomed. Othewise, any unnecessary action, including any
"non-intrusive/non-risky" tasks, would be unwelcomed.

Surely, we don't oppose the "non-intrusive/non-risky" or completely
"intrusive/risky" action adding before kdump kernel switching, with a
conditional limitation. When we handle customers' kdump support, we
explicitly declare we only support normal and default kdump operation.
If any action which is done before switching into kdump kernel is specified,
e.g panic_notifier, panic_print, they need take care of their own kdump
failure.

