Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE8F4CA229
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbiCBK3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiCBK3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:29:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81E68F983;
        Wed,  2 Mar 2022 02:29:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 735E4B81F64;
        Wed,  2 Mar 2022 10:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9CEC004E1;
        Wed,  2 Mar 2022 10:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646216944;
        bh=SxiAf4w0t5Z/laDZISR+TqH6C7L6uEHJCHh5rWwHoak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Au0FuN8NZqg5fQ+d6O/N1dmXPu5GNfYEnDbEMSaNG1Y8T2Tj3ITcdCF+0wuIe+1Ah
         n/4TUvcQEpUqLJNbhS5GCJAMPbx5IaJfUSfUfh1M1K7pKH10FHyZMcLMjMGLhYYV5L
         IueFz4+O6nHwvx8amotFPOc55B48mTAqTV4VWUdU=
Date:   Wed, 2 Mar 2022 11:29:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Kyle Sanderson <kyle.leet@gmail.com>,
        Dave Chinner <david@fromorbit.com>, qat-linux@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
Message-ID: <Yh9G7FyCLtsm2mFA@kroah.com>
References: <CACsaVZ+mt3CfdXV0_yJh7d50tRcGcRZ12j3n6-hoX2cz3+njsg@mail.gmail.com>
 <20220219210354.GF59715@dread.disaster.area>
 <CACsaVZ+LZUebtsGuiKhNV_No8fNLTv5kJywFKOigieB1cZcKUw@mail.gmail.com>
 <YhN76/ONC9qgIKQc@silpixa00400314>
 <CACsaVZJFane88cXxG_E1VkcMcJm8YVN+GDqQ2+tRYNpCf+m8zA@mail.gmail.com>
 <CAHk-=whVT2GcwiJM8m-XzgJj8CjytTHi_pmgmOnSpzvGWzZM1A@mail.gmail.com>
 <Yh0y75aegqS4jIP7@silpixa00400314>
 <Yh1aLfy/oBawCJIg@gondor.apana.org.au>
 <CAHk-=wi+xewHz=BH7LcZAxrj9JXi66s9rp+kBqRchVG3a-b2BA@mail.gmail.com>
 <Yh2c4Vwu61s51d6N@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh2c4Vwu61s51d6N@gondor.apana.org.au>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 04:11:13PM +1200, Herbert Xu wrote:
> On Mon, Feb 28, 2022 at 05:12:20PM -0800, Linus Torvalds wrote:
> > 
> > It sounds like it was incidental and almost accidental that it fixed
> > that thing, and nobody realized it should perhaps be also moved to
> > stable.
> 
> Yes this was incidental.  The patch in question fixes an issue in
> OOM situations where drivers that must allocate memory on each
> request may lead to dead-lock so it's not really targeted at qat.

Ok, so what commits should I backport to kernels older than 5.10 to
resolve this?

thanks,

greg k-h
