Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E39508F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381423AbiDTSOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345342AbiDTSOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:14:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2E446B0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBC0B61B44
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 18:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A071C385A0;
        Wed, 20 Apr 2022 18:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650478322;
        bh=NTy9pFDWRuCUyy+uRS6JtLFaKO2Z2cLw81UXIFC+Vr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DdBFOPQKPs5WI1dCKZuS5WAuu77VokqeMbZM5eTxoTWfi+tZDeOdFOBl/exLtmrE/
         50q2oNjj7F2e547EfrKKG5jMin0+lWpjlUGv65p3WMbp3NxnN+tk1WAmotlyvsci+P
         kpnuCskiQbDl7HubYrAeF9HUiDZ6c0hdK29vtZaTebAxvE9p6AHY1c1D/a3YeV5SRG
         kYhJ1SmaMyOEyQ/InoqZjNrwLMzvIPqbd5onUlptLNKS1zH2vd+9j96oX2K2sriXKe
         9yIuO7woiJuruLrI5YjaQ/C4LMguzLYyex44KpqiW5QPHpUEzKgjspdeHTljRuOuK1
         2oxBEZtax11BQ==
Date:   Wed, 20 Apr 2022 11:12:00 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: use flush command instead of FUA for zoned device
Message-ID: <YmBM8KEZ9JttevxH@google.com>
References: <20220419215703.1271395-1-jaegeuk@kernel.org>
 <Yl+XIjiuFRN9Pzxv@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl+XIjiuFRN9Pzxv@infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19, Christoph Hellwig wrote:
> On Tue, Apr 19, 2022 at 02:57:03PM -0700, Jaegeuk Kim wrote:
> > The block layer for zoned disk can reorder the FUA'ed IOs. Let's use flush
> > command to keep the write order.
> 
> The block layer can reorder all commands.  Given that FUA only affects
> the command itself that should not matter.  What is this trying to fix?

Not for zoned disk, as I mentioned. The mq-deadline serializes write commands
but I got an reordered command, if there's a FUA|PREFLUSH command, which emits
EIO by the disk.
