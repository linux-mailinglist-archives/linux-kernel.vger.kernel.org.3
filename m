Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DFC487E38
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiAGVZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiAGVZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:25:15 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F199EC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:25:14 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id v25so6491975pge.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vmeUDsYhyilXUhg7eNx05V60GDkXKS2mt10ChPxZfWo=;
        b=VkNyjXVlxS3NIQspKMQxDnvauKd6DvbImgdmGlKFZ25nnVEO5hb5b0gOx/q41G59OM
         fDxwrJE/7L0bIgFrh/Oe3SK26uGLFW/93/uIvOyiYd2a+YZv5V4Co5byD2lquUIBqBTl
         qWhovB5VrgBbKPqTrun8ytqNDSu4wgf+b7WudtmFJZvfduiiCFSlDO38kRTkhbVED6aM
         nJEwpBKz6TS/Spunrmkzakrmr4qvfnZIOpwEcSkw9eho1BtpI7UtMw1wIG9c3CKuiHcB
         PB8vmLDoe0Jo5/X6EzVKZtN3+hbKQjnND4dfDwe7xidOxA2aY8vkZtZRn7Kw3T0n/RYc
         lHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vmeUDsYhyilXUhg7eNx05V60GDkXKS2mt10ChPxZfWo=;
        b=NJmE5Q/oVw8oR1e08TqqRtXO8U3e3KEUVlWruTw0t4AbnuejbiFGRQD/NNJv65cwFb
         IjmLgc3QHPpYTWG0rJZjiaPHI023/FPg/vVW/cgJnd9W58LjkT9Re6PVMlhkCh1Gn60V
         McuF5Z6OortuXdlfP2f1a4pPacO4jJLNecSsOz9aj8lnE8sCuThWtVgsIqQt31z5tTRb
         7AJ5h8VlyNPPQG3xQmB7vCqpdR97Bh4aqZPMVcpl2wI6c+HozqLxTt9w07GS25AHzawT
         RQviCryCRrdcZCP91i53ZfAXsDpGOCsmsgkBrJevMprTTiWS3vBtZm6nNu1btFcPw/yH
         bEbw==
X-Gm-Message-State: AOAM530VczX7QP0YHgggsjI7tGmAPXYsR4etLfPiTAxtCJQNncK88jsu
        7qUK7FRL9Ey3EqkC3/C43VQ=
X-Google-Smtp-Source: ABdhPJyVEXxdvd6+WSsadNTn0AecrGeZkr/O2nzE7LtUbFF6f3JCdReqCBSnJSJXYJcK1/5XEcqMHg==
X-Received: by 2002:a05:6a00:1681:b0:4a8:2462:ba0a with SMTP id k1-20020a056a00168100b004a82462ba0amr66110940pfc.75.1641590714342;
        Fri, 07 Jan 2022 13:25:14 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id v17sm9822159pju.1.2022.01.07.13.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:25:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 7 Jan 2022 11:25:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] kernfs: use kernfs_node specific mutex and
 spinlock.
Message-ID: <YdivuA12i3VU8zO/@slm.duckdns.org>
References: <20220103084544.1109829-1-imran.f.khan@oracle.com>
 <20220103084544.1109829-2-imran.f.khan@oracle.com>
 <YdLH6qQNxa11YmRO@kroah.com>
 <719eb5d2-680c-e596-1446-3ca8f47c3aea@oracle.com>
 <YdP57ij4JxahpdnC@kroah.com>
 <YddRVH4r6uNHt3xa@slm.duckdns.org>
 <03cb9939-efbb-1ce8-42f5-c167ac5246da@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03cb9939-efbb-1ce8-42f5-c167ac5246da@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jan 07, 2022 at 11:01:55PM +1100, Imran Khan wrote:
> Could you please suggest me some current users of hashed locks ? I can
> check that code and modify my patches accordingly.

include/linux/blockgroup_lock.h seems to be one.

> As of now I have not found any standard benchmarks/workloads to show the
> impact of this contention. We have some in house DB applications where
> the impact can be easily seen.  Of course those applications can be
> modified to get the needed data from somewhere else or access sysfs less
> frequently but nonetheless I am trying to make the current locking
> scheme more scalable.

I don't think it needs to show up in one of the common benchmarks but what
the application does should make some sense. Which files are involved in the
contentions?

Thanks.

-- 
tejun
