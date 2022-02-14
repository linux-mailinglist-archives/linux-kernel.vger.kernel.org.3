Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B1B4B5425
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245297AbiBNPGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:06:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355596AbiBNPFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:05:48 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF37B84F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:05:39 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id g145so14584693qke.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rwVAodOL1EH3E2Lb+JFjMWVXe7YxW9eI5axnQQxt+8s=;
        b=Blcmsc5N/kIb5n3TBW2qeHMOmRpQxeJLgz/718gzF5QOwt1Joo0UUjQrTiHTfXLwpx
         mHtQjpUOy3MUi7I8xet5mgQMQZMVzKylhTzcyZp+na2TPRPZDnnsJRkFgdqjqYsY3CqX
         uBxCoaMyFc2YKDn5I5BZrEHHgZAVtgyutMVV4wwdrkEoxL2HArIbXDzl5eqC6b9B7ti9
         fZFU/jIv4MaYGqxX9KX35TOZ+z64y8kiVPoRDNdSnK3EzMcgFkXun7peHhMnlGNuz1fi
         U8ll9bnwJrAqvMnjoH5EBpE1VJO/lOsAHb2RKjBjbJGIzMVX/7JnydEOaqIHfBIKvigT
         a1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rwVAodOL1EH3E2Lb+JFjMWVXe7YxW9eI5axnQQxt+8s=;
        b=15tw90YeBN/dv+nE1ei7KMGO9pxEMxsK/kYt0lJjEaXOF0v3Nb44tyVkjbL272Cn9b
         gOCUmLPKUsdqbgExtQmeqLff99TqRVrof/1VDErX3Nnvf7zi8DWuZLD36WD+1CNF72/6
         18S2lNW5Rw+ZD+otLXG5Wpys19HSBSd2i3KTA5rkAcvh1zJRcUbGvPR9Zd2GcryCAb5A
         9tEOKxYpagC0JlEBF6sOKNLM9XELOTMzZQyAfluXIu0Fb9tVpjk6ujy6xxlNdnVwS9v1
         JeDejlfKvujTcpHooUiZ/DVv6FNL42cs4KWQnRF0YoGfNQH27F3ecP5G8wKRKfphYgAz
         N5fw==
X-Gm-Message-State: AOAM533yZwT8Vz8TQwH0x7tZYKhu2J2PuWtSBLOPyGYUfoFKPNWGkUBr
        gL6FrgLdtnoF6+StmhRvgfqF0Q==
X-Google-Smtp-Source: ABdhPJyFnvLhA5jRRIY4FmCW9aMreqDmbqNG5v6+fa6ZHTUrPL6DsVol9AFQPkuDA59hPq3Yhq/7cg==
X-Received: by 2002:a37:a987:: with SMTP id s129mr7341056qke.681.1644851138994;
        Mon, 14 Feb 2022 07:05:38 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id y15sm15842513qko.95.2022.02.14.07.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 07:05:38 -0800 (PST)
Date:   Mon, 14 Feb 2022 10:05:37 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Huangzhaoyang <huangzhaoyang@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4] psi: fix possible trigger missing in the window
Message-ID: <YgpvwTbakWSI4TWK@cmpxchg.org>
References: <1643093818-19835-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643093818-19835-1-git-send-email-huangzhaoyang@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 02:56:58PM +0800, Huangzhaoyang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> When a new threshold breaching stall happens after a psi event was
> generated and within the window duration, the new event is not
> generated because the events are rate-limited to one per window. If
> after that no new stall is recorded then the event will not be
> generated even after rate-limiting duration has passed. This is
> happening because with no new stall, window_update will not be called
> even though threshold was previously breached. To fix this, record
> threshold breaching occurrence and generate the event once window
> duration is passed.
> 
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Hey Peter, would you mind taking this through the scheduler tree? It's
got my and Suren's acks. It's not a recent regression so I'm thinking
for 5.18 is fine. Thanks!
