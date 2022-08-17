Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC175970E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiHQOTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiHQOTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:19:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B6558B4B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:19:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAC33B81DB8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7256C433D6;
        Wed, 17 Aug 2022 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660745937;
        bh=F30WPjdHzZcjMxtCTa9eRPGzNte6mq2vkatly6/A0F0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AS9pB+9iZMoAiXwHeC7lPiXOdX5O6DD13HMJhOj8i7xKWikjFTDjc9Z6kmSlxtRmM
         3QNrHNRrMmmpAGYMCwEsMIvn4jcijYOmDZbPs+q68UfMUjmcxvzy7EzkviEerZ9MZk
         kUNYrWED0PgAJ6kYtLUODi8ztEtLvMLIZVfSW+bg4fR/XltX2KYOkjAL5+yB/2bJ9Z
         gnRWS/lOMaS3OylkE0xSwJQSlVywoTXchl4aO+YDwb8ENnkZs4DIxbpoI5AibMau8o
         JRrM+z0bYp6UIejEhRL6ZMmia9kikjBV28WlQqOGEBlDsObzOtLmAyqAblyz3bu+S3
         D3E84XBpQJQ9g==
Date:   Wed, 17 Aug 2022 08:18:54 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Message-ID: <Yvz4zquwplVKwwXK@kbusch-mbp.dhcp.thefacebook.com>
References: <20220816091808.23236-1-fmdefrancesco@gmail.com>
 <YvvpJbOT9iv6rnm2@kbusch-mbp.dhcp.thefacebook.com>
 <c11e62ae-3439-e3e3-adba-d7f5f951791c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c11e62ae-3439-e3e3-adba-d7f5f951791c@grimberg.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:44:09PM +0300, Sagi Grimberg wrote:
> 
> > You should also remove the cmd's 'nr_mapped' field while you're at it,
> > otherwise you'll hit the WARN in nvmet_tcp_free_cmd_buffers().
> 
> Not remove nr_mapped because we use it to know the iovec entries, but
> we can just remove the WARN statement.

It's only used locally within nvmet_tcp_map_pdu_iovec() after this change, so
no need to carry it in struct nvmet_tcp_cmd anymore.
