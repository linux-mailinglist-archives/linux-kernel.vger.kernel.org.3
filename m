Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759CB5196AA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 06:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbiEDEyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 00:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiEDEyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 00:54:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C1A17AB9
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 21:50:30 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x18so425992plg.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 21:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=nDnIq4AJplcQ+V/YkmM9MByHrS7SNaW6zevcswA9vuo=;
        b=E+q3rvnQG7/uAG7CxQ8bGZmNH9iz0VFV8fu2I2ORaDNUWXrRmj6iEyM2NpydbymxmP
         +Pq//57c8Z4Wo3HZ+KUP9MCFEgh0ToLzWfYII/dD0x/Ps/Tz+PfDXlqNgGKcLl+Y9LdW
         MpAg66Yty4ZeDNaenulGJbsESaQjMmKW3oBBrsu/6e8DDYkqSKuy7eYi4XP1YxnZEr5+
         lBoIykh3Uq63FTr7xeugs00+/rrQtkxObkNaVFTpt/+AhLeOQNktBT0O3xzt9STPXLDx
         mKPaHjZXKd1lnUSjUUh420CgP+2w1PQuSx4YlGv7tAD8/GFD9lpewulJ58PsM2udwIxp
         Vb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=nDnIq4AJplcQ+V/YkmM9MByHrS7SNaW6zevcswA9vuo=;
        b=uXAosEE5H+lzlQd7SvEAUkIVMoJiHT1jTf9z1VGZzPM19gkaBggcCANH3/bzb7p9X+
         QdA03vzmTZggjXGNbtD4j6VdSEOk8h/nqVGOIQMReczvk5JVM/aBC+FkBczCFihgDDS/
         SSWj8Lh4zdQZPdFymfCq6/giT2aaqajF66L9OdxX+ftNdWmTLp/LZQoPW+fUwwkZm2QN
         ccRfmYJF6mHEAxPWgmIyXL6zR58Yi2wNn7xfmJ9LoouOQKl2VGJpkuxT7B+mPNxFetmw
         J/1nBjDSv1rxeAHayP1VDmbrYx8dBBuT6dYO7GFwcJR/dEsbY8wA0hXXDDCEhAECGdTQ
         P/UQ==
X-Gm-Message-State: AOAM53209a4HPJVbPKfxFoyi46bUtuiYQL73jMcGIIMXM4xT1nzX2pmX
        n+oi/yc7PfVDltShCGdzLVf48Q==
X-Google-Smtp-Source: ABdhPJzPnzlabVWMQ4GQHpHNvKJk1TekE2nin/8E/4hKug+e48n/j2/Bmix2rpjWzhj9bkppl8LSWA==
X-Received: by 2002:a17:90a:b395:b0:1dc:a402:bd4 with SMTP id e21-20020a17090ab39500b001dca4020bd4mr97878pjr.238.1651639829760;
        Tue, 03 May 2022 21:50:29 -0700 (PDT)
Received: from [2620:15c:29:204:81bf:3703:f79b:1d5] ([2620:15c:29:204:81bf:3703:f79b:1d5])
        by smtp.gmail.com with ESMTPSA id z21-20020aa791d5000000b0050dc76281ddsm7157513pfa.183.2022.05.03.21.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 21:50:29 -0700 (PDT)
Date:   Tue, 3 May 2022 21:50:28 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Yuanchu Xie <yuanchu@google.com>
cc:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/damon: add damon to selftests root
 Makefile
In-Reply-To: <20220504000358.1174849-2-yuanchu@google.com>
Message-ID: <11379f3f-441e-4851-7d4d-61ec68abc59@google.com>
References: <f6cc50f0-318f-097f-af13-271a2fb4d645@linuxfoundation.org> <20220504000358.1174849-1-yuanchu@google.com> <20220504000358.1174849-2-yuanchu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2022, Yuanchu Xie wrote:

> Currently the damon selftests are not built with the rest of the
> selftests. We add damon to the list of targets.
> 
> Fixes: b348eb7abd09 ("mm/damon: add user space selftests")
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>

Acked-by: David Rientjes <rientjes@google.com>
