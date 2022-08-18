Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB94D59885C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbiHRQI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiHRQIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:08:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8621764C2;
        Thu, 18 Aug 2022 09:08:19 -0700 (PDT)
Date:   Thu, 18 Aug 2022 18:08:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660838898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WSEnY9Oyyc/p4us4LuxFbzYZ43B4fny9FnSWnDSoyqc=;
        b=oZeZEF4rcv1sm1g9R7AUQW4/GoeFNvk+H4Nbb8oBcZ6DixvGOm9627O5/LtVGhVpqG5jl6
        pHo2zOIm1BC5jvbWEmCGYukgr/ukL4Dqmgh1UjJxSLXQ/GTK7JnauJlfRZxfDCSYHBsTdi
        DjqbmXgrxYGBP/jkfuzeI69cgKFlshbyUMcrv7dBbbxaoQ4lhliI+5rwNEwjgjn2BQ7tdP
        Ig0LD9Hj9mQTVOEsVc0LlmIXNwkSZhH9A9EqwXOTm0SpKnPxULTwE79k56F+InhGM42rlo
        KbXvFIjLvtiDx/SMJKPVasl1dOzcdUUCYh/+HodsaMZegKZuwmjZyHt0HVcDmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660838898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WSEnY9Oyyc/p4us4LuxFbzYZ43B4fny9FnSWnDSoyqc=;
        b=frcnYRt+bgC2hvQ50FFQr9kw8qXuVYqCAk4HBBQep5msKjngWfB641mmvDqndJx33Wju9g
        8WOCRprK+BZ6YzAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Mark Gross <markgross@kernel.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux RT users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT BUG] Mismatched get_uid/free_uid usage in signals in some
 rts (2nd try)
Message-ID: <Yv5j8NQ72KXu60nL@linutronix.de>
References: <VI1PR09MB358214376379A2D6B024A689A0B39@VI1PR09MB3582.eurprd09.prod.outlook.com>
 <YrXtH1z2JSmwLS7W@T470>
 <20220624184431.GA4386@zipoli.concurrent-rt.com>
 <20220626123019.GA51149@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220626123019.GA51149@zipoli.concurrent-rt.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-26 08:30:19 [-0400], Joe Korty wrote:
> Hi Mark,
> Absent an actual test of your port of a99e09659e6c to 4.9-rt, I just
> eye-verified that the change it makes to sigqueue_free_current looks
> correct.  In detail,
> 
>   matches the same change the Linus patch makes to __sigqueue_free (ie,
>   to the routine that sigqueue_free_current is a copy of).
> 
>   That the new variable 'up', in sigqueue_free_current, is being used
>   in the patch (some variants of this fix do not have 'up'), and that
>   variable is present in 4.9's version of sigqueue_free_current.
>   
>   That atomic_dec_and_test, rather than the refcounting version of that
>   some function, is being used (some versions of this patch are refcounted
>   instead).

What is the status here? Is this still needed?

> Regards,
> Joe

Sebastian
