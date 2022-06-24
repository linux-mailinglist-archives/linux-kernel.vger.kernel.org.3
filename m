Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D44F559A75
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiFXNiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiFXNht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01BFB52E5B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656077858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iihGsDJaCfgB0U9H9bTk3P+5uHXU2Udgo4mdhsEY1hk=;
        b=Royy/kYSZQmbA8kjAokE+eg67UWwe37hREQM4pAAKdvjOxKJdJ/Nc/7waUVv9pfXgk0qWq
        mBO+ZUUq3HLE9NYqMiI3JUiglLRwiSwLwSkl494rV9mXJ+nffqdlipTAHZHO8eL9Sp4N4V
        QRNoHE2e3XrD9PjIfqJASy/GpWvrJ6g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-9iHzjYXuO1KmlERCulCrrA-1; Fri, 24 Jun 2022 09:37:36 -0400
X-MC-Unique: 9iHzjYXuO1KmlERCulCrrA-1
Received: by mail-wr1-f70.google.com with SMTP id s7-20020adfbc07000000b0021a558c09b4so341022wrg.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iihGsDJaCfgB0U9H9bTk3P+5uHXU2Udgo4mdhsEY1hk=;
        b=asbpT29KYA6T0mQT/x5xhUgpfG3ZBCVZrz1sST1u4Do+p3iWh9ChmYRcqLoyZs3INW
         BT4m70+ZXXtO0IEGZHVuTnQflTPMlcpcGmhyoE1qn965ygpAhDEsBuuJgdty/ytm8VC7
         1cTVmsKWqUrCpKTUQUv5sRhjlF/00y6gCl06WefFyHHGDO1bglFPqgrwz8a6Fvd6nw3N
         1PsCFLK67BWsbIdN9lepkb27vliDvkodRlD2nWQSja1c7P6Fn/fTfM3TzUrrDlHxFELt
         N48EiwT1i05oBGGJlKaTW5Sdv8ydm6az1m70+qrB2oavhDROtef9mzalBmiTP0J0Ncxt
         2PqA==
X-Gm-Message-State: AJIora8WQK/r+c89AlDREl/wjxWfD3c+Z0kIU8Mxz3FwYQHr17PQEmQc
        ZzCBLQC6FqOuXsNSiVb40Uf2YkAZytyG7Z2226a9ScvaTKx4EZMTG7ADZgVj9xafxe7zYzGcUQK
        vUHC+ZZG1E7z++vNHBQVXV3G+
X-Received: by 2002:a05:6000:1373:b0:21b:ae65:cd38 with SMTP id q19-20020a056000137300b0021bae65cd38mr5758329wrz.323.1656077855326;
        Fri, 24 Jun 2022 06:37:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t5kxEQLYP7f2/L7To0n1AeI7/BBSZOapMMFe+ZmhaXEaq7njP/DHXIEAivdtbuhzGRbNBfxw==
X-Received: by 2002:a05:6000:1373:b0:21b:ae65:cd38 with SMTP id q19-20020a056000137300b0021bae65cd38mr5758301wrz.323.1656077855110;
        Fri, 24 Jun 2022 06:37:35 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id h6-20020adffd46000000b0021b96cdf68fsm2300843wrs.97.2022.06.24.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 06:37:34 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
In-Reply-To: <YrUTsJiIQb583fKy@MiWiFi-R3L-srv>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <YrUTsJiIQb583fKy@MiWiFi-R3L-srv>
Date:   Fri, 24 Jun 2022 14:37:33 +0100
Message-ID: <xhsmhsfnu5giq.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/22 09:30, Baoquan He wrote:
> On 06/20/22 at 12:15pm, Valentin Schneider wrote:
>> @@ -94,14 +94,20 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>  	/*
>>  	 * Because we write directly to the reserved memory region when loading
>>  	 * crash kernels we need a mutex here to prevent multiple crash kernels
>> -	 * from attempting to load simultaneously, and to prevent a crash kernel
>> -	 * from loading over the top of a in use crash kernel.
>> -	 *
>> -	 * KISS: always take the mutex.
>> +	 * from attempting to load simultaneously.
>>  	 */
>>  	if (!mutex_trylock(&kexec_mutex))
>>  		return -EBUSY;
>
> So kexec_mutex is degenerated to only avoid simultaneous loading,
> should we rename to reflect that?, e.g kexec_load_mutex.
>

It's also serializing crash_get_memory_size() and crash_shrink_memory();
more generally it should still be the preferred serialization mechanism as
it's a "proper" lock visible by instrumentation, the atomic variable is a
side character for the NMI case.

