Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766764C323C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiBXQxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiBXQxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:53:38 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE37140746;
        Thu, 24 Feb 2022 08:53:08 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id q11so2237903pln.11;
        Thu, 24 Feb 2022 08:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lcnz2zjfxCgMkLxPxLNYpBqRn/BJiazJDqJnM371Fso=;
        b=CJxNaJCBRSgCBTuSlz9/lHBPVVdIbJgBI61Xa3dkm08KFuxwM2uLTuQ6UK04gbA9Ju
         smyFlKW1mrfiSV0Z3vDnzrTwfoaySbkLL8JNoYxBh1e9I5Xbfvw7iBYtkGac8PLIlrF+
         OqJvdj1dzyw2qfRL8F9WOMPqsMKVMg1Ha+ODs5g1Hl5+PfUgQXYRSuvePu/MCTYqS8KE
         nV1sBpSzMdY0AEyajO25OMRDqMw7+xWtXT4OwX1oYlOb31HOli2gy9DyoHRUNB0oYqDg
         SJWQaN9uaXeF65sPx6sUihuH+Ve8BhuLwC/cLnBfeGhsDOK9O3P2qbwgkspR7N2CBmEU
         KU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lcnz2zjfxCgMkLxPxLNYpBqRn/BJiazJDqJnM371Fso=;
        b=jRzEkAYVI87KXSuJ29lN9xkC9CUd6mETQyCsHEACOsZWO1vZijCdw16RGlTONBH3zS
         C9UTm5Gk3d6Qn4IfUvxyl2peoa5i7pz3L14XVvllMfZt6232bUahcyOde0NEq7bUHfrm
         MZGZOrBCOxRsBzR4KJuF8h/S7pq35mcgZ3+PKhUN37WWMG/DRKjgPeQEgizo17r/JdHY
         KMYBLp75Qy8JveA32z52205h7Bya8Keswx4NkBtjjW4eIgMDGKFQzxOI31thY02pafkF
         XfgM1vy8PqemJs6PWnXVrtw5xVUh5FOoRvveD1ioQQsS03fBW0qNvQs7YJVr/0d8JKu/
         mhNA==
X-Gm-Message-State: AOAM531NrKlRQtNpz2d3IHIPWvxyUMo+mzhFKEGd4kXS83sDgNBaqywR
        chzruYjVA5APsf8J1S8Eh8k=
X-Google-Smtp-Source: ABdhPJzrkmVf0iQcqvVfKJ/yExrp30gZgR9ZZsdvX8u+ZdD5qcosZuc5zkAu+mx7S055zhSlAzft+Q==
X-Received: by 2002:a17:903:1c6:b0:14f:45c3:6c29 with SMTP id e6-20020a17090301c600b0014f45c36c29mr3448588plh.77.1645721587945;
        Thu, 24 Feb 2022 08:53:07 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id np11sm3393720pjb.25.2022.02.24.08.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:53:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 24 Feb 2022 06:53:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V4 1/6] blk: prepare to make blk-rq-qos pluggable and
 modular
Message-ID: <Yhe38VnBq7VzUBAV@slm.duckdns.org>
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-2-jianchao.wan9@gmail.com>
 <YhUbCH+dhKkgMirE@slm.duckdns.org>
 <2e17c058-8917-4a37-896e-1093446339f6@gmail.com>
 <39db454d-ca30-fb42-3d72-899efa34fb78@gmail.com>
 <YhapCurbiI21WYmm@slm.duckdns.org>
 <efd94670-9d6d-5651-358c-2f88646298cd@gmail.com>
 <Yhbod7pJ1X4CGhEZ@slm.duckdns.org>
 <7489a7f8-2589-29de-1c95-b99d1d9b1850@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7489a7f8-2589-29de-1c95-b99d1d9b1850@gmail.com>
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

On Thu, Feb 24, 2022 at 10:50:22AM +0800, Wang Jianchao wrote:
> Yes, right now, every policy has their own way to turn off, but we always need to
> iterate the rqos list and enter into the policy's callback to check it. And every
> blkio cgroup needs to allocate memory for it even we don't use it.
> 
> I don't this patchset is adding a new layer, but blk-rq-qos layer has been already
> there , we just add a unified interface to open/close the policies.

We're talking in circles. We already know when a policy is inactive. If it
sits in hot path in that state, take it off whatever gets iterated in hot
path and put it back on when it actually gets enabled. The same goes for
memory allocation. If there's substantial amount of memory allocted while
not used, make that dynamic and trigger it when the policy starts getting
used. It makes no sense to add another enable/disable interface on top.

FWIW, please consider the series nacked on this side.

Thanks.

-- 
tejun
