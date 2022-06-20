Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8206550FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 07:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbiFTFRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 01:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiFTFRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 01:17:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C753DEDE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:17:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h34-20020a17090a29a500b001eb01527d9eso8345667pjd.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 22:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ye9oT+fVkuVusF1MJBuMtcEcRVtRSMFhDTuupOu+Yfk=;
        b=LVLBdqZIxPf6pahTqAsOnqMtTx51tkrRW2H/HUulK6nTKkAXDK948rOXo8MnE7jIVk
         guWB3bfOY85VN4WxGuV1OYLzLIquJOjr4AsqUVfg6mDm2dkhUXiv35T0SQ1hktrL2Cxo
         UrVscK3WTwvMCqbB/5g0h+6yp3upTpvww80dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ye9oT+fVkuVusF1MJBuMtcEcRVtRSMFhDTuupOu+Yfk=;
        b=QqT0WRDqDukey9KEwM4dgDX415iUF7U4BfsmF7l17IaWv5p8mbQsuIB9deQqUcxEMB
         ZadoCI7Oz5/DaJUpRSQVV847cq/tenC2dTuBCkcgTqM3R7crQUjfhe9l4E/A4n2lieiY
         5on77qWx5qcf0DvayPWLtCETVqiKauL0KZajPG7b8fyt0II3pHUMepKzyhuIQjuDd65R
         2DJodth9y1pL4OYRzqsIyEVDoBAVR9zAHN+KQ77kAnr5FYDUu1sc2zriDmwtlLr1x/jz
         mIT97tBwkHE5BwoMllJyElAbxOZ43EJp4TNe/K0p/nsgcEoZ1jOV2otKTM6WNRe8Q8jN
         I4HA==
X-Gm-Message-State: AJIora91BwOj4NvJg+RayZI7MYc6G4JVXD3qgll7drUfS6jYBbL/fJt5
        0TWTew4UpIBZ1yA/J4/8fCJDZA==
X-Google-Smtp-Source: AGRyM1tjTCxWUOyfbY0GuDMi3KpbLSCt8hOkcZNMtm7Aj8GITka2lds8VdXHgi+yJ5Eoe0uRk0D+qA==
X-Received: by 2002:a17:90b:1e0e:b0:1ec:ac5b:ddca with SMTP id pg14-20020a17090b1e0e00b001ecac5bddcamr2638119pjb.97.1655702262082;
        Sun, 19 Jun 2022 22:17:42 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:b60c:9d67:b219:6c6f])
        by smtp.gmail.com with ESMTPSA id jh20-20020a170903329400b00168b113f222sm2247472plb.173.2022.06.19.22.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 22:17:41 -0700 (PDT)
Date:   Mon, 20 Jun 2022 14:17:36 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] printk: allow direct console printing to be enabled
 always
Message-ID: <YrAC8F8lDc1JNkoq@google.com>
References: <Yq+Jjoyn/wj7yzeQ@zx2c4.com>
 <20220619204326.556923-1-Jason@zx2c4.com>
 <87letsw8en.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87letsw8en.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/06/20 01:23), John Ogness wrote:
> I'm wondering if we should output a message here. My suggestion is:
> 
> pr_info("printing threads disabled, using direct printing\n");
> 
> > +		return 0;
> > +
> >  	console_lock();
> >  	printk_kthreads_available = true;
> >  	for_each_console(con)
> 
> Otherwise it looks OK to me. But you may want to wait on a response from
> Petr, Sergey, or Steven before sending a v3. You are adding a kernel
> config and a boot argument. Both of these are sensitive topics that
> require more feedback from others.

A tricky situation. I think John already mentioned in another thread
that any such config/boot param potentially can become a default value
for some setups; at the same time, well, yeah, I see what commit message
talks about.

May I just dump some thoughts?

I guess user-space "[+] some userspace command" are write()-s to /dev/ttyX
which end up in uart circular buffer and which are printed from console
IRQ handler (where it handles both TX and RX)

	console_irq()
	{
		int count = XXX;

		spin lock irqsafe port->lock

		RX

		do {
			TX char from xmit->buf
		} while (--count);

		spin unlock irqrestore port->lock
	}

The "[    1.2345 ] some kernel log output" (which I assume are printed
by user-space from some syscall?) now take a much more lengthy path to
console and are always async/deferred.

I know that John and Petr (rightfully so) will hate what I'm about to
say, but would it make sense/be possible/etc. to look into possibility
to address that "deferred kthread vs IRQ" race by moving prb entries
emit to the same IRQ handler that emits chars from uart xmit buffer?
In other words:

	console_irq()
	{
		int count = XXX;

		spin lock irqsafe port->lock

		RX

		do {
			TX char from xmit->buf
		} while (--count);

+		count = XXX;
+		do {
+			console_emit_next_record();
+		} while (--count);

		spin unlock irqrestore port->lock
	}
