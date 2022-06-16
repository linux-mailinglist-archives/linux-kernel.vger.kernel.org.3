Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F28454E6A1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377101AbiFPQFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiFPQFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:05:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD04F30578;
        Thu, 16 Jun 2022 09:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=bewGKNu60ce93OglEfrUE0YxII8yhxsWSngVzrxtmZs=; b=Bfso75brsL0PA8G7DnzukMeP40
        /k+2S7PXG0068vdmUqDgKC6b+bor9SV8jqrAqw7PTXorXgvlX9/y/QozRebL3mcu7GCWaXDNlaTUY
        LzQoK/SPHMuX44AcvuR3yhhpVfMWo/ihIRRZhNGz9W72t5VRwo/e56RY1z+maT4idrsbwxP6883CZ
        LDCMgofIdu6HZUrFHQoN1HUj+9F6GhnaEQeNXmx1Jbv6JGn3i1GuIvJTxcDOUht+f5Dwncy0s5QcL
        qdI03X0OuDFY14icokQPlRCQNOdwM5EceFHgw2uMoiryw8MpJfzfKJnRpfKzjmLQzKR+TFPu+xDaM
        uCTmBY+g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1rzE-003Jg0-9g; Thu, 16 Jun 2022 16:04:48 +0000
Date:   Thu, 16 Jun 2022 09:04:48 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, hch@lst.de,
        snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk, pankydev8@gmail.com, gost.dev@samsung.com,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        Johannes.Thumshirn@wdc.com, dsterba@suse.com, jaegeuk@kernel.org
Subject: Re: [dm-devel] [PATCH v7 02/13] block: allow blk-zoned devices to
 have non-power-of-2 zone size
Message-ID: <YqtUoK4KzvG7NQS0@bombadil.infradead.org>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615101931eucas1p15ed09ae433a2c378b599e9086130d8eb@eucas1p1.samsung.com>
 <20220615101920.329421-3-p.raghav@samsung.com>
 <857c444a-02b9-9cef-0c5b-2ecdb2fd46f6@acm.org>
 <e04db101-5628-2a1d-6b5c-997090484d7d@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e04db101-5628-2a1d-6b5c-997090484d7d@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 12:09:35PM +0200, Pankaj Raghav wrote:
> On 2022-06-15 22:28, Bart Van Assche wrote:
> >> +        if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
> >> +            pr_warn("%s: Invalid zone capacity for non power of 2
> >> zone size",
> >> +                disk->disk_name);
> >>               return -ENODEV;
> >>           }
> > 
> > The above check seems wrong to me. I don't see why devices that report a
> > capacity that is less than the zone size should be rejected.
> > 
> This was brought up by Damien during previous reviews. The argument was
> that the reason to allow non power-of-2 zoned device is to remove the
> gaps between zone size and zone capacity. Allowing a npo2 zone size with
> a different capacity, even though it is technically possible, it does
> not make any practical sense. That is why this check was introduced.
> Does that answer your question?

Perhaps just add a comment because unless you are involved in the prior
reviews this might not be clear.

  Luis
