Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B384709CB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbhLJTKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhLJTJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:09:59 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFFDC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:06:24 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r5so8828020pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZMjqd61KOFOzqKxqVCYZcFhh+AEgXiRDekZvsMc4HD8=;
        b=DwN56LnVniDb8xU8V/fE3ACrHDyNi2nAljz8rrjh3ZTuYCJ76R4ce6xGBZhP2/BGpU
         GQIChpRFr1q4uJCt9S7r6MBp0aKAe8EAc2IyTwidMywvNfL3PlbuAcVmRBRu9pFfhnmG
         wCKOn6YRkQ4D2kkzeWEmbvKi5wWHFZd71nPUQ3J8uZQFA5ayA31yhuMsD5UKguvo7xNY
         wUJv0C4QGSndo68WjCp8YpsR2WC29bdmqNinBsftQcbwi6qiMpTClV6Ng1E9w1dvemPv
         CGui79whDn3gEAY32t/qK7qQAWZj1c/YGABcHRHINzfqdYERruRE/5oQ1H/LTmGGmf+w
         m30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZMjqd61KOFOzqKxqVCYZcFhh+AEgXiRDekZvsMc4HD8=;
        b=wo9IBQSbvXsL+TX3Ax2P+3mdIuDBsQvd2yWlO33i+kX9eaDALre3CimTIcBHgCqQ+y
         qwhAix3mMroTOTx+MARVaWnuh9XlHtdVf6da+ZAT+eizpy46pQ1Zj/ES6ywrhPW/iUXd
         37DloZferHqEsnyi2tvXGG4CgUg+lnn8Z9Rr3woXNWQ+kTDHidJtGHae3u1O8P/smKMr
         EkHbSL4tg7GOPw1KdaUEElvvXhPbkMknECeHSLi5L9wX9UfTq+xewWUwV8tnUZ7ItEIh
         LUiArSJ5ZoZN55UMe+lX/leymVK/h4EOJl7HWEKXvG1ErWihnCGQkOhjJr2O6nomgBbW
         fgTg==
X-Gm-Message-State: AOAM532Z6f43m/+iPajpS6/MpuGr6oLvaJYlD/fcnpa9cz15VnpnrKfY
        7l4sAFvfayPqhWG7DKUQ9+4=
X-Google-Smtp-Source: ABdhPJxURYPQPQ2u2pwXbUdLksq/11ey5rTDWLQOaxeANw+hU9ZwCcm0CNnlnuqWmk93ZD2INeB31g==
X-Received: by 2002:a62:1813:0:b0:494:5d7b:864d with SMTP id 19-20020a621813000000b004945d7b864dmr19564332pfy.23.1639163183487;
        Fri, 10 Dec 2021 11:06:23 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id y31sm4240198pfa.92.2021.12.10.11.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 11:06:22 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 10 Dec 2021 09:06:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Koutny <mkoutny@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Newsome <jnewsome@torproject.org>,
        Alexey Gladkov <legion@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 2/6] cgroup: Allocate cgroup_file_ctx for
 kernfs_open_file->priv
Message-ID: <YbOlLawFDdS0hkpd@slm.duckdns.org>
References: <20211209214707.805617-1-tj@kernel.org>
 <20211209214707.805617-3-tj@kernel.org>
 <CAHk-=wgiYkECT=hZRKj8ZwfBPw2Uz=gpOGBGd4ny0KYhSsjC0w@mail.gmail.com>
 <YbOeiu5+DZQsJbm8@slm.duckdns.org>
 <CAHk-=wgVUBc+9UVYp=uhyqTTw-QTHNrJow1Av+1jB4_Va93m1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgVUBc+9UVYp=uhyqTTw-QTHNrJow1Av+1jB4_Va93m1A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 10:45:33AM -0800, Linus Torvalds wrote:
> But if it then ever becomes a possible source of confusion and it's
> not obvious from the context who uses what, I'd rather use the extra 8
> bytes in the allocation.
> 
> Ok?

Just so that I'm understanding you correctly. The following is what I was
suggesting. ie. just dropping the union and making the iterator embedded:

  struct cgroup_file_ctx {
          struct cgroup_namespace         ns;

          struct {
                  struct css_task_iter    it;
          } procs;

          struct {
                  void                    *trigger;
          } psi;
  };

and I was wondering whether you wanted something like the following:

  struct cgroup_file_ctx {
          struct cgroup_namespace         ns;
          struct css_task_iter            it;
          void                            *trigger;
  };

Thanks.

-- 
tejun
