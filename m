Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD8521DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbiEJPM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346125AbiEJPLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:11:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678342AC0F1;
        Tue, 10 May 2022 07:45:19 -0700 (PDT)
Date:   Tue, 10 May 2022 16:45:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652193917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5blkjIedYuMCiqErNt15Eq65xE+zoCnwsx/3F3fRUQ8=;
        b=jXszJivvNglB8FP/v3gF3KwlzVs0dDzDmH1/cWD/Zy3cdPLh9I8DjDJZwprPIV+P5jvzEy
        xm+NGj8oUdQNAZGcrqWTv4+neGmzcCMwyZpJhgDdsnp3X47Bxugq4OqnvDph5Ou9eoljOV
        F5QRTSDBnFjkgu+fzG9vgfqcLk12/M5XMTw4w1QxaO+zx7VQrXVM60oYxGyY6ITBPiT7ac
        X24VJanYpx8dmh0ZkIwdpqKtmklxkZcMhQI5I/wl1fPsXGuJ53yqFGI+NNUIdzm3labKWi
        i3ZmLr8IwHR0bm+cqlY+0APMFY4+8Y7wrVxqNJZzyIWu0C03zqnS4fGAvBt77Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652193917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5blkjIedYuMCiqErNt15Eq65xE+zoCnwsx/3F3fRUQ8=;
        b=WEzshOP+DtQxpnpyZIVwNRSJAbEcKHWL7ofcB9TlTU5e8NmlPVtxeVq23+5gqbxWlEHFC3
        1TYWJVUuC1RJKMCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v4 0/12] ptrace: cleaning up ptrace_stop
Message-ID: <Ynp6fP8QkIGvUT1T@linutronix.de>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org>
 <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <20220510141119.GA23277@redhat.com>
 <87lev9xy3n.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lev9xy3n.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-10 09:26:36 [-0500], Eric W. Biederman wrote:
> Does anyone else have any comments on this patchset?
> 
> If not I am going to apply this to a branch and get it into linux-next.

Looks good I guess.
Be aware that there will be clash due to
   https://lore.kernel.org/all/1649240981-11024-3-git-send-email-yangtiezhu@loongson.cn/

which sits currently in -akpm.

> Eric

Sebastian
