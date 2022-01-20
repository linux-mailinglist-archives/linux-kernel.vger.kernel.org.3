Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F864955C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 22:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377760AbiATVIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 16:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347149AbiATVH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:07:58 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2C5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:07:58 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id e9so6355178pgb.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7yReEIG2XuZiaNevYXoaZDowK53Ixw5WTV91sPdZZqQ=;
        b=grI/nQxFj4oq2UTCiTdXevZ8OZsVAsxw2JnG3XbEjojLZnobinLSlHnGgZLO52pCZI
         19THJqzHoFwydtdyad18RY2vhUe/8mJU5w3B7O5rQOcLM5Zjh2qeZ1Ho4BlWsW2vk03n
         E4Cf0jadhAew4LxhZo3sl6KLyG5ePdu9lHc8dHnNkfpu/xSRs5Ih7ARPmIP1OjHbrfmz
         a3lp3vsNO1gd7m57yEEz8KmT4O9sAzSRaZNzkATJ4RTqzuynqEpiyEkXlIT8Mxkje8mZ
         BxHNBSIzmA36MR4Zbt/uqRq7DWfg5Zaoc1WmBkQrjac1U3F1Lfr7E+6BFTjd/lopnPdc
         231w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7yReEIG2XuZiaNevYXoaZDowK53Ixw5WTV91sPdZZqQ=;
        b=TP0dcg1YxtA2UtBHhtGrax5NUzjm3sXXw7mp0Aiq2q+MB3c2p6ixtAGZZn7LvSlAzy
         TsYGhbDLXheosABrjL3I3BmfFPpRis7MYJjGQAKKcz9tni0yZ7TvhKmAQ5hj4e37gTBR
         M4iK5Wqud2j+A/C3oed8zuoXmqEfd9TUL5YRPMS7u+u4yGToB5nqpsCiJbQzii5kaTJj
         YRvzpebN+ziA4Fg7WvOGS4XWm0euVETH2+F0OhrOryvgAKebvRvPuHT6ou2cMWQGHtUi
         JuPilRHNzsWo60k/QmfISVBTbcDUPobblj3Pa+/73PwOb6pzJijF/m88bkB35u8i6s0L
         wilQ==
X-Gm-Message-State: AOAM530lTeWoAA0iGZORJ+jB7ZWRCyw1TYsDvYx+LE3hvvhZUpbYZems
        AQo17LgRi0pghQGbPCReAcw=
X-Google-Smtp-Source: ABdhPJyDsV/Dackn7ETE8gQmoorS0gE8B+qtyYaosDeMdlIlb4q1K/lzMrYQ09g8a7ycDinULfPXxA==
X-Received: by 2002:a63:2210:: with SMTP id i16mr488618pgi.532.1642712877626;
        Thu, 20 Jan 2022 13:07:57 -0800 (PST)
Received: from google.com ([2620:15c:211:201:b370:1e12:5bf4:801f])
        by smtp.gmail.com with ESMTPSA id h21sm4549939pfh.93.2022.01.20.13.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 13:07:57 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 20 Jan 2022 13:07:55 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [RESEND][PATCH v2] mm: don't call lru draining in the nested
 lru_cache_disable
Message-ID: <YenPK/JVNOhbxjtr@google.com>
References: <20211230193627.495145-1-minchan@kernel.org>
 <YeVzWlrojI1+buQx@dhcp22.suse.cz>
 <YedXhpwURNTkW1Z3@google.com>
 <YefX1t4owjlx/m5I@dhcp22.suse.cz>
 <YejkUlnnYeED1pC5@google.com>
 <YekcNmBqcpO9BYWv@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YekcNmBqcpO9BYWv@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 09:24:22AM +0100, Michal Hocko wrote:
> On Wed 19-01-22 20:25:54, Minchan Kim wrote:
> > On Wed, Jan 19, 2022 at 10:20:22AM +0100, Michal Hocko wrote:
> [...]
> > > What does prevent you from calling lru_cache_{disable,enable} this way
> > > with the existing implementation? AFAICS calls can be nested just fine.
> > > Or am I missing something?
> > 
> > It just increases more IPI calls since we drain the lru cache
> > both upper layer and lower layer. That's I'd like to avoid
> > in this patch. Just disable lru cache one time for entire
> > allocation path.
> 
> I do not follow. Once you call lru_cache_disable at the higher level
> then no new pages are going to be added to the pcp caches. At the same
> time existing caches are flushed so the inner lru_cache_disable will not
> trigger any new IPIs.

lru_cache_disable calls __lru_add_drain_all with force_all_cpus
unconditionally so keep calling the IPI.
