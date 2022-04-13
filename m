Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776614FFEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbiDMTOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238288AbiDMTMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:12:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D126E8DC;
        Wed, 13 Apr 2022 12:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FCBDB82760;
        Wed, 13 Apr 2022 19:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7C7C385A3;
        Wed, 13 Apr 2022 19:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649876887;
        bh=HS2szbOJxe7C3PIkz+onUkqYqx0zj5ZuzRc1VOGk0IM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DD5eWZ+7y7wEUnMyatZWxirBYZvREPY7llxtxRnNTa36xQjeWepf5jUk7HQvhTzkM
         vcb10gqp4plEO0lSUDjx0bwDBE1yl4O6/OjlwSS1E2eqjTF3/YRuCqRQ0oe1KRdPbI
         hy9guWV8Z+7Yo9UAghXSkCglT+RBOroKfE96qpO4=
Date:   Wed, 13 Apr 2022 12:08:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v8 1/4] mm: hugetlb_vmemmap: introduce
 CONFIG_HUGETLB_PAGE_HAS_OPTIMIZE_VMEMMAP
Message-Id: <20220413120804.3570dc230a958f4923e3f3c3@linux-foundation.org>
In-Reply-To: <20220413144748.84106-2-songmuchun@bytedance.com>
References: <20220413144748.84106-1-songmuchun@bytedance.com>
        <20220413144748.84106-2-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 22:47:45 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> If the size of "struct page" is not the power of two but with the feature
> of minimizing overhead of struct page associated with each HugeTLB is
> enabled, then the vmemmap pages of HugeTLB will be corrupted after
> remapping (panic is about to happen in theory).  But this only exists when
> !CONFIG_MEMCG && !CONFIG_SLUB on x86_64.  However, it is not a conventional
> configuration nowadays.  So it is not a real word issue, just the result
> of a code review.

The patch does add a whole bunch of tricky junk to address something
which won't happen.  How about we simply disable
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP if (!CONFIG_MEMCG &&
!CONFIG_SLUB)?

