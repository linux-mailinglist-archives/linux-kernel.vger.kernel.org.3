Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592314E2650
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347321AbiCUM36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347310AbiCUM3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:29:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8278AFF3;
        Mon, 21 Mar 2022 05:28:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2063F60FED;
        Mon, 21 Mar 2022 12:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EA3C340E8;
        Mon, 21 Mar 2022 12:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647865707;
        bh=QyTms11ucj43cfEyvyJ0ZYPiqCIc/hCJWYw+wpzEWLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bIU+fbv77ZEZh/dsWZVKjvsFysOuVFelPB5opGim2qvatZnSnkUmiuXFeYjDmz4sV
         ve0WLgMUxW7npSqzuVYKW09Bj5Y0rhv1NVNtrqwHr1GLRU0P6iBFos02oJey7L9sKz
         cHas+CVehPUy/2fhoJTFCcVgIS+GEeFxPaDTN6Ic=
Date:   Mon, 21 Mar 2022 13:28:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     hfreude <hfreude@imap.linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] s390/zcrypt: fix using the correct variable for sizeof()
Message-ID: <YjhvZ3cqNY4laXBu@kroah.com>
References: <20220319203528.2552869-1-jakobkoschel@gmail.com>
 <63552021dab7bcf6385526c6dd715e4f@imap.linux.ibm.com>
 <1A255D0D-F9E4-4155-933E-574442F3652E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1A255D0D-F9E4-4155-933E-574442F3652E@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 01:16:52PM +0100, Jakob Koschel wrote:
> 
> > On 21. Mar 2022, at 10:26, hfreude <hfreude@imap.linux.ibm.com> wrote:
> > 
> > On 2022-03-19 21:35, Jakob Koschel wrote:
> >> While the original code is valid, it is not the obvious choice for the
> >> sizeof() call and in preparation to limit the scope of the list iterator
> >> variable the sizeof should be changed to the size of the variable
> >> being allocated.
> >> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> >> ---
> >> drivers/s390/crypto/zcrypt_card.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >> diff --git a/drivers/s390/crypto/zcrypt_card.c
> >> b/drivers/s390/crypto/zcrypt_card.c
> >> index 3e259befd30a..fcbd537530e8 100644
> >> --- a/drivers/s390/crypto/zcrypt_card.c
> >> +++ b/drivers/s390/crypto/zcrypt_card.c
> >> @@ -90,7 +90,7 @@ static ssize_t online_store(struct device *dev,
> >> 	list_for_each_entry(zq, &zc->zqueues, list)
> >> 		maxzqs++;
> >> 	if (maxzqs > 0)
> >> -		zq_uelist = kcalloc(maxzqs + 1, sizeof(zq), GFP_ATOMIC);
> >> +		zq_uelist = kcalloc(maxzqs + 1, sizeof(*zq_uelist), GFP_ATOMIC);
> >> 	list_for_each_entry(zq, &zc->zqueues, list)
> >> 		if (zcrypt_queue_force_online(zq, online))
> >> 			if (zq_uelist) {
> >> base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
> >> --
> >> 2.25.1
> > Thanks Jakob, add my Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> > Which way is this patch going to be integrated into the kernel ?
> > Usually I pick this and push it into s390 and on the next merge window it will
> > get merged into Linus Torvalds kernel tree.
> > However, sounds like you are about to clean up the kernel in preparation for the
> > changes related to the double linked list api. So maybe you have a patch series
> > which will go into the kernel by another way ?
> > Waiting for an answer, Thanks
> > 
> 
> CC'd Greg KH (in case he has some input) but my assumption is that this just goes
> the normal way through your s390 tree. Most of this cleanup is not in a hurry so
> getting it into the next merge window should be fine.

Normal way is fine.

thanks,

greg k-h
