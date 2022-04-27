Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BDD511215
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbiD0HOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358622AbiD0HOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:14:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363EB3968B;
        Wed, 27 Apr 2022 00:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kBYXnZGelPUmL/h6ghNUjmmjkB82BgyHIdyq6pLu9pA=;
        t=1651043480; x=1652253080; b=aiwry/tJ+Bc7UlHbV5IEkmsM9vBuoZnt9LuEaiBk5okEae+
        kIMQYznz8NlcKWjsJbAs8axTsdNBsfLpVQnEefgHPhztJYvhS9ca20TsJjhexhQv66z9ZuB4chps3
        z+lc6A79zR+6toSg9+oMk46qQz9ydAD2EvpjvSV3xJaF+YDUQR3v5wIrd1Ji4+AvOwegTeimQmHhZ
        /piWbpa0FMN1BEw8zXC36dBjDWUcZv4Rt+vB0TvFdHPmQcGMyG1Z0hNuvswT5MvUGRUnGd2N2Jwxm
        QQBod+lCojG5h7vPzT530d9nRSL9wxewk7KqedX2dKkbexqcIP0vEZVt4efihJxg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1njbp2-00Fndk-U2;
        Wed, 27 Apr 2022 09:10:49 +0200
Message-ID: <f6d31801de631dfe6e1a2da25370cddf2aca32ad.camel@sipsolutions.net>
Subject: Re: [PATCH 3/9] ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        tj@kernel.org, linux-pm@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
Date:   Wed, 27 Apr 2022 09:10:47 +0200
In-Reply-To: <20220426225211.308418-3-ebiederm@xmission.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
         <20220426225211.308418-3-ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-26 at 17:52 -0500, Eric W. Biederman wrote:
> User mode linux is the last user of the PT_DTRACE flag.  Using the flag to indicate
> single stepping is a little confusing and worse changing tsk->ptrace without locking
> could potentionally cause problems.
> 
> So use a thread info flag with a better name instead of flag in tsk->ptrace.
> 
> Remove the definition PT_DTRACE as uml is the last user.


Looks fine to me.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

Looking at pending patches, I don't see any conflicts from this. I'm
guessing anyway you'll want/need to take these through some tree all
together.

johannes


