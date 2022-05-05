Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CFC51C9DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385531AbiEEUGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244961AbiEEUGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:06:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94B15EDF4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 13:03:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q4so2506173plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=brkJ6owvYL1KoosVSZE4yumPgk1GO96GIBcBjKpOKvc=;
        b=omBR79tG1I04L4QPaHcpmVt4Hckx2Jx3tNtHLIg8QieI5aS2Ck0SMkoRFhw10ZtBVj
         DDDM9vzyz/kYTqIKGH9wwmiLZmZRcBplqc1BT7c3vP0RS0zs/RA34Tul698mcRglqjEp
         anCH5uR1UXdXTg3Stj/f9igDhwAEnGP8KIqDMnSAbCcrB4Ciq46FhoqEoe6D1zIKgCWm
         8LncoIshUZUgdLrJWss2bJvGdKb3+0KhjTxWL+fp/gcnPSeU2hM32QKzceMLTEqp8ktk
         gHaHFzdEbQ9cyBo/3C3UOvcwHiu1CXJXwhwzUDQpYY9bK1jzy+zZ08e7X1N/UEDAfeKl
         PmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=brkJ6owvYL1KoosVSZE4yumPgk1GO96GIBcBjKpOKvc=;
        b=dJPOy31ZM2OS8VxxhwDKm+06xn5k8vxVF1t38k7O9CAelRZgFMApFF2+7rpN7udx1L
         qMlsqFdTV5zZ+0PgVwAelLuvwOaKAw+vfMbObBZlsX8P0rNUgryab5HLi6gibZC6wCpr
         Wl9Nn5tFvStGfBDtwEuAhVuzZPR5wInO7Evm5te75BZfEF8gl3eNc2iKJ8xnyA7YEZnu
         VEBjPzOPURcOcoL5z08r57Eph7Fa2eg5SN6eWK/xoBd4Ezk1097n4mUc7RaJGoTUHyJf
         /qTIOZTyvA3pX7lxykgXEqBEfKGEQaS8MH0f5auCSZ9YHYbrAy0TEd2nW22X07zk/uc7
         D+iQ==
X-Gm-Message-State: AOAM5306/mI6Y3OnXwHv40qN/G7iI2ssmQzcXoaIFIMgpcXfC59yaJvk
        KodQTbdjgf33r0eKJb35Eos=
X-Google-Smtp-Source: ABdhPJxy92iV18NVqGQGN4MZhQws6tWKkCHNAtFLuaM68y0/MTXyr/u+TWqCiQU2DohJW4su+2MqQw==
X-Received: by 2002:a17:90b:1b4d:b0:1dc:c33c:3fc9 with SMTP id nv13-20020a17090b1b4d00b001dcc33c3fc9mr12362pjb.123.1651780982218;
        Thu, 05 May 2022 13:03:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:29a5])
        by smtp.gmail.com with ESMTPSA id v68-20020a626147000000b0050dc762814asm1800181pfb.36.2022.05.05.13.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 13:03:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 May 2022 10:03:00 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] kernfs: Change kernfs_notify_list to llist.
Message-ID: <YnQtdJ2cPLfSELmA@slm.duckdns.org>
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
 <20220428055431.3826852-4-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428055431.3826852-4-imran.f.khan@oracle.com>
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

On Thu, Apr 28, 2022 at 03:54:29PM +1000, Imran Khan wrote:
> At present kernfs_notify_list is implemented as a singly linked
> list of kernfs_node(s), where last element points to itself and
> value of ->attr.next tells if node is present on the list or not.
> Both addition and deletion to list happen under kernfs_notify_lock.
> 
> Change kernfs_notify_list to llist so that addition to list can heppen
> locklessly. We still need kernfs_notify_lock for consumers (kernfs_notify\
> _workfn) because there can be multiple concurrent work items.
> 
> Suggested by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
