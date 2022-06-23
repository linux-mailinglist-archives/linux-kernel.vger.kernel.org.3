Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD40557FBF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiFWQ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiFWQ0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:26:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641FF4504A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:26:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so54309pjj.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g8uL4Cnos+tnqMRM/pR25DTlUlkkTtmxJhV6l+Yrd1g=;
        b=iq5Nofk2xDryk147dU/ZEzGYE5R3sJqvrdrhWA+r1L+t0r6bE6P+1TaIEdNkrJqCB/
         Wjjy8ratdufNJKZyfwQu4YmbE3RVOD87F75MQbXVPsiFKf+C2mB7atafn2LS6CtKH/Os
         lqgOU8ZsaX4aYxfQCfMzO5re9+IbiBu8wbYJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g8uL4Cnos+tnqMRM/pR25DTlUlkkTtmxJhV6l+Yrd1g=;
        b=vI04D+0qwCwgT7LB/K4xTObt/bu2XZBtvvmkfFFj75p8PkLy2k2dZvVZ4N6wgJGeUH
         6QTMW3xjw+WzqUsEbsK6JbkJgr+6ZsU+0Oeo551achbOKksnRd6z/1O60aT0/d31LOhb
         CBebCsKOiTSBD6KVljJQEKWJy9HWpQVuG3NoomFI8x/mFV/4Idy7K3d6GeT57rj0h8Ss
         18Jd5PwjOHEd0nH0Xd9Tz3uszGdVLdcZDvzwSTVgiLWt02jG49pqagxLnwWCk84Aczc8
         puruoNIvYIXjtfF8OLtj/C6wKFMAVYSFVWkFd0+f8slHhzG58vvzhhRv2Q/3L2/lFMk+
         g/dA==
X-Gm-Message-State: AJIora8qsCw0ErAssVUcDM5Zxv2EdCGn7mxHpOgR0iAT9IKynTISd4QL
        11ekgUch6r/GHTJ3Pna5PLcreQ==
X-Google-Smtp-Source: AGRyM1vZYkVfdqhPecRvHa8SQIPJmMPxgpo/hrHswx5SewkcMf+oXPMK42iOKzJucOlu1xgGYsy1bQ==
X-Received: by 2002:a17:902:d905:b0:16a:2917:73dc with SMTP id c5-20020a170902d90500b0016a291773dcmr20464902plz.6.1656001561800;
        Thu, 23 Jun 2022 09:26:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id az5-20020a170902a58500b0016636256970sm12712658plb.167.2022.06.23.09.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 09:26:01 -0700 (PDT)
Date:   Thu, 23 Jun 2022 09:26:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/8] scsi: aacraid: Replace one-element arrays with
 flexible-array members
Message-ID: <202206230924.A8A4D005@keescook>
References: <cover.1645513670.git.gustavoars@kernel.org>
 <20220310040347.GA2295236@embeddedor>
 <yq1h77zdg37.fsf@ca-mkp.ca.oracle.com>
 <20220315042223.GA2385465@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315042223.GA2385465@embeddedor>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 11:22:23PM -0500, Gustavo A. R. Silva wrote:
> On Tue, Mar 15, 2022 at 12:02:13AM -0400, Martin K. Petersen wrote:
> > 
> > Gustavo,
> > 
> > > Friendly ping: who can review or comment on this series, please?
> > 
> > I'm afraid I don't have any hardware to test it on and the generated
> > output differs substantially from the original code.
> 
> Yeah; this series requires careful review from the people that
> knows the code better. 
> 
> It took me a day of work to go through all the places that needed
> to be changed due to the flexible array transformation. However,
> due to the kind of changes, it'd be great to have a second opinion
> or at least someone that could take a look at the changes.

If the int/size_t changes are separated from the array size change, it's
easier to see the array size change is a binary no-op. (i.e. diffoscope
shows no executable changes.)

I'd recommend splitting the int/size_t changes from the array size
changes.

-- 
Kees Cook
