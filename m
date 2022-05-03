Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921B3518E78
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242551AbiECURY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242513AbiECURM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:17:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B6841331;
        Tue,  3 May 2022 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EV8wWFdN34AhA7Wg4Wqdo8oXKW0h6HfwBJVrdvsJ7F0=; b=yUVNG3ZnrxlUXxtf8HkrX3J7sX
        30XigjyXNfw0gw/Au7hQaGiuhA6AgJ6CqOQDh0xNIcRUCdsiUM3VD67ZVqQd4SE7woil9N9JiQ+Db
        CbzieOb1bZNAEQWDDAuyrDLA3xBQ/cDXtJL68Uqc9eNihk9ZC5fvVtZpFAHI2OG6ebRAyxXe5eC6/
        swLddcqgobGPEWB3TDz8Y9Y1rnl3Gb2g4uzIXhgtJFW2R3vMkEwLYYCvsYff31WP7pEhG9/MDRPuF
        3kb54lROFkfr/5MCuYuQ5sUTW+Hr7+uSuU5uz17OwkE3tNb48qvggr2kQCAf1mkyPvgn5pI9yGwBd
        PvVLl2Dw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlysj-007WKS-6X; Tue, 03 May 2022 20:12:25 +0000
Date:   Tue, 3 May 2022 13:12:25 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: Re: [PATCH v5 0/3] module: Introduce module unload taint tracking
Message-ID: <YnGMqYuiR+S6ChYC@bombadil.infradead.org>
References: <20220502205105.919523-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502205105.919523-1-atomlin@redhat.com>
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

On Mon, May 02, 2022 at 09:51:02PM +0100, Aaron Tomlin wrote:
> Hi Luis,
> 
> This iteration is still based on the latest mcgrof/modules-next branch.
> 
> I have decided still to use RCU even though no entry is ever removed from
> the unloaded tainted modules list. That being said, if I understand
> correctly, it is not safe in some instances to use 'module_mutex' in
> print_modules().  So instead we disable preemption to ensure list traversal
> with concurrent list manipulation e.g. list_add_rcu(), is safe too.
> 
> Changes since v4 [1]
>  - Moved code to kernel/module/tracking.c
>    (Luis Chamberlain)
>  - Used only strcmp() in try_add_tainted_module()
>    (Christophe Leroy)
> 
> Changes since v3 [2]
>  - Fixed kernel build error reported by kernel test robot i.e. moved
>    '#endif' outside 'if (!list_empty(&unloaded_tainted_modules))'
>    statement in the context of print_modules()
>  - Used strncmp() instead of memcmp()
>    (Oleksandr Natalenko)
>  - Removed the additional strlen()
>    (Christoph Lameter)
> 
> Changes since v2 [3]
>  - Dropped RFC from subject
>  - Removed the newline i.e. "\n" in printk()
>  - Always include the tainted module's unload count
>  - Unconditionally display each unloaded tainted module
> 
> Please let me know your thoughts.

Thanks! Queued onto modules-testing. If no issues are found I'll push to
modules-next soon after.

  Luis
