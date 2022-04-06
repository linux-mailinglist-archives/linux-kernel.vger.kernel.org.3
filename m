Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21B84F66AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbiDFRUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbiDFRUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:20:17 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C7949679B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:18:05 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s72so2468821pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tD2HAuHG+5YJaSii4/pDZTUEWXTpWgVavDzLNdcJvRo=;
        b=ghciRJ4WeLtJOlmPaNKNNBc5YhuT7dQR1C5O3lXt5eBfSo2/yikt0ry3pL33c65QLZ
         gPqYMlqE9MS4HAVKfHnL81AXoWcWL50H0pbYhU4+oJQumzI9mahgpbtSOzoifxSe4f83
         zK9EZ/jj0cZIdWOzMUKAFAmKMU76WIrA5872qhWzqhK7sBxMRKJeppawIECASqXKUyxT
         WWQZTetJa4ZQd6zaQzDFaXspclIgi4XlyuecrucpPR+uxJCyf6PKodz+pO+FFpgAsvdE
         ZFNxF5ljA5vn/PH3grEFRY0i2+lT00bgwummWOooKDwCMvLrj8KrVXfc6jqdUIs5JuRb
         cwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tD2HAuHG+5YJaSii4/pDZTUEWXTpWgVavDzLNdcJvRo=;
        b=T98ozha1YLL2zD2k0g+hzjjvkuL+MCxvnfvp2YGfQuTvSEGpop1/9JeQV9iXzgWbCe
         B062Q3QQYWbHDIAKdnNSM6Hcz3Z1dOVnlPOO57ILQw1gBVL7xsYWn7ZEZUw7y3zbXKxD
         mJbhuTY0XKRgerT9wQ0aCf+C+MZ6RZ67AuL5q6YaTQGv5N3c4/tg9OVyE23FtNPo8yJ+
         ek5mWe/+1AVql659g+BkZAJAJ19AOFSbvLDmZGZ1MLI+jEmUDrOHmILXoFpyGynF4ndu
         seR4IQg53CqO4UqLy2f/HP01mahScumPv9xurQLHFiHXbfvuuQ3/5t2bicDtl/LPLpLG
         LSaw==
X-Gm-Message-State: AOAM533Pgnlq7g1pjf2NnCSfe0yed30mi+KhDHg2f99VVFjmVyG7obJd
        ehVq8aZA7VSUNxjhLB9b7QWoAUiwW68KCQ==
X-Google-Smtp-Source: ABdhPJzLNf7AxdI360rwpfGrbei3y65RuheIGAcynCqmFjz+dryhZ5myQ9SUoHJbcmxsVDaEL+V6nQ==
X-Received: by 2002:a63:801:0:b0:382:a089:59d3 with SMTP id 1-20020a630801000000b00382a08959d3mr7532652pgi.350.1649258284934;
        Wed, 06 Apr 2022 08:18:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f1a3])
        by smtp.gmail.com with ESMTPSA id t69-20020a638148000000b0039822f39a40sm15680959pgd.25.2022.04.06.08.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:18:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 6 Apr 2022 05:18:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Imran Khan <imran.f.khan@oracle.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/8] kernfs: Introduce interface to access
 global kernfs_open_file_mutex.
Message-ID: <Yk2vKqLSN3aqGiZK@slm.duckdns.org>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-2-imran.f.khan@oracle.com>
 <YjOpedPDj+3KCJjk@zeniv-ca.linux.org.uk>
 <10b5d071-7f69-da59-6395-064550c6c6cb@oracle.com>
 <YkxRDJ2ynEHGdjeT@zeniv-ca.linux.org.uk>
 <0dfe1056-3dc5-4d31-698e-e2c075ffd6ee@oracle.com>
 <Yk2ptLIKdpvgL3QY@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk2ptLIKdpvgL3QY@zeniv-ca.linux.org.uk>
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

Hello,

On Wed, Apr 06, 2022 at 02:54:44PM +0000, Al Viro wrote:
> On Wed, Apr 06, 2022 at 02:54:19PM +1000, Imran Khan wrote:
> 
> > > BTW, speaking of kernfs_notify() - can calls of that come from NMI handlers?
> > > If not, I'd consider using llist for kernfs_notify_list...
> > 
> > I see it gets invoked from 3 places only: cgroup_file_notify,
> > sysfs_notify and sysfs_notify_dirent. So kernfs_notify should not be
> > getting invoked in NMI context. I will make the llist transition in next
> > version.
> 
> Er...  Are you sure neither of those is ever called from something that is
> called from .... from NMI?
> 
> It might never happen, but there's a plenty of callchains leading to that
> thing and no obvious obstacles for some of those to come from NMI context;
> I don't see it documented anywhere either.
> 
> Tejun, could you comment on that one?

I don't know any case off the top of my head and expectedly all the common
cases don't involved nmi. If we're worried about being called from nmis, I'd
go for just adding WARN_ON_ONCE(in_nmi()).

Thanks.

-- 
tejun
