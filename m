Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0664E9D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244573AbiC1RXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244563AbiC1RXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:23:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A9760CD1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:21:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u16so21382587wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AA9VriTYf3jKrZYNetwW/7xvUoB3MbpeM0Zb2dqi/hA=;
        b=TdMydTYX3pbRo19Mbk4+TDMgMVeGK3c6zUvBYHggkBkGlG9cVCqp6oqanz5J4huQ2m
         A+8u1alcWk3SdfJIGGMDl7dPZqessWliCcYUWWvQ1XwwA1UggwBElxpDbESlerXUPqYi
         qo5c1JHbBKMcpAW0scCtmpNLH3ixlX7bEBdu/8M9+YYT8bRp9+MU7pOFS9EyKTa4nYAK
         PlcV0dpwDREDDhx1+4AYzFTS+LPM0XmstcQoSwT0B6NHgYo78J6Snyro4+0ggK1+ZyrA
         DzTdvdM9z6X9ZNd890TSPJlGv2HejfGdcwfQzEHRt8HBrUeQAr7NJOTG4BY7AoUqDi50
         ztgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AA9VriTYf3jKrZYNetwW/7xvUoB3MbpeM0Zb2dqi/hA=;
        b=SK1VIYR4S4/9KIr0fYMZIDzawUhbnFdXoX/1+zKp3xTCkt10HeqeR8S6LHmHaBe57w
         5Qgz7cutFAG6eXJyZtxgVE+46DU7vGGF0mJ5oKyOrFl4Y5KISrTEUeZrecGQZcSnI/sd
         xRXW1fMJeUS1ukwfMa4lhkdI6foOj6s5z5OJnETsY1DhPx+2EDKaEFYRKskfDRCPDEhf
         Rv0APNMnRhXldaiWq9/4o6TSs3HuUXngM+9MPY/kO6YBb4VVqg04P5RWyLRz2Q+QqOq7
         Fz42rsFJZt9rbRouSPFk/3tEVGRoiI14Ru/qADGj2xh/UQ+R0/bcDAU3DicQUOW6C2rt
         TyIg==
X-Gm-Message-State: AOAM530kYpUdL+tUZrrDypjZ8213zbP8hQc4Uz1W8s98Ku+OF6289KSL
        Nu/NSK+3iFkRNehzFWXD8t8=
X-Google-Smtp-Source: ABdhPJybT//Aze1al+8a/xDU3kHsjC3Zs4UGHQYU6nb5u88vRwpBFo1985eB55KiQTGkRtX8r8ovDg==
X-Received: by 2002:adf:e483:0:b0:203:f946:396 with SMTP id i3-20020adfe483000000b00203f9460396mr24891290wrm.548.1648488090667;
        Mon, 28 Mar 2022 10:21:30 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm175034wmq.27.2022.03.28.10.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 10:21:29 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Philip <benjamin.philip495@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Charlie Sands <sandsch@northvilleschools.net>,
        Mitali Borkar <mitaliborkar810@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Convert kmap() to kmap_local_page()
Date:   Mon, 28 Mar 2022 19:21:26 +0200
Message-ID: <1816944.CQOukoFCf9@leap>
In-Reply-To: <YkHXQRmExRFioEBN@iweiny-desk3>
References: <20220328112440.17756-1-fmdefrancesco@gmail.com> <YkHXQRmExRFioEBN@iweiny-desk3>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned? 28 marzo 2022 17:41:53 CEST Ira Weiny wrote:
> On Mon, Mar 28, 2022 at 01:24:40PM +0200, Fabio M. De Francesco wrote:
> > The use of kmap() is being deprecated and kmap_local_page() is faster.
> > Use kmap_local_page() in place of kmap().
> 
> Thanks for the patch!  

Thanks for your review!

> I have just a couple of comments.
> 
> kmap_local_page() is not necessarily faster than kmap() but it is more correct
> in this case.  You should mention why.

Sure, my mistake. Thomas G. was talking about kmap_atomic() when he wrote that
it is "faster". It does not apply to kmap_local_page(). 

What could justify the use of kmap_local_page() is that "The mapping is per 
thread, CPU local and not globally visible.". Therefore this code is the right 
context where to use kmap_local_page() in place of kmap().

At this moment I think that I might change my commit message and write something
like the above.

However, I'll research more information during the next days. In the meantime 
I'm also going to take a look at the differences in implementation.

> Also to help with kmap_local_page() there are a number of helpers implemented
> in highmem.h for things like memcpy, memmove, etc.
> 
> Check out memcpy_page() for this use case.

Aren't memcpy_to_page() and memcpy_from_page() better suited for the two 
different branches of the "if" statement?

Thank you,

Fabio M. De Francesco

> 
> Thank you!
> Ira
> 
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/staging/rts5208/rtsx_transport.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
> > index 805dc18fac0a..de690d7ee5e3 100644
> > --- a/drivers/staging/rts5208/rtsx_transport.c
> > +++ b/drivers/staging/rts5208/rtsx_transport.c
> > @@ -92,13 +92,13 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
> >  			while (sglen > 0) {
> >  				unsigned int plen = min(sglen, (unsigned int)
> >  						PAGE_SIZE - poff);
> > -				unsigned char *ptr = kmap(page);
> > +				unsigned char *ptr = kmap_local_page(page);
> >  
> >  				if (dir == TO_XFER_BUF)
> >  					memcpy(ptr + poff, buffer + cnt, plen);
> >  				else
> >  					memcpy(buffer + cnt, ptr + poff, plen);
> > -				kunmap(page);
> > +				kunmap_local(ptr);
> >  
> >  				/* Start at the beginning of the next page */
> >  				poff = 0;
> > -- 
> > 2.34.1
> > 
> 




