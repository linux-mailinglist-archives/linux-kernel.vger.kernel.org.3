Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C6159AA9F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 04:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbiHTCGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 22:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiHTCGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 22:06:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E51104471
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 19:06:04 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gb36so11796277ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 19:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc;
        bh=PGhNSQLIn/ZoIFIjGbm3ePERCEF0hihTt1y3R9iOg80=;
        b=EjpOGt+n+VN/1y/8qbnTOTLkdvTXGd+Eyu2sa89rqbJW2T+djoGepA5BY4y0Cab7N/
         4uTltTKW/kCCFesRxXG8wyyk3YJywtLYPwq1wXc+G9g+3AYdXBuRdqESxkfmwy7XjyI0
         bJTFJFFugORG1om/MuxxuGUQi/QlhyTvMnYWwBEo4g2se4TbINfNhpHnl18v1oVzh9H/
         Dww/kXsdQ/7AA0Fxo3G8ovXkQwhqOTLCntE8Kl87Xvxrbl24bwPqnxed2lHxaLjhYl97
         mN3SeRDjI0AQpHanJPYcTSG1dlFCZBheT2T6CPLZ5zHllIAHBt5XnvFMjk1MWBYesTHp
         OLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc;
        bh=PGhNSQLIn/ZoIFIjGbm3ePERCEF0hihTt1y3R9iOg80=;
        b=eESy34vbWWIcT2EyVqBIzqiZwkFtqCKjP01RGFb9TRMdaWL2j+gbQKIkiSfncfUhVo
         lLSdD2eyeAmw5BG+rsxwv/gWuhkngpCm67NuL87doF3cjdF0+463BIwS34bZ0NCDcPWW
         9TGesk5KeiufRciwmtYBstA3G/ymulQw5t0Y4a8FHtTHOBM+1UhPYa/ycEu3j5c19v5w
         YWgvJojz9n4JHqwhCzYT1YWIB07eHVu+upWXLIT52WmhHUZKxsNUDj18hLeZAKxs/4cH
         VnUfyDgtvjOCezThVegQaU4c9HCe4QpER5Cwu2Iph8UmCYgaOvwLmJXvIK2EFbtiFmAl
         vm3A==
X-Gm-Message-State: ACgBeo2/cXgF5E8wwQ7jr76UD9rtzl4PTsskYaVCQvYMGD/h40/W2UJk
        hoRY3Dt6W23WHrvJHqAKBt4=
X-Google-Smtp-Source: AA6agR7G9k+/d7JV7sNAZQ5LDRtXkrTgcCZ/VHRhnNf8pdCjVF2oMv2AQzXjhGCb9krBii0wYNHtSw==
X-Received: by 2002:a17:907:6297:b0:72f:9aad:fcb with SMTP id nd23-20020a170907629700b0072f9aad0fcbmr6397591ejc.161.1660961162617;
        Fri, 19 Aug 2022 19:06:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id gq10-20020a170906e24a00b00734b3194ecesm3062400ejb.163.2022.08.19.19.06.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Aug 2022 19:06:01 -0700 (PDT)
Date:   Sat, 20 Aug 2022 02:06:01 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v2] mm/mempolicy: fix lock contention on mems_allowed
Message-ID: <20220820020601.vxeotpde5obuauqt@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220811124157.74888-1-wuyun.abel@bytedance.com>
 <YvUM7KaJaY+xnN2Y@dhcp22.suse.cz>
 <YvUOCTlk7HSgJkdY@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvUOCTlk7HSgJkdY@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 04:11:21PM +0200, Michal Hocko wrote:
>fix the lkml address (fat fingers, sorry)
>
>On Thu 11-08-22 16:06:37, Michal Hocko wrote:
>> [Cc Wei Yang who is author of 78b132e9bae9]
>> 
>> On Thu 11-08-22 20:41:57, Abel Wu wrote:
>> > The mems_allowed field can be modified by other tasks, so it isn't
>> > safe to access it with alloc_lock unlocked even in the current
>> > process context.
>> > 
>> > Say there are two tasks: A from cpusetA is performing set_mempolicy(2),
>> > and B is changing cpusetA's cpuset.mems:
>> > 
>> >   A (set_mempolicy)		B (echo xx > cpuset.mems)
>> >   -------------------------------------------------------
>> >   pol = mpol_new();
>> > 				update_tasks_nodemask(cpusetA) {
>> > 				  foreach t in cpusetA {
>> > 				    cpuset_change_task_nodemask(t) {
>> >   mpol_set_nodemask(pol) {
>> > 				      task_lock(t); // t could be A
>> >     new = f(A->mems_allowed);
>> > 				      update t->mems_allowed;
>> >     pol.create(pol, new);
>> > 				      task_unlock(t);
>> >   }
>> > 				    }
>> > 				  }
>> > 				}
>> >   task_lock(A);
>> >   A->mempolicy = pol;
>> >   task_unlock(A);
>> > 
>> > In this case A's pol->nodes is computed by old mems_allowed, and could
>> > be inconsistent with A's new mems_allowed.
>> 
>> Just to clarify. With an unfortunate timing and those two nodemasks
>> overlap the end user effect could be a premature OOM because some nodes
>> wouldn't be considered, right?
>> 
>> > While it is different when replacing vmas' policy: the pol->nodes is
>> > gone wild only when current_cpuset_is_being_rebound():
>> > 
>> >   A (mbind)			B (echo xx > cpuset.mems)
>> >   -------------------------------------------------------
>> >   pol = mpol_new();
>> >   mmap_write_lock(A->mm);
>> > 				cpuset_being_rebound = cpusetA;
>> > 				update_tasks_nodemask(cpusetA) {
>> > 				  foreach t in cpusetA {
>> > 				    cpuset_change_task_nodemask(t) {
>> >   mpol_set_nodemask(pol) {
>> > 				      task_lock(t); // t could be A
>> >     mask = f(A->mems_allowed);
>> > 				      update t->mems_allowed;
>> >     pol.create(pol, mask);
>> > 				      task_unlock(t);
>> >   }
>> > 				    }
>> >   foreach v in A->mm {
>> >     if (cpuset_being_rebound == cpusetA)
>> >       pol.rebind(pol, cpuset.mems);
>> >     v->vma_policy = pol;
>> >   }
>> >   mmap_write_unlock(A->mm);
>> > 				    mmap_write_lock(t->mm);
>> > 				    mpol_rebind_mm(t->mm);
>> > 				    mmap_write_unlock(t->mm);
>> > 				  }
>> > 				}
>> > 				cpuset_being_rebound = NULL;
>> > 
>> > In this case, the cpuset.mems, which has already done updating, is
>> > finally used for calculating pol->nodes, rather than A->mems_allowed.
>> > So it is OK to call mpol_set_nodemask() with alloc_lock unlocked when
>> > doing mbind(2).
>> > 
>> > Fixes: 78b132e9bae9 ("mm/mempolicy: remove or narrow the lock on current")
>> > Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> 

Thanks for pointing out. This looks correct.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

