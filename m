Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF99F4E7D35
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiCYUBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiCYUBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:01:41 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEBC123BED
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:51:58 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-de3ca1efbaso9105919fac.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=QLTO7zxCRfU/Eq0CUYYhO07dMpZAmnVyyZ1CD2K1GdE=;
        b=hUIAUHAiWumWpNM6dJ28X9NA/M2p90hWfgXtpAcTqDr7ToJAVYS0HlJrZp2xE9Ba6O
         PzIQ7Xlye8U18iA+6LfFtAywAZ5gCXFX54gY1Rn07mvzlVQvFVgEM76/X7UkzXkAKf2Q
         mb4nTjet2vjyCu8jhGShERvca8Kt/qVLm5rR3VuT9I+X4EvP9vqKyIVqsxQ1U7yJZb8W
         HkBHljFFXfmbto09R2L6xpFAqkLasXkdyJhccctRxzkPpdyMuJfJ6uO4MUIcQK0Ncyqu
         KmAg11Zs2OJLqR5muhOxwHnqtQxmM35c+J0mOeRYc00IzSbD6fcoJTiCUSDvTIH4lRY+
         ti6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=QLTO7zxCRfU/Eq0CUYYhO07dMpZAmnVyyZ1CD2K1GdE=;
        b=kx4uoP4oC+QaiSEOknZC81MMYFx0/UjKkmTDCbb98IQUkUHX+hkcMAuoib7rq1xBW5
         OzgrxZ/RpRMHU7hTw1UyoCCphBMeytr3Kk8rxZ6GOfYuahYb3dAaPepwXx6bSgV2lRI3
         bkY7flOYgHfrKsCFGLXdKc+XFr8nx8ph0rS8Uj66E+wpfRk10/6js/o9jCFjz/WJwxQc
         ZnVPO+n/YgG4X2+LcVvcMG8Mr0xPpDdBjxevLF/GdV8TJPJXZyfIfrFgT4jATJYjwne9
         vzgieXJlRHmLxGcBwYQLIMG1az92flVPBNR1ZtLaRC/1f4EOAsyKHquMFWcGP/AADQ1a
         JKDw==
X-Gm-Message-State: AOAM532wVtI83mclcl7XB8tGVk+RDrWrcE7Jwfbqd8LFp38BPiDMkixg
        0zdcZbcVDr0JNX/hnvetA+dtUQ==
X-Google-Smtp-Source: ABdhPJwcVCvvL3UsJdxZZ57rWY6C8EyJTKb5G6YtxbhoPeXHiX7bkUkz5XPiYNlHeKVlc9HEKukWAQ==
X-Received: by 2002:a05:6871:294:b0:de:1872:fe40 with SMTP id i20-20020a056871029400b000de1872fe40mr9766966oae.254.1648237916264;
        Fri, 25 Mar 2022 12:51:56 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w133-20020acadf8b000000b002ef9fa2ba84sm3324219oig.12.2022.03.25.12.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:51:55 -0700 (PDT)
Date:   Fri, 25 Mar 2022 12:51:44 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Mike Galbraith <efault@gmx.de>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: new ltp memcg gripe bisects to b67bf49ce7aa ("post mm/munlock:
 delete FOLL_MLOCK and FOLL_POPULATE")
In-Reply-To: <969a2030a492f3cecdb7d0095478f1b779c643c3.camel@gmx.de>
Message-ID: <90eb31fa-69f7-e320-d8a6-6227fecb780@google.com>
References: <969a2030a492f3cecdb7d0095478f1b779c643c3.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2022, Mike Galbraith wrote:

> Greetings,
> 
> $subject bisected in a kvm ala:
> 
> leap153:/usr/local/ltp # cat testme
> export PATH=$PATH:`pwd`/testcases/bin
> memcg_stat_test.sh
> leap153:/usr/local/ltp # . ./testme
> 
> Usually leads to...
> memcg_stat_test 3 TINFO: Test unevictable with MAP_LOCKED
> memcg_stat_test 3 TINFO: Running memcg_process --mmap-lock1 -s 135168
> memcg_stat_test 3 TINFO: Warming up pid: 3460
> memcg_stat_test 3 TINFO: Process is still here after warm up: 3460
> memcg_stat_test 3 TFAIL: unevictable is 122880, 135168 expected
> ...but may lead to...
> memcg_stat_test 4 TINFO: Test unevictable with mlock
> memcg_stat_test 4 TINFO: Running memcg_process --mmap-lock2 -s 135168
> memcg_stat_test 4 TINFO: Warming up pid: 4271
> memcg_stat_test 4 TINFO: Process is still here after warm up: 4271
> memcg_stat_test 4 TFAIL: unevictable is 122880, 135168 expected
> ...or both.  A wee bit flaky.
> 
> I wanted to verify with a revert on top of 85c7000fda00, but while the
> revert patch applied, the result didn't boot.  Config is full distro.

Thanks a lot for spotting that.  I'll have no trouble reproducing it here,
looking through my old LTP test results.  I never noticed because I'm used
to memcg_stat failing - but looking closer, that's been because I'm usually
running with THP shmem_enabled "force", which causes memcg_stat_test 1 to
fail with a bigger number than expected (understandably): memcg_stat_test
3 and 4 failures are new to mlock/munlock changes.

It will (almost certainly) be a pagevec draining issue, to be fixed by a
strategically placed lru_add_drain() or mlock_page_drain().  I did have
more of those in for a while, before understanding and arriving at
b74355078b65 ("mm/munlock: page migration needs mlock pagevec drained");
and with that fix, hadn't noticed the need for more, so left them out
until proven desirable.

If it's as I expect, then it's worth doing: not just to pass an LTP test,
but more generally a good thing.  I'll play around in the next few days
and post a patch once I'm satisfied.

Regarding your bisection and revert of b67bf49ce7aa ("mm/munlock: delete
FOLL_MLOCK and FOLL_POPULATE").  I'm glad to hear that you got a build
error trying to revert that one commit: not a supported combination!
Maybe not too far wrong, but I wouldn't trust it.

But yes, I can see that the revert will bring in an lru_add_drain()
per page, so that fits with my guess above.

Thanks!
Hugh
