Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4BD472AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhLMKuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:50:19 -0500
Received: from first.geanix.com ([116.203.34.67]:37706 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhLMKuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:50:17 -0500
Received: from skn-laptop (unknown [195.24.41.109])
        by first.geanix.com (Postfix) with ESMTPSA id 1C885E1D01;
        Mon, 13 Dec 2021 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1639392614; bh=cGxFVdayz5jAaqQX0zPXjvkju3c6WvmCUgBcKAZPV0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=cS23gm/a38x3zfw858JVQzfU+NOG0lg1sHsfkkCjK/fcYFTCUqhwGmjNrrh/OW8nB
         +s2p5caiTdXgujox/EVVWxX/h3VI3gBeiZQ/yKbfU9IeQkXP7mPHvXpS3rDTKppBUg
         tssMieQEkBNXsqkW/9HidFUGXjoZM3CfOyq+BJcaFw3+qagPrUdJgG9pp29Iyp8DC4
         YjD3jLzPc0dOckfQi1ds3Xr4f15Ian2wHijeYbMtlGi5h+qgLUTMkcfVYdasqCD5BK
         IATqXq37qr8RqdEM2pxZE28eavvI+ZP+QD+7CbD/CDZBI258BspnT7t+Oqp1zFgQgG
         oRNFHWZYya/MQ==
Date:   Mon, 13 Dec 2021 12:50:12 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v5 3/4] mtd: core: protect access to MTD devices while in
 suspend
Message-ID: <20211213105012.65jk4rylxzncqdfy@skn-laptop>
References: <20211130132912.v6v45boce2zbnoy3@skn-laptop>
 <20211130143705.5d0404aa@collabora.com>
 <20211203143958.40645506@xps13>
 <20211209140721.6ki7gznvxwyn3cze@skn-laptop.hinnerup>
 <20211209152811.318bdf17@xps13>
 <20211210132535.gy7rqj5zblqlnz5y@skn-laptop.hadsten>
 <20211213101025.42c27b43@xps13>
 <20211213102801.569b50b1@collabora.com>
 <20211213103350.22590c13@xps13>
 <20211213105336.7be369b7@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211213105336.7be369b7@collabora.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel and Boris,

On Mon, Dec 13, 2021 at 10:53:36AM +0100, Boris Brezillon wrote:
> On Mon, 13 Dec 2021 10:33:50 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Hello,
> > 
> > boris.brezillon@collabora.com wrote on Mon, 13 Dec 2021 10:28:01 +0100:
> > 
> > > On Mon, 13 Dec 2021 10:10:25 +0100
> > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >   
> > > > Hi Sean,
> > > > 
> > > > sean@geanix.com wrote on Fri, 10 Dec 2021 14:25:35 +0100:
> > > >     
> > > > > On Thu, Dec 09, 2021 at 03:28:11PM +0100, Miquel Raynal wrote:      
> > > > > > Hi Sean,
> > > > > > 
> > > > > > sean@geanix.com wrote on Thu, 9 Dec 2021 15:07:21 +0100:
> > > > > >         
> > > > > > > On Fri, Dec 03, 2021 at 02:39:58PM +0100, Miquel Raynal wrote:        
> > > > > > > > Hello,
> > > > > > > >           
> > > > > > > > > > Fine by me, lets drop this series.          
> > > > > > > > 
> > > > > > > > FYI I've dropped the entire series from mtd/next. I'm waiting for the
> > > > > > > > fix discussed below (without abusing the chip mutex ;-) ).          
> > > > > > > 
> > > > > > > Cool, looking forward to test a patch series :)        
> > > > > > 
> > > > > > Test? You mean "write"? :)
> > > > > > 
> > > > > > Cheers,
> > > > > > Miquèl        
> > > > > 
> > > > > Hi Miquel,
> > > > > 
> > > > > Should we us a atomic for the suspended variable?      
> > > > 
> > > > I haven't thought about it extensively, an atomic variable sound fine
> > > > but I am definitely not a locking expert...    
> > > 
> > > No need to use an atomic if the variable is already protected by a lock
> > > when accessed, and this seems to be case.  
> > 
> > Maybe there was a confusion about this lock: I think Boris just do not
> > want the core to take any lock during a suspend operation. But you can
> > still use locks, as long as you release them before suspending.
> > 
> > And also, that chip lock might not be the one you want to take because
> > it's been introduced for another purpose.
> 
> Access to the suspended field is already protected by the chip lock,
> and I think it's just fine to keep it this way.

I'm reading the suspended variable in wait_event() outside the lock :/

/Sean
