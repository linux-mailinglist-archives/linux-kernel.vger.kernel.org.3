Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E5557EFCF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiGWOu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiGWOuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:50:54 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4732E111B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1658587851;
        bh=rdXu9LN/zAdNX0uOk+wFkFqFAj3SIkSwTTiQs3IjqvQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=VffJB7MlpUC4ZDSW4HI075M4hgSq6XZbAusnUaKXWfrVDZ2tXtxmJgwqfYWTzzOjc
         iM5qmHBmLY6uWrhswXWgyDoYowFmMJHYZPQymLJgwJDrClidXLbz7HNv7rPjf4QhRq
         IauO8NssFtEJlgzKkvXAbR78fRoQwvlaQUPI5pUI=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 90EA91281845;
        Sat, 23 Jul 2022 10:50:51 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JVY4S5aeAk8F; Sat, 23 Jul 2022 10:50:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1658587851;
        bh=rdXu9LN/zAdNX0uOk+wFkFqFAj3SIkSwTTiQs3IjqvQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=VffJB7MlpUC4ZDSW4HI075M4hgSq6XZbAusnUaKXWfrVDZ2tXtxmJgwqfYWTzzOjc
         iM5qmHBmLY6uWrhswXWgyDoYowFmMJHYZPQymLJgwJDrClidXLbz7HNv7rPjf4QhRq
         IauO8NssFtEJlgzKkvXAbR78fRoQwvlaQUPI5pUI=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 85F79128182C;
        Sat, 23 Jul 2022 10:50:50 -0400 (EDT)
Message-ID: <f58c2c8a157714e1860caee9bb005ec469ddb72e.camel@HansenPartnership.com>
Subject: Re: [PATCH] keys/keyctl: Use kfree_rcu instead of kfree
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Siddh Raman Pant <code@siddh.me>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        keyrings <keyrings@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 23 Jul 2022 10:50:49 -0400
In-Reply-To: <1822b7c129a.14411444236159.6380883938307880248@siddh.me>
References: <20220723135035.199188-1-code@siddh.me>
         <YtwAHGISvlgXgXZM@kroah.com>
         <1822b7c129a.14411444236159.6380883938307880248@siddh.me>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-23 at 20:05 +0530, Siddh Raman Pant wrote:
> On Sat, 23 Jul 2022 19:35:16 +0530  Greg KH <
> gregkh@linuxfoundation.org> wrote:
> > That does not explain why this change is needed.  What problem does
> > this solve?  Why use RCU if you don't have to?  What functionality
> > did you just change in this commit and why?
> 
> We can avoid a race condition wherein some process tries to access
> them while they are being freed. For instance, the comment on
> `watch_queue_clear()` also states that:
>         /*
>          * Remove all the watches that are contributory to a
> queue.  This has the
>          * potential to race with removal of the watches by the
> destruction of the
>          * objects being watched or with the distribution of
> notifications.
>          */
> And an RCU read critical section is initiated in that function, so we
> should use kfree_rcu() to not unintentionally free it while it is in
> the critical section.

That doesn't apply in this case, does it?  watch and wlist are locally
allocated and neither has been made externally visible if the error leg
is taken, so they should just be locally freed, which is what the code
was doing before this proposed patch.

James


