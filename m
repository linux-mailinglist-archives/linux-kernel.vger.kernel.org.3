Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380CE4E58EF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245261AbiCWTJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbiCWTJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:09:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC912188
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 922DE612ED
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE63AC340ED;
        Wed, 23 Mar 2022 19:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648062486;
        bh=zFdZWs5OnOMMmacYkRRB3t4RUItHRUGPpw62iNiScpE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dqT9ytUV8lU7Oe1jcuq+pjd+gGNfNq2R7xnln1481nx3ky2I2lVnpd6nplo1FbM2U
         cEhCtJ58dcU4lwVrg0KaQUJO0X614roDGJuCJEPcWNh65iCQgF7NpyWiBZE+76jKQN
         1aUSagLRTh5aVlago+hFN6gcEnwxUYZ4cfSbQhr0=
Date:   Wed, 23 Mar 2022 12:08:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yinan Zhang <zhangyinan2019@email.szu.edu.cn>
Cc:     Sean Anderson <seanga2@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/vm/page_owner_sort.c: add switch between culling
 by stacktrace and txt
Message-Id: <20220323120805.45fa9e5a0da60b861bf94671@linux-foundation.org>
In-Reply-To: <623a8074.1c69fb81.33a39.0d6cSMTPIN_ADDED_BROKEN@mx.google.com>
References: <20211129145658.2491-1-zhangyinan2019@email.szu.edu.cn>
        <f0a8099b-3c60-3e34-078a-be3c1280ca61@gmail.com>
        <623a8074.1c69fb81.33a39.0d6cSMTPIN_ADDED_BROKEN@mx.google.com>
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

On Wed, 23 Mar 2022 10:05:28 +0800 Yinan Zhang <zhangyinan2019@email.szu.ed=
u.cn> wrote:

> >> *(&list[i].txt+offset)) !=3D 0) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 list2[count++] =3D list[i];
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 list2[count-1].num +=3D list[i=
].num;
> >>
> >
> >
> You are right. Due to timestamp etc, it's almost impossible to
>=20
> cull by txt. And I did observe some blocks differ in head and same in
>=20
> stack trace on my linux. The examples I mentioned in patch are
>=20
> part of them.
>=20
>=20
> Besides, --cull has been added in patch:
>=20
> tools/vm/page_owner_sort.c: support for user-defined culling rules
>=20

So should I drop this patch?
