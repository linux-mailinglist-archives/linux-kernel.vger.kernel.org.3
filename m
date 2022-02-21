Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9574BE515
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355910AbiBULOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:14:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355666AbiBULNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:13:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40C552898A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645440535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E5Bnpr0CZ7QRxn2UIVJ9sz4gWvkJfCXyHgAr6HeDYek=;
        b=gaLzv3B9ipLxLlgKeLTf/c7eNJ/zA4CiaCwZY+2FMkZ8HemiQwUvyj/q41gBN4ZWGTFcLk
        N7f7DUR3xneD6w6r6AwUXcSbQuLuusgngVPyfIvDoBdyGFxDAyLcEa6vNfF/gcRcBWrSxX
        vmJ9PncoW0DlwHQ5dmzq6V4QMR0BRGE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-s1ubP1dFOmuzBwVBg9CKGA-1; Mon, 21 Feb 2022 05:48:54 -0500
X-MC-Unique: s1ubP1dFOmuzBwVBg9CKGA-1
Received: by mail-ed1-f71.google.com with SMTP id j9-20020a056402238900b004128085d906so9017636eda.19
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E5Bnpr0CZ7QRxn2UIVJ9sz4gWvkJfCXyHgAr6HeDYek=;
        b=5QFrDraDpxPBHkBSoDJAfpdSfOyyVL+/duh/bF/iyIZ5xifJRBmq4TTgUM7GBp35CX
         /HHPzJlfuzViDiY6ITeOhHKf92axqk4M3z8WwVDwTuPSJMdTPwkRMQWvDV25DUrFbWLO
         abut/nUgPiVxoimR3M5+SvuUzrT8SQ/zwvUPrHDv8GDNnCT75FFE0dMFD/nmjT03ilER
         5s+Kvdnhl2pV0iFHERZA4+9dPHkvE9mj6lhGRWnq2X72B2PWKFFCsSPp69WKOwSlFHyK
         7DMB4IJNh/qYJ32UK7QPxz6Y4ytHtU45CCEyC6D/mRAaeW93v470z4MHrxShT36IEaRb
         fy6g==
X-Gm-Message-State: AOAM532miDVv/f2A5+Pv3fDp6PJ5AqJg36vr2sH6/rvbbKG+UPVs3BDY
        0U6Sux+DhfbexTBAksFE6v8wQBRMb0LmsXJ8g3nGwRNqt80tGxtv9R1O+XsGg19I8egPu0iJxOA
        LVKKqV14iUtbQJosVCTGNQoSx
X-Received: by 2002:a17:906:cc12:b0:6b5:ec8f:fdf2 with SMTP id ml18-20020a170906cc1200b006b5ec8ffdf2mr15032196ejb.579.1645440532765;
        Mon, 21 Feb 2022 02:48:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpj9WO3rLWndsSMkC1v/vS7IEXzs8HD9yPCKyRHc/HhLseaMTjw47C5DmwxS9HU1Hb1qcGig==
X-Received: by 2002:a17:906:cc12:b0:6b5:ec8f:fdf2 with SMTP id ml18-20020a170906cc1200b006b5ec8ffdf2mr15032178ejb.579.1645440532507;
        Mon, 21 Feb 2022 02:48:52 -0800 (PST)
Received: from redhat.com ([2.52.4.205])
        by smtp.gmail.com with ESMTPSA id u27sm5012362ejc.220.2022.02.21.02.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 02:48:51 -0800 (PST)
Date:   Mon, 21 Feb 2022 05:48:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
Message-ID: <20220221054618-mutt-send-email-mst@kernel.org>
References: <20220221040745.1177-1-hdanton@sina.com>
 <20220221085227.1356-1-hdanton@sina.com>
 <20220221101538.1415-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221101538.1415-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 06:15:38PM +0800, Hillf Danton wrote:
> On Mon, 21 Feb 2022 04:17:02 -0500 Michael S. Tsirkin wrote:
> > On Mon, Feb 21, 2022 at 04:52:27PM +0800, Hillf Danton wrote:
> > > Another round of attempts to quiesce the
> > > WARNING: CPU: 1 PID: 4069 at drivers/vhost/vhost.c:715 after the
> > > BUG at drivers/vhost/vhost.c:2337 went home.
> > 
> > Could you pls clarify what do you mean by "went home" here?
> 
> The reproducer failed to trigger it.
> 
> Hillf

You mean this patch?

@@ -2207,7 +2209,10 @@ int vhost_get_vq_desc(struct vhost_virtq
        __virtio16 avail_idx;
        __virtio16 ring_head;
        int ret, access;
+       bool was_set = !!(vq->used_flags & VRING_USED_F_NO_NOTIFY);

+       if (!was_set)
+               return -EINVAL;
        /* Check it isn't doing very strange things with descriptor numbers. */
        last_avail_idx = vq->last_avail_idx;


However, I do not understand how do we enter vhost_get_vq_desc
with vq->used_flags & VRING_USED_F_NO_NOTIFY being clear.
Do you?

