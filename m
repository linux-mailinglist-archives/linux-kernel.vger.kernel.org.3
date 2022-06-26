Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741EE55B151
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 12:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiFZKph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 06:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiFZKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 06:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0711212AF7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656240334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6InSV56Wmf/Ott/MhJFHAADQ4Uv/vbzwSYycypoeAmU=;
        b=KGHUo4VXOvfGNCE09P3s2QdatZ7Knyol/DpP8UIzLBuoT4urV/hWTi2gXbbb5/uihfPR7k
        qBMOGHGq5MqkR/nXzzS08YhU8NcjYD9N3dBKbx5gYjBnX6/iwctHM3VPsWe+2ISG5MAswl
        70+pWTk8+9rrSlAKPdKQaS32CyN8E7c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-slomwFmrMKqalepE5Ds0-Q-1; Sun, 26 Jun 2022 06:45:30 -0400
X-MC-Unique: slomwFmrMKqalepE5Ds0-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04D3D1C01B23;
        Sun, 26 Jun 2022 10:45:30 +0000 (UTC)
Received: from localhost (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 26EF91415108;
        Sun, 26 Jun 2022 10:45:28 +0000 (UTC)
Date:   Sun, 26 Jun 2022 18:45:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
Message-ID: <Yrg4xW0oBoVv5D1R@MiWiFi-R3L-srv>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <YrUTsJiIQb583fKy@MiWiFi-R3L-srv>
 <xhsmhsfnu5giq.mognet@vschneid.remote.csb>
 <Yrg25MZNqt+h1FCB@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrg25MZNqt+h1FCB@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/22 at 06:37pm, Baoquan He wrote:
> On 06/24/22 at 02:37pm, Valentin Schneider wrote:
> > On 24/06/22 09:30, Baoquan He wrote:
> > > On 06/20/22 at 12:15pm, Valentin Schneider wrote:
> > >> @@ -94,14 +94,20 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
> > >>  	/*
> > >>  	 * Because we write directly to the reserved memory region when loading
> > >>  	 * crash kernels we need a mutex here to prevent multiple crash kernels
> > >> -	 * from attempting to load simultaneously, and to prevent a crash kernel
> > >> -	 * from loading over the top of a in use crash kernel.
> > >> -	 *
> > >> -	 * KISS: always take the mutex.
> > >> +	 * from attempting to load simultaneously.
> > >>  	 */
> > >>  	if (!mutex_trylock(&kexec_mutex))
> > >>  		return -EBUSY;
> > >
> > > So kexec_mutex is degenerated to only avoid simultaneous loading,
> > > should we rename to reflect that?, e.g kexec_load_mutex.
> > >
> > 
> > It's also serializing crash_get_memory_size() and crash_shrink_memory();
> > more generally it should still be the preferred serialization mechanism as
> > it's a "proper" lock visible by instrumentation, the atomic variable is a
> > side character for the NMI case.
> 
> You are right. I only checked the code comment in this place. Then this
> patch looks good to me, thx.
> 
> Acked-by: Baoquan He <bhe@redhat.com>

OK, just saw Eric's comment after I replied.

