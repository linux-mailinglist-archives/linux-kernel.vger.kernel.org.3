Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2780A463BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbhK3Qjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbhK3Qjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:39:45 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7433DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:36:26 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id r130so21237076pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G9UcRoG6n7uSI6RSS4bAaNF3e1CzNs1fxTdoBdfl5jM=;
        b=qZzQYJspZBn9YHGzADbzUQDDgasoS0mJZE6iz43pBaZOB9DrtPqAZfVeKmjEvpnQMh
         WIstXIKb8Pvdomnzw0bE738NbVYon3tkYh17Oj/dGEQhAbz1HkTqduNSvKfi8+xMHbyU
         lCf3rrxazetPwRTvBBHwT4jTJqZZufec9V2wjeq5iZYAKssY5VwOBTjPLKQw/kkBPQzw
         t2/HIQJum/cCNW6sQJsAH1SDYlki1m8CO1KqWVFuEUZnqKjNI7tHbowweJN1XOnP0pVL
         Y49cNbPmXjppJQhi8Wbo75i57YAeZygk4jp6LjTTMnDU19/y4yqrKSsku0/PhXUnpToL
         nZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=G9UcRoG6n7uSI6RSS4bAaNF3e1CzNs1fxTdoBdfl5jM=;
        b=qBoqQh7HpsvEXdDpnOoYe8ff2O3Za9u7SVyXLSijVEt4elYDbTcNziooDBQY8c2Nqh
         e648Ch4mzCMXx2J3FX4LZmbe9Ujkf3FQAYkAix7BuiUbKug4F2uLBNAwO/j4mhIwZehd
         SzcEXeDWQ9SV9KhkldCMTseLJR47c1fyCrAy/x/q2UaxQEYRyhuCcBKrHAgDn58UUJh5
         qEVw8UuU0X2vU1QMJ0iyNsto4QcuxDGV+yv3H9EpQEg9yFI4pCRMPqYl5Mm9i4YFvauK
         sYEcHW/Qsd4Dni4oRYOxUnygHa5BOLsLd3fjEoO9qzm2Oi7bjTrpsJn1Cj8XMIOgFdf7
         wJ6w==
X-Gm-Message-State: AOAM532OS8nk3XhdkudEV5kU/WhUUDW7P3uzWOg9OHb5IbDwIy5jGYO8
        klIKY/uLDob2HmMIlcDZoycsvUdmsGiw/g==
X-Google-Smtp-Source: ABdhPJxiowYGgzDK3NHQz7bpm7p97sY1CByZVkt+RsJ2uGDGZ1cE0012erL4Fct6P5/KKPMu/QiWvg==
X-Received: by 2002:a62:18d2:0:b0:4a2:b2d0:c39f with SMTP id 201-20020a6218d2000000b004a2b2d0c39fmr273009pfy.69.1638290185838;
        Tue, 30 Nov 2021 08:36:25 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id a18sm20378723pfn.185.2021.11.30.08.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:36:25 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 30 Nov 2021 06:36:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 0/2] workqueue: Fix hotplug races
Message-ID: <YaZTB/XiC6VNMR0d@slm.duckdns.org>
References: <20211130000612.591368-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130000612.591368-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 01:06:10AM +0100, Frederic Weisbecker wrote:
> While triggering rcutorture splats, I couldn't trace down to the exact
> cause due to the issue being tracing-unfriendly. But looking at the code,
> those two potential races look like plausible causes and also after
> these two patches, I couldn't reproduce the rcutorture issues again (yet...).
> 
> Frederic Weisbecker (2):
>   workqueue: Fix unbind_workers() VS wq_worker_running() race
>   workqueue: Fix unbind_workers() VS wq_worker_sleeping() race

Both patches look good to me. Lai, thanks for finding the offending commits.
Frederic, can you please repost them w/ scheduler folks and tglx cc'd?

Thanks.

-- 
tejun
