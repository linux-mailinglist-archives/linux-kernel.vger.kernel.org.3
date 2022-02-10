Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CEB4B1652
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344027AbiBJTaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:30:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241448AbiBJT36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:29:58 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2ABD62
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:29:59 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so6564973pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JEtaSIPUmwPMEbht/8GtpdgCpAImz37J+lOV4wPhprY=;
        b=aUPjrbgO33gzzmshctnoKvqOJvUxoWLMN42XPnz4Vokls/etwnpBR1+icvCJ7InEKU
         yA+FswwCL3wJSPkXrnkU9/XqlprHFyMpdCVZsa3Za/szdtUQHgmgxTGZnS85bd4+DjT3
         nMVP1gXBZss6DtZYothTZlr4WSTHL6uTxqdjhU73IlnN7LFYkW4efH1OryuNDt2Xe9i3
         Ngh5ATcsKtuiyfmCAi1oHmoUx1NGabGWWHDJd+9n+2R4JI77QCh192SfMDwH9yFiFs4Q
         JAcpdNNN+jQaDOHnFs6fNsSN0mDWDL3yyaEOBKLWrJAKXtOQi5GY3dm/A0mCMk3yRXho
         l0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JEtaSIPUmwPMEbht/8GtpdgCpAImz37J+lOV4wPhprY=;
        b=1VzOAfgKLdlv2rdhECNjf6irQy2bNk3t5EqspGqh+18Cw/AGSrwmYAVYftbyjWwCNb
         p4ns/kjjIyzyxyfwo0TrFXAusj2qFeCQzc2sPQeP4PzrRL1MBEsgrpCgP7eixkAgRkhw
         eOYeoFzvLa1ijbGPNNbKl0cc/Jb+wBaGwZkraaCXXZIxj5H4PHq1N+EkdAL7a83VAwlO
         1Y/TNbYh5ASiQqqy9Be7murHItruO/8no2JW49NOdspnHRUgKH2psSOBWQJeKs/4E7Ss
         Ph4HvWXa/Yt5LLGMRvAalmnfPeHxOsGXjyIDOXOrJ+icFUqQitfazM89p+Xtp0pLTCvd
         3SZg==
X-Gm-Message-State: AOAM532jIWACo4ehlE6H7W0+BaJHh65vqTHyIGD4SwM8Xv3z7ksOYXWx
        BqpkZyudB3Accm0Pg3dPGPE=
X-Google-Smtp-Source: ABdhPJwOGnBgHG33xKvmltVSm6jAf0YDvFUD92BcxdXu4vCOUEV1rYv5+YecvAz/A+pxM0U2EGWzsg==
X-Received: by 2002:a17:902:c702:: with SMTP id p2mr9003202plp.37.1644521398357;
        Thu, 10 Feb 2022 11:29:58 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4c8c:3496:9911:5b66])
        by smtp.gmail.com with ESMTPSA id r7sm11913794pgv.15.2022.02.10.11.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:29:58 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 10 Feb 2022 11:29:56 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: pin_user_pages supports NULL pages arguments?
Message-ID: <YgVntJO3E+8ILRDV@google.com>
References: <YgVkxwYtLov6Z5WZ@google.com>
 <7b19b521-01cf-fafb-e616-21deced2cd5b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b19b521-01cf-fafb-e616-21deced2cd5b@nvidia.com>
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

On Thu, Feb 10, 2022 at 11:20:31AM -0800, John Hubbard wrote:
> On 2/10/22 11:17, Minchan Kim wrote:
> >   * pin_user_pages() - pin user pages in memory for use by other devices
> >   < snip >
> >   * @pages:      array that receives pointers to the pages pinned.
> >   *              Should be at least nr_pages long. Or NULL, if caller
> >   *              only intends to ensure the pages are faulted in.
> > 
> > pin_user_pages(,, pages = NULL, );
> >    gup_flags |= FOLL_PIN
> >    __get_user_pages_locked
> >      __get_user_pages
> >        ..
> >        VM_BUG_ON(!!pages != !!(gup_flags & (FOLL_GET | FOLL_PIN)));
> 
> Only FOLL_GET or FOLL_PIN are supposed to fill in the **pages array. So
> if a caller passes a null **pages arg, then that caller must not also
> set FOLL_GET or FOLL_PIN. That's what the VM_BUG_ON() is expressing.

Yub, but pin_user_pages adds FOLL_PIN unconditinally and the comments
says it supports NUU pages argument. Isn't it conflict?

> 
> Perhaps that should be part of the documentation. It sort of is already,
> for get_user_pages*().

I expected it was just copied from get_user_pages.
