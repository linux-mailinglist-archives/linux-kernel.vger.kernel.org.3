Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20C6516213
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 07:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbiEAFvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 01:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbiEAFvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 01:51:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F200D1EAC5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 22:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651384089; x=1682920089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VfVBN8Czqd5L00yLeKwp03TgFJtAH93BdVhaCmBvWVw=;
  b=chBoQEq2nitgZCHtUepFmv+appbkf05FlxFyuim7x55q1M0sKxdFVCos
   e6SwBwux0ZyB45Sn6FHC2rLp5uju24JnlLJ5qISrMFyvd37bgEChMrF2c
   uLrmdwHg7aoCrHbqI3IRhCsby7uHjECRfcZTbhxz95tLZI9AeP0/G3tYJ
   wy9EIB/roTN65LaUb7Uf7U0s0sbhByYtlv+ym/jJJIeD6DhGPOec+yrYh
   9ezyEkVzk/7sRuRQmmmTF3B6PlYonHrFOiI9piDYY2hrMBlsZokWElSxB
   Icp/3W0J/9W3LC0BjFDX7iWiStkz4vR15wF+U/rWTp1SElVGBj2daujmA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="254389705"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="254389705"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 22:48:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="535264040"
Received: from iweiny-server.sc.intel.com (HELO localhost) ([172.25.222.75])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 22:48:09 -0700
Date:   Sat, 30 Apr 2022 22:48:08 -0700
From:   ira.weiny@intel.com
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2 0/3] binder: Use kmap_local_page() in binder_alloc.c
Message-ID: <Ym4fAd501sUmEdLB@iweiny-server>
References: <20220425175754.8180-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425175754.8180-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 07:57:51PM +0200, Fabio M. De Francesco wrote:
> Use kmap_local_page() in binder_alloc.c because kmap() and kmap_atomic()
> are being deprecated and kmap_local_page() is preferred where it is
> feasible.
> 
> With kmap_local_page(), the mapping is per thread, CPU local and not
> globally visible. Furthermore, the mapping can be acquired from any
> context, including interrupts.

For the series:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Fabio M. De Francesco (3):
>   binder: Use memset_page() in binder_alloc_clear_buf()
>   binder: Use kmap_local_page() in binder_alloc_copy_user_to_buffer()
>   binder: Use memcpy_{to,from}_page() in binder_alloc_do_buffer_copy()
> 
>  drivers/android/binder_alloc.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> -- 
> 2.34.1
> 
