Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05AA55FFC8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiF2MXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiF2MXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:23:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 982651EB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656505415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D4xckCgJ4Bw0w9xbbVbINWepGBRVBzb5aJNwu4HG9GY=;
        b=MUk4+8DZ9vaOOyJG99XLyLqnjld4/nDfTKuEyCLRTHP0VjM+huhaKtytZL3ysf5AXqRN2k
        FnhiPjxCidfbmDi5ut1qst96dSyfvGQsQv1tW+iSRhD6pQD0Fuj4sdrRWfYXWBCfM2Mtrz
        hxLyWVUwU+nUfVaIuAKNG+r2H59y+BA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-cCEXTSNGMhKkmNAUso5MSQ-1; Wed, 29 Jun 2022 08:23:27 -0400
X-MC-Unique: cCEXTSNGMhKkmNAUso5MSQ-1
Received: by mail-wr1-f69.google.com with SMTP id e5-20020adff345000000b0021b9f00e882so2358855wrp.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=D4xckCgJ4Bw0w9xbbVbINWepGBRVBzb5aJNwu4HG9GY=;
        b=efwEq4f+XtJBdgHkEM5uNk8ohNXZO4K19QwaQbDeu7Oh8aGDJmA7nN170RkWerbQpK
         yelgib6HCwPWuhjxqRXEvB2n6UyKxg06w/RMXEJzIsd1/y7PcFsrpLmBdL6g7qUgBpRy
         d1MY692ck/IG8aVZW32SpULtXcA2LC1TllDkrb6IWU+E+HmNoarAkyaVTknWat2dQdZ3
         jxn/8LnqHddG7b7g2Y3JAsACR5oQr5aLZ7Zbw5sv88vJcLrgp81pEu7ZpnCQLzpdse5b
         HPWMIuFt6tBvgORLGvUnSOY1tCP3P0RdScXITth8XCFTCllAYEZM9K+Lu2UOHMkGgyy7
         oqOw==
X-Gm-Message-State: AJIora8B7/7HHYYj/ISELjX+sIjT+IrWFazAFJ6t0g33bOS+FOwmUFm0
        SmnPuqRdb+1dhp9OrgBce8HNokRcF0L9dwQ/vcVunnyJsDfheGZmzo9ZRMF2O2oBx+dhRas3qFV
        ywY1x19CRc8cR2LauFs5EocOd
X-Received: by 2002:a05:6000:1281:b0:21b:9c01:df79 with SMTP id f1-20020a056000128100b0021b9c01df79mr2793340wrx.563.1656505405847;
        Wed, 29 Jun 2022 05:23:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v9pJO/EqSfuHhWYEuTzIM+Ml0Cf5xYU+IXYXEoEGJo5PASFAvTCOcpNz8z35DuzQpGGt5rXw==
X-Received: by 2002:a05:6000:1281:b0:21b:9c01:df79 with SMTP id f1-20020a056000128100b0021b9c01df79mr2793306wrx.563.1656505405591;
        Wed, 29 Jun 2022 05:23:25 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id o12-20020a1c750c000000b003a04b248896sm2888552wmc.35.2022.06.29.05.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:23:24 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
In-Reply-To: <20220629115539.GB12720@pathway.suse.cz>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <87r13c7jyp.fsf@email.froward.int.ebiederm.org>
 <xhsmhpmiu5lch.mognet@vschneid.remote.csb>
 <xhsmhmtdw66cr.mognet@vschneid.remote.csb>
 <20220629115539.GB12720@pathway.suse.cz>
Date:   Wed, 29 Jun 2022 13:23:08 +0100
Message-ID: <xhsmhk08z64lv.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/22 13:55, Petr Mladek wrote:
> On Tue 2022-06-28 18:33:08, Valentin Schneider wrote:
>>
>> 8c5a1cf0ad3a ("kexec: use a mutex for locking rather than xchg()") was
>> straightforward enough because it turned
>>
>>         if (xchg(&lock, 1))
>>                 return -EBUSY;
>>
>> into
>>
>>         if (!mutex_trylock(&lock))
>>                 return -EBUSY;
>>
>> Now, most of the kexec_mutex uses are trylocks, except for:
>> - crash_get_memory_size()
>> - crash_shrink_memory()
>>
>> I really don't want to go down the route of turning those into cmpxchg
>> try-loops, would it be acceptable to make those use trylocks (i.e. return
>> -EBUSY if the cmpxchg fails)?
>
> IMHO, -EBUSY is acceptable for both crash_get_memory_size()
> and crash_shrink_memory(). They are used in the sysfs interface.
>
>> Otherwise, we keep the mutexes for functions like those which go nowhere
>> near an NMI.
>
> If we go this way then I would hide the locking into some wrappers,
> like crash_kexec_trylock()/unlock() that would do both mutex
> and xchg. The xchg part might be hidden in a separate wrapper
> __crash_kexec_trylock()/unlock() or
> crash_kexec_atomic_trylock()/unlock().
>

Makes sense, thanks. I've started playing with the trylock/-EBUSY approach,
I'll toss it out if I don't end up hating it.

> Best Regards,
> Petr

