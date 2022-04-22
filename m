Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8735750B8EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448139AbiDVNrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388465AbiDVNrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:47:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A88958E74
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:44:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25CCD620D4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E27C385A4;
        Fri, 22 Apr 2022 13:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650635051;
        bh=h7Ecm6MBAXN+s9MsujnvJUtmyfXyAIH8LNTgBqNYka4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nGMIJmBxeBZYmhUuOcxv9FL3/A5lAEqMseKDyEMox0CvEpb1i53+tIFpUtFeX2AJs
         N9zBTswiTuY9wl35PTkKRfTywkP34vv8WtRb1tqVdtJy2gMjQEZWqVXxot2Nnf9Qiz
         rUdZKCSR4PRLlqqyOaqzKeFaQgWFGwjQ9FFHn7K8=
Date:   Fri, 22 Apr 2022 15:44:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6IGC5rGf56OK?= <niejianglei2021@163.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: vt: consolemap: Add missing kfree() in
 con_do_clear_unimap()
Message-ID: <YmKxKS+ydekDWs5f@kroah.com>
References: <20220303020630.460257-1-niejianglei2021@163.com>
 <4a7fe3ca.68b6.17f6eacb952.Coremail.niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a7fe3ca.68b6.17f6eacb952.Coremail.niejianglei2021@163.com>
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

On Wed, Mar 09, 2022 at 08:34:47PM +0800, 聂江磊 wrote:
> I found this bug by using clang static analyse checkers. I found that function con_release_unimap() is only called in this file(drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c). There are totally 5 times that con_release_unimap() is called
> 
> (line 430, 466, 522, 599, 673) while con_release_unimap() is not followed by kfree() only in line 522. So I think it is a bug
> 
> and make this patch.

Given that we do not have any reports of this leaking memory, I do not
think your analysis is correct, so I am loath to apply this, sorry.

greg k-h
