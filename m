Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E7650E998
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244975AbiDYTkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbiDYTks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:40:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A8B111153
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:37:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650915462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kmfq8fzVoEHC3SLS8iOyzMnfjBRDrka13gMWgVL1LSo=;
        b=XHzJHtJAhv5AM/TDaBJdYPi+iUnnHuIlPazyyRW5+P1oAN/MIgmHiVO9Vy/b2yK43im1o3
        3w0/mq/K3uvDuVs2pIkUWkgA1puDPY1xDejfLrgZy73KVOvgrF3YyDstlp+b0S/aYRi7VI
        4vH3MFFG7hKP05o2fwwM5NMXRS5yVEOGNgI/aIteuNwsI0Z7xLGATgf106+Y72E9YbqMs+
        RmgUPcrCn0p2vF53qg3+ZjsLRS1SN1SwFaI13x+/bvF4FMU6wbcyPl6tiI2FWiD46WTYQv
        3OQ6r/58Wt3lSlrDOT0y0sJEbxGY/BHhjvjkfUMj0gEtTIsTMjy5Y5Wzm+Q5Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650915462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kmfq8fzVoEHC3SLS8iOyzMnfjBRDrka13gMWgVL1LSo=;
        b=lh5hgOI59S4pn6X/KYSmqpxbOYHkPq0C7iK5XCXqJ6CuvBZm07XAQzRDWVxwVq4UHf0FBa
        nLrieppdwqWn0eCg==
To:     Johannes Berg <johannes@sipsolutions.net>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 ] devcoredump : Serialize devcd_del work
In-Reply-To: <8186de033c87f0cdec296ae272a72c5b9a2880a3.camel@sipsolutions.net>
References: <87levt14kn.ffs@tglx>
 <8186de033c87f0cdec296ae272a72c5b9a2880a3.camel@sipsolutions.net>
Date:   Mon, 25 Apr 2022 21:37:41 +0200
Message-ID: <878rrt0xa2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc+: Kees

On Mon, Apr 25 2022 at 19:19, Johannes Berg wrote:
> On Mon, 2022-04-25 at 19:00 +0200, Thomas Gleixner wrote:
>> 
>> Johannes, can you please explain whether this immediate flush in
>> disabled_store() is really required and if so, why?
>> 
> I don't really know, as I remember that requirement (or maybe even code,
> not sure) came from Kees, who needed the lockdown.
>
> Given the use case (ChromeOS?) I'm not sure I see a need to flush all of
> them, since I guess a typical system would set the lockdown early in
> boot and hopefully not have a crash-dump around already.
>
> That said, I don't think the diagram you made works - fn() during the
> iteration is guaranteed to be invoked with a reference of its own, so
> the put_device() there can't be the last reference, only as fn() returns
> you'd put the last reference *there*, freeing it.

Bah, you are right, it's magically protected by the klist ref, which
prevents devcd from going away. Damned obvious.

This really needs comments why this all can magically "work".

Thanks,

        tglx




