Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D008568EC6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiGFQNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiGFQN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:13:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9521111
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EDC3B81A99
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4539C3411C;
        Wed,  6 Jul 2022 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657124006;
        bh=LA1VOdK5ORMoU+ewAB2GaJidmodmb2eFm76yDvl9Yo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W31t8Uh5Qnw6yELg57p4gOOOxvDnB0kHkcoTzmetYEh7N0irUK2SErFHh0QgM6RoZ
         jnmwmDT4YuuBtyd1qMluR0dkX2VzqErJgrgJ7SUNuqiMihrkbDQ5ZVIIW5hd1KVxeA
         snOohjfx6i5tQMOnUDutgcFi8zUpe9rHaXWqkqnEz8V8paX4zneI3ue0dafdsrEkaT
         4H0cPByYmx95x/eJvEoBdz4V/mwkS1IKzcJa2t9sQao2YY4TUgLLD7sl9ADeYFpfNg
         xroPQecRzIK8PvexI67SBvSi3ra+NBCa1lfkW1N12qvHSULQQ7ijuBvuO0rjdooS8H
         GV7o0cu9Ws3EQ==
Date:   Wed, 6 Jul 2022 10:13:22 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix nvme_setup_command metadata trace event for
 cdw10
Message-ID: <YsW0orMaDFfrHbx+@kbusch-mbp.dhcp.thefacebook.com>
References: <1657095398-114310-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1657095398-114310-1-git-send-email-john.garry@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 04:16:38PM +0800, John Garry wrote:
> For x86_64 allmodconfig I get this warning:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘perf_trace_nvme_setup_cmd’ at drivers/nvme/host/./trace.h:47:1:
> ./include/linux/fortify-string.h:352:4: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror]
>     __read_overflow2_field(q_size_field, size);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘trace_event_raw_event_nvme_setup_cmd’ at drivers/nvme/host/./trace.h:47:1:
> ./include/linux/fortify-string.h:352:4: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror]
>     __read_overflow2_field(q_size_field, size);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> cdw10 metadata is 24 bytes, and we try to copy size of cdw10 metadata from
> nvme_command.common.cdw10 into that cdw10 metadata, but
> nvme_command.common.cdw10 is only 4 bytes in size.
> 
> Fix by making the trace metadata size as 4 bytes.
> 
> I find that this warning started first appearing from commit f68f2ff91512
> ("fortify: Detect struct member overflows in memcpy() at compile-time").

Did you test what the trace looks like afte this? We're losing valuable trace
data here. The field is supposed to get CDW's 10 - 15, so that's 24 bytes. I
don't know why it cares that the address of the field being read is only 4
bytes; we want everything that comes after it too.
