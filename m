Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FB24A8153
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346207AbiBCJT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:19:57 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58966 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241226AbiBCJTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:19:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 92CF81F3A5;
        Thu,  3 Feb 2022 09:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643879989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mMHRl+3oS7jcJj4KDFQJNIuprJqV/MWu3fMSTCqn8qo=;
        b=ZcVqrc/4khKPD8ZVgO9u5DCNFaUy96KEkOVyjAfro5Ypms3GQLNEbaLeekPTaK3/107gIr
        2pzmNS0Z0mEs9WK2b97yjWsWFPfZHoKba635V0rtA0NALGwehUGxK6s1U8UmUcggefLFM0
        8sugCnsz/sp1bjSo6x/aOzaTqKptK8I=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4426CA3B8C;
        Thu,  3 Feb 2022 09:19:49 +0000 (UTC)
Date:   Thu, 3 Feb 2022 10:19:48 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Rafael Aquini <raquini@redhat.com>
Subject: Re: [PATCH 2/6] mm: handle uninitialized numa nodes gracefully
Message-ID: <YfueNDJJJIm/1MAy@dhcp22.suse.cz>
References: <20220127085305.20890-3-mhocko@kernel.org>
 <YfKgE5hTgbaBeaMa@kernel.org>
 <YfKwjAlPW2kJUv5w@dhcp22.suse.cz>
 <20220201024119.2ailcw4rp5thambz@master>
 <YfkDXYhGjAvAKKeU@dhcp22.suse.cz>
 <20220203002116.akpk5um5nkpeflve@master>
 <YfuC6IaasxcnAdGl@kernel.org>
 <c67e5fc0-95dd-1659-3a81-f23cf0be9c08@redhat.com>
 <YfubhocKKKWgKlEq@kernel.org>
 <15ad305f-a147-4a9c-35e5-bb0a868499ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15ad305f-a147-4a9c-35e5-bb0a868499ad@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we will go with the following.
/*
 * We do not want to confuse userspace by sysfs files/directories for node
 * without any memory attached to it, so this node is not marked as
 * N_MEMORY and not marked online so that no sysfs hierarchy will be
 * created via register_one_node for this node. The pgdat will get fully
 * initialized by hotadd_init_pgdat() when memory is hotpluged into this
 * node
 */

OK?
-- 
Michal Hocko
SUSE Labs
