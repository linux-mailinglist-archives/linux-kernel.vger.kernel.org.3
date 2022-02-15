Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2202A4B63B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiBOGlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:41:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiBOGlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:41:42 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278BCB7C50;
        Mon, 14 Feb 2022 22:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644907293; x=1676443293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VJFlrD9QjYOIRicWbxzby4C9BObMKUSbQQt8X0A9Bkw=;
  b=XUeu/+rtVEYHH65v6ahpoQLpn03KUsnayWiTmZ5q3xFKm24CSiujd9Mp
   MzB/ZUNSrUTBrdcDPi5uyRIkRIaIRT4erj2o0jOvMFmYs6N3QR81C4SiS
   CtJXwh9NxWGCS82S9pInMflYirqqT2UW6meJvTg1bgaIlEMdVWs76GjGx
   92P622K/VX8QQARyn890FXcOG6ZwGLD9eUcAGrB/HZF+BdWRKFsIafh/D
   9OeE36KSwXnF6GRC213XivJzmoEs5WuJIPeCvviGNTNgzPrVUsXXQ3YoD
   pO0JYUwY03vMLrwzmuyAYpKq8J/8N49J+RZ2Ti18IWosem0JqYqZvHh3e
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="247857020"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="247857020"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 22:41:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="635654634"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 22:41:30 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 15 Feb 2022 08:41:27 +0200
Date:   Tue, 15 Feb 2022 08:41:27 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: test: get running under UML, add kunitconfig
Message-ID: <YgtLFwORwGggQ7M2@lahna>
References: <20220214184104.1710107-1-dlatypov@google.com>
 <CAGS_qxomM_mGzvFokZH5dnf7L3kCitB3dWD8JH56fPcDSb6PeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxomM_mGzvFokZH5dnf7L3kCitB3dWD8JH56fPcDSb6PeA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Feb 14, 2022 at 06:39:25PM -0800, Daniel Latypov wrote:
> On Mon, Feb 14, 2022 at 10:41 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > These tests didn't work under the normal `kunit.py run` command since
> > they require CONFIG_PCI=y, which could not be set on ARCH=um.
> >
> > Commit 68f5d3f3b654 ("um: add PCI over virtio emulation driver") lets us
> > do so. To make it so people don't have to figure out how to do so, we
> > add a drivers/thunderbolt/.kunitconfig.
> >
> > Can now run these tests using
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/thunderbolt
> >
> > Potentially controversial bits:
> > 1. this .kunitconfig is UML-specific, can't do this for example
> > $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kunitconfig=drivers/thunderbolt
> > 2. this removes the manual call to __kunit_test_suites_init(), which
> >    allowed us to control exactly when the tests got run.
> 
> kernel-test-robot points out something I had forgotten.
> Doing this prevents us from being able to build this test as a module.
> 
> kunit_test_suites() defines an init_module() which conflicts with the
> existing ones.
> 
> There's some relevant discussion about reworking how kunit modules
> work here, https://lore.kernel.org/linux-kselftest/e5fa413ed59083ca63f3479d507b972380da0dcf.camel@codeconstruct.com.au/
> 
> So I think we have two options for this patch:
> a) proceed, but disable building the test as a module for now (tristate => bool)
> b) wait on this patch until kunit module support is refactored
> 
> Basically the question is: does this slightly easier way of running
> the test seem worth losing the ability to test as a module in the
> short-term?

I would like to keep the module option available.

For me, I can just continue running this under QEMU for now so let's
wait until the reworking has been done. Thanks for looking into this,
though! :)
