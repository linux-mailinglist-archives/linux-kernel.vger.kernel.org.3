Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D739545BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 07:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244580AbiFJFor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 01:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiFJFoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 01:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 303BD33E1A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 22:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654839884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ShE1FlsmSfqxYvr7PfIooFDqvA9+xWO6036Ml2D5cEU=;
        b=KpXroa9o+vUYkImFKMftHiAkcN9FCj7BVs7d4V5yM9f4I8L/Ko+Kt6pS5lkkBDyI5ly2fQ
        q3i4/WLoOEJC6JmoOGt7VjFpMhfYeYlFsrRL4wh5cwSFWeW9RMschlvNfona2bmGwgSTf5
        2iuzxBduB0Cx1gHfkjU1jWQDwkJik/o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-h5KhKokMNpmnysPfogtCkg-1; Fri, 10 Jun 2022 01:44:42 -0400
X-MC-Unique: h5KhKokMNpmnysPfogtCkg-1
Received: by mail-wm1-f71.google.com with SMTP id k34-20020a05600c1ca200b0039c7db490c8so358344wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 22:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ShE1FlsmSfqxYvr7PfIooFDqvA9+xWO6036Ml2D5cEU=;
        b=FINFYONC4OJjLKY0mrl9V0CYWiNvqCVT1VxM7+NCI1HSZA1DST9tu+diGF+KfHcRo6
         NglXGigEx7tFt1uO/ss/1hVDEkMeQU/vb+XS4o62Rp2/A1w7LxVXxzkBY9p29+GjDHdm
         bBzzzYKopnKSZ91ec3qpXn8eOSIj8+y1Y9mm+UiwiGVMBKrAk1CLGQszOoHoTQlOihrB
         NKmwBzSh0DQsNnVrcSfH9FImDGC1SlsdKyfBEo5r934ICdZXOSHnwj7RU/iecHQ2eXOU
         M+6kWKgdHPKrFiQkKYh/dZ6WmjSYiQOExVJadbLzJ1JJIUo6sBRhNV5Eqmn3mtq+0wos
         j5KA==
X-Gm-Message-State: AOAM533HNdVIGw9ReSdhQ2U/A8b4KGkVsB3KIgofKSUhIHLFMl8fU113
        qYmRE3jJVxbh5iFk544RX5BXNmavG/MGKM6AAFNw8RxfHY6tVlX13GwlGRci40jB79uyVZURzth
        y/gW19Oa5kzQLC2KBZOvyzQNc
X-Received: by 2002:a5d:4d01:0:b0:219:e782:786e with SMTP id z1-20020a5d4d01000000b00219e782786emr1109613wrt.29.1654839881193;
        Thu, 09 Jun 2022 22:44:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEmWQHVgI7mLEv3SkzwqsG0Oxbqj8p8QyhoSd4ME6IUhU+HW5jSNN0aKke5wjImdfMPeuohQ==
X-Received: by 2002:a5d:4d01:0:b0:219:e782:786e with SMTP id z1-20020a5d4d01000000b00219e782786emr1109594wrt.29.1654839880990;
        Thu, 09 Jun 2022 22:44:40 -0700 (PDT)
Received: from redhat.com ([212.116.178.142])
        by smtp.gmail.com with ESMTPSA id q9-20020a5d6589000000b00219e758ff4fsm666864wru.59.2022.06.09.22.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 22:44:39 -0700 (PDT)
Date:   Fri, 10 Jun 2022 01:44:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Minghao Xue <quic_mingxue@quicinc.com>
Cc:     krzysztof.kozlowski@linaro.org, jasowang@redhat.com,
        robh+dt@kernel.org, jean-philippe@linaro.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ztu@quicinc.com
Subject: Re: [PATCH v2 1/2] dt-bindings: virtio: mmio: add optional
 wakeup-source property
Message-ID: <20220610014330-mutt-send-email-mst@kernel.org>
References: <20220325015945.GA17578@mingxue-gv.qualcomm.com>
 <20220328164228-mutt-send-email-mst@kernel.org>
 <20220329074610.GA20342@mingxue-gv.qualcomm.com>
 <a35529be-d9cb-9913-76aa-653faed87b54@linaro.org>
 <20220519071958.GA24236@mingxue-gv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519071958.GA24236@mingxue-gv.qualcomm.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 03:23:02PM +0800, Minghao Xue wrote:
> On Tue, Mar 29, 2022 at 09:59:31AM +0200, Krzysztof Kozlowski wrote:
> > On 29/03/2022 09:46, Minghao Xue wrote:
> > > On Mon, Mar 28, 2022 at 04:42:59PM -0400, Michael S. Tsirkin wrote:
> > >> On Fri, Mar 25, 2022 at 09:59:45AM +0800, Minghao Xue wrote:
> > >>> Some systems want to set the interrupt of virtio_mmio device
> > >>> as a wakeup source. On such systems, we'll use the existence
> > >>> of the "wakeup-source" property as a signal of requirement.
> > >>>
> > >>> Signed-off-by: Minghao Xue <quic_mingxue@quicinc.com>
> > >>
> > >> I don't have enough of a clue about dt to review this.
> > >> Pls get some acks from people with DT expertise.
> > >>
> > > Hi Michael,
> > > I had a discussion with Krzysztof on the first version of patch. And we've
> > > got aligned. 
> > > 
> > 
> > I thought I reviewed this and provided an ack, but apparently I did not.
> > Sorry for late response.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > Best regards,
> > Krzysztof
> 
> Hi Michael and Jason,
> As this patch has been reviewed by Krzysztof. Would you help upstream
> these two patches? And is there any progress on it?
> 
> Regards,
> Minghao

Hi!
Sorry about the delay - the issue with the patchset is it was not
threaded correctly and so can not get handled properly by
automated scripts. Can you please repost threading properly,
preferably with a cover letter?

-- 
MST

