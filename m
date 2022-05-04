Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C289B51AFF6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378473AbiEDVDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359713AbiEDVDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:03:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6313E517EF
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=WNWx0x7W17X3MaNlQNM4Sq+GiTxh8gtdGrx9WBRQX18=; b=C16xbeWESD3ld8uLEPr/VxjBpt
        H2GI2Dx9vYPCc0wXnnyBioomz2UYBtnPA7NcI5tRT25H70Xk+1A5P29nQsVf1tDv+5BZUThPPEMj9
        l2kQr56miiAuQUuz7sqlrDe9JsXjbSEpup10JCX5hLzXLr50hbOdz7gUS7nsE7ONjmv/Ur5Uk0ycK
        k+SWQXF89ZlepvXbqc/5wri7Dh/zR4XtnYfujT/dPlr1njtxQR4f9T6cG6KASKLR8xrDQGrFbrh1T
        q3+tmOPb1q4MO+IJTKPoFByrcw2BqTBlfpFwSXecog+yiWRuOU5mIPoeeK/gIZGrnVnyDIyIZXZGc
        ikuvB6hw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmM61-00Chgz-HG; Wed, 04 May 2022 20:59:41 +0000
Date:   Wed, 4 May 2022 13:59:41 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, nizhen@uniontech.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH sysctl-next] sched: Fix build warning without
 CONFIG_SYSCTL
Message-ID: <YnLpPdQeD+Sz83Cn@bombadil.infradead.org>
References: <20220427131002.16192-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427131002.16192-1-yuehaibing@huawei.com>
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

On Wed, Apr 27, 2022 at 09:10:02PM +0800, YueHaibing wrote:
> IF CONFIG_SYSCTL is n, build warn:
> 
> kernel/sched/core.c:1782:12: warning: ‘sysctl_sched_uclamp_handler’ defined but not used [-Wunused-function]
>  static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> sysctl_sched_uclamp_handler() is used while CONFIG_SYSCTL enabled,
> wrap all related code with CONFIG_SYSCTL to fix this.
> 
> Fixes: 3267e0156c33 ("sched: Move uclamp_util sysctls to core.c")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks! Merged and pushed onto sysctl-testing. If there are no issues
I'll move  it to sysctl-next.  

  Luis
