Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233C94C0178
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiBVSgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiBVSgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:36:45 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25C9B45AC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:36:18 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t4-20020a17090a3b4400b001bc40b548f9so439867pjf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tF6rmuMXtGk0hN9rsy+J8lsWYNzFCfbbxlyGFlvvvpU=;
        b=OIoGyXOeO/t2Mk5R8d6d7fd0wdXVR/yhMef7ZZxAihufd9Jffci4UcaQjXjXEXT5KI
         RomoElcCURCFnqgv5mUkEJwcgHOV/7VoOsAeO4vxIHY5bbnGVVDVO70q3K/kBtywNRVg
         z1zW4dq3VDpvEECOPAnZoc6nJ/e74qQX+D+BvYkZT55+tW/8ES3KfUDfL8XQK0Yhq+/K
         uvqywJGBI4HWKQl1kPGtY045NUZYazQAZ4ktmXn0gTAhTwcf9hV6v+Xp70xgNeVJKdRQ
         bXyOv8w2+3Pbx140eEs2fWN/qgxo+DRbBGJA6hMzDTCkr3Hgc0naCo8IJVmGcMz6QhnU
         81cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tF6rmuMXtGk0hN9rsy+J8lsWYNzFCfbbxlyGFlvvvpU=;
        b=D/PyDx82C1uYjm6f5J5hGAw5We3WeKkj/i5e1GZdPtrzBmavynQbUj8ls4iMUfRzOz
         6t5h35DZ97Jy5QnwrRCdgqtqdPr6Opv1RLGUvR3HexqV0r7ePoyv7vQv8uUWRmVvNIaY
         qTdvRJAwsYPUVP88N9JTAilBth3EN7I67g+pQUOapL9Hm9cY0Km9PbgkdUgjhLHh7Uh+
         V+tnYcVdB8sR8sN7oW/2meOrpKGE7gNhSum5QZ2P2vdQ+DLAFNHW6QOd812RhwCALHlG
         P/9kb13u5xdEb8e/imSPBJtqBfyRfjsZNs6ymB9vUTCGgl+mUVTc0AgMZ/ZiHoBwfJgV
         51UQ==
X-Gm-Message-State: AOAM533KhUOsIpcpIuKDMKlONHzt/17pOen7YUZFFwW0sXvzbRpxge2J
        vxMVToslQ4gEmC9pMNaToI4=
X-Google-Smtp-Source: ABdhPJwj09+7OtT89P7QurRXGQlSQLkksDLYY9izDrFCayHDeLuQj/x/gMvAvvsBXYsvYzPAkqR0dA==
X-Received: by 2002:a17:902:e743:b0:14f:c274:cc2a with SMTP id p3-20020a170902e74300b0014fc274cc2amr9192233plf.70.1645554978137;
        Tue, 22 Feb 2022 10:36:18 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090a8d8400b001bc386dc44bsm233029pjo.23.2022.02.22.10.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:36:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Feb 2022 08:36:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Bart Van Assche <bvanassche@acm.org>, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Haakon Bugge <haakon.bugge@oracle.com>
Subject: Re: [PATCH v2] workqueue: Warn flush attempt using system-wide
 workqueues
Message-ID: <YhUtIHtH2IAOWrEp@slm.duckdns.org>
References: <8ea57ddf-a09c-43f2-4285-4dfb908ad967@acm.org>
 <ccd04d8a-154b-543e-e1c3-84bc655508d1@I-love.SAKURA.ne.jp>
 <71d6f14e-46af-cc5a-bc70-af1cdc6de8d5@acm.org>
 <309c86b7-2a4c-1332-585f-7bcd59cfd762@I-love.SAKURA.ne.jp>
 <aa2bf24e-981a-a811-c5d8-a75f0b8f693a@acm.org>
 <2959649d-cfbc-bdf2-02ac-053b8e7af030@I-love.SAKURA.ne.jp>
 <YgnQGZWT/n3VAITX@slm.duckdns.org>
 <8ebd003c-f748-69b4-3a4f-fb80a3f39d36@I-love.SAKURA.ne.jp>
 <YgqSsuSN5C7StvKx@slm.duckdns.org>
 <2f887679-c783-bf18-a2aa-aa9a709bfb38@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f887679-c783-bf18-a2aa-aa9a709bfb38@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 08:22:30PM +0900, Tetsuo Handa wrote:
> @@ -335,6 +335,18 @@ enum {
>  	 */
>  	WQ_POWER_EFFICIENT	= 1 << 7,
>  
> +	/*
> +	 * Since flush operation synchronously waits for completion, flushing
> +	 * system-wide workqueues (e.g. system_wq) or a work on a system-wide
> +	 * workqueue might introduce possibility of deadlock due to unexpected
> +	 * locking dependency.
> +	 *
> +	 * This flag emits warning if flush operation is attempted. Don't set
> +	 * this flag on user-defined workqueues, for destroy_workqueue() will
> +	 * involve flush operation.
> +	 */
> +	WQ_WARN_FLUSH_ATTEMPT   = 1 << 8,

Maybe just __WQ_NO_FLUSH?

>  	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
>  	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
>  	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
...
> +static void warn_flush_attempt(struct workqueue_struct *wq)
> +{
> +	static DEFINE_RATELIMIT_STATE(flush_warn_rs, 600 * HZ, 1);
> +
> +
> +	/* Use ratelimit for now in order not to flood warning messages. */
> +	ratelimit_set_flags(&flush_warn_rs, RATELIMIT_MSG_ON_RELEASE);
> +	if (!__ratelimit(&flush_warn_rs))
> +		return;

If you're worried about spamming console while conversion is in progress, we
can just print the immediate (and maybe one more) caller with %pf and
__builtin_return_address() so that it only prints out one line.

Thanks.

-- 
tejun
