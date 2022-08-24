Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0DA59F752
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbiHXKUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbiHXKTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:19:51 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B476BC28
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 03:19:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z2so21434856edc.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 03:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=s0j2FSbwvmjKdvN+169nQdScgb7ALVuRcy3EIVLP7So=;
        b=DNYaMoJZfqTl1zDi6NfKZZNWYwlrnOiVUiJmcwR/S17jsY9fY/Ngvx8ghbhYAQYLBZ
         iosJQQDlAc2g+gT/jZ08h5QB8fcv4B7NVl0dzILk2YtT5fwGcE742npl8exZOAzm+0nu
         Gwl5Vid27xtbN7GAblRedWuh/ys90QXaZZvu+xQG6IAGfMTgGMhEc560XEWHesJI/Rn7
         crl2l5Bcu1/NXTW+J9mMKFiWXjfZGppPM3A0EvsLASxxnw3/XvZ1IZs2+glf+3Xczq1v
         7O/VRL7UEObRyKjXpOjb8Zi01VJ7UFfV02Bc6L/TKGpYLA8hihsJUgMZTgRx340ziDDD
         2Apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=s0j2FSbwvmjKdvN+169nQdScgb7ALVuRcy3EIVLP7So=;
        b=PFrFPevDj2rt42/r20nMNzEbIVd4Zi++nAPoWDGdxjGuefP7KVreirjBOuKYJ6SF17
         DmsKSQLSvXIblvVYhfFDUtDgRnhAta/qzW+TpG/GjjlWuHS2TAOE3OsPZvwOymDAm5iX
         +zALtUrgHWSymUlsZ2btmx49OQu9Z7Jt/ssxOPGd04Uspf7gnaVdstux8mobCP9z8uRP
         W1J9wlq/OLhCbth65GhcM4hPkwX2oEFP+J9dwE/IRCqUfFN6JFbYMyFk/PA/tNSfo0UA
         KfhUqrx5ZXQ82pkpFGhQ5AO4y0sO0GP7XOA30L1xgT1cjPrnB7632wEGe1iV6JIN6i7c
         1aLg==
X-Gm-Message-State: ACgBeo31253hz5uewUfFPXOn6XHCH40b/6enLcg77+BAMxGLJTpHAXRH
        dG8TxQ5YrxpyjIx4HW3YFE5AxQ==
X-Google-Smtp-Source: AA6agR7qxhD95wx9Ex9KCuhMEFSKKxiH5pnOMNEntNXYgYlefJndvgHpOhNVzvJet7AGNK5e/+mN3A==
X-Received: by 2002:a05:6402:27c6:b0:446:71e1:7399 with SMTP id c6-20020a05640227c600b0044671e17399mr6988640ede.357.1661336387791;
        Wed, 24 Aug 2022 03:19:47 -0700 (PDT)
Received: from localhost ([2a02:8070:6389:a4c0:2ca9:6d59:782b:fff3])
        by smtp.gmail.com with ESMTPSA id d6-20020a50fb06000000b0043a5bcf80a2sm2794293edq.60.2022.08.24.03.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 03:19:47 -0700 (PDT)
Date:   Wed, 24 Aug 2022 06:19:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     tj@kernel.org, mkoutny@suse.com, surenb@google.com,
        gregkh@linuxfoundation.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] sched/psi: consolidate cgroup_psi()
Message-ID: <YwX7QvIpmPpxEHgI@cmpxchg.org>
References: <20220824081829.33748-1-zhouchengming@bytedance.com>
 <20220824081829.33748-9-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824081829.33748-9-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 04:18:27PM +0800, Chengming Zhou wrote:
> cgroup_psi() can't return psi_group for root cgroup, so we have many
> open code "psi = cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi".
> 
> This patch move cgroup_psi() definition to <linux/psi.h>, in which
> we can return psi_system for root cgroup, so can handle all cgroups.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
