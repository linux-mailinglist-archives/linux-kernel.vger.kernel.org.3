Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A824DD6E0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiCRJMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiCRJMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:12:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA331905BE;
        Fri, 18 Mar 2022 02:10:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DA4B268AFE; Fri, 18 Mar 2022 10:10:54 +0100 (CET)
Date:   Fri, 18 Mar 2022 10:10:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        jaegeuk@kernel.org, chao@kernel.org, ulf.hansson@linaro.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daeho Jeong <daehojeong@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: security issue: data exposure when using block layer secure
 erase
Message-ID: <20220318091054.GA31758@lst.de>
References: <20220316093740.GA7714@lst.de> <YjIm6f6pSX1CKeqb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjIm6f6pSX1CKeqb@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 06:05:29PM +0000, Eric Biggers wrote:
> __blkdev_issue_discard() can break up the region into multiple bios, but I don't
> see where it actually skips parts of the region.  Can you explain more
> specifically where the problem is?

You're right.  We used to skip misaligned parts, but that was actually
fixed two years ago.
