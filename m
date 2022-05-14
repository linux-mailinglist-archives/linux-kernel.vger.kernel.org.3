Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E485270CA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 13:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiENLLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 07:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiENLLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 07:11:46 -0400
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 441C7167EC;
        Sat, 14 May 2022 04:11:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id E7A8EFF959;
        Sat, 14 May 2022 11:11:43 +0000 (UTC)
Date:   Sat, 14 May 2022 13:11:40 +0200
From:   Max Staudt <max@enpas.org>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220514131128.5e647fb8.max@enpas.org>
In-Reply-To: <CAMZ6RqLj2eLX2UWMvGc9rH2SP6HNuqBAXnwJ6q6qvk+7QWE8pA@mail.gmail.com>
References: <20220512182921.193462-1-max@enpas.org>
 <CAMZ6Rq+BwL1NPTLtC5sQAd4z1Kc1TFJPPoW-i+0RZ5dnFaWYiw@mail.gmail.com>
 <CAMZ6RqKjGJyOPCQvS95ZUc6UrgaFzjunRhU=10biAAWYT_V_ZQ@mail.gmail.com>
 <20220513205907.6d5473ff.max@enpas.org>
 <CAMZ6RqLj2eLX2UWMvGc9rH2SP6HNuqBAXnwJ6q6qvk+7QWE8pA@mail.gmail.com>
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

On Sat, 14 May 2022 12:14:24 +0900
Vincent Mailhol <vincent.mailhol@gmail.com> wrote:

> But I still think it is possible to do pointer arithmetic.
> 
> len = strnchr(elm->rxbuf, elm->rxfill, '\r') - elm->rxbuf;
> (I let you check that I did not do an off by one mistake).
> 
> The above should also work with memchr(). Although the C standard
> doesn't allow pointer arithmetic on void *, GNU C adds an extension
> for that: https://gcc.gnu.org/onlinedocs/gcc/Pointer-Arith.html
> 
> As I said before, your for loop is not fundamentally wrong, this is
> just not my prefered approach. You have my suggestion, choose what you
> prefer.

Yeah, this is the arithmetic that I'd like to avoid here. In my
opinion, it is clearer with indices.

If I were searching through a UTF-8 string (i.e. with variable width
chars), that'd be another matter entirely IMHO, and I'd rely on C
library functions that know more about UTF that I do. But it's really
just naked ASCII bytes this time.


...unless memchr() may be faster than the loop? Could this happen?



Max
