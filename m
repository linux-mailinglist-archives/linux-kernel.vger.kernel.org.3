Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A9B52BABB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiERMOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiERMOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:14:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48448187D92
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:14:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D8ACD1F8CD;
        Wed, 18 May 2022 12:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652876071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9r+gPElnJVP8tCAnWitGOvk8YXLPGtSi9I5ydDa7xpA=;
        b=WMhtvuOMPfMCZax4or3zzsT7ft7vS5rGAM1j1qZmJupHus5HM6rwLdNeJjfcQmJ3Jb7Lb0
        KVZAhuIB60i2EkL8zH/gBVgXasinLow6VUMb8qc+YOrROyOEnGbkwVUMUBAoB2FO1RH7fs
        bwDLsSHfzSgT143/uF7O+RIPYGTrH7Q=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A19C52C141;
        Wed, 18 May 2022 12:14:31 +0000 (UTC)
Date:   Wed, 18 May 2022 14:14:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     Balbir Singh <bsingharora@gmail.com>, akpm@linux-foundation.org,
        ammarfaizi2@gnuweeb.org, oleksandr@natalenko.name,
        willy@infradead.org, linux-mm@kvack.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>
Subject: Re: [PATCH] mm/ksm: introduce ksm_enabled for each processg
Message-ID: <YoTjJH7+QD+DSrW8@dhcp22.suse.cz>
References: <20220517092701.1662641-1-xu.xin16@zte.com.cn>
 <YoSZE7Iak3AYA4VE@balbir-desktop>
 <6284a2ef.1c69fb81.e53cd.32b2@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6284a2ef.1c69fb81.e53cd.32b2@mx.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-05-22 07:40:30, CGEL wrote:
[...]
> 2. process_madvise is still a kind of madvise. processs_madvise from
> another process overrides the intention of origin app code ifself that
> also calls madvise, which is unrecoverable. For example, if a process "A"
> which madvises just one part of VMAs (not all) as MERGEABLE run on the OS
> already, meanwhile, if another process which doesn't know the information
> of "A" 's MERGEABLE areas, then call process_madvise to advise all VMAs of
> "A" as MERGEABLE, the original MERGEABLE information of "A" calling madivse
> is erasured permanently.

I do not really follow. How is this any different from an external
process modifying the process wide policy via the proc or any other
interface?
-- 
Michal Hocko
SUSE Labs
