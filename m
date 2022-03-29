Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B927E4EAE8E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbiC2NgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiC2NgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:36:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CA31F626;
        Tue, 29 Mar 2022 06:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QUx/n+gFzgQBxeEXkD3spbgzkI2e56CAN02KOXZxJaI=; b=w/6iPI8bgV8iER5ysGWuY/CMSk
        //ZwXNSfxQHrlEPa+KReDK/eV4Tuvea2zSNR0YnvuRMs8GxZapw0YHioDbHhz9Onq25awDwLSDqJ+
        lEdOUbDe+sp2++REdNRebbz62G/ce68GsALtf9JaNXLfRk+yLzbwijhBcUulz0sis/3wMjeA4ih3N
        vz+X2MhonFEimkZd+vU5Ycs2QWRJSWd2EZcWIRAob7+BiNTGmd2Srr/ioNcdn9bquvPSNVJGeuzA5
        PEgQfZUjRRnCl1pztgGy3zNmbpRLdhf7ymN8JJTVwqO2vGVaOlw/WaOpKtv1yj6KIV6iElbvhyAN/
        M0YD9TEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZBzB-00CNM3-8O; Tue, 29 Mar 2022 13:34:13 +0000
Date:   Tue, 29 Mar 2022 06:34:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kirill Tkhai <kirill.tkhai@openvz.org>
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, linux-kernel@vger.kernel.org,
        khorenko@virtuozzo.com, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [dm-devel] [PATCH 3/4] dm-qcow2: Introduce driver to create
 block devices over QCOW2 files
Message-ID: <YkMK1cmWyEJGoMB+@infradead.org>
References: <164846619932.251310.3668540533992131988.stgit@pro>
 <164846631540.251310.2398727490395218229.stgit@pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164846631540.251310.2398727490395218229.stgit@pro>
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

On Mon, Mar 28, 2022 at 02:18:35PM +0300, Kirill Tkhai wrote:
> The driver is request based, since this allows to use blk-mq
> merging of request. Driver splits requests itself, and every
> request (i.e., qio) after splitting fits a single cluster.
> (In some cases it is worth to create bigger splits, and this
> is a subject of further optimizations).

Nak, please don't do that.  If you want finer grained processing use
a bio based driver, not a request based one.  This is just getting us
into tons of problems.
