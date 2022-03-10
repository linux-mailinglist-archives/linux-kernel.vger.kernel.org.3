Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BC44D3FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 04:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbiCJDax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 22:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiCJDat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:30:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107C012A741
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 19:29:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56B3A610AB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CF6C340E8;
        Thu, 10 Mar 2022 03:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646882988;
        bh=Y3t4lV1jIoKGK4m2yMyigJhYuqSRKau7FAkkcqBIRb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TGA/6LQtGGREJgckJiJnRD6BRW/t2sHNz8Y9nex10J6D2Jza2f3UDYQNwFE2OQnQt
         QxC9JUuYQ7NTU7yHY3QfCnp0l/AAzP02c8DDweQlbhE98WqTAEn3gDRHYaZcpMY4hB
         YPtYY8xQHe5TB2TluBh/+11jrp8Iel64ITQ1S8Cs=
Date:   Wed, 9 Mar 2022 19:29:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     wangjianxing <wangjianxing@loongson.cn>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz
Subject: Re: [PATCH 1/1] mm/page_alloc: add scheduling point to
 free_unref_page_list
Message-Id: <20220309192947.0b4c8c875c492de09c1ab632@linux-foundation.org>
In-Reply-To: <3713cb82-9596-9916-9830-c2827d6a6fe4@loongson.cn>
References: <20220302013825.2290315-1-wangjianxing@loongson.cn>
        <YieCFVMJOgT7es6E@casper.infradead.org>
        <20220309170517.05facf4a2d183cc9aac9196d@linux-foundation.org>
        <3713cb82-9596-9916-9830-c2827d6a6fe4@loongson.cn>
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

On Thu, 10 Mar 2022 10:48:41 +0800 wangjianxing <wangjianxing@loongson.cn> =
wrote:

> spin_lock will preempt_disable(), interrupt context will=20
> __irq_enter/local_bh_disable and also add preempt count with offset.
>=20
> cond_resched check whether if preempt_count =3D=3D 0 in first and won't=20
> schedule in previous context.
>=20
> Is this right?
>=20
>=20
> With another way, could we add some condition to avoid call cond_resched=
=20
> in interrupt context or spin_lock()?
>=20
> + if (preemptible())
> +=A0=A0 =A0=A0=A0 cond_resched();
>=20

None of this works with CONFIG_PREEMPTION=3Dn.
