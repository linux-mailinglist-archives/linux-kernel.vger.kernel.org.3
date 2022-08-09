Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257DD58D607
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiHIJMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiHIJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:12:06 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD86D5D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 02:12:04 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f65so10812698pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 02:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rnKvsjRzjSZVAjcLrYl/OIdjQK2uj+t6rJ77SSO6CMM=;
        b=UEOGGaqvsR2p1jHsaMP0Hmr/dYjSZxADudKeomtqEELhb112451c4ixhOoRdxhPh9A
         O9uFbOEeInN1y5q2uQK6VLjGjFItGb91DpDzAtToWtlhn64ekTEJmoKmWtiTPleEeKvO
         6NJwgOOxwh99JVSXVCjE5YDMKPnR3WWnO/kDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rnKvsjRzjSZVAjcLrYl/OIdjQK2uj+t6rJ77SSO6CMM=;
        b=3LQomsK6la/HWUuqHTu2hKi2AAOAOZ3C+eh8tRJEKluDo9CGMOymMf5BWpk6Z1J65K
         /OIi9FGwtGX4gqnyMKj9gcbr0YjyuUDjsfTn7GoXFUUb3a9KdlH8YVqC4deruImYRw7q
         VfWd9I5aWoatW69BQsCMN6F08DFl9MpTWKg6Uvn0qXjJU8plsB5Sp29nMHZaZ3lwpR1z
         +XwRDDLc2w2EvWBGigKuxP99QpW2nDGO+aTlhXpCu8bKaSPYismuFrCbyOiN+TWutgCH
         SOH+hDg5DXaSE26VOlrrs8VabSEBqnnBWWwXCp8+PReNEs2pA88LW7RcdKZclgwUhY+g
         RrXA==
X-Gm-Message-State: ACgBeo2+Y0OgEkQJHbO3tqKIoRjjwq+Et32UarhhSfvcFKWFFkJxAHzc
        KKDghDSEWz/S7176imj9A9Cy9Q==
X-Google-Smtp-Source: AA6agR4YjfpNeCgdxVd1yQ8AWTKp3oIXYofRkuKCvkMGshMjI+ND2ooQKLj8EiTWOCP7BNCp3BDxgQ==
X-Received: by 2002:a63:6d2:0:b0:41c:18f2:8ec5 with SMTP id 201-20020a6306d2000000b0041c18f28ec5mr19158344pgg.197.1660036324302;
        Tue, 09 Aug 2022 02:12:04 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:8d43:c739:457a:5504])
        by smtp.gmail.com with ESMTPSA id t3-20020a1709027fc300b0016daee46b72sm10195159plb.237.2022.08.09.02.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 02:12:03 -0700 (PDT)
Date:   Tue, 9 Aug 2022 18:11:57 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        minchan@kernel.org, ngupta@vflare.org, Jan Kara <jack@suse.com>,
        Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        avromanov@sberdevices.ru, ddrokosov@sberdevices.ru,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: ext2/zram issue [was: Linux 5.19]
Message-ID: <YvIk3SdC7wP3uItR@google.com>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
 <c7c69f77-4ea2-3375-33f3-322a3d35def5@kernel.org>
 <8710b302-9415-458d-f8a2-b78cc3a96e49@kernel.org>
 <YvIeLHuEb9XDSp6N@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvIeLHuEb9XDSp6N@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/08/09 17:43), Sergey Senozhatsky wrote:
> On (22/08/09 10:12), Jiri Slaby wrote:
> > > So currently, I blame:
> > > commit e7be8d1dd983156bbdd22c0319b71119a8fbb697
> > > Author: Alexey Romanov <avromanov@sberdevices.ru>
> > > Date:�� Thu May 12 20:23:07 2022 -0700
> > > 
> > >  ��� zram: remove double compression logic
> > > 
> > > 
> > > /me needs to confirm.
> > 
> > With that commit reverted, I see no more I/O errors, only oom-killer
> > messages (which is OK IMO, provided I write 1G of urandom on a machine w/
> > 800M of RAM):
> 
> Hmm... So handle allocation always succeeds in the slow path? (when we
> try to allocate it second time)

Yeah I can see how handle re-allocation with direct reclaim can make it more
successful, but in exchange it oom-kills some user-space process, I suppose.
Is oom-kill really a good alternative though?
