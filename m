Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9220C568794
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiGFMAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiGFMAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:00:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8459237DD;
        Wed,  6 Jul 2022 05:00:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2C5DA68B05; Wed,  6 Jul 2022 14:00:11 +0200 (CEST)
Date:   Wed, 6 Jul 2022 14:00:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: unable to read RDB block due to b9684a71fca793
Message-ID: <20220706120010.GA16423@lst.de>
References: <YsT5MGPNha1Z1i7V@debian.me> <20220706080912.GA32273@lst.de> <aa126250-9f7f-b48b-79dc-bdb8b4bf5ca9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa126250-9f7f-b48b-79dc-bdb8b4bf5ca9@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 05:16:06PM +0700, Bagas Sanjaya wrote:
> On 7/6/22 15:09, Christoph Hellwig wrote:
> >> Bisecting between v5.18 and v5.19-rc5, the culprit is commit b9684a71fca793
> >> ("block, loop: support partitions without scanning").
> > 
> > Which just restores the previous behavior of optionally allowing to
> > scan for partitions on all loop devices.  So that error had been
> > there before and just disappeared due to a regression.
> 
> OK.
> 
> Can partition scanning for loop devices be disabled? If so, how?

It is disabled by default.  But some tools force partitions rescans,
which is what that commit enabled.  parted was the original reproducer.
