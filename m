Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443E4535ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350981AbiE0K5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242359AbiE0K5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A8441059E4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653649058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/W1rjmpFLa1v2RHMPVw1HSemGhVAnYnW7IDz+nVRvU=;
        b=dOqQytcRWagiQX7alGKqfLg9DGB335er+jyv2wAQTzao8LNvh1VGFrzeLUexm3u5PYZ6H+
        p6TjRMZ4Tip3zkpD0zvoLOhYgv1dYz5hYOdkoqAnEbcGN3lUqt6vRlNaxxzI09xupp4py+
        GrfSeOiS22lGa0YPEnLwySib35s1qE4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-jSclqcxJNDW64hEep1fi1Q-1; Fri, 27 May 2022 06:57:37 -0400
X-MC-Unique: jSclqcxJNDW64hEep1fi1Q-1
Received: by mail-ed1-f69.google.com with SMTP id e3-20020a056402330300b0042b903637bbso2822999eda.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w/W1rjmpFLa1v2RHMPVw1HSemGhVAnYnW7IDz+nVRvU=;
        b=zrx4zUg2v0uMAahcrihVJAU5FFfgF/gKulxzExW+vG5SZB9nv4nryRm1Oxo8K8huIJ
         yjYW4BMUhAbzFyUTudmw2AJt9jJFgDlkmKBw0AITVzpYu7dm2WdOuLHWzfPS13sidqpW
         aBooVwX6wIA31/qxy66ME5CoyT41lu1v+ocDpcfNyzMCDZv4cDq7/q3nbP5Yo4RdTtXK
         5sIPZliL8C4bOaFDIhwxh7/6tdNzsCKNIqTPgtUCOtYVFNp37llEFRPgBqaiOH0Mlya0
         MNrYgyRFmIphO8+stnBMiDmBLntvrCl2BM4RrSdct7j4dQJd77ObfeUCDPXU4p8i9pqK
         fHxg==
X-Gm-Message-State: AOAM532AhKe0O3VSpD6khkfwX4AaX0xsukgKHNi8JPZ5zpIhDvqR3mTv
        fCMea3gWj1LjFeqvFZLyVJdIaBP5LdR0udawMUTs3oOnlqA3aTNtmQJ88Vzj03cg5PoMznWYsQe
        GLWz6fd1XW7jAHYcmbZkcSvxQ
X-Received: by 2002:a17:907:6d85:b0:6fa:80ea:7565 with SMTP id sb5-20020a1709076d8500b006fa80ea7565mr38630247ejc.395.1653649055993;
        Fri, 27 May 2022 03:57:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwk6Jj1t6DUqc/RXpwAHg1SYPdtQFfHok9zAcciQ3wqDOE6E1PqZgNrOq+IAz4pxLa39lLnbQ==
X-Received: by 2002:a17:907:6d85:b0:6fa:80ea:7565 with SMTP id sb5-20020a1709076d8500b006fa80ea7565mr38630235ejc.395.1653649055743;
        Fri, 27 May 2022 03:57:35 -0700 (PDT)
Received: from redhat.com ([2.55.130.213])
        by smtp.gmail.com with ESMTPSA id kx17-20020a170907775100b006feded0fa87sm1330944ejc.218.2022.05.27.03.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:57:35 -0700 (PDT)
Date:   Fri, 27 May 2022 06:57:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bo Liu =?utf-8?B?KOWImOazoikt5rWq5r2u5L+h5oGv?= 
        <liubo03@inspur.com>
Cc:     "david@redhat.com" <david@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_balloon: check virtqueue_add_outbuf() return value
Message-ID: <20220527065611-mutt-send-email-mst@kernel.org>
References: <4789cbbb9d59420abc86a9e225ef0bfd@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4789cbbb9d59420abc86a9e225ef0bfd@inspur.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 10:43:30AM +0000, Bo Liu (刘波)-浪潮信息 wrote:
> The purpose of this patch is, virtqueue_add_outbuf() adding data to
> virtqueue may succeed or fail. If successful, it will call virtqueue_kick()
> to notifie the host backend driver, but if the virtqueue_add_outbuf() fails,
> the data is not successfully added to the virtqueue, and the host back-end
> driver does not need to be notified for processing.
> 
> Thanks.

Why is it a problem if we do?

-- 
MST

