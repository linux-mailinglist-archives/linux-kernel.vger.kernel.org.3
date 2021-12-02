Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133104669CA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376609AbhLBS3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbhLBS3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:29:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB29C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 10:25:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46CC662773
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 18:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81569C00446;
        Thu,  2 Dec 2021 18:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638469551;
        bh=o2r1iA58GRDamQyALDCHeB90Mhv0GeLSXU5yXMYXgmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oHJdV2HOJaEjgLAbE+0qdY37gZEfTUBnx2Z/7uNKrHpMBeGmUaMJVyl56+IARF70Y
         55mEtthtdRT/vZ3ahgX85pIv2fD5rBy/vs3H35SPSiQC2D8kmgd0ynW9CUnpJ9i/GX
         pgBHRZeDcRKVkSveM2zByz78gucOp73oKR1qWdbm/aD6vk1VWvcUur2p3XO4iTttjR
         Zui8UnYJqRDLYGYv2o5NH3uv10LE/TNWQfENr1tIjp9Zjv9G1ixn+iIvxmMGHej/TR
         vlYOCAi7dz6A7aY50zAYv0o2e1fgMrFhtx9bzwG1jDaosh5N8iuK0CzmNSoKcRQYec
         o1Ds6VXHTOkQQ==
Date:   Thu, 2 Dec 2021 10:25:49 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 5/6] f2fs: implement iomap operations
Message-ID: <YakPrVPz5+qQm3kQ@sol.localdomain>
References: <20211116214510.2934905-1-jaegeuk@kernel.org>
 <20211116214510.2934905-5-jaegeuk@kernel.org>
 <b36e2d44-4834-3931-6a32-4fa52d1d7785@kernel.org>
 <YahIf3UlhuxJT1O4@sol.localdomain>
 <1ba0f002-42c7-b085-0c54-6071664ba79b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba0f002-42c7-b085-0c54-6071664ba79b@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 10:04:11PM +0800, Chao Yu wrote:
> On 2021/12/2 12:15, Eric Biggers wrote:
> > On Thu, Dec 02, 2021 at 11:10:41AM +0800, Chao Yu wrote:
> > > Why not relocating this check before f2fs_map_blocks()?
> 
> Wait, it supports DIO in multi-device image after commit 	71f2c8206202
> ("f2fs: multidevice: support direct IO"), how about
> checking with f2fs_allow_multi_device_dio()?
> 
> Thanks,
> 

Okay, that was not the case when I sent this patch originally.  We'll need to
update this to support multiple devices.

- Eric
