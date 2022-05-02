Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68795516B6D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353537AbiEBHyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiEBHyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:54:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229042B253;
        Mon,  2 May 2022 00:50:48 -0700 (PDT)
Date:   Mon, 2 May 2022 09:50:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651477846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9YTwBIK9lAkbWBv23hCp719JHcqmc8JMf0hCdSYBc0c=;
        b=2M/sPU3//pAEsdX2cONt1/QyGpv7JUbznaFo3TL8EJYTKMi46YrGDl3WPIqBcwfCkHLBcp
        h42onsWI74tqZHpKXhtQxejKNdHatf0qwYrxCbwJ0373XSjpxnQY3IDFBO7kcms/g+tP7p
        pozCCrHyhYHHtBN8lYx4jD4N4vuVk60XqLqHTW2nH2BhG5SI6zTuRkaio4snddKj0FmbLY
        YNfLb49+1LRvo3Kg0P5oc4PPCrfN5BsoE1pRqZiZRfSCt6/yA4gVvyJVOhvpdrHFYR6r18
        cXXunTFGvBryM5xbKBRTif551R6v2RuvnKiU00cgzBgsRA97uVOyda/LJd53pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651477846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9YTwBIK9lAkbWBv23hCp719JHcqmc8JMf0hCdSYBc0c=;
        b=iKhJ9axWwZeRIT1UBVN+1JD11D9mG69F1hukRvMjdZiumE3VqDBinhkuZlzlhWxP3X35Ig
        O6Z7BX4CmlFo0NBQ==
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
Subject: Re: [PATCH v2 01/12] signal: Rename send_signal send_signal_locked
Message-ID: <Ym+NVG2kxgkaN3lb@linutronix.de>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <20220429214837.386518-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429214837.386518-1-ebiederm@xmission.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-29 16:48:26 [-0500], Eric W. Biederman wrote:
> Rename send_signal send_signal_locked and make to make

s@to make@@

> it usable outside of signal.c.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Sebastian
