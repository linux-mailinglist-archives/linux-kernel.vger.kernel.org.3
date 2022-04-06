Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9BE4F617B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiDFORI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiDFOQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3FA164F0C8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649240220;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gl9lzH2B8iXtNv+PmQrHe3XVaVHAWUpzZOHHKPgN0ss=;
        b=IO/1qyTj1T/w+bQmj+3MHKoYKvtP7/Mebo85xQBeHeyg3rlxleORzomutqAKfGtx5UhGn8
        QMv5OOBl7YpDb1C1H0Ra1CWFnLc+16WcZjQmFM4WX6B4Cm+eCjdrXOO2mfgYvSyop4z+BL
        0LmAestc0sW+PKyqZ0MVjsNlFcYMYw8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-GKo8ae7zNg6o77SSGIC75Q-1; Wed, 06 Apr 2022 06:13:33 -0400
X-MC-Unique: GKo8ae7zNg6o77SSGIC75Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 976FC1C068E6;
        Wed,  6 Apr 2022 10:13:32 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.39.195.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5743540316C;
        Wed,  6 Apr 2022 10:13:32 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.16.1/8.16.1) with ESMTPS id 236ADTpr1580645
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 6 Apr 2022 12:13:29 +0200
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.16.1/8.16.1/Submit) id 236ADSnS1580644;
        Wed, 6 Apr 2022 12:13:28 +0200
Date:   Wed, 6 Apr 2022 12:13:27 +0200
From:   Jakub Jelinek <jakub@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-toolchains@vger.kernel.org,
        Michael Matz <matz@suse.de>,
        Richard Biener <rguenther@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: older gccs and case labels producing integer constants
Message-ID: <Yk1nx2dwh6e3YFHu@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <YkwQ6+tIH8GQpuct@zn.tnic>
 <Ykw0wzdab0ICUFvy@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ykw0wzdab0ICUFvy@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 02:23:31PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 05, 2022 at 11:50:35AM +0200, Borislav Petkov wrote:
> > Hi folks,
> > 
> > I'm starting to see failures like this on allmodconfig builds:
> > 
> > sound/usb/midi.c: In function ‘snd_usbmidi_out_endpoint_create’:
> > sound/usb/midi.c:1389:2: error: case label does not reduce to an integer constant
> >   case (((0xfc08) << 16) | (0x0101)):
> >   ^~~~
> > 
> > (The case statement is a macro but it evaluates to what I have there)
> > 
> > and that thing fails with
> > 
> > $ gcc --version
> > gcc (SUSE Linux) 7.5.0
> > 
> > although it doesn't have any problems building with newer compilers.
> > 
> > I'm presuming older gccs consider those case statements signed ints and
> > the following fixes it:
> > 
> >   case ((((unsigned int)0xfc08) << 16) | (0x0101)):
> > 
> > and I guess we can whack the couple of occurrences but what I'm
> > wondering is why does this work with newer gccs?
> 
> IIRC GCC-8 fixed a bunch of -wrapv issues. Could be this is one of them
> I suppose.

If we are talking about -fsanitize=shift -fwrapv, then that is
https://gcc.gnu.org/PR68418 , i.e. it was fixed already for GCC 6.

	Jakub

