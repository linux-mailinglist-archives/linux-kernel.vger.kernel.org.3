Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C2358EEB0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiHJOpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiHJOpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F3DB39BA6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660142728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tUu6M2S/duiNeGM8Kec4bSt+ImPwKlLEvtTkCC42t94=;
        b=JHEX0KFMjMZbgB4iAbdpFxlC/HZyOCfsmcUe+ZKC26+3lJjuGZCYZydeo8UNnM2CePqAyE
        ETulEVf/KT74qqZskSDBFVCpbot8UMBhokM0q5Ja7GfMSCYRKGr4JJy+zviv3+fvtCPKaJ
        NENQeHn+ks+tg+vivwb0IfLoQZP78qo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-XHbjNoS8OyaHBysqMp1iuA-1; Wed, 10 Aug 2022 10:45:25 -0400
X-MC-Unique: XHbjNoS8OyaHBysqMp1iuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F02138217F7;
        Wed, 10 Aug 2022 14:45:24 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.194.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 493191121314;
        Wed, 10 Aug 2022 14:45:21 +0000 (UTC)
Date:   Wed, 10 Aug 2022 10:45:18 -0400
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3 0/2] cpuhp: fix some st->target issues
Message-ID: <YvPEfgHnmMz0U8wv@lorien.usersys.redhat.com>
References: <20220711211619.112854-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711211619.112854-1-pauld@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 05:16:17PM -0400 Phil Auld wrote:
> Several small fixes that clean up some cpuhp inconsistencies.
> The first prevents target_store() from calling cpu_down() when
> target == state which prevents the cpu being incorrectly marked
> as dying.  The second just makes the boot cpu have a valid cpuhp
> target rather than 0 (CPU_OFFLINE) while being in state
> CPU_ONLINE.
> 
> A further issue which these two patches don't address is that
> the cpuX/online file looks at the device->offline state and can
> thus get out of sync with the actual cpuhp state if the cpuhp
> target is used to change state.
> 
> v3: Added code to make sure st->target == target in the nop case.
> 
> Phil Auld (2):
>   cpuhp: make target_store() a nop when target == state
>   cpuhp: Set cpuhp target for boot cpu
> 
>  kernel/cpu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> -- 
> 2.31.1
> 

Ping?

Any thoughts on this? I'm not sure what tree it needs to go in but
getting a cpu shutdown by writing the current target/state back
in here seems wrong.


Thanks,
Phil

-- 

