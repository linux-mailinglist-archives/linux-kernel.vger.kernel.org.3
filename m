Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282C04838CA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 23:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiACW2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 17:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiACW2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 17:28:18 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC25C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 14:28:17 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so1135106pjp.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 14:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=scLme1me/0UxlFwtDPAEkrpt4SJIwSBGjImUO7Hvan8=;
        b=F89F64Oh0gYb1DYapXQNgjUITveKUu0OV6oM4B/4RDoodqY2nAR+EexPKklhohGfAx
         W3tb/mGgwIQU7U3x9oU5bozXzZfbYqmuseRyu8xVvoOOg44r19Z/H0EM3ylxBT91pWLn
         lNeHlm4f9ZEzePdt5aBjW1TM2MWM0p+mDJXonaWgwrep8nsatqChgyLSRtUQMtK0IqLY
         wdxjEhj7kjQf8/teJNE98QVxSZW9FWR9ek3v0djD/VzaYw4hvETTkfwe9CbUWRx584x3
         KyKtMwHHYntNDgG8tm0A9ElPTAiggQo1WmjG/vpYYISbRG6VIwbDN+uVvUKlMEZOWSe0
         jZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=scLme1me/0UxlFwtDPAEkrpt4SJIwSBGjImUO7Hvan8=;
        b=OyX5/5ZJvFvV5ulMMNhsHLVkV2edclAHYNldRZ4VnExF97Ta1bRX/lFraz92B8NOdF
         PgXrdJpFT179Ib2KuCDLI6BjnJFETgpAmxXfoptRIDJWrD+7b1zIcFJdUNjuzDBcKFtV
         B7dY3v2huQXlc+RvX0rqbt1LunAJ3gsUEW4T0YoCGqn31/057GHkhQt3lcvUZUP1zN79
         5mS1pAWdwN54qrFMAYrLpC23HsoUh47JExLagH3G7dVuz0iT486/fI4ANt90VASUTEvz
         +mMmSyxofJYyEXifVXJxuJJelPkARN1DO2U0JVCKEitwONiiKsWqcuUIGqU8cntzXsh8
         QD5w==
X-Gm-Message-State: AOAM532jviff/m5zni0UQ9ScWK1AmYB4VMhpbmrJl7kl/Y6lavUZv0JU
        nW7e7upeV61T350lZmYF5n8=
X-Google-Smtp-Source: ABdhPJw5Eh9ze8vem7JU3X38Brouv0NzrOiB7e98/fWKYp9QBYY6dQ6jHK+N3CtndO/3A82N0A5Azw==
X-Received: by 2002:a17:903:228f:b0:148:d5d0:5be0 with SMTP id b15-20020a170903228f00b00148d5d05be0mr47419628plh.104.1641248897119;
        Mon, 03 Jan 2022 14:28:17 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id b65sm38452265pfg.209.2022.01.03.14.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 14:28:16 -0800 (PST)
Date:   Tue, 4 Jan 2022 11:28:11 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>, fabioaiuto83@gmail.com
Cc:     realwakka@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: fix frequency deviation check
Message-ID: <20220103222811.GA6995@mail.google.com>
References: <20220103081135.GA11642@mail.google.com>
 <YdL5rtWw2PTXdsRM@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdL5rtWw2PTXdsRM@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 02:27:10PM +0100, Greg KH wrote:
> On Mon, Jan 03, 2022 at 09:11:35PM +1300, Paulo Miguel Almeida wrote:
> > -	// calculat f step
> > +	// calculate f step
> 
> This change should be a separate patch.
>

Thanks Fabio and Greg for reviewing my patch. I just sent a v2 of this
patch with that line untouched.

thanks,

Paulo A.
