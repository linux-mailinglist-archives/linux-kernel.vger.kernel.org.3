Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996D05A8223
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiHaPrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiHaPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5112DA3E6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661960780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDnsKK2cZELk5wddqmtKkVouG+DKHN8ltWUs0oV7mCc=;
        b=VkOc/eUsODxiVivu1spYJvbiSSztMf0h7EENeoGeeL+wIqrQdfYj6cOgXzd3UaZmMjJENK
        5D1C1hbHvObBHZrChzNxrtJDpVkm27xDfYkqRRh7bnnNRiTuqQNIX42L8qUrb36xY+yZzg
        Q+ty8ZB+9kR5OEL0zH24nd3qvLoRYpY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-t-OIe2qaP0iUklszjBYdsA-1; Wed, 31 Aug 2022 11:46:18 -0400
X-MC-Unique: t-OIe2qaP0iUklszjBYdsA-1
Received: by mail-wm1-f71.google.com with SMTP id q16-20020a1cf310000000b003a626026ed1so2923133wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FDnsKK2cZELk5wddqmtKkVouG+DKHN8ltWUs0oV7mCc=;
        b=UPB3bggRnblE1Mirf+jkW3fRp3SAxeYML/76hTunHmBF8Xrqo6ddIVjMEIcxyKzK63
         m11XC1taWP2l8S+0hoOzDWc7oo8Z658oI2WBsR/I1Or2DkiYKXmseTAhI5bzSo77GF+2
         ejbFoAsLJNCLpkfStDeqWH2NkAIEj0OqIT+m+UXYygy91SkOIxGjHzFhcBU6ECs5Qaqm
         XeC8VnbqEw8ybjIIFADVQvh/rsAv2Ta7UK2gDkvXTqk7jiuASg3rycXp3gb+pbV+VYPZ
         4KwglRVR2GoSms2t9f3/MKfNkKS4+AlMFeQatQUMtLgjww43nOsX1YdPkb2/ZHR78hqe
         Khlw==
X-Gm-Message-State: ACgBeo3VCR88n7QsDiMyE+l2GENaJIANbGdZnmHEwvGMuJ7BwEaQZMCP
        8D/YQ4R3xaRWS/DVgXp9yjQkMKgfrwbjkXs+N2OCEA1lwuOPbUVQU8vf9TLTayXF/hC8Q5csBPi
        jRYJiCVjAaM6LHp30cvYDOM8Q
X-Received: by 2002:adf:f2c5:0:b0:226:e838:3ed8 with SMTP id d5-20020adff2c5000000b00226e8383ed8mr3256074wrp.545.1661960776895;
        Wed, 31 Aug 2022 08:46:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR51lk4waATJlZuT8JdfrFRa/Uuco6WTTGuyB1nHXQejK5PjPhp5O0007rSiEEDR6ePRgGWKog==
X-Received: by 2002:adf:f2c5:0:b0:226:e838:3ed8 with SMTP id d5-20020adff2c5000000b00226e8383ed8mr3256066wrp.545.1661960776675;
        Wed, 31 Aug 2022 08:46:16 -0700 (PDT)
Received: from redhat.com ([2.55.191.225])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4850000000b0022546f469e1sm12162234wrs.28.2022.08.31.08.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 08:46:16 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:46:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     jasowang@redhat.com, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, elic@nvidia.com,
        guanjun@linux.alibaba.com, parav@nvidia.com,
        gautam.dawar@xilinx.com, dan.carpenter@oracle.com,
        xieyongji@bytedance.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] vduse: prevent uninitialized memory accesses
Message-ID: <20220831114534-mutt-send-email-mst@kernel.org>
References: <20220829073424.5677-1-maxime.coquelin@redhat.com>
 <YwxvXFiuRqGxRgZH@kroah.com>
 <796c9d73-30a0-2401-e499-724aeb0f8dc6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <796c9d73-30a0-2401-e499-724aeb0f8dc6@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 05:01:11PM +0200, Maxime Coquelin wrote:
> On 8/29/22 09:48, Greg KH wrote:
> > On Mon, Aug 29, 2022 at 09:34:24AM +0200, Maxime Coquelin wrote:
> > > If the VDUSE application provides a smaller config space
> > > than the driver expects, the driver may use uninitialized
> > > memory from the stack.
> > > 
> > > This patch prevents it by initializing the buffer passed by
> > > the driver to store the config value.
> > > 
> > > This fix addresses CVE-2022-2308.
> > > 
> > > Cc: xieyongji@bytedance.com
> > > Cc: stable@vger.kernel.org # v5.15+
> > > Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> > > 
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > 
> > Please no blank line above the Acked-by: line here if possible.
> 
> Sure.
> 
> Jason, do you prefer I post a new revision with this single change or
> you will handle it while applying? Either way is fine to me.
> 
> Thanks,
> Maxime

I queue these normally.

> > thanks,
> > 
> > greg k-h
> > 

