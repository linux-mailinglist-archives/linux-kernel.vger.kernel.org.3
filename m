Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FDB55094A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 10:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiFSIPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 04:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiFSIPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 04:15:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB466E036
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 01:15:39 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655626537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ozKBpCxlc961tRoJYmZ9NNhV2JVRg4NLegnLO9GahaU=;
        b=ZV89nUrNMAAbCeTJvDQkH6C/WptgNIESkT/FkozD0pJDaDohYwx4M5h4MkWB4jQf8pfAxR
        ZCm3LZjk45cmVGD3XA3XCzBxwQp5lI0b+WME+Hi7EvJ93vSi3r1cojBQCZ3f7QsomGBz8J
        h5tFj2MEn/4yQaG7MMbkP32vv8Hrts4f9epeKXQkeN/fzWdrjCa6iJFsYlgLMeYuzJNj2h
        u7nJAFNvofpFoZ+6QR7YrZMgBUMM1Voz1p4rxnhkT3N4XG5EA1Cnov+tvGduQfj0Tz6oyd
        lgOlFCoLqbfMWnSvCFA8B2M9RFNxbpWUg6ThqlwegvxvfXZufQLuLlA6eA7g7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655626537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ozKBpCxlc961tRoJYmZ9NNhV2JVRg4NLegnLO9GahaU=;
        b=XkkUUc83Akog3zhpHcrLAcVJO1hEzToYOqdXAnAx7y4aOy56jzbwnmp3iCs0UTMTaWj0tZ
        P4+DxT01DjOsLiAQ==
To:     David Laight <David.Laight@ACULAB.COM>,
        'Petr Mladek' <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: 5.19 printk breaks message ordering
In-Reply-To: <a35dc47eb9924d56bb6dca7868c34c94@AcuMS.aculab.com>
References: <YqyANveL50uxupfQ@zx2c4.com> <YqyN20jpRw1SaaTw@alley>
 <a35dc47eb9924d56bb6dca7868c34c94@AcuMS.aculab.com>
Date:   Sun, 19 Jun 2022 10:21:37 +0206
Message-ID: <87edzlrrva.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-17, David Laight <David.Laight@ACULAB.COM> wrote:
> What priority do these kthreads run at?

120 (SCHED_OTHER, nice=0)

> I'd have thought they ought to run at a high priority?
> That should tend to give kernel messages priority over user ones.
>
> Quite how high is another matter.
> Probably a bit below the RT/FIFO:50 of threaded ISR.

As a default value, I recommend keeping to the SCHED_OTHER policy as a
default. Perhaps a nice value of -20? There are quite a few kernel
threads using that as their default:

# ps -Leo ni,command | grep ^-20 | sort
-20 [acpi_thermal_pm]
-20 [ata_sff]
-20 [blkcg_punt_bio]
-20 [cfg80211]
-20 [inet_frag_wq]
-20 [ipv6_addrconf]
-20 [kblockd]
-20 [kworker/0:0H-events_highpri]
-20 [kworker/0:1H-events_highpri]
-20 [md]
-20 [mld]
-20 [mm_percpu_wq]
-20 [netns]
-20 [nfsiod]
-20 [rcu_gp]
-20 [rcu_par_gp]
-20 [rpciod]
-20 [scsi_tmf_0]
-20 [scsi_tmf_1]
-20 [writeback]
-20 [xprtiod]

John Ogness
