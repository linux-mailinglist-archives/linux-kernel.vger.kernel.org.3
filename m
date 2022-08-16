Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDDD595B64
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiHPMJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiHPMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:08:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED9E10C7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660651219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pwz8sbWeHrkfuw7TlrsGXqGQd9GZSL1nvueVrYuNuZ0=;
        b=NbJAAGXaDePzXDLNZgOvKqwsf6Rui8Qm0mgh69MGXNlX5r39Y7XWmlQsC8l/EdntJQYYDm
        zL9i6uKuydP+SQVdMorsZQ2UV3gCh8YZy6j1GV0FY4i4FlgPiGzlwiMqvkaGW4kXgFAZpT
        R2aHa9JUCbJLX9WwuBEig2b/QESkTHw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-509-t2z_HEDkN16ZdtfP_uyM4Q-1; Tue, 16 Aug 2022 08:00:17 -0400
X-MC-Unique: t2z_HEDkN16ZdtfP_uyM4Q-1
Received: by mail-wm1-f71.google.com with SMTP id f18-20020a05600c4e9200b003a5f81299caso1723830wmq.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Pwz8sbWeHrkfuw7TlrsGXqGQd9GZSL1nvueVrYuNuZ0=;
        b=tO92eycBQiLYyGVssodeKPUzJA5zdkRuSsnoptuyM1FV7gx/VgLv2d7w3917KbuBUf
         eJ57WJWEG13LpDgmNGP1UoVCknValk+2GShB3smvejiRmAOy5UmrjzbJuNkgNfx0VxJ2
         l4b0sEAEzUJhXrWUEd1clppuCFEBkx77sjinAh8eJnt29wj7eLz6sZp7JyfhKLhTkvF0
         az0+ocKvtHSK+VvhgrzkzE/Xw2LuHslAzKrXOTG/oySHI78jL4OjXWc5zmmSaWNR9LQa
         /UMhkpS+VpnVJIPkhOgMowQM/FnF7N83MLmhLrzeSlpb2LAgqnXkaY8uPGs5+wFBJwg4
         RRxg==
X-Gm-Message-State: ACgBeo002eytDRXtltDw7copRGVrbehntT/QaqooI40ic6bgORDtfeAl
        BF4ViGAl/8eyXOC3zi7gwmr3Z6iVwIB1ffTA6csrjL/LsTpVtzK16JURie80jIogNDBdPiLZRVS
        hMddcjoCeFjORV7xO9pv6/PRe
X-Received: by 2002:a05:6000:2a8:b0:220:6893:4ff6 with SMTP id l8-20020a05600002a800b0022068934ff6mr11805873wry.170.1660651216639;
        Tue, 16 Aug 2022 05:00:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5+lxy72X0p8q1N/VA1caBeK9MeCyZ3upRXQRZYRJDWig+QRJxJ+nox5XWYdcFyrgUtFuIZyQ==
X-Received: by 2002:a05:6000:2a8:b0:220:6893:4ff6 with SMTP id l8-20020a05600002a800b0022068934ff6mr11805859wry.170.1660651216420;
        Tue, 16 Aug 2022 05:00:16 -0700 (PDT)
Received: from redhat.com ([2.55.4.37])
        by smtp.gmail.com with ESMTPSA id cl5-20020a5d5f05000000b00224f7c1328dsm8312482wrb.67.2022.08.16.05.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:00:15 -0700 (PDT)
Date:   Tue, 16 Aug 2022 08:00:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nadav Amit <namit@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/4] Make place for common balloon code
Message-ID: <20220816075953-mutt-send-email-mst@kernel.org>
References: <20220816094117.3144881-1-alexander.atanasov@virtuozzo.com>
 <20220816094117.3144881-2-alexander.atanasov@virtuozzo.com>
 <YvtoDxvefWUJBfAS@kroah.com>
 <f88fe469-d4a4-3240-b325-a745255bf01c@virtuozzo.com>
 <YvuF8CsP0M1TAK1a@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvuF8CsP0M1TAK1a@kroah.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 01:56:32PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 16, 2022 at 02:47:22PM +0300, Alexander Atanasov wrote:
> > Hello,
> > 
> > On 16.08.22 12:49, Greg Kroah-Hartman wrote:
> > > On Tue, Aug 16, 2022 at 12:41:14PM +0300, Alexander Atanasov wrote:
> > 
> > > >   rename include/linux/{balloon_compaction.h => balloon_common.h} (99%)
> > > 
> > > Why rename the .h file?  It still handles the "balloon compaction"
> > > logic.
> > 
> > File contains code that is common to balloon drivers,
> > compaction is only part of it. Series add more code to it.
> > Since it was suggested to use it for such common code.
> > I find that common becomes a better name for it so the rename.
> > I can drop the rename easy on next iteration if you suggest to.
> 
> "balloon_common.h" is very vague, you should only need one balloon.h
> file in the include/linux/ directory, right, so of course it is "common"
> :)
> 
> thanks,
> 
> greg "naming is hard" k-h

Yea, just call it balloon.h and balloon.c then.

-- 
MST

