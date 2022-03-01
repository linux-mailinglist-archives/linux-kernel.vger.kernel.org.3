Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103E34C9150
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiCARSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiCARSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:18:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F02432064
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646155063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vU3c8INkyRrLYmMmG6yRKZ1MJ2tssrI6rFUsT1snRg0=;
        b=LI4N+48OsQHomdrVNAKBoKHpxQ6dNDSuA78AkSTP8QwHedAMzOhXdyeS00T/50xPBloNcX
        HyYjg43K8VRh4r+JyuxAviDrja0RJCHUk4UcI0KVDuCNvzSxRJ/1DGV+J+I8LrSnvlhYyp
        daAzQ33kuecB+0qpuNjelobBFi8Eotc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-X8IATDp0MNC0K_9Lf6I8eA-1; Tue, 01 Mar 2022 12:17:41 -0500
X-MC-Unique: X8IATDp0MNC0K_9Lf6I8eA-1
Received: by mail-wr1-f70.google.com with SMTP id f14-20020adfc98e000000b001e8593b40b0so3536659wrh.14
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 09:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vU3c8INkyRrLYmMmG6yRKZ1MJ2tssrI6rFUsT1snRg0=;
        b=MEXKQ6sbnHu2ttO1IWsUD/7G7020VNFmpnIxTnHBBMPVIeKXGIosfHlZO65fXFe4VF
         AeDLjvGxQeLR3cQ5uKQv2yUASHNu8Pc1/4GYAF0brYzdx+1x0jZawTrzFnwa0lc+V4UF
         AnGZagflx+KWmQiWb33dJSJFOyBr50Gcko5vRTzayZoh6e4NbkcE8jXJqn7Go/NEJCEf
         y1xoQRlvtmvAROkRlXzONad6YYAWYxKF3fAm1bnOszjfcHHmA0aeOYYJxx5+ENhRhOuX
         LMPb3Hykh2zi2uNHjJY9WcXqAo1K2+Q+hHWmOUVsyOoC/uFX9iB0a384orGRRfIkCNdW
         SNbw==
X-Gm-Message-State: AOAM531fvAHLl5VmY142/3z2cgd/yAPRgPxakruJazp6u0JYWjC1iRg+
        4E/ok5d1AadfU/aJxJ9G0Ue5v9RNagyCFBr8SChyBWR03G9fVU4vybs+tI0lGSCmYOhuhXMcxu+
        iRyzj0JftKNRcbRd6C0aqADOV
X-Received: by 2002:a5d:61ca:0:b0:1f0:22ef:bb9f with SMTP id q10-20020a5d61ca000000b001f022efbb9fmr1534536wrv.56.1646155059890;
        Tue, 01 Mar 2022 09:17:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzm0/sILq9s5oSrG8KTBgACJNRqT1mtZa0IVWQDeU62j8WMqO9Pb3os150cIhmIfKb7xYMP0Q==
X-Received: by 2002:a5d:61ca:0:b0:1f0:22ef:bb9f with SMTP id q10-20020a5d61ca000000b001f022efbb9fmr1534511wrv.56.1646155059630;
        Tue, 01 Mar 2022 09:17:39 -0800 (PST)
Received: from redhat.com ([2.53.2.184])
        by smtp.gmail.com with ESMTPSA id w26-20020a7bc11a000000b0037bf8fa8c02sm2970118wmi.13.2022.03.01.09.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 09:17:38 -0800 (PST)
Date:   Tue, 1 Mar 2022 12:17:33 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Laszlo Ersek <lersek@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, qemu-devel@nongnu.org,
        linux-hyperv@vger.kernel.org, linux-crypto@vger.kernel.org,
        graf@amazon.com, mikelley@microsoft.com,
        gregkh@linuxfoundation.org, adrian@parity.io, berrange@redhat.com,
        linux@dominikbrodowski.net, jannh@google.com, rafael@kernel.org,
        len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org,
        colmmacc@amazon.com, tytso@mit.edu, arnd@arndb.de
Subject: Re: propagating vmgenid outward and upward
Message-ID: <20220301121419-mutt-send-email-mst@kernel.org>
References: <Yh4+9+UpanJWAIyZ@zx2c4.com>
 <223f858c-34c5-3ccd-b9e8-7585a976364d@redhat.com>
 <Yh5JwK6toc/zBNL7@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh5JwK6toc/zBNL7@zx2c4.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 05:28:48PM +0100, Jason A. Donenfeld wrote:
> Hi Laszlo,
> 
> On Tue, Mar 01, 2022 at 05:15:21PM +0100, Laszlo Ersek wrote:
> > > If we had a "pull" model, rather than just expose a 16-byte unique
> > > identifier, the vmgenid virtual hardware would _also_ expose a
> > > word-sized generation counter, which would be incremented every time the
> > > unique ID changed. Then, every time we would touch the RNG, we'd simply
> > > do an inexpensive check of this memremap()'d integer, and reinitialize
> > > with the unique ID if the integer changed.
> > 
> > Does the vmgenid spec (as-is) preclude the use of the 16-byte identifier
> > like this?
> > 
> > After all, once you locate the identifier via the ADDR object, you could
> > perhaps consult it every time you were about to touch the RNG.
> 
> No, you could in fact do this, and there'd be nothing wrong with that
> from a spec perspective. You could even vDSO it all the way through
> onward to userspace. However, doing a 16-byte atomic memcmp on
> each-and-every packet is really a non-starter. For that kind of "check
> it in the hot path" thing to be viable, you really want it to be a
> counter that is word-sized. The "pull"-model involves pulling on every
> single packet in order to be better than the "push"-model. Anyway, even
> with a word-sized counter, it's unclear whether the costs of checking on
> every packet would be worth it to everyone, but at least it's more
> tenable than a 16-byte whammy.
> 
> Jason

Hmm okay, so it's a performance optimization... some batching then? Do
you really need to worry about every packet? Every 64 packets not
enough?  Packets are after all queued at NICs etc, and VM fork can
happen after they leave wireguard ...

-- 
MST

