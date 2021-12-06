Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FC34690A1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238256AbhLFHHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbhLFHHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:07:34 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF17C061354
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 23:04:06 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 8so9316262pfo.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 23:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HXwTAzkvUDjhhLa3JIAth4980gr9mc2XPQgpC9SXV2k=;
        b=EuuusfaKwDO78vIynmlmC+q9xyjLypNxyQP9l0ha5xjEPJsSBOFLbcyNcnc2GFaAKb
         nw3aVtAe1i4K/Ug9czH/IwJ7C46wF9bdREs1z52JztxkMFUnRtt252UskxMlFZx6zBJo
         tejOl1WwgLWCS/yEGnjSj+20CezTGG2hQ7QEJdRekC/DO1i/BjsC61LBTo65Pm+FIvK2
         oeaKAgDINfVlfbM6hNMK5zibLodWrCPjuou+lCbBXibTJbYC+bYMFisqUE93N28THMR8
         a3IyDuno6EUDuF06sT8VS83OlXcC4sdwuIm9rcVGyq/dji+tdR5Au/q16P2sD0LkDI0x
         iYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HXwTAzkvUDjhhLa3JIAth4980gr9mc2XPQgpC9SXV2k=;
        b=HcVQLQSIlW/4dRY3dzMD85PcjGNM8BOpG66csGZdZ/KpN9Cn9u6vYxIrfLMtL31moQ
         Q9WYGw+GSaOsF8QYyXGCbZpDCc2lsaYiHKyZHn/3K2VzXON5gNs7EaT+0mz/xW5lhlTt
         4Wp/rml2W1jtd53AzsTnvwR2nywvRV/yBGKi/BqvZlB9LqWtwyDTQRyMsSSXXAzgtyuZ
         sS7wA+emdyZ2lFy9km5+0wSNsTUpC5x2K6u5Jtd/26/sVeCGAgvU7/208IV+lf5r5uMF
         88ZbRvTtF8djziK8Xw7nwcBLLBSQqeGCKDbt8kinIWR5NgPGJkeOKppTjPC89q52jF41
         B1hA==
X-Gm-Message-State: AOAM533nI6pNtoeQC4z4iH86IhiH5GJTzMTa/6vsn6vUKg6Kc7H8yOvr
        6pnJkPHikRzai3Fwnl0F65sYWA==
X-Google-Smtp-Source: ABdhPJzjLMthv5mO34i8EfRiYH7pph+S6Wp1Hk+X2XlKJmVy4wOGI/LF8C4azzeCKwWqapJQc8mjhQ==
X-Received: by 2002:a63:8749:: with SMTP id i70mr17421400pge.511.1638774245629;
        Sun, 05 Dec 2021 23:04:05 -0800 (PST)
Received: from leoy-ThinkPad-X240s (104.225.157.100.16clouds.com. [104.225.157.100])
        by smtp.gmail.com with ESMTPSA id nh21sm9357961pjb.30.2021.12.05.23.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 23:04:05 -0800 (PST)
Date:   Mon, 6 Dec 2021 15:03:58 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, codalist@coda.cs.cmu.edu,
        linux-audit@redhat.com
Subject: Re: [PATCH v1 1/7] pid: Introduce helper task_is_in_root_ns()
Message-ID: <20211206070358.GC42658@leoy-ThinkPad-X240s>
References: <20211205145105.57824-1-leo.yan@linaro.org>
 <20211205145105.57824-2-leo.yan@linaro.org>
 <Ya2yXZAn+36yhfdU@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya2yXZAn+36yhfdU@unreal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leon,

On Mon, Dec 06, 2021 at 08:49:01AM +0200, Leon Romanovsky wrote:
> On Sun, Dec 05, 2021 at 10:50:59PM +0800, Leo Yan wrote:

[...]

> > +static inline bool task_is_in_root_ns(struct task_struct *tsk)
> 
> It is bad that this name doesn't reflect PID nature of this namespace.
> Won't it better to name it task_is_in_init_pid_ns()?

Yes, task_is_in_init_pid_ns() is more clear.

Will respin for this.  Thank you for suggestion!

Leo
