Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0486C4C002F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiBVRaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiBVRaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:30:18 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2A11704EF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:29:52 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id u16so12748908pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vh3CaiCMI4LYCw7gOppCXTcSJXSh9VoQ9nFVl2kwI0Q=;
        b=YHjdPhssPsuXUnpb5L3MwbBzPRtkWVauMDE7yZfEK1xt644kH5ZXOw9xHVCNP8zhsE
         kN2FEBFEzLsYcgiu5kAyN6Aw344lq66A3NNP7xis5kDyqVn3M1ZIJ2zzi/rjxHLoOFY7
         1TKOMxIAupI+j/f/Bgu1Y5ty/rrQOuls1ufP6m4eWbkUwxPJv0Tpgwi8vz2upObvnkjT
         kwEys3/+XlVB9Eg+lenF1C/wWeDaaWHZ6U1BFLb2gr+2XEoFS9gh9OBVjcQWksZL2Gdl
         Y5HUDoA/3n1yLZlztLwh5O0xTqsmBIia3i3nWc+ryxdbrawaVTOcpMKfxrpiJCcdSIHM
         xvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vh3CaiCMI4LYCw7gOppCXTcSJXSh9VoQ9nFVl2kwI0Q=;
        b=ade5hwwbqAavBOUHgLs0ixQl/oPCiE5Yg/zW/u4/cXsvEubHe4ALPddAe8gtZdjgvw
         DkD07flyE11mN5GIfcCubEI7iU11f8qW/Fbw4t6bnP7mWbVe7c0aI6VtTVlR9HNu7yNq
         szuvTANFjS/M7ABXtAXGMpO+EPbaPqOWREbJWy1Po+zYRheGzr44csy1xLzXFGaHXUus
         xsATJXkY3JUI9Waf6xtuzJzykUkRdMOqI0+xbnGtQPUKJVbKtJUODtlVdspfb/BY3HPs
         xO6WLoKtlH/DxItRsuDiry7fPhimoRILGdjV42lZ6G07CW8gjyWaGw9zerXcsja2coZ9
         36LQ==
X-Gm-Message-State: AOAM530sDuGPqtsZputrOF2PllHApF1FnzpBgpnyKSNRlwQFJMlYMdy1
        Lum9KAXsNJu+72Q0ZRe/kNJ8iJRlnLY=
X-Google-Smtp-Source: ABdhPJx4UZqowLNBaxvhTvfcuzfUzzipYJhVLf6J3K+7SAvu2VJneuK61F1OHDuegm1ugzK6erq07A==
X-Received: by 2002:aa7:88c9:0:b0:4f3:645a:4a11 with SMTP id k9-20020aa788c9000000b004f3645a4a11mr2221960pff.17.1645550992344;
        Tue, 22 Feb 2022 09:29:52 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm150722pju.8.2022.02.22.09.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 09:29:51 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Feb 2022 07:29:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] workqueue: Use private WQ for schedule_on_each_cpu() API
Message-ID: <YhUdjip4VSWe4zDO@slm.duckdns.org>
References: <20220221083358.GC835@xsang-OptiPlex-9020>
 <3a20c799-c18e-dd3a-3161-fee6bca1491e@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a20c799-c18e-dd3a-3161-fee6bca1491e@I-love.SAKURA.ne.jp>
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

On Mon, Feb 21, 2022 at 07:38:09PM +0900, Tetsuo Handa wrote:
> Since schedule_on_each_cpu() calls schedule_work_on() and flush_work(),
> we should avoid using system_wq in order to avoid unexpected locking
> dependency.

I don't get it. schedule_on_each_cpu() is flushing each work item and thus
shouldn't need its own flushing domain. What's this change for?

Thanks.

-- 
tejun
