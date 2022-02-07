Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3CD4AC98B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbiBGT1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbiBGTWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:22:45 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071E0C0401E0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:22:44 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id t17so12684149qto.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 11:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yHQiDHxA3qZlcWTxLN1MgZypNnbjTwUZO2QoeiWP/cI=;
        b=WalR+vjdCg+8zPlO5aZ1ywuN+woRsi3gerM9e8um5R75M05o/0A4tTPV0sDoS0iLf7
         MI5Ayh/aUjA3lzGk4knlGcpvrjJkTAzgzCaIVUlu2cLGGSbDhpJ/GrhJhUdc2HnXtmRK
         stuNg7sUYxLt5HQjP/PwyCP9ZRninXNxW8lX4+8vi6VkUSLgg5BY3Jxg39rH3WH2BDNx
         g9rpWqR/RtcR0wf2poNmSVgkhRnSCPEG3oCgynxbJlts+OBBSOpC9atYeDDQCpJbBHmV
         OdyYF8TiYTFFifPNOFO5hE7XJgkPbqKroSw//vj0hDKtL6BLQKT8a9/Jd8uxBZMUHGVb
         3Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yHQiDHxA3qZlcWTxLN1MgZypNnbjTwUZO2QoeiWP/cI=;
        b=j5LqV3SkSS3gVr/BsFnco7OD3IYXDPLM2V+CwTrRSGZCc+lY7Ax7loALESe0AEQVSf
         JM2lfif0+ua15qfkuvoAzvecMveM92FkHIDN7AVwk+Yo4ffpEGnRebzLn+Zh3ByrozzC
         SekPMtQyLPRfVd7n+E91otlzUrbHg3PFIUwstNPe3DjluCYn5Gy+bl8n+uw5/31CxNBx
         MSg6szMoVGAeI3TNOWWbbYo/iMqx/710gyX3TOhthCa2UjvFQ6NF+9sGqBkHjibQ95Ba
         KZlfKIX2VEwBpIdsoiKay9P98wyzoPte4WUcY2ULxqym+FkNnAJMLvbrfTyEP6ShNpYg
         4VLw==
X-Gm-Message-State: AOAM53370GW6pofJ12Dyc4NXQEa83K0gXWg2tguOSt/MbcLU0E4rGfYk
        E4jM2/JTp03Xu5THGt+cvH3JVQ==
X-Google-Smtp-Source: ABdhPJyusc4Y6UBxGsOMvrtpT2MH3zTc6ABg/OaP0sDSZntIjW01XzJV/gLuVV8p/6/141fWu3yUUA==
X-Received: by 2002:a05:622a:1303:: with SMTP id v3mr740294qtk.294.1644261763197;
        Mon, 07 Feb 2022 11:22:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id y5sm5930001qkp.37.2022.02.07.11.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 11:22:42 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nH9b0-000HrC-2F; Mon, 07 Feb 2022 15:22:42 -0400
Date:   Mon, 7 Feb 2022 15:22:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH 1/8] mm: remove a pointless CONFIG_ZONE_DEVICE check in
 memremap_pages
Message-ID: <20220207192242.GC49147@ziepe.ca>
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207063249.1833066-2-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 07:32:42AM +0100, Christoph Hellwig wrote:
> memremap.c is only built when CONFIG_ZONE_DEVICE is set, so remove
> the superflous extra check.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/memremap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
