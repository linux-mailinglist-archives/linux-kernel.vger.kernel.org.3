Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E1655B41F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 23:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiFZVKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 17:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiFZVKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 17:10:15 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA22C10E1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 14:10:14 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id cs6so12318351qvb.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 14:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fJk5i5qpoI/Z1v8egzKlbqflsnmD9fHKRX7TDMxaEDk=;
        b=Ulft6Wnm3OS1Ytwk0MVOaHd0bBkUdvy8Ep1VwF6STcVTQgHqOZlQLAwP84A5S8a+g1
         2QiB3bPDvFQYO7VRjUP7tkvFlwdy164C8np5fE0JAxyUCIaakgdt8U0fU8HO1c+dgEPW
         g48Zm20EQ8g6FzkAFe9O7SV4xQnXvoWWs42HD2SeiMJPOeqDENNEVDDDMnQg8TsJ9sjD
         P4yLRNzbJ60UuuS2AJudSjl9CZsPXcYc7RtyU/o+X+etFdvKAksiFIsfsUSKtpDU1p8D
         lArsDSyXYfK7baG/J6rP94GWCdFXzR8oq2rX7458GoAMNCXqXT85eJ3yt9HYRYAjNp2o
         t5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fJk5i5qpoI/Z1v8egzKlbqflsnmD9fHKRX7TDMxaEDk=;
        b=0UjTeiVM7cFRiBvXcyzA3bNMlQBKs+Y1U5fYJCdwil1QZzq1KNOViCyurWVKJoXQRW
         hKpuI3KQ6Zi91+P99mO4SL6H3UQpk73LeodliEqNIyjZ8o2XqzvCXcnOI6HHs/kPs3VU
         B2XFGxnBuLM/V2N9padOJlJKQQXF1lsqtY68TXy2lCFe621c1Fh54jkg3yR2bQeXVgeH
         /og5pZPJsDuxUN/djWleX1JeY7dP+JlYxLy3ootO69eUGzlUHHgNbAhcBiflyKhsEZ44
         rAd13Vky+vsZI+POgVNPBMUybnh0Aq+pzn/IZZ5vNVjuLRhSas43RNwoNLfrEp1hALc9
         ZRMA==
X-Gm-Message-State: AJIora97ZthaYImD2OXDi5uK5770xT54OOImjN0nAmV0DB7M4+b4QcRn
        QwW5yhVMLMNUd+Ce0zqSUA==
X-Google-Smtp-Source: AGRyM1sFgIMiO7hAGCuVW2vZVJE9a48uWHstFqVns685vPJbuFMfR1HofPUhOVG2Hm9IS/ddvXQmQA==
X-Received: by 2002:a05:6214:178a:b0:470:41b6:22ce with SMTP id ct10-20020a056214178a00b0047041b622cemr6565260qvb.90.1656277814006;
        Sun, 26 Jun 2022 14:10:14 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b006a6d74f8fc9sm7794785qko.127.2022.06.26.14.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 14:10:13 -0700 (PDT)
Date:   Sun, 26 Jun 2022 17:10:12 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC[ Alloc in vsprintf
Message-ID: <20220626211012.aurhmgdolvt6vnbt@moria.home.lan>
References: <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
 <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
 <20220621005752.ohiq5besmy3r5rjo@moria.home.lan>
 <a795818f9a49ed401bffc7c38ca7e39ae449e9e0.camel@perches.com>
 <c1a92cf059fc9a3c395d87b11e9f757f5ec1ff6a.camel@perches.com>
 <355e912490dbaef8fe4e12df0201c3f5b439565d.camel@perches.com>
 <CAHk-=whwyxSpzgr+roEr7_V5wVenw9fV3EOAZhAYCAuRdEyChQ@mail.gmail.com>
 <93ab94ec92497af13c563c52fc7e1f7f81dac333.camel@perches.com>
 <20220626205158.bqeyetui3cromscp@moria.home.lan>
 <20e7ca5f3b7b5b473afe891e8b28c83de62bc6d6.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20e7ca5f3b7b5b473afe891e8b28c83de62bc6d6.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 02:02:31PM -0700, Joe Perches wrote:
> Because the stack use in _this_ function is quite large.
> Backporting to stable would be trivial.
> No so with printbufs.

Yeah, I'm not so sure "do what's easiest to backport to stable" makes any sense
to me.
