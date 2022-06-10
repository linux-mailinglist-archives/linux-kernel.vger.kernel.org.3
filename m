Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85877545E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347214AbiFJINw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbiFJINs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:13:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7634824581;
        Fri, 10 Jun 2022 01:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=mfo6gnsnKvWPQGI70J9oynwrmqtAtRBKV8BUH0Vequw=; b=UAWAcU1Hf8sZPfCD2b0J+jM0T1
        SaY3iiJSWUskfoWLJErOAFaf/RbRu6QlXlTfzyI2008+Gu8NDj3h8mK0/+mGBrjIkGrMSQD9qIuax
        8SndR03P0qOaNNa2XDK933lJEznT7iDReE70hHPDQ9fldQ3pZrlBW+o09FeAqkwWav7iKNvflV/Zo
        zL6Y9wtXQE/qOrQGevqith5HqKckyowtWuN+Cc2L+cdtYs4M74BVP9pDbm0beMbsTF3dyZ70AfgkR
        qxkDLuvTTqGTgB9Sl7cJ0lKmjr80/ftESHV1RGrUxVIen+/aUjXLsyQj+3kZ/4dQSorg/3VJKdv/E
        YV7fz0cw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzZm6-006hyG-A7; Fri, 10 Jun 2022 08:13:46 +0000
Date:   Fri, 10 Jun 2022 01:13:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sun Feng <loyou85@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix attribute_group lost if set before add_disk
Message-ID: <YqL9Ou+UlweAH/Me@infradead.org>
References: <1654845389-21741-1-git-send-email-loyou85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1654845389-21741-1-git-send-email-loyou85@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 03:16:29PM +0800, Sun Feng wrote:
> after commit 52b85909f85d("block: fold register_disk into device_add_disk")
> when set attribute_group with following code:
> 
>   disk_to_dev(disk)->groups = attr_groups;
>   err = add_disk(disk);
> 
> disk_to_dev(disk)->groups will set to NULL in device_add_disk,
> 
>   static inline int __must_check add_disk(struct gendisk *disk)
>   {
>        	return device_add_disk(NULL, disk, NULL);
>   }
>   int __must_check device_add_disk(struct device *parent, ...
>                                  const struct attribute_group **groups)
>   {
> 	…
> 	ddev->groups = groups
> 
> and it will lose attribute group set.

Well, your are not supposed to set the attribute group yourself, but
instead pass it to device_add_disk.
