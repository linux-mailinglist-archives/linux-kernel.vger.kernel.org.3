Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2B154C2C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346853AbiFOHlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243125AbiFOHlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:41:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCA03D1E0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12825B81C6F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74159C34115;
        Wed, 15 Jun 2022 07:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655278870;
        bh=Ha9BSiQXox2PfpxcDFD0A0nYSDvHgZn3nzqMn97d1VY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JefCOJN94QTLTZFrle1CmDPK/+MjXLb5cEoxCuEiXKGbUVJknrg5qCUM6akFSc5um
         INfHdj24N5yl0LiD4E5cNgFjvoE/ro5ucYsMT4G00c8TPQyZqbyF4HIjnIKStCwTU2
         NhwZz1d7lVixYCPX9Xzqup3wn9N7OyUpwplGh9wU=
Date:   Wed, 15 Jun 2022 08:19:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chi wu <wuchi.zero@gmail.com>
Cc:     alexios.zavras@intel.com, allison@lohutok.net, armijn@tjaldur.nl,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/klist: Remove mb() before wake_up_process
Message-ID: <Yql57cL4aFbnykfL@kroah.com>
References: <20220614144443.6566-1-wuchi.zero@gmail.com>
 <YqiiC+4xES0DoV7X@kroah.com>
 <CA+tQmHAJbqDenRE47OacSurF5HZ-XWHu6dRBf+A=UqbhiLomAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+tQmHAJbqDenRE47OacSurF5HZ-XWHu6dRBf+A=UqbhiLomAA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:30:51AM +0800, chi wu wrote:
> Greg KH <gregkh@linuxfoundation.org> 于2022年6月14日周二 22:58写道：
> >
> > On Tue, Jun 14, 2022 at 10:44:43PM +0800, wuchi wrote:
> > > Function wake_up_process always executes a general memory barrier,
> > > so remove the mb() before it.
> >
> > Really?  On all systems?  I do not see that, where does it happen?
> >
> As I understand it, it is on all systems.  Please help correct the
> mistake, thanks.
> 
> 1. Follow  Documentation/memory-barriers.txt  line 2128 ~ 2278,
> especially line 2187 ~ 2202 snippet:
>         A general memory barrier is executed by wake_up() if it wakes
> something up.
>         If it doesn't wake anything up then a memory barrier may or may not be
>         executed; you must not rely on it.

So as the documentation states, it might not be there, so if you have to
have a memory barrier, you must not rely on this function to provide it.

So unless you have testing proof otherwise, the code should be correct
as-is.

thanks,

greg k-h
