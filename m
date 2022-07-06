Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8236B5680C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiGFIJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGFIJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:09:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F41617A8E;
        Wed,  6 Jul 2022 01:09:16 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 189526732D; Wed,  6 Jul 2022 10:09:13 +0200 (CEST)
Date:   Wed, 6 Jul 2022 10:09:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: unable to read RDB block due to b9684a71fca793
Message-ID: <20220706080912.GA32273@lst.de>
References: <YsT5MGPNha1Z1i7V@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsT5MGPNha1Z1i7V@debian.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 09:53:36AM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> I first noticed this issue on v5.18.9, and still found on v5.19-rc5.
> 
> Looking at dmesg, I see error message on loop8 device:
> 
> [   41.319699] Dev loop8: unable to read RDB block 8
> [   41.320566]  loop8: unable to read partition table
> [   41.320597] loop8: partition table beyond EOD, truncated
> 
> My Debian 11 laptop is also run LXD (as development server).
> 
> Bisecting between v5.18 and v5.19-rc5, the culprit is commit b9684a71fca793
> ("block, loop: support partitions without scanning").

Which just restores the previous behavior of optionally allowing to
scan for partitions on all loop devices.  So that error had been
there before and just disappeared due to a regression.
