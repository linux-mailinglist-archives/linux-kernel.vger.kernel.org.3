Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFA94D267B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiCICuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 21:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiCICuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 21:50:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 285ED10F20F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 18:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646794150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o8jU4yOIWdVZnRNPr5i6wj8UDPPcKoM8kOoyqL1we7c=;
        b=ejZCGsEQDYyhMyeNyDoyCmCeIimDBBTJaWaFEr23YFKzvfP/ZvsfRSXPR19j+V7MazjDtU
        tX9Ujg3+I8JLIyJQorNcli4rbYvO+R5Y2wW4T+X1jp0+4VWP+czChVnCB2ovkhBNryggHp
        YZgwKdUJIO8YUYm1jPNN3y2MpeW/SXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515--C-j4-_eMUyfzWzRgWWKFw-1; Tue, 08 Mar 2022 21:49:07 -0500
X-MC-Unique: -C-j4-_eMUyfzWzRgWWKFw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 900661854E21;
        Wed,  9 Mar 2022 02:49:05 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF914305B6;
        Wed,  9 Mar 2022 02:48:39 +0000 (UTC)
Date:   Wed, 9 Mar 2022 10:48:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Maurizio Lombardi <mlombard@redhat.com>,
        linux-nvme@lists.infradead.org, axboe@fb.com,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Ming Lei <minlei@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: nvme-host: disk corruptions when issuing IDENTIFY commands via
 ioctl()
Message-ID: <YigVg/URukuwwKWF@T590>
References: <CAFL455n1WaRxZuqCeQGWt1MVDnK8uUytUsAUVEUV9-LLQYv9gQ@mail.gmail.com>
 <20220308195238.GC3501708@dhcp-10-100-145-180.wdc.com>
 <YifyZ9MoUws/7esK@T590>
 <20220309003904.GA3948780@dhcp-10-100-145-180.wdc.com>
 <Yif8svaBscrL9WZk@T590>
 <20220309011429.GA3948855@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309011429.GA3948855@dhcp-10-100-145-180.wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 05:14:29PM -0800, Keith Busch wrote:
> On Wed, Mar 09, 2022 at 09:02:42AM +0800, Ming Lei wrote:
> > On Tue, Mar 08, 2022 at 04:39:04PM -0800, Keith Busch wrote:
> > > On Wed, Mar 09, 2022 at 08:18:47AM +0800, Ming Lei wrote:
> > > > Given NVMe spec states that data length of IDENTIFY command should be
> > > > 4096bytes, and PRP list can't be used. 
> > > > 
> > > > So looks nvme driver need to validate the command before submitting to
> > > > hardware, otherwise any buggy application can break FS or memory easily.
> > > 
> > > No way. The driver does not police the user passthrough interface for
> > > these kinds of things.
> > 
> > So you trust application to provide correct data always?
> >
> > From user viewpoint, this defect provides one easy hole to break FS or
> > memory, it is one serious issue, IMO. The FS/memory corruption can
> > be reproduced easily even in VM.
> 
> It doesn't seem so serious considering it's been this way for 10 years,
> and we already knew about this. It's even been reported before:
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2013-August/000365.html

BTW, this issue is actually one real report from one Red Hat Customer.

> 
> > > It couldn't ever be complete or future proof if
> > > it did.
> > 
> > But the spec states clearly the data length of IDENTIFY command is 4096
> > and PRP list can't be used, so why do you think it isn't complete or
> > future proof to validate data length of IDENTIFY in nvme driver?
> 
> The current spec says that opcode uses 4k today. What about some time in
> the future?

spec change should only be applied on future hardware, which can not break
current in-market hardware.

nvme target has validated the Identify's transfer length already.

> And why are you focusing on Identify anyway?

Nvme spec states explicitly that the following 4 commands can't use PRP list:

- Identify command
- Namespace Attachment command
- Namespace Management command
- Set Features command

So it should be enough to just validate these commands.

Thanks, 
Ming

