Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A14471F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 04:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhLMDX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 22:23:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhLMDX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 22:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639365807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2skDNVKo25BiMyqDlfguThb2xQemx2Ye13yt8UEzpJ0=;
        b=TkXnBUymCSYi/dP/O//OBEfIZPo3uhAzVyKxut7TWv1LrR3mpqnDsAmrrUhrRsZqtzy+89
        qmoEnWFu6GJ4exHMAoAuw2uxVtiIGGt1bEcUVZ+xhEtU4zMnvaYVekdc4COfOitEibSE1M
        v4vpYIpMnO2SsI+cWCsfNFXTed2vNZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-z2hyQz-JPIuS77Xbp7IOZw-1; Sun, 12 Dec 2021 22:23:22 -0500
X-MC-Unique: z2hyQz-JPIuS77Xbp7IOZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94621801B35;
        Mon, 13 Dec 2021 03:23:20 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 634D54ABA9;
        Mon, 13 Dec 2021 03:23:12 +0000 (UTC)
Date:   Mon, 13 Dec 2021 11:23:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Jens Axboe <axboe@kernel.dk>, 'Christoph Hellwig' <hch@lst.de>,
        "'linux-block@vger.kernel.org'" <linux-block@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Random high CPU utilization in blk-mq with the none scheduler
Message-ID: <Yba8nL4x9R6rmTYL@T590>
References: <BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com>
 <BYAPR21MB1270DCE17A0FE017AF3272F1BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <b80bfe9a-bece-1f32-3d2a-fb4d94b1fa8c@kernel.dk>
 <BYAPR21MB1270B5DAD526C42C070ECB9EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1270B5DAD526C42C070ECB9EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dexuan,

On Sat, Dec 11, 2021 at 03:10:43AM +0000, Dexuan Cui wrote:
> > From: Jens Axboe <axboe@kernel.dk>
> > Sent: Friday, December 10, 2021 6:05 PM
> > ...
> > It's more likely the real fix is avoiding the repeated plug list scan,
> > which I guess makes sense. That is this commit:
> > 
> > commit d38a9c04c0d5637a828269dccb9703d42d40d42b
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Thu Oct 14 07:24:07 2021 -0600
> > 
> >     block: only check previous entry for plug merge attempt
> > 
> > If that's the case, try 5.15.x again and do:
> > 
> > echo 2 > /sys/block/<dev>/queue/nomerges
> > 
> > for each drive you are using in the IO test, and see if that gets
> > rid of the excess CPU usage.
> > 
> > --
> > Jens Axboe
> 
> Thanks for the reply! Unluckily this does not work.
> 
> I tried the below command:
> 
> for i in `ls /sys/block/*/queue/nomerges`; do echo 2 > $i; done
> 
> and verified that the "nomerges" are changed to "2", but the
> excess CPU usage can still reproduce easily.

Can you provide the following blk-mq debugfs log?

(cd /sys/kernel/debug/block/dm-N && find . -type f -exec grep -aH . {} \;)

(cd /sys/kernel/debug/block/sdN && find . -type f -exec grep -aH . {} \;)

And it is enough to just collect log from one dm-mpath & one underlying iscsi disk,
so we can understand basic blk-mq setting, such as nr_hw_queues, queue depths, ...



Thanks,
Ming

