Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16B957EF60
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbiGWOFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237328AbiGWOFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:05:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8EB1056E;
        Sat, 23 Jul 2022 07:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8951B614B5;
        Sat, 23 Jul 2022 14:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB10C341C0;
        Sat, 23 Jul 2022 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658585119;
        bh=2g5s13C+IFBQd9xKYRDH27YjqkKmXT8LzRfCOLtta2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3v6kDUyyoOc2RLrQEdcJh8KRxU32gs+RlKKkJNJwfOPCw15HDLg7JGAjZEBwurps
         b8J9KVbEGG17e9nIMXn8ePxKwEV4ltEUozC2FWRSXaaij1DESR8mv0o9sWx6ab0Gnu
         zM+H7htPngHmRGV50lkndYupXy/GGXV4nilXaVnI=
Date:   Sat, 23 Jul 2022 16:05:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        keyrings <keyrings@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] keys/keyctl: Use kfree_rcu instead of kfree
Message-ID: <YtwAHGISvlgXgXZM@kroah.com>
References: <20220723135035.199188-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723135035.199188-1-code@siddh.me>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 07:20:35PM +0530, Siddh Raman Pant via Linux-kernel-mentees wrote:
> In keyctl_watch_key, use kfree_rcu() for freeing watch and wlist
> as they support RCU and have an rcu_head in the struct definition.

That does not explain why this change is needed.  What problem does this
solve?  Why use RCU if you don't have to?  What functionality did you
just change in this commit and why?

And how was this tested?

thanks,

greg k-h
