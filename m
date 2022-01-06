Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFF4486B99
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244121AbiAFVF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244069AbiAFVF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:05:58 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F52C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:05:58 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g2so3644358pgo.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ihoowGKIlqCtCEF0ZrB21wpVHVfuaPYQtlyL5YV0Rn8=;
        b=o9Rr7nFutJ0GMZbaKGH6tjk7/Uai23hFte9AUIj+8ny68IwkOqrlw4zQj3BM4pltqV
         NPnY66A1sHjwVmbtkmqIUNrnbgzc9HePeSEYxj8hYeIo+0lKMYTLXPtqex0aEbdJ6fSN
         w+oiZy4EE+xywY1sOD7DUe5Dj80vjKmfL+3flY8i8tBMTn6kzmK8/e3huBD2PzeftNkb
         7nDHDxfUchpSBfWCiZy70YTZtV0vaBMpGBwyCTEZwuw1iWLuNhRpWIXtcijxC73CqQqf
         cD5CWoU0pO2YUmM2YJBZThO/TKhAukSyVf0v48KeyhpiKBYzAX/Bqx/8ZWuHQsmlS/xq
         ZQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ihoowGKIlqCtCEF0ZrB21wpVHVfuaPYQtlyL5YV0Rn8=;
        b=3Ylk82NlJOgTWBLsnHYV6UGCRkN6T4y/oPKKqqXbieHWWh4AYSTk/mOhKPrOjWQL/a
         QimWh/z/J8gm+vghyvpgRZeI2ruQoWH5vuosSQMv/VhkyvM8w0pmgcXbRGCTbFOyZjcX
         GqTN3irEIgyF/teX0Oc4ZTkqW/A+Z1R7/fMUrfCskL4xoGWul3dtUmMFpAXl12iq34o2
         HSPqWfMSZD+CUKwk+bjaa4xOFU7yy5EWa+RHFMZDF9k6d/oKdTx8hk/2Amhg9L2iyFQe
         w08VarJRBMWg5TePLzUwO7/j38A0+6DnmmcDoLvUlkXRMUQcmlFPK6Abf83w/Ooet13r
         VWTA==
X-Gm-Message-State: AOAM530hrnbctovHZ1pR3nMMPL9b0TG15R3hzvs0+vk1MQ/edmr2hhvo
        vST/wWPQAgySimed8ODJytg=
X-Google-Smtp-Source: ABdhPJx1zykPGFv9yF+foOIUKe8W3XGipkymzVW7Sk8mUbHkCwgXHCQV1UpDfm2HgmESlg9xFdRC7w==
X-Received: by 2002:a62:1996:0:b0:4bb:db58:9f6d with SMTP id 144-20020a621996000000b004bbdb589f6dmr51229828pfz.31.1641503158320;
        Thu, 06 Jan 2022 13:05:58 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id mu2sm3502368pjb.43.2022.01.06.13.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:05:57 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 6 Jan 2022 11:05:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linuxfoundation.org, ebiederm@xmission.com,
        mkoutny@suse.com, axboe@kernel.dk, keescook@chromium.org,
        oleg@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        jnewsome@torproject.org, legion@kernel.org, luto@amacapital.net,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org, security@kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCHSET v2 cgroup/for-5.16-fixes] cgroup: Use open-time creds
 and namespace for migration perm checks
Message-ID: <YddZtCtJpoFGM6Em@slm.duckdns.org>
References: <20211213191833.916632-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213191833.916632-1-tj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to cgroup/for-5.16-fixes w/ Michal's reviewed-by added.

Thanks.

-- 
tejun
