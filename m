Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F525AC494
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 15:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiIDNyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 09:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiIDNyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 09:54:08 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 37D683AE74
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 06:54:05 -0700 (PDT)
Received: (qmail 328391 invoked by uid 1000); 4 Sep 2022 09:54:04 -0400
Date:   Sun, 4 Sep 2022 09:54:04 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Rondreis <linhaoguo86@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: KASAN: use-after-free Read in configfs_composite_bind
Message-ID: <YxSt/OPYpd+cRp2d@rowland.harvard.edu>
References: <CAB7eexLHN1gn2QPdo1_PF70sPbo2cA8skwG17oZb7+J1DQ+J1Q@mail.gmail.com>
 <CAB7eexKGRgDWBLiRs=U70OPLREESi+bCgwt=7wWCESBDZDM=zQ@mail.gmail.com>
 <YxC7ix+MerW5xGsB@kroah.com>
 <CAB7eexK+x8+RZp16aJFmdmqqEL=NMYp+Fy+hAJG+CWUUEH1_fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB7eexK+x8+RZp16aJFmdmqqEL=NMYp+Fy+hAJG+CWUUEH1_fg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 09:21:07PM +0800, Rondreis wrote:
> Thanks for your reply! I ran the reproducer again on the master
> branch(commit id: 7726d4c3e60bfe206738894267414a5f10510f1a) and it
> didn't crash.
> 
> The reason for not using the latest version is I can't attach more
> than one gadget at a time using `configfs` and `dummy_hcd`. When I
> attach the second gadget with a different `udc` it always fails and
> the kernel message says:
> 
> ```
> [ 1625.254858] Error: Driver 'configfs-gadget' is already registered,
> aborting...
> [ 1625.271018] UDC core: g1: driver registration failed: -16
> ```
> 
> I'm not sure if this is a new feature from version v5.19(v5.18, commit
> id: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f works very well) or a
> potential bug, or my mistake...

It probably was introduced by a change I made.  One consequence of that 
change is that gadget drivers now must all have different names (as must 
drivers on any bus) -- but configfs uses the same name for all the 
drivers it registers: "configfs-gadget".

I had to adjust a couple of drivers to avoid this problem.  See for 
example commit f2d8c2606825 ("usb: gadget: Fix non-unique driver names 
in raw-gadget driver").  You could use that as a model for changing 
configfs.c.

Alan Stern
