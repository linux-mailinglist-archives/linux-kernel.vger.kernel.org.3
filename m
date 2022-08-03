Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0835888C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiHCIjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiHCIjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:39:52 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAC51CFD6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 01:39:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j15so12577202wrr.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 01:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t6EpmrJg1rl4P6DA/NKdt4w33GwmTrl1EmhjtCL6AeI=;
        b=UXLnQ6/t/uA0Mr9SmTcP7ICttNhDLKgVrmd289QRlCx+8YnfquUAh7BjyfAseqrPAp
         HjlJjpCwMfiDL+DMFLTWtXTVEruKPf1wlzeLDSUkly1uksFsquLIClIOY5he8wuKAq9y
         jIs1TMigHTN+YL22s/rqfPUFT957jQOALFpgMa7kMGJgxURvE5mH/MhFQuzDweFSFmtA
         /6p+Fna6betFlIo8xOn4AsfDWq1yjzkSLOfdf7IMXGyhTeuVvJtFzuQ3SasgJvP0hf7C
         YpGNxGQOkczPLSPMVWcLOq0uwDnY5k81Eid1Sb+lpCFzVSD0lz3dmJ1ANUW7yBY9ORPg
         JcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=t6EpmrJg1rl4P6DA/NKdt4w33GwmTrl1EmhjtCL6AeI=;
        b=cJCmqheZdE+HeaEk1bRgfpJxBAyWcNV9NX2vmUB8VehGF92MxBG97tb/nPsfUEOwYp
         Xb4LaYGRZB0sEJMmxzLlUJ2OWiooyDxo3EA8o5srG7fw/ydec+yrut1UGE5AgJrI5r52
         FqU2cRUON4XEZjxVWzT6OCSvlvwnDmpZvbYDsrrLjKjPpnaQh679CheKJ3LxI1nrcvP8
         VKxXZjJqtvWpjQLQ6nypY+iW6zt5qDIBLZcW/os3meSNGd921UH2n1B9aiRKYpyJNJQd
         vL0rRXh8Xce351Iu4dO6Kutt751i6Hx2WT3l9mkI3zVwvXGDHn/yr8ql4NhT/eBV+lWd
         5E9w==
X-Gm-Message-State: ACgBeo1f3raQrChdZTew8aHK7gPcmN/RocsLcLG8WWroGgZnaiyR90Yl
        HRPnGm3zb3JRBZSN2esA3I7DOlNrOUA=
X-Google-Smtp-Source: AA6agR7f0o5CP/x81CJAcR+/T0qRCWUcs5kZzvLRWDKXss+H/j6DQcCh7ZOfOylQCAdbIzLKfyFiTQ==
X-Received: by 2002:a5d:5e8a:0:b0:21e:b9c9:890e with SMTP id ck10-20020a5d5e8a000000b0021eb9c9890emr15139925wrb.27.1659515990173;
        Wed, 03 Aug 2022 01:39:50 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c510200b003a3270735besm1656586wms.28.2022.08.03.01.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 01:39:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 3 Aug 2022 10:39:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/debug: avoid executing show_state and causing rcu
 stall warning
Message-ID: <Yuo0U2aWUZRLBAsA@gmail.com>
References: <1659489525-82994-1-git-send-email-liusong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659489525-82994-1-git-send-email-liusong@linux.alibaba.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Liu Song <liusong@linux.alibaba.com> wrote:

> From: Liu Song <liusong@linux.alibaba.com>
> 
> If the number of CPUs is large, "sysrq_sched_debug_show" will execute for
> a long time. Every time I execute "echo t > /proc/sysrq-trigger" on my
> 128-core machine, the rcu stall warning will be triggered. Moreover,
> sysrq_sched_debug_show does not need to be protected by rcu_read_lock,
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> and no rcu stall warning will appear after adjustment.
> 

That doesn't mean it doesn't have to be protected by *any* lock - which 
your patch implements AFAICS.

There's a couple of lines such as:

        for_each_online_cpu(cpu) {

... which need to be protected against CPU hotplug events.

I haven't checked any of the deeper code to see what RCU or other 
protection it may need, but clearly you didn't either ...

Thanks,

	Ingo
