Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8114DD6E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbiCRJNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiCRJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:13:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A2C2C5437;
        Fri, 18 Mar 2022 02:11:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F2A9D68AFE; Fri, 18 Mar 2022 10:11:52 +0100 (CET)
Date:   Fri, 18 Mar 2022 10:11:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        jaegeuk@kernel.org, chao@kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH alternative 2] block: fix the REQ_OP_SECURE_ERASE
 handling to not leak erased data
Message-ID: <20220318091152.GB31758@lst.de>
References: <20220316093740.GA7714@lst.de> <20220316093855.GC7714@lst.de> <CAPDyKFrH4L2Y2TOFyWPJ+_rrgvJPixR05XX_HWUU99h0MZhLuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrH4L2Y2TOFyWPJ+_rrgvJPixR05XX_HWUU99h0MZhLuA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 10:44:01AM +0100, Ulf Hansson wrote:
> Stating that it can't work is probably not a correct statement.
> Certainly it can, but it depends on how "secure" (or clever) the
> implementation of the FTL is in the flash media. I mean, nothing
> prevents the FTL from doing a real erase on erase block level and
> simply let the "secure erase" request wait on that operation to be
> completed.

Well, that assumes it can find all the previous copied of the data.
Having worked with various higher end SSDs FTLs I know they can't,
so if an eMMC device could that would very much surpise me given
the overhead.
