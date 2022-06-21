Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E0A552964
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344080AbiFUCby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 22:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbiFUCbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 22:31:49 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731B01F2F2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 19:31:48 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id g18so10986387qvn.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 19:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bug3LXi1Aq6PRwRUvNUaWDOJ1zcASuYiUSH1Dvw5rS4=;
        b=ZIzAarIJwUG1UzRAc3XDmaIU7ID4JLGGYXAYm45TtviKkBsscq8QgmwifNWFchnYsf
         kZ7aDg6JPZdcip5nRIkOV+QktfEQwpIGIlfGjRyQGLdISvmn2qslg0C2zn4SdiIsIWuu
         wOT1sQ4FThObehTU+RRWq8NO31TfOkb9NghyML0dl+bg590te3b1+vs0UyW/4Rgxw4Nh
         O5xUOu7dXpGsdlymDtrI0rkfAPMqN0Ajdmk46xLfZQCk8YJjMwC7qANzbM4wBB4FH5b2
         IN3puqtBFxr9LDY1Fe/9//DQw6aE3gBvUz2PCeOmKYP1IMgm5OmXciod12YXm5KPrhfl
         00Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bug3LXi1Aq6PRwRUvNUaWDOJ1zcASuYiUSH1Dvw5rS4=;
        b=lnS+vMpceiXli+a//5i1r+PO77EidoJt5NW4f0gf6UGiLqbpWsvPkEb/s9zB+1wQ9i
         4NgTGRHXU0NRMQx9Dl1Ti4uweDmB9HR02jPYEgtahoy6R49M12yddZliQokj4ovinzZQ
         tpvybSk8x39lyhKI18wdUzo9dS4jGzr+RVEq22yadcqLebZQdQxLo9oPKsoslwHJtb5K
         jSylxppWOInqTquxDNL3BYH8qmX283sU9TJr8KuNO3oOHH77T/KM4MejXSjv/yTH3WRG
         h7EXcdA/CbME7aUgivIy1bcQ+j1VixjrfLTFXccAocrqj2PxuwFjsfAwcfqTvmcBl+ec
         l7DA==
X-Gm-Message-State: AJIora8v69hpnkhizUtslLBwSpKS++eWY9Z15Wr1ys2VCFku3vwdqRDF
        7meoEgUsQsW9zqGxMHjjQg==
X-Google-Smtp-Source: AGRyM1sKLR8mPrR5c57iQz1Ki3yWj3lrFksqjFTf0n2kFU/SXQfh7Deltq59LjbB2sU05EnmqWNPuw==
X-Received: by 2002:ac8:4e90:0:b0:304:fe09:6c32 with SMTP id 16-20020ac84e90000000b00304fe096c32mr22037211qtp.157.1655778707596;
        Mon, 20 Jun 2022 19:31:47 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id b64-20020a376743000000b006a5d4f32e5dsm12819128qkc.128.2022.06.20.19.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 19:31:46 -0700 (PDT)
Date:   Mon, 20 Jun 2022 22:31:45 -0400
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
Message-ID: <20220621023145.sx3o3txbmbsa3br6@moria.home.lan>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
 <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
 <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
 <20220621005752.ohiq5besmy3r5rjo@moria.home.lan>
 <a795818f9a49ed401bffc7c38ca7e39ae449e9e0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a795818f9a49ed401bffc7c38ca7e39ae449e9e0.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 06:26:58PM -0700, Joe Perches wrote:
> On Mon, 2022-06-20 at 20:57 -0400, Kent Overstreet wrote:
> > On Mon, Jun 20, 2022 at 05:38:51PM -0700, Joe Perches wrote:
> > > On Mon, 2022-06-20 at 11:07 -0400, Kent Overstreet wrote:
> > > > On Mon, Jun 20, 2022 at 04:19:31AM +0000, David Laight wrote:
> > > > > I really think that is a bad idea.
> > > > > printk() already uses a lot of stack, anything doing a recursive
> > > > > call is just making that worse.
> > > > > Especially since these calls can often be in error paths
> > > > > which are not often tested and can already be on deep stacks.
> > > > 
> > > > We went over this before - this patch series drastically reduces stack usage of
> > > > sprintf by eliminating a bunch of stack allocated buffers. Do try to keep up...
> > > 
> > > I generally agree with David.
> > > 
> > > I think Kent has not provided data that this actually _reduces_
> > > stack usage.
> > 
> > I think the people who are comfortable with reading C can discern that when
> > large stack allocated character arrays are deleted, frame size and stack usage
> > go down.
> 
> I am very comfortable reading C.
> 
> You have not provided any data.

It seems like neither of you have even bothered to check stack frame size in the
current code, and you guys are the one asserting that this is an issue. 
