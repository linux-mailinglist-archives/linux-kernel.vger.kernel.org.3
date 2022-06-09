Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1A3545504
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343750AbiFITcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241978AbiFITct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:32:49 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4A44144BD7;
        Thu,  9 Jun 2022 12:32:48 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 259JWcqM010839;
        Thu, 9 Jun 2022 21:32:38 +0200
Date:   Thu, 9 Jun 2022 21:32:38 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [Linux v5.17.9] -Wdeprecated-declarations warnings with LLVM-14
 and OpenSSL v3.0.x
Message-ID: <20220609193238.GD10732@1wt.eu>
References: <CA+icZUUFdsEyNybVORm4x7_bAyoc0zTnudtNdgnTqjvbYXJRYA@mail.gmail.com>
 <CA+icZUWxyNeZnEBDpDWxGc-qJ-jHwR0rJMBhk1a8StPHRgC6qA@mail.gmail.com>
 <CA+icZUW7y3JxQ3dCB8Wy83EjEyYj7z55nFUw-kZ+V4We22HZZg@mail.gmail.com>
 <CA+icZUVyp2CdX7m72GY-=DtK9J+64uHeWPr5-cvo8haQm_4hUw@mail.gmail.com>
 <CA+icZUWiYYQbAav7VxVsT0ikqCeLckym08Au8oSeyYjvJHcNbg@mail.gmail.com>
 <CA+icZUUOQcc4uiVbv+tJzPr_ED7e4tD0u9tC8mcn2BRe3sdPAg@mail.gmail.com>
 <CAHk-=wiOrXUr0wqHL+hfkzGg_+b7UvtLeB=59KsX8W939bTY-A@mail.gmail.com>
 <CA+icZUUma1B8KFWF-ed9sjXH4QpCRZ+B2pON3uAFkTUs77tMzw@mail.gmail.com>
 <20220609192308.GB10732@1wt.eu>
 <CAHk-=wimC_B+nCJrXwuvWULz6ycFFmRMT1Uc+PeM5wJdma_VFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wimC_B+nCJrXwuvWULz6ycFFmRMT1Uc+PeM5wJdma_VFw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 12:25:31PM -0700, Linus Torvalds wrote:
> On Thu, Jun 9, 2022 at 12:23 PM Willy Tarreau <w@1wt.eu> wrote:
> >
> > IIRC you can also disable the deprecation warnings by defining the
> > OPENSSL_SUPPRESS_DEPRECATED macro. It doesn't require to change the
> > compiler's options and allows us to put our head in the sand.
> 
> That one had the downside that you have to know what you're doing to
> make such a change ;)

Sure, but when I had to go through it, I found that it was the one
that's used to decide whether another macro would point to either
__attribute__((deprecated)) or to an empty string. It was doing
exactly the required job for that. My plan was to use it only for
default builds but let developers remove it to see new warnings.
Finally we did better and disabled engines completely!

> I just wanted to be able to start doing pulls again after mistakenly
> thinking that an upgrade would be pain-free.

:-)

Willy
