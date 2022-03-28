Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917FA4EA2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiC1WPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiC1WPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:15:00 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5032A5AB0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:08:21 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id d142so12676190qkc.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ZMkNRPnAswmQwnzC9tBCWN0d9K/Tuq/KhdrPUuaz0L4=;
        b=IF4JOF0xk69Y0ZXhi0VpDnQsLL3/jPIUosOl+1hrHO0YYRpMM0d4rSaH73NYA4rAH6
         fqLAZT9D9X38FFl//qML+NQm2GJEaw2/xISZoCU/faB18IpSoMDbeJmTPwwSSrzfDxMZ
         ozL28/JUqrS8RKOPRBM/eVGsQQIYyxf0OsQRAQohQkxqxLsPWho3EYP9dU3torC1ngBE
         swSikCRmoPMFTyK8mvDtPV+E/L0uz3WpJa9a8uL200Oto0idzRYZijB6uL3D0qVoW45n
         6S9Oe7ytPuGMD0YLIhwpOx/+a0ZrCJ7xdgldNxhslP6EHVQJ+U2Ox7tQpF9WXK12D8Ad
         cJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ZMkNRPnAswmQwnzC9tBCWN0d9K/Tuq/KhdrPUuaz0L4=;
        b=drDaSX+/iSajh/BdaUkRsISTE0MH1NUpnkxGQubQ/xgQUcZuw5x1/kxeV5//zkWVzE
         HCQCkioSUS81588G+BqcD8AjK651UCd/p9b+wR4wtAG8n9xDPhUOXBSGrRnaHHKxUQgd
         lq2EBkVMOeiMeKAkgx+eeEBdRrdhyo8IaA8LOS44BAof9eMqFdRPMd2Fv70+OOLRuux5
         9NSGB9UpXdFZ2OQlMVcsfWRO9rOzR2/uoKMX3ehsO/ZQpM8R11edlLK3ni8oNRlHbolb
         htjBGm1IHKMVbUoXddjBjzL248+xiF0x6aHv3M0lf+ToAm/wNwa7Pc1dFWH1V5S5vea/
         tMhg==
X-Gm-Message-State: AOAM533xTc62A5Zk+TFU3lLFfc67Q+0L8tTxrqRh4Y225AUGvXvkNhM1
        TcsLy/KgcIpgCvJtwRC9mZslBIkolq1aQA==
X-Google-Smtp-Source: ABdhPJxMzZ8nzhrfCS+cRRrJkRKVWkxBWGmQv1JEKQiw+KZuAOx2hBM/rHyGAbOampUv7sj6LhPDtg==
X-Received: by 2002:a05:620a:bd5:b0:67d:15ed:2fcd with SMTP id s21-20020a05620a0bd500b0067d15ed2fcdmr18041898qki.81.1648503558618;
        Mon, 28 Mar 2022 14:39:18 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x6-20020a376306000000b0067b32a8568esm8820059qkb.101.2022.03.28.14.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 14:39:17 -0700 (PDT)
Date:   Mon, 28 Mar 2022 14:39:08 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Mike Galbraith <efault@gmx.de>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: new ltp memcg gripe bisects to b67bf49ce7aa ("post mm/munlock:
 delete FOLL_MLOCK and FOLL_POPULATE")
In-Reply-To: <90eb31fa-69f7-e320-d8a6-6227fecb780@google.com>
Message-ID: <a7ab5bc1-9a54-6a1a-bac7-e17f2ed16457@google.com>
References: <969a2030a492f3cecdb7d0095478f1b779c643c3.camel@gmx.de> <90eb31fa-69f7-e320-d8a6-6227fecb780@google.com>
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

On Fri, 25 Mar 2022, Hugh Dickins wrote:
> On Fri, 25 Mar 2022, Mike Galbraith wrote:
> 
> > Greetings,
> > 
> > $subject bisected in a kvm ala:
> > 
> > leap153:/usr/local/ltp # cat testme
> > export PATH=$PATH:`pwd`/testcases/bin
> > memcg_stat_test.sh
> > leap153:/usr/local/ltp # . ./testme
> > 
> > Usually leads to...
> > memcg_stat_test 3 TINFO: Test unevictable with MAP_LOCKED
> > memcg_stat_test 3 TINFO: Running memcg_process --mmap-lock1 -s 135168
> > memcg_stat_test 3 TINFO: Warming up pid: 3460
> > memcg_stat_test 3 TINFO: Process is still here after warm up: 3460
> > memcg_stat_test 3 TFAIL: unevictable is 122880, 135168 expected
> > ...but may lead to...
> > memcg_stat_test 4 TINFO: Test unevictable with mlock
> > memcg_stat_test 4 TINFO: Running memcg_process --mmap-lock2 -s 135168
> > memcg_stat_test 4 TINFO: Warming up pid: 4271
> > memcg_stat_test 4 TINFO: Process is still here after warm up: 4271
> > memcg_stat_test 4 TFAIL: unevictable is 122880, 135168 expected
> > ...or both.  A wee bit flaky.
> > 
> > I wanted to verify with a revert on top of 85c7000fda00, but while the
> > revert patch applied, the result didn't boot.  Config is full distro.
> 
> Thanks a lot for spotting that.  I'll have no trouble reproducing it here,
> looking through my old LTP test results.  I never noticed because I'm used
> to memcg_stat failing - but looking closer, that's been because I'm usually
> running with THP shmem_enabled "force", which causes memcg_stat_test 1 to
> fail with a bigger number than expected (understandably): memcg_stat_test
> 3 and 4 failures are new to mlock/munlock changes.
> 
> It will (almost certainly) be a pagevec draining issue, to be fixed by a
> strategically placed lru_add_drain() or mlock_page_drain().  I did have
> more of those in for a while, before understanding and arriving at
> b74355078b65 ("mm/munlock: page migration needs mlock pagevec drained");
> and with that fix, hadn't noticed the need for more, so left them out
> until proven desirable.
> 
> If it's as I expect, then it's worth doing: not just to pass an LTP test,
> but more generally a good thing.  I'll play around in the next few days
> and post a patch once I'm satisfied.
> 
> Regarding your bisection and revert of b67bf49ce7aa ("mm/munlock: delete
> FOLL_MLOCK and FOLL_POPULATE").  I'm glad to hear that you got a build
> error trying to revert that one commit: not a supported combination!
> Maybe not too far wrong, but I wouldn't trust it.
> 
> But yes, I can see that the revert will bring in an lru_add_drain()
> per page, so that fits with my guess above.

Right, I was easily able to reproduce those failures; and happily the
patch I had earlier, but left out, indeed fixes them as expected:
follows now.

Thanks,
Hugh
