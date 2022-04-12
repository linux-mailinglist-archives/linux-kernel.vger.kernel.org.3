Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75BD4FCD6A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiDLEE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345752AbiDLEEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:04:04 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97C833A0F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:01:27 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id y19so3313934qvk.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4NRq9wUKR0Pv6QYoD5yUdpYhNg4tlKq7MmYRIVRzyYg=;
        b=QzCANZSdJ5P0+QrETcEAa6nqQQp1jd5ilnjCvFDnDT7sdPxYaJ10EojfQFQAg69hNZ
         pc425I6h5uZoTbN4CZVHIRffDzOOpuJennuxofR1caDO8EZAE4n/XKf8cRtK/VKaSjIA
         uVzhZ2dKVH+8iSdQvlWf0yBGRTe4KFfS/dpFO46TdYcVOtuUYXz/a5YXgzGPXWMeHkv9
         V20UJ6t8nLZvj253txKvxL2aMaAB616KPMuEMfUeg8WpYHCfXqnJG8dkVr09Eh8edyjW
         f/wQweIS/rbsNs74SDT+yfLu04AAa8W1EUknm3+hS4og/ZPN8eqVz9oB6XGqfkwQiEcB
         qggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4NRq9wUKR0Pv6QYoD5yUdpYhNg4tlKq7MmYRIVRzyYg=;
        b=XvwA60HQFwUtqSl3XkP1n9Hs78AFaYRgFpC8MJcmWnu3kLwW5mc4CJVWV1hj/IIXod
         oyfOnRCdlFaXsDDmXB5wMKD5FiIrl8tiUTUL7koMlj11h61a6/ocSEpaJQwWm0SZW9AZ
         MUf/z+fuzVd4KQgyacEGAnEkM+sa6ZRUvcO9wx1iZX1lE7pbYsTcEhjRPXZ9eeh9kbL9
         Upi5qIHL1bRa0ClY/K9rgu3pP8r88UbYGv+Wumvryqww5UHK+S6hbwZs++nkN2gzM75k
         9Fh0LyIHQX+IjCyRxiBWruX/CcmSL4m+MSOKE89RfddHfyZ41MW8V1rebZ3CIc6hYwAg
         DNkQ==
X-Gm-Message-State: AOAM532S1WBfR6k/nVgBguurhWJobx+sJ0FDmoOexna9XEaWQEUrDOz+
        egde+4CvtSGw68Pj/LbkuzhZq/SMUYbXa79p
X-Google-Smtp-Source: ABdhPJzqhYzE8rSosQ1y35nYVPJCR/QBBweg90gLw/1MosTidp4k6pHMqgdf7sjn4nLxuVotsKjRUg==
X-Received: by 2002:a05:6214:19c8:b0:444:32f0:2351 with SMTP id j8-20020a05621419c800b0044432f02351mr2073117qvc.109.1649736086971;
        Mon, 11 Apr 2022 21:01:26 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([2607:fb90:50fb:900e:25ab:983d:ac30:58b5])
        by smtp.gmail.com with ESMTPSA id t125-20020a372d83000000b0069c1df12422sm3349402qkh.84.2022.04.11.21.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 21:01:26 -0700 (PDT)
Date:   Tue, 12 Apr 2022 00:01:23 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Stefano Brivio <sbrivio@redhat.com>
Subject: Re: [PATCH] staging: wfx: use container_of() to get vif
Message-ID: <20220412040123.GB2856917@jaehee-ThinkPad-X1-Extreme>
References: <20220407204128.GA1810425@jaehee-ThinkPad-X1-Extreme>
 <alpine.DEB.2.22.394.2204081149360.2196@hadrien>
 <20220408222102.GB2511628@jaehee-ThinkPad-X1-Extreme>
 <1911301.taCxCBeP46@pc-42>
 <alpine.DEB.2.22.394.2204091737130.2655@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.22.394.2204091737130.2655@hadrien>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 05:37:32PM +0200, Julia Lawall wrote:
> 
> 
> On Sat, 9 Apr 2022, Jérôme Pouiller wrote:
> 
> > On Saturday 9 April 2022 00:21:02 CEST Jaehee Park wrote:
> > > On Fri, Apr 08, 2022 at 11:49:49AM +0200, Julia Lawall wrote:
> > > > On Thu, 7 Apr 2022, Jaehee Park wrote:
> > > >
> > > > > Use container_of() to get vif. This improves the code in two ways:
> > > > > [1] it speeds up the compilation because container_of() saves steps to
> > > > > retrieve vif (the representation of ieee80211_vif), and
> > > >
> > > > I don't understand this part.
> > > >
> > > > julia
> > > >
> > >
> > > Thank you for your message. I revised the commit message (below)--
> > > I hope it makes it clearer. I'm open to suggestions as well!
> > >
> > > Currently, upon virtual interface creation, wfx_add_interface() stores
> > > a reference to the corresponding struct ieee80211_vif in private data,
> > > for later usage. This is not needed when using the container_of
> > > construct. This construct already has all the info it needs to retrieve
> > > the reference to the corresponding struct from the offset that is
> > > already available, inherent in container_of(), between its type and
> > > member inputs (struct ieee80211_vif and drv_priv, respectively).
> > > Remove vif (which was previously storing the reference to the struct
> > > ieee80211_vif) from the struct wfx_vif, define a macro
> > > wvif_to_vif(wvif) for container_of(), and replace all wvif->vif with
> > > the newly defined container_of construct.
> > >
> > > Sorry if I'm putting out more information than was asked for:
> > > Diagram is worth a thousand words; this one is made by Stefano when
> > > he was explaining the container_of() construct:
> > >
> > > .-----------------------------------.
> > > |  .------------------------------. |
> > > '->| struct ieee80211_vif         | |
> > >    |------------------------------| |
> > >    | 1                            | |
> > >    | 2                            | |
> > >    |  .--------------------------.| |
> > >    | 3| struct wfx_vif drv_priv   | |
> > >    |  |---------------------------| |
> > >    |  | ...                       | |
> > >    |  |                           | |
> > >    |  | struct ieee80211_vif *vif---'
> > >    '------------------------------'
> > > In this example, the offset is 3.
> > > What I want to convey here is the compiler already knows the offset
> > > of drv_priv within struct ieee80211_vif by using the container_of()
> > > construct. So, it doesn't need to do extra work.
> >
> > Wow, nice ascii art :)
> >
> > I think that Julia has not understand why you said it "speeds up the
> > compilation". I think you meant "speeds up the execution", don't you?
> 
> Yes, that was my concern.
> 
> julia

Understood-- Thank you Julia and Jérôme for catching my mistake and clarifying! 
