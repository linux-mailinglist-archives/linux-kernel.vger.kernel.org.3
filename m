Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED6592709
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 02:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiHOAO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 20:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHOAOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 20:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B93D1147D
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 17:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E547360F22
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F787C433D6;
        Mon, 15 Aug 2022 00:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660522463;
        bh=ra/RMG6v9yO5osT/ekGSmnfTxYanJLz/WPdP8mRg9zY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NPgeuqavCqM+fsiAZsR8u+cdJRVqAg6IckOQk3ki1ssvWva40MJq7wNZA3duE6N5p
         WTRWHaDj9WwBy+sht2jTID1sXONgmD3HimW+IGtbZQzb/i70glp0LGPu5y4FQIBJoD
         LKGVNLLtDdUxh/ALYBYn0wQug0yMAD9b5H5vJH9A=
Date:   Sun, 14 Aug 2022 17:14:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 (REPOST)] rapidio/tsi721: Replace
 flush_scheduled_work() with flush_work().
Message-Id: <20220814171422.49b14550b9f3f3794166316e@linux-foundation.org>
In-Reply-To: <8347375e-29fd-cd45-2b07-5504c9ddbd0c@I-love.SAKURA.ne.jp>
References: <8347375e-29fd-cd45-2b07-5504c9ddbd0c@I-love.SAKURA.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Thu, 28 Jul 2022 10:02:13 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> Since "struct tsi721_device" is per a device struct, I assume that
> tsi721_remove() needs to wait for only two works associated with that
> device. Therefore, wait for only these works using flush_work().

The changelog provides no reason for making this change.  Correctness?
Efficiency?
