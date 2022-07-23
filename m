Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBF957EFC3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbiGWOgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbiGWOgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:36:09 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F4EDF44;
        Sat, 23 Jul 2022 07:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658586938; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=P14KMg7Zc246bVkhisdefrW6lxfNpldYDDzSVYqK0RNGk9phCJMo14SjMus4YHD71M+5L2KIkmKCotIBvpC75T1AV0i/xtcICFJGXTWecTOBXJJ1dF/pG8KgRV7i1n/G/MOCTYB3TdJ09BvyjejLMcRnvVEubEF7XMSqSBdlUvc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658586938; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=+F8VEZ1Z9Pj1QEwW5vQk6MFoPQK/TpHHEams4IFBR5o=; 
        b=FxX9ttl/jntH3qcSUk2myZJl+keN4fVeE4RmdRYUXjqmBShsPp5xdWWBJO8yV7vMbAQuVqi7IPRVCQSdDEspii/9GPc30fxqNgmvcYD6QR4ZtlanEvi32HmoflggMi5YW4yZpa1aKalHoe4nLyMSQbg9FqmEws7cx0Q9V+2qtSA=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658586938;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=+F8VEZ1Z9Pj1QEwW5vQk6MFoPQK/TpHHEams4IFBR5o=;
        b=KbKtqbecy0QVLwF36Avuvq0fq3nBQzaO+KqXMun669P08qJxDt7fvskseBUZ4R7t
        cTs6071CJGosVhZvQ8XdOnOXoaVh2LQncYcURGrR/WZQY3cuz8PAOwLIH98iv85dnFb
        VFUYNXf4lA5olE3VDQVY+gjJ0JHKYPDTkaOu+WPU=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 165858692779635.69655596083135; Sat, 23 Jul 2022 20:05:27 +0530 (IST)
Date:   Sat, 23 Jul 2022 20:05:27 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     "David Howells" <dhowells@redhat.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "keyrings" <keyrings@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1822b7c129a.14411444236159.6380883938307880248@siddh.me>
In-Reply-To: <YtwAHGISvlgXgXZM@kroah.com>
References: <20220723135035.199188-1-code@siddh.me> <YtwAHGISvlgXgXZM@kroah.com>
Subject: Re: [PATCH] keys/keyctl: Use kfree_rcu instead of kfree
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2022 19:35:16 +0530  Greg KH <gregkh@linuxfoundation.org> wrote:
> That does not explain why this change is needed.  What problem does this
> solve?  Why use RCU if you don't have to?  What functionality did you
> just change in this commit and why?

We can avoid a race condition wherein some process tries to access them while
they are being freed. For instance, the comment on `watch_queue_clear()` also
states that:
        /*
         * Remove all the watches that are contributory to a queue.  This has the
         * potential to race with removal of the watches by the destruction of the
         * objects being watched or with the distribution of notifications.
         */
And an RCU read critical section is initiated in that function, so we should
use kfree_rcu() to not unintentionally free it while it is in the critical
section.

> And how was this tested?

It compiles locally for me, and I used syzbot on this along with testing the
other `watch_queue_clear` patch, which generated no errors.

Thanks,
Siddh
