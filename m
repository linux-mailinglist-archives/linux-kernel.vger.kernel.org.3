Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B354F46F6CC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhLIWbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhLIWbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:31:01 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D96C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:27:27 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id v19so4971065plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 14:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PkDVlmoUW/39lGeBdelZ8+my3A2JcSqLTVuo8EkjbsM=;
        b=oVaT5BOsAKTXBUK4zyKZDsJjT60Lb+G5CSYqY7NE98nMHTR3M4VR1teyDfdZNg4qDo
         YtW5eQHOUx/Znfvdy8/NaDnUMZu1jBET74Ip0Px7shq8coGXf5SLxbydeDqqBnEwE8RG
         G91emUiFIHRXwR15KfwJ2kuV046AHGM6dCFRKdXSndkgwi29I6TwOV5Fc4SLvS+Ripwp
         Esp4tWo9o6V0uOGLlH+bZtArbXAUXsvfXXQSDllvpK+4cA16x5TmAhd21RTqlWOL8meX
         AtWSdA7DlNHthZOn5wZVr3MoQ99xYjQSouOGtUb1d3pNWOagQMbmJt/WposZjSNRZJQ1
         a9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PkDVlmoUW/39lGeBdelZ8+my3A2JcSqLTVuo8EkjbsM=;
        b=3tfOTXd2fwqCKl3rDHrnr3FsoKsUupgyF9pA0wy/5fDMczTGUALIxkmxUEBNBHq5h5
         7aVMeG5PGlgph8SGOKu4mGoA9vSOK1LAvls18Ns9pDVl0JS2mhkOrMaicIJWxKZd2R3V
         5+D7WE5UG33p1nsG+yiwycAmeXZNQI6nQSdw3cPv+6fE02a7JbpV7JFDA0ZKfncii8gH
         L7PpWFfbxg5ENdOe9QqApMbNNt3F2xYc/EvXBRlirD3Kk+wX32cHAsceWFo4FmPnO4lW
         jv53wHhMiuo1KIhgNwyaSjpKBMsYOkz/NxpD5gqYWvRHwdXuIXIhxLSoLqeIIatj3bQe
         s4OA==
X-Gm-Message-State: AOAM531ENTEwe9NB5Fpj0VvdSwB8Y3sWoitqVH6ByVDNdk4yDfsmlhA9
        z1Rz1vyx0N1B8E6OTJk5JhEuWR+fdgw=
X-Google-Smtp-Source: ABdhPJz+85zkhVaeTxEzT8v5QSiqOm/WCKIUin5D6k4nC8HJkE1ZWdunkvLndrL5RwE3WguXU5tS2Q==
X-Received: by 2002:a17:90b:4c85:: with SMTP id my5mr18824409pjb.26.1639088846745;
        Thu, 09 Dec 2021 14:27:26 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id j16sm761491pfj.16.2021.12.09.14.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 14:27:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 9 Dec 2021 12:27:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: Re: [PATCH 6/7] workqueue: Remove the cacheline_aligned for
 nr_running
Message-ID: <YbKCzQ3aMoeapv8T@slm.duckdns.org>
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
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

Applied 4-6 to cgroup/for-5.17.

Thanks.

-- 
tejun
