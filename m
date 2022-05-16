Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF31528D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345040AbiEPSlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344921AbiEPSls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:41:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731F126577
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:41:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso141328pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t0WHOZ8M8CCVArjgFOA4NPEPytdqu3cn45iRVUJfn8E=;
        b=qBLb0qbXoOY9QKvHcAiYwyp0wiZOSttrToExkPzqe2Grr7/BC8qdixbZAmIgKBTLFf
         iVZ+X/xkRkA8j5YNdbgaSrXSdXvNsyMN1WSukxGN7syh+Drk22gilsPRAC1HxL22ZPlu
         LBNWgvitZbzXbRx5alCuKFYQ/VeaLc9eC2SHop5verC+8b9lAYTJagBXHlP9U5/1s1gY
         FhFb3sJLldprxoV7SaUimnIdF01wfcFvEEPdxgfN8byq9NJATm2o4Smdi3HzyP4rNGUJ
         pNY3FPyvnGD0R+b2g47JMnbrZmv3dXFWq/beOKqoemJOagkcaCjHQW+B7i73hJlpBk0i
         m1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=t0WHOZ8M8CCVArjgFOA4NPEPytdqu3cn45iRVUJfn8E=;
        b=5XGlESe3DTNTFYl6U0htXE98ncC5ljJKYEez/0jS+rC+i0cXLqd5hK4cSxd8TtPEL0
         BXXbUNhI+lXBPMcUloRU52ZI+pWCN6eWc5V5dvofT75vLXbtYP0qNjT3/NKp9Ykz6WGY
         QAhrgfrUCiXm4P1qMUX6CRrILhJpyDDIQlJ59+cyVKynha/RoCuvqOdHl2ukcuI43uae
         PUbI65Tn8vzzKFd1hldp61AqazvUd+Y9MfEKNNIQANLESdShW5LaCl6JFqBhHDPui26p
         7s6UOtHN9CJ3YA8JC0xOa9C8r7VIoeGcUKRfaktXcGuRtdO7BX55ZmLpdw5UDO+Pd+IP
         i0Ww==
X-Gm-Message-State: AOAM532zIlPnm+oeo+EYiS2sseIKqGUXvdPEWjBJb7nSKTAMhFW2jZ/R
        vJa1J3hO2RA6OUUaHrbyPcx3Q7d2fmQ=
X-Google-Smtp-Source: ABdhPJy2q37S0Wo6xpbuq+dUCGWfdMJAGYloT0dM3vmRVjJ+G713bAP5OoihKCihUGqOPKylV5WdOg==
X-Received: by 2002:a17:90b:3a90:b0:1df:7e0f:f851 with SMTP id om16-20020a17090b3a9000b001df7e0ff851mr475982pjb.125.1652726506843;
        Mon, 16 May 2022 11:41:46 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:62fc])
        by smtp.gmail.com with ESMTPSA id ja1-20020a170902efc100b001617e18e253sm2442442plb.143.2022.05.16.11.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:41:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 16 May 2022 08:41:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hao Luo <haoluo@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: Separate kernfs_pr_cont_buf and rename_lock.
Message-ID: <YoKa6CLLF25xx6QX@slm.duckdns.org>
References: <20220516182859.3131675-1-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516182859.3131675-1-haoluo@google.com>
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

On Mon, May 16, 2022 at 11:28:59AM -0700, Hao Luo wrote:
> Previously the protection of kernfs_pr_cont_buf was piggy backed by
> rename_lock, which means that pr_cont() needs to be protected under
> rename_lock. This can cause potential circular lock dependencies.
> 
> If there is an OOM, we have the following call hierarchy:
> 
>  -> cpuset_print_current_mems_allowed()
>    -> pr_cont_cgroup_name()
>      -> pr_cont_kernfs_name()
> 
> pr_cont_kernfs_name() will grab rename_lock and call printk. So we have
> the following lock dependencies:
> 
>  kernfs_rename_lock -> console_sem
> 
> Sometimes, printk does a wakeup before releasing console_sem, which has
> the dependence chain:
> 
>  console_sem -> p->pi_lock -> rq->lock
> 
> Now, imagine one wants to read cgroup_name under rq->lock, for example,
> printing cgroup_name in a tracepoint in the scheduler code. They will
> be holding rq->lock and take rename_lock:
> 
>  rq->lock -> kernfs_rename_lock
> 
> Now they will deadlock.
> 
> A prevention to this circular lock dependency is to separate the
> protection of pr_cont_buf from rename_lock. In principle, rename_lock
> is to protect the integrity of cgroup name when copying to buf. Once
> pr_cont_buf has got its content, rename_lock can be dropped. So it's
> safe to drop rename_lock after kernfs_name_locked (and
> kernfs_path_from_node_locked) and rely on a dedicated pr_cont_lock
> to protect pr_cont_buf.
> 
> Signed-off-by: Hao Luo <haoluo@google.com>

Can you please add a comment explaining why the lock is separate? Other than
that:

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
