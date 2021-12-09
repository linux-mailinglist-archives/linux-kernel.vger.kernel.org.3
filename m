Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C1746F4C1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhLIUSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhLIUSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:18:41 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36436C061746;
        Thu,  9 Dec 2021 12:15:07 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so5934242wmi.1;
        Thu, 09 Dec 2021 12:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UpOHznmuWyfzyJGYZKWpvpptLU0bCNBsLqMfixSniLA=;
        b=JiQ8N0lIkkYeNQfo56n7WlvF8GupU3Ueu9BFvUJI06cDBAVjNpOW50fyCskPYnMFN7
         axBheVhgdpwoPZE6x171seWPlRYU7mS11mDQTbpB8/JFMN8AkmHkMV9vwQdFuk7lbVHh
         13gcXh1yGjyroSPWdY/MDlXSRqjTzdKJbg88ifMuhYxaokhpXNNi3YSpmXAqp+DY8oYx
         X/I4AhfXIFqVhjhq24XSPPw+r5JpDJN9AyUP1x/0hQ8Sq/hzr7ECsQN9IvwsAowo11DQ
         KC1cNaCdfraXYRlmrFePj+GXXSjLYljSLlEuCyeySk7q3Zbqi/x8p7GH7lvA+7iMY/90
         UngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=UpOHznmuWyfzyJGYZKWpvpptLU0bCNBsLqMfixSniLA=;
        b=O9aUxYOd0as3/bQwUMFjwwtv50/vz/ACtFvHpk35Dv0JftwqFW57fhhKS9bK0B8SSU
         02ruZN47BngagCZ8jIGVRVd7Zx6EdY64w7gJy3Ne6f02csxIj72q/IINEp+AESSBIOKU
         b1zlCbgsvkjt+945jeHMLYmqC5Te6ClFUH9sZN3ITBYB6a0FL6sStqwTsH5gBkJG9gwZ
         dsaGCVR4vICj9y3ChbUFqALb9LBqzDrtg9O8WZG6Z9NOGo8u+MbV6V9OS2y2n2NpHJmx
         NhvnoPNJsEfrd7r9CUs7bSWzPExWNqAZu9s7GHEbXmNckXVHSa/p8yxEjGwZJQoGe+ki
         Mm/w==
X-Gm-Message-State: AOAM530yhPs44Y8z1A1fTC3dw0d2TxvfKhgYlYNLAu74pxBIFMRBQdBg
        f3cw0Xn7zBGQAiz4kGbmGlL4Uy60T1HC2g==
X-Google-Smtp-Source: ABdhPJwbxi9Ru8FHQ++cIWXnVMdV4c4F71qdwB3gluKRQiZ87SvUfKv78DYdFtbDtThxSilJGdCjZA==
X-Received: by 2002:a05:600c:3658:: with SMTP id y24mr10181648wmq.161.1639080905693;
        Thu, 09 Dec 2021 12:15:05 -0800 (PST)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id n2sm9689063wmi.36.2021.12.09.12.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:15:05 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Thu, 9 Dec 2021 21:15:04 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        German Gomez <german.gomez@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf dlfilter: Drop unused variable
Message-ID: <YbJjyMRIcW49HVXa@eldamar.lan>
References: <20211123211821.132924-1-carnil@debian.org>
 <5603b487-3e42-cfbd-200b-250c46dc0bc6@arm.com>
 <YbCS/xEis4QKbH6D@eldamar.lan>
 <YbJW9sHObkXC5lcz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YbJW9sHObkXC5lcz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 09, 2021 at 04:20:22PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 08, 2021 at 12:11:59PM +0100, Salvatore Bonaccorso escreveu:
> > Hi German,
> > 
> > On Wed, Dec 08, 2021 at 10:44:01AM +0000, German Gomez wrote:
> > > 
> > > On 23/11/2021 21:18, Salvatore Bonaccorso wrote:
> > > > Compiling tools/perf/dlfilters/dlfilter-test-api-v0.c result in:
> > > >
> > > > 	checking for stdlib.h... dlfilters/dlfilter-test-api-v0.c: In function ‘filter_event’:
> > > > 	dlfilters/dlfilter-test-api-v0.c:311:29: warning: unused variable ‘d’ [-Wunused-variable]
> > > > 	  311 |         struct filter_data *d = data;
> > > > 	      |
> > > 
> > > Did you get this warning when issuing "make"? From my side, it generated
> > > this gcc command so I didn't get it (make DEBUG=1):
> > > 
> > >   gcc -c -Iinclude  -o dlfilters/dlfilter-test-api-v0.o -fpic dlfilters/dlfilter-test-api-v0.c
> > > 
> > > Reviewed-by: German Gomez <german.gomez@arm.com>
> > 
> > Only when passing -Wall (this is the case when building the kernel packages in
> > Debian with additional flags, so this is why this was spotted):
> > 
> > gcc -Wall -c -Iinclude  -o dlfilters/dlfilter-test-api-v0.o -fpic dlfilters/dlfilter-test-api-v0.c
> > dlfilters/dlfilter-test-api-v0.c: In function ‘filter_event’:
> > dlfilters/dlfilter-test-api-v0.c:311:29: warning: unused variable ‘d’ [-Wunused-variable]
> >   311 |         struct filter_data *d = data;
> >       |
> > 
> 
> So I'm applying this, its an obvious cleanup, but please CC the author
> next time, I'm doing it in this reply, Adrian, ok?

Yes right, I apologies for that, something went wrong when I generated
the list of people to contact using 

./scripts/get_maintainer.pl ./tools/perf/dlfilters/dlfilter-test-api-v0.c

and write up the persons to contact.

Thank you!

Regards,
Salvatore
