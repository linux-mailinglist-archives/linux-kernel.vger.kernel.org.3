Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D315AA0C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiIAUPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiIAUPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:15:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A903DF1B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:15:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC78861ED5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FB4C433D6;
        Thu,  1 Sep 2022 20:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662063340;
        bh=T5Bo80Pv2NufC6SUc5YR59Ij4pgjvbIU/dVFhzBVUjc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=khS3obip1ehrIP4wlDKuwfFQQzoIwb0VYvjyPdno5ZWGYetjjZFR6uQu3IzDs6uwI
         /7yGsVxzV3xFPqjdAfEwVnWEYIjEKjVy/X8NPZy8NYNRLYShHlVi2FrIuI1Mlg9qfE
         FXbiaOgdgXKSRT3eSQ+gqEGiFY2T76WwUp65G2/c=
Date:   Thu, 1 Sep 2022 13:15:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v3 1/1] kernel/utsname_sysctl.c: Print kernel arch
Message-Id: <20220901131539.1bfacab0f60b5116e492a46c@linux-foundation.org>
In-Reply-To: <20220901194403.3819-1-pvorel@suse.cz>
References: <20220901194403.3819-1-pvorel@suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Sep 2022 21:44:03 +0200 Petr Vorel <pvorel@suse.cz> wrote:

> Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.
> 
> This helps people who debug kernel with initramfs with minimal
> environment (i.e. without coreutils or even busybox) or allow to open
> sysfs file instead of run 'uname -m' in high level languages.

If they're this constrained, why not run sys_uname() directly?
