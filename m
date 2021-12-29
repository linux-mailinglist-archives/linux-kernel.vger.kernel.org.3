Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9604815DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 18:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbhL2Rf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 12:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbhL2Rfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 12:35:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D8AC061574;
        Wed, 29 Dec 2021 09:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8upZYbBQJptXDs6sEu9pcLyNTYjynBlYbcVuzKtbkL0=; b=izkEcKST5rHTQh2/36t6bEb6rc
        SoTIoDugwKTY/RcaVs+8hPCe8FiMyMSINUFh81CYhnxGIwfgIHkgQuo2B3xn5Gl2vwMROS5kAUdIh
        dgNbb4D6yvxyybHt29dTNFHp+oykssLHccVSuzmHMPPhBvpkqJhXrJSw8yw9lnskZPIr1Fp0K0Zee
        9tTN8/ncH2ogdlkyXKOQNjEnT4qwo0RSl9LjN/igFWuC7WtZzu3hH/Kdw77n2VRorP8yEY436jdM1
        O65/7FS3mBquGuFXHq4PQMSvaiQLTB7lLl1hqytJYNIPLUUpafD4XyNUh1hiV+uArT6X2C1Kc0Y0p
        Cpq9x1Dw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n2crd-003CVV-NS; Wed, 29 Dec 2021 17:35:49 +0000
Date:   Wed, 29 Dec 2021 09:35:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, bvanassche@acm.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nbd: Don't use workqueue to handle recv work
Message-ID: <Ycycda8w/zHWGw9c@infradead.org>
References: <20211227091241.103-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227091241.103-1-xieyongji@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 05:12:41PM +0800, Xie Yongji wrote:
> The rescuer thread might take over the works queued on
> the workqueue when the worker thread creation timed out.
> If this happens, we have no chance to create multiple
> recv threads which causes I/O hung on this nbd device.

If a workqueue is used there aren't really 'receive threads'.
What is the deadlock here?
