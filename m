Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD17F52B582
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbiERI4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiERIzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:55:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC283134E1F
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:55:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652864138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UcxXOvDlY2eSV87H7dyKFcZrRDyg8Lk6SHYT9Da8KPE=;
        b=soOUlAjykXqqw5GqpV6bSf3DeibNHLnZ6JJhWS1tz0XWIkl95zBIzfxO/1jYTTkPn7OsfR
        h9KH72lIOoy5ev2WAbVGxhYEV0UHr2KAErgvAN1KPJxYGEZxGH25UrMY3en69mYTENKrPF
        NWMslFjnTkUxO1JgT9hmxu9kpizZF6w1xAd4mdoeZdgbFMLG+NU3pXV0jP5WByg8CYdCpV
        KttSXwYBw50EDz8AeuzTfGFM+0tvi6WSJgIQrTymJjyiCr/aHAqGL8lv66v1uPXQ+v2gh+
        MByCIiIZ5Z9+T7SHN/04HEYtfYgKKcFVcYqPX2LlBBbnHk8GNgi01h46MAMIqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652864138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UcxXOvDlY2eSV87H7dyKFcZrRDyg8Lk6SHYT9Da8KPE=;
        b=s8ytQ9+po5ZeGiw2qixlDDlIyKp3zZx4e06fhU3rnjk9Nc9yTZX0bFm6uZVRwGas7XFl9L
        D1ZwWtaL2qvHAZAw==
To:     Chao Liu <liuchao173@huawei.com>, linux-kernel@vger.kernel.org,
        hewenliang4@huawei.com
Cc:     steven.price@arm.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpu/hotplug: check the return value of idle_thread_get
In-Reply-To: <20230327203728.159123-1-liuchao173@huawei.com>
References: <20230327203728.159123-1-liuchao173@huawei.com>
Date:   Wed, 18 May 2022 10:55:37 +0200
Message-ID: <87leuzjk3a.ffs@tglx>
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

On Mon, Mar 27 2023 at 20:37, Chao Liu wrote:
> ilde may be ERR_PTR()

Yes, but if that happens in bringup_cpu() or finish_cpu() it would be a
serious bug and the error pointer dereference would be the least of the
problems.

If the initial check in _cpu_up() failed for a CPU then the above
functions cannot be invoked for that CPU ever.

Thanks,

        tglx
