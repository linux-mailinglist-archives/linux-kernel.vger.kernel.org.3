Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953984CB44E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiCCBbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiCCBbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:31:23 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426BF1A2748
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:30:39 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id j78so2868857qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 17:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=7dLWebgFFMbieGxz46r2opbysTbpngvo1n6jE6+JxQE=;
        b=cVwXupy7j/3vSCvATMypXscf553gCWjRWH3s5r8ZN0p2EvIBGUnjZEgo4O51EqKiw0
         0z6e7Gmaf9z2L8Iao4ye4//lp+hweSrTHBiRDfRHQSew8lvlJPGkiOd56svjPyTb8yB5
         XwwQGJfE7vkdp3ChqMQUZFHUZ8MafPVFcBSlUwZpRLK4Nq1SfIOP57zMkqyFdidlJRj3
         i1coQVGoY1dlGjCt9cn9pCFegufyvkW2wC5Ae2QZvAyw96vllJYj+05fcRNFzA7MxKJn
         kukIq3s8dvP4RukexOPCyTgn/oHte+lo2VkdAUzspYBSuX18KnrtD9pY4lpox8u98Tu9
         YQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=7dLWebgFFMbieGxz46r2opbysTbpngvo1n6jE6+JxQE=;
        b=mdI2QQxpQPkwVmUcXyZ1o/GbrHgA+fyTGRNv7FcSUlqdBptGLFQIEt6jd8lSdCmNi7
         7g1AlGRmDq+Pw7JIuTR80L2Mw/uzHinv9fmJ4f2xj48ktFeJLz08lMwF8Tr1h16+K5F4
         gViFBOiCwinvjsblOIg/FX88a9I3Myn7olbhaJAToFzXvAfNooLhmVa+WfNSUU/Vlgzo
         9HHnxHrrxSCNZvAN3gJ9usS5pCox3kctfvQUtTXX7og2hgZyH5A2095BI+ar2vRhq8WT
         4xxRZkSNKp5IJvYTkz1G4Vq8Ny78tmTEPqNBZ0R5VuNep//rJQ0WXZWQxAmzT3G54BaE
         Jn6g==
X-Gm-Message-State: AOAM530uRc3QFh5YVnY1l7cUwfQHk1ESoO/cZAEI7GWMZlOHiVcgFToK
        EPZq0ukLeCej4IkybrgHF8os9kgzT3ppQg==
X-Google-Smtp-Source: ABdhPJxHYJhwWHQ4dIiqSSfjqCDq2CQB6hJ8iVHLqUo7Sk+11HWUfVElaG737QpGmTYQNJRxrAYMMA==
X-Received: by 2002:a05:620a:69c:b0:648:cdae:ca2a with SMTP id f28-20020a05620a069c00b00648cdaeca2amr18118482qkh.711.1646271037989;
        Wed, 02 Mar 2022 17:30:37 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y17-20020a376411000000b006490deb56b2sm391141qkb.1.2022.03.02.17.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 17:30:37 -0800 (PST)
Date:   Wed, 2 Mar 2022 17:30:27 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH mmotm 00/15] mm: assorted small fixes and cleanups
Message-ID: <8caa60fa-fb3e-e2ea-64fa-65971e382db9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, I'm about to trickle through the first six of probably fifteen
patches, diffed against against top of next-20220301, equally applicable
to mmotm 2022-02-28-14-45 (sorry, not looked at 2022-03-02-16-53 yet).

These are independent patches, which may be applied or dropped as you
wish: I'm not numbering them N/15, and I'm Cc'ing different interested
parties on the different patches.

More to come later today or tomorrow or after, I'm still updating
commit messages and Cc-lists for the rebased and retested patches: many
of which go back years, never quite reaching priority for posting until
now.  I'd hoped to send them earlier in the cycle, but mm/munlock took
precedence - and the first I'll send is a fix to an issue there.

Thanks,
Hugh
