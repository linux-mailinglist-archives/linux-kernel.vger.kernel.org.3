Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863074C1DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 22:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242724AbiBWVdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 16:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiBWVde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 16:33:34 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14DD4EA38
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:33:05 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id w2so60275pfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o3F1fn31BsVyEav46oaUSfeJlWihbw10OJWGV7VLc8U=;
        b=Y5gZkMi28r+WxhsjdUErs+zaiyQY+lpdC416gS3r7rWZh+GS+Tc3hfcEYsDarkkcd7
         +x4LZlo0yMfHyH8DyfT4vEktSAfM9jQ5dbGJuc62BpXncxkjklGer/BjCEXLIT48of5h
         Gf0xQYYw4+jIf9hZ6hlkFkXb7QX1jihmXZ7qQFnNZH8BhRnYBmZp9uoUkOZOL7BjqoJI
         Y8v9W5TRKIAEInSiS37QxaSmaIREHcnCmAOAcza8nYqZWbQ2dSiWPEEc7hQpiRpV6MKn
         rJEsGD/tHUzJ4Whxpe9gbNzCxFj9kWf7dS7hPywrXSuSZgX+S5od38Dr6R3oOARe2CiJ
         /lQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=o3F1fn31BsVyEav46oaUSfeJlWihbw10OJWGV7VLc8U=;
        b=qJ1GkGDJwlcjlK5LzF98xogvBWVE/gDHJ5opTeN1MlbOXz9Nr6TblAz5I5KI6SUXBp
         +IjAAaiAjHKKbS9BEtE2IZdYBKluMv2iJv8lCmayg+vQBhQgFTTDfm3QtATIu0/O5RmI
         w4KN+sAcyuvCGAXgTZ27c5AzLTRYV7npS0p1nrL+NuQ/Ec2r9qx5L7IqgVvAS2nu+65H
         rR89qf5T7bzWdKvXlbKzBGhMNN5ZRQzd8tlpiJtUVA5DV/qk0uBO7T6JE/nCadjO/J1c
         VsbcRTiJ/ySKjOvLUuBv4YrAXuFWzCWFgzb4UkPrQZCho+cqQ//PPVb8WvHfXv9KpOW7
         2Ryg==
X-Gm-Message-State: AOAM533eZ9V1QGq0ndz3Yt5Kj9aT9NwRj6IS3zOmgI0ZQvcZKol5Z21g
        IIHpUGn12Re6K958PzH7p5Y=
X-Google-Smtp-Source: ABdhPJwEWpLr6owhhXHbZ5+BXl6m1lrcLKoiFIxv7I/dw0nZ8g+PXykCsyswaE+PXKND4KUrAPhi9A==
X-Received: by 2002:a63:cf4c:0:b0:34d:5dd8:c489 with SMTP id b12-20020a63cf4c000000b0034d5dd8c489mr1271355pgj.10.1645651984813;
        Wed, 23 Feb 2022 13:33:04 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id f18sm468209pfc.110.2022.02.23.13.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 13:33:04 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Feb 2022 11:33:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] workqueue: Use private WQ for schedule_on_each_cpu() API
Message-ID: <YhaoDiJ8MUOhRmp6@slm.duckdns.org>
References: <20220221083358.GC835@xsang-OptiPlex-9020>
 <3a20c799-c18e-dd3a-3161-fee6bca1491e@I-love.SAKURA.ne.jp>
 <YhUdjip4VSWe4zDO@slm.duckdns.org>
 <16a33a65-3c67-ef66-ccc8-9c4fffb0ae5a@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16a33a65-3c67-ef66-ccc8-9c4fffb0ae5a@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:57:27AM +0900, Tetsuo Handa wrote:
> On 2022/02/23 2:29, Tejun Heo wrote:
> > On Mon, Feb 21, 2022 at 07:38:09PM +0900, Tetsuo Handa wrote:
> >> Since schedule_on_each_cpu() calls schedule_work_on() and flush_work(),
> >> we should avoid using system_wq in order to avoid unexpected locking
> >> dependency.
> > 
> > I don't get it. schedule_on_each_cpu() is flushing each work item and thus
> > shouldn't need its own flushing domain. What's this change for?
> 
> A kernel test robot tested "[PATCH v2] workqueue: Warn flush attempt using
> system-wide workqueues" on 5.16.0-06523-g29bd199e4e73 and hit a lockdep
> warning ( https://lkml.kernel.org/r/20220221083358.GC835@xsang-OptiPlex-9020 ).
> 
> Although the circular locking dependency itself needs to be handled by
> lockless console printing support, we won't be able to apply
> "[PATCH v2] workqueue: Warn flush attempt using system-wide workqueues"
> if schedule_on_each_cpu() continues using system-wide workqueues.

The patch seems pretty wrong. What's problematic is system workqueue flushes
(which flushes the entire workqueue), not work item flushes.

Thanks.

-- 
tejun
