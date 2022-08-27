Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2AF5A3396
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 03:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344880AbiH0Bne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 21:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiH0Bna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 21:43:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E96DEC4D7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:43:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F7F061CEB
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 01:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C968FC433D7;
        Sat, 27 Aug 2022 01:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661564609;
        bh=ZRrgfPWyUv61JlX8iDzy2PZiGjGRvRzl+FOAReOkttk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OHZOEdZr+3pm7ImsHzxQeWDoenMwByLK5b8Zm/YlaJS5271UR1A+xNersydHjlUmf
         MI1ICUUvwa/mumTeArajp/5smKe6mwi+1kXabJE/O+0FmnqOXQ+/npI5PwUOVX4YgW
         6SF2IwHvaK92VxJ1JnElSB8HB7RIUGcYhrSD752g=
Date:   Fri, 26 Aug 2022 18:43:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/3] mm/zswap: delay the initializaton of zswap
 until the first enablement
Message-Id: <20220826184328.3bce63050a1f82e9242580df@linux-foundation.org>
In-Reply-To: <YwksRZPIfXmlOmHR@dev-arch.thelio-3990X>
References: <20220825142037.3214152-1-liushixin2@huawei.com>
        <20220825142037.3214152-3-liushixin2@huawei.com>
        <YwksRZPIfXmlOmHR@dev-arch.thelio-3990X>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 13:25:41 -0700 Nathan Chancellor <nathan@kernel.org> wrote:

> Hi Liu,
> 
> On Thu, Aug 25, 2022 at 10:20:36PM +0800, Liu Shixin wrote:
> > In the initialization of zswap, about 18MB memory will be allocated for
> > zswap_pool in my machine. Since not all users use zswap, the memory may be
> > wasted. Save the memory for these users by delaying the initialization of
> > zswap to first enablement.
> > 
>
> ...
>
> This change is in -next as commit 22100432cf14 ("mm/zswap: delay the
> initializaton of zswap until the first enablement"). I just bisected my
> arm64 test system running Fedora failing to boot due to that commit,
> with the following stack trace:
> 

Thanks.  Sorry.  I dropped the series.
