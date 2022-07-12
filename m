Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65DD5721D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiGLReP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiGLReL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30846C3AF7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657647249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YnYHNlXG4sAUmEFeyzh6YNeY0EHRa/NJXlU0ExFTwhw=;
        b=LeN0LOk5xO5EDmwLsi6D9VbtzoDO3q9V2wmGRURYa6gOh9RJzebyyU/Q6a6q86lchgVnCP
        9z5EJ3RGUMBMw2Y8Nh3CTLlccE9crpTAFJs43TBQB1mSVzrgKli4V1djYJQ2N7a9Qtv+mL
        vf4bmcVuG+xGl0RzioxHv9jNAx8St7U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-1fguBv73P2axXfe8VyYEDA-1; Tue, 12 Jul 2022 13:34:08 -0400
X-MC-Unique: 1fguBv73P2axXfe8VyYEDA-1
Received: by mail-wm1-f69.google.com with SMTP id a6-20020a05600c348600b003a2d72b7a15so6977977wmq.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YnYHNlXG4sAUmEFeyzh6YNeY0EHRa/NJXlU0ExFTwhw=;
        b=hxvXrv3X9ONizYn2E3Jpk0GDOEQYDCYdqQkRputhvyJTO5uP+a4sLT/JVyPBwfYZXc
         kxdwnppY1M4iHy2pImp2D7htX22f4M4w8LpD9bWE9te15dW4PUnnLNQbBCGariNcw1RQ
         OIaXReDGx6gYI6b8ZlkjpEPReRWn9ZNd9FMEV/eaFe0H1vseagEO8qp2qqfWi8fpBKqO
         GNnpJdfOAG9sizYDJo71Y9rQG4JtPGDHrXFvmtc8zJQ+UYBuJ32IBYzzRdgEiElxE0vi
         jjj7N+7Znegb9a0ZkM7Y6fg5QlW+jwezPf54QVOdZTqtyAAwPKw5d0K9xKzTnYtig5rg
         Ztiw==
X-Gm-Message-State: AJIora8hsGi1lY7UY2+p3aXlI9J3u7wZ3wK/yGKF6u2ZfTRlXXqkwo9e
        t6WZiww3IGdavoXJFbI0/AIhx7+eDYJk7Tb9mW8X/2tl7eBda2dpCuItZOPxrFPqS3+dPNQOU8k
        gPahJQAIT+/7VIXRalwLkN+ko
X-Received: by 2002:a5d:64e2:0:b0:21d:38e8:2497 with SMTP id g2-20020a5d64e2000000b0021d38e82497mr21630555wri.142.1657647246900;
        Tue, 12 Jul 2022 10:34:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s+PP4fF7oA8OdWVvLKhyeV68On2eq47evFDSzPrbco4GFV9G3YPeiUG9k5/I7KupkTLDI7PA==
X-Received: by 2002:a5d:64e2:0:b0:21d:38e8:2497 with SMTP id g2-20020a5d64e2000000b0021d38e82497mr21630530wri.142.1657647246710;
        Tue, 12 Jul 2022 10:34:06 -0700 (PDT)
Received: from localhost.localdomain ([185.233.130.50])
        by smtp.gmail.com with ESMTPSA id j16-20020adfff90000000b0021d76a1b0e3sm8759337wrr.6.2022.07.12.10.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 10:34:05 -0700 (PDT)
Date:   Tue, 12 Jul 2022 19:34:03 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     James Carlson <carlsonj@workingcode.com>,
        Chris Fowler <cfowler@outpostsentinel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-ppp@vger.kernel.org" <linux-ppp@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppp: Add rtnl attribute IFLA_PPP_UNIT_ID for specifying
 ppp unit id
Message-ID: <20220712173403.GC3794@localhost.localdomain>
References: <20210811180401.owgmie36ydx62iep@pali>
 <20210812092847.GB3525@pc-23.home>
 <20210812134845.npj3m3vzkrmhx6uy@pali>
 <20210812182645.GA10725@pc-23.home>
 <20210812190440.fknfthdk3mazm6px@pali>
 <20210816161114.GA3611@pc-32.home>
 <20210816162355.7ssd53lrpclfvuiz@pali>
 <20210817160525.GA20616@pc-32.home>
 <20210817162155.idyfy53qbxcsf2ga@pali>
 <20220709120906.ymkhn5diywadgrka@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220709120906.ymkhn5diywadgrka@pali>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2022 at 02:09:06PM +0200, Pali Rohár wrote:
> On Tuesday 17 August 2021 18:21:55 Pali Rohár wrote:
> > On Tuesday 17 August 2021 18:05:25 Guillaume Nault wrote:
> > > On Mon, Aug 16, 2021 at 06:23:55PM +0200, Pali Rohár wrote:
> > > > On Monday 16 August 2021 18:11:14 Guillaume Nault wrote:
> > > > > Do you have plans for adding netlink support to pppd? If so, is the
> > > > > project ready to accept such code?
> > > > 
> > > > Yes, I have already some WIP code and I'm planning to send a pull
> > > > request to pppd on github for it. I guess that it could be accepted,
> > > 
> > > I guess you can easily use the netlink api for cases where the "unit"
> > > option isn't specified and fall back to the ioctl api when it is. If
> > > all goes well, then we can extend the netlink api to accept a unit id.
> > > 
> > > But what about the lack of netlink feedback about the created
> > > interface? Are you restricted to use netlink only when the "ifname"
> > > option is provided?
> > 
> > Exactly, this is how I wrote my WIP code...
> 
> Sorry for a long delay (I forgot about it). Now I created pull request
> for pppd https://github.com/ppp-project/ppp/pull/354 which adds support
> for creating ppp interface via rtnetlink. rtnetlink is used only when
> ppp unit id was not provided and interface name was provided.

Interesting work. Thanks for working on it!

> > > > specially if there still would be backward compatibility via ioctl for
> > > > kernels which do not support rtnl API.
> > > 
> > > Indeed, I'd expect keeping compatiblitity with old kernels that only
> > > have the ioctl api to be a must (but I have no experience contributing
> > > to the pppd project).
> > > 
> > > > One of the argument which can be
> > > > used why rtnl API is better, is fixing issue: atomic creating of
> > > > interface with specific name.
> > > 
> > > Yes, that looks useful.
> > > 
> 

