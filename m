Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1D34E6513
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350734AbiCXO3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbiCXO3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:29:17 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D121D7B105
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:27:45 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id s11so3952605qtc.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qyHFfaKBiNo+/JYUdPZLsqKFQcJgYWqH70R3hhuOnaE=;
        b=qgoHbDGhJ13cJiR+oXZgVdrFHi6Zu/n9ZKB9HjZBjfyUHv5uKHtqMCrKRxjCMjYl5Q
         8dbe+R9r0IZX3IPjqQuKEwkrxvty1wAhDHJSTXM3131i0GKN8+E8x9379OqRC1IH8b8x
         FEiX/fW2f4M9t7MsvjacIgGvlG6mk9ntoYg28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qyHFfaKBiNo+/JYUdPZLsqKFQcJgYWqH70R3hhuOnaE=;
        b=kLPF4vbMjLgMJeG5OcwexOdXWyb6RExP5C8+LeEo1RKwUyPKlY5OE9d54VojV2HBpj
         ee3Ap2SeULTY5nyfiE8mDgbLZJWCg521GTM7eunBiUrYweaJjxnpmCWfgafQ9M1Y3nYA
         yyujE/gTfQNP/vQtSMm2iVfj+GMj82QPM69F3n5gltMMbc7kI1w9yuVAyTBnwWshHNS7
         fj9cPreKE4cs6dva3NrFhxfZ0exm2nLz4T4hXIo4FKN+4bftZ1qjppchqE1PGJxjw9Y9
         YVEFZFls+vZRCVEv4yYVbGn20lJMRqUXixKi2Le2PMC9cgQlxqOEj9yEsyxd6ytWUe37
         LG4Q==
X-Gm-Message-State: AOAM5303R0g3mOs9GmnT3jAntBf0AsJIZKBLGhGef21gXl+B5bbOw7lx
        PTWRaMkxfAea1RPA5UG/n+MOZg==
X-Google-Smtp-Source: ABdhPJyjLG6nIEJ4K8CdWJSs2v53UxYktjfgFxKvM4Oitz16GNuh2UxisV1C7+aVpQkXlG8vGx77JA==
X-Received: by 2002:a05:622a:1742:b0:2e1:ecf4:900c with SMTP id l2-20020a05622a174200b002e1ecf4900cmr4610880qtk.473.1648132064836;
        Thu, 24 Mar 2022 07:27:44 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id e7-20020a37ac07000000b0067d7cd47af4sm1630338qkm.31.2022.03.24.07.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 07:27:44 -0700 (PDT)
Date:   Thu, 24 Mar 2022 10:27:43 -0400
From:   Chris Down <chris@chrisdown.name>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        ke wang <ke.wang@unisoc.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH] cgroup: introduce proportional protection on memcg
Message-ID: <Yjx/3yi7BfH7wLPz@chrisdown.name>
References: <1648113743-32622-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1648113743-32622-1-git-send-email-zhaoyang.huang@unisoc.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm confused by the aims of this patch. We already have proportional reclaim 
for memory.min and memory.low, and memory.high is already "proportional" by its 
nature to drive memory back down behind the configured threshold.

Could you please be more clear about what you're trying to achieve and in what 
way the existing proportional reclaim mechanisms are insufficient for you?
