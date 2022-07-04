Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B0B5657DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiGDNx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiGDNxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:53:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E674E26F7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:53:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso4372835pjo.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fm9sLVMzMrF0JEzy4i5Ix9ZeBV19Ov/P7FIJPiALsMY=;
        b=7oM8TL3pQ/hBMS+x24c0dg0P9Ge8mRR7QKOit7uWIL3ys9FcBlG+WkMtN+wQrEEmVZ
         tp1Cw5wbFg/9yAtpI9b5cMw4b17+ZqB3BXLecWNlxZSjV4jQtnZYC9jwL+sHjRph60N0
         WE9hIi19RX7BCGcA9tJ09d0uS4RysWa8mOGYeefCxzh00E0sywRGHvEQ7J9k2hO2L00J
         aQmcopZfE7aJvp16DwF/gQG/kcSlBcFknUYUYZFMb1r2Amqz9LBwP3W5gaUny0kfzEtk
         amdWpJ8wAdlGWR+Uem/in/XM7Z6Yz9ZLIRhHCFobKlsK92JJyw9JKWw9WJ+JfooZRLr+
         uUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fm9sLVMzMrF0JEzy4i5Ix9ZeBV19Ov/P7FIJPiALsMY=;
        b=L6avj4JoOGSPdWeLzacEPQCGY7LU1yqZEiZITFUOybAj9KfsvuSYFKUrTvrdLiCqW6
         Z7MfovRpUgUuLZC3xB68puhH1RfL1cYbZHQ5zeP7OpNMkG+J6c2pcDvnhSvpPcjZqZJg
         z4OYIQmbcXqk7J6H1U9UnKiZ7aemovTgHWMBY5DFFxIM6dsXUylnoj9hIRsAljRrPP/I
         QbZ3YXlUh+2sUPpHi6DNpr8L9Cy9SrtwJq5xODoToEaJX9cd0UhuFTduxUGlsIYnMuYL
         cPwzFucS6Qe/48VZ9MjT/sqL3JWR5ksNeQxsp0KRghxVwc2Xyt59rzHbbIbfErcoi0p6
         8UkQ==
X-Gm-Message-State: AJIora9XwvNlkD1yREcKSLYuxJXPAcT5FNzKbZu9Hyx57rVrug0c4puN
        a38njFY6XqpmjTol1OfFDQuPbw==
X-Google-Smtp-Source: AGRyM1smOvkNWfIiM+++kF1EnH/TM3XV2TSCu9cMYbdIs3rkHynl0mQ9wXbnIQFFotucUwAUfJmYXQ==
X-Received: by 2002:a17:90b:1e06:b0:1ec:b396:7468 with SMTP id pg6-20020a17090b1e0600b001ecb3967468mr36274814pjb.63.1656942802351;
        Mon, 04 Jul 2022 06:53:22 -0700 (PDT)
Received: from localhost ([2408:8207:18d5:ce0:b44a:d6ac:cbc5:89fd])
        by smtp.gmail.com with ESMTPSA id z29-20020aa7949d000000b0052515e20df8sm21223980pfk.152.2022.07.04.06.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 06:53:21 -0700 (PDT)
Date:   Mon, 4 Jul 2022 21:53:19 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/16] mm/huge_memory: use helper touch_pmd in
 huge_pmd_set_accessed
Message-ID: <YsLwz0IK9/kI9tFF@FVFYT0MHHV2J.googleapis.com>
References: <20220704132201.14611-1-linmiaohe@huawei.com>
 <20220704132201.14611-6-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704132201.14611-6-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 09:21:50PM +0800, Miaohe Lin wrote:
> Use helper touch_pmd to set pmd accessed to simplify the code and improve
> the readability. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
