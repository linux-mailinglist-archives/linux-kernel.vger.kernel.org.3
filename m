Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FD75269C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383509AbiEMS7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240694AbiEMS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:59:13 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ECC852E51;
        Fri, 13 May 2022 11:59:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 0668AFFCE9;
        Fri, 13 May 2022 18:59:09 +0000 (UTC)
Date:   Fri, 13 May 2022 20:59:07 +0200
From:   Max Staudt <max@enpas.org>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220513205907.6d5473ff.max@enpas.org>
In-Reply-To: <CAMZ6RqKjGJyOPCQvS95ZUc6UrgaFzjunRhU=10biAAWYT_V_ZQ@mail.gmail.com>
References: <20220512182921.193462-1-max@enpas.org>
        <CAMZ6Rq+BwL1NPTLtC5sQAd4z1Kc1TFJPPoW-i+0RZ5dnFaWYiw@mail.gmail.com>
        <CAMZ6RqKjGJyOPCQvS95ZUc6UrgaFzjunRhU=10biAAWYT_V_ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 15:31:20 +0900
Vincent Mailhol <vincent.mailhol@gmail.com> wrote:

> On Fri. 13 May 2022 at 11:38, Vincent Mailhol
> <vincent.mailhol@gmail.com> wrote: [...]
> > > +       case ELM327_STATE_RECEIVING:
> > > +               /* Find <CR> delimiting feedback lines. */
> > > +               for (len = 0;
> > > +                    (len < elm->rxfill) && (elm->rxbuf[len] !=
> > > '\r');
> > > +                    len++) {
> > > +                       /* empty loop */  
> >
> > Question of taste but would prefer a while look with the len++ in
> > the body (if you prefer to do as above, no need to argue, just keep
> > it like it is).  
> 
> Actually, what about this?
> 
> len = strnchr(elm->rxbuf, elm->rxfill, '\r');

Actually I'd use memchr() if anything, but not really here. I do end up
using the actual index. And since both strchr() and mrmchr() return
pointers, I'd rather avoid them because I prefer to use indices
whenever possible.


Max
