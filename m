Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B2B5049F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 01:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiDQXFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 19:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiDQXFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 19:05:44 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9963918B14;
        Sun, 17 Apr 2022 16:03:01 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 04C069200B3; Mon, 18 Apr 2022 01:03:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id F40D492009C;
        Mon, 18 Apr 2022 00:03:00 +0100 (BST)
Date:   Mon, 18 Apr 2022 00:03:00 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH v3 1/2] serial: 8250: Fold EndRun device support
 into OxSemi Tornado code
In-Reply-To: <Ylk3Q6HyaN/5+97/@kroah.com>
Message-ID: <alpine.DEB.2.21.2204172341250.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203310114210.44113@angie.orcam.me.uk> <alpine.DEB.2.21.2203310121211.44113@angie.orcam.me.uk> <Ylk3Q6HyaN/5+97/@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022, Greg Kroah-Hartman wrote:

> > Remove redundant code then and factor out OxSemi Tornado device
> > detection.  Also correct the baud base like with commit 6cbe45d8ac93
> > ("serial: 8250: Correct the clock for OxSemi PCIe devices") for the
> > value of 3906250 rather than 4000000, obtained by dividing the 62.5MHz
> > clock input by the default oversampling rate of 16.  Finally move the
> > EndRun vendor:device ID to <linux/pci_ids.h>.
> 
> That's a lot of different things happening all the same commit.  Please
> break this out into one-patch-per-logical-change as is required.

 The baud base fix is completely swallowed by the next change for EndRun 
devices, but I guess someone may want to backport it on its own, however 
unlikely.

 I have posted v4 then with this change split off (and the other removed) 
as per your request.  I have also reconsidered the changes made in 2/2 and 
split it into three, so that drivers/tty/serial/8250/8250_port.c updates 
are separate and self-contained.

 In the course of the respin, I have realised exporting the ICR access
helpers caused a code generation regression, so I have removed the inline 
function specifier so as to let the compiler choose whether to inline the 
functions or not.  I have also realised that the change to the console 
restorer is actually a fix for a preexisting bug in handling of the AFE 
bit, so I have annotated the change accordingly.

 Thank you for your review.

  Maciej
