Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956F349CFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243157AbiAZQhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243097AbiAZQhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:37:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6663AC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:37:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E4FCB81EDD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BFFC340E3;
        Wed, 26 Jan 2022 16:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643215035;
        bh=Wvh+j4ViOhP5lyh7Ldj6SkzunVt2K7HTtCp2ap0/Cj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=ZlMHr2A0wa+PyYj4ZJGYfrFb3iYH33IlBUZlqtYd9/LR8Ia0sHwJZj7RMKo3IJzri
         F8ymXD9B84cTOUTGAQ0Lps76t/hLgMy2Wo9GdcX8n6mrzLKVTW1Cp70kyVE37L77sy
         foUcDUtULVMrPSQMmceSanFTKXxc+0dd1tFidDo7gmwpNezEGOqcEhmjOlZSaZoCx5
         x8Z+HbO8mrNts3mIPmegRoCZmKaTsavPn6o9yI/8uuARvp6Hu7ui33WvCKpd3ENNuK
         GrK6xDucF0Iku4biMgOEcA0KewFmegv3xKjjQFKaF9E6cEniw25dRBrfRdTca2L8QS
         2kHpd6fGXw1Gg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Remove the type-unclear target id concept
Date:   Wed, 26 Jan 2022 16:37:13 +0000
Message-Id: <20220126163713.8058-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211230182059.6535f9201eba9e420a08445a@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021 18:20:59 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 30 Dec 2021 10:07:19 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > DAMON asks each monitoring target ('struct damon_target') to have one
> > 'unsigned long' integer called 'id', which should be unique among the
> > targets of same monitoring context.  Meaning of it is, however, totally
> > up to the monitoring primitives that registered to the monitoring
> > context.  For example, the virtual address spaces monitoring primitives
> > treats the id as a 'struct pid' pointer.
> > 
> > This makes the code flexible but ugly, not well-documented, and
> > type-unsafe[1].  Also, identification of each target can be done via its
> > index.  For the reason, this patchset removes the concept and uses clear
> > type definition.
> 
> Thanks.  This doesn't appear to be urgent, so I'll park it until after 5.17-rc1.

Just for a remind.  I confirmed this patchset is cleanly applicable on the
latest -next tree.


Thanks,
SJ
