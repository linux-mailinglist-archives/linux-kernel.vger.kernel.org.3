Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A593759C923
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238317AbiHVTmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbiHVTmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988D048E8F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661197333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J4GHfux6w3/w2b7KxiBzPcOgQglBM7+/Ly21ZzyiIj4=;
        b=hORPowuShSYQuTkquq7jSW6d6T6YXylBG5mDm7OSBHtoMDsPWctEdWgUxZ4VNNFzOO4oj2
        zROcHzWqhKCexMD2o7JLfRRWvLVzWq4EQmQn+BS3zQQP9JP4mBCPMo4cLePgG6raKHdIMZ
        g6v9owAVdjTY3r2Joo0InNvERT8Atcs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-177-84Mc871iORGgtb6blSAVqA-1; Mon, 22 Aug 2022 15:42:12 -0400
X-MC-Unique: 84Mc871iORGgtb6blSAVqA-1
Received: by mail-qk1-f199.google.com with SMTP id v13-20020a05620a0f0d00b006b5f0ec742eso10399096qkl.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=J4GHfux6w3/w2b7KxiBzPcOgQglBM7+/Ly21ZzyiIj4=;
        b=GdzGtKi3D9HFHqRIJxmGLflTncpRrknRCachuLxU+2BDmgR/7dV3T9py1jRZLdD+wI
         fiTxU3kFpcw36a40RFOZ5NAG8MN5DB6GG8EdDwrcE0bNuRfkYZxh2CKDQS9clmLNvmaJ
         v5cVvf+9gKWUfL5knRu+Fl4sBO6192Es+f0Wz3bc5XZOzKAlD37tdyBzztvFomFCY96K
         BrWJpfJWonIn5RD8VYDGt5mhReSDNiMrECcKlkGyoxTj25DEzxZlSbErlj2y67a8slnq
         4Aw23p2KifoKQgp2loWWfjcS7h9IPHflzRdNe/mizvfA3rDtM21kgKyrDaOzcPPte8yv
         CUXg==
X-Gm-Message-State: ACgBeo01M+oOKU/nE6IyYNjXnlCcTLkz7TeLk1ybMSdMBJBYFvhmI/Yw
        lH6n3rQRXA6/WAqOr2sT68dqBbu5CGHdjokbu2LUcmCxYjaEE9/ElR28JXZWAPeu1NSR1frDT6y
        cFLy0CM0/XmG+dDCW0bvRDwS9
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id s13-20020a05620a254d00b006ab84b825ebmr13533960qko.383.1661197332136;
        Mon, 22 Aug 2022 12:42:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5IEzuFn0RfsfxXNTzE3MUceYDNF8SxLxnAMuUUMZCTNC28EXLcXLDtyXi4dTDnDXzhCL/qCA==
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id s13-20020a05620a254d00b006ab84b825ebmr13533948qko.383.1661197331901;
        Mon, 22 Aug 2022 12:42:11 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::48])
        by smtp.gmail.com with ESMTPSA id c13-20020ac8054d000000b00343681ee2e2sm9309351qth.35.2022.08.22.12.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:42:11 -0700 (PDT)
Date:   Mon, 22 Aug 2022 14:42:09 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, bmasney@redhat.com
Subject: Re: [PATCH] regulator: core: Clean up on enable failure
Message-ID: <20220822194209.b7mpb3wgvqwjybg5@halaneylaptop>
References: <20220819194336.382740-1-ahalaney@redhat.com>
 <YwATSglfJEgG6V73@sirena.org.uk>
 <CAD=FV=UWn8a9C3j0Ky9JWqo_2AvOE=ORVP94zHftGQLsxFdXyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UWn8a9C3j0Ky9JWqo_2AvOE=ORVP94zHftGQLsxFdXyw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 04:03:24PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Aug 19, 2022 at 3:48 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Fri, Aug 19, 2022 at 02:43:36PM -0500, Andrew Halaney wrote:
> >
> > > -     if (regulator->uA_load && regulator->enable_count == 1)
> > > -             return drms_uA_update(rdev);
> > > +     if (regulator->uA_load && regulator->enable_count == 1) {
> > > +             ret = drms_uA_update(rdev);
> >
> > I am vaugely surprised and a bit concerned that drms_uA_update() can
> > fail...
> 
> In his original email Andrew implied that his system was misconfigured
> when he was seeing this error. I presume this isn't common which is
> why nobody had noticed this before now, but given that the function
> drms_uA_update() does return an error code it seems like we should
> handle it properly in the caller.

Doug was right, I thought my devicetree was bad. But after spending the
morning trying to write a reply about why exactly it was bad, I realized
that it might not be that. I agree with him that this patch makes sense
(to me at least) regardless.

Here I am reporting on how a recent change in qcom-rpmh-regulator.c made
this appear (no idea yet if the change is at fault, or if I've got some
other misconfiguration though in my devicetree!):

    https://lore.kernel.org/all/20220822193153.zn2oxljmd76awqot@halaneylaptop/

Thanks,
Andrew

