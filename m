Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6EF5A99A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiIAODa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiIAODU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:03:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432FE11A0D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:03:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AF43921A09;
        Thu,  1 Sep 2022 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662040996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AKM5woBJZ/tCRh065vQzvgTeR5vNNBhhlwNnn/LvKxU=;
        b=VQv1uxV82L2X8SjfPVB1ErZODqTmdw4ESiqDNsyLyPjZ/iedOUX04HSoiUhvcekmnov9wG
        ChHJiOAzhYy9WeRp98DtUL/ia6NFmDJfuQmBNY0NoArSWSQB+FcEM67IaIYSdZjw5iTzM4
        Q9WylTwPwFvPQT/Gn8CDyrflkE86ryQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662040996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AKM5woBJZ/tCRh065vQzvgTeR5vNNBhhlwNnn/LvKxU=;
        b=s0N0J+x2QpG1msw84aPxYfM4XsO0cu0jy0HKNt2CNNw1v0fHaF50XMB+xvzMYFBW8pWbPK
        +q+V/D60FxgqJeBQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0FB772C142;
        Thu,  1 Sep 2022 14:03:15 +0000 (UTC)
Date:   Thu, 1 Sep 2022 15:03:11 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] sched/fair: cleanup for SIS_PROP
Message-ID: <20220901140311.xi3y72uxdwbpxzrq@suse.de>
References: <20220901131107.71785-1-wuyun.abel@bytedance.com>
 <20220901131107.71785-5-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220901131107.71785-5-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:11:07PM +0800, Abel Wu wrote:
> The sched-domain of this cpu is only used when SIS_PROP is enabled,
> and it should be irrelevant whether the local sd_llc is valid or
> not, since all we care about is target sd_llc if !SIS_PROP.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

This could conceivably result in an uninitialised memory access if
SIS_PROP was enabled while select_idle_cpu is running. I'm not sure if
it can happen when jump labels are in use but I think it could happen
for !CONFIG_JUMP_LABEL updating the sysctl_sched_features bitmap updated
via sysctl.

The patch is still a good idea because it moves an unlikely rcu_deference
out of the default path for sched features but either this_sd needs to
be initialised to NULL and checked or the this_sd lookup needs to happen
twice at a slight additional cost to the default-disabled SIS_PROP path.

-- 
Mel Gorman
SUSE Labs
