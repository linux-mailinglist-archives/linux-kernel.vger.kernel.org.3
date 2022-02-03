Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81384A86A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351626AbiBCOgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351339AbiBCOeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:34:04 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB19C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 06:34:04 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id x5so2296632qtw.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 06:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WtESLeYtc0Jg20kmUatCfJN0QM7WwgD2xCtN7UseXOs=;
        b=Srm1pWpD7+dVLr0XsFjhkGfXDJLpFboMvJ3rV3L9faQs+iaF6pDBnt+9ykPS7k/vCz
         YcFq1A83TTKmrstXGgUfY8wswu0NprN8KFTl8bX4xvzTddUUiCVtox7JuyXQcger+XbD
         t8Xg25jK4hEnlCYbaWM97lrftHWkdHl9+FfGR25KFB/R72N+6ITyFb/KiOPyVtAFIBHj
         HdzEzOpmJQzU0OLsldcNsc2IQhZ13xsF38Ya2oDyK8XSwrbBmWYmTlXll+gFew8Llg3G
         Wc83bGQ+wYEV7eA32W7u5HORd03xs3dv47huMyXrkkr7NYq5OrqQa3ZvwAkdobJu116Z
         n8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WtESLeYtc0Jg20kmUatCfJN0QM7WwgD2xCtN7UseXOs=;
        b=atLI8EF42DprsTfpMcTR6gh54t5MYNrR6dfg/p/rWu4H8/6SEKet8UxtarcgeMpqN6
         SljqBPDfh0YsMS4BKZ3lanF2dLnVhC4/e/GHsloCRRioG3TJgKHk8I7acqEpdpX7qqcR
         MCm6/qDYs/d/+zasCHSl2FXPFLbdjfc1kR1STF63f0VPr4TK+XF8Eawcn5m4hlzqdbo7
         fjmVo4fjkTxKJSF8K0tpSZ/Byu4TykS4d0Rjvaen/y4bXO4lgoGg9ZpYlsHqcf3AAxQU
         bPkDDhkr3FZxS2wvd3tyJ1XJPuyx5vkLJZUsO2jawBOedG7aJikRXIF5pb3QGIFu8dgI
         2IEA==
X-Gm-Message-State: AOAM530f98La0H7Iw70XKneOxr/gD6e06PROVyCRhViLyqZx4V57+KJ5
        KOGxyky7MUIaCVs7Nrj0sI6jlg==
X-Google-Smtp-Source: ABdhPJzPZHSHFUJG5JGw8tQ4HMCOi78TfB3MMbRyck9YZi6qNrSO5uWPC25vlutLQoU4ZRyLjwMhwA==
X-Received: by 2002:a05:620a:c4e:: with SMTP id u14mr22844594qki.710.1643898843325;
        Thu, 03 Feb 2022 06:34:03 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id s28sm13037951qkm.53.2022.02.03.06.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 06:34:02 -0800 (PST)
Date:   Thu, 3 Feb 2022 09:34:02 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Doug Berger <opendmb@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        SeongJae Park <sj@kernel.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Updated git tree for MM patches??
Message-ID: <Yfvn2gatF0NA1ihp@cmpxchg.org>
References: <fbad2233-207e-6b66-890b-ef1b1f97fdad@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbad2233-207e-6b66-890b-ef1b1f97fdad@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Wed, Feb 02, 2022 at 04:21:38PM -0800, Florian Fainelli wrote:
> Hi Andrew, Johannes,
> 
> The MAINTAINERS file for MEMORY MANAGEMENT lists the following git tree:
> 
> git://github.com/hnaz/linux-mm.git
> 
> however it does not look like it has been updated in the past 5 months or so
> as master still points to 5.17-rc7-mm1

Oops, that was a bug in my script. I had to work around a behavior
change in wget and it looks like it started failing quietly in the
next wget version.

All fixed now and the tree is uptodate again. Thanks for the report.

Johannes
