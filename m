Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C044C4D57A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345462AbiCKBxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbiCKBxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:53:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC15417B88A;
        Thu, 10 Mar 2022 17:52:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74BD5B829A4;
        Fri, 11 Mar 2022 01:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C67C340E8;
        Fri, 11 Mar 2022 01:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646963537;
        bh=2Gke8hh3aIhj9iTkxhpQghxW0+aYsJifVXn4KB8RgQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XGekMziLl59NDO8JIAbgZiw2jhRA9ZtLzNZDJb2liZKXKA0C4dovTLBI1D9lg8Ct8
         lVnjqvriGUWQBOqfbKY8YFNYF7LrXRprhxODCRRFgmmPqnpCu5ec6+aL3w5Y3OcZ6q
         a4YmwV9WrQIiWolOegSe2xs0R3gW9/sdvQoXo8eg=
Date:   Thu, 10 Mar 2022 17:52:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] linux/types.h: Remove unnecessary __bitwise__
Message-Id: <20220310175216.252fabefeca040004216d40d@linux-foundation.org>
In-Reply-To: <20220310220927.245704-2-helgaas@kernel.org>
References: <20220310220927.245704-1-helgaas@kernel.org>
        <20220310220927.245704-2-helgaas@kernel.org>
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

On Thu, 10 Mar 2022 16:09:26 -0600 Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> There are no users of "__bitwise__" except the definition of "__bitwise".
> Remove __bitwise__ and define __bitwise directly.
> 
> This is a follow-up to 05de97003c77 ("linux/types.h: enable endian checks
> for all sparse builds").
> 

Can we change the copy-pasted code in tools/include/linux/types.h while
we're there?


--- a/tools/include/linux/types.h~linux-typesh-remove-unnecessary-__bitwise__-fix
+++ a/tools/include/linux/types.h
@@ -43,11 +43,10 @@ typedef __u8  u8;
 typedef __s8  s8;
 
 #ifdef __CHECKER__
-#define __bitwise__ __attribute__((bitwise))
+#define __bitwise	__attribute__((bitwise))
 #else
-#define __bitwise__
+#define __bitwise
 #endif
-#define __bitwise __bitwise__
 
 #define __force
 #define __user
_

