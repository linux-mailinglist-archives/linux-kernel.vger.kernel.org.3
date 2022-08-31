Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DCC5A899F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiHaXxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHaXxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:53:35 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35A7F14F0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=LTD4vkKdl/8JE62fAvhqroKwZk3JK69BSlVKTdGE7uU=; b=TwMHM0ixt8oG9zUIGNVqBosx/V
        11RMsBEDlRZk8wO/YA8ft3p3oyQ5BtMLXZsH6B+qhlXGjP9gqSCuUyKBfl8miaYnz7jNTC53lOSfL
        R1v/qHOzd0LweNYk+o1kzFDCQhQEn2H6F3psASXuxMwgC0AqcDph5UoDxEAIQpetk1NeczLI2V+b/
        hNTYFZbEjRfk0/Km3ag91r/4+hh8hW9Ad27e7wxknkcGjOZn+5frSe+fQR4yZCMJqqv4FhzI49rJb
        218F1rr8c18xejO47H+Ti+T/12EA5n2GJKoGx6NF6vOKc4JM8pGmMY/0339mv3hYTg/Q7c0SJLxU6
        1vw00s0w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oTXWL-00Amej-9y;
        Wed, 31 Aug 2022 23:53:21 +0000
Date:   Thu, 1 Sep 2022 00:53:21 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        James Smart <james.smart@broadcom.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Venkataramanan Anirudh <anirudh.venkataramanan@intel.com>,
        linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v2] nvmet-tcp: Don't map pages which can't come from
 HIGHMEM
Message-ID: <Yw/0cZFCQQpx3hhZ@ZenIV>
References: <20220830220533.17777-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830220533.17777-1-fmdefrancesco@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 12:05:33AM +0200, Fabio M. De Francesco wrote:
> kmap() is being deprecated in favor of kmap_local_page().[1]
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> The pages which will be mapped are allocated in nvmet_tcp_map_data(),
> using the GFP_KERNEL flag. This assures that they cannot come from
> HIGHMEM. This imply that a straight page_address() can replace the kmap()
> of sg_page(sg) in nvmet_tcp_map_pdu_iovec(). As a side effect, we might
> also delete the field "nr_mapped" from struct "nvmet_tcp_cmd" because,
> after removing the kmap() calls, there would be no longer any need of it.
> 
> In addition, there is no reason to use a kvec for the command receive
> data buffers iovec, use a bio_vec instead and let iov_iter handle the
> buffer mapping and data copy.
> 
> Test with blktests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> HIGHMEM64GB enabled.

Looks sane...
