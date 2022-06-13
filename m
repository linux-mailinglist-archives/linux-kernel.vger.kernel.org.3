Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C294554803E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbiFMHPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiFMHPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:15:07 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375491A3A6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:15:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id bo5so5001345pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ryeH9bTEtbNft6a8+l0Ww/QD0tPIB9O2GIzjchd0JQ8=;
        b=7Z2m+UanT7leluCE0awhNxUgN/zvt+QgLX41xEJAkZ+hZl9VI2EHpDcYFUppZ9BKoY
         50fge9XUhht5/9Jy98ZmwWcEyX6y0D12e8O+OcFKcGMtINA54VotW1Re/vgDyk53Ukdm
         IHxc1+r+vMC9HH0wgZhf2TJdBx5q2rbxsUSIztrzJbjkJ804j6UTeS5RqqRNrRkuRW6M
         zyXgQD365z1Sc+96lW/fEZVdEBCWAefn+rXwdENfblHqcGEtDQrRctODB4Opn2iWL40a
         99tK75i+ilgO4NFf/w7KwY3VOplAn0WgtizKYpUhR3effzvDCve7a3XIeOS6hX6DqZzx
         pZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ryeH9bTEtbNft6a8+l0Ww/QD0tPIB9O2GIzjchd0JQ8=;
        b=JFwQnpVegLwpleVxFtHu/RZZ4a073GHAr8NTyuGOZN0PEK44RaOgfMPSgNyA4MKpgo
         CfCxp4Dqkae9SogZe8uB4m85EmUsHUgHgxbzSEbp5dEH0vWx6Z2+PWYKa1y3JmyOOHTo
         YzLln7ATzMevlroJObQ+ine8dDEfoQ+cmdPzGzpqhqw/J7UdFAntqKsCXn+29ZcMotXf
         7Cl3fexOgQk0VChP+u5hN2r+lt3feDAAXtfXzkVFIE5ggui+8JhsLNDR5yInOYgu743X
         HPFbTX6lZsn1pY0qY63grU6ZFCSiJydHCGj3Lkg2COgJd9dE6BK3qJnjdSTHK3yqeBI8
         8Q2Q==
X-Gm-Message-State: AOAM531T/UO1KFbpeZC76nuV5mhVHsyUb46karGfqHrCr0zWLfzBeia+
        5b26qL5gmQ55VihI8DfkV6I/LQ==
X-Google-Smtp-Source: ABdhPJzHmwvUgcBKOSqyUg5vAuPr66x5IQQXFrWOSIsM17SUv8GbRUJd/cQ3bPRDaT8Mt+cFaz4YcQ==
X-Received: by 2002:a63:4853:0:b0:3fa:dc6:7ac2 with SMTP id x19-20020a634853000000b003fa0dc67ac2mr50831303pgk.298.1655104505694;
        Mon, 13 Jun 2022 00:15:05 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090302c200b00168d9630b49sm2205628plk.307.2022.06.13.00.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 00:15:05 -0700 (PDT)
Date:   Mon, 13 Jun 2022 15:15:02 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/kmemleak: Use _irq lock/unlock variants in
 kmemleak_scan/_clear()
Message-ID: <Yqbj9vxGrpuBlMuc@FVFYT0MHHV2J.usts.net>
References: <20220612183301.981616-1-longman@redhat.com>
 <20220612183301.981616-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612183301.981616-2-longman@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 02:32:59PM -0400, Waiman Long wrote:
> The kmemleak_scan() function is called only from the kmemleak scan
> thread or from write to the kmemleak debugfs file. Both are in task
> context and so we can directly use the simpler _irq() lock/unlock calls
> instead of the more complex _irqsave/_irqrestore variants.
> 
> Similarly, kmemleak_clear() is called only from write to the kmemleak
> debugfs file. The same change can be applied.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
