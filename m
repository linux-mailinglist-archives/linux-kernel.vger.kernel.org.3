Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D5F5A8E47
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiIAGcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiIAGb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:31:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3504AEDB0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:31:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z187so16579393pfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=qgznlsEL8rrRURFkBPf1CvcDi8VkwA/PSkT7W3fypSQ=;
        b=N+BsFiGffP+6LqadpKPTJsZPO+m6Ud5Z7FDFohVPAScFSRI7gcAeJp21NYsttZ+Q0o
         sCgXDIYP/hMwhmfhdHRISAHXZRXYJKeLwE4bHUe0taXNCWBAwBJd7pp3a5996q+jU5tO
         l43P1lsZav/sra4osBYRMQOxE/WL4rrsbaTO7i0DtMn/hOsSGmsDQ1xF+mzUqKuMV0ZJ
         hr1y/rwQicoQ/OWTBVBNCpqKH9fBhJkcu/neU63RwlyxpoCCtZdGvk23zMNfgxpVSj58
         LSQawklaDaQVhW5JFjd7LVKc70YPB2SjN0AIme/afZUoLw3LZ/GgHv9zKaBJNvLgRHE0
         SZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=qgznlsEL8rrRURFkBPf1CvcDi8VkwA/PSkT7W3fypSQ=;
        b=RloC2yakBIzi6B3iheIKJEw5exOhiTq5f2vOyF/MOkzVxGH+BEOkzbYZurl5Qpr5OK
         hDBhATevS3W1nyHLbYJD/b11lWo5xO0NMXTx0SIGjrBG8wAuPMSkjtC/jNZc6jZwhWKF
         whDrRlnzwqElJ5KapVeWFqcqg4enPcf/ylgqhcDFj9rBbVvOPH4Q3C9wpsx5G5lyM3ri
         JTTXUapItgi7/UvkEr9eO3NPCoU/Btoa7yuRmLdZFAwSCSF2GjRAP+OptBRrhOD3yfoX
         /mJBEFBonsT0OH87ufSyNImgSuVmHzSmFi4Hf5+QA65vEQHIFaMva1X/gD4sgwj5YIiH
         Nuaw==
X-Gm-Message-State: ACgBeo2uOAW9Tb3f6pvSg8doUrThkHV5niRY03X50piZMZv+9/fZxiMn
        HrlsHiXR3DHQu2wHYAIll/rPbw==
X-Google-Smtp-Source: AA6agR5o76Em579NM4goc9xQ2weO617CRt1DE5JRDmvRSLUWB8iTkLjDcpprDyUhWom8aXDfHikd9w==
X-Received: by 2002:a05:6a00:1586:b0:537:f5f:11d0 with SMTP id u6-20020a056a00158600b005370f5f11d0mr30325083pfk.64.1662013916176;
        Wed, 31 Aug 2022 23:31:56 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id z62-20020a623341000000b0053670204aeasm12361749pfz.161.2022.08.31.23.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 23:31:55 -0700 (PDT)
Date:   Thu, 1 Sep 2022 12:01:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, ray.huang@amd.com,
        Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Shimmer.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] cpufreq: amd-pstate: cleanup the unused and
 duplicated headers declaration
Message-ID: <20220901063153.zutwnnfykaz47sah@vireshk-i7>
References: <20220901062339.2357552-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901062339.2357552-1-Perry.Yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-09-22, 14:23, Perry Yuan wrote:
> Cleanup the headers declaration which are not used
> actually and 

This is okay.

> some duplicated declaration which is declarated in some
> other headers already, it will help to simplify the header part.

This isn't.

Every file should directly include headers they use definitions from,
instead of relying on indirect inclusions.

-- 
viresh
