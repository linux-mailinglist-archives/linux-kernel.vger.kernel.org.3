Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039CB461BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 17:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244953AbhK2Qcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 11:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhK2Qah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 11:30:37 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AE0C08EB3E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 06:23:20 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q16so16216378pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 06:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YLydFlTHoWjzh5FM2f+PSZxxi/Xa/coyUIlxGE2+P/Q=;
        b=aPvFo5iJR6a2oq0v6KDaGZ+uraf1SiLFUfddWlQ2epY6HloVDYOnx8727S1jwPD6HY
         ItNr3qSPj6B2f4kSBxPB00VOU+uu8Rel3vCjvsuRm0eeyjHYc1gH6eMKApnXUcmlX7c8
         FLMuJw66HA6PdT7RXY4xmDitWaHcjAMrPfdMTHcQq6z8brSpsK5BeqcVkDREqtMpKhdp
         BTh2WaXbZQ5ezkBRiKj4galF04LIzV3k5l/u74IWsDpKcCoYaVDhdEm3YNr+QwxuS/qr
         Zxh8Jw0PXetjmGELbLjED/3DEIL8k/OfteWo4AG92DefXID8+Xl5Fqi0NT3/0rKSbQc/
         2Fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLydFlTHoWjzh5FM2f+PSZxxi/Xa/coyUIlxGE2+P/Q=;
        b=owlGw/Y2UBI3hikYekFRHOLX7nt0vIEpho95mrMlgyaoOGg1291My9lZiHgCsBzPAr
         n7ToXnfzAMiWtORVeSROjTuhdnLiAAiLkOlafQLCVpnfDzoHXy5wJ+OoILUhLkeywDuI
         7gHDStOgT12BSxPuzt+KxfUOfzztzL47a/cUPlFL0FCyjkdMTxuwGQ/DQ8SrJeuf3piO
         t3ZaIxbY9+fJCDmZTqXhAPunO1wcy1eh802oXLZGjXmkxlcAKoYh1BnLAMoK3muH/ysD
         7761S4mo3p/U/40egquD0Aq/hcoy1O9ryGPy5eS8I3jYDenlGLHN1lLwXxvNe769YIF3
         kCJg==
X-Gm-Message-State: AOAM533nY36dkYfHOGTgRMX1S01f37Yv5sLPdrr8ZOuHb91YF61ZvAws
        0tsbeb73FpfyNd3fXEouKLijNB1/QbKvaQ==
X-Google-Smtp-Source: ABdhPJwgqJmtr+dmVevA9fhP1HnZR/+rr++6rgnFxNlGzrM9TJGgVIiDWycKiGqqnXfntCD6Gn4vow==
X-Received: by 2002:a63:8041:: with SMTP id j62mr21442126pgd.517.1638195799623;
        Mon, 29 Nov 2021 06:23:19 -0800 (PST)
Received: from localhost.localdomain (bb42-60-144-185.singnet.com.sg. [42.60.144.185])
        by smtp.gmail.com with ESMTPSA id o2sm19010699pfu.206.2021.11.29.06.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 06:23:19 -0800 (PST)
From:   Nguyen Dinh Phi <phind.uet@gmail.com>
To:     m.szyprowski@samsung.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, tj@kernel.org
Subject: Re: [PATCH] kernfs: switch global kernfs_rwsem lock to per-fs lock
Date:   Mon, 29 Nov 2021 22:23:16 +0800
Message-Id: <20211129142316.4191999-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a7464856-486a-a76a-937c-35a426555507@samsung.com>
References: <a7464856-486a-a76a-937c-35a426555507@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>This patch landed recently in linux-next (20211126) as commit 
>393c3714081a ("kernfs: switch global kernfs_rwsem lock to per-fs lock"). 
>In my tests I've found that it causes the following warning during the 
>system reboot:
>
>  =========================
>  WARNING: held lock freed!
>  5.16.0-rc2+ #10984 Not tainted
>  -------------------------
>  kworker/1:0/18 is freeing memory ffff00004034e200-ffff00004034e3ff, 
>with a lock still held there!
>  ffff00004034e348 (&root->kernfs_rwsem){++++}-{3:3}, at: 
>__kernfs_remove+0x310/0x37c
>  3 locks held by kworker/1:0/18:
>   #0: ffff000040107938 ((wq_completion)cgroup_destroy){+.+.}-{0:0}, at: 
>process_one_work+0x1f0/0x6f0
>   #1: ffff80000b55bdc0 
>((work_completion)(&(&css->destroy_rwork)->work)){+.+.}-{0:0}, at: 
>process_one_work+0x1f0/0x6f0
>   #2: ffff00004034e348 (&root->kernfs_rwsem){++++}-{3:3}, at: 
>__kernfs_remove+0x310/0x37c
>
>  stack backtrace:
>  CPU: 1 PID: 18 Comm: kworker/1:0 Not tainted 5.16.0-rc2+ #10984
>  Hardware name: Raspberry Pi 4 Model B (DT)
>  Workqueue: cgroup_destroy css_free_rwork_fn
>  Call trace:
>   dump_backtrace+0x0/0x1ac
>   show_stack+0x18/0x24
>   dump_stack_lvl+0x8c/0xb8
>   dump_stack+0x18/0x34
>   debug_check_no_locks_freed+0x124/0x140
>   kfree+0xf0/0x3a4
>   kernfs_put+0x1f8/0x224
>   __kernfs_remove+0x1b8/0x37c
>   kernfs_destroy_root+0x38/0x50
>   css_free_rwork_fn+0x288/0x3d4
>   process_one_work+0x288/0x6f0
>   worker_thread+0x74/0x470
>   kthread+0x188/0x194
>   ret_from_fork+0x10/0x20
>
>Let me know if you need more information or help in reproducing this issue.

This patch has a problem, in function kernfs_remove(), it call to 
__kernfs_remove(kn), which will free the related @root of @kn, it means the 
root->kernfs_rwsem will be freed too, but it is still being held by the call 
to down_write(&root->kernfs_rwsem) around line number 100.

BR
