Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F54C4D8E64
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbiCNUnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbiCNUmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:42:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0457433E97;
        Mon, 14 Mar 2022 13:41:41 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id a5so16045480pfv.2;
        Mon, 14 Mar 2022 13:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dMQU9SMKR/lWX9t7ZKrdc0ixf/awYY/e1sBD6vIkKPI=;
        b=RrxHYKMJBnyETq0qfUtJd1iGBLZXpi7mjMJFEVIjz11p6q7xjGkQSY/3iLk2WZMasM
         x6fp47eS7duSMT81i4O+nfNKXkZbpkCBpzbOY3d5w3C4krYwww86shhuA/QzhDJrvFO0
         lvJXrhQhnqoxiq/J4nZXspxAzMDT2XdWMwluYz10w9pQIlDB7Thpd6aNvzUkBNRRcgMw
         z2AnC5JRv20+GCgX4GbusF7eF2MuuEBBWy7JY4ubO9gBhDJaESYPgAMyJ/BXCKZjziF7
         eHLr8ucXJ6+HWfMgvHLv5Z5JhVi8iAYcg+EsBRFaGvdXwvcbvhRgOa4Bz5rsTcXNs+/G
         6g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dMQU9SMKR/lWX9t7ZKrdc0ixf/awYY/e1sBD6vIkKPI=;
        b=bEsSwOv5KCXl+AX+xjLcnCWzdohlTQHkh/DGaQt/nNWB8THigQRc89OAMcEcW0bv9F
         hiDiz2OtOWYXOfSQVSDgldlb9STeEZB6gWYk58NJBlSZHU6z5WF5omw4b4iK/iXpixww
         uzgviNLMq/0ct9bDSXUdEWr9xQmEM+VP6v+8Wu+AYgCCitQaWq9eq7OOmB2iVVf61vgA
         wsYzh15SSXeES9jMur4koASsA3J9e5IBODJ0rAoQ5FCDYgaqMJ++Q44pR2sEinni4Ofa
         nmwtWZ5yDCKf6FYoq7ng63V13M078XZIDSdl251w+7GOp7LbsRfeSWEgvdtVJrb4psaz
         eKGQ==
X-Gm-Message-State: AOAM533CHfKFTgeUNiTXMJuZZ+eeenZ+Im2K5ITsDv4tnKlAI3XWg3WU
        JBSRXonqQM8DmyAkGdat4FY=
X-Google-Smtp-Source: ABdhPJx3MBfRuN5zDbXZ+FLahPq7ftjfuDQAvsx25iJ5KKvDXeil8IvDJMbAZNuRbVSLLAVRY+z0sw==
X-Received: by 2002:a65:670a:0:b0:37f:f344:76c1 with SMTP id u10-20020a65670a000000b0037ff34476c1mr21557392pgf.204.1647290500367;
        Mon, 14 Mar 2022 13:41:40 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id na8-20020a17090b4c0800b001bf191ee347sm352677pjb.27.2022.03.14.13.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 13:41:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Mar 2022 10:41:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH block-5.17] block: don't merge across cgroup boundaries
 if iocost or iolatency is active
Message-ID: <Yi+ogt9ahz3yr9RE@slm.duckdns.org>
References: <Yi71WZ3O9/YViHSb@slm.duckdns.org>
 <107965ce-a29a-b5f4-ef87-63b753380891@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <107965ce-a29a-b5f4-ef87-63b753380891@kernel.dk>
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

On Mon, Mar 14, 2022 at 02:12:34PM -0600, Jens Axboe wrote:
> > * Add WARN_ON_ONCE() on blkg mismatch in ioc_rqos_merge() so that we can
> >   easily notice similar failures in the future.
> > 
> > * Make sure iocost enable/disable transitions only happen when iocost is
> >   actually enabled / disabled.
> 
> Is there really no better way to do this than add a lot of expensive
> checks to the fast path?
> 
> Even just inverting the checks so that
> 
> if (req->bio->bi_blkg != bio->bi_blkg)
> 	...
> 
> is checked first would seem a lot saner.
> 
> In any case, since this isn't a new regression, I'd feel a lot better
> deferring it to 5.18.

As discussed, the only risk of removing the disable/enable switch and always
testing is ruining some merges for cases where blkcg is enabled but no
control is applied, which shouldn't be a big problem. I'll redo the patch.

Thanks.

-- 
tejun
