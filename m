Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F05524A78
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352727AbiELKiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352716AbiELKin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:38:43 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8271660D8A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:38:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x23so4409704pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fhb/gLdB62M/KppDRxMb67JB1I+wuLhsL+yRQv7dNnE=;
        b=WptS6rXNI1lIyARRPN0Dir6uaYGtj4tD+vZGdBX8ED6HxiNp1jRp2CSj7A98/lq+qo
         2Rc3Q9UzVon23nBA+J9BaCWeQlWwMY2m9kRi1X6dc0aytOWx1l3n50psqYaRF50pWBq5
         +kfw3Ol9+coKFQ+DNy7xu3wFiM8puLK2/jbE5IxJeX9zfxrzbVlyLes+ydgi0OKxXzY6
         2aP7n2zuj6QDomWwy2gJMUnK6oSNCU/XpkubyxDxIirrwQ7g8n7kdPpHnac6fPrm9cVG
         QGJvEoO9Jnfi1YzVjva1pok2bDmd7Tr9s+lXw1zAaLKQ421hR2sEYFAR66Fe7k8YE9kl
         vnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fhb/gLdB62M/KppDRxMb67JB1I+wuLhsL+yRQv7dNnE=;
        b=gCV1H8y0sFgRHb9frIfK8PrqgooivExhHdyb2Um+oiAqA3av5NJX9d9jXNzVvQ/vdB
         FCBdxh99eATcOh0mVV9yZk79MgmDpR2Uu2vBtIOxVVpM/ZQLckMc8EZ0QFlAEXVsdGma
         73sgE6fmk1VOrWpSXof5DfJ6HT4sTx8GNzn60YwTp27vV/wnYkUhxWYTv8LfXIc3W7LP
         +BB89e2bk9knfA7ZvLW8LfVlYu/E9wSYc03lam5UNJwkx6wBOFLH9QNVQJljLarVd19Y
         N+oO1tEObob8QCqlTdiabKjLYTo0ULtkrvHYR0vD21OUTC8KLTc6BPrZtL0n7ClNYTGH
         rOWg==
X-Gm-Message-State: AOAM530kauLHtllKQ/xDR4OCOEZPNEyW5oo3Md98Fg7Rz5ghTRREKUAY
        g8kScgE0umj9L/dEpykuEBU=
X-Google-Smtp-Source: ABdhPJwGMvU1iTckYo4JM/N3oRhQtDxRt7mv3GmYcaJTbOJTrIvicGsmGDjxy/QiAMjpYQu7aPT0dg==
X-Received: by 2002:a63:c013:0:b0:3c1:df82:c8b3 with SMTP id h19-20020a63c013000000b003c1df82c8b3mr24535936pgg.141.1652351921735;
        Thu, 12 May 2022 03:38:41 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ad76:8fc:e2ba:172])
        by smtp.gmail.com with ESMTPSA id n123-20020a622781000000b0050e0dadb28dsm3387332pfn.205.2022.05.12.03.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:38:40 -0700 (PDT)
Date:   Thu, 12 May 2022 03:38:38 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 (repost)] workqueue: Warn flushing of kernel-global
 workqueues
Message-ID: <YnzjrnnP622mad1y@google.com>
References: <2efd5461-fccd-f1d9-7138-0a6767cbf5fe@I-love.SAKURA.ne.jp>
 <CAHk-=wgiCVcF4vJCOcg1hDw9PMT6zNSgt-pPuZL8ihWEcVv3eg@mail.gmail.com>
 <e4203c4f-9c3d-6e33-06e8-052676cc5af1@I-love.SAKURA.ne.jp>
 <YjivtdkpY+reW0Gt@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjivtdkpY+reW0Gt@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Mon, Mar 21, 2022 at 07:02:45AM -1000, Tejun Heo wrote:
> I'm willing to bet that the majority of the use cases can be converted to
> use flush_work() and that'd be the preference. We need a separate workqueue
> iff the flush requrement is complex (e.g. there are multiple dynamic work
> items in flight which need to be flushed together) or the work items needs
> some special attributes (such as MEM_RECLAIM or HIGHPRI) which don't apply
> to the system_wq users in the first place.

This means that now the code has to keep track of all work items that it
allocated, instead of being able "fire and forget" works (when dealing
with extremely infrequent events) and rely on flush_workqueue() to
cleanup. That flush typically happens in module unload path, and I
wonder if the restriction on flush_workqueue() could be relaxed to allow
calling it on unload.

Thanks.

-- 
Dmitry
