Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA9F48EF59
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243922AbiANRo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243936AbiANRoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:44:15 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D3EC061401
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 09:44:15 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id n16-20020a17090a091000b001b46196d572so875380pjn.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 09:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Tf1y8NPR8awPz4dMppv7tyk5zmNgJO+gD+PDlVaFbU=;
        b=GqaVr+XFcNjvPXq229ojhvvTmtPiHYVcrAnWb0O/RJ6Uix8SEUIyG5U8bq/HXusseL
         BA2h+dlVGvTK8qidZiB+I+I4qtOuRF37fvVk8jmO4zBV9AWd5psuWkvly7NWRpK6NS5l
         4IHwKlMfq9VOvdSQ3mY2BWxS7TPkeE+yp4419FWKpoLgQyXFYT2TMYITpMxHCHvE4OE7
         HDILMnGA/FLRZzyE7brIYZwptfH9r/ni97Fq+GJVgEXRpr3nQaDVQ3jrnQFAyH8W+yAO
         R4E7TL5GsJ+pdTYsslQSpn0pzwWLjmdO+3vpbye6j6WWMUDKRX2u1v+3+cPYHOvvpTex
         yTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5Tf1y8NPR8awPz4dMppv7tyk5zmNgJO+gD+PDlVaFbU=;
        b=qhTcGfF2sPX/YYlrP2O+CzchS8IbPEdo3Tuu8zizkqxKQhUTrL3AdIyqddPH0XpyMF
         C6wJoB9KhI0cUTWPjPXpss6cMHQtW4uvcCNSVs42OmPGuEMKRQtaAsfv8hvcDIE+hSHX
         /f/yW8eUMtbwTxBA/ceAN3FCtWwIQiaoISV5IvlFdOY7+7cIFx1xfijl7TWTfUWyMoX3
         h+Y/Yy2Pa5jMm1WnwwqZTcxHMfmamfzTHol3A6S5+TFP+j3nUhcea7J5rGsonre3ymIq
         kEpNmfoowEqtyULH8kvHm7D01gXnEb1N/8aZVg8dniNAXY41jFVx6DKyX+uFenbt1DLS
         rqJw==
X-Gm-Message-State: AOAM532caSf3qec977B9i1uSuaG4Qh1ZP9X/uuQHLDpAcol10x8NzDye
        rqM/A5keBT1ZMN+E/M45lMg=
X-Google-Smtp-Source: ABdhPJwQtbxSfihNU4BXZjnYQm55bWL/jYfwiOdX6lgXw3lCT3FsApkcKeJ6VOmGOBGHk9yryehN3A==
X-Received: by 2002:a17:90b:4f8d:: with SMTP id qe13mr21147321pjb.178.1642182254689;
        Fri, 14 Jan 2022 09:44:14 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id s5sm6140342pfe.117.2022.01.14.09.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 09:44:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 14 Jan 2022 07:44:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] kernfs: Reduce contention around global per-fs
 kernfs_rwsem.
Message-ID: <YeG2bJtkbrue/hwZ@slm.duckdns.org>
References: <20220113104259.1584491-1-imran.f.khan@oracle.com>
 <20220113104259.1584491-3-imran.f.khan@oracle.com>
 <YeBWWWa030xTftWe@slm.duckdns.org>
 <84861be0-519a-233d-9c6c-482f12e33328@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84861be0-519a-233d-9c6c-482f12e33328@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Jan 15, 2022 at 04:08:10AM +1100, Imran Khan wrote:
> I have made changes inline with your suggestion to synchronize
> addition/removal through hashed locks but so far I am not using tokens.
> I am currently testing these changes (so far no issues seen). Before
> floating next version for review I wanted to understand the reason
> behind need of tokens. Could you please elaborate a bit about what needs
> / may have to be recorded in tokens. Just one example will do. It would
> help me consolidate the next version of this change without overlooking
> something.

Oh, just sth to carry what needs to be done to unlock. If you didn't need
them and returning pointers to the locks was enough, that's fine too but if
double locking was necessary for e.g. removals, encapsulating it in a struct
may be neater.

Thanks.

-- 
tejun
