Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255465B0D60
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiIGTid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiIGTia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:38:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC36ABFEAD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 12:38:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso19355597pjh.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 12:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=RklU/hIBIkY0kKlgNnnkAXogrz9CZQU5PUxPN62R/Xg=;
        b=q6Ob1DzVjsFdEeFHbV7+WhmUR2Sn4qBIqdKJvlbUbTKK7jQ0YVksbWJ8S9lYBujIX9
         LBHuQolM/UaPtQY3ExHYfolv1oUL5DuR+ZlvDfodX0w6nKk2ImdKRujfoOXD3ParAjOS
         LGvY8HXO7Z//taly4ObtyciRK2olm5B0ck/0UF05bhOyvkeuMi+FbaHyD59zOzrF+Lgt
         ZcgOeB2bJaviH21HBPbT6XDU/1OSTYAPzJ8kzU+8gXHKhNj11+JIn1kXadldIfiOZ8Ta
         M485/MQ2GkAJ4v7G9vJ0h9fI4LYKsvrgmB2/ivj1UPWmHLgk4RIV2GPG9nxG3nL6xIwk
         GFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RklU/hIBIkY0kKlgNnnkAXogrz9CZQU5PUxPN62R/Xg=;
        b=X8+WgfLJ3oSMgAfdXLXhljGyBHipQrw1UgWxPe00NyQmFDZEJW0Td4TSxIpx8Gz3rd
         l2fcq4AXJlwOeo7Lz4FYfxU9M8oawqYWtkezO0McmuY/IaLM8CY/PejGg5HbTpl4QKdf
         EU3M3OFZjFtEliSlsgpIgejPzg1Po96F4O20AhtZ4R4PRj/UGlOSz2+4aiVEgTGlLJiO
         FRaCT0l+nQKQtg5+f7JQ+s1PoN29HpPtoXjTTRgoB89Qokx4HY8isCsKrGKCVZrCxkjG
         Dea4Yb36APj8PfkNjep3airYn0lzSLDW9RaBpTwRuzGgeRiOm7Fn6TNH8HLteWMNDLA5
         Yv2Q==
X-Gm-Message-State: ACgBeo20mX7GALYXSw50Ad/mtlvRr1ocUn6yYPPk9iH5am2MQMaKgTxS
        jhZDuIWfhE3hTHYznc6C+OI=
X-Google-Smtp-Source: AA6agR7w8UGj9y5U2ZyN5Ab6JnhQkJMubRcl6QBz+SOlC0s1RNWgjew02WZyjcL+LqfSVCJhfLW2eA==
X-Received: by 2002:a17:90b:3e84:b0:1fe:3c34:8c5a with SMTP id rj4-20020a17090b3e8400b001fe3c348c5amr65945pjb.77.1662579509111;
        Wed, 07 Sep 2022 12:38:29 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:62af])
        by smtp.gmail.com with ESMTPSA id m7-20020a1709026bc700b00172ccb3f4ebsm8640324plt.160.2022.09.07.12.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 12:38:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 7 Sep 2022 09:38:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        kernel test robot <lkp@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:sched/psi 11/11]
 include/linux/cgroup-defs.h:432:38: error: 'NR_PSI_RESOURCES' undeclared
 here (not in a function)
Message-ID: <YxjzM9vv55meOAPU@slm.duckdns.org>
References: <202209070242.7EuRnstk-lkp@intel.com>
 <e95c6e55-a023-b6f7-1dce-4195dc22114a@bytedance.com>
 <Yxi4os4PUWSARTS/@slm.duckdns.org>
 <YxjzAnztFtvrtr96@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxjzAnztFtvrtr96@hirez.programming.kicks-ass.net>
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

On Wed, Sep 07, 2022 at 09:37:38PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 07, 2022 at 05:28:34AM -1000, Tejun Heo wrote:
> > On Wed, Sep 07, 2022 at 10:45:55AM +0800, Chengming Zhou wrote:
> > > 2. This patchset depends on Tejun's commit e2691f6b44ed ("cgroup: Implement cgroup_file_show()") in linux-next
> > > 
> > >    Maybe peterz-queue should include that first? I don't know what's the normal way to handle.
> > 
> > FYI, this patch is in the Greg's driver-core/driver-core-next branch. If
> > it'd be better to route these through the cgroup tree, let me know.
> 
> I can base sched/psi off of sched/core and driver-core-next and do a
> separate late pull for it I suppose.
> 
> I'm guessing that is more or less what you'd end up doing too, right?

Yeap.

Thanks.

-- 
tejun
