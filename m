Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CE25528DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 02:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243940AbiFUA7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 20:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245609AbiFUA56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 20:57:58 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ED426CE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 17:57:55 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id c1so17906037qvi.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 17:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s9yCSknvivXOCDzx6BY6FbW8mnwWGLGgsKhyrZCinWU=;
        b=njxx+bhrRN/d5D7pBWAqvtB9LH64qZRgC9Gy2Dx0mKfxea66YfdkKR/lbtJqUMQWo2
         wov/9mpBSRKVHW2zx9B6goeBTkv9JV5gRBPu+F4y4t3KNuohdWHD0w34la+Oox2lpMn+
         l4aZQ2932xzeENYlbyBciutU4JI3If5eoO8QfDhbloYysYSvSskjyxMgxnvbRtCMeYP3
         gugcalew2eu7Zpj+JADT65hTXyLiD5wpKs/DMuBWEQaWas9Yh5xuszdlO2/3/7ZAsAH6
         cp7rrBvtPiv0OEffiOMlBRGKTmsolwzWK/I6r6milsfKq1ZXWYVM4whADlyBNN0qYyFC
         kQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s9yCSknvivXOCDzx6BY6FbW8mnwWGLGgsKhyrZCinWU=;
        b=frSs41iaZVob94MBSqChi+2NHiZzoy7/LqtCn4GCMcWdk22dSvIeI0yCbTGJxOtBqB
         Z2OrO355DaIPbR6dR2VHI8toB7fmC8B9VaNYZ80WaQyvatxI9bLs9HKJfn0IcUkPojAJ
         jYAW8vPuaARuyZV0HsJC4FqT65vaMeu94RLAZOmZo9cvVNeYWI9TZfDztlaVBBkDCqNo
         7QhLTQqhAS0c27h0NVaKzfy5sVAlm0tAdJmZjANYng5RXRPA1vxyiiTjiHnohvfka5V3
         2dUD2EVPSd/2duA0Po0ToKZmKe8ymE9YoJuaq2uuCAujs/J0kYDX3A1wO6HboeEGUc2J
         7uBw==
X-Gm-Message-State: AJIora9b2BUYihoXyI4gspDerN3fb4SNHEKZU7VAd6gu7LNYm4iGqP3w
        gA3g+uKGel6LSZ8QjomoZg==
X-Google-Smtp-Source: AGRyM1slrO9xwd2Aonm9UtY5AjVCx98e+png+gulVl2ecfSSdz90oZc4bznkwHR/J1H4BTOpBXgzWA==
X-Received: by 2002:ac8:5790:0:b0:305:bd1:f7b0 with SMTP id v16-20020ac85790000000b003050bd1f7b0mr21931700qta.94.1655773074740;
        Mon, 20 Jun 2022 17:57:54 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id r8-20020a05622a034800b00304e4bbc369sm12057403qtw.10.2022.06.20.17.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 17:57:53 -0700 (PDT)
Date:   Mon, 20 Jun 2022 20:57:52 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "enozhatsky@chromium.org" <enozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
Message-ID: <20220621005752.ohiq5besmy3r5rjo@moria.home.lan>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
 <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
 <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 05:38:51PM -0700, Joe Perches wrote:
> On Mon, 2022-06-20 at 11:07 -0400, Kent Overstreet wrote:
> > On Mon, Jun 20, 2022 at 04:19:31AM +0000, David Laight wrote:
> > > I really think that is a bad idea.
> > > printk() already uses a lot of stack, anything doing a recursive
> > > call is just making that worse.
> > > Especially since these calls can often be in error paths
> > > which are not often tested and can already be on deep stacks.
> > 
> > We went over this before - this patch series drastically reduces stack usage of
> > sprintf by eliminating a bunch of stack allocated buffers. Do try to keep up...
> 
> I generally agree with David.
> 
> I think Kent has not provided data that this actually _reduces_
> stack usage.

I think the people who are comfortable with reading C can discern that when
large stack allocated character arrays are deleted, frame size and stack usage
go down.
