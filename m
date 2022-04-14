Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44BB501D67
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbiDNV1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241466AbiDNV10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:27:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4094AE6149
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0757DB82B61
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 21:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613D2C385A5;
        Thu, 14 Apr 2022 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649971498;
        bh=1fW5C9p+VqRotwZZLlRMnVPtuH73+1atlPH6e+BjlOQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y/4dWiF0jnQ/NUhMqpTAzaT+nwlqer4zRBYjg0+e2TJL4jEXr+mnPy60zrkoeuO02
         ZKgcqO8utmTajOsymxq5PD/dq2z7RQTFcvK+bk9fIZQLnq4h41aF7TnNYKIucmu07V
         mAvUjaSq3HmVCRciaD0e9JK4+p9IZhe97ofJw2sk=
Date:   Thu, 14 Apr 2022 14:24:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, andreyknvl@gmail.com, elver@google.com,
        glider@google.com, tarasmadan@google.com, bigeasy@linutronix.de
Subject: Re: [PATCH v3] kcov: don't generate a warning on vm_insert_page()'s
 failure
Message-Id: <20220414142457.d22ce3a11920dc943001d737@linux-foundation.org>
In-Reply-To: <20220401182512.249282-1-nogikh@google.com>
References: <20220401182512.249282-1-nogikh@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Apr 2022 18:25:12 +0000 Aleksandr Nogikh <nogikh@google.com> wrote:

> vm_insert_page()'s failure is not an unexpected condition, so don't do
> WARN_ONCE() in such a case.
> 
> Instead, print a kernel message and just return an error code.

(hm, I thought I asked this before but I can't find it)

Under what circumstances will this failure occur?

Why do we emit a message at all?  What action can the user take upon
seeing the message?

Do we have a Fixes: for this?

From the info provided thus far I'm unable to determine whether a
-stable backport is needed.  What are your thoughts on this?
