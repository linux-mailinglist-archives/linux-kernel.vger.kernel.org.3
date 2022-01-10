Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F034489316
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbiAJILf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239601AbiAJIL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:11:26 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBFCC06173F;
        Mon, 10 Jan 2022 00:11:25 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g11so41402042lfu.2;
        Mon, 10 Jan 2022 00:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+MlSZiq9RqylWqDh0sRZineCftjbqoTJy5wCtgk/PXk=;
        b=lKs1E7vhWP22buArl+muj6kwVzs6P90Xz+OW+m5epbct4jtpfJmTrAwey0yQvMtz+b
         +NPW9kec6s2A0PCpVh4kNBEZwSHvkth+HT9iiCdRewCko1pQvoq3bzkKRTGVx0QF+lNF
         YCrNTK4UowVvsIITmc30TChYZ/lbq65CeSPIG+x/icbAA4bt97oK1DCGbLklA7+YkUxI
         l4qBWrzjLe5UBNPryO4vlnltEiHcSoS2GfvfK8werJztcC6KKau4cqFxoD0884Nz5uHV
         hGi80jYoD/ukwzyRhKw7twvz06zOQ9QXokpLOJGkRaJQRptCX+ZTQJAHMPv19mgCdGKs
         Kong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+MlSZiq9RqylWqDh0sRZineCftjbqoTJy5wCtgk/PXk=;
        b=1g5jV5+qAp6P9H15TD02uZx8maXs62D+wBmkjLUTN+rlvBJM8Fclepa6yk36hkFzXQ
         d68Cu0JwG5r12MReK3csWNObYV4oFO354UG9Rxge7wG3khpxNJlHSH+aNFVp2cJjPn4e
         zdZ3/gLfJ0rDcgSkw8SngFSzzcLtqw2qSb64/ZK8tGhX6Mztetr2DARFZhenYDt1S+W1
         OIGKzMxTXFQIKZEE1+fHge784SqL7RgxRNPYcVfSZE3Y/qWKZXfcVBJ0vFXX3l6YCE6z
         nZyB9l31Nc/g6f8LdAHmDh3/mgiZs/TMDsUkS0q8EKAHBqN8CADNMTEeNEC5r3IH0Q47
         ay2g==
X-Gm-Message-State: AOAM533mLoCTMNYcq7eqzYIe9XW8mf39D9xEK78boAj2YlbX6qLARyVA
        +OHUq3/2E3Xf3ltAjkd7i7s=
X-Google-Smtp-Source: ABdhPJyvAK15Ft/TN00MXnX0QnPG8re5XR1Yf1yQQ2tWZqRZdFUQ2pjijp4dqVOXxkvwbc/sD+nIew==
X-Received: by 2002:a05:6512:130b:: with SMTP id x11mr33805576lfu.660.1641802283674;
        Mon, 10 Jan 2022 00:11:23 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id w7sm950690lfd.36.2022.01.10.00.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 00:11:22 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 7B2335A0020; Mon, 10 Jan 2022 11:11:21 +0300 (MSK)
Date:   Mon, 10 Jan 2022 11:11:21 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Pintu Kumar <quic_pintu@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, ebiederm@xmission.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        sfr@canb.auug.org.au, legion@kernel.org, sashal@kernel.org,
        chris.hyser@oracle.com, Colin Cross <ccross@google.com>,
        Peter Collingbourne <pcc@google.com>, dave@stgolabs.net,
        caoxiaofeng@yulong.com, david@redhat.com,
        Vlastimil Babka <vbabka@suse.cz>, linux-api@vger.kernel.org
Subject: Re: [PATCH v2] sysinfo: include availram field in sysinfo struct
Message-ID: <YdvqKWokVKgC0fDv@grain>
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
 <1641578854-14232-1-git-send-email-quic_pintu@quicinc.com>
 <YdiqLKS5Sv9eWwu2@grain>
 <CAOuPNLhcvbk3-rTPqmJj5LBOh4VaZ+Bc=-_j6xKOLM-kH6jkfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLhcvbk3-rTPqmJj5LBOh4VaZ+Bc=-_j6xKOLM-kH6jkfw@mail.gmail.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 09:54:37PM +0530, Pintu Agarwal wrote:
> Thank you so much for your feedback...
> I had a need to get total/free/available memory in my application (on
> a memory constraint system).
> First I tried to parse these from /proc/meminfo but then I saw sysinfo
> already provides some information,
> however available field was missing. Just to get available field I
> need to again do all the file operations.
> 
> Then I saw, even the "free" command doing this redundant work.
> Use sysinfo system call to get "total" and "free" memory then again
> get "available" memory from /proc/meminfo.
> Yet again, I see, even in kernel its reading from two different places
> while populating the /proc/meminfo.
> Also, I am sure there are plenty of other applications where this can
> be improved with this.
> Moreover, I think with this field there is not much use of other ram
> fields in sysinfo.
> Thus I felt a need to introduce this field to ease some operations.

Thanks for explanation.

> 
> > Don't get me wrong please but such extension really need a strong
> > justification because they are part of UAPI and there is not that much
> > space left in sysinfo structure. We will _have_ to live with this new
> > field forever so I propose to not introduce anything new here until
> > we have no other choise or parsing meminfo become a really bottleneck.
> >
> My guess is that this situation might exist in other places as well ?
> How do we handle new field addition to existing system calls ?

If there is no space left in uapi structures then we simply can't extend
the syscall, since we're not allowed to break api. an option is to deprecate
old interface and introduce a new one but this is a painfull procedure that's
why i'm not convinced that we should extend sysinfo right now. but final
decision is up to mantainers of course.
