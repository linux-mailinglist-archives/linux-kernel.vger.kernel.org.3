Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1638950018B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 00:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiDMWIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 18:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbiDMWIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:08:32 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6E413E27
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 15:06:09 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q3so3114532plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 15:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TkOV5v3hXeRRZE7H5Vq1vLrZTdrHF1lFjpXd5xGlls=;
        b=q6sK4N3fFAyBdutlj3pA0WimzP1uGFTAe5+cE/dtB9yEAOFJIyKZsB84DqxChLidKx
         NU/g4XTKeQyD1+NLhsWf4RjmS2Fc1e0IJxDFaMN1dwYTZm+wByCBelYAyI1hISqJE/pY
         LYZ60ezMfuPQDGcV5PwaYU0RF9MTdkNiLzp0vMq33AAqgaT83wWiyVpFU0uTtOFjlNm0
         KLUinkvgkYLebCQXnIHpVm8jqXLkscZKeTq2fWyu5Bwd88Si7Lkim091Tik+Cq9bIZ0E
         x+2qoKZbDouq5Tkz+/6THbFbhmvGk1OUcm2EqH8Aw92H7EQPHtZ4kRYCBeNXvKpmxZyP
         lYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TkOV5v3hXeRRZE7H5Vq1vLrZTdrHF1lFjpXd5xGlls=;
        b=zkxsjvfUBV9Dmd/b5h6qO0XXMLfwSpVuh61ii6budW3zyCzR7M64j5lRy0U5vd5olC
         n2J9SE5owHT+NsYZUgcR/KvmWluvs1le5uLuHv6DD2HCSX60tILa0T613An4khgEEwrN
         1kErYSWtgm+savMd10K1OQQny+ZkiF/hHPEX1W28yQxK/70+SmJNpshpFg4Jo0n6522i
         8U/9eRKtcw7UGXoCZ3eFbp3Dxp652cD5LVNV8HlaA362QAJw35na04kYcRL5yFjzq6dZ
         Xe94cYLEhVKQIjJGlVDl9dgpJVChzjaCRtrwTEPHfxXBEtOMqWAgN8AdCV5kC9L5JQTF
         2H3A==
X-Gm-Message-State: AOAM5336z0BwBf1EyTageeUDanXHiWc1HLABZk23cBY9h0Gfa3AFViBI
        C90oZqQxon5ROITK1ykoFoaKhrvc6s9WxZ+yV2FoEQ==
X-Google-Smtp-Source: ABdhPJzQWdsUZCwUxrbytfbWfiMVW0aRlZe6t/+QfsydcXfayxcE9qafFVe9BtUEBFbnbNU/t1NH5fSWq09IxrTa06I=
X-Received: by 2002:a17:90a:430d:b0:1bc:f340:8096 with SMTP id
 q13-20020a17090a430d00b001bcf3408096mr266248pjg.93.1649887569436; Wed, 13 Apr
 2022 15:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164982970436.684294.12004091884213856239.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220413093949.GW2731@worktop.programming.kicks-ass.net>
In-Reply-To: <20220413093949.GW2731@worktop.programming.kicks-ass.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Apr 2022 15:05:58 -0700
Message-ID: <CAPcyv4g-88D=ysgY5aXS9-jDM+KzPqpUoKi8VxBQeK4WKtcRHw@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] cxl/core: Refactor a cxl_lock_class() out of cxl_nested_lock()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 2:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> *Completely* untested (I wouldn't know where to begin and probably odn't
> have the hardware anyway), and known incomplete.
>
> What's wrong with something like this then?
>

I'll give it a shot, I think it solves all the cringeworthy aspects of
what I proposed.
