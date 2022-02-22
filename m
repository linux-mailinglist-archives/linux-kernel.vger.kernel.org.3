Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0FA4C02DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbiBVUJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbiBVUJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:09:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441DCBECE2;
        Tue, 22 Feb 2022 12:09:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5739616A5;
        Tue, 22 Feb 2022 20:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B59C340E8;
        Tue, 22 Feb 2022 20:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645560550;
        bh=1RpeK2ezkeXvyqdfTt2Tyf6eIBlrvYVjmKs7rO0ojdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kX1+BSiIzoCC7MPwCqygUVYJjYjCGP8r0uNbfIvHrEUClkW1piWFY0f6WZWt/CKnC
         JMhyXgFkSIr4Wqa/2F+eN6U1ZhpPp8qhzTr4/djfi8ayJprxTYDMxvyXHbj37008Sp
         CCiY+w24npvSlnH9uitpVrv76+EUJbJgG130TtVndHZCfTHUOQSMesvAH2Ipw5qw1z
         wq3MxQKizauoTcEZtY0Q9ZhCOAkjDy/Wfd4XhtkRQH7yVPT6D/Qc0UnlFcsYpokyFW
         ESFioc5kDB+DFV9dR1MblY51KCMUdRQ+vUUPzTu0Wi5TViO/O6bZ/mpLm1PlS5bkuq
         yXu4fBMHR5igQ==
Date:   Tue, 22 Feb 2022 12:09:07 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv3 06/10] crypto: add rocksoft 64b crc framework
Message-ID: <20220222200907.GA1782741@dhcp-10-100-145-180.wdc.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-7-kbusch@kernel.org>
 <YhU+kuMhueXVQvxe@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhU+kuMhueXVQvxe@sol.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 11:50:42AM -0800, Eric Biggers wrote:
> On Tue, Feb 22, 2022 at 08:31:40AM -0800, Keith Busch wrote:
> > +config CRYPTO_CRC64_ROCKSOFT
> > +	tristate "Rocksoft Model CRC64 algorithm"
> > +	depends on CRC64
> > +	select CRYPTO_HASH
> > +	help
> > +	  Rocksoft Model CRC64 computation is being cast as a crypto
> > +	  transform. This allows for faster crc64 transforms to be used
> > +	  if they are available.
> 
> The first sentence of this help text doesn't make sense.

Much of the this patch is a copy from the equivalent T10DIF option,
which says the same as above. I meant to revist these help texts because
they don't make sense to me either. I'll be sure to do that for the next
version.
