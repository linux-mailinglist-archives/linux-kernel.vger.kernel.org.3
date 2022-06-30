Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB6C56263C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiF3WqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiF3Wp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:45:57 -0400
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C4CC51B2F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:45:55 -0700 (PDT)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 4403820CAC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:45:54 +0900 (JST)
Received: by mail-pl1-f198.google.com with SMTP id h18-20020a170902f55200b0016a4a78bd71so330074plf.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=km11n9bibd1DONw/oZcy8niZnRZ3n4v8wZkKOW817eo=;
        b=7yOpNjFn43foWr4JOXXFaM6+u2f9AlaKCCNaxcQ7h+tL5R8rTkHAV0LzWDwRL0s2Fk
         4y5YnjrvbuZOtAcIn2XNKWh5YEUILIvSYyaz1uF/Ls/ZtE9JNKuL1z99lBW1Cghe88vO
         4AmKtKlwQ9k9/HhN1czdtq1zzQpU63bl48g0ysMVI1BNRRYgyOyZgbEjSMrlIAOBQzXO
         iuumngWIx5CHr8Mu7dvT9gzq6sC9GJUjnbOjWwS8O8KAW2S0klV1xHuW+0rsj0rhCj+/
         2Khx6paMqh7c11LpQK8Mawe3L2TSe8MiKaEM3QE+ESbulzH5cZ6UEetRTf3tEaBtZm2M
         zh7g==
X-Gm-Message-State: AJIora98lkNHFK4m2GMwUz6yF4tYzgY1+DErZMBgC4qnUqu2TuiQj5SR
        XzRPmh87b8QicRjC3eIR6UNEkjCkCQM4gTcpB6xdqc/0G8mihWs22d5ONo9pEjT5KN3TA9/h829
        xSWMEl0sY3SQOeib+c8wKts4u5A==
X-Received: by 2002:a17:90a:e7c7:b0:1ec:99eb:ff3a with SMTP id kb7-20020a17090ae7c700b001ec99ebff3amr14185458pjb.204.1656629153371;
        Thu, 30 Jun 2022 15:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tbEF7rysEj6qq7RxLY0j8faMqmAl6JmAcrnAwXLdvYnDiPLFibeEEek+5kuLiDdUWGgs+lTw==
X-Received: by 2002:a17:90a:e7c7:b0:1ec:99eb:ff3a with SMTP id kb7-20020a17090ae7c700b001ec99ebff3amr14185441pjb.204.1656629153168;
        Thu, 30 Jun 2022 15:45:53 -0700 (PDT)
Received: from pc-zest.atmarktech (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id s9-20020a62e709000000b00527ab697c6asm8281384pfh.18.2022.06.30.15.45.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2022 15:45:52 -0700 (PDT)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.95)
        (envelope-from <martinet@pc-zest>)
        id 1o72su-000Ee0-Uy;
        Fri, 01 Jul 2022 07:43:40 +0900
Date:   Fri, 1 Jul 2022 07:43:30 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: Major btrfs fiemap slowdown on file with many extents once in
 cache (RCU stalls?) (Was: [PATCH 1/3] filemap: Correct the conditions for
 marking a folio as accessed)
Message-ID: <Yr4nEoNLkXPKcOBi@atmark-techno.com>
References: <20220619151143.1054746-1-willy@infradead.org>
 <20220619151143.1054746-2-willy@infradead.org>
 <Yr1QwVW+sHWlAqKj@atmark-techno.com>
 <Yr21RoL+ztf1W5Od@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yr21RoL+ztf1W5Od@mit.edu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote on Thu, Jun 30, 2022 at 10:37:58AM -0400:
> On Thu, Jun 30, 2022 at 04:29:05PM +0900, Dominique MARTINET wrote:
> > Hi Willy, linux-btrfs@vger,
> > 
> > Matthew Wilcox (Oracle) wrote on Sun, Jun 19, 2022 at 04:11:41PM +0100:
> > > We had an off-by-one error which meant that we never marked the first page
> > > in a read as accessed.  This was visible as a slowdown when re-reading
> > > a file as pages were being evicted from cache too soon.  In reviewing
> > > this code, we noticed a second bug where a multi-page folio would be
> > > marked as accessed multiple times when doing reads that were less than
> > > the size of the folio.
> > 
> > when debugging an unrelated issue (short reads on btrfs with io_uring
> > and O_DIRECT[1]), I noticed that my horrible big file copy speeds fell
> > down from ~2GB/s (there's compression and lots of zeroes) to ~100MB/s
> > the second time I was copying it with cp.
> > 
> > I've taken a moment to bisect this and came down to this patch.
> 
> I think you may have forgotten to include the commit-id that was the
> results of your bisect.... ?

Sorry, this is the patch I replied to and it was recent enough that I
assumed it'd still be in mailboxes, but you're right it's better with a
commit id. This is was merged as 5ccc944dce3d ("filemap: Correct the
conditions for marking a folio as accessed")


Thanks,
-- 
Dominique
