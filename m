Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265124C31FC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiBXQsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiBXQsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:48:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD90F8BAA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:47:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B7EA619FC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B68BC340EC;
        Thu, 24 Feb 2022 16:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645721266;
        bh=NDxAEiw7XzHaYnoHtfiEjZg9QHLixGpKQ7Q7uKv4Nno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L5s003OTMRbk9HSAoLvdBrUo0I9GlP5to3gvEs/2+vZMQ0v8xS/YYXw85uYJV3xip
         qiTY8TCZPyR1+tzDpbiDeH3806pTmEWokfO4hAGl7HiZ+PQfJfEoFQkXV8cfw6en6j
         a2XB6qWs8XLWouEbLphBzOUzDUkw8FaE+IAezao5zNgj5UxH6j6vI7MKJ0L7Lbx4Hk
         Tp1f93HDEmSA6m5ZEqU6awq5fvsgOug81brE4hYlCOD3ZtRyQZ8uMfo2Hb9Fti19Oi
         IZtPrnK43TIe5MJmIsdixJuVU9IQZqRFCzKj4rCjsADs3tG5DaSmaTR1bYBvLu2gOu
         K1cMQB8EyivpQ==
Date:   Thu, 24 Feb 2022 18:47:36 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>
Subject: Re: [PATCH 00/29] x86: Kernel IBT
Message-ID: <Yhe2qN6kHL7FHicY@kernel.org>
References: <20220218164902.008644515@infradead.org>
 <7a241b81ccd21da02bc27379b0a837c09fe4f135.camel@intel.com>
 <420C3057-8359-4303-9E25-0C25FAB9203B@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420C3057-8359-4303-9E25-0C25FAB9203B@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 11:26:57PM -0800, Kees Cook wrote:
> 
> On Fri, 2022-02-18 at 17:49 +0100, Peter Zijlstra wrote:
> > This is an (almost!) complete Kernel IBT implementation. 
> 
> BTW, I've successfully tested this on what /proc/cpuinfo calls an "11th
> Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz" (in a Lenovo "Yoga 7 15ITL5").
> Normal laptop-y things all seem happy and it correctly blows up on a new
> LKDTM test I'll send out tomorrow.

For me it boots and can build kernel on a desktop with "12th Gen Intel(R)
Core(TM) i9-12900K"
 
> So, even though the series is young and has some TODOs still:
> 
> Tested-by: Kees Cook <keescook@chromium.org>

So, FWIW:

Tested-by: Mike Rapoport <rppt@linux.ibm.com>

> One thought: should there be a note in dmesg about it being active? The
> only way to see it is finding "ibt" in cpuinfo...
> 
> -Kees
> 
> -- 
> Kees Cook

-- 
Sincerely yours,
Mike.
