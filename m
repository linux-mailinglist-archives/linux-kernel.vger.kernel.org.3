Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB57547DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 04:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbiFMCrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 22:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiFMCq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 22:46:58 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEC425FF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 19:46:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 187so4572417pfu.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 19:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X9KlT/th/NEPHvU/mvKmYtxJ9mQBWC3ItPq9ZAOwK9Q=;
        b=Cgc+WHAN9bqJckXfuAa0sPbHyJRa/IXuhmUxjX+4d22yoEd8foos1ijobXnMprDHrs
         trykDs4W4P/ZuSD8jk75ZohL/euGgmk82ptlH0Oj/8NFKrSvCafL6pKwkQFxUzNB3tn8
         O+679vEge3sFNz0Ax/AXtxL7V4Kfn8rwhrlbINdWSP0HETyyApvnLCKlezl4O7mco8WZ
         /Yl15yhicY3S/hJiq9e15b+GM+pzDi6uCXgOO9MHjt5xN7NyplzvLlNtvRoI3DFtRQvu
         SthtPOOR05m5vm0dxSCb6lhPLtUkDeF56aZytaGWd6mRL3sCgPrP3me3swqwelNbJkbG
         mv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=X9KlT/th/NEPHvU/mvKmYtxJ9mQBWC3ItPq9ZAOwK9Q=;
        b=XRVtgSPAq0TCr4Y+6TMl/YsK2AJP+BseAsniTngTQscsTz9ilyQsX9T7URin0KIAOC
         NoR+9dkq6XwvYEbMOFzOk0Yp4AB3r8jwHEFZNDqpT8w8B4lukpyMybjH50qjHJsH8NYj
         szY4ID+cef93SaScw5lPs9QZ9mKHSX04ZMXOcPMDcRq3kzoxsdVmE/xA3lL8tNCU4S4U
         sxNahsEW7EAlpYr+wT/UljjGAEsXEm9Bw9Hy3tbPKNyKA8O9SkKfhmvKyWgweHyPlJVF
         jjbyrcoDcBcU1OHN2NDGimNoM8OUbpZZDpSEehFOEE3V1H27mRi0pO4Zl/oCDPBPkHsZ
         75BQ==
X-Gm-Message-State: AOAM532DxQzkXAMReJeI7pBFFwE6uui9vgugX8L9VkAc3Hq2yHrqReX+
        Bdds4jq5B3KV8HER4ogwoYb8aSEqoJI=
X-Google-Smtp-Source: ABdhPJzFLVCRMUr200HJoIyk015wY4pPFJJXfMuHySdBPiZ5UqU+lE8FhDkbq2t/CHpF04o9Otkl9A==
X-Received: by 2002:a63:2a97:0:b0:3fe:1929:d05 with SMTP id q145-20020a632a97000000b003fe19290d05mr25540441pgq.58.1655088417331;
        Sun, 12 Jun 2022 19:46:57 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k6-20020a17090a3cc600b001e345c579d5sm3838119pjd.26.2022.06.12.19.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 19:46:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 12 Jun 2022 16:46:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/4] kernfs: make ->attr.open RCU protected.
Message-ID: <YqalHuEB6OjjUosV@slm.duckdns.org>
References: <20220602063907.136569-1-imran.f.khan@oracle.com>
 <20220602063907.136569-2-imran.f.khan@oracle.com>
 <YqYpTShTDLvAp4vx@slm.duckdns.org>
 <6d1c5a49-fc16-5fc7-e527-8cb91ec0d25c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d1c5a49-fc16-5fc7-e527-8cb91ec0d25c@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jun 13, 2022 at 12:36:12PM +1000, Imran Khan wrote:
> >> +static struct kernfs_open_node *
> >> +kernfs_check_open_node_protected(struct kernfs_node *kn)
> >> +{
> >> +	return rcu_dereference_check(kn->attr.open,
> >> +				      lockdep_is_held(&kernfs_open_file_mutex));
> >> +}
> > 
> > I don't understand why the above is necessary. Whether you're a reader or
> > writer, you can deref the pointer w/ _protected as long as you're holding
> > the lock, right?
> 
> As per [1], we should use rcu_dereference_check() for the reader side when we
> are holding the lock.

Hmm.... can you quote the exact phrase that you took the above from?

Thanks.

-- 
tejun
