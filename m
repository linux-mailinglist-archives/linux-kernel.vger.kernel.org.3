Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4D24CA95B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbiCBPqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiCBPqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:46:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0253156433
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:45:31 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso5158408pjk.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 07:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xTJHpKyMbwJIUTzbPcREPP/lO0zjzJYVICFI+irUGpk=;
        b=b6fPZJA+5kErDGZ8x8Ts/e+b46TsKRHIX0aSI4l9Yty0tOt/p+y8BJUR4MBLu9Fb9Y
         G7v8Cu5SydgifnGgKyfoP2dlRFczNNHOm9cEMFEsS4ptMqRdsTvkjQU7fUHE/eGus/LV
         4bths2zNpMvsCMpo0uedRlHGKV4pProYn23RIbYsPESbklU13+Qz9ZEQgSNEF2lsHS/J
         VKoYW1Ko/SBqoX9YGZZIQODSOTzGPpKHntN7iRWDUuXrL0anG6quz8GYw/7uYGQ2wnFG
         5Es9OMNTFQNqwc3MZHbUk8FIT8Pkl4VUOIdsHyCWZIggcSdEeIsJ5PKktC8+DXAKvD+D
         PIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=xTJHpKyMbwJIUTzbPcREPP/lO0zjzJYVICFI+irUGpk=;
        b=lZ0E4GhZ1t5oaQDIVLHOB0mAvhtWYCAgDJlv886UxkBfNMN36lT1noFOMjt0hy6ig+
         eAeFmuHICMWyw2G6ppRPIz/b8kUGQ7n2+om0cOSuXi2aR/nGhTCqW6MCu+bQHvtKEky8
         LdKq982nMViNR00JWlTt0RDXprFTZYg9WH4Vmph2PhvGqfy8azJFWvBbozo7ON0uMi4b
         NoAv8OoUyv3dIZP9c/SBNGqHkiyH308XSWsmOUE2uH4AbeK/GQ5ces2lHjhRcXHMgIrj
         adkYZmKzXBEVVxSAlWTsnKh/iQ9RDRRkgDwl/lNzA+1o9ESvZaK7TPbvN0jtcJIsxXEh
         75Qw==
X-Gm-Message-State: AOAM533p13bYyo3uaUH12i2RWXO6yIgaYFSHYG/0y03fi+MCkcQHEyIS
        oehicxpCu2k2xts4XYY2EXo=
X-Google-Smtp-Source: ABdhPJx7IBO40FGSetPEogK3UAM18nV0y8/Vc7lnhOXG0gE+j4L2C5GsekpKWK2xDhJndgJ+7KE5wg==
X-Received: by 2002:a17:90a:c901:b0:1be:ce4d:7cee with SMTP id v1-20020a17090ac90100b001bece4d7ceemr360863pjt.213.1646235930058;
        Wed, 02 Mar 2022 07:45:30 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id g19-20020a056a00079300b004bca2737f34sm19882902pfu.187.2022.03.02.07.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 07:45:29 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Mar 2022 05:45:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, brauner@kernel.org,
        hannes@cmpxchg.org
Subject: Re: Use after free in cgroup_migrate_execute
Message-ID: <Yh+RGIJ0f3nrqIiN@slm.duckdns.org>
References: <549de740-1356-7ad2-3ee5-c52bc355fd99@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <549de740-1356-7ad2-3ee5-c52bc355fd99@quicinc.com>
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

On Wed, Mar 02, 2022 at 08:42:32PM +0530, Mukesh Ojha wrote:
> Hi ,
> 
> We are facing one issue like below in cgroup .
> Not able to find which race could lead to this.
> Any idea, would be helpful.
> 
> [136233.086904][ T1457] ------------[ cut here ]------------
> *[136233.086912][ T1457] refcount_t: addition on 0; use-after-free.*
> [136233.086943][ T1457] WARNING: CPU: 4 PID: 1457 at lib/refcount.c:25
> cgroup_migrate_execute+0x188/0x528
> [136233.087527][ T1457] CPU: 4 PID: 1457 Comm: PERFD-SERVER Tainted: G
> S      WC O      5.10.66 #1
> [136233.087532][ T1457] pstate: 62400085 (nZCv daIf +PAN -UAO +TCO BTYPE=--)
> [136233.087536][ T1457] pc : cgroup_migrate_execute+0x188/0x528
> [136233.087539][ T1457] lr : cgroup_migrate_execute+0x188/0x528
> [136233.087541][ T1457] sp : ffffffc01ff23a60
> [136233.087543][ T1457] x29: ffffffc01ff23a60 x28: 00000000c0000000
> [136233.087547][ T1457] x27: ffffffffffffeaa8 x26: ffffff88cbc55668
> [136233.087551][ T1457] x25: ffffff878424d458 x24: ffffff891fdd5e00
> [136233.087557][ T1457] x23: ffffff88cbc55600 x22: ffffff8784d673d8
> [136233.087565][ T1457] x21: ffffff88cbc55758 x20: ffffffc01ff23b20
> [136233.087572][ T1457] x19: ffffffc01ff23b00 x18: ffffffc019475068
> [136233.087580][ T1457] x17: 0000000000000000 x16: 0000000000162ba8
> [136233.087587][ T1457] x15: 0000000000000004 x14: 000000000000407f
> [136233.087594][ T1457] x13: ffffff8ae5d48be8 x12: 00000000ffffffff
> [136233.087602][ T1457] x11: ffffff8785a79f98 x10: 0000000000000002
> [136233.087609][ T1457] x9 : 759287265d79e000 x8 : 759287265d79e000
> [136233.087616][ T1457] x7 : 206e6f206e6f6974 x6 : ffffffd7616121b4
> [136233.087623][ T1457] x5 : ffffffffffffffff x4 : 0000000000000000
> [136233.087629][ T1457] x3 : ffffffd7635ce996 x2 : 0000000000000000
> [136233.087633][ T1457] x1 : ffffffd7635ce996 x0 : 000000000000002a
> [136233.087636][ T1457] Call trace:
> [136233.087640][ T1457]  cgroup_migrate_execute+0x188/0x528
> [136233.087643][ T1457]  cgroup_migrate+0xb4/0xe4
> [136233.087646][ T1457]  cgroup_attach_task+0x128/0x20c
> [136233.087650][ T1457]  __cgroup1_procs_write+0x1d8/0x290
> [136233.087653][ T1457]  cgroup1_procs_write+0x18/0x28
> [136233.087656][ T1457]  cgroup_file_write+0xa4/0x544
> [136233.087661][ T1457]  kernfs_fop_write_iter+0x1b0/0x2f8
> [136233.087665][ T1457]  vfs_write+0x300/0x37c
> [136233.087668][ T1457]  ksys_write+0x84/0x12c
> [136233.087672][ T1457]  __arm64_sys_write+0x20/0x30
> [136233.087676][ T1457]  el0_svc_common+0xdc/0x294
> [136233.087681][ T1457]  el0_svc+0x38/0x9c
> [136233.087684][ T1457]  el0_sync_handler+0x8c/0xf0
> [136233.087688][ T1457]  el0_sync+0x1b4/0x1c0
> [136233.087690][ T1457] ---[ end trace 9e592742965258ba ]---
> [136233.087693][ T1457] ------------[ cut here ]------------
> *[136233.087695][ T1457] refcount_t: saturated; leaking memory.*

Looks like the target css_set ref underglowed but you have five taint flags
set and this isn't even the first warning message. Any chance you can
reproduce this in a cleaner environment?

Thanks.

-- 
tejun
