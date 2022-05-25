Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726B2533FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbiEYPJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237638AbiEYPJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 556DAA5025
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653491374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ccrjSda3Gg6tpH9tIUthKiP8+yaV2mjgmcEAdhHoFPY=;
        b=dK1YXAa/B9vYO8m0/gond9zTv4JnF9fxli7Ni9APuuWu8ubFXUM4Xstq8guNkgnFVJybQL
        BIypE78H1kcM0mz3MxoFiEUg2Ll5Q2gU03PwNf30YUKovUhdcnJj7GO9x/vMJx+9V01hH3
        xSuXdDXlYMHynM3f/n+8SRIadTJzbCw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530--SfwkLv-Ptap7oP-y3zFSQ-1; Wed, 25 May 2022 11:09:32 -0400
X-MC-Unique: -SfwkLv-Ptap7oP-y3zFSQ-1
Received: by mail-wm1-f71.google.com with SMTP id c187-20020a1c35c4000000b003970013833aso8501012wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ccrjSda3Gg6tpH9tIUthKiP8+yaV2mjgmcEAdhHoFPY=;
        b=z9cjGBcrO+bOe+WxdOIKnWj9A47ItZU98ZupOG3SdlELxKpKcJaLZ3sIVsZBsbyn//
         AaVCs/b+V9I9nnsJobmp2LVKbi6HAImLvRg8e/KE7cCpcwVIX0IHmvcID5aCPpuClBxu
         a/WK3gy2vc/DQY0Be/4tohkMFGgrJMfEhd9MVu8L6cW9b2TLPEkRI5l75I5xJryfagK+
         4ZneI8sdQqvxRzQt5wcJ9o+5kll0dL5Y9HwNaVuv6dBASzib1lBeZu2RvVVFLhofKhnZ
         mGAdCMBlRz6xOg0QWcCx0Fa9W8oiFlZt+s+UtUDpQ4Hs3+iJIs6Rtoq6qLeuznokLszn
         eBUg==
X-Gm-Message-State: AOAM533k2jIipa3Wb4TS/Zd0hYUm/fPWWr5R5g/8muww1/rsND2XI7Fw
        /KEwFkTBDw4YW8c/mO7r8ta6gytpS0sI6syijwn1gBa8V9c4J2lLR4O3VZGkbKYRFTD/9MCN728
        NqNReMZAoQk7nHrwIuLR4XCwp
X-Received: by 2002:a7b:c202:0:b0:397:4c68:169d with SMTP id x2-20020a7bc202000000b003974c68169dmr8666816wmi.133.1653491371173;
        Wed, 25 May 2022 08:09:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmDHyT61UQhL1XhRMmWMUjuk8ZGdNPPSPcffz1qg6VoAHfDK5nF7B9kbqhvWWNAigHQDf19Q==
X-Received: by 2002:a7b:c202:0:b0:397:4c68:169d with SMTP id x2-20020a7bc202000000b003974c68169dmr8666795wmi.133.1653491370979;
        Wed, 25 May 2022 08:09:30 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id m13-20020a5d624d000000b0020fe43fca50sm2399143wrv.91.2022.05.25.08.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:09:30 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpuhp: make target_store() a nop when target == state
In-Reply-To: <20220525133133.GA5500@pauld.bos.csb>
References: <20220523144728.32414-1-pauld@redhat.com>
 <xhsmh35gzj77s.mognet@vschneid.remote.csb>
 <Yo0KRVpfhUb8Ta4N@lorien.usersys.redhat.com>
 <xhsmhy1yqhrio.mognet@vschneid.remote.csb>
 <20220525133133.GA5500@pauld.bos.csb>
Date:   Wed, 25 May 2022 16:09:29 +0100
Message-ID: <xhsmhtu9dir86.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/22 09:31, Phil Auld wrote:
> On Wed, May 25, 2022 at 10:48:31AM +0100 Valentin Schneider wrote:
>>
>> Yeah it would be neater to not even enter cpu_{up, down}(), but my paranoia
>> makes me think we need the comparison to happen with at least the
>> cpu_add_remove_lock held to make sure st->state isn't moving under our
>> feet, otherwise we may still end up with target == state in _cpu_down() and
>> hit the bug you're describing.
>>
>
> This is what I was originally doing before I tried to "optimize" it:
>
>          if (st->state < target)
>                  ret = cpu_up(dev->id, target);
>          else if (st->state > target)
>                  ret = cpu_down(dev->id, target);
>
> This does the check under the lock and just falls through if state==target.
> I think I'll go back to that version.
>
> I also noticed while testing that the boot cpu does not get its target set.
> It's got state 233 but target 0.  So reading that out and writing it back
> on offlines cpu0.   I'll try to find where that is not getting set.
>

If I had to guess I'd say it's because the boot CPU doesn't go through the
regular hotplug machinery and sets its state straight to CPUHP_ONLINE

/me digs

Maybe around this?

void __init boot_cpu_hotplug_init(void)
{
        this_cpu_write(cpuhp_state.booted_once, true);
        this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
}

