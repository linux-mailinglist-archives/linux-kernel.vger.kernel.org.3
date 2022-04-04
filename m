Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49184F1E54
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382686AbiDDWJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379078AbiDDQ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34A543464D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649089641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P7hJ01+Z8CTQmsHFJdXv1elOc2Pqcj7fQA/ZIutEB5E=;
        b=i0TTI0Sv3Gi0njaigApTcHR/tyQK4TjtuSbfUu4IrmjpvdBtEtt2WRmeBriThyMaLnVBLZ
        EyYEIrp4SFmwmYmbAP40186KULcGFSrhUJp9vglfjc9Z02eVud7zH1Zm93rjVQ68ggQ8VF
        5tqkja9eIYQLAUClUfoLEMwbe+7lyFk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-2SdOY_9iM-WuCDXvykkonw-1; Mon, 04 Apr 2022 12:27:20 -0400
X-MC-Unique: 2SdOY_9iM-WuCDXvykkonw-1
Received: by mail-wr1-f71.google.com with SMTP id j67-20020adf9149000000b00203e6b7d151so1907942wrj.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 09:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P7hJ01+Z8CTQmsHFJdXv1elOc2Pqcj7fQA/ZIutEB5E=;
        b=V7MZSJkP7GrpOEBbAD+ogvq/3U4PzUyGGr1Jlh9N1EnIAODIFqkiFuhq8m4+gAIH1A
         lcvqJhAWBICubR0fmimuFRcZ2iODeBZj9qlhGIyvNLw8MamAZOk2CB/9zadz7FOEsPD7
         nzekuqTfnnEI6c8uIbkqJ1tHzzHlDx+lkejgfVsQeYw6Asf9y8CEpOunbazEO6EPOhj3
         oS4vhLujdPG/WTZXKAUltnsNeG138iGnjnD9cWnM7AJ+aFZFnkftdMs4U3R1EIYVOvsa
         AaLRc87Fq6PRmLlv2zkaOyp4lHV/quFpjgMRxtB4e8MAaNCzR3PHH9Yy3dSn3LYER+zr
         /piw==
X-Gm-Message-State: AOAM531Cp65SbxmjPvEgI96zUsNaOBG1HqC/nCONLnKYlUpWJbUpvEwg
        +8KZI98U+NcCQdx45G7I1ImvMbPT3rwj51KJz8ismmY0Hbq6ZxtGpaixwAP46kCOTM/wIZdrAXG
        Brx2bEOzsRAwPCsofbfPogWdR
X-Received: by 2002:adf:c10b:0:b0:1ed:c40f:7f91 with SMTP id r11-20020adfc10b000000b001edc40f7f91mr432724wre.276.1649089639382;
        Mon, 04 Apr 2022 09:27:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuDmOwegjvGJFl7L9LJ7bym2qL/D7kmZ5IhcobdoiPO6Grj58r50Xw6ksaa9Y+iOv1AFo58Q==
X-Received: by 2002:adf:c10b:0:b0:1ed:c40f:7f91 with SMTP id r11-20020adfc10b000000b001edc40f7f91mr432713wre.276.1649089639209;
        Mon, 04 Apr 2022 09:27:19 -0700 (PDT)
Received: from redhat.com ([2.52.17.211])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm26246102wmb.36.2022.04.04.09.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 09:27:18 -0700 (PDT)
Date:   Mon, 4 Apr 2022 12:27:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio_ring: add unlikely annotation for free descs
 check
Message-ID: <20220404122707-mutt-send-email-mst@kernel.org>
References: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
 <20220328105817.1028065-2-xianting.tian@linux.alibaba.com>
 <20220329075024.eoajm5ufrcfytug4@sgarzare-redhat>
 <073dc28b-1707-cd04-daba-13aa4fac5a85@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <073dc28b-1707-cd04-daba-13aa4fac5a85@linux.alibaba.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 11:11:16PM +0800, Xianting Tian wrote:
> I can't find it in next branch, will you apply this patch?

yes, thanks!

