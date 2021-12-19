Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688D547A25D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 22:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbhLSVaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 16:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbhLSVaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 16:30:14 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17469C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 13:30:14 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id u22so12815982lju.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 13:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lA7KgPxPYpHDfTxG46FBZ4dlzGm+BkeZaFrnHni8o60=;
        b=R5MUM+v8QoMZxvAO8cPHIyS4JDe2iOT9QBKSOwu3Q8zjiL/xfuaElxukX+qyAbRV19
         6+AYEgPaMzf3xEUoUGXLAieCEaRsF2g0qizgGPtUPs4BRRkH8cfdQoG4EbGoRLYbuHs+
         HCZdQBRHo/gcx0KtL/ADU+HhN1Lq8AnFld5Ly2cvM3tHZEyeXiRThMOdMiDQY2TqetUH
         zbMFy7vHXWMZupN5hvvHW/Yng5EUeclsqEhBf+m7XrGqonxcE6wp2LUzNNBSXSZSb66+
         VQxb4u/TJiN2ssTm0mi8Iw3OY9YGFNMQPchzT5USoTztFQrA6cT7fd4sVLevPimLElMh
         AtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lA7KgPxPYpHDfTxG46FBZ4dlzGm+BkeZaFrnHni8o60=;
        b=0U3YWUlF8Ljcu6oNKH84hXgkqiLEJd0nnzQY1fqpwVCUAGnu/LUQnJfeHSXPw7rdOL
         pgTDjh082Le4GWy8k4OsnHnWti85akTqr0ySaEy9Lsfqen8hadWHYLlm0faR+0jKnrbQ
         do9AYSF5y5+R+JLJ3Wib532EwosWHru453d1zyBpv+aMG8FpQkdRiGoaDcKer1tqA8RT
         /Ee1U7bp7jN+AzzqwH/HgPIRZYAw8us+ii0nMbGusLplZsCMZCRC2aUfAwvE6poA1ldG
         fpVEuEHEqQOqVeSmcDjntN773Kra7kaVxvMnA7nkAPWiGwcFeEp/kz+e7CVcOESvf4mD
         b68Q==
X-Gm-Message-State: AOAM532c/M02znpK3mG1j+yuS/6EleihKuGvrUtlfhBI6bHkPlU2PYjH
        YPOXNSY8lXrx6XCnW5UpT9oZqxO5is4l3A==
X-Google-Smtp-Source: ABdhPJyPqhXDPGVPydtqb5rpDKs4o5lVVGIv/pTnRxqO0h2UBOatU5yIeDZ60UCnLuIm4y3LUtBOmw==
X-Received: by 2002:a2e:5445:: with SMTP id y5mr12058699ljd.189.1639949412372;
        Sun, 19 Dec 2021 13:30:12 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id o9sm1253003lfk.247.2021.12.19.13.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 13:30:11 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 853FA5A0021; Mon, 20 Dec 2021 00:30:10 +0300 (MSK)
Date:   Mon, 20 Dec 2021 00:30:10 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Barret Rhoden <brho@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rlimits: do not grab tasklist_lock for do_prlimit on
 current
Message-ID: <Yb+kYqLVbL3N9d/4@grain>
References: <20211213220401.1039578-1-brho@google.com>
 <8735mww2w3.fsf@email.froward.int.ebiederm.org>
 <456a056e-453e-71b0-0f9e-03511b9f56b1@google.com>
 <87zgp1psd3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgp1psd3.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 01:42:32PM -0600, Eric W. Biederman wrote:
...
> 
> > If it's too much of a risk/ugliness for not clear enough gain (in code
> > quality or performance), I'm fine with dropping it.
> 
> Removing the tasklist_lock where we can is definitely a clear gain.
> 
> Simply shoving tasklist_lock aside and making the code more complicated
> is much less clear.
> 
> Plus anything you can benchmark (even microbenchmark) and show the
> benefit of is welcome.  Especially when you have indications that it
> makes a difference in a larger context.

Thanks for looking into this, Eric! I must confess I've a vague memory
about this code. Still while you're talking about cleanup I wonder if
we should make do_prlimit() being a static function, not global as it
now.
