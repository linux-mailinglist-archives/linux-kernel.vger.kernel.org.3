Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B577508ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379489AbiDTOiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354568AbiDTOh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD0A3B1C7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650465309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQ3OOjy9//QRnsaidk1OuN7d13rJ2o2i8lIMYiz0dH4=;
        b=EOs+8/ApgxEC5JhMfhtkFN5lIegU/+aWFwPnC6QfGn4QrrZcbDoTOWj6CcKNfg4XlsXImc
        QVsq3KFC/kt/WyvzjdMsCXMM2O5OKYdJVYxZZrM/G/8Tid4lv/NgsWP8UtwfIlgNmZcKLo
        ZhALAhHYUHakzDY9IVhHN1B49Hs/C6E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-xGZ1R46UOQ6y4GE0XUBBsA-1; Wed, 20 Apr 2022 10:35:08 -0400
X-MC-Unique: xGZ1R46UOQ6y4GE0XUBBsA-1
Received: by mail-ed1-f69.google.com with SMTP id cx6-20020a05640222a600b0041df79fb9e8so1326466edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=YQ3OOjy9//QRnsaidk1OuN7d13rJ2o2i8lIMYiz0dH4=;
        b=wJ/q0DWW1kzFIOkrcTJsQUUrz+pnaYllDAWDU2fq5OfBl1vY3WUenDprFeHOkHZF/8
         PIanJG7PkB3rUTFwly7x2o0wlt3ATBPISmP5mD41rZcsE4qUf5+jH6kgvKbAJfGlDxMv
         JTNC2UKHJwqAgb6FJ00Fet8jtJaSrgINmVkgAhqCHjShlELwLNpQYmwIKjb7MseOnVTK
         eXHFmyUOPwjCMq3Fj2HOCjOI2k1GAYkTXYVcVMQLX3d0BfAwDNyBwswdL9D4Qz/kOiCd
         EUFxqqdC1kX/TbJ4YPCBc0J7XuQ8PbxVc8c5eWn4LWqvs4zaBuHR/dBlG+893wzLzy5U
         Y4xw==
X-Gm-Message-State: AOAM532ynYte/fARE9X5fNUlbHABO3jDm9d8zZwJuHQF5E3SUqil6Tkj
        HcWtEsxao+kMXO4BsAKyWSQ/G9tG+ng+/qU5eiDSjmUIBuBPmwgwJT0a1u0xfctLpk6YryVRuYq
        cdUGtb8TFTfhA+pkMzwMH/RLt
X-Received: by 2002:a05:6402:4414:b0:408:4dc0:3ee9 with SMTP id y20-20020a056402441400b004084dc03ee9mr23799984eda.203.1650465306113;
        Wed, 20 Apr 2022 07:35:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzSWGe1zTO7atYdK463hGUYzazLjAAXkdhrCdMbYvQk629uaZeKO/+RYN8Vqn5k83XVuagzg==
X-Received: by 2002:a05:6402:4414:b0:408:4dc0:3ee9 with SMTP id y20-20020a056402441400b004084dc03ee9mr23799960eda.203.1650465305911;
        Wed, 20 Apr 2022 07:35:05 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1306:2f00:cfcf:62cf:6f38:dd92? ([2a0c:5a80:1306:2f00:cfcf:62cf:6f38:dd92])
        by smtp.gmail.com with ESMTPSA id n5-20020a170906378500b006efb4ab6f59sm3328411ejc.86.2022.04.20.07.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:35:05 -0700 (PDT)
Message-ID: <f33efa638824ff7bb796fe69d2ab825c4bf03c70.camel@redhat.com>
Subject: Re: [PATCH 5/6] mm/page_alloc: Protect PCP lists with a spinlock
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Hillf Danton <hdanton@sina.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Wed, 20 Apr 2022 16:35:04 +0200
In-Reply-To: <20220420140214.2330-1-hdanton@sina.com>
References: <20220420095906.27349-1-mgorman@techsingularity.net>
         <20220420140214.2330-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

On Wed, 2022-04-20 at 22:02 +0800, Hillf Danton wrote:
> On Wed, 20 Apr 2022 10:59:05 +0100 Mel Gorman wrote:
> >  void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
> >  {
> > -	unsigned long flags;
> >  	int to_drain, batch;
> >  
> > -	local_lock_irqsave(&pagesets.lock, flags);
> >  	batch = READ_ONCE(pcp->batch);
> >  	to_drain = min(pcp->count, batch);
> > -	if (to_drain > 0)
> > +	if (to_drain > 0) {
> > +		unsigned long flags;
> > +
> > +		/* free_pcppages_bulk expects IRQs disabled for zone->lock */
> > +		local_irq_save(flags);
> > +
> > +		spin_lock(&pcp->lock);
> 
> Nit, spin_lock_irqsave() instead.

See cover letter's:

"This series is a partial series. Follow-on work would allow the local_irq_save
to be converted to a local_irq to avoid IRQs being disabled/enabled in most
cases. However, there are enough corner cases that it deserves a series on its
own separated by one kernel release and the priority right now is to avoid
interference of high priority tasks."

Regards,

-- 
Nicolás Sáenz

