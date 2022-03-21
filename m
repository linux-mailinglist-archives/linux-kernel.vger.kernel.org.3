Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9934E228D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345480AbiCUIwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbiCUIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:52:42 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78D647891F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:51:16 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22L8p0aG005720;
        Mon, 21 Mar 2022 09:51:00 +0100
Date:   Mon, 21 Mar 2022 09:51:00 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [RFC PATCH v1 6/6] tools/include/string: Implement `strdup()`
 and `strndup()`
Message-ID: <20220321085100.GB5676@1wt.eu>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-7-ammarfaizi2@gnuweeb.org>
 <20220321075308.GD29580@1wt.eu>
 <CAOG64qMpEMh+EkOfjNdAoueC+uQyT2Uv3689_sOr37-JxdJf4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOG64qMpEMh+EkOfjNdAoueC+uQyT2Uv3689_sOr37-JxdJf4g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 03:16:54PM +0700, Alviro Iskandar Setiawan wrote:
> On Mon, Mar 21, 2022 at 2:53 PM Willy Tarreau wrote:
> > Here it can cost quite a lot for large values of maxlen. Please just use
> > a variant of the proposal above like this one:
> >
> >         size_t len;
> >         char *ret;
> >
> >         len = strlen(str);
> >         if (len > maxlen)
> >                 len = maxlen;
> >         ret = malloc(len + 1);
> >         if (ret)
> >                 memcpy(ret, str, len);
> >         return ret;
> 
> Maybe better to use strnlen(), see the detail at man 3 strnlen.
> 
>   size_t strnlen(const char *s, size_t maxlen);
> 
> The strnlen() function returns the number of bytes in the string
> pointed to by s, excluding the terminating null byte ('\0'), but at
> most maxlen. In doing this, strnlen() looks only at the first maxlen
> characters in the string pointed to by s and never beyond s[maxlen-1].
> 
> Should be trivial to add strnlen() with a separate patch before this patch.
> 
> So it can be:
> 
>     size_t len;
>     char *ret;
> 
>     len = strnlen(str, maxlen);
>     ret = malloc(len + 1);
>     if (__builtin_expect(ret != NULL, 1)) {
>         memcpy(ret, str, len);
>         ret[len] = '\0';
>     }
>     return ret;
> 
> Thoughts?

I thought about it as well and while I was seeking the simplest route,
I agree it would indeed be cleaner.

Willy
