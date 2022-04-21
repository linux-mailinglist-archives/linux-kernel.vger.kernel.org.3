Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066F250A204
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiDUOUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiDUOUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:20:45 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EA027FFC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:17:55 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id hh4so3300972qtb.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NGvnES751j4Kpm/2yGGRz1dr4K8jefdTS2zO6HL1LQo=;
        b=ZPAZ/ahk5mYAJFvXYDcer5zr1glKh98W1H94yE7fJYu3RfJdgQHb+WdQHFWNuH77tn
         RlRNbAEEiuQi3ELJfSo2IneS6DY7/piylSJtKZ8jsMRSY9wLoi7PPZ6OEg9+xxb7y/Nx
         4V2VfujoAiPffqcRvQL7bJum8Q6uGNQmRM84Uo0xYIEVspG2jjnyzH9MszH7L0GBx7P2
         oJumAdYl7SAAZJV1LN6U5BZh0EIl4w+6t/TSGJLshuGWFDlfTftMFwDjr1vMk/HcXlMx
         DGbx9ITYWAVBlbk85h0sIwNvZc6vou9qMuxYT1rEoyEgaAcYn1bHe6KAeyuUu1ZIty0o
         RMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NGvnES751j4Kpm/2yGGRz1dr4K8jefdTS2zO6HL1LQo=;
        b=bPKVHbI5UfVU4B+sYOS7MJ2M3jsa1Dm+nlEqZ/sy/Ky76+P3x5p4BjYPHKSTIXr8TF
         j/30STHkaQIzJQGdaF23BgGfwf3wBEqQm2hiXeTwYeTXkgBcNQkJe2AhryHvtF1rSlTf
         fbgm9mpZnV2iLZjbK6SyBJpFwC92OhSrAH6YQAEYIRIRxnhdL+881bBBH+cYQihnr8oY
         y4kACuDo+qTWvx2DQp0n7d7LkPd3uyztnfW+dGYNOTURhaxWlNDM2yviagpRH58eGkwg
         2roTHZn45LPgKtAOfBwYig2TO7cAQjtpeLgVQXURoN6HdDwxEtod5L0YWuDee+A6yBSS
         G92w==
X-Gm-Message-State: AOAM531U2+Q8GEh2F+bhjqbOIg9PlE9bg2QW9pKsLZX9Du0tiYCt9BI1
        JMI1sqbNX6mL6bSekU5cgLajQg==
X-Google-Smtp-Source: ABdhPJw3y6sc1cvuh7Iwow/lZYeFmmT2grlBR+uVbCJNQ4FTg1Ngw1CpMR+b8RQrjsWNrntsmms2Pg==
X-Received: by 2002:a05:622a:1194:b0:2f2:35b:28df with SMTP id m20-20020a05622a119400b002f2035b28dfmr12062976qtk.30.1650550674487;
        Thu, 21 Apr 2022 07:17:54 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id u129-20020a376087000000b0067e401d7177sm3118955qkb.3.2022.04.21.07.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:17:53 -0700 (PDT)
Date:   Thu, 21 Apr 2022 10:17:52 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -next] mm/memcontrol.c: remove unused private flag of
 memory.oom_control
Message-ID: <YmFnkPhMSilL92nq@cmpxchg.org>
References: <20220421122755.40899-1-lujialin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421122755.40899-1-lujialin4@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:27:55PM +0800, Lu Jialin wrote:
> There is no use for the private value, __OOM_TYPE and OOM notifier
> OOM_CONTROL. Therefore remove them to make the code clean.
> 
> Signed-off-by: Lu Jialin <lujialin4@huawei.com>

Good catch, it's been unused since 347c4a874710 ("memcg: remove
cgroup_event->cft").

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
