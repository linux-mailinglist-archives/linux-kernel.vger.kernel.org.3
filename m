Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB2348DC0D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbiAMQmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbiAMQmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:42:04 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52B1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:42:03 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id f13so359667plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0RghS5in1nYPx/uEnl/bNk9uJrbAUCko5BnNI6t0d7A=;
        b=bd3akMxtoY9qvnWlzDOgFdInNxVVmO3jCTQLlz+Cnj32CwJ/Sd+XulfUMvK2MYIbDK
         7PCplGYtZY46Gasvui4ntsgcBBZkej6h3k9GHvHaa7sE6jGx59JWCDaGVT7CA3KpzJU7
         yHl93n7/RD4QoBPDhY3u3w1pAsrcjwfomlVc+eSMtHdZLUceGAp85X6gloMAtk+GooNA
         MG/XziYC8b8Ive3teUvzEGvWddQVX4HuwoT+Fqh5EfunOv/Gie4zAeeC2Dro78ZnzhRd
         G3MQqVYcoqWZR5I85Q9TOhGFHxWFJt0/U66P/53E3RtF79RQiakO+kPK4SSPH8PRNIls
         m1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0RghS5in1nYPx/uEnl/bNk9uJrbAUCko5BnNI6t0d7A=;
        b=tFSI+HMzxL145R9ePgP+4yNj17rrp9XSmczipWMYJ5k6q7LSzAogBzvRQMtXYOL7aU
         DEXAeDsDl0BLEBz/0NYY8e9Q/EnhhnmX44igmZbCCyf5WWAb7el5FB+bEgOWREQBPIiG
         QCiI+kN99F1ll2nRl4ZBaAcchvoWxR+EKLw8fEZ4YnoxJy3qG2oG1DRwOmG1CA+8GuBX
         iZXCwmOm3SszlTVVRrUgr2Cj3OxrOIWp/K/fj5yAseGC1CTRIZR2K/j854KMlBSeNHDM
         RDZ+jw5uTmjR9Yg24bF5CD1dB0Dz8UckVPED7hdYoRENe3oifI7FZUPoB8oKtyJbAHZM
         dWdQ==
X-Gm-Message-State: AOAM530kD17YU4sfceuzSm+aS7Tak1vN/hhAcmR4HCs/KWTcnvprvfqs
        KzdTL+0HrGfXsSuf/+P56s3XOuiEj8YRhQ==
X-Google-Smtp-Source: ABdhPJxLuSieBetOIm6dcQtHfslT5H9JQcUa7G0tZf3pMJQrfLp/pmtvJyCqg1YC06fJYRbB8wg8ng==
X-Received: by 2002:a17:90a:b281:: with SMTP id c1mr6047150pjr.221.1642092123302;
        Thu, 13 Jan 2022 08:42:03 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id a14sm3660044pfv.18.2022.01.13.08.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:42:02 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 13 Jan 2022 06:42:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] kernfs: Reduce contention around global per-fs
 kernfs_rwsem.
Message-ID: <YeBWWWa030xTftWe@slm.duckdns.org>
References: <20220113104259.1584491-1-imran.f.khan@oracle.com>
 <20220113104259.1584491-3-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113104259.1584491-3-imran.f.khan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jan 13, 2022 at 09:42:59PM +1100, Imran Khan wrote:
> @@ -748,11 +749,14 @@ int kernfs_add_one(struct kernfs_node *kn)
>  		goto out_unlock;
>  
>  	/* Update timestamps on the parent */
> +	rwsem = iattr_rwsem_ptr(parent);
> +	down_write(rwsem);
>  	ps_iattr = parent->iattr;
>  	if (ps_iattr) {
>  		ktime_get_real_ts64(&ps_iattr->ia_ctime);
>  		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
>  	}
> +	up_write(rwsem);
>  
>  	up_write(&root->kernfs_rwsem);

Hmmm, so the additions / removals are still fs-global lock protected. Would
it be possible to synchronize them through hashed locks too? We can provide
double locking helpers - look up locks for both parent and child and if
different lock in the defined order (parent first most likely) and record
what happened in a token so that it can be undone later.

Without going through the code carefully, I don't remember whether there's
something which depends on global locking but I'm sure we can fix them too.
It'd be really nice if we can make all operations similarly scalable cuz
with heavy stacking addition/removals can get pretty hot too.

Thanks.

-- 
tejun
