Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693AF4CEE1F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 23:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbiCFWQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 17:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiCFWQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 17:16:29 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967623B570
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 14:15:36 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z4so12022383pgh.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 14:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=391huVYq5DAxhEYcIPd+Z6lK4Gud3fqq7TgEeUR+WWI=;
        b=tXH49C8/vqs+ygCTzo5gP4nqHiqf0//z9rAWQ3TD+9PZuNPidOX/ZS1vxWIoFuREqs
         WcrIp1iJL5qTXQG1TGsDXXXhnXWK6J/WuMKVQ/YN4EEaKW4mYCFjnTZDBoZB8kiSYn4q
         gp+XMKpzFJOdiiejLnn+lG11vEwFwoGRup5SHgJXjxBs0B24C7pCZ/Gy2dusyG9LYgPm
         L5sOz8iXExBhKRmF0YnPLcOOF3FfMm1ypr35T/55arFRS1zVuVToSeFOdctvH0LZp5st
         io3B4Sg3DLipbdzZ+ROgmvU0GrfkNkFjYoWDnxd5LsUCK7m78sqCb91LOa6Fu++FMXeb
         q8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=391huVYq5DAxhEYcIPd+Z6lK4Gud3fqq7TgEeUR+WWI=;
        b=RcOhtkXSx27EBrgOUY70hc6bBKKfDUnv2HV3lL8lD/7dlG2Li5yFj+vNszt5moCq2b
         ehH/0xW21+KoSVDWw1r1Q/VxItJ/H890E/3fp1lJn42MlOH9VlJWhaXfcNi/Mx6C+jSX
         sAKxl1yReaYvg3fUSNv4iTCDeab5OePsESJX4GxoMBCcMMHcgRI2ov+7TDiSy8xFjhGb
         rrdWShS1N+Voihvt7mI4LlkCCiF9HiKKn/aH8nKp/selpJPXRU6jUyCiwSpjiFteEEZB
         GY6uOw9tSKOBrkiy+vv7ut7m2FiYju0XcxI14piVPPgfUTGqQZDovz9XdpKNzmDd92q4
         FhHg==
X-Gm-Message-State: AOAM5337SiQ7fzXpssA0l0CkfLYDVUbC61BrObNlSfrlEwf05z1+e53A
        WzyKsAm0qN7VXgRByoQcuh3iIOZnP63uHg==
X-Google-Smtp-Source: ABdhPJwzKRwjJxCBJDMG8IhPCM3CI0pHUwMA/K8n/SXqp3bCN/ofaAeYsUKldmofLQ5O23BfCUuCiA==
X-Received: by 2002:a63:7b49:0:b0:37f:ed43:4fc4 with SMTP id k9-20020a637b49000000b0037fed434fc4mr7481916pgn.387.1646604935931;
        Sun, 06 Mar 2022 14:15:35 -0800 (PST)
Received: from [2620:15c:29:204:5f87:a605:2b59:e392] ([2620:15c:29:204:5f87:a605:2b59:e392])
        by smtp.gmail.com with ESMTPSA id l5-20020a056a0016c500b004f140564a00sm13682590pfc.203.2022.03.06.14.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 14:15:35 -0800 (PST)
Date:   Sun, 6 Mar 2022 14:15:35 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm/page_alloc: call check_new_pages() while zone
 spinlock is not held
In-Reply-To: <20220304170215.1868106-1-eric.dumazet@gmail.com>
Message-ID: <5867e22f-43cc-ca21-bc60-ec67554e66@google.com>
References: <20220304170215.1868106-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022, Eric Dumazet wrote:

> From: Eric Dumazet <edumazet@google.com>
> 
> For high order pages not using pcp, rmqueue() is currently calling
> the costly check_new_pages() while zone spinlock is held,
> and hard irqs masked.
> 
> This is not needed, we can release the spinlock sooner to reduce
> zone spinlock contention.
> 
> Note that after this patch, we call __mod_zone_freepage_state()
> before deciding to leak the page because it is in bad state.
> 
> v2: We need to keep interrupts disabled to call __mod_zone_freepage_state()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: David Rientjes <rientjes@google.com>

Acked-by: David Rientjes <rientjes@google.com>
