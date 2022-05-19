Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5EA52CD9A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiESHxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiESHxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:53:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0B133E10;
        Thu, 19 May 2022 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B5cpWiyJrfxegy/gbK51jPPmCM2K6U8g7xBnC+gR7Eo=; b=wWmHtvr1QI5IubVYr2IEWyQx/W
        xTqvr3iBM7g2LaRaYd/m/KmIBkGdRJFZ8MWFPTL0Zfh6IvbXez/l9+fbFZzqovxUAU0qIQyRh6lpS
        GdWBQi60V1zGv80MeCAUP+mlMClhnhsh9d4gzXSeYMJ/u9woTHvWmBPYZDDHtXKQ54hZ+hrNHG52l
        /eDiWBDN+LYCNZCWshOZ9ExodIpC/jQVn2hqXXfVpSQMD+SueXQuvxnwGtDl8Ai9BHHFzD5l38HBt
        d+vgKm8212Y5qoGfKdU3wrFQuy5Q0sbC5v3DIRvv45V1ZxpJKN67x9yfaY5J1jftSC3fm4TfJTs9s
        8PhUtVkQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrayP-005eWM-68; Thu, 19 May 2022 07:53:29 +0000
Date:   Thu, 19 May 2022 00:53:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: fix incorrect blk_status_t casts
Message-ID: <YoX3ebAlPIcFMpKn@infradead.org>
References: <YoH0/2FBC2YS9kk5@infradead.org>
 <55475ea9-5f6c-fa19-b52d-93fb89209850@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55475ea9-5f6c-fa19-b52d-93fb89209850@openvz.org>
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

Still a whole lot of casts.  Take a look at my "cleanup blk_execute_rq*"
for how think we can solve this in a much nicer way.
