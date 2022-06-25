Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AED55A6D1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 06:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiFYEMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 00:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiFYEMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 00:12:50 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F41506CB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 21:12:49 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id t16so7427992qvh.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 21:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mu3odQ0M0Qvx/r7jdcJQ8ae46sgyjBsKuFfZlo4wFsQ=;
        b=csyFHmCigc+PbhykWmKVKhLdfXh8OzB8NQnqRVh0butI9dLvRGF6EbCb9bmbSwQScR
         aOcQo9cab3d5HByo4D6Tho/ZI6Cpgx6j6ZT7kJ6Uc74A/bxx+27H15N0rI9RWECTDYSz
         dBxVn4ma5Z3e+eVs7c9ag0zRwaGR/827LAsEKjgHNym0Axo2Jb9g/7t8YrR6Aw9Ut0bz
         hG1w7SpVFsecpzTw/TISvWktvEKrIn7ugsINl1pMSNzhx7wI3k0IoGT9Q5yLkc0+xif5
         js7lYv6RQPNHhawW6i4AIJ07KcgQ3V61QdV8GttlMNaS6h7UKExVdeLcx6iKal5c3Bf8
         +BeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Mu3odQ0M0Qvx/r7jdcJQ8ae46sgyjBsKuFfZlo4wFsQ=;
        b=j8a5o/aAM1uImYU4JllEgjzdTYJLmq3T2aKtkBQCJAsGbRaMGHIfQru/4VJCkB36eT
         jusJjZ3OPDYNsDDbMdX5MC2PCDZfn+3RDU1yNmaOxpnuwyqMaUt9SwL29QeGKXWGaDrs
         Sj223LauCcPYrW4H9simoYtn3PFIKRhwVkFKv37z+WFgc/KDbui2/2CR+wb+Ifi5KGr1
         e4thEzQ5UbZTkIFvT0YDUAg1IFRfSMVNK+6osltJyXSUMdke5BKonGWFp8Dt7ngT52Qu
         p+9tAteLelSc1ic8cYERHrrwetOFqHL+SHvK/a9rwL8ptBTh0gbc6COwIdO2u7TskFqz
         3JoA==
X-Gm-Message-State: AJIora/BNxa8PPwPKEFQOlj3Cfj1J5YuLYVXIjEY1yjLKlIyd/4MlZsS
        njj3Wl3UcP/qAoSEkL+YftI=
X-Google-Smtp-Source: AGRyM1sEzMij80swva6BuYGmnCoSR8BvOFFxX+9QgRq8oUrwrqOFVouuXbtGv1UUiHWxjQIcVNmiAw==
X-Received: by 2002:ac8:4e53:0:b0:305:2d86:8bce with SMTP id e19-20020ac84e53000000b003052d868bcemr1841127qtw.639.1656130368279;
        Fri, 24 Jun 2022 21:12:48 -0700 (PDT)
Received: from localhost ([2600:380:5224:f7e5:15cd:bf15:6146:ee5c])
        by smtp.gmail.com with ESMTPSA id b13-20020ac85bcd000000b00304ea0a86cesm2936346qtb.81.2022.06.24.21.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 21:12:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 25 Jun 2022 13:12:41 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: Change kernfs_rwsem to a per-cpu rwsem.
Message-ID: <YraLOZb2SnKl0wUO@mtj.duckdns.org>
References: <20220620032634.1103822-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620032634.1103822-1-imran.f.khan@oracle.com>
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

On Mon, Jun 20, 2022 at 01:26:34PM +1000, Imran Khan wrote:
> On large systems when few hundred CPUs simulateously acquire kernfs_rwsem,
> for reading we see performance degradation due to bouncing of cache line
> that contains kernfs_rwsem. Changing kernfs_rwsem into a per-fs, per-cpu
> rwsem can fix this degradation.
...
> Moreover this run of 200 applications take more than 32 secs to finish on
> this system.
> 
> After changing kernfs_rwsem to a per-cpu rwsem, I can see that contention
> for kernfs_rwsem is no longer visible in perf data and the test execution
> time has reduced to almost half (17 secs or less from 32 secs or more).
> 
> The overhead involving write operations with per-cpu rwsem will be higher
> but frequency of creation/deletion of kernfs files is much less than
> frequency at which kernfs (cgroup, sysfs) files are read.

The problem with percpu_rwsem is that write locking requires going
through a RCU grace period, which can easily add two or more digit
millisec latencies. I'm pretty sure there are code paths which are
pretty heavy on write - e.g. during boot, depending on the machine
configuration, we could be write-acquiring the rwsem hundreds of
thousands of times and we'd be constantly doing RCU grace periods.

So, I don't think kernfs_rwsem is a good candidate for percpu rwsem.
There likely are plenty of cases where write path isn't cold enough.

Thanks.

-- 
tejun
