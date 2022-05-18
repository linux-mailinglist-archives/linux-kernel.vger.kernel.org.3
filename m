Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B4652C153
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbiERRbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbiERRbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:31:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FEF263A;
        Wed, 18 May 2022 10:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652895065; x=1684431065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BoOLoJEyDFfO0iEr6PodmlZMpo8kGeXxw5b90DAP5hw=;
  b=TBqUJeRom2Lj1jRLQlnWIhxLqM927SA0zG36dbuUsF4sHd46tcB5/YEN
   uXlEbIphLnpa1SyBr3kNb2QpOQQMMcPNLAF/npBDDvej+GhIAxddQD1CM
   32aDGeVqbH+l3q2fBmRQyW8IB8oaTMlYMRIeTkdXBBQbbzcrJzYEppWhU
   lVmh6KVnTMnlY7NKgxz7NnwO0TBoOy8YoMId8iIW89KyZLE/iE6g22YvN
   MhEWI5owS9uycYW30tEyE9FvgRQqP6Dy52/ubFI3royfztdKJJrS8qcwt
   YCLc93eQ1BH2XJdEOPgfVDKg1Nwnr/vkmwvbAP0gBgbtlXHev2Qxv9XwB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="332407527"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="332407527"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 10:08:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="605989915"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 10:08:56 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 79AFF20387;
        Wed, 18 May 2022 20:08:53 +0300 (EEST)
Date:   Wed, 18 May 2022 20:08:53 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alain Volmat <alain.volmat@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe CORNU <philippe.cornu@foss.st.com>
Subject: Re: [PATCH] media: stm32-dcmi: add support of 1X16 serial pixel
 formats variant
Message-ID: <YoUoJRzStCnzhxUK@paasikivi.fi.intel.com>
References: <20220516092048.264036-1-hugues.fruchet@foss.st.com>
 <20220516150237.v3xt7onp2lpmellw@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516150237.v3xt7onp2lpmellw@uno.localdomain>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Mon, May 16, 2022 at 05:02:37PM +0200, Jacopo Mondi wrote:
> Hi Hugues,
> 
> On Mon, May 16, 2022 at 11:20:48AM +0200, Hugues Fruchet wrote:
> > From: Hugues Fruchet <hugues.fruchet@st.com>
> >
> > Add support of 1X16 serial pixel formats in order to support
> > CSI-2 camera sensor exposing 1x16 pixel formats only.
> >
> > Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
> 
> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
> 
> Sakari, if you're sending a new pull request for the ov5640 series,
> could you include this one as otherwise dcmi would be broken when used
> with that sensor.

Just took this into my tree, with your refreshed ov5640 set.

Thanks!

-- 
Sakari Ailus
