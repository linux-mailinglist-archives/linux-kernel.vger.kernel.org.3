Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E556529C99
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243353AbiEQIfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241839AbiEQIfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A31D43ACF
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652776530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R9Q3Ybr/A+KH6Q6IRTVG7OKDqcb8C3K/4ZYVZVJz/JQ=;
        b=YFGY3q6A2L+dBe70nIfS1HljewV2oFCLoh6dDRkbayqQQUhxKrvq5LA3BCUfpg4PNlBUk0
        GvPT4xHmdzvZWroDFOsPSQuVRvAqg7H1GjwfH+w8/FGrxngkS9d4ke+ZsLyT7O5S+nHh2x
        RWG3JKBmBNmmtNOCsrn4Mb4mPij+Mrg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-pnH4RoGEPL2IBFELIu9N5A-1; Tue, 17 May 2022 04:35:29 -0400
X-MC-Unique: pnH4RoGEPL2IBFELIu9N5A-1
Received: by mail-wm1-f71.google.com with SMTP id k5-20020a05600c0b4500b003941ca130f9so7895127wmr.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=R9Q3Ybr/A+KH6Q6IRTVG7OKDqcb8C3K/4ZYVZVJz/JQ=;
        b=SgryO+0TOJnhDSByOzuPjKqQ0+fRBHowWvYov6j2rk2HpKFDSWAAmmx1UCZ2c8vEod
         aDyewLv3sugXMcAE3Vg7/pTry/o2k/GjjiFzt9PqW0s5madj3PsgaeQGzkVm3lPceJtM
         cEJx3B2CBlhEJ/T0jkw21YXmD8nfAhPdcwyTR8g/krxT/D01zM83Ye8DL5hpgQ/GxnMU
         YlVkLbwqdnmDdeOX0Y9MVp34LKbMEcPgcpauSBpe6hUeuaaldjDIZR5dbTFzAvInRS3x
         s8IIi6w2s9PIIVjgExjRg0deS/P6AXWSYUXctWyRKDg4YGzCHqsnM8daamz6cNgft58S
         P09A==
X-Gm-Message-State: AOAM53101KfyLK1Z0tnz2Ibk4AOUn0AA6N9vQJWDiAsa+FlS94HRz2tP
        tWkbEQS3BmxctPVCRDcvvCTYiEyq5MMHmum2dgp9IqLYg32wtLLoCfr7rrvtFGs/CPMPaNAuppz
        LVyn/gfoE8/HSKxNPZrO3357V
X-Received: by 2002:a05:6000:18ab:b0:20c:8d82:52c3 with SMTP id b11-20020a05600018ab00b0020c8d8252c3mr17376046wri.701.1652776527979;
        Tue, 17 May 2022 01:35:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynNDaHlWT281tDMJcjSUvSYFm6lWCzrbIbx4uNhf1j1RzE3YF7n118/uFtQmBSHPZ318R+hg==
X-Received: by 2002:a05:6000:18ab:b0:20c:8d82:52c3 with SMTP id b11-20020a05600018ab00b0020c8d8252c3mr17376026wri.701.1652776527671;
        Tue, 17 May 2022 01:35:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id q4-20020adf9dc4000000b0020c6b78eb5asm11047086wre.68.2022.05.17.01.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 01:35:27 -0700 (PDT)
Message-ID: <eec880be771e75d60ead01cbf71d83fe070ccde8.camel@redhat.com>
Subject: Re: [PATCH 2/2] octeon_ep: Fix irq releasing in the error handling
 path of octep_request_irqs()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Veerasenareddy Burru <vburru@marvell.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Satananda Burla <sburla@marvell.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        netdev@vger.kernel.org
Date:   Tue, 17 May 2022 10:35:26 +0200
In-Reply-To: <20220517052859.GN4009@kadam>
References: <cover.1652629833.git.christophe.jaillet@wanadoo.fr>
         <a1b6f082fff4e68007914577961113bc452c8030.1652629833.git.christophe.jaillet@wanadoo.fr>
         <20220517052859.GN4009@kadam>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-17 at 08:28 +0300, Dan Carpenter wrote:
> On Sun, May 15, 2022 at 05:56:45PM +0200, Christophe JAILLET wrote:
> > For the error handling to work as expected, the index in the
> > 'oct->msix_entries' array must be tweaked because, when the irq are
> > requested there is:
> > 	msix_entry = &oct->msix_entries[i + num_non_ioq_msix];
> > 
> > So in the error handling path, 'i + num_non_ioq_msix' should be used
> > instead of 'i'.
> > 
> > The 2nd argument of free_irq() also needs to be adjusted.
> > 
> > Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > I think that the wording above is awful, but I'm sure you get it.
> > Feel free to rephrase everything to have it more readable.
> > ---
> >  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> > index 6b60a03574a0..4dcae805422b 100644
> > --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> > +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> > @@ -257,10 +257,12 @@ static int octep_request_irqs(struct octep_device *oct)
> >  
> >  	return 0;
> >  ioq_irq_err:
> > +	i += num_non_ioq_msix;
> >  	while (i > num_non_ioq_msix) {
> 
> This makes my mind hurt so badly.  Can we not just have two variables
> for the two different loops instead of re-using i?
> 
> >  		--i;
> >  		irq_set_affinity_hint(oct->msix_entries[i].vector, NULL);
> > -		free_irq(oct->msix_entries[i].vector, oct->ioq_vector[i]);
> > +		free_irq(oct->msix_entries[i].vector,
> > +			 oct->ioq_vector[i - num_non_ioq_msix]);
> >  	}
> 
> ioq_irq_err:
>         while (--j >= 0) {
>                 ioq_vector = oct->ioq_vector[j];
>                 msix_entry = &oct->msix_entries[j + num_non_ioq_msix];
> 
>                 irq_set_affinity_hint(msix_entry->vector, NULL);
>                 free_irq(msix_entry->vector, ioq_vector);
>         }
> 
> regards,
> dan carpenter

I agree the above would be more readable. @Christophe: could you please
refactor the code as per Dan's suggestion?

Thanks!

Paolo

