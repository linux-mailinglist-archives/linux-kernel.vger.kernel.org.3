Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DDA4EC892
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348340AbiC3PoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbiC3PoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:44:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40C033E0A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mj2UbADx+YNRvo7oIcDQ5Z38Xm8WJ83fqDWbmjvlOwc=; b=LLGIXOeTCMzAUOivLAjaHxROvf
        kHk0MPMJ/17SNeJ/VV1+/HzYJuDE05PN7FyyRqwGn4zlvEnhH57Earji9YvrD9CBBJPAgJnauQ31y
        VIxGlDhrbdaLT1IO0F9ei6vMLUdoK1taK7RbKFVhg0csbcP3GpP/63bW1vYKJgFkS/0WvbEXBbAzS
        fYNVHpHpHBBQaVPUE9i0CUwgMYyAR35GKE0AgEi4a3ABY6BxI8n7HJiZkLtCqmrSx5VE1/QB25ilA
        APtj9UBd9761+s+wG3uf6Tg8sXcYaYwWt86EQpQKBd1RiELy+w/qPO9n1tI5FFLkhfUmFdU1XwrUx
        1Oe+AhZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZaSf-00GbcO-2U; Wed, 30 Mar 2022 15:42:17 +0000
Date:   Wed, 30 Mar 2022 08:42:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fs: sysv: check sbi->s_firstdatazone in
 complete_read_super
Message-ID: <YkR6WdjLJyF0PMcd@infradead.org>
References: <20220330104215.530223-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330104215.530223-1-liushixin2@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 06:42:15PM +0800, Liu Shixin wrote:
> sbi->s_firstinodezone is initialized to 2 and sbi->s_firstdatazone is read
> from sbd. There's no guarantee that sbi->s_firstdatazone must bigger than
> sbi->s_firstinodezone. If sbi->s_firstdatazone less than 2, the filesystem
> can still be mounted unexpetly. At this point, sbi->s_ninodes flip to very
> large value and this filesystem is broken. We can observe this by
> executing 'df' command. When we execute, we will get an error message:
> 	"sysv_count_free_inodes: unable to read inode table"

This looks fine.  Just curious: which variant of the sysv fs do you
use and what is the use case?
