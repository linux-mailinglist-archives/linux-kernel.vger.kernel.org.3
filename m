Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36B152ED12
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347533AbiETN0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349862AbiETN0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:26:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D75441F8E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:26:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w14so14262887lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/1UN+TaMaEHcux1d6IJ2KDdfHYHO4F5ExU+odphW0WU=;
        b=duNEHjCO0S0AOhMSt8aOd7DDMhxLHCQYK4g5GNHpXgS79y73DaQzAHn91LKMBCeOgD
         1ZCPBLge3Cn96dQLOkEBsSLL8tRzqmO3sGp3nbRNnSbFVVEe05nol/Ts0rtg+UAT5qf9
         KrNsl2YTbt0ua/0c/1wDITK3tAgfp6sVbaMT/a5Z5VnEQvz8Oiu5GqFx3STskU1zBxBj
         WAOOE/4pBlOlTxjiZHB9p7CsDOnB+gRVfv5zGcBZsLKkBGcQE8O7ImKGFxpuI6e/D3tb
         3gHeJLsT5Hvg9DpkdOoOJfn7w5twy49l2wvF9yWDtJfERc9MdiKHDpnN+gWxhwOaosHA
         xfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/1UN+TaMaEHcux1d6IJ2KDdfHYHO4F5ExU+odphW0WU=;
        b=xzHqCojVquwapH4EN7uVa65YultU0WhjHIJGF2r5AprVix0FBE7g9JuOmLLmMfWguY
         NU0I50oMODMmwKwyq/2cQ+oIaljUZ1lmxaqdQGRB9yBaGNhSPmq8KoszxVFS6jvyPdEu
         FpmdwH3sVY1qjArmmwD/fyVQDVW9sq1KNSg80pIFACussK7TbMY72RCGDvHSV3I0iXc2
         kRTq+cceAkLzcoY3H1sWMH8NDezvf7uDRvXY3PMXB5ydViEX+LW/2MXvtD6J+TaRlPLm
         S6p28FktoBF+uIgga89D/DWnWr4TwQcpXks8WYHIPeoBC3GPGRnB6M6rEXfQGUnOD7p2
         1d6w==
X-Gm-Message-State: AOAM533TcAELlVSo5Qa53kzAU+j7EBbICVivux7FDLHJtrCWZK9NskBn
        D0JlHN0F7+npQTZjP+uVy68Sjg==
X-Google-Smtp-Source: ABdhPJwzB3/PlRlrkNXbK7mwUivWQKZ0qAFrQcRwuovyF2EoriPwqD771ALNFGv+zdxasA/ruuX6Zg==
X-Received: by 2002:a05:6512:10cf:b0:473:b735:4fae with SMTP id k15-20020a05651210cf00b00473b7354faemr6947736lfg.93.1653053167466;
        Fri, 20 May 2022 06:26:07 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o3-20020ac24e83000000b0047794db1ffasm659901lfr.237.2022.05.20.06.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 06:26:06 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 61396104AAB; Fri, 20 May 2022 16:28:00 +0300 (+03)
Date:   Fri, 20 May 2022 16:28:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jakub =?utf-8?Q?Mat=C4=9Bna?= <matenajakub@gmail.com>
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, riel@surriel.com,
        rostedt@goodmis.org, peterz@infradead.org, david@redhat.com
Subject: Re: [RFC PATCH v3 1/6] [PATCH 1/6] mm: refactor of vma_merge()
Message-ID: <20220520132800.hijytnlyjqeesjfj@box.shutemov.name>
References: <20220516125405.1675-1-matenajakub@gmail.com>
 <20220516125405.1675-2-matenajakub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220516125405.1675-2-matenajakub@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 02:54:00PM +0200, Jakub Matěna wrote:
> Refactor vma_merge() to make it shorter, more understandable and
> suitable for tracing of successful merges that are made possible by
> following patches in the series. Main change is the elimination of code
> duplicity in the case of merge next check. This is done by first doing
> checks and caching the results before executing the merge itself. Exit
> paths are also unified.
> 
> Signed-off-by: Jakub Matěna <matenajakub@gmail.com>

Okay, this looks good:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

I would also consider renaming 'area' to 'vma'. 'area' feels wrong to me,
but maybe it is only me.

-- 
 Kirill A. Shutemov
