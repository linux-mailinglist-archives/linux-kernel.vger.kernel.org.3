Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091C95664E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiGEIRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGEIRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:17:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D555FE7;
        Tue,  5 Jul 2022 01:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657009069; x=1688545069;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZOIuOHY3YmUfzQTDZkId3qQnYX7+Qjh5YhJnl8kwwC4=;
  b=QT6eaznyUQ9rHh+qweaIWb7fSgOfaQ8nvc/+nfB+is9YIPNt94kRo+yl
   4N+mvf2KVaXJfWZfZ4+DzAFSUE4w92WtnUOWvk6Un1UOmYhVHnL3Xsq7+
   L67P17+LJ8ZK8iywlmQsE0+w729QYELKZ9eOjup4sI0HJUfUncs3yjA2V
   MdGb5+/Gphm0Oq1+IYpa8tc26gr5FTX/bm8MrD7uhaywoqb40EK0QnBYU
   PZkj+M05+SQyzay6pIGk3CsxhjB5JaDWpWW2DF+MXbvAGWs6+MF125q8G
   dq4d6xRHVoU8Pw9p7zse/oGWLa8/QTR5B+Sc7Hay+++ZmjS0z8jW9gP7I
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="263711055"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="263711055"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 01:17:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="619722726"
Received: from zhiwench-mobl1.ccr.corp.intel.com ([10.255.31.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 01:17:46 -0700
Message-ID: <fe71367289b6ee12d47422fd4fb5a9da3569fb52.camel@intel.com>
Subject: Re: [PATCH v3 11/12] thermal/of: Use thermal trips stored in the
 thermal zone
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linexp.org>, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>
Date:   Tue, 05 Jul 2022 16:17:44 +0800
In-Reply-To: <af7463e7-4ec3-8a26-fbc1-aa73bda2e434@linaro.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
         <20220703183059.4133659-12-daniel.lezcano@linexp.org>
         <6c7e1865e7e68ac0f035680044eb878ced715a1b.camel@intel.com>
         <f16d855b-28b0-b4ee-0e42-7293d0e61c21@linexp.org>
         <0c525d16f34bedd1ea4ee4b7516c9dee5a92d419.camel@intel.com>
         <af7463e7-4ec3-8a26-fbc1-aa73bda2e434@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-05 at 08:44 +0200, Daniel Lezcano wrote:
> On 05/07/2022 03:20, Zhang Rui wrote:
> 
> [ ... ]
> 
> > > There is no difference between those functions. There are 34 more
> > > patches in the pipe to be sent after this series to do more
> > > cleanups
> > > and
> > > remove code duplication.
> > > 
> > 
> > Good to know.
> > 
> > It would be nice to have a cover letter to describe the whole
> > picture,
> > including this patch series and the following patches in your
> > queue.
> 
> 
https://lore.kernel.org/lkml/20220703183059.4133659-4-daniel.lezcano@linexp.org/T/
> 
> You will Cc'ed next time ;)
> 
Cool, thanks!

-rui

