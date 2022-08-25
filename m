Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7675A181C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbiHYRom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239861AbiHYRoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:44:39 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7E6B6D2A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:44:38 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id io24so5852748plb.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=ywmy6tC4a8AFm3DYCGlNXvDbFK6O2fsc7cCstl/Zw4w=;
        b=ZTy3Iixf4EgulBk9eX/Zd5TCVbgnBAyLv5v/ctOEOV1jWT3q07bxvemAbhrjmbnxC1
         0mtt2gBrF/1VfSPN0xm0QF9x7dzoGtYGWsIgQzpDj9NMTP7RgRoXL4R4Jg2k2mDfqLvD
         IGYslx0hJeDaLfYKSbDjKziBL0/aBVhIkIBypSBG+jG10MtpE8mKs1I7zf+V6hAB2qTH
         Ey6ubMna4RSV7WpajSx4G4+t7HDZPN+KE2HhRujPGTISpkTpSGcwUQgmfLiDQD1yqazp
         QBgJvavu23VKPW/fvXiuVs/XDF7eo7YRz6S7ENiP2c2XDBFWsHBT/UeZeyS257Od3zWN
         xjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=ywmy6tC4a8AFm3DYCGlNXvDbFK6O2fsc7cCstl/Zw4w=;
        b=j4+/hUD84REQRggMRgcbMbOue+U3jNHRedM4j55MGcmS4z9r8fa+jL/wcK8qVxA6xb
         aDkfioulFN7RqGsjmyzCCqvAJjjt6ZzkBlcTcgUs6FuSwyX1KyzVCvM+24sws7z0zGft
         Mzy0OZpuObgVdRjA79s/KuyHgwQIYiOOsFH3CrmIIScFYuaqLk3IQubmcTlxRlhb6HE2
         qUXkS84ooMOi/Sk/Vb7PatdjEz9XeAG8cyjvZIQ+TVQ07kDRbE9j0E26UnJAKZcPwvo1
         0j6gVZ50t+U5ChMqVrltd+/R5eq4kutfqUrghlogTJgQVfeXnccGmnv16YZ5OfqKl6JQ
         qviQ==
X-Gm-Message-State: ACgBeo2gUhm+UpXBqEAdY4mNquU1mHaVMuX3wSRDNAGqdANtbfwbEPjg
        jLHvUUMaatR2Qr4rHOLntRk=
X-Google-Smtp-Source: AA6agR50eAwdxfHFqnm1CltXt/HOMr43FHryzBuGGoE9wRuQ+gkeC7dIbFIJGRFtCbMevo013xV/Ig==
X-Received: by 2002:a17:902:ce91:b0:172:c2c4:e6be with SMTP id f17-20020a170902ce9100b00172c2c4e6bemr187471plg.99.1661449478245;
        Thu, 25 Aug 2022 10:44:38 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p64-20020a625b43000000b005379fb50ff0sm1460192pfb.50.2022.08.25.10.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 10:44:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 25 Aug 2022 07:44:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Imran Khan <imran.f.khan@oracle.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>,
        syzbot <syzbot+29d3a3b4d86c8136ad9e@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] cgroup: Add missing cpus_read_lock() to
 cgroup_attach_task_all()
Message-ID: <Ywe1BAeUsJV7ZXzF@slm.duckdns.org>
References: <0000000000009ebf5605e6ff48d5@google.com>
 <0000000000000bc13705e702955b@google.com>
 <cb0b22e1-0d55-cb06-7401-37581c18169b@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb0b22e1-0d55-cb06-7401-37581c18169b@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 05:38:38PM +0900, Tetsuo Handa wrote:
> syzbot is hitting percpu_rwsem_assert_held(&cpu_hotplug_lock) warning at
> cpuset_attach() [1], for commit 4f7e7236435ca0ab ("cgroup: Fix
> threadgroup_rwsem <-> cpus_read_lock() deadlock") missed that
> cpuset_attach() is also called from cgroup_attach_task_all().
> Add cpus_read_lock() like what cgroup_procs_write_start() does.
> 
> Link: https://syzkaller.appspot.com/bug?extid=29d3a3b4d86c8136ad9e [1]
> Reported-by: syzbot <syzbot+29d3a3b4d86c8136ad9e@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 4f7e7236435ca0ab ("cgroup: Fix threadgroup_rwsem <-> cpus_read_lock() deadlock")

Applied to cgroup/for-6.0-fixes and sent pull request.

> Waiting for test result from syzbot. Should we remove "static" from
> cgroup_attach_lock() and call from cgroup_attach_task_all() ?

Yeah, that probably is better. Can you spin up a follow up patch?

Thanks.

-- 
tejun
