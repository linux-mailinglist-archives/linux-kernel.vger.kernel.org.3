Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEAD536930
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 01:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354078AbiE0XhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 19:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiE0XhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 19:37:22 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C62CB7DE
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 16:37:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j10so8871072lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 16:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=J+HEM1XZa0sy/b3V0gcwypiEOba1ZZAFxr2ass/Bc/k=;
        b=KaiJVkdhS9GxcUZdH7TXoY1kzZIbIL0KGrXTtPH5vePuGcMbiuQz0wFdE/sZxznQXm
         Ij+X6IJxXLKGUi3PNdt1yuRitQzFbNpUTjqY6DyQybVIUFPibzEQgjH/hGp7iRdUsP24
         67agV3aZTV/fDEuduTEIOxX/V/rfUSmCcfK4oJ1wexCdLLv8boBR/OHgrC7gh0Z9JLDI
         xfoDUHMarvR4VhTQPSPoDMueMxhLIs8TKd7o5GyU90nSAN2/qYNTvhXs3xBaF4U0mqd/
         sljAlT3BpxRD+1a0WwOA7BIaEAtjPNllKi4bRd7AD6BUWfcZEze72uxYz2kImwzNXsJY
         E98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J+HEM1XZa0sy/b3V0gcwypiEOba1ZZAFxr2ass/Bc/k=;
        b=eMjZ11G94lcG5ohWbd5mporMMVabRFpCkdu37YF22RT9mUzQWiMQH9lkaJA1XMnH1k
         yLdxE9Zd3+coPXDXJtOv/VGYfH9mU7rue2yedWmnLQ8uoBfbDgDbf7aQNMymeQNqoKoj
         IXlQlUn/4qa/YaTpKycrTVtoxZBM+blQTA5CNagqFMjpB76MO9aHOBiiUOVRjE9he3jX
         00w/NYUvKit1K5dSd3IgnCPB/kZdJGltu+2lOs3onmyLVGkBK7LNWvdwCeKp1AeHD+HB
         PMmZxsi1qtnq+YBsCwzNwP7oaSygrJZsEUiBJ2rp1S9wo0icU8vHi0XMEUJHp/PqoIst
         q/Jg==
X-Gm-Message-State: AOAM531OK6zxNRZEDF8BtzoBHbbQU1AJaD1/LkbSi6AHg/Oc+1CQWlvD
        U2+T5ocd0CyYV9+T++jE9cUrRg==
X-Google-Smtp-Source: ABdhPJya26gfWjXOurelttGI3jMJSVrxfCHFs3URpcAcCY2mOlGUtdts0WB3wFjgiifG5/VPAwXMmA==
X-Received: by 2002:ac2:5e73:0:b0:478:9aca:4a00 with SMTP id a19-20020ac25e73000000b004789aca4a00mr12438267lfr.394.1653694640018;
        Fri, 27 May 2022 16:37:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o22-20020ac24c56000000b00477b11144e9sm1061804lfk.66.2022.05.27.16.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 16:37:18 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 86A191094B9; Sat, 28 May 2022 02:39:15 +0300 (+03)
Date:   Sat, 28 May 2022 02:39:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jakub =?utf-8?Q?Mat=C4=9Bna?= <matenajakub@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        riel@surriel.com, rostedt@goodmis.org, peterz@infradead.org
Subject: Re: [PATCH 1/2] [PATCH 1/2] mm: refactor of vma_merge()
Message-ID: <20220527233915.55oe6jittuogavot@box.shutemov.name>
References: <20220527104810.24736-1-matenajakub@gmail.com>
 <20220527104810.24736-2-matenajakub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220527104810.24736-2-matenajakub@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 12:48:09PM +0200, Jakub Matěna wrote:
> Refactor vma_merge() to make it shorter and more understandable.
> Main change is the elimination of code duplicity in the case of
> merge next check. This is done by first doing checks and caching
> the results before executing the merge itself. The variable 'area' is
> divided into 'mid' and 'res' as previously it was used for two purposes,
> as the middle VMA between prev and next and also as the result of the
> merge itself. Exit paths are also unified.
> 
> Signed-off-by: Jakub Matěna <matenajakub@gmail.com>

You've ignored my ack. Or is there substantial changes that you want me to
review again?

-- 
 Kirill A. Shutemov
