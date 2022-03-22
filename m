Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6214E3DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiCVLdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbiCVLdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:33:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C110882D2C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:31:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AD6B612F5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27358C340F0;
        Tue, 22 Mar 2022 11:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647948696;
        bh=Q803Ahh2mXBrXYeT2gzMvlXoFBqdS/QQwfKfuZr72KE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j5C+iEKDhFncKyOkwb+7ZLqwnyfRKMuB/qf++cLRjNkSe1LI4aUDhEpKLMdiSSnqt
         bAOT/Xtxhe3i5Ae0hDn1jDLEW2RwcUuX5+Kqq0hVaS5rg8ojii9VkYsxTQlS/iv9R5
         rCD+qeLYUqng7rUXGu6WToL6doPELz0+V8fxgbYA=
Date:   Tue, 22 Mar 2022 12:31:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Sathish Kumar <skumark1902@gmail.com>, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8712: Fix CamelCase warnings
Message-ID: <YjmzlGZJaBxLljq2@kroah.com>
References: <20220318101440.13887-1-skumark1902@gmail.com>
 <YjRswrHu0JUm9331@kroah.com>
 <3a85ae64-00c1-6483-f1d7-c12abdd3ff3a@gmail.com>
 <1786742.atdPhlSkOF@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1786742.atdPhlSkOF@leap>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:42:21AM +0100, Fabio M. De Francesco wrote:
> On martedì 22 marzo 2022 05:30:29 CET Sathish Kumar wrote:
> > On 18/03/22 4:58 pm, Greg KH wrote:
> > > On Fri, Mar 18, 2022 at 03:44:40PM +0530, Sathish Kumar wrote:
> > >> This patch fixes the checkpatch.pl warnings like:
> > >> CHECK: Avoid CamelCase: <blnEnableRxFF0Filter>
> > >> +   u8 blnEnableRxFF0Filter;
> > >>
> > >> Signed-off-by: Sathish Kumar <skumark1902@gmail.com>
> > >> ---
> > >> Changes in v2:
> > >>      - Remove the "bln" prefix
> > >> ---
> > >>   drivers/staging/rtl8712/drv_types.h   | 2 +-
> > >>   drivers/staging/rtl8712/rtl871x_cmd.c | 2 +-
> > >>   drivers/staging/rtl8712/xmit_linux.c  | 4 ++--
> > >>   3 files changed, 4 insertions(+), 4 deletions(-)
> > >>
> > >> [...]
> > >>
> > >>   	do {
> > >>   		msleep(100);
> > >> -	} while (adapter->blnEnableRxFF0Filter == 1);
> > >> +	} while (adapter->enable_rx_ff0_filter == 1);
> > > Ah, that's funny.  It's amazing it works at all and that the compiler
> > > doesn't optimize this away.  This isn't a good pattern to use in kernel
> > Do you mean the following code is not a good pattern in kernel?
> > do {
> > msleep();
> > } while(condition);
> 
> Exactly, this is not a pattern that works as you expect :)
> 
> I was waiting for Greg to detail something more about this subject but, 
> since it looks like he has no time yet to respond, I'll try to interpret 
> his words.
> 
> (@Greg, please forgive me if I saying something different from what you
> intended to convey :)).
> 
> The reason why this pattern does not work as expected is too long to be
> explained here. However, I think that Greg is suggesting to you to research
> and use what are called "Condition variables".

Kind of.  The problem is that "condition" here is just looking at a
random variable.  There is no sort of assurance that the variable will
actually change or that that compiler even has to read from memory for
it.  It could cache the value the first time it is read and then never
update it for the whole loop logic.

Please read Documentation/memory-barriers.txt for how to fix this all up
and do it properly.

Again, it's amazing that the current code even works at all.  So maybe
it doesn't!  :)

thansks,

greg k-h
