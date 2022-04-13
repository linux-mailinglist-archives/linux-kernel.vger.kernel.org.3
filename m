Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63944FFEF1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiDMTPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239135AbiDMTOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:14:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BAA48E5B;
        Wed, 13 Apr 2022 12:10:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3026AB82761;
        Wed, 13 Apr 2022 19:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C03C385A3;
        Wed, 13 Apr 2022 19:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649877053;
        bh=7zffni3b6WrTkbJ/vkGXvRk4tdERsTcUIscgc872JCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SqqwH/ILeJhcYHRxq2AClOf8Giw69xPlpG9aNeHURMMSzmwK4WpuapedIeUPEC9+1
         8PiG87qt/kuClb3p6ErUbd2GuAIWw7YlDCQF4u2BiMVfsaHuYzCZUwJGEr1b8uXtqi
         NLCeoVYVhofr6h4dBfWKxp5jWITD4C0bA8pfpC+A=
Date:   Wed, 13 Apr 2022 12:10:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v8 4/4] mm: hugetlb_vmemmap: add
 hugetlb_optimize_vmemmap sysctl
Message-Id: <20220413121051.a363193c726451115c634a69@linux-foundation.org>
In-Reply-To: <20220413144748.84106-5-songmuchun@bytedance.com>
References: <20220413144748.84106-1-songmuchun@bytedance.com>
        <20220413144748.84106-5-songmuchun@bytedance.com>
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

On Wed, 13 Apr 2022 22:47:48 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> We must add hugetlb_free_vmemmap=on (or "off") to the boot cmdline and
> reboot the server to enable or disable the feature of optimizing vmemmap
> pages associated with HugeTLB pages.  However, rebooting usually takes a
> long time.  So add a sysctl to enable or disable the feature at runtime
> without rebooting.

Do we really need this feature?  Really?  What's the use case and what
is the end-user value?

Presumably CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP worsens things for some
setups/workloads?  Please tell us much more about that.  What is the
magnitude of the deoptimization?
