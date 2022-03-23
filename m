Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CD84E533A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244338AbiCWNiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244315AbiCWNiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:38:00 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CC7532F6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:36:30 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.71.26])
        by gnuweeb.org (Postfix) with ESMTPSA id C015B7E34E;
        Wed, 23 Mar 2022 13:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648042589;
        bh=kspSnS46lZV734KbQIo5pA/i92KsQL/tiG1+/s6yn7Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kcSf8zofG1Ae79QbZtwwD1xaWjFxENfn05JIUSat/GpbIDrcZpefOB5w0UdBHIjyY
         AUZfewatYsqEK5iDgtC3n6tYRSaVvh6pWu9Jl+5S5rfJsoKCKiduRIg/GOeIMoB9i4
         CR+Z/iIA3YkGdzRRk9N08+dnD+TY57RkDPXmJJ93kA+/AnHMmBBsUXU2Yv+oYfbfCt
         g9I06f6kEGBTEax4PMXUq3dmVajI0+qA52D9WMXBWfFm+fc2aeH0DyRhXU0p7eBfdg
         lnUcHP6nBKcW7VZxLlM8TX0rhd5gT8o6JRfJCiEVNNmGcZfCdzV+2WgeqjbekNLxTr
         H1T00RpGk1Zsw==
Message-ID: <5b611ae8-aca6-71c1-6a86-6234f61f1608@gnuweeb.org>
Date:   Wed, 23 Mar 2022 20:36:24 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] tools/nolibc/stdlib: only reference the external
 environ when inlined
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>, "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20220323071807.14413-1-w@1wt.eu>
 <20220323071807.14413-3-w@1wt.eu>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220323071807.14413-3-w@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/22 2:18 PM, Willy Tarreau wrote:
> When building with gcc at -O0 we're seeing link errors due to the
> "environ" variable being referenced by getenv(). The problem is that
> at -O0 gcc will not inline getenv() and will not drop the external
> reference. One solution would be to locally declare the variable as
> weak, but then it would appear in all programs even those not using
> it, and would be confusing to users of getenv() who would forget to
> set environ to envp.
> 
> An alternate approach used in this patch consists in always inlining
> the outer part of getenv() that references this extern so that it's
> always dropped when not used. The biggest part of the function was
> now moved to a new function called _getenv() that's still not inlined
> by default.
> 
> Reported-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---

This one works nicely. I will resend my previous RFC after this one
lands in Paul's tree to avoid conflict.

Tested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Thanks!

-- 
Ammar Faizi
