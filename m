Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F334148EC18
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbiANPAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbiANPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:00:29 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57170C06161C;
        Fri, 14 Jan 2022 07:00:28 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e9so16116962wra.2;
        Fri, 14 Jan 2022 07:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TUU+DMa7U3mjpjYCA+HNoEJPTDawZ7oiEXnBDzYpIQ4=;
        b=b3RFYe7/XHj7ObWRTcs3pjWGVbt3+gM9uVFlpJwpzMW0C1ctPeenn/MyAmsVBBVeGA
         +ZUjO6vS9nMnXPnDhPujXoztWypjxq3mEdok+zvImur9ei+1Gd+r3fMNjFIISkAKmlYq
         WfUjrFvYg2WNfdntHbJX12n4r2KNbxqb4cgFd7tXZEoMquIOODyMka1jMJhq8KauEbTz
         yt1EKqNaRpw5gUP62/JYim5D3Q9iEDG4Z82GIzv2rGkzy8929+uq2gDnh1bglacPvz4/
         hL/sJhUkVNQx2NiVn0JP8uCfA0nvVR/TJHX236I+6+t9a5hPKUHqOiRYT/aNfvBQR79J
         WlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TUU+DMa7U3mjpjYCA+HNoEJPTDawZ7oiEXnBDzYpIQ4=;
        b=y5pJKGPkEPavbLlxFvMqzBVzsl731v1510OJGTJwTJ57YpZ0038tRZhoaKAYffBaGs
         142dOa3JND96T3akLog9pQQcruyUOany/N76QlylLeFkH7i+fobpNfBQUvmDQPJY3Owy
         vwHVmPm8qJjYY0EJ6j2oTqZWLuUnPrL/Vj/ztkh0m8AdVxXQL4JlDK30acOD+BVtg48i
         YdGZhOfZ4isnicy+9XzAcLBaypHw9Js8RywTlinn3Gpk6Fp86iw2QeQQo3Jm6qqkDpWb
         HrImXOLKAy3YebQ9DDYSu1exGIW7b9GNbjSBqdPMmms5u5tf5aen7qpzr6u1KmGPHxgw
         tejA==
X-Gm-Message-State: AOAM531xTZsFEdn/MOz3btR+xmLQ5hiMP+WadDtRigG22ESpWTC3o1+L
        uP40q20ZtN5U7LtrCr2qPNC4Ti43iatTEA==
X-Google-Smtp-Source: ABdhPJzKSJQ53YkPS8o4b5mIenTlKqDuobOxTGikalxpM3OfJ7vwhurUzG3DIlk2axwuQNEnX3OQ5Q==
X-Received: by 2002:a5d:5590:: with SMTP id i16mr7911949wrv.34.1642172426900;
        Fri, 14 Jan 2022 07:00:26 -0800 (PST)
Received: from elementary ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id c22sm11516936wmr.27.2022.01.14.07.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:00:26 -0800 (PST)
Date:   Fri, 14 Jan 2022 16:00:24 +0100
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf util: Fix use after free in metric__new
Message-ID: <20220114150024.GA5646@elementary>
References: <20211208171113.22089-1-jose.exposito89@gmail.com>
 <CAP-5=fUAR9uSAQGkukqafkoX+jz1fE8f-ziU5WeG59XT53jMWw@mail.gmail.com>
 <YeGNDskRtgpIFmzU@kernel.org>
 <44b8de2c-b976-a396-2363-61a014d7e71f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44b8de2c-b976-a396-2363-61a014d7e71f@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 02:48:35PM +0000, John Garry wrote:
> On 14/01/2022 14:47, Arnaldo Carvalho de Melo wrote:
> > > > Addresses-Coverity-ID: 1494000
> > > > Signed-off-by: José Expósito<jose.exposito89@gmail.com>
> > > Acked-by: Ian Rogers <irogers@google,com>
> > > 
> > > This can only happen in the ENOMEM case, but it is a good fix.
> > > 
> > > Fixes: b85a4d61d302 (perf metric: Allow modifiers on metrics)
> > Sorry, I missed this one_as well_, sigh...
> > 
> > - Arnaldo
> 
> 
> Isn't there a v3 out there? Not sure if you noticed...
> 
> Cheers

Yes, here is v3 including the Fixes, Acked-by and Reviewed-by tags:

https://lore.kernel.org/linux-perf-users/20220107182106.138418-1-jose.exposito89@gmail.com/
