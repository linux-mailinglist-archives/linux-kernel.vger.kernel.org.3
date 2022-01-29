Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BFB4A2A91
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiA2A0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiA2A0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:26:30 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99847C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:26:30 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r10so13237223edt.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9SdoHewBp8piJxVnfN6HQGYBjFN4wMCA0gUu8ko+iys=;
        b=XsYh7tv71oF/a0S/TLARBNuBzE4nyFwYqC2eajKdVtkFqlfsXnu+QF1VCtv6pGHnV+
         6np/CbkjNgfaNRBE5fDdUPVwGg0ujFC1TntVWz82qjMqO4X7df09Rnc1rz8gjsvUtkmR
         88lzCImupQIN5wEIJ9OzIs4UxkvAB9YBI4rGyQNFTxIUVP28JTyTwCIwovrvctbrIN58
         DlUXfTFZNxhQv/tY3NWHMtWGnAcVT78txhtmBUbY5uLY+CmpkJPA+s99wBGl+0YKVwBT
         YmNMolkedPReTZcpAF9DfjXs5SeTT083EGO4gZoAoBGJuj5O+qach2zBd6fe4hF6m5CM
         uIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9SdoHewBp8piJxVnfN6HQGYBjFN4wMCA0gUu8ko+iys=;
        b=PjPbcPsgp8wQ/SRmZWb7IsVgE7A0t6Z94jPg1EN1qF3yRQjI2ItJAiUITOT/kAwnPl
         7R0FrZZp05oVjSrnBR20ZrCWgMGfLlhHEgzcTvDbJ5tLc8907CXrN8YBGe4iIQlOi3m+
         LhFyKthmrQ9OruvKct1uFwPFvQfsa1DWHSRkAjpTEMoPiM+lVEOU6vtdDXGvNUFpiaYP
         YK+Y7hlHy7pb6NLb9eZVBV2MQuXXzW3gkzrsBbjYH6usBJz1NvXgpYda/iUnQ7JfE9aq
         dvX2UDOfeU0LAFbmjHvIrQaHN/WhlyCMGIK+bOHNvtQ2dXY9cBodU0BYkvwKxWz9y/vo
         7jLg==
X-Gm-Message-State: AOAM533oqV0rKM1HvAOKnXHeJz62wMC4hIqUrRwEgcbnDkSWhjV8F6zK
        rRpR0r4LYXbuJEUduULsqFU=
X-Google-Smtp-Source: ABdhPJyj/aKnXW0BC8G00eDEMbqK1FU/ARC0uh6PHw7WDj2c3ZP2XvK+e5JquPATjmVmZtN/GFANLw==
X-Received: by 2002:a05:6402:3552:: with SMTP id f18mr10644929edd.189.1643415989052;
        Fri, 28 Jan 2022 16:26:29 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id r22sm13614354edt.51.2022.01.28.16.26.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jan 2022 16:26:28 -0800 (PST)
Date:   Sat, 29 Jan 2022 00:26:28 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: build zonelist for managed_zone
Message-ID: <20220129002628.2cwr35glahq5f5md@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220127012023.18095-1-richard.weiyang@gmail.com>
 <YfJXoSVkQ3X5u44F@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfJXoSVkQ3X5u44F@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:28:17AM +0100, Michal Hocko wrote:
>On Thu 27-01-22 01:20:23, Wei Yang wrote:
>> During memory hotplug, when online/offline a zone, we need to rebuild
>> the zonelist for all node. There are two checks to decide whether a zone
>> would be added to zonelist:
>> 
>>   * one in online_pages/offline_pages to decide necessity
>>   * one in build_zonerefs_node to do real add
>> 
>> Currently we use different criteria at these two places, which is
>> different from the original behavior.
>> 
>> Originally during memory hotplug, zonelist is re-built when zone hasn't
>> been populated. This in introduced in 'commit 6811378e7d8b ("[PATCH]
>> wait_table and zonelist initializing for memory hotadd: update zonelists")'.
>> And at that moment, build_zonelists_node() also use populated_zone() to
>> decide whether the zone should be added to zonelist.
>> 
>> While in 'commit 6aa303defb74 ("mm, vmscan: only allocate and reclaim
>> from zones with pages managed by the buddy allocator")',
>> build_zonelists_node() changed to use managed_zone() to add zonelist.
>> But we still use populated_zone() to decide the necessity.
>> 
>> This patch restore the original behavior by using the same criteria to
>> add a zone in zonelist during memory hotplug.
>
>Why?
>

In case we online a populated zone, but not managed. Then this zone will not
be in zonelist. Right?

-- 
Wei Yang
Help you, Help me
