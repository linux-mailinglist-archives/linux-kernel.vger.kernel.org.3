Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378534E9D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbiC1Rbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiC1Rbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:31:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676B8633A2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:30:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mp11-20020a17090b190b00b001c79aa8fac4so264765pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2rbg0zjEEZcrrrki0TLW7AmDf91MrcPr+Sit2fUDac0=;
        b=T50k+e8A1/6vv1rfaDGOCv8B5qU1VUl408G2Ln8z6Jp25Qjr8AdOCZrDGIrNWXxnGm
         c4NJx+VC/TJj02rrHHOIJdBBhvpand0nvwJrHjfwKAcIyWJmWDDZxuk10DEJXrJd7JOM
         eo38/C9E92JT2x3fyk0853ktk/jORrKo2Rh6U7FHXT/LXAd2bOAqXQ6bmgOowANp3cOC
         nGbuBfY2YGJrn4c0ZEXM7UCHbeNgF9faf5TscSYF2y7v/0E1nX2chDkmXCCJE6CWTF5T
         K6PIArSmkRwohFu4bcuSmwg0XSm7Hsz5z7jE7GKebgV7Cv+37AZXC3YqvCmXZADTbm3n
         REWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2rbg0zjEEZcrrrki0TLW7AmDf91MrcPr+Sit2fUDac0=;
        b=x06alG4o1ZjSjz5KQQrOSbS+5w9yLaipBeUMTH6jCj6t+7yIMuy03Isaic4S0k1iAy
         9hp1DJXCdrCV2xPt2IyEj8G+5iMy4VEVxKeSQt3JjLbr/QHdKbm8uUIKWO+v288nmmu2
         Vwq10a8oNEQ8QptPvxtxon9b0vJ7ORZhq9+7VZXemYwGB8QID0KARg+I6Y+NTTfbtLc7
         0FPrthnUKH/FxwD0FnWN9HBqnpepVgra9olsmDAhRolGAA6/vJAoAXoF2M996f8zuU+8
         dfR9qkpQK2xjy9KurDziTyhO7TjedTyoTvSm19pzGiux5eCx0KRPr4Eq59wUlr3cqQTO
         yMFw==
X-Gm-Message-State: AOAM530Aa+NuZ4jVaqWqhAE1POeXBdneSE/2fjGh5Sjx/Qx9I+pDzwnu
        uYDCosJQ7GTM//WNm82jCW0=
X-Google-Smtp-Source: ABdhPJx4XIuVX7JbWq9Yd7WuK4wvV525Y3fxmMqq9rs5w970A+gth+x7NsJzcOwJ6+d3mdDOY8VPQQ==
X-Received: by 2002:a17:90a:c28c:b0:1c9:9eef:6e2b with SMTP id f12-20020a17090ac28c00b001c99eef6e2bmr232555pjt.188.1648488604648;
        Mon, 28 Mar 2022 10:30:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:3b11])
        by smtp.gmail.com with ESMTPSA id nn7-20020a17090b38c700b001c9ba103530sm100826pjb.48.2022.03.28.10.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 10:30:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 28 Mar 2022 07:30:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 7/8] kernfs: Replace per-fs rwsem with hashed
 rwsems.
Message-ID: <YkHwmhOaSHuXPemP@slm.duckdns.org>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-8-imran.f.khan@oracle.com>
 <YjPNOQJf/Wxa4YeV@zeniv-ca.linux.org.uk>
 <536f2392-45d2-2f43-5e9d-01ef50e33126@oracle.com>
 <YjgpaeFfFandY999@zeniv-ca.linux.org.uk>
 <Yjir/d5S3J1PTiux@slm.duckdns.org>
 <Yji8KT2K7ZKOQ+6S@zeniv-ca.linux.org.uk>
 <YjjP5ldCCGYqD+UV@slm.duckdns.org>
 <Yjk3Nqft/U6vDvd1@zeniv-ca.linux.org.uk>
 <a692a5af-158e-ad0c-63a1-6525ee6d3898@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a692a5af-158e-ad0c-63a1-6525ee6d3898@oracle.com>
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

On Mon, Mar 28, 2022 at 11:15:30AM +1100, Imran Khan wrote:
> Hello Al,
> 
> On 22/3/22 1:40 pm, Al Viro wrote:
> [...]
> > 
> > Sorry, misread that thing - the reason it copies the damn thing at all is
> > the use of strsep().  Yecch...  Rule of the thumb regarding strsep() use,
> > be it in kernel or in the userland: don't.  It's almost never the right
> > primitive to use.
> > 
> > Lookups should use qstr; it has both the length and place for hash.
> > Switch kernfs_find_ns() to that (and lift the calculation of length
> > into the callers that do not have it - note that kernfs_iop_lookup()
> > does) and you don't need the strsep() shite (or copying) anymore.
> > 
> 
> Regarding using qstr in kernfs_find_ns, do you mean that I should remove
> ->name and ->hash with a ->qstr in kernfs_node and further modify
> kernfs_name_compare to make use of qstr.name and qstr.hash.
> 
> Also the suggestion about removing buffer copying from kernfs_walk_ns is
> not clear to me because kernfs_walk_ns invokes kernfs_find_ns with
> individual path components so we need some mechanism to separate path
> components.
> 
> Sorry if I have missed or misunderstood something in your suggestion.

qstr encodes the lenght of the string and doesn't need the terminating '\0',
so we can just walk qstr over the passed in path instead of copying and
overwriting '\0'. This is rather separate and we can revisit this later tho.

Thanks.

-- 
tejun
