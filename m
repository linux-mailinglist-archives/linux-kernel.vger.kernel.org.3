Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63B94C6FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbiB1Omo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiB1Omm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:42:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513757EDA0;
        Mon, 28 Feb 2022 06:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ujPnOWbvLWDuP5VEFGAmYpTMedCZmNkrYJPtv8OTgqQ=; b=iVE4UwL1JqhBMEMkDuJQY0xTXQ
        JaVXp5Bd8Yzr8lQfhEw7pOAb+wVaZ0k2Bqldk7xK9BtTaACFMnRhnmn6HSVmLzldB5sp21KtBJD2s
        jV8Y0f7PHUOeisnC9I63cue51CRJpXyzicCI/QKRl7E5u0hpW5MM7bz7/oU9ril60op8c+VK+9vE7
        nJ0voNLfy5LOnljS8MqkQakszidWPIwAAJp6mvMoT/CwcdnOqYMxIAsAURXOrfXoFbF+aQqX7CO7D
        q0B190hD32ZZfNHTIdXTQdkjrS3RfcbC5hFZLqJn6nDhJ3vjbTy61KXeOs0zTXMRVr88Ehx0bGbkO
        fPEK2xxw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOhDr-00CyXK-U6; Mon, 28 Feb 2022 14:41:59 +0000
Date:   Mon, 28 Feb 2022 06:41:59 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        keescook@chromium.org, yzaikin@google.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com
Subject: Re: [PATCH 3/3] mm: hugetlb: add hugetlb_free_vmemmap sysctl
Message-ID: <YhzfN574YUta3qay@bombadil.infradead.org>
References: <20220228071022.26143-1-songmuchun@bytedance.com>
 <20220228071022.26143-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228071022.26143-4-songmuchun@bytedance.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 03:10:22PM +0800, Muchun Song wrote:
> We must add "hugetlb_free_vmemmap=on" to boot cmdline and reboot the
> server to enable the feature of freeing vmemmap pages of HugeTLB
> pages. Rebooting usually taske a long time. Add a sysctl to enable
> the feature at runtime and do not need to reboot.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/sysctl/vm.rst | 13 +++++++++++++
>  include/linux/hugetlb.h                 |  5 +++++
>  include/linux/memory_hotplug.h          |  1 +
>  kernel/sysctl.c                         | 11 +++++++++++

kernel/sysctl.c is a hot mess with tons of knobs from all over the
place. And so we've been moving these to their own place. For instance
all the filesystem knobs are now properly in fs/. So Adding new ones
to the file is undesirable. If this is going to be added, please add
it somewhere in mm / hugetlb code.

  Luis
