Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C192546F674
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhLIWKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhLIWKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:10:52 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C77C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:07:18 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id k4so4933366plx.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 14:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AE0YjcoZsKQA/h89Qqfbr3mpuL5VXiWzoyClY6zdV/c=;
        b=Mh9gP+hi2dBTGwqMiBo2/96mbOB4nj2Rt+LKXIAT5/6keKHqsS5OVdCBTY5dLvJnkA
         JBRnlgGu34n9aOtQDWhLuelWdfNEbV2f/reOPrpbaOCf4sbbRfAKG/o5sYSuc8bm3vUh
         f4COGE6GlSrxVnB8zK3HQWxJ6Kx9DWQCcP1u2OoK0OiWxAgDxlcuytQIZw/tNL/qQUMt
         cHlJTqGGBr4BWuJ7Y4i94IrW/I5YTMBJDCkA1csh5QAEEpf/Blfb3HC2CjEY6z2myxdM
         Jx1Y8wiOq1e3it9Ep1z50Z7LWFK9yBrdaO5PbU4gbVSJmAmZ2d5Knnj9RtQ9+BYEwx7l
         ILGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AE0YjcoZsKQA/h89Qqfbr3mpuL5VXiWzoyClY6zdV/c=;
        b=NAzCaiPCZ5SbD3sNuwG96tYXqzuzsZZkXelrPwAVl08O3F16k9hDbh6CXeEFIM0YZM
         /dRdBm5qlsPFdLS2VbYaosLgTb9GNE8Ht3W9Ro+B+Mt9ZAZGVm2YVDTfGklDssdS9QGf
         9JAJozBHvcX+gQypgOcR7SiWB80lwOTpEMnk9py+EDCdHBMsve9+1//kvTNvMZzdUx++
         GLoDeqXJUPcyMmbzohaw+rtmUfcDDAH1ix+BakG3ElTzM9dmNDPt7NCujYoHqhWanuOA
         DcsGUL0QbIk+VY8c5JNAkoPFh+7/rCJH8HdCIWGtXPphk2dJu5QtuTJRcRGv9KF6YNdA
         E4yg==
X-Gm-Message-State: AOAM53003+dy1XsuUb9yyq6F3fpxhhFfPQfn0LvALSRtPDh5PEKgkDCs
        PR8K/C7rkZJM9I8gmZ3KkyeI/uFfcyw=
X-Google-Smtp-Source: ABdhPJwiJQeIVoL/HI0gJP4Oy/2hUdTDwai05hKCFZdPLrQGPi/lUi+uo10qhx7YNtNpVlPbd1rDhA==
X-Received: by 2002:a17:90a:4894:: with SMTP id b20mr18883297pjh.121.1639087637708;
        Thu, 09 Dec 2021 14:07:17 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id d17sm622850pfj.215.2021.12.09.14.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 14:07:16 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 9 Dec 2021 12:07:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: Re: [PATCH 6/7] workqueue: Remove the cacheline_aligned for
 nr_running
Message-ID: <YbJ+E+HB+UCYHxSi@slm.duckdns.org>
References: <20211207073543.61092-1-jiangshanlai@gmail.com>
 <20211207073543.61092-7-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207073543.61092-7-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 03:35:42PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> nr_running is never modified remotely after the schedule callback in
> wakeup path is removed.
> 
> Rather nr_running is often accessed with other fields in the pool
> together, so the cacheline_aligned for nr_running isn't needed.

Does it even need to be atomic anymore?

Thanks.

-- 
tejun
