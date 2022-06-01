Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD71053AB1F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356173AbiFAQjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356163AbiFAQjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF7B671A34
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654101571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1sspQ35G5aSQ+++l6IYriZ0Sm6pA3iBlqPQBAXhh4bU=;
        b=TW6MRvHG6EeUdWnfXup85t0IwQIA5zCevt1WLcE7lzUvNv20qn1N2AjKaMI6BTWZnh0USd
        qBOfTplsw+OnPNjtPz0N0zazrMJfCGPAYIVNfQR32EZpiyhAOSfePbSaein2gro0EgG9QO
        6WVK14cGB4MFObYcbiC+vnKJs6Fmzeg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-O3AKFw3LMqCPZ1_XvLd74w-1; Wed, 01 Jun 2022 12:39:30 -0400
X-MC-Unique: O3AKFw3LMqCPZ1_XvLd74w-1
Received: by mail-wr1-f72.google.com with SMTP id p10-20020adfaa0a000000b0020c4829af5fso410014wrd.16
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 09:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1sspQ35G5aSQ+++l6IYriZ0Sm6pA3iBlqPQBAXhh4bU=;
        b=tufjXtWGLX6IU6WIB6S/OG1bxLpfqxjXmIvAlk6izpMzHtjyYVyb6qXaRwtXXoYtiZ
         NbWlZLgBGOKaPS5ZZvXpoTUCTv4hCVhpTG2+JGKB4Rd2auRSMBXDp9th+rdAMqlMExMk
         1FbV6dC3CZntJeH9eiQ1f4g5wCFLP7QzeaF7FqxjLK3uHlsG5+2pgK0m8xTJ8EGCsQk9
         5vlnyHZQgfdFQ02rj98DGasMay6NUHkMVarT/Ah72pJT9vRSK+u4WZTOKH/eMbCppVZ5
         ZIjqag97HEyfJje5WWe6gzNdL3U1tzScnAHI+epalMIj5VGQLvBp2IDKo+XBWwMXCA6q
         WJDQ==
X-Gm-Message-State: AOAM530XwNJYhn4csQP5tFTVelz1POeMmLySh9B2BFzuwcORbLcP76QE
        QWgxFSBblAVFkWuOkF4BfFmrklNuTKQ43+H5KvHWjRX9Q2bwPjC6D5lgLygUDv3hxhcHe4y3XAM
        SbecMoakTefFg99x9X2KMEOmB
X-Received: by 2002:a5d:6445:0:b0:211:7eee:2f94 with SMTP id d5-20020a5d6445000000b002117eee2f94mr212788wrw.631.1654101567892;
        Wed, 01 Jun 2022 09:39:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+oyTibnD2fH+x88YRR3uMOPXJb33nGoeYz9A06MHI3sF5tASGhvljiq3v+668gECf62nP5w==
X-Received: by 2002:a5d:6445:0:b0:211:7eee:2f94 with SMTP id d5-20020a5d6445000000b002117eee2f94mr212772wrw.631.1654101567648;
        Wed, 01 Jun 2022 09:39:27 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d6042000000b002102baa2370sm2094843wrt.100.2022.06.01.09.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 09:39:27 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] cpuhp: make target_store() a nop when target ==
 state
In-Reply-To: <YpeKkVVp+/JWuxUi@lorien.usersys.redhat.com>
References: <20220526160615.7976-1-pauld@redhat.com>
 <20220526160615.7976-2-pauld@redhat.com>
 <xhsmhy1ynl3hr.mognet@vschneid.remote.csb>
 <20220527132156.GB26124@pauld.bos.csb>
 <xhsmho7zf8auj.mognet@vschneid.remote.csb>
 <YpeKkVVp+/JWuxUi@lorien.usersys.redhat.com>
Date:   Wed, 01 Jun 2022 17:39:26 +0100
Message-ID: <xhsmh8rqg8hj5.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/22 11:49, Phil Auld wrote:
> On Mon, May 30, 2022 at 01:27:00PM +0100 Valentin Schneider wrote:
>> 
>> Yeah, you could append a simple:
>> 
>>         else
>>                 WARN_ON(st->state != target);
>
> I was thinking more like:
>
>       	 else 
>                    if (st->target != target) st->target = target;
>
> Since this is a write to the target field and we are not
> doing one of the operations that will set target because 
> state == target we should make sure target == target. Although
> that could have its own issues, I suppose. But as I said
> fixing the boot cpu should make it much less likely that
> st->target != st->state once we have the hotplug lock. 
>  
> I don't see how that WARN would ever fire. We're under the lock
> and nothing is re-reading the value of st->state anyway. Looks more
> like a compiler sanity check :)
>

Right, having a warning in there would mostly be to catch
unexpected/unintended scenarios like the one you've found for the boot
CPU. I'd vote for

WARN("Huh, didn't expect that")
+
fix st->target

>
> Cheers,
> Phil
>
>
>> > Maybe I'll include that if/when I have code to keep cpux/online in sync
>> > with st->state and cpu_online_mask.
>> 
>
> -- 

