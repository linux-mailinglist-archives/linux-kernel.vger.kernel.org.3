Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57F8572DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiGMGGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGMGGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:06:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F00AAE543
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:06:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DDB461ADA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF03C34114;
        Wed, 13 Jul 2022 06:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657692365;
        bh=dzm77fEEnjGbL+Mhdkf9rTXSRCDs1doi0Qc7/nfiyNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kafTMeUehalTQFMB+NMQSv2ybE8kBufq3Ctx6OwBSOrBUfXkttF5QtFlwlbCfRh6D
         FQns6dlzFsgRb1LiLqO832Gtqt/ocmM4VzTi9b8vnLU5coASiuM+moxHP5eYqP/X1L
         kK7A/gZVqJryT4v+anGf8BuFxop/zR1NGzG0TTl4=
Date:   Wed, 13 Jul 2022 08:06:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] drivers/base/node.c: fix userspace break from using
 bin_attributes for cpumap and cpulist
Message-ID: <Ys5gyqMqB/TW6ftv@kroah.com>
References: <20220712214301.809967-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712214301.809967-1-pauld@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 05:43:01PM -0400, Phil Auld wrote:
> Using bin_attributes with a 0 size causes fstat and friends to return that 0 size.
> This breaks userspace code that retrieves the size before reading the file. Rather
> than reverting 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size
> limitation of cpumap ABI") let's put in a size value at compile time. Use direct
> comparison and a worst-case maximum to ensure compile time constants. For cpulist the 
> max is on the order of NR_CPUS * (ceil(log10(NR_CPUS)) + 1) which for 8192 is 40960. 
> In order to get near that you'd need a system with every other CPU on one node or 
> something similar. e.g. (0,2,4,... 1024,1026...). We set it to a min of PAGE_SIZE 
> to retain the older behavior. For cpumap, PAGE_SIZE is plenty big.

Does userspace care about that size, or can we just put any value in
there and it will be ok?  How about just returning to the original
PAGE_SIZE value to keep things looking identical, will userspace not
read more than that size from the file then?

> On an 80 cpu 4-node sytem (NR_CPUS == 8192)

We have systems running Linux with many more cpus than that, and your
company knows this :)

thanks,

greg k-h
