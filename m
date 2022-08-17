Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D13859795F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242443AbiHQV5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241364AbiHQV5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:57:52 -0400
Received: from matoro.tk (unknown [IPv6:2600:1700:4b10:9d80::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A21AA4F1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:57:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; bh=yOKakIqHXCzZv31j5+n9zOkk3z3d5d3Q9bnca8uv+no=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20220801; t=1660773462; v=1; x=1661205462;
 b=waa3nn9Z2IABkYVlk43UMeRg1lCDp8Q/4glQ4TphrDMLmVlvG585ve+f0GMnVeN4mXiu+Qjo
 O7PcvN0STCnkmupFzGFM9ZIsfW5GYZ92NsEf5GXEQyTHv8LgcPNR7XeSxnVGQKeDoW+uq6L3+1y
 5OR2/BTABjVv/lAf7sKfSFd+RNZuK04WfDKL0QxGWFbibKR334HY5eqF+PTH6V7mlHDraJCNYh6
 lX6l4NO/6a1qMALhfRFhSEY4DeuSSATU+41uQOd8zoCdIYS+0mTzVquYa3ybUTkab3AWAvvyISu
 iwEJrgOJ3GTeskHFZFi4AIaZnFc1j5NAFeU3DHwzjM7RxadByveQ5WXsNXlM12cwBXlsQOCj/qf
 6cXI7QmqDrqZ969UE4LTvngOswSNfQJneuQiC/OHnGoZ8005bgz0QY9tK6oM6mCX22pKT8imD6j
 XBaEKnF98Lfxemu4AHhtfr10JFR8HHdzTm9f8YqHEB4CAxXnitjn6yvZlYr1BO7B8LIDm6/CS0j
 rSInf2lg7KtFm4ne04qNDiXLJHfpRraYeMXNxPs1MNlrj43lNDrrtHBJUBU/iXaql8cXrVWS2wT
 TTmtyr45bc6G3j3YYM5BI2KFzKTRbPFuwSjFzTKA/urCUVwYBJOOpkzVLPOlxQjSIQwAl5OGBYN
 tuIbcrx0ubo=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id 80adfee9; Wed, 17 Aug
 2022 17:57:42 -0400
MIME-Version: 1.0
Date:   Wed, 17 Aug 2022 17:57:42 -0400
From:   matoro <matoro_mailinglist_kernel@matoro.tk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergei Trofimovich <slyich@gmail.com>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] ia64: fix clock_getre(CLOCK_MONOTONIC) to report ITC
 frequency
In-Reply-To: <20220817122103.ecbd08bd545385e5bf8e0d72@linux-foundation.org>
References: <20220815054944.4130786-1-slyich@gmail.com>
 <20220817122103.ecbd08bd545385e5bf8e0d72@linux-foundation.org>
Message-ID: <6d07209d000b671a3bc48003905652e8@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, I came up with the prototype for this patch, but it was based 
entirely on Sergei's investigation which was documented in 
https://bugs.gentoo.org/596382.  I asked him to send it upstream because 
I'm unable to attach my realname to it due to my job.  I can place a 
signed-off-by with my handle but I understand that's normally against 
kernel policy which is why I didn't.  Either way the bulk of the work 
belongs to Sergei, I just scribbled it down, and he cleaned it up for 
this submission.

-------- Original Message --------
Subject: Re: [PATCH] ia64: fix clock_getre(CLOCK_MONOTONIC) to report 
ITC frequency
Date: 2022-08-17 15:21
 From: Andrew Morton <akpm@linux-foundation.org>
To: Sergei Trofimovich <slyich@gmail.com>

On Mon, 15 Aug 2022 06:49:44 +0100 Sergei Trofimovich <slyich@gmail.com> 
wrote:

> clock_gettime(CLOCK_MONOTONIC, &tp) is very precise on ia64 as it uses
> ITC (similar to rdtsc on x86). It's not quite a hrtimer as it is a few
> times slower than 1ns. Usually 2-3ns.
> 
> clock_getres(CLOCK_MONOTONIC, &res) never reflected that fact and
> reported 0.04s precision (1/HZ value).
> 
> In https://bugs.gentoo.org/596382 gstreamer's test suite failed loudly
> when it noticed precision discrepancy.
> 
> Before the change:
> 
>     clock_getres(CLOCK_MONOTONIC, &res) reported 250Hz precision.
> 
> After the change:
> 
>     clock_getres(CLOCK_MONOTONIC, &res) reports ITC (400Mhz) precision.
> 
> The patch is based on matoro's fix. It adds a bit of explanation why we
> need to special-case arch-specific clock_getres().
> 

It would be best (and nice) to include the original developer's
Signed-off-by: and to Cc Émeric Maschino if possible?

Could you please take care of these paperwork issues?
