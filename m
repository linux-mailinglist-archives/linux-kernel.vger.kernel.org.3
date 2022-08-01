Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF43586753
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiHAKYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiHAKYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:24:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDAA2FA;
        Mon,  1 Aug 2022 03:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BEB061160;
        Mon,  1 Aug 2022 10:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C783C433D6;
        Mon,  1 Aug 2022 10:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659349446;
        bh=aZ5KzaP2kedlbYW3tFmm//ddOrI7TYRpUXxPO9v7KlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2HFP7ZaVHaYxu0hQciwzi/nzE3T0b/0margR75eCj7z/YgWoMkoWtpvaRXw+MdyH
         M2BJA54FAtA5+FdsQS7oiDMNMmX6pTloBd6ojxseqdSeOn75NQ8XIn5M9qQPQVpzym
         LSaiQnkqo6Yd8rIz7Jx+xUtNddCy9WlbZfOfyoC4=
Date:   Mon, 1 Aug 2022 12:24:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Dipanjan Das <mail.dipanjan.das@gmail.com>,
        syzbot+c70d87ac1d001f29a058 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH v3] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
Message-ID: <Yuepw21SyLbWt9F+@kroah.com>
References: <20220728155121.12145-1-code@siddh.me>
 <18258c1d370.6c4bec7a269297.4170944235031209431@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18258c1d370.6c4bec7a269297.4170944235031209431@siddh.me>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Mon, Aug 01, 2022 at 03:04:33PM +0530, Siddh Raman Pant via Linux-kernel-mentees wrote:
> Hello Dipanjan,
> 
> It would be nice if you could test this patch and tell if it fixes the
> issue on v5.10, as you had reported it earlier.
> 
> Please apply the following commits before applying this patch:
> db8facfc9faf ("watch_queue, pipe: Free watchqueue state after clearing pipe ring")
> 353f7988dd84 ("watchqueue: make sure to serialize 'wqueue->defunct' properly")
> 
> I have tested locally on tag v5.10, using the reproducer available on
> syzkaller dashboard. The crash occurred when the patches weren't applied,
> and it no longer occurs after applying the three patches.

Trying anything on tag v5.10 is not a good test as that kernel is very
old and obsolete and over 15000 changes behind what the latest 5.10.y
kernel release has in it.

So trying it on v5.10.134 would be best.

thanks,

greg k-h
