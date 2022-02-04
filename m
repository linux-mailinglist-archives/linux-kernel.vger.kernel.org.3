Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B5A4A9298
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 04:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356738AbiBDDKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 22:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241328AbiBDDKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 22:10:01 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CD3C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 19:10:01 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d18so4006172plg.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 19:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Xb2euam+bxQRkVsUNlC1wKKJLQkTZqUjd7jMV5JJi+U=;
        b=GooFC8jW6okwOSCljLIV/3aDiFNcwXCOYW7628p/ZwlxHL7KtECawy3G3T46Exy/2i
         hZK0mv/3JdIOvw/foQoBgGmtbzgU+pqd3cTSG11YEBRwHZKIyMgtIEmhuD5IKjLXvTFr
         RnrCvdHI2D3ORPWWscV8lQviMdV/G3LLcwrz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Xb2euam+bxQRkVsUNlC1wKKJLQkTZqUjd7jMV5JJi+U=;
        b=pu5tDQACmH6qT9T2MuzCmBpdSgNx9luINNCVYQuA35ghh82tFVwTKjx56yssQHdLd1
         pBp6PaP+13ZeRLDtvWLjZ8sB4rgncw5CGcWpEk5NCsqSB0EOzFEfeUir3zzEEzcj9Pxz
         44agA8IF8Mjp90oP1UdGu4DpmlPkMqePK1PdIrsEiy+PVrdK3z9AbQD3N8ozxLs2XKFo
         1iBZNPSQ/gC6NIvBSh8fZfV6StNspH2oZmRzOSYE3j9CQ/LetABi/3US7K8HoTBKDvv8
         Ihb0HNe9YN8LArjRaPqTCWZYm6gC0NlS+AFJcIGwCPD6N9ZfgIt4eUyXl8MrANX673dJ
         B3RQ==
X-Gm-Message-State: AOAM530NAv9Mnzx5zK7EmgVt5HmoG+Qa4dvEXE38pilU0IYF31Nrjve8
        SktLT8zDGvvfwLLADVe1C+/MXw==
X-Google-Smtp-Source: ABdhPJwbqURJ9S5I9AbzDnpbYUrrxmi4XLMvNqGguxqTELmn3JbqrMuciCmIksEY3Jcc4RUe9g59Yg==
X-Received: by 2002:a17:902:e313:: with SMTP id q19mr1152083plc.161.1643944200754;
        Thu, 03 Feb 2022 19:10:00 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2b9:190e:d890:b53e])
        by smtp.gmail.com with ESMTPSA id m23sm378119pff.201.2022.02.03.19.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 19:10:00 -0800 (PST)
Date:   Fri, 4 Feb 2022 12:09:55 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v1] printk: Fix incorrect __user type in
 proc_dointvec_minmax_sysadmin()
Message-ID: <YfyZAy+ZDZ4SXIFE@google.com>
References: <20220203145029.272640-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220203145029.272640-1-mic@digikod.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/03 15:50), Mickaël Salaün wrote:
> The move of proc_dointvec_minmax_sysadmin() from kernel/sysctl.c to
> kernel/printk/sysctl.c introduced an incorrect __user attribute to the
> buffer argument.  I spotted this change in [1] as well as the kernel
> test robot.  Revert this change to please sparse:
> 
> kernel/printk/sysctl.c:20:51: warning: incorrect type in argument 3 (different address spaces)
> kernel/printk/sysctl.c:20:51:    expected void *
> kernel/printk/sysctl.c:20:51:    got void [noderef] __user *buffer
> 
> Fixes: faaa357a55e0 ("printk: move printk sysctl to printk/sysctl.c")
> Link: https://lore.kernel.org/r/20220104155024.48023-2-mic@digikod.net [1]
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Xiaoming Ni <nixiaoming@huawei.com>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220203145029.272640-1-mic@digikod.net

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
