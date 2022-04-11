Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708DD4FC638
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349944AbiDKVA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbiDKVA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:00:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFF325295;
        Mon, 11 Apr 2022 13:58:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649710718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y9TgkPsl7PyK9/9vchpS586Qdh2s6nbjRZCiEVa2GjI=;
        b=Tkj8hb6wjt489YfOjb1WKjifuBNaX7h9jgYodPxy0Cghih4P3z7/3m+qloNvSJkvKwpGc+
        crmTOCmX5tIP6tWMDxno1pfIweHHzQD/IL2n7ZXXbBhe7WJHWEZ9gltK8mGyY0LpW21em8
        sA8i9Ir5ew6JsMnVdqv89K8zG44tAcvYw8aa7noFfsQh14868trqSElYzgqWvxZm8sqcZV
        lOJKJBdSrJIKdLbH9Nin4SG5qSrvazDaskDqKaTQY7p+sBn2GpOMhXfbxxGm4kpC2+zakC
        ss88EhM5Mgo/6DpVIY+VZR+NT7OvE8atgYPGE9BswVm+9C8WyR7uiXq6Tdljgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649710718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y9TgkPsl7PyK9/9vchpS586Qdh2s6nbjRZCiEVa2GjI=;
        b=hwefFdMZwEuMJZZ27Jxd1Z6uB5hkk5DyvCT2yo+o7TZy24X3gEFEGjz8FKO8ofxk+jTrfN
        DFU2un8L7G14IVCw==
To:     Steven Rostedt <rostedt@goodmis.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] timekeeping: Introduce fast accessor to clock tai
In-Reply-To: <871qy6hu8q.ffs@tglx>
References: <20220409081300.4762-1-kurt@linutronix.de>
 <20220409081300.4762-2-kurt@linutronix.de>
 <20220409093727.7dda6371@rorschach.local.home> <871qy6hu8q.ffs@tglx>
Date:   Mon, 11 Apr 2022 22:58:37 +0200
Message-ID: <87k0bvfibm.ffs@tglx>
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

On Sat, Apr 09 2022 at 22:33, Thomas Gleixner wrote:
> On Sat, Apr 09 2022 at 09:37, Steven Rostedt wrote:
>> On Sat,  9 Apr 2022 10:12:58 +0200
>> Kurt Kanzenbach <kurt@linutronix.de> wrote:
>>
>>> ---
>>>  include/linux/timekeeping.h |  1 +
>>>  kernel/time/timekeeping.c   | 17 +++++++++++++++++
>>>  2 files changed, 18 insertions(+)
>>
>> If the time keeping folks are OK with this and ack it, I'm happy to
>> take this through my tree.
>
> Go ahead. I just sent a Reviewed-by and I don't see conflicting changes
> in that area. Famous last words :)

And yes, I have some conflicting changes in the pipeline and just saw
that this lacks a data_race() annotation like the boot variant from
which this is derived.

Let me pick this up into a rc2 based branch. I'll tag it and provide it
to you for consumption.

Thanks,

        tglx
