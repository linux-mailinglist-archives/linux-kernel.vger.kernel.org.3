Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461304F5F23
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiDFNSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiDFNSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6546949D65F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649238993;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eG+lA98DgXDfZlx051ErYhuzaKYIyqcOJZfsLhGFR/o=;
        b=F0MVufxa1UuLTgwmgYatQzwxRlA1FHxn2AKzq+5HDktQ5llgtPPnBu78hUOTixREvabasK
        gPG7uBnsWxMlucNByfYI9LN9DJXnjAEPPYfj65JAlYHxFe7FExOKqOAFDOAxmJCnzf9vVm
        kvqO468ZvqsGtCPEAYMg9vF2b4MFjXo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-eDrC-MY7P2-smmVV8MfwcA-1; Wed, 06 Apr 2022 05:53:20 -0400
X-MC-Unique: eDrC-MY7P2-smmVV8MfwcA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C29FD100BAAA;
        Wed,  6 Apr 2022 09:53:19 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.39.195.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C6DD40CF905;
        Wed,  6 Apr 2022 09:53:19 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.16.1/8.16.1) with ESMTPS id 2369rGLR1580461
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 6 Apr 2022 11:53:16 +0200
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.16.1/8.16.1/Submit) id 2369rFOl1580460;
        Wed, 6 Apr 2022 11:53:15 +0200
Date:   Wed, 6 Apr 2022 11:53:15 +0200
From:   Jakub Jelinek <jakub@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Richard Biener <rguenther@suse.de>,
        linux-toolchains@vger.kernel.org, Michael Matz <matz@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: older gccs and case labels producing integer constants
Message-ID: <Yk1jC4oLnIklOTHI@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <YkwQ6+tIH8GQpuct@zn.tnic>
 <7o5nn52-nqn1-oo13-s6o9-59r85r91o768@fhfr.qr>
 <onrq8p1-582o-6rs9-r682-rs9sqoq7sq6p@fhfr.qr>
 <YkwbygWj/C3XooMV@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YkwbygWj/C3XooMV@zn.tnic>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 12:36:58PM +0200, Borislav Petkov wrote:
> On Tue, Apr 05, 2022 at 12:06:45PM +0200, Richard Biener wrote:
> > Wird auch mit gcc 11 rejected.  Kanns sein dass mit gcc 7 andere
> > compiler flags genommen werden?
> 
> Found it:
> 
> $ gcc -fsanitize=shift -c switch.c
> switch.c: In function ‘foo’:
> switch.c:10:7: error: case label does not reduce to an integer constant
>        case (((0xfc08) << 16) | (0x0101)):;
> 
> $ gcc --version
> gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407]
> Copyright (C) 2017 Free Software Foundation, Inc.
> 
> Something not fully backported?

That is rejected with -fsanitize=shift even on current trunk (in C, C++ is
fine).
C++ constexpr code has cases for ubsan builtins and internal functions,
but C just doesn't handle those apparently.

	Jakub

