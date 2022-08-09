Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ECD58D77F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242564AbiHIKfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242476AbiHIKfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E82121827
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660041331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YeZmWlJ57t/EqWJ2923+U6CuKUM3PGmeDKKJtSlBlkw=;
        b=M6KMel1DlIENY7/QnWM2fhj7SE2Qkh3bXhzJ3L2p+6SfhrhIUjdW6j200gfUZ+2nCLDuEH
        30+vDe4AabZGbsjSpiU6Pu9yrKFsB83+p44R2a90jH1D6N2gCg0t59+dN5q0WLB6lFM+it
        Wicdrd4Y/93R1Mpy0q3E24f3Twz3ZOk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-gL_V-U-1PGWUpjD-M0vfFg-1; Tue, 09 Aug 2022 06:35:30 -0400
X-MC-Unique: gL_V-U-1PGWUpjD-M0vfFg-1
Received: by mail-wm1-f70.google.com with SMTP id i6-20020a1c3b06000000b003a537064611so904299wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 03:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YeZmWlJ57t/EqWJ2923+U6CuKUM3PGmeDKKJtSlBlkw=;
        b=haojQH2YWCnTnSVCMl8N85pppeHZvea9etw08AXrT/bQJEM20gnjnXMbpgX3XszNxf
         aMVXnDugec1b3rx4ogRYWEsELO+r1F61yDcXV2rkH1gFHEpFodfoA9zRI4TGWDl7IDlz
         rQTd/LauKTXl+1SM4HOzg81zaKhvX49vsdZhGPESDMkzCIZczJt5FY1nMS/LlVei2ekx
         gQWcl/0iJorcQWlAkjTuSJaYoy6U5CCcvVenfOm62wcsRzD4UnmAM3JN15gVnkLFSS8l
         OrHfWplzbZW0Q4tdkVagd5FTXE/5DxS3dgX7zI3xr71GxUb+yNUEJtImSkxTItC8jO5A
         uo/w==
X-Gm-Message-State: ACgBeo3yihPo8fYjtoXU/egjA/KszYMfGFqo0LNpPv+BAQP7cuKNWOx4
        u2bWB6fAxB1unnUkfHa4RR+8Ypir2w24YVCylYoetMZuGsF4C7CZYuxjGhiahoyw/kLaF8DeNdg
        RDB0se4u/fLJ8qkVzwrvUhcEz
X-Received: by 2002:adf:f346:0:b0:21f:13ec:cacf with SMTP id e6-20020adff346000000b0021f13eccacfmr13580125wrp.525.1660041329265;
        Tue, 09 Aug 2022 03:35:29 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5yD3fjmdk8FR8LY7ZeN/oQbXPL4+j7fn+/YDf5jFwCIuY7SkUglVYGH0jzof0I4LcXb2HSWQ==
X-Received: by 2002:adf:f346:0:b0:21f:13ec:cacf with SMTP id e6-20020adff346000000b0021f13eccacfmr13580110wrp.525.1660041329068;
        Tue, 09 Aug 2022 03:35:29 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id az25-20020a05600c601900b003a35516ccc3sm16299278wmb.26.2022.08.09.03.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 03:35:28 -0700 (PDT)
Date:   Tue, 9 Aug 2022 06:35:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kernel@openvz.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Create debugfs file with virtio balloon usage
 information
Message-ID: <20220809063414-mutt-send-email-mst@kernel.org>
References: <20220705083638.29669-1-alexander.atanasov@virtuozzo.com>
 <20220705045912-mutt-send-email-mst@kernel.org>
 <f6b46a29-0f65-9081-5228-a1028fea2bef@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6b46a29-0f65-9081-5228-a1028fea2bef@virtuozzo.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:01:58PM +0300, Alexander Atanasov wrote:
> > > diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> > > index ddaa45e723c4..f3ff7c4e5884 100644
> > > --- a/include/uapi/linux/virtio_balloon.h
> > > +++ b/include/uapi/linux/virtio_balloon.h
> > > @@ -40,6 +40,7 @@
> > >   /* Size of a PFN in the balloon interface. */
> > >   #define VIRTIO_BALLOON_PFN_SHIFT 12
> > > +#define VIRTIO_BALLOON_PAGE_SIZE (1<<VIRTIO_BALLOON_PFN_SHIFT)
> > >   #define VIRTIO_BALLOON_CMD_ID_STOP	0
> > >   #define VIRTIO_BALLOON_CMD_ID_DONE	1
> > Did you run checkpatch on this?
> 
> 
> Sure, i did:
> 
> scripts/checkpatch.pl
> ../outgoing/v4-0001-Create-debugfs-file-with-virtio-balloon-usage-inf.patch
> total: 0 errors, 0 warnings, 108 lines checked
> 
> ../outgoing/v4-0001-Create-debugfs-file-with-virtio-balloon-usage-inf.patch
> has no obvious style problems and is ready for submission.

Weird. There should be spaces around << I think.

-- 
MST

