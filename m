Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704AA533DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbiEYNZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244434AbiEYNZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:25:13 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25902B1B4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:25:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fw21-20020a17090b129500b001df9f62edd6so4070738pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TKu3jDxR1qyaoZyxQd8Ts5G700gfE4pahytHEbPkEuo=;
        b=GXtzlSsV72DJ4r7qA3ECNDCXmSDzD8JR+b7SloEDQLdYm1Ra/ZpSJk2ACoplR9lw4J
         8fqymQa/ZL0HYinpuFgcXOXxZRd/zF6n72jKlTNQRV9dpq0D6UX0i5on8X/oNtwuLC5U
         iIK1AyD1hM2JWl5CiM8yckZo7u1n/GdB7j5wbub/+rF3ww76dZXgPymJMPnltPFfmEZN
         VdpdZz/hpeiVxZRJPlgN/ztZasy+PLIfvkG2Flt3OQAQsyC9oeoKlO/F43PLMwyyQ9P+
         Pp/9Nvh9eIkub2B8hVSz6WjmJmTsOHnQE4BMc+/lXsld8wAiPyWgPyTTY1qr0q/iz8vf
         11tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TKu3jDxR1qyaoZyxQd8Ts5G700gfE4pahytHEbPkEuo=;
        b=yp0mhrGsb35ZLXtZ/gEykCsWyAIvlCRtkox33Xwlg7Dy0SWFK2S0i/BTsUBgFbQVuX
         SYb5DMf/KzVXipdkJG/d88JPtSEf7Tag5jzG5L37h0Rk99Gc65IUQWUG4IdtMdgdt885
         kbNgz0fBeqJFLK/IGMTjsxz5jpX2P+O6fmSuO4GtbN6PMnesv82DOmVxTpnTtQeMNRT3
         aOoO1Bdd9vl3oCzGFaQP4N8teBVjePGZ63RHirCMwDXRd9nTdwEDmW6kY0nZuHH6ixFm
         5xwF1kdo8pP/VPORROVJM+tGZ8YOuplNFZ5HSHqrwC26YVt7VsFaxv1Ql1eXve2J0HGp
         XNNg==
X-Gm-Message-State: AOAM530OAlB+P/A9a3Q88U4b2UHD8AjMegQ9LlDim+iQhOiWq+WtMtGA
        8WkYX2JB8LzmOu3qcshCiWAC69HjAv8rmg==
X-Google-Smtp-Source: ABdhPJyN50WS/ZtJCxkiUtPA7dalNKgxc+rog0QkB9FGU0KBuqFIf2s5Rr1fKS9zMJ2Rv4ytEghz5Q==
X-Received: by 2002:a17:902:eb4d:b0:15e:d25c:4e0a with SMTP id i13-20020a170902eb4d00b0015ed25c4e0amr33288707pli.8.1653485112355;
        Wed, 25 May 2022 06:25:12 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903209100b0015e8e7db067sm9225346plc.4.2022.05.25.06.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:25:12 -0700 (PDT)
Date:   Wed, 25 May 2022 21:25:07 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/hugetlb: Remove unnecessary
 huge_ptep_set_access_flags() in hugetlb_mcopy_atomic_pte()
Message-ID: <Yo4uM6sP7Cpx722V@FVFYT0MHHV2J.googleapis.com>
References: <7cd55152c1a00910afda570d1543a97198b3665b.1653468078.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cd55152c1a00910afda570d1543a97198b3665b.1653468078.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 06:26:24PM +0800, Baolin Wang wrote:
> There is no need to update the hugetlb access flags after just setting the
> hugetlb page table entry by set_huge_pte_at(), since the page table entry
> value has no changes. Thus remove the unnecessary huge_ptep_set_access_flags()
> in hugetlb_mcopy_atomic_pte().
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
