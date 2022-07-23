Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BF157F133
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 21:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbiGWT3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 15:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiGWT3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 15:29:54 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E96DE1B7B7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 12:29:51 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 26NJMEw8012545;
        Sat, 23 Jul 2022 14:22:15 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 26NJMBU3012544;
        Sat, 23 Jul 2022 14:22:11 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 23 Jul 2022 14:22:11 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Jason Wang <wangborong@cdjrlc.com>, lkp@intel.com,
        linux-kernel@vger.kernel.org, npiggin@gmail.com,
        Julia.Lawall@inria.fr, paulus@samba.org, joel@jms.id.au,
        linuxppc-dev@lists.ozlabs.org, hbathini@linux.ibm.com
Subject: Re: [PATCH] powerpc: Remove the static variable initialisations to 0
Message-ID: <20220723192211.GP25951@gate.crashing.org>
References: <20220723092436.7149-1-wangborong@cdjrlc.com> <20220723133405.GF17705@kitsune.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220723133405.GF17705@kitsune.suse.cz>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 03:34:05PM +0200, Michal Suchánek wrote:
> Hello,
> 
> On Sat, Jul 23, 2022 at 05:24:36PM +0800, Jason Wang wrote:
> > Initialise global and static variable to 0 is always unnecessary.
> > Remove the unnecessary initialisations.
> 
> Isn't this change also unnecessary?
> 
> Initializing to 0 does not affect correctness, or even any kind of
> semantics in any way.

It did make a difference when the kernel was still compiled with
-fcommon (which used to be the GCC default on most configurations, it is
traditional on Unix).  No explicit initialiser puts an object in .bss if
you use -fcommon.  This matters a bit for data layout.

> The current code is slightly easier to understand.
> 
> And changing the code introduces history noise for na gain.

Yup.

This does give you some code golf points of course ;-)


Segher
