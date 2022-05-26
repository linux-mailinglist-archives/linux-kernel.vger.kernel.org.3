Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47D5534880
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345910AbiEZB64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345891AbiEZB6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:58:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A228BCE85
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:58:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o10-20020a17090a4e8a00b001df2fcdc165so3205994pjh.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kGL6h5v+Jr74W1Yhb+Bf5QfP2tpx/zeVbCOX59bHIDg=;
        b=6XMugYmG+RUzN2StHKzTsP39OPJNYLJCQObzG+2FFmneHpobDjdWIRdY3HskteR7ZQ
         +y9BoEU+++ihSyELnRUGFnA1pD6EW3RxiDJ3MuSe7G2PtTnSSz9kmnwqfssiHH2p8MP1
         inMrblr/tC0RwZDvcfd3jiKeO7VFs9OLhILAiTiKo3dBmGwhwXkQyear1mwraKi36zNo
         B3vjRDg9YiY7Q1G5L370pM7cScF2zE4oRBjW7I9piLH3jWTwjNzaEqTKaD61xg3cs/lD
         QbrnO2HfvtvCc+K1/QIK+x85eom8nR7L9KgyQJUGz4/KGDkstI0/Ui2TwMCNdlbuVF3n
         EMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kGL6h5v+Jr74W1Yhb+Bf5QfP2tpx/zeVbCOX59bHIDg=;
        b=cWRVxIRJm+M8kaMxQ9nhvXe6HCFNJiSUC4+VQ3ul0bbHq2j+VMgyX/eG3c14TNVmnz
         UR+AFt6K5ZeYycPVhruioVhC3uIIh6+uOKvbIG7r9Wmc5o5Y8IZN3Kg2YEWJYRTDXttQ
         /mVbFGqPuE/T733/XbR7hC6tTpbqzUCkSF7jsiwQ20JI9Oibo7nquMwRqSkSSc25YSQH
         KD5w9VVMYMJQN3wpgg5xGKDehp2BWVZgPLgRbVSr/hi0Dz0VS5WID1fP/mGdBQzazQ5Y
         49tLlda15n1lslruUx5TTQWnN8lh6os3ZHkOydbfo2aSCmx8NxNwK/tCrpjEdeMWe/zF
         FRrA==
X-Gm-Message-State: AOAM531XwrAxabk11POXPlWqYFxe3toeT34JCVopoPgq0RoeeKIL1nQc
        oO8KKY1ZbtcmI/n7MDqofmWtkw==
X-Google-Smtp-Source: ABdhPJyecRSqOMMOeKI3i4gTLNfcDTqJwxnemVDUYrbKOQnvinFvVfcOT5vypfUsGRm8USrxsDh9VQ==
X-Received: by 2002:a17:903:22cd:b0:161:be20:577 with SMTP id y13-20020a17090322cd00b00161be200577mr36110298plg.54.1653530328625;
        Wed, 25 May 2022 18:58:48 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40c:3e14:bb57:48be])
        by smtp.gmail.com with ESMTPSA id 26-20020a63195a000000b003c6ab6ba06csm188772pgz.79.2022.05.25.18.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 18:58:48 -0700 (PDT)
Date:   Thu, 26 May 2022 09:58:42 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v4 2/6] mm: shrinkers: introduce debugfs interface for
 memory shrinkers
Message-ID: <Yo7e0st/IiSpkfQR@FVFYT0MHHV2J.googleapis.com>
References: <20220525202600.2910982-1-roman.gushchin@linux.dev>
 <20220525202600.2910982-3-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525202600.2910982-3-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 01:25:56PM -0700, Roman Gushchin wrote:
> This commit introduces the /sys/kernel/debug/shrinker debugfs
> interface which provides an ability to observe the state of
> individual kernel memory shrinkers.
> 
> Because the feature adds some memory overhead (which shouldn't be
> large unless there is a huge amount of registered shrinkers), it's
> guarded by a config option (enabled by default).
> 
> This commit introduces the "count" interface for each shrinker
> registered in the system.
> 
> The output is in the following format:
> <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1>...
> <cgroup inode id> <nr of objects on node 0> <nr of objects on node 1>...
> ...
> 
> To reduce the size of output on machines with many thousands cgroups,
> if the total number of objects on all nodes is 0, the line is omitted.
> 
> If the shrinker is not memcg-aware or CONFIG_MEMCG is off, 0 is
> printed as cgroup inode id. If the shrinker is not numa-aware, 0's are
> printed for all nodes except the first one.
> 
> This commit gives debugfs entries simple numeric names, which are not
> very convenient. The following commit in the series will provide
> shrinkers with more meaningful names.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
