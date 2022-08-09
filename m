Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B06C58D62D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiHIJQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbiHIJPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:15:50 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9521A816
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 02:15:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d16so10781815pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 02:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FSqOfzpZFUwxr8/HeQ2ME9Ryp30O9Pfj1SqUD1sPdrE=;
        b=cysesuRYHU30L5/uc3M+rJSD7t5hbJ6SmQZQGevM+9EmiBSlfecggbUEkZgRRIMq00
         9ZLuoH8Faa+Na2fsTSh7Ly83OG47w28c4bg5NYyrkpY/yKc+Ph1v0SNC/O+MIL66B4Je
         k3oaZzIZ6VNzcBBSeqeRb+UqY+skq7sbqvT30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FSqOfzpZFUwxr8/HeQ2ME9Ryp30O9Pfj1SqUD1sPdrE=;
        b=OdBY/b9g4tPDkO/NsFD0LRlfqz/Ucp0Jrsrt8oAE5drzXCuvPbG7lWlCj/Z5Iu1X+u
         u0Qbt+G1ZMoxOjFrH/GDSDN0nomEgqsdAxqnkAY4Sj7IAcqEurKYvgVBXy9pLd0s5/gA
         eNEFTWQQVK9952lyh66WPrsSdARtl3GSbcZ5FdWvxKj/V8eGGHkpbDgZDIZ4S/1SKtnm
         DlNd6EJ9eLQwOAr0T1+MnYrNXsYQ3R4q+SOT6rsyoodYrO8T/0VP44eDKpxkETwImAXh
         PhT84gsaFtJtXHtsJd6/YcflfJPW5nGSE4vEPYxBxPRKHdwaVj77Cv5T/3OsmY24WHsH
         AgzQ==
X-Gm-Message-State: ACgBeo1JJN/SLHa4zUfdl2ZNVh0KogEEowVH+Ys0JATSvYyCW8ztCvsb
        3VsYMG0sX82AOgf43p7VciBrwg==
X-Google-Smtp-Source: AA6agR5KA4bN2UFClOwGt6cKcwaRp/Ex5oIjk0AIN3k2UJ+MpFxP0OjPZfORGUebEqY9naJNf2zoXg==
X-Received: by 2002:a17:902:d48d:b0:16f:5ce:1d08 with SMTP id c13-20020a170902d48d00b0016f05ce1d08mr22446624plg.49.1660036543139;
        Tue, 09 Aug 2022 02:15:43 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:8d43:c739:457a:5504])
        by smtp.gmail.com with ESMTPSA id p3-20020a625b03000000b0052d7cca96acsm10053741pfb.110.2022.08.09.02.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 02:15:42 -0700 (PDT)
Date:   Tue, 9 Aug 2022 18:15:37 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        minchan@kernel.org, ngupta@vflare.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jan Kara <jack@suse.com>, Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: ext2/zram issue [was: Linux 5.19]
Message-ID: <YvIluTU6oFDpwQwK@google.com>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
 <20220809091212.mgreambnhgso5hzw@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809091212.mgreambnhgso5hzw@fedora>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/08/09 11:12), Lukas Czerner wrote:
> Hi Jiri,
> 
> I've tried a quick xfstests run on ext2 on zram and I can't see any
> issues like this so far. I will run a full test and report back in case
> there is anything obvious.

AFAICT this should be visible only when we are under memory pressure,
so that direct reclaim from zs_malloc handle allocation call makes a
difference.
