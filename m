Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2F1516B7F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383614AbiEBIB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383621AbiEBIBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:01:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0615E2C674;
        Mon,  2 May 2022 00:58:23 -0700 (PDT)
Date:   Mon, 2 May 2022 09:58:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651478301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=40HIHqjULj7b9BBWanQBtKhj+DqOWd6zjF1ZGpV3jJs=;
        b=3+yDNLPVuk6Nnbmj///eGm1fshWeR5tBgWbYbGGvcbj87D9zxhmQRP4Ntt6SwoAg1er8EY
        q+P8EsMWWSgFGHW169ewpH/Txt5aCDYfgvilbcj4IQ268+4/UpzvfVnJI94rjAT0vsPPQl
        O/vnr3Gn84ysELjY8f1YvootIjFOc8lJwLVw1X5oieoXLDdEHuvuMwY14Ic9/BBbl3i0ew
        Rtx0BB/yeCZBRuG0/CfWa+elT+n942Jf0jQpSDorymjE0tFSWyLk/+Ay53oaAa4aMdSH+Y
        zBWKm2hXz4VesoA3zUtXfiqs5P1UkCrLKmT++cycufWuxSmwKMTn2Ciq5UB+yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651478301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=40HIHqjULj7b9BBWanQBtKhj+DqOWd6zjF1ZGpV3jJs=;
        b=foW1BVHDKV8C6erKOmaeyl+gnXeoQ/59yY2ELW717UAKKcgPOnPAhm2/kKrTDWsDIMGMyj
        dsPQnMxO9BjKoTCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v2 02/12] signal: Replace __group_send_sig_info with
 send_signal_locked
Message-ID: <Ym+PG/5Ro/v3nJUR@linutronix.de>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <20220429214837.386518-2-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429214837.386518-2-ebiederm@xmission.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-29 16:48:27 [-0500], Eric W. Biederman wrote:
> The function send_signal_locked does more than __group_send_sig_info so
> replace it.

This might be easier to understand:
   __group_send_sig_info() is just a wrapper around send_signal_locked()
   with a special pid_type. 
   
   Replace __group_send_sig_info() with send_signal_locked(,,,
   PIDTYPE_TGID).

However, keep it as is if you feel otherwise ;)

> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Sebastian
