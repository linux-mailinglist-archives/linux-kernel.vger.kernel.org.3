Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FE749882C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245181AbiAXSUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241869AbiAXSUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:20:23 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4121C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:20:22 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x37so12822543pfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=dD7dOLXb+YQYq589HrH7forsalWY8+LJ4rBHpm/SHRw=;
        b=gRTdqJHKCLMkSZ3bmFhgUlfkqnsGok83Bdw5ohbB+I4EGKL6koKg7mnrTsh5YuMBLa
         GKVPoF7oCPhLtG/voaI0hrXtEDgvwdvX9ISnG4Co2a5itSLEAKDL4E6DmN8zOpsfwmNq
         c+RR9Pzr/NoDUNdSUiTg3T+GaucTB45uBXKpK7LHeRF2sDhEkjwk6UcdD4kB4221HScc
         V1Sfw3DzXLotVi01fh06jyDfTnUzIJ9DmoO/4r7Gh0MvqQx3wsDe7Mw9xj1KK9JEqhsB
         GH9cThxBfs6YAdrp63S8R3uwKE4MIutDdJa0hJSb5kYB7fuNcyX7gcbggWsNZgCM8AH2
         n/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=dD7dOLXb+YQYq589HrH7forsalWY8+LJ4rBHpm/SHRw=;
        b=o2taO6/lu9blQ2gutKypT99yAtYQ///9zaHKwnwUyOyDw3yRm3rQEP94RjXM5n/LdR
         be0o5gatm4+40Tz5OoSTwGRXOY2amOCeS98w2r2wV+imCsUAfTCjdx4aWQ+tlqQrt8OZ
         vgQdWN/LFA0r/OGgDsoWini99jujOcXZvcmN8wQOj7e8ijfNd4xV7v2GzEX0cJWQkvp3
         93nFOYlLWtuTZJQ4qy4/PzYJywWyj7e2VQaLOBzFWlMfEa5Fmg+O5XieEOIcG0BsAyMG
         gXYKN0EM0Wy5Wkj0GzkPIBaOMXilrWw6oYYUBuZxF81VEjY19ZlNfmzfrk3tePr1IUE9
         e5Cg==
X-Gm-Message-State: AOAM530U+OitkstZAV8OilWci9bpC7yYEPkgvihsqngHntWWUoZetSwP
        lZC6Uod6/4obbM5hxwvBGxallA==
X-Google-Smtp-Source: ABdhPJwLIGzTlfukShqfyFMX/Z6h5Q8RTwu9HHBQUuZApv0356SMbN+8i8h6wUvDuRXC5+uOphr6QQ==
X-Received: by 2002:a63:ea51:: with SMTP id l17mr6080241pgk.450.1643048421931;
        Mon, 24 Jan 2022 10:20:21 -0800 (PST)
Received: from [2620:15c:29:204:1f99:bd65:fcbb:146c] ([2620:15c:29:204:1f99:bd65:fcbb:146c])
        by smtp.gmail.com with ESMTPSA id x12sm12678911pge.58.2022.01.24.10.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:20:21 -0800 (PST)
Date:   Mon, 24 Jan 2022 10:20:20 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
cc:     sj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon: Remove redundant page validation
In-Reply-To: <6d32f7d201b8970d53f51b6c5717d472aed2987c.1642386715.git.baolin.wang@linux.alibaba.com>
Message-ID: <bdc7a556-b826-8d82-91b-8664f8a655e@google.com>
References: <6d32f7d201b8970d53f51b6c5717d472aed2987c.1642386715.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022, Baolin Wang wrote:

> It will never get a NULL page by pte_page() as discussed in thread [1],
> thus remove the redundant page validation to fix below Smatch static
> checker warning.
> 
>     mm/damon/vaddr.c:405 damon_hugetlb_mkold()
>     warn: 'page' can't be NULL.
> 
> [1] https://lore.kernel.org/linux-mm/20220106091200.GA14564@kili/
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>

Acked-by: David Rientjes <rientjes@google.com>
