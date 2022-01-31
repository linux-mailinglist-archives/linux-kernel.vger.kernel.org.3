Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5EC4A3CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 03:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357448AbiAaC6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 21:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241493AbiAaC6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 21:58:48 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D33DC061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 18:58:48 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o16-20020a17090aac1000b001b62f629953so9509646pjq.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 18:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UKwameRoPfgLHWpBXoqOSY31hKTED2y4WM3/cMREqYQ=;
        b=ie36z+3JbZH6BpcGWoA8u8BouUWN7xsL3fl1f4YoG1CTP82izOviQ8uJeRSWesrmi0
         SdWI6A0H7yGOF4A02a4ZCDGnvB8dgzI0l6WNB2l6lcim35Ft20EXinLNlIA2m0HzJZro
         iWeB2iq9vReukiu+pPL2Qswox9STXWvm1FfDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UKwameRoPfgLHWpBXoqOSY31hKTED2y4WM3/cMREqYQ=;
        b=CweuLFtSKAsyVTLAQgdWYLbnqmcauVVQVGdWnHzoXUy8AB6wLGTz8a7NpGbxYeSy/0
         Khy2wiwJmQZvMhe+0SMAiq5NMAtZTboKjCLx1DQt0AoeSP/PBN3yQFhS6cOjneJffyD7
         dkSv/jqkTO9nP/NYjTmpYQ0br5346sG6VyWi9lYNIlTrBMQV2LnO29dFpanB4lafsOrE
         Mg3CaZtPifOTV3L/by9a1SD35LottFIGjNHp4IaFos27PuPgkD928DsuPeMZv1xnRTsi
         xgRnqJtY1M7lXDhQmuBcntJRl1G+TbIGVX30oyw+FxvQvqMfL9ERKrjAtsiKWY/2QSI4
         fHKQ==
X-Gm-Message-State: AOAM532DkZX6NXPgvuYPRbZ2ua0dQ1JlwQgkTH+iEZAzt93EBvrB0+Lw
        R4EvJBbtpt6ytrLynxm3ZR2mYg==
X-Google-Smtp-Source: ABdhPJzC803twXWB9gJWO7ckQkbQydjauPxbn+wK2Zrz3p/u8T15jAhCVbBRrUJeQ+UwY1smWH5+XA==
X-Received: by 2002:a17:90a:ed03:: with SMTP id kq3mr21942288pjb.136.1643597927548;
        Sun, 30 Jan 2022 18:58:47 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c6d0:3c7:e220:605c])
        by smtp.gmail.com with ESMTPSA id s30sm5169120pfw.63.2022.01.30.18.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 18:58:47 -0800 (PST)
Date:   Mon, 31 Jan 2022 11:58:41 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 2/3] mm/page_owner: Use scnprintf() to avoid excessive
 buffer overrun check
Message-ID: <YfdQYdFKdH0WQMVO@google.com>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129205315.478628-3-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/01/29 15:53), Waiman Long wrote:
> The snprintf() function can return a length greater than the given
> input size. That will require a check for buffer overrun after each
> invocation of snprintf(). scnprintf(), on the other hand, will never
> return a greater length. By using scnprintf() in selected places, we
> can avoid some buffer overrun checks except after stack_depot_snprint()
> and after the last snprintf().
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
