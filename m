Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2B74FC6AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350180AbiDKVYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350114AbiDKVYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E85D2FE61
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649712111;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=hYNVq0t1WrkTI/K6D/l/f7tQTRIta/302c+AVM0dqpk=;
        b=ZYe/bbLU88HwXDOCYm4mM+BkBNYSN6PSHWLQGjB4Mgv5zTq1TMT9nBduLGXE3E/WhwJSTE
        V5byJjfE+rzXm3a25L7z/F74XOJMwfrDb63V9tmlDjXm+BeLzwZgsB1Ef/ERCWYdzAJfK+
        n5V7vzPETcAiP0WLRQcvITA/F3FAd80=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-PCLCKfmRMeisw7VBMB77DA-1; Mon, 11 Apr 2022 17:21:48 -0400
X-MC-Unique: PCLCKfmRMeisw7VBMB77DA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 824D4185A7BA;
        Mon, 11 Apr 2022 21:21:47 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.39.195.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6192E40CF914;
        Mon, 11 Apr 2022 21:21:46 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.16.1/8.16.1) with ESMTPS id 23BLLg5f2961636
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 23:21:42 +0200
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.16.1/8.16.1/Submit) id 23BLLe6o2961635;
        Mon, 11 Apr 2022 23:21:40 +0200
Date:   Mon, 11 Apr 2022 23:21:40 +0200
From:   Jakub Jelinek <jakub@redhat.com>
To:     Sergei Trofimovich <slyich@gmail.com>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Joe Perches <joe@perches.com>, linux-kbuild@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: gcc inserts __builtin_popcount, causes 'modpost: "__popcountdi2"
 ... amdgpu.ko] undefined'
Message-ID: <YlSb5D3rDTyCWpay@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <YlSYv3d9a5cZR9KE@nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlSYv3d9a5cZR9KE@nz>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 10:08:15PM +0100, Sergei Trofimovich wrote:
> Current linux-5.17.1 on fresh gcc-12 fails to build with errors like:
> 
>     ERROR: modpost: "__popcountdi2" [drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko] undefined!
>     ERROR: modpost: "__popcountdi2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> 
> It is occasionally seen by others on previous gcc versions as well:
> 
>     https://lkml.org/lkml/2021/7/11/261
>     https://lkml.org/lkml/2018/10/24/403
> 
> '__popcountdi2' are inserted by gcc for code like the following
> from 'drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c':
> 
>     static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
>     {
>         uint64_t n = 0;
>         uint8_t count = 0;
>         u8 bksv[sizeof(n)] = { };
> 
>         memcpy(bksv, hdcp->auth.msg.hdcp1.bksv, sizeof(hdcp->auth.msg.hdcp1.bksv));
>         n = *(uint64_t *)bksv;
> 
>         /* Here gcc inserts 'count = __builtin_popcount(n);' */
>         while (n) {
>                 count++;
>                 n &= (n - 1);
>         }
> 
>         return (count == 20) ? MOD_HDCP_STATUS_SUCCESS :
>                                MOD_HDCP_STATUS_HDCP1_INVALID_BKSV;
>     }
> 
> Note that gcc can insert it regardless of -mno-* options.

Just FYI, this has been added in GCC 9 for https://gcc.gnu.org/PR82479
If the kernel implements its own __popcount?i2, it can perhaps with
runtime patching use hw instructions when those are available and
fallback to the generic version.

	Jakub

