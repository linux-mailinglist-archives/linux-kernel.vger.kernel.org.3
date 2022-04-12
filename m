Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0AE4FE143
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354869AbiDLM5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355047AbiDLMzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:55:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2D32D1E3;
        Tue, 12 Apr 2022 05:29:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k5so1809458lfg.9;
        Tue, 12 Apr 2022 05:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SbuOQk5XHCi9O0P6+0FQZ2Hr3E5U7aXIVRnTTuHTV4s=;
        b=oyUYl76UTgrDCOg633zFKDQ6mGxT/HDKNQmRsE59lXd3UXd4DE3b0AQgUEwy3DM0+S
         t6kgd9MSgXryHXW3MxRTjLMydT0bzNfu72YkTq3wxCL2AO9gDnC5L9VwO9KpIk+Uwf2Q
         1N83wdOB3S+IjBWDRuHzglDWQTZKXWoh25FpzLj/7D6jjsAl73Q9DlCZno6nkdjCBg9r
         sFIdR2Iu2qBY2b1KJ2mEpbA55wMGcuI5J9KFKI9BEqEGBPdnwBzVHHK3aTDRvq+sbb2r
         pPd3Y0sNYB3iq1FPRzwtt0iYf0N2ylSeyaVdLRkB99w+7C2g287pJRze4+OEVLlvp6VQ
         ovfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SbuOQk5XHCi9O0P6+0FQZ2Hr3E5U7aXIVRnTTuHTV4s=;
        b=SdLHsN9tahXzhMMq+F8Th+1KVrvfSVl2PCek4OWLekbj5kQ6pPysq04FBzjbp0SvtI
         zMV1/DMxLuUjpG4gRlp2U8/htEfFzz6xjVAid6HqxzljM22/820O3WsWYCpJClJlxaVM
         GZbvPtTJEq1E1gFbMlac6hAc0hoq7il93yFKq9K+jLsbnt+0NHkNzA39Ykck+vmyOAOT
         haXb6JTybPUYzLAzfgNzR9RIelJMBy13xBP4kpPGSSA2ynWtE6RxlBsbflr8CsqehU/8
         435H9y+6sjv9eGDXpWMmQXDUjcpogFMylLxZ+nG2tjugH857fgcN+AODdqjTOXm/oa+O
         QZCg==
X-Gm-Message-State: AOAM531IUMbWQ76qVB4OutUqEb5w1e5EMkfvzbV5EpioCArKY4RZE/C+
        GBaHiohFC0QsuyDxxDPIFa4=
X-Google-Smtp-Source: ABdhPJzJf0bk6yLE45h+CmwHLM/NUua6uzkx95kgOF5Wv+rBriHTUagQkv4xRuctyOayDKr2EVoA1Q==
X-Received: by 2002:a05:6512:318a:b0:44a:4dab:4cd2 with SMTP id i10-20020a056512318a00b0044a4dab4cd2mr25488680lfe.606.1649766573758;
        Tue, 12 Apr 2022 05:29:33 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id f15-20020ac25ccf000000b0046b8d6adbb0sm1191726lfq.225.2022.04.12.05.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 05:29:33 -0700 (PDT)
Date:   Tue, 12 Apr 2022 15:29:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 12/21] ata: libahci: Discard redundant force_port_map
 parameter
Message-ID: <20220412122931.ckjmwopnktpfwbov@mobilestation>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-13-Sergey.Semin@baikalelectronics.ru>
 <b06a8382-d5c1-e3a5-8577-692fa82cb3c1@opensource.wdc.com>
 <20220411121151.vm6wmtalbl2lgtgo@mobilestation>
 <bde34952-e244-a1c3-fc33-251d618d2bb4@opensource.wdc.com>
 <20220411205205.p5vnqvscgfb2siej@mobilestation>
 <5ae5764f-ca51-9c2d-c13f-cfe855bda45e@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ae5764f-ca51-9c2d-c13f-cfe855bda45e@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 07:48:50AM +0900, Damien Le Moal wrote:
> On 4/12/22 05:52, Serge Semin wrote:
> > On Mon, Apr 11, 2022 at 09:25:03PM +0900, Damien Le Moal wrote:
> >> On 4/11/22 21:11, Serge Semin wrote:
> >>> On Thu, Mar 24, 2022 at 11:05:58AM +0900, Damien Le Moal wrote:
> >>>> On 3/24/22 09:16, Serge Semin wrote:
> >>>>> Currently there are four port-map-related fields declared in the
> >>>>> ahci_host_priv structure and used to setup the HBA ports mapping. First
> >>>>> the ports-mapping is read from the PI register and immediately stored in
> >>>>> the saved_port_map field. If forced_port_map is initialized with non-zero
> >>>>> value then its value will have greater priority over the value read from
> >>>>> PI, thus it will override the saved_port_map field. That value will be then
> >>>>> masked by a non-zero mask_port_map field and after some sanity checks it
> >>>>> will be stored in the ahci_host_priv.port_map field as a final port
> >>>>> mapping.
> >>>>>
> >>>>> As you can see the logic is a bit too complicated for such a simple task.
> >>>>> We can freely get rid from at least one of the fields with no change to
> >>>>> the implemented semantic. The force_port_map field can be replaced with
> >>>>> taking non-zero saved_port_map value into account. So if saved_port_map is
> >>>>> pre-initialized by the glue-driver/platform-specific code then it will
> >>>>
> >>>
> >>>> glue-driver == LLDD (low level device driver), for the entire series please.
> >>>
> >>> Why? It's a normal term and well known amongst developers. I've used it
> >>> in a plenty of my patches before and none of them has been questioned in that
> >>> part so far.
> >>
> > 
> >> This term is not used in libata, nor do I remember seeing it used in SCSI
> >> or block subsystem either. We always talk about mid-layer (ahci platform)
> >> and LLDD (adapter driver).
> > 
> > Great, do we need to learn the subsystem-specific dictionary now
> > before submitting the patches for it? =)
> > Really, you are asking me to change one term to its synonym just
> > because it's mainly unused here. Now you know what it means, the
> > others can easily google it and get to learn something new. Win-win.)
> 

> I already knew what it meant, but it was unclear if my idea of what you
> meant was actually the same as yours. Sticking with the vocabulary already
> used since *a long time ago* makes life easier for reviewers and avoids
> confusion.

I believe there can't be too many possible meaning of that term to
have much doubts. Especially when we refer to the kernel drivers. One
more time requesting to settle some implicit subsystem-specific
conventions, not having them described in some kernel documents seems
very much wrong. The ahci_ prefixing and the specific vocabulary
concerns each driver in very many aspects. Seeing there are not a few
drivers which don't follow those conventions, you give no chance for
the developers to get their code accepted with no requests to fix the
corresponding parts. So to speak you need to thoroughly describe these
and the others conventions in the kernel documentation otherwise
you'll always end up requesting the same fixes wasting your and
developers time again and again.

Really if you had that document available, you could have used as a
reference and just said something like "please, follow the coding
style convention described here..." and no question would have raised.
Meanwhile currently both ahci_-prefix change and using the LLDD term
seem more like a personal desire to me.

-Sergey

> 
> -- 
> Damien Le Moal
> Western Digital Research
