Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5DD4E6B18
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 00:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355691AbiCXXQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 19:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244340AbiCXXQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 19:16:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCE34D25E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:15:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACEE4616D0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F356BC340EC;
        Thu, 24 Mar 2022 23:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648163716;
        bh=gX2zLmWmZ8H5bi3l6ekaAnBAVIrb/aTIimGY60hPKx0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=omRla7Y/yQts8G6/qZlYUShApkMhkvu3ziS4rQm7HTDveh1JhszVBkdN9oBlilCbN
         G4kkwmWC7lf1bRmjhaq2H0sPzvjQkzTSoLCs3fpu5lTB5N6xRHDhNfD+s5goh8lsru
         4f9jaVI5VAH1IlJrWjIm6Th9yBFBEl9FuEf53khg=
Date:   Thu, 24 Mar 2022 16:15:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yinan Zhang <zhangyinan2019@email.szu.edu.cn>
Cc:     Sean Anderson <seanga2@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/vm/page_owner_sort.c: add switch between culling
 by stacktrace and txt
Message-Id: <20220324161515.19e74f062210861d71ac414b@linux-foundation.org>
In-Reply-To: <623bc151.1c69fb81.12d57.ef3cSMTPIN_ADDED_BROKEN@mx.google.com>
References: <20211129145658.2491-1-zhangyinan2019@email.szu.edu.cn>
        <f0a8099b-3c60-3e34-078a-be3c1280ca61@gmail.com>
        <623a8074.1c69fb81.33a39.0d6cSMTPIN_ADDED_BROKEN@mx.google.com>
        <20220323120805.45fa9e5a0da60b861bf94671@linux-foundation.org>
        <623bc151.1c69fb81.12d57.ef3cSMTPIN_ADDED_BROKEN@mx.google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2022 08:54:34 +0800 Yinan Zhang <zhangyinan2019@email.szu.ed=
u.cn> wrote:

> on 2022/3/24 3:08, Andrew Morton wrote:
> > On Wed, 23 Mar 2022 10:05:28 +0800 Yinan Zhang<zhangyinan2019@email.szu=
.edu.cn>  wrote:
> >
> >>>> *(&list[i].txt+offset)) !=3D 0) {
> >>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 list2[count++] =3D list[i];
> >>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {
> >>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 list2[count-1].num +=3D lis=
t[i].num;
> >>>>
> >>>
> >> You are right. Due to timestamp etc, it's almost impossible to
> >>
> >> cull by txt. And I did observe some blocks differ in head and same in
> >>
> >> stack trace on my linux. The examples I mentioned in patch are
> >>
> >> part of them.
> >>
> >>
> >> Besides, --cull has been added in patch:
> >>
> >> tools/vm/page_owner_sort.c: support for user-defined culling rules
> >>
> > So should I drop this patch?
>=20
> you decide.

I'd rather not.

And dropping this patch makes a huge mess of the series.  So I either
ask for the whole series to be redone and we might miss the merge
window or I send it all in as-is.

Sigh.  I'll send it all in as-is.  Please continue to work on this
issue and if we decide to drop the -c option, please send along a patch
to remove it over the next week or two.

