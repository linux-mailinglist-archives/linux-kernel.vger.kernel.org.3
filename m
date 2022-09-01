Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0355A8F4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiIAHHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiIAHGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A48E120334
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662015979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eeBUu9nEhT4Kc4CwsZdP2lrb/xjOrC7tj07BpY9X5O8=;
        b=EATUQ3E4DoZl7J6tJivXQUEpa0kea3pdhJAC2cpdd0lXyhiWK1Lv+6Y6/O7IVo7e5GpmdP
        nh9Mi6tMsTP+n0N4dJ49V5nekDHrTlLuJsqYJDyrl7l6Kqpx+oLoYPOCvdGcUXYTLXVhS5
        odivWudvfTx0J56m7rYWxMMnCceiBpQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-2PaaNq9yOrG3TBDajA1iqw-1; Thu, 01 Sep 2022 03:06:15 -0400
X-MC-Unique: 2PaaNq9yOrG3TBDajA1iqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDC8485A58A;
        Thu,  1 Sep 2022 07:06:14 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AE802026D4C;
        Thu,  1 Sep 2022 07:06:09 +0000 (UTC)
Date:   Thu, 1 Sep 2022 15:06:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dusty Mabe <dusty@dustymabe.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de,
        linux-raid@vger.kernel.org
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Message-ID: <YxBZ4BBjxvAkvI2A@T590>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dusty,

On Fri, Aug 26, 2022 at 12:15:22PM -0400, Dusty Mabe wrote:
> Hey All,
> 
> I think I've found a regression introduced by:
> 
> a09b314 o block: freeze the queue earlier in del_gendisk
> 
> In Fedora CoreOS we have tests that set up RAID1 on the /boot/ and /root/ partitions
> and then subsequently removes one of the disks to simulate a failure. Sometime recently

Do you have test case which doesn't need raid1 over /boot or /root? such
as by create raid1 over two disks, then mount & remove one of device, ...

It isn't easy to setup/observe such test case and observe what is wrong.

> this test started timing out occasionally. Looking a bit closer it appears instances are
> getting stuck during reboot with a bunch of looping messages:
> 
> ```
> [   17.978854] block device autoloading is deprecated and will be removed.
> [   17.982555] block device autoloading is deprecated and will be removed.
> [   17.985537] block device autoloading is deprecated and will be removed.
> [   17.987546] block device autoloading is deprecated and will be removed.
> [   17.989540] block device autoloading is deprecated and will be removed.
> [   17.991547] block device autoloading is deprecated and will be removed.
> [   17.993555] block device autoloading is deprecated and will be removed.
> [   17.995539] block device autoloading is deprecated and will be removed.
> [   17.997577] block device autoloading is deprecated and will be removed.
> [   17.999544] block device autoloading is deprecated and will be removed.
> [   22.979465] blkdev_get_no_open: 1666 callbacks suppressed
> ...
> ...
> ...
> [  618.221270] blkdev_get_no_open: 1664 callbacks suppressed
> [  618.221273] block device autoloading is deprecated and will be removed.
> [  618.224274] block device autoloading is deprecated and will be removed.
> [  618.227267] block device autoloading is deprecated and will be removed.
> [  618.229274] block device autoloading is deprecated and will be removed.
> [  618.231277] block device autoloading is deprecated and will be removed.
> [  618.233277] block device autoloading is deprecated and will be removed.
> [  618.235282] block device autoloading is deprecated and will be removed.
> [  618.237370] block device autoloading is deprecated and will be removed.
> [  618.239356] block device autoloading is deprecated and will be removed.
> [  618.241290] block device autoloading is deprecated and will be removed.
> ```
> 
> Using the Fedora kernels I narrowed it down to being introduced between 
> `kernel-5.19.0-0.rc3.27.fc37` (good) and `kernel-5.19.0-0.rc4.33.fc37` (bad).
> 
> I then did a bisect and found:
> 
> ```
> $ git bisect bad
> a09b314005f3a0956ebf56e01b3b80339df577cc is the first bad commit
> commit a09b314005f3a0956ebf56e01b3b80339df577cc
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Tue Jun 14 09:48:27 2022 +0200
> 
>     block: freeze the queue earlier in del_gendisk

It is a bit hard to associate the above commit with reported issue.


Thanks,
Ming

