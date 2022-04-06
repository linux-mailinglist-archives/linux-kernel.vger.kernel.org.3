Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1504F5F0A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiDFN3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiDFN2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:28:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D7C51BD99D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649240771;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ZcKsEZ8qwBQThqWn9sE6S/H8YRw8IewVlhEa4ihZuo=;
        b=ckHTOObpm3NtPtjw/vGjnhnar2pzf/NnzNlLFhPHYcWIcMDEi6a8PclrPNgH76U4BfghDR
        psSx4A7DlRtVyCDftr/Vd8RZ/xiLCsnoCXjLPRZEWshqdnk3ngDLgKtPhRQ7ECHXXGzGNF
        fpnWEs9+SuHRaqd0bRVpHqrOZeZjO1w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-AIsMgtwZNIGqyAF5y3K81A-1; Wed, 06 Apr 2022 06:04:22 -0400
X-MC-Unique: AIsMgtwZNIGqyAF5y3K81A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B59E780346E;
        Wed,  6 Apr 2022 10:04:21 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.39.195.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7460040CF905;
        Wed,  6 Apr 2022 10:04:21 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.16.1/8.16.1) with ESMTPS id 236A4IHC1580605
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 6 Apr 2022 12:04:19 +0200
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.16.1/8.16.1/Submit) id 236A4HPQ1580604;
        Wed, 6 Apr 2022 12:04:17 +0200
Date:   Wed, 6 Apr 2022 12:04:17 +0200
From:   Jakub Jelinek <jakub@redhat.com>
To:     Borislav Petkov <bp@alien8.de>, Richard Biener <rguenther@suse.de>,
        linux-toolchains@vger.kernel.org, Michael Matz <matz@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: older gccs and case labels producing integer constants
Message-ID: <Yk1lodskz34cmqJ1@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <YkwQ6+tIH8GQpuct@zn.tnic>
 <7o5nn52-nqn1-oo13-s6o9-59r85r91o768@fhfr.qr>
 <onrq8p1-582o-6rs9-r682-rs9sqoq7sq6p@fhfr.qr>
 <YkwbygWj/C3XooMV@zn.tnic>
 <Yk1jC4oLnIklOTHI@tucnak>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yk1jC4oLnIklOTHI@tucnak>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 11:53:17AM +0200, Jakub Jelinek wrote:
> On Tue, Apr 05, 2022 at 12:36:58PM +0200, Borislav Petkov wrote:
> > On Tue, Apr 05, 2022 at 12:06:45PM +0200, Richard Biener wrote:
> > > Wird auch mit gcc 11 rejected.  Kanns sein dass mit gcc 7 andere
> > > compiler flags genommen werden?
> > 
> > Found it:
> > 
> > $ gcc -fsanitize=shift -c switch.c
> > switch.c: In function ‘foo’:
> > switch.c:10:7: error: case label does not reduce to an integer constant
> >        case (((0xfc08) << 16) | (0x0101)):;
> > 
> > $ gcc --version
> > gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407]
> > Copyright (C) 2017 Free Software Foundation, Inc.
> > 
> > Something not fully backported?
> 
> That is rejected with -fsanitize=shift even on current trunk (in C, C++ is
> fine).
> C++ constexpr code has cases for ubsan builtins and internal functions,
> but C just doesn't handle those apparently.

But I think the error is actually correct.
In C99 and later, for signed left shift the rule for x << y is that
there is UB if (similarly to all C family) if y is negative or greater or
equal to precision of promoted x, but for C99 also when
((unsigned_typeof_x) x >> (precision_of_x - 1 - y)) != 0.
That is the case above, 0xfc08 is signed int and 0xfc08 << 16 is
0xfc080000 where (0xfc08 >> 15) is 1 and so it is UB.
In C99 and later you need:
	case (int)(((0xfc08U) << 16) | (0x0101)):;
or so.
Note, C++ has different rules (and C++20 and later only has the
y non-negative and less than precision requirement and nothing else).

	Jakub

