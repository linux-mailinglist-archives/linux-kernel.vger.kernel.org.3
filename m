Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147BA580191
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbiGYPTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 11:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbiGYPTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:19:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0C01EC6F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:16:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h8so16429491wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CVCQ8tfKIFEzeVExE0kyLHNTa2ByqIgAnCfadhZ4mCU=;
        b=kC+Ks2aAX/NG7lgXCqWZc0gBkHZkddcZb8xh9mAOY+8Hd1Jjo6/ShYoE88KxSCm5jb
         YAPDF04OQiHmHgNnX9N5CySstP+K4L3WC1PoZH9RGTEFr2GaWo3YtckD7qv25dVhdC1B
         iAzCFpuEpcfNhPy4dZ0R2EeJMikulV/awSJRzX9xC842sMlVypJJZ0+uJBxNYDZ/bLPG
         Z7BDg9KYNauRpOm5aJ23P7GjIM1vUhZEVjyH3LD6oFDcImCL7x8uPdWFKI6mc02sLnX1
         ZsZx2QkXBnQcg/rlwcOHM6k+yhkm5mYIWL2WTYNerzesTbXxyIBNXsqGACg1bezaVwh9
         8Ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CVCQ8tfKIFEzeVExE0kyLHNTa2ByqIgAnCfadhZ4mCU=;
        b=PZ4001gUOstMAPkRa2098Tg6ndaBLLvexmqAx4w3eoMYn7Zmi6Paa1QB6qwiZZUMN4
         hvCWSiJD3RcPxb/GmJlPgscLtSfpRdCtYl6AJj+faZhXmms7ZF2TFZxKInFy1gh0yv1M
         vsE9BZp1SYY+/1Au3oTVGdMTSLkQGt9RqNkj8g7wI15Yaq826nzprR71vGsQsAK0alyS
         irpXeSdUjsreY9iSEbYs2GlhdENat0Y4LbpdfbRcaLvRwq2nioeQJ037beqJZTPjSXC5
         NsAZkmQuxqIBIsVOfZgZjHAYE37KVC2DofRV3isIoG6HVewu7MvqIWuXLlWG63NjMcB+
         7D3g==
X-Gm-Message-State: AJIora8+0OvUW1T/gtN0L804mAFc9i9s7unLQMiOZbVy/W9wPJVwmvaz
        +qQsmQrx+GgIrQKZxIJrHYpshA==
X-Google-Smtp-Source: AGRyM1sh4JJsyv01o1pTUbJe94X2a7ENfgNJU4V6N4BSs8qOE65ALareUatP6q2m7IQMLo1dco9MJA==
X-Received: by 2002:adf:e188:0:b0:21e:9291:44ab with SMTP id az8-20020adfe188000000b0021e929144abmr1820465wrb.106.1658762175058;
        Mon, 25 Jul 2022 08:16:15 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b003a31fd05e0fsm34364843wms.2.2022.07.25.08.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:16:14 -0700 (PDT)
Date:   Mon, 25 Jul 2022 16:16:10 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        kernel-team@android.com, Derek Dolney <z23@posteo.net>
Subject: Re: [PATCH v5] cpu/hotplug: Do not bail-out in DYING/STARTING
 sections
Message-ID: <Yt6zuvatUa0gtYjn@google.com>
References: <20220725095952.206884-1-vdonnefort@google.com>
 <xhsmh1qu9fcxo.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh1qu9fcxo.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 04:07:47PM +0100, Valentin Schneider wrote:
> On 25/07/22 10:59, Vincent Donnefort wrote:
> > The DYING/STARTING callbacks are not expected to fail. However, as reported
> > by Derek, drivers such as tboot are still free to return errors within
> > those sections, which halts the hot(un)plug and leaves the CPU in an
> > unrecoverable state.
> >
> > No rollback being possible there, let's only log the failures and proceed
> > with the following steps. This restores the hotplug behaviour prior to
> > commit 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=215867
> > Fixes: 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")
> > Reported-by: Derek Dolney <z23@posteo.net>
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > Tested-by: Derek Dolney <z23@posteo.net>
> >
> 
> The changelog has some undesired stowaways below, but regardless:
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>

Arg indeed, my bad. But thanks for the tag!

> 
> > v4 -> v5:
> >    - Remove WARN, only log broken states with pr_warn.
> > v3 -> v4:
> >    - Sorry ... wrong commit description style ...
> > v2 -> v3:
> >    - Tested-by tag.
> >    - Refine commit description.
> >    - Bugzilla link.
> > v1 -> v2:
> >    - Commit message rewording.
> >    - More details in the warnings.
> >    - Some variable renaming
> >
> 
