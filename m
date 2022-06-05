Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB68653DD77
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 19:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351345AbiFERzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 13:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiFERzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 13:55:07 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5F64B1DD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 10:55:06 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 15so4339687qki.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 10:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8tiiUv4eBu5du21eIL4t/D0KywBJvdO3W3xtbfv6aY0=;
        b=Spx54QQbJ3FvO5ogfJ4LHHNYOWvAsInam2fKcwOy+Lkl84OL8pNIuekva1D0OHiItt
         NeXqLtyi55jEqBOamyMhLrLnhLgsqlknzxwHHPWeff+eCDDVwbnPx8IsBziaPM3dkUEA
         +C/zl3Nm/lNAfnRhCC31ALXNXHU5MOCU7cmO9B/2ud1bngrnYUDz1aZOggkMTMfYjawh
         /PTpbC51nvZlq2LjmymLu9ubQklgpSELjXp+Ddx+GETt5BficSeQJa0MGMSmhiWJqvuA
         1g40E3W2NVcALCamauZ+RnmuLSgbhlSNpta1923m3tH9TL6s7c+1UKPUKet/3TaR6Vkr
         Adpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8tiiUv4eBu5du21eIL4t/D0KywBJvdO3W3xtbfv6aY0=;
        b=TV62usqU/elZ0P7rmVicfrT5+BsgEMbr+w4BKY5FpTU8EUAzkXAkKEjQdkheylE4Wy
         mvc56D67npjhO6MO5r4oiXgMvvPZv5wDnUMBd86RjG7iV4vO/Ohl+3xXKAhYaNkXMJgh
         K8BJjiIn8fE8I7H65CU8K3XZ/XI2Yfq4/eR0kshM25t9lPmOBMkjreHtJYO0ykUDHp1R
         I/hJ1o/OaR/AIfLgO8/mo/VBwcjpaYpCpZ4d6tS32twyTPcKH5kDN1NN9ZfMuygse3a3
         MRJsjFlKQicDcrLu9kCl0qK+FQfP1zLg8suz+uT0XHvduKpxkPjG+ID7epQpW+a/S1/I
         Yspg==
X-Gm-Message-State: AOAM533OHlH9FWx6e0izLzCMDOhBsy11vEDw/mqfTkv1K8jAlmQ6CQx2
        a4pKcrPB54GYKbHKp1xVVtpApnRUTyiL
X-Google-Smtp-Source: ABdhPJyYRaDiFIB3LGVc4ZE/PLH4eHVidb3WcE9+L9raD+RloeB2RA+R/u+PAKVWLkwD51ewuaDHMg==
X-Received: by 2002:a37:8701:0:b0:6a5:ff4f:b2bc with SMTP id j1-20020a378701000000b006a5ff4fb2bcmr13483219qkd.584.1654451705953;
        Sun, 05 Jun 2022 10:55:05 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id br9-20020a05620a460900b006a6539862f8sm10272057qkb.40.2022.06.05.10.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 10:55:05 -0700 (PDT)
Date:   Sun, 5 Jun 2022 13:55:03 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com
Subject: Re: [PATCH v3 00/33] Printbufs
Message-ID: <20220605175503.ug3cjtv5tjmmornx@moria.home.lan>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
 <20220605122110.22176bd9@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605122110.22176bd9@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 12:21:10PM -0400, Steven Rostedt wrote:
> On Sat,  4 Jun 2022 15:30:09 -0400
> Kent Overstreet <kent.overstreet@gmail.com> wrote:
> 
> > Printbufs, your new data structure for all your string-building and outputting
> > needs!
> > 
> > git repo: https://evilpiepirate.org/git/bcachefs.git/log/?h=printbuf_v3
> 
> Hi Kent,
> 
> Just wanted to let you know that I want to review this and I'm not
> ignoring it. But there's a still quite a bit in my queue that I must
> review before I get to this, so it may still be a while. :-/

Could you just review the parts that touch your code then? The rest has already
seen some review and Petr's going to do more, and I'd like to get this patchset
done and squared away so I can go back to building my OOM debugging improvements
on top of this stuff :)
