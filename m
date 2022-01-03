Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813D6483665
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbiACRro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:47:44 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:33431 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiACRrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:47:43 -0500
Received: by mail-pg1-f180.google.com with SMTP id 7so17971378pgn.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 09:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7c8QZYkWUUFDQAv4xug93cso5ONu1KnGivhyK1kn96M=;
        b=6O9upvi2aAPdM5FhbCqYfDEiSWwmGhtBNkEg/4U28MpIXq8OILvtGuHJLi+2f4VikD
         Pfjj28mx4ZKx2yqSFaraDn2DbL96fNt8jcKnq90Iz6M7w1wmGAapxQmQyub48Z5ASTWo
         j55Rqhc3n8BCM/BdxvleJ0YE60WZSsivhPorKKe/DVLFccSyfL6cnteW/OgiQ6epzThq
         185C9vebOQKnwYRZTRE0Nhw6vIGKWN+7evwLzYM4+z4Ze+KqZ7T8cLYkys9godh5gVZo
         gVRH+YxuOrlRVtlihtjaVmhf2zlLs4C5jBcdJK2ZRqH0Z35z0VVXSAqZiM3r347wKaWG
         33MQ==
X-Gm-Message-State: AOAM530da25zh+lWG6l6OGqTyK2MoTjn4RO9LmiR5MxwrzoDdsiO1gy7
        dbbZPlUFFADuQC2WF2ca72JIpqTFA7I=
X-Google-Smtp-Source: ABdhPJx1OERthB4k7oZ1ZaR6FHDGWoRiJdTnFQvEttN6MRuG/GvCGQfAdqukwKQHgHlSOVggc2NYtQ==
X-Received: by 2002:a05:6a00:1409:b0:4bc:764c:5a39 with SMTP id l9-20020a056a00140900b004bc764c5a39mr12891245pfu.13.1641232062737;
        Mon, 03 Jan 2022 09:47:42 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id m3sm37966728pjz.10.2022.01.03.09.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 09:47:42 -0800 (PST)
Message-ID: <954086c4-d679-57d7-cc46-9ce6af2872a4@acm.org>
Date:   Mon, 3 Jan 2022 09:47:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] locking/lockdep: Avoid potential access of invalid memory
 in lock_class
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20220103023558.1377055-1-longman@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220103023558.1377055-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/22 18:35, Waiman Long wrote:
> -	WARN_ON_ONCE(!found);
> -	__lockdep_free_key_range(pf, key, 1);
> -	call_rcu_zapped(pf);
> -	graph_unlock();
> -out_irq:
> +	WARN_ON_ONCE(!found && debug_locks);

lockdep_unregister_key() should only be called for a registered key so I'd
like to keep the WARN_ON_ONCE(!found) here instead of changing it into
WARN_ON_ONCE(!found && debug_locks). Otherwise this patch looks good to me.

Thanks,

Bart.
