Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E184ACFB5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 04:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346368AbiBHDWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 22:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiBHDWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 22:22:40 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29209C043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 19:22:39 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id fh9so5214533qvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 19:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=90XsEdNXJrY04sKVLTFX0hH6LSLsZT/XD+WqONrkToE=;
        b=A3MJ4wbIsuKoXv2XlF+FIWZDf6FKTHnTRwv/el2HCZDOJL8MM0JUDUMXydMJ9qi4ax
         QKPE9ODBrOzNvMKOWrFY6PwMorAsBCmCHACP+tDJTlBOc/+pgLzYxfcUNoWhEm7k+B3+
         pAIaToCVRmNn1ADS//ppPQRdQfhrB+8z0oE33Nzpw8QrulQLvfOcrt0unVcj4VvIysdL
         AxtrdhBJIYEhtkBeduKmSHdfiHzTwW8A3f2KwJUcAxeC4/UEqJ2Ve7BINyhwvrNwSmRW
         qIcigu49r9AdsLQJXqyxIB9ClQ75uP1XfhIShlIJOOJ+KyzPabViwipr5JZGH9aEZrDu
         KpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=90XsEdNXJrY04sKVLTFX0hH6LSLsZT/XD+WqONrkToE=;
        b=yroGDjahtbB/jX+jfnekVANS50iqbzCP/z26qcM/HJYhghY72xYm4osrHalsgYdhRC
         aU9vl9ALigo8D7fgmIxnWuchi61wdhkAB57Z4/mG3EAJNV3IrxWKpMgAYeFHh2WWJlHY
         VkAGbFF4ulLE54MyRil2CBwkJKx7liygWISXn0vyNci2dZ/lIi+IwOkB3zslITcuBJZw
         VuOSVyHoTDh1UTZjD86vqKyAjI0br1l7tNZ9d+W6yIZK8FhzugzvqBeAIGQSSmIwDJHp
         7lJD9FXWPtND6d99tgaW9NQa7Sptmm4pbUciiNW0J6jbE5gSm+OYrB6SR06YOYlEyuEx
         XG5w==
X-Gm-Message-State: AOAM533PqfJs85ZrFKSAzC8dSLiWDmeDq8SH3a+E+em9Yu6qMBOAA5sL
        CcwASSGreqaMNAxbTFvvOhuB7Q==
X-Google-Smtp-Source: ABdhPJyQibgCzqK7N2jnCNnhCK1tSEVAws6CXxjHT8O0zK/hOFoMmYMF6ToVfj7Q12aSwrgiskTwIQ==
X-Received: by 2002:a05:6214:5081:: with SMTP id kk1mr1932846qvb.112.1644290558185;
        Mon, 07 Feb 2022 19:22:38 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u35sm6948625qtc.26.2022.02.07.19.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 19:22:35 -0800 (PST)
Date:   Mon, 7 Feb 2022 19:22:22 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     CGEL <cgel.zte@gmail.com>
cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] psi: Treat ksm swapping in copy as memstall
In-Reply-To: <61f35591.1c69fb81.48dad.3244@mx.google.com>
Message-ID: <72532675-d898-9f30-1ba4-318fbd61786@google.com>
References: <20220116152150.859520-1-yang.yang29@zte.com.cn> <YeVdvVVBvrXH5U0L@cmpxchg.org> <61e7ac25.1c69fb81.e8938.bc67@mx.google.com> <YegK7+oKFG8EPRp9@cmpxchg.org> <61ea820f.1c69fb81.e79d5.09c9@mx.google.com> <YfNG5KAog6fI0kYu@cmpxchg.org>
 <61f35591.1c69fb81.48dad.3244@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022, CGEL wrote:
> On Thu, Jan 27, 2022 at 08:29:08PM -0500, Johannes Weiner wrote:
> > On Fri, Jan 21, 2022 at 09:51:08AM +0000, CGEL wrote:
> > >  Wed, Jan 19, 2022 at 07:58:23AM -0500, Johannes Weiner wrote:
> > > > On Wed, Jan 19, 2022 at 06:13:54AM +0000, CGEL wrote:
> > > > > I did a test, when we use zram, it takes longer time for ksm copying than
> > > > > swap_readpage(). Ksm copying average takes 147263ns, swap_readpage()
> > > > > average takes 55639ns. So I think this patch is reasonable.
> > > > 
> > > > Ok, that sounds reasonable to me as well. Please add the
> > > > PageWorkingset() check and resubmit the patch. Thanks!
> > > I am a litte confused about adding PageWorkingset(), since I
> > > think ksm_might_need_to_copy() memstall is like swap_readpage()
> > > memstall and swap_readpage() doesn't add PageWorkingset().
> > 
> > That's actually a bug! It should do that.
> I recently found that too. Please CC to me your new patch, thanks!
> And I will send V2 of this patch "psi: Treat ksm swapping in copy
> as memstall" with PageWorkingset().

I'm entirely PSI-ignorant, and reluctant to disagree with Johannes,
but I don't see how your patch to ksm_might_need_to_copy() could be
correct - maybe the "swapping" in your subject is confusing.

There is no PSI enter and exit around the page allocation and copying
in wp_page_copy(), so why in the analogous ksm_might_need_to_copy()?

Hugh
