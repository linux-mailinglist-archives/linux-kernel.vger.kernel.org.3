Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A092539674
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347086AbiEaSob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbiEaSo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:44:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657B85BE54
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:44:25 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c5-20020a1c3505000000b0038e37907b5bso1763402wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ch7twLtw+5fNTAlbGEf7CksnVVIfOdFAcyFmxvHg4E=;
        b=AdZz1uQLCuoO0bLwU16jQM8/iOGi+/Wk+LpUbPQcScUtsNZ8RawmarHeY8x1eNaFcl
         pvJMdKTl5V9vBfVx9/2iCQA+WSB4KBhtJe3bCBN2J2h1GIiDS7IOAbcSwnUrCWnafOom
         GLqVX2TyUtyFMw0bnodUGggR5b4lcOn8kH/UTT1I0OV/Vuhf1x469wMdPw41cRDEbyXS
         qFbPdwsLHyfR+3uMvyOqqsbvyas0SxAs4KmpEUUWWZVHItlWLlVndKPcpvnqRbEz+Gj1
         gwCWlBrkkDQRnj+R3asvRpmmr6A7tlf08NsrA6K//VoCiiNY+SMwF3m/ZO9EebyK5NTX
         1Naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ch7twLtw+5fNTAlbGEf7CksnVVIfOdFAcyFmxvHg4E=;
        b=whbR5Yc6690/lULsD/Hq2HSXLF0pLhlKcDEbdr+8YX5AcERIjdOhdpPUPk/SFH3O95
         xsSQ/yvcmxQbMXRZmtm/aN94gyiEe2rX/NmjNlsoMYgN91wC0HFkHJlIPI+MqIEIf7W6
         q2rZki4cd0+VIHWzTGBJCq6IQt8jiKlxG/4tFUmE7/j6+GKqHhpOwwzztuhvwpWaqKEC
         y5QIFQ2j2VtI/f0MHzf14ebsm6qlv7WwIbVVN99wFlZbrQRmLren/4R33Ev7SFq9RAci
         n8Kkv4GevtLtR7h6uYUgvttzYR510qGQhpuE+SVehlfNzjwnIel8msmyEWTDCW92pQXR
         JQyA==
X-Gm-Message-State: AOAM5319rsrd9+H9qiXNQAn+mxZYRmNUqno2fKQPOkPp9aO7N4srNlq9
        kaRZYrrmVIzWhf8uHnXbscboFQ==
X-Google-Smtp-Source: ABdhPJylgXfGE/jENacaw6AV75unEpt8XBtrZATb2cTQ3noOVW6zfJv8r+BuUG9LdZNv6D6Dqm/1Wg==
X-Received: by 2002:a7b:c445:0:b0:397:28d3:d9cf with SMTP id l5-20020a7bc445000000b0039728d3d9cfmr24845740wmi.116.1654022663960;
        Tue, 31 May 2022 11:44:23 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb4a000000b0021003082534sm14432340wrs.36.2022.05.31.11.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:44:23 -0700 (PDT)
Date:   Tue, 31 May 2022 19:44:21 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 0/2] Fix some compile warnings in v5.18+
Message-ID: <YpZiBfFZrPkcCil/@equinox>
References: <20220531013103.2175-1-Larry.Finger@lwfinger.net>
 <YpW4WKxKIIgY0l7m@equinox>
 <bf78b567-5c69-c968-3dc4-6c94eeb8d77a@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf78b567-5c69-c968-3dc4-6c94eeb8d77a@lwfinger.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 12:16:58PM -0500, Larry Finger wrote:
> On 5/31/22 01:40, Phillip Potter wrote:
> > 
> > Hi Larry,
> > 
> > Both patches look good to me, however I've already submitted a patch 10
> > days ago that does exactly what your rtw_xmit.c patch does, in
> > addition to fixing the changed error handling semantics for the relevant
> > function (in f94b47c6bde6) which broke the driver.
> 
> Phil,
> 
> Sorry I missed your patch. I have been really busy the past month on another
> problem, and I was not paying much attention to r8188eu.
> 
> When I built a mainline kernel in the middle of the merge from 5.18 to 5.19,
> those two warnings stood out.
> 
> Your patch should be ahead of mine in Greg's queue, thus mine should fail,
> and I will get the "does not apply" message. At that time, I will send the
> other patch. As both of us missed the 5.19 merge, the build warnings will
> persist until 5.20, but no harm.
> 
> Larry
> 

Please don't be sorry - just wanted you to know in advance :-).

Figured if I said nothing I would probably aggravate the situation. I
don't have much time to spend on r8188eu myself either so don't worry.

All the best,
Phil
