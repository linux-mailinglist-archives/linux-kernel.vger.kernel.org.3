Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CC94D3ABB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbiCIUCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbiCIUCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:02:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1814D2D8;
        Wed,  9 Mar 2022 12:01:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A78AA61982;
        Wed,  9 Mar 2022 19:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB0EC340F6;
        Wed,  9 Mar 2022 19:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646855349;
        bh=vLWP7Mz1loKXAb3DtQpG0OTSE1xeUnN23OMpCL3CeWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KDQyLvFoiqpenp9TLxg7LLUJNyjnj7ylkJMcOzp6owy80ytt6FI07RIh5EW9UJFpE
         EVa7KR0f17MBf4Qjb1ckQ1kkCvl/CYsRfdBzc2nsz63RxM2FA0ymXd9QTneB+GAhK/
         DgzqOfcsLb22La8VJMRGG1wWWAC2yb/gOqdRnuGdNJ2ILYFSz8dkXzGeaXlIOUnh6O
         fpHTqJeralBNOQaLkuXvqIB3//XGERraP26JGoYJYPnIDNFLcd9KvPvhrFohk5OwQX
         m4h+woBg34bDT6DK8932+pOn7HsLwq9OPr7eHDnUOU1ZAit+dgWxASMpS3UjuQqbK/
         e3il182jgGS9Q==
Date:   Wed, 9 Mar 2022 19:49:07 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCHv4 6/8] crypto: add rocksoft 64b crc guard tag framework
Message-ID: <YikEs7RNgPXTQolv@gmail.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-7-kbusch@kernel.org>
 <your-ad-here.call-01646770901-ext-3299@work.hours>
 <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
 <YigzoKRJ1EHFRZY9@sol.localdomain>
 <20220309193126.GA3950874@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309193126.GA3950874@dhcp-10-100-145-180.wdc.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 11:31:26AM -0800, Keith Busch wrote:
> On Tue, Mar 08, 2022 at 08:57:04PM -0800, Eric Biggers wrote:
> > On Tue, Mar 08, 2022 at 12:27:47PM -0800, Keith Busch wrote:
> > > On Tue, Mar 08, 2022 at 09:21:41PM +0100, Vasily Gorbik wrote:
> > > > On Thu, Mar 03, 2022 at 12:13:10PM -0800, Keith Busch wrote:
> > > > > Hardware specific features may be able to calculate a crc64, so provide
> > > > > a framework for drivers to register their implementation. If nothing is
> > > > > registered, fallback to the generic table lookup implementation. The
> > > > > implementation is modeled after the crct10dif equivalent.
> > > > 
> > > > Hi Keith,
> > > > 
> > > > this is failing on big-endian systems. I get the following on s390:
> > > 
> > > Oh, I see the put_unaligned_le64() in chksum_final() was not the correct
> > > action. I'll send an update, thank you for the report.
> > 
> > Or you could make the digests in your test vectors have have a consistent byte
> > order, probably little endian.  That's how "shash" algorithms in the crypto API
> > normally work, including crc32 and crc32c; they produce bytes as output.  I see
> > that crct10dif violates that convention, and I assume you copied it from there.
> > I'm not sure you should do that; crct10dif might be more of a one-off quirk.
> 
> Right, I started with the t10dif implementation. I changed it to the
> unaligned accessor since you indicated the output buffer doesn't have an
> alignment guarantee.
> 
> Perhaps I'm missing something, but it looks easier to just use the CPU
> native endianess here. The only users for t10 and rocksoft transform to
> big-endian for the wire protocol at the end, but there's no need to
> maintain a specific byte order before setting the payload.

The issue is that every other "shash" algorithm besides crct10dif, including
crc32 and crc32c, follow the convention of treating the digest as bytes.  Doing
otherwise is unusual for the crypto API.  So I have a slight preference for
treating it as bytes.  Perhaps see what Herbert Xu (maintainer of the crypto
API, Cc'ed) recommends?

- Eric
