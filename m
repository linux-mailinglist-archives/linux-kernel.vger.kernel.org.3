Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC1353FB71
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbiFGKge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241178AbiFGKgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB1F8EC336
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654598183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VIZmENWoecc1Gjip/W8Q1+dSiheQPkO4yhqkXrzmqmA=;
        b=KbKhOchsr23hSRwnGzay+5kok3z0O/8peBFL/J/muwzfLomSRhhcD/HD2TOSdFypLp4GS+
        2Lmw0ZT0pbsbE57XE6+3evfI4QxZFDK/3hTL1WhH6BG7g7REX687TqRg3QJr7smYWAgeiG
        c6/gqjJtlseVjZyAIunHjpp9a1Sm2L8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-K7FkSfscOPeeN8s5yE5YwQ-1; Tue, 07 Jun 2022 06:36:22 -0400
X-MC-Unique: K7FkSfscOPeeN8s5yE5YwQ-1
Received: by mail-wm1-f72.google.com with SMTP id n15-20020a05600c4f8f00b0039c3e76d646so5290551wmq.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VIZmENWoecc1Gjip/W8Q1+dSiheQPkO4yhqkXrzmqmA=;
        b=tOIaTke36wTrXOJfqmhHbyTM4/gh9LGw7sYy0WL5qfMKdepngLMjztKa0rW30IDDc5
         gcTZkNQdJ6MN8MOcSGxpMO1hWD+uxGUl4aTo4BuH/EmJXiCpO9SBS3jaNUsK2jh0Gar7
         M/lLvu2eXZetL0h+lk24soXqiLVY00t8rLPvTSgSc1MscgTpZfPqKgCdwFBzeoSNlmbR
         OBzdzhLp94dKR3chkki+vY6/NBDaeNwMH4m9i7KJk7+lHexkaasW+cSJTSmrIrLek0G7
         6oev4zEln8/0pr7IUnXXnPP7+PhVVQmB95Oo2XSOum0AxA/PzqsjgMArywUgpg5F23fZ
         /1cw==
X-Gm-Message-State: AOAM5328Su/KgQkv5RD7ApG51BWfKdz1hJ8daDT7FYE9fVp00Dg4NeD4
        x7HXsEGYZQb2bV3xqfvP9Yu4P1zsAk4fAotsAXJVxap4gaaNUqGqRk4CkSnFMSNq3U4U7k6wjiW
        txmOvYM4ApZTXPpsXwfWwYrt4
X-Received: by 2002:a05:600c:3b20:b0:397:6311:c0c7 with SMTP id m32-20020a05600c3b2000b003976311c0c7mr56578498wms.69.1654598181302;
        Tue, 07 Jun 2022 03:36:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMvJByNJtOpfW7JFF+6+fzeex2HW2ExVgG0ZmK8Z/TskZxgAJUrPnbY07auM9j9IWBDFyxdA==
X-Received: by 2002:a05:600c:3b20:b0:397:6311:c0c7 with SMTP id m32-20020a05600c3b2000b003976311c0c7mr56578454wms.69.1654598181061;
        Tue, 07 Jun 2022 03:36:21 -0700 (PDT)
Received: from redhat.com ([2.55.169.1])
        by smtp.gmail.com with ESMTPSA id m4-20020a1c2604000000b0039c506de087sm5271489wmm.6.2022.06.07.03.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 03:36:20 -0700 (PDT)
Date:   Tue, 7 Jun 2022 06:36:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bo Liu =?utf-8?B?KOWImOazoikt5rWq5r2u5L+h5oGv?= 
        <liubo03@inspur.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_ring: remove unnecessary to_vvq call
Message-ID: <20220607063549-mutt-send-email-mst@kernel.org>
References: <f5cef070316447cebe0e9c6e86657218@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5cef070316447cebe0e9c6e86657218@inspur.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 08:08:58AM +0000, Bo Liu (刘波)-浪潮信息 wrote:
> This patch removes unnecessary code and generates smaller binary files.
> Thanks

Can you post info on which files are smaller an by how much please?

-- 
MST

