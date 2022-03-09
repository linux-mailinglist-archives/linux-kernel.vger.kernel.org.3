Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836F34D3A78
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237942AbiCIThd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbiCIThb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:37:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10C21A4;
        Wed,  9 Mar 2022 11:36:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36510B82398;
        Wed,  9 Mar 2022 19:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E13C340E8;
        Wed,  9 Mar 2022 19:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646854289;
        bh=bbCEaeZ6kj/X8f+p8As796Wn0k/8aBP9PNr1a78uZNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lM4+beyoJs2qor9r9JVwhzgyyugqlkR/2q5Y97uShJ9WcvQosx9cmiBjHf6KMCnsu
         QLbGWvruJxIG8YEyRhpKJaucuifcytA9/a+z4WCRnLBa6ws8VexY80WlZ+FL284/4z
         nISI5Al8Cu67rJxNGt1VgmQZh9t2dlUnoheZi3m3z5B+1IhjTaPTk5u3zh4JxFB60w
         H1b/YupgF5NKQi+a03frHhjSxvgQnATcLqCJGBphIcWpkn1TQ2ULrM9QsJsydwBwbe
         cakvh71vbcL3J9AbusKlsi5r+WvGWqyMZ8L5seRXK8Kj9LqbckuE7mipJ58FvcnPKu
         Xdrx9vOTE4gHA==
Date:   Wed, 9 Mar 2022 11:31:26 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com
Subject: Re: [PATCHv4 6/8] crypto: add rocksoft 64b crc guard tag framework
Message-ID: <20220309193126.GA3950874@dhcp-10-100-145-180.wdc.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-7-kbusch@kernel.org>
 <your-ad-here.call-01646770901-ext-3299@work.hours>
 <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
 <YigzoKRJ1EHFRZY9@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YigzoKRJ1EHFRZY9@sol.localdomain>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 08:57:04PM -0800, Eric Biggers wrote:
> On Tue, Mar 08, 2022 at 12:27:47PM -0800, Keith Busch wrote:
> > On Tue, Mar 08, 2022 at 09:21:41PM +0100, Vasily Gorbik wrote:
> > > On Thu, Mar 03, 2022 at 12:13:10PM -0800, Keith Busch wrote:
> > > > Hardware specific features may be able to calculate a crc64, so provide
> > > > a framework for drivers to register their implementation. If nothing is
> > > > registered, fallback to the generic table lookup implementation. The
> > > > implementation is modeled after the crct10dif equivalent.
> > > 
> > > Hi Keith,
> > > 
> > > this is failing on big-endian systems. I get the following on s390:
> > 
> > Oh, I see the put_unaligned_le64() in chksum_final() was not the correct
> > action. I'll send an update, thank you for the report.
> 
> Or you could make the digests in your test vectors have have a consistent byte
> order, probably little endian.  That's how "shash" algorithms in the crypto API
> normally work, including crc32 and crc32c; they produce bytes as output.  I see
> that crct10dif violates that convention, and I assume you copied it from there.
> I'm not sure you should do that; crct10dif might be more of a one-off quirk.

Right, I started with the t10dif implementation. I changed it to the
unaligned accessor since you indicated the output buffer doesn't have an
alignment guarantee.

Perhaps I'm missing something, but it looks easier to just use the CPU
native endianess here. The only users for t10 and rocksoft transform to
big-endian for the wire protocol at the end, but there's no need to
maintain a specific byte order before setting the payload.
