Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B45950B2A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445441AbiDVIOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiDVIOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:14:35 -0400
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B0351E5C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:11:41 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 740E9B00798; Fri, 22 Apr 2022 10:11:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 72A4FB00100;
        Fri, 22 Apr 2022 10:11:38 +0200 (CEST)
Date:   Fri, 22 Apr 2022 10:11:38 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Aaron Tomlin <atomlin@redhat.com>
cc:     Oleksandr Natalenko <oleksandr@natalenko.name>, mcgrof@kernel.org,
        pmladek@suse.com, mbenes@suse.cz, christophe.leroy@csgroup.eu,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, neelx@redhat.com
Subject: Re: [PATCH v3 2/2] module: Introduce module unload taint tracking
In-Reply-To: <20220421145757.zfn6zxh6rx3dp75o@ava.usersys.com>
Message-ID: <alpine.DEB.2.22.394.2204221009390.1397495@gentwo.de>
References: <20220420115257.3498300-1-atomlin@redhat.com> <20220420115257.3498300-3-atomlin@redhat.com> <2100545.irdbgypaU6@natalenko.name> <20220421145757.zfn6zxh6rx3dp75o@ava.usersys.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022, Aaron Tomlin wrote:

> > > +		if (len == strlen(mod->name) && !memcmp(mod_taint->name, mod->name, len) &&
> >
> > Here, two strings are compared, so I'd expect to see `strncmp()` instead of `memcmp()`.
>
> Good point. There are other examples of this throughout
> kernel/module/main.c; albeit, I will use strncmp() here.

Comparing the length first may be an attempt to avoid the expensive
memcmp. But here we need to first execute strlen() to obtain the string
length. This is already accessing all characters so this
check is wasteful and a straight str[n]cmp is better.

