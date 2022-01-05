Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991A4485825
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242879AbiAESZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242861AbiAESZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:25:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01671C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:25:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA5CBB81D06
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4D4C36AE0;
        Wed,  5 Jan 2022 18:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641407137;
        bh=UhbgZ6yAolUgL+vJbB+aKnkVpV4hja3dxMxdnicNqzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SpE/9Xi+1rs7/qKEzh/VWq+4uaeG0sElXWOZXpqgJW+HcUwmXgtR0WGPjkyubpz58
         cZuR2RSuNS6TgAdSO6EpjYfCGztsf+swifgmbQoYkqSYmzP2B8maLOz3fWyE/HQ/lv
         gOyOQ+0uLm/7x/hs643uXKw/AW3GOrFmvyY7z8F00taVZ/ojv40XNvyswRnkZnyszA
         oPvVl4HpszCtk+kDVp1Gv9Zm9xmWkoL/BxkFnl3jey9+BMqmum5sO2/uipHm1i3bjK
         h5+rjwPNAC42lYbr+Dy1JMBX3NGXp/QyqlkFOh2yZqtIEXjoMePdRzw56Sd/gHLY1G
         29K3sO4qRM6cQ==
Date:   Wed, 5 Jan 2022 10:25:35 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 3/6] f2fs: do not expose unwritten blocks to
 user by DIO
Message-ID: <YdXin0epwgAX295L@google.com>
References: <20220104212419.1879225-1-jaegeuk@kernel.org>
 <20220104212419.1879225-3-jaegeuk@kernel.org>
 <a2036978-81f9-fad4-90ce-15dadf048693@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2036978-81f9-fad4-90ce-15dadf048693@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05, Chao Yu wrote:
> On 2022/1/5 5:24, Jaegeuk Kim wrote:
> > DIO preallocates physical blocks before writing data, but if an error occurrs
> > or power-cut happens, we can see block contents from the disk. This patch tries
> > to fix it by 1) turning to buffered writes for DIO into holes, 2) truncating
> > unwritten blocks from error or power-cut.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Thank you for the review tho, I can't ruin the one month git history. Please
chime in if there's any bug in the patch.

> 
> Thanks,
