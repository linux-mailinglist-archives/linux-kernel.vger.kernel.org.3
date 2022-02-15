Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B364B7676
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243995AbiBOUFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:05:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbiBOUFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:05:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058BF88789
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:05:27 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4319A1F37B;
        Tue, 15 Feb 2022 20:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644955526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SusZ2Nn0UF1cMWphj1PKY7wujcVBC8OwT9Ti8njPVmQ=;
        b=JtFMbVxT7bbNnkh2qV56nxXV4fJNroicIZgWuWLCPFiDu4ubhJ2fofzVsJhHmRXipQKjXB
        Ixve3P7JbYHQOYirWM2QmIYfBk16A8yiTmjLb+6QKfGetsui+dlSD2FKESTl3tYDubccAd
        oqLLtUfD4IqdiX/hhFVC06weJdOPnKM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 76125A3B83;
        Tue, 15 Feb 2022 20:05:25 +0000 (UTC)
Date:   Tue, 15 Feb 2022 21:05:25 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, ebiederm@xmission.com, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        chris.hyser@oracle.com, dave@stgolabs.net, pcc@google.com,
        caoxiaofeng@yulong.com, david@redhat.com, gorcunov@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/1] mm: fix use-after-free when anon vma name is used
 after vma is freed
Message-ID: <YgwHhTN4P5yyZqBz@dhcp22.suse.cz>
References: <20220211013032.623763-1-surenb@google.com>
 <YgvONKdZ2T0PB2/0@dhcp22.suse.cz>
 <YgwDa6rMHRdRTnzB@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgwDa6rMHRdRTnzB@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One thing I was considering is to check agains ref counte overflo (a
deep process chain with many vmas could grow really high. ref_count
interface doesn't provide any easy way to check for overflows as far as
I could see from a quick glance so I gave up there but the logic would
be really straightforward. We just create a new anon_vma_name with the same
content and use it when duplicating if the usage grow really
(arbitrarily) high.
-- 
Michal Hocko
SUSE Labs
