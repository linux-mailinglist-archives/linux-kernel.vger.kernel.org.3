Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FD04ED365
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiCaFrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiCaFrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:47:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A4D1005;
        Wed, 30 Mar 2022 22:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KYbf7HSV24jrzW2ZtVUEOaLTWz6JVZPXyL3Rs7bbWM0=; b=GVzk+N3zwXy8smg2a0hAxoFSWr
        vlNPRnTm7Z1CH/5DWiTzx54r2Z32DfZQnywgD+6RYOrjqOiE6OWIF0mMOSzZxJKJnd4V3DuyFP/oH
        jBsg3NpArwXOP8hqFhedNGhb9Zq9QxvatG/Fk8heHlBrfZnyjViW1u0oITuS7+1YfI0bPNEqI/t+e
        1lOFGwO0wkNjGz3VMgHT70prYy7YNAXXFRnSj5eby/FVwOtGty/t1J3IGGvuEaEyt9HwodJYRbWI+
        LI45kP425fWQ90+/mjRbGuBpqXtNxJblFkvpnW3iaxPi9p5WjUG6fQ2jz7CYmT+hKJC1RFfaC3soB
        S0Jobl1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZncO-000jlX-Jw; Thu, 31 Mar 2022 05:45:12 +0000
Date:   Wed, 30 Mar 2022 22:45:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Wenchao Hao <haowenchao@huawei.com>, fmdefrancesco@gmail.com,
        axboe@kernel.dk, jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, linfeilong@huawei.com
Subject: Re: [PATCH] scsi: sd: call device_del() if device_add_disk() fails
Message-ID: <YkU/6KB+0fPU5Hie@infradead.org>
References: <20220329154948.10350-1-fmdefrancesco@gmail.com>
 <20220331152622.616534-1-haowenchao@huawei.com>
 <20220331054156.GI3293@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331054156.GI3293@kadam>
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

> The temptation was to call device_unregister() which is a combined
> device_del(); device_put(); but when the device_initialize() and
> device_add() are called separately, then I think it is more readable to
> call del and put separately as well.

I think we should also consolidate the initialization side.  Using
device_register and device_unregister would have prevented this bug
and I should have switched to that before refactoring the code.
